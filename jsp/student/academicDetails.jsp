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
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<jsp:useBean id="now" class="java.util.Date" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>


<script type="text/javascript">
function validate(){
  var iChars = "'";
  var myTextArea = document.getElementById("seminarDetailArea");
  var str=myTextArea.value;

  for (var i = 0; i < document.MarkForm.seminarDetailArea.value.length; i++) {
    if (iChars.indexOf(document.MarkForm.seminarDetailArea.value.charAt(i)) != -1) {
    	var finalStr = str.replace("'","");
    	myTextArea.value=finalStr;
    return false;
    }
  }
}
</script>


<script type="text/javascript">

	//function to show marks of the student. This will load marks of the current Grade.
	function showMarks(thisVal){
		//set the action to submit the form.
		document.MarkForm.action="showMarks.htm";
		//submit the form.
		document.MarkForm.submit();
	}

	//function to showSubTerm of the students selected grade.
	function showSubTerm(subject){

		//Get the selected Grade.
		var e = document.getElementById("selectedGrade");
		var selectedGrade = e.options[e.selectedIndex].innerHTML;

		//Set the URL to get subterm view.
		selectedGrade = selectedGrade.replace(/^\s+|\s+$/g,"");
		var url = "showSubTermView.htm?year="+selectedGrade.substring(0,4)+"&subject="+subject;

		//Set the popup values.
		PopupCenter(url, 'myPop1',750,190);
	}

	//function to show assignment marks of the students for selected grade.
	function showAssignment(subject){

		//Get the selected Grade.
		var e = document.getElementById("selectedGrade");
		var selectedGrade = e.options[e.selectedIndex].innerHTML;

		//Set the URL to get assignment view.
		selectedGrade = selectedGrade.replace(/^\s+|\s+$/g,"");
		var url = "showAssignmentMarks.htm?year="+selectedGrade.substring(0,4)+"&subject="+subject;

		//Set the popup values.
		PopupCenter(url, 'myPop1',750,190);
	}

	//function to show exam marks of the student for a selected grade.
	function showExamMark(){

		//Get the selected Grade.
		var e = document.getElementById("selectedGrade");
		var selectedGrade = e.options[e.selectedIndex].innerHTML;

		//Set the URL to get assignment view.
		selectedGrade = selectedGrade.replace(/^\s+|\s+$/g,"");
		var url = "showExamMarks.htm?year="+selectedGrade.substring(0,4);

		//Set the popup values.
		PopupCenterScroll(url,'helpWindow',680,500);
	}

	//function to addAction.
	function addAction(thisVal){

			document.MarkForm.idFoundForPrefect.value = "false";
			document.MarkForm.idFoundForScholarship.value = "false";
			document.MarkForm.idFoundForAchievment.value = "false";
			setAddEditPane(thisVal,'Add');
			document.MarkForm.selectedPrefectType.options[0].selected = "selected";
			document.MarkForm.selectedScholarshipType.options[0].selected = "selected";
			document.MarkForm.achievementTextArea.value = "";
	}

	//function to savePrefectAction.
	function savePrefectAction(thisVal){
		//if an id is found for Prefect then edit the Prefect details.
		if(document.MarkForm.idFoundForPrefect.value == "true"){
			document.MarkForm.action ="editPrefectDetails.htm";
		}else{
		//id is not found then save the Prefect details.
			document.MarkForm.action ="savePrefectDetails.htm";
		}
		//Set the form submit action.
		document.MarkForm.submit();
	}

	//function to editPrefectImgAction.
	function editPrefectImgAction(thisValue, selectedValue, selectVal, PrefectTypeList){

		//set the values to PrefectType to object to be edited.
		setAddEditPane(thisValue,'Edit');
		document.MarkForm.selectedPrefectId.value = selectedValue;
		document.MarkForm.selectedStudentPrefectId.value = selectVal;
		document.MarkForm.idFoundForPrefect.value = "true";

		//Set the selected Prefect type.
	    for (var d = 0; d < document.MarkForm.selectedPrefectType.length; d++) {
	        if(document.MarkForm.selectedPrefectType.options[d].value == document.MarkForm.selectedPrefectId.value){
	        	document.MarkForm.selectedPrefectType.options[d].selected = "selected";
	    	}
	    }
	}

	//function to deletePrefectImgAction.
	function deletePrefectImgAction(thisValue, selectedValue){

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		//Get the selected Prefect Id.
		document.MarkForm.selectedStudentPrefectId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var okfunction = function(){
			document.MarkForm.action='deletePrefectDetails.htm';
			document.MarkForm.submit();
		};
        var cancelfunction = function(){	
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message, okfunction, cancelfunction);
		
	}

	//function to saveScholarshipAction.
	function saveScholarshipAction(thisVal){

		if(document.MarkForm.idFoundForScholarship.value == "true"){
			//Set the action to submit the form.
			document.MarkForm.action ="editScholarshipDetails.htm";
		}else{
			//Set the action to submit the form.
			document.MarkForm.action ="saveScholarshipDetails.htm";
		}
		//Submit the form.
		document.MarkForm.submit();
	}

	//function to editScholarshipImgAction.
	function editScholarshipImgAction(thisValue, selectedValue, selectVal){

		//set the values to PrefectType to object to be edited.
		setAddEditPane(thisValue,'Edit');
		document.MarkForm.selectedScholarshipId.value = selectedValue;
		document.MarkForm.selectedStudentScholarshipId.value = selectVal;
		document.MarkForm.idFoundForScholarship.value = "true";

		//Set the selected ScholarshipType to edit.
		for (var s = 0; s < document.MarkForm.selectedScholarshipType.length; s++) {
	        if(document.MarkForm.selectedScholarshipType.options[s].value == document.MarkForm.selectedScholarshipId.value){
	        	document.MarkForm.selectedScholarshipType.options[s].selected = "selected";
	    	}
	    }
	}

	//function to deleteScholarshipImgAction.
	function deleteScholarshipImgAction(thisValue, selectedValue){

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.MarkForm.selectedStudentScholarshipId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var okfunction = function(){
			document.MarkForm.action = "deleteScholarshipDetails.htm";
			document.MarkForm.submit();
		};
		
		var cancelfunction = function(){
			
			$(thisValue).parents('tr').removeClass('highlight');
		};

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message,okfunction, cancelfunction);
		
	}

	//function to save AchievementAction.
	function saveAchievementAction(thisVal){

		if(document.MarkForm.idFoundForAchievment.value == "true"){
			document.MarkForm.action ="editAchievementDetails.htm";
		}else{
			document.MarkForm.action ="saveAchievementDetails.htm";
		}
		document.MarkForm.submit();
	}

	//function to edit AchievementImgAction.
	function editAchievementImgAction(thisValue, selectedValue, selectedVal){

		setAddEditPane(thisValue,'Edit');
		//Un escape the special characters wich already escaped, in Academic Achievment description
		document.MarkForm.achievementTextArea.value = $("<div/>").html(selectedVal).text();;
		document.MarkForm.selectedStudentAchievementId.value = selectedValue;
		document.MarkForm.idFoundForAchievment.value = "true";
	}

	//function to delete AchievementImgAction.
	function deleteAchievementImgAction(thisValue, selectedValue){

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.MarkForm.selectedStudentAchievementId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.MarkForm.action = "deleteAchievementDetails.htm";
			document.MarkForm.submit();
		};
		
		var cancelfunction = function(){
			
			$(thisValue).parents('tr').removeClass('highlight');
		};

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);

	}

	// function to edit seminar
	function onClickEditSeminar(thisValue,StudSemId,description,seminarId){
		
		// to display edit panal.
		document.getElementById("massageSeminar").innerHTML="";
		
		//document.MarkForm.seminarDetailArea.value = description;
		// Un escape the special characters wich already escaped, in seminar description
		document.MarkForm.seminarDetailArea.value = $("<div/>").html(description).text();

		// set the student Seminar Id to post
		// when edit, StudentSemID form param should be grater than 0
		document.MarkForm.StudentSemID.value = StudSemId;

		// to set select the previous seminar
		var selectTag=document.MarkForm.selectSemID;
		for (var i=0; i<selectTag.options.length; i++){
		 if (selectTag.options[i].value==seminarId){
				 selectTag.options[i].selected=i;
			  break;
			 }
		}

		setAddEditPane(thisValue,'Edit');
	}

	//function to add seminar
	function onClickAddSeminar(thisValue){

		// when Add, StudentSemID form param should be "0"
		document.MarkForm.StudentSemID.value = "0";

		document.MarkForm.seminarDetailArea.value="";
		document.getElementById("massageSeminar").innerHTML="";
		setAddEditPane(thisValue,'Add');

	}

	//finction to delete seminar
	function onClickDelSeminar(thisValue,StudSemId){

		// requst to remove the given record from student
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		// requst to hide the given record from student
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var okfunction = function(){
			document.MarkForm.StudentSemID.value = StudSemId;
			document.MarkForm.action ="deleteSeminarsDetails.htm";
			document.MarkForm.submit();
		};
		
		var cancelfunction = function(){		
			$(thisValue).parents('tr').removeClass('highlight');
		};

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		
		confirm_function(message,okfunction, cancelfunction);
	}

	//function to save seminar
	function seminarSorEAction(thisValue){

		//request for save or edit seminars for student
		var SeminarID= document.MarkForm.selectSemID.value;

			document.MarkForm.action ="saveEditSeminarsDetails.htm";
			document.MarkForm.submit();

	}


	/* fucntion for show hide panels*/
	function showHidePanels(){
			var panel = new String('${not empty error_msg_section?error_msg_section:"empty"}')
			var panel_id = "section_full_inside_" + panel;
			if(document.getElementById(panel_id) != null){
				document.getElementById(panel_id).style.display = "block";
			}

			/* set open state values*/
			document.getElementById("selectedPrefectType").value = "${not empty selectedPrefectType?selectedPrefectType:'0'}";
			document.getElementById("selectedScholarshipType").value = "${not empty selectedScholarshipType?selectedScholarshipType:'0'}";
			document.getElementById("achievementTextArea").value = "${not empty achievementTextArea?achievementTextArea:''}";
			document.getElementById("selectSemID").value = "${not empty selectSemID?selectSemID:'0'}";
			document.getElementById("seminarDetailArea").value = "${not empty seminarDetailArea?seminarDetailArea:''}";
	}

	//function for limit text in text area
    function limitText(limitField, limitNum) {
		//maxlength is not work in IE8
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		}
	 }

</script>
</head>
<body onload="showHidePanels()">

<c:set var="isMarksNotEnterd" value="false" />
	<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
	<%--check whether logged user is student or parent --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="academicDetails.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="academicDetails.htm" />
		</c:otherwise>
	</c:choose>

	<div id="page_container">
		<div id="breadcrumb_area">
		
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>

					<%-- Checks the logged role has the privileges to view academic life. --%>

					<sec:authorize access="hasRole('Student Search')">
						<li><a href="studentSearch.htm"><spring:message code="STUDENT.STUDENTSEARCH"/></a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="STUDENT.ACADEMIC.TITLE"/></li>
				</ul>
			</div>
				<div class="help_link">
					<a href="#"
						onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/academicLifeHelp.html"/>','helpWindow',780,550)"><img
						src="resources/images/ico_help.png" width="20" height="20"
						align="absmiddle"><spring:message code="application.help"/></a>
				</div>
			<c:if test="${showAcademicLifeBar eq 'on'}">
				<div id="progress_bar_wraper">
					<label><spring:message
							code="STUDENT.PROGRESS.ACADEMIC_LIFE" />
					</label>
					<div class="progress_bar">
						<c:if test="${not empty averageAcademicLife}">
							<div class="colour_bar"
								style="width:<c:out value="${averageAcademicLife}"/>px"></div>
							<div class="prog_value">
								<c:out value="${averageAcademicLife}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${showReligiousActivitiesBar eq 'off'}">
				<div id="progress_bar_wraper">
					<label><spring:message
							code="STUDENT.PROGRESS.RELIGIOUS_ACTIVITY" />
					</label>
					<div class="progress_bar">
						<c:if test="${!(averageFaithLife == null)}">
							<div class="colour_bar"
								style="width: <c:out value="${averageFaithLife}" />px"></div>
							<div class="prog_value">
								<c:out value="${averageFaithLife}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${showAttendanceBar eq 'on'}">
				<div id="progress_bar_wraper">
					<label><spring:message code="STUDENT.PROGRESS.ATTENDANCE" />
					</label>
					<div class="progress_bar">
						<c:if test="${!(attendanceRating == null)}">
							<div class="colour_bar"
								style="width: <c:out value="${attendanceRating}" />px"></div>
							<div class="prog_value">
								<c:out value="${attendanceRating}" />
								%
							</div>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="STUDENT.ACADEMIC.TITLE"/></h1>
		<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.NAME"/>&nbsp;</label> ${student.nameWtInitials}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.ADDMISSION"/>&nbsp;</label> ${student.admissionNo}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.CLASS"/>&nbsp;</label> ${studentClassDescription}
					</div>
					<div class="clearfix"></div>
				</div>
			</div>

<c:choose>
<c:when test="${not empty hasStudentClass}">

			<c:if test="${showErrorDefault != null}">
				<h3><spring:message code="STUDENT.ACADEMIC.ASSIGNTOCLASS"/></h3>
			</c:if>
			
			<form:form action="" method="POST" id="MarkForm" name="MarkForm">
				<input type="hidden" name="selectedPrefectId">
				<input type="hidden" name="selectedStudentPrefectId">
				<input type="hidden" name="selectedScholarshipId">
				<input type="hidden" name="selectedStudentScholarshipId">
				<input type="hidden" name="selectedStudentAchievementId">
				<input type="hidden" name="idFoundForPrefect" value="false">
				<input type="hidden" name="idFoundForScholarship" value="false">
				<input type="hidden" name="idFoundForAchievment" value="false">
				<div class="section_full">
					<div class="row">
						<div class="messageArea">
							<c:if test="${message != null}">
								<div>
									<label class="required_sign">${message}</label>
								</div>	
							</c:if>
							<c:if test="${assginMessage != null}">
								<div>
									<label class="success_sign">${assginMessage}</label>
								</div>	
							</c:if>
						</div>

			<label><strong></strong><spring:message code="STUDENT.ACADEMIC.STUDENTGRADE"/></label>
						<select
							name="selectedGrade" onchange="showMarks(this)" id="selectedGrade">
										<option value="0">
											<spring:message code="application.drop.down" />
										</option>
										<c:forEach items="${studentGradeList}" var="studentGrade">
											<option  <c:if test="${selectedStudClassId == studentGrade.classGrade.grade.description and (studentGrade.year).toString().substring(0,4) == Year}">
															selected="selected"
												</c:if>
												value="<c:out value="${studentGrade.studentClassInfoId}" />">
												<c:out value="${(studentGrade.year).toString().substring(0,4)} - ${studentGrade.classGrade.description}" />
											</option>
										</c:forEach>


						</select>

					</div>
				</div>
				<div class="clearfix"></div>
				<c:if test="${showStudentData != null}">
				<div class="section_box">
					<div class="section_box_header">

						<h2><spring:message code="STUDENT.ACADEMIC.SUBJECTMARKS"/></h2>
						<div class="noteMessage"><spring:message code="STUDENT.EXAM.DETAIL.NOTE"/></div>
					</div>
<div></div>
              <div class ="float_right">
							<a href="javascript:void(0);" onclick="showExamMark();">
							<img src="resources/images/detail_view.jpeg" align="bottom" title="<spring:message code="REF.UI.ACADEMIC.EXAM.MARKS.VIEW"/>">
							<spring:message code="REF.UI.ACADEMIC.EXAM.MARKS.VIEW"/></a>
						</div><div></div><br>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th width="auto" class="center"><spring:message code="STUDENT.ACADEMIC.SUBJECT"/></th>
								<%
									int count = 0;
								%>
								<c:choose>
									<c:when test="${not empty TermList}">
										<c:forEach items="${TermList}" var="termList"
											varStatus="status">
											<th width="auto" class="center">${termList.description}</th>
											<%
												count++;
											%>
										</c:forEach>
									</c:when>
								</c:choose>
							</tr>
							<c:choose>
								<c:when test="${not empty LastList}">
									<c:forEach items="${LastList}" var="mainList"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		    	</c:choose>>
											<td>
													<a href="javascript:void(0);" title="<spring:message code="STUDENT.ACADEMIC.VIEW.SUBTERM.MARKS"/>"
														onclick="showSubTerm('<c:out value="${mainList.get('Subject')}" />');">${mainList.get("Subject")}</a>
													<a href="javascript:void(0);"
														onclick="showAssignment('<c:out value="${mainList.get('Subject')}" />');">
														<img src="resources/images/detail_view.jpeg" align="absbottom" title="View Assignment Marks Details"></a>


												<input type="hidden" value="${mainList.get('Subject')}"	name="subject">
												</td>
											<c:forEach items="${TermList}" var="termList"
												varStatus="status">
												<c:set var="isEqual" value="false" />
												<c:forEach items="${mainList}" var="keyVal"
													varStatus="status">
													<c:choose>
														<c:when
															test="${termList.description eq keyVal.key and not fn:containsIgnoreCase(keyVal, 'AB')}">
															<td title="<spring:message code="STUDENT.ACADEMIC.MARKS_TOOL_TIP"/>"
																<c:choose >
																<c:when test="${termList.description eq 'Term 1' and mainList.get('flag1') <= redUpper}"> class="right red"</c:when>
		              											<c:when test="${termList.description eq 'Term 1' and mainList.get('flag1') >= greenLower}"> class="right green"</c:when>
		              											<c:when test="${termList.description eq 'Term 1' and mainList.get('flag1') <= yellowUpper and termList.description eq 'Term 1' and mainList.get('flag1')>= yellowLower}"> class="right amber"</c:when>
																<c:when test="${termList.description eq 'Term 2' and mainList.get('flag2') <= redUpper}"> class="right red" </c:when>
		              											<c:when test="${termList.description eq 'Term 2' and mainList.get('flag2') >= greenLower}"> class="right green"</c:when>
		              											<c:when test="${termList.description eq 'Term 2' and mainList.get('flag2') <= yellowUpper and termList.description eq 'Term 2' and mainList.get('flag2')>= yellowLower}"> class="right amber"</c:when>
																<c:when test="${termList.description eq 'Term 3' and mainList.get('flag3') <= redUpper}"> class="right red" </c:when>
		              											<c:when test="${termList.description eq 'Term 3' and mainList.get('flag3') >= greenLower}"> class="right green"</c:when>
		              											<c:when test="${termList.description eq 'Term 3' and mainList.get('flag3') <= yellowUpper and termList.description eq 'Term 3' and mainList.get('flag3')>= yellowLower}"> class="right amber"</c:when>

		             											 </c:choose>>


		             											 ${mainList.get(termList.description)} </td>
															<c:set var="isEqual" value="true" />
														</c:when>
														<c:when
															test="${termList.description eq keyVal.key and fn:containsIgnoreCase(keyVal, 'AB')}">
															<td nowrap="nowrap" class="right grey">${mainList.get(termList.description)}</td>
															<c:set var="isEqual" value="true" />
														</c:when>
														
													</c:choose>
												</c:forEach>
												<c:if test="${isEqual == 'false'}">
													<td></td>
												</c:if>
											</c:forEach>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
										<%
											for (int i = 0; i < count; i++) {
										%>
										<td></td>
										<%
											}
										%>
									</tr>
								</c:otherwise>
							</c:choose>
							<c:if test="${not empty LastList}">

								<c:if test="${not empty TotMarkList}">
									<tr>
										<td><b><spring:message code="STUDENT.ACADEMIC.TOTALTERMMARKS"/></b>
										</td>
										<c:forEach items="${TotMarkList}" var="totalMarks"
											varStatus="status">

											
											<c:forEach items="${TermList}" var="termList"
												varStatus="status">
												<c:set var="isEqual" value="false" />
												<c:forEach items="${totalMarks}" var="keyVal"
													varStatus="status">
													<c:choose>
														<c:when test="${termList.description eq keyVal.key && totalMarks.get(termList.description) ge 0}">
															<td class="right"><b>${totalMarks.get(termList.description)}</b>
															</td>
															<c:set var="isMarksNotEnterd" value="true" />
														</c:when>
														<c:when
															test="${termList.description eq keyVal.key && totalMarks.get(termList.description) lt 0}">
															<c:set var="isMarksNotEnterd" value="flase" />
															<c:set var="isEqual" value="true" />
															<td class="right"><b>N/A</b></td>
															<c:set var="isEqual" value="true" />
														</c:when>
													</c:choose>
												</c:forEach>

											</c:forEach>

										</c:forEach>
									</tr>
								</c:if>
								<c:if test="${not empty AvgMarkList}">
									<tr>
										<td><b><spring:message code="STUDENT.ACADEMIC.AVERAGETERMMARKS"/></b>
										</td>
										<c:forEach items="${AvgMarkList}" var="averageMarks"
											varStatus="status">


											<c:forEach items="${TermList}" var="termList"
												varStatus="status">
												<c:set var="isEqual" value="false" />
												<c:forEach items="${averageMarks}" var="keyVal"
													varStatus="status">
													<c:choose>
														<c:when test="${termList.description eq keyVal.key && averageMarks.get(termList.description) ne -1}">
															<td class="right"><b>${averageMarks.get(termList.description)}</b>
															</td>
															<c:set var="isEqual" value="true" />
														</c:when>
														<c:when test="${termList.description eq keyVal.key && averageMarks.get(termList.description) eq -1}">
															<td class="right"><b></b>
															</td>
															<c:set var="isEqual" value="true" />
														</c:when>
													</c:choose>
												</c:forEach>

											</c:forEach>
										</c:forEach>
									</tr>
								</c:if>
								
								<tr>
									<c:set var="isEqual" value="false" />
										<td><b><spring:message code="STUDENT.ACADEMIC.POSITION"/></b>
										</td>
									<c:if test="${not empty PositionList}">
											<c:forEach items="${PositionList}" var="positionList"
												varStatus="status">
												<c:choose>
														<c:when test="${isMarksNotEnterd}">
															<td class="right"><b>${positionList}</b>
															</td>
														</c:when>
														<c:when test="${not isMarksNotEnterd}">
															<td class="right">${positionList}<b></b>
															</td>
														</c:when>
												</c:choose>
												<c:set var="isEqual" value="true" />
											</c:forEach>
									</c:if>
									<c:if test="${isEqual == 'false'}">
									<c:forEach items="${TermList}" var="termList"
													varStatus="status">
											<td class="right"><spring:message code="STUDENT.ACADEMIC.NULL.POSITION"/></td>
									</c:forEach>
									</c:if>
								</tr>
							</c:if>
							
						</table>
					</div>
					<div class="noteMessage"><spring:message code="STUDENT.ACADEMIC.MARKS_TOOL_TIP.DESCRIPTION"/></div>
					<div class="clearfix"></div>
				</div>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.ACADEMIC.PREFECTDETAILS"/></h2>
					</div>
					<div>
						<label class="required_sign"> <c:if
								test="${message_pre != null}">${message_pre}</c:if> </label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.ACADEMIC.PREFECT"/></th>
								<th width="42" class="right">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

								<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages();addAction(this);" width="18" height="20"
											title="<spring:message code="STUDENT.ACADEMIC.ADDPREFECTDETAILS"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
											<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize></th>
							</tr>
							<c:choose>
								<c:when test="${not empty Prefects}">
									<c:forEach items="${Prefects}" var="prefectList"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		    	</c:choose>>
											<td>${prefectList.prefectType.description}</td>
											<td nowrap="nowrap" class="right">

												<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

												<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="STUDENT.ACADEMIC.EDITPREFECTDETAILS"/>"
														onClick="clearMessages();editPrefectImgAction(this,'<c:out value="${prefectList.prefectType.prefectTypeId}" />','<c:out value="${prefectList.studentPrefectId}" />','<c:out value="${PrefectTypeList}" />');"
														width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>

												<%-- Checks the logged role has the privileges to delete student academic data. --%>

													<sec:authorize access="hasAnyRole('Delete Student Academic Data')">
													<img src="resources/images/ico_delete.gif"
														onClick="clearMessages();deletePrefectImgAction(this,'<c:out value="${prefectList.studentPrefectId}"></c:out>');"
														title="<spring:message code="STUDENT.ACADEMIC.DELETE"/>" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
										<td nowrap="nowrap" class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="section_full_inside" style="display: none;" id="section_full_inside_prefect">
						<h3><spring:message code="STUDENT.ACADEMIC.ADDPREFECTDETAILS"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><spring:message code="STUDENT.ACADEMIC.ADDPREFECTDETAILS.PREFECT"/></label>
									</div>
									<select name="selectedPrefectType" id="selectedPrefectType">
										<option value="0"><spring:message code="application.drop.down" /></option>

										<c:choose>
											<c:when test="${not empty PrefectTypeList}">
												<c:forEach items="${PrefectTypeList}" var="pList"
													varStatus="status">
													<option value="${pList.prefectTypeId}">${pList.description}</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value=""></option>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

									<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
											onClick="savePrefectAction(this);" class="button">
										<input type="button" class="button"
											onClick="clearMessages();setAddEditPane(this,'Cancel')" value='<spring:message code="REF.UI.CANCEL"/>'>
									</sec:authorize>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.ACADEMIC.SCHOLARSHIPDETAILS"/></h2>
					</div>
					<div>
						<label class="required_sign"> <c:if
								test="${message_schol ne null}">${message_schol}</c:if> </label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.ACADEMIC.SCHOLARSHIP"/></th>
								<th width="42" class="right">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

								<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages();addAction(this);" width="18" height="20"
											title="<spring:message code="STUDENT.ACADEMIC.ADDSCHOLARSHIPDETAILS"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
											<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize></th>
							</tr>
							<c:choose>
								<c:when test="${not empty Scholarships}">
									<c:forEach items="${Scholarships}" var="scholarship"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		    	</c:choose>>
											<td>${scholarship.scholarship.name}</td>
											<td nowrap="nowrap" class="right">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

													<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="STUDENT.ACADEMIC.EDITSCHOLARSHIPDETAILS"/>"
														onClick="clearMessages();editScholarshipImgAction(this,'<c:out value="${scholarship.scholarship.scholarshipId}" />','<c:out value="${scholarship.studentScholarshipId}" />');"
														width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>

									<%-- Checks the logged role has the privileges to delete student academic data. --%>

													<sec:authorize access="hasAnyRole('Delete Student Academic Data')">
													<img src="resources/images/ico_delete.gif"
														onClick="clearMessages();deleteScholarshipImgAction(this,'<c:out value="${scholarship.studentScholarshipId}"></c:out>');"
														title="<spring:message code="STUDENT.ACADEMIC.DELETE"/>" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
										<td nowrap="nowrap" class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="section_full_inside" style="display: none;" id="section_full_inside_scholar">
						<h3><spring:message code="STUDENT.ACADEMIC.ADDSCHOLARSHIPDETAILS"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><spring:message code="STUDENT.ACADEMIC.ADDSCHOLARSHIPDETAILS.SCHOLARSHIP"/></label>
									</div>
									<select name="selectedScholarshipType"
										id="selectedScholarshipType">
										<option value="0"><spring:message code="application.drop.down" /></option>
										<c:choose>
											<c:when test="${not empty ScholarshipList}">
												<c:forEach items="${ScholarshipList}" var="sList"
													varStatus="status">
													<option value="${sList.scholarshipId}">${sList.name}</option>
												</c:forEach>
											</c:when>
										
										</c:choose>
									</select>
								</div>
								<div class="buttion_bar_type1" style="margin-top: 15px;">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

									<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
											onClick="saveScholarshipAction(this);" class="button">
										<input type="button" class="button"
											onClick="clearMessages();setAddEditPane(this,'Cancel')" value='<spring:message code="REF.UI.CANCEL"/>'>
									</sec:authorize>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.ACADEMIC.ACADEMICACHIEVEMENTS"/></h2>
					</div>
					<div >
						<label class="required_sign" > <c:if
								test="${message_ach ne null}">${message_ach}</c:if> </label>
					</div>
					<div class="column_single" >
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.ACADEMIC.ACADEMICACHIEVEMENT"/></th>
								<th width="42" class="right">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

									<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages();addAction(this);" width="18" height="20"
											title="<spring:message code="STUDENT.ACADEMIC.ADDACADEMICACHIEVEMENTS"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
											<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize></th>
							</tr>
							<c:choose>
								<c:when test="${not empty Achievement}">
									<c:forEach items="${Achievement}" var="achievement"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		    	</c:choose>>
											<td style="text-align:justify !important;width:100%;" >${achievement.description}</td>
											<td nowrap="nowrap" class="right">

											<%-- Checks the logged role has the privileges to add/edit student academic data. --%>
												<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="STUDENT.ACADEMIC.EDITACADEMICACHIEVEMENTS" />"
														onClick="clearMessages();editAchievementImgAction(this,'<c:out value="${achievement.achievementId}" />','<c:out value="${fn:escapeXml(achievement.description)}"/>');"
														width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>


											<%-- Checks the logged role has the privileges to delete student academic data. --%>
													<sec:authorize access="hasAnyRole('Delete Student Academic Data')">
													<img src="resources/images/ico_delete.gif"
														onClick="clearMessages();deleteAchievementImgAction(this,'<c:out value="${achievement.achievementId}" />');"
														title="<spring:message code="STUDENT.ACADEMIC.DELETE"/>" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
										<td nowrap="nowrap" class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="section_full_inside" style="display: none;" id="section_full_inside_achievement">
						<h3><spring:message code="STUDENT.ACADEMIC.ADDACADEMICACHIEVEMENTS"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span>
										<label><spring:message code="STUDENT.ACADEMIC.ADDACADEMICACHIEVEMENTS.ACADEMICACHIEVEMENT"/></label>
									</div>
									<textarea id="achievementTextArea" name="achievementTextArea"
										cols="30" rows="2" onkeydown="limitText(this,400);"
												onkeyup="limitText(this,400);" onkeypress="return disableEnterKey(event);"
												onpaste="limitText(this,400);" maxlength="400"></textarea>
								</div>
								<div class="buttion_bar_type1" style="margin-top: 40px;">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

									<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
											onClick="saveAchievementAction(this);" class="button">
										<input type="button" class="button"
											onClick="clearMessages();setAddEditPane(this,'Cancel')" value='<spring:message code="REF.UI.CANCEL"/>'>
									</sec:authorize>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.ACADEMIC.SEMINARS"/></h2>
					</div>
					<div>
						<label class="required_sign" id="massageSeminar"></label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.ACADEMIC.SEMINAR"/></th>
								<th width="75%" text ><spring:message code="STUDENT.ACADEMIC.DETAILS"/></th>
								<th width="42" class="left">
								

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

								<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">

										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages();onClickAddSeminar(this);" width="18" height="20"
											title="<spring:message code="STUDENT.ACADEMIC.ADDSEMINARS"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
											<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize>
								</th>
							</tr>
							<c:choose>
								<c:when test="${not empty stuSemList}">
									<c:forEach items="${stuSemList}" var="studentSem"
										varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		    	</c:choose>>
											<td ><c:out value="${studentSem.seminar.description}" />
											</td>
											<td><c:out value="${studentSem.description}" />
											</td>
											<td nowrap="nowrap" class="right">

											<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

											<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="STUDENT.ACADEMIC.EDITSEMINARS"/>"
														onClick="clearMessages();onClickEditSeminar(this,'<c:out value="${studentSem.studentSeminarId}" />','<c:out value="${fn:escapeXml(studentSem.description)}"/>','${studentSem.seminar.seminarId}');"
														width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
											</sec:authorize>

											<%-- Checks the logged role has the privileges to delete student academic data. --%>

											<sec:authorize access="hasAnyRole('Delete Student Academic Data')">
													<img src="resources/images/ico_delete.gif"
														onClick="clearMessages();onClickDelSeminar(this,'<c:out value="${studentSem.studentSeminarId}" />');"
														title="<spring:message code="STUDENT.ACADEMIC.DELETE"/>" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>
														<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="odd">
										<td><spring:message code="APPLICATION.NORECORDSFOUND"/></td>
										<td nowrap="nowrap" class="right"></td>
										<td nowrap="nowrap" class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>

					<div class="section_full_inside" style="display: none;" id="section_full_inside_seminar">
						<h3><spring:message code="STUDENT.ACADEMIC.ADDSEMINARS"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span> <label><spring:message code="STUDENT.ACADEMIC.ADDSEMINARS.SEMINAR"/></label>
									</div>
									<select name="selectSemID" id="selectSemID">
										<option value="0"><spring:message code="application.drop.down" /></option>
										<c:forEach items="${seminarList}" var="seminar">
											<option value="${seminar.seminarId}">
												<c:out value="${seminar.description}" />
											</option>
										</c:forEach>

									</select>
								</div>

								<div class="float_right">
									<div class="lbl_lock">
										<label><spring:message code="STUDENT.ACADEMIC.ADDSEMINARS.DETAIL"/></label>
									</div>
									<input type="hidden" name="StudentSemID" id="StudentSemID">
									<textarea id="seminarDetailArea" name="seminarDetailArea"
										cols="" rows="2" onkeydown="limitText(this,200);"
												onkeyup="limitText(this,200);" onkeypress="return disableEnterKey(event);"
												onpaste="limitText(this,200);" maxlength="200"></textarea>
								</div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">

								<%-- Checks the logged role has the privileges to add/edit student academic data. --%>

									<sec:authorize access="hasAnyRole('Add/Edit Student Academic Data')">
										<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
											onClick="seminarSorEAction(this);" class="button">
										<input type="button" class="button"
											onClick="clearMessages();setAddEditPane(this,'Cancel')" value='<spring:message code="REF.UI.CANCEL"/>'>
									</sec:authorize>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				</c:if>
			</form:form>
		</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.ACADEMIC.ASSIGNTOCLASS"/></h3>
		</c:otherwise>
	</c:choose>
		</div>
	</div>
	<h:footer />
</body>
</html>
