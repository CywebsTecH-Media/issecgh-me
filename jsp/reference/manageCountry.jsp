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
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script type="text/javascript">
	function deleteCountry(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>');
		if (ans) {
			document.form.action = 'manageDeleteCountry.htm';
			document.form.submit();
		} else {
			$(thisObj).parents('tr').removeClass('highlight');
		}
	}
	function saveCountry(thisValue) {
		setAddEditPane(thisValue, 'Save');
		document.form.action = "manageSaveOrUpdateCountry.htm";
		document.form.submit();
	}

	function updateCountry(thisValue, selectedValue, description,code) {
		setAddEditPane(thisValue, 'Edit');
		document.form.countryId.value = selectedValue;
		document.form.countryName.value = description;
		document.form.countryCode.value = code;
		
	}

	function previousOrNext(value, startFrom){
		pageSize = 10;
		if(value == "next"){
			startFrom = parseInt(startFrom) + pageSize;
			document.getElementById('startFrom').value = startFrom + "";

		}else if(value == "previous"){
			startFrom = parseInt(startFrom) - pageSize;
			document.getElementById('startFrom').value = startFrom + "";
		}
		document.getElementById('actionType').value = value;
		document.form.submit();
		
	}

	function showArea() {
		$(document).ready(function() {
			$(".area").hide();
		});
	}
	
	function addEditPanelTitle(countryId) {
		if(countryId > 0) {
			$('#addEditPanelTitle').empty();
			$('#addEditPanelTitle').append("<spring:message code='REF.UI.MANAGE.COUNTRY.EDIT' />");
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
	<li><a href="adminWelcome.htm"><spring:message
		code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
	<li><a href="referenceModule.htm"><spring:message
		code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="REF.UI.MANAGE.COUNTRY.TITLE" /></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="showArea(),PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageCountryHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"><spring:message code="REF.UI.HELP" /></a></div>
</div>
<div class="clearfix"></div>
<h1><spring:message code="REF.UI.MANAGE.COUNTRY.TITLE" /></h1>
<div id="content_main"><form:form action="#" method="post"
	name="form" commandName="country">
	<div class="section_full_search">
	<div></div>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><label><spring:message
		code="REF.UI.MANAGE.COUNTRY.COUNTRY.NAME" />:</label></div>
	<input type="text" maxlength="45" name="searchDescription"
		value="${searchDescription}"></div>
	<div class="float_right">
	<div class="buttion_bar_type1"><sec:authorize access="hasRole('Search countries')"><input type="button" id="myButton"
		value="<spring:message code="REF.UI.SEARCH" />"
		onClick="showArea(),document.form.action='manageSearchCountry.htm';document.form.submit();"
		class="button"></sec:authorize></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<input type="hidden" name="startFrom" id="startFrom" value="0" />
	<input type="hidden" name="actionType" id="actionType" value="search" />
	
	
	<div class="section_box">
			<div id="search_results">
			<div class="section_box_header">
			<h2><spring:message code="REF.UI.SEARCH.RESULTS" /></h2>
			<div class="area"><c:if test="${message != null}">
		
		<div><label class="required_sign">${message}</label></div>
		
	</c:if><form:errors path="countryName" cssClass="required_sign" />
	<form:errors path="countryCode" cssClass="required_sign" />
	</div>
			</div>
			<div class="column_single">
			<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th width="35%"><spring:message
						code="REF.UI.MANAGE.COUNTRY.NAME" /></th>
						<th width="35%"><spring:message
						code="REF.UI.MANAGE.COUNTRY.COUNTRY.CODE" /></th>
					<th width="150" class="right"><c:if
						test="${numberOfRecords == 0}">${country.startFrom}</c:if> <c:if
						test="${numberOfRecords > 0}">${country.startFrom+1}</c:if> -
					${country.maxNumber} <spring:message
						code="REF.UI.MANAGE.COUNTRY.OF" /> ${numberOfRecords} <input
						type="image" class="button" width="15" height="15"
						src="resources/images/leftSideArrow.png"
						title="<spring:message code='REF.UI.MANAGE.COUNTRY.PREVIOUS'/>"
						onclick="previousOrNext('previous', '<c:out value="${country.startFrom}"/>')"
						<c:if test="${country.startFrom == 0}">disabled="disabled"</c:if>>
					<input type="image" width="20" height="15" class="button"
						src="resources/images/rightSideArrow.png"
						title="<spring:message code='REF.UI.MANAGE.COUNTRY.NEXT'/>"
						onclick="previousOrNext('next', '<c:out value="${country.startFrom}"/>')"
						<c:if test="${country.maxNumber == numberOfRecords}">disabled="disabled"</c:if>>
					</th>
				</tr>
				<c:choose>
					<c:when test="${searchCountry != null }">
						<c:forEach var="searchCountry" items="${searchCountry}"
							varStatus="status">
							<tr
								<c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
								<td><c:out value="${searchCountry.countryName}"></c:out></td>
								<td><c:out value="${searchCountry.countryCode}"></c:out></td>
								<td nowrap class="right"><sec:authorize
		access="hasRole('Add/Edit Country')">
									<img src="resources/images/ico_edit.gif"
										title="<spring:message code="REF.UI.MANAGE.COUNTRY.EDIT"/>"
										onClick="updateCountry(this, '<c:out value="${searchCountry.countryId}" />', '<c:out value="${strEscapeUtil:escapeJS(searchCountry.countryName)}" />', '<c:out value="${strEscapeUtil:escapeJS(searchCountry.countryCode)}" />' ,showArea());"
										width="18" height="20" class="icon">
								</sec:authorize> <sec:authorize access="hasRole('Delete Country')">
									<img src="resources/images/ico_delete.gif"
										onClick="document.form.countryId.value='${searchCountry.countryId}';
                        deleteCountry(this);"
										title="<spring:message code="REF.UI.DELETE"/>" width="18"
										height="20" class="icon">
								</sec:authorize></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${not empty countryList }">
								<c:forEach items="${countryList}" var="country"
									varStatus="status">
									<tr <c:if test="${selectedObjId != null && (selectedObjId == country.countryId)}">class="highlight"</c:if>
										<c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
										<td><c:out value="${country.countryName}"></c:out></td>
										<td><c:out value="${country.countryCode}"></c:out></td>
										<td nowrap class="right"><sec:authorize
		access="hasRole('Add/Edit Country')"><img
											src="resources/images/ico_edit.gif"
											title="<spring:message code="REF.UI.MANAGE.COUNTRY.EDIT"/>"
											onClick="showArea(),updateCountry(this, '<c:out value="${country.countryId}" />', '<c:out value="${strEscapeUtil:escapeJS(country.countryName)}" />', '<c:out value="${strEscapeUtil:escapeJS(country.countryCode)}" />' );"
											width="18" height="20" class="icon"></sec:authorize><sec:authorize access="hasRole('Delete Country')"><img
											src="resources/images/ico_delete.gif"
											onClick="showArea(),document.form.countryId.value='${country.countryId}';
                        deleteCountry(this);"
											title="<spring:message code="REF.UI.DELETE"/>" width="18"
											height="20" class="icon"></sec:authorize></td>
									</tr>
								</c:forEach>
							</c:when>

							<c:otherwise>
								<tr>
									<td width="830">
									<h5><spring:message code="REF.UI.COUNTRY.EMPTY" /></h5>
									</td>
									<td nowrap class="right"></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</table>
			</div>
			</div>
		
	
	<div class="button_row">
	<div class="float_right"><sec:authorize
		access="hasRole('Add/Edit Country')">
		<div class="buttion_bar_type2"><input type="button"
			class="button" value="Add New Country"
			onClick="showArea(),setAddEditPane(this,'Add')
                  if (document.form.countryName.value != null) {
						 document.form.countryName.value='';
						 document.form.countryCode.value='';
						 document.form.countryId.value ='0';
					}
				"
			width="18" height="20"
			title="<spring:message code="REF.UI.MANAGE.COUNTRY.ADD"/>"></div>
	</sec:authorize></div>
	</div>
	<div class="clearfix"></div>
	<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
	<h3 id="addEditPanelTitle"><spring:message code="REF.UI.MANAGE.COUNTRY.ADD" /></h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><form:hidden path="countryId" /> <span
		class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.COUNTRY.COUNTRY.NAME" />:</label></div>

	<form:input maxlength="45" path="countryName" /></div>
	
	<div class="float_right">
	<div class="lbl_lock"> <span
		class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.COUNTRY.COUNTRY.CODE" />:</label>
				
		</div>
		
	<form:input maxlength="2" path="countryCode" /></div>
	
	<div class="float_right"></div>
	</div>
	<div class="row">
	<div class="buttion_bar_type1">
	<input type="button" class="button" onClick="saveCountry(this);"
		value="<spring:message code="REF.UI.SAVE" />"> <input
		type="button" class="button" onClick="setAddEditPane(this,'Cancel')"
		value="<spring:message code="REF.UI.CANCEL" />"></div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
</form:form></div>
</div>
<h:footer />
</body>
</html>
