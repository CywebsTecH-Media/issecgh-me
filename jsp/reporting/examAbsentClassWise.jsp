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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function loadClasses(selectedValue, comments, selectedClassId) {

		var url = '<c:url value="/populateGradeClassList1.htm" />';

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
									.createTextNode("<spring:message code="application.drop.down" />"));
					selector.appendChild(option);

					for ( var i = 0; i < a.length; i++) {
						b = a[i].split("_");

						option = document.createElement('option');
						option.value = b[1];
						option.appendChild(document.createTextNode(b[0]));
						selector.appendChild(option);

						if(selectedClassId != null)
						{
								if(option.value == selectedClassId)
								{
									option.selected = 'selected';
								}
						}
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

		document.form.action = "ExamAbsentClassWiseReport.htm";
		document.form.submit();
	}

	function load(thisValue) {
		document.getElementById('selectGrade').value = document
				.getElementById('selectOptionGrade').value;
	}

	function callOnLoadFun(thisValue,selectedClassId)
	{

		loadClasses(thisValue, null,selectedClassId);
	}
</script>



</head>
<body onload="<c:if test="${selectedGradeId != null}">callOnLoadFun('<c:out value="${selectedGradeId}" />','<c:out value="${selectedClassId}" />');</c:if>
<c:if test="${(selectedGradeId == null) and (selectedClassId == null)}">load('this');</c:if>">
	<div id="page_container">
		<div id="breadcrumb_area">

			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/examAbsentClassWiseReportsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.CLASS.WISE.EXAM.ABSENTEES"/></h2>
				</div>

				<div class="section_full_inside">

					<div class="box_border">
						<form:form action="ExamAbsentClassWiseReport.htm" method="POST"
							commandName="cRExamAbsentTemplate" name="form">
							<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>
							<div>
								<label class="required_sign"> <form:errors
										path="gradeDescription" /><br> </label>
							</div>
							<input type="hidden" name="selectedValue" />
							<input type="hidden" name="gradeClass" />

							<table>

								<tr>

									<td><span class="required_sign">*</span><label><spring:message
												code="REPORT.STUDENT.GRADE" /> </label></td>
									<td><form:select id="selectGrade" path="gradeDescription"
											onchange="loadClasses(this.value),null">
											<form:option value="0" id="selectOptionGrade">  <spring:message code="application.drop.down"/> </form:option>

											<c:forEach items="${gradeList}" var="grade">
								                  	<option value="${grade.gradeId}" <c:if test='${selectedGradeId != null &&
								                  	grade.gradeId eq selectedGradeId}'> selected="selected"</c:if>>${grade.description}</option>
								            </c:forEach>

										</form:select>
									</td>
								</tr>

								<tr>
									<td><span class="required_sign">*</span><label><spring:message
												code="REPORT.STUDENT.CLASS" /> </label>
									</td>

									<td>
                                        <div id="selectClass"></div>
									</td>
								</tr>
						
								<tr>
									<td><label><spring:message	code="REPORT.PRIZE.LIST.YEAR" /> </label></td>
									<td><form:select path="year"><spring:message code="application.drop.down" />
											<c:forEach items="${yearList}" var="year">
												<form:option value="${year}"></form:option>
											</c:forEach>
										</form:select></td>
								</tr>

								<tr>
									<td colspan="2"><input type="submit" class="button"
										onClick="generateTrport('this')" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
									</td>
								</tr>
								<tr> 
								<td colspan="2">
									  <label><font size="1" face="Consolas"><spring:message code="REPORT.CLASS.WISE.EXAM.ABSENTEES.SPECIALNOTE"/> </font></label>
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
