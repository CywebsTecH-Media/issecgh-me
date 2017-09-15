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

<!DOCTYPE HTML>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
<script language="javascript" src="resources/js/main.js"></script>


</head>
<body>
	<h:headerNew parentTabId="40" page="messageToTeacher.htm" />

	<div id="page_container">

		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="PARENT.MESSAGE_TO_TEACHER" /></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/messageToTeacherHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20">
					<spring:message code="application.help" /> </a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="PARENT.MESSAGE_TO_TEACHER.INFORM_HEADER" />
		</h1>
		<div id="content_main">
			<c:if test="${successMessage != null}">
				<div class="success_sign">&nbsp;${successMessage}</div>
			</c:if>
			<c:if test="${errorMessage != null}">
				<div class="required_sign">&nbsp;&nbsp;&nbsp;${errorMessage}</div>
			</c:if>

			<form:form action="sendEmailRequest.htm" commandName="messageTT" method="post" name="form">

				<div class="clearfix"></div>

				<div class="section_full_inside">
					<div class="box_border">

						<div class="row">
							<span class="required_sign">*</span> <label><spring:message
									code="PARENT.MESSAGE_TO_TEACHER.TO" />
							</label>
						</div>
						<div class="row">
							<form:select name="staffId" path="toStaffId">
								<form:option value="0">
									<spring:message code='OPT.PLEASE.SELECT' />
								</form:option>
								<form:options items="${messageTT.teacherMap}" />
								
							</form:select>
							
						
						</div>
						
						<div class="row">
							<label><spring:message
									code="PARENT.MESSAGE_TO_TEACHER.CC" />
							</label>
						</div>
						<div class="row">
							<form:select name="ccstaffId" path="ccStaffId" multiple="true" style="overflow:auto;" >
								<c:if test="${(errorMessage == null && successMessage == null) || successMessage != null}">
									<form:option value="0" selected="selected">
										<spring:message code='OPT.PLEASE.SELECT' />
									</form:option>
								</c:if>
								<c:if test="${errorMessage != null}">
									<form:option value="0" >
										<spring:message code='OPT.PLEASE.SELECT' />
									</form:option>
								</c:if>
								<form:options items="${messageTT.teacherMap}" />
								
							</form:select>
							
							
						</div>

						<div class="row">
							<span class="required_sign">*</span> <label><spring:message
									code='PARENT.MESSAGE_TO_TEACHER.MESSAGE_SUBJECT' />
							</label>
						</div>
						<div class="row">
							<form:input path="subject" type="text" />
						</div>

						<div class="row">
							<div class="float_left">
								<span class="required_sign">*</span> <label><spring:message
										code='PARENT.MESSAGE_TO_TEACHER.MESSAGE' />
								</label>
								<form:textarea path="message"  cols="" rows="5" style="width: 885px;"
									id="id"></form:textarea>
							</div>
						</div>
						<div class="buttion_bar_type2">
							<input type="submit"
								value="<spring:message code='STUDENT.PROGRESS.UI.SEND.EMAIL'/>"
								class="button">
						</div>
						<div class="clearfix"></div>

					</div>
				</div>
				<div>
					<div class="clearfix"></div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>

