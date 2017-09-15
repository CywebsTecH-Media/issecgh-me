<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>

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
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
$(function(sach) {
	var date = new Date();
	var currentMonth = date.getMonth();
	var currentDate = date.getDate();
	var currentYear = date.getFullYear();

	$("#leaveFromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		yearRange : "c:c",
		dateFormat : 'yy-mm-dd',
		showOn : "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly : true,
		onSelect: function(selected,evnt) {
		 $('#leaveToDate').datepicker('option', 'minDate', selected);
		
		
		
}

	});
});
$(function(sach) {
		
	$("#leaveToDate").datepicker({	
	
		changeYear : true,
		changeMonth : true,
		yearRange : "c:c+1",
		dateFormat : 'yy-mm-dd',
		showOn : "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly : true

	});
});



	
	

	
	
	
</script>
<!-- END Calender controll CSS and JS -->

<script type="text/javascript">

	<sec:authorize access="hasAnyRole('Add/Edit Student Leave')">
	$(document).ready(function() {
		// works only for save upate privalages(admin ,teacher)
		// when page request comming from "attendece tab"
		// date comes weth a parameter 
		var date="${param.date}";		
		if(date!="" ){
			var thisEliment=document.getElementById("imageAdd");
			setAddEditPane(thisEliment, 'Add');
			document.studentLeaveForm.fromDate.value=date;
			document.studentLeaveForm.toDate.value=date;
		}	
	   
	 });
	</sec:authorize>

	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.studentLeaveForm.reason.value != '') {
			document.studentLeaveForm.reason.value = '';
		}
		if (document.studentLeaveForm.fromDate.value != '') {
			document.studentLeaveForm.fromDate.value = '';
		}
		if (document.studentLeaveForm.toDate.value != '') {
			document.studentLeaveForm.toDate.value = '';
		}
		document.getElementById("certificategiven").checked = false;
		document.studentLeaveForm.studentLeaveId.value = 0;
		
		
		document.getElementById("attendancePage").value = "false";
		
		$(function(sach) {
			var date = new Date();
			var currentMonth = date.getMonth();
			var currentDate = date.getDate();
			var currentYear = date.getFullYear();

			$("#leaveFromDate").datepicker({
				changeYear : true,
				changeMonth : true,
				yearRange : "c:c",
				dateFormat : 'yy-mm-dd',
				showOn : "button",
				buttonImage : "resources/images/calendar.jpg",
				buttonImageOnly : true,
				onSelect: function(selected,evnt) {
				 $('#leaveToDate').datepicker('option', 'minDate', selected);
				
				
				
	    }

			});
		});

		
		
		$(function(sach) {
				
			$("#leaveToDate").datepicker({	
			
				changeYear : true,
				changeMonth : true,
				yearRange : "c:c+1",
				dateFormat : 'yy-mm-dd',
				showOn : "button",
				buttonImage : "resources/images/calendar.jpg",
				buttonImageOnly : true

			});
		});
	}

	function saveStudentLeave(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.studentLeaveForm.certificategiven.value = document.getElementById("certificategiven").checked;
		document.studentLeaveForm.action = "saveOrUpdateStudentLeave.htm";
		document.studentLeaveForm.submit();
	}

	function updateStudentLeave(thisValue, studentLeaveId, reason, fromDate,
			toDate , certificategiven) {
		setAddEditPane(thisValue, 'Edit');
		document.getElementById("certificategiven").checked = false;
		document.studentLeaveForm.studentLeaveId.value = studentLeaveId;
		document.studentLeaveForm.reason.value = reason;
		document.studentLeaveForm.fromDate.value = fromDate;
		document.studentLeaveForm.toDate.value = toDate;
		 if(certificategiven == ("true")){
				document.getElementById("certificategiven").checked = true;
				}
		 
		 $("#leaveFromDate, #leaveToDate").datepicker(
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
							var option = this.id == "leaveFromDate" ? "minDate"
									: "maxDate", instance = $(this).data(
									"datepicker"), date = $.datepicker.parseDate(
									instance.settings.dateFormat
											|| $.datepicker._defaults.dateFormat,
									selectedDate, instance.settings);
							dates.not(this).datepicker("option", option, date);
						}
					});
	}

	function deleteStudentLeave(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.studentLeaveForm.studentLeaveId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.studentLeaveForm.action = "deleteStudentLeave.htm";
			document.studentLeaveForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}
	
	
</script>

</head>
<body>
<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="studentLeave.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="studentLeave.htm" />
		</c:otherwise>
	</c:choose>

<div id="page_container">

<div id="breadcrumb_area">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
	<sec:authorize access="hasRole('Student Search')">
		<li><a href="studentSearch.htm"><spring:message code="STUDENT.STUDENTSEARCH"/></a>&nbsp;&gt;&nbsp;</li>
	</sec:authorize>
	<li><spring:message code="STUDENT.LEAVE.TITLE"/></li>
</ul>
</div>
	<div class="help_link"><a href="#"
		onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentLeaveHelp.html"/>','helpWindow',780,550)"><img
		src="resources/images/ico_help.png" width="20" height="20"
		align="absmiddle"> <spring:message code="application.help"/></a></div>

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
<h1><spring:message code="STUDENT.LEAVE.TITLE"/></h1>
<div id="content_main">
<div class="section_full_summary">
<div class="box_border">
<div class="float_left"><label><spring:message code="STUDENT.COMMON.NAME"/>&nbsp;</label>
${student.nameWtInitials}</div>
<div class="float_left"><label><spring:message code="STUDENT.COMMON.ADDMISSION"/>&nbsp;</label>
${student.admissionNo}</div>
<div class="float_left"><label><spring:message code="STUDENT.COMMON.CLASS"/>&nbsp;</label>
${studentClassDescription}</div>
<div class="clearfix"></div>
</div>
</div>

<c:choose>
<c:when test="${not empty hasStudentClass}">
			<c:if test="${showErrorDefault != null}">
				<h3><spring:message code="STUDENT.LEAVE.ASSIGNCLASS"/></h3>
			</c:if>
<form:form action="" method="POST" commandName="studentLeave"
	name="studentLeaveForm">

	<form:hidden path="studentLeaveId" />

	<div class="clearfix"></div>
	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message code="STUDENT.LEAVE.TITLE"/></h2>
	</div>
	
	<div>
	<label class="success_sign"> <c:if
		test="${assginMessage != null}">${assginMessage}</c:if></label>
	<label class="required_sign"> <c:if
		test="${message != null}">${message}</c:if> <form:errors
		path="studentLeaveId" /><br>
	<form:errors path="reason" /> </label>
	</div>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th width="376"><spring:message code="STUDENT.LEAVE.DESCRIPTION"/></th>
			<th width="136"><spring:message code="STUDENT.LEAVE.DATEFROM"/></th>
			<th width="136"><spring:message code="STUDENT.LEAVE.DATETO"/></th>
			<th width="186" class="center"><spring:message code="STUDENT.LEAVE.NUMBER.OF.DAYS"/></th>
			<th width="74" align="right" class="right">
			<sec:authorize access="hasAnyRole('Add/Edit Student Leave')">
				<img id="imageAdd" src="resources/images/ico_new.gif" class="icon_new"
					onClick="addNew(this)" width="18" height="20" title="<spring:message code="STUDENT.LEAVE.ADD.LEAVE"/>" <c:if test="${student.statusId != 1 || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
			</sec:authorize></th>
		</tr>
		<c:choose>
			<c:when test="${not empty studentLeaveList}">
				<c:forEach items="${studentLeaveList}" var="studentLeave"
					varStatus="status">
					<tr
						<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
						<td>${studentLeave.reason}</td>
						<td>${studentLeave.fromDate}</td>
						<td>${studentLeave.toDate}</td>
						<td class="center">${studentLeave.noOfDays}</td>
						<td nowrap class="right">
							<sec:authorize access="hasAnyRole('Add/Edit Student Leave')">
							<img src="resources/images/ico_edit.gif"
								onClick="updateStudentLeave(this, '<c:out value="${studentLeave.studentLeaveId}"/>', '<c:out value="${studentLeave.reason}"/>', '<c:out value="${studentLeave.fromDate}"/>'
														, '<c:out value="${studentLeave.toDate}"/>' , '<c:out value="${studentLeave.certificategiven}"/>')"
								title="<spring:message code="STUDENT.LEAVE.EDIT.LEAVE"/>" width="18" height="20" class="icon" <c:if test="${studentLeave.checkAutoGenerated eq true}">style="display:none;"</c:if><c:if test="${student.statusId != 1  || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('Delete Student Leave')">
							<img src="resources/images/ico_delete.gif"
								onClick="deleteStudentLeave(this, '<c:out value="${studentLeave.studentLeaveId}"/>')"
								title="Delete" width="18" height="20" class="icon" <c:if test="${studentLeave.checkAutoGenerated eq true}">style="display:none;"</c:if><c:if test="${student.statusId != 1  || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
							</sec:authorize></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td width="830">
					<h5><spring:message code="STUDENT.LEAVE.NO.DATA.FOUND"/></h5>
					</td>
					<td nowrap class="right"></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	<spring:bind path="studentLeave.*">
		<c:set var="status" value="${status}"></c:set>
	</spring:bind>
	<div class="section_full_inside" style="display: ${message != null or not empty status.errorMessages?'block':'none'};">
	<h3><spring:message code="STUDENT.LEAVE.ADD.LEAVE"/></h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message code="STUDENT.LEAVE.DESCRIPTION"/>:</label>
	</div>
	<form:input path="reason" maxlength="45"/></div>
	<div class="float_right"
		style="margin-right: 50px; * margin-right: 10px;">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message code="STUDENT.LEAVE.DATETO"/>:</label></div>
	<form:input path="toDate" id="leaveToDate" cssClass="date_field" readonly="true" /></div>
	<div class="float_right" style="margin-right: 50px;">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message code="STUDENT.LEAVE.DATEFROM"/>:</label></div>
	<form:input path="fromDate" id="leaveFromDate" cssClass="date_field" readonly="true" />
	</div>
	<div class="row">
	<div class="row">
	<span class="required_sign">**</span>
	This field is mandatory if date range is greater than 3.
	</div>
	<div class="float_left">
	<div class="lbl_lock"></div>

	<spring:message code="studentLeave.ui.certificate" />
	<form:checkbox path="certificategiven" id="certificategiven"
		cssClass="date_field"
		cssStyle="border:none; background:none; width:20px;" /></div>
	<div class="buttion_bar_type1">
	<sec:authorize access="hasAnyRole('Add/Edit Student Leave')">
	<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
		onClick="saveStudentLeave(this)" class="button">
	<input type="button" class="button" onClick="setAddEditPane(this,'Cancel')"
		value='<spring:message code="REF.UI.CANCEL"/>'>
	</sec:authorize></div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	<div class="section_box">
	<div class="clearfix"></div>
	</div>
<input type="hidden" id="attendancePage" name="attendancePage"
								value="${attendancePage}">
</form:form>
	</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.LEAVE.ASSIGNCLASS" /></h3>
		</c:otherwise>			
</c:choose>


</div>
</div>
</div>
</div>
<h:footer />
</body>
</html>
