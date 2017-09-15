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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
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

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function saveClubSociety(thisValue) {

		setAddEditPane(thisValue, 'Save');
		document.clubSocietyForm.action = "saveOrUpdateClubSociety.htm";
		document.clubSocietyForm.submit();

	}

	function addClubSociety(thisValue) {

		document.forms["clubSocietyForm"]["name"].value = "";
		document.forms["clubSocietyForm"]["description"].value = "";
		document.clubSocietyForm.clubSocietyId.value = 0;
		setAddEditPane(thisValue, 'Add');
	}

	function updateClubSociety(thisValue, selectedValue, selectedName,
			selectedDes) {

		setAddEditPane(thisValue, 'Edit');
		document.clubSocietyForm.clubSocietyId.value = selectedValue;
		document.forms["clubSocietyForm"]["name"].value = selectedName;
		document.forms["clubSocietyForm"]["description"].value = selectedDes;
	}

	function deleteClubSociety(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.clubSocietyForm.clubSocietyId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			document.clubSocietyForm.clubSocietyId.value = selectedValue;
			document.clubSocietyForm.action = "manageDeleteClubSociety.htm";
			document.clubSocietyForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}

	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
		});
	}

	function reSet(thisValue) {

		document.forms["clubSocietyForm"]["name"].value = "";
		document.forms["clubSocietyForm"]["description"].value = "";
		document.clubSocietyForm.clubSocietyId.value = 0;
		setAddEditPane(thisValue, 'Cancel');
	}
	
	function load(thisValue){
			
		if (!(thisValue == null || thisValue == "")) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.MANAGE.CLUBS.EDIT"/>";
			});		
		}
	}
	

	
	
	
	
	
	
	
	
	
	
	//limit textarea description for ie8
	
	$(document).ready(function() {  
  
    $('textarea#des[maxlength]').keyup(function(){  
        //get the limit from maxlength attribute  
        var limit = parseInt($(this).attr('maxlength'));  
        //get the current text inside the textarea  
        var text = $(this).val();  
        //count the number of characters in the text  
        var chars = text.length;  
  
        //check if there are more characters then allowed  
        if(chars > limit){  
            //and if there are use substr to get the text before the limit  
            var new_text = text.substr(0, limit);  
  
            //and change the current text with the new text  
            $(this).val(new_text);  
        }  
    });  
  
});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

</script>
</head>












<body onload="load('<c:out value="${selectedObj}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm"/>

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.CLUBS.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageClubSocietyHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.CLUBS.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" name="clubSocietyForm"
				commandName="clubSociety">
				<form:hidden path="clubSocietyId" />
				
				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.CLUBS.DETAILS"/></h2>
						</div>
						<div id="area">
							<c:if test="${message != null}"><font class="required_sign">&nbsp;&nbsp;&nbsp;<c:out value="${message}"
							escapeXml="false"/></font></c:if>
		
	  						<c:if test="${assginMessage != null}"><font class="success_sign">&nbsp;&nbsp;&nbsp;<c:out value="${assginMessage}"
							escapeXml="false"/></font></c:if>
							<form:errors path="name" id="errormsg" class="required_sign" />
							<form:errors path="description" id="errormsg"
								class="required_sign" />
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message code="REF.UI.MANAGE.CLUBS.CLUB"/></th>
									<th width="78" class="right">
									
									<sec:authorize access="hasRole('Save or Update a Club and Society')">
									
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="addClubSociety(this),showArea()" width="18"
										height="20" title="<spring:message code="REF.UI.MANAGE.CLUBS.ADD"/>">
									
									</sec:authorize>
									
									</th>
								</tr>

								<c:choose>
									<c:when test="${not empty clubSocietyList}">
										<c:forEach items="${clubSocietyList}" var="clubSociety"
											varStatus="status">
											<tr
												<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>
												<td width="830"
													<c:if test="${selectedObj.name == clubSociety.name }">
															id="flag" 
												</c:if>>${clubSociety.name}
												</td>
												<td nowrap class="right">
												
												<sec:authorize access="hasRole('Save or Update a Club and Society')">
												
												<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.CLUBS.EDIT"/>"
													onClick="updateClubSociety(this,'<c:out value="${clubSociety.clubSocietyId}" />','<c:out value="${strEscapeUtil:escapeJS(clubSociety.name)}"/>', '<c:out value="${strEscapeUtil:escapeJS(clubSociety.description)}"/>'),showArea()"
													width="18" height="20" class="icon"> 
												</sec:authorize>
												
												<sec:authorize access="hasRole('Delete a Club and Society')">
												
												<img src="resources/images/ico_delete.gif"
													onClick="deleteClubSociety(this,'<c:out value="${clubSociety.clubSocietyId}" />'),showArea()"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
													
												</sec:authorize>
													
											  </td>
												
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="REF.UI.MANAGE.CLUBS.No.CLUB.FOUND"/></h5></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
	
					<sec:authorize access="hasRole('Save or Update a Club and Society')">
					
					<div class="section_full_inside" style='display: ${editPane != null ?'block':'none'}'>
						<h3 id="editpanetitle"><spring:message code="REF.UI.MANAGE.CLUBS.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="REF.UI.MANAGE.CLUBS.CLUB.NAME"/>:</label>
									</div>
									<form:input path="name" name="name" id="dataValue"
										maxlength="45" onkeypress="return disableEnterKey(event)" />
								</div>
							</div>
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><spring:message code="REF.UI.MANAGE.CLUBS.DESCRIPTION"/>:</label>
									</div>
									
									
									<form:textarea rows="0" cols="20" path="description"
										name="description" id="des" maxlength="250"
										onkeypress="return disableEnterKey(event)" />
										
										
								</div>

								<div class="buttion_bar_type1" style="margin-top: 15px;">

									<input type="button" class="button"
										onClick="saveClubSociety(this);" value="<spring:message code="REF.UI.SAVE" />"> <input
										type="button" class="button" onClick="reSet(this),showArea()"
										value="<spring:message code="REF.UI.CANCEL" />">
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
