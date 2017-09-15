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
	<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>

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

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

function addNew(thisValue) {
	setAddEditPane(thisValue, 'Add');
	if (document.form.description.value != null) {
		document.form.description.value = '';
	}
	document.form.titleId.value = 0;
	
}

function updateTitle(thisValue, selectedValue, description) {
	setAddEditPane(thisValue, 'Edit');
	document.form.titleId.value = selectedValue;
	document.form.description.value = description;
}
	function deleteTitle(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			document.form.action = 'manageDeleteTitle.htm';
			document.form.submit();
		};

		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
	}
	
	

	function saveTitle(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.form.action = "saveOrUpdateTitle.htm";
		document.form.submit();
	}
	
	function hideArea() {
        $(document).ready(function() {
                $(".section_full_inside").hide();      
                
        });
        
}
	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}
	
	function load(thisValue){
		
		if (thisValue>0) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.TITLE.IMAGE.EDIT"/>";
			});		
		}
	}

</script>
</head>
<body onload="load('<c:out value="${selectedObj.titleId}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.TITLE.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
			
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageTitleHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /> </a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.TITLE.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="manageSaveOrUpdateTitle.htm" method="POST"
				commandName="title" name="form">
				<form:hidden path="titleId" />

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.TITLE.SUB_TITLE" />
							</h2>
						</div>
						 <div id="area">
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
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message
											code="REF.UI.TITLE.MANAGE.TITLE" />
									</th>
									<th width="78" class="right"><sec:authorize
											access="hasRole('Add/Edit Title')">
											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="addNew(this),showArea()" width="18" height="20"
												title="<spring:message code="REF.UI.TITLE.SUB_FORM.TITLE"/>">
										</sec:authorize>
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty titleList}">
										<c:forEach var="title" items="${titleList}" varStatus="status">

											<tr>
												<c:choose>
													<c:when test="${(status.count) % 2 == 0}">
														<tr class="odd">
													</c:when>
													<c:otherwise>
														<tr class="even">
													</c:otherwise>
												</c:choose>
												<td <c:if test="${selectedObj.description == title.description }">
															id="flag" 
												</c:if>><c:out value="${title.description}"></c:out></td>
												<td nowrap class="right"><sec:authorize
														access="hasRole('Add/Edit Title')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="REF.UI.TITLE.IMAGE.EDIT"/>"
															onClick="updateTitle(this, '<c:out value="${title.titleId}" />','<c:out value="${strEscapeUtil:escapeJS(title.description)}" />',showArea());"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize access="hasRole('Delete Title')">
														<img src="resources/images/ico_delete.gif"
															onClick="showArea(),document.form.titleId.value='${title.titleId}';deleteTitle(this)"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830">
												<h5>
													<spring:message code="REF.UI.TITLE.NO.RESULT" />
												</h5></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>

					<sec:authorize access="hasRole('Add/Edit Title')">

						<div class="section_full_inside" style='display: ${editPane != null ?'block':'none'}'>
							<h3 id="editpanetitle">
								<spring:message code="REF.UI.TITLE.SUB_FORM.TITLE" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span> <spring:message
													code="REF.UI.TITLE.SUB_TITLE" />:</label>
										</div>

										<form:input path="description" maxlength="5" autocomplete="off"/>
									</div>
									<div class="float_right"></div>
								</div>

								<div class="buttion_bar_type1">
									<input type="submit" class="button" 
										value="<spring:message code="REF.UI.SAVE"/>"><input
										type="button" class="button"
										onClick="setAddEditPane(this,'Cancel'),showArea()"
										value="<spring:message code="REF.UI.CANCEL"/>">
								</div>

								<div class="clearfix"></div>
							</div>
					</sec:authorize>

					<div class="clearfix"></div>
				</div>
			</form:form>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>