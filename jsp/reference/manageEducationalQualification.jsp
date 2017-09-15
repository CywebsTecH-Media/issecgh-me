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

<link rel="stylesheet" type="text/css"
	href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	
	var titleName = "0";
	var qualificationType = "";
	var studyAreaTxt = "";
	
	$(document).ready(function(){
		
		$("#titleId").click(function(){
			titleName = $('#titleId').val();
			if(titleName != 0){
				titleName = $('#titleId option:selected').text() + " ";
				$('#descLabel').text(titleName + qualificationType + studyAreaTxt);						
			}
		});
		
		$("#specialRadio").click(function(){
			qualificationType = "(Special) ";
			if(titleName != 0){					
				$('#descLabel').text(titleName + qualificationType + studyAreaTxt);		
			}
		});
			
		$("#generalRadio").click(function(){
			qualificationType = "";
			if(titleName != 0){					
				$('#descLabel').text(titleName + studyAreaTxt);		
			}
		});
		
		$('#studyArea').bind('input propertychange', function() {
			if(this.value.length == 0){
				studyAreaTxt = "";				
			}else{
				studyAreaTxt = " in " + $(this).val();
			}
			if(titleName != 0){
				$('#descLabel').text(titleName + qualificationType + studyAreaTxt);		 
			}			
		});
		
		var showP = '${showPanel}';		
		if(showP != null && showP == 'TRUE'){
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+25);
			
			$('#descLabel').text("<c:out value='${educationalQualification.description}'/>");
			
			titleName = ${educationalQualification.titleId};
			if(titleName != 0){
				document.educationalQualificationForm.titleId.value = titleName;
				titleName = $('#titleId option:selected').text() + " ";
			}
			
			if(${educationalQualification.isSpecial}){
				qualificationType = "(Special) ";
			}
			
			var tempSA = '${educationalQualification.studyArea}'; 
			if(tempSA.length != 0){
				studyAreaTxt = " in " + tempSA;
			}				
		}
	
	});
	
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		//$("#oldDataMsg").text('');
		$('#descLabel').text('');
		$('#studyArea').val('');
		$('input[value=false]:radio').attr('checked', 'checked');
		
		titleName = 0;
		qualificationType = "";
		studyAreaTxt = "";
		resetErrorMsgs();
		
		document.educationalQualificationForm.educationalQualificationId.value = 0;
		document.educationalQualificationForm.titleId.value = 0;
	}

	function saveEducationalQualification(thisValue) {
		setAddEditPane(thisValue, 'Save');
		$('#description').val($('#descLabel').text());
		document.educationalQualificationForm.action = "saveOrUpdateEducationalQualification.htm";
		document.educationalQualificationForm.submit();		
	}
	
	function updateEducationalQualification(thisValue, selectedValue,description, titleId, isSpecial, studyArea) {
			
		setAddEditPane(thisValue, 'Edit');
		resetErrorMsgs();
		document.educationalQualificationForm.educationalQualificationId.value = selectedValue;
		$('#descLabel').text(description);
		
		if(titleId == 1 ){
			$("#oldDataMsg").text("<spring:message code='REF.UI.EDUCATIONALQUALIFICATION.DESCRIPTION.OLDDATA'/>");
			document.educationalQualificationForm.titleId.value = 0;
			$('#studyArea').val('');
			$('input[value=false]:radio').attr('checked', 'checked');
		}else{
			$("#oldDataMsg").text('');
			document.educationalQualificationForm.titleId.value = titleId;
			document.educationalQualificationForm.isSpecial.value = isSpecial;
			document.educationalQualificationForm.studyArea.value = studyArea;
			$('input[value=' + isSpecial + ']:radio').attr('checked', 'checked');
		}
				
		if(document.educationalQualificationForm.titleId.value != 0 ){
			var titleIdVar =  document.educationalQualificationForm.titleId;
			titleName = titleIdVar.options[titleIdVar.selectedIndex].innerHTML + " ";		
		}else{
			titleName = '';
		}
		
		if(isSpecial){
			qualificationType = "(Special) ";
		}else{
			qualificationType = "";
		}
		
		if(studyArea.length == 0){
			studyAreaTxt = "";				
		}else{
			studyAreaTxt = " in " + studyArea;
		}
		
		
		var position = $(".section_full_inside").position();			
		scroll(0,position.top+25);
	}
	
	function resetErrorMsgs(){		
		$("#eduQIdError").text("");
		$("#descError").text("");
		$("#errorMsg").text("");
		$("#errorDelMsg").text("");
		$("#successMsg").text("");	
		$("#oldDataMsg").text("");			
	}

	function deleteEducationalQualification(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.educationalQualificationForm.educationalQualificationId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var okfunction = function() {
			$(thisValue).parents('tr').hide();
			document.educationalQualificationForm.action = "manageDeleteEducationalQualification.htm";
			document.educationalQualificationForm.submit();
		};

		var cancelfunction = function() {
			$(thisValue).parents('tr').removeClass('highlight');
		};

		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';

		confirm_function(message, okfunction, cancelfunction);
	}

	function changePanelTitle() {
		if ($('.highlight').length > 0) {
			$('#panelTitle').empty();
			$('#panelTitle').append(
					"<spring:message code='REF.UI.MANAGE.EDUCATIONAL.EDIT' />");
		}
	}
</script>
</head>
<body
	onload="changePanelTitle('<c:out value="${educationalQualification.educationalQualificationId}"/>')">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message
							code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/educationalQualificationHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /> </a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="" method="POST"
				name="educationalQualificationForm"
				commandName="educationalQualification">

				<form:hidden path="educationalQualificationId" />
				<form:hidden path="description" id="description" />

				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message
									code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION.DETAIL" />
							</h2>
						</div>
						<div>
							<c:if test="${!(message == null)}">
								<div class="error">
									&nbsp;<label id="successMsg" class="success_sign"><c:out value="${message}" />
									</label>
								</div>
							</c:if>
							<c:if test="${!(message_del_error == null)}">
								<div class="error">
									&nbsp;<label id="errorDelMsg" class="required_sign"><c:out value="${message_del_error}" />
									</label>
								</div>
							</c:if>
							
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="857">
										<spring:message	code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION" />
									</th>
									<th width="51" class="right">
										<sec:authorize access="hasRole('Add/Edit Educational Qualification')">
											<a href="#boxDiv" >
												<img src="resources/images/ico_new.gif" class="icon_new"
													onClick="clearMessages(); addNew(this);" width="18"	height="20" 
													title="<spring:message code='REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION.ADD'/>"  />
											</a>
										</sec:authorize>
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty educationalQualificationList}">
										<c:forEach items="${educationalQualificationList}"
											var="educationalQualificationData" varStatus="status">

											<c:set var="cssClass"
												value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if
												test="${((showPanel != null) && (showPanel == 'TRUE')
											 	&& (educationalQualificationData.educationalQualificationId == educationalQualification.educationalQualificationId))}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>

											<tr class="${cssClass}">
												<td>${educationalQualificationData.description}</td>
												<td nowrap class="right"><sec:authorize
														access="hasRole('Add/Edit Educational Qualification')">
														<img src="resources/images/ico_edit.gif"
															onClick="clearMessages(); updateEducationalQualification(this, '<c:out value="${educationalQualificationData.educationalQualificationId}" />',
															'<c:out value="${educationalQualificationData.description}" />', '<c:out value="${educationalQualificationData.titleId}" />',
															${educationalQualificationData.isSpecial}, '<c:out value="${educationalQualificationData.studyArea}" />');"
															title="<spring:message code="REF.UI.MANAGE.EDUCATIONAL.EDIT"/>"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize
														access="hasRole('Delete Educational Qualification')">
														<img src="resources/images/ico_delete.gif"
															onClick="clearMessages(); deleteEducationalQualification(this, '<c:out value="${educationalQualificationData.educationalQualificationId}" />');"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5>
													<spring:message
														code="REF.UI.MANAGE.EDUCATIONAL.No.QUALIFICATION.FOUND" />
												</h5></td>
											<td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					
					<div>
						<div class="required_sign">						
							&nbsp;
							<c:if test="${!(message_error == null)}">
								<div class="error">
									&nbsp;<label id="errorMsg" ><c:out value="${message_error}" /></label>
								</div>
							</c:if>
							<label id="oldDataMsg"></label>
							<form:errors path="educationalQualificationId" id="eduQIdError" />
							<form:errors path="description" id="descError" />
						</div>
					</div>
					
					<sec:authorize
						access="hasRole('Add/Edit Educational Qualification')">

						<c:set var="displayStyle"
							value="${((showPanel != null) && (showPanel == 'TRUE')) ? 'display: block;' : 'display: none;' }" />

						<div class="section_full_inside" style="${displayStyle}">
							<h3 id="panelTitle">
								<spring:message	code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION.ADD" />
							</h3>
							<div class="box_border" id="boxDiv" >
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock" style="margin-bottom:5px">
											<label><spring:message code="REF.UI.MANAGE.EDUCATIONAL.QUALIFICATION" />:</label>
											<label id="descLabel" >&nbsp;</label>
										</div>										
										<div class="clearfix"></div>
									</div>									
								</div>	
								
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">								
											<span class="required_sign">*</span>
											<label><spring:message code='REF.UI.PROFESSIONAL_QUALIFICATION.ACADEMIC_TITLE' />:</label>
										</div>
										<form:select path="titleId" id="titleId">
											<form:option value="0" id="optionTitle">
												<spring:message code='application.drop.down' />
											</form:option>
											<c:if test="${titleList != null}">
												<c:forEach var="title" items="${titleList}">
													<c:if test="${title.titleId != 1}">
														<option value="${title.titleId}">${title.description}</option>
													</c:if>
												</c:forEach>
											</c:if>
										</form:select>										
									</div>

									<div class="float_left" style="margin-left: 90px;">
										<div class="lbl_lock">
											<span class="required_sign">*</span> 
											<label><spring:message	code='REF.UI.PROFESSIONAL_QUALIFICATION.QUALIFICATION_TYPE' />:</label>
										</div>
										<div class="radio_buttion_bar_type1" style="margin-left: 10px;">
											<form:radiobutton path="isSpecial" id="generalRadio" value="false" cssClass="radio_btn" />
											<label><spring:message code='REF.UI.PROFESSIONAL_QUALIFICATION.GENERAL' /> </label>&nbsp;&nbsp;
											<form:radiobutton path="isSpecial" id="specialRadio" value="true" cssClass="radio_btn" />
											<label><spring:message code='REF.UI.PROFESSIONAL_QUALIFICATION.SPECIAL' /> </label>
										 </div>
									</div>
								</div>
								
								<div class="row">
									<div class="float_left">
									<div class="lbl_lock">
										<label><spring:message code='REF.UI.PROFESSIONAL_QUALIFICATION.STUDY_AREA' />:</label>
									</div>
									<form:input path="studyArea" id="studyArea"
										onkeypress="return disableEnterKey(event)" maxlength="40" autocomplete="off" />
									</div>
								</div>
								
								<div class="row">
									<div class="buttion_bar_type1" style="margin-top: 15px;">
										<input type="button"
											value="<spring:message code='REF.UI.SAVE' />"
											onClick="saveEducationalQualification(this);" class="button">
										<input type="button" class="button"
											onClick="clearMessages(); setAddEditPane(this,'Cancel');resetErrorMsgs()"
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
