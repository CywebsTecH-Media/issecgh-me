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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

function loadMonths(selectedValue, comments, selectedMonth) {

	var url = '<c:url value="/populateYearMonthList.htm" />';

	$.ajax({
		url : url,
		data : ({
			'selectedValue' : selectedValue
		}),
		success : function(response) {

			var c = response;
			var a;

			a = c.split(",");

			var b;
			document.getElementById('selectMonth').innerHTML = '';
			if (comments == null) {
				var dropDownDiv = document.getElementById('selectMonth');

				var selector = document.createElement('select');
				selector.id = "selectMonths";
				selector.name = "selectMonths";
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

					if(b != "")
					{
						option = document.createElement('option');
						option.value = b[1];
						option.appendChild(document.createTextNode(b[0]));
						selector.appendChild(option);

						if(selectedMonth != null)
						{
								if(option.value == selectedMonth)
								{
									option.selected = 'selected';
								}
						}
					}
				}

			}
		},
		error : function(transport) {
			var message = "An error has occurred." ;
			custom_alert(message);

		}
	});
}

function loadClasses(selectedValue, comments, selectedClassId) {

	var url = '<c:url value="/populateGradeClassListByGradeId.htm" />';

	$.ajax({
		url : url,
		data : ({
			'selectedValue' : selectedValue
		}),
		success : function(response) {

			var c = response;
			var a;

			a = c.split(",");

			var b;
			document.getElementById('selectClass').innerHTML = '';
			if (comments == null) {
				var dropDownDiv = document.getElementById('selectClass');

				var selector = document.createElement('select');
				selector.id = "selectClasses";
				selector.name = "selectClasses";
				selector.path = "classDescription";
				dropDownDiv.appendChild(selector);

				var option = document.createElement('option');
				option.value = '0';
				option
						.appendChild(document
								.createTextNode("<spring:message code="application.drop.down" />"));
				selector.appendChild(option);

				for ( var i = 0; i < a.length; i++) {
					b = a[i].split("_");

					if(b != "")
					{
						option = document.createElement('option');
						option.value = b[1];
						option.appendChild(document.createTextNode(b[0]));
						selector.appendChild(option);

						if(option.value == "undefined")
						{
							option.value = '0';
							dropDownDiv.removeChild(selector);
						}

						if(selectedClassId != null)
						{
								if(option.value == selectedClassId)
								{
									option.selected = 'selected';
								}
						}
					}
				}

			}
		},
		error : function(transport) {
			var message = "An error has occurred." ;
			custom_alert(message);

		}
	});
}


function callOnLoadMonthsFun(thisValue, selectedMonth)
{
	loadMonths(thisValue, null, selectedMonth);
}


function callOnLoadClassesFun(thisValue,selectedClassId)
{

	loadClasses(thisValue, null,selectedClassId);
}

function nextOrPrevPublication(nextOrPrev , pageNo){
	document.getElementById('paginate').value = nextOrPrev;
	document.getElementById('itemNo').value = pageNo;
	document.dashboardForm.action = "getAttendancePagination.htm";
	document.dashboardForm.submit();
}

</script>

</head>
<body onload="<c:if test="${selectedYear != null}">callOnLoadMonthsFun('<c:out value="${selectedYear}" />','<c:out value="${selectedMonth}" />');</c:if>
<c:if test="${selectedGradeId != null}">callOnLoadClassesFun('<c:out value="${selectedGradeId}" />','<c:out value="${selectedClassId}" />');</c:if>">

<h:headerNew parentTabId="33" page="attendanceDashboard.htm" />

<div id="page_container">
  <div id="breadcrumb">
    <ul>
       <li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
	   <li><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.TITLE"/></li>
    </ul>
  </div>

  <div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/attendance/attendanceDashboard.htm"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help"/></a>
  </div>

  <div class="clearfix"></div>
  <h1><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.TITLE"/></h1>
  <div id="content_main">
    <form:form action="attendanceDashboard.htm" method="post" commandName="AttendanceDashboardDto" name="dashboardForm">


      <div class="clearfix"></div>
      <div class="section_full_search" id="search_area">

      	<div class="messageArea">
			<label class="required_sign">
					<c:if test="${message != null}">${message}</c:if>
			</label>
			<label class="required_sign">
					<form:errors path="gradeId" />
			</label>
		</div>

        <div class="box_border">
           <p><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.DESCRIPTION"/></p>
          <div class="row">
            <div class="float_left">
              <div class="lbl_lock">
				<span class="required_sign">*</span>
                <label><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.GRADE"/></label>
              </div>
              <form:select id="selectGrade" path="gradeId" onchange="loadClasses(this.value),null">
					<option value="0" id="selectOptionGrade">
						<spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.ALL" />
					</option>
					<c:forEach items="${gradeList}" var="grade">
					<option value="${grade.gradeId}"
						<c:if test='${selectedGradeId != null &&
								    grade.gradeId eq selectedGradeId}'> selected="selected"</c:if>>${grade.description}</option>
				</c:forEach>
			  </form:select>

            </div>
			<div class="float_left">
              <div class="lbl_lock">
              <span class="required_sign">*</span>
                <label><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.CLASS"/></label>
              </div>
              	<div id="selectClass"></div>
            </div>

			<div class="float_left">
              <div class="lbl_lock">
				<span class="required_sign">*</span>
                <label><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.YEAR"/></label>
              </div>
				<form:select id="year" path="year" onchange="loadMonths(this.value),null">
					<c:forEach items="${yearList}" var="year">
					<option value="${year}"
						<c:if test='${selectedYear != null &&
					 year eq selectedYear}'> selected="selected"</c:if>>${year}</option>
				</c:forEach>
			  	</form:select>

            </div>
			<div class="float_left">
              <div class="lbl_lock">
                <label><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.MONTH"/></label>
              </div>
					<div id="selectMonth"></div>


            </div>
			<div class="float_right">
              <div class="buttion_bar_type1">
                <input type="submit" class="button" onClick="" value="Search">
              </div>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>

      <div class="section_box" id="search_results" style="">
        <div class="section_box_header">
          <h2><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.TABLE_HEADER"/></h2>
        </div>

        <c:choose>
            <c:when test="${not empty bestStudentAttendanceList &&  selectedGradeId != 0 }" >

		        <c:forEach items="${bestStudentAttendanceList}" var="bestStudent">
		        <div class="dashboard">
		        	<div class="dashboard-left"><img src="${bestStudent.imagePath}"  /></div>
		        		<div class="dashboard-right">
		        		<h3><c:out value="${bestStudent.studentName}"/></h3>
		        		<p><c:out value="${bestStudent.classDescription}"/> <br>
		        			 <c:out value="${bestStudent.presentDays}"/>/${AttendanceDashboardDto.academicDays}</p>
		        		</div>
		        </div>

		        </c:forEach>

	        	<div class="pagination_container">
					<input type="hidden" name="paginate" id="paginate"/>
					<input type="hidden" name="itemNo" id="itemNo"/>
					&lt;

                <c:choose>
                
                    <c:when test="${minNo == 0 && firstStatus}">
                    <a href="#" class="disabled" title="Previous"><spring:message code="ADMIN.WELCOME.PREVIOUS"/></a> | <spring:message code="ADMIN.WELCOME.ITEMS"/><c:out value="${minNo+1}"/> - <c:out value="${maxNo}"/> |
							 <a href="#" class="disabled" title="Next" onclick="nextOrPrevPublication('next' , '<c:out value= '${minNo}'/>');"><spring:message code="ADMIN.WELCOME.NEXT"/></a>
				    </c:when>
				    
					<c:when test="${minNo == 0}">
                    <a href="#" class="disabled" title="Previous"><spring:message code="ADMIN.WELCOME.PREVIOUS"/></a> | <spring:message code="ADMIN.WELCOME.ITEMS"/><c:out value="${minNo+1}"/> - <c:out value="${maxNo}"/> |
							 <a href="#" class="active" title="Next" onclick="nextOrPrevPublication('next' , '<c:out value= '${minNo}'/>');"><spring:message code="ADMIN.WELCOME.NEXT"/></a>
				    </c:when>

                    <c:otherwise>
                    <c:if test="${!status}">
                      <a href="#" class="active" title="Previous" onclick="nextOrPrevPublication('previous' , '<c:out value= '${minNo}'/>');"><spring:message code="ADMIN.WELCOME.PREVIOUS"/></a> | <spring:message code="ADMIN.WELCOME.ITEMS"/><c:out value="${minNo+1}"/> - <c:out value="${maxNo}"/> |
				      <a href="#" class="active" title="Next" onclick="nextOrPrevPublication('next' , '<c:out value= '${minNo}'/>');"><spring:message code="ADMIN.WELCOME.NEXT"/></a>
                    </c:if>


                    <c:if test="${status}">
                    <a href="#" class="active" title="Previous" onclick="nextOrPrevPublication('previous' , '<c:out value= '${minNo}'/>');"><spring:message code="ADMIN.WELCOME.PREVIOUS"/></a> | <spring:message code="ADMIN.WELCOME.ITEMS"/><c:out value="${minNo+1}"/> - <c:out value="${maxNo}"/> |
							<a href="#" class="disabled" title="Next"><spring:message code="ADMIN.WELCOME.NEXT"/></a>
				    </c:if>
                    </c:otherwise>
               
                </c:choose>
					&gt;
				</div>

		  		<div class="clearfix"></div>

        	</c:when>
	        <c:otherwise>
            			<h5><spring:message code="ATTENDANCE.ATTENDANCEDASHBOARD.NO_RESULTS_FOUND" /></h5>
			</c:otherwise>
		</c:choose>

        </div>
        </form:form>
        <div class="clearfix"></div>
      </div>


  </div>
<h:footer/>
</body>
</html>