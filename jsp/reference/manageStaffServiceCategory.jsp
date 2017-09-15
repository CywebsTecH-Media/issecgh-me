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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
<script language="javascript" src="resources/js/common.js"></script>


<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>



<script type="text/javascript">

	function saveStaffServiceCategory(thisValue) {

		
		setAddEditPane(thisValue, 'Save');
		document.staffServiceCategoryForm.action = "manageSaveOrUpdateStaffServiceCategory.htm";
		document.staffServiceCategoryForm.submit();

	}

	function addStaffServiceCategory(thisValue) {

		document.forms["staffServiceCategoryForm"]["description"].value = "";
		document.staffServiceCategoryForm.serviceId.value = 0;
		setAddEditPane(thisValue, 'Add');
	}

	function updateStaffServiceCategory(thisValue, selectedValue, selectedName) {

		setAddEditPane(thisValue, 'Edit');
		document.staffServiceCategoryForm.serviceId.value = selectedValue;	
		document.forms["staffServiceCategoryForm"]["description"].value = selectedName;
	}

	function deleteStaffServiceCategory(thisValue, selectedValue) {		

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.staffServiceCategoryForm.serviceId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		
		
		var okfunction = function(){
			document.staffServiceCategoryForm.serviceId.value = selectedValue;
			document.staffServiceCategoryForm.action = "manageDeleteStaffServiceCategory.htm";
			document.staffServiceCategoryForm.submit();
		};
		
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
			
			
			
		};
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
		
		
		
		
	}

	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}

	function reSet(thisValue) {

		document.forms["staffServiceCategoryForm"]["description"].value = "";
		setAddEditPane(thisValue, 'Cancel');
	}
	
	function load(thisValue){
		
		if (thisValue>0) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.EDIT"/>";
			});		
		}
	}

</script>
</head>
<body onload="load('<c:out value="${selectedObjId}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
			
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.TITLE" /></li>
				</ul>
			
			</div>
				
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageStaffServiceCategoryHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP" /></a>
					
			</div>
			
		</div>
		
		<div class="clearfix"></div>

		<h1><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.TITLE" /></h1>
		
		<!--
		Middle data table start from here
		-->
		
		<div id="content_main">
		
		<form:form action="" method="POST" name="staffServiceCategoryForm" commandName="staffServiceCategory">
		<form:hidden path="serviceId" />
		<div class="clearfix"></div>
			<div class="section_box">
			
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.DETAILS" /></h2>
						</div>
						
						<div id="area">
							<c:if test="${!(message == null)}">
								<div class="error">
									&nbsp;<label id="errormsg" class="success_sign"><c:out value="${message}" /> </label>
								</div>
							</c:if>
							
							<c:if test="${!(message_error == null)}">
								<div class="error">
									&nbsp;<label id="errormsg" class="required_sign"><c:out value="${message_error}" /> </label>
								</div>
							</c:if>
							<form:errors path="description" id="errormsg" class="required_sign" />
						</div>
						
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
							
							<tr>
			
								<th width="849"><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY" /> </th>														
								<th width="59" align="right" class="right">
								
								<sec:authorize access="hasRole('Save/Update Staff Service Category')">
								
								<img src="resources/images/ico_new.gif" class="icon_new"
									onClick="addStaffServiceCategory(this),showArea()" width="18" height="20"
									title="<spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.ADD"/>">
									
								</sec:authorize>								
								</th>						
							</tr>
				<c:set var="selectedStaffServiceCategoryId" value="${staffServiceCategory.serviceId}" />
					<c:choose>
						<c:when test="${not empty staffServiceCategoryList}">
							<c:forEach items="${staffServiceCategoryList}" var="staffServiceCategory" varStatus="status">
								<tr
									<c:choose>
				            		<c:when test="${displayPanel && selectedStaffServiceCategoryId == staffServiceCategory.serviceId}">class="highlight"</c:when>
				            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
				            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
				            		</c:choose>>
									<td width="830"
										<c:if test="${selectedObjId eq staffServiceCategory.serviceId}"> id="flag" 
										</c:if>>${staffServiceCategory.description}
									</td>
									<td nowrap class="right">
									
									<sec:authorize access="hasRole('Save/Update Staff Service Category')">
										<img src="resources/images/ico_edit.gif"
											onclick="updateStaffServiceCategory(this,'<c:out value="${staffServiceCategory.serviceId}"/>','<c:out value="${staffServiceCategory.description}"/>'),showArea()"											                                 	
											title="<spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.EDIT"/>" width="18" height="20" class="icon">
								   
								   </sec:authorize>
			
									<sec:authorize access="hasRole('Delete Staff Service Category')">
									
										<img src="resources/images/ico_delete.gif"											
											onclick="deleteStaffServiceCategory(this,'<c:out value="${staffServiceCategory.serviceId}"/>'),showArea()"									
											title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">

			 						</sec:authorize>
									</td>
			
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td width="830">
								<h5><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.NOT.FOUND" /></h5>
								</td>
								<td nowrap class="right"></td>
							</tr>
						</c:otherwise>
					</c:choose>
	
				</table>
				</div>
				</div>
				
				
				<!--
				Add section start from here
				-->
				
				<spring:bind path="staffServiceCategory.*">
						<c:set var="status" value="${status}"></c:set>
					</spring:bind>
				
				<div class="section_full_inside" style="display: ${displayPanel ?'block':'none'}">
					<h3 id="editpanetitle"><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.ADD" /></h3>
					<div class="box_border">
						<div class="row">
							<div class="float_left">
					
								<div class="lbl_lock"><label><span class="required_sign">*</span><spring:message code="REF.UI.MANAGE.STAFFSERVICECATEGORY.NAME" />:</label></div>					
								<form:input path="description" id="nameValue" maxlength="45" onkeypress="return disableEnterKey(event)" name="name"/>
							
							</div>
					
							<div class="buttion_bar_type1" style="margin-top: 15px;">
								
								<input type="button" value="<spring:message code="REF.UI.SAVE"/>" onClick="saveStaffServiceCategory(this),showArea()" class="button">								
								<input type="button" class="button" onClick="reSet(this),showArea()" value="<spring:message code="REF.UI.CANCEL"/>">
							
							</div>
						</div>
						<div class="clearfix"></div>	
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</form:form> 
	</div>
</div>
<h:footer/>
</body>
</html>

