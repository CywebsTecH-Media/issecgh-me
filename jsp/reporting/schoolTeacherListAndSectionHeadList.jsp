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
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">
	
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript">
$(function() {
    showSubList(document.getElementById("mainCategory").value);
});
	
function showSubList(selectedValue){
	hideSubLists();
	resetSubLists();
	if(selectedValue == 1){
		document.getElementById("staffCategory").style.display = "block";
	} else if(selectedValue == 3){
		document.getElementById("gradeList").style.display = "block";
	} else if(selectedValue == 4){
		document.getElementById("coreSubjectList").style.display = "block";
	} else if(selectedValue == 5){
		document.getElementById("genderList").style.display = "block";
	} else if(selectedValue == 6){
		document.getElementById("maritalList").style.display = "block";
	} else if(selectedValue == 7){
		document.getElementById("religionList").style.display = "block";
	} else if(selectedValue == 8){
		document.getElementById("qualificationsList").style.display = "block";
	}
		
}

function hideSubLists(){
	document.getElementById("staffCategory").style.display = "none";
	document.getElementById("gradeList").style.display = "none";
	document.getElementById("genderList").style.display = "none";
	document.getElementById("coreSubjectList").style.display = "none";
	document.getElementById("maritalList").style.display = "none";
	document.getElementById("religionList").style.display = "none";
	document.getElementById("qualificationsList").style.display = "none";
}

function resetSubLists(){
	document.getElementById("catogaryID").selectedIndex = 0;
	document.getElementById("gradeId").selectedIndex = 0;
	document.getElementById("gender").selectedIndex = 0;
	document.getElementById("coreSubjectId").selectedIndex = 0;
	document.getElementById("civilStatusId").selectedIndex = 0;
	document.getElementById("religionId").selectedIndex = 0;
	document.getElementById("titleId").selectedIndex = 0;
	document.getElementById("studyArea").selectedIndex = 0;
	document.getElementById("specialGeneral").selectedIndex = 0;
	  
}

</script>
<style type="text/css">
.column-short{
	margin-left : 9px;
	float : left;
	width:auto!important;
}
.column-short .frmlabel{
	text-align: left;
	float:left;
	width:auto!important;
}
.column-short .frmlabel required_sign{

}
.column-short .frmlabel label{


}
.column-short select{
margin-left : 5px;
float : left;
width:auto!important;
}
</style>
</head>
<body>
	<div id="page_container">
		<div id="breadcrumb_area">			
			<div class="help_link">
			<a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/customizedStaffGeneralReportHelp.html"/>','helpWindow',780,550)">
			<img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/>
			</a>
			</div>
		</div>
		<div class="clearfix"></div>
			<h1><spring:message code="REPORT.STAFF.GENERAL.REPORTS"/></h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2><spring:message code="REPORT.SCHOOL.TEACHER.LIST"/></h2>
				</div>

				<div class="section_full_inside">
					<div class="box_border">

					<form:form action="customizedStaffGeneralReports.htm"
						commandName="SchoolTeacherAndSectionHeadList" method="POST"
						name="TeacherSectionHeadListForm">
							<div class="messageArea">	
								<label class="required_sign"> 
									<c:if test="${message != null}">${message}</c:if>
								</label>
								<label class="required_sign"> <form:errors path="*" /></label>
							</div>
							
								
							<div id="singleColumn" >
								<div class="row">
									<div class="frmlabel">
										<span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.REPORTTYPE"/></label>
									</div>
									<div class="frmvalue">
										<form:select path="listType" name="mainCategory" id="mainCategory" onchange="showSubList(this.value);">
											<form:option value="0"> <spring:message code="application.drop.down"/></form:option>
											<form:option value="1"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.STAFFTYPE"/></form:option>
											<form:option value="2"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.SECTIONTYPE"/></form:option>
											<form:option value="3"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.CLASSTEACHER"/></form:option>
											<form:option value="4"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.CORESUBJECT"/></form:option>
											<form:option value="5"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENDER"/></form:option>
											<form:option value="6"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.MARITAL"/></form:option>
											<form:option value="7"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.RELIGION"/></form:option>
											<form:option value="8"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.QUALIFICATION"/></form:option>
										</form:select>
										<input type="submit" class="button"
								value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
									</div>
									
								</div>

								<div class="row" id="staffCategory" style="display: none;">
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.CATEGORY"/></label></div>
										<div class="frmvalue">
											<form:select path="catogaryID" name="catogaryID">
												<form:option value="0" label=""> <spring:message code="application.drop.down"/></form:option>
												<form:option value="-1" label=""> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.CATEGORY.ALL"/></form:option>
												<c:if test="${staffCategoryList ne null}">
													<c:forEach var="categories" items="${staffCategoryList}">
														<form:option value="${categories.catogaryID}" label="${categories.description}" />
													</c:forEach>
												</c:if>
											</form:select>
									</div>
								</div>	
								<div class="row" id="gradeList" style="display: none;">	
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GRADE"/></label></div>
										<div class="frmvalue">
											<form:select path="gradeId" name="gradeId">
												<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
													<c:if test="${gradeList ne null}">
														<c:forEach var="grades" items="${gradeList}">
														<form:option value="${grades.gradeId}"
															label="${grades.description}" />
														</c:forEach>
													</c:if>
											</form:select>
									</div>

								</div>
								<div class="row" id="genderList" style="display: none;">	
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENDER.CHOOSE"/></label></div>
										<div class="frmvalue">
											<form:select path="gender" name="gender">
												<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
												<form:option value="M"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENDER.MALE"/></form:option>
												<form:option value="F"> <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENDER.FEMALE"/></form:option>								
											</form:select>
									</div>
								</div>
								<div class="row" id="coreSubjectList" style="display: none;">	
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.CORESUBJECT.TYPE"/></label></div>
										<div class="frmvalue">
											<form:select path="coreSubjectId" name="coreSubjectId">
												<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
													<c:if test="${coreSubjectList ne null}">
														<c:forEach var="subject" items="${coreSubjectList}">
														<form:option value="${subject.subjectId}"
															label="${subject.description}" />
														</c:forEach>
													</c:if>
											</form:select>
									</div>

								</div>
								<div class="row" id="maritalList" style="display: none;">	
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.MARITAL.CHOOSE"/></label></div>
									<div class="frmvalue">
										<form:select path="civilStatusId" name="civilStatusId">
											<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
												<c:if test="${maritalList ne null}">
													<c:forEach var="maritalStatus" items="${maritalList}">
													<form:option value="${maritalStatus.civilStatusId}"
														label="${maritalStatus.description}" />
													</c:forEach>
												</c:if>
										</form:select>
									</div>

								</div>
								<div class="row" id="religionList" style="display: none;">	
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.RELIGION.CHOOSE"/></label></div>
									<div class="frmvalue">
										<form:select path="religionId" name="civilStatusId">
											<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
												<c:if test="${religionList ne null}">
													<c:forEach var="religion" items="${religionList}">
													<form:option value="${religion.religionId}"
														label="${religion.description}" />
													</c:forEach>
												</c:if>
										</form:select>
									</div>
								</div>
								
								<div class="row" id="qualificationsList" style="display: none;">	
								<div class="column-short">
									<div class="frmlabel"><span class="required_sign">*</span><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.DEGREE.TITLE"/></label></div>
									<form:select path="titleId" name="titleId">
										<form:option value="0" label="" > <spring:message code="application.drop.down"/></form:option>
										<c:if test="${titleList ne null}"> 
										<c:forEach var="title" items="${titleList}">
											<form:option value="${title.titleId}" 
										label="${title.description}" />  
											</c:forEach>  
										</c:if>  
									</form:select>
									
								</div>
								<div class="column-short">
									<div class="frmlabel"><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENERALSPECIALTYPE"/></label></div>
									<form:select path="specialGeneral" name="specialGeneral">
										<form:option value="false" label="" ><spring:message code="application.drop.down"/></form:option>
										<form:option value="false" label="" > <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.GENERAL"/></form:option>
										<form:option value="true" label="" > <spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.SPECIAL"/></form:option>
									</form:select>
									
								</div>
								<div class="column-short">
									<div class="frmlabel"><label><spring:message code="REPORT.STAFF.SECTION.HEAD.STAFF.STUDYAREATYPE"/></label></div>
									<form:select path="studyArea" name="studyArea">
										<form:option value="0" label="" ><spring:message code="application.drop.down"/></form:option>
										<c:if test="${studyAreaList ne null}"> 
										<c:forEach var="studyArea" items="${studyAreaList}">
											<form:option value="${studyArea}" 
										label="${studyArea}" />  
											</c:forEach>  
										</c:if>  
									</form:select>
									
								</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<form:hidden path="category" name ="category" id="category"></form:hidden>
							<form:hidden path="gradeDescription" name ="gradeDescription" id="gradeDescription"></form:hidden>
							
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