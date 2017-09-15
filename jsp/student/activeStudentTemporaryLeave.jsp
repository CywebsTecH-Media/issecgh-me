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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>


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


<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	$(function() {

		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		$("#activateDate").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c:c+1",
			minDate : new Date(currentYear, currentMonth, currentDate),
			maxDate : new Date(currentYear, currentMonth, currentDate),
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

		var dates = $("#fromDateId, #toDateId").datepicker(
				{
					defaultDate : "+1w",
					yearRange : "c:c+2",
					changeYear : true,
					changeMonth : true,
					numberOfMonths : 1,
					dateFormat : 'yy-mm-dd',
					showOn : "button",
					buttonImage : "resources/images/calendar.jpg",
					buttonImageOnly : true,
					minDate : new Date(currentYear, currentMonth, currentDate),
					onSelect : function(selectedDate) {
						var option = this.id == "fromDateId" ? "minDate"
								: "maxDate", instance = $(this).data(
								"datepicker"), date = $.datepicker.parseDate(
								instance.settings.dateFormat
										|| $.datepicker._defaults.dateFormat,
								selectedDate, instance.settings);
						dates.not(this).datepicker("option", option, date);
					}
				});
	});

	function activeteStudentTempDetails(thisValue) {

		if(${successActiveMsg == true})
		{
			var okfunction = function(){
				setAddEditPane(thisValue, 'Save');
				document.studentTempLeaveForm.action = "activateStudentTemp.htm?selectedStudentId="+${studentId.studentId};
				document.studentTempLeaveForm.submit();
			};
			
			var cancelfunction = function(){};

			var message = '<spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.CONFIRMATION"/>';

			confirm_function(message, okfunction, cancelfunction);
		
		}

	}

	function activateButton()
	{
	
		if(${successActiveMsg == true})
		{
			document.getElementById('activate').style.display='';
			document.getElementById('extend').style.display='none';
			document.getElementById('activateDate').value='';
		}
	}
	
function activation(){
		
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		
		if ( yyyy < 1970 ) yyyy = yyyy + 100;	// We still have to fix the millennium bug
		ys = new String(yyyy)	// Convert year, month and date to strings
		ms = new String(mm)	 
		ds = new String(dd)	 
		if ( ms.length == 1 ) ms = "0" + ms;	// Add leading zeros to month and date if required
		if ( ds.length == 1 ) ds = "0" + ds;
		
		var currentDate =ys + "/" + ms + "/" + ds;
		var dateOne = new Date(currentDate); //Year, Month, Date
				
		var toDate = document.getElementById('expire').innerHTML;
		var date = new Date(toDate.replace(/-/g, '/'));
		var ddd = date.getDate()+1;
		var mmm = date.getMonth()+1; //January is 0!
		var yyyyy = date.getFullYear();
		
		if ( yyyyy < 1970 ) yyyyy = yyyyy + 100;	// We still have to fix the millennium bug
		yys = new String(yyyyy)	// Convert year, month and date to strings
		mms = new String(mmm)	 
		dds = new String(ddd)	 
		if ( mms.length == 1 ) mms = "0" + mms;	// Add leading zeros to month and date if required
		if ( dds.length == 1 ) dds = "0" + dds;
		
		var toD =yys + "/" + mms + "/" + dds;
		var dateTwo = new Date(toD); //Year, Month, Date
		
		if(dateTwo.getTime() < dateOne.getTime()){
			document.getElementById("activate1").disabled = true; 
		}
		else{
			document.getElementById("activate1").disabled = false; 
		}
	}
	
	function extendStudentTempDetails(thisValue) {

		if(${successActiveMsg == true})
	    {
			setAddEditPane(thisValue, 'Save');
			document.studentTempLeaveForm.action = "extendStudentTemp.htm?selectedStudentId="+${studentId.studentId};
			document.studentTempLeaveForm.submit();
	    }
	}

	function saveExtenedStudentTempDetails(thisValue)
	{
		setAddEditPane(thisValue, 'Save');
		document.studentTempLeaveForm.action = "saveExtendedStudentTemp.htm?selectedStudentId="+${studentId.studentId};
		document.studentTempLeaveForm.submit();

	}

	function closePage()
	{
		opener.document.searchStudent.action = 'Search.htm';
		opener.document.searchStudent.actionType.value = 'search';
		opener.document.searchStudent.studentStatusId.value='0';
		opener.document.searchStudent.admissionNumber.value = "${studentId.admissionNo}";
		opener.document.searchStudent.submit();
		self.close();
	}

	function closePopup() {

		if (${successMsg == true}) {
			opener.document.searchStudent.action = 'Search.htm';
			opener.document.searchStudent.actionType.value = 'search';
			opener.document.searchStudent.studentStatusId.value='0';
			opener.document.searchStudent.admissionNumber.value = "${studentId.admissionNo}";
			opener.document.searchStudent.submit();

		}
	}

	closePopup();

	function clearAll(thisValue)
	{
		document.studentTempLeaveForm.activateDate.value = '';
		document.studentTempLeaveForm.classGradeDescription.value = '0';
		document.studentTempLeaveForm.year.value = '0';
	}


</script>
<!-- END Calender controll CSS and JS -->
</head>
<body onload="activation();">

	<div id="page_container">
		<div class="help_link">
			<a href="#"
				onclick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/activateTempLeaveHelp.html"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"><spring:message code="application.help" /> </a>
		</div>
		<br>
		<h1><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.EXTEND.TITLE" /></h1>

		<div class="area"></div>
		<div class="box_border">
		<label class="success_sign"><c:if
										test="${messages != null}">${messages}</c:if>
								</label>

			<div class="section_full_summary">
				<div class="box_border">

					<div class="float_left">
						<label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.NAME" />&nbsp;</label> ${studentId.nameWtInitials}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.GRADE" />&nbsp;</label> ${currentClassName}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.YEAR" />&nbsp;</label> ${currentYear}
					</div>
					<div class="float_left"></div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div id="content_main">
				<form:form action="#" commandName="tempLeaveListCommand"
					name="studentTempLeaveForm">

					<div class="section_box">
						<div id="search_results">
							<div class="section_box_header">
								<h2><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.DETAILS" /></h2>
								<label class="required_sign"><c:if
										test="${errorMessages != null}">${errorMessages}</c:if>
								</label> 

							</div>
							<div class="column_single">
							
								<div class="clearfix"></div>
								<div class="column_single">
									<table class="basic_grid" border="0" cellspacing="0"
										cellpadding="0">
										<tr>
											<th width="376"><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.DESCRIPTION" /></th>
											<th width="136"><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.DATE.FROM" /></th>
											<th width="136"><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.DATE.TO" /></th>
											<th width="186" class="center"><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.NO.OF.DAYS" /></th>
										</tr>

										<c:choose>
											<c:when test="${not empty tempLeaveList}">
												<c:forEach var="tempLeave" items="${tempLeaveList}"
													varStatus="status">

													<c:choose>
														<c:when test="${(status.count) % 2 == 0}">
															<tr class="odd">
														</c:when>
														<c:otherwise>
															<tr class="even">
														</c:otherwise>
													</c:choose>
													<td>${tempLeave.reason}</td>
													<td>${tempLeave.fromDate}</td>
													<td id="expire">${tempLeave.toDate}</td>
													<td class="center">${tempLeave.noOfDays}</td>
												</c:forEach>

											</c:when>
											<c:otherwise>
												<tr>
													<td>
														<h5><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.LEAVE.NO.RESULTS.FOUND" /></h5>
													</td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</c:otherwise>

										</c:choose>

									</table>
									<br>
									<table align="right">
										<tr>
											<td colspan="3"></td>
											<td><input type="button" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.STUDENT' />"
												name="activate" class="button" value="Activate" id="activate1"
												onClick="activateButton()">
											</td>
											<td><input type="button" class="button" value="Extend" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.EXTEND.TOOLTIP.STUDENT' />"
												name="extend" onClick="extendStudentTempDetails(this)">

											</td>
											<td><input type="button" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.CLOSE.TOOLTIP.STUDENT' />" class="button"
												value="Close" onclick="closePage()"></td>
										</tr>
									</table>
									<br>
								</div>
							</div>
							<div class="section_full_inside" id="activate"
								style="display: ${Errstate?'block':'none'}">
								<h3><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.TEMPORARY.LEAVE" /></h3>
								<div class="box_border">
									<div class="row">
										<div class="float_left">
											<div class="messageArea">
												<label class="required_sign"> <c:if
														test="${message != null}">${message}</c:if> </label>

												<form:errors path="activateDate" id="errormsg"
													cssClass="required_sign" /><br>
												<form:errors path="fromDate" id="errormsg"
													cssClass="required_sign" /><br>
											</div>
											<table>
												<tr>

													<td><span class="required_sign">*</span> <label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.DATE" /></label></td>
													<td><form:input id="activateDate"
															cssClass="date_field" path="activateDate" readonly="true" />
													</td>

													<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;</td>
													<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;</td>

													<td><span class="required_sign">*</span><label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.CLASS" />
															</label></td>
													<td><c:choose>
															<c:when test="${not empty classGradeList}">
																<form:select id="classGradeDescription"
																	path="classGradeDescription" cssStyle="width: 180px">
																	<option value="0">
																		<spring:message code="application.drop.down" />
																	</option>
																	<c:forEach var="classGrade" items="${classGradeList}"
																		varStatus="status">
																		<option value="${classGrade.description}"
																		<c:if test='${selectedClassGrade != null &&
								                  	classGrade.description eq selectedClassGrade}'> selected="selected"</c:if>>
																			${classGrade.description}</option>
																	</c:forEach>
																</form:select>
															</c:when>
														</c:choose></td>



													<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;</td>
													<td><span class="required_sign">*</span> <label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.YEAR" /></label></td>
													<td><c:choose>
															<c:when test="${not empty yearList}">
																<select name="year" id="year" style="width: 180px">
																	<option value="0">
																		<spring:message code="application.drop.down" />
																	</option>
																	<c:forEach var="varYear" items="${yearList}"
																		varStatus="status">
																		<option value="${varYear}"
																		<c:if test='${selectedYear != null &&
								                  	varYear eq selectedYear}'> selected="selected"</c:if>>${varYear}</option>
																	</c:forEach>
																</select>
															</c:when>
														</c:choose></td>

												</tr>
											</table>
										</div>
										<div class="buttion_bar_type1" style="margin-top: 15px;">
											<input type="button" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.STUDENT' />"
												value="Activate" onClick="activeteStudentTempDetails(this)"
												class="button"> <input type="button" class="button"
												onClick="clearAll(this)" value="Clear" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.CLEAR' />">

											<input type="button" class="button"
												onClick="clearMessages(); clearAll(this);setAddEditPane(this,'Cancel');document.getElementById('activate').style.display='none';"
												value="Cancel" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.CANCEL' />">
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="clearfix"></div>


							<div class="section_full_inside" id="extend"
								style="display: ${state?'block':'none'}">
								<h3><spring:message code="STUDENT.TEMPORARY.REJOIN.EXTEND.LEAVE.DETAILS" /></h3>
								<div class="box_border">
									<div class="row">
										<div class="float_left">
											<label class="success_sign"> <c:if
													test="${extendedMsg != null}">${extendedMsg}</c:if> </label>
                                            <br />
											<label class="required_sign"> <c:if
													test="${message != null}">${message}</c:if> </label>
											<label class="success_sign"> <c:if
													test="${Sucmessage != null}">${Sucmessage}</c:if> </label>

											<table>
												<tr>
													<td colspan="2"><span class="required_sign">*</span> <label>
															<spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.REASON" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td>
													<td><form:textarea id="reason" cols="30" rows="2"
															onkeydown="limitText(this.form.reason,this.form.countdown,100);"
															onkeyup="limitText(this.form.reason,this.form.countdown,100);"
															path="reason" readonly="readonly" disabled="true"></form:textarea>
													</td>

												</tr>
											</table>
											<table>
												<tr>
													<td colspan="2"><span class="required_sign">*</span> <label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.DATE.FROM" /></label> <form:input path="fromDate"
															id="${success?'':'fromDateId'}" cssClass="date_field"
															readonly="${success}" disabled="true" /></td>

													<td colspan="2" align="right">&nbsp;&nbsp;&nbsp;&nbsp;<span
														class="required_sign">*</span> <label><spring:message code="STUDENT.TEMPORARY.REJOIN.ACTIVATE.DATE.TO" /></label> <form:input
															path="toDate" id="toDateId" cssClass="date_field"
															readonly="true" /></td>

												</tr>
											</table>

										</div>
										<div class="clearfix"></div>
										<div class="float_right">
											<div class="buttion_bar_type1">


												<input type="button" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.SAVE' />" value="Save"
													onClick="saveExtenedStudentTempDetails(this)"
													class="button"> <input type="button" class="button"
													onClick="setAddEditPane(this,'Cancel');document.getElementById('extend').style.display='none';"
													value="Cancel" title="<spring:message code='STUDENT.TEMPORARY.REJOIN.ACTIVATE.TOOLTIP.CANCEL' />">
											</div>
										</div>

									</div>
									<div class="clearfix"></div>
								</div>

							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<input type="hidden" name="selectedStudentId"
						id="selectedStudentId" value="${studentId.studentId}" />

					<input type="hidden" name="studentClass" id="studentClass"
						value="${currentClassName}" />

					<input type="hidden" name="studentYear" id="studentYear"
						value="${currentYear}" />
				</form:form>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>

