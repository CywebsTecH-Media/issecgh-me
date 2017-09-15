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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="PRAGMA" content="NO-CACHE">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<link rel="stylesheet" type="text/css"
	href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function deleteSectionHead(thisObj) {
		$(thisObj).parents('tr').addClass('highlight');

		var okfunction = function() {
			document.sectionHeadSearch.action = 'staffDeleteSectionHead.htm';
			document.sectionHeadSearch.submit();
		};

		var cancelfunction = function() {
			$(thisObj).parents('tr').removeClass('highlight');
		};

		var message = '<spring:message code="REF.DELETE.CONFIRMATION"/>';

		confirm_function(message, okfunction, cancelfunction);
	}

	function disableSectionHead() {
		if (document.sectionHeadSearch.gradeId.value != '0') {
		document.sectionHeadSearch.sectionId.disabled = true;
		document.sectionHeadSearch.sectionId.value = '0';
		}else{
			document.sectionHeadSearch.sectionId.disabled = false;
			document.sectionHeadSearch.sectionId.value = '0';
			
		}
	}

	function disableGrade() {
		if (document.sectionHeadSearch.sectionId.value != '0') {
		document.sectionHeadSearch.gradeId.disabled = true;
		document.sectionHeadSearch.gradeId.value = '0';
		}else{
			document.sectionHeadSearch.gradeId.disabled = false;
			document.sectionHeadSearch.gradeId.value = '0';
		}
	}

	function resetDisabled() {
		document.sectionHeadSearch.sectionId.disabled = false;
		document.sectionHeadSearch.sectionId.value = '0';
		document.sectionHeadSearch.gradeId.disabled = false;
		document.sectionHeadSearch.gradeId.value = '0';
	}
	function updateDisabled() {
		if (document.sectionHeadSearch.gradeId.value != '0') {
			document.sectionHeadSearch.sectionId.disabled = true;
			document.sectionHeadSearch.gradeId.disabled = false;
		} else if (document.sectionHeadSearch.sectionId.value != '0') {
			document.sectionHeadSearch.gradeId.disabled = true;
			document.sectionHeadSearch.sectionId.disabled = false;
		} else {
			document.sectionHeadSearch.sectionId.disabled = false;
			document.sectionHeadSearch.gradeId.disabled = false;
		}
	}

	// to store current panal "Edit" or "Add"
	var isEditPane = false;

	function setPane(thisObj, type) {
		//this will set "AddEditPane" and 
		//if type = Edit ,remove start date calander img
		if (type == 'Add') {
			isEditPane = false;
			setAddEditPane(thisObj, 'Add');
			disableImages('StartDateDiv', false);
		} else if (type == 'Edit') {
			disableImages('StartDateDiv', false);
			isEditPane = true;
			setAddEditPane(thisObj, 'Edit');
		}
	}

	function disableImages(DivId, doHide) {
		//this fuction will remove images in given div tag
		var imgTags = document.getElementById(DivId)
				.getElementsByTagName('img');
		if (doHide) {
			imgTags[0].style.visibility = 'hidden';
		} else {
			imgTags[0].style.visibility = 'visible';
		}

	}
</script>

<script>
	$(function() {

		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDate = date.getDate();
		var currentYear = date.getFullYear();

		var dates = $("#StartDate, #EndDate")
				.datepicker(
						{
							defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							numberOfMonths : 1,
							dateFormat : 'yy-mm-dd',
							showOn : "button",
							minDate : new Date(currentYear, currentMonth,
									currentDate),
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,

							onSelect : function(selectedDate) {

								var option = this.id == "StartDate" ? "minDate"
										: "maxDate", instance = $(this).data(
										"datepicker"), date = $.datepicker
										.parseDate(
												instance.settings.dateFormat
														|| $.datepicker._defaults.dateFormat,
												selectedDate, instance.settings);

								dates.not(this).datepicker("option", option,
										date);

								if (this.id == "StartDate") {
									displayEnddate();
								}
								if (this.id == "EndDate"
										&& $("#StartDate")
												.datepicker('getDate') < new Date()) {

									if (document.getElementById('StartDate').value == "") {
										disableImages('StartDateDiv', false);
									} else {
										disableImages('StartDateDiv', false);
									}

								}
							}
						});
	});
</script>
<script type="text/javascript">
	function displayEnddate() {
		var startdate = document.getElementById('StartDate').value;
		var endDate = document.getElementById('EndDate').value;
		if (endDate == null || endDate == "") {
			var selectdate = startdate.split("-");
			document.getElementById('EndDate').value = selectdate[0] + "-12-31";
		}
	}
</script>
<script>
	function saveSectionHead(thisValue) {
		var newSectionHead = document.getElementById("staffId").value;
		var newGrade = document.getElementById("gradeId").value;
		var newSection = document.getElementById("sectionId").value;
		var newStartDate = document.getElementById("StartDate").value;
		var newEndDate = document.getElementById("EndDate").value;

		clearMessages();

		if (oldStaffID == newSectionHead && oldSelectedGrade == newGrade
				&& oldSelectedSection == newSection
				&& oldSelectedStartDate == newStartDate
				&& oldSelectedEndDate == newEndDate) {
			var messageElement = document.getElementById("msgArea");
			var messageLabel = document.createElement("LABEL");
			var messageText = document
					.createTextNode("<spring:message code="REF.UI.SECTION.EDIT"/>");
			messageLabel.setAttribute('class', 'required_sign');
			messageLabel.appendChild(messageText);
			messageElement.setAttribute('class', 'messageArea');
			messageElement.appendChild(messageLabel);

		}

		else if (newSectionHead != 0 && newStartDate != null) {
			if (newGrade != 0 || newSection != 0) {
				setAddEditPane(this, 'Save');
				document.sectionHeadSearch.action = 'staffAddSectionHead.htm';
				document.sectionHeadSearch.submit();

			} else {
				document.getElementById("msgArea").innerHTML = "<p Class='required_sign'><spring:message code='REF.UI.MANDATORY.FIELD.REQUIRED'/></p>";
			}
		} else {
			document.getElementById("msgArea").innerHTML = "<p Class='required_sign'><spring:message code='REF.UI.MANDATORY.FIELD.REQUIRED'/></p>";
		}

	}

	var oldStaffID, oldSelectedGrade, oldSelectedSection, oldSelectedStartDate, oldSelectedEndDate;
	function updateSectionHead(thisValue, selectedValue, selectedGrade,
			selectedSection, selectedStartDate, selectedEndDate,
			selectedSectionHeadId) {

		oldStaffID = selectedValue;
		oldSelectedGrade = selectedGrade;
		oldSelectedSection = selectedSection;
		oldSelectedStartDate = selectedStartDate;
		oldSelectedEndDate = selectedEndDate;

		document.getElementById('staffId').value = selectedValue;
		document.getElementById('gradeId').value = selectedGrade;

		document.sectionHeadSearch.EndDate.value = selectedEndDate;
		document.sectionHeadSearch.StartDate.value = selectedStartDate;
		document.sectionHeadSearch.StartDate.set;
		document.sectionHeadSearch.sectionHeadId.value = selectedSectionHeadId;
		document.sectionHeadSearch.sectionId.value = selectedSection;

	}
</script>
<!-- END Calender controll CSS and JS -->

</head>
<body>

	<h:headerNew parentTabId="1" page="sectionHeadAllocation.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="STAFF.SECTION_HEAD_ALLOCARION" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/sectionHeadAllocationHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" />
				</a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="STAFF.SECTION_HEAD_ALLOCARION" />
		</h1>
		<div class="messageArea" id="msgArea" style="padding-left: 14px;">

			<label class="required_sign"><form:errors
					path="sectionHeadID" /> </label> <label class="required_sign"> <c:if
					test="${message != null}">${message}</c:if> </label> <label
				class="success_sign"> <c:if test="${successMessage != null}">${successMessage}</c:if>
			</label>

		</div>
		<div id="content_main">
			<form:form method="POST" commandName="sectionHead"
				name="sectionHeadSearch">
				<form:hidden path="sectionHeadId" />

				<div class="section_full_search">
					<div class="box_border">

						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.LAST_NAME" /> </label>
								</div>
								<form:input path="staff.lastName" />
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.EMP_NO" /> </label>
								</div>
								<form:input path="staff.registrationNo" />
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.YEAR" /> </label>
								</div>

								<select name="year" id="selectedYear">
									<c:forEach items="${yearList}" var="year" varStatus="status">
										<option label="${year}" value="${year}"
											<c:if test="${thisYear == year}">selected="selected"</c:if>>${year}</option>
									</c:forEach>
								</select>


							</div>
							<div class="float_right">

								<div class="buttion_bar_type1">
									<sec:authorize
										access="hasRole('Search Section Head Allocation')">
										<input type="button"
											value="<spring:message code='REF.UI.SEARCH'/>"
											onClick="document.sectionHeadSearch.action='staffSearchSectionHeadList.htm'; document.sectionHeadSearch.submit();document.getElementById('search_results').style.display='';"
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
							<h2>
								<spring:message
									code="STAFF.SECTION_HEAD_ALLOCARION.SEARCH_RESULTS" />
							</h2>
						</div>
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="368"><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.SECTION_HEAD" />
									</th>
									<th width="477"><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.SECTION_GRADE" />
									</th>
									<th width="477"><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.START_DATE" />
									</th>
									<th width="477"><spring:message
											code="STAFF.SECTION_HEAD_ALLOCARION.END_DATE" />
									</th>
									<th width="63" align="right" class="right"><sec:authorize
											access="hasRole('Add/Edit Section Head Allocation')">
											<img src="resources/images/ico_new.gif" class="icon_new"
												onClick="clearMessages(); setPane(this,'Add'); $('#textName').hide(); $('#selectName').show();document.getElementById('staffId').value ='0';document.sectionHeadSearch.EndDate.value='';document.sectionHeadSearch.StartDate.value='';document.sectionHeadSearch.sectionHeadId.value='0';document.sectionHeadSearch.sectionId.value='0';document.sectionHeadSearch.gradeId.value='0';
												$('#staffId').attr('disabled', false);
												$('#gradeId').attr('disabled', false);
												$('#sectionId').attr('disabled', false);
												document.getElementById('staff.lastName').value = '';
												document.getElementById('staff.registrationNo').value = '';
												document.getElementById('selectedYear').selectedIndex = 1;
												document.getElementById('hiddenStaffId').value = 0;
												document.getElementById('hiddenGradeId').value = 0;
												document.getElementById('hiddenSectionId').value = 0;"
												width="18" height="20"
												title="<spring:message code='STAFF.SECTION_HEAD_ALLOCARION.NEW_SH_ALLOCATION'/>">
										</sec:authorize></th>

								</tr>
								<tr
									<c:choose>
		            					<c:when test="${teacherList != null  || message != null}">
			 								id="search_results"
										</c:when>
		            					<c:otherwise>
											id="search_results" style="display:none;"
										</c:otherwise>
		            				</c:choose>>
									<c:forEach items="${sectionHeadList}" var="sectionHead"
										varStatus="status">
										<tr
											<c:if test="${editedSectionHeadId != null && (editedSectionHeadId == sectionHeadId)}">class="highlight"</c:if>
											<c:choose>
		            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
		            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
		            		</c:choose>>
											<c:choose>
												<c:when test="${(sectionHead) == 'Empty' }">
			
												</c:when>
												<c:otherwise>
													<td>${sectionHead.staff.nameWithIntials}</td>
													<c:choose>
														<c:when test="${sectionHead.sectionId!=null}">
															<c:forEach items="${sectionList}" var="section">
																<c:if test="${sectionHead.sectionId==section.sectionId}">
																	<td>${section.description}</td>
																</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<c:forEach items="${gradeList}" var="grade">
																<c:if test="${sectionHead.gradeId==grade.gradeId}">
																	<td>${grade.description}</td>
																</c:if>
															</c:forEach>
														</c:otherwise>
													</c:choose>
													<td>${sectionHead.startDate}</td>
													<td>${sectionHead.endDate}</td>

													<td nowrap class="right">
															
																<sec:authorize
																	access="hasRole('Add/Edit Section Head Allocation')">
																	<img src="resources/images/ico_edit.gif"
																		title="<spring:message code='STAFF.SECTION_HEAD_ALLOCARION.EDIT_SH_ALLOCATION'/>"
																		onClick="clearMessages(); 
																		
															updateSectionHead(this,'<c:out value="${sectionHead.staff.staffId}" />','<c:out value="${sectionHead.gradeId}" />','<c:out value="${sectionHead.sectionId}" />','<c:out value="${sectionHead.startDate}" />','<c:out value="${sectionHead.endDate}"/>','<c:out value="${sectionHead.sectionHeadId}"/>');
																		
																		
													setPane(this,'Edit');
													 $('#selectName').hide();
													  $('#textName').show(); 
													  disableImages('StartDateDiv', false);
													$('#staffId').attr('disabled', false);
													$('#clearSectionGrade').attr('disabled', false);
													document.getElementById('hiddenStaffId').value = 0;
													document.getElementById('hiddenGradeId').value = 0;
													document.getElementById('hiddenSectionId').value = 0;
													updateDisabled();"
																		width="18" height="20" class="icon">
																</sec:authorize>
																<sec:authorize
																	access="hasRole('Delete Section Head Allocation')">
																	<img src="resources/images/ico_delete.gif"
																		onClick="document.sectionHeadSearch.sectionHeadId.value='${sectionHead.sectionHeadId}';deleteSectionHead(this);"
																		title="<spring:message code='REF.UI.DELETE'/>"
																		width="18" height="20" class="icon">
																</sec:authorize>														
														</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
							</table>
						</div>
					</div>
					<div class="section_full_inside"
						style='display: ${editpane != null ?'block':'none'}'>
						<h3>
							<spring:message
								code="STAFF.SECTION_HEAD_ALLOCARION.NEW_SH_ALLOCATION" />
						</h3>
						<div class="box_border">
							<div class="float_left">
								<h6>
									<span class="required_sign">**</span>
									<spring:message
										code="STAFF.SECTION_HEAD_ALLOCARION.GRADE_SECTION_MANDATORY" />
								</h6>
							</div>
							<br />
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="STAFF.SECTION_HEAD_ALLOCARION.TEACHER" /> </label>
									</div>
									<form:select path="staff.staffId" id="staffId">
										<option value="0">
											<spring:message code="application.drop.down" />
										</option>
										<c:choose>
											<c:when test="${(sectionHead.staff.dateOfDepature) == null}">
												<form:options items="${staffList}" itemValue="staffId"
													itemLabel="nameWithIntials" />
											</c:when>
										</c:choose>

									</form:select>
									<form:hidden path="hiddenStaff.staffId" id="hiddenStaffId" />
								</div>
								<div class="float_right">
									<div class="lbl_lock">
										<span class="required_sign">**</span><label><spring:message
												code="STAFF.SECTION_HEAD_ALLOCARION.GRADE" /> </label>
									</div>
									<form:select path="gradeId" id="gradeId"
										onchange="disableSectionHead();">
										<option value="0">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${gradeList}" itemValue="gradeId"
											itemLabel="description" />
									</form:select>

									<form:hidden path="hiddenGradeId" id="hiddenGradeId" />
								</div>
							</div>
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">**</span><label><spring:message
												code="STAFF.SECTION_HEAD_ALLOCARION.SECTION" /> </label>
									</div>
									<div>
										<form:select path="sectionId" id="sectionId"
											onchange="disableGrade();">
											<option value="0">
												<spring:message code="application.drop.down" />
											</option>
											<form:options items="${sectionList}" itemValue="sectionId"
												itemLabel="description" />
										</form:select>
										<form:hidden path="hiddenSectionId" id="hiddenSectionId" />
									</div>




								</div>
								<div class="float_right"
									style="margin-right: 50px; *margin-right: 10px;">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="STAFF.SECTION_HEAD_ALLOCARION.END" /> </label>
									</div>
									<form:input id="EndDate" path="endDate" cssClass="date_field"
										readonly="true" />
								</div>
								<div class="float_right" style="margin-right: 80px;"
									id="StartDateDiv">
									<div class="lbl_lock">
										<span class="required_sign">*</span><label><spring:message
												code="STAFF.SECTION_HEAD_ALLOCARION.START" /> </label>
									</div>
									<form:input id="StartDate" path="startDate"
										cssClass="date_field" readonly="true"
										onchange="displayEnddate() ; " />
								</div>

							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" class="button" id="clearSectionGrade"
										value='<spring:message code="STAFF.UI.CLEAR_BUTTON"/>'
										onclick="resetDisabled();"> <input type="button"
										class="button" onClick="saveSectionHead(this);"
										value='<spring:message code="REF.UI.SAVE"/>'> <input
										type="button" class="button"
										onClick="clearMessages(); setAddEditPane(this,'Cancel')"
										value='<spring:message code="REF.UI.CANCEL"/>'>
								</div>
							</div>

							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>