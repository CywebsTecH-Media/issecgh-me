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

<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function fillStudentDetails(studentId) {

		var url = '<c:url value="/loadStudentDetails.htm" />';
		$
				.ajax({
					url : url,
					data : ({
						'studentId' : studentId
					}),
					success : function(response) {
						<c:url value="/studentDetails.htm" var="gotourl" />
						location
								.replace('<c:out value="${gotourl}" escapeXml="true"/>');
					},
					error : function(transport) {
						custom_alert("An error has occurred.");
					}
				});
	}
</script>
</head>
<body>
	<h:headerNew parentTabId="0" page="getChildList.htm" />
	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" /> </a>
					</li>
					<li>&gt; <spring:message code="PARENT.CHILD_LIST.TITLE" /></li>
				</ul>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="PARENT.PARENT_WELCOME.WELCOME_MESSAGE" />
		</h1>
		<div id="content_main">
			<div class="clearfix"></div>
			<div class="section_box">
				<div class="main_page">
					<!--   <p class="welcome_text">This application will provide you all the services and functionalities that you will need to track all information related to the school.</p>-->
					<div class="main_page_left"
						style="border: 1px solid #BCD1E6; padding: 0px;">
						<div class="section_box_header">
							<h2>
								<spring:message code="PARENT.CHILD_LIST.CHILDREN" />
							</h2>
						</div>
						<c:forEach items="${childList}" var="child">

							<c:set var="addNO" scope="request" value="${child.admissionNo}" />
							<c:if test="${child.statusId!=2}">
								<div class="awards">
									<div class="awards-left">
										<a href="javascript:fillStudentDetails(${child.studentId})">
											<img src="${imagePaths[addNO]}"> </a>
									</div>
									<div class="awards-right">
										<a href="javascript:fillStudentDetails(${child.studentId})">${child.fullName}</a>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<div class="clearfix"></div>


					</div>

					<div class="main_page_right">
						<img src="resources/images/bus.png">
					</div>

				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>
