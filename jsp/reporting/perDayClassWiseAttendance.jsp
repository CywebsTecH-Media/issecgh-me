<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
	<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
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
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<script>

var date = new Date();
var currentMonth = date.getMonth();
var currentDate = date.getDate();
var currentYear = date.getFullYear();
$(function() {
	$("#DateConsidered").datepicker({
		changeYear : true,
		changeMonth : true,
		yearRange : "-15:+0",
		dateFormat : 'yy-mm-dd',
		showOn : "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly : true,
		maxDate : new Date(currentYear, currentMonth,
				currentDate)
	});
});


</script>

</head>
<body>
	<div id="page_container">

		<div class="clearfix"></div>
		<div id="content_main">
		<div id="breadcrumb_area">
			
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/perDayClassWiseAttendanceReportHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
           </div>
            <div class="clearfix"></div>
		    <h1><spring:message code="REPORT.STUDENT.ATTENDANCE.REPORTS"/></h1>
			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.TITLE"/></h2>
				</div>

				<div class="section_full_inside">
				

					<div class="box_border">
						<form:form action="AbsentClassWiseReport.htm" method="POST"
							commandName="perDayAttendanceTemplate" name="form">
							<div>

								<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>

								<label class="required_sign"> <form:errors
										path="gradeDescription" /><br> </label>
							</div>

							<table>

								<tr>

									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.CLASS"/></label>
									</td>
									<td><form:select id="selecteClasses" name="selectClasses"
											path="classDescription" onchange="document.getElementById('DateConsidered').value ='';">
											<form:option value="0"> <spring:message code="application.drop.down"/> </form:option>
											<c:if test="${gradeClassList ne null}">
												<c:forEach var="classes" items="${gradeClassList}">
													<form:option value="${classes.classGradeId}"
														label="${classes.description}" />
												</c:forEach>
											</c:if>
										</form:select></td>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.REPORT.TYPE"/></label>
									</td>
               						<td> <label><form:radiobutton path="reportType" value="1" label="" cssClass="radio_btn" checked = "true"/><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.REPORT.ALL"/></label></td>
               						
								</tr>
								<tr>
									<td></td>
               						<td><label><form:radiobutton path="reportType" value="2" label="" cssClass="radio_btn"/><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.REPORT.PRESENT"/></label></td>
               						
								</tr>
								<tr>
									<td></td>
               						<td><label><form:radiobutton path="reportType" value="3" label="" cssClass="radio_btn"/><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.REPORT.ABSENT"/></label></td>
								</tr>


								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STUDENT.PERDAY.CLASS.WISE.REPORT.CONSIDERDATE"/></label></td>
									<td><form:input id="DateConsidered" class="date_field" name="DateConsidered"
											path="dateConsidered" readonly="true" /></td>
								</tr>

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
