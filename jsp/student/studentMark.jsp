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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE HTML> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code='APPLICATION.NAME' />
</title>

<!-- Jquery -->
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/ui.jqgrid.css" rel="stylesheet" type="text/css">
<!-- Jquery -->
<script type="text/javascript" src="resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script type="text/javascript" src="resources/js/grid.locale-en.js"></script>
<script type="text/javascript" src="resources/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/grid.celledit.js"></script>
<!-- Akura -->
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css"> 
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<!-- Akura -->  	 
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="resources/js/jquery.blockUI.js"></script>
<script src="resources/js/student/studentTermMark.js"></script> 

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
/* Term Mark save confirmation message */
function saveMark(invalideFiledCount) {

	if(invalideFiledCount.length>0){
		$("#validationErrorMessagelabel").html(markErrorMsg);
		$('#validationErrorMessage').show();
	}
	else{
		$('#validationErrorMessage').hide();
		
		var okfunction = function(){
			document.getElementById("submitBy").value = "";
			document.form.action = 'saveOrUpdateStudentTermMark.htm';
			document.form.submit();
		};
	
		var cancelfunction = function(){};
	
		var message = "<spring:message code='REF.SAVE.CONFIRMATION' />";
	
		confirm_function(message, okfunction, cancelfunction);
		
	}
	
}
function importAfterMarkComplete(){
	custom_alert('You can not import after mark completion.');
}

	function clearTextBox(element) {
		var elementObject = $(element);
		var tempVal = elementObject.val();

		if (tempVal == 0.0 || tempVal == 0) {
			elementObject.val("");
		}
	}

	function resetTextBox(element) {
		var elementObject = $(element);
		var tempVal = elementObject.val();

		if (tempVal == 0.0 || tempVal == 0) {
			elementObject.val("0.0");
		}
	}
	
	function openWindow(){
	
	$("#importForm").show();
			
	}
	
function downloadFile(){		
	bulkUploadBlockUI();
	document.getElementById("submitBy").value = "downloadFile";
    document.getElementById("fromid").submit();
    document.getElementById("errmsg").innerHTML ="<p><spring:message code='STUDENT_TERM_MARK_EMPTY_STRING' /></p>";
}
	
	

function searchBtn() {
	document.getElementById("submitBy").value = "searchBtn";
    document.getElementById("fromid").submit();
}


var check = false;
function uploadFile(){	
	$('#errorMessage').hide();
	$('#successMessage').hide(); 
	//check whether the file is chosen or not
	if(document.getElementById("classUpload").value!=""){
		if(document.getElementById("classUpload").value.indexOf(".xls") != -1 ){
	bulkUploadBlockUI();
	document.getElementById("submitBy").value = "uploadFile";
	document.getElementById("fromid").submit();	
	}else
		
		
		document.getElementById("errmsg").innerHTML ="<p Class='required_sign'><spring:message code='STUDENT_TERM_MARK_FILE_NOT_XSL' /></p>";
	}else{		
	 //if not selected print this message
	 document.getElementById("errmsg").innerHTML ="<p Class='required_sign'><spring:message code='STUDENT_TERM_MARK_FILE_NOT_SELECTED' /></p>";
	}
	/* document.getElementById("errmsg").innerHTML ="<p><spring:message code='STUDENT_TERM_MARK_EMPTY_STRING' /></p>"; */
	
	 
}

</script>

<script type="text/javascript">
	var admissionNo = "<spring:message code='STUDENT.STUDENTMARK.ADMISSIONNO' />";
	var studentName = "<spring:message code='STUDENT.STUDENTMARK.STUDENTNAME' />";
	var studentRank = "<spring:message code='STUDENT.STUDENTMARK.STUDENTRANK' />";
	var studentAverage = "<spring:message code='STUDENT.STUDENTMARK.STUDENTAVERAGE' />";
	var total = "<spring:message code='STUDENT.STUDENTMARK.STUDENTTOTAL' />";
	var isEditable = "<spring:message code='STUDENT.STUDENTMARK.IS.EDITABLE' />";
	var termMarkID = "<spring:message code='STUDENT.STUDENTMARK.TERM.MARK.ID' />";
	var optional = "<spring:message code='STUDENT.STUDENTMARK.OPTIONAL' />";
	var validator = "<spring:message code='TERM.MARK.VALIDATOR.MARK' />";
	var markErrorMsg = "<spring:message code='REF.UI.STUDENT.MARKASSIGN.MARK.INVALID' />";	
	var admissionNoIndex = "<spring:message code='STUDENT.STUDENTMARK.ADMISSIONNUMBER.INDEX' />";
	var studentNameIndex = "<spring:message code='STUDENT.STUDENTMARK.COLUMN.STUDENTNAME.INDEX' />";
	var subjectNames = null;
	var isFromUpload = null;
	var isMarkingCompletedInDB = null;
	function termMarkGrid() {	
	
		isFromUpload = '${isFromUpload}';
		isFromUpload = $.parseJSON(isFromUpload);
		
		sMarkingCompletedInDB = '${markingCompleted}';
		isMarkingCompletedInDB = $.parseJSON(isMarkingCompletedInDB);
		
		var jsonData='${termMarkJsonData}';  
		var subjectOptionalStatus='${Optional}'; 
		subjectOptionalStatus = $.parseJSON(subjectOptionalStatus);
		var showMarkingComplete ='${showMarkingComplete}'; 
		showMarkingComplete = $.parseJSON(showMarkingComplete);
		subjectNames = getSubjectNames(subjectOptionalStatus);
		termMarkGridView(jsonData,subjectOptionalStatus,showMarkingComplete);
		
		 $("#importForm").hide();
	}

function cancelUpload(){
	$("#classUpload").val("");
	$("#importForm").hide();
	document.getElementById("errmsg").innerHTML ="<p><spring:message code='STUDENT_TERM_MARK_EMPTY_STRING' /></p>";
}

</script>


<script type="text/javascript">

	
function subTermMarkGrid() {

		var jsonData='${subTermMarkJsonData}';  
		var subjectOptionalStatus='${Optional}'; 
		subjectOptionalStatus = $.parseJSON(subjectOptionalStatus);
		 
		subTermMarkGridView(jsonData,subjectOptionalStatus);

		$("#importForm").hide();
		$("div#col2").hide();
}



</script>

<script type="text/javascript">
	
	/* If there is any edited data in the grid when click cancel, ask for some confirmation */
	
	function CheckForEditedDataCancelButton(){
		var editedData = JSON.parse(populateEditedMarkJsonArray());
		if(editedData.length>0){
			
			var okfunction = function(){
				document.location.href='studentMarks.htm';
			};
			
			var cancelfunction = function(){};
			
			var message = '<spring:message code="STUDENT.STUDENTMARK.UNSAVEDMARK" />';
			
			confirm_function(message, okfunction, cancelfunction);	
			
		}
		else{
			document.location.href='studentMarks.htm';
		}
	}
	
	/* If there is any edited data in the grid when click Reset, ask for some confirmation */
	
	function CheckForEditedDataResetButton(){
		var editedData = JSON.parse(populateEditedMarkJsonArray());
		if(editedData.length>0){
			
			var okfunction = function(){
				document.form.action='searchStudentTermMarkList.htm'; 
				document.form.submit();
				document.getElementById('search_results').style.display=''; 
				document.getElementById('btn_row').style.display='';
			};
			
			var cancelfunction = function(){};
			
			var message = '<spring:message code="STUDENT.STUDENTMARK.UNSAVEDMARK" />';
			
			confirm_function(message, okfunction, cancelfunction);	
			
		}
		else{
			document.form.action='searchStudentTermMarkList.htm'; 
			document.form.submit();
			document.getElementById('search_results').style.display=''; 
			document.getElementById('btn_row').style.display='';
		}
	}
	
	/* If there is any edited data in the grid when click Export, ask for some confirmation */
	
	function CheckForEditedDataExportButton(){
		var editedData = JSON.parse(populateEditedMarkJsonArray());
		if(editedData.length>0){
			
			var okfunction = function(){
				downloadFile();
			};
			
			var cancelfunction = function(){};
			
			var message = '<spring:message code="STUDENT.STUDENTMARK.UNSAVEDMARK" />';
			
			confirm_function(message, okfunction, cancelfunction);	
			
		}
		else{
			document.form.action='searchStudentTermMarkList.htm'; 
			downloadFile();
		}
	}
	
	/* If there is any edited data in the grid when click Import, ask for some confirmation */
	
	function CheckForEditedDataImportButton(){
		var editedData = JSON.parse(populateEditedMarkJsonArray());
		if(editedData.length>0){
			
			var okfunction = function(){
				openWindow();
			};
			
			var cancelfunction = function(){};
			
			var message = '<spring:message code="STUDENT.STUDENTMARK.UNSAVEDMARK" />';
			
			confirm_function(message, okfunction, cancelfunction);	
			
		}
		else{
			openWindow();
			document.form.action='searchStudentTermMarkList.htm'; 
		}
		document.getElementById("errorMessage").innerHTML ="<lable><spring:message code='STUDENT_TERM_MARK_EMPTY_STRING' /></lable>";
	}
	
</script>


</head>
<body>

	<!-- Import the page header from custom tag library -->
	<h:headerNew parentTabId="10" page="studentMarks.htm" />

	<!-- Generate dynamic page content -->
	<div id="page_container">
		<div id="breadcrumb">
			<ul>
				<li><a href="adminWelcome.htm"><spring:message
							code='application.home' /> </a>&nbsp;&gt;&nbsp;</li>
				<li><spring:message code='STUDENT.STUDENTMARK.ADD' />
				</li>
			</ul>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentMarksHelp.html"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code='STUDENT.STUDENTMARK.ADD' />
		</h1>
		
		<div>
			 
			<div id="errorMessage" name="errorMessage">
			  <label class="missing_required_error" id="errorMessagelabel" name="errorMessagelabel">${message}</label>
			 
			</div>
			<div id="errmsg" name="errmsg">
			 
			 
			</div>
		
			<script>
				$('#errorMessage').hide();
			</script>
			
			<c:if test="${message != null}">
			<script>
				$('#errorMessage').show();
				 document.getElementById('errorMessagelabel').innerText = "${message}";
				
				</script>
			</c:if>
			
			<div id="successMessage" name="successMessage">
			  <label class="success_sign" id="successMessagelabel" name="successMessagelabel">${successMessage}</label>
			</div>
			
			
			<script>
				$('#successMessage').hide();
			</script>
			
			<c:if test="${successMessage != null}">
			<script>
				$('#successMessage').show();
				 document.getElementById('successMessagelabel').innerText = "${successMessage}";
				
				</script>
			</c:if>
			
			<c:set var="isStudentSubTermMarkMapEmpty" scope="session"
				value="${(not empty studentsubtermmarkmap)? true : false}" />
			<c:set var="isTermMark" scope="session"
				value="${gradingType eq 'MG'? true : false}" />
		</div>
		<div id="content_main">
			<form action="" id="fromid" method="post" name="form" modelAttribute="uploadedClassFile" name="classUpload" enctype="multipart/form-data">
				<!-- Initialize JSTL variables -->
				<c:set var="gradeclassdescription" value="" />
				<c:set var="termdescription" value="" />
				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border">
						<p>
							<spring:message code='STUDENT.STUDENTMARK.SEARCHCLASS' />
						</p>
						<input type="hidden" id="path" name="path" value="">
						<input type="hidden" id="fileName" name="fileName" value="">
						<input type="hidden" id="submitBy" name="submitBy" value="">
						<div class="row">
							<!-- Render class list style="margin-right: inherit"-->
							<div class="float_left" >
								<div class="lbl_lock">
									<span class="required_sign">*</span><label><spring:message
											code='REF.UI.EXAM.MARK.YEAR' />:</label>
								</div>
								<select name="year" id="year">
									<c:if test="${yearList != null}">
										<c:forEach var="year" items="${yearList}">
											<!-- if the year is equals to the selected year then seleted the option of the drop down. -->
											<option value="${year}"
												<c:if test = "${errorYear != null && year eq errorYear}">
				selected = "selected"</c:if>>${year}</option>
										</c:forEach>
									</c:if>
								</select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message
											code='STUDENT.STUDENTMARK.SELECTCLASS' />:</label>
								</div>
								<select name="selectedClass"  id="classs">
									<option value="0">
										<spring:message code='application.drop.down' />
									</option>
									<c:forEach var="gradeclass" items="${gradeClassList}">
										<c:set var="testval" value="" />
										<c:if test="${gradeclass.classGradeId eq classGradeId}">
											<c:set var="testval" value="SELECTED" />
											<c:set var="gradeclassdescription"
												value="${gradeclass.description}" />
										</c:if>
										<option label="${gradeclass.description}"
											value="${gradeclass.classGradeId}"
											<c:out value="${testval}"></c:out>>
											${gradeclass.description}</option>
									</c:forEach>
								</select>
							</div>

							<!-- Render term list -->
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message
											code='STUDENT.STUDENTMARK.TERM' />:</label>
								</div>
								<select name="selectedTerm" id="term">
									<option value="0">
										<spring:message code='application.drop.down' />
									</option>
									<c:forEach items="${studentTermList}" var="term">
										<c:set var="testval" value="" />
										<c:if test="${term.termId eq termId}">
											<c:set var="testval" value="SELECTED" />
											<c:set var="termdescription" value="${term.description}" />
										</c:if>
										<option label="${term.description}" value="${term.termId}"
											<c:out value="${testval}"></c:out>>
											${term.description}</option>
									</c:forEach>
								</select>
							</div>

							<!-- Render grade list -->
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message
											code='STUDENT.STUDENTMARK.SELECTGRADE' />:</label>
								</div>
								<select name="selectGrid"  id="grid">

									<c:choose>
										<c:when test="${gradingType eq 'MG' }">
											<option value="0" selected>
												<spring:message code='application.drop.down' />
											</option>
											<option value="TG">
												<spring:message code='STUDENT.STUDENTMARK.TERMGRADE' />
											</option>
											<option value="MG" selected>
												<spring:message code='STUDENT.STUDENTMARK.MONTHLYGRADE' />
											</option>
										</c:when>
										<c:when test="${gradingType eq 'TG' }">
											<option value="0" selected>
												<spring:message code='application.drop.down' />
											</option>
											<option value="TG" selected>
												<spring:message code='STUDENT.STUDENTMARK.TERMGRADE' />
											</option>
											<option value="MG">
												<spring:message code='STUDENT.STUDENTMARK.MONTHLYGRADE' />
											</option>
										</c:when>
										<c:otherwise>
											<option value="0" selected>
												<spring:message code='application.drop.down' />
											</option>
											<option value="TG">
												<spring:message code='STUDENT.STUDENTMARK.TERMGRADE' />
											</option>
											<option value="MG">
												<spring:message code='STUDENT.STUDENTMARK.MONTHLYGRADE' />
											</option>
										</c:otherwise>
									</c:choose>
								</select>
							</div>
							<!-- set privillage for search student term mark  -->
							<sec:authorize access="hasRole('Search Student Marks')">
								<div class="float_right">

									<div class="buttion_bar_type1">

										<input type="button"
											value="<spring:message code='STUDENT.STUDENTMARK.SEARCH.CLASS' />"
											onClick="document.form.action='searchStudentTermMarkList.htm'; searchBtn();"
											class="button">
									</div>
									
									
								</div>
							</sec:authorize>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>

				<!-- represents the error messages. -->
				<c:if test="${(not empty studentList) and (empty gradeSubjectList)}">
					<div class="box_border">

						<p>
							<font color="red"><spring:message
									code='STUDENT.STUDENTMARK.ERRORMSG1' /> </font>
						</p>
					</div>
				</c:if>
				<c:if test="${(empty studentList) and (not empty gradeSubjectList)}">
					<div class="box_border">

						<p>
							<font color="red"><spring:message
									code='STUDENT.STUDENTMARK.ERRORMSG2' /> </font>
						</p>
					</div>
				</c:if>

				<c:if
					test="${(not empty studentList) and (not empty gradeSubjectList) }">
					
				
					
					<div class="section_box" id="search_results">
						<div class="section_box_header">
							<h2>
								${gradeclassdescription} (${termdescription })
								<spring:message code='STUDENT.STUDENTMARK.MARKS' />
							</h2>
						</div>
						<div class="column_single">
							<div style="width: 100%;height: 40px;">
								<div style="width: 70%;" id="validationErrorMessage" name="validationErrorMessage">
									<label class="missing_required_error" id="validationErrorMessagelabel" name="validationErrorMessageerrorMessagelabel"></label>
								</div>
								<div id="col2" style="float:right;width: 30%;">
							<!--	
							<p>
								<font size="1"> <spring:message
										code="STUDENT.STUDENTMARK.MAXIMUM.MARK"></spring:message> </font>
							</p>
							-->		
							
							<sec:authorize access="hasAnyRole('Term Mark Import')">
								<c:if test="${ showMarkingComplete eq true }">
									<c:if test="${ markingCompleted eq true }">

										
											<input type="button"
												value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.IMPORT' />"
												onclick="importAfterMarkComplete();" class="button">
										

									</c:if>
									<c:if test="${ markingCompleted eq false }">

										
											<input type="button"
												value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.IMPORT' />"
												onclick="CheckForEditedDataImportButton();" class="button">
										

									</c:if>
								</c:if>

								<c:if test="${ !(showMarkingComplete eq true) }">
									<c:if test="${!(user.role eq 'ROLE_ADMIN')}">
										<c:if test="${ !(user.role eq 'ROLE_TEACHER') }">
											<c:if test="${ markingCompleted eq true }">

												
													<input type="button"
														value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.IMPORT' />"
														onclick="importAfterMarkComplete();" class="button">
												

											</c:if>
											<c:if test="${ markingCompleted eq false }">

												
													<input type="button"
														value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.IMPORT' />"
														onclick="CheckForEditedDataImportButton();" class="button">
												

											</c:if>
										</c:if>

									</c:if>
								</c:if>

							</sec:authorize>
							<sec:authorize access="hasAnyRole('Term mark Export')">
								<c:if test="${ showMarkingComplete eq true }">
									
										<input type="button"
											value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.EXPORT' />"
											onclick="CheckForEditedDataExportButton();" class="button">
									
								</c:if>
								<c:if test="${ !(showMarkingComplete eq true) }">
									<c:if test="${!(user.role eq 'ROLE_ADMIN')}">
										<c:if test="${ !(user.role eq 'ROLE_TEACHER') }">
											
												<input type="button"
													value="<spring:message code='STUDENT.STUDENTMARK.TERMMARK.EXPORT' />"
													onclick="CheckForEditedDataExportButton();" class="button">
											
										</c:if>

									</c:if>
								</c:if>

							</sec:authorize>
							</div>
						</div>
						<br/>
		<div class="box_border" id="importForm">
		<div id="content_main">
				<div class="section_box">
					<div class="section_box_sub_header">
						<h2><spring:message code="STUDENT.STUDENTMARK.FILEUPLOAD.TITLE"/></h2>
					</div>					
					<div id="singleColumn">
						<div class="raw">
							<div class="frmlable">
								<label id="yearSet">Year: ${yearToSet}</label>
								<label id="classSet">Class: ${gradeclassdescription}</label>
								<label id="termSet">Term: ${termToSet}</label>
							</div>
						</div> <br />
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="STUDENT.STUDENTMARK.FILEUPLOAD.NAME"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input class="upload-file" name="classUpload" type="file" style="width: 290px;" id="classUpload" value="">
								<input type="hidden" name="year" value="">
								<input type="hidden" name="sclass" value="">
								<input type="hidden" name="term" value="">
								<input type="hidden" name="type" value="">
								<input type="hidden" name="sortCol" value="">
								<input type="hidden" name="sortOrder" value="">
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="button" value="Upload" onclick="clearMessages(),uploadFile();" class="button btnUpload" style="margin-left:0" />	
								<input type="button" value="Cancel" onclick="cancelUpload();" class="button btnUpload" style="margin-left:0" />						
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>				
		</div>
		</div>
							
							
							<!-- Term Marks View -->
							<div id="tableDiv_General" class="tableDiv" align="center" style="padding-top: 10px;">
							<table id="users" class="FixedTables">
							</table>
							<div id="usersPage" ></div>
								
							</div>

							<c:if
								test="${(not empty termMarkJsonData) }">
								<input type="hidden" id="gradeID" name="gradeID" value="${gradeID}" />
								<script>
								
									termMarkGrid();
								</script>
							</c:if> 
							
							<c:if
								test="${(not empty subTermMarkJsonData) }">
								<script>
									subTermMarkGrid();
								</script>
							</c:if>
							
							<input type="hidden" id="editedMarksJsonArray" name="editedMarksJsonArray" value="" />
							<input type="hidden" id="toMarkComplete" name="toMarkComplete" value="" />
							<!-- Sub Term Marks View -->
							
						</div> 
						<div class="clearfix"></div>
					</div>

					<c:if test="${gradingType eq 'TG' and showMarkingComplete}">
						<input type="checkbox" id="markingCompleted" name="markingCompleted"
							value="markingCompleted"
							<c:if test="${markingCompleted}">checked disabled</c:if> />
						<c:if test="${markingCompleted}">
							<input type="hidden" id="markingCompleted" name="markingCompleted"
								value="markingCompleted" />
						</c:if>
						<spring:message code="STUDENT.STUDENTMARK.MARKED"></spring:message>
					</c:if>
					<br>

					<!-- Set privillages for save,delete cancel term mark for teacher -->
					
					<c:choose>
						<c:when test="${user.role eq 'ROLE_TEACHER'}">
							<div id="btn_row" class="button_row">
								<div class="buttion_bar_type2">
									<!-- Hidden fields -->
									<c:if
										test="${(classGradeId ne 'null') and (termId ne 'null') and (gradingType ne 'null')}">
										<input type="hidden" name="selectedClass"
											value="${classGradeId}">
										<input type="hidden" name="selectedTerm" value="${termId}">
										<input type="hidden" name="selectGridId"
											value="${gradingType}">
									</c:if>
									<!-- Render buttons -->
									<input type="button"
										value="<spring:message code='REF.UI.RESET'/>"
										onClick="CheckForEditedDataResetButton(),clearMessages();"
										class="button"> 
								    <input type="button"
									    id="saveButton"
										value="<spring:message code='REF.UI.SAVE'/>" class="button"> 
									<input
										type="button" value="<spring:message code='REF.UI.CANCEL'/>"
										class="button"
										onclick="CheckForEditedDataCancelButton(),clearMessages();">
								</div>
								<div class="clearfix"></div>
							</div>
						</c:when>

						<c:otherwise>
							<sec:authorize ifAllGranted="Add Student mark,Edit Student mark">

								<div id="btn_row" class="button_row">
									<div class="buttion_bar_type2">
										<!-- Hidden fields -->
										<c:if
											test="${(classGradeId ne 'null') and (termId ne 'null') and (gradingType ne 'null')}">
											<input type="hidden" name="selectedClass"
												value="${classGradeId}">
											<input type="hidden" name="selectedTerm" value="${termId}">
											<input type="hidden" name="selectGridId"
												value="${gradingType}">
										</c:if>
										<!-- Render buttons -->
										<input type="button"
											value="<spring:message code='REF.UI.RESET'/>"
											onClick="CheckForEditedDataResetButton();"
											class="button"> 
										<input type="button"
											id="saveButton"
											value="<spring:message code='REF.UI.SAVE'/>"
											class="button"> 
										<input
											type="button" value="<spring:message code='REF.UI.CANCEL'/>"
											class="button"
											onclick="CheckForEditedDataCancelButton(); ">
									</div>
									<div class="clearfix"></div>
								</div>
							</sec:authorize>
						</c:otherwise>
					</c:choose>
						
						
						


				</c:if>
				
				<c:if test="${path != null}">
				<script>
				document.getElementById("submitBy").value = "";
				
				var filePath = "${path}";
				var fileName = "${fileName}";
				window.location.assign("errorFileDownload.htm?fileType=xls&fileName="+filePath+"&filePaths="+filePath);
				
				
				//document.getElementById("path").value = "${path}";
				//document.getElementById("fileName").value = "${fileName}";
				//document.getElementById("fromid").action = 'fileDownLoad.htm';
				//document.getElementById("fromid").submit(); 
				//document.getElementById("fromid").action = 'searchStudentTermMarkList.htm';
				</script>
			</c:if>

			</form>
		</div>
	</div>
	<!-- Import footer from custom tag library -->
	<h:footer />

</body>
</html>



