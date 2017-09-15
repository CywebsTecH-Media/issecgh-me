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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
	<link href="resources/css/list.css" rel="stylesheet"
	type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script src="resources/js/jquery-1.8.2.min.js"></script>
<script src="resources/js/jquery-ui-1.10.2.custom.js"></script>
<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>

	<script type="text/javascript">

$(document).ready(function() {
	$("#ToList").on('click', 'li', function (e) {
	    if (e.ctrlKey || e.metaKey) {
	        $(this).toggleClass("item_selected");
	    } else {
	        $(this).addClass("item_selected").siblings().removeClass('item_selected');
	    }
	});
});


$(document).ready(function() {

	$('#tList').click(function() {
		if($('#tList').is(':checked')){
			$('#ToList option').prop('selected', 'selected');
		}
 		else{
			$('#ToList option').prop('selected', '');
		}
	});

});


$(document).ready(function() {

	$('#fList').click(function() {
		if($('#fList').is(':checked')){
			$('#FromList option').prop('selected', 'selected');
		}
 		else{
			$('#FromList option').prop('selected', '');
		}
	});

});

	function statusCheckbox(){
		if(document.getElementById("tList").checked){		
			document.getElementById("tList").checked = false;
			}
		if(document.getElementById("fList").checked){
			document.getElementById("fList").checked = false;
			}
		}

</script>


<script type="text/javascript">

function selectClass(thisValue) {
	document.form.selectedClass.value = thisValue;

}

function loadAdmissionNo(selectedValue,selectedAddmissionNo) {

	var url = '<c:url value="/populateAddmissionNosByClass1.htm" />';

	$.ajax({
		url : url,
		data : ({
			'classGradeId' : selectedValue
		}),
		success : function(response) {

			var responseArray = response.split(",");
			document.getElementById('selectAddmission').innerHTML = '';

			var dropDownDiv = document.getElementById('selectAddmission');
			var selector = document.createElement('select');
			selector.id = "selectedAddmission";
			selector.name = "selectedAddmission";
			dropDownDiv.appendChild(selector);

			var option = document.createElement('option');
			option.value = '0';
			option.appendChild(document.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
			selector.appendChild(option);

			if (responseArray.length > 0) {

				for ( var i = 0; i < responseArray.length; i++) {

					if (responseArray[i] != "") {
						option = document.createElement('option');
						option.value = responseArray[i];
						option.appendChild(document.createTextNode(responseArray[i]+""));
						selector.appendChild(option);
					}

					if(selectedAddmissionNo!=null)
					{
						if(option.value==selectedAddmissionNo)
						{
							option.selected = 'selected';
						}

					}
				}
			}
		},
		error : function(transport) {
			alert("error");

		}
	});

}

function submitList(form){

	var result=new Array();
	var fromArrayList = new Array(); // array to keep the values to be removed.
	fromList = document.getElementById("FromList");
	if(form.ToList.length != 0){
	    for (var i = 0; i < form.ToList.length; i++) {
	    	form.ToList.options[i].selected = "selected";
	        if (form.ToList.options[i].selected) {
	            	result[i] = form.ToList.options[i].value + "-"
					+ form.ToList.options[i].text;
	        }
	    }


	 // generates the list to be removed for the From list.
		for ( var index = 0; index < fromList.length; index++) {
			fromArrayList[index] = fromList.options[index].value + "-"
					+ fromList.options[index].text;

		}
		document.form.selectedArray.value = result;
		document.form.removedFromArray.value = fromArrayList;
	}
    document.form.action = "studentSummaryReport.htm";
	document.form.submit();
}

function callOnLoadFun(thisValue, selectedAddmissionNo)
{
	selectClass(thisValue);
	loadAdmissionNo(thisValue, selectedAddmissionNo);
}


//keeps the selected values on the To list and remove them from the from list when
//errors occured.
function openMultipleSelect() {

	var array = "${selectedToList}";

	if(array.length != 0)
	{
		var splitArray = array.split(",");
		toList = document.getElementById("ToList");
		var len = splitArray.length;
		for (index = 0; index < len; index++) {

			var selectedOption = splitArray[index].split("-");
			var newOption = document.createElement("option");
			newOption.setAttribute('label', selectedOption[1]);
			newOption.setAttribute('value', selectedOption[0]);
			newOption.setAttribute('id', selectedOption[0]);
			newOption.innerHTML = selectedOption[1];
			toList.appendChild(newOption);
		}

		// remove the selected objects from the from list.
		fromList = document.getElementById("FromList");
		var fromLength = fromList.length;
		var fromArray = "${removedFromArray}";
		var fromArrayList = fromArray.split(",");

		for (index = 0; index < len; index++) { // iterates over the selected values.
			var selectedOption = splitArray[index].split("-");
			for (indexFrom = 0; indexFrom < fromLength; indexFrom++) { //iterates over the from list.

				if (selectedOption[0] == fromList.options[indexFrom].value) {
					fromList.remove(indexFrom);
					indexFrom--;
					fromLength--;
				}
			}
		}
	}

}




</script>
</head>
<body onload="<c:if test="${selectedClassGradeId != null}">callOnLoadFun('<c:out value="${selectedClassGradeId}" />','<c:out value="${selectedAddmissionNo }" />');</c:if>
<c:if test = "${selectedToList != null}"> openMultipleSelect(); </c:if>">
<div id="page_container">
	<div id="breadcrumb_area">
		<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentSummaryReportsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
	</div>
	<div class="clearfix"></div>
	<h1><spring:message code="REPORT.STUDENT.GENERAL.REPORTS"/></h1>
	<div id="content_main">
		<div class="clearfix"></div>

		<div class="section_box">
			<div class="section_box_header">
				<h2><spring:message code="REPORT.STUDENT.DETAILS.SUMMARY"/></h2>
			</div>

			<div class="section_full_inside">

				<div class="box_border">
					<form:form method="POST"
						commandName="StudentSummaryTemplate" name="form" id="form">
						<label class="required_sign"> <c:if
										test="${message != null}">${message}</c:if> </label>
						<div>
							<label class="required_sign"> <form:errors
									path="studentAdmissionNo" /><br> </label>
						</div>
						<div class="clearfix"></div>

						<div class="clearfix"></div>
						<div><table>

						<tr>
								<td>
									<span class="required_sign">*</span> <label><spring:message code="REPORT.STUDENT.REPORT.CARD.SELECT.CLASS"/></label>
								</td>
								<td>
									<select name="selectedClass" id="selectedClass" onchange="selectClass(this.value);loadAdmissionNo(this.value);submitList(this)">
						                <option value="0"> <spring:message code="OPT.PLEASE.SELECT"/> </option>
							                <c:forEach items="${classGradeList}" var="classGrade">
							                  	<option value="${classGrade.classGradeId}" <c:if test='${selectedClassGradeId != null &&
								                  	grade.gradeId eq selectedClassGradeId}'> selected="selected"</c:if>>${classGrade.description}</option>
							                </c:forEach>
						            </select>
								</td>

							</tr>

							<tr>
								<td>
									<span class="required_sign">*</span> <label><spring:message code="REPORT.ADMISSIONNO"/></label>
								</td>
								<td>
									<div id="selectAddmission"></div>
								</td>

							</tr>


							<tr>
								<td colspan="2">
								</td>
							</tr>

						</table>
						</div>
						<div>
							<div class="section_box">
							<div class="column_single">

							<div id="add_remove_student">
							<div style="width: 340px; float: left">
							<div class="studenSelectbox"> <input id="fList" name="rem" type="checkbox" />Select all</div>
							<br>
							<label><spring:message code='REPORT.CATEGORY'/>
							<c:out value="${Grade}" /> (<c:out value="${SelectedYear}" />):</label><br>
							<select name="FromList" size="15" multiple="multiple" id="FromList">
								<c:forEach items="${categoryList}" var="categoryList" varStatus="status">
										<option id="New" value="${categoryList.key}">${categoryList.value}</option>
								</c:forEach>
							</select>
							</div>
							<div id="selected_list" class="ccontroller"><input type="button"
								class="button" name="Button" value="&gt;" onClick="add();statusCheckbox();"><br>
							<br>

							<input type="hidden" name = "selectedArray"/>
	                        <input type="hidden" name = "removedFromArray"/>
							<input type="button" class="button" name="Button" value="&lt;"
								onClick="removeoptions(); statusCheckbox();"></div>
							<div style="width: 340px; float: left">
							<div class="studenSelectbox"> <input id="tList" name="rem" type="checkbox" />Select all</div>
							<br>
							<span class="required_sign">*</span><label><spring:message code='REPORT.CATEGORY.SELECTED'/></label>
							<select name="ToList" size="15"
								multiple="multiple" id="ToList">
							</select></div>
							<div class="clearfix"></div>
							</div>
							</div>
							<div style="margin-left:5px;">
							</div>
							<div style="margin-left:5px;">
							<input type="submit" class="button" onClick="submitList(form)" value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
							</div>
							<div class="clearfix"></div>
							<br>
							</div>
						</div>


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