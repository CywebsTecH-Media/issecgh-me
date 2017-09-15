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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>	

<script language=JavaScript>

function check_length(command)
	{
		maxLen = 400;
		if (command.clubAchievement.value.length >= maxLen) {

			//var msg = "You have reached your maximum limit of characters allowed. Remove some characters.";
			//alert(msg);

			command.clubAchievement.value = command.clubAchievement.value.substring(0, maxLen);
		 }
		else{
			command.text_num.value = maxLen - command.clubAchievement.value.length;}
	}
	
function limit_length(command)
{
	maxLen = 400;
	if (command.achievement.value.length > maxLen) {

		//var msg = "You have reached your maximum limit of characters allowed. Remove some characters.";
		//alert(msg);

		command.achievement.value = command.achievement.value.substring(0, maxLen);
	 }
	else{
		command.text_num.value = maxLen - command.achievement.value.length;}
}

</script>


<script type="text/javascript">
	function populate(thisValue) {

		document.coCurricularForm.action = "populateData.htm";
		if (thisValue.value != "") {
			document.coCurricularForm.submit();
		}
	}

	function saveStudentClubSociety(thisValue) {
		clearMessages();
		var clubId = document.getElementById("clubSocietySelect").selectedIndex;
		var positionId = document.getElementById("cPositionSelect").selectedIndex;
		if(clubId * positionId == 0){
			var msgDiv = document.getElementById("csArea");
			var msgLabel = document.createElement("LABEL");
			msgLabel.innerHTML = "<spring:message code="REF.UI.MANDATORY.FIELD.REQUIRED"/>";
			msgLabel.setAttribute('class', 'required_sign');
			msgDiv.appendChild(msgLabel);
		}
		else{
		var elementWraper = $(thisValue).closest('#cs');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		document.coCurricularForm.action = "saveOrUpdateStudentClubSociety.htm";
		document.coCurricularForm.submit();
		}
	}

	function addStudentClubSociety(thisValue) {
		document.forms["coCurricularForm"]["clubSociety"].value = "0";
		document.forms["coCurricularForm"]["cPosition"].value = "0";
		document.coCurricularForm.selectedStudentClubSocietyId.value = "";
		var elementWraper = $(thisValue).closest('#cs');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);

	}

	function updateStudentClubSociety(thisValue, selectedValue, selectedClub,
			selectedPosition) {

		document.coCurricularForm.selectedStudentClubSocietyId.value = selectedValue;
		document.coCurricularForm.clubSociety.value = selectedClub;
		document.coCurricularForm.cPosition.value = selectedPosition;

		var elementWraper = $(thisValue).closest('#cs');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);

	}
	function deleteStudentClubSociety(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('#cs');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.coCurricularForm.selectedStudentClubSocietyId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.coCurricularForm.action = "deleteStudentClubsociety.htm";
			document.coCurricularForm.submit();
		};
		

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}
	function reSet(thisValue) {

		document.coCurricularForm.selectedStudentClubSocietyId.value = "";
		var elementWraper = $(thisValue).closest('#cs');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	}

	function saveStudentSport(thisValue) {
		clearMessages();
		var sportId = document.getElementById("sportSelect").selectedIndex;
		var positionId = document.getElementById("sPositionSelect").selectedIndex;
		var teamId = document.getElementById("sportSubSelect");
		var teamSelected=0;
		if(teamId != null)
			teamSelected = teamId.selectedIndex;
		if(sportId * positionId * teamSelected == 0){
			var msgDiv = document.getElementById("sArea");
			var msgLabel = document.createElement("LABEL");
			msgLabel.innerHTML = "<spring:message code="REF.UI.MANDATORY.FIELD.REQUIRED"/>";
			msgLabel.setAttribute('class', 'required_sign');
			msgDiv.appendChild(msgLabel);
		}
		else{
			var elementWraper = $(thisValue).closest('#spo');
			$(elementWraper).find('.basic_grid tr').removeClass('highlight');
			$(elementWraper).find('.section_full_inside').hide();
			document.coCurricularForm.action = "saveOrUpdateStudentSport.htm";
			document.coCurricularForm.submit();
		}
	}

	function addStudentSport(thisValue) {
		
		
		
		var selectedVal1=1;
		var showval=1;
		var hideval=0;
		
		
		document.forms["coCurricularForm"]["sport"].value = "0";
		//document.forms["coCurricularForm"]["sportSubSelect"].value = "0";
		document.forms["coCurricularForm"]["sPosition"].value = "0";
		document.coCurricularForm.selectedStudentSportId.value = "";
		var elementWraper = $(thisValue).closest('#spo');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
		loadsportCategory(selectedVal1,null,showval,hideval);
	}
	function updateStudentSport(thisValue, selectedValue, selectedSpo,
			selectedTeam, selectedPos, selectedCol) {
	
		loadsportCategory(selectedSpo,null,selectedTeam,1);
		
		
		document.coCurricularForm.selectedStudentSportId.value = selectedValue;
		
		
		document.coCurricularForm.sport.value = selectedSpo;
		//document.coCurricularForm.sportSub.value = selectedTeam;
		document.coCurricularForm.sPosition.value = selectedPos;
		

		if (selectedCol == 1) {
			document.coCurricularForm.colour.checked = "checked";
		} else {
			document.coCurricularForm.colour.checked = "";
		}
		var elementWraper = $(thisValue).closest('#spo');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
	}

	function deleteStudentSport(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('#spo');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.coCurricularForm.selectedStudentSportId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.coCurricularForm.action = "deleteStudentSport.htm";
			document.coCurricularForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}

	function reSet2(thisValue) {

		document.coCurricularForm.selectedStudentSportId.value = "";
		var elementWraper = $(thisValue).closest('#spo');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	}

	function saveAchievement(thisValue, flag) {
		clearMessages();
		var clubId = document.getElementById("activityText").value.length;
		var achievementTextLength = document.getElementById("achievementText").value.length;
		if(clubId * achievementTextLength == 0){
			var mainDiv = document.getElementById("achieve");
			var msgDiv = mainDiv.getElementsByClassName("messageArea")[0];			
			var msgLabel = document.createElement("LABEL");
			msgLabel.innerHTML = "<spring:message code="REF.UI.MANDATORY.FIELD.REQUIRED"/>";
			msgLabel.setAttribute('class', 'required_sign');
			msgDiv.appendChild(msgLabel);
		}
		else{
			var achievementFlag;
			if (flag != "" || flag != null) {
				achievementFlag = flag;
			}
			document.coCurricularForm.flag.value = achievementFlag;
			var elementWraper = $(thisValue).closest('#achieve');
			$(elementWraper).find('.basic_grid tr').removeClass('highlight');
			$(elementWraper).find('.section_full_inside').hide();
			document.coCurricularForm.action = "saveOrUpdateAchievement.htm";
			document.coCurricularForm.submit();
		}
	}
	function addAchievement(thisValue) {
		
		document.forms["coCurricularForm"]["activity"].value = "";
		document.forms["coCurricularForm"]["achievement"].value = "";
		document.coCurricularForm.selectedAchievementId.value = "";
		var elementWraper = $(thisValue).closest('#achieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
		// change edittype elements value
		$('#editType').val('new');
	}
	function updateAchievement(thisValue, selectedValue, activity, description) {

		document.coCurricularForm.selectedAchievementId.value = selectedValue;
		document.coCurricularForm.activity.value = activity;
		document.coCurricularForm.achievement.value = description;

		var elementWraper = $(thisValue).closest('#achieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
		// change edittype elements value
		$('#editType').val('edit');
	}

	function deleteAchievement(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('#achieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.coCurricularForm.selectedAchievementId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.coCurricularForm.action = "deleteAchievement.htm";
			document.coCurricularForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
 }

	function reSetAchiev(thisValue) {

		document.coCurricularForm.selectedAchievementId.value = "";
		var elementWraper = $(thisValue).closest('#achieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	}

	function saveIntAchievement(thisValue, flag) {
		clearMessages();
		var clubId = document.getElementById("studClubSocietySelect").selectedIndex;
		var achievementTextLength = document.getElementById("clubAchievementText").value.length;
		if(clubId * achievementTextLength == 0){
			var mainDiv = document.getElementById("iachieve");
			var msgDiv = mainDiv.getElementsByClassName("messageArea")[0];			
			var msgLabel = document.createElement("LABEL");
			msgLabel.innerHTML = "<spring:message code="REF.UI.MANDATORY.FIELD.REQUIRED"/>";
			msgLabel.setAttribute('class', 'required_sign');
			msgDiv.appendChild(msgLabel);
		}
		else{
			//studClubSocietySelect
			var achievementFlag;
			if (flag != "" || flag != null) {
				achievementFlag = flag;
			}
			document.coCurricularForm.flag.value = achievementFlag;
	
			var elementWraper = $(thisValue).closest('#iachieve');
			$(elementWraper).find('.basic_grid tr').removeClass('highlight');
			$(elementWraper).find('.section_full_inside').hide();
			document.coCurricularForm.action = "saveOrUpdateAchievement.htm";
			document.coCurricularForm.submit();
		}
	}
	function addIntAchievement(thisValue) {

		document.forms["coCurricularForm"]["studClubSociety"].value = "0";
		document.forms["coCurricularForm"]["clubAchievement"].value = "";
		document.coCurricularForm.selectedAchievementId.value = "";
		var elementWraper = $(thisValue).closest('#iachieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
	}

	function updateIntAchievement(thisValue, selectedValue, clubSociety,
			clubAchiev) {

		document.coCurricularForm.selectedAchievementId.value = selectedValue;
		document.coCurricularForm.studClubSociety.value = clubSociety;
		document.coCurricularForm.clubAchievement.value = clubAchiev;

		var elementWraper = $(thisValue).closest('#iachieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').show();
		$(elementWraper).find('.section_full_inside').children('h3').html(
				thisValue.title);
	}

	function deleteIntAchievement(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('#iachieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		document.coCurricularForm.selectedAchievementId.value = selectedValue;
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.coCurricularForm.action = "deleteAchievement.htm";
			document.coCurricularForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}

	function reSetIntAchiev(thisValue) {

		document.coCurricularForm.selectedAchievementId.value = "";
		var elementWraper = $(thisValue).closest('#iachieve');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
	}

	function loadValues(thisValue){
		document.getElementById('clubSocietySelect').value="${not empty clubSociety?clubSociety:'0'}";
		document.getElementById('cPositionSelect').value="${not empty cPosition?cPosition:'0'}";
		document.getElementById('studClubSocietySelect').value="${not empty studClubSociety?studClubSociety:'0'}";
		document.getElementById('sPositionSelect').value="${not empty sPosition?sPosition:'0'}";
		//document.getElementById('sportSubSelect').value="${not empty sportSub?sportSub:'0'}";
		document.getElementById('sportSelect').value="${not empty sport?sport:'0'}";
		document.getElementById('clubAchievementText').value="${not empty clubAchievement?clubAchievement:''}";
		document.getElementById('achievementText').value="${not empty achievement?achievement:''}";
		document.getElementById('activityText').value="${not empty activity?activity:''}";
		document.getElementById('colourCheckBox').checked=${not empty colour?colour:false};
	}


	
	function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}


	
	
	

	
	function loadSport(selectedValue,sport,message) {
	
	
  
	{
	if(selectedValue==null){
	
	
	}
	else{
		
		loadsportCategory(selectedValue,null,0,1);
	
	}
	
	
	}
}

	function loadsportCategory(selectedValue,comments,teamval,hideval){
	
		
		var url = '<c:url value="/populateSportSubList.htm" />';
		
		$.ajax({
		url: url,
		data : ({
			'selectedValue' : selectedValue
			
		}),

		success : function(response) {
				var c = response;
			var a;

			a = c.split(",");
			if(a[0] == ""){
			a.length = 0;
				}

			var b;
			
			document.getElementById('sportTeam').innerHTML = '';
			if (comments == null) {
				
				var dropDownDiv = document.getElementById('sportTeam');
				var selector = document.createElement('select');
				
			
				
				selector.id = "sportSubSelect";
				selector.name = "sportSub";
				selector.path = "description";
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
					
				}
	if(teamval!=0){
				selector.value=teamval;
				}
	if(hideval==0){
		
		$("#sportTeam").hide();
		}
	else{
		$("#sportTeam").show();
		
	}


			}
				
		},
		
		error : function(transport) {
			custom_alert("An error has occurred.");
		}
		
		}).done(function() {
			$( this ).addClass( "done" );
			});
		
	
	}




	
	
	
</script>
<jsp:useBean id="now" class="java.util.Date" />
</head>
<body onload="loadValues();">

	<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="coCurricularActivity.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="coCurricularActivity.htm" />
		</c:otherwise>
	</c:choose>


	<div id="page_container">

		<div id="breadcrumb_area">
			<div id="breadcrumb">
				 <ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<sec:authorize access="hasRole('Student Search')">
						<li><a href="studentSearch.htm"><spring:message code="STUDENT.STUDENTSEARCH"/></a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="STUDENT.COCURRICULARS.TITLE"/></li>
				</ul> 
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/coCurricularHelp.html"/>','helpWindow',780,550)"><img
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
		<div class="clearfix"></div>
		<h1><spring:message code="STUDENT.COCURRICULARS.TITLE"/></h1>
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
				<h3><spring:message code="STUDENT.COCURRICULARS.ASSIGNCLASS"/></h3>
			</c:if>
			<form:form action="" method="POST" name="coCurricularForm">

				<input type="hidden" name="selectedStudentSportId" value="${((not empty selectedStSportObj) && (selectedStSportObj.studentSportId ne 0)) ? selectedStSportObj.studentSportId : ''}" />
				<input type="hidden" name="selectedStudentClubSocietyId" value="${((not empty selectedStClubObj) && (selectedStClubObj.studentClubSocietyId ne 0)) ? selectedStClubObj.studentClubSocietyId : ''}" />
				<input type="hidden" name="selectedAchievementId" value="${((not empty selectedAchivObj) && (selectedAchivObj.achievementId ne 0)) ? selectedAchivObj.achievementId : ''}" />
				<input type="hidden" name="flag" />
				<input type="hidden" name="selectedValue" />

				<div class="section_full">
					<div>
						<c:if test="${assginMessage != null}">
								<div>
									<label class="success_sign">${assginMessage}</label>
								</div>	
							</c:if>
					</div>
					<div class="row">
					
						<label><strong></strong><spring:message code="STUDENT.COCURRICULARS.STUDENTGRADE"/></label> 
						<select
							name="selectedGrade" onchange="populate(this)" id="selectedGrade">
										<option value="0">
											<spring:message code="application.drop.down" />
										</option>
										<c:forEach items="${studentGradeList}" var="studentGrade">
											<option  <c:if test="${selectedStudClassId == studentGrade.classGrade.grade.description and (studentGrade.year).toString().substring(0,4) == selectedYr}">
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
				<div class="section_box" id="cs">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES"/></h2>
					</div>

					<div id="csArea" class="messageArea">
						<c:if test="${!(cmessage == null)}">
							<div class="error">
								&nbsp;<label id="errormsg" class="required_sign"><c:out
										value="${cmessage}" /> </label>
							</div>
						</c:if>
							<c:if test="${!(errorDeleteClubSociety == null)}">
							<div class="error">
								&nbsp;<label id="errormsgdeleteclubsociety" class="required_sign"><c:out
										value="${errorDeleteClubSociety}" /> </label>
							</div>
						</c:if>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.CLUBORSOCIETY"/></th>
								<th width="30%"><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.POSITION"/></th>

								<th width="42" class="right"><sec:authorize
										access="hasAnyRole('Add/Edit Co Curricular Details')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages(); addStudentClubSociety(this);" width="18" height="20"
											title="<spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.ADDCLUBSOCIETY" />"<c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize>
								</th>
							</tr>
							<c:choose>
								<c:when test="${not empty studentClubSocietyList}">
									<c:forEach items="${studentClubSocietyList}"
										var="studentClubSociety" varStatus="status">

										<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
										<c:if test="${(not empty selectedStClubObj) && (selectedStClubObj.studentClubSocietyId eq studentClubSociety.studentClubSocietyId)}">
											<c:set var="cssClass" value="${cssClass} highlight" />
										</c:if>

										<tr class="${cssClass}" >
											<td
												<c:if test="${selectedStClubObj == studentClubSociety }">
															id="flagC"
												</c:if>><c:out
													value="${studentClubSociety.clubSociety.name}"></c:out></td>
											<td><c:out
													value="${studentClubSociety.position.description}"></c:out>
											</td>
											<td nowrap class="right">
												<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
													<img src="resources/images/ico_edit.gif"
														onClick="clearMessages(); updateStudentClubSociety(this,'<c:out value="${studentClubSociety.studentClubSocietyId}" />','<c:out value="${studentClubSociety.clubSociety.clubSocietyId}" />','<c:out value="${studentClubSociety.position.positionId}" />');"
														title="<spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.EditCLUBSOCIETY"/>" width="18" height="20"
														class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
												<sec:authorize access="hasAnyRole('Delete Co Curricular Details')">
													<img src="resources/images/ico_delete.gif"
														onClick="clearMessages(); deleteStudentClubSociety(this,'<c:out value="${studentClubSociety.studentClubSocietyId}" />');"
														title="Delete" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5>
										</td>
										<td nowrap class="right"></td><td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>


						</table>
					</div>
					<div class="section_full_inside" style="display: ${!(cmessage == null) ?'block':'none'}">
						<h3><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.ADDCLUBSOCIETY"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.CLUBORSOCIETY"/>:</label>
									</div>
									<select name="clubSociety" id="clubSocietySelect">
										<option value="0"><spring:message code="application.drop.down"/></option>
										<c:forEach items="${clubSocietyList}" var="clubSociety">
											<option
												value="<c:out value="${clubSociety.clubSocietyId}" />">
												<c:out value="${clubSociety.name}" />
											</option>
										</c:forEach>
									</select>
								</div>
								<div class="float_right">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.POSITION"/>:</label>
									</div>
									<select name="cPosition" id="cPositionSelect">
										<option value="0"><spring:message code="application.drop.down"/></option>
										<c:forEach items="${positionList}" var="position">
											<option
												value="<c:out value="${position.positionId}" />">
												<c:out value="${position.description}" />
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" class="button"
										onClick="saveStudentClubSociety(this)" value='<spring:message code="REF.UI.SAVE"/>'> <input
										type="button" class="button" onClick="clearMessages(); reSet(this);"
										value='<spring:message code="REF.UI.CANCEL"/>'>
								</div>
							</div>
							</sec:authorize>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="section_box" id="iachieve">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESACHIEVEMENTS"/></h2>
					</div>
					<div id="area" class="messageArea">
						<c:if test="${!(amessage == null)&&!(flag == null)&& (flag == 1)}">
							<div class="error">
								&nbsp;<label id="errormsg" class="required_sign"><c:out
										value="${amessage}" /> </label>
							</div>
						</c:if>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.CLUBORSOCIETY"/></th>
								<th width="60%"><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESORACHIEVEMENTS"/></th>
								<th width="42" class="right"><sec:authorize
										access="hasAnyRole('Add/Edit Co Curricular Details')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages(); addIntAchievement(this);" width="18" height="20"
											title="<spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESORACHIEVEMENTS.ADD"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize>
								</th>
							</tr>

							<c:choose>
								<c:when test="${not empty achievementList}">
									<c:forEach items="${achievementList}" var="achievement"
										varStatus="status">
										<c:if test="${achievement.clubSociety != null}">

											<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if test="${(not empty selectedAchivObj) && (selectedAchivObj.achievementId eq achievement.achievementId)}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>

											<tr class="${cssClass}" >
												<td width="830"
													<c:if test="${selectedAchivObj == achievement }">
															id="flagA"
												</c:if>>${achievement.clubSociety.name}</td>
												<td>${achievement.description}</td>
												<td nowrap class="right">
												<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESORACHIEVEMENTS.EDIT"/>"
															onClick="clearMessages(); updateIntAchievement(this,'<c:out value="${achievement.achievementId}" />','<c:out value="${achievement.clubSociety.clubSocietyId}" />','<c:out value="${achievement.description}" />');"
															width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
												<sec:authorize access="hasAnyRole('Delete Co Curricular Details')">
														<img src="resources/images/ico_delete.gif"
															onClick="clearMessages(); deleteIntAchievement(this,'<c:out value="${achievement.achievementId}" />');"
															title="Delete" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5></td>
										<td nowrap class="right"></td><td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>

						</table>
					</div>
					<div class="section_full_inside" style="display: ${!(amessage == null)&&!(flag == null)&& (flag == 1)?'block':'none'}">
						<h3><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESORACHIEVEMENTS.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIES.CLUBORSOCIETY"/>:</label>
									</div>
									<select name="studClubSociety" id="studClubSocietySelect">
										<option value="0"><spring:message code="application.drop.down"/></option>
										<c:forEach items="${studentClubSocietyList}"
											var="sClubSociety">
											<option
												value="<c:out value="${sClubSociety.clubSociety.clubSocietyId}" />">
												<c:out value="${sClubSociety.clubSociety.name}" />
											</option>
										</c:forEach>
									</select>
								</div>

								<div class="float_right">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.CLUBSOCIETIESORACHIEVEMENTS"/>:</label>
									</div>
									<textarea name="clubAchievement" id="clubAchievementText" cols="" rows="2" maxlength="400"
										onKeyPress="check_length(this.form);"></textarea>
								</div>
								<div class="clearfix"></div>
								<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
								<div class="buttion_bar_type1" style="margin-top: 48px;">
									<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
										onClick="saveIntAchievement(this,'1');" class="button"><input
										type="button" class="button" onClick="clearMessages(); reSetIntAchiev(this);"
										value='<spring:message code="REF.UI.CANCEL"/>'>
								</div>
								</sec:authorize>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

				<div class="section_box" id="spo">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.COCURRICULARS.SPORTS.TITLE"/></h2>
					</div>
						<div id="sArea" class="messageArea">
							<c:if test="${!(smessage == null)}">
								<div class="error">
									&nbsp;<label id="errormsg" class="required_sign"><c:out
											value="${smessage}" /> </label>
								</div>
							</c:if>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th><spring:message code="STUDENT.COCURRICULARS.SPORTS.SPORT"/></th>
									<th><spring:message code="STUDENT.COCURRICULARS.SPORTS.TEAM"/></th>
									<th width="15%"><spring:message code="STUDENT.COCURRICULARS.SPORTS.POSITION"/></th>
									<th width="10%" class="center"><spring:message code="STUDENT.COCURRICULARS.SPORTS.COLOUR"/></th>
									<th width="42" class="right"><sec:authorize
											access="hasAnyRole('Add/Edit Co Curricular Details')">
											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="clearMessages(); addStudentSport(this);" width="18" height="20"
												title="<spring:message code="STUDENT.COCURRICULARS.SPORTS.ADDNEW"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
										</sec:authorize></th>
								</tr>
								<c:choose>
									<c:when test="${not empty studentSportList}">
										<c:forEach items="${studentSportList}" var="studSport"
											varStatus="status">

											<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if test="${(not empty selectedStSportObj) && (selectedStSportObj.studentSportId eq studSport.studentSportId)}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>

											<tr class="${cssClass}">
												<td
													<c:if test="${selectedStSportObj == studSport }">
															id="flagS"
												</c:if>>${studSport.sportCategory.sport.description}</td>
												<td>${studSport.sportCategory.sportSubCategory.description}</td>
												<td>${studSport.position.description}</td>
												<td class="center"><c:if
														test="${studSport.sportColour == 1}">
														<img src="resources/images/y.gif" width="20" height="20">
													</c:if>
												
												</td>

												<td nowrap class="right"><sec:authorize
														access="hasAnyRole('Add/Edit Co Curricular Details')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="STUDENT.COCURRICULARS.SPORTS.EDITNEW"/>"
															onClick="clearMessages(); updateStudentSport(this,'<c:out value="${studSport.studentSportId}" />','<c:out value="${studSport.sportCategory.sport.sportId}" />','<c:out value="${studSport.sportCategory.sportSubCategory.sportSubId}" />','<c:out value="${studSport.position.positionId}" />','<c:out value="${studSport.sportColour}" />');"
															width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>
													<sec:authorize access="hasAnyRole('Delete Co Curricular Details')">
														<img src="resources/images/ico_delete.gif"
															onClick="clearMessages(); deleteStudentSport(this,'<c:out value="${studSport.studentSportId}" />');"
															title="Delete" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5>
											</td>
											<td nowrap class="right"></td><td nowrap class="right"></td><td nowrap class="right"></td><td nowrap class="right"></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
						<div class="section_full_inside" style="display: ${!(smessage == null)?'block':'none'}">
							<h3><spring:message code="STUDENT.COCURRICULARS.SPORTS.ADDNEW"/></h3>
							<div class="box_border">
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.SPORTS.SPORT"/>:</label>
										</div>
										
										<select path="sportId" name="sport" id="sportSelect" onchange="loadSport(this.value , '${lsportid}', '${message}')">
											<option value="0"><spring:message code="application.drop.down"/></option>
											<c:forEach items="${sportList}" var="sport">
												<option value="<c:out value="${sport.sportId}" />">
													<c:out value="${sport.description}" />
												</option>
											</c:forEach>
										
										</select>


									</div>
									
									<div class="float_right">
									
										<div class="lbl_lock">
											<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.SPORTS.TEAM"/>:</label>
										</div>

										<div id="sportTeam">  </div>

									</div>
								</div>
								<div class="row">
									<div class="float_left">
										<div class="lbl_lock">
											<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.SPORTS.POSITION"/>:</label>
										</div>
										<select name="sPosition" id="sPositionSelect">
											<option selected="selected" value="0" ><spring:message code="application.drop.down"/></option>
											<c:forEach items="${positionList}" var="position">
												<option value="${position.positionId}">${position.description}</option>
											</c:forEach>
										</select>

									</div>
									<div class="float_right">
										<div class="lbl_lock">
											<label><spring:message code="STUDENT.COCURRICULARS.SPORTS.COLOUR"/>:</label> <input name="colour" id="colourCheckBox" type="checkbox"
												class="checkbox" value="true" onclick="this.value=this.checked"/>
										</div>
									</div>

								</div>
							<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
								<div class="row">

									<div class="buttion_bar_type1">
										<input type="button" class="button"
											onClick="saveStudentSport(this)" value='<spring:message code="REF.UI.SAVE"/>'> <input
											type="button" class="button" onClick="clearMessages(); reSet2(this);"
											value='<spring:message code="REF.UI.CANCEL"/>'>
									</div>
								</div>
							</sec:authorize>
								<div class="clearfix"></div>
							</div>
						</div>
					
					<div class="clearfix"></div>
				</div>
				<div class="section_box" id="achieve">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.COCURRICULARS.EXTERNAL.TITLE"/></h2>
					</div>
					<div id="area" class="messageArea">
						<c:if test="${!(amessage == null)&&!(flag == null)&& (flag == 0)}">
							<div class="error">
								&nbsp;<label id="errormsg" class="required_sign"><c:out
										value="${amessage}" /> </label>
							</div>
						</c:if>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.COCURRICULARS.EXTERNAL.EXTERNALACTIVITY"/></th>
								<th width="60%"><spring:message code="STUDENT.COCURRICULARS.EXTERNAL.ACHIEVEMENT"/></th>
								<th width="42" class="right"><sec:authorize
										access="hasAnyRole('Add/Edit Co Curricular Details')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages(); addAchievement(this);" width="18" height="20"
											title="<spring:message code="STUDENT.COCURRICULARS.EXTERNAL.ADDNEW"/>" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
									</sec:authorize></th>
							</tr>

							<c:choose>
								<c:when test="${not empty achievementList}">
									<c:forEach items="${achievementList}" var="achievement"
										varStatus="status">
										<c:if test="${achievement.clubSociety == null}">

											<c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
											<c:if test="${(not empty selectedAchivObj) && (selectedAchivObj.achievementId eq achievement.achievementId)}">
												<c:set var="cssClass" value="${cssClass} highlight" />
											</c:if>

											<tr class="${cssClass}" >
												<td width="830"
													<c:if test="${selectedAchivObj == achievement }">
															id="flagAA"
												</c:if>>${achievement.activity}</td>
												<td>${achievement.description}</td>
												<td nowrap class="right"><sec:authorize
														access="hasAnyRole('Add/Edit Co Curricular Details')">
														<img src="resources/images/ico_edit.gif"
															title="<spring:message code="STUDENT.COCURRICULARS.EXTERNAL.EDIT"/>"
															onClick="clearMessages(); updateAchievement(this,'<c:out value="${achievement.achievementId}" />','<c:out value="${achievement.activity}" />','<c:out value="${achievement.description}" />');"
															width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
												<sec:authorize access="hasAnyRole('Delete Co Curricular Details')">
														<img src="resources/images/ico_delete.gif"
															onClick="clearMessages(); deleteAchievement(this,'<c:out value="${achievement.achievementId}" />');"
															title="Delete" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if><c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5></td>
										<td nowrap class="right"></td><td nowrap class="right"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div class="section_full_inside" style="display: ${!(amessage == null)&&!(flag == null)&& (flag == 0)?'block':'none'}">
						<h3><spring:message code="${(titleMessage != null)? titleMessage : 'STUDENT.COCURRICULARS.EXTERNAL.ADDNEW'}"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.EXTERNAL.EXTERNALACTIVITY"/>:</label>
									</div>
									<input type="text" name="activity" id="activityText" maxlength="250"
										onkeypress="return disableEnterKey(event)">
								</div>
								<div class="float_right">
									<div class="lbl_lock">
										<label><span class="required_sign">*</span><spring:message code="STUDENT.COCURRICULARS.EXTERNAL.ACHIEVEMENT"/>:</label>
									</div>

										<textarea name="achievement" id="achievementText" cols="" rows="2" maxlength="400" onKeyPress="limit_length(this.form)"></textarea>
								</div>
							</div>
							<sec:authorize access="hasAnyRole('Add/Edit Co Curricular Details')">
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
										onClick="saveAchievement(this,'0');" class="button"><input
										type="button" class="button" onClick="clearMessages(); reSetAchiev(this);"
										value='<spring:message code="REF.UI.CANCEL"/>'>
								</div>
							</div>
							</sec:authorize>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<input type="hidden" name="editType" id="editType" value="new">
				</c:if>
				<%--     </form> --%>
			</form:form>
		</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.COCURRICULARS.ASSIGNCLASS"/></h3>
		</c:otherwise>
	</c:choose>
		</div>
	</div>
	</div>
	<h:footer />
</body>
</html>