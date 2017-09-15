
<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>
    
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
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>


<!DOCTYPE HTML>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/colorPicker.css" rel="stylesheet"
	type="text/css">

<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<!-- <script language="javascript" -->
<!-- 	src="resources/js/jquery.colorPicker.min.js"></script> -->
<script language="javascript" src="resources/js/jquery.colorPicker.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$('#color').colorPicker();

	});

	function deleteWarningLevel(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action = 'manageDeleteWarningLevel.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);
	}

	var oldSelectedValue;
	var oldColorValue;
	function updateWarningLevel(thisValue, selectedValue, colorVal,
			warningLevelVal) {
	
		oldSelectedValue= selectedValue;  
		oldColorValue= colorVal;
		setAddEditPane(thisValue, 'Edit');
		document.form.description.value = selectedValue;
		document.form.color.value = colorVal;
		document.getElementById('warningLevelId').value = warningLevelVal;
		$('.colorPicker-picker').hide();
		$('#color').colorPicker({

		});

	}
	function removeElement(id) {
		var element = document.getElementById(id);
		element.parentNode.removeChild(element);
	}
	function showArea() {
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
				document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.WARNING.IMAGE.EDIT"/>";
			});		
		}
	}
		function showDown(bool){	
			//'display: ${editPane != null ?'block':'none'}'		
			var name = '${editpane != null}';
			if(bool){
			$(document).ready(function() {
			if(!name){								
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
	
	function displayMessage(){
		var newSelectedVal= document.getElementById("inputWarningLevel").value;
		var newColorVal= document.getElementById("color").value;
 		if(oldColorValue == newColorVal && oldSelectedValue == newSelectedVal){
			$(".areaBot").show();
			document.getElementsByClassName("areaBot")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
 		}
 		else{
 			var changeButtonType = document.getElementById("saveButton");
			//changeButtonType.type = "submit";Because it causes problems in Internet Explorer.
			document.form.submit();
		}
	}
	
</script>
<style type="text/css">
#label_1 {
	width: 400px;
}
</style>
<body onload="showDown(false),showErrorMessage(),load('<c:out value="${selectedObj}"></c:out>')">
	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.WARNING.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageWarningLevelHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.WARNING.TITLE" />
		</h1>
		<div id="content_main">
			<form:form action="manageSaveOrUpdateWarningLevel.htm" method="post"
				commandName="warningLevel" name="form">
				<div class="section_box">
					<div class="search_results">
						<div class="section_box_header">
							<h2>
								<spring:message code="REF.UI.WARNING.SUB_TITLE" />
							</h2>
						</div>
						<div class="area">
							<div>
							<!-- update success message comes through query string (after redirecting) -->
							<label class="success_sign"> ${param.addEditDelete}</label>
							</div>
						</div>
						<div class="areaTop">
							<c:if test="${message != null}">
								<div id="req_lbl_div">
									<label class="required_sign">${message}</label>
								</div>
							</c:if>
	
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
						</div>						
						<form:errors path="warningLevelId" cssClass="required_sign" />
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpading="0">
								<tr>
									<th width="830"><spring:message
											code="REF.UI.WARNING.LEVEL" /></th>
									<th width="757"><spring:message
											code="REF.UI.WARNING.COLOR" /></th>
									<th width="78" class="right"><sec:authorize
											access="hasRole('Add/Edit Warning Level')">

											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="showDown(true),showArea(),updateWarningLevel(this,'','',
													0)"
												width="18" height="20"
												title="<spring:message code="REF.UI.WARNING.IMAGE.ADD"/>">
										</sec:authorize></th>
								</tr>
								<c:choose>
									<c:when test="${not empty warningLevelList}">

										<c:forEach var="warningLevel" items="${warningLevelList}"
											varStatus="status">
											<c:choose>
												<c:when test="${(status.count) % 2 == 0}">
													<tr class="odd">
												</c:when>
												<c:otherwise>
													<tr class="even">
												</c:otherwise>
											</c:choose>

											<td width="830"
												<c:if test="${selectedObj.description == warningLevel.description }">
					id="flag" 
				</c:if>>

												<c:out value="${warningLevel.description}"></c:out>

											</td>
											<td><input type="text" disabled="disabled"
												style="background-color:${warningLevel.color};width:10px;height:10px">
											</td>
											<td nowrap class="right"><sec:authorize
													access="hasRole('Add/Edit Warning Level')">
													<img id="edit" src="resources/images/ico_edit.gif"
														title="<spring:message code="REF.UI.WARNING.IMAGE.EDIT"/>"
														onClick="showDown(true),showArea(),updateWarningLevel(this,'<c:out value="${strEscapeUtil:escapeJS(warningLevel.description)}" />','<c:out value="${warningLevel.color}" />','<c:out value="${warningLevel.warningLevelId}" />');"
														width="18" height="20" class="icon">
												</sec:authorize> <sec:authorize access="hasRole('Delete Warning Level')">

													<img src="resources/images/ico_delete.gif"
														onClick="showArea(),document.form.warningLevelId.value='${warningLevel.warningLevelId}';
					                  deleteWarningLevel(this);"
														title="<spring:message code="REF.UI.DELETE"/>" width="18"
														height="20" class="icon">
												</sec:authorize></td>

										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830">
												<h5>
													<spring:message code="REF.UI.PUBLICATION.NO.RESULT" />
												</h5>
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
						<c:if test="${message != null}">
							<div id="req_lbl_div">
								<label class="required_sign">${message}</label>
							</div>
						</c:if>

						<div>
							<form:errors path="description" cssClass="required_sign" />
						</div>
					</div>

					<sec:authorize access="hasRole('Add/Edit Warning Level')">

						<div class="section_full_inside" style='display: ${editPane != null ?'block':'none'}'>
							<h3 id="editpanetitle">
								<spring:message code="REF.UI.WARNING.SUB_FORM.TITLE" />
							</h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<span class="required_sign">*</span><label><spring:message
													code="REF.UI.WARNING.LEVEL" />:</label>
										</div>


										<form:input id="inputWarningLevel" path="description" maxlength="45" />
									</div>
									<div class="float_right" >
										<div class="lbl_lock" style="padding-right:300px; margin-top:-9px;">
											<span class="required_sign">*</span><label id="label_1"><spring:message
													code="REF.UI.WARNING.COLOR" />:</label>
										</div>
										<div>
											<div
												style="display: inline; position: relative; width: 90px; float: left;">
												<c:if test="${not empty warningLevel.color}">
										     		<input id="color" name="color" type="text" value="${warningLevel.color}" />.					
												</c:if>
												<c:if test="${empty warningLevel.color}">
										     		<input id="color" name="color" type="text" value="#FFFFFF" />				
												</c:if>
												
											</div>
											<div
												style="display: inline; position: relative; width: 30px; float: left;">
												<img src="resources/images/colorPicker.png" width="15"
													height="15">
											</div>
										</div>
										<!-- form:input path="color" /-->

									</div>

								</div>

								<div class="row">
									<div class="buttion_bar_type1">
										<input type="button" id="saveButton" class="button" onClick="displayMessage()"
											value="<spring:message code="REF.UI.SAVE"/>"><input
											type="button" class="button"
											onClick="showArea(),setAddEditPane(this,'Cancel')"
											value="<spring:message code="REF.UI.CANCEL"/>">
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</sec:authorize>
					<form:hidden path="warningLevelId" />
					<div class="clearfix"></div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>