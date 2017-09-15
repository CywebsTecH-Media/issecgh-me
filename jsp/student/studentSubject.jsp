<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>

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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<!-- Jquery -->
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/ui.jqgrid.css" rel="stylesheet" type="text/css">
<script src="resources/js/messageCommon.js"></script>
<!-- Jquery -->
<script type="text/javascript" src="resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script type="text/javascript" src="resources/js/grid.locale-en.js"></script>
<script type="text/javascript" src="resources/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/grid.celledit.js"></script>
<!-- Akura -->
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css"> 
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<!-- Akura -->  	
<script type="text/javascript" src="resources/js/main.js"></script>


<script type="text/javascript">


// function for check all button.
function checkAll() {


jQuery('#users').jqGrid('setGridParam', {cellEdit: true});

var temp = document.getElementById('users')
var checkboxes = temp.getElementsByTagName('input');     
         for (var i = 0; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = true;
                
                
             }
         }
         
         
 		
 		

jQuery('#users').jqGrid('setGridParam', {cellEdit: false});


}
</script>

<script type="text/javascript">
	//set properties in jqgrid
	function subjectGridView(subjectName) {
		var data = '${subjectJsonData}';		
		var subjectOptionalStatus = subjectName;		
		var subjectNames = getSubjectNames(subjectOptionalStatus);
		var colname = BuildCoulmnNames(subjectNames, subjectOptionalStatus);
		var columns = BuildColumnModel(subjectNames);
		$(document).ready(function(){
		jQuery('#users').jqGrid({
			datatype: "jsonstring",
			datastr: data,   			    			  
		    colNames:colname,
		    colModel:columns,
		    scroll:1,
			width: 900,
			height: 300,
			mtype: "POST",
			sortorder: "asc",					
			rownumbers: true,			
			cellsubmit:'clientArray',
			
			 afterInsertRow: function(rowid, aData)
			{
				setColorForUnEditableCells(subjectNames,rowid);
			},        
						
		    onCellSelect: function(rowid, index, contents, event) 
			{   	
				editSelectedCell(rowid,index);	
			},
				
				shrinkToFit: false 
				
			});
			
			  $('#load_users').hide();
			 $("#users").jqGrid('setFrozenColumns');  
			 
			
		
		 
 		$("#saveButton").click(function () {
				populateEditedMarkJsonArray();
				saveSubject();
				
			});
 		 
 		
 		$("#Check_All").click(function () {
 			
			checkAll() ;
		
			
			
 		});
 		 
 		
	});

}
	
	
	function cancel() {
		document.form.action = 'resetForm1.htm';
		document.form.submit();
	}


	function BuildCoulmnNames(subjectNames, subjectOptionalStatus){
       var columns = [];
	    columns.push('Admission Number');
		columns.push('Student Name');
		columns.push('studentNameStatus');
        for(var i=0;i< subjectNames.length; i++){
		var fieldVal = subjectNames[i];
		var isOptional=subjectOptionalStatus[subjectNames[i]];
		if(isOptional){
			fieldVal=fieldVal+" (optional)";
		}
		columns.push(fieldVal);
		columns.push(subjectNames[i]+'IsEditable');
		columns.push(subjectNames[i]+'StudentID');
		columns.push(subjectNames[i]+'SubjectID');
		columns.push(subjectNames[i]+"MarkID");
		columns.push(subjectNames[i]+"HasMark");
        }
        return columns;
	}
	
	function BuildColumnModel(subjectNames){
        var uFields = subjectNames;
        var columns = [];
		columns.push({ name : 'AdmissionNumber' , index : 'AdmissionNumber', width : 150 , align : 'left', editable : false, frozen: true,});		
		columns.push({ name : 'studentName' , index : 'studentName' , width : 300 , align : 'left', editable : false, frozen: true,});
		columns.push({ name: 'studentNameStatus', hidden: true});
        for(var i = 0;i< uFields.length; i++){
           columns.push({ name : uFields[i] , index : uFields[i] , width : 100 , align : 'center' , editable : true, edittype:'checkbox', edittype: 'checkbox', 
		   editoptions: { value: "True:False" , defaultValue: "True"}, formatter: "checkbox", formatoptions: {
			disabled: true
			}});
		   columns.push({ name: uFields[i]+'IsEditable', hidden: true});
		   columns.push({ name: uFields[i]+'StudentID', hidden: true});
		   columns.push({ name: uFields[i]+'SubjectID', hidden: true});
		   columns.push({ name: uFields[i]+"MarkID", hidden: true});
		   columns.push({ name: uFields[i]+"HasMark", hidden: true});
       
		}
        return columns;
	}
	
	function getSubjectNames(subjectOptionalStatus){
		var subjectNames = [];

		for (var key in subjectOptionalStatus) {
			subjectNames.push(key);
		}
		return subjectNames;
	}

	function setColorForUnEditableCells(subjectNames ,rowid){
		
		for(var i=0;i<subjectNames.length;i++){
			var hasMark = jQuery('#users').jqGrid('getCell', rowid, subjectNames[i]+'HasMark');
			var editable = jQuery('#users').jqGrid('getCell', rowid, subjectNames[i]+'IsEditable');
			if (editable == "false"){
				$("#users").setCell(rowid,subjectNames[i],"",{"background-color":"#e6e6e6"});
				 if(hasMark=="true"){
				 jQuery("#users").jqGrid('setCell', rowid,subjectNames[i] ,"","", {title: "Term mark entries are already completed"});
				 }
			}		
			
		}
	
		var status = jQuery('#users').jqGrid('getCell', rowid, 'studentNameStatus');		
		if (status == 2){
			//$('#users').setCell(rowid,'AdmissionNumber','',{'background-color':'#aaaaaa'});
			//$('#users').setCell(rowid,'studentName','',{'background-color':'#aaaaaa'});
			 jQuery("#users").jqGrid('setCell', rowid, 'AdmissionNumber' ,"",{'background-color':'#aaaaaa'}, {title: "Past Student"});
			 jQuery("#users").jqGrid('setCell', rowid, 'studentName' ,"",{'background-color':'#aaaaaa'}, {title: "Past Student"});
		}
		
		if (status == 3){
			//$('#users').setCell(rowid,'AdmissionNumber','',{'background-color':'#aaaaaa'});
			//$('#users').setCell(rowid,'studentName','',{'background-color':'#aaaaaa'});
			 jQuery("#users").jqGrid('setCell', rowid, 'AdmissionNumber' ,"",{'background-color':'#aaaaaa'}, {title: "Suspend Student"});
			 jQuery("#users").jqGrid('setCell', rowid, 'studentName' ,"",{'background-color':'#aaaaaa'}, {title: "Suspend Student"});
		}
		
		if (status == 4){
			//$('#users').setCell(rowid,'AdmissionNumber','',{'background-color':'#aaaaaa'});
			//$('#users').setCell(rowid,'studentName','',{'background-color':'#aaaaaa'});
			 jQuery("#users").jqGrid('setCell', rowid, 'AdmissionNumber' ,"",{'background-color':'#aaaaaa'}, {title: "Temporary Leave Student"});
			 jQuery("#users").jqGrid('setCell', rowid, 'studentName' ,"",{'background-color':'#aaaaaa'}, {title: "Temporary Leave Student"});
		}
		
       	
					
				
	}

	function editSelectedCell(rowid,index){
	
		var columnData = $("#users").jqGrid('getGridParam','colModel');   	
		var subjectName=columnData[index].name;
		var editable = jQuery('#users').jqGrid('getCell', rowid, subjectName+'IsEditable');
		if(editable=='true'){
			jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
			jQuery('#users').jqGrid('editCell', rowid, index, true);
			
		}	
		else{
			jQuery('#users').jqGrid('setGridParam', {cellEdit: false});
			
		}
	}

	function populateEditedMarkJsonArray(){
		
		jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
		jQuery('#users').jqGrid("editCell", 0, 0, false);				
		var returnEditedRow = $("#users").getChangedCells('all');		
		var returnEditedCol = $("#users").getChangedCells('dirty');
		
		var editedMarksJsonArray = [];
		for(var i=0;i<returnEditedCol.length;i++){
			var editedColObj = returnEditedCol[i];
			var editedRowObj = returnEditedRow[i];
			for(var key in editedColObj){
			if(key!="id"){				
				var editedValue = editedRowObj[key];
				var markId = editedRowObj[key+"MarkID"];
				var studentID = editedRowObj[key+"StudentID"];
				var subjectID = editedRowObj[key+"SubjectID"];
				
				if(markId!=null){
					 editedMarksJsonArray.push({
						value: editedValue,
						mid: markId,
						stuid: studentID,
						subid: subjectID
						
						
					});
					}
					
				}
			}
			
		}
			
		document.getElementById('editedMarksJsonArray1').value = JSON.stringify(editedMarksJsonArray);
	}
	
    function saveSubject(){
	
		
    	var okfunction = function(){
			document.form.action = 'saveorupdatestudentsubject.htm';
			document.form.submit(); 
		};
		
		var cancelfunction = function(){};
		
		var message = "<spring:message code='REF.SAVE.CONFIRMATION' />";
		
		confirm_function(message, okfunction, cancelfunction);
		
		
	
	}
	
</script>
</head>
<body>

<h:headerNew parentTabId="10" page="studentSubject.htm" />
<div id="page_container">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="STUDENT.SUBJECT.TITLE"/></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentSubjectHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"><spring:message code="application.help"/> </a></div>
<div class="clearfix"></div>
<h1><spring:message code="STUDENT.SUBJECT.TITLE"/></h1>
<div>
	<c:choose>
      <c:when test="${successMessage == null}">
         <label class="missing_required_error"> ${errorMessage}</label>
      </c:when>

      <c:otherwise>
         <label class="success_sign"> ${successMessage}</label>
      </c:otherwise>
	</c:choose>
</div>
<div id="content_main">
<form action="" method="post" name="form"><c:set
	var="gradeclassdescription" value="" />

<div class="clearfix"></div>
<div class="section_full_search">
<div class="box_border">
<p><spring:message code="STUDENT.SUBJECT.SUB.TITLE"/></p>
<div class="row">
<div class="float_left">
<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message code="STUDENT.SUBJECT.CLASS"/></label></div>
<select name="select">
	<option value ="0"><spring:message code="application.drop.down"/></option>
	<c:forEach var="gradeclass" items="${gradeClassList}">
		<c:set var="testval" value="" />
		<c:if test="${gradeclass.classGradeId eq classGradeId}">
			<c:set var="testval" value="SELECTED" />
			<c:set var="gradeclassdescription" value="${gradeclass.description}" />
		</c:if>
		<option label="${gradeclass.description}"
			value="${gradeclass.classGradeId}" <c:out value="${testval}"></c:out>>
		${gradeclass.description}</option>
	</c:forEach>
</select></div>
<div class="float_left">
<div class="lbl_lock"><label><spring:message code="STUDENT.SUBJECT.YEAR"/></label></div>
<select name="year" id="selectedYear">
									<c:forEach items="${yearList}" var="year" varStatus="status">
										<option label="${year}" value="${year}" <c:if test="${thisYear == year}">selected="selected"</c:if>>${year}</option>
									</c:forEach>
								</select></div>
								
								<!-- Render term list -->
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message
											code='STUDENT.STUDENTMARK.TERM' />:</label>
								</div>
								<select name="selectedTerm" id="term">
									<option value="0">
										<spring:message code='application.drop.down' />
									</option>
									<c:forEach items="${studentTermList}" var="term">
										<c:set var="testval" value="" />
										<c:if test="${term.termId eq termId}">
											<c:set var="testval" value="SELECTED" />
											<c:set var="termdescription" value="${term.description}" />
										</c:if>
										<option label="${term.description}" value="${term.termId}"
											<c:out value="${testval}"></c:out>>
											${term.description}</option>
									</c:forEach>
								</select>
							</div>
								
							
<div class="float_right">
<div class="buttion_bar_type1">
<sec:authorize access="hasAnyRole('Search Student Subject List')">
<input id="searchButton" type="button"
	value="<spring:message code='STUDENT.SUBJECT.UI.SEARCH.CLASS'/>"
	onClick="document.form.action='searchStudentSubjectList.htm'; document.form.submit();"
	class="button">
</sec:authorize></div>

</div>
</div>
<div class="clearfix"></div>
</div>
</div>
<c:if test="${(not empty studentList) and (not empty gradeSubjectList)}">
	
	<div class="section_box" id="search_results">
	<div class="section_box_header">
	<h2>${gradeclassdescription} (${thisYear}) <spring:message code="STUDENT.SUBJECT.SUBJECT"/></h2>
	</div>
	<div class="column_single">
	
														
		<table id="users" class="FixedTables">
							</table>
							<div id="usersPage" ></div>	
							
			<c:if
					test="${(not empty subjectJsonData) }">
							<script>
							var subjectName= ${subjectName};
							 subjectGridView(subjectName);
							</script>
				</c:if>	
				<input type="hidden" id="editedMarksJsonArray1" name="editedMarksJsonArray1" value="" />
					
	
	
	</div>
	<div class="clearfix"></div>
	</div>
	</div>

		<div id="btn_row" class="button_row">

		<div class="buttion_bar_type2">
		<sec:authorize access="hasAnyRole('Save Or Update Student Subject')">
		
		<%-- <input type="button"
			name="Check_All" id="Check_All" value="<spring:message code="STUDENT.SUBJECT.UI.CHECK.ALL"/>" class="button"
			> --%>
			
			<c:if
			test="${(classGradeId ne null) and (year ne null)}">
			<input type="hidden" name="select" value="${classGradeId}">
			<input type="hidden" name="selecting" value="${year}">
		  </c:if> <input type="button" value="<spring:message code="REF.UI.RESET"/>"
			onClick="document.form.action='searchStudentSubjectList.htm'; 
		    document.form.submit();
			document.getElementById('search_results').style.display=''; 
			document.getElementById('btn_row').style.display=''"
			class="button"> <input type="button" id = "saveButton" value="<spring:message code='REF.UI.SAVE'/>"
			
			class="button"  /> 
			<input type="button" value="<spring:message code='REF.UI.CANCEL'/>" class="button"
								onclick="cancel()"/>
		
		</sec:authorize>
		
		
		</div>
		


		<div class="clearfix"></div>
		</div>
	

</c:if></form>
</div>


</div>
<h:footer />
</body>
</html>





