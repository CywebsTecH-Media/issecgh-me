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

<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
</head>
<body>
	<h:headerNew parentTabId="11" page="AdminParent.htm" />
	<div id="page_container">

		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<li><a href="studentProgressReport.htm"><spring:message code="STUDENT.PROGRESS.MESSAGE.BOARD.LINK"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="STUDENT.PROGRESS.SUCCESS.TITLE"/></li>
				</ul>
			</div>

		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="STUDENT.PROGRESS.MESSAGE.SENT"/></h1>
		<div id="content_main">


			<div class="clearfix"></div>

			<div class="section_full_inside">

				<div class="box_border">
					<div class="row">
						<div align="center" style="height: 150px; padding-top: 75px;">
							<spring:message code="STUDENT.PROGRESS.SUCCESS.MESSAGE"/></div>

					</div>

					<div class="clearfix"></div>
				</div>
			</div>
			<div>

				<div class="clearfix"></div>
			</div>

		</div>
	</div>
	<h:footer />
</body>
</html>
