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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
		if (document.methodOfTravelForm.travelMethod.value != null) {
			document.methodOfTravelForm.travelMethod.value = '';
		}
		document.methodOfTravelForm.travelId.value = 0;
	}


	function saveMethodOfTravel(thisValue) {
		var textValue = document.getElementById("travelMethod").value;
		if(textValue == oldTravelMethod){
			$(".area").show();
			document.getElementsByClassName("area")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
		setAddEditPane(thisValue, 'Save');
		document.methodOfTravelForm.action = "saveOrUpdateMethodOfTravel.htm";
		document.methodOfTravelForm.submit();
		}
	}

	var oldTravelMethod;
	function updateMethodOfTravel(thisValue, selectedValue, travelMethod) {
	oldTravelMethod=travelMethod;
	setAddEditPane(thisValue, 'Edit');
	document.methodOfTravelForm.travelId.value = selectedValue;
	document.methodOfTravelForm.travelMethod.value = travelMethod;
	}

	function deleteMethodOfTravel(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.methodOfTravelForm.travelId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.methodOfTravelForm.action = "manageDeleteMethodOfTravel.htm";
			document.methodOfTravelForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);		
	}
	
	function load(thisValue) {
		var flagVal = null;
		if (!(thisValue == null || thisValue == "")) {
			flagVal = thisValue;
		}
		if (flagVal != null) {
			//$(document).ready(function() {
				//$("#flag").parents('tr').addClass('highlight');
			//});

		} else {
			$(document).ready(function() {
				$(".section_full_inside").hide();
			});
		}
	}
	
   function showArea(){
	   $(document).ready(function() {
			$(".area").hide();
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
					<li><spring:message code="REF.UI.METHOD_OF_TRAVEL.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageMethodOfTravelHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP"/> </a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.METHOD_OF_TRAVEL.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" commandName="methodOfTravel"
				name="methodOfTravelForm">

				<form:hidden path="travelId" />

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.METHOD_OF_TRAVEL.SUB_TITLE"/></h2>
						</div>
						<div class="area" >
							<label class="required_sign">
							<form:errors path="travelId" /> 
							<br/>
							<form:errors path="travelMethod" /> 
							</label>
							<c:if test="${message != null}">
								<label class="required_sign">${message}</label>
							</c:if>	
							<c:if test="${message_er != null}">
								<label class="success_sign">${message_er}</label>
							</c:if>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message code="REF.UI.METHOD_OF_TRAVEL.DESCRIPTION"/></th>
									<th width="78" class="right">
									
									<sec:authorize access="hasRole('Save or Update a Method of Travel')">
									
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="showArea();addNew(this)" width="18" height="20"
										title="<spring:message code="REF.UI.METHOD_OF_TRAVEL.SUB_FORM.TITLE"/>">
									
									</sec:authorize>
									
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty methodOfTravelList}">
										<c:forEach items="${methodOfTravelList}" var="methodOfTravel"
											varStatus="status">
											<tr
												<c:choose>
			            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
			            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
			            		</c:choose>>
												<td
													<c:if test="${selectedObj.travelMethod == methodOfTravel.travelMethod}">
															id="flag" 
												</c:if>>${methodOfTravel.travelMethod}</td>
												<td nowrap class="right">
												
												<sec:authorize access="hasRole('Save or Update a Method of Travel')">
												
												<img src="resources/images/ico_edit.gif"
													onClick="showArea();updateMethodOfTravel(this,'<c:out value="${methodOfTravel.travelId}"/>', '<c:out value="${methodOfTravel.travelMethod}"/>');"
													title="<spring:message code="REF.UI.METHOD_OF_TRAVEL.IMAGE.EDIT"/>" width="18" height="20"
													class="icon">
												
												</sec:authorize>	
												
												<sec:authorize access="hasRole('Delete a Method of Travel')">
												
												<img src="resources/images/ico_delete.gif"
													onClick="showArea();deleteMethodOfTravel(this,'<c:out value="${methodOfTravel.travelId}"/>');"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
												
												</sec:authorize>
												
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="REF.UI.METHOD_OF_TRAVEL.EMPTY"/></h5>
											</td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					
					<sec:authorize access="hasRole('Save or Update a Method of Travel')">
					
					<div class="section_full_inside">
							<h3>
						      <c:choose>
       				  <c:when test="${selectedObj.travelId > 0 }">
        		      <spring:message code="REF.UI.METHOD_OF_TRAVEL.IMAGE.EDIT"/>
    			      </c:when>
        			  <c:otherwise><spring:message code="REF.UI.METHOD_OF_TRAVEL.SUB_FORM.TITLE"/></c:otherwise>
        			  </c:choose>
							</h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.METHOD_OF_TRAVEL.DESCRIPTION"/>:</label>
									</div>
									<form:input path="travelMethod" maxlength="40"
										onkeypress="return disableEnterKey(event)" />
								</div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">
									<input type="button" value="<spring:message code="REF.UI.SAVE"/>"
										onClick="saveMethodOfTravel(this);" class="button"><input
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
