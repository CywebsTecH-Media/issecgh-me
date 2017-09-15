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
	
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<script language="javascript">
	
	
	function populate(thisValue) {

		document.form.action = "populateParticipantList.htm";
		if (thisValue.value != "") {
			document.form.submit();
		}
	}
	function cancelSearch(thisValue) {

		document.form.action = "changeParticipationList.htm";
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
		if ($('input[name="studentIdList"]:checked').length == $('input[name="studentIdList"]').length) {
			$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
		}
		
		// Toggle Check All / Uncheck All behaviour
		$('#toggle_check_all').click(function() {
			if ($('#toggle_check_all').attr('value') == '<spring:message code="REF.UI.CHECK.ALL" />') {
				$('input[name="studentIdList"]').attr('checked', 'checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('input[name="studentIdList"]').removeAttr('checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
		// Each click on check box, check all check boxes are checked or not
		// for change the Check All button behaviour if needed 
		$('input[name="studentIdList"]').click(function() {
			if ($('input[name="studentIdList"]:checked').length == $('input[name="studentIdList"]').length) {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
	});
	

</script>

</head>
<body>
	<h:headerNew parentTabId="33" page="SpecialEventsAttendance.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
		<sec:authorize access="hasRole('View Special Events Attendance Page')">
			<div id="breadcrumb">
			
				
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="ATTENDANCE.SPECIALEVENT.ATTENDANCE.TITLE"/></li>
				</ul>
				
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/attendance/specialEventsAttendanceHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help"/></a>
			</div>
			</sec:authorize>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="ATTENDANCE.SPECIALEVENT.ATTENDANCE.TITLE"/></h1>
		<div>
			<c:if test="${message != null}">
				<label class="missing_required_error">${message}</label>
			</c:if>
		</div>
		<div id="content_main">
			<form action="" method="post" name="form"><c:set
	var="gradeclassdescription" value="" />
	<c:set
	var="eventsDescription" value="" />
	<c:set
	var="dateDescription" value="" />
	
				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border">
						<p><spring:message code="ATTENDANCE.SPECIALEVENT.ATTENDANCE.DESCRIPTION"/></p>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<div><span class="required_sign">*</span><label><spring:message code="ATTENDANCE.SPECIALEVENT.ATTENDANCE.SPECIALEVENT"/></label></div>
								</div>
								<select  name="selectedSpecialEvent" onchange="populate(this)" id="selectedSpecialEvent">
									<option value ="0"><spring:message code="application.drop.down"/></option>
									<c:forEach var="specialEventsList" items="${specialEventsList}">
										<c:set var="testval" value="" />
										<c:if test="${specialEventsList.specialEventsId eq specialEventsId}">
											<c:set var="testval" value="SELECTED" />
											<c:set var="gradeclassdescription"
												value="${specialEventsList.name}" />
											<c:set
												var="eventsDescription" value="${specialEventsList.date}" />
										</c:if>
										<option label="${specialEventsList.name}"
											value="${specialEventsList.specialEventsId}"
											<c:out value="${testval}"></c:out>>
											${specialEventsList.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
								
									<div><span class="required_sign">*</span><label><spring:message code="ATTENDANCE.SPECIALEVENT.ATTENDANCE.PARTICIPANT"/></label></div>
							</div>

								<select name="selectedParticipant" id="selectedParticipant"
<c:if test="${(not empty studentList)}"> onchange="cancelSearch(this)"</c:if>>
									<option value ="0"><spring:message code="application.drop.down"/></option>

									<c:forEach var="participationList" items="${participationList}">
										<c:choose>
											
											<c:when
												test="${participationList.specialEvents.participantCategory.participantCategoryId eq 1}">

												<option label="${participationList.classGrade.description}"
													value="${participationList.specialEventsParticipationId}"
													<c:if test="${participationList.specialEventsParticipationId == participationId}">selected="selected" <c:set var="staffTypeDecription"
												value="${participationList.specialEventsParticipationId}" /></c:if>>${participationList.classGrade.description}</option>

											</c:when>
											<c:when
												test="${participationList.specialEvents.participantCategory.participantCategoryId eq 2}">
												<option
													label="${participationList.sportCategory.sportSubCategory.description}-${participationList.sportCategory.sport.description}"
													value="${participationList.specialEventsParticipationId}"
													<c:if test="${participationList.specialEventsParticipationId == participationId}">selected="selected" <c:set var="staffTypeDecription"
												value="${participationList.specialEventsParticipationId}" /></c:if>>${participationList.sportCategory.sportSubCategory.description}-${participationList.sportCategory.sport.description}</option>
											</c:when>
											<c:when
												test="${participationList.specialEvents.participantCategory.participantCategoryId eq 3}">

												<option label="${participationList.clubSociety.name}"
													value="${participationList.specialEventsParticipationId}"
													<c:if test="${participationList.specialEventsParticipationId == participationId}">selected="selected" <c:set var="staffTypeDecription"
												value="${participationList.specialEventsParticipationId}" /></c:if>>${participationList.clubSociety.name}</option>

											</c:when>
										</c:choose>
									</c:forEach>
								</select>

							</div>
							<sec:authorize access="hasRole('View Special Events Attendance')">
							<div class="float_right">
								<div class="buttion_bar_type1">
									<input type="button" value="<spring:message code="REF.UI.SEARCH"/>"
										onClick="document.form.action='searchSpecialEventsAttendance.htm'; document.form.submit();document.getElementById('search_results').style.display=''; document.getElementById('btn_row').style.display=''"
										class="button">
								</div>
							</div>
							</sec:authorize>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<c:if test="${(not empty studentList)}">
				<script language="javascript">
					$(document)
							.ready(
									function() {
										$("#tblFreezed tr")
												.each(
														function(index) {
															$("#tblScrool tr")
																	.eq(index)
																	.height(
																			$(
																					"#tblFreezed tr")
																					.eq(
																							index)
																					.innerHeight());
														});
									});
				</script>
				<div class="section_box" id="search_results">
					<div class="section_box_header">
						<h2>${gradeclassdescription} <spring:message code="ATTENDANCE.ATTENDANCE"/> - ${eventsDescription} </h2>
					</div>
					<div class="column_single">
						<table id="tblFreezed" class="basic_grid basic_grid_freezed"
							style="width: 650px;" border="0" cellspacing="0">
							<tr>
								<th style="height: 34px; * height: 32px;"><spring:message code="ATTENDANCE.STUDENT.ADMISSION"/></th>
								<th style="height: 34px; * height: 32px;"><spring:message code="ATTENDANCE.STUDENT.NAME"/></th>
								<th style="height: 34px; * height: 32px; text-align: center;"><spring:message code="ATTENDANCE.ATTENDANCE"/></th>
							</tr>
							<c:forEach var="studentclass" items="${studentList}"
								varStatus="status">
								<input type="hidden" name="studentnameList"  value="${studentclass.nameWtInitials}"/>
								
					            	
					            	<c:if test="${studentclass.statusId == 1}">
					            	
					            	<tr
									<c:choose>
					            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
					            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
					            	</c:choose>>
					            	
					            	<td class="left">${studentclass.admissionNo}</td>
									<td class="left">${studentclass.nameWtInitials}</td>
									<c:set var="checkval" value="false" />
									<c:if test="${not empty attendanceList}">
										<c:forEach var="attendanceList" items="${attendanceList}">
											<c:if test="${attendanceList.studentId eq studentclass.studentId}">
												<c:set var="checkval" value="true" />
												
											</c:if>
										</c:forEach>
									</c:if>
						
									
									<td style="text-align: center;"><input name="studentIdList" type="checkbox" value="${studentclass.studentId}" 
									<c:if test="${checkval eq true}">checked="checked"</c:if>></td>		
									</tr>															
									</c:if>
									
									
									<c:if test="${studentclass.statusId != 1}">
									
											<c:forEach var="attendanceList" items="${attendanceList}">
											<c:if test="${attendanceList.studentId eq studentclass.studentId}">
											
											<tr
									<c:choose>
					            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
					            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
					            	</c:choose>>
											
												<td class="left">${studentclass.admissionNo}</td>
												<td class="left">${studentclass.nameWtInitials}</td>
											<c:set var="checkval" value="true" />
									
											<td style="text-align: center;"><input name="studentIdList" type="checkbox" value="${studentclass.studentId}" 
									<c:if test="${checkval eq true}">checked="checked"</c:if>></td>	
									
										</tr>
									</c:if>
									</c:forEach>
									
									
									</c:if>
								
								
							</c:forEach>
							<tfoot style="background: #C0C0C0;">
								<tr>
									<td class="left" style="font-weight:bold;" ><spring:message code="ATTENDANCE.TOTAL"/></td>
									<td></td>
									<td style="text-align: center; font-weight:bold;">${total}</td>
								</tr>
							</tfoot>
							
						</table>
						
					</div>
					<div class="clearfix"></div>
				</div><sec:authorize access="hasRole('Save Special Events Attendance')">
				<div id="btn_row" class="button_row" >
					<div class="buttion_bar_type2">
						
						<input type="button" value="<spring:message code="REF.UI.SAVE"/>" class="button" onclick="document.form.action='saveorupdateSpecialEventsAttendance.htm'; document.form.submit();"> 
						<input type="button" id="toggle_check_all" class="button" value="<spring:message code="REF.UI.CHECK.ALL" />" />
						<input type="button" value="<spring:message code="REF.UI.CANCEL"/>" class="button" onclick="document.location.href='SpecialEventsAttendance.htm'">
					</div>
					<div class="clearfix"></div>
				</div></sec:authorize>
			</c:if></form>
		</div>
	</div>
	<h:footer />
</body>
</html>