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
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="PRAGMA" content="NO-CACHE">
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
		$("#educationQualYear").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange : "c-100:c+2",
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true
		});
	});

	$(function() {
		var dates = $("#professionalQualFromYear, #professionalQualToYear")
			.datepicker(
				{
					defaultDate : "+1w",
					changeYear : true,
					changeMonth : true,
					yearRange : "c-100:c+2",
					dateFormat : 'yy-mm-dd',
					numberOfMonths : 1,
					showOn : "button",
					buttonImage : "resources/images/calendar.jpg",
					buttonImageOnly : true,
					onSelect : function(selectedDate) {
						var option = this.id == "professionalQualFromYear" ? "minDate"
								: "maxDate", instance = $(this).data(
								"datepicker"), date = $.datepicker
								.parseDate(
										instance.settings.dateFormat
												|| $.datepicker._defaults.dateFormat,
										selectedDate, instance.settings);
						dates.not(this).datepicker("option", option,
								date);
					}
				});
	});
</script>

<script type="text/javascript">

	function saveStaffQualifications(qualification) {
		if(qualification=="Proffesional"){
			document.staffQualifications.action="saveStaffProfessionalQualification.htm";
		}else if(qualification=="Education"){
			document.staffQualifications.action="saveStaffEducationQualification.htm";
		}
		document.staffQualifications.submit();
	}

	
	
	
	//delete staffEducationQualification
	function deleteStaffEducation(thisObj, staffEducationQualId) {

		$(thisObj).parents('tr').addClass('highlight');
		var elementWraper = $(thisObj).closest('.section_box');
		  $(elementWraper).find('.section_full_inside').hide();
		  
			var okfunction = function(){
				document.getElementById('selectedStaffEducationQualId').value = staffEducationQualId;
				document.staffQualifications.action = "deleteStaffEducation.htm";
	            document.staffQualifications.submit();
			};
			
			var cancelfunction = function(){
				
				$(thisObj).parents('tr').removeClass('highlight');
			};
			
			var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
			confirm_function(message,okfunction, cancelfunction);
		  
		

		
	}
	
	
	

	//delete staffProfessionalQualification
	function deleteStaffProfessional(thisObj, staffProfessionalQualId) {

		$(thisObj).parents('tr').addClass('highlight');
		var elementWraper = $(thisObj).closest('.section_box');
		  $(elementWraper).find('.section_full_inside').hide();
		  
		  
		  
		  
			var okfunction = function(){
				document.getElementById('selectedStaffProfesionalQualId').value = staffProfessionalQualId;
				document.staffQualifications.action = "deleteStaffProfessional.htm";
	            document.staffQualifications.submit();
			};
			
			var cancelfunction = function(){
				
				$(thisObj).parents('tr').removeClass('highlight');
			};
			
			var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
			confirm_function(message,okfunction, cancelfunction);
		  
		

	
	}
	
	//Limit the text area input.
	function limitText(limitField, limitNum) {
		
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} 
	}
	
	
	function clearErrorMessage(id){
	     $(document).ready(function() {
				$("#"+id).hide();
			});

	}
	
		
	function hideSection(id){
		
		 $(document).ready(function() {
		 $("tr").removeClass('highlight');
			$("#"+id).hide();
		
			});
	}
	function hideErrorSection(){
		// Reset student education id and Professional id...
		document.staffQualifications.staffEducationId.value='0';
		document.staffQualifications.staffProfessionalId.value = '0';
		
		 $(document).ready(function() {
		 $("tr").removeClass('highlight');
			$("#eduError").hide();
			$("#profError").hide();
			});
	}
</script>

</head>
<body>

	<h:headerNew parentTabId="2" page="staffQualifications.htm" />

	<div id="page_container">

		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
					<sec:authorize access="hasRole('Search Staff Members')">
					<li><a href="staffSearch.htm"><spring:message code="STAFF.STAFF_QUALIFICATIONS.STAFF_SEARCH"/></a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="STAFF.STAFF_QUALIFICATIONS"/></li>
				</ul>
			</div>
			<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/staffMemberQualificationsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="STAFF.STAFF_QUALIFICATIONS"/></h1>
		<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.NAME"/> :&nbsp;</label> ${staff.nameWithIntials}
					</div>
					<div class="float_left">
						<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.REG_NO"/> :&nbsp;</label> ${staff.registrationNo}
					</div>
					<div class="float_left"></div>
					<div class="clearfix"></div>
				</div>
			</div>
			<form:form action="" method="POST" name="staffQualifications"
				commandName="wrapperQualification">

				<div class="clearfix"></div>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="STAFF.STAFF_QUALIFICATIONS.EDUCARIONAL_QUA"/></h2>
					</div>
					
					<spring:bind path="wrapperQualification.staffEducation.*">
							
							<label id="eduError" class="required_sign"> <c:if
									test="${not empty status.errorMessages}">
									<c:forEach var="error" items="${status.errorMessages}">
										<c:out value="${error}" escapeXml="false" />
										<br />
									</c:forEach>
								</c:if>
							</label>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th width="25%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.EDUCARIONAL_QUA"/></th>
								<th width="40%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.DETAILS"/></th>
								<th width="12%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.YEAR"/></th>
								<th width="12%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.STATUS"/></th>
								<th width="12%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.INSTITUTE"/></th>
								<th width="65" class="right">
								<c:if test="${departureDate == null }">
								<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="hideErrorSection(),hideSection('profSectionFullInside'),setAddEditPane(this,'Add');
										document.staffQualifications.staffEducationId.value='0';
										document.staffQualifications.educationQualDescription.value='0';
										document.staffQualifications.educationQualStatus.value='0';
										document.staffQualifications.educationQualYear.value='';
										document.staffQualifications.educationQualDetails.value='' ;
										document.staffQualifications.educationQualInstitute.value='0';"
											width="18" height="20"
											title="<spring:message code='STAFF.STAFF_QUALIFICATIONS.ADD_EDUCATIONAL_QUA'/>">
                                </sec:authorize></c:if>
								</th>
							</tr>

							<c:choose>
								<c:when test="${not empty staffEducationList}">
									<c:forEach var="staffEducation" items="${staffEducationList}"
										varStatus="count">
									
										<c:set var="cssClass" value="${(count.count % 2 == 1) ? 'odd' : 'even'}" />
									    <c:if test="${((wrapperQualification.staffEducation != null) && (wrapperQualification.staffEducation.staffEducationId gt 0)
											 	&& (staffEducation.staffEducationId == wrapperQualification.staffEducation.staffEducationId))}">
												<c:set var="cssClass" value="${cssClass} highlight" />
									    </c:if>
									    
									    <tr class="${cssClass}">
										<td>${staffEducation.educationalQualification.description}</td>
										<td>${staffEducation.description}</td>
										<td>${staffEducation.year}</td>
										<td><c:choose>
												<c:when test="${staffEducation.status eq 1}">
													<c:out value="Pending"></c:out>
												</c:when>
												<c:when test="${staffEducation.status eq 2}">
													<c:out value="Following"></c:out>
												</c:when>
												<c:when test="${staffEducation.status eq 3}">
													<c:out value="Completed"></c:out>
												</c:when>
											</c:choose></td>
										<td>
										<c:forEach var="staffInstitute" items="${instituteList}"
										varStatus="count">
										
										<c:choose>
											 <c:when test="${staffInstitute.instituteId eq staffEducation.instituteId}">
												${staffInstitute.instituteName}
											 </c:when>
											<c:otherwise>
												
											</c:otherwise>
										</c:choose>
										
										
										</c:forEach>
										</td>
										<td nowrap class="right">
										<c:if test="${departureDate == null}">
										
										<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
										<img src="resources/images/ico_edit.gif"
											title="<spring:message code='STAFF.STAFF_QUALIFICATIONS.EDIT_EDUCATIONAL_QUA'/>"
											onClick="hideErrorSection(),hideSection('profSectionFullInside'),setAddEditPane(this,'Edit');
												document.staffQualifications.staffEducationId.value='${staffEducation.staffEducationId}';
												document.staffQualifications.educationQualDescription.value='${staffEducation.educationalQualification.educationalQualificationId}';
												document.staffQualifications.educationQualStatus.value='${staffEducation.status}';
												document.staffQualifications.educationQualYear.value='${staffEducation.year}';
												document.staffQualifications.educationQualInstitute.value='${staffEducation.instituteId}';
												document.staffQualifications.educationQualDetails.value='<c:out value="${strEscapeUtil:escapeJS(staffEducation.description)}"/>'; "
											width="18" height="20" class="icon">
										</sec:authorize>
										<sec:authorize access="hasAnyRole('Delete Qualification')">
											<img src="resources/images/ico_delete.gif"
											onClick="hideErrorSection(),hideSection('profSectionFullInside'),deleteStaffEducation(this, ${staffEducation.staffEducationId});"
											title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20" class="icon">
										</sec:authorize>
										</c:if>
											</td>
										</tr>
									</c:forEach>									
								</c:when>
								<c:otherwise>
									<tr>
										<td><h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5></td>
										<td></td>	
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										
									</tr>
								</c:otherwise>
							</c:choose>

						</table>
					</div>
						<div class="section_full_inside" id="eduSectionFullInside"
							style="display: ${not empty status.errorMessages?'block':'none'}">
					</spring:bind>
					<h3><spring:message code="${isEdit? 'STAFF.STAFF_QUALIFICATIONS.EDIT_EDUCATIONAL_QUA' : 'STAFF.STAFF_QUALIFICATIONS.ADD_EDUCATIONAL_QUA'}"/></h3>
					<div class="box_border">
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span><label><spring:message code="STAFF.STAFF_QUALIFICATIONS.EDUCARIONAL_QUA"/> :</label>
								</div>

								<form:select id="educationQualDescription"
									path="staffEducation.educationalQualification.educationalQualificationId"
									disabled="${readonly}">
									<option value="0"><spring:message code="application.drop.down"/></option>
									<form:options items="${educationalQualificationsList}"
										itemValue="educationalQualificationId" itemLabel="description" />
								</form:select>

							</div>
							<div class="float_right">
								<div class="lbl_lock">
									<span class="required_sign">*</span><label><spring:message code="STAFF.STAFF_QUALIFICATIONS.STATUS"/> :</label>
								</div>
								<form:select path="staffEducation.status"
									id="educationQualStatus" disabled="${readonly}">
									<option value="0"><spring:message code="application.drop.down"/></option>
									<form:option value="1"><spring:message code="STAFF.STAFF_QUALIFICATIONS.PENDING"/></form:option>
									<form:option value="2"><spring:message code="STAFF.STAFF_QUALIFICATIONS.FOLLOWING"/></form:option>
									<form:option value="3"><spring:message code="STAFF.STAFF_QUALIFICATIONS.COMPLETED"/></form:option>
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.YEAR"/> :</label>
								</div>
								<spring:message code='STAFF.STAFF_MEMBER_DETAILS.DATE_OF_BIRTH.FORMAT' var="dateOfFirstAppointmentFormat"/>
								<form:input path="staffEducation.year" id="educationQualYear"
									class="date_field" title="${dateOfFirstAppointmentFormat}"/>
							</div>

							<div class="float_right">
								<div class="lbl_lock">
									<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.DETAILS"/> :</label>
								</div>
								<form:textarea path="staffEducation.description" rows="4"
									id="educationQualDetails" cols="20" onkeydown="limitText(this.form.educationQualDetails,250);" 
							onkeyup="limitText(this.form.educationQualDetails,250);"></form:textarea>
							</div>
						</div>
						
						<div class = "row">
						<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.INSTITUTE"/> :</label>
								</div>

								<form:select id="educationQualInstitute"
									path="staffEducation.instituteId"
									disabled="${readonly}">
									<option value="0"><spring:message code="application.drop.down"/></option>
									<form:options items="${instituteList}"
										itemValue="instituteId" itemLabel="instituteName" />
								</form:select>

							</div>
						</div>

						<div class="row">
							<div class="buttion_bar_type1">
							<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
								<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
									onClick="setAddEditPane(this,'Save');saveStaffQualifications('Education')"
									class="button"> <input type="button" class="button"
									onClick="setAddEditPane(this,'Cancel'),hideErrorSection();" value="<spring:message code='REF.UI.CANCEL'/>">
							</sec:authorize>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="clearfix"></div>
		</div>
		<div class="section_box">
			<div class="section_box_header">
				<h2><spring:message code="STAFF.STAFF_QUALIFICATIONS.PROFESSIONAL_QUA"/></h2>
			</div>
			<spring:bind path="wrapperQualification.staffProfessional.*">
					
					<label  id="profError" class="required_sign"> <c:if
							test="${not empty status.errorMessages}">
							<c:forEach var="error" items="${status.errorMessages}">
								<c:out value="${error}" escapeXml="false" />
								<br />
							</c:forEach>
						</c:if>
					</label>
			<div class="column_single">
				<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th width="25%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.PROFESSIONAL_QUA"/></th>
						<th width="50%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.DETAILS"/></th>
						<th width="12%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.FROM_YEAR"/></th>
						<th width="12%"><spring:message code="STAFF.STAFF_QUALIFICATIONS.TO_YEAR"/></th>
						<th width="42" class="right">
						
						<c:if test="${departureDate == null }" >
						<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
						<img src="resources/images/ico_new.gif" class="icon_new"
							onClick="hideErrorSection(),hideSection('eduSectionFullInside'),setAddEditPane(this,'Add');
								document.staffQualifications.staffProfessionalId.value = '0';
								document.staffQualifications.professioanlQualDiscription.value='0';
								document.staffQualifications.professionalQualDetials.value='';
								document.staffQualifications.professionalQualFromYear.value='';
								document.staffQualifications.professionalQualToYear.value='';" width="18" height="20"
							title="<spring:message code='STAFF.STAFF_QUALIFICATIONS.ADD_PROFESSIONAL_QUA'/>">
						</sec:authorize></c:if>
							</th>
					</tr>

					<c:choose>
						<c:when test="${not empty staffProfessionalList}">
							<c:forEach var="staffProfessional" varStatus="count"
								items="${staffProfessionalList}">
								
									<c:set var="cssClass" value="${(count.count % 2 == 1) ? 'odd' : 'even'}" />
									    <c:if test="${((wrapperQualification.staffProfessional != null) && (wrapperQualification.staffProfessional.staffProfessionalId gt 0)
											 	&& (staffProfessional.staffProfessionalId == wrapperQualification.staffProfessional.staffProfessionalId))}">
												<c:set var="cssClass" value="${cssClass} highlight" />
									    </c:if>
										<tr class="${cssClass}">
										
								<td>${staffProfessional.professionalQualification.description}</td>
								<td>${staffProfessional.description}${dfg}</td>
								<td>${staffProfessional.fromYear}</td>
								<td>${staffProfessional.toYear}</td>
								<td nowrap class="right">
								
								<c:if test="${departureDate == null}">
								<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
								<img src="resources/images/ico_edit.gif"
									title="<spring:message code='STAFF.STAFF_QUALIFICATIONS.EDIT_PROFESSIONAL_QUA'/>"
									onClick="hideErrorSection(),hideSection('eduSectionFullInside'),setAddEditPane(this,'Edit'); 
											document.staffQualifications.staffProfessionalId.value = '${staffProfessional.staffProfessionalId}';
											document.staffQualifications.professioanlQualDiscription.value='${staffProfessional.professionalQualification.professionalQualificationId}';
											document.staffQualifications.professionalQualDetials.value='<c:out value="${strEscapeUtil:escapeJS(staffProfessional.description)}"/>';
											document.staffQualifications.professionalQualFromYear.value='${staffProfessional.fromYear}';
											document.staffQualifications.professionalQualToYear.value='${staffProfessional.toYear}' ; "
									width="18" height="20" class="icon">
								</sec:authorize>
								<sec:authorize access="hasAnyRole('Delete Qualification')">
								<img src="resources/images/ico_delete.gif"
									onClick="hideErrorSection(),hideSection('eduSectionFullInside'),deleteStaffProfessional(this, ${staffProfessional.staffProfessionalId}); "
									title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20" class="icon">
								</sec:authorize></c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
									<tr>
										<td><h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:otherwise>
					</c:choose>

				</table>
			</div>
				<div class="section_full_inside" id="profSectionFullInside"
					style="display: ${not empty status.errorMessages?'block':'none'}">
			</spring:bind>
			<h3><spring:message code="${isEdit? 'STAFF.STAFF_QUALIFICATIONS.EDIT_PROFESSIONAL_QUA' : 'STAFF.STAFF_QUALIFICATIONS.ADD_PROFESSIONAL_QUA'}"/></h3>
			<div class="box_border">
				<div class="row">
					<div class="float_left">
						<div class="lbl_lock">
							<span class="required_sign">*</span><label><spring:message code="STAFF.STAFF_QUALIFICATIONS.PROFESSIONAL_QUA"/> :</label>
						</div>

						<form:select
							path="staffProfessional.professionalQualification.professionalQualificationId"
							disabled="${readonly}" id="professioanlQualDiscription">
							<option value="0"><spring:message code="application.drop.down"/></option>
							<form:options items="${professionalQualificationsList}"
								itemValue="professionalQualificationId" itemLabel="description" />
						</form:select>

					</div>
					<div class="float_right">
						<div class="lbl_lock">
							<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.DETAILS"/> :</label>
						</div>
						<form:textarea id="professionalQualDetials"
							path="staffProfessional.description" rows="4" cols="20" onkeydown="limitText(this.form.professionalQualDetials,250);" 
							onkeyup="limitText(this.form.professionalQualDetials,250);"></form:textarea>
					</div>
				</div>

				<div class="row">
					<div class="float_left">
						<div class="lbl_lock">
							<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.FROM_YEAR"/> :</label>
						</div>
						<spring:message code='STAFF.STAFF_QUALIFICATIONS.DATE_YEAR_MONTH.FORMAT' var="dateOfYearFormat"/>
						<form:input id="professionalQualFromYear"
							path="staffProfessional.fromYear" class="date_field" title="${dateOfYearFormat}"/>
					</div>

				</div>
				<div class="row">
					<div class="float_left">
						<div class="lbl_lock">
							<label><spring:message code="STAFF.STAFF_QUALIFICATIONS.TO_YEAR"/> :</label>
						</div>
						<spring:message code='STAFF.STAFF_QUALIFICATIONS.DATE_YEAR_MONTH.FORMAT' var="dateOfYearFormat"/>
						<form:input id="professionalQualToYear"
							path="staffProfessional.toYear" class="date_field" title="${dateOfYearFormat}"/>
					</div>
				</div>

				<div class="row">
					<div class="buttion_bar_type1">
					<sec:authorize access="hasAnyRole('Add/Edit Qualification')">
						<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
							onClick="setAddEditPane(this,'Save');saveStaffQualifications('Proffesional')"
							class="button">
						<input type="button" class="button"
							onClick="hideErrorSection(),setAddEditPane(this,'Cancel');" value="<spring:message code='REF.UI.CANCEL'/>">
					</sec:authorize>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>
	<input type="hidden" name="selectedStaffEducationQualId"
		id="selectedStaffEducationQualId" />
	<input type="hidden" name="selectedStaffProfesionalQualId"
		id="selectedStaffProfesionalQualId" />
	<form:hidden path="staffProfessional.staff.staffId" />
	<form:hidden path="staffEducation.staff.staffId" />
	<form:hidden path="staffProfessional.staffProfessionalId"
		id="staffProfessionalId" />
	<form:hidden path="staffEducation.staffEducationId"
		id="staffEducationId" />
	</form:form>
	</div>
	</div>
	<h:footer />
</body>
</html>
