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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function deleteSubject(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	    
		
		
		var okfunction = function(){
			document.form.action='manageDeleteSubject.htm';
			document.form.submit();
		};
		
		
		var cancelfunction = function(){
			
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
		
		}
	
	var oldDescription, oldStreamDescription, oldSubjectCode, oldGovSubjectCode;
	function testSave(thisVal,description, subjectId, streamDescription, subjectCode ,govSubjectCode) {
	document.form.selectedSubjectDescription.value = description;
		setAddEditPane(thisVal,'Edit');
			oldDescription= description;
			oldStreamDescription= streamDescription;
			oldSubjectCode= subjectCode;
			oldGovSubjectCode= govSubjectCode;
			document.form.description.value = description;
			document.form.subjectId.value = subjectId;
			document.form.govSubjectCode.value=govSubjectCode;
			document.form.subjectCode.value = subjectCode;
			if (streamDescription == "") {
				document.getElementById('select').value = document.getElementById('selectOption').value;
			} else {
				document.getElementById('select').value = streamDescription;
			}

		}
	
function saveSubject(thisValue){
	var newDescription= document.getElementById("inputSubDesc").value;
	var newStreamDescription= document.getElementById("select").value;
	var newSubjectCode= document.getElementById("inputSubCode").value;
	var newGovSubjectCode= document.getElementById("inputGovSubCode").value;
	
		if(document.form.subjectId.value == null || document.form.subjectId.value == ""){
			document.form.subjectId.value = 0;
		}	
		else if(newDescription == oldDescription && newStreamDescription == oldStreamDescription && newSubjectCode == oldSubjectCode && newGovSubjectCode == oldGovSubjectCode){
			$("#areaBot").show();
			document.getElementById("areaBot").innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
			setAddEditPane(thisValue, 'Save');
			document.form.action='manageSaveOrUpdateSubject.htm'; 
			document.form.submit();
		}
	}
	
	function showArea() {
		$(document).ready(function() {
			$("#areaTop").hide();
			$("#areaBot").hide();
			$("#area").hide();
		});
		
	}
	function showDown(bool){
			var name = '${editpane}';
			if(bool){
			$(document).ready(function() {
			if(name == null){								
		        $(".section_full_inside").hide();			 
			}
			else{			
			$(".section_full_inside").show();
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+25);	
			}
			});
			}
			else{
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+25);	
			}
			}
	
	function showErrorMessage(){
		if(${del!= null}){	
			$("#areaBot").hide();
		}
		else{
			$("#areaTop").hide();
		}
	}
	
</script>
</head>
<body onLoad="showDown(false),showErrorMessage()">
<h:headerNew parentTabId="26" page="referenceModule.htm"/>
<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
		<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
		<li><spring:message code="REF.UI.MANAGE.SUBJECTS.TITLE"/></li>
      </ul>
    </div>
    <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageSubjectHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP"/></a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="REF.UI.MANAGE.SUBJECTS.TITLE"/></h1>
  <div id="content_main">
   <form:form action="#" method="post" commandName="subject" name = "form">
   <div class="section_full_search">
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
<input type="hidden" name="selectedSubjectDescription" />
                  <label><spring:message code="REF.UI.MANAGE.SUBJECT.NAME"/>:</label>
                </div>
                <input type="text" name="searchDescription" value="${searchDescription}"/>
              </div>
			  <div class="float_right">

                 <div class="buttion_bar_type1"><sec:authorize access="hasRole('Search Subject')">
                <input type="button" value="<spring:message code="REF.UI.SEARCH"/>" onClick="document.form.action='manageSearchSubject.htm'; document.form.submit();" class="button">
                </sec:authorize>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
          </div>
      </div>
	  <div class="section_box">
	  <div id="search_results">
        <div class="section_box_header">
          <h2><spring:message code="REF.UI.SEARCH.RESULTS"/></h2>
        </div>
       <div id="area">
		<div>
			<!-- updte succes message comes through query string (after redircting) -->
			<label class="success_sign"> ${param.addEditDelete}</label>
		</div>
		<div id="areaTop">       	
         	<c:if test="${!(message == null)}">
						<div class="error"> &nbsp;<label id="errormsg" class="required_sign">
						<c:out value="${message}" /> 
						</label></div>
			</c:if>
  		<div> <form:errors path="*" cssClass="required_sign" /></div></div>
		</div>
        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th width="408"><spring:message code="REF.UI.MANAGE.SUBJECT.NAME"/></th>
              <th width="408"><spring:message code="REF.UI.MANAGE.SUBJECT.SHORT"/></th>
               <th width="408"><spring:message code="REF.UI.MANAGE.SUBJECT.CODE"/></th>
               <th width="441"><spring:message code="REF.UI.MANAGE.SUBJECT.STREAM"/></th>
              <th width="59" class="right"><sec:authorize access="hasRole('Add/Edit Subjects')"><img src="resources/images/ico_new.gif" class="icon_new" onClick="showDown(true),setAddEditPane(this,'Add',showArea())
            	  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.form.subjectCode.value='';
						 document.form.govSubjectCode.value='';
						 document.getElementById('select').value = document.getElementById('selectOption').value;
						 document.form.subjectId.value='0';
					}
               " width="18" height="20" title="<spring:message code="REF.UI.MANAGE.SUBJECT.ADD"/>"></sec:authorize></th>
            </tr>
            <c:choose>
            <c:when test="${searchSubject != null }">
            <c:forEach var="searchSubject" items="${searchSubject}" varStatus="status">
           <tr <c:if test="${selectedObjId != null && (selectedObjId == searchSubject.subjectId)}">class="highlight"</c:if>
            <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              		<td><c:out value="${searchSubject.description}"></c:out></td>
              		<td><c:out value="${searchSubject.subjectCode}"></c:out></td>
              		<td><c:out value="${searchSubject.govSubjectCode}"></c:out></td>
               	 	<td><c:out value="${searchSubject.stream.description}"></c:out></td>
               	 	
           	  		<td nowrap class="right"><sec:authorize access="hasRole('Add/Edit Subjects')"><img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.SUBJECT.EDIT"/>"
              			onClick="showDown(true),testSave(this,'<c:out value="${searchSubject.description}"/>', '<c:out value="${searchSubject.subjectId}"/>', '<c:out value="${searchSubject.stream.description}"/>', '<c:out value="${searchSubject.subjectCode}"/>','<c:out value="${searchSubject.govSubjectCode}"/>',showArea());"
              			width="18" height="20" class="icon"></sec:authorize><sec:authorize access="hasRole('Delete Subjects')"><img src="resources/images/ico_delete.gif"
              			onClick="document.form.subjectId.value='${searchSubject.subjectId}';
                        deleteSubject(this,showArea());" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize></td>
            	</tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <c:forEach var="subject" items="${subjectList}" varStatus="status">
           <tr <c:if test="${selectedObjId != null && (selectedObjId == subject.subjectId)}">class="highlight"</c:if>
            <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              		<td><c:out value="${subject.description}"></c:out></td>
             	 	<td><c:out value="${subject.subjectCode}"></c:out></td>
               	 	<td><c:out value="${subject.govSubjectCode}"></c:out></td>
               	 	<td><c:out value="${subject.stream.description}"></c:out></td>
           	  		<td nowrap class="right"><sec:authorize access="hasRole('Add/Edit Subjects')"><img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.SUBJECT.EDIT"/>"
              			onClick="showDown(true),testSave(this,'<c:out value="${subject.description}" />', '<c:out value="${subject.subjectId}" />', '<c:out value="${subject.stream.description}"/>', '<c:out value="${subject.subjectCode}"/>', '<c:out value="${subject.govSubjectCode}"/>',showArea())"
              			width="18" height="20" class="icon"></sec:authorize><sec:authorize access="hasRole('Delete Subjects')">
              			<img src="resources/images/ico_delete.gif"
              			onClick="document.form.subjectId.value='${subject.subjectId}';
                        deleteSubject(this,showArea())" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize>
           </c:forEach>
           </c:otherwise>
           </c:choose>
          </table>
        </div>
		</div>
		
		<div id="areaBot">       	
         	<c:if test="${!(message == null)}">
						<div class="error"> &nbsp;<label id="errormsg" class="required_sign">
						<c:out value="${message}" /> 
						</label></div>
			</c:if>
  		<div> <form:errors path="*" cssClass="required_sign" /></div></div>
  		
		<sec:authorize access="hasRole('Add/Edit Subjects')">
		<div class="section_full_inside" style='display: ${editpane != null ?'block':'none'}'>
          <h3><spring:message code="REF.UI.MANAGE.SUBJECT.ADD"/></h3>
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.SUBJECT.NAME"/>:</label>
                </div>
                <form:input id="inputSubDesc" path="description" maxlength="45"/>
                <form:hidden path="subjectId"/>
              </div>
			  <div class="float_right">
                <div class="lbl_lock">
                  <label><spring:message code="REF.UI.MANAGE.SUBJECT.STREAM"/>:</label>
                </div>
                <form:select path="stream.description" id="select">
                	<form:option value="select" id="selectOption"> <spring:message code="application.drop.down" /> </form:option>
                	<form:options itemLabel="description" items="${streamList}" itemValue="description"/>
                  </form:select>
              </div>
            </div>
            
            
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.SUBJECT.SHORT"/>:</label>
                </div>
                <form:input id="inputSubCode" path="subjectCode" maxlength="5"/>
              </div>			 
            
                         
              <div class="float_right">
                <div class="lbl_lock">
                  <span class="required_sign"></span><label><spring:message code="REF.UI.MANAGE.SUBJECT.CODE"/>:</label>
                </div>
                <form:input id="inputGovSubCode" path="govSubjectCode" maxlength="10"/>
               
              </div>			 
            </div>
            
            <div class="row">
              <div class="buttion_bar_type1">
                <input type="button" class="button" onClick="saveSubject(this);"
                     value="<spring:message code="REF.UI.SAVE"/>"><input type="button" class="button" onClick="showArea();setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>"></sec:authorize>
              </div>
            </div>
            <div class="clearfix"></div>
          </div>
        </div>
        <div class="clearfix"></div>
      </div>

    </form:form>
  </div>
</div>
<h:footer />
</body>
</html>
