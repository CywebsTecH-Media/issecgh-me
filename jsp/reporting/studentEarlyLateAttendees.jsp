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
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>


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
							dateFormat : 'yy-mm-dd',
							showOn : "button",
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
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
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
	$(function() {
		var dates = $("#EarlyAttendanceFromDate, #EarlyAttendanceToDate")
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
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
							onSelect : function(selectedDate) {
								var option = this.id == "EarlyAttendanceFromDate" ? "minDate"
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
	<div id="page_container">
	<div id="breadcrumb_area">
			
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/generateStudentEarlyLateAttendiesReportHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REPORT.STUDENT.ATTENDANCE.REPORTS"/></h1>
		<div id="content_main">
			<div class="clearfix"></div>
			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.ATTENDANCE.STUDENT.LATE"/></h2>
				</div>
				<form:form action="studentLateReport.htm" method="POST"
							commandName="attendeesWrapperTemplate">

							<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>
					<div>
						<label class="required_sign"> <form:errors path="*" /><br>
						</label>
					</div>
				</form:form>
				<div class="section_full_inside">
					
					<div class="box_border">
						<form:form action="studentLateReport.htm" method="POST"
							commandName="attendeesWrapperTemplate">

							<input type="hidden" name="formIndex" />
							<table>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.DATE.FROM"/></label>
									</td>
									<td><form:input id="LateAttendanceFromDate"
											class="date_field"
											path="teacherLateAttendiesTemplate.dateFrom" />
									</td>

								</tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.DATE.TO"/></label>
									</td>
									<td><form:input id="LateAttendanceToDate"
											class="date_field" path="teacherLateAttendiesTemplate.dateTo" />
									</td>

								</tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.TIME.IN.FROM"/></label>
									</td>
									<td><form:select name="select"
											path="teacherLateAttendiesTemplate.timeInFrom">
											<form:option value="0"><spring:message code="application.drop.down"/></form:option>
											<form:option value="07:30"><spring:message code="REPORT.ATTENDANCE.SEVEN.THIRTY"/></form:option>
											<form:option value="07:45"><spring:message code="REPORT.ATTENDANCE.SEVEN.FOURTYFIVE"/></form:option>
											<form:option value="08:00"><spring:message code="REPORT.ATTENDANCE.EIGHT"/></form:option>
											<form:option value="08:30"><spring:message code="REPORT.ATTENDANCE.EIGHTTHIRTY"/></form:option>
											<form:option value="09:00"><spring:message code="REPORT.ATTENDANCE.NINE"/></form:option>
											<form:option value="09:30"><spring:message code="REPORT.ATTENDANCE.NINETHIRTY"/></form:option>
										</form:select>
									</td>

									</tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.TIME.IN.TO"/></label>
									</td>
									<td><form:select name="select"
											path="teacherLateAttendiesTemplate.timeInTo">
											<form:option value="0"><spring:message code="application.drop.down"/></form:option>
											<form:option value="07:45"><spring:message code="REPORT.ATTENDANCE.SEVEN.FOURTYFIVE"/></form:option>
											<form:option value="08:00"><spring:message code="REPORT.ATTENDANCE.EIGHT"/></form:option>
											<form:option value="08:30"><spring:message code="REPORT.ATTENDANCE.EIGHTTHIRTY"/></form:option>
											<form:option value="09:00"><spring:message code="REPORT.ATTENDANCE.NINE"/></form:option>
											<form:option value="09:30"><spring:message code="REPORT.ATTENDANCE.NINETHIRTY"/></form:option>
											<form:option value="10:00"><spring:message code="REPORT.ATTENDANCE.TEN"/></form:option>
										</form:select>
									</td>
									</tr>
								<tr>
									<td colspan="2"><input type="submit"
										name="late_Attendees_Submit" class="button" onClick=""
										value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>"></td>
								</tr>
							</table>
						</form:form>
						<div class="clearfix"></div>

					</div>
				</div>

				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>
