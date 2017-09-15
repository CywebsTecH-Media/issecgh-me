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

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	function deletePrefectType(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action='manageDeletePrefectType.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);
		
	}
	
	
	
	
	function load(thisValue){
		
        if (!(thisValue == null || thisValue == 0)) {
                $(document).ready(function() {
                        $("#flag").parents('tr').addClass('highlight');
                        document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.PREFECT.IMAGE.EDIT"/>";

                });             
        }
	}

	
	function showArea() {
		$(document).ready(function() {
			$("#errmsgarea").hide();
		});
	}

	
	
</script>
</head>

<body onload="load('<c:out value="${selectedObj.prefectTypeId}"></c:out>')">

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
					<li><spring:message code="REF.UI.PREFECT.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/managePrefectTypeHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle">
				<spring:message code="REF.UI.HELP" />
				</a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.PREFECT.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="manageSaveOrUpdatePrefectType.htm" method="post"
				commandName="prefectType" name="form">

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.PREFECT.SUB_TITLE" />
							</h2>
						</div>
						<div id="errmsgarea">
							<c:if test="${message != null}">
								<div>
									<label class="success_sign">${message}</label>
								</div>
							</c:if>
							
							<c:if test="${message_error != null}">
								<div>
									<label class="required_sign">${message_error}</label>
								</div>
							</c:if>
						
						<div>
							<form:errors path="description" cssClass="required_sign" />
						</div>
						<form:errors path="prefectTypeId" cssClass="required_sign" />
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message code="REF.UI.PREFECT.TYPE" />
									</th>
									<th width="78" class="right"><sec:authorize
											access="hasRole('Save or Update a Prefect Type')">

											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="showArea();setAddEditPane(this,'Add')
                  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.form.prefectTypeId.value='0';
					}
                  "
												width="18" height="20"
												title="<spring:message code="REF.UI.PREFECT.IMAGE.ADD"/>">
										</sec:authorize></th>
								</tr>
								<c:choose>
									<c:when test="${not empty prefectTypeList}">
										<c:forEach var="prefectType" items="${prefectTypeList}"
											varStatus="status">
											<c:choose>
												<c:when test="${(status.count) % 2 == 0}">
													<tr class="odd">
												</c:when>
												<c:otherwise>
													<tr class="even">
												</c:otherwise>
											</c:choose>

 
 					<td <c:if test="${selectedObj.description == prefectType.description }">
															id="flag" 
												</c:if>>${prefectType.description}</td>
						
 
 											
											<td nowrap class="right"><sec:authorize
													access="hasRole('Save or Update a Prefect Type')">

													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="REF.UI.PREFECT.IMAGE.EDIT"/>"
														onClick="setAddEditPane(this,'Edit');
            	  	document.form.description.value='${prefectType.description}';
           	 		document.form.prefectTypeId.value='${prefectType.prefectTypeId}';showArea()"
														width="18" height="20" class="icon">

												</sec:authorize> <sec:authorize access="hasRole('Delete a Prefect Type')">

													<img src="resources/images/ico_delete.gif"
														onClick="document.form.prefectTypeId.value='${prefectType.prefectTypeId}';
                  deletePrefectType(this);showArea();"
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

					<sec:authorize access="hasRole('Save or Update a Prefect Type')">
						
 						<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
 						
							<h3 id="editpanetitle">
								<spring:message code="REF.UI.PREFECT.SUB_FORM.TITLE" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span>
											<spring:message code="REF.UI.PREFECT.TYPE" />:</label>
										</div>
										<form:hidden path="prefectTypeId" />

										<form:input path="description" maxlength="45" />
									</div>
									<div class="float_right"></div>
								</div>
								<div class="row">
									<div class="buttion_bar_type1">
										<input type="submit" class="button"
											value="<spring:message code="REF.UI.SAVE"/>"><input
											type="button" class="button"
											onClick="setAddEditPane(this,'Cancel');showArea();"
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
