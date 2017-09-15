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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>


</head>
<body>
	<div id="page_container">

		<div class="clearfix"></div>
		<div id="content_main">
		<div id="breadcrumb_area">

			<div class="help_link"><a href="#" onClick="PopupCenterScroll('resources/html/akura-help/topics/reporting/examResultsReportHelp.html','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> Help</a></div>
           </div>
            <div class="clearfix"></div>
		    <h1><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h1>
			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.EXAM.RESULTS"/></h2>
				</div>

				<div class="section_full_inside">

					<div class="box_border">
						<form:form id="examResultsTemplate" name="form" action="" method="POST" commandName="examResults">

 							<div>
								<label class="required_sign">
									<form:errors path="examAdmissionNo" /><br>
								</label>
							</div>
							<table>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.GENERAL.EXAM.ADMISSION.NO"/></label></td>
									<td><form:input path="examAdmissionNo" maxlength="20" /></td>
								</tr>
								<tr>

									<td><span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.GENERAL.EXAM.NAME"/></label>
									</td>
									<td><form:select path="examId">
											<option value="">
												<spring:message code="application.drop.down" />
											</option>
											<form:options items="${examList}" itemValue="examId"
												itemLabel="description" />
											</form:select></td>

								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
									</td>
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