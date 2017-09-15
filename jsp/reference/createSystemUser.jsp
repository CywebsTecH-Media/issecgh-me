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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
	
<!-- css & js for tool tip -->
<link rel="stylesheet" href="resources/css/jquery.tooltip.css" type="text/css" />
<script type="text/javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.tooltip.js"></script>
<!-- css & js for tool tip -->

<script language="javascript" src="resources/js/main.js"></script>

<script type="text/javascript">

	$j = jQuery.noConflict();
	
	$j(document).ready(function(){
	  $j("input.item").tooltip();
	    $j("input.username_item").tooltip();
	});
	
	
	
	
	function setServiceStatus(userLoginId) {
	
		document.getElementById("smsSubscriber").checked = ${userDetail.smsSubscriber};
		document.getElementById("mobileSubscriber").checked =${userDetail.mobileSubscriber};
		
		if (userLoginId != 0) {
			$j('#username').attr('disabled', 'disabled');
		}
		
	}

	function reSet(thisValue) {
		document.systemUserForm.userIdentificationNoTxt.disabled = false;
		document.forms["systemUserForm"]["userIdentificationNoTxt"].value = "";
		document.forms["systemUserForm"]["firstName"].value = "";
		document.forms["systemUserForm"]["lastName"].value = "";
		document.forms["systemUserForm"]["email"].value = "";
		document.forms["systemUserForm"]["username"].value = "";
		document.forms["systemUserForm"]["password"].value = "";
		document.forms["systemUserForm"]["confirmPassword"].value = "";
		document.systemUserForm.userRoleId.value = "0";

	}

	function reSet2(thisValue) {
		document.forms["systemUserForm"]["password"].value = "";
		document.forms["systemUserForm"]["confirmPassword"].value = "";
		document.forms["systemUserForm"]["firstName"].value = "${userDetail.firstName}";
		document.forms["systemUserForm"]["lastName"].value = "${userDetail.lastName}";
		document.forms["systemUserForm"]["email"].value = "${userDetail.email}";
	}

	function cancel(thisValue) {
		document.systemUserForm.action = "manageSystemUsers.htm";
		document.systemUserForm.method = "GET";
		document.systemUserForm.submit();
	}

	function submitUser() {
		
		document.systemUserForm.userIdentificationNo.value = document.systemUserForm.userIdentificationNoTxt.value;
		document.systemUserForm.action = "createSystemUser.htm";
		document.systemUserForm.submit();
	}

	function changeUserIdentificationNo(selectedValue) {
		

		if (selectedValue == 2 || selectedValue == 3 || selectedValue == 4 || selectedValue == 5 ) {
			document.systemUserForm.userIdentificationNoTxt.disabled = false;
			document.getElementById("userIdentificationNo").style.display='block';
			document.getElementById("subscribeToServices").style.display='none';

			var labelEle = document.getElementById("userIdentificationNoText");
			var txtfield = document.getElementById("userIdentificationField");
			document.forms["systemUserForm"]["userIdentificationNoTxt"].value = "";
			if(selectedValue == 2){
				labelEle.innerHTML = "<spring:message code='REF.UI.MANAGE.USERS.ADMISSION.NO.STAFF' />" ;
				txtfield.maxLength = 20 ;
			}else if(selectedValue == 3){
				labelEle.innerHTML = "<spring:message code='REF.UI.MANAGE.USERS.ADMISSION.NO.STUDENT' /> ";
				txtfield.maxLength = 20 ;
			}else if(selectedValue == 4){
				labelEle.innerHTML = "<spring:message code='REF.UI.MANAGE.USERS.ADMISSION.NO.STAFF' />";
				txtfield.maxLength = 20 ;
			}else if(selectedValue == 5){
				labelEle.innerHTML = "<spring:message code='REF.UI.MANAGE.USERS.ADMISSION.NO.PARENT'/>";
				txtfield.maxLength = 45 ;
				document.getElementById("subscribeToServices").style.display='block';
			}

		} else {
			document.systemUserForm.userIdentificationNoTxt.disabled = true;
			document.getElementById("userIdentificationNo").style.display='none';
			document.getElementById("subscribeToServices").style.display='none';
		}
	}
	
	// score the password
	function scorePassword(pass) {
	    var score = 0;
	    if (!pass)
	        return score;

	    // award every unique letter until 5 repetitions
	    var letters = new Object();
	    for (var i=0; i<pass.length; i++) {
	        letters[pass[i]] = (letters[pass[i]] || 0) + 1;
	        score += 4.0 / letters[pass[i]];
	    }

	    // bonus points for mixing it up
	    var variations = {
	        digits: /\d/.test(pass),
	        lower: /[a-z]/.test(pass),
	        upper: /[A-Z]/.test(pass),
	        nonWords: /\W/.test(pass),
	    }

	    variationCount = 0;
	    for (var check in variations) {
	        variationCount += (variations[check] == true) ? 1 : 0;
	    }
	    score += (variationCount -1) * 15;

	    return parseInt(score);
	}
	
	//Good passwords start to score around 60 or so, here's function to translate that in words:
	function checkPassStrength(pass) {
		
		if(pass.length>=8){
			var score = scorePassword(pass);
		    if (score >= 80)
		        return "strong|Strong";
		    if (score < 80 && score >= 60)
		        return "good|Good";
		    if (score < 60 && score >= 30)
		        return "average|Average";
		    if (score < 30)
		        return "weak|Weak";
		}
	    return "tooshort|Too Short";
	}
	
	//rate and populate the password strenghBar
	function populateStrengthBar(pass){
		
			var bar = document.getElementById("strengthBar");
			var label = document.getElementById("strengthBarLabel");
			var div = document.getElementById("strengthBarLabeldiv");
			
		if(pass.length>0){
			var rate = checkPassStrength(pass);
			div.style.display = 'block';
			bar.className=rate.split('|')[0];
			label.innerText=rate.split('|')[1]; 
			label.textContent =rate.split('|')[1]; 
		}else{
			div.style.display = 'none';
		}
	}

</script>

</head>
<body onload=setServiceStatus(${userDetail.userLoginId});>


<h:headerNew parentTabId="39" page="manageSystemUsers.htm" />

	
<div id="page_container">
<div id="breadcrumb_area">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message
		code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
	<li><a href="manageSystemUsers.htm"><spring:message
		code="REF.UI.USER.MANAGEMENT.MANAGE.USERS" /></a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="REF.UI.MANAGE.USERS.DETAILS.TITLE" /></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/createSystemUserHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"> <spring:message code="REF.UI.HELP" /></a></div>
</div>
<div class="clearfix"></div>
<h1><spring:message code="REF.UI.MANAGE.USERS.DETAILS.TITLE" /></h1>
<div id="content_main"><form:form method="POST"
	commandName="userDetail" name="systemUserForm"
	action="createSystemUser.htm">
	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message code="REF.UI.MANAGE.USERS.DETAILS" /></h2>
	</div>
	
       <c:if test="${not empty successMessage}">
       <label class="success_sign"> <c:out value="${successMessage}" escapeXml="false" /><br /></label>
       </c:if>
       
    
	<label class="required_sign"> 
		<c:if test="${not empty message}"> ${message} </br></c:if> 
		<c:if test="${not empty dupicateUserErrormessage}"> ${dupicateUserErrormessage} </br></c:if> 
		<c:if test="${not empty userDetail}">
		<spring:bind path="userDetail.*">
			<c:if test="${not empty status.errorMessages}">
				<c:forEach var="error" items="${status.errorMessages}">
					<c:out value="${error}" escapeXml="false" />
					<br />
				</c:forEach>
			</c:if>
		</spring:bind>
		</c:if>
	</label> 
	

	<div class="column_equal">
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.ROLE" />:</label></div>
	<div class="frmvalue"><form:select path="userRoleId" disabled="${userDetail.userLoginId!=0?true:false}"
		name="userRoleId" 
		onchange="changeUserIdentificationNo(this.value);">
		<form:option value="0">
			<spring:message code="application.drop.down" />
		</form:option>
		<form:options items="${userLevelList}" itemValue="userRoleId"
			itemLabel="role" />
	</form:select></div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.USERNAME" />:</label></div>
	<div class="frmvalue"><form:input path="username" maxlength="45"
		name="username" autocomplete="off" readonly="${userDetail.userLoginId!=0?true:false}" class="username_item"/>
		
		<div class="tooltip_description" style="display: none">
					<div align="left" style="font-weight:bold;" >For username validation:</div>
					<div id="toolpipText">
		                                    <ul  >
						<li> -Username must contain at least 5 characters</li>
						
					</ul>
		        	</div>
				</div>
	</div>
	</div>
	
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.PASSWORD" />:</label></div>
		
		<div class="frmvalue">
			
			
			<div >
			<form:password path="password"
			maxlength="45" name="password" autocomplete="off" value="" onchange="populateStrengthBar(this.value)" onkeyup="populateStrengthBar(this.value)" class="item"/>
			
				<div class="tooltip_description" style="display: none">
					<div align="left" style="font-weight:bold;" >To secure your password:</div>
					<div id="toolpipText">
		                                    <ul  >
						<li> - Use both letters and numbers</li>
						<li> - Add special characters (such as $, &, ?)</li>
						<li> - Mix uppercase and lowercase letters</li>
					</ul>
		        	</div>
				</div>
       	 	</div>
		</div>
	
	</div>
	
	
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.CONFIRM.PASSWORD" />:</label></div>
		
	<div class="frmvalue">
		<input type="password" name="confirmPassword" maxlength="45" value="" onpaste="return false">
	</div>
	
	</div>
	
		<div class="row" id="strengthBarLabeldiv" style="display: none; ">
	         <div class="frmlabel"> </div>
			 
	         <div class="frmvalue">
	          <div class="passwordrow">
	          <div class="strengthBar">
	          <div id="strengthBar" class="average"></div></div> 
	          <div class="clearfix"></div>
	          <div>
	          	<strong>Password strength:</strong>
	          	 <span id="strengthBarLabel"></span>
	          </div>
	         	</div>
	         </div>
     	</div>
		
		
		
	</div> 
	
		<div class="column_equal">
	<div class="row" id="userIdentificationNo" style="display:${(userDetail.userRoleId>1)&&(userDetail.userRoleId<6)?'block':'none'}">
	<div class="frmlabel">
	<span class="required_sign">*</span>
		<label id="userIdentificationNoText">
			<c:if test="${userDetail.userRoleId==2}">
				<spring:message code="REF.UI.MANAGE.USERS.ADMISSION.NO.STAFF" />
			</c:if>
			<c:if test="${userDetail.userRoleId==3}">
				<spring:message code="REF.UI.MANAGE.USERS.ADMISSION.NO.STUDENT" />
			</c:if>
			<c:if test="${userDetail.userRoleId==4}">
				<spring:message code="REF.UI.MANAGE.USERS.ADMISSION.NO.STAFF" />
			</c:if>
			<c:if test="${userDetail.userRoleId==5}">
				<spring:message code="REF.UI.MANAGE.USERS.ADMISSION.NO.PARENT" />
			</c:if>
		
		</label><label>:</label>
	</div>
	<div class="frmvalue">
		<input id="userIdentificationField" name="userIdentificationNoTxt" value="${identificationNo}" ${userDetail.userLoginId!=0?'readonly':''}  />
	</div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.FIRST.NAME" />:</label></div>
	<div class="frmvalue"><form:input path="firstName"
		name="firstName" maxlength="45"/>
	</div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.LAST.NAME" />:</label></div>
	<div class="frmvalue"><form:input path="lastName" maxlength="45"
		name="lastName" />
	</div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.MANAGE.USERS.EMAIL.ADDRESS" />:</label></div>
	<div class="frmvalue"><form:input path="email" maxlength="45"
		name="email" /></div>
	</div>
			<div class="row" id="subscribeToServices" style="display:${(userDetail.userRoleId==5) ? 'block': 'none'};">
				<div class="frmlabel">
					<label style="display:none">Subscribe To:</label>
				</div>
				<div class="frmvalue"><!--
					<form:input path="smsSubscriber" id="smsSubscriber" class="checkbox" type="checkbox" value="true"
						name="smsSubscriber" style="display:none" /> <label class="label_inline" style="display:none">SMS Service</label> 
						--><form:input path="mobileSubscriber" id="mobileSubscriber" class="checkbox" value="true"
						type="checkbox" name="mobileSubscriber" style="display:none" /> <label class="label_inline" style="display:none">Mobile Service</label>
				</div>
			</div>
		</div>
	
	<div class="clearfix"></div>
	</div>
	<div class="button_row">
	<div class="buttion_bar_type2">
	
	<sec:authorize access="hasRole('Save or update System user')">
	
	<input type="button"
		class="button"
		onClick="${userDetail.userLoginId!=0?'reSet2(this)':'reSet(this)'}"
		value="<spring:message code="REF.UI.RESET" />" id="reset"> <input
		type="button" value="<spring:message code="REF.UI.SAVE" />"
		onclick="submitUser()"
		class="button"> <input type="button"
		value="<spring:message code="REF.UI.CANCEL" />" class="button"
		onClick="cancel(this)">
	
	</sec:authorize>	
		
		</div>
	<div class="clearfix"></div>
	</div>
	<form:input type="hidden" path="userLoginId" value="${userDetail.userLoginId}" />
	<form:input type="hidden" path="userIdentificationNo" value="${userDetail.userIdentificationNo}" />
	<c:if test="${userDetail.userLoginId!=0}">
	 	<form:input type="hidden" path="userRoleId" value="${userDetail.userRoleId}" /> 
	</c:if>
 

</form:form></div>
</div>
<h:footer />
</body>
</html>