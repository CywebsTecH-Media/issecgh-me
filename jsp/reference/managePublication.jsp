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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
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

<link href="resources/css/jquery.ui.core.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
	$(function() {
		$("#expiryDate").datepicker({
			changeYear : true,
			changeMonth : true,
			dateFormat : 'yy-mm-dd',
			yearRange : "c-100:c+2",
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true,
			minDate : new Date()
		});
	});
	
	var oldHeader, oldExpireDate, oldType , oldMessage ;
	function updatePublication(thisObject, editedId, header,expiryDate,message,select) {
		setAddEditPane(thisObject, 'Edit');
		oldHeader= header;
		oldExpireDate= expiryDate;
		oldType=select;
		oldMessage=message;
		
		document.form.publicationId.value = editedId;
		document.getElementById("header").value =header ;
		document.getElementById("expiryDate").value =expiryDate ;
		document.getElementById("message").value =message;
		document.getElementById("select").value=select;
		
		
	}

	function deletePublication(thisObject, editedId) {
		document.form.publicationId.value = editedId;
		var elementWraper = $(thisObject).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObject).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action = 'manageDeletePublication.htm';
			document.form.submit();
		};

		var cancelfunction = function(){
			$(thisObject).parents('tr').removeClass('highlight');
		};

		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';

		confirm_function(message, okfunction, cancelfunction);

	}
	
	
function savePublication(thisObject) {
		
		var newHeader= document.getElementById("header").value;
		var newExpireDate= document.getElementById("expiryDate").value;
		var newType = document.getElementById("select").value;
		var newMessage= document.getElementById("message").value;
		var elementWraper = $(thisObject).closest('.section_box');
		
		var okfunction = function(){
			if(oldHeader == newHeader && oldExpireDate == newExpireDate && oldType == newType && oldMessage ==newMessage){
				$(".area").show();
				document.getElementsByClassName('area')[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
				}
			else{
				setAddEditPane(thisObject, 'Save');
				document.form.action = "saveOrUpdatePublication.htm";
				document.form.submit();
			}
		};
		
		var cancelfunction = function(){};
		
		var message = '<spring:message code="REF.SAVE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
		
	}

	function addPublication() {
		document.form.publicationId.value = 0;
		document.form.header.value = '';
		document.form.message.value = '';
		document.form.expiryDate.value = '';
		document.form.image.value = '';
		document.form.notify.checked = false;		
		document.getElementById('select').value = document
				.getElementById('selectOption').value;
	}


	function load(selectedPublication, publicationList) {

		if (selectedPublication != null && publicationList != null) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
			});
		}
	}

	window.onload = function() {
		if (document.getElementById('divSection')) {
			document.getElementById('section').style.display = "";
		}
	}

	function showArea() {
		$(document).ready(function() {
// 			$("#area").hide();
			$(".area").hide();
		});
	}
	function clearMessage() {
		$(document).ready(function() {
			$("#validate").hide();
		});
	}
	
	function editPublication(thisObj) {
		var elementWraper = $(thisObj).closest('section_full_inside');
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisObj.title);
		document.form.action = "getPublicationToEdit.htm";
		document.form.submit();
	}
	
	
	function maxLengthSize(text) 
{
    var maxlength = 160; 
    var object = document.getElementById(text.id) 
    if (object.value.length > maxlength) 
    {
        object.focus(); 
        object.value = text.value.substring(0, maxlength); 
        object.scrollTop = object.scrollHeight; 
        return false;
    }
    return true;
}
	
	
	
</script>
</head>
<body
	onload="load('<c:out value="${editPublication.publicationId}"/>','<c:out value="${findPublication}" />')">
	<h:headerNew parentTabId="26" page="referenceModule.htm" />
	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"><spring:message
								code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.NEWS_EVENT.TITLE" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/managePublicationHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="REF.UI.HELP" /> </a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REF.UI.NEWS_EVENT.TITLE" />
		</h1>
		<div id="content_main">
			<div class="section_box">
				<div id="search_results">
					<div class="section_box_header">
						<h2>
							<spring:message code="REF.UI.NEWS_EVENT.PUBLICATION" />
						</h2>
					</div>

					<div id="validate">
						<c:if test="${SmsMessageStatus != null}">
							<label class="success_sign_publication">${SmsMessageStatus}</label>
						</c:if>

						<c:if test="${SmsMessageStatusNegative != null}">
							<label class="error_sign_publication">${SmsMessageStatusNegative}</label>
						</c:if>
					</div>

					<div class="clearfix"></div>
					<div class="area">
						<c:if test="${message != null}">
							<div>
								<label class="required_sign">${message}</label>
							</div>
						</c:if>
						<label class="required_sign"> <spring:bind
								path="publication.*">
								<c:forEach items="${status.errorMessages}" var="error">
									<c:out value="${error}" />
									<br>
								</c:forEach>
							</spring:bind> </label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th width="480"><spring:message
										code="REF.UI.PUBLICATION.HEADER" /></th>
								<th width="480"><spring:message
										code="REF.UI.PUBLICATION.MESSAGE" /></th>
								<th width="480">Informed To Parent</th>
								<th width="140"><spring:message
										code="REF.UI.PUBLICATION.TYPE" /></th>
								<th width="200"><spring:message
										code="REF.UI.PUBLICATION.EXPIRE_DATE" /></th>
								<th width="64" align="right" class="right"><sec:authorize
										access="hasAnyRole('Add/Edit News and Events')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="setAddEditPane(this,'Add'); addPublication(); showArea(); clearMessage();"
											width="18" height="20"
											title="<spring:message code="REF.UI.NEWS_EVENT.SUB_FORM.ADD.TITLE"/>">
									</sec:authorize></th>
							</tr>
							<c:if test="${editPublication ne null}">
								<div>
									<input type="hidden" id="divSection" />
								</div>
							</c:if>
							<c:choose>
								<c:when test="${not empty publicationList}">
									<c:if test="${publicationList ne null}">
										<c:forEach items="${publicationList}" var="publication"
											varStatus="status">
											<tr
												<c:if test="${selectedObjId != null && (selectedObjId == publication.publicationId)}">class="highlight"</c:if>
												<c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>

												<td
													<c:if test="${editPublication.publicationId == publication.publicationId }"> id ="flag"</c:if>><c:out
														value="${publication.header}" /></td>
												<td class="publication_align"><c:out
														value="${publication.message}" /></td>
												<td><c:out
														value="${publication.notify == true ?'Yes':'No'}" /></td>
												<td><c:out value="${publication.pType.type}" /></td>
												<td><c:out value="${publication.expiryDate}" /></td>
												<td nowrap class="right"><sec:authorize
														access="hasAnyRole('Add/Edit News and Events')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="REF.UI.PUBLICATION.IMAGE.EDIT"/>"
														onClick="updatePublication(this,'<c:out value="${publication.publicationId}" />','<c:out value="${strEscapeUtil:escapeJS(publication.header)}" />',
															'<c:out value="${publication.expiryDate}" />','<c:out value="${strEscapeUtil:escapeJS(publication.message)}"/>','${publication.pType.pTypeId}');"
					 										editPublishImage(this); showArea(); clearMessage();"
															width="18" height="20" class="icon">
													</sec:authorize> <sec:authorize
														access="hasAnyRole('Delete News and Events')">
														<img src="resources/images/ico_delete.gif"
															onClick="showArea(); clearMessage(); deletePublication(this , '<c:out value = "${publication.publicationId}"/>');"
															title="<spring:message code="REF.UI.DELETE"/>" width="18"
															height="20" class="icon">
													</sec:authorize></td>
											</tr>
										</c:forEach>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830">
											<h5>
												<spring:message code="REF.UI.PUBLICATION.NO.RESULT" />
											</h5>
										</td>
										<td nowrap class="right"></td>
										<td nowrap class="right"></td>
										<td nowrap class="right"></td>
										<td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
				<form:form action="" commandName="publication" method="post"
					name="form" enctype="multipart/form-data">
					<div class="section_full_inside" id="section"
						style='display: ${showEditWindow != null || (editPublication != null) ?'block':'none'}'>
						<c:if test="${subformheader != null}">
							<h3>
								<spring:message code="REF.UI.NEWS_EVENT.SUB_FORM.TITLE" />
							</h3>
						</c:if>

						<c:if test="${subformheader == null}">
							<h3>
								<spring:message code="REF.UI.NEWS_EVENT.SUB_FORM.ADD.TITLE" />
							</h3>
						</c:if>

						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span>
										<spring:message code="REF.UI.PUBLICATION.HEADER" />
									</div>
									<form:hidden path="publicationId" />
									<form:input path="header" maxlength="45" />
								</div>
								<div class="float_right_mpub">
									<div class="lbl_lock">
										<span class="required_sign">*</span>
										<spring:message code="REF.UI.PUBLICATION.TYPE" />
									</div>
									<form:select path="pType.pTypeId" class="mpub_input_select_textarea"
										 id="select">
										<form:option value="0" id="selectOption">
											<spring:message code="application.drop.down" />
										</form:option>
										<form:options itemLabel="type" items="${publicationTypeList}"
											itemValue="pTypeId" />
									</form:select>
								</div>
							</div>
							<div class="row">

								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span>
										<spring:message code="REF.UI.PUBLICATION.EXPIRE_DATE" />
									</div>
									<div class="lbl_lock">
										<form:input id="expiryDate" cssClass="date_field"
											path="expiryDate" readonly="true" />
									</div>
								</div>

								<div class="float_right" style="margin-top:-2px;">
									<div class="lbl_lock_mpub">
										<span class="required_sign">*</span>
										<spring:message code="REF.UI.PUBLICATION.MESSAGE" />
									</div>
									<form:textarea path="message" class="mpub_textarea" onKeyUp="javascript:maxLengthSize(this);" onChange="javascript:maxLengthSize(this);"/>


								</div>

								<br class="clearfix">

								<div class="float_right"
									style="margin-right: 250px; margin-top: 0;">
									<font size="1">(Maximum characters: 160)</font><br>
									<form:checkbox path="notify" cssClass="checkbox"
										value="checkbox" />
									Notify Via SMS
									<!--<form:checkbox path ="notify" value="" style="width:20px;"/>Notify Via SMS -->
									<!--<input type="checkbox" name="notice" value="true">Notify Via SMS -->
								</div>
							</div>

							<div class="row">
								<div class="buttion_bar_type1">
									<sec:authorize access="hasAnyRole('Add/Edit News and Events')">
										<input type="button" class="button"
											onClick="savePublication(this)";
											value="<spring:message code="REF.UI.SAVE"/>">
										<input type="button" class="button"
											onClick="setAddEditPane(this,'Cancel'); showArea();"
											value="<spring:message code="REF.UI.CANCEL"/>">
									</sec:authorize>
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

