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
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
		if (document.positionForm.description.value != null) {
			document.positionForm.description.value = '';
		}
		document.positionForm.positionId.value = 0;
	}

	function savePosition(thisValue) {

		setAddEditPane(thisValue, 'Save');
		document.positionForm.action = "saveOrUpdatePosition.htm";
		document.positionForm.submit();
	}

	function updatePosition(thisValue, selectedValue, description) {
		setAddEditPane(thisValue, 'Edit');
		document.positionForm.positionId.value = selectedValue;
		document.positionForm.description.value = description;
	}

	function deletePosition(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.positionForm.positionId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
				
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.positionForm.action = "manageDeletePosition.htm";
			document.positionForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}
	
	function load(thisValue){
		
		if (thisValue>0) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.MEMBER_SHIP.IMAGE.EDIT"/>";
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
<body onload="load('<c:out value="${selectedObj.positionId}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MEMBER_SHIP.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/managePositionHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle">
				<spring:message code="REF.UI.HELP" />
				</a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.MEMBER_SHIP.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="" method="POST" commandName="position"
				name="positionForm">

				<form:hidden path="positionId" />

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.MEMBER_SHIP.SUB_TITLE" />
							</h2>
						</div>
						<div id="area">
							
						<c:if test="${message != null}"><font class="required_sign">&nbsp;&nbsp;&nbsp;<c:out value="${message}"
							escapeXml="false"/></font></c:if>
		
	  					<c:if test="${assginMessage != null}"><font class="success_sign">&nbsp;&nbsp;&nbsp;<c:out value="${assginMessage}"
							escapeXml="false"/></font></c:if>
							
							<form:errors path="description" cssClass="required_sign" />
							
							
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message
											code="REF.UI.MEMBER_SHIP.POSITION" />
									</th>
									<th width="78" class="right"><sec:authorize
											access="hasRole('Save or Update a Position')">

											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="showArea(),addNew(this)" width="18" height="20"
												title="<spring:message code="REF.UI.MEMBER_SHIP.SUB_FORM.TITLE"/>">
										</sec:authorize></th>
								</tr>
								<c:choose>
									<c:when test="${not empty positionList}">
										<c:forEach items="${positionList}" var="position"
											varStatus="status">
											<tr
												<c:choose>
			            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
			            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
			            		</c:choose>>
												<td <c:if test="${selectedObj.description == position.description}">
															id="flag" 
												</c:if>>${position.description}</td>
												<td nowrap class="right"><sec:authorize
														access="hasRole('Save or Update a Position')">

														<img src="resources/images/ico_edit.gif"
															onClick="showArea(),updatePosition(this,'<c:out value="${position.positionId}"/>','<c:out value="${position.description}"/>');"
															title="<spring:message code="REF.UI.MEMBER_SHIP.IMAGE.EDIT"/>"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize access="hasRole('Delete a Position')">
														<img src="resources/images/ico_delete.gif"
															onClick="showArea(),deletePosition(this,'<c:out value="${position.positionId}"/>');"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5>
													<spring:message code="REF.UI.MEMBER_SHIP.EMPTY" />
												</h5></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>

					<sec:authorize access="hasRole('Save or Update a Position')">

						<div class="section_full_inside" style='display: ${editPane != null ?'block':'none'}'>
							<h3  id="editpanetitle">
								<spring:message code="REF.UI.MEMBER_SHIP.SUB_FORM.TITLE" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label><spring:message
													code="REF.UI.MEMBER_SHIP.POSITION" />:</label>
										</div>
										<form:input path="description"
											onkeypress="return disableEnterKey(event)" maxlength="45" />
									</div>
									<div class="buttion_bar_type1" style="margin-top: 15px;">
										<input type="button"
											value="<spring:message code="REF.UI.SAVE"/>"
											onClick="savePosition(this)" class="button"><input
											type="button" class="button"
											onClick="setAddEditPane(this,'Cancel');showArea()"
											value="<spring:message code="REF.UI.CANCEL"/>">
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
