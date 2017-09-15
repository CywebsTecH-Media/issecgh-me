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

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
	$(function() {
		
		var date = new Date();
		var currentMonth = date.getMonth() + 1;
		var currentDate = date.getDate();
		var datee = $("#selectedYear option:selected").text();
		var setdate = ""+datee+"-"+currentMonth+"-"+currentDate;
		var parsedDate = $.datepicker.parseDate('yy-mm-dd', setdate);
		
		var dates = $("#StartDate, #EndDate").datepicker(
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
					onSelect : function(selectedDate) {
						var option = this.id == "StartDate" ? "minDate"
								: "maxDate", instance = $(this).data(
								"datepicker"), date = $.datepicker.parseDate(
								instance.settings.dateFormat
										|| $.datepicker._defaults.dateFormat,
								selectedDate, instance.settings);
						dates.not(this).datepicker("option", option, date);
					}
				});
	});
</script>
<!-- END Calender controll CSS and JS -->
	
<script type="text/javascript">
	
	var datee = new Date();
	var currentMonth = datee.getMonth();
	var currentDate = datee.getDate();
	var currentYear = datee.getFullYear();
	$(function() {

		var date = $("#selectedYear option:selected").text();

		$("#StartDate").datepicker("option", 'minDate',new Date(date, 1 - 1, 1) );
	});

	$(function() {

		var date = $("#selectedYear option:selected").text();

		$("#EndDate").datepicker("option", 'minDate',new Date(currentYear, currentMonth, currentDate) );
	});

	function populate(thisValue) {

		document.yearForm.action = "populateHolidayData.htm";
		if (thisValue != "") {
			document.yearForm.submit();
		}
	}

	function addNewHoliday(thisValue) {

		setAddEditPane(thisValue, 'Add');
		$("#StartDate").datepicker("enable");
		var date = $("#selectedYear option:selected").text();
		$("#StartDate").datepicker("option", 'minDate',new Date(date, 1 - 1, 1) );
		//$("#EndDate").datepicker("option", 'minDate',new Date(currentYear, currentMonth, currentDate) );
		document.holidayForm.description.value = '';
		document.holidayForm.startDate.value = '';
		document.holidayForm.endDate.value = '';
		document.holidayForm.holidayId.value = 0;
		document.holidayForm.selectedYear.value = selectedYear;
	}
	var oldDescription, oldStartDate, oldEndDate;
	function editHoliday(thisValue, selectedValue, description, startDate,
			endDate, currentDatee) {
		oldDescription= description;
		oldStartDate= startDate;
		oldEndDate= endDate;
		setAddEditPane(thisValue, 'Edit');
		var date = $("#selectedYear option:selected").text();
		//$("#StartDate").datepicker("option", 'minDate',new Date(currentYear, currentMonth, currentDate) );
		$("#StartDate").datepicker("enable");

		document.holidayForm.description.value = description;
		document.holidayForm.startDate.value = startDate;
		document.holidayForm.endDate.value = endDate;
		document.holidayForm.holidayId.value = selectedValue;
		document.holidayForm.selectedYear.value = selectedYear;
		if (startDate < currentDatee && endDate > currentDatee) {

			$("#StartDate").datepicker("disable");
		}
	}
	function deleteHoliday(thisValue, selectedValue, startDate, endDate) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.holidayForm.holidayId.value = selectedValue;
			document.holidayForm.selectedYear.value = selectedYear;
			document.holidayForm.startDate.value = startDate;
			document.holidayForm.endDate.value = endDate;
			document.holidayForm.action = "manageDeleteHoliday.htm";
			document.holidayForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );

	}
	function saveHoliday(thisValue) {
		var newDescription= document.getElementById("inputDescription").value; 
		var newStartDate= document.getElementById("StartDate").value;
		var newEndDate= document.getElementById("EndDate").value;
		//setAddEditPane(thisValue, 'Save');

		if (selectedYear == undefined) {
			selectedYear = new Date().getFullYear();
		}
		
		if(oldDescription == newDescription && oldStartDate == newStartDate && oldEndDate == newEndDate){
			$(".areaBot").show();
			document.querySelectorAll('.areaBot')[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
			}
		else{
			document.holidayForm.selectedYear.value = selectedYear;
			document.holidayForm.action = "saveOrUpdateHoliday.htm?startDate="+document.holidayForm.startDate.value;
			document.holidayForm.submit();	
		}
	}



	function showArea(){
		   $(document).ready(function() {
				$(".area").hide();
				$(".areaBot").hide();
			});
	   }

	function showDown(bool){			
		var name = '${showEditSection != null}';
		if(bool){
		$(document).ready(function() {
		if(!name){								
	        $(".section_full_inside").hide();			 
		}
		else{			
		$(".section_full_inside").show();
		var position = $(".section_full_inside").position();			
		scroll(0,position.top);	
		}
		});
		}
		else{
		var position = $(".section_full_inside").position();			
		scroll(0,position.top);	
		}
		}
</script>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="CurrentYear" value="${now}" pattern="yyyy" />

<!-- Get the current Date and set to a variable now -->
<c:set var="nowDate" value="${now}" />
<!-- Get the formatted date of the current date -->
<fmt:formatDate var="currentDate" value="${nowDate}" pattern="yyyy-MM-dd" />

</head>
<body onload="showDown(false);">
	<h:headerNew parentTabId="26" page="referenceModule.htm" />
	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.CALENDER.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageCalendarHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"><spring:message code="REF.UI.HELP"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.CALENDER.TITLE"/></h1>
		<div id="content_main">
			<form action="" method="POST" name="yearForm">
				<div class="section_full">
			<sec:authorize access="hasRole('Search Manage Calendar')">
					<div class="row">
						<label><strong><spring:message code="REF.UI.CALENDER.YEAR"/>:</strong> </label> <select
							name="selectedYear" onchange="populate(this)" id="selectedYear">
							<c:forEach var="i" begin="0" end="1" step="1" varStatus="loop">
								<c:choose>
									<c:when test="${selectedYr eq CurrentYear+i}">
										<option value="${CurrentYear+i}" selected="selected">${CurrentYear+i}</option>
									</c:when>
									<c:otherwise>
										<option value="${CurrentYear+i}">${CurrentYear+i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</sec:authorize>
				</div>
			</form>

			<form:form action="" method="POST" commandName="holiday"
				name="holidayForm">
				<form:hidden path="holidayId" />
				<input type="hidden" name="selectedYear" />
				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.CALENDER.DETAIL"/></h2>
						</div>


						<div>
							<div class="area">
								<div>
								<!-- update success message comes through query string (after redirecting) -->
								<label class="success_sign"> ${addEditDelete}</label>
								</div>
							</div>
							<div class="column_single">
								<table class="basic_grid" border="0" cellspacing="0"
									cellpadding="0">
									<tr>
										<th width="184"><spring:message code="REF.UI.HOLIDAY.START_DATE"/></th>
										<th width="198"><spring:message code="REF.UI.HOLIDAY.END_DATE"/></th>
										<th width="198"><spring:message code="REF.UI.HOLIDAY.REASON"/></th>
										<th width="55" align="right" class="right"><sec:authorize access="hasRole('Save/Update Manage Calendar')"><img
											src="resources/images/ico_new.gif" class="icon_new"
											onClick="showDown(true),showArea();addNewHoliday(this)" width="18" height="20"
											title="<spring:message code="REF.UI.HOLIDAY.SUB_FORM.TITLE"/>"></sec:authorize></th>

									</tr>
									<c:choose>
										<c:when test="${not empty holidayList}">
											<c:forEach items="${holidayList}" var="holiday"
												varStatus="status">
												<tr <c:if test="${selectedObj != null && (selectedObj.holidayId == holiday.holidayId)}">class="highlight"</c:if>
													<c:choose>
			            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
			            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
			            	</c:choose>>
			            							<c:set var="temp" value="false"></c:set>
													<td>${holiday.startDate}</td>
													<td>${holiday.endDate}</td>
													<td>${holiday.description}</td>
													<c:if test="${(holiday.endDate > currentDate) || (holiday.endDate eq currentDate)}">
														<c:set var="temp" value="true"></c:set>
													</c:if>
													<td nowrap class="right">
													<c:if test="${temp}">
													<sec:authorize access="hasRole('Save/Update Manage Calendar')">
													<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.HOLIDAY.IMAGE.EDIT"/>"
														onClick="showDown(true),showArea();editHoliday(this,'<c:out value="${holiday.holidayId}" />','<c:out value="${strEscapeUtil:escapeJS(holiday.description)}" />'
														,'<c:out value="${holiday.startDate}" />','<c:out value="${holiday.endDate}" />', '<c:out value="${currentDate}" />')" width="18" height="20" class="icon">
													</sec:authorize>
													<sec:authorize access="hasRole('Delete Manage Calendar')">
													<img src="resources/images/ico_delete.gif"
														onClick="showArea();deleteHoliday(this,'<c:out value="${holiday.holidayId}" />','<c:out value="${holiday.startDate}" />','<c:out value="${holiday.endDate}" />')"
														title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
													</sec:authorize>
													</c:if>
													</td>
												</tr>

											</c:forEach>


										</c:when>
										<c:otherwise>
											<tr>
												<td><h5><spring:message code="REF.UI.HOLIDAY.EMPTY"/></h5>
												</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>

										</c:otherwise>
									</c:choose>


								</table>
							</div>
						</div>
							<c:if test="${message != null}">
								<div class = "area">
									<label class="required_sign">${message}</label>
								</div>
							</c:if>

							<div class="areaBot">
								<form:errors path="holidayId" id="errormsg"
									class="required_sign" />
							</div>
							<div>
								<form:errors path="description" id="errormsg"
									class="required_sign" />
							</div>
						<sec:authorize access="hasRole('Save/Update Manage Calendar')">
						<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}' >
							<h3>
							<c:choose>
								<c:when
									test="${(selectedObj != null && (selectedObj.holidayId > 0))}">
									<spring:message
										code="REF.UI.HOLIDAY.IMAGE.EDIT" />
								</c:when>
								<c:otherwise>
									<spring:message code="REF.UI.HOLIDAY.SUB_FORM.TITLE"/>
								</c:otherwise>
							</c:choose>

							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label><spring:message code="REF.UI.HOLIDAY.START_DATE"/>:</label>
										</div>
										<form:input path="startDate" id="${success?'':'StartDate'}" cssClass="date_field"
															readonly="${success}" disabled="true" />
									</div>
									<div class="float_left" style="margin-left: 100px;">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label><spring:message code="REF.UI.HOLIDAY.END_DATE"/>:</label>
										</div>
										<form:input path="endDate" id="EndDate" cssClass="date_field"
											readonly="true" />
									</div>

								</div>
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label><spring:message code="REF.UI.HOLIDAY.REASON"/>:</label>
										</div>
										<form:input id="inputDescription" path="description"
											onkeypress="return disableEnterKey(event)" maxlength="45"/>
									</div>
									<div class="buttion_bar_type1" style="margin-top: 15px;">
										<input type="button" value="<spring:message code="REF.UI.SAVE"/>" onClick="saveHoliday(this)"
											class="button"><input type="button" class="button"
											onclick="showArea();document.location.href='manageHoliday.htm'" value="<spring:message code="REF.UI.CANCEL"/>">
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</sec:authorize>
					</div>
					<div class="clearfix"></div>
			</form:form>
		</div>

  </div>
	</div>

	<h:footer/>
</body>

<script type="text/javascript">
if (document.getElementById("selectedYear") != null) {
	var selectedYear = document.getElementById("selectedYear").value;
}
if (document.yearForm.selectedYear != null) {
	var selectedYear = document.yearForm.selectedYear.value;
}
</script>
</html>
