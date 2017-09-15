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
<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
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
		yearRange : "c-100:c+2",
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

			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/perDayStaffCategoryWiseAttendanceReportHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
           </div>
            <div class="clearfix"></div>
		    <h1><spring:message code="REPORT.STAFF.ATTENDANCE.REPORTS"/></h1>
			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.TITLE"/></h2>
				</div>

				<div class="section_full_inside">

					<div class="box_border">
						<form:form action="AbsentStaffCategoryWiseReport.htm" method="POST"
							commandName="perDayAttendanceTemplate" name="form">
							<div>

								<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>

								<label class="required_sign"> <form:errors
										path="dateConsidered" /><br> </label>
							</div>

							<table>

								<tr>

									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.CATEGORY"/></label>
									</td>
									<td><form:select id="catogaryID" name="catogaryID"
											path="catogaryID">
											<form:option value="0"> <spring:message code="REPORT.ATTENDANCE.STAFF.ALL"/></form:option>
											<c:if test="${staffCategoryList ne null}">
												<c:forEach var="staff" items="${staffCategoryList}">
													<form:option value="${staff.catogaryID}"
														label="${staff.description}" />
												</c:forEach>
											</c:if>
										</form:select>
									</td>
							   </tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.REPORT.TYPE"/></label>
									</td>
               						<td> <label><form:radiobutton path="reportType" value="1" label="" cssClass="radio_btn" checked = "true"/><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.ABSENT" /></label>
               						<label><form:radiobutton path="reportType" value="2" label="" cssClass="radio_btn"/><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.PRESENT"/></label></td>
								</tr>
					<tr>
									<td>&nbsp;&nbsp;
									<label>  <spring:message code="REPORT.ATTENDANCE.CUTOFF.TIME"/></label></td>
									<td><form:select name="select" style="width:130px;width:130px/*\**/:0\9;  /*hack */"
											path="cutOffTime">
											<form:option value="0"><spring:message code="application.drop.down"/></form:option>
											<form:option value="07:30"><spring:message code="REPORT.ATTENDANCE.SEVEN.THIRTY"/></form:option>
											<form:option value="07:45"><spring:message code="REPORT.ATTENDANCE.SEVEN.FOURTYFIVE"/></form:option>
											<form:option value="08:00"><spring:message code="REPORT.ATTENDANCE.EIGHT"/></form:option>
											<form:option value="08:30"><spring:message code="REPORT.ATTENDANCE.EIGHTTHIRTY"/></form:option>
											<form:option value="09:00"><spring:message code="REPORT.ATTENDANCE.NINE"/></form:option>
											<form:option value="09:30"><spring:message code="REPORT.ATTENDANCE.NINETHIRTY"/></form:option>
											<form:option value="10:00"><spring:message code="REPORT.ATTENDANCE.TEN"/></form:option>
											<form:option value="10:30"><spring:message code="REPORT.ATTENDANCE.TENTHIRTY"/></form:option>
											<form:option value="11:00"><spring:message code="REPORT.ATTENDANCE.ELEVEN"/></form:option>
											<form:option value="11:30"><spring:message code="REPORT.ATTENDANCE.ELEVENTHIRTY"/></form:option>
											<form:option value="12:00"><spring:message code="REPORT.ATTENDANCE.TWELEVE"/></form:option>
										    <form:option value="12:30"><spring:message code="REPORT.ATTENDANCE.TWELEVETHIRTY"/></form:option>
											<form:option value="13:00"><spring:message code="REPORT.ATTENDANCE.ONE"/></form:option>
											<form:option value="13:30"><spring:message code="REPORT.ATTENDANCE.ONEETHIRTY"/></form:option> 
																						</form:select></td>


								</tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.CONSIDERDATE"/></label></td>
									<td><form:input id="DateConsidered" cssClass="date_field" name="DateConsidered" readonly="true"
											path="dateConsidered" /></td>
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
