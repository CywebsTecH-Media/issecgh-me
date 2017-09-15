<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>

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
<%@ taglib uri="/WEB-INF/tld/custom-functions.tld" prefix="func"%>
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
<script src="resources/js/student/studentExamMark.js"></script>


<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	function search(){
		document.form.action = 'searchExamMarks.htm';
		document.form.submit();
		
	}
	
	function cancel(){
		document.getElementById('btn_row').style.display='none';
		document.getElementById('search_results').style.display='none';
		document.getElementById('missing_error').style.display='none';
		/* document.getElementById("x").innerHTML = "<lable id = successmsglabel>''</lable>"; */
	}
	
		//save function	
	function saveExam(invalideFiledCount, subjectNames){
		var successLabel = document.getElementById("successmsglabel");
		 if(!!successLabel)
			successLabel.innerHTML = "";
	var indexsta = indexNoValidation(subjectNames, invalideFiledCount);
	
	
	if(invalideFiledCount.length==0 && !indexsta){
		
		var message= "<spring:message code='REF.SAVE.CONFIRMATION' />" ;
		
		var okfunction = function(){
			document.form.action = 'saveOrUpdateStudentMarks.htm';
			document.form.submit(); 
		};
		var cancelfunction = function(){};
		
		confirm_function(message , okfunction, cancelfunction );
	}
	
	else{
		if(indexsta){
			custom_alert(indexNumberRequired);			
		}			
		else {
			custom_alert("<spring:message code='REF.SAVE.ERROR' />");
		}
	}
	
	}
	
	// finds the class grades for a selected exam.
	function findClasses(selectedValue, classGradeError) {
		var url = '<c:url value="/findGradeClasses.htm" />';
		$.ajax({
	        url:url,
		    data:({
		         'selectedValue': selectedValue
		    }),
		    success: function(response) {
		    if(response != ''){
		        var responseArray = response.split(",");
				document.getElementById('classes').innerHTML = '';
		        var dropDownDiv = document.getElementById('classes');
				var selector = document.createElement('select');
				selector.id = "classGrade";
				selector.name = "grade";
				dropDownDiv.appendChild(selector);

				var option = document.createElement('option');
				option.value = '0';
				option.appendChild(document.createTextNode('<spring:message code="OPT.PLEASE.SELECT"/>'));
				selector.appendChild(option);

				if (responseArray.length > 0) {

					for ( var i = 0; i < responseArray.length; i++) {

						if (responseArray[i] != "") {
							option = document.createElement('option');
							var responseValue = responseArray[i].split("-");
							option.value = responseValue[1];
							option.appendChild(document.createTextNode(responseValue[0]));

							selector.appendChild(option);

							// if the class grade is selected then select it as the default.
							if(classGradeError != null){

								// converts the responseValue[1], which is a string int a int.
								// as it is needed to check the comparability.
								var val = parseInt(responseValue[1] , 10);

								if(val == classGradeError){
								option.selected = 'selected';
								}
							}
						}
					}

				}
		        } else {
		        	document.getElementById('classes').innerHTML = '';
		        }},
		        error: function(transport) {
		        	custom_alert("An error has occurred.");

		        }
	        });
	     }
		 
		//overrides reset function and calls setClassGradeError() to set Grade to previously selected value
		$(document).ready(function(){
		    $("input:reset").click(function() {
		        this.form.reset();
		        setClassGradeError(<c:out value = "${classGradeError} "/>);
		        return false;
		    });
		});
		
		function setClassGradeError(classGradeError){
			
			var classGradeErrorCombo = document.getElementById("classGrade");
			
			for(var i, j = 0; i = classGradeErrorCombo.options[j]; j++) {
				
				if(i.value == classGradeError) {
		        	
		        	classGradeErrorCombo.selectedIndex = j;
		        	
		        	break;
		        }
		    }
		}
</script>
		
<script type="text/javascript">		
	
	var markGradings;
	var indexno = "<spring:message code='REF.UI.EXAM.MARK.ADMISSION' />";
	var studentName = "<spring:message code='REF.UI.EXAM.MARK.NAME' />";
	var markError = "<spring:message code='EXAM.MARKS.MAX.MARKS' />";
	var notApplyError = "<spring:message code='EXAM.MARKS.MADATORY.CORE' />";
	var gradeInvalidError = "<spring:message code='EXAM.GRADES.INVALID' />";
	var gradeAcronymError = "<spring:message code='EXAM.MARKS.GRADING.ACRONYM' />";
	var indexDupError = "<spring:message code='EXAM.MARK.INDEXNO.EXISTS' />";
	var indexInvalidError = "<spring:message code='EXAM.INDEX.INVALID' />";
	var indexNumberRequired = "<spring:message code='EXAM.MARKS.ADMISSION.REQUIRED' />";
	
	//set properties in jqgrid
	function markGridView(subjectName) {
		var data = '${MarkJsonData}';
		studentMarkGridView(subjectName, data);

	}
</script>


<script type="text/javascript">

function loadAssigmentGrades(){	 

	var url = '<c:url value="/populateAssignmentGrades.htm" />';
	$.ajax({
	url: url,
	data : ({
		
	}),
	
	success : function(response) {
		markGradings = response;

	},	
	error : function(transport) {
		custom_alert("An error has occurred.");

	}
	
	}).done(function() {
		
		});	
}  		
</script>

</head>
<body onload="loadAssigmentGrades(); <c:if test = "${examKeyError != null}">findClasses('${examKeyError}',
'<c:out value = "${classGradeError} "/>')</c:if>">
<h:headerNew parentTabId="10" page="studentExamMarks.htm" />

<div id="page_container">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message
		code='application.home' /></a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code='REF.UI.MANAGE.EXAM.ADD' /></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentExamMarksHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"><spring:message code='application.help' /></a></div>
<div class="clearfix"></div>
<h1><spring:message code='REF.UI.MANAGE.EXAM.ADD' /></h1>
<div id="content_main"><form:form action="#" method="post"
	name="form" commandName="examMark" >

	<div class="clearfix"></div>
	<c:if test="${message != null}">
		<div><label id="missing_error" class="missing_required_error">${message}</label></div>
	</c:if>
	<div id="errorLabel"  class="missing_required_error"><label  class="missing_required_error"></label></div>
	<c:if test="${successMessage != null}">
		<div id="x"><label class="success_sign" id="successmsglabel">${successMessage}</label></div>
	</c:if>
	<div class="section_full_search">
	<div class="box_border">
	<p><spring:message code='REF.UI.MANAGE.EXAM.SEARCH.ADD' /></p>
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span> <label><spring:message
		code='REF.UI.EXAM.MARK.EXAM' />:</label></div>
	<select name="examId" id="examId" onchange="findClasses(this.value, null)">
		<option value="0" id="optionExam"><spring:message
			code="application.drop.down" /></option>
		<c:if test="${examList != null}">
			<c:forEach var="exam" items="${examList}">
				<option value="${exam.examId}"
				<c:if test="${examKeyError != null && exam.examId eq examKeyError}">
				selected="selected"
				</c:if>
				>${exam.description}</option>
			</c:forEach>
		</c:if>
	</select>
	</div>
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code='REF.UI.EXAM.MARK.GRADE' />:</label></div>
	<div id="classes"></div>
	</div>

	<div class="float_left" style="margin-right: inherit">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code='REF.UI.EXAM.MARK.YEAR' />:</label></div>
	<select name="year" id="year">
		<option value="0" id="optionYear"><spring:message
			code='application.drop.down' /></option>
		<c:if test="${yearList != null}">
			<c:forEach var="year" items="${yearList}">
			<!-- if the year is equals to the selected year then seleted the option of the drop down. -->
				<option value="${year}" <c:if test = "${errorYear != null && year eq errorYear}">
				selected = "selected"</c:if>>${year}</option>
			</c:forEach>
		</c:if>
	</select></div>
	<div class="float_right">
	<div class="buttion_bar_type1"><sec:authorize access="hasRole('Search Student Exam Marks')"><input type="button"
		value="<spring:message code='REF.UI.EXAM.MARK.SEARCH' />"
		onClick="search();  " class="button"></sec:authorize></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	
	 <c:if
					test="${(not empty studentList) and (not empty studentSubjectList) }"> 
	 <div class="section_box" id="search_results">
<div class="section_box_header">
	<h2><label><spring:message
		code='REF.UI.EXAM.MARK.EXAM.VIEW' /></label> ${examName} ${gradeName}
	${modelYear}</h2>
	</div>
	<div class="column_single">
<div><spring:message code='REF.UI.EXAM.MARK.FYI' /></div>	
	 <div id="validationErrorMessage" name="validationErrorMessage">
		<label class="missing_required_error" id="validationErrorMessagelabel" name="validationErrorMessagelabel"></label>
			</div>
	 
							<div id="tableDiv_General" class="tableDiv">
							<table id="users" class="FixedTables">
							</table>
							<div id="usersPage" ></div>
								
							</div>
	
	<c:if
					test="${(not empty subjectName) }">
							<script>
							var subjectName= ${subjectName};
							 markGridView(subjectName);
							</script>
				</c:if>
				
				<input type="hidden" id="editedMarksJsonArray" name="editedMarksJsonArray" value="" />
		<input type="hidden" id="editedIndexJsonArray" name="editedIndexJsonArray" value="" />
				

				
							

	<sec:authorize access="hasRole('Save Exam Marks')">
		<div id="btn_row" class="button_row" style="display: none">
		<c:if test="${fn:length(studentSubjectList) > 0}">
			<script language="javascript">
            	document.getElementById('btn_row').style.display='';
				
			</script>
		</c:if>
			<div class="buttion_bar_type2">
			<input type="button"
					value="<spring:message code='REF.UI.RESET'/>"
					onClick="search();document.getElementById('search_results').style.display=''; document.getElementById('btn_row').style.display=''"
					class="button"> 
		<input id = "saveButton" name= "saveButton" type="button" value="<spring:message code='REF.UI.SAVE' />"
			class="button">	
			<input type="button" value="<spring:message code='REF.UI.CANCEL' />"
			class="button" onclick="document.location.href='studentExamMarks.htm'">
			
		
		
		<input type="hidden" name="markorgrade" id="markorgrade" value="">
		
			<div id="gradeMarkErrorMessage" name="gradeMarkErrorMessage" >
	
	 		<c:choose>
              <c:when test="${exam.mark eq true}">
              <script>
              document.getElementById('markorgrade').value="isMark";
              </script>
              </c:when>
              <c:when test="${exam.mark eq false}">
              
                <script>
                document.getElementById('markorgrade').value="isGrade";
              </script>
              </c:when>
              </c:choose>
	</div>
	</div>
	</div>
		<div class="clearfix"></div>
		</div>
		</div>
	</sec:authorize>
	</c:if>
</form:form></div>


</div>
<h:footer />
</body>
</html>


