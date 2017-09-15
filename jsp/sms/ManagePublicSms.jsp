<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.virtusa.akura.api.dto.ClassGrade"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script src="resources/js/jquery-1.8.2.min.js"></script>
<script src="resources/js/jquery-ui-1.10.2.custom.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<script type="text/javascript">
	
		
	function sendSms(form){
		document.sendSmsForm.action='sendPublicSms.htm';
	}
			
	function listbox_selectall(listID, isSelect) {
		var listbox = document.getElementById(listID);
		for ( var count = 0; count < listbox.options.length; count++) {
			listbox.options[count].selected = isSelect;
		}
	}
	
	function limitText(limitField, limitCount, limitNum) {
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} else {
			limitCount.value = limitNum - limitField.value.length;
		}
	}
	function clearMeaasage(id){
		document.getElementById(id).value = "";
	}
	
</SCRIPT>
</head>
<body>
	<h:headerNew parentTabId="53" page="publicSms.htm" />
	<div id="page_container">
		<div id="breadcrumb">
			<ul>
				<li><a href="adminWelcome.htm"><spring:message
							code="application.home" /> </a>&nbsp;&gt;&nbsp;</li>
				<li><spring:message code="SMS.STUDENTS.TITLE" /></li>
			</ul>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/other/StudentSMS.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code="application.help" />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="SMS.STUDENTS.TITLE" />
		</h1>
		<div style="padding-left:16px;">
			<label class="success_sign"> <c:if test="${message != null}"> ${message}</c:if><br>
			<c:if test="${count != null}"> 
			<label>No parents :</label>
			<label>${count}</label></c:if>
			</label>
		</div>
		<div style="padding-left:16px;">
			<label  class="required_sign"> <c:if test="${errormessage != null}"> ${errormessage}</c:if>
			</label>
		</div>
		<form:form method="POST"  name="sendSmsForm" id="form" 	>
		<div id="content_main">
					
			<div class="section_box" id="search_results">

				<div class="column_single">
					<div id="add_remove_list">
				
							<div class="lbl_lock">
							<span class="required_sign">*</span> <label><spring:message
									code='SMS.STUDENT.MESSAGE' /> </label>
						    </div>
						<br>
				<textarea  rows="4" cols="100" style="width: 395px;"  id="messageArea"  name="messageArea" 
								onkeydown="limitText(this.form.messageArea,this.form.countdown,114);"
										onkeyup="limitText(this.form.messageArea,this.form.countdown,114);"></textarea> 
								
			
					</div>
				</div>
				

				
			</div>
				<div class="button_row">
					<div class="buttion_bar_type2">
						<input type="submit" value="<spring:message code='SMS.STUDENT.SEND'/>"
							class="button" onclick="sendSms()"> 
							<input type="submit"
							value="<spring:message code='SMS.STUDENT.CANCEL'/>" class="button"
							onclick="cancel()">

					</div>
					<div class="clearfix"></div>
				</div>
				
			</div>
			</form:form>
		</div>
		<h:footer />
</body>
</html>