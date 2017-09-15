<%--
    < ÀKURA, This application manages the daily attendance of staff of a School>

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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
	
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

</head> 
<body>
	<h:headerNew parentTabId="33" page="selfStaffAttendance.htm" />
	
	<div id="page_container">
  <div id="breadcrumb">
    <ul>
      <li><a href="adminWelcome.htm">Home</a>&nbsp;&gt;&nbsp;</li>
      <li>Manual Staff Attendance</li>
    </ul>
  </div>
  <div class="help_link">
	<a onclick="PopupCenterScroll('resources/html/akura-help/topics/attendance/selfStaffAttendanceHelp.html','helpWindow',780,550)" href="#">
		<img width="20" height="20" align="absmiddle" src="resources/images/ico_help.png">
	Help
	</a>
 </div>
  
  <div class="clearfix"></div>
  <h1>Manual Staff Attendance</h1>
  
        <div id="msgDiv">
			<c:if test="${error_message != null}">
				<label class="missing_required_error">${error_message}</label>
			</c:if>
			<c:if test="${success_message != null}">
			<label class="success_sign">${success_message}</label>
			</c:if>			
		</div>
  
  <div id="content_main">
    <form:form action="" method="post" name="form" commandName="selfStaff">
      <div class="clearfix"></div>
      <div class="section_full_search">
        <div class="box_border">
          <p>Search Employee to add attendance.</p>
          <div class="row">
            <div class="float_left">
              <div class="lbl_lock">
                <span class="required_sign">*</span>
                <label>Registration No:</label>
              </div>
              <form:input id="reg_no" type="text" name="reg_no" path="registrationNo" onKeyPress="if(event.keyCode==13){return false;}"/>
            </div>
  

			<div class="float_right">
			<sec:authorize access="hasRole('View Self Staff Details')">
              <div class="buttion_bar_type1">
                <input type="button" value="Search" onClick="document.form.action='searchSelfStaffDetails.htm'; document.form.submit();document.getElementById('search_results').style.display='none'; document.getElementById('btn_row').style.display='none'" class="button">
              </div>
              </sec:authorize>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
	  <script language="javascript">
	  $(document).ready(function() {
	    $("#tblFreezed tr").each(function(index){
	     $("#tblScrool tr").eq(index).height($("#tblFreezed tr").eq(index).innerHeight());
	    });
	  });
	  </script>
      <div class="section_box" id="search_results" style="display: ${state?'block':'none'};">
        <div class="section_box_header">
          <h2>Manual Staff Attendance</h2>
        </div>
		      
        <div class="column_equal">
        
        <div class="row">
            <div class="frmlabel">
	    
              <label>Employee Name:</label>
              <form:hidden path="staffName" />
            </div>
            <div class="frmvalue">
               <form:label class="pixelAling" path="staffName">${employeeName}</form:label>
            </div>
          </div>
          <div class="row">
            <div class="frmlabel">
	   
              <label>Registration No:</label>
              <form:hidden path="staffId" />
            </div>
            <div class="frmvalue">
                  <form:label class="pixelAling" path="registrationNo">${reg_no}</form:label>
            </div>
          </div>
          <div class="row">
            <div class="frmlabel">

              <label>Date:</label>
            <form:hidden path="date" /> 
            </div>
            <div class="frmvalue">
              <form:label class="pixelAling" path="date">${date}</form:label>
            </div>
          </div>
          <div class="row">
            <div class="frmlabel">

              <label>Time:</label>
              <form:hidden path="time" />
            </div>
            <div class="frmvalue">
                 <form:label class="pixelAling" path="time">${time}</form:label>
            </div>
          </div>
          <div class="row">
            <div class="frmlabel">

              <form:label path="timeIn">Time In:</form:label>
              <form:hidden path="timeIn" />
            </div>
            <div class="pixelAling"><input name="inTime" type="checkbox" onclick="return false" onkeydown="return false" <c:if test="${timeIn eq true}">checked="checked"</c:if> <c:if test="${timeOut eq true}">checked="checked" disabled="disabled"</c:if> > </div>
          </div>
          <div class="row">
            <div class="frmlabel">

              <form:label path="timeOut">Time Out:</form:label>
              <form:hidden path="timeOut" />
            </div>
            <div class="pixelAling"><input name="outTime" type="checkbox" onclick="return false;" onkeydown="return false;" <c:if test="${timeOut eq true}">checked="checked"</c:if> <c:if test="${timeIn eq true}">disabled="disabled"</c:if> ></div>
          </div>
                      <div style="margin-top:30px;" >Note : Please click on save to mark attendance </div>
        </div>
          <div class="column_equal">
          <div class="clearfix"></div>
          
          <div class="row">
             <div class="frmlabel">Profile Image:
	   
            
            </div>
            <div class="frmlabel">
             <form:hidden path="imageUrl" />
             <img src=${ImagePath} width="120px" height="120px" >
            </div>
            <div class="frmvalue"></div>
          </div>
          <div class="row" style="height:30px;">
            <div class="frmlabel"></div>
            <div> </div>
          </div>
          <div class="row">
            <div class="frmlabel"></div>
            <div style="height:20px;">                			
				<c:choose>
  				 <c:when test="${aleave_message != null}">
  				 <label class="aleave">${aleave_message}</label>
  				 </c:when> 
  				 <c:when test="${pleave_message != null}">
  				 <label class="pleave">${pleave_message}</label>
  				 </c:when> 
   				</c:choose>
   				
   				<form:hidden path="aLeaveStatus" />
                <form:hidden path="pLeaveStatus" />   	
   				
			</div>

          </div>
            </div>
             
		<div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
      </div>
      
      <div id="btn_row" class="button_row" style="display:${state?'block':'none'}; ">
      <sec:authorize access="hasRole('Save Self Staff Attendance')">
        <div class="buttion_bar_type2" >
			<input type="button" value="Save" class="button" onclick="document.form.action='markSelfStaffAttendance.htm'; document.form.submit();">
			<input type="button" value="Cancel" class="button" onClick="document.getElementById('search_results').style.display='none'; document.getElementById('btn_row').style.display='none';document.getElementById('reg_no').value='';document.getElementById('msgDiv').style.display='none';" >
        </div>
        </sec:authorize>
        <div class="clearfix"></div>
        
      </div>
    </form:form>
  </div>

<h:footer />
</body>
</html>