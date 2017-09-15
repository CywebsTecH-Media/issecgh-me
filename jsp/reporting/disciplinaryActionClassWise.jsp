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

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function loadClasses(selectedValue, comments) {

		var url = '<c:url value="/populateGradeClassList.htm" />';

		$.ajax({
			url : url,
			data : ({
				'selectedValue' : selectedValue
			}),
			success : function(response) {

				var c = response;
				var a;

				a = c.split(",");

				var b;
				document.getElementById('selectClass').innerHTML = '';
				if (comments == null) {
					var dropDownDiv = document.getElementById('selectClass');

					var selector = document.createElement('select');
					selector.id = "selectClasses";
					selector.name = "selectClasses";
					selector.path = "classDescription";
					dropDownDiv.appendChild(selector);

					var option = document.createElement('option');
					option.value = '0';
					option
							.appendChild(document
									.createTextNode('<spring:message code="application.drop.down"/>'));
					selector.appendChild(option);

					for ( var i = 0; i < a.length; i++) {
						b = a[i].split("_");

						option = document.createElement('option');
						option.value = b[1];
						option.appendChild(document.createTextNode(b[0]));
						selector.appendChild(option);
					}

				}
			},
			error : function(transport) {
				var message = "An error has occurred." ;
				custom_alert(message);

			}
		});
	}

	function generateTrport(thisValue) {

		document.form.action = "StudentDisciplinaryActions.htm";
		document.form.submit();
	}

	function load(thisValue) {
		document.getElementById('selectGrade').value = document
				.getElementById('selectOptionGrade').value;

	}
</script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
</head>
<body onload="load('this')">
	<div id="page_container">
		<div id="breadcrumb_area">

			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentDisciplinaryReportsHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="application.help"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REPORT.STUDENT.GENERAL.REPORTS" />
		</h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2>
						<spring:message code="REPORT.STUDENT.DISCIPLINE.REPORT" />
					</h2>
				</div>

				<div class="section_full_inside">

					<div class="box_border">

						<form:form action="StudentDisciplinaryActions.htm" method="POST"
							commandName="disciplinaryActionClassWise" name="form">

							<input type="hidden" name="selectedValue" />
							<input type="hidden" name="gradeClass" />

							<c:if test="${message != null}">
								<div>
									<label class="required_sign">${message}</label>
								</div>
							</c:if>

							<div>
								<label class="required_sign"> <form:errors
										path="gradeDescription" /><br> </label>
							</div>
							<table>
								<tr>

									<td><span class="required_sign">*</span><label><spring:message
												code="REPORT.STUDENT.CLASS" /> </label></td>
									<td><form:select id="selectClass" path="gradeDescription">
											<form:option value="0" ><spring:message code="application.drop.down" /></form:option>
											<form:options items="${gradeList}" itemLabel="description"
												itemValue="classGradeId" />
										</form:select>
									</td>
								</tr>



								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="generateTrport('this')" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
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
	<h:footer/>
</body>
</html>
