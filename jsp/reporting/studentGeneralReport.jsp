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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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

<script type="text/javascript">
function openWindow(url){
	var newWindow=window.open(url,'_blank','status=0,toolbar=0,menubar=0,location=0,resizable=1,width = 980,scrollbars=1');
	newWindow.location=url;
}
</script>
<script language="javascript" src="resources/js/main.js"></script>
</head>
<body>
	<h:headerNew parentTabId="28" page="StudentGeneralReports.htm"/>

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></li>
				</ul>
			</div>
            <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/generalReportsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1></h1>
		<div id="content_main">
			<div class="clearfix"></div>


			<div class="section_box">
			<sec:authorize access="hasRole('View Student General Reports Page')">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h2>
				</div>

				<ul>
				    <li
						title="<spring:message code="REPORT.STUDENT.SUMMARY"/>">
						<a href="#" onclick="openWindow('showStudentSummaryReportForm.htm')"><spring:message code="REPORT.STUDENT.DETAILS.SUMMARY"/></a>
					</li>
					<sec:authorize access="hasRole('Print Student Report Card')">
						<li
						title="<spring:message code="REPORT.STUDENT.RERORT.CARD"/>">
						<a href="#" onclick="openWindow('studentReportCardPage.htm')"><spring:message code="REPORT.STUDENT.REPORT.CARD" /></a>
						</li>
					</sec:authorize>
					<li
					 	title="<spring:message code="REPORT.CLASSWISE.AVARAGE.TERM.MARKS"/>">
						<a href="#" onclick="openWindow('averageTermMarkClassWise.htm')"><spring:message code="REPORT.AVERAGE.TERM.MARKS.SUBJECT.GRADE"/></a>
					</li>
					<li
						title="<spring:message code="REPORT.STUDENT.PERFORMANCE"/>">
						<a href="#" onclick="openWindow('studentPerformance.htm')"><spring:message code="REPORT.CLASS.WISE.STUDENT.TERM.MARKS.EVALUATION"/></a>
					</li>
					<li
						title="<spring:message code="REPORT.CLASSWISE.EXAM.ABSENTEE"/>">
						<a href="#" onclick="openWindow('classWiseExamAbenteeList.htm')"><spring:message code="REPORT.CLASS.WISE.EXAM.ABSENTEES"/></a>
					</li>

					<li
						title="<spring:message code="REPORT.CLASSWISE.STUDENT"/>">
						<a href="#" onclick="openWindow('classWiseStudentList.htm')"><spring:message code="REPORT.CLASS.WISE.STUDENT.LIST"/></a>
					</li>

					<sec:authorize access="hasRole('View Class Wise Student Disciplinary Action Report')">
					<c:if test="${isClassTeacher }">
					<li
						title="<spring:message code="REPORT.CLASSWISE.STUDENT.DISCIPLINARY.ACTION"/>">
						<a href="#" onclick="openWindow('studentDisciplinaryActionClassWise.htm')"><spring:message code="REPORT.CLASS.WISE.STUDENT.DISCIPLINARY"/></a>
					</li></c:if>
					</sec:authorize>

					<li
						title="<spring:message code="REPORT.CLASSWISE.STUDENT.MARKS"/>">
						<a href="#" onclick="openWindow('classWiseStudentMarksReport.htm')"><spring:message code="REPORT.CLASS.WISE.STUDENT.MARK.SHEET"/></a>
					</li>

                    <li
                    	title="<spring:message code="REPORT.EXAM.RESULT"/>">
						<a href="#" onclick="openWindow('examResultsReport.htm')"><spring:message code="REPORT.EXAM.RESULTS"/></a>
					</li>

					<li
						title="<spring:message code="REPORT.PRIZE.LIST"/>">
						<a href="#" onclick="openWindow('prizeListReport.htm')"><spring:message code="REPORT.Prize.List"/></a>
					</li>
					<li
						title="<spring:message code="REPORT.STUDENT.SCHOLARSHIP"/>">
						<a href="#" onclick="openWindow('studentScholarshipReport.htm')"><spring:message code="REPORT.SCHOLARSHIP.REPORT"/></a>
					</li>
				</ul>
             </sec:authorize>

			</div>

		</div>
	</div>
	<h:footer />
</body>
</html>