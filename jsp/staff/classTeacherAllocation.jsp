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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
    <%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.virtusa.akura.api.dto.UserInfo"%><html>
<head>
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet" type="text/css">

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>


<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script>
	$(function() {
		$( "#dateOfBirth" ).datepicker({
			changeYear: true,
			changeMonth: true,
			yearRange:"c-100:c+2",
			showOn: "button",
			buttonImage: "resources/images/calendar.jpg",
			buttonImageOnly: true
		});
	});

		$(function() {
		$( "#dateOfHire" ).datepicker({
			changeYear: true,
			changeMonth: true,
			yearRange:"c-100:c+2",
			showOn: "button",
			buttonImage: "resources/images/calendar.jpg",
			buttonImageOnly: true
		});
	});

			$(function() {
		$( "#dateOfDeparture" ).datepicker({
			changeYear: true,
			changeMonth: true,
			yearRange:"c-100:c+2",
			showOn: "button",
			buttonImage: "resources/images/calendar.jpg",
			buttonImageOnly: true
		});
	});

			function deleteClassTeacher(thisObj){
				var elementWraper = $(thisObj).closest('.section_box');
				$(elementWraper).find('.basic_grid tr').removeClass('highlight');
				$(thisObj).parents('tr').addClass('highlight');
				$(elementWraper).find('.section_full_inside').hide();
				
				
				
				var okfunction = function(){
					document.form.action='staffDeleteClassTeacher.htm';
					document.form.submit();
				};
				
				var cancelfunction = function(){
					
					$(thisObj).parents('tr').removeClass('highlight');
				};
				
				var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
				confirm_function(message, okfunction, cancelfunction);
				
			
				
				
				
				
				}
			
			
			
			
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
			});

			
			
			var oldStaffID, oldSelectedClassGrade,oldSelectedYear;
			
			function updateSectionHead(thisValue, selectedValue,selectedClassGrade, selectedYear, selectedClassTeacherId ) {
				
				setAddEditPane(thisValue, 'Edit');
				
				oldStaffID= selectedValue;
				oldSelectedYear=selectedYear;

				oldSelectedClassGrade=selectedClassGrade;
			
				
				

           document.getElementById('selectStaff').value =selectedValue;
           document.getElementById('selectClassGrade').value =selectedClassGrade;
           document.getElementById('classTeacherYear').value=selectedYear;
           
		   document.form.classTeacherId.value = selectedClassTeacherId;
			
			
			}
			
			
			function validateAndSubmit(){	
				var newteacherId = document.getElementById("selectStaff").value;
				var newclassgradeId = document.getElementById("selectClassGrade").value;
				var newyearId = document.getElementById("classTeacherYear").value;
				
				
				clearMessages();
				
				if(oldStaffID == newteacherId && oldSelectedClassGrade == newclassgradeId && oldSelectedYear == newyearId
				){
				var messageElement = document.getElementById("statusMessage");
				var messageLabel = document.createElement("LABEL");
				var messageText = document.createTextNode("<spring:message code="REF.UI.SECTION.EDIT"/>");
				messageLabel.setAttribute('class', 'required_sign');		
				messageLabel.appendChild(messageText);
				messageElement.setAttribute('class', 'messageArea');
				messageElement.appendChild(messageLabel);
			}
				
				else{
					document.form.action='staffSaveOrUpdateClassTeacher.htm'; 
					document.form.submit();
					setAddEditPane(this,'Save');
				}
			}

			
			
			
			
			
			
			
			
</script>
<!-- END Calender controll CSS and JS -->
</head>


<body>
<h:headerNew parentTabId="1" page="classTeacherAllocation.htm"/>
<script language="javascript">
   $(document).ready(function() {
    var url = window.location.toString();
      if(url.split("?")[1] === "new"){
		var firstElement = $("#menubar li").first();
		$("#menubar li a").removeAttr("href")
		$("#menubar li a").addClass("disabled")
   	  //  $("#menubar ul").append(firstElement);
     }
  });
   
  function resetitems(){
	 document.getElementById('lName').value = "";
	 document.getElementById('classGrade').selectedIndex="0";
	 document.getElementById('selectedYear').selectedIndex="1";
	 
	 document.getElementById('classTeacherYear').value = "0";
	 document.getElementById('selectClassGrade').value = "0";
	 document.getElementById('selectStaff').value = "0";
	 document.form.classTeacherId.value="0";
   }

  
</script>

	


	<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
        <li><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION"/></li>
      </ul>
    </div>
   <div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/classTeacherAllocationHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" />
				</a>
			</div>
 
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION"/></h1>
  <div id="content_main">
  <div class="messageArea" id="statusMessage">
	  <c:if test="${message != null}"><font class="required_sign">&nbsp;&nbsp;&nbsp;<c:out value="${message}"
				escapeXml="false"/></font></c:if>
		
	  <c:if test="${assginMessage != null}"><font class="success_sign">&nbsp;&nbsp;&nbsp;<c:out value="${assginMessage}"
				escapeXml="false"/></font></c:if>
				
	  <c:if test="${searchMessage != null}"><font class="required_sign">&nbsp;&nbsp;&nbsp;<c:out value="${searchMessage}"
			escapeXml="false"/></font></c:if>
  </div>			
    <form:form action="#" method="post" commandName="classTeacher" name="form">
	<div class="section_full_search">
	
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.LAST_NAME"/></label>
                </div>
                <input type="text" id="lName" name="lName" <c:if test="${lasName != null}"> value="${lasName}"</c:if>/>
                
              </div>
			  <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.CLASS_GRADE"/></label>
                </div>
                <select name="classGrade" id="classGrade">
                    <option value = ""><spring:message code="application.drop.down"/></option>
                    <c:forEach items="${classGradeList}" var="classGrade">
                    	<option label="${classGrade.description}" value="${classGrade.description}" <c:if test="${selectedClass == classGrade.description}">selected="selected"</c:if>>${classGrade.description}</option>
                    </c:forEach>
                </select>
              </div>
			  <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.YEAR"/></label>
                </div>
								<select name="year" id="selectedYear">
									<c:forEach items="${yearList}" var="year" varStatus="status">
										<option label="${year}" value="${year}" <c:if test="${thisYear == year}">selected="selected"</c:if>>${year}</option>
									</c:forEach>
								</select>
							</div>
              <div class="float_right">
                 <div class="buttion_bar_type1">
                 <sec:authorize access="hasRole('Search Class Teacher Allocation')">
                <input type="button" value="<spring:message code="REF.UI.SEARCH"/>"
                onClick="
                document.form.action ='staffSearchClassTeacher.htm';
                document.form.submit();"
                class="button">
                </sec:authorize>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
          </div>
      </div>
	<div class="clearfix"></div>
	<div class="section_box">
	<div>
        <div class="section_box_header">
          <h2><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.SEARCH_RESULTS"/></h2>
        </div>
		
        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.TEACHER"/></th>
              <th><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.GRADE_CLASS"/></th>
			
			  <th align="right" class="right">
				
				<sec:authorize access="hasRole('Add/Edit Class Teacher Allocation')">
				
				<img src="resources/images/ico_new.gif" class="icon_new"
 					onClick="clearMessages(); setAddEditPane(this,'Add'); resetitems();"
 					width="18" height="20"
 					title="<spring:message code='STAFF.CLASS_TEACHER_ALLOCATION.NEW_GS_ALLOCATION'/>"/>					
				
				</sec:authorize>
			</th>
			
		</tr>
            <tr
									<c:choose>
		            					<c:when test="${teacherList != null  || message != null}">
			 								id="search_results"
										</c:when>
		            					<c:otherwise>
											id="search_results" style="display:none;"
										</c:otherwise>
		            				</c:choose>
		            			>
            <c:if test="${searchClassTeacher != null }">
            <c:forEach var="searchClassTeacher" items="${searchClassTeacher}" varStatus="status">
            <tr <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              <td class="left" <c:if test="${selectedObj.classTeacherId == searchClassTeacher.classTeacherId}">
															id="flag"
												</c:if>>${searchClassTeacher.staff.nameWithIntials}</td>
              <td>${searchClassTeacher.classGrade.description} </td>              
              
              <c:choose>
            	<c:when test="${(searchClassTeacher.deleted) == false}">
            		<td nowrap class="right">
              
              <c:if test="${showEdit == true }">
              
   <sec:authorize access="hasRole('Add/Edit Class Teacher Allocation')">

   
            <c:forEach items="${editYearList}" var="editYear"  >
				<c:if test = "${searchClassTeacher.classTeacherId == editYear.key}">
                    <c:set var="yearVariable" value="${editYear.value}" scope="application" />
                </c:if>
          </c:forEach> 
              
       <img src="resources/images/ico_edit.gif" title="<spring:message code='STAFF.CLASS_TEACHER_ALLOCATION.EDIT_GS_ALLOCATION'/>"
          width="18" height="20" class="icon"
               
          onClick="clearMessages(); setAddEditPane(this,'Edit');  
          updateSectionHead(this,'<c:out value="${searchClassTeacher.staff.staffId}" />','<c:out value="${searchClassTeacher.classGrade.classGradeId}" />','<c:out value="${applicationScope.yearVariable}" />','<c:out value="${searchClassTeacher.classTeacherId}"/>');"
       /> 
   </sec:authorize>
			   
			  <sec:authorize access="hasRole('Delete Class Teacher Allocation')">
              <img src="resources/images/ico_delete.gif" 
              onClick="
              document.form.classTeacherId.value = '${searchClassTeacher.classTeacherId}';
              deleteClassTeacher(this);"
              title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20" class="icon">
              </sec:authorize>
              </c:if>
              
              </td>
            	</c:when>
            	<c:otherwise>
            		</td>
            	</c:otherwise>
            </c:choose>
              

              
			</tr>
		</c:forEach>
	</c:if>
          </table>
        </div>
		</div>
		<div class="section_full_inside" style="display: ${state?'block':'none'}">
		
          <h3><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.NEW_GS_ALLOCATION"/></h3>
          <div class="box_border">
		  <div class="row">
		  <div><form:hidden path="classTeacherId"/></div>
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.TEACHER"/> :</label>
                </div>
               <form:select path="staff.staffId" id="selectStaff">
                    <form:option value="0"><spring:message code="application.drop.down"/></form:option>
                    
                    <c:forEach items="${staffList}" var="staff">
							                  	<option value="${staff.staffId}" <c:if test='${selectedStaffIdVal != null &&
								                  	staff.staffId eq selectedStaffIdVal}'> selected="selected"</c:if>>${staff.registrationNo} - ${staff.nameWithIntials}</option>
				    </c:forEach>
				    
                </form:select>
              </div>
			  <div class="float_right">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.GRADE_CLASS"/>:</label>
                </div>
                <form:select path="classGrade.classGradeId" id="selectClassGrade">
                    <form:option value="0"><spring:message code="application.drop.down"/></form:option>
                    
                    <c:forEach items="${classGradeList}" var="classGrade">
                   
							                  	<option value="${classGrade.classGradeId}" <c:if test='${selectedClassGradeVal != null &&
								                  	classGrade.classGradeId eq selectedClassGradeVal}'> selected="selected"</c:if>>${classGrade.description}</option>
				    </c:forEach>
							                
                </form:select>
              </div>
            </div>
			<div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="STAFF.CLASS_TEACHER_ALLOCATION.YEAR"/></label>
                </div>
               <select name="classTeacherYear" id="classTeacherYear">
               		<option value="0" ><spring:message code="application.drop.down"/></option>
               		
                     
                    <c:forEach items="${currentYear}" var="year">
                    <option value="${year}" <c:if test='${selectedYearVal != null &&
								                  	year eq selectedYearVal}'> selected="selected"</c:if>>${year}</option>
                    </c:forEach>
                    
                    
                </select>
              </div>
			  <div class="buttion_bar_type1" style="margin-top:15px; ">
			  <sec:authorize access="hasRole('Add/Edit Class Teacher Allocation')">
                <input type="button" value='<spring:message code="REF.UI.SAVE"/>'
                onClick="validateAndSubmit()" class="button">
                
                <input type="button" class="button"
                onClick="setAddEditPane(this,'Cancel'); clearMessages()" value='<spring:message code="REF.UI.CANCEL"/>' >
               </sec:authorize>
              </div>
            </div>

            <div class="clearfix"></div>
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
      
     <input type="hidden" name="selectVal" id="selectVal" value="${showEdit}"/>
    </form:form>
  </div>
</div>
<h:footer />
</body>
</html>
