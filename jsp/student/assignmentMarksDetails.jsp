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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

</head>
<body>
	<div id="page_container_popup">
		<div class="clearfix">&nbsp;</div>
		<div id="content_main">
			<div class="clearfix"></div>
			<h1>
				<spring:message code="STUDENT.MARKDETAILS.ASSIGNMENT" />
				<c:out value="${Subject}" />
				(
				<spring:message code="STUDENT.MARKDETAILS.ASSIGNMENT.YEAR" />
				<c:out value="${Year}" />
				)
			</h1>
			<div class="column_single">
				<table class="basic_grid" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<th width="184"><spring:message
								code="STUDENT.MARKDETAILS.ASSIGNMENT.TITLE" />
						</th>
						<th width="198"><spring:message
								code="STUDENT.MARKDETAILS.ASSIGNMENT.MARKS" />
						</th>
					</tr>
					<c:choose>
						<c:when test="${not empty AssignmentMarksList}">
							<c:forEach items="${AssignmentMarksList}" var="assignmentMarks"
								varStatus="status">

								<tr
									<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>

									<td>${assignmentMarks.name}</td>
									<td>
										<c:choose>
											<c:when test="${assignmentMarks.absent}">AB</c:when>
											<c:otherwise>
												<c:if test="${assignmentMarks.grading != null}">${assignmentMarks.grading}</c:if>
												<c:if test="${assignmentMarks.marks != null}">${assignmentMarks.marks}</c:if>
											</c:otherwise>
										</c:choose>
									</td>

								</tr>

							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td><h5>
										<spring:message code="APPLICATION.NORECORDSFOUND" />
									</h5>
								</td>
								<td></td>

							</tr>
						</c:otherwise>
					</c:choose>





				</table>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
		<div class="button_row">
			<div class="buttion_bar_type3">
				<input type="button" value='<spring:message code="REF.UI.CLOSE"/>'
					onClick="window.close()" class="button">
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</body>
</html>
