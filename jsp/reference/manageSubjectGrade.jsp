<%--
    < ÀKURA, This application manages the daily activities of a Teacher and a Student of a School>

    Copyright (C) 2012 Virtusa Corporation.
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.virtusa.akura.api.dto.GradeSubject"%>

<%@page import="java.util.List"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/list_grade_subject.css" rel="stylesheet" type="text/css">

<script language="javascript" src="resources/js/jquery-1.11.0.min.js"></script>
<script language="javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="JavaScript" src="resources/js/list_grade_subject.js" type="text/JavaScript"></script>
<script language="javascript" src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#ToList").on('click', 'li', function (e) {
		
	    if (e.ctrlKey || e.metaKey) {
	        $(this).toggleClass("item_selected");
	    } else {
	        $(this).addClass("item_selected").siblings().removeClass('item_selected');
	    }
	    
	    if ($('#ToList li[class="item_selected"]').length == $('#ToList li').length) {
	    	$('#tList').attr('checked', 'checked');
	    } else {
	    	$('#tList').removeAttr('checked');
	    }
	    
	});
	
	$('#tList').click(function() {
		
		if($('#tList').is(':checked')){
			$('#ToList li').addClass('item_selected');
		} else {
			$('#ToList li').removeClass('item_selected');
		}
		
	});
	
	$("#FromList").on('click', 'option', function (e) {
		
	    if ($('#FromList option:selected').length == $('#FromList option').length) {
	    	$('#fList').attr('checked', 'checked');
	    } else {
	    	$('#fList').removeAttr('checked');
	    }
	    
	});
	
	$('#fList').click(function() {
		
		if($('#fList').is(':checked')){
			$('#FromList option').prop('selected', 'selected');
		} else{
			$('#FromList option').prop('selected', '');
		}
		
	});
	
});

function statusCheckbox() {
	
    if (($('#ToList li[class="item_selected"]').length != $('#ToList li').length)
		|| ($('#ToList li').length == 0)
	) {
		$('#tList').removeAttr('checked');
    }
	
	if (($('#FromList option:selected').length != $('#FromList option').length)
		|| ($('#FromList option').length == 0)
	) {
		$('#fList').removeAttr('checked');
    }
	
}

</script>

<script type="text/javascript">
	var oldToListItems= new Array();
	var oldSubjectIds= new Array();
	var oldSubjectNames= new Array();
	var oldMaxMarksList= new Array();
	var oldOptionalSubjects= new Array();
	var oldGradeSubjectConfigCodes= new Array();
	var oldListSize= "";
	$(document).ready(
			function() {
				oldToListItems= document.getElementById("ToList").getElementsByTagName("li");
				oldListSize= oldToListItems.length;				
				if(oldListSize > 0) {
					for (var i = 0; i < oldListSize; i++) {
				    	if(oldToListItems[i].getElementsByTagName("input")[0].checked){
				    		oldOptionalSubjects[i] = oldToListItems[i].getElementsByTagName("input")[0].value;
				    	}
				    	oldSubjectIds[i] = oldToListItems[i].getElementsByTagName("input")[0].value +"-"+(i+1);
				    	oldSubjectNames[i] = oldToListItems[i].getElementsByTagName("div")[0].outerText ||
				    	oldToListItems[i].getElementsByTagName("div")[0].textContent;
				    	oldMaxMarksList[i] = oldToListItems[i].getElementsByTagName("input")[1].value;
				    	oldGradeSubjectConfigCodes[i] = oldToListItems[i].getElementsByTagName("input")[2].value;
				    }
				}
			});
	
	function saveGradeSubject(thisValue) {
		//setAddEditPane(thisValue,'Save');
		var changesMade= "";

		var toListItems = document.getElementById("ToList").getElementsByTagName("li");
		
		if(	document.getElementById("selectGradeId").value=='0'){
			//$(".messageAreaBot").show();
					 document.getElementById('editpanetitle').innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
				 }
		else{
			if(toListItems.length > 0) {
			var allSubjectIdArray = new Array();
			var allSubjectNamesArray = new Array();
			var maximMarkslist = new Array();
			var optionalSudjectIds = new Array();
			var gradeSubjectConfigCodesList = new Array();
			
		    for (var i = 0; i < toListItems.length; i++) {		    	
		    	if(toListItems[i].getElementsByTagName("input")[0].checked){		    		
		    		optionalSudjectIds[i] = toListItems[i].getElementsByTagName("input")[0].value;
		    	}		    
		    	allSubjectIdArray[i] = toListItems[i].getElementsByTagName("input")[0].value +"-"+(i+1);
		    	allSubjectNamesArray[i] = $.trim(toListItems[i].getElementsByTagName("div")[0].outerText || toListItems[i].getElementsByTagName("div")[0].textContent);
		    	maximMarkslist[i] = toListItems[i].getElementsByTagName("input")[1].value;
		    	gradeSubjectConfigCodesList[i] =  toListItems[i].getElementsByTagName("input")[2].value;
		    }		    
	    	document.GradeSubjectForm.allSubjectIds.value = allSubjectIdArray;
	    	document.GradeSubjectForm.allSubjectNames.value = allSubjectNamesArray;
	    	document.GradeSubjectForm.maximumMarklist.value = maximMarkslist;
	    	document.GradeSubjectForm.optionalSudjectIds.value = optionalSudjectIds;
	    	document.GradeSubjectForm.gradeSubjectConfigCodeList.value = gradeSubjectConfigCodesList;
	    	
		}
		 
		 }
		
		
		if(oldListSize == toListItems.length){
			for(var i= 0; i < toListItems.length; i++){
			if((oldSubjectIds[i] == allSubjectIdArray[i]) && /* (oldSubjectNames[i] == allSubjectNamesArray[i]) &&  */
	    				(oldOptionalSubjects[i] == optionalSudjectIds[i])  && (oldMaxMarksList[i] == maximMarkslist[i])  &&
	    				 (oldGradeSubjectConfigCodes[i] == gradeSubjectConfigCodesList[i]) ){
				
	    			changesMade= "No";
	    			
	    					}
				else{
					changesMade = "Yes";
				
					break;
				}
			}
		}
		else{
			changesMade = "Yes";
			
		}
				
		if(changesMade =="No"){
		//$(".messageAreaBot").show();
			document.getElementById('editpanetitle').innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
			
		}
		else{
			document.GradeSubjectForm.gradeDescription.value = '${selectedDescription}';
			document.GradeSubjectForm.action = "saveOrUpdateGradeSubjects.htm";
		    document.GradeSubjectForm.submit();
		}
	
	}

	function deleteGradeSubject(thisObj, gradeDescription) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		document.GradeSubjectForm.gradeDescription.value = gradeDescription;

		
		
		
		var okfunction = function(){
			document.GradeSubjectForm.action='deleteGradeSubject.htm';
			document.GradeSubjectForm.submit();
		};
		
		var cancelfunction = function(){
			
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
		
		
		
	}

	function editGradeSubject(thisVal, gradeDescription) {

		document.getElementById("selectGradeId").value="0";
		document.getElementById("ToList").innerHTML="";

		setAddEditPane(thisVal, 'Edit');
		document.GradeSubjectForm.gradeDescription.value = gradeDescription;
		document.GradeSubjectForm.action = "editGradeSubjects.htm";
		document.GradeSubjectForm.submit();
	}

	function onClickOption(thisVal) {
		var toListItems = document.getElementById("ToList").getElementsByTagName("li");

	    for (var i = 0; i < toListItems.length; i++) {
	    	toListItems[i].className = "";
	    }
	    thisVal.className = "item_selected";
	}

	function addNew(thisVal) {

		$('#selectGradeId option').removeAttr('disabled');
		setAddEditPane(thisVal,'Add');
		document.getElementById('add_edit_panel').style.display='block';
		
		// reset the selected subject list
		document.getElementById("selectGradeId").value="0";
		//document.getElementById("FromList").innerHTML="";
		document.getElementById("ToList").innerHTML="";
		var newOption = document.createElement("ol");
		newOption.style.width='445px';
		newOption.style.borderBottom='solid rgb(214, 223, 238) 1px';
		
		newOption.innerHTML="<div style='width:445px'><label style='margin-left: 5px;;width:200px' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.SUBJECT"/></label><label style='margin-left: 150px;;width:70px'  align='left'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.OPTIONAL"/></label><label style='margin-left: 12px;width:40px;display:none;' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.MAXIMUM.MARK"/></label><label style='margin-left: 12px;;width:40px;display:none;' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.CONFIG.CODE"/></label></div>";
		document.getElementById("ToList").appendChild(newOption);
		document.GradeSubjectForm.actionType.value="addNew";//
		//document.GradeSubjectForm.gradeDescription.value = '${selectedDescription}';
		document.GradeSubjectForm.action = "saveOrUpdateGradeSubjects.htm";
	    document.GradeSubjectForm.submit();
	

	}

	function load(selectedDescription, gradeSubject) {

		if (selectedDescription != null && gradeSubject != null) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
			});

		}

		// Remove disabled attribute of all options in grade select box,
		// and select the relevant grade after the error
		// Add subjects for a grade, which already assigned set of subjects
		<c:if test="${not empty selectedGradeId}">
			$('#selectGradeId option').removeAttr('disabled');
			$('#selectGradeId option[value="${selectedGradeId}"]').attr("selected", "selected");
		</c:if>

	}

	function loadOpenStateData(){
		fromList = document.getElementById("FromList");
	    toList = document.getElementById("ToList");
	    var len = fromList.length;
	    if(toList.length !=null || !isEmpty('${assigned}')){		
	    <c:forEach items="${allSubjectIds}" var="subjectId" varStatus="i">
	    	var newOption = document.createElement("li");
        	newOption.style.width='435px';
        	var subjectName = '${allSubjectNames[i.count -1]}';
        	newOption.innerHTML ="<div style='width:435px;'><div style='width:200px;'>" + subjectName + "</div><div style='margin-left: 5px;;width:70px;'><input type='checkbox' value='${subjectId}'  ${optionalSudjectIds[i.count-1]==subjectId?"checked='checked'":''}  name='optionalSubjects'></div><div style='width:40px;'><input type='text' style='width: 40px; border: 1px solid rgb(70, 130, 180);display:none;' title='Enter to Maximum Mark relevant to Term ' value='100' ></div> <div style='width:40px;'> <input type='text' style='margin-left:40px;;width:40px; border: 1px solid rgb(70, 130, 180);;display:none;' title='Enter The Grade Subject Config Code ' value='" + '${gradeSubjectConfigCodeList[i.count-1]}' + "' ></div><div class='clearfix'></div></div>";
            toList.appendChild(newOption);
		</c:forEach>
	    }
		//showDown(false)
		//get the toList length
	    var toListOps = toList.getElementsByTagName("li");
		var removeCount = toListOps.length;
	    //remove selected from the fromList
		for (j = 0; j < len; j++) { //iterates over fromList

			for(k = 0; k<toListOps.length; k++){//iterates over toList
				var remove = false;

		        if (fromList.options[j].value == toListOps[k].getElementsByTagName("input")[0].value) {
		        	remove = true;
		            break;
		        }
			}

			if(remove){
		    	fromList.remove(j);
		    	len--;
		    	removeCount--;
		    	j--;
			}
			if(removeCount==0){
				break;
			}
	    }

	}
//${display_edit_panel!=null or message!=null or not empty status.errorMessages?'block':'none'}
	function showDown(bool){
			var name = '${display_edit_panel!=null or message!=null or not empty status.errorMessages}';			
			if(bool){
			$(document).ready(function() {
			if(!name){								
		        $(".section_full_inside").hide();			 
			}
			else{			
			$(".section_full_inside").show();
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+30);	
			}
			});
			}
			else{
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+30);	
			}
			}
	
	function showArea() {
		$(document).ready(function() {
			$(".messageAreaBot").hide();
			$(".messageAreaTop").hide();
		});
	}

	function showErrorMessage(){
		if(${del!= null}){	
			$(".messageAreaBot").hide();
		}
		else{
			$(".messageAreaTop").hide();
		}
	}
	function isEmpty(str) {
	    return (!str || 0 === str.length);
	}
	
</script>
<script>
    jQuery(function($){
	
	$('ul.sortable').sortable({
    	items: 'li:not(.disabled)'
	});

	});
</script>


</head>
<body
	onLoad="showDown(false),showErrorMessage(),load('<c:out value="${selectedDescription}"></c:out>','<c:out value="${gradeSubjects}"></c:out>');loadOpenStateData()" >
<h:headerNew parentTabId="26" page="referenceModule.htm" />
<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
		<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
		<li><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.TITLE"/></li>
      </ul>
    </div>
    <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageGradeSubjectsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="middle"> <spring:message code="REF.UI.HELP"/></a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.TITLE"/></h1>
  <div id="content_main">
    <form:form action="" method="post" commandName="gradeSubject" name="GradeSubjectForm">

	<input type="hidden" name="allSubjectIds" value=""/>
	<input type="hidden" name="allSubjectNames" value=""/>
	<input type="hidden" name="gradeDescription"/>
	<input type="hidden" name="maximumMarklist" value=""/>
	<input type="hidden" name="optionalSudjectIds" value=""/>
	<input type="hidden" name="gradeSubjectConfigCodeList" value=""/>
	<input type="hidden" name="actionType" value=""/>

      <div class="section_box">
        <div class="section_box_header">
          <h2><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.DETAILS" /></h2>
        </div>
        <div class="messageArea">
			<div>
			<!-- update success message comes through query string (after redirecting) -->
			<label class="success_sign"> ${param.addEditDelete}</label>
			</div>
        </div>
        
        <h3 id="editpanetitle">
       
							
						</h3>
        
        <div class="messageAreaTop">        	
        	<label class="required_sign">${message}</label>
        	<label class="required_sign">${deleteFailMessage}</label>
        </div> 
        <div class="column_single">
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th width="20%"><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.GRADE" /></th>
              <th><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.MAIN.SUBJECTS" /></th>
              <th><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.OPTIONAL.SUBJECTS" /></th>
              <th width="42" align="right" class="right"><sec:authorize access="hasRole('Add/Edit Grade Subject')">
              <img src="resources/images/ico_new.gif" class="icon_new" onClick="showDown(true),clearMessages(),showArea(); addNew(this);" width="18" height="20" title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.ADD"/>"></sec:authorize></th>
            </tr>
            <c:choose>
            <c:when test="${not empty gradeSubjects}">
	            <c:forEach var="gradeSubject" items="${gradeSubjects}" varStatus="status">
		            <tr
		       		    <c:if test="${status.count % 2 == 1}">class="odd"</c:if>
		       			<c:if test="${status.count % 2 == 0}">class="even"</c:if>
		       		>
				       <td
				        	<c:if test="${selectedDescription==gradeSubject.key}">id="flag"</c:if>>
				        	<c:out value="${gradeSubject.key}"/>
				        </td>
				        <td> <% int mainCount = 0; %>
							<c:forEach items="${gradeSubject.value}" var="gradeSubjectMain">
								<c:if test="${gradeSubjectMain.isOptionalSubject eq false}">
									<% mainCount++; %>
									<% if (mainCount != 1) %>,
				            	 	<c:out value= "${gradeSubjectMain.subject.description}"/>
				            	</c:if>
				            </c:forEach>
				        </td>
						<td> <% int optionalCount = 0; %>
							<c:forEach items="${gradeSubject.value}" var="gradeSubjectOptional">
								<c:if test="${gradeSubjectOptional.isOptionalSubject eq true}">
									<% optionalCount++; %>
									<% if (optionalCount != 1) %>,
									<c:if test="optionalCount != 1">,</c:if>
				            		<c:out value= "${gradeSubjectOptional.subject.description}"/>
				            	</c:if>
				            </c:forEach>
				        </td>
			        	<td nowrap class="right">
							<sec:authorize access="hasRole('Add/Edit Grade Subject')">
			            		<img src="resources/images/ico_edit.gif" onClick="showDown(true),clearMessages(),showArea(); editGradeSubject(this, '${gradeSubject.key}');"
			            		title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.EDIT"/>" width="18" height="20" class="icon">
							</sec:authorize>
							<sec:authorize access="hasRole('Delete Grade Subject')">
				           		<img src="resources/images/ico_delete.gif" onClick="clearMessages(),showArea(); deleteGradeSubject(this, '${gradeSubject.key}');"
				           	 	title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
				           	 </sec:authorize>
			        	</td>
		            </tr>
	            </c:forEach>
            </c:when>
            <c:otherwise>
					<tr>
						<td width="830">
							<h5>
								<spring:message code="REF.UI.MANAGE.EXAM.SUBJECT.NO.RESULT" />
							</h5>
						</td>
						<td nowrap class="right"></td>
						<td></td>
						<td></td>
					</tr>
				</c:otherwise>
            </c:choose>
          </table>
        </div>
        <div class="messageAreaBot" id="messageAreaBot">        	
        	<label class="required_sign">${message}</label>
        	<label class="required_sign">${deleteFailMessage}</label>
        </div> 
        <sec:authorize access="hasRole('Add/Edit Grade Subject')">
        <spring:bind path="gradeSubject.*">
			<c:set var="status" value="${status}"></c:set>
		</spring:bind>
        <div class="section_full_inside" style="display: ${display_edit_panel!=null or message!=null or not empty status.errorMessages?'block':'none'}" id="add_edit_panel">
          	<c:if test="${display_edit_panel != null}">
				<h3><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.EDIT"/></h3></c:if>
			<c:if test="${display_edit_panel == null}">
	 			<h3><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.ADD"/></h3></c:if>
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.GRADE" />:</label>
                </div>
                <form:select path="grade.gradeId" id="selectGradeId">
                	<form:option value="0" id="selectOption">  <spring:message code="application.drop.down" /> </form:option>
                	<c:forEach items="${gradeList}" var="grade">

	                	<c:if test="${selectedDescription != null}">
	                		<option value="${grade.gradeId}" <c:if test="${grade.description != selectedDescription}">disabled="disabled"</c:if>
	                		<c:if test="${grade.gradeId == gradeSubject.grade.gradeId}"> seleted </c:if>
	                	<c:if test="${grade.description eq selectedDescription}">selected="selected"</c:if>>${grade.description}</option></c:if>

	                	<c:if test="${selectedDescription == null}">
					    	<option value="${grade.gradeId}" <c:if test="${grade.gradeId == gradeSubject.grade.gradeId}"> selected </c:if> >
					    	${grade.description}</option>
					    </c:if>

                	</c:forEach>
                  </form:select>
              </div>

            </div>

			<div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <label>&nbsp;</label>
                </div>


	<div id="add_remove_list">

			<div class="list_containers" ><div><label><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.AVAILABLE.SUBJECTS"/>:</label></div>
	            <div class="studenSelectbox"> <input id="fList" name="rem" type="checkbox" />Select all</div>
	              
	              <div style='width:375px'><label style='margin-left: 5px;text-align: right;'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.SUBJECT"/></label></div>
	              
	              <ul style='border: 1px solid rgb(69, 150, 201);' >
		      <li >	         
		      <select multiple id ='FromList' style='height:244px;;margin-left:-1px;border-top-style:solid;;border-top-color:rgb(214, 223, 238);'>	            
		            <c:choose>
		            	<c:when test="${not empty availableSubjectsList}">		            		 
		            		<c:forEach items="${availableSubjectsList}" var="availableSubject" varStatus="status">
		            			<option value="${availableSubject.subjectId}">${availableSubject.description}</option>
		            		</c:forEach>		            		
		            	</c:when>
		            	<c:when test="${empty selectedSubjectsList}">		            		
		            		<c:forEach items="${subjectList}" var="subject" varStatus="status">
			            		<option value="${subject.subjectId}">${subject.description}</option>
		            		</c:forEach>		            		
		            	</c:when>
		            </c:choose>		            
	            </select>
	            </li>
	            </ul>
			</div>
            <div class="ccontroller"><input type="button" class="button" title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.ADD.SELECTED"/>"  name="Button" value="&gt;" onClick="add(); statusCheckbox();"><br>
			<br>
			<input type="button" class="button"  title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.REMOVE.SELECTED"/>"  name="Button" value="&lt;" onClick="removeGradeSubject(); statusCheckbox();" ></div>
			<div class="list_containers">
			<div><span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.SELECTED.SUBJECT"/>:</label></div>

         <div class="studenSelectbox"> <input id="tList" name="rem" type="checkbox" />Select all</div>
           <c:choose>
           	<c:when test="${not empty selectedSubjectsList}">
           		 <ul name="subjects" size="15" id="ToList" class="sortable" >
           		<ol style='width:445px;;border-bottom:solid rgb(214, 223, 238) 1px;'>
           		 <div style=' width:445px'><label style='margin-left: 5px;;width:200px' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.SUBJECT"/></label><label style='margin-left: 150px;;width:70px'  align='left'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.OPTIONAL"/></label><label style='margin-left: 12px;;width:50px;display:none;text-align: right;'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.MAXIMUM.MARK"/></label><label style='margin-left: 10px;;width:50px;;display:none;' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.CONFIG.CODE"/></label></div>
           		 </ol>       	
           			
           		     <c:forEach items="${selectedSubjectsList}" var="selectedSubject">
           				<li style='width:445px;'>
           				<div style="width:435px;">
	           				<div style=width:200px;>${selectedSubject.subject.description}</div>
	           				<div style=width:70px;;margin-left:5px>
		           				<input type="checkbox" value="${selectedSubject.subject.subjectId}" name="optionalSubjects"
		           				<c:if test="${selectedSubject.isOptionalSubject eq true}">checked="checked"</c:if>>
	           				</div>
	           				<div style=margin-left:5px;width:45px;>
	           				<input type="text" style='width: 40px; border: 1px solid rgb(70, 130, 180);display:none;' value="${selectedSubject.maximumMark}" title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.MAXIMUM.MARK.TITLE"/>"></div>
	           				<div style=margin-left:40px;width:45px;>
	           				<input type="text" style='width: 45px; border: 1px solid rgb(70, 130, 180);display:none;' value="${selectedSubject.gradeSubjectConfigCode}" title="<spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.CONFIG.CODE.TITLE"/>"></div>
	           				<div class="clearfix"></div>
	           			</div>
           				</li>
           			</c:forEach>
			
	            </ul>
           	</c:when>
           	<c:otherwise>
			 <ul name="subjects" size="15" id="ToList" class="sortable">
           		<ol style='width:445px;;border-bottom:solid rgb(214, 223, 238) 1px;'>
           		 <div style='width:445px'><label style='margin-left: 5px;;width:200px' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.SUBJECT"/></label><label style='margin-left: 150px;;width:70px'  align='left'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.OPTIONAL"/></label><label style='margin-left: 12px;d;width:50px;display:none;' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.MAXIMUM.MARK"/></label><label style='margin-left: 12px;;width:50px;;display:none;' align='right'><spring:message code="REF.UI.MANAGE.GRADE.SUBJECT.CONFIG.CODE"/></label></div>
           		 </ol>     
	            </ul>
           	</c:otherwise>
           </c:choose>
      </div>

	 <div class="clearfix"></div>

</div>


              </div>

            </div>
           
            <div class="row"> <div>Note : Please drag and drop the subjects in the right hand pane; to customize the subject field order.</div>
              <div class="buttion_bar_type1">
                <input type="button" class="button" onClick="clearMessages(),saveGradeSubject(this),showArea();" value="<spring:message code="REF.UI.SAVE"/>">
                <input type="button" class="button" onClick="clearMessages(),showArea(); setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>">
              </div>
            </div>
            <div class="clearfix"></div>
          </div>
        </div></sec:authorize>
        <div class="clearfix"></div>
      </div>
    </form:form>
  </div>
</div>
<h:footer/>
</body>
</html>