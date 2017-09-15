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

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function deleteCity(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			document.form.action = 'manageDeleteCity.htm';
			document.form.submit();
		};

		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
	}

	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}
	
	function edit(thisVal,city,cityId,district ){		
		 setAddEditPane(thisVal,'Edit');
			document.form.description.value= city;
			document.form.cityId.value= cityId;
		
			if(district == ""){
				document.getElementById('select').value = document.getElementById('selectOption').value;
			}
			else{
				document.getElementById('select').value = district ;
			}
	}
	
	function addEditPanelTitle(cityId) {
		if(cityId > 0) {
			$('#addEditPanelTitle').empty();
			$('#addEditPanelTitle').append("<spring:message code='REF.UI.MANAGE.CITY.EDIT' />");
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
					<li><spring:message code="REF.UI.MANAGE.CITY.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageCityHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.MANAGE.CITY.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="#" method="post" name="form" commandName="city">
				<div class="section_full_search">
					<div class="box_border">
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="REF.UI.MANAGE.CITY.CITY.NAME" />:</label>
								</div>
								<input type="text" maxlength="45" name="searchDescription" value="${searchDescription}">
							</div>
							<div class="float_right">

								<div class="buttion_bar_type1">
									<input type="button"
										value="<spring:message code="REF.UI.SEARCH" />"
										onClick="document.form.action='manageSearchCity.htm'; document.form.submit();"
										class="button">
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="section_box">
					<div id="search_results">

						<div class="section_box_header">

							<h2>
								<spring:message code="REF.UI.SEARCH.RESULTS" />
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
							<div>
								<form:errors path="district.description"
									cssClass="required_sign" />
							</div>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="45%"><spring:message
											code="REF.UI.MANAGE.CITY.CITY" /></th>
									<th><spring:message code="REF.UI.MANAGE.CITY.DISTRICT" /></th>
									<th width="42" class="right"><img
										src="resources/images/ico_new.gif" class="icon_new"
										onClick="showArea(),setAddEditPane(this,'Add')
                  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.getElementById('select').value = document.getElementById('selectOption').value;
						 document.form.cityId.value ='0';
					}
				"
										width="18" height="20"
										title="<spring:message code="REF.UI.MANAGE.CITY.ADD"/>"></th>
								</tr>
								<c:choose>
									<c:when test="${searchCity != null }">
										<c:forEach var="searchCity" items="${searchCity}"
											varStatus="status">
											<tr <c:if test="${selectedObjId != null && (selectedObjId == searchCity.cityId)}">class="highlight"</c:if>
												<c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
												<td><c:out value="${searchCity.description}"></c:out></td>
												<td><c:out value="${searchCity.district.description}"></c:out>
												</td>
												<td nowrap class="right"><img
													src="resources/images/ico_edit.gif"
													title="<spring:message code="REF.UI.MANAGE.CITY.EDIT"/>"
													onClick="showArea(),edit(this,'<c:out value="${searchCity.description}" />','<c:out value="${searchCity.cityId}"/>','<c:out value="${searchCity.district.description}" />');"
													width="18" height="20" class="icon"><img
													src="resources/images/ico_delete.gif"
													onClick="showArea(),document.form.cityId.value='${searchCity.cityId}';
                        deleteCity(this);"
													title="<spring:message code="REF.UI.DELETE"/>" width="18"
													height="20" class="icon"></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
									<c:choose>
									<c:when test="${not empty cityList}">
										<c:forEach items="${cityList}" var="city" varStatus="status">
											<tr <c:if test="${selectedObjId != null && (selectedObjId == city.cityId)}">class="highlight"</c:if>
												<c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
												<td><c:out value="${city.description}"></c:out></td>
												<td><c:out value="${city.district.description}"></c:out>
												</td>
												<td nowrap class="right"><img
													src="resources/images/ico_edit.gif"
													title="<spring:message code="REF.UI.MANAGE.CITY.EDIT"/>"
													onClick="showArea(),edit(this,'<c:out value="${city.description}" />','<c:out value="${city.cityId}"/>','<c:out value="${city.district.description}" />');"
													width="18" height="20" class="icon"><img
													src="resources/images/ico_delete.gif"
													onClick="showArea(); document.form.cityId.value='${city.cityId}';
                        deleteCity(this);"
													title="<spring:message code="REF.UI.DELETE"/>" width="18"
													height="20" class="icon"></td>
											</tr>
										</c:forEach>
										</c:when>
										<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="REF.UI.CITY.EMPTY" /></h5>
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
					<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
						<h3 id="addEditPanelTitle">
							<spring:message code="REF.UI.MANAGE.CITY.ADD" />
						</h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message
												code="REF.UI.MANAGE.CITY.CITY.NAME" />:</label>
									</div>
									<form:hidden path="cityId" />
									
									<form:input maxlength="45" path="description" />
								</div>
								<div class="float_right">
									<div class="lbl_lock">
										<label><spring:message
												code="REF.UI.MANAGE.CITY.DISTRICT" />:</label>
									</div>
									<form:select path="district.description" id="select">
										<form:option value="select" id="selectOption">
											<spring:message code="application.drop.down" />
										</form:option>
										<form:options itemLabel="description" items="${districtList}"
											itemValue="description" />
									</form:select>
								</div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" class="button"
										onClick="document.form.action='manageSaveOrUpdateCity.htm'; document.form.submit();"
										value="<spring:message code="REF.UI.SAVE" />"><input
										type="button" class="button"
										onClick="showArea(),setAddEditPane(this,'Cancel')"
										value="<spring:message code="REF.UI.CANCEL" />">
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
	<h:footer />
</body>
</html>
