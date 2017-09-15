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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

function selectClass(thisValue) {
	document.form.selectedClass.value = thisValue;
}
function selectYear(thisValue) {
	document.form.selectedYear.value = thisValue;
}
function loadAdmissionNo(selectedValue,selectedAddmissionNo) {

	var url = '<c:url value="/populateAddmissionNosByClass.htm" />';
	var year=$("#selectedYear").val();

	$.ajax({
		url : url,
		data : ({
			'classGradeId' : selectedValue,
			'selectedYear' : year
		}),
		success : function(response) {

			var responseArray = response.split(",");
			
			document.getElementById('selectAddmission').innerHTML = '';
			
			var dropDownDiv = document.getElementById('selectAddmission');
			var selector = document.createElement('select');
			selector.id = "selectedAddmission";
			selector.name = "selectedAddmission";
			dropDownDiv.appendChild(selector);

			var option = document.createElement('option');
			option.value = '0';
			option.appendChild(document.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
			selector.appendChild(option);
			
			if (responseArray.length > 0) {
					
				for ( var i = 0; i < responseArray.length; i++) {
				
					if (responseArray[i] != "") {
						
						var optionTextArray = responseArray[i].split('&nbsp;&nbsp;-&nbsp;&nbsp;');
						
						option = document.createElement('option');
						option.value = optionTextArray[0];
						option.innerHTML = responseArray[i];
						selector.appendChild(option);
						
						
						if(selectedAddmissionNo!=null)
						{
							if(option.value==selectedAddmissionNo)
							{
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

function generateStudentReportCard() {
	document.form.action = "studentReportCard.htm";
	document.form.submit();
}


function callOnLoadFun(thisValue,selectedAddmissionNo,year)
{
	selectClass(thisValue);
	selectYear(year);
	loadAdmissionNo(thisValue,selectedAddmissionNo);
}
function loadAdmissionNoAfteryear() {
	var selectedClass = $("#selectedClass").val();
	if (selectedClass != 0) {
		loadAdmissionNo(selectedClass);
	}
}
</script>
</head>
<body onload="<c:if test="${selectedClassGradeId != null}">callOnLoadFun('<c:out value="${selectedClassGradeId}" />','<c:out value="${selectedAddmissionNo}" />','<c:out value="${selectedYear}" />');</c:if>">
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currentYear" value="${now}" pattern="yyyy" />
<div id="page_container">
	<div id="breadcrumb_area">
		
		<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentReportCard.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
	</div>
	<div class="clearfix"></div>
	<h1><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h1>
	<div id="content_main">
		<div class="clearfix"></div>

		<div class="section_box">
			<div class="section_box_header">
				<h2><spring:message code="REPORT.STUDENT.REPORT.CARD"/></h2>
			</div>

			<div class="section_full_inside">

				<div class="box_border">
					<form action="" method="POST" name="form">
						<div>
							<label class="required_sign">${message}</label>
						</div>

						<table>
								<tr>
									<td>
										<label><spring:message code="REPORT.STUDENT.REPORT.CARD.SELECT.YEAR"/></label>
									</td>
									<td>
										<select name="selectedYear" id="selectedYear" onchange="selectYear(this.value);loadAdmissionNoAfteryear();">
								                <option value="${currentYear}"> ${currentYear} </option>
									            <option value="${currentYear-1}"> ${currentYear-1} </option>
								            </select>
									</td>

								</tr>
								<tr>
									<td>
										<span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.REPORT.CARD.SELECT.CLASS"/></label>
									</td>
									<td>
										<select name="selectedClass" id="selectedClass" onchange="selectClass(this.value);loadAdmissionNo(this.value);">
							                <option value="0"> <spring:message code="OPT.PLEASE.SELECT"/> </option>
								                <c:forEach items="${classGradeList}" var="classGrade">
								                  	<option value="${classGrade.classGradeId}" <c:if test='${selectedClassGradeId != null &&
								                  	classGrade.classGradeId eq selectedClassGradeId}'> selected="selected" </c:if>>${classGrade.description}</option>
								                </c:forEach>
							            </select>
									</td>

								</tr>
							<tr>
								<td>
									<span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.REPORT.CARD.SELECT.ADMISSION.NO"/></label>
								</td>
								<td>
									<div id="selectAddmission"></div>
								</td>

							</tr>

							<tr>
								<td colspan="2"><input type="button" class="button"
									onclick="generateStudentReportCard();" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
								</td>
							</tr>
							<tr> </tr>
							<tr> </tr>
							<tr> 
								<td colspan="2">
									  <label><font size="1" face="Consolas"><spring:message code="REPORT.STUDENT.REPORT.CARD.SPECIALNOTE"/> </font></label>
								</td>
							</tr>
						</table>
					</form>
				</div>

			</div>

			<div class="clearfix"></div>
		</div>
	</div>
</div>
<h:footer/>
</body>
</html>