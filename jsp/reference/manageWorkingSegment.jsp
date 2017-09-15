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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
<script language="javascript" src="resources/js/common.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.workingSegmentForm.description.value != null) {
			document.workingSegmentForm.description.value = '';
		}
		document.workingSegmentForm.workingSegmentId.value = 0;
	}

	function saveWorkingSegment(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.workingSegmentForm.action = "saveOrUpdateWorkingSegment.htm";
		document.workingSegmentForm.submit();
	}

	function updateWorkingSegment(thisValue, selectedValue, description) {
		setAddEditPane(thisValue, 'Edit');
		document.workingSegmentForm.workingSegmentId.value = selectedValue;
		document.workingSegmentForm.description.value = description;
	}

	function deleteWorkingSegment(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.workingSegmentForm.workingSegmentId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.workingSegmentForm.workingSegmentId.value = selectedValue;
			document.workingSegmentForm.action = "manageDeleteWorkingSegment.htm";
			document.workingSegmentForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
	}
	
	function showArea(){
		   $(document).ready(function() {
				$(".area").hide();
			});
	   }
	
	function addEditPanelTitle(workingSegmentId) {
		if(workingSegmentId > 0) {
			$('#addEditPanelTitle').empty();
			$('#addEditPanelTitle').append("<spring:message code='REF.UI.MANAGE.WORKING.SEGMENT.EDIT' />");
		}
	}
</script>

</head>
<body onload="addEditPanelTitle(${selectedObjId});">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageWorkingSegmentHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" commandName="workingSegment"
				name="workingSegmentForm">

				<form:hidden path="workingSegmentId" />

				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.DETAIL"/></h2>
						</div>
						<div class="area">
							&nbsp; <label class="success_sign"> <c:if
									test="${message != null}">${message}</c:if> <form:errors
									path="workingSegmentId" /> <form:errors path="description" /> </label>
									<label class="required_sign"> <c:if
									test="${ass_message != null}">${ass_message}</c:if> <form:errors
									path="workingSegmentId" /> <form:errors path="description" /> </label>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="857"><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT"/></th>
									<th width="51" class="right"><sec:authorize access="hasRole('Save or Update a Working Segment')"><img
										src="resources/images/ico_new.gif" class="icon_new"
										onClick="showArea();addNew(this)" width="18" height="20"
										title="<spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.ADD"/>"></sec:authorize>
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty workingSegmentList}">
										<c:forEach items="${workingSegmentList}" var="workingSegment"
											varStatus="status">
											<tr <c:if test="${selectedObjId != null && (selectedObjId == workingSegment.workingSegmentId)}">class="highlight"</c:if>
												<c:choose>
			            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
			            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
			            		</c:choose>>
												<td>${workingSegment.description}</td>
												<td nowrap class="right"><sec:authorize access="hasRole('Save or Update a Working Segment')"><img
													src="resources/images/ico_edit.gif"
													onClick="showArea();updateWorkingSegment(this,'<c:out value="${workingSegment.workingSegmentId}"/>','<c:out value="${workingSegment.description}"/>');"
													title="<spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.EDIT"/>" width="18" height="20"
													class="icon"></sec:authorize><sec:authorize access="hasRole('Delete a Working Segment')"><img
													src="resources/images/ico_delete.gif"
													onClick="showArea();deleteWorkingSegment(this,'<c:out value="${workingSegment.workingSegmentId}"/>');"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5>
											</td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					<sec:authorize access="hasRole('Save or Update a Working Segment')">
					<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
						<h3 id="addEditPanelTitle"><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.WORKING.SEGMENT"/>:</label>
									</div>
									<form:input path="description"
										onkeypress="return disableEnterKey(event)" maxlength="45"/>
								</div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">
									<input type="button" value="<spring:message code="REF.UI.SAVE"/>"
										onClick="showArea();saveWorkingSegment(this)" class="button"><input
										type="button" class="button"
										onClick="showArea();setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>">
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
