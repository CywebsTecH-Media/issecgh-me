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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
//update UserLogin
function updateStatusUserStatus(thisObj, value, userLoginId) {
	$(thisObj).parents('tr').addClass('highlight');
	
	if(value == "disable"){
		
		var message = "<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.DISABLE.CONFIRMATION'/>" ;
		
		var okfunction = function(){
			document.getElementById('selectedUserStatus').value = "0";
			document.getElementById('selectedUserLoginId').value = userLoginId;
			document.systemUserSearch.action = "updateUserStatus.htm";
			document.systemUserSearch.submit();
		};

		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );		
	}
	
	if(value == "enable"){
		
		var message = "<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.ENABLE.CONFIRMATION'/>" ;
		
		var okfunction = function(){
			document.getElementById('selectedUserStatus').value = "1";
			document.getElementById('selectedUserLoginId').value = userLoginId;
			document.systemUserSearch.action = "updateUserStatus.htm";
			document.systemUserSearch.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		confirm_function(message , okfunction, cancelfunction );
	}
	
}

//resetPassword.
function resetPassword(thisObj, userLoginId) {
		document.getElementById('selectedUserLoginId').value = userLoginId;
		document.systemUserSearch.action = "editSystemUser.htm";
        document.systemUserSearch.submit();
}

//Unlock user
function unlockUser(thisObj, userLoginId, loginAttempts) {
	if(loginAttempts<2){
		return false;
	}
	$(thisObj).parents('tr').addClass('highlight');
	
	var message = "<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.UNLOCK.CONFIRMATION'/>" ;
	
	var okfunction = function(){
		document.getElementById('selectedUserLoginId').value = userLoginId;
		document.systemUserSearch.action = "unlockUser.htm";
        document.systemUserSearch.submit();
	};

	var cancelfunction = function(){
		$(thisObj).parents('tr').removeClass('highlight');
	};

	confirm_function(message , okfunction, cancelfunction );	
}

//Delete user
function deleteUserLogin(thisObj, userLoginId) {

	$(thisObj).parents('tr').addClass('highlight');
	
	var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
	
	var okfunction = function(){
		document.getElementById('selectedUserLoginId').value = userLoginId;
		document.systemUserSearch.action = "deleteUserLogin.htm";
        document.systemUserSearch.submit();
	};

	var cancelfunction = function(){
		$(thisObj).parents('tr').removeClass('highlight');
	};

	confirm_function(message , okfunction, cancelfunction );
}

//Used of pagination in onclick event of previous and next buttons
function previousOrNext(value){
	pageSize = 10;

	if(value == "next"){
		startFrom = parseInt(${startFrom}) + pageSize;
		document.getElementById('startFrom').value = startFrom + "";

	}else if(value == "previous"){
		startFrom = parseInt(${startFrom}) - pageSize;
		document.getElementById('startFrom').value = startFrom + "";
	}

	document.getElementById('actionType').value = value;
	document.systemUserSearch.submit();
}

</script>
</head>
<body>

<h:headerNew parentTabId="37" page="manageSystemUsers.htm" />
<div id="page_container">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.TITLE"/></li>
</ul>
</div>
<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageSystemSystemUsersHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP"/></a></div>
<div class="clearfix"></div>
<h1><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.TITLE"/></h1>
<label class="required_sign"> <c:if test="${message != null}"> 
			${message}
		</c:if> </label>
<div id="content_main"><form:form method="POST"
	modelAttribute="userLoginObj" name="systemUserSearch" action="manageSystemUsers.htm">

	<div class="clearfix"></div>
	<div class="section_full_search">
	<div class="box_border">
	<div class="column">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><label><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.USER.NAME"/>:</label></div>
	<div class=""> <form:input path="username" /> </div>
	</div>
	<div class="float_left">
	<div class="lbl_lock"><label><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.USER.ROLE"/>:</label></div>
	
	<form:select path="userRoleId" name="userRole">
		<form:option value="0">
			<spring:message code="application.drop.down" />
		</form:option>
		<form:options items="${userLevelList}" itemValue="userRoleId"
			itemLabel="role" />
	</form:select>
	</div>
	<div class="float_right">

	<div class="buttion_bar_type1">
	
	<sec:authorize access="hasRole('search System User')">
		<input type="submit" value="<spring:message code="REF.UI.SEARCH"/>" class="button">
	</sec:authorize>
	
	</div>
	</div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<c:if
		test="${fn:length(userLoginList) > 0 || (userLoginList) == 'Empty' }">
		<div class="section_box" id="search_results" style="display: block">

		<div class="section_box_header">
		<h2><spring:message code="REF.UI.SEARCH.RESULTS"/></h2>
		</div>

		<div class="column_single">
		<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<th><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.USER.NAME"/></th>
				<th><spring:message code="REF.UI.MANAGE.SYSTEM.USERS.USER.ROLE"/></th>

				<th width="150" class="right"><c:if
					test="${numberOfRecords == 0}">${startFrom}</c:if> <c:if
					test="${numberOfRecords > 0}">${startFrom+1}</c:if> - ${maxNumber}
				<spring:message code="PAGINATION.OF"/> ${numberOfRecords} <input type="image" class="button" width="15"
					height="15" src="resources/images/leftSideArrow.png"
					title="<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.PREVIOUS"/>" onclick="previousOrNext('previous')"
					<c:if test="${startFrom == 0}">disabled="disabled"</c:if>>
				<input type="image" width="20" height="15" class="button"
					src="resources/images/rightSideArrow.png" title="<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.NEXT"/>"
					onclick="previousOrNext('next')"
					<c:if test="${maxNumber == numberOfRecords}">disabled="disabled"</c:if>>
				</th>

			</tr>

			<c:choose>
				<c:when test="${(userLoginList) == 'Empty' }">
					<tr class="odd">
						<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
						<td></td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${userLoginList}" var="userLogin"
						varStatus="status">
						<tr class="<c:if test="${status.count % 2 == 0}">even</c:if>
						
						<c:if test="${status.count % 2 == 1}">odd</c:if>">
							<td>${userLogin.username}</td>
							<td>${userRoleMap[userLogin.userRoleId]}</td>
							<td class="right">
								
								
							<c:if test="${userLogin.status}"> 
											
								<sec:authorize access="hasRole('Edit System User')">
									<img src="resources/images/ico_edit.gif"
									width="18" height="20" border="0" class="icon"
									onclick="resetPassword(this,${userLogin.userLoginId})"
									title='<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.EDIT"/>'>
								</sec:authorize>
								
								<sec:authorize access="hasRole('Unlock User')">
									<img src="${userLogin.loginAttempts<2?'resources/images/ico_unlockuser.gif':'resources/images/ico_lockuser.gif'}"
									width="18" height="20" border="0" class="icon"
									onclick="unlockUser(this,${userLogin.userLoginId},${userLogin.loginAttempts})"
									title=<c:if test="${userLogin.loginAttempts>2}"><spring:message code='REF.UI.MANAGE.SYSTEM.USERS.UNLOCK'/></c:if>>
								</sec:authorize>
							
							</c:if>		
							
							<sec:authorize access="hasRole('Enable / Disable User')">
								<img src="${userLogin.status==true?'resources/images/ico_enableuser.gif':'resources/images/ico_disableuser.gif'}"
								width="18" height="20" border="0" class="icon"
								onclick="updateStatusUserStatus(this,'${userLogin.status==true?'disable':'enable'}', ${userLogin.userLoginId})"
								title=<c:if test="${userLogin.status==true}">
								<spring:message code='REF.UI.MANAGE.SYSTEM.USERS.DISABLE'/>
								</c:if>
								<c:if test="${userLogin.status==false}"><spring:message code='REF.UI.MANAGE.SYSTEM.USERS.ENABLE'/></c:if>>
							</sec:authorize>
							
							<sec:authorize access="hasRole('Delete System User')">
							
								<img src="resources/images/ico_delete.gif"
								onClick="deleteUserLogin(this,${userLogin.userLoginId})"
								title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
							</sec:authorize>
								
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>

		</table>
		</div>

		<div class="clearfix"></div>
		</div>

	</c:if>
	<div class="button_row">
	<div class="buttion_bar_type2">
	
	<sec:authorize access="hasRole('Save or update System user')">
	
	<input type="button" value="<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.ADD"/>"
		onClick="window.location='createSystemUser.htm'" class="button">
	
	</sec:authorize>
		
	</div>	
	<div class="clearfix">		
	</div>
	</div>
	<input type="hidden" name="selectedUserLoginId"
		id="selectedUserLoginId" />
	<input type="hidden" name="startFrom" id="startFrom" value="0" />
	<input type="hidden" name="selectedUserStatus" id="selectedUserStatus"
		value="0" />
	<input type="hidden" name="actionType" id="actionType" value="search" />
</form:form></div>
</div>
<h:footer />
</body>
</html>