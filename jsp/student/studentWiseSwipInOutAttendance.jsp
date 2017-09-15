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
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
		var status = ${student.statusId};
		var depatureDate = '${student.dateOfDeparture}';
		
		if(depatureDate == ''){
			depatureDate = new Date();
		}
		
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
							beforeShow : function(){
								
								dates.datepicker("option", "maxDate", status == 1 ? new Date() : depatureDate);
 							},
							onSelect : function(selectedDate) {
								var minDate = "minDate";
								var maxDate = "maxDate";
								var option = this.id == "AttendanceFromDate" ? minDate
										: maxDate, instance = $(this).data(
										"datepicker"), date = option == 'minDate' ? $.datepicker
										.parseDate(
												instance.settings.dateFormat
														|| $.datepicker._defaults.dateFormat,
												selectedDate, instance.settings) : new Date(); 
								dates.not(this).datepicker("option", option,
										date);
							}
						});
	});

	
	function submitForm() {
		// to view attendence in this page(jsp)
		document.form.action = "populateAttendence.htm";
		document.form.submit();
	}
	
</script>
<!-- END Calender controll CSS and JS -->

</head>
<body>
<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="studentAttendanceForm.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="studentAttendanceForm.htm" />
		</c:otherwise>
	</c:choose>

	<div id="page_container">

		<div id="breadcrumb_area">
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
					<li><spring:message code="STUDENT.SWIP.IN.OUT.ATTENDANCE.LINK" />
					</li>
				</ul>
			</div>

			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentWiseAttendanceReportHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle">
				<spring:message code="application.help" /> </a>
			</div>

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
		<div class="clearfix"></div>
		<h1>
			<spring:message code="STUDENT.SWIP.IN.OUT.ATTENDANCE.TITLE" />
		</h1>
	<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.NAME" />&nbsp;</label>
						${student.nameWtInitials}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.ADDMISSION" />&nbsp;</label>
						${student.admissionNo}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.CLASS" />&nbsp;</label>
						${studentClassDescription}
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
	<c:choose>
<c:when test="${not empty hasStudentClass}">
			<c:if test="${showErrorDefault != null}">
				<h3><spring:message code="STUDENT.SWIP.IN.OUT.UI.ASSIGN_CLASS"/></h3>
			</c:if>
			<form:form action="populateAttendence.htm" method="POST"
				commandName="studentWiseSwipInOutTemplate" name="form">

				<label class="required_sign"> <c:if
						test="${message != null}">${message}</c:if> </label>

				<label class="required_sign"> <form:errors path="*" /><br>
				</label>
				<table>

					<tr>
						<td><span class="required_sign">*</span> <label> <spring:message
									code="STUDENT.SWIP.IN.OUT.ATTENDANCE.DATE.FROM" />
						</label></td>
						<td><form:input id="AttendanceFromDate" class="date_field"
								path="dateFrom" readonly="true" /></td>
					</tr>

					<tr>
						<td><span class="required_sign">*</span> <label> <spring:message
									code="STUDENT.SWIP.IN.OUT.ATTENDANCE.DATE.TO" />
						</label></td>
						<td><form:input id="AttendanceToDate" class="date_field"
								path="dateTo" readonly="true" /></td>
					</tr>

					<tr>
						<td colspan="2">
						<sec:authorize access="hasAnyRole('Search Attendeance','Parent Search Attendeance')">
							<input type="submit" class="button"
								onClick="submitForm();" value="<spring:message code='REF.UI.SEARCH'/>" />
						</sec:authorize>
						</td>
					</tr>
				</table>



				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.SWIP.IN.OUT.ATTENDANCE.LINK"/></h2>
					</div>
					<div>
						<label class="required_sign" id="massageSeminar"></label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.SWIP.IN.OUT.UI.DATE"/></th>
								<th><spring:message code="STUDENT.SWIP.IN.OUT.UI.DAY"/></th>
								<th><spring:message code="STUDENT.SWIP.IN.OUT.UI.STATUS"/></th>
								<th class="center"><spring:message code="STUDENT.SWIP.IN.OUT.UI.TIME_IN"/></th>
								<th class="center"><spring:message code="STUDENT.SWIP.IN.OUT.UI.TIME_OUT"/></th>
								<th ><spring:message code="STUDENT.SWIP.IN.OUT.UI.DETAILS"/></th>
							</tr>
							<c:choose>
								<c:when test="${not empty attendeceMap}">
									<c:forEach items="${attendeceMap}" var="attendeceEntry"
										varStatus="status">
										<tr
											<c:choose>
												<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
												<c:when test="${status.count % 2 == 0}">class="even"</c:when>
											</c:choose>>
											<td>${attendeceEntry.key} </td>
											<td>${attendeceEntry.value.day}</td>
											<td >${attendeceEntry.value.status}</td>
											<td class="center" >${attendeceEntry.value.timeIn}</td>
											<td class="center" >${attendeceEntry.value.timeOut}</td>
											<c:choose>
												<c:when test="${attendeceEntry.value.absent}"> 
													<c:choose>
														<c:when test="${not empty attendeceEntry.value.description}"> 
															<td>${attendeceEntry.value.description}</td>
														</c:when>
														<c:otherwise>
															<td class="right" >
															<sec:authorize access="hasRole('Link Add Leave')">
															<a href="studentLeave.htm?date=${attendeceEntry.key}&attendancePage=${attendeceEntry.key}" <c:if test="${student.statusId != 1 || enableAddReason == null}">style="display:none;"</c:if>> 
																<spring:message code="STUDENT.SWIP.IN.OUT.UI.REASON"/>
																<img src="resources/images/detail_view.jpeg" class="icon">
															</a></sec:authorize></td>
														</c:otherwise>
													</c:choose>				
												</c:when>
												<c:otherwise>
													<td class="right"></td>
												</c:otherwise>
											</c:choose>
											
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND" />
										</td>
										<td nowrap="nowrap" class="right"></td>
										<td nowrap="nowrap" class="right"></td>
										<td nowrap="nowrap" class="right"></td>
										<td nowrap="nowrap" class="right"></td>
										<td nowrap="nowrap" class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="clearfix"></div>
				</div>

			</form:form>
		</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.SWIP.IN.OUT.UI.ASSIGN_CLASS" /></h3>
		</c:otherwise>			
	</c:choose>
		</div>

	</div>

	<div class="clearfix"></div>

	<h:footer />
</body>
</html>