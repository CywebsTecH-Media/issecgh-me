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
<h1><spring:message code="STUDENT.MARKDETAILS.EXAM" /> ( <spring:message
	code="STUDENT.MARKDETAILS.EXAM.YEAR" /> <c:out value="${Year}" /> )</h1>
<div class="column_single">
<table class="basic_grid" border="0" cellspacing="1" cellpadding="0">

                

	<c:choose>
		<c:when test="${not empty examList}">
			<c:forEach items="${examList}" var="exam">
				<tr
					<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>
					<th><spring:message code="REF.UI.EXAM.MARK.EXAM.VIEW" />${exam.value}</th>

					<% int count = 0; %>
					<c:if test="${not empty examMarksList}">
						<c:forEach items="${examMarksList}" var="examMark"
							varStatus="status">

							<c:if test="${examMark.examId == exam.key}">

								<% if (count == 0){ %>
								<tr>
									<th><spring:message
										code="REF.UI.ACADEMIC.EXAM.MARKS.ADMISSION" />${examMark.examAdmissionNo}</th>
								</tr>
								<tr>
									<th><spring:message
										code="REF.UI.ACADEMIC.EXAM.MARKS.SUBJECT" /></th>
									<th><spring:message code="REF.UI.ACADEMIC.EXAM.MARKS" /></th>
								</tr>
								<% } count = count + 1; %>
							</c:if>

							<c:if test="${examMark.examId == exam.key}">
								<tr>
								   
									<td>${examMark.subjectDescription}</td>
									<td><c:choose>
										<c:when test="${examMark.absent}">AB</c:when>
										<c:when test="${examMark.optional}">NA</c:when>

										<c:otherwise>
											<c:if test="${examMark.gradingAcronym != null}">${examMark.gradingAcronym}
											&nbsp; &nbsp; &nbsp; ${examMark.gradingDescription}</c:if>
											<c:if test="${examMark.marks != null and examMark.marks == -1 }">NA</c:if>
											<c:if test="${examMark.marks != null and examMark.marks != -1 }">${examMark.marks}</c:if>
										</c:otherwise>
									</c:choose></td>
								</tr>
							</c:if>

						</c:forEach>

					</c:if>

				</tr>
			</c:forEach>
			<hr>
		</c:when>

		<c:otherwise>
			<tr>
				<td>
				<h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5>
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
<div class="buttion_bar_type3"><input type="button"
	value='<spring:message code="REF.UI.CLOSE"/>' onClick="window.close()"
	class="button"></div>
<div class="clearfix"></div>
</div>
</div>
</body>
</html>
