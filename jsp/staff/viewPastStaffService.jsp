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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>



<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
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
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<script>
$(function() {
	var departuredDate="${pastStaffServiceList[listCount].dateOfDepature}";
	var n=departuredDate.split("-");

	var Year=n[0];
	var month=n[1];
	var day=n[2];

	var date = new Date();
	var currentMonth = date.getMonth();
	var currentDate = date.getDate();
	var currentYear = date.getFullYear();
	
	
	$( "#dateOfReJoin" ).datepicker({
		changeYear: true,
		changeMonth: true,
		yearRange:"c-100:c+1",
		dateFormat : 'yy-mm-dd',
		minDate: new Date(Year, month-1, day),
		maxDate : new Date(currentYear, currentMonth,
				currentDate),
		showOn: "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly: true
		
	});
});

function rejoinStaffMember(thisValue) {
	
	document.form.action = "manageRejoinStaffMember.htm";
	document.form.submit();
}

function closePopup(){
	if(${success != null}){
	opener.document.staffSearch.staffStatus.value='0';	
	opener.document.staffSearch.registrationNo.value = "${pastStaffServiceList[0].staff.registrationNo}";
	opener.document.staffSearch.submit();
    //self.close(); 
	}
}

function showArea() {
	$(document).ready(function() {
		$(".area").hide();
	});
	document.form.dateOfReJoin.value = "";
}
</script>
</head>
<body onload="closePopup();">
<div id="page_container">
<div class="help_link">
				<a href="#"
					onclick="showArea(),PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/RejoinStaffHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> Help </a>
			</div>
<br>
<h1><spring:message code="STAFF.STAFF_PAST_SERVICE_TITLE" /></h1>
<form:form action="" method="POST" 
	name="form" commandName="staffPastService">
<div class="clearfix"></div>
<div class="area">&nbsp;&nbsp;&nbsp;<c:if test="${messages != null}">
		<div><label class="required_sign">${messages}</label></div>
		
	</c:if><form:errors path="dateOfJoin" cssClass="required_sign" />
	<div>&nbsp;&nbsp;&nbsp;<c:if test="${success != null}"><label class="success_sign">${success}</label></c:if></div>
	</div>
<div id="content_main">

	
	<div class="section_box">
			<div id="search_results">
			<div class="section_box_header">
			<h2><spring:message code="STAFF.STAFF_PAST_SERVICE_RESULTS" /></h2>
			
			
			<div class="clearfix"></div><div class="row">	
	<div class="lbl_lock"><br>
    <label>&nbsp;&nbsp;&nbsp;<spring:message code="STAFF.STAFF_NAME"/>:</label>
     <label>${nameWithIntials}</label>
     </div></div><div class="clearfix"></div>
			
			
			</div>
			<div class="column_single">
			<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th style="text-align: center; width: 20%"><spring:message
						code="STAFF.STAFF_REGISTRATION_NUMBER" />
					</th>
					<th style="text-align: center; width: 20%"><spring:message
						code="STAFF.STAFF_JOINED_DATE" />
					</th>
					<th style="text-align: center; width: 20%"><spring:message
						code="STAFF.STAFF_DEPARTURE_DATE" />
					</th>
					<th style="text-align: center; width: 40%"><spring:message
						code="STAFF.STAFF_REASON" />
					</th>
					
				</tr>
				<c:choose>
									<c:when test="${not empty pastStaffServiceList}">
										<c:forEach var="staffPastService" items="${pastStaffServiceList}" varStatus="status">

											<tr>
												<c:choose>
													<c:when test="${(status.count) % 2 == 0}">
														<tr class="odd">
													</c:when>
													<c:otherwise>
														<tr class="even">
													</c:otherwise>
												</c:choose>
												<td style="text-align: center;" ><c:out value="${staffPastService.registrationNo}"></c:out></td>
												<td style="text-align: center;"><c:out value="${staffPastService.dateOfJoin}"></c:out></td>
												<td style="text-align: center;"><c:out value="${staffPastService.dateOfDepature}"></c:out></td>
												<td style="text-align: center;"><c:out value="${staffPastService.reason}"></c:out></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830">
												<h5>
													<spring:message code="STAFF.STAFF.SERVICE.NO.RESULT" />
												</h5></td>
												<td></td>
												<td></td>
												<td></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
		
	
	<div class="button_row">
	<div class="float_right">
		<div class="buttion_bar_type2"><c:if test="${success == null}">
		<sec:authorize access="hasRole('View Staff Service')">
		<input type="button"
			class="button" value="Rejoin Staff Member"
			onClick="showArea(),setAddEditPane(this,'Add')	"
			width="18" height="20"
			title="<spring:message code="STAFF.STAFF.REJOIN.STAFF.MEMBER"/>"></sec:authorize></c:if>
			<input type="button"
			class="button" value="Close"
			onClick="window.open('', '_self', ''); window.close();"
			width="18" height="20"
			title="<spring:message code="STAFF.STAFF.CLOSE.SERVICE.DETAILS"/>">
			</div>
	</div>
	</div>
	<div class="clearfix"></div>
	<div class="section_full_inside" style="display: none">
	<h3><spring:message code="STAFF.STAFF_REJOIN_PAST_STAFF_MEMBER" /></h3>
	<div class="box_border">
	<div class="float_left">
	<div class="lbl_lock">
	<div class="row">
	<div class="frmlabel"><spring:message
		code="STAFF.STAFF_PAST_MEMBER.DATE_OF_DEPARTURE" />:</div>
	<div class="frmvalue"><input type="text" id="dateOfDeparture"
	class="date_field hasDatepicker" value="${pastStaffServiceList[listCount].dateOfDepature}" readonly="readonly"></div>
	</div><div class="clearfix"></div></div></div>
	<div class="row">
	<h6></h6>
	<div class="frmlabel">
	 <span
		class="required_sign">*</span><spring:message
		code="STAFF.STAFF_PAST_MEMBER.DATE_OF_REJOIN" />:</div>
		<div class="frmvalue"><form:input path="dateOfJoin" id="dateOfReJoin" 
	cssClass="date_field" readonly="readonly"/></div>
	<div class="float_right">
	<c:if test="${success == null}">
	<div class="buttion_bar_type1">
	<input type="button" class="button" onClick="rejoinStaffMember(this);"
		value="<spring:message code="STAFF.STAFF.REJOIN" />"> <input
		type="button" class="button" onClick="setAddEditPane(this,'Cancel')"
		value="<spring:message code="STAFF.STAFF.CANCEL" />"></c:if></div></div>
		</div>
		<input type="hidden" name="selectedStaffId" id="selectedStaffId" value="${pastStaffServiceList[0].staff.staffId}"/>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
</form:form></div>
</div>
<h:footer />
</body>
</html>