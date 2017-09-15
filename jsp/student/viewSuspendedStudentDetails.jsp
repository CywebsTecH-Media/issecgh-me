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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
$(function() {
	

	
	var departuredDate="${suspendedStudentDetailList[0].fromDate}";
	var n=departuredDate.split("-");

	var Year=n[0];
	var month=n[1];
	var day=n[2];
	
	var activeDate="${suspendedStudentDetailList[0].toDate}";
	var m=activeDate.split("-");
	
	var YearTo=m[0];
	var monthTo=m[1];
	var dayTo=m[2];

	var date = new Date();
	var currentMonth = date.getMonth();
	var currentDate = date.getDate();
	var currentYear = date.getFullYear();
	
	$( "#activatedDate" ).datepicker({
		changeYear: true,
		changeMonth: true,
		yearRange:"c-100:c+2",
		dateFormat : 'yy-mm-dd',
		minDate: new Date(Year, month-1, day),
		maxDate : new Date(currentYear, currentMonth, currentDate),
		showOn: "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly: true
		
	});
});

function activateSuspendedStudent(thisValue) {	
	
	var message = '<spring:message code="STUDENT.SUSPEND.ACTIVATION.CONFIRMATION"/>';
	
	var okfunction = function(){
		document.form.action = "manageActivateSuspendedStudent.htm";	
		document.form.submit();
	}
	
	var cancelfunction = function(){};
	
	confirm_function(message , okfunction, cancelfunction );
	
}

function showDiv() {
	  
	     
	$(".section_full_inside").show();
	  
	
	}
function showHide() {
	
	if(${messages!=null}){

		$(".section_full_inside").show();
		
		}
	else{
		$(".section_full_inside").hide();
		}
	   
	 }


function setListSize(){
	var listSize = ${fn:length(suspendedStudentDetailList)};
	
}

function ClearForm(){
    document.form.reset();
}

function showArea() {
	$(document).ready(function() {
		$(".area").hide();
	});
}

function closePopup() {
	if (${success!=null}) {	
		
		opener.document.searchStudent.studentStatusId.value='0';
		opener.document.searchStudent.admissionNumber.value = "${rejoinStudent.admissionNo}";
		opener.document.searchStudent.grade.value = '0';
		opener.document.searchStudent.actionType.value = 'search';
		opener.document.searchStudent.submit();
		
		
	}
}

closePopup(); 


function hideArea() {
	$(document).ready(function() {
		$(".area").hide();
	});
}

function hideButton(){
	
		if (${success!=null}){
			document.getElementById("Activebtn").setAttribute("disabled", "disabled");
			}		
}


function closeWindow(){
	self.close();
}


function maxLengthSize(curtailedOrExtendedReason) 
{
    var maxlength = 150; 
    var object = document.getElementById(curtailedOrExtendedReason.id) 
    if (object.value.length > maxlength) 
    {
        object.focus(); 
        object.value = curtailedOrExtendedReason.value.substring(0, maxlength); 
        object.scrollTop = object.scrollHeight; 
        return false;
    }
    return true;
}

</script>
</head>
<body onload="hideButton(),showHide()">
<div id="page_container">
<div class="help_link"><a href="#"
	onclick="showArea(),PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/activateSuspendedHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"> Help </a></div>

<div class="clearfix"></div>
<h1><spring:message
	code="STUDENT.ACTIVATE_SUSPENDED_STUDENT_TITLE" /></h1>
<div id="content_main"><form:form action="" method="POST"
	name="form" commandName="suspendStudent">

	<div class="section_full_summary">
	<div class="box_border">
	<div class="float_left"><label><spring:message
		code="STUDENT.STUDENT_NAME" />:&nbsp;</label> ${nameWithInitial}</div>
	<div class="float_left"><label><spring:message
		code="STUDENT.STUDENT_ADMISSION_NUMBER" />:&nbsp;</label> ${admissionNumber}</div>
	<div class="float_left"></div>
	<div class="clearfix"></div>


	</div>
	</div>
	<div><c:if test="${success != null}">
		<label class="success_sign">&nbsp;&nbsp;&nbsp;${success}</label>
		</br>
		<label class="required_sign">&nbsp;&nbsp;&nbsp;${message}</label>
		</br>
		<label class="success_sign">&nbsp;&nbsp;&nbsp;${successmessage}</label>
	</c:if></div>
	<div class="area"><c:if test="${messages != null}">
		<div>&nbsp;&nbsp;<label class="required_sign">&nbsp;${messages}</label>

		</div>


	</c:if><form:errors path="fromDate" cssClass="required_sign" /></div>
	<div class="section_box">
	<div id="search_results">
	<div class="section_box_header">
	<h2><spring:message code="STUDENT.STUDENT_SUSPENDED_DETAILS" /></h2>

	</div>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th style="text-align: left; width: 11%"><spring:message
				code="STUDENT.STUDENT_SUSPENDED_PERIOD" /></th>
			<th style="text-align: left; width: 22%"><spring:message
				code="STUDENT.SUSPENDED_STUDENT.DISCIPLINARY_ACTION" /></th>
			<th style="text-align: left; width: 28%"><spring:message
				code="STUDENT.STUDENT_DESCRIPTION" /></th>
			<th style="text-align: left; width: 11%"><spring:message
				code="STUDENT.STUDENT_ACTIVATED_DATE" /></th>
			<th style="text-align: left; width: 28%"><spring:message
				code="STUDENT.STUDENT_SUSPEND_REASON" /></th>

		</tr>
		<c:choose>
			<c:when test="${not empty suspendedStudentDetailList}">
				<c:forEach var="suspendedStudentDetail"
					items="${suspendedStudentDetailList}" varStatus="status">

					<tr>
						<c:choose>
							<c:when test="${(status.count) % 2 == 0}">
								<tr class="odd">
							</c:when>
							<c:otherwise>
								<tr class="even">
							</c:otherwise>
						</c:choose>
						<td style="text-align: left;"><c:out
							value="${suspendedStudentDetail.fromDate}"></c:out> &nbsp;-&nbsp;
						<c:out value="${suspendedStudentDetail.toDate}"></c:out></td>

						<td style="text-align: left;"><c:forEach
							items="${studentDisciplineList}" var="studentDisciplineList">
							<c:if
								test="${studentDisciplineList.studentDisciplineId eq  suspendedStudentDetail.disciplinaryActionId}">
								<c:out value="${studentDisciplineList.comment}"></c:out>
							</c:if>
						</c:forEach></td>

						<td style="text-align: left;"><c:out
							value="${suspendedStudentDetail.description}"></c:out></td>
						<td style="text-align: left;"><c:out
							value="${suspendedStudentDetail.activatedDate}"></c:out></td>
						<td style="text-align: left;"><c:out
							value="${suspendedStudentDetail.curtailedOrExtendedReason}"></c:out></td>

					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td width="830">
					<h5><spring:message
						code="STUDENT.SUSPENDED_STUDENT_REJOIN.NO_RESULTS" /></h5>
					</td>
					<td nowrap class="right"></td>
				</tr>
			</c:otherwise>
		</c:choose>

	</table>
	</div>


	<div class="button_row">
	<div class="float_right">

	<div class="buttion_bar_type2"><input type="button"
		class="button" value="<spring:message code="STUDENT.STUDENT_ACTIVATE_STUDENT"/>" id="Activebtn"
		onClick="hideArea(),showDiv()" width="18" height="20"
		title="<spring:message code="STUDENT.STUDENT_ACTIVATE_STUDENT"/>">
	<input type="button" class="button" value="Close"
		onClick="window.open('', '_self', ''); window.close();" width="18"
		height="20"
		title="<spring:message code="STUDENT.STUDENT_CLOSE_REJOIN_SERVICE"/>">

	</div>
	</div>
	</div>
	<div class="clearfix"></div>

	<div class="section_full_inside" style="display: none;"
		id="activePanel">
	<h3><spring:message code="STUDENT.STUDENT_ACTIVATE_STIDENT" /></h3>
	<div class="box_border">
	<div class="float_left">
	<div class="lbl_lock">
	<div class="row">
	<div class="frmlabel" style="width: 190px"><spring:message
		code="STUDENT.SUSPENDED_STUDENT.DATE_OF_SUSPEND" />:</div>
	<div class="frmvalue"><input type="text" id="dateOfDeparture"
		class="date_field hasDatepicker"
		value="${suspendedStudentDetailList[0].fromDate}" readonly="readonly"></div>
	</div>

	</div>
	</div>
	<div class="clearfix"></div>


	<div class="row">




	<div class="frmlabel" style="width: 190px"><span
		class="required_sign">*</span><spring:message
		code="STUDENT.STUDENT_ACTIVATE_DATE" />:</div>
	<div class="frmvalue"><form:input path="activatedDate"
		id="activatedDate" cssClass="date_field" readonly="readonly" /></div>
	</div>
	<div class="row"><span class="required_sign">**</span><spring:message
		code="STUDENT.STUDENT_SUSPEND_REASON_DESCRIPTION" /></div>
	<div class="row">
	<div class="frmlabel" style="width: 190px"><spring:message
		code="STUDENT.STUDENT_SUSPEND_REASON" />:</div>
	<div class="frmvalue"><form:textarea
		name="curtailedOrExtendedReason" id="curtailedOrExtendedReason"
		cols="54" rows="3" onKeyUp="javascript:maxLengthSize(this);" onChange="javascript:maxLengthSize(this);" path="curtailedOrExtendedReason" />
	</div>
	</div>
	<div class="row">
	<div class="float_right">
	<div class="buttion_bar_type1"><input type="button"
		class="button" onClick="activateSuspendedStudent(),hideArea()"
		value="<spring:message code="STUDENT.STUDENT.ACTIVATE" />"> <input
		type="button" class="button"
		onClick="hideArea(),setAddEditPane(this,'Cancel'),ClearForm()"
		value="<spring:message code="STUDENT.STUDENT.CANCEL" />"></div>
	</div>
	</div>

	<input type="hidden" name="selectedStudentId" id="selectedStudentId"
		value="${suspendedStudentDetailList[0].student.studentId}" />
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