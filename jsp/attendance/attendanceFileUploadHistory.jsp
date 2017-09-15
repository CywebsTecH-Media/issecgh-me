<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>School Management System</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
</head>
<body>
	<div id="page_container_popup">
		<div class="clearfix">&nbsp;</div>
		<div id="content_main">
			<div class="clearfix"></div>
			<h1>
				<c:if test="${pageTitlePrefix ne null}">
					${pageTitlePrefix}&nbsp;
				</c:if>
				<spring:message code="ATTENDANCE.FILEUPLOAD.FILEUPLOADHISTORY.TITLE" />
			</h1>

			<br class="clearfix" />
			<div class="column_single">
				<div style="height: 170px; overflow: auto;">
					<table class="basic_grid" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<th width="28">&nbsp;</th>
							<th width="197">Uploaded on</th>
							<th width="278">Attendance On</th>
						</tr>

						<c:choose>
							<c:when
								test="${(historyList ne null) && (not empty historyList)}">
								<c:forEach var="historyItem" items="${historyList}"
									varStatus="status">

									<c:set var="cssClass"
										value="${(status.count % 2 eq 0) ? 'odd' : 'even'}" />

									<tr class="${cssClass}">

										<td>${status.count}</td>
										<td><fmt:formatDate value="${historyItem.modifiedTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${historyItem.dateOfAttendance}</td>

									</tr>

								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="odd">
									<td width="830" colspan="0"><h5>
											<spring:message code="REF.REPO.NO.DATA" />
										</h5>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>

					</table>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
		<div class="button_row">
			<div class="buttion_bar_type3">
				<input type="button" value="Close" onClick="window.close()"
					class="button">
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</body>
</html>
