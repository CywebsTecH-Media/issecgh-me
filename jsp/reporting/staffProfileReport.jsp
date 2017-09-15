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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="JavaScript" src="resources/js/list.js" type="text/JavaScript"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function selectCategory(thisValue) {
		document.form.selectedCategory.value = thisValue;
		var admission = document.getElementById('selectedAddmission');
		var status = document.form.selectedStatus.value;
		document.getElementById('FromList').innerHTML = '';
		document.getElementById('ToList').innerHTML = '';
		if(thisValue == 0){
			document.getElementById('selectAddmission').innerHTML = '';	
			document.getElementById('FromList').innerHTML = '';
			document.getElementById('ToList').innerHTML = '';
		}
	}

	function loadRegistrationNo(selectedValue,selectedAddmissionNo) {

		var url = '<c:url value="/populateRegistrationNosByStaffCategoryType.htm" />';

		$.ajax({
			url : url,
			data : ({
				'statusID' : document.form.selectedStatus.value,
				'catogaryID' : document.form.selectedCategory.value

			}),
			success : function(response) {

				
				//devide responce array to regNo and report data by using + sign
				var i = response.indexOf("+");
				var firstHalf, secondHalf;

				if (i>0) {
				  firstHalf = response.slice(0, i);
				  secondHalf = response.slice(i + 1, response.length);    
				}else{
					document.getElementById('selectAddmission').innerHTML = '';
				}
								
				//End of division of array
				document.getElementById('selectAddmission').innerHTML = '';		
				
				var inLenth = document.getElementById("ToList").length;
				
				if(inLenth == 0){
					document.getElementById('formList').innerHTML = '';
					var fromListDropDown = document
							.getElementById('formList');
					var selectorFromList = document.createElement('select');
					selectorFromList.id = "FromList";
					selectorFromList.name = "FromList";
					selectorFromList.size = "15";
					selectorFromList.multiple = "multiple";
					fromListDropDown.appendChild(selectorFromList);
					var regex = /(\d+)/g;
					if(secondHalf != null){
						var responseArrayTWO = secondHalf.split(",");
						if (responseArrayTWO.length > 0) {
		
							for ( var i = 0; i < responseArrayTWO.length; i++) {
		
								if (responseArrayTWO[i] != "") {
									
									option = document.createElement('option');
									option.value = responseArrayTWO[i].match(regex);
									option.appendChild(document
											.createTextNode(responseArrayTWO[i].replace(/[0-9]+=/g,'')
													+ ""));
									selectorFromList.appendChild(option);
								}
							}
						}
					}
				}

				var dropDownDiv = document.getElementById('selectAddmission');
				if ($("#selectedAddmission").length==0){
					var selector = document.createElement('select');
					selector.id = "selectedAddmission";
					selector.name = "selectedAddmission";
					dropDownDiv.appendChild(selector);	
				}

				var option = document.createElement('option');
				option.value = '0';
				option.appendChild(document
								.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
				selector.appendChild(option);

				if(firstHalf !=null){
					var responseArray = firstHalf.split(",");
					if (responseArray.length > 0) {
	
						for ( var i = 0; i < responseArray.length; i++) {
	
							if (responseArray[i] != "") {
								
								var dashMark = responseArray[i].indexOf("-");
								var regNumber = responseArray[i].slice(0, dashMark);
								var nameWithInitials = responseArray[i].slice(dashMark + 1, responseArray[i].length);
								
								option = document.createElement('option');
								option.value = regNumber;
								option.innerHTML = regNumber 
												+ "&nbsp;&nbsp;-&nbsp;&nbsp;" + nameWithInitials;
								selector.appendChild(option);
	
								if(selectedAddmissionNo!=null) {
									if(option.value==selectedAddmissionNo) {
										option.selected = 'selected';
									}
								}
	
							}
						}
					}
				}
				else{
					document.getElementById('selectAddmission').innerHTML = '<spring:message code="REPORT.STAFF.NOSTAFFFOUND"/>';
				}
			},
			error : function(transport) {
				custom_alert("An error has occurred.");

			}
		});
	}

	function callOnLoadFun(thisValue,selectedAddmissionNo){

		selectCategory(thisValue);
		loadRegistrationNo(thisValue,selectedAddmissionNo);
		var array = "${selectedToList}";
		if(array.length != 0){
			openMultipleSelect();
		}
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
	    document.form.action = "staffProfileReport.htm";
		document.form.submit();
	}
	
	//keeps the selected values on the To list and remove them from the from list when
	//errors occured.
	function openMultipleSelect() {
		var array = "${selectedToList}";
		var fromListArray = "${removedFromArray}";
		if(array.length != 0){
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

		}
		
		if(fromListArray.length != 0){
			
			var splitFromListArray = fromListArray.split(",");
			fromList = document.getElementById("FromList");
			var length = splitFromListArray.length;
			
			for (indexFrom = 0; indexFrom < length; indexFrom++) {

				var selectedOptionFrom = splitFromListArray[indexFrom].split("-");
				var newOptionFrom = document.createElement("option");
				newOptionFrom.setAttribute('label', selectedOptionFrom[1]);
				newOptionFrom.setAttribute('value', selectedOptionFrom[0]);
				newOptionFrom.setAttribute('id', selectedOptionFrom[0]);
				newOptionFrom.innerHTML = selectedOptionFrom[1];
				fromList.appendChild(newOptionFrom);
			}
		}

	}
	
	function claerToList(){
		var category = document.form.selectedCategory.value;
		var status = document.form.selectedStatus.value;
		var addmissionNo = document.getElementById('selectedAddmission').value;

		if(category == 0 && status == 0 && addmissionNo == 0){
			document.getElementById('ToList').innerHTML = '';
			document.getElementById('selectAddmission').innerHTML = '';
		}
		
	}
	
	function disableFromList(){
		var category = document.form.selectedCategory.value;
		var status = document.form.selectedStatus.value;
		if(category == 0 && status == 0){
			document.getElementById('FromList').innerHTML = '';
		}	
	}

</script>

</head >
<body  onload="disableFromList();<c:if test="${selectedStaffCategoryId != null}">callOnLoadFun('<c:out value="${selectedStaffCategoryId}" />','<c:out value="${selectedAddmissionNo}" />');</c:if>">
	<div id="page_container">
		<div id="breadcrumb_area">

			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/staffProfileReportsHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="REPORT.STAFF.GENERAL.REPORTS" />
		</h1>
		<div id="content_main">
			<div class="clearfix"></div>

			<div class="section_box">
				<div class="section_box_header">
					<h2>
						<spring:message code="STAFF.PROFILE.TITLE" />
					</h2>
				</div>

				<div class="section_full_inside">

					<div class="box_border">
						<form:form action="staffProfileReport.htm" method="POST"
							commandName="staffProfileReportTemplate" name="form">
							<label class="required_sign"> <c:if
									test="${message != null}">${message}</c:if>
							</label>
							<div>
								<label class="required_sign"> <form:errors path="*" /><br>
								</label>
							</div>

							<table>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message
												code="REPORT.ATTENDANCE.STAFF.PERDAY.CATEGORY.WISE.CATEGORY" /></label></td>
									<td><select name="selectedCategory" id="selectedCategory"
										onchange="selectCategory(this.value);loadRegistrationNo(this);claerToList();" >
											<option value="0">
												<spring:message code="OPT.PLEASE.SELECT" />
											</option>
											
											<c:if test="${staffCategoryList ne null}">
												<c:forEach items="${staffCategoryList}" var="staffCategory">
													<option value="${staffCategory.catogaryID}" <c:if test='${selectedStaffCategoryId != null &&
								                  	staffCategory.catogaryID eq selectedStaffCategoryId}'> selected="selected" </c:if>>${staffCategory.description}</option>
												</c:forEach>
											</c:if>
									</select></td>
								</tr>

								<tr>
									<td><span class="required_sign">*</span> <label><spring:message code="STAFF.PROFILE.STATUS" /></label></td>
									<td><select name="selectedStatus" id="selectedStatus"
										onchange="loadRegistrationNo(this);claerToList();disableFromList();">
											<option value="0">
												<spring:message code="OPT.PLEASE.SELECT" />
											</option>
											<option value="1"  <c:if test='${selectedStatus eq 1 }'> selected="selected" </c:if>><spring:message code="OPT.STAFF.PRESENT" /></option>
											<option value="2" <c:if test='${selectedStatus eq 2 }'> selected="selected" </c:if>><spring:message code="OPT.STAFF.PAST" /></option>
									</select></td>
								</tr>


								<tr>
									<td><span class="required_sign">*</span> <label><spring:message
												code="STAFF.PROFILE.REG.NO" /></label></td>
									<td>
										<div id="selectAddmission"></div>
									</td>

								</tr>
								<tr></tr>
							</table>
							<div> 
								<div class="section_box">
									<div class="column_single">
							
										<div id="add_remove_list">
											<div style="width: 340px; float: left"><label><spring:message code='REPORT.CONTENTS'/></label> 
													<div id="formList">
														<select name="FromList" size="15" multiple="multiple" id="FromList">
														<%-- <c:forEach items="${contentsList}" var="contentsList" varStatus="status">
															<option id="New" value="${contentsList.key}">${contentsList.value}</option>								
														</c:forEach> --%>
													</select>
													</div>
													
											</div>
											<div id="selected_list" class="controller"><input type="button"
												class="button" name="Button" value="&gt;" onClick="add()"><br>
											<br>
							
												<input type="hidden" name = "selectedArray"/>
						                        <input type="hidden" name = "removedFromArray"/>
												<input type="button" class="button" name="Button" value="&lt;" onClick="removeoptions()">
											</div>
											<div style="width: 340px; float: left">
												<label><spring:message code='REPORT.CONTENTS.SELECTED'/></label>
												<select name="ToList" size="15" multiple="multiple" id="ToList"> </select>
											</div>		
											<div class="clearfix"></div>					
										</div>						
									</div>
									<div style="margin-left:5px;"> </div>
									<div style="margin-left:5px;">
										<input type="submit" class="button"
										onClick="submitList(form)"
										value="<spring:message code="REPORT.UI.GENERATE.REPORT"/>">
									</div>
									<div class="clearfix"></div>
									<br>		
									<label><font size="1" face="Consolas"><spring:message code="REPORT.STAFF.PEOFILE.REPORT.NOTE"/> </font></label>					
								</div>	
							</div>
						</form:form>
					</div>
				</div>

				<div class="clearfix"></div>				
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>