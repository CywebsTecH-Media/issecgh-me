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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>


<script>

function selectClass(thisValue) {
	document.form.selectedClass.value = thisValue;
}

function loadAdmissionNo(selectedValue,selectedAddmissionNo) {

	var url = '<c:url value="/populateAddmissionNosByClass2.htm" />';

	$.ajax({
		url : url,
		data : ({
			'classGradeId' : selectedValue
		}),
		success : function(response) {

			var responseArray = response.split(",");

			document.getElementById('selectAddmission').innerHTML = '';

			var dropDownDiv = document.getElementById('selectAddmission');
			var selector = document.createElement('select');
			selector.id = "selectedAddmission";
			selector.name = "selectedAddmission";
			dropDownDiv.appendChild(selector);

			var option = document.createElement('option');
			option.value = '0';
			option.appendChild(document.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
			selector.appendChild(option);

			if (responseArray.length > 0) {

				for ( var i = 0; i < responseArray.length; i++) {

					if (responseArray[i] != "") {
						option = document.createElement('option');
						option.value = responseArray[i];
						option.appendChild(document.createTextNode(responseArray[i]+""));
						selector.appendChild(option);
						
						if(selectedAddmissionNo!=null) {
							if(option.value==selectedAddmissionNo) {
								option.selected = 'selected';
							}							
						}
					}
				}
			}
		},
		error : function(transport) {
			alert("error");

		}
	});
}
</script>
<script>
var date = new Date();
var currentMonth = date.getMonth();
var currentDate = date.getDate();
var currentYear = date.getFullYear();

	$(function() {
		var dates = $("#AttendanceFromDate, #AttendanceToDate")
				.datepicker(
						{
							//defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							showOn : "button",
							dateFormat : 'yy-mm-dd',
							yearRange:"c-0:c+0",
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
							onSelect : function(selectedDate) {
								var option = this.id == "AttendanceFromDate" ? "minDate"
										: "maxDate", instance = $(this).data(
										"datepicker"), date = $.datepicker
										.parseDate(
												instance.settings.dateFormat
														|| $.datepicker._defaults.dateFormat,
												selectedDate, instance.settings);
								dates.not(this).datepicker("option", option,
										date);
							}
						});
	});

	function callOnLoadFun(thisValue,selectedAdmissionNo){
		
		selectClass(thisValue);
		loadAdmissionNo(thisValue,selectedAdmissionNo);
		
	}

</script>
<!-- END Calender controll CSS and JS -->

</head>
<body onload="<c:if test="${selectedClassGradeId != null}">callOnLoadFun('<c:out value="${selectedClassGradeId}" />','<c:out value="${selectedAddmissionNo}" />');</c:if>">
	<div id="page_container">
	<div id="breadcrumb_area">
			
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/generateStudentWiseAttendanceReportHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REPORT.STUDENT.ATTENDANCE.REPORTS"/></h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.STUDENT.WISE"/></h2>
				</div>
				<form:form action="" method="POST"
							commandName="studentWiseAttendanceTemplate">

							<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>
					<div>
						<label class="required_sign"> <form:errors path="*" /><br>
						</label>
					</div>
				</form:form>
				<div class="section_full_inside">
				

					<div class="box_border">
						<form:form action="studentAttendanceReport.htm" method="POST"
							commandName="studentWiseAttendanceTemplate" name="form">

							<table>
							    <tr>
								<td>
									<span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.REPORT.CARD.SELECT.CLASS"/></label>
								</td>
								<td>
									<select name="selectedClass" id="selectedClass" onchange="selectClass(this.value);loadAdmissionNo(this.value);">
						                <option value="0"> <spring:message code="OPT.PLEASE.SELECT"/> </option>
							                <c:forEach items="${classGradeList}" var="classGrade">
							                  	<option value="${classGrade.classGradeId}" <c:if test='${selectedClassGradeId != null &&
								                  	classGrade.classGradeId eq selectedClassGradeId}'> selected="selected" </c:if>>${classGrade.description}</option>
							                </c:forEach>
						            </select>
								</td>
                                </tr>

								<tr>
								<td>
									<span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STUDENT.ADMISSIONNO"/></label>
								</td>
								<td>
									<div id="selectAddmission"></div>
								</td>

							    </tr>

								<tr></tr>
								<tr></tr>
								<tr></tr>
								<tr></tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.DATE.FROM"/></label></td>
									<td><form:input id="AttendanceFromDate" class="date_field"
											path="dateFrom" />
									</td>

								</tr>

								<tr></tr>
								<tr></tr>
								<tr></tr>
								<tr></tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.DATE.TO"/></label></td>
									<td><form:input id="AttendanceToDate" class="date_field"
											path="dateTo" /></td>

								</tr>
								<tr></tr>
								<tr></tr>
								<tr></tr>
								<tr></tr>

								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>"></td>
								</tr>



							</table>
						</form:form>
					</div>

				</div>

				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>
