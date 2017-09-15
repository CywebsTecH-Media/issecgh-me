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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.virtusa.akura.api.dto.ClassGrade"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>
<!-- START -->
<!-- msdropdown -->
<link rel="stylesheet" type="text/css" href="resources/css/dd.css" /> 
<script src="resources/js/jquery.dd.min.js"></script>
<!-- msdropdown> -->

<link rel="stylesheet" type="text/css" href="resources/css/skin2.css" />
<link rel="stylesheet" type="text/css" href="resources/css/flags.css" />

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

//delete student
function deleteStudent(thisObj, studentId) {

$(thisObj).parents('tr').addClass('highlight');

var message = "<spring:message code='REF.DELETE.CONFIRMATION'/>" ;
var okfunction = function(){
	document.getElementById('selectedStudentId').value = studentId;
	document.searchStudent.action = "deleteStudent.htm";
	            document.searchStudent.submit();

};

var cancelfunction = function(){
	$(thisObj).parents('tr').removeClass('highlight');
};

confirm_function(message , okfunction, cancelfunction );

}

		//Used of pagination in onclick event of previous and next buttons
		function previousOrNext(value, startFrom){
			pageSize = 10;
			var actionTypeVal = '<c:out value="${actionType}"/>';
			document.getElementById('isPagination').value = "true";
			
			if(actionTypeVal == "search"){
				document.searchStudent.actionType.value = actionTypeVal;
					if(value == "next"){
						startFrom = parseInt(startFrom) + pageSize;
						document.searchStudent.startFrom.value = startFrom + "";	
					
					}else if(value == "previous"){
						startFrom = parseInt(startFrom) - pageSize;
						document.searchStudent.startFrom.value = startFrom + "";
					
					}
				document.searchStudent.submit();
				
			} else if(actionTypeVal == "advancedSearch"){
				document.searchAdvanceStudent.actionType.value = actionTypeVal;
					if(value == "next"){
						startFrom = parseInt(startFrom) + pageSize;
						document.searchAdvanceStudent.startFrom.value = startFrom + "";
					
					
					}else if(value == "previous"){
						startFrom = parseInt(startFrom) - pageSize;
						document.searchAdvanceStudent.startFrom.value = startFrom + "";
					
					}
				document.searchAdvanceStudent.submit();
			}
			
		}

function fillStudentDetails(studentId,studentClass) {

var url = '<c:url value="/loadStudentDetails.htm" />';

$.ajax({
                url:url,
       data:({
             'studentId': studentId, 'studentClass':studentClass
             
       }),
       success: function(response) {
       	<c:url value="/studentDetails.htm" var="gotourl" />
        location.replace('<c:out value="${gotourl}" escapeXml="true"/>');
       },
       error: function(transport) {
    	   custom_alert("An error has occurred.");
       }
        });
     }

function addNewStudent(thisVal) {
document.newStudent.eventValue.value = thisVal;
document.newStudent.action='newStudentDetails.htm';
document.newStudent.submit();
}

function viewAdvanceSearch(){
document.getElementById('clazzId').value = 0;
document.getElementById('sportId').value = 0;
document.getElementById('subjectId').value = 0;
document.getElementById('prefectTypeId').value = 0;
document.getElementById('workingSegmentId').value = 0;
document.getElementById('addsearch_results').style.display='';
document.getElementById('search_results').style.display='none';
document.getElementById('last_name').value = "";
document.getElementById('admission_number').value = "";
document.getElementById('grade').value = 0;
document.getElementById('status_id').value = 0;
document.getElementById('year').value = 0;
}
//open pop up menu window
function openWindow(url){
var newWindow=window.open(url,'_blank','status=0,toolbar=0,menubar=0,location=0,resizable=1,width = 980,scrollbars=1');
newWindow.location=url;
}

function setActionTypeSearch(){
	document.searchStudent.actionType.value = 'search';
}

function setActionTypeAdvancedSearch(){
	document.searchAdvanceStudent.actionType.value = 'advancedSearch';
}

</script>

<script>

$(document).ready(function(e) {
	try {
		var pages = $("#pages").msDropdown({on:{change:function(data, ui) {
												var val = data.value;
												if(val!="")
													window.location = val;
											}}}).data("dd");

		var pagename = document.location.pathname.toString();
		pagename = pagename.split("/");
		pages.setIndexByValue(pagename[pagename.length-1]);
		$("#ver").html(msBeautify.version.msDropdown);
	} catch(e) {
		//console.log(e);
	}

	$("#ver").html(msBeautify.version.msDropdown);

	//convert
	$("#contactResidence").msDropdown();
	$("#contactMobile").msDropdown();
	$("#contactResidenceEmg").msDropdown();
	$("#contactMobileEmg").msDropdown();
	$("#contactOfficeEmg").msDropdown();

});
function showValue(h) {
	console.log(h.name, h.value);
}
$("#tech").change(function() {
	console.log("by jquery: ", this.value);
})

    function selectCountry(selectedResCountry,selectedMobCountry,selectedOfficeCountry,selectedOfficeFaxCountry) {
    	if(selectedResCountry != null && selectedResCountry != ""){
    		$('#contactResidence').msDropDown().data('dd').set('value',selectedResCountry);
    	}
    	if(selectedMobCountry != null && selectedMobCountry != ""){
    		$('#contactMobile').msDropDown().data('dd').set('value',selectedMobCountry);
    	}
    	if(selectedOfficeCountry != null && selectedOfficeCountry != ""){
    		$('#contactOffice').msDropDown().data('dd').set('value',selectedOfficeCountry);
    	}

    	if(selectedOfficeFaxCountry != null && selectedOfficeFaxCountry != ""){
    		$('#contactOfficeFax').msDropDown().data('dd').set('value',selectedOfficeFaxCountry);
    	}
    }
</script>

<script>
	$("#search_results").ready(function() {
		  $("html, body").animate({ scrollTop: $(document).height() }, "fast");
	});
</script>

</head>
<body onload="<c:if test="${critiria != null}">selectCountry('<c:out value="${selectedResCountry}" />','<c:out value="${selectedMobCountry}" />','<c:out value="${selectedOfficeCountry}" />','<c:out value="${selectedOfficeFaxCountry}" />');</c:if>">

	<h:headerNew parentTabId="10" page="studentSearch.htm" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currentYear" value="${now}" pattern="yyyy" />
	
	<div id="page_container">
		<div id="breadcrumb">
			<ul>
				<li><a href="adminWelcome.htm"><spring:message
							code="application.home" /> </a>&nbsp;&gt;&nbsp;</li>
				<li><spring:message code="STUDENT.SEARCH.TITLE" /></li>
			</ul>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/searchStudentHelp.html"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code="application.help" />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="STUDENT.SEARCH.TITLE" />
		</h1>
		<div>
			<label class="required_sign"> <c:if test="${message != null}">${message}</c:if>
			</label>
		</div>
		<div id="content_main">
			<form:form method="POST" commandName="critiria" name="searchStudent"
				action="Search.htm">

				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border" >
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.LAST.NAME" />
									</label>
								</div>
								<form:input path="lastName" id="last_name"/>
								<br />
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STUDENT.SEARCH.ADMISSION.NO" /> </label>
								</div>
								<form:input path="admissionNumber" id="admission_number"/>
								<br />
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.GRADE" />
									</label>
								</div>

								<form:select path="grade" id="grade">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<option value="New"
										<c:if test='${isSelectNew}'> selected="selected" </c:if>>
										<spring:message code="STUDENT.SEARCH.UI.NEW.STUDENT.LABEL" />
									</option>
									<form:options items="${gradeList}" itemValue="description"
										itemLabel="description" />
								</form:select>

							</div>
							</div>
							<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.STATUS" />
									</label>
								</div>

								<form:select path="studentStatusId"  style="width:206px" id="status_id">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${studentStatusList}"
										itemValue="studentStatusId" itemLabel="description" />
								</form:select>
								<br />
							</div>
							<!------------------------------------>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.YEAR" />
									</label>
								</div>
								
									<form:select path="year" style="width:206px" id="year">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach var="i" begin="0" end="15" varStatus="loop" step="1">
													<form:option value="${currentYear+1 - i}">${currentYear+1 - i}</form:option>
							          	</c:forEach>
							          </form:select>
							</div>
							<!-- ------------------------------------------------->
							<div class="float_right">

								<div class="buttion_bar_type1">
									<sec:authorize access="hasRole('Student Search')">
										<input type="submit"
											value="<spring:message code="REF.UI.SEARCH"/>" class="button" onclick="setActionTypeSearch();">
									</sec:authorize>
									<sec:authorize access="hasRole('Student Search')">
									<input type="button"
										value="<spring:message code="REF.UI.ADVANCE.SEARCH"/>"
										onClick="viewAdvanceSearch();" class="button">
								</sec:authorize>
								</div>
							</div>
							</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<input type="hidden" name="isPagination" id="isPagination" value="false"/>
				<input type="hidden" name="selectedStudentId" id="selectedStudentId" />
				<input type="hidden" name="startFrom" id="startFrom" value="0" />
				<input type="hidden" name="actionType" id="actionType" />
			</form:form>

			<form:form method="POST" commandName="critiria"
				name="searchAdvanceStudent" action="Search.htm">
				<div class="section_full_search" id="addsearch_results"
					style='display: ${showEditSection != null ?'block':'none'}'>
					<div class="box_border">
					<div>
						<label class="required_sign"> <c:if test="${nocriteria != null}">${nocriteria}</c:if>
						</label>
					</div>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.CLASS" />
									</label>
								</div>
								<form:select path="clazzId" id="clazzId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${classList}" itemValue="classGradeId"
										itemLabel="description" />
								</form:select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.SPORT" />
									</label>
								</div>

								<form:select path="sportId" id="sportId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${sportList}" itemValue="sportId"
										itemLabel="description" />
								</form:select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.SUBJECT" />
									</label>
								</div>
								<form:select path="subjectId" id="subjectId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${subjectList}" itemValue="subjectId"
										itemLabel="description" />
								</form:select>

							</div>
							<div class="float_right">
								<div class="buttion_bar_type1">

									<sec:authorize access="hasRole('Student Search')">

										<input type="submit"
											value="<spring:message code="REF.UI.SEARCH"/>" class="button" onclick="setActionTypeAdvancedSearch();">

									</sec:authorize>
								</div>
							</div>

						</div>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STUDENT.SEARCH.PREFECT.TYPE" /> </label>
								</div>
								<form:select path="prefectTypeId" id="prefectTypeId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${prefectTypeList}"
										itemValue="prefectTypeId" itemLabel="description" />
								</form:select>
							</div>

							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="REF.UI.MANAGE.WORKING.SEGMENT" /> </label>
								</div>
								<form:select path="workingSegmentId" id="workingSegmentId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${workingSegmentList}"
										itemValue="workingSegmentId" itemLabel="description" />
								</form:select>
							</div>
							
							<div class="float_left">
                				<div class="lbl_lock">
                 					 <label><spring:message
											code="STUDENT.SEARCH.PARENT.NIC" /></label>
               					 </div>
                 				<form:input  path="parentNIC" maxlength="45" />
                 				<br />
							</div>
							
							
					
							<div class="row">
			<div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message
											code="STUDENT.SEARCH.PARENT.MOBILE" /></label>
                </div>
                 <select style="width:130px; line-height:10px !important;" id="contactMobile" name="selectedCountryCodeMob">
			  <option value="0">
										<spring:message code="application.drop.down" />
									</option>
      
      <c:forEach items="${countryListPhone}" var="countryListPhone"
										varStatus="status">
										<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />								
										<option value='${countryListPhone.value.countryCode}'
											data-image="resources/images/blank.gif"
											data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}"
											data-title='${countryListPhone.value.countryName}'>
											${countryCode[0]}</option>
									</c:forEach>
    </select>&nbsp;<form:input  path="parentMobile" style=" width:108px !important;" class="phoneNo_text" maxlength="12"  />
			</div>
			</div>
			
			
 
      
						</div>

						<div class="clearfix"></div>
					</div>

				</div>
				<input type="hidden" name="isPagination" id="isPagination" value="false"/>
				<input type="hidden" name="selectedStudentId" id="selectedStudentId" />
				<input type="hidden" name="startFrom" id="startFrom" value="0" />
				<input type="hidden" name="actionType" id="actionType" />
			</form:form>

			<c:if
				test="${fn:length(studentList) > 0 || (studentList) == 'Empty' }">
				<div class="section_box" id="search_results" style="display: block">

					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.SEARCH.RESULTS.TITLE" />
						</h2>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th style="width: 120px;">
								<spring:message code="STUDENT.SEARCH.ADMISSION.NO.HEADER" />
								</th>
								<th><spring:message code="STUDENT.SEARCH.STUDENT.NAME" />
								</th>
								<th><spring:message
										code="STUDENT.SEARCH.STUDENT.GRADE.CLASS" /></th>
								<th width="150" class="right"><c:if
										test="${numberOfRecords == 0}">${critiria.startFrom}</c:if> <c:if
										test="${numberOfRecords > 0}">${critiria.startFrom+1}</c:if> -
										${critiria.maxNumber} of ${totalNoOfStudent}<br/>
									<input
									type="image" class="button" width="15" height="15"
									src="resources/images/leftSideArrow.png"
									title="<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.PREVIOUS'/>"
									onclick="previousOrNext('previous', '<c:out value="${critiria.startFrom}"/>');"
									<c:if test="${critiria.startFrom == 0}">disabled="disabled"</c:if>>
									<input type="image" width="20" height="15" class="button"
									src="resources/images/rightSideArrow.png"
									title="<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.NEXT'/>"
									onclick="previousOrNext('next', '<c:out value="${critiria.startFrom}"/>')"
									<c:if test="${critiria.maxNumber == totalNoOfStudent}">disabled="disabled"</c:if>>
								</th>
							</tr>


							<c:choose>
								<c:when test="${(studentList) == 'Empty' }">
									<tr class="odd">
										<td style="width: 200px;"><spring:message
												code="STUDENT.SEARCH.NO.RESULTS.FOUND" /></td>
									<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:when>

								<c:otherwise>
									<c:forEach items="${studentList}" var="student"
										varStatus="status">
																					
										<tr
											class="<c:if test="${status.count % 2 == 0}">even</c:if>
												<c:if test="${status.count % 2 == 1}">odd</c:if>">
											<sec:authorize access="hasRole('View Student Details')">
											 <td>
											   ${student[2]}
											 </td>
											    <td>
														<a
															href="javascript:fillStudentDetails(${student[0]},'${student[3]}')">
															${student[1]} </a>
													</td>
												
												<td>
													<c:if test="${student[5] != 2}">
														<c:choose>
															<c:when test="${student[4] == null}">New Student</c:when>
															<c:when test="${student[4] == year}">${student[3]}</c:when>
															<c:otherwise></c:otherwise>
														</c:choose>
														</c:if>
												</td>
												<td class="right">
												<sec:authorize access="hasRole('Terminate Student')">
												<c:if
														test="${student[5] == 1 and student[6] <= currentDate }">

														<img src="resources/images/ico_disableuser.gif" width="18"
															height="20" border="0" class="icon"
															onclick="openWindow('terminateStudent.htm?selectedStudentId=${student[0]}')"
															title="<spring:message code='REF.UI.TERMINATE'/>">

													</c:if>
													</sec:authorize>
													 <c:if test="${student[5] == 1 }">
														<sec:authorize access="hasRole('Edit Student')">
															<img src="resources/images/ico_edit.gif" width="18"
																height="20" border="0" class="icon"
																onclick="fillStudentDetails(${student[0]},'${student[3]}')"
																title="<spring:message code='STUDENT.SEARCH.EDIT'/>">
														</sec:authorize>
													</c:if> <c:if test="${student[5] == 1 }">
														<sec:authorize access="hasRole('Delete Student')">
															<img src="resources/images/ico_delete.gif"
																onClick="deleteStudent(this, ${student[0]})"
																title="<spring:message code='REF.UI.DELETE'/>"
																width="18" height="20" class="icon">
														</sec:authorize>
													</c:if>
													
													 <c:if test="${student[5] == 3 }">
														<sec:authorize access="hasRole('Activate Student')">
															<img src="resources/images/ico_user_sus.gif"
																onClick="openWindow('suspendStudentDetails.htm?selectedStudentId=${student[0]}')"
																title="<spring:message code='REF.UI.ACTIVATE_SUS'/>"
																width="18" height="20" class="icon">
															<c:set var="testSec" value="true" scope="page"></c:set>
														</sec:authorize>
														
														
														<c:if test="${!testSec}">
															<img src="resources/images/ico_user_sus_dis.gif"
																onClick=""
																title="<spring:message code='REF.UI.ACTIVATE_SUS'/>"
																width="18" height="20" class="icon">
														</c:if>
														
													</c:if> 
													
													
													<c:if test="${student[5] == 4 }">
														<sec:authorize access="hasRole('Activate Student')">
															
															<img src="resources/images/ico_user.gif"
																onClick="openWindow('manageActiveExtendTempStudentLeave.htm?selectedStudentId=${student[0]}&studentClass=${student[3]}&studentYear=${student[4]}')"
																title="<spring:message code='REF.UI.ACTIVATE_TMPRY_LV'/>"
																width="18" height="20" class="icon">
															<c:set var="testSec" value="true" scope="page"></c:set>
														</sec:authorize>
														
														<c:if test="${!testSec}">
															<img src="resources/images/ico_user_dis.gif" onClick=""
																title="<spring:message code='REF.UI.ACTIVATE_TMPRY_LV'/>"
																width="18" height="20" class="icon">
														</c:if>
													</c:if></td>
											</sec:authorize>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>

						</table>
					</div>

					<div class="clearfix"></div>
				</div>
			</c:if>
			<sec:authorize access="hasRole('Add New Student')">
				<div class="button_row">
					<div class="buttion_bar_type2">
						<form action="" name="newStudent">
							<input type="hidden" name="eventValue" /> <input type="button"
								value="<spring:message code="STUDENT.SEARCH.UI.NEW.STUDENT"/>"
								onClick="addNewStudent(this.value)" class="button">
						</form>
					</div>
					<div class="clearfix"></div>
				</div>
			</sec:authorize>
		</div>
	</div>
	<h:footer />
</body>

</html>