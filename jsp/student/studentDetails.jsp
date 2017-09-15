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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
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
<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
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
//
</script>
<!-- END -->
<script>

	$(document).ready(function() {

		var isPastPupil = document.getElementById("hasSibling").checked;
		if (isPastPupil) {
			document.getElementById("siblingAdmition").style.visibility = 'visible';
		} else {
			document.getElementById("siblingAdmition").style.visibility = 'hidden';
		}
	});

	$(function() {

		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		$('#birthDatePicker')
				.datepicker(
						{
							defaultDate : "+1w",
							yearRange : "-75:+0",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							showOn : "button",
							dateFormat : 'yy-mm-dd',
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
							onSelect : function(selectedDate) {
										instance = $(this).data("datepicker"),
										date = $.datepicker
												.parseDate(
														instance.settings.dateFormat
																|| $.datepicker._defaults.dateFormat,
														selectedDate,
														instance.settings);

								$("#admissionDatePicker").datepicker("option",
										"minDate", date);
							}
						});
	});

	$(function() {
	
	
	    var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();
	
		var dates = $(
				"#previousSchoolFromDatePicker, #previousSchoolToDatePicker")
				.datepicker(
						{
							defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							showOn : "button",
							dateFormat : 'yy-mm-dd',
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
						
						});
	});

	$(function() {
	
	    var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();
		
		var dates = $("#admissionDatePicker, #firstDatePicker")
				.datepicker(
						{
						
							
							defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							showOn : "button",
							dateFormat : 'yy-mm-dd',
							buttonImage : "resources/images/calendar.jpg",
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
							buttonImageOnly : true,
							
							onSelect : function(selectedDate) {
										instance = $(this).data("datepicker"),
										date = $.datepicker
												.parseDate(
														instance.settings.dateFormat
																|| $.datepicker._defaults.dateFormat,
														selectedDate,
														instance.settings);

							
							}
						});
	});

	function callAction(thisVal) {
		document.Form.action = "studentSearch.htm";
		document.Form.submit();
	}

	function resetAction(thisVal) {
		<c:if test="${student.studentId eq 0}">
		document.Form.action = "newStudentDetails.htm";
		</c:if>
		<c:if test="${student.studentId eq 1}">
		document.Form.action = "studentDetails.htm";
		</c:if>
		<c:if test="${student.studentId gt 1}">
		document.Form.action = "studentDetails.htm";
		</c:if>
		document.Form.submit();
	}

	// Disabling tabs when add new student.
	<c:if test="${student.studentId eq 0}">
	$(document).ready(function() {
		var firstElement = $("#menubar li").first();
		$("#menubar li a").removeAttr("href")
		$("#menubar li a").addClass("disabled")
	});
	</c:if>

	function setGender(){

		<c:if test="${user.role eq 'ROLE_PARENT' or user.role eq 'ROLE_STUDENT'}" >

		var inputs = document.getElementsByTagName('input');
		for (var i = 0; i < inputs.length; ++i) {
		  inputs[i].disabled = true;
		}

		var nSelect = document.getElementsByTagName('select');
		for (var i = 0; i < nSelect.length; ++i) {
		  nSelect[i].disabled = true;
		}

		var nTextArea = document.getElementsByTagName('textarea');
		for (var i = 0; i < nTextArea.length; ++i) {
		  nTextArea[i].disabled = true;
		}

		//var nSpan = document.getElementsByTagName('span');
		//for (var i = 0; i < nSpan.length; ++i) {
		 // nSpan[i].disabled = true;
		//}
		</c:if>

		<c:if test="${fn:contains(student.gender,'M')}">
			 document.getElementById("radioMale").checked = true;
			 document.getElementById("radioFemale").disabled = true;
			 document.getElementById("radioMale").value = 'M';
		</c:if>

		<c:if test="${fn:contains(student.gender,'F')}">
			document.getElementById("radioFemale").checked = true;
			document.getElementById("radioMale").disabled = true;
			document.getElementById("radioFemale").value = 'F';

		</c:if>
	}


	//Limit the text area input.
	function limitText(limitField, limitCount, limitNum) {
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} else {
			limitCount.value = limitNum - limitField.value.length;
		}
	}

	function getStudentSummary(admissionNo) {
		var url = "studentSummaryReport.htm?selectedAddmission="+admissionNo+"&flag="+true;
		PopupCenterReSize(url, 'studentSummaryReport', 1000, 500);

	}

	function getStudentReportCard(admissionNo, studentClass) {
		var studentClass = studentClass;
		var url = "studentReportCard.htm?selectedAddmission="+admissionNo+"&selectedClass="+studentClass;
		PopupCenterReSize(url, 'studentReportCard', 1000, 500);

	}

	function checkSibling(thisObj) {
		if (thisObj.checked) {

			document.getElementById("siblingAdmition").style.visibility = 'visible';
		} else {
			document.getElementById("siblingAdmitionNo").value = '';
			document.getElementById("siblingAdmition").style.visibility = 'hidden';
		}
	}

	function selectCountry(selectedResCountry,selectedMobCountry,selectedEmgResCountry,selectedEmgMobCountry,selectedEmgOffCountry) {
		if(selectedResCountry != null && selectedResCountry != ""){
			$('#contactResidence').msDropDown().data('dd').set('value',selectedResCountry);
		}

		if(selectedMobCountry != null && selectedMobCountry != ""){
			$('#contactMobile').msDropDown().data('dd').set('value',selectedMobCountry);
		}
		
		if(selectedEmgResCountry != null && selectedEmgResCountry != ""){
			$('#contactResidenceEmg').msDropDown().data('dd').set('value',selectedEmgResCountry);
		}

		if(selectedEmgMobCountry != null && selectedEmgMobCountry != ""){
			$('#contactMobileEmg').msDropDown().data('dd').set('value',selectedEmgMobCountry);
		}
		
		if(selectedEmgOffCountry != null && selectedEmgOffCountry != ""){
			$('#contactOfficeEmg').msDropDown().data('dd').set('value',selectedEmgOffCountry);
		}
	}
</script>

</head>
<body
	onload="<c:if test="${student != null}">selectCountry('<c:out value="${selectedResCountry}" />','<c:out value="${selectedMobCountry}" />','<c:out value="${selectedEmgResCountry}" />','<c:out value="${selectedEmgMobCountry}" />','<c:out value="${selectedEmgOffCountry}" />');</c:if>setGender();">


	<c:choose>
		<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="studentDetails.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="studentDetails.htm" />
		</c:otherwise>
	</c:choose>

	<div id="page_container">
		<div id="breadcrumb">
			<ul>
				<li><a href="adminWelcome.htm"><spring:message
							code="application.home" />
				</a>&nbsp;&gt;&nbsp;</li>
				<sec:authorize access="hasRole('Student Search')">
					<li><a href="studentSearch.htm"><spring:message
								code="STUDENT.STUDENTSEARCH" />
					</a>&nbsp;&gt;&nbsp;</li>
				</sec:authorize>
				<li><spring:message code="STUDENT.STUDENTDETAILS.TITLE" />
				</li>
			</ul>

		</div>

		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentDetailsHelp.html"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle">
			<spring:message code="application.help" />
			</a>
		</div>

		<div id="breadcrumb_area">
			<c:if test="${showAcademicLifeBar eq 'on'}">
				<div id="progress_bar_wraper">
					<label><spring:message
							code="STUDENT.PROGRESS.ACADEMIC_LIFE" />
					</label>
					<div class="progress_bar">
						<c:if test="${not empty averageAcademicLife}">
							<div class="colour_bar"
								style="width:<c:out value="${averageAcademicLife}"/>px"></div>
							<div class="prog_value">
								<c:out value="${averageAcademicLife}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${showReligiousActivitiesBar eq 'off'}">
				<div id="progress_bar_wraper">
					<label><spring:message
							code="STUDENT.PROGRESS.RELIGIOUS_ACTIVITY" />
					</label>
					<div class="progress_bar">
						<c:if test="${!(averageFaithLife == null)}">
							<div class="colour_bar"
								style="width: <c:out value="${averageFaithLife}" />px"></div>
							<div class="prog_value">
								<c:out value="${averageFaithLife}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${showAttendanceBar eq 'on'}">
				<div id="progress_bar_wraper">
					<label><spring:message code="STUDENT.PROGRESS.ATTENDANCE" />
					</label>
					<div class="progress_bar">
						<c:if test="${!(attendanceRating == null)}">
							<div class="colour_bar"
								style="width: <c:out value="${attendanceRating}" />px"></div>
							<div class="prog_value">
								<c:out value="${attendanceRating}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
		<c:if test="${student.studentId gt 0}">
			<sec:authorize access="hasRole('Print Student Summary')">
				<div class="row">
					<div class="float_right">
						<a href="#" onclick="getStudentSummary('${student.admissionNo}');">
							<img src="resources/images/print_icon.gif" width="20" height="20"
							align="absmiddle">
						<spring:message code="STUDENT.STUDENT.DETAILS.PRINT.SUMMARY" /> </a>
					</div>
					<c:if test="${subjectsExistOrNot != null}">
						<div class="float_right">
							<a href="#"
								onclick="getStudentReportCard('${student.admissionNo}','${studentGradeClass}');">
								<img src="resources/images/print_icon.gif" width="20"
								height="20" align="absmiddle">
							<spring:message code="STUDENT.STUDENT.DETAILS.REPORT.CARD" /> </a>
						</div>
					</c:if>
				</div>
			</sec:authorize>
		</c:if>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="STUDENT.STUDENTDETAILS.TITLE" />
		</h1>
		<div>
			<label class="success_sign"> <c:if test="${message != null}">${message}</c:if>
			</label>
		</div>
		<div>
			<!-- updte succes message comes through query string (after redircting) -->
			<label class="success_sign"> ${param.successUpdate}</label>
		</div>

		<div id="content_main">
			<form:form method="POST" commandName="student" name="Form"
				action="saveStudentDetails.htm" enctype="multipart/form-data">
				<div class="section_box">
					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.STUDENTDETAILS.GENERALINFO" />
						</h2>
					</div>
					<div>
						<label class="required_sign"> <c:if
								test="${errorMessage != null}">${errorMessage}</c:if> </label>
					</div>
					<label class="required_sign"> <spring:bind path="student.*">
							<c:forEach items="${status.errorMessages}" var="error">
								<c:out value="${error}" />
								<br>
							</c:forEach>
						</spring:bind> </label>
					<%-- <h4>
						<form:errors path="studentId" cssClass="required_sign" />
					</h4> --%>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.ADMISSIONNO" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="admissionNo" maxlength="20" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.FULLNAME" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="fullName" maxlength="100" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.NAMEINITIALS" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="nameWtInitials" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.LASTNAME" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="lastName" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.NIC" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="nationalIdNo" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.GENDER" />:</label>
							</div>
							<div class="frmvalue">
								<form:radiobutton id="radioMale" path="gender" value="" label=""
									cssClass="radio_btn" onclick="this.value='M'" />
								<spring:message code="STUDENT.STUDENTDETAILS.GENERALINFO.MALE" />
								<form:radiobutton id="radioFemale" path="gender" value=""
									label="" cssClass="radio_btn" onclick="this.value='F'" />
								<spring:message code="STUDENT.STUDENTDETAILS.GENERALINFO.FEMALE" />
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.DATEOFBIRTH" />:</label>
							</div>
							<div class="frmvalue">
								<form:input id="birthDatePicker" path="dateOfBirth"
									cssClass="date_field" title="Correct date format is yyyy-mm-dd" readonly="true"/>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.DATEOFADMISSION" />:</label>
							</div>
							<div class="frmvalue">
								<form:input id="admissionDatePicker" path="admissionDate"
									cssClass="date_field" title="Correct date format is yyyy-mm-dd" readonly="true"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.FIRSTDAYSCHOOL" />:</label>
							</div>
							<div class="frmvalue">
								<form:input id="firstDatePicker" path="firstSchoolDay"
									cssClass="date_field" readonly="true" />
							</div>
						</div>
						<c:if test="${student.dateOfDeparture != null}">
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STUDENT.STUDENTDETAILS.GENERALINFO.LASTDAYSCHOOL" />:</label>
								</div>
								<div class="frmvalue">
									<form:input id="dateOfDeparture" path="dateOfDeparture"
										cssClass="date_field" />
								</div>
							</div>
						</c:if>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.RELIGION" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="religionId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${religionList}" itemValue="religionId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.HOSTELER" />:</label>
							</div>
							<div class="frmvalue">
								<form:checkbox path="hosteler" id="hosteler"
									cssClass="checkbox" value="checkbox"		 />
							</div>
							</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.RACE" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="raceId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${raceList}" itemValue="raceId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.HAS.SIBLING" /> </label>
							</div>
							<div class="frmvalue">
								<form:checkbox path="hasSibling" id="hasSibling"
									cssClass="checkbox" value="checkbox"
									onclick="checkSibling(this);" />
							</div>
						</div>

						<div class="row" id="siblingAdmition">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.ADMISSIONNO" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="siblingAdmitionNo" id="siblingAdmitionNo" maxlength="20"/>
							</div>
						</div>
						<div class="row" style="display: none;">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.STATUS" />:</label>
							</div>
							<div class="frmvalue">
								<form:radiobutton path="isOldBoy" value="false" label=""
									cssClass="radio_btn" />
								<spring:message
									code="STUDENT.STUDENTDETAILS.GENERALINFO.CURRENTSTUDENT" />
								<form:radiobutton path="isOldBoy" value="true" label=""
									cssClass="radio_btn" />
								<spring:message
									code="STUDENT.STUDENTDETAILS.GENERALINFO.PASTSTUDENT" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.STUDYMEDIUM" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="languageId">
									<form:option value="0">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${studyMediumList}"
										itemValue="studyMediumId" itemLabel="studyMediumName" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.NATIONALITY" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="nationalityId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${nationalityList}"
										itemValue="nationalityId" itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.COUNTRY" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="countryId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${countryList}" itemValue="countryId"
										itemLabel="countryName" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.BLOODGROUP" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="bloodGroupId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${bloodGroupList}"
										itemValue="bloodGroupId" itemLabel="description" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.HOUSE" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="houseId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${houseList}" itemValue="houseId"
										itemLabel="name" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.TRAVEL" />: <br>
									<spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.OPTION1" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="travelId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${methodOfTravelList}"
										itemValue="travelId" itemLabel="travelMethod" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.TRAVEL" />: <br>
									<spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.OPTION2" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="travelId2">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${methodOfTravelList}"
										itemValue="travelId" itemLabel="travelMethod" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.TRAVEL" />: <br>
									<spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.OPTION3" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="travelId3">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${methodOfTravelList}"
										itemValue="travelId" itemLabel="travelMethod" />
								</form:select>
							</div>
						</div>

					</div>
					<div class="column_equal">
						<div class="clearfix"></div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.IMAGE" />:</label>
							</div>
							<c:choose>
								<c:when test="${ImagePath != null}">
									<div class="frmvalue" align="right">
										<img src="${ImagePath}" name="image" id="image" border="1"
											align="middle" height="${ImageHeight}" width="${ImageWidth}">
									</div>
								</c:when>
								<c:otherwise>
									<div class="frmvalue" align="right">
										<img src="${defaultImage}" name="image" id="image" border="1"
											align="middle" height="${ImageHeight}" width="${ImageWidth}">
									</div>
								</c:otherwise>
							</c:choose>

						</div>
						<div class="row">
							<div class="frmlabel">
								<label style="line-height: 10px;"><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.CHANGEIMAGE" />:</label>
							</div>
							<div class="frmvalue">
								<input name="mPhoto" type="file" style="width: 290px;" value=""
									id="mPhoto">
							</div>
						</div>

						<div class="row">
							<strong><spring:message
									code="STUDENT.STUDENTDETAILS.GENERALINFO.PADDRESS" />
							</strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.ADDRESS" />:</label>
							</div>
							<div class="frmvalue">
								<form:textarea path="address" id="address" cols="30" rows="2"
									onkeydown="limitText(this.form.address,this.form.countdown,350);"
									onkeyup="limitText(this.form.address,this.form.countdown,350);" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.CITY" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="cityId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${cityList}" itemValue="cityId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<strong><spring:message
									code="STUDENT.STUDENTDETAILS.GENERALINFO.TADDRESS" />
							</strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.ADDRESS" />:</label>
							</div>
							<div class="frmvalue">
								<form:textarea path="temporaryAddress" id="temporaryAddress"
									cols="30" rows="2"
									onkeydown="limitText(this.form.temporaryAddress,this.form.countdown,350);"
									onkeyup="limitText(this.form.temporaryAddress,this.form.countdown,350);" />
							</div>

						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.CITY" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="temporaryCityId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${cityList}" itemValue="cityId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>


						<div class="row">
							<strong><spring:message
									code="STUDENT.STUDENTDETAILS.GENERALINFO.CONTACTDETAILS" />
							</strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.PHONERES" />:</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
                                <select style="width: 130px" name="selectedCountryCodeRes"
                                    id="contactResidence">
                                    <option value="0">
                                        <spring:message code="application.drop.down" />
                                    </option>
                                    <c:forEach items="${countryListPhone}" var    ="countryListPhone"
                                        varStatus="status">
                                        <c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
                                        <option value='${countryListPhone.value.countryCode}'
                                            data-image="resources/images/blank.gif"
                                            data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}"
                                            data-title='${countryListPhone.value.countryName}'>
                                            ${countryCode[0]}</option>   
                                    </c:forEach>
                                </select>
                                <form:input path="residenceNo" maxlength="12"
                                    class="phoneNo_text" />
                            </div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.PHONEMOB" />:</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select style="width: 130px" name="selectedCountryCodeMob"
									id="contactMobile">
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
								</select>
								<form:input path="mobileNo" maxlength="12" class="phoneNo_text" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.EMAIL" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="email" maxlength="45" />
							</div>
						</div>					
					</div>
					<div class="clearfix"></div>
				</div>

				<div class="section_box">
					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.STUDENTDETAILS.PREVIOUS" />
						</h2>
					</div>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.SCHOOL" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="previousSchoolName" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.GRADE" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="previousSchoolStudiedGrade" maxlength="45" />
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.FROMDATE" />:</label>
							</div>
							<div class="frmvalue">
								<form:input id="previousSchoolFromDatePicker"
									path="previousSchoolFromDate" cssClass="date_field"
									title="Correct date format is yyyy-mm-dd" readonly="true"/>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.TODATE" />:</label>
							</div>
							<div class="frmvalue">
								<form:input id="previousSchoolToDatePicker"
									path="previousSchoolToDate" cssClass="date_field"
									title="Correct date format is yyyy-mm-dd" readonly="true"/>
							</div>
						</div>


					</div>
					<div class="column_equal">

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.GRADEPASSED" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="previousSchoolPassedGrade" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.STUDIEDMEDIUM" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="previousSchoolStudyMediumId">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${studyMediumList}"
										itemValue="studyMediumId" itemLabel="studyMediumName" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.PREVIOUS.REASON" />:</label>
							</div>
							<div class="frmvalue">
								<form:textarea path="previousSchoolReasonForLeave" id="previousSchoolReasonForLeave" rows="2"
									cols="30" cssStyle="width:290px;" 
									onkeydown="limitText(this.form.previousSchoolReasonForLeave,this.form.countdown,45);"
									onkeyup="limitText(this.form.previousSchoolReasonForLeave,this.form.countdown,45);"/>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

				<div class="section_box">
					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.STUDENTDETAILS.DISABILITIES" />
						</h2>
					</div>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.ALLERGIES" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.allergiesMedicalNotes" id="allergiesMedicalNotes"
											rows="3" cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.allergiesMedicalNotes,this.form.countdown,300);" 
											onkeyup="limitText(this.form.allergiesMedicalNotes,this.form.countdown,300);">${studentDisability.allergiesMedicalNotes}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.allergiesMedicalNotes" id="allergiesMedicalNotes"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.allergiesMedicalNotes,this.form.countdown,300);" 
											onkeyup="limitText(this.form.allergiesMedicalNotes,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.INFORMATION" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.disabilityInfo" id="disabilityInfo" rows="3"
											cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.disabilityInfo,this.form.countdown,300);" 
											onkeyup="limitText(this.form.disabilityInfo,this.form.countdown,300);">${studentDisability.disabilityInfo}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.disabilityInfo" id="disabilityInfo"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.disabilityInfo,this.form.countdown,300);" 
											onkeyup="limitText(this.form.disabilityInfo,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.HEARING" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.hearingImpairment" rows="3" id="hearingImpairment"
											cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.hearingImpairment,this.form.countdown,300);" 
											onkeyup="limitText(this.form.hearingImpairment,this.form.countdown,300);">${studentDisability.hearingImpairment}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.hearingImpairment" id="hearingImpairment"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.hearingImpairment,this.form.countdown,300);" 
											onkeyup="limitText(this.form.hearingImpairment,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.VISUAL" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.visualImpairment" id="visualImpairment" rows="3"
											cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.visualImpairment,this.form.countdown,300);" 
											onkeyup="limitText(this.form.visualImpairment,this.form.countdown,300);">${studentDisability.visualImpairment}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.visualImpairment" id="visualImpairment"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.visualImpairment,this.form.countdown,300);" 
											onkeyup="limitText(this.form.visualImpairment,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.SPEECH" />:<br>
									<spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.LANGUAGE" />
								</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.speechDifficulties" rows="3" id="speechDifficulties"
											cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.speechDifficulties,this.form.countdown,300);" 
											onkeyup="limitText(this.form.speechDifficulties,this.form.countdown,300);">${studentDisability.speechDifficulties}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.speechDifficulties" id="speechDifficulties"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.speechDifficulties,this.form.countdown,300);" 
											onkeyup="limitText(this.form.speechDifficulties,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.DYSLEXIA" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.dyslexia" rows="3" cols="30" id="dyslexia"
											style="width: 290px;" 
											onkeydown="limitText(this.form.dyslexia,this.form.countdown,300);" 
											onkeyup="limitText(this.form.dyslexia,this.form.countdown,300);">${studentDisability.dyslexia}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.dyslexia" rows="3" id="dyslexia"
											cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.dyslexia,this.form.countdown,300);" 
											onkeyup="limitText(this.form.dyslexia,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.PHYSICAL" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.physicalDisabilities" id="physicalDisabilities"
											rows="3" cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.physicalDisabilities,this.form.countdown,300);" 
											onkeyup="limitText(this.form.physicalDisabilities,this.form.countdown,300);">${studentDisability.physicalDisabilities}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.physicalDisabilities" id="physicalDisabilities"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.physicalDisabilities,this.form.countdown,300);" 
											onkeyup="limitText(this.form.physicalDisabilities,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.FITS" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.fits" rows="3" cols="30" id="fits"
											style="width: 290px;" 
											onkeydown="limitText(this.form.fits,this.form.countdown,300);" 
											onkeyup="limitText(this.form.fits,this.form.countdown,300);">${studentDisability.fits}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.fits" rows="3" id="fits"
											cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.fits,this.form.countdown,300);" 
											onkeyup="limitText(this.form.fits,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.BEHAVIOR" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.behaviourDifficulties" id="behaviourDifficulties"
											rows="3" cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.behaviourDifficulties,this.form.countdown,300);" 
											onkeyup="limitText(this.form.behaviourDifficulties,this.form.countdown,300);">${studentDisability.behaviourDifficulties}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.behaviourDifficulties" id="behaviourDifficulties"
											rows="3" cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.behaviourDifficulties,this.form.countdown,300);" 
											onkeyup="limitText(this.form.behaviourDifficulties,this.form.countdown,300);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.DISABILITIES.OTHER" />:</label>
							</div>
							<div class="frmvalue">
								<c:choose>
									<c:when test="${studentDisability != null}">
										<textarea name="studentDisability.otherInfo" rows="3" id="otherInfo"
											cols="30" style="width: 290px;" 
											onkeydown="limitText(this.form.otherInfo,this.form.countdown,400);" 
											onkeyup="limitText(this.form.otherInfo,this.form.countdown,400);">${studentDisability.otherInfo}</textarea>
									</c:when>
									<c:otherwise>
										<form:textarea path="studentDisability.otherInfo" rows="3" id="otherInfo"
											cols="30" cssStyle="width:290px;" 
											onkeydown="limitText(this.form.otherInfo,this.form.countdown,400);" 
											onkeyup="limitText(this.form.otherInfo,this.form.countdown,400);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

				<div class="section_box">
					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.STUDENTDETAILS.EMERGENCYCONTACT" />
						</h2>
					</div>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.FULLNAME" />:</label>
							</div>
							<div class="frmvalue">
								<form:errors path="emergencyContactFullName"
									cssClass="required_sign" />
								<form:input path="emergencyContactFullName" maxlength="100" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.NAMEINITIALS" />:</label>
							</div>
							<div class="frmvalue">
								<form:errors path="emergencyContactNameWtInitials"
									cssClass="required_sign" />
								<form:input path="emergencyContactNameWtInitials" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.LASTNAME" />:</label>
							</div>
							<div class="frmvalue">
								<form:errors path="emergencyContactLastName"
									cssClass="required_sign" />
								<form:input path="emergencyContactLastName" maxlength="45" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.EMERGENCYCONTACT.RELATIONSHIP" />:</label>
							</div>
							<div class="frmvalue">
								<form:select path="emergencyContactRelationship">
									<form:option value="">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:options items="${emergencyContactRelationList}" />
								</form:select>
							</div>
						</div>
					</div>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.PHONERES" />:</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select style="width: 130px" name="selectedCountryCodeEmgRes"
									id="contactResidenceEmg">
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
								</select>
								<form:input path="emergencyContactResidenceNo" maxlength="12"
									class="phoneNo_text" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.PHONEMOB" />:</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select style="width: 130px" name="selectedCountryCodeEmgMob"
									id="contactMobileEmg">
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
								</select>
								<form:input path="emergencyContactMobileNo" maxlength="12"
									class="phoneNo_text" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.EMERGENCYCONTACT.PHONEOFF" />:</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select style="width: 130px" name="selectedCountryCodeEmgOffice"
									id="contactOfficeEmg">
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
								</select>
								<form:input path="emergencyContactOfficeNo" maxlength="12"
									class="phoneNo_text" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.STUDENTDETAILS.GENERALINFO.EMAIL" />:</label>
							</div>
							<div class="frmvalue">
								<form:input path="emergencyContactEmailAddress" maxlength="45"/>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

				<sec:authorize access="hasRole('Save Student Details')">
					<div class="button_row">
						<div class="buttion_bar_type2"
							<c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
							<input type="button"
								value='<spring:message code="REF.UI.RESET"/>' class="button"
								onclick="resetAction(this);"> <input type="submit"
								value='<spring:message code="REF.UI.SAVE"/>' class="button">
							<input type="button"
								value='<spring:message code="REF.UI.CANCEL"/>' class="button"
								onclick="callAction(this);">
						</div>
						<div class="clearfix"></div>
					</div>
				</sec:authorize>

				<!-- End of StudentDetail form -->
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
