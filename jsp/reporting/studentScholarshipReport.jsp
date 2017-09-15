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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

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
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<!-- END Calender controll CSS and JS -->

</head>
<body>
	<div id="page_container">
			<div id="breadcrumb_area">
			
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentScholarshipReport.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>

		<div id="content_main">
			<div class="clearfix"></div>
			<h1><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h1>
			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.SCHOLARSHIP.NAME"/></h2>
				</div>

				<div class="section_full_inside">
					<h3></h3>

					<div class="box_border">
						<form:form action="generateStudentScholarshipReport.htm"
							method="POST" commandName="scholarshipCommand">

							<div>
								<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if>
								</label> <label class="required_sign"> <form:errors
										path="scholarship" />
								</label>
							</div>
							<table>
								<tr>
									<td>
									<td><span class="required_sign">*</span><label><spring:message code="REF.UI.SCHOLARSHIP.DETAIL"/>:</label>
									<td><form:select path="scholarship">
											<option value="0">- Please Select -</option>
											<form:options items="${scholarshipList}" itemValue="name"
												itemLabel="name" />
												<!-- <c:if
										test="${scholarshipList == null}">No scholarships found</c:if> -->
										</form:select></td>
								</tr>
								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="" value="Generate Report"></td>
								</tr>
							</table>
						</form:form>
					</div>

				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>

<h:footer />
</body>
</html>
