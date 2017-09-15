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
	function addSportCategory(thisValue) {
		document.sportCategoryForm.sportCategoryId.value = 0;
		document.getElementById('selectSport').value = document
				.getElementById('selectOptionSport').value;
		document.getElementById('selectSportSub').value = document
				.getElementById('selectOptionSportSub').value;
		setAddEditPane(thisValue, 'Add');
	}

	function reSet(thisValue) {

		document.getElementById('selectSport').value = document
				.getElementById('selectOptionSport').value;
		document.getElementById('selectSportSub').value = document
				.getElementById('selectOptionSportSub').value;
		document.sportCategoryForm.sportCategoryId.value = 0;
		setAddEditPane(thisValue, 'Cancel');
	}

	function saveSportCategory(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.sportCategoryForm.action = "saveOrUpdateSportCategory.htm";
		document.sportCategoryForm.submit();
	}

	function updateSportCategory(thisValue, selectedValue, sportVal,
			sportSubVal) {
		setAddEditPane(thisValue, 'Edit');
		document.sportCategoryForm.sportCategoryId.value = selectedValue;
		document.getElementById('selectSport').value = sportVal;
		document.getElementById('selectSportSub').value = sportSubVal;
	}

	function deleteSportCategory(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			document.sportCategoryForm.sportCategoryId.value = selectedValue;
			document.sportCategoryForm.action = "manageDeleteSportCategory.htm";
			document.sportCategoryForm.submit();
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
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.SPORT.CATEGORY.EDIT"/>";
			});		
		}
	}
	
	function hideArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}

</script>

</head>
<body onload="load('<c:out value="${selectedObj.sportCategoryId}"></c:out>')">

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
					<li><spring:message code="REF.UI.SPORT_CATEGORY.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/createSportCategoryHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" />
				</a>
			</div>
		</div>
		<div class="clearfix"></div>

		<h1>
			<spring:message code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU7" />
		</h1>
		<div id="content_main">
			<form:form action="" method="POST" name="sportCategoryForm"
				commandName="sportCategory">
				<form:hidden path="sportCategoryId" />
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.SPORT_CATEGORY.SUB_TITLE" />
							</h2>
						</div>
						<div id="area">
							<c:if test="${message != null}"><font class="required_sign">&nbsp;&nbsp;&nbsp;<c:out value="${message}"
							escapeXml="false"/></font></c:if>
		
	  					<c:if test="${assginMessage != null}"><font class="success_sign">&nbsp;&nbsp;&nbsp;<c:out value="${assginMessage}"
							escapeXml="false"/></font></c:if>
							<form:errors path="sport" id="errormsg" class="required_sign" />

						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="857"><spring:message code="REF.UI.SPORT" />
									</th>
									<th width="857"><spring:message code="REF.UI.SPORTSUB" />
									</th>
									<th width="51" align="right" class="right"><sec:authorize
											access="hasRole('Add/Edit Sport Category')">
											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="hideArea(),addSportCategory(this),hideArea()" width="18" height="20"
												title="<spring:message code="REF.UI.SPORT_CATEGORY.SUB_FORM.TITLE"/>">
										</sec:authorize>
									</th>
								</tr>

								<c:choose>
									<c:when test="${not empty sportCategoryList}">
										<c:forEach items="${sportCategoryList}" var="sportCategory"
											varStatus="status">
											<tr
												<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>
												<td <c:if test="${selectedObj.sportCategoryId == sportCategory.sportCategoryId}">
															id="flag" 
												</c:if>>${sportCategory.sport.description}</td>
												<td>${sportCategory.sportSubCategory.description}</td>
												<td nowrap class="right"><sec:authorize
														access="hasRole('Add/Edit Sport Category')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="REF.UI.SPORT.CATEGORY.EDIT"/>"
															onClick="hideArea(),updateSportCategory(this,'<c:out value="${sportCategory.sportCategoryId}" />','<c:out value="${sportCategory.sport.sportId}" />','<c:out value="${sportCategory.sportSubCategory.sportSubId}" />')"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize access="hasRole('Delete Sport Category')">
														<img src="resources/images/ico_delete.gif"
															onClick="hideArea(),deleteSportCategory(this,'<c:out value="${sportCategory.sportCategoryId}" />')"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
											<tr>
											<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5></td>
											<td nowrap class="right"></td>
											<td nowrap class="right"></td>
											</tr>
									</c:otherwise>
								</c:choose>

							</table>
						</div>
					</div>
					<sec:authorize access="hasRole('Add/Edit Sport Category')">
						<div class="section_full_inside" style='display: ${editPane != null ?'block':'none'}'>
							<h3 id="editpanetitle">
								<spring:message code="REF.UI.SPORT_CATEGORY.SUB_FORM.TITLE" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span>
											<spring:message code="REF.UI.SPORT" />:</label>
										</div>
										<form:select path="sport.sportId" id="selectSport">
											<form:option value="0" id="selectOptionSport">
												<spring:message code="application.drop.down" />
											</form:option>
											<form:options items="${sportList}" itemLabel="description"
												itemValue="sportId" />
										</form:select>

									</div>

									<div class="float_right">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span>
											<spring:message code="REF.UI.SPORTSUB" />:</label>
										</div>

										<form:select path="sportSubCategory.sportSubId"
											id="selectSportSub">
											<form:option value="0" id="selectOptionSportSub">
												<spring:message code="application.drop.down" />
											</form:option>
											<form:options items="${sportSubList}" itemLabel="description"
												itemValue="sportSubId" />
										</form:select>
									</div>
									<div class="row">
										<div class="buttion_bar_type1">
											<input type="button" class="button"
												onClick="saveSportCategory(this),hideArea()"
												value="<spring:message code="REF.UI.SAVE"/>"> <input
												type="button" class="button" onClick="reSet(this),hideArea()"
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
