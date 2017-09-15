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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<script language="javascript">

	function cancelSearch(thisValue) {

		document.form.action = "onChangeDateList.htm";
		if (thisValue.value != "") {
			document.form.submit();
		}
	}
	
	function reloadPage(thisValue) {

		document.form.action = "TeacherDailyAttendanceReload.htm";
		if (thisValue.value != "") {
			document.form.submit();
		}
	}
	
	$(document).ready(function() {
		
		$("#tblFreezed tr").each(function(index) {								
			$("#tblScrool tr").eq(index).height($("#tblFreezed tr").eq(index).innerHeight());
		});
		
		// When load attendance details, toggle button to Uncheck All,
		// if all checkboxes are already checked 
		if ($('input[name="staffIdList"]:checked').length == $('input[name="staffIdList"]').length) {
			$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
		}
		
		// Toggle Check All / Uncheck All behaviour
		$('#toggle_check_all').click(function() {
			if ($('#toggle_check_all').attr('value') == '<spring:message code="REF.UI.CHECK.ALL" />') {
				$('input[name="staffIdList"]').attr('checked', 'checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('input[name="staffIdList"]').removeAttr('checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
		// Each click on check box, check all check boxes are checked or not
		// for change the Check All button behaviour if needed 
		$('input[name="staffIdList"]').click(function() {
			if ($('input[name="staffIdList"]:checked').length == $('input[name="staffIdList"]').length) {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
	});
	
</script>

</head>
<body>
	<h:headerNew parentTabId="33" page="TeacherDailyAttendance.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<sec:authorize access="hasRole('View Staff Attendance Page')">
					<ul>
						<li><a href="adminWelcome.htm"><spring:message
									code="application.home" /></a>&nbsp;&gt;&nbsp;</li>
						<li><spring:message code="ATTENDANCE.TEACHERATTENDANCE.TITLE" /></li>
					</ul>
				</sec:authorize>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/attendance/teacherAttendanceHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="ATTENDANCE.TEACHERATTENDANCE.TITLE" />
		</h1>
		<div>
			<c:if test="${message != null}">
				<label class="missing_required_error">${message}</label>
			</c:if>
		</div>
		<div id="content_main">
			<form action="" method="post" name="form">
				<c:set var="gradeclassdescription" value="" />
				<c:set var="dateDescription" value="" />

				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border">
						<p>
							<spring:message code="ATTENDANCE.TEACHERATTENDANCE.DESCRIPTION" />
						</p>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<div>
										<span class="required_sign">*</span><label><spring:message
												code="ATTENDANCE.TEACHERATTENDANCE.STAFFTYPE" /></label>
									</div>
								</div>
								<select name="select" id="select"
									<c:if test="${(not empty staffList)}"> onchange="reloadPage(this)"</c:if>>
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${staffTypeList}" var="staffTypeList"
										varStatus="status">
										<option label="${staffTypeList.value}"
											value="${staffTypeList.key}"
											<c:if test="${staffTypeList.key == staffType}">selected="selected" <c:set var="staffTypeDecription"
												value="${staffTypeList.key}" /></c:if>>${staffTypeList.value}</option>
									</c:forEach>


								</select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="ATTENDANCE.DATE" /></label>
								</div>

								<select name="date" id="selectedDate"
									<c:if test="${(not empty staffList)}"> onchange="cancelSearch(this)"</c:if>>
									<c:forEach items="${dateList}" var="date" varStatus="status">
										<option label="${date}" value="${date}"
											<c:if test="${currentDate == date}">selected="selected" <c:set var="dateDescription"
												value="${date}" /></c:if>>${date}</option>
									</c:forEach>
								</select>

							</div>
							<div class="float_right">
								<sec:authorize access="hasRole('View Staff Attendance')">
									<div class="buttion_bar_type1">
										<input type="button"
											value="<spring:message code="REF.UI.SEARCH"/>"
											onClick="document.form.action='searchTeacherDailyAttendance.htm'; document.form.submit();document.getElementById('search_results').style.display=''; document.getElementById('btn_row').style.display=''"
											class="button">
									</div>
								</sec:authorize>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<c:if test="${(not empty staffList)}">
					<div class="section_box" id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="ATTENDANCE.TEACHERATTENDANCE.TITLE" />
							</h2>
						</div>

						<div id="leave_info_block">
							<table id="leave_info_table">
								<tr>
									<td class="approvedLeaveColor"></td>
									<td class="colorDescription">&nbsp;<spring:message
											code="ATTENDANCE.TEACHERATTENDANCE.APPROVED_LEAVE_COLOR_DESCRIPTION" /></td>
								</tr>
								<tr>
									<td class="inProgressLeaveColor"></td>
									<td class="colorDescription">&nbsp;<spring:message
											code="ATTENDANCE.TEACHERATTENDANCE.IN_PROGRESS_LEAVE_COLOR_DESCRIPTION" /></td>
								</tr>
							</table>
						</div>

						<div class="column_single">
							<table id="tblFreezed" class="basic_grid basic_grid_freezed"
								style="width: 450px;" border="0" cellspacing="0">
								<tr>
									<th style="height: 34px; * height: 32px;"><spring:message
											code="ATTENDANCE.TEACHERATTENDANCE.STAFF.REGISTRATION" /></th>
									<th style="height: 34px; * height: 32px;"><spring:message
											code="ATTENDANCE.TEACHERATTENDANCE.NAME" /></th>
									<th style="height: 34px; * height: 32px; text-align: center;">${dateDescription}</th>
									<th style="height: 34px; * height: 32px;width:100px; text-align: center;">Time In</th>
									<th style="height: 34px; * height: 32px;width:100px; text-align: center;">Time Out</th>
								</tr>
								<c:forEach var="staff" items="${staffList}" varStatus="status">

									<c:choose>
										<c:when test="${status.count % 2 == 1}">
											<c:set var="cssClass" value="odd" />
										</c:when>
										<c:when test="${status.count % 2 == 0}">
											<c:set var="cssClass" value="even" />
										</c:when>
									</c:choose>

									<c:forEach var="leaveInfo" items="${allowableLeaveList}">
										<c:if test="${leaveInfo.staffId == staff.staffId}">
											<c:choose>
												<c:when test="${leaveInfo.staffLeaveStatusId == 1}">
													<c:set var="cssClass"
														value="${cssClass} approvedLeaveColor" />
												</c:when>
												<c:otherwise>
													<c:set var="cssClass"
														value="${cssClass} inProgressLeaveColor" />
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>

									<tr class="${cssClass}">
										<td class="left">${staff.registrationNo}</td>
										<td class="left">${staff.nameWithIntials}</td>
										<c:set var="checkval" value="false" />										
										<c:if test="${not empty attendanceList}">
											<c:forEach var="attendanceList" items="${attendanceList}">
												<c:if test="${attendanceList.staffId eq staff.staffId}">
													<c:set var="checkval" value="true" />													
													<fmt:parseDate value="${attendanceList.timeIn}" var="parsedateTimeIn" pattern="HH:mm:ss" />
													<fmt:parseDate value="${attendanceList.timeOut}" var="parsedateTimeOut" pattern="HH:mm:ss" />													
												</c:if>
											</c:forEach>
										</c:if>
										<td style="text-align: center;"><input name="staffIdList"
											type="checkbox" value="${staff.staffId}"
											<c:if test="${checkval eq true}">checked="checked"</c:if>></td>
											<c:if test="${not empty parsedateTimeIn}">
												<td style="text-align: center;"><fmt:formatDate value="${parsedateTimeIn}" type="time" pattern="hh:mm a"/></td>
												<td style="text-align: center;"><fmt:formatDate value="${parsedateTimeOut}" type="time" pattern="hh:mm a"/></td>
											</c:if>
											<c:if test="${empty parsedateTimeIn}">
												<td style="text-align: center;"><spring:message code="ATTENDANCE.TEACHERATTENDANCE.NOTAVAILABLE" /></td>
												<td style="text-align: center;"><spring:message code="ATTENDANCE.TEACHERATTENDANCE.NOTAVAILABLE" /></td>
											</c:if>
											<c:remove var="parsedateTimeIn"/>
											<c:remove var="parsedateTimeOut"/>
									</tr>
								</c:forEach>
								<tfoot style="background: #C0C0C0;">
									<tr>
										<td class="left" style="font-weight: bold;"><spring:message
												code="ATTENDANCE.TOTAL" /></td>
										<td></td>
										<td style="text-align: center; font-weight: bold;">${total}</td>
										<td></td>
										<td></td>
									</tr>
								</tfoot>

							</table>

						</div>
						<div class="clearfix"></div>
					</div>
					<div id="btn_row" class="button_row">
						<sec:authorize access="hasRole('Save Staff Attendance')">
							<div class="buttion_bar_type2">

								<input type="button"
									value="<spring:message code="REF.UI.SAVE"/>" class="button"
									onclick="document.form.action='saveorupdateTeacherAttendance.htm'; document.form.submit();">
								<input type="button" id="toggle_check_all" class="button"
									value="<spring:message code="REF.UI.CHECK.ALL" />" />
								<input type="button"
									value="<spring:message code="REF.UI.CANCEL"/>" class="button"
									onclick="document.location.href='TeacherDailyAttendance.htm'">
							</div>
						</sec:authorize>
						<div class="clearfix"></div>
					</div>
				</c:if>
			</form>
		</div>
	</div>
	<h:footer />
</body>
</html>