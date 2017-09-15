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
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
	
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script language="javascript">

	$(document).ready(function() {
		
		$("#tblFreezed tr").each(function(index) {								
			$("#tblScrool tr").eq(index).height($("#tblFreezed tr").eq(index).innerHeight());
		});
		
		// When load attendance details, toggle button to Uncheck All,
		// if all checkboxes are already checked 
		if ($('input[name="studentIdList"]:checked').length == $('input[name="studentIdList"]').length) {
			$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
		}
		
		// Toggle Check All / Uncheck All behaviour
		$('#toggle_check_all').click(function() {
			if ($('#toggle_check_all').attr('value') == '<spring:message code="REF.UI.CHECK.ALL" />') {
				$('input[name="studentIdList"]').attr('checked', 'checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('input[name="studentIdList"]').removeAttr('checked');
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
		// Each click on check box, check all check boxes are checked or not
		// for change the Check All button behaviour if needed 
		$('input[name="studentIdList"]').click(function() {
			if ($('input[name="studentIdList"]:checked').length == $('input[name="studentIdList"]').length) {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.UNCHECK.ALL" />');
			} else {
				$('#toggle_check_all').attr('value', '<spring:message code="REF.UI.CHECK.ALL" />');
			}
		});
		
	});
		
	function cancelSearch(thisValue) {

		document.form.action = "changeDateList.htm";
		if (thisValue.value != "") {
			document.form.submit();
		}
	}
	function reloadPage(thisValue) {

		document.form.action = "DailyAttendanceReload.htm";
		if (thisValue.value != "") {
			document.form.submit();
		}
	}
	

	
	function selectCheckBox(studentID, studentName)
	{

	  var numberOfStudent = studentID.length;	  
	  var count=0;
	  var presentStudents = "";
	  var absentStudents = "";
	  var countPresentStudents = 0;
	  var confirmAttendance = document.getElementById('confirmAttendance');
	  var onlyOnestudentinClassisabsent = -1;
	  var onlyOnestudentinClassispresent = -1;
					
	  for(count=0;count<numberOfStudent;count++)
	  {		  
	   if(studentID[count].checked){
	    	
		presentStudents = presentStudents + studentName[count].value +"<br>";
		countPresentStudents = countPresentStudents + 1;
	    }
	  
	    else {
	    		absentStudents =  absentStudents + studentName[count].value + "<br>";	    		    	  	
	    }
	  }		
	  
	  onlyOnestudentinClassisabsent =  absentStudents.localeCompare("");
	  onlyOnestudentinClassispresent = presentStudents.localeCompare("");
	  
if( !(document.form.confirmAttendance.disabled)){	  
   if(document.form.confirmAttendance.checked){		  	  
		  confirmAttendance = true;		  
	if(!(countPresentStudents==numberOfStudent)){			 
			 if(onlyOnestudentinClassisabsent == 0 && onlyOnestudentinClassispresent == 0 ){				 
				 if(!studentID.checked){
					 var message = "Absent Students Are, <br>"+ studentName.value +" Do you want to sent attendance notification to their parents?" ;
						
						var okfunction = function(){
							document.getElementById('confirmAlert').value = 1;
							document.form.action='saveorupdateStudentAttendance.htm';
							document.form.submit();
						};

						var cancelfunction = function(){
							document.getElementById('confirmAlert').value = 0;
							document.form.action='saveorupdateStudentAttendance.htm';
							document.form.submit();
						};

						confirm_function(message , okfunction, cancelfunction );	 
				  }
				  else {	
					  var message = "All Are Present for the day" ;
						
						var okfunction = function(){
							document.getElementById('confirmAlert').value = 3;
							document.form.action='saveorupdateStudentAttendance.htm';
							document.form.submit();
						};

						var cancelfunction = function(){
							document.getElementById('confirmAlert').value = 0;
							document.form.action='saveorupdateStudentAttendance.htm';
							document.form.submit();
						};

						confirm_function(message , okfunction, cancelfunction );
				  }					 				 
			 }			 
			 else {
				 var message = "Absent Students Are, <br>"+ absentStudents +" Do you want to sent attendance notification to their parents?" ;
					
				var okfunction = function(){
					document.getElementById('confirmAlert').value = 1;
					document.form.action='saveorupdateStudentAttendance.htm';
					document.form.submit();
				};

				var cancelfunction = function(){
					document.getElementById('confirmAlert').value = 0;
					document.form.action='saveorupdateStudentAttendance.htm';
					document.form.submit();
				};

				confirm_function(message , okfunction, cancelfunction );	  			  
 			}
		
	  }
	else{	
		
		var message = "All Are Present for the day" ;
		
		var okfunction = function(){
			document.getElementById('confirmAlert').value = 3;
			document.form.action='saveorupdateStudentAttendance.htm';
			document.form.submit();
		};

		var cancelfunction = function(){
			document.getElementById('confirmAlert').value = 0;
			document.form.action='saveorupdateStudentAttendance.htm';
			document.form.submit();
		};

		confirm_function(message , okfunction, cancelfunction );
		  }
	 }else{
		 document.form.action='saveorupdateStudentAttendance.htm';
		 document.form.submit(); 
	 }
  }else{
	   document.form.action='saveorupdateStudentAttendance.htm';
		document.form.submit(); 
   }
}

</script>


</head>

<body>
	<h:headerNew parentTabId="33" page="DailyAttendance.htm" />
	


	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
			<sec:authorize access="hasRole('View Student Attendance Page')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="ATTENDANCE.DAILYATTENDANCE.TITLE"/></li>
				</ul>
			</sec:authorize>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/attendance/manualAttendanceHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help"/></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="ATTENDANCE.DAILYATTENDANCE.TITLE"/></h1>
		<div>
			<c:if test="${message != null}">
				<label class="missing_required_error">${message}</label>
			</c:if>
		</div>
		<div>
			<c:if test="${sentMessage != null}">
				<label class="success_sign_attendance">${sentMessage}</label>
			</c:if>
			<c:if test="${notSentMessage != null}">
				<label class="missing_required_error">${notSentMessage}</label>
			</c:if>
		</div>

		<div id="content_main">
			<form action="" method="post" name="form"><c:set
	var="gradeclassdescription" value="" />
	<c:set
	var="dateDescription" value="" />
	
				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border">
						<p><spring:message code="ATTENDANCE.DAILYATTENDANCE.DESCRIPTION"/></p>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<div><span class="required_sign">*</span><label><spring:message code="ATTENDANCE.DAILYATTENDANCE.CLASS"/></label></div>
								</div>
								<select name="select" id="select" <c:if test="${(not empty studentList)}"> onchange="reloadPage(this)"</c:if>>
									<option value ="0"><spring:message code="application.drop.down"/></option>
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
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="ATTENDANCE.DATE"/></label>
							</div>
							
							<select name="date" id="date" <c:if test="${(not empty studentList)}"> onchange="cancelSearch(this)"</c:if>>
									<c:forEach items="${dateList}" var="date" varStatus="status">								
										<option label="${date}" value="${date}" <c:if test="${currentDate == date}">selected="selected" <c:set var="dateDescription"
												value="${date}" /></c:if>>${date}</option>
									</c:forEach>
							</select>
							
							</div>
							<div class="float_right">
								<div class="buttion_bar_type1">
								<sec:authorize access="hasRole('View Student Attendance')">
									<input type="button" value="<spring:message code="REF.UI.SEARCH"/>"
										onClick="document.form.action='searchStudentAttendance.htm'; document.form.submit();document.getElementById('search_results').style.display=''; document.getElementById('btn_row').style.display=''"
										class="button">
								</sec:authorize>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<c:if test="${(not empty studentList)}">
				<script language="javascript">
					$(document)
							.ready(
									function() {
										$("#tblFreezed tr")
												.each(
														function(index) {
															$("#tblScrool tr")
																	.eq(index)
																	.height(
																			$(
																					"#tblFreezed tr")
																					.eq(
																							index)
																					.innerHeight());
														});
									});
				</script>
				<div class="section_box" id="search_results">
					<div class="section_box_header">
						<h2>${gradeclassdescription} <spring:message code="ATTENDANCE.ATTENDANCE"/></h2>
					</div>
					<div class="column_single">
					<div style="width: 670px;height:250px;overflow:auto;">
						<table id="tblFreezed" class="basic_grid basic_grid_freezed"
							style="width: 650px;" border="0" cellspacing="0">
							<tr>
								<th style="height: 34px; * height: 32px;"><spring:message code="ATTENDANCE.STUDENT.ADMISSION"/></th>
								<th style="height: 34px; * height: 32px;"><spring:message code="ATTENDANCE.STUDENT.NAME"/></th>
								<th style="height: 34px; * height: 32px; text-align: center;">${dateDescription}</th>
							</tr>
							<c:forEach var="studentclass" items="${studentList}"
								varStatus="status">
								<input type="hidden" name="studentnameList"  value="${studentclass.student.nameWtInitials}"/>
													            	
					            	<c:if test="${studentclass.student.statusId == 1}">
					            	
					            	<tr
									<c:choose>
					            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
					            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
					            	</c:choose>>
					            	
					            	<td class="left">${studentclass.student.admissionNo}</td>
									<td class="left">${studentclass.student.nameWtInitials}</td>
									<c:set var="checkval" value="false" />
									<c:if test="${not empty attendanceList}">
										<c:forEach var="attendanceList" items="${attendanceList}">
											<c:if test="${attendanceList.studentId eq studentclass.student.studentId}">
												<c:set var="checkval" value="true" />
												
											</c:if>
										</c:forEach>
									</c:if>
						
									
									<td style="text-align: center;">
									<input name="studentIdList" type="checkbox" value="${studentclass.student.studentId}" 
										<c:if test="${checkval eq true}">checked="checked"</c:if>
										<c:if test="${confirmval eq true}">disabled="disabled"</c:if>></td>		
									</tr>															
									</c:if>
									
									
									<c:if test="${studentclass.student.statusId != 1}">
									
											<c:forEach var="attendanceList" items="${attendanceList}">
											<c:if test="${attendanceList.studentId eq studentclass.student.studentId}">
											
											<tr
									<c:choose>
					            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
					            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
					            	</c:choose>>
											
												<td class="left">${studentclass.student.admissionNo}</td>
												<td class="left">${studentclass.student.nameWtInitials}</td>
											<c:set var="checkval" value="true" />
									
											<td style="text-align: center;">
												<input name="studentIdList" type="checkbox" value="${studentclass.student.studentId}" 
													<c:if test="${checkval eq true}">checked="checked"</c:if>
													<c:if test="${confirmval eq true}">disabled="disabled"</c:if>></td>	
									
										</tr>
									</c:if>
									</c:forEach>
									
									
									</c:if>
								
								
							</c:forEach>

							<tfoot style="background: #C0C0C0;">
								<tr>
									<td class="left" style="font-weight:bold;" ><spring:message code="ATTENDANCE.TOTAL"/></td>
									<td></td>
									<td style="text-align: center; font-weight:bold;">${total}</td>
								</tr>
							</tfoot>
							
						</table>
					</div>
					
						<!--
					================================================================================
 							SMS Application Related Code
					================================================================================

						-->

						
					   <div class="clearfix"></div><br>
          			   <div class="float_right" style="margin-right:285px;"> 
            		   <input name="confirmAttendance" type="checkbox" value="3" 
            		   <c:if test="${confirmval eq true}">disabled="disabled", checked="checked"</c:if> >
     
            		    <span>Confirm Attendance</span>
            		    <input type="hidden" name="confirmAlert" id="confirmAlert" value="2"/>
            		    
            	      </div>
           
		  </div>
		  <div class="clearfix"></div>
        </div>
					<div class="clearfix"></div>
				</div>
						<!--
					================================================================================
 							SMS Application Related Code End
					================================================================================

						-->
				<div id="btn_row" class="button_row" >
				<sec:authorize access="hasRole('Save Student Attendance')">
					<div class="buttion_bar_type2">
						<input type="hidden" name="date" value="${date}">
						<input type="hidden" name="select" value="${gradeclass.classGradeId}">
						<input type="button" value="<spring:message code='REF.UI.SAVE'/>" class="button" onclick="selectCheckBox(document.form.studentIdList,document.form.studentnameList);" <c:if test="${confirmval eq true}">disabled="disabled"</c:if>> 
						<input type="button" value="<spring:message code='REF.UI.CHECK.ALL'/>" class="button" id="toggle_check_all" <c:if test="${confirmval eq true}">disabled="disabled"</c:if>>
						<input type="button" value="<spring:message code="REF.UI.CANCEL"/>" class="button" onclick="document.location.href='DailyAttendance.htm'">
					</div>
				</sec:authorize>
					<div class="clearfix"></div>
				</div>
			</c:if> </form>
		</div>
	</div>
	<h:footer />
</body>
</html>