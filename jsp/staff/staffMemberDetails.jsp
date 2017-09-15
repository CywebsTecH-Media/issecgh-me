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

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="PRAGMA" content="NO-CACHE">
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
<!-- msdropdown -->
<link rel="stylesheet" type="text/css" href="resources/css/dd.css" />
<script src="resources/js/jquery.dd.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/skin2.css" />
<link rel="stylesheet" type="text/css" href="resources/css/flags.css" />

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>





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

});
function showValue(h) {
	console.log(h.name, h.value);
}
$("#tech").change(function() {
	console.log("by jquery: ", this.value);
})
</script>
<!-- msdropdown> -->

<script>

	$(document).ready(
		function() {

			showCategorySpecificFields(${staff.staffCategory.catogaryID});

	});

	var date = new Date();
	var currentMonth = date.getMonth();
	var currentDate = date.getDate();
	var currentYear = date.getFullYear();

	$(function() {



		$('#dateOfBirth')
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

								$("#dateOfHire").datepicker("option",
										"minDate", date);
							}

						});
	});

	$(function() {

		$('#dateOfFirstAppointment')
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

								$("#dateOfHire").datepicker("option",
										"minDate", date);
							}

						});
	});

	$(function() {

		var dates = $("#dateOfHire, #dateOfDeparture")
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
							onSelect : function(selectedDate) {
										instance = $(this).data("datepicker"),
										date = $.datepicker
												.parseDate(
														instance.settings.dateFormat
																|| $.datepicker._defaults.dateFormat,
														selectedDate,
														instance.settings);

								if (this.id == "dateOfHire") {
									$("#dateOfBirth").datepicker("option",
											"maxDate", date);
									$("#dateOfDeparture").datepicker("option",
											"minDate", date);
								} else {
									$("#dateOfHire").datepicker("option",
											"maxDate", date);
								} 
							}
						});
	});
</script>
<!-- END Calender controll CSS and JS -->

<script type="text/javascript">
	function saveStaffDetails() {
		var staffId = document.staffForm.staffIdValue.value;
		var message = "";
		
		
		var okfunction = function(){
			document.staffForm.action = "saveStaffDetails.htm";
			document.staffForm.submit();
		};
		
		var cancelfunction = function(){
			
			
		};
		
		
		if (staffId == 0) {
			message = '<spring:message code="STAFF.STAFF_MEMBER_DETAILS.SAVE"/>';
		} else {
			message = '<spring:message code="STAFF.STAFF_MEMBER_DETAILS.UPDATE"/>';
		}
		
		
		confirm_function(message,okfunction, cancelfunction);
			
	}

	function showCategorySpecificFields(categoryVal) {

		var contains = false;

		<c:forEach var="item" items="${staffCategoryList}">

			if(${item.academic} == true) {
				if (categoryVal == '${item.catogaryID}') {

					contains = true;
				}
			}

		</c:forEach>


		if (contains) {

			$("#div_CoreSubject").css("display", "inline");
			$("#div_Medium").css("display", "inline");
			$("#div_Interest").css("display", "inline");
		
			

		} else {
			$("#div_CoreSubject").css("display", "none");
			$("#div_Medium").css("display", "none");
			$("#div_Interest").css("display", "none");
		}
	}
</script>
<script type="text/javascript">
function limitText(limitField, limitCount, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} else {
		limitCount.value = limitNum - limitField.value.length;
	}
}

function getStaffProfile(registrationNo,catogaryID) {
	var url = "staffProfileReport.htm?selectedAddmission="+registrationNo+"&selectedCategory="+catogaryID+"&flag="+true;
	PopupCenterReSize(url, 'staffProfileReport', 1000, 500);

}

function selectCountry(selectedResCountry,selectedMobCountry,selectedEmgResCountry,selectedEmgMobCountry) {
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
}

</script>
</head>

<body onload="<c:if test="${staff != null}">selectCountry('<c:out value="${selectedResCountry}" />','<c:out value="${selectedMobCountry}" />','<c:out value="${selectedEmgResCountry}" />','<c:out value="${selectedEmgMobCountry}" />');</c:if>">
	<script language="javascript">
		function resetAction(thisVal) {
			<c:if test="${staff.staffId eq 0}">
			document.staffForm.action = "newStaffDetails.htm";
			</c:if>
			<c:if test="${staff.staffId eq 1}">
			document.staffForm.action = "viewStaffMemberDetails.htm";
			</c:if>
			<c:if test="${staff.staffId gt 1}">
			document.staffForm.action = "viewStaffMemberDetails.htm";
			</c:if>
			document.staffForm.submit();
		}

		$(document).ready(function() {
			var url = window.location.toString();
			if (url.split("?")[1] === "new") {
				var firstElement = $("#menubar li").first();
				$("#menubar li a").removeAttr("href")
				$("#menubar li a").addClass("disabled")
				//  $("#menubar ul").append(firstElement);
			}
		});

		// Disabling tabs when add new student.
		<c:if test="${staffIdCheck ne false}">
		$(document).ready(function() {
			var firstElement = $("#menubar li").first();
			$("#menubar li a").removeAttr("href")
			$("#menubar li a").addClass("disabled")
		});
		</c:if>
		
	</script>

	<h:headerNew parentTabId="2" page="viewStaffMemberDetails.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<sec:authorize access="hasRole('Search Staff Members')">
						<li><a href="staffSearch.htm"><spring:message
									code="STAFF.STAFF_MEMBER_DETAILS.STAFF_SEARCH" />
						</a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="STAFF.STAFF_MEMBER_DETAILS" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/staffMemberDetailsHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle">
				<spring:message code="application.help" />
				</a>
			</div>
		</div>
		<c:if test="${staff.staffId gt 0}">
			<sec:authorize access="hasAnyRole('Print Staff Profile Report')">
				<div class="row">
					<div class="float_right">
						<a href="#" onclick="getStaffProfile('${staff.registrationNo}','${staff.staffCategory.catogaryID}');">
							<img src="resources/images/print_icon.gif" width="20" height="20"
							align="absmiddle">
						<spring:message code="STAFF.PROFILE.PRINT" /> </a>
					</div>
				</div>
			</sec:authorize>
		</c:if>

		<div class="clearfix"></div>
		<h1>
			<spring:message code="STAFF.STAFF_MEMBER_DETAILS" />
		</h1>
		<div id="content_main">
			<form:form method="POST" action="" commandName="staff"
				name="staffForm" id="staffForm" enctype="multipart/form-data">
				<form:hidden path="staffId" id="staffIdValue"/>

				<div class="clearfix"></div>
				<div class="section_box">
					<label class="success_sign"> <c:if
							test="${message != null}"> ${message}</c:if> </label> <label
						class="required_sign"> <c:if test="${modelError != null}"> ${modelError}</c:if>
					</label> <label class="required_sign"><spring:bind path="staff.*">
							<c:if test="${not empty status.errorMessages}">
							
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" />
									<br />
								</c:forEach>
							</c:if>
						</spring:bind> </label>
					<div class="section_box_header">
						<h2>
							<spring:message code="STAFF.STAFF_MEMBER_DETAILS.GENERAL_INFO" />
						</h2>
					</div>


					<%-- 		<form:errors path="staffId" cssClass="required_sign"/> --%>
					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="staff.leave.regNo" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="registrationNo" maxlength="20" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.FULL_NAME" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="fullName" maxlength="150"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.NAME_WITH_INITIALS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="nameWithIntials"  maxlength="45"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.LAST_NAME" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="lastName" maxlength="45"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.NIC_NO" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="nationalID" maxlength="20"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span>
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.GENDER" />
								</label>
							</div>
							<div class="frmvalue">
								<form:radiobutton path="gender" value="M" label=""
									cssClass="radio_btn" />
								<spring:message code="STAFF.STAFF_MEMBER_DETAILS.GENDER.MALE" />
								<form:radiobutton path="gender" value="F" label=""
									cssClass="radio_btn" />
								<spring:message code="STAFF.STAFF_MEMBER_DETAILS.GENDER.FEMALE" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH" />
								</label>
							</div>
							<div class="frmvalue">
								<spring:message
									code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT'
									var="dateOfBirthFormat" />
								<form:input path="dateOfBirth"
									id="${readonly=='true' ? '' : 'dateOfBirth'}"
									cssClass="date_field" title="${dateOfBirthFormat}" readonly="true"
									/>

							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.COUNTRY" />:</label>
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
										code="STAFF.STAFF_MEMBER_DETAILS.RACE" />
								</label>
							</div>
							<div class="frmvalue">
								<label> <form:select path="race" >
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${raceList}" itemValue="raceId"
											itemLabel="description" />
									</form:select> </label>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.RELIGION" />
								</label>
							</div>
							<div class="frmvalue">
								<label> <form:select path="religionId">
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${religionList}" itemValue="religionId"
											itemLabel="description" />
									</form:select> </label>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.CIVIL_STATUS" />
								</label>
							</div>
							<div class="frmvalue">
								<label> <form:select path="civilStatus">
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${civilStatusList}"
											itemValue="civilStatusId" itemLabel="description" />
									</form:select> </label>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.SECTION" />
								</label>
							</div>
							<div class="frmvalue">
								<label> <form:select path="section">
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${sectionList}" itemValue="sectionId"
											itemLabel="description" />
									</form:select> </label>
							</div>
						</div>

						<div class="row" style="display: none">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.ALUMIN_NO" />
								</label>
							</div>
							<div class="frmvalue">
								<input type="text">
							</div>
						</div>
						<div class="row" style="display: none;">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.EMP_NO" />
								</label>
							</div>
							<div class="frmvalue">
								<input type="text">
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.STAFF_CATEGORY" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="staffCategory.catogaryID" name="selectedCategory"
									onchange="showCategorySpecificFields(this.value);">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${staffCategoryList}"
										itemValue="catogaryID" itemLabel="description" />
								</form:select>
							</div>
						</div>

						<div id="div_CoreSubject" class="row" style="display: none;">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.CORE_SUBJECT" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="coreSubject.subjectId" >
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${coreSubjectList}" itemValue="subjectId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>


						<div id="div_Medium" class="row" style="display: none;">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.MEDIUM" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="studyMedium.studyMediumId">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${studyMediumList}"
										itemValue="studyMediumId" itemLabel="studyMediumName" />
								</form:select>
							</div>
						</div>
						
						
                        <div id="div_Interest" class="row" style="display: none;">
							<div class="frmlabel">
								<span class="required_sign"></span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.INTEREST" />
								</label>
							</div>
							<div class="frmvalue">
								<form:textarea path="interest" id="InterestArea" class="txtArea_staff" rows="3"
										onkeydown="limitText(this.form.InterestArea,this.form.countdown,250);"
										onkeyup="limitText(this.form.InterestArea,this.form.countdown,250);"
										/>
							</div>
						</div>
						
						
						
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.SALARY_SCALE" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="salaryScale" maxlength="15"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.BASIC_SALARY" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="basicSalary" maxlength="15"/>
							</div>
						</div>
						
						
                           <div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.INSURANCE_PLLICY_DETAILS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:textarea path="insurancePolicyDetails" id="InsurancePolicyDetails" class="txtArea_staff" rows="3"
										onkeydown="limitText(this.form.InsurancePolicyDetails,this.form.countdown,250);"
										onkeyup="limitText(this.form.InsurancePolicyDetails,this.form.countdown,250);"
										/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.DATE_FIRST_APPOINMENT" />
								</label>
							</div>
							<div class="frmvalue">
								<spring:message
									code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT'
									var="dateOfFirstAppointmentFormat" />
								<form:input path="firstAppointmetDate"
									id="${readonly=='true' ? '' : 'dateOfFirstAppointment'}"
									cssClass="date_field" title="${dateOfFirstAppointmentFormat}"  readonly="true"/>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span><label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.DATE_JOINED" />
								</label>
							</div>
							<div class="frmvalue">
								<spring:message
									code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT'
									var="dateOfHireFormat" />
								<form:input path="dateOfHire" 
									id="${readOnlyJoinDate=='true' ? '' : 'dateOfHire'}" 
									readonly="true"
									cssClass="date_field"
									title="${dateOfHireFormat}" />
							</div>
							
						</div>
						<c:if test="${readOnly}">
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STAFF.STAFF_MEMBER_DETAILS.DATE_OF_DEPARTURE"/></label>
							</div>
							<div class="frmvalue">
							<spring:message code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT' var="dateOfDepartureFormat"/>
								<form:input path="dateOfDeparture"
									id="${readonly=='true' ? '' : 'dateOfDeparture'}"
									cssClass="date_field" title="${dateOfDepartureFormat}"/>
							</div>
						</div>
						</c:if>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.APPOINTMENT_NATURE" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="appointmentNature">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${appointmentNatureList}"
										itemValue="natureId" itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.APPOINTMENT_CLASSIFICATION" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="appointmentClassification"
									>
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${appointmentClassificationList}"
										itemValue="classificationId" itemLabel="description" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.SERVICE" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="staffServiceCategory">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${staffServiceList}" itemValue="serviceId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.CLASS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="staffClass">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:option value="I">
										<spring:message code="STAFF.STAFF_MEMBER_DETAILS.CLASS.ONE" />
									</form:option>
									<form:option value="II">
										<spring:message code="STAFF.STAFF_MEMBER_DETAILS.CLASS.TWO" />
									</form:option>
									<form:option value="III">
										<spring:message code="STAFF.STAFF_MEMBER_DETAILS.CLASS.THREE" />
									</form:option>
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.GRADE" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="staffGrade">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:option value="I">
										<spring:message code="STAFF.STAFF_MEMBER_DETAILS.GRADE.ONE" />
									</form:option>
									<form:option value="II">
										<spring:message code="STAFF.STAFF_MEMBER_DETAILS.GRADE.TWO" />
									</form:option>
								</form:select>
							</div>
						</div>

						<div class="clearfix"></div>
					</div>
					<div class="column_equal">

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.PROFILE_IMG" />
								</label>
							</div>
							<c:choose>

								<c:when test="${ImagePath != null}">
									<div class="frmvalue" align="right">
										<img src="${ImagePath}" name="mFile" id="mFile" border="1"
											align="middle" height="${ImageHeight}" width="${ImageWidth}">
									</div>
								</c:when>
								<c:otherwise>
									<div class="frmvalue" align="right">
										<img src="${defaultImage}" name="mFile" id="mFile" border="1"
											align="middle" height="${ImageHeight}" width="${ImageWidth}">
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label style="line-height: 10px;"><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.CHANGE_IMG" />
								</label>
							</div>
							<div class="frmvalue">
								<div class="frmvalue">
										<input name="multipartFile" type="file" id="multipartFile"
											style="width: 290px;" value="">
								</div>
							</div>

							<div class="row">
								<strong><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.PERMANENT_ADDRESS" />
								</strong>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.ADDRESS" />
									</label>
								</div>
								<div class="frmvalue">
									<form:textarea path="address" id="AddressArea" class="txtArea_staff" rows="3"
										onkeydown="limitText(this.form.AddressArea,this.form.countdown,250);"
										onkeyup="limitText(this.form.AddressArea,this.form.countdown,250);"
										/>
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.CITY" />
									</label>
								</div>
								<div class="frmvalue">
									<form:select path="cityId" >
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${cityList}" itemValue="cityId"
											itemLabel="description" />
									</form:select>
								</div>
							</div>
							<div class="row">
								<strong><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.TEMPORARY_ADDRESS" />
								</strong>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.ADDRESS" />
									</label>
								</div>
								<div class="frmvalue">
									<form:textarea path="tempAddress" id="tempAddress" class="txtArea_staff" cols="30"
										rows="2"
										onkeydown="limitText(this.form.tempAddress,this.form.countdown,250);"
										onkeyup="limitText(this.form.tempAddress,this.form.countdown,250);"
										 />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.CITY" />
									</label>
								</div>
								<div class="frmvalue">
									<form:select path="tempCityId" >
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${cityList}" itemValue="cityId"
											itemLabel="description" />
									</form:select>
								</div>
							</div>
							<div class="row">
								<strong><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.CONTACT_DETAILS" />
								</strong>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.PHONE_RES" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
								<select style="width:130px" name="selectedCountryCodeRes" id="contactResidence">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">								
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>				
									</c:forEach>
								</select>
									<form:input path="residenceNo"
										maxlength="12" class="phoneNo_text" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.PHONE_MOB" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
								<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeMob" id="contactMobile">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">								
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>				
									</c:forEach>
								</select>
								<form:input path="mobileNo" id="mobile"
										maxlength="12" class="phoneNo_text" />
								</div>
							</div>

							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.EMAIL_PERSONAL" />
									</label>
								</div>
								<div class="frmvalue">
									<form:input path="email" maxlength="45"/>
								</div>
							</div>
							
							<div class="row">
								<strong><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.EMERGANCY" />
								</strong>
							</div>
							
							<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STAFF.STAFF_MEMBER_DETAILS.EMERGENCY.CONTACT.NAME" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input path="emergencyContactName" maxlength="100"/>
							</div>
						</div>
							
							
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.PHONE_RES" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
								<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeEmgRes" id="contactResidenceEmg">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">								
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>				
									</c:forEach>
								</select>
									<form:input path="emergencyContactResidenceNo"
										maxlength="12" class="phoneNo_text" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.PHONE_MOB" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
								<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeEmgMob" id="contactMobileEmg">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">								
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>				
									</c:forEach>
								</select>
									<form:input path="emergencyContactMobileNo"
										maxlength="12" class="phoneNo_text" />
								</div>
							</div>
							
							
							
							
							<div class="row">
								<strong>&nbsp;</strong>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.HISTORY" />
									</label>
								</div>
								<div class="frmvalue">
									<form:textarea path="history" id="historyArea" class="txtArea_staff" rows="2"
										onkeydown="limitText(this.form.historyArea,this.form.countdown,250);"
										onkeyup="limitText(this.form.historyArea,this.form.countdown,250);"
										 />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STAFF.STAFF_MEMBER_DETAILS.OTHER_INFO" />
									</label>
								</div>
								<div class="frmvalue">
									<form:textarea path="otherInfo" id="otherInfoArea" class="txtArea_staff" rows="2"
										onkeydown="limitText(this.form.otherInfoArea,this.form.countdown,250);"
										onkeyup="limitText(this.form.otherInfoArea,this.form.countdown,250);"
										/>
								</div>
							</div>

						</div>

						<div class="clearfix"></div>
						<div class="clearfix"></div>
					</div>
					<div class="button_row">
						<div class="buttion_bar_type2">
						<c:if test="${readOnly eq null}">
							<sec:authorize access="hasAnyRole('Save Staff Details')">
								<input type="button"
									value="<spring:message code='REF.UI.RESET'/>" class="button"
									onclick="resetAction(this);">
								<input type="button" onclick="saveStaffDetails();"
									value="<spring:message code='REF.UI.SAVE'/>" class="button">
										<input type="button" class="button"
											value="<spring:message code='REF.UI.CANCEL'/>"
											onClick="location.href='<c:url value="/staffSearch.htm"/>'">
							</sec:authorize>
							</c:if>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
