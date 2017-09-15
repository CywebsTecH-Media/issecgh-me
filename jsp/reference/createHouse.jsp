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
<script language="javascript" src="resources/js/common.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.houseForm.name.value != null) {
			document.houseForm.name.value = '';
		}
		if (document.houseForm.colour.value != null) {
			document.houseForm.colour.value = '';
		}
		if (document.houseForm.description.value != null) {
			document.houseForm.description.value = '';
		}
		document.houseForm.houseId.value = 0;
	}

	function saveHouse(thisValue) {

		setAddEditPane(thisValue, 'Save');
		document.houseForm.action = "saveOrUpdateHouse.htm";
		document.houseForm.submit();
	}

	function updateHouse(thisValue, selectedValue, name, colour, description) {
		setAddEditPane(thisValue, 'Edit');
		document.houseForm.houseId.value = selectedValue;
		document.houseForm.name.value = name;
		document.houseForm.colour.value = colour;
		document.houseForm.description.value = description;
	}

	function deleteHouse(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.houseForm.houseId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.houseForm.action = "manageDeleteHouse.htm";
			document.houseForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
	}
	
	function load(thisValue){
		
		if (thisValue>0) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.MANAGE.HOUSE.EDIT"/>";
			});		
		}
	}
	
	function showArea() {
		$(document).ready(function() {
			$(".errmsgarea").hide();
		});
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
<body onload="load('<c:out value="${selectedObjId}"></c:out>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.HOUSE.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/createHouseHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="REF.UI.HELP" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.MANAGE.HOUSE.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="" method="POST" name="houseForm"
				commandName="house">

				<form:hidden path="houseId" />

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.MANAGE.HOUSE.DETAILS" />
							</h2>
						</div>

								<div class="errmsgarea">
						<label class="success_sign"> <c:if
								test="${message != null}">${message}</c:if> </label>
						<label class="required_sign"> <c:if
								test="${message_error != null}">${message_error}</c:if> </label>
						<form:errors path="houseId" cssClass="required_sign" /><br/>
						<form:errors path="name" cssClass="required_sign" />
					</div>


						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th><spring:message code="REF.UI.MANAGE.HOUSE" />
									</th>
									<th><spring:message code="REF.UI.MANAGE.HOUSE.COLOR" />
									</th>
									<th width="78" valign="top" class="right">
									<sec:authorize access="hasRole('Add/Edit Grade')">
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="addNew(this);showArea();" width="18" height="20"
										title="<spring:message code="REF.UI.MANAGE.HOUSE.NEW" />">
									</sec:authorize>
									</th>
								</tr>
						<c:set var="selectedHouseId" value="${house.houseId }" />
								<c:choose>
									<c:when test="${not empty houseList}">
										<c:forEach items="${houseList}" var="house" varStatus="status">
											<tr
												<c:choose>
	            		<c:when test="${displayPanel && selectedHouseId == house.houseId}">class="highlight"</c:when>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>
												<td <c:if test="${selectedObjId == house.houseId}">
															id="flag" 
												</c:if>>${house.name}</td>
												<td>${house.colour}</td>
												<td nowrap class="right">
												
												<sec:authorize access="hasRole('Save or Update a House')">
												
												<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.HOUSE.EDIT"/>"
													onClick="updateHouse(this, '<c:out value="${house.houseId}" />', '<c:out value="${house.name}" />', '<c:out value="${house.colour}" />', '<c:out value="${house.description}" />');showArea();"
													width="18" height="20" class="icon"> 
													
												</sec:authorize>
													
													
												<sec:authorize access="hasRole('Delete a House')">
													
												<img src="resources/images/ico_delete.gif" title="<spring:message code="REF.UI.DELETE"/>"
													onClick="showArea();deleteHouse(this, '<c:out value="${house.houseId}" />');"
													width="18" height="20" class="icon">
													
												</sec:authorize>
												
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td><h5><spring:message code='REF.UI.MANAGE.NO.HOUSE.FOUND' /></h5>
											</td>
											<td></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					
					<sec:authorize access="hasRole('Save or Update a House')">
					
					<spring:bind path="house.*">
						<c:set var="status" value="${status}"></c:set>
					</spring:bind>
					
					<div class="section_full_inside" style="display: ${displayPanel ?'block':'none'};">
						<h3 id="editpanetitle"><spring:message code="REF.UI.MANAGE.HOUSE.NEW" /></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="REF.UI.MANAGE.HOUSE" />:</label>
									</div>
									<form:input path="name"
										onkeypress="return disableEnterKey(event)" maxlength="45"  />
								</div>
								<div class="float_right">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="REF.UI.MANAGE.HOUSE.COLOR" />:</label>
									</div>
									<form:input path="colour" maxlength="45" />
								</div>
							</div>
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><spring:message
												code="REF.UI.MANAGE.HOUSE.DESCRIPTION" />:</label>
									</div>
									<form:textarea id="des" path="description" maxlength="45" onkeypress="return disableEnterKey(event)"/>
								</div>
								<div class="float_right"></div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" class="button" onClick="saveHouse(this);"
										value="<spring:message code="REF.UI.SAVE" />"> <input
										type="button" class="button"
										onClick="setAddEditPane(this,'Cancel');showArea();"
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
