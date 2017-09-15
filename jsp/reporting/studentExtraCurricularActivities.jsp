<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>School Management System</title>
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
	<div id="breadcrumb_area">
			
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentExtraCurricularReportsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1>General Reports</h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2>More Reports</h2>
				</div>

				<div class="section_full_inside">
					<h3>Extra Curricular Activities Report</h3>

					<div class="box_border">
						<form:form action="" method="POST"
							commandName="cRExtraCurricularActivitiesTemplate">
							<div>
								<label class="required_sign"> <form:errors
										path="*" /><br> </label>
							</div>

							<table>


								<tr>
									<td><span class="required_sign">*</span><label>Admission No :</label></td>
									<td>
										<form:input path="admissionNo" />
									</td>

								</tr>

								<tr>
									<td><span class="required_sign">*</span><label>Full Name :</label></td>
									<td>
										<form:input path="fullName" />
									</td>

								</tr>


								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="" value="Generate Report">
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
</body>
</html>
