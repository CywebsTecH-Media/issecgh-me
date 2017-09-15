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
<!DOCTYPE HTML>

<%@page import="com.virtusa.akura.api.exception.ErrorMsgLoader"%><html>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function deleteStaffCategory(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action = 'manageDeleteStaffCategory.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
	}

	var oldDescription, oldStaffType;
	function editStaffCategory(thisVal, description, staffCategoryId,
			isAcademic) {
		setAddEditPane(thisVal, 'Edit');
		oldDescription= description;
		document.form.description.value = description;
		document.form.catogaryID.value = staffCategoryId;
		document.form.academic.value = isAcademic;
		$('input[value=' + isAcademic + ']:radio').attr('checked', 'checked');
		oldStaffType= $('input[name="academic"]:checked').val();
	}
	
	function checkRadioButton(value) {
		$('input[value=' + value + ']:radio').attr('checked', 'checked');
	}

	function addStaffCategory(thisVal) {
		setAddEditPane(thisVal, 'Add');
		if (document.form.description.value != null) {
			document.form.description.value = '';
			document.form.catogaryID.value = '0';
			$('input[value=true]:radio').attr('checked', 'checked');
		}
	}
	
	function showArea() {
		$(document).ready(function() {
			$(".messageAreaTop").hide();
			$(".messageAreaBot").hide();
			$(".messageArea").hide();
		});
	}
	
	function changePanelTitle(catogaryID) {
		if(catogaryID > 0) {
			$('#panelTitle').empty();
			$('#panelTitle').append("<spring:message code='REF.UI.STAFF.CATEGORY.EDIT' />");
		}
	}
	
	function showDown(bool){			
		var name = '${showPanel != null}';
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
	
	function showErrorMessage(){
		if(${del!= null}){	
			$(".messageAreaBot").hide();
		}
		else{
			$(".messageAreaTop").hide();
		}
	}
	
	function displayMessage(academic){
		var newDescription = document.getElementById("inputCatDesc").value;
		var newStaffType = $('input[name="academic"]:checked').val();;
		if(oldDescription == newDescription && oldStaffType == newStaffType){
			$(".messageAreaBot").show();
			document.getElementsByClassName("messageAreaBot")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
			var changeButtonType = document.getElementById("saveButton");
			//changeButtonType.type = "submit";Because it causes problems in Internet Explorer.
			document.form.submit();
		}
	}
		
</script>
</head>
<body onload="showDown(false),showErrorMessage(),changePanelTitle('<c:out value="${staffCategory.catogaryID}"/>'); checkRadioButton('<c:out value="${staffCategory.academic}"/>');" >

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.STAFF.CATEGORY.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageStaffCategoryHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.STAFF.CATEGORY.SUB_TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="manageSaveOrUpdateStaffCategory.htm" method="post"
				commandName="staffCategory" name="form">
				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.STAFF.CATEGORY.DETAIL_TITLE" />
							</h2>
						</div>
						
						<div class="messageArea">
							<div>
							<!-- update success message comes through query string (after redirecting) -->
							<label class="success_sign"> ${param.addEditDelete}</label>
							</div>
						</div>
						<div class="messageAreaTop">
							<c:if test="${message != null}">
								<div>
									<label class="required_sign">${message}</label>
								</div>
							</c:if>
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
						</div>		
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="45%"><spring:message
											code="REF.UI.STAFF.CATEGORY" /></th>
									<th><spring:message code="REF.UI.STAFF.CATEGORY.ACADEMIC" /></th>
									<th width="51" class="right"><sec:authorize
											access="hasRole('Add/Edit Staff Category')">
											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="showDown(true),showArea(),clearMessages();addStaffCategory(this);" width="18" height="20"
												title="<spring:message code="REF.UI.STAFF.CATEGORY.ADD"/>">
										</sec:authorize></th>
								</tr>



								<c:choose>
									<c:when test="${not empty staffCategoryList}">
										<c:forEach var="staffCategoryData" items="${staffCategoryList}"
											varStatus="status">
											
											<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if test="${((showPanel != null) && (showPanel == 'TRUE')
											 	&& (staffCategoryData.catogaryID == staffCategory.catogaryID))}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>
											
											<tr class="${cssClass}" >
												<td><c:out value="${staffCategoryData.description}"></c:out>
												</td>
												<c:choose>
													<c:when test="${staffCategoryData.academic == true}">
														<td><%=new ErrorMsgLoader()
											.getErrorMessage("REF.UI.STAFFCATEGORY.ACADEMIC")%></td>
													</c:when>
													<c:otherwise>
														<td><%=new ErrorMsgLoader()
											.getErrorMessage("REF.UI.STAFFCATEGORY.NONACADEMIC")%></td>
													</c:otherwise>
												</c:choose>
												<td nowrap class="right"><sec:authorize
														access="hasRole('Add/Edit Staff Category')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="REF.UI.STAFF.CATEGORY.EDIT"/>"
															onClick="showDown(true),showArea(),editStaffCategory(this,'<c:out value="${staffCategoryData.description}"/>', '<c:out value="${staffCategoryData.catogaryID}"/>', '<c:out value="${staffCategoryData.academic}"/>',clearMessages());"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize access="hasRole('Delete Staff Category')">
														<img src="resources/images/ico_delete.gif"
															onClick="clearMessages(),showArea();document.form.catogaryID.value='${staffCategoryData.catogaryID}';
                      deleteStaffCategory(this)"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5>
													<spring:message code="APPLICATION.NORECORDSFOUND" />
												</h5></td>
												<td></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>


							</table>
						</div>
					</div>
					<sec:authorize access="hasRole('Add/Edit Staff Category')">
					
						<c:set var="displayStyle" value="${((showPanel != null) && (showPanel == 'TRUE')) ? 'display: block;' : 'display: none;' }" />
						<div class="messageAreaBot">
							<c:if test="${message != null}">
								<div>
									<label class="required_sign">${message}</label>
								</div>
							</c:if>
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
						</div>					
						<div class="section_full_inside" style="${displayStyle}" >

							<h3 id="panelTitle">
								<spring:message code="REF.UI.STAFF.CATEGORY.ADD" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label> <spring:message
													code="REF.UI.STAFF.CATEGORY" />:
											</label>
										</div>
										<form:input id="inputCatDesc" path="description" maxlength="45" />
										<form:hidden path="catogaryID" />
									</div>
									<div class="float_right">
										<div class="lbl_lock">
											<label><spring:message
													code="REF.UI.STAFF.CATEGORY.TYPE" />:</label>
										</div>
										<form:radiobutton path="academic" value="true"
											cssClass="radio_btn" />
										<label class="label_inline"><spring:message
												code="REF.UI.STAFF.CATEGORY.ACADEMIC" /></label>&nbsp;&nbsp;
										<form:radiobutton path="academic" value="false"
											cssClass="radio_btn" />
										<label class="label_inline"><spring:message
												code="REF.UI.STAFF.CATEGORY.NON.ACADEMIC" /></label>
									</div>
									<div class="row">
										<div class="buttion_bar_type1">
											<input type="button" id="saveButton"
												value="<spring:message code="REF.UI.SAVE"/>"
												onClick="displayMessage('<c:out value="${staffCategoryData.academic}"/>')" class="button"><input
												type="button" class="button"
												onClick="setAddEditPane(this,'Cancel'), clearMessages(),showArea()"
												value="<spring:message code="REF.UI.CANCEL"/>">
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</sec:authorize>
					<div class="clearfix"></div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
