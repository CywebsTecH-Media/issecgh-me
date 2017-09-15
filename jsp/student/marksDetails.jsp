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
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />

</head>
<body>
	<div id="page_container_popup">
		<div class="clearfix">&nbsp;</div>
		<div id="content_main">
			<div class="clearfix"></div>
			<h1>
				<spring:message code="STUDENT.MARKDETAILS.MONTHLYGRADE"/>
				<c:out value="${Subject}" />
				(<spring:message code="STUDENT.MARKDETAILS.YEAR"/>
				<c:out value="${Year}" />
				)
			</h1>
			<div class="noteMarks"><spring:message code="STUDENT.EXAM.DETAIL.NOTE"/></div>
			<br class="clearfix" />
			<div class="column_single">
				<table class="basic_grid" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<c:choose>
							<c:when test="${not empty TermList}">
								<c:forEach items="${TermList}" var="termList"
									varStatus="status1">
									<%
										int i = 0; //Initialize clospan attribute value
									%>
									<c:forEach items="${SubTermList}" var="subTermList"
										varStatus="status">
										<c:if test="${termList.termId == subTermList.termId}">
											<%
												i++; //increase the value if new term found
											%>
										</c:if>
									</c:forEach>
									<th class="center" colspan="<%=i%>">${termList.description}</th>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<th class="center"></th>
							</c:otherwise>
						</c:choose>
					</tr>

					<tr class="odd">
						<c:forEach items="${TermList}" var="termList" varStatus="status">
							<c:set var="isEqual" value="false" />
							<%
								int j = 0; //Initialize count variable
							%>
							<c:choose>
								<c:when test="${not empty SubTermList}">
									<c:forEach items="${SubTermList}" var="subTermList"
										varStatus="status">
										<c:if test="${termList.termId == subTermList.termId}">
											<%
												j++; //Increase count variable by 1
											%>
											<th class="center">${subTermList.description}</th>
											<c:set var="isEqual" value="true" />
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
					<spring:message code="STUDENT.MARKDETAILS.NOSUBTERMS"/>
				</c:otherwise>
							</c:choose>
							<%
								if (j == 0) {
							%>
							<th class="center"></th>
							<%
								}
							%>
						</c:forEach>
					</tr>


					<tr class="odd">
						<c:forEach items="${TermList}" var="termList" varStatus="status">
							<%
								int k = 0; //Initialize count variable
							%>
							<c:choose>
								<c:when test="${not empty SubTermList}">
									<c:forEach items="${SubTermList}" var="subTermList"
										varStatus="status">
										<c:if test="${termList.termId == subTermList.termId}">
											<c:forEach items="${LastList}" var="item" varStatus="status">
												<c:if
													test="${fn:substringBefore(item.key,'_') == termList.description && fn:substringAfter(item.key,'_') == subTermList.description}">
													<%
														k++; //Increase count variable by 1
													%>
													<td class="center">${item.value}</td>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
					<spring:message code="STUDENT.MARKDETAILS.NOSUBTERMS"/>
				</c:otherwise>
							</c:choose>
							<%
								if (k == 0) {
							%>
							<td class="center"></td>
							<%
								}
							%>
						</c:forEach>
					</tr>

				</table>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
		<div class="button_row">
			<div class="buttion_bar_type3">
				<input type="button" value='<spring:message code="REF.UI.CLOSE"/>' onClick="window.close()"
					class="button">
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</body>
</html>
