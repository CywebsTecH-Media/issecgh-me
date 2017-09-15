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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
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

	function deleteEmploymentStatus(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action='manageDeleteEmploymentStatus.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);
		
	}
	
	function load(thisValue){
		var flagVal = null;
		if (!(thisValue == null || thisValue == "")) {
			flagVal = thisValue;
		}
		if (flagVal != null) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
			});			

		} /* else {
			$(document).ready(function() {
				$(".section_full_inside").hide();
			});
		} */
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
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageEmploymentStatusHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.TITLE"/></h1>
		
		<div id="content_main">
			<form:form action="manageSaveOrUpdateEmploymentStatus.htm" method="post"
				commandName="employmentStatus" name="form">
			
			 
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.NAME.DETAILS"/></h2>
						</div>
						<div id="area">
							<label class="required_sign"> 
								<c:if test="${message != null}">${message}</c:if> 
								<form:errors path="description" cssClass="required_sign" />
							</label>	
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr><th width="830"><spring:message
											code="REF.UI.MANAGE.EMPLOYMENTSTATUS.NAME" />
									</th>
									<th width="78" class="right">
									<sec:authorize access="hasRole('Save or Update a Employment Status')">
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="setAddEditPane(this,'Add');showArea()
                  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.form.employmentStatusId.value='0';
					}
                  "
										width="18" height="20" title='Add New Employment Status'>
										</sec:authorize>


									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty employmentStatusList}">
										<c:forEach var="employmentStatus"
											items="${employmentStatusList}" varStatus="status">
											<c:choose>
												<c:when test="${(status.count) % 2 == 0}">
													<tr class="odd">
												</c:when>
												<c:otherwise>
													<tr class="even">
												</c:otherwise>
											</c:choose>
											<td <c:if test="${selectedObj.description == employmentStatus.description }">
															id="flag"  
												</c:if>><c:out value="${employmentStatus.description}"></c:out>
											</td>
											<td nowrap class="right">
											<sec:authorize access="hasRole('Save or Update a Employment Status')">
											<img src="resources/images/ico_edit.gif"
												title="<spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.EDIT"/>"
												onClick="setAddEditPane(this,'Edit');
            	  	document.form.description.value='${employmentStatus.description}';
           	 		document.form.employmentStatusId.value='${employmentStatus.employmentStatusId}';showArea()"
												width="18" height="20" class="icon">
											</sec:authorize> 
											<sec:authorize access="hasRole('Delete Employment Status')">	
											<img src="resources/images/ico_delete.gif"
												onClick="showArea(); document.form.employmentStatusId.value='${employmentStatus.employmentStatusId}';
                  deleteEmploymentStatus(this)"
												title="<spring:message code="REF.UI.DELETE"/>" width="18"
												height="20" class="icon">
											</sec:authorize></td>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td>
												<h5>
													<spring:message
														code='REF.UI.MANAGE.NO.STAFFLEAVETYPES.FOUND' />
												</h5></td>
											<td></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					
					
					
					<div class="section_full_inside" style='display: ${message != null ?'block':'none'}'>
						<h3><spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="REF.UI.MANAGE.EMPLOYMENTSTATUS.NAME"/>:</label>
									</div>
									<form:hidden path="employmentStatusId" />	
									<form:input path="description" maxlength="45"/>
								</div>
								<div class="float_right"></div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="submit" class="button" value="<spring:message code="REF.UI.SAVE"/>" onclick="showArea()">
									<input type="button" class="button" onClick="setAddEditPane(this,'Cancel'),showArea()" 
									value="<spring:message code="REF.UI.CANCEL"/>">
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
