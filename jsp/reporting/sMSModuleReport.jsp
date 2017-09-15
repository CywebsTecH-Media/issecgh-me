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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script type="text/javascript">
function openWindow(url){
	var newWindow=window.open(url,'_blank','status=0,toolbar=0,menubar=0,location=0,resizable=1,width = 980,scrollbars=1');
	newWindow.location=url;
}
</script>
<script language="javascript" src="resources/js/main.js"></script>
</head>
<body>
	<h:headerNew parentTabId="28" page="sMSModuleReport.htm" />
	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<li>SMS Summary Reports</li>
				</ul>
			</div>
            <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/SmsSubscriptionReportsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1></h1>
		<div id="content_main">
			<div class="clearfix"></div>


			<div class="section_box">
			<sec:authorize access="hasRole('View Student General Reports Page')">
				<div class="section_box_header">
					<h2>SMS Summary Reports</h2>
				</div>

				<ul>
					<li
						title="<spring:message code="REPORT.SMS.SUBSCRIPTION.REPORT"/>">
						<a href="#" onclick="openWindow('monthlySMSSubCription.htm')">
							<spring:message code="REPORT.SMS.SUBSCRIPTION.PARENT.USAGE.REPORT" /></a>
					</li>
					
					
				</ul>
             </sec:authorize>

			</div>

		</div>
	</div>
	<h:footer />
</body>
</html>