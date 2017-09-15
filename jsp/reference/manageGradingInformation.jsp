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
		setAddEditPane(thisValue,'Add');
	    if (document.gradingForm.gradeAcronym.value != null) {
	    	document.gradingForm.gradeAcronym.value='';
		}
	    if (document.gradingForm.description.value != null) {
	    	document.gradingForm.description.value='';
		}
	    document.gradingForm.gradingId.value = 0;
	}

	function saveGrading(thisValue) {
		var newGradeVal= document.getElementById("inputGrade").value;
		var newGradeDescription= document.getElementById("inputGradeDesc").value;
		if(oldGradeVal == newGradeVal && oldGradeDescription == newGradeDescription){
			$(".areaBot").show();
			document.getElementsByClassName("areaBot")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
			setAddEditPane(thisValue,'Save');
			document.gradingForm.action = "saveOrUpdateGrading.htm";
			document.gradingForm.submit();
		}
	}
	
	var oldGradeVal, oldGradeDescription;
	function updateGrading(thisValue, selectedValue, gradeAcronym, description) {
		oldGradeVal= gradeAcronym;
		oldGradeDescription= description;
		setAddEditPane(thisValue,'Edit');
		document.gradingForm.gradingId.value = selectedValue;
		document.gradingForm.gradeAcronym.value = gradeAcronym;
		document.gradingForm.description.value = description;
	}


	function deleteGrading(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.gradingForm.gradingId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.gradingForm.action = "manageDeleteGrading.htm";
			document.gradingForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);
		
	}
	
	function showArea(){
		   $(document).ready(function() {
				$(".areaTop").hide();
				$(".areaBot").hide();
				$(".area").hide();
			});
	   }
	
	function load(thisValue){

        if (!(thisValue == null || thisValue == "")) {

                $(document).ready(function() {

                        $("#flag").parents('tr').addClass('highlight');

                        document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.GRADING.IMAGE.EDIT"/>";

                });             
        }
	}
	
	
		function showDown(bool){
			var name = '${showEditSection != null}';				
			if(bool){
			$(document).ready(function() {
			if(!name ){								
		        $(".section_full_inside").hide();			 
			}
			else{			
			$(".section_full_inside").show();
			var position = $(".section_full_inside").position();			
			scroll(0,position.top);	
			}
			});
			}
			else{													
			var position = $(".section_full_inside").position();			
			scroll(0,position.top);	
			}
			}
		
		function showErrorMessage(){
			if(${del!= null}){	
				$(".areaBot").hide();
			}
			else{
				$(".areaTop").hide();
			}
		}

</script>
</head>
<body onLoad="showDown(false),showErrorMessage();" onLoad="<c:if test="${selectedObj != null}">load('<c:out value="${selectedObj}"></c:out>')</c:if>">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.GRADING.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageGradingInformationHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="REF.UI.HELP"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.GRADING.TITLE"/></h1>
		<div id="content_main">
			<form:form action="" method="POST" commandName="grading"
				name="gradingForm">

				<form:hidden path="gradingId" />

				<div class="clearfix"></div>
				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.GRADING.SUB_TITLE"/></h2>
						</div>
						<div class="area">
							<div>
							<!-- update success message comes through query string (after redirecting) -->
							<label class="success_sign"> ${param.addEditDelete}</label>
							</div>
						</div>
						<div class="areaTop">
							<label class="required_sign"> <c:if
									test="${message != null}">${message}</c:if> <form:errors
									path="*" />
							</label>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="93"><spring:message code="REF.UI.GRADING.NAME"/></th>
									<th width="708"><spring:message code="REF.UI.GRADING.DESCRIPTION"/></th>
									<th width="107" class="right">
									
									<sec:authorize access="hasRole('Save or Update a Grading Information')">
									
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="showDown(true),showArea();addNew(this)" width="18" height="20"
										title="<spring:message code="REF.UI.GRADING.SUB_FORM.TITLE"/>">
									
									</sec:authorize>
									
									</th>
								</tr>
								<c:choose>
									<c:when test="${not empty gradingList}">
										<c:forEach items="${gradingList}" var="grading"
											varStatus="status">
											<tr
												<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
		            		<td <c:if test="${selectedObj.gradeAcronym == grading.gradeAcronym }">
															id="flag" 
												</c:if>>${grading.gradeAcronym}</td>
							<td <c:if test="${selectedObj.description == grading.description }">
															id="flag" 
												</c:if>>${grading.description}</td>
												<td nowrap class="right">
												
												<sec:authorize access="hasRole('Save or Update a Grading Information')">
												
												<img src="resources/images/ico_edit.gif"
													onClick="showDown(true),showArea();updateGrading(this,'<c:out value="${grading.gradingId}" />', '<c:out value="${grading.gradeAcronym}" />', '<c:out value="${grading.description}" />');"
													title="<spring:message code="REF.UI.GRADING.IMAGE.EDIT"/>" width="18" height="20" class="icon">
													
												</sec:authorize>
												
												<sec:authorize access="hasRole('Delete a Grading Information')">
													<img src="resources/images/ico_delete.gif"
													onClick="showArea();deleteGrading(this,'<c:out value="${grading.gradingId}" />');"
													title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
												
												</sec:authorize>
												
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="REF.UI.GRADING.EMPTY"/></h5>
											</td>
											<td nowrap class="right"></td>
											<td></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
					<div class="areaBot">
						<label class="required_sign"> <c:if
								test="${message != null}">${message}</c:if> <form:errors
								path="*" />
						</label>
					</div>
					
					<sec:authorize access="hasRole('Save or Update a Grading Information')">
					
					<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
						<h3 id="editpanetitle"><spring:message code="REF.UI.GRADING.SUB_FORM.TITLE"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.GRADING.NAME"/>:</label>
									</div>
									<form:input id="inputGrade" path="gradeAcronym" maxlength="1" />

								</div>
							</div>
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="REF.UI.GRADING.DESCRIPTION"/>:</label>
									</div>
									<form:input id="inputGradeDesc" path="description" maxlength="45"/>
								</div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">
									<input type="button" onClick="saveGrading(this);"
										class="button" value="<spring:message code="REF.UI.SAVE"/>"><input type="button" class="button"
										onClick="showArea();setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>">
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="clearfix"></div>
					</div>
					
					</sec:authorize>
					
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
