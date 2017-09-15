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
<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>


<script>
	
	$(function() {
		var dates = $( "#fromMonth, #toMonth" ).datepicker({
			defaultDate: "+1w",
			changeYear: true,
			changeMonth: true,
			numberOfMonths: 1,
			dateFormat: 'yy-mm-dd',
			showOn: "button",
			buttonImage: "resources/images/calendar.jpg",
			buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromMonth" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});

	</script>
<!-- END Calender controll CSS and JS -->

<script type="text/javascript">

	function addNew(thisValue) {
		setAddEditPane(thisValue,'Add');
	    if (document.termForm.description.value != null) {
	    	document.termForm.description.value='';
		}
	    if (document.termForm.fromMonth.value != null) {
	    	document.termForm.fromMonth.value='';
		}
	    if (document.termForm.toMonth.value != null) {
	    	document.termForm.toMonth.value='';
		}
	    document.termForm.termId.value = 0;
	}
	
	function saveTerm(thisValue) {
		setAddEditPane(thisValue,'Save');
		document.termForm.action = "saveOrUpdateTerm.htm";
		document.termForm.submit();
	}
	
	function updateTerm(thisValue, selectedValue, description, fromMonth, toMonth) {
		setAddEditPane(thisValue,'Edit');
		document.termForm.termId.value = selectedValue;
		document.termForm.description.value = description;
		document.termForm.fromMonth.value = fromMonth;
		document.termForm.toMonth.value = toMonth;
	}
	
	
	function deleteTerm(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		
		document.termForm.termId.value = selectedValue;
	
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	
		
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.termForm.action = "manageDeleteTerm.htm";
			document.termForm.submit();
		};
		
		var cancelfunction = function(){
			
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
	
		
			
		
	}


</script>

</head>
<body>

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.TERMS.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageTermHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.TERMS.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" commandName="term" name="termForm">

				<form:hidden path="termId" />

				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.TERMS.DETAIL"/></h2>
						</div>
						<div>
							<label class="required_sign"> 
								<c:if test="${message != null}">${message}</c:if> 
								<form:errors path="termId" /><br> 
								<form:errors path="fromMonth" /> 
								<form:errors path="description" /> 
							</label>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="184"><spring:message code="REF.UI.MANAGE.SUB.TERMS.TERM"/></th>
									<th width="198"><spring:message code="REF.UI.MANAGE.SUB.TERMS.START"/></th>
									<th width="198"><spring:message code="REF.UI.MANAGE.SUB.TERMS.END"/></th>
									<th width="55" class="right"><img
										src="resources/images/ico_new.gif" class="icon_new"
										onClick="addNew(this)" width="18" height="20"
										title="<spring:message code="REF.UI.MANAGE.TERMS.ADD"/>">
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty termList}">
										<c:forEach items="${termList}" var="term" varStatus="status">
											<tr
												<c:choose>
			            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
			            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
			            	</c:choose>>
												<td>${term.description}</td>
												<td>${term.fromMonth}</td>
												<td>${term.toMonth}</td>
												<td nowrap class="right"><img
													src="resources/images/ico_edit.gif"
													onClick="updateTerm(this,'<c:out value="${term.termId}" />','<c:out value="${term.description}" />','<c:out value="${term.fromMonth}" />','<c:out value="${term.toMonth}" />');"
													title="<spring:message code="REF.UI.MANAGE.TERMS.EDIT"/>" width="18" height="20" class="icon">
													<img src="resources/images/ico_delete.gif"
													onClick="deleteTerm(this,'<c:out value="${term.termId}" />');"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5>
											</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					<div class="section_full_inside">
						<h3><spring:message code="REF.UI.MANAGE.TERMS.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.SUB.TERMS.TERM"/>:</label>
									</div>
									<form:input path="description"
										onkeypress="return disableEnterKey(event)" maxlength="45"/>
								</div>
								<div class="float_right"
									style="margin-right: 50px; *margin-right: 10px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.SUB.TERMS.END"/>:</label>
									</div>
									<form:input path="toMonth" id="toMonth" cssClass="date_field" />
								</div>
								<div class="float_right" style="margin-right: 50px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.SUB.TERMS.START"/>:</label>
									</div>
									<form:input path="fromMonth" id="fromMonth"
										cssClass="date_field" />
								</div>

							</div>
							<div class="row">
								<div class="float_left"></div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">
									<input type="button" value="<spring:message code="REF.UI.SAVE"/>" onClick="saveTerm(this)"
										class="button"><input type="button" class="button"
										onClick="setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>">
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
