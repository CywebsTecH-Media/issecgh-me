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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

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
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function loadFromMonths(selectedValue, comments, selectedFromMonth) {

		var url = '<c:url value="/populateYearFromMonthList.htm" />';

		$
				.ajax({
					url : url,
					data : ({
						'selectedValue' : selectedValue
					}),
					success : function(response) {

						var c = response;
						var a;

						a = c.split(",");

						var b;
						document.getElementById('selectFromMonth').innerHTML = '';
						if (comments == null) {
							var dropDownDiv = document
									.getElementById('selectFromMonth');

							var selector = document.createElement('select');
							selector.id = "selectFromMonths";
							selector.name = "selectFromMonths";
							selector.path = "monthDescription";
							dropDownDiv.appendChild(selector);

							var option = document.createElement('option');
							option.value = '0';
							option
									.appendChild(document
											.createTextNode("<spring:message code="application.drop.down" />"));
							selector.appendChild(option);

							for ( var i = 0; i < a.length; i++) {
								b = a[i].split("_");

								if (b != "") {
									option = document.createElement('option');
									option.value = b[1];
									option.appendChild(document
											.createTextNode(b[0]));
									selector.appendChild(option);

									if (selectedFromMonth != null) {
										if (option.value == selectedFromMonth) {
											option.selected = 'selected';
										}
									}
								}
							}

						}
					},
					error : function(transport) {
						custom_alert("An error has occurred.");

					}
				});
	}

	function callOnLoadFromMonthsFun(thisValue, selectedMonth)
	{
		loadFromMonths(thisValue, null, selectedMonth);
	}


	function loadToMonths(selectedValue, comments, selectedToMonth) {

		var url = '<c:url value="/populateYearToMonthList.htm" />';

		$
				.ajax({
					url : url,
					data : ({
						'selectedValue' : selectedValue
					}),
					success : function(response) {

						var c = response;
						var a;

						a = c.split(",");

						var b;
						document.getElementById('selectToMonth').innerHTML = '';
						if (comments == null) {
							var dropDownDiv = document
									.getElementById('selectToMonth');

							var selector = document.createElement('select');
							selector.id = "selectToMonths";
							selector.name = "selectToMonths";
							selector.path = "monthDescription";
							dropDownDiv.appendChild(selector);

							var option = document.createElement('option');
							option.value = '0';
							option
									.appendChild(document
											.createTextNode("<spring:message code="application.drop.down" />"));
							selector.appendChild(option);

							for ( var i = 0; i < a.length; i++) {
								b = a[i].split("_");

								if (b != "") {
									option = document.createElement('option');
									option.value = b[1];
									option.appendChild(document
											.createTextNode(b[0]));
									selector.appendChild(option);

									if (selectedToMonth != null) {
										if (option.value == selectedToMonth) {
											option.selected = 'selected';
										}
									}
								}
							}

						}
					},
					error : function(transport) {
						custom_alert("An error has occurred.");

					}
				});
	}

	function callOnLoadToMonthsFun(thisValue, selectedMonth)
	{
		loadToMonths(thisValue, null, selectedMonth);
	}

</script>

</head>
<body onload="<c:if test="${selectedFromYear != null}">callOnLoadFromMonthsFun('<c:out value="${selectedFromYear}" />','<c:out value="${selectedFromMonth}" />');</c:if>
<c:if test="${selectedToYear != null}">callOnLoadToMonthsFun('<c:out value="${selectedToYear}" />','<c:out value="${selectedToMonth}" />');</c:if>">
	<div id="page_container">
		<div class="clearfix"></div>

		<div id="content_main">
			<div id="breadcrumb_area">
				<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/userWiseSMSSubscriptionReportHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"> <spring:message code="application.help" /></a></div>
			</div>
			<div class="clearfix"></div>
			<h1>User Wise Subscription Report</h1>
			<div class="section_box">
				<div class="section_box_header">
					<h2>User Wise Subscription Report</h2>
				</div>

				<div class="section_full_inside_reports">
					<h3></h3>

					<div class="box_border">
						<form:form action="userSmsSubcriptionReport.htm"
							commandName="userSMSSubcription" name="form">

							<label class="required_sign"> <c:if
									test="${message != null}">${message}</c:if> </label>


							<label class="required_sign"> <form:errors path="*" /><br>

							</label>

							<table cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td><label>From:</label>
									</td>
									<td>&nbsp;</td>
									<td><label>To:</label>
									</td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<td><span class="required_sign">*</span> <label>Year:</label>
									</td>
									<td><form:select id="fromYear" name="fromYear"
											style="width: 130px;" path="fromYear"
											onchange="loadFromMonths(this.value),null">

											<form:option value="0">
												<spring:message code="application.drop.down" />
											</form:option>
											<c:forEach items="${yearList}" var="year">
												<option value="${year}" <c:if test='${selectedFromYear != null &&
					 year eq selectedFromYear}'> selected="selected"</c:if>>${year}</option>
											</c:forEach>
										</form:select></td>
									<td><span class="required_sign">*</span> <label>Year:</label>
									</td>
									<td><form:select id="toYear" name="toYear"
											style="width: 130px;" path="toYear"
											onchange="loadToMonths(this.value),null">

											<form:option value="0">
												<spring:message code="application.drop.down" />
											</form:option>
											<c:forEach items="${yearList}" var="year">
												<option value="${year}" <c:if test='${selectedToYear != null &&
					 year eq selectedToYear}'> selected="selected"</c:if>>${year}</option>
											</c:forEach>
										</form:select></td>
								</tr>
								<tr>
									<td width="8%"><span class="required_sign">*</span> <label>Month:</label></td>
									<td width="32%">

										<div id="selectFromMonth"></div>
									</td>



									<td width="7%"><span class="required_sign">*</span> <label>Month:</label>
									</td>
									<td width="53%">
										<div id="selectToMonth"></div></td>
								</tr>

								<tr></tr>
								<tr></tr>

								<tr>
									<td colspan="5"><input type="submit" class="button"
										onClick=""
										value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
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