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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE HTML>
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

<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
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

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
$(function() {
	var date1='${staffPastService.staff.dateOfHire}';
	var datevar=date1.split("-");
	var currentyear=datevar[0];
	var currentMonth=datevar[1]-1;
	var currentDate=datevar[2];
	
	
	$("#dateOfDeparture").datepicker({

		changeYear : true,
		changeMonth : true,
		dateFormat : 'yy-mm-dd',
		minDate : new Date(currentyear,currentMonth,currentDate),
		showOn : "button",
		buttonImage : "resources/images/calendar.jpg",
		buttonImageOnly : true
	});
});
	
	
	
	function saveDepartureDetails(thisValue) {
		
		var okfunction = function(){
			setAddEditPane(thisValue, 'Save');
			document.staffDepartureForm.action = "saveStaffTerminate.htm";
			document.staffDepartureForm.submit();
		};
		
		var cancelfunction = function(){
			
			
		};
		
		var message='<spring:message code="STAFF.DEPARTURE_DATE_DETAILS.TERMINATE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
		
	
	}
	
	
	
	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}
	
	function hideArea() {
        $(document).ready(function() {
                $(".section_full_inside").hide();      
                
        });
        
}
	function closeWindow(){
		self.close();
	}

	// if success close the window and redirect to search page;
	function redirectToSearch(){

		if(${success?true:false}){
			opener.document.staffSearch.staffStatus.value='0';
			opener.document.staffSearch.registrationNo.value="${staffPastService.staff.registrationNo}";
			opener.document.staffSearch.submit();
			window.close();
		}
	
	} 
	redirectToSearch();
	
</script>
<!-- END Calender controll CSS and JS -->

</head>
<body>


	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">

				<h1>
					<spring:message code="STAFF.DEPARTURE_DATE_DETAILS.TITLE" />
				</h1>
			</div>

			<div class="help_link">
				<a href="#"
					onclick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/TerminateStaffHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> Help </a>
			</div>
			<div class="clearfix"></div>
			<div id="content_main">
				<form:form action="saveStaffTerminate.htm" method="post" commandName="staffPastService" name="staffDepartureForm">

					<div class="clearfix"></div>

					<div class="section_box" id="search_results">

						<div class="section_box_header">
							<h2>
								<spring:message code="STAFF.DEPARTURE_DATE_DETAILS.INFORMATION" /> 
							</h2>
						</div>

						<div id="area">
							<label class="required_sign"> 
								<c:if test="${message != null}"> ${message}</c:if>
							<spring:bind path="staffPastService.*">
									<c:if test="${not empty status.errorMessages}">
										<c:forEach var="error" items="${status.errorMessages}">
											<c:out value="${error}" escapeXml="false" />
											<br />
										</c:forEach>
									</c:if>
								</spring:bind>
							</label> 
						</div>

						<div class="column_single">
							<div class="box_border">

								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.REGISTRATION_NO" /> :</label>
									</div>

									<div class="frmvalue">
										<label> ${staffPastService.staff.registrationNo} </label>	
									</div>
								</div>

								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.STAFF.NAME" /> :</label>
									</div>
									<label> &nbsp;&nbsp;${staffPastService.staff.nameWithIntials} </label>
									
								</div>

								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.JOIN_DATE" /> :</label>
									</div>
									<label> &nbsp;&nbsp;${staffPastService.staff.dateOfHire} </label>
									
								</div>
								
								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<span class="required_sign">*</span><label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.DEPARTURE_DATE" /> :</label>
									</div>

									<div class="frmvalue">
										<form:input path="dateOfDepature" id="${success?'':'dateOfDeparture'}" class="date_field" readonly="true"/>
									</div>
								</div>



								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<span class="required_sign">*</span><label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.REASON" /> :</label>
									</div>

									<div class="frmvalue">

										<form:textarea name="reason" path="reason" rows="3" maxlength="250"
											style="width: 290px;" readonly="${success}" /> 

									</div>
								</div>
								
								<div class="row">
									<div class="frmlabel" style="width: 185px">
										<span class="required_sign">*</span><label><spring:message code="STAFF.DEPARTURE_DATE_DETAILS.COMPLETE_CLEARANCE" /> :</label>
									</div>

									<div class="frmvalue">

										<form:checkbox type="checkbox" path="completeClearance" name="clearance" align="left"
											style="width: 20px; height: 20px;" />


									</div>
								</div>
								<div class="clearfix"></div>


								<div class="buttion_bar_type2">
								<c:if test="${not success}">
									<input type="reset"
										value="<spring:message code='REF.UI.RESET' />" class="button"
										name="button"
										onclick="document.location.href='staffDepartureDetails.htm?selectedStaffId=${staffPastService.staff.staffId}'; ">
									
									<sec:authorize access="hasAnyRole('Terminate Staff Member')">
										<input type="button"
											value="<spring:message code='REF.UI.SAVE'/>"
											onClick="saveDepartureDetails(this)" class="button">
									</sec:authorize>
											
								</c:if>			
										<input type="button" class="button"
											onClick="closeWindow()" 
											value="<spring:message code="REF.UI.CLOSE"/>">

								</div>

								<div class="clearfix"></div>
							</div>
						</div>

					</div>
			<input type="hidden" name="selectedStaffId" value="${staffPastService.staff.staffId}"/>
			</form:form>
			</div>
		</div>
	</div>
<h:footer />
</body>
</html>
