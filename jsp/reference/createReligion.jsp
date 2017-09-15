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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.religionForm.description.value != null) {
			document.religionForm.description.value = '';
			document.religionForm.religionId.value = 0;
		}
		
	}

	function saveReligion(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.religionForm.action = "saveOrUpdateReligion.htm";
		document.religionForm.submit();
	}

	function updateReligion(thisValue, selectedValue, description) {
		setAddEditPane(thisValue, 'Edit');
		document.religionForm.religionId.value = selectedValue;
		document.religionForm.description.value = description;
	}

	function deleteReligion(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.religionForm.religionId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.religionForm.action = "manageDeleteReligion.htm";
			document.religionForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );

	}
	function load(thisValue){
		var flagVal = null;
		if (!(thisValue == null || thisValue == "")) {
			flagVal = thisValue;
		}
		if (flagVal != null) {
		//	$(document).ready(function() {
		//		$("#flag").parents('tr').addClass('highlight');
		//	});			

		} else {
			$(document).ready(function() {
				$(".section_full_inside").hide();
			});
		}
	}
	
	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}
</script>
</head>
<body onLoad="load('<c:out value="${selectedObj}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"> <spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.RELIGION.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageReligionHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.MANAGE.RELIGION.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="" method="POST" name="religionForm"
				commandName="religion">

				<form:hidden path="religionId" />

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.MANAGE.RELIGION.TABLE.HEADER" />
							</h2>
						</div>
						<div id="area">							
							<div>
								<c:if test="${message != null}">
									<div>
										<label class="required_sign">${message}</label>
									</div>
								</c:if>
								<c:if test="${assginMessage != null}">
									<div>
										<label class="success_sign">${assginMessage}</label>
									</div>
								</c:if>
							</div>
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
							
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message
											code="REF.UI.MANAGE.RELIGION.RELIGION" /></th>
									<th width="78" class="right"><sec:authorize access="hasRole('Add/Edit Religion')"> <img
										src="resources/images/ico_new.gif" class="icon_new"
										onClick="showArea(),addNew(this)" 	width="18" height="20"
										title="<spring:message code="REF.UI.MANAGE.RELIGION.CREATE.NEW"/>"></sec:authorize>
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty religionList}">
										<c:forEach items="${religionList}" var="religion"
											varStatus="status">
											<tr
												<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
												<td <c:if test="${selectedObj.description == religion.description }">
															id="flag" 
												</c:if>>${religion.description}</td>
												<td nowrap class="right">
												<sec:authorize access="hasRole('Add/Edit Religion')"> 
												<img
													src="resources/images/ico_edit.gif"
													onClick="updateReligion(this, '<c:out value="${religion.religionId}" />','<c:out value="${religion.description}" />');showArea()"
													title="<spring:message code="REF.UI.MANAGE.RELIGION.EDIT"/>" width="18" height="20" class="icon">
													</sec:authorize>
													<sec:authorize access="hasRole('Delete Religion')"> <img src="resources/images/ico_delete.gif"
													onClick="showArea();deleteReligion(this, '<c:out value="${religion.religionId}" />');"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="REF.UI.MANAGE.NO.RELIGION.FOUND" /></h5>
											</td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
					<sec:authorize access="hasRole('Add/Edit Religion')">
					<div class="section_full_inside">
						<h3>
							<spring:message code="REF.UI.MANAGE.RELIGION.CREATE.NEW" />
						</h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="REF.UI.MANAGE.RELIGION.RELIGION" />:</label>
									</div>
									<form:input path="description"
										onkeypress="return disableEnterKey(event)" maxlength="45" />
								</div>
								<div class="float_right"></div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" class="button"
										onClick="saveReligion(this);"
										value="<spring:message code="REF.UI.SAVE" />"/>
										<input type="button" class="button"
										onClick="setAddEditPane(this,'Cancel');showArea()"
										value="<spring:message code="REF.UI.CANCEL" />"/>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div></sec:authorize>
					<div class="clearfix"></div>
				</div>

			</form:form>
		</div>
		
		<div class="clearfix"></div>
	</div>
	<div class="clearfix"></div>
	<h:footer />
</body>
</html>
