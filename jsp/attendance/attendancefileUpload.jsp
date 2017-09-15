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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script type="text/javascript" src="resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<!-- Calender controll CSS and JS -->


<script type="text/javascript">
	function openWindow(url, isStudentHistoryValue) {
		$('#isStudentHistory').val(isStudentHistoryValue);
		var newWindow = window
				.open(url + "?isStudentHistory=" + isStudentHistoryValue, '_blank',
						'status=0,toolbar=0,menubar=0,location=0,resizable=1,width = 920, height=300, scrollbars=1');
	}
</script>

</head>
<body>
	<h:headerNew parentTabId="33" page="attendanceFileUpload.htm" />

	<div id="page_container">
		<div id="breadcrumb">
			<sec:authorize access="hasRole('Attendance File Upload')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="ATTENDANCE.FILEUPLOAD.TITLE" />
					</li>
				</ul>
			</sec:authorize>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/attendance/attendanceFileUpload.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="ATTENDANCE.FILEUPLOAD.TITLE"/></h1>
		
		<div id="content_main">
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedFile" action="fileUpload.htm" name="studentFileUpload">
				
				<div class="messageArea">
					<label class="success_sign">${successMessage}</label>
					<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
					<label class="required_sign">${exception}</label>
				</div>
				
				<div class="section_box" style="display: none;">
					<div class="section_box_header">
						<h2><spring:message code="ATTENDANCE.FILEUPLOAD.STUDENT.TITLE"/></h2>
					</div>
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="studentFile" type="file" style="width: 290px;" value="">
								<input type="hidden" name="isStudents" value="true" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">								
									<input type="submit" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel"></div>
							<div class="frmvalue">
								<c:if test="${studentRecord ne null}">
									<spring:message code="ATTENDANCE.FILEUPLOAD.HISTORY.TITLE"/>: <fmt:formatDate value="${studentRecord.modifiedTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
									(<c:out value="${studentRecord.dateOfAttendance}"></c:out>)
									<sec:authorize access="hasRole('View Attendance File Upload History')">
										&nbsp;&nbsp;<a href="#" onClick="openWindow('attendanceFileUploadHistory.htm', 'true')" class="moreData" title="displays History of last 10 days" >More &gt;&gt;</a>
									</sec:authorize>
								</c:if>
							</div>
						</div>
						


					</div>



					<div class="clearfix"></div>
				</div>
			</form:form>
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedFile" action="fileUpload.htm" name="staffFileUpload">
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="ATTENDANCE.FILEUPLOAD.STAFF.TITLE"/></h2>
					</div>
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="staffFile" type="file" style="width: 290px;" value="">
								<input type="hidden" name="isStudents" value="false" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="submit" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel"></div>
							<div class="frmvalue">
								<c:if test="${staffRecord ne null}">
									<spring:message code="ATTENDANCE.FILEUPLOAD.HISTORY.TITLE"/>: <fmt:formatDate value="${staffRecord.modifiedTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
									(<c:out value="${staffRecord.dateOfAttendance}"></c:out>)
									<sec:authorize access="hasRole('View Attendance File Upload History')">
										&nbsp;&nbsp;<a href="#" onClick="openWindow('attendanceFileUploadHistory.htm', 'false')" class="moreData" title="displays History of last 10 days" >More &gt;&gt;</a>
									</sec:authorize>
								</c:if>
							</div>
						</div>

<label>${message}</label>

					</div>



					<div class="clearfix"></div>
				</div>






			</form:form>
		</div>
	</div>
<h:footer />
</body>
</html>