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
<%@page import="java.util.Date"%>
<%@page import="com.virtusa.akura.util.DateUtil"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">

<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>

	var maxValEmpty = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.EMPTY' />";
	var maxValExceed = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.EXCEED' />";
	var maxValInvalidChar = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.INVALID.CHARACTER' />";
	var maxValInvalidDecimal = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.INVALID.DECIMAL' />";
	var requestProcessError = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.ERROR.PROCESS' />";
	var inprogressLeave = "<spring:message code='STAFF.LEAVE.LEAVE.MAXVALUE.INPROGRESS.LEAVE' />"
	var notApplicableText = "<spring:message code='STAFF.LEAVE.VALUE.NOT.APPLICABLE' />"
	var leaveFromDate = null;
	var leaveToDate = null;
	$(function() {
		
		$("#select").change(function() {
			var selectedStaffLeavetypeId = $("#select").val();
			if(selectedStaffLeavetypeId == ''){
				$('#holidayNote').html('');
			}
			else{
				if((selectedStaffLeavetypeId == 6) || (selectedStaffLeavetypeId == 7)){			
					$('#holidayNote').html('<p>*Leaves are calculated including holidays.</p>');
				}else{
					$('#holidayNote').html('<p>*Leaves are calculated excluding holidays.</p>');
				}
			}
			});
		
					
		var date = new Date();
		var currentMonth = date.getMonth() + 1;
		var currentDate = date.getDate();
		var datee = $("#SelectedYear option:selected").text();
		var setdate = ""+datee+"-"+currentMonth+"-"+currentDate;
		var parsedDate = $.datepicker.parseDate('yy-mm-dd', setdate);
		
		leaveFromDate = $("#leaveFromDate").datepicker(
				{
					defaultDate : parsedDate,  
					yearRange : datee+':0',
					changeYear : true,
					changeMonth : true,
					numberOfMonths : 1,
					dateFormat : 'yy-mm-dd',
					showOn : "button",
					buttonImage : "resources/images/calendar.jpg",
					buttonImageOnly : true,
					onClose: function( selectedDate ) {						
						 $( "#leaveToDate" ).datepicker( "option", "minDate", selectedDate );						 
					}
				});

		leaveToDate = $("#leaveToDate").datepicker(
				{
					defaultDate : parsedDate,  
					yearRange : datee+':0',
					changeYear : true,
					changeMonth : true,
					numberOfMonths : 1,
					dateFormat : 'yy-mm-dd',
					showOn : "button",
					buttonImage : "resources/images/calendar.jpg",
					buttonImageOnly : true,
					onClose: function( selectedDate ) {
						 $( "#leaveFromDate" ).datepicker( "option", "maxDate", selectedDate );
					}
					
				});
	});
	
	function clearDateValues(){
		leaveFromDate.datepicker( "option" , {
		    minDate: null,
		    maxDate: null} );
		leaveToDate.datepicker( "option" , {
		    minDate: null,
		    maxDate: null} );
	}
</script>
<!-- END Calender controll CSS and JS -->

<script type="text/javascript">

	var date = new Date();
	var currentMonth = date.getMonth() + 1;
	var currentDate = date.getDate();
	var datee = date.getFullYear();
	var setdate = datee + "-" + currentMonth + "-" + currentDate;
	var staffLeaveMaxNumber = {};
	<c:forEach items="${staffLeaveTypeList}" var="leaveType">
		staffLeaveMaxNumber[${leaveType.staffLeaveTypeId}] = ${leaveType.maxStaffLeaves};		
	</c:forEach>

	function addNew(thisValue) {

		setAddEditPane(thisValue, 'Add');
		$('#saveAction').val('saveOrUpdateStaffLeave.htm');
		if (document.staffLeaveForm.reason.value != '') {
			document.staffLeaveForm.reason.value = '';
		}
		if (document.staffLeaveForm.fromDate.value != '') {
			document.staffLeaveForm.fromDate.value = '';
		}
		if (document.staffLeaveForm.toDate.value != '') {
			document.staffLeaveForm.toDate.value = '';
		}
		document.staffLeaveForm.staffLeaveId.value = 0;
		document.staffLeaveForm.select.value = '';
		document.staffLeaveForm.noOfDays.value = 0;
		document.staffLeaveForm.DayType.value = '';
		document.staffLeaveForm.staffId.value = 0;
		document.staffLeaveForm.staffLeaveStatusId.value = '';
		document.staffLeaveForm.appliedDate.value = setdate;
		document.staffLeaveForm.approvedRejectedDate.value = setdate;
		document.getElementById("userLoginId").value = '';
		document.staffLeaveForm.comment.value = '';
	}

	function saveStaffLeave(thisValue) {
		
		var okfunction = function(){
			setAddEditPane(thisValue, 'Save');
			var year = document.getElementById("SelectedYear").value;
			var actionURL = 'saveOrUpdateStaffLeave.htm';
			document.staffLeaveForm.action = actionURL+"?SelectedYear="
					+ year;
			document.staffLeaveForm.submit();
		};
		
		var cancelfunction = function(){
			
			clearDateValues();
		};
		
		var message = "<spring:message code='STAFF.LEAVE.CONFIRMATION'/>";
		
		confirm_function(message, okfunction, cancelfunction);
	
	}

		
	
	function cancelApprovedLeave(thisValue, staffLeaveId) {
		
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.staffLeaveForm.staffLeaveId.value = staffLeaveId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			var year = document.getElementById("SelectedYear").value;
			var actionURL = 'cancelApprovedStaffLeave.htm';			
			document.staffLeaveForm.action = actionURL+"?SelectedYear="
					+ year;
			document.staffLeaveForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = "<spring:message code='REF.APPROVE.CANCEL.CONFIRMATION'/>";
		
		confirm_function(message, okfunction, cancelfunction);			
		
	}
		
	function cancelCancelInProgressLeave(thisValue, staffLeaveId) {
				
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.staffLeaveForm.staffLeaveId.value = staffLeaveId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			var year = document.getElementById("SelectedYear").value;
			var actionURL = 'cancelCancelInProgressStaffLeave.htm';	
			document.staffLeaveForm.action = actionURL+"?SelectedYear="
					+ year;
			document.staffLeaveForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = "<spring:message code='REF.APPROVE.CANCEL.CANCEL.CONFIRMATION'/>";
		
		confirm_function(message, okfunction, cancelfunction);	
		
	}
	
	function updateStaffLeave(thisValue, staffLeaveId, reason, fromDate,
			toDate, staffLeaveTypeId, noOfDays, dateType, staffId,
			staffLeaveStatusId, appliedDate, approvedRejectedDate, userLogin,
			comment) {
		setAddEditPane(thisValue, 'Edit');
		
		setFormValues(staffLeaveId, reason, fromDate,
				toDate, staffLeaveTypeId, noOfDays, dateType, staffId,
				staffLeaveStatusId, appliedDate, approvedRejectedDate, userLogin,
				comment);
	}

	function setFormValues(staffLeaveId, reason, fromDate,
			toDate, staffLeaveTypeId, noOfDays, dateType, staffId,
			staffLeaveStatusId, appliedDate, approvedRejectedDate, userLogin,
			comment){
		
		document.staffLeaveForm.staffLeaveId.value = staffLeaveId;
		document.staffLeaveForm.reason.value = reason;
		document.staffLeaveForm.fromDate.value = fromDate;
		document.staffLeaveForm.toDate.value = toDate;
		document.staffLeaveForm.select.value = staffLeaveTypeId;
		document.staffLeaveForm.noOfDays.value = noOfDays;
		document.staffLeaveForm.DayType.value = dateType;
		document.staffLeaveForm.staffId.value = staffId;
		document.staffLeaveForm.staffLeaveStatusId.value = staffLeaveStatusId;
		document.staffLeaveForm.appliedDate.value = appliedDate;
		document.getElementById("userLoginId").value = userLogin;
		document.staffLeaveForm.comment.value = comment;
		if (approvedRejectedDate.length != 0) {
			document.staffLeaveForm.approvedRejectedDate.value = approvedRejectedDate;
		} else {
			document.staffLeaveForm.approvedRejectedDate.value = setdate;
		}
	}
	
	function deleteStaffLeave(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.staffLeaveForm.staffLeaveId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			var year = document.getElementById("SelectedYear").value;
			document.staffLeaveForm.action = "deleteStaffLeave.htm?SelectedYear="
					+ year;
			document.staffLeaveForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = "<spring:message code='REF.DELETE.CONFIRMATION'/>";
		
		confirm_function(message, okfunction, cancelfunction);
	}

	function changeFunc(thisVal) {

		document.staffLeavePerYearForm.submit();
	}

	function showArea() {
		$(document).ready(function() {
			$("#errorMessage").hide();
		});
	}
	
	function changeToEdit(thisVal, leaveId, minVal){
		clearStatusMessages();		
		var parentClass = thisVal.parentNode.parentNode;		
		var maxLeaveClass = parentClass.getElementsByClassName('maxLeaveLabel')[0];
		var inputTextBox = parentClass.getElementsByClassName('maxleaveText')[0]; 		
		inputTextBox.value = maxLeaveClass.innerHTML.trim() ;
		maxLeaveClass.style.display = "none";
		inputTextBox.style.display = "table-cell";
		thisVal.style.display = "none";
		parentClass.getElementsByClassName('saveImg')[0].style.display	= "inline-block";
		parentClass.getElementsByClassName('cancelImg')[0].style.display	= "inline-block";
	//	maxLeaveClass.innerHTML = "<input type='text' name='MaxLeaves' class = 'maxleaveText' width = 40px >";
		
	}
	
	function isNumber(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
	function CancelEdit(thisVal){
		clearStatusMessages();
		var parentClass = thisVal.parentNode.parentNode;
		var maxLeaveClass = parentClass.getElementsByClassName('maxLeaveLabel')[0];
		var inputTextBox = parentClass.getElementsByClassName('maxleaveText')[0];
		inputTextBox.style.display = "none";
		parentClass.getElementsByClassName('saveImg')[0].style.display	= "none";
		parentClass.getElementsByClassName('cancelImg')[0].style.display	= "none";
		parentClass.getElementsByClassName('editImg')[0].style.display	= "inline-block";
		maxLeaveClass.style.display = "initial";
	}
	
	function clearStatusMessages(){
		var statusLabel = document.getElementById('errorMessageForEditMax');
		var successLabel = statusLabel.getElementsByClassName('success_sign')[0];
		var errorLabel = statusLabel.getElementsByClassName('required_sign')[0];
		successLabel.style.display = "none";
		errorLabel.style.display = "none";
	}
	
	function printErrorMessageLeaveType(message, inputClass){
		var statusLabel = document.getElementById('errorMessageForEditMax');
		var errorLabel = statusLabel.getElementsByClassName('required_sign')[0];
		errorLabel.innerHTML = message;
		errorLabel.style.display = 'initial';
    	if(!!inputClass)
			inputClass.select();
	}
		
	function SaveEdit(thisVal, leaveTypeId, utilizedLeaves){
		clearStatusMessages();
		var statusLabel = document.getElementById('errorMessageForEditMax');
		var successLabel = statusLabel.getElementsByClassName('success_sign')[0];
		var errorLabel = statusLabel.getElementsByClassName('required_sign')[0];
		var parentClass = thisVal.parentNode.parentNode;
		var maxLeaveClass = parentClass.getElementsByClassName('maxLeaveLabel')[0];
		var inputClass = parentClass.getElementsByClassName('maxleaveText')[0];
		var availableLvLbl = parentClass.getElementsByClassName('availableLeave')[0];		
		
		var insertedValue = inputClass.value.trim();		
		var errorStr = "";
		var year = document.getElementById("SelectedYear").value;
		var inputNum;		
		
		if(insertedValue == ""){
			printErrorMessageLeaveType(maxValEmpty,inputClass);
			return;
		}			
		
	    if(isNumber(insertedValue)){
	    	var decimalPattern = new RegExp("^([0-9]+([.][5]|[.][0])?)$");
	    	if(decimalPattern.test(insertedValue)){
		    	inputNum = +insertedValue;
		    	
		    	if(inputNum <= +staffLeaveMaxNumber[leaveTypeId] && inputNum >= utilizedLeaves){	    		
		    		hasError = false;
					var url = '<c:url value="/modifyStaffLeaveTypeMax.htm" />';
			
					$.ajax({
						url : url,
						data : ({
							'staffLeaveTypeId' : leaveTypeId,
							'modifiedMaxleaveValue' : inputNum,
							'SelectedYear': year
						}),
						success : function(response) {						
							if(response.indexOf("Success") > -1){							
								successLabel.innerHTML = "SuccessFully Saved!!";
								maxLeaveClass.innerHTML = (+inputNum).toFixed(1);
								availableLvLbl.innerHTML = ((+inputNum) - (+utilizedLeaves)).toFixed(1);
								successLabel.style.display = "initial";
								successLabel.hidden = false;
								inputClass.style.display = "none";
								maxLeaveClass.style.display = "initial";							
								parentClass.getElementsByClassName('saveImg')[0].style.display	= "none";
								parentClass.getElementsByClassName('cancelImg')[0].style.display	= "none";
								parentClass.getElementsByClassName('editImg')[0].style.display	= "inline-block";
							}
							else{								
								printErrorMessageLeaveType(response, inputClass);
							}
						}
					});
			    }
		    	else
		    		printErrorMessageLeaveType(maxValExceed, inputClass);
	    	}
	    	else 
	    		printErrorMessageLeaveType(maxValInvalidDecimal, inputClass);
	    }
	    else{
	    	printErrorMessageLeaveType(maxValInvalidChar, inputClass);
	    }
	    
	    
	}
	
</script>
 
<!--<jsp:useBean id="now" class="java.util.Date" />-->
<!-- Get the current Date and set to a variable now -->
<c:set var="now" value="<%=new Date()%>" />
<!-- Get the formatted date of the current date -->
<fmt:formatDate var="currentDate" value="${now}" pattern="yyyy-MM-dd" />

</head>
<body>
	<h:headerNew parentTabId="2" page="staffLeave.htm" />

	<div id="page_container">

		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<sec:authorize access="hasRole('Search Staff Members')">
						<li><a href="staffSearch.htm"><spring:message code="staff.leave.staffSearch"/></a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="staff.leave.title"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/staffLeaveHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="staff.leave.title"/></h1>
		<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="staff.leave.name"/>&nbsp;</label> ${staff.nameWithIntials}
					</div>
					<div class="float_left">
						<label><spring:message code="staff.leave.regNo"/>&nbsp;</label> ${staff.registrationNo}
					</div>
					<div class="clearfix"></div>
				</div>
			</div>

<!-- Form to select the year -->
			<form action="staffLeave.htm" method="GET" name="staffLeavePerYearForm">
				<input type="hidden" name="selectedYear" />
				<div class="section_full">
					<div class="row">
						<div class="float_left">
							<div class="lbl_lock">
								<label><spring:message code="STAFF.LEAVE.SELECT.YEAR"/>:</label> 
								<select name="SelectedYear" onchange="changeFunc(this);" id="SelectedYear">
									<c:forEach items="${yearList}" var="year">
										<c:choose>
											<c:when test="${year == SelectedYear}">
												<option selected="selected" value="${year}">${year}</option>
											</c:when>
											<c:otherwise>
												<option value="${year}">${year}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</form>
			<!-- Form abount staff leave details -->
			<form:form action="" method="POST" commandName="staffLeave"
				name="staffLeaveForm">
				<form:hidden path="staffLeaveId" />
				<c:set var="role_admin" value="false"></c:set>
				<c:choose>
					<c:when test="${user.role eq 'ROLE_ADMIN'}">
						<c:set var="role_admin" value="true"></c:set>
					</c:when>
				</c:choose>
				<div class="clearfix"></div>
				<div class="section_box">
				
				<div class="section_box_header">
          			<h2><spring:message code="STAFF.LEAVE.INFORMATION.TITLE"/>
							<%
          			    if (request.getParameter("SelectedYear") == null) {
          			            out.print(DateUtil.getStringYear(new Date()));
          			        } else {
          			            out.print(request.getParameter("SelectedYear").toString());
          			        }
          			%></h2>
        		</div>
        		<div class="error" id="errorMessageForEditMax" style = "height : 7px;">
						<label class="success_sign" hidden = "true"></label> 
						<label class="required_sign" hidden = "true"></label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th width="376"><spring:message code="STAFF.LEAVE.STAFFLEAVETYPE"/></th>
								<th width="136" class="center"><spring:message code="STAFF.LEAVE.MAXNOOFDAYS"/></th>
								<th width="136" class="center"><spring:message code="STAFF.LEAVE.UTILIZED"/></th>
								<th width="186" class="center"><spring:message code="STAFF.LEAVE.AVAILABLE"/></th>
								<th width="40" class="center"></th>
							</tr>
							<c:choose>
								<c:when test="${not empty staffLeaveTypeInfoList}">
									<c:forEach items="${staffLeaveTypeInfoList}" var="leaveTypeInfo"
										varStatus="status">
										<tr 
											<c:choose>
		            							<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            							<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            						</c:choose>>
		            						<c:set var = "isEditable" value = "false" />
		            						<c:if test="${leaveTypeInfo[2] ne -1}">
		            							<c:set var = "isEditable" value = "true" />
		            						</c:if>
											<td>${leaveTypeInfo[1]}</td>
											<td class="center maxLeave" >
												<label style = "font-weight: normal" class = "maxLeaveLabel">
													<c:choose>
														<c:when test="${isEditable}"> 
															${leaveTypeInfo[2]}
														</c:when>
														<c:otherwise>
															<spring:message code='STAFF.LEAVE.VALUE.NOT.APPLICABLE' />
														</c:otherwise>
													</c:choose>
												</label>
												<input type='text' class = 'maxleaveText' style = 'display:none'>
											</td>											
											<td class="center">${leaveTypeInfo[3]}</td>
											<td class="center availableLeave">
												<label style = "font-weight: normal" class = "maxLeaveLabel">
													<c:choose>
														<c:when test="${isEditable}"> 
															${leaveTypeInfo[4]}
														</c:when>
														<c:otherwise>
															<spring:message code='STAFF.LEAVE.VALUE.NOT.APPLICABLE' />
														</c:otherwise>
													</c:choose>
												</label>
											</td>
											<c:set var="editFunction" value=""/>
											<c:choose>											
												<c:when test="${not empty staffLeaveList}">
													<c:forEach items="${staffLeaveList}" var="staffLeaveObj" >
														<c:if test="${empty editFunction}">
															<c:if test="${staffLeaveObj.staffLeaveTypeId eq leaveTypeInfo[0]}">
																<c:set var= "editFunction" value = "custom_alert(inprogressLeave)"/>																
															</c:if>
														</c:if>
													</c:forEach>
												</c:when>
											</c:choose>
											<c:if test="${empty editFunction }">
												<c:set var= "editFunction" value = "changeToEdit(this, ${leaveTypeInfo[0]})"/>
											</c:if>
											<td class = "editLeave">
											<sec:authorize access="hasRole('Add/Edit Staff Leave Type')">
												<c:if test="${isEditable}">
													<img src="resources/images/ico_edit.gif" class = 'editImg' title ="Edit Leave" onclick = "${editFunction}"><img src='resources/images/save.png' class = 'saveImg' + title = 'Save' align = 'left' onclick='SaveEdit(this, ${leaveTypeInfo[0]}, ${leaveTypeInfo[3]})' style = 'display:none'><img src='resources/images/cancel.png' class = 'cancelImg' align='right'  title = 'Cancel' onclick='CancelEdit(this)' style = 'display:none'>												
												</c:if>	
											</sec:authorize>												
											</td>	
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td><h5><spring:message code="staff.leave.noStasffLeave_found"/></h5></td>
										<td></td>
										<td></td>
										<td></td>
										<td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="section_box_header">
						<h2><spring:message code="staff.leave.title"/> 
						<%
          			    if (request.getParameter("SelectedYear") == null) {
          			            out.print(DateUtil.getStringYear(new Date()));
          			        } else {
          			            out.print(request.getParameter("SelectedYear").toString());
          			        }
          			%></h2>
					</div>
					
					<div class="error" id="errorMessage">
						<label class="success_sign"> <c:if
								test="${successMessage != null}">
								<c:out value="${successMessage}" escapeXml="false" />
						</c:if></label> 
						<label class="required_sign"> <c:if
								test="${message != null}">${message}</c:if>
								<form:errors path="staffLeaveId" /><br>
								<form:errors path="reason" />
						</label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>

								<th width="18%"><spring:message code="staff.leave.description"/></th>
								<th width="12%"><spring:message code="staff.leave.dateFrom"/></th>
								<th width="12%"><spring:message code="staff.leave.dateTo"/></th>
								<th width="15%" class="center"><spring:message code="STAFF.LEAVE.STAFFLEAVETYPE"/></th>
								<th width="5%" class="center"><spring:message code="staff.leave.noOfDays"/></th>
								<th width="8%" class="center"><spring:message code="STAFF.LEAVE.DATE.TYPE"/></th>
								<th width="10%" class="center"><spring:message code="STAFF.LEAVE.APPROVAL.STATUS"/></th>
								<th width="15%" class="center"><spring:message code="STAFF.LEAVE.APPROVED.REJECTED"/></th>
								<th width="74" align="right" class="right">
								<c:if test="${(isViewOnly ne true) && (departureDate == null) && (currentYear != null)}">
								<sec:authorize access="hasAnyRole('Add Staff Leave')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="addNew(this),showArea()" width="18" height="20"
											title="<spring:message code='staff.leave.addNewLeave'/>">
								</sec:authorize>
								</c:if>
								</th>
							</tr>
							<c:choose>
								<c:when test="${not empty staffLeaveList}">
									<c:forEach items="${staffLeaveList}" var="staffLeaveObj"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
											<td>${staffLeaveObj.reason}</td>
											<td>${staffLeaveObj.fromDate}</td>
											<td>${staffLeaveObj.toDate}</td>
											<td class="center">
											<c:choose>
		            							<c:when test="${not empty staffLeaveTypeList}">
		            								<c:forEach items="${staffLeaveTypeList}" var="staffLeaveTypeObj" varStatus="status">
		            									<c:if test="${staffLeaveObj.staffLeaveTypeId eq staffLeaveTypeObj.staffLeaveTypeId}">
		            										${staffLeaveTypeObj.description }
		            									</c:if>
		            								</c:forEach>
		            							</c:when>
		            						</c:choose></td>
		            						
											<td class="center">${staffLeaveObj.noOfDays}</td>
											<td class="center">${staffLeaveObj.dateType}</td>
											<c:set var="isInProgress" value="false"></c:set>
											<c:set var="isApproved" value="false"></c:set>
											<c:set var="isCancelInprogress" value="false"></c:set>
											<c:if test="${staffLeaveObj.staffLeaveStatusId eq 1}">
													<td class="center"><c:out value="Approved"></c:out></td>
													<c:set var="isApproved" value="true"></c:set>													
		            						</c:if>
		            						<c:if test="${staffLeaveObj.staffLeaveStatusId eq 2}">
													<td class="center"><c:out value="Rejected"></c:out></td>													
		            						</c:if>
		            						<c:if test="${staffLeaveObj.staffLeaveStatusId eq 3}">
													<td class="center"><c:out value="In Progress"></c:out></td>
													<c:set var="isInProgress" value="true"></c:set>
		            						</c:if>
		            						<c:if test="${staffLeaveObj.staffLeaveStatusId eq 4}">
													<td class="center"><c:out value="Cancel Approved"></c:out></td>													
		            						</c:if>
		            						<c:if test="${staffLeaveObj.staffLeaveStatusId eq 5}">
													<td class="center"><c:out value="Cancel Reject"></c:out></td>													
		            						</c:if>
		            						<c:if test="${staffLeaveObj.staffLeaveStatusId eq 6}">
													<td class="center"><c:out value="Cancel In Progress"></c:out></td>
													<c:set var="isCancelInprogress" value="true"></c:set>
		            						</c:if>

											<td class="center">${staffLeaveObj.userLogin.firstName} ${staffLeaveObj.userLogin.lastName}</td>
											<td nowrap class="right">
											<c:if test="${(isViewOnly ne true) || (departureDate == null) || (role_admin)}">
											<sec:authorize access="hasAnyRole('Edit Staff Leave')">
												<c:if test="${(isInProgress)}">
													<img src="resources/images/ico_edit.gif"
														onClick="updateStaffLeave(this, '<c:out value="${staffLeaveObj.staffLeaveId}"/>', '<c:out value="${strEscapeUtil:escapeJS(staffLeaveObj.reason)}"/>', '<c:out value="${staffLeaveObj.fromDate}"/>', '<c:out value="${staffLeaveObj.toDate}"/>', '<c:out value="${staffLeaveObj.staffLeaveTypeId}"/>', '<c:out value="${staffLeaveObj.noOfDays}"/>', '<c:out value="${staffLeaveObj.dateType}"/>',
														'<c:out value="${staffLeaveObj.staffId}"/>', '<c:out value="${staffLeaveObj.staffLeaveStatusId}"/>', '<c:out value="${staffLeaveObj.appliedDate}"/>', '<c:out value="${staffLeaveObj.approvedRejectedDate}"/>', '<c:out value="${staffLeaveObj.userLogin.userLoginId}"/>', '<c:out value="${staffLeaveObj.comment}"/>',showArea());"
														title="<spring:message code='staff.leave.editNewLeave'/>" width="18" height="20" class="icon">
												</c:if>
												<c:if test="${(isApproved)}">
													<img src="resources/images/ico_cancel.jpg"
														onClick="cancelApprovedLeave(this, '<c:out value="${staffLeaveObj.staffLeaveId}"/>');showArea();"
														title="<spring:message code='staff.leave.cancelAppeovedLeave'/>" width="18" height="20" class="icon">
												</c:if>
												<c:if test="${(isCancelInprogress)}">
															<img src="resources/images/ico_cancel.jpg"
																onClick="cancelCancelInProgressLeave(this, '<c:out value="${staffLeaveObj.staffLeaveId}"/>');showArea();"
																title="<spring:message code='staff.leave.cancelCancelInprogressLeave'/>"
																width="18" height="20" class="icon">
														</c:if>
											</sec:authorize>
											<sec:authorize access="hasAnyRole('Delete Staff Leave')">
												<c:if test="${(isInProgress)}">
													<img src="resources/images/ico_delete.gif"
														onClick="deleteStaffLeave(this, '<c:out value="${staffLeaveObj.staffLeaveId}"/>');showArea();"
														title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20" class="icon" >
												</c:if>
											</sec:authorize></c:if>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td><h5><spring:message code="staff.leave.noStasffLeave_found"/></h5></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<spring:bind path="staffLeave.*">
						<c:set var="status" value="${status}"></c:set>
					</spring:bind>
					<div class="section_full_inside" style="display: ${(message != null or not empty status.errorMessages) and successMessage == null?'block':'none'};">
						<h3><spring:message code="staff.leave.addNewLeave"/></h3>
						<form:hidden path="noOfDays" />
						<form:hidden path="staffLeaveStatusId" />
						<form:hidden path="appliedDate" />
						<input type="hidden" id="userLoginId" name="userLoginId"/>
						<form:hidden path="comment" />
						<form:hidden path="staffId" />
						<form:hidden path="approvedRejectedDate" />
						
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="staff.leave.description"/> :</label>
									</div>
									<form:textarea path="reason" maxlength="150"/>
								</div>
								<div class="float_right"
									style="margin-right: 50px; *margin-right: 10px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="staff.leave.dateTo"/> :</label>
									</div>
									<spring:message code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT' var="dateOfFormat"/>
									<form:input path="toDate" id="leaveToDate" readonly="true" cssClass="date_field" title="${dateOfFormat}"/>
								</div>
								<div class="float_right" style="margin-right: 50px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="staff.leave.dateFrom"/> :</label>
									</div>
									<spring:message code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT' var="dateOfFormat"/>
									<form:input path="fromDate" id="leaveFromDate" readonly="true" cssClass="date_field" title="${dateOfFormat}"/>
								</div>
							</div>
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="STAFF.LEAVE.STAFFLEAVETYPE"/>:</label>
									</div>
									<form:select id="select" path="staffLeaveTypeId">
										<option value="" id="selectOption">
											<spring:message code="application.drop.down" />
										</option>
										<form:options itemLabel="description" items="${staffLeaveTypeList}"
											itemValue="staffLeaveTypeId" />
									</form:select>
								</div>
								<div class="float_right" style="margin-right: 75px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="STAFF.LEAVE.DATE.TYPE"/> :</label>
									</div>
									<div class="frmvalue">
										<form:select path="dateType" name="DayType" id="DayType"
											style="margin-right: 80px; width: 200px">
											<option selected value=""><spring:message code="application.drop.down" /></option>
											<form:option value="Full Day"><spring:message code="STAFF.LEAVE.FULL.DAY" /></form:option>
											<form:option value="Half Day"><spring:message code="STAFF.LEAVE.HALF.DAY" /></form:option>
										</form:select>
									</div>
								</div>
							</div>
							<div class="row">
								<div id='holidayNote'></div>
								<div class="buttion_bar_type1">
								<c:if test="${isViewOnly ne true}">
								<sec:authorize access="hasAnyRole('Add Staff Leave','Edit Staff Leave')">
									<input id="saveAction" type="hidden" value=""/>
									<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
										onClick="saveStaffLeave(this);showArea()" class="button"><input
										type="button" class="button"
										onClick="clearDateValues();setAddEditPane(this,'Cancel');showArea();" value="<spring:message code='REF.UI.CANCEL'/>">
								</sec:authorize>
								</c:if>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="section_box">
					<div class="clearfix"></div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
