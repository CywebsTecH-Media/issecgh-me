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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
<script language="javascript" src="resources/js/common.js"></script>

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

<script>
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
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
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

	$(function() {
		$("#DateConsidered").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c-100:c+2",
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true
		});
	});

	$(function() {
		var dates = $("#LateAttendanceFromDate, #LateAttendanceToDate")
				.datepicker(
						{
							//defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							dateFormat : 'yy-mm-dd',
							showOn : "button",
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
							onSelect : function(selectedDate) {
								var option = this.id == "LateAttendanceFromDate" ? "minDate"
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
</script>
<!-- END Calender controll CSS and JS -->

</head>
<body>
	<h:headerNew parentTabId="11"
		page="GenerateStudentWiseSwipInOutReport.htm" />

	<div id="page_container">

		<div id="breadcrumb_area">
			
			<div id="progress_bar_wraper">
				<label><spring:message code="STUDENT.PROGRESS.CO_CURRICULAR"/></label>
				<div class="progress_bar">
					<div class="colour_bar" style="width: 95px"></div>
					<div class="prog_value">95%</div>
				</div>
			</div>
			<div id="progress_bar_wraper">
				<label><spring:message code="STUDENT.ACADEMIC.TITLE"/></label>
				<div class="progress_bar">
				<c:if test="${not empty averageAcademicLife}">
					<div class="colour_bar" style="width:<c:out value="${averageAcademicLife}"/>px"></div>
					<div class="prog_value">
					<c:out value="${averageAcademicLife}" />%
					</div>
				</c:if>
				</div>
			</div>
			<div id="progress_bar_wraper">
				<label>Faith Life</label>
				<div class="progress_bar">
				<c:if test="${!(averageFaithLife == null)}">
					<div class="colour_bar" style="width: <c:out value="${averageFaithLife}" />px"></div>
					<div class="prog_value">
							<c:out value="${averageFaithLife}" />%
					</div>
				</c:if>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REPORT.STUDENT.ATTENDANCE.SWIPE.IN.OUT.TITLE"/></h1>
		<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="REPORT.STUDENT.ATTENDANCE.SWIPE.IN.OUT.NAME"/>&nbsp;</label> ${student.fullName}
					</div>
					<div class="float_left">
						<label><spring:message code="REPORT.ATTENDANCE.STUDENT.ADMISSIONNO"/>&nbsp;</label> ${student.admissionNo}
					</div>
					<div class="float_left">
						<label><spring:message code="REPORT.STUDENT.GRADE"/>&nbsp;</label> ${studentGrade}
					</div>
					<div class="clearfix"></div>
				</div>
			</div>

			<form:form action="studentSwipeInOutReport.htm" method="POST"
				commandName="studentWiseSwipInOutTemplate">

				<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>

                <label class="required_sign"> <form:errors
								path="*" /><br> </label>
				<table>

					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>

					<tr>
						<td><span class="required_sign">*</span> <label>
								<spring:message code="REPORT.ATTENDANCE.DATE.FROM"/></label>
						</td>
						<td><form:input id="AttendanceFromDate" class="date_field"
								path="dateFrom" />
						</td>
					</tr>

					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>

					<tr>
						<td><span class="required_sign">*</span> <label>
								<spring:message code="REPORT.ATTENDANCE.DATE.TO"/></label>
						</td>
						<td><form:input id="AttendanceToDate" class="date_field"
								path="dateTo" />
						</td>
					</tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>

					<tr>
						<td colspan="2"><input type="submit" class="button"
							onClick="" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
						</td>
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