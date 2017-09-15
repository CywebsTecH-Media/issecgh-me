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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
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
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function saveDonationType(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.DonationTypeForm.action = "saveOrUpdateDonationType.htm";
		document.DonationTypeForm.submit();
	}
	function addDonationType(thisValue) {

		document.forms["DonationTypeForm"]["description"].value = "";
		document.DonationTypeForm.donationTypeId.value = '0';
		setAddEditPane(thisValue, 'Add');
	}
	function updateDonationType(thisValue, selectedValue, selectedName) {

		setAddEditPane(thisValue, 'Edit');
		document.DonationTypeForm.selectedDonationTypeId.value = selectedValue;
		document.getElementById('donationTypeId').value = selectedValue;
		// Un escape the special characters wich already escaped, in description
		document.forms["DonationTypeForm"]["description"].value = $("<div/>").html(selectedName).text();
	}

	function deleteDonationType(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.DonationTypeForm.selectedDonationTypeId.value = selectedValue;
		document.getElementById('donationTypeId').value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.DonationTypeForm.action = "DeleteDonationType.htm";
			document.DonationTypeForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
	}

	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}

	function reSet(thisValue) {

		document.forms["DonationTypeForm"]["description"].value = "";
		document.DonationTypeForm.selectedDonationTypeId.value = "";
		setAddEditPane(thisValue, 'Cancel');
	}
	
	function changePanelTitle(donationTypeId) {
		if(donationTypeId > 0) {
			$('#panelTitle').empty();
			$('#panelTitle').append("<spring:message code='REF.UI.MANAGE.DONATION.EDIT' />");
		}
	}
	
</script>
</head>
<body onload="changePanelTitle('<c:out value="${selectedObj.donationTypeId}"/>')" >

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"> <spring:message
								code="REF.UI.REFERENCE" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.DONATION.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageDonationTypeHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" /></a>
			</div>
		</div>

		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.DONATION.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" name="DonationTypeForm"
				commandName="donationType">
				<input type="hidden" name="selectedDonationTypeId">
				<form:hidden path="donationTypeId" id="donationTypeId" />
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.DONATION.TYPE"/></h2>
						</div>
						<div id="area">
							<c:if test="${!(message == null)}">
								<div class="error">
									&nbsp;<label id="errormsg" class="required_sign"><c:out
											value="${message}" /> </label>
								</div>

							</c:if>
							<form:errors path="description" id="errormsg"
								class="required_sign" />
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830">DonationType</th>
									<th width="78" class="right">
									
									<sec:authorize access="hasAnyRole('Save or Update a donation type')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="addDonationType(this),showArea()" width="18"
											height="20" title="<spring:message code="REF.UI.MANAGE.DONATION.ADD"/>">
									</sec:authorize>
										
									</th>
								</tr>

								<c:choose>
									<c:when test="${not empty DonationTypeList}">
										<c:forEach items="${DonationTypeList}" var="DonationType"
											varStatus="status">
											
											<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if test="${((showPanel != null) && (showPanel == 'TRUE')
											 	&& (DonationType.donationTypeId == selectedObj.donationTypeId))}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>
											
											<tr class="${cssClass}" >
												<td width="830">${DonationType.description}</td>
												<td nowrap class="right">
												
													<sec:authorize access="hasAnyRole('Save or Update a donation type')">
														<img src="resources/images/ico_edit.gif"
														title="<spring:message code="REF.UI.MANAGE.DONATION.EDIT"/>"
														onClick="updateDonationType(this,'<c:out value="${DonationType.donationTypeId}" />','<c:out value="${fn:escapeXml(DonationType.description)}" />'),showArea()"
														width="18" height="20" class="icon"> 
													</sec:authorize>
													
													<sec:authorize access="hasAnyRole('Delete a donation type')">
														<img src="resources/images/ico_delete.gif"
														onClick="deleteDonationType(this,'<c:out value="${DonationType.donationTypeId}" />'),showArea()"
														title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
													</sec:authorize>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830">
												<h5><spring:message code="REF.UI.MANAGE.DONATION.NO.DONATION.TYPE.FOUND"/></h5></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>

					<c:set var="displayStyle" value="${((showPanel != null) && (showPanel == 'TRUE')) ? 'display: block;' : 'display: none;' }" />

					<div class="section_full_inside" style="${displayStyle}" >
						<h3 id="panelTitle"><spring:message code="REF.UI.MANAGE.DONATION.CREATE"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="REF.UI.MANAGE.DONATION.TYPE"/> :</label>
									</div>
									<form:input path="description" name="description"
										onkeypress="return disableEnterKey(event)" maxlength="45"
										value="${((showPanel != null) && (showPanel == 'TRUE')) ? selectedObj.description : ''}" />
								</div>

							</div>
							<sec:authorize access="hasAnyRole('Save or Update a donation type')">
								<div class="row">
									<div class="buttion_bar_type1">
										<input type="button" class="button"
											onClick="saveDonationType(this);" value="<spring:message code="REF.UI.SAVE" />"> <input
											type="button" class="button" onClick="reSet(this),showArea()"
											value="<spring:message code="REF.UI.CANCEL" />">
									</div>
								</div>
							</sec:authorize>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>