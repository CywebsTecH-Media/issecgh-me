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

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<!DOCTYPE HTML>
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

<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
	$(function() {
		$("#disciplinaryActionDate").datepicker({
			changeYear : true,
			changeMonth : true,
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true,
			maxDate: new Date()
		});
	});
</script>

<!-- END Calender controll CSS and JS -->

<script type="text/javascript">
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.studentDisciplineForm.comment.value != null) {
			document.studentDisciplineForm.comment.value = '';
		}
		if (document.studentDisciplineForm.date.value != null) {
			document.studentDisciplineForm.date.value = '';
		}
		var radioButtonsWL = document.getElementsByName("warningLevelId");
		for ( var x = 0; x < radioButtonsWL.length; x++) {
			radioButtonsWL[x].checked = false;
		}
		var radioButtonsIP = document.getElementsByName("informedtoParent");
		for ( var x = 0; x < radioButtonsIP.length; x++) {
			radioButtonsIP[x].checked = false;
		}
		document.studentDisciplineForm.studentDisciplineId.value = '0';
	}
	function aleartfunction(thisValue)
	{
		alert(thisValue);
	}
	
	function saveStudentDiscipline(thisValue) {
		document.studentDisciplineForm.useSchoolQuotaConfomation.value = "false";
		var ischecked=false;
		 ischecked=document.getElementById('radiooBtnYes').checked
		if(ischecked){
			//document.studentDisciplineForm.useSchoolQuotaConfomation.value = "true";
		if(${useSchoolQuota}){
			var r=false;
			r = confirm("Are you sure you want to send messages from school quota");	
			 if (r==true)
			  {
				 document.studentDisciplineForm.useSchoolQuotaConfomation.value = "true";
				 }else{
					 document.studentDisciplineForm.useSchoolQuotaConfomation.value = "false";
					 }
			
		}}
		// alert( document.studentDisciplineForm.useSchoolQuotaConfomation.value );
		
		
		var newDate=document.studentDisciplineForm.date.value;
		var newComment=document.studentDisciplineForm.comment.value;
		var newStaffType = $('input[name="warningLevelId"]:checked').val();;
		
		if(newDate==oldDate && newComment==oldComment && newStaffType==oldwarningLevelId ){
			//alert("make changes before saving.");
			$(".messageArea").show();
			document.getElementsByClassName("messageArea")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
			oldDate = '';
			oldComment = '';
		}else{
			
				
		setAddEditPane(thisValue, 'Save');
		document.studentDisciplineForm.action = "saveOrUpdateStudentDiscipline.htm";
		document.studentDisciplineForm.submit();
		}
		
	}
	
	var oldComment,oldDate,oldwarningLevelId;
	function updateStudentDiscipline(thisValue, studentDisciplineId, comment,
			warningLevelId, date, informedtoParent,ownerID) {
		oldComment=comment;
		oldDate=date;
		oldwarningLevelId=warningLevelId;
		
		setAddEditPane(thisValue, 'Edit');
		document.studentDisciplineForm.studentDisciplineId.value = studentDisciplineId;
		//Un escape the special characters which already escaped ,in comment.
		document.studentDisciplineForm.comment.value = $("<div/>").html(comment).text();
		document.studentDisciplineForm.userLoginId.value=ownerID;
		var radioButtonsWL = document.getElementsByName("warningLevelId");
		for ( var x = 0; x < radioButtonsWL.length; x++) {
			if (radioButtonsWL[x].value == warningLevelId) {
				radioButtonsWL[x].checked = true;
			}
		}
		document.studentDisciplineForm.date.value = date;

		var radioButtonsIP = document.getElementsByName("informedtoParent");
		for ( var x = 0; x < radioButtonsIP.length; x++) {
			if ((radioButtonsIP[x].value == 'No' && informedtoParent == 'false')
					|| (radioButtonsIP[x].value == 'Yes' && informedtoParent == 'true')) {
				radioButtonsIP[x].checked = true;
			}
		}
	}

	function deleteStudentDiscipline(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.studentDisciplineForm.studentDisciplineId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.studentDisciplineForm.action = "deleteStudentDiscipline.htm";
			document.studentDisciplineForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	}
	
	
	
	function hideErrorSection(){
		
		 $(document).ready(function() {
		
			$("#smserror").hide();
			});
	}
	
</script>

</head>
<body>

	<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="studentDiscipline.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="studentDiscipline.htm" />
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
					<li><spring:message code="STUDENT.DISCIPLINE.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentDisciplineHelp.html"/>','helpWindow',780,550)"><img
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
		<h1><spring:message code="STUDENT.DISCIPLINE.TITLE"/></h1>
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
				<h3><spring:message code="STUDENT.DISCIPLINE.ASSIGNCLASS"/></h3>
			</c:if>
			<form:form action="" method="POST" commandName="studentDiscipline"
				name="studentDisciplineForm">

				<form:hidden path="studentDisciplineId" />
				<!--when editing the record , to hold userLoginid of user which is record created  -->
				<form:hidden path="userLoginId" />
				<input type="hidden" name="useSchoolQuotaConfomation" />
				<div class="clearfix"></div>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STUDENT.DISCIPLINE.DISCIPLINARYACTIONS"/></h2>
					</div>
					<div id="smserror" class="float_left">
						<label  class="required_sign">${SmsMessageSuccess}	</label> 
						<label class="success_sign">${SmsMessageStatus}	</label> 
					</div>
					<div class="clearfix"></div>
					<div class="messageArea">
						<label  class="success_sign"> <c:if
								test="${assginMessage != null}">${assginMessage}</c:if> 
								</label>
						<label  class="required_sign"> <c:if
								test="${message != null}">${message}</c:if> 
								<form:errors
								path="studentDisciplineId" /><br> </label>
						<label class="required_sign">
							<c:if test="${fn:length(warningLevelList) == 0 }"><spring:message code="STUDENT.DISCIPLINE.DISCIPLINARYACTIONS.NO.WARNINGLEVELS"/></c:if>
						</label>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message code="STUDENT.DISCIPLINE.COMMENT"/></th>
								<th width="10%" class="center"><spring:message code="STUDENT.DISCIPLINE.INFORMEDPARENTS"/></th>
								<th width="10%" class="center"><spring:message code="STUDENT.DISCIPLINE.WARNINGLEVEL"/></th>
								<th width="15%"><spring:message code="STUDENT.DISCIPLINE.DATE"/></th>
								<th width="42" class="right">
								<sec:authorize access="hasAnyRole('Add/Edit Student Discipline')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="hideErrorSection();clearMessages();addNew(this)" width="18" height="20"
											title="<spring:message code="STUDENT.DISCIPLINE.ADD"/>"<c:if test="${student.statusId != 1 || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
								</sec:authorize>
								</th>
							</tr>
							<c:set var="seletedDiciplineId" value="${studentDiscipline.studentDisciplineId}" />
							<c:choose>
								<c:when test="${not empty studentDisciplineList}">
									<c:forEach items="${studentDisciplineList}"
										var="studentDiscipline" varStatus="status">
										<tr
											<c:choose>
		            		<c:when test="${displayPanel && seletedDiciplineId == studentDiscipline.studentDisciplineId}">class="highlight"</c:when>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
											<td>${studentDiscipline.comment}</td>
											<td class="center"><c:choose>
													<c:when
														test="${studentDiscipline.informedtoParent eq 'false'}"><spring:message code="STUDENT.DISCIPLINE.NO"/></c:when>
													<c:when
														test="${studentDiscipline.informedtoParent eq 'true'}"><spring:message code="STUDENT.DISCIPLINE.YES"/></c:when>
												</c:choose></td>
												
											<td class="center">
											<c:forEach items="${warningLevelList}" var="warningLevel">
											<c:if test="${warningLevel.warningLevelId eq  studentDiscipline.warningLevelId}">
											<input type="text" disabled="disabled" 
										style="background-color:${warningLevel.color};width:10px;height:10px" title="${warningLevel.description}" >
																</c:if>       
											</c:forEach>
										
										

											
										
											</td>
											<td>${studentDiscipline.date}</td>
											<td nowrap class="right">
											
											<!-- user(with out admin) can only edit/delete records which is add by him  -->
											<c:if test="${(userLogin.userLoginId eq studentDiscipline.userLoginId) or userLogin.userRoleId==1 }">
												<sec:authorize access="hasAnyRole('Add/Edit Student Discipline')">
												
													<img src="resources/images/ico_edit.gif"
														title="<spring:message code="STUDENT.DISCIPLINE.EDIT"/>"
														onClick="  hideErrorSection();clearMessages();updateStudentDiscipline(this,'${studentDiscipline.studentDisciplineId}','<c:out value="${fn:escapeXml(studentDiscipline.comment)}"/>','${studentDiscipline.warningLevelId}','${studentDiscipline.date}','${studentDiscipline.informedtoParent}','${studentDiscipline.userLoginId}' )")
												     	width="18" height="20"
														class="icon" <c:if test="${student.statusId != 1 || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
												<sec:authorize access="hasAnyRole('Delete Student Discipline')">
													<img src="resources/images/ico_delete.gif"
														onClick="hideErrorSection();clearMessages();deleteStudentDiscipline(this,'<c:out value="${studentDiscipline.studentDisciplineId}"/>')"
														title="Delete" width="18" height="20" class="icon" <c:if test="${student.statusId != 1 || EnableAddEditDelete eq null}">style="display:none;"</c:if>>
												</sec:authorize>
											</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td width="830"><h5><spring:message code="APPLICATION.NORECORDSFOUND"/></h5></td>
										<td nowrap class="right"></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>

					<div class="section_full_inside" style="display: ${displayPanel != null && displayPanel?'block':'none'};">
						<h3><spring:message code="${(displayPanel && studentDiscipline.studentDisciplineId != 0)? 'STUDENT.DISCIPLINE.EDIT' : 'STUDENT.DISCIPLINE.ADD'}"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="STUDENT.DISCIPLINE.COMMENT"/>:</label>
									</div>
									<form:input path="comment" maxlength="103" />
								</div>
								<div class="float_right"
									style="margin-right: 250px; *margin-right: 10px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="STUDENT.DISCIPLINE.DATE"/>:</label>
									</div>
									<form:input path="date" id="disciplinaryActionDate"
										cssClass="date_field" readonly="true" />
								</div>
                         
							</div>
                            <div class="row">
                            <div>
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message code="STUDENT.DISCIPLINE.WARNINGLEVEL"/>:</label>
									</div>
									<c:forEach items="${warningLevelList}" var="warningLevel">
										<form:radiobutton path="warningLevelId"
											value="${warningLevel.warningLevelId}" label=""
											cssClass="radio_btn" />
										<input type="text" disabled="disabled" title="${fn:escapeXml(warningLevel.description)}"
										style="background-color:${warningLevel.color};width:10px;height:10px" >
									</c:forEach>

								</div>
                            </div>
							<div class="row">

								<div class="float_left">
									<div class="lbl_lfock">
										<label><spring:message code="STUDENT.DISCIPLINE.INFORMEDPARENTS"/>:</label>
											<form:radiobutton path="informedtoParent" value="Yes" label="" cssClass="radio_btn" id="radiooBtnYes"/>
											<spring:message code="STUDENT.DISCIPLINE.YES"/>
											<form:radiobutton path="informedtoParent" value="No"
											label="" cssClass="radio_btn" /> <spring:message code="STUDENT.DISCIPLINE.NO"/>
									</div>
								</div>							
								
								<div class="buttion_bar_type1" style="margin-top: 15px;">
								<sec:authorize access="hasAnyRole('Add/Edit Student Discipline')">
									<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
										onClick="clearMessages();saveStudentDiscipline(this)" class="button">
										<!-- onClick="saveStudentDiscipline(this,'${messageConfirm}')" class="button"> -->
										<!--  onClick="saveStudentDiscipline(this,'<c:out value="${studentDiscipline.informedtoParent}"/>','${studentDiscipline.studentDisciplineId}')" class="button"> -->
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
					<div class="clearfix"></div>
				</div>
			</form:form>
</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.DISCIPLINE.ASSIGNCLASS" /></h3>
		</c:otherwise>			
</c:choose>			
			
		</div>
	</div>
	<h:footer />
</body>
</html>