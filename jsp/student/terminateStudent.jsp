<%--
    < AKURA, This application manages the daily activities of a Teacher and a Student of a School>
    
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

		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		$("#suspendToDate").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c:c+1",
			minDate : new Date(currentYear, currentMonth, currentDate),
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true

		});
	});

	$(function() {
		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		$("#suspendFromDate,#tempLeaveFromDate").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c:c",
			minDate : new Date(currentYear, currentMonth, currentDate),
			maxDate : new Date(currentYear, currentMonth, currentDate),
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true

		});
	});

	$(function() {
		$("#dateOfDeparture").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "-1:+0:+0",
			dateFormat : 'yy-mm-dd',
			maxDate : new Date(),
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true
		});
	});

	$(function() {

		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		$(" #tempLeaveToDate").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c:c+10",
			minDate : new Date(currentYear, currentMonth, currentDate),
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true

		});
	});

	function selectArea() {
		var dropdownValue = document.getElementById("select").value;
		if (dropdownValue == "3") {
			$(".suspend").show();
			$(".section_full_inside").show();
			$(".a").hide();
			$(".leaveMessage").hide();
			$(".tempLeave").hide();
			$(".pastSt").hide();
		} else if (dropdownValue == "4") {
			$(".tempLeave").show();
			$(".section_full_inside").show();
			$(".a").hide();
			$(".leaveMessage").hide();
			$(".suspend").hide();
			$(".pastSt").hide();
		} else if (dropdownValue == "2") {
			$(".pastSt").show();
			$(".section_full_inside").show();
			$(".a").hide();
			$(".leaveMessage").hide();
			$(".suspend").hide();
			$(".tempLeave").hide();
		} else if (dropdownValue == "0") {
			$(".pastSt").hide();
			$(".suspend").hide();
			$(".tempLeave").hide();
		}
	}

	function selectDefaultArea() {
		if ("${select}" == "3") {
			$(".suspend").show();
			$(".section_full_inside").show();
			$(".tempLeave").hide();
			$(".pastSt").hide();

		} else if ("${selectvalue}" == "Past") {
			$(".pastSt").show();
			$(".section_full_inside").show();
			$(".tempLeave").hide();
			$(".suspend").hide();

		} else if("${selectvalue}" == "Temporary Leave") {
			$(".tempLeave").show();
			$(".section_full_inside").show();
			$(".pastSt").hide();
			$(".suspend").hide();
		}
	}
	function Cancel() {
		document.getElementById("select").value = "0";
		document.getElementById("suspendToDate").value = "";
		document.getElementById("suspendFromDate").value = "";
		document.getElementById("description").value = "";
		document.getElementById("selectDis").value = "0";
		$(".area").hide();

	}
	
	
	
	function terminateStudent() {
		var deleteRecords;
		
		var message = '<spring:message code="STUDENT.DEPARTURE_DATE_DETAILS.TERMINATE.CONFIRMATION"/>';
		
		var okfunction = function(){
			
			var dropdownValue = document.getElementById("select").value;
			
			if (dropdownValue == "4") {
				var data = $('form').serialize();
				var url = '<c:url value="/checkTerminateStudent.htm" />';
				
				$.ajax({
					url : url,
					data : data,
					success : function(response) {
						if(response=='true'){
						
							var message= '<spring:message code="REF.SAVETEMPLEAVE.CONFIRMATION"/>';
							
							var okfunction = function(){
								
								deleteRecords = true;
								document.form.action = "saveOrUpdateTempStudent.htm";
								document.form.tempDelete.value=true;
								document.form.submit();
							};
							var cancelfunction = function(){};
							
							confirm_function(message , okfunction, cancelfunction );
							
						}else{
							
							deleteRecords = false;
							document.form.action = "saveOrUpdateTempStudent.htm";
							document.form.tempDelete.value=false;
							document.form.submit();
						}
						
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
                    	custom_alert("An error has occurred");
					}//EINDE error
                   
				});
			
				//redirect to terminateRequest
				if(deleteRecords){
					document.form.action = "saveOrUpdateTempStudent.htm";
					document.form.tempDelete.value=true;
					document.form.submit();
				}else if (deleteRecords==false){
					document.form.action = "saveOrUpdateTempStudent.htm";
					document.form.tempDelete.value=false;
					document.form.submit();
				}
					
			}else{
				document.form.action = "saveOrUpdateTerminateStudent.htm";
				document.form.submit();
			}
			
			
		};
		var cancelfunction = function(){};
		
		confirm_function(message , okfunction, cancelfunction );
	}

	function suspendTerminateStudent(){
		
		var message = '<spring:message code="REF.SUSPEND.CONFIRMATION"/>';

		var okfunction = function(){
				document.form.action = "saveOrUpdateTerminateStudent.htm";
				document.form.submit();
		};
		
		var cancelfunction = function(){};

		confirm_function(message , okfunction, cancelfunction );
	}

	function terminateStudentNew(thisValue) {		
		
		var message = '<spring:message code="REF.SAVE.CONFIRMATION"/>';

		var okfunction = function(){
			var dropdownValue = document.getElementById("select").value;
			if (dropdownValue == "2") {
				var data = $('form').serialize();
				var url = '<c:url value="/checkTerminateStudent.htm" />';
				
				$.ajax({
					url : url,
					data : data,
					success : function(response) {

						var c = response;
						
						if(c='true'){
							var message = '<spring:message code="REF.SAVE.PAST.LEAVE.CONFIRMATION"/>';							
														
							var okfunction = function(){								
								document.form.action = "saveOrUpdatePastStudent.htm";
								document.form.pastDelete.value=true;
								document.form.submit();
							};
							var cancelfunction = function(){};
							
							confirm_function(message , okfunction, cancelfunction );

						}
						
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
                    	custom_alert("An error has occurred");
					}
				});				
				
			}else{
				document.form.action = "saveOrUpdateTerminateStudent.htm";
				document.form.submit();
			}
			
			
		};
		var cancelfunction = function(){};
		
		confirm_function(message , okfunction, cancelfunction );
		
	}
			
			
			
	
			
			
	function closePopup() {

		if (${success!=null}) {
			opener.document.searchStudent.studentStatusId.value='0';
			opener.document.searchStudent.admissionNumber.value = "${studentId.admissionNo}";
			opener.document.searchStudent.actionType.value = 'search';
			opener.document.searchStudent.submit();
		}
	}

	closePopup();
	
	function selectArea_1(){
		document.getElementById("reason").value="";
		document.getElementById("dateOfDeparture").value="";
		document.getElementById("completeClearance").checked=false;
		$(".pastSt").show();
		$(".b").show();
		$(".tempLeave").hide();
		$(".suspend").hide();
		
		
	}

	function selectArea_templeave(){
		document.getElementById("tempLeaveFromDate").value="";
		document.getElementById("tempLeaveReason").value="";
		document.getElementById("tempLeaveToDate").value="";
		document.getElementById("tempLeaveCompleteClearence").checked=false;
		$(".pastSt").hide();
		$(".tempLeave").hide();
		$(".suspend").hide();
		
		
	}


	function closeWindow(){
		self.close();
	}
	
	
	function maxLengthSize(description) 
	{
	    var maxlength = 150; 
	    var object = document.getElementById(description.id) 
	    if (object.value.length > maxlength) 
	    {
	        object.focus(); 
	        object.value = description.value.substring(0, maxlength); 
	        object.scrollTop = object.scrollHeight; 
	        return false;
	    }
	    return true;
	}

	function maxLengthSize1(tempLeaveReason) 
	{
	    var maxlength = 150; 
	    var object = document.getElementById(tempLeaveReason.id) 
	    if (object.value.length > maxlength) 
	    {
	        object.focus(); 
	        object.value = tempLeaveReason.value.substring(0, maxlength); 
	        object.scrollTop = object.scrollHeight; 
	        return false;
	    }
	    return true;
	}
</script>
</head>

<body
	onload="selectDefaultArea(),document.getElementById('select').selectedValue='${selectValue}'">
<div id="page_container">
<div class="help_link"><a href="#"
	onclick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/terminateStudentHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"> Help </a></div>
<br>
<h1><spring:message code="STUDENT.STUDENT_TERMINATE_STUDENT_TITLE" />
</h1>

<div class="area">
<div>&nbsp;&nbsp;&nbsp; <c:if test="${success != null}">
	<label class="success_sign">${success}&nbsp;and&nbsp;${successmessage}</label>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;<label class="required_sign">${message}</label>
</c:if>
<div class="leaveMessage"><label class="required_sign">${leave}</label></div>
</div>
</div>
<div class="box_border">
<div class="section_full_summary">
<div class="box_border">
<div class="float_left"><label><spring:message
	code="STUDENT.STUDENT_ADMISSION_NUMBER" />:&nbsp;</label>
${studentId.admissionNo}</div>
<div class="float_left"><label><spring:message
	code="STUDENT.STUDENT_NAME" />:&nbsp;</label> ${studentId.nameWtInitials}</div>
<div class="float_left"></div>
<div class="clearfix"></div>


</div>
</div>


<div id="content_main"><form:form action="#" method=""
	commandName="wrapperTerminateStudent" name="form">
	<input type="hidden" name="tempDelete" />
	<input type="hidden" name="pastDelete" />
	<div class="clearfix"></div>
	<div class="section_box">

	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><c:if test="${success == null}">
		<label><spring:message
			code="STUDENT.STUDENT_TERMINATE_CRITERIA" />:</label>


		<select name="select" onchange="selectArea()" id="select">
			<option value="0"><spring:message
				code="application.drop.down" /></option>

			<c:forEach items="${studentStatusList}" var="studentStatus">

				<c:choose>
					<c:when test="${selectvalue eq studentStatus.description}">
						<option selected="selected"
							value="${studentStatus.studentStatusId}">${studentStatus.description}</option>
					</c:when>
					<c:otherwise>
						<option value="${studentStatus.studentStatusId}">${studentStatus.description}</option>
					</c:otherwise>
				</c:choose>



				<!--				<option value="${studentStatus.studentStatusId}">${studentStatus.description}</option>-->

			</c:forEach>
		</select>




	</c:if></div>

	</div>

	<div class="float_right"><input type="button" class="button"
		value="Close" onClick="closeWindow()" width="18" height="20"
		title="<spring:message code="STUDENT.STUDENT.CLOSE"/>"></div>

	</div>

	<div class="clearfix"></div>
	</div>


	<div class="section_full_inside" style="display: none">
	<div class='suspend' id="suspend" style="display: none">
	<h3><spring:message code="STUDENT.STUDENT.SUSPEND_TITLE" /></h3>

	<spring:bind path="wrapperTerminateStudent.suspendStudent.*">
		<div class="a"><label class="required_sign"> <c:if
			test="${not empty status.errorMessages}">
			<c:forEach var="error" items="${status.errorMessages}">
				<c:out value="${error}" escapeXml="false" />
				<br />
			</c:forEach>
		</c:if> </label></div>
		<div class="box_border">

		<div class="row">
		<div class="float_left">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="STUDENT.STUDENT.DISCIPLINARY_ACTION" /> </label></div>

		<form:select name="selectDis" onchange="" id="selectDis"
			path="suspendStudent.disciplinaryActionId">
			<option value="0"><spring:message
				code="application.drop.down" /></option>
			<c:forEach items="${studentDisciplineList}" var="studentDiscipline">

				<option value="${studentDiscipline.studentDisciplineId}"><b>${studentDiscipline.comment}</b>&nbsp;(${studentDiscipline.date})
				</option>
			</c:forEach>
		</form:select></div>
		<div class="float_right"
			style="margin-right: 50px; *margin-right: 10px;">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="STUDENT.STUDENT.TO_DATE" />:</label></div>
		<form:input type="text" id="suspendToDate" name="suspendToDate"
			class="date_field" path="suspendStudent.toDate" readonly="true" /></div>
		<div class="float_right" style="margin-right: 50px;">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="STUDENT.STUDENT.FROM_DATE" />:</label></div>
		<form:input id="suspendFromDate" name="suspendFromDate"
			class="date_field" path="suspendStudent.fromDate" readonly="true" />
		</div>

		</div>

		<div class="row"><br>
		<div class="float_left">
		<div class="lbl_lock"><label><spring:message
			code="STUDENT.STUDENT.DESCRIPTION" />:</label></div>
		<form:textarea name="description" id="description" cols="54" rows="3"
			 onKeyUp="javascript:maxLengthSize(this);" onChange="javascript:maxLengthSize(this);"  path="suspendStudent.description" /></div>
		</div>

		<div class="row">
		<div class="buttion_bar_type1" style="margin-top: 15px;"><input
			type="button" value=<spring:message code="STUDENT.STUDENT.SAVE"/>
			onClick="suspendTerminateStudent()" class="button"
			title=<spring:message code="STUDENT.STUDENT.SAVE"/>><input
			type="button" class="button"
			onClick="Cancel(),setAddEditPane(this,'Cancel')"
			value=<spring:message code="STUDENT.STUDENT.CANCEL"/>
			title=<spring:message code="STUDENT.STUDENT.CANCEL"/>></div>
		</div>
		<div class="clearfix"></div>

		</div>
	</spring:bind></div>

	<div class='tempLeave' id="tempLeave" style="display: none">
	<h3><spring:message code="STUDENT.STUDENT.TEMPORARY_LEAVE_TITLE" />
	</h3>
	<spring:bind path="wrapperTerminateStudent.studentTemporaryLeave.*">
		<div class="a"><label class="required_sign"> <c:if
			test="${not empty status.errorMessages}">
			<c:forEach var="error" items="${status.errorMessages}">
				<c:out value="${error}" escapeXml="false" />
				<br />
			</c:forEach>
		</c:if> </label></div>




		<div class="box_border">
		<div class="row">

		<div class="float_left">
		<div class="lbl_lock"><span class="required_sign">*</span><label>
		<spring:message code="STUDENT.STUDENT.FROM_DATE" />:</label></div>
		<form:input path="studentTemporaryLeave.fromDate"
			id="tempLeaveFromDate" cssClass="date_field" title="${dateOfFormat}"
			readonly="true" /></div>
		<div class="float_left" style="margin-left: 100px;">
		<div class="lbl_lock"><span class="required_sign">*</span> <label><spring:message
			code="STUDENT.STUDENT.TO_DATE" />:</label></div>
		<form:input path="studentTemporaryLeave.toDate" id="tempLeaveToDate"
			cssClass="date_field" title="${dateOfFormat}" readonly="true" /></div>

		</div>
		<div class="row">
		<div class="float_left">
		<div class="lbl_lock"><span class="required_sign">*</span> <label><spring:message
			code="STUDENT.STUDENT.REASON" />:</label></div>
		<form:textarea path="studentTemporaryLeave.reason" cols="50"
			id="tempLeaveReason" name="tempLeaveReason" rows="4" onKeyUp="javascript:maxLengthSize1(this);" onChange="javascript:maxLengthSize1(this);" /></div>
		</div>
		<div class="row">
		<div class="float_left">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="STUDENT.DEPARTURE_DATE_DETAILS.COMPLETE_CLEARANCE" />:</label> <form:checkbox
			type="checkbox" path="studentTemporaryLeave.completeClearance"
			id="tempLeaveCompleteClearence" align="left"
			style="width: 20px; height: 12px;" /></div>
		</div>
		
		<div class="float_right">
		<div class="buttion_bar_type1" style="margin-top: 15px;"><input
			type="button" value=<spring:message code="STUDENT.STUDENT.SAVE"/>
			onClick="terminateStudent();" class="button"
			title=<spring:message code="STUDENT.STUDENT.SAVE"/>><input
			type="button" class="button"
			onClick="Cancel(),setAddEditPane(this,'Cancel'),selectArea_templeave()"
			value=<spring:message code="STUDENT.STUDENT.CANCEL"/>
			title=<spring:message code="STUDENT.STUDENT.CANCEL"/>></div>
		</div>


		</div>
		<div class="clearfix"></div>
		</div>
	</spring:bind></div>

	<div class="section_full_inside" style="display: none" name="b"
		id="pastForm">
	<div class='pastSt' id="pastSt" style="display: none">
	<h3><spring:message
		code="STUDENT.DEPARTURE_DATE_DETAILS.INFORMATION" /></h3>

	<spring:bind path="wrapperTerminateStudent.pastStudent.*">
		<div class="a"><label class="required_sign"> <c:if
			test="${not empty status.errorMessages}">
			<c:forEach var="error" items="${status.errorMessages}">
				<c:out value="${error}" escapeXml="false" />
				<br />
			</c:forEach>

		</c:if> </label></div>


		<div class="box_border">

		<div class="row">



		<div class="frmlabel" style="width: 185px"><label><spring:message
			code="STUDENT.DEPARTURE_DATE_DETAILS.ADMISSION_DATE" /> :</label></div>
		<label> &nbsp;&nbsp;${studentId.firstSchoolDay} </label></div>
		<div class="row">
		<div class="frmlabel" style="width: 185px"><span
			class="required_sign">*</span><label><spring:message
			code="STUDENT.DEPARTURE_DATE_DETAILS.DEPARTURE_DATE" /> :</label></div>

		<div class="frmvalue"><form:input
			path="pastStudent.dateOfDeparture"
			id="${success?'':'dateOfDeparture'}" cssClass="date_field"
			readonly="true" /></div>
		</div>



		<div class="row">
		<div class="frmlabel" style="width: 185px"><span
			class="required_sign">*</span><label><spring:message
			code="STUDENT.DEPARTURE_DATE_DETAILS.REASON" /> :</label></div>

		<div class="frmvalue"><form:textarea path="pastStudent.reason"
			id="reason" rows="3" maxlength="250" style="width: 290px;"
			readonly="${success}" /></div>
		</div>

		<div class="row">
		<div class="frmlabel" style="width: 185px"><span
			class="required_sign">*</span><label><spring:message
			code="STUDENT.DEPARTURE_DATE_DETAILS.COMPLETE_CLEARANCE" /> :</label></div>

		<div class="frmvalue"><form:checkbox type="checkbox"
			path="pastStudent.completeClearance" name="clearance"
			id="completeClearance" align="left"
			style="width: 20px; height: 20px;" /></div>
		</div>
		<div class="row">
			<div class="frmlabel" style="width: 185px"><label><spring:message
					code="SMS.STUDENT.SUBSCRIPTIONS" /> : </label>
			</div>
		
			<div class="frmlabel">
				<table style="padding:0px;border-width:0px  "">
					<tr>
						<td align="left"  >
						 	<c:forEach var="ob"  items="${subscriptions}">
						 		<c:out value="&nbsp;${ob}" escapeXml="false" />
								<br />
						 	</c:forEach>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="frmlabel" style="width: 540px"><label><span class="required_sign">*</span>
			<spring:message code="SMS.STUDENT.PAST.NOTE" /></label>
			</div>
		</div>
		<div class="clearfix"></div>


		<div class="float_right">
		<div class="buttion_bar_type2"><c:if test="${not success}">
			<input type="button" value="<spring:message code='REF.UI.RESET' />"
				class="button" name="button" onclick="selectArea_1()">
			<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
				onClick="terminateStudentNew(this)" class="button">
		</c:if> <input type="button" class="button"
			onClick="Cancel(),setAddEditPane(this,'Cancel'),selectArea_1()"
			value="Cancel"></div>
		</div>



		<div class="clearfix"></div>
		</div>
	</spring:bind></div>

	</div>



	<div class="clearfix"></div>
	</div>


	<input type="hidden" name="selectedStudentId" id="selectedStudentId"
		value="${studentId.studentId}" /></div>
</form:form></div>
</div>


</div>



<h:footer />
</body>
</html>
