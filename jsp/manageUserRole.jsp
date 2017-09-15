<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>


<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>


<script type="text/javascript">

function deleteUserRole(thisObj) {
	var elementWraper = $(thisObj).closest('.section_box');
	$(elementWraper).find('.basic_grid tr').removeClass('highlight');
	$(thisObj).parents('tr').addClass('highlight');
	$(elementWraper).find('.section_full_inside').hide();
	
	var message = "<spring:message code='REF.DELETE.CONFIRMATION' />" ;
	
	var okfunction = function(){
		document.userRoleForm.action='deleteUserRole.htm';
		document.userRoleForm.submit();
	};
	
	var cancelfunction = function(){
		$(thisObj).parents('tr').removeClass('highlight');
	};
	
	confirm_function(message , okfunction, cancelfunction );
}
</script>
</head>
<body>

	<h:headerNew parentTabId="37" page="manageUserRoles.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="USER.MANAGEMENT.MANAGE.ROLE.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageUserRoleHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="USER.MANAGEMENT.MANAGE.ROLE.TITLE"/> </h1>
		<div id="content_main">
			<form:form method="POST" commandName="userRole" action=""
				name="userRoleForm">

				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="USER.MANAGEMENT.MANAGE.ROLE.SUB.TITLE"/></h2>
					</div>
					<div>
						<label class="required_sign">
							<c:if test="${message != null}">${message}</c:if>
						</label>
						<form:errors path="role" cssClass="required_sign"/><br>
						<form:errors path="description" cssClass="required_sign"/>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th width="181"><spring:message code="USER.MANAGEMENT.MANAGE.ROLE.USER.ROLE"/></th>
								<th width="677"><spring:message code="USER.MANAGEMENT.MANAGE.ROLE.DESCIPTION"/></th>
								<th width="51" align="right" valign="top" class="right"></th>
							</tr>
							
							<c:choose>
								<c:when test="${not empty userRoleList}">
									<c:forEach items="${userRoleList}" var="role" varStatus="status">
										<tr
											<c:choose>
							            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
							            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
						            		</c:choose>>
						            		
											<td>${role.role}</td>
											<td>${role.description}</td>
											<td nowrap class="right">
											
												<sec:authorize access="hasRole('Edit User Role')">
												
												<img  
												
												<c:if test="${role.isSystemRole==false }" >
													src="resources/images/ico_edit.gif"" 
													title="<spring:message code='USER.MANAGEMENT.MANAGE.ROLE.EDIT.ROLE'/>"  
												</c:if>	
												<c:if test="${role.isSystemRole==true }" >
													src="resources/images/ico_user.gif"
													title="<spring:message code='USER.MANAGEMENT.MANAGE.ROLE.VIEW.ROLE'/>"  
												</c:if>	
												
												onClick="document.userRoleForm.userRoleId.value='${role.userRoleId}';
							              			document.userRoleForm.action='loadUserRolefDetails.htm';
						              			document.userRoleForm.submit();"
												width="18" height="20" class="icon"> 
												
												</sec:authorize>
												
											<c:if test="${role.isSystemRole==false }" >
												
												<sec:authorize access="hasRole('delete User Role')">
												
												<img src="resources/images/ico_delete.gif"
												onClick="document.userRoleForm.selectedRole.value='${role.userRoleId}';deleteUserRole(this);"
												title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20" class="icon">
												
												</sec:authorize>
												
											</td>
												
											</c:if>	
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830"><h5><spring:message code="USER.MANAGEMENT.MANAGE.NO.ROLE.FOUND"/></h5>
										</td>
										<td nowrap class="right"></td>
										<td></td>
									</tr>
								</c:otherwise>
							</c:choose> 
							
							</table>
					</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<input type="hidden" name="selectedRole">
				<form:hidden path="userRoleId"/>
				   <div class="button_row">
				  	<div class="buttion_bar_type2" >
				  		<sec:authorize access="hasRole('Save or update user role')"> 
							<input type="button" value="<spring:message code="USER.MANAGEMENT.MANAGE.ROLE.ADD.ROLE"/>" onClick="window.location='newUserRoleDetails.htm'" class="button">
						</sec:authorize>
			        </div>
			        <div class="clearfix"></div>
	  			   </div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
