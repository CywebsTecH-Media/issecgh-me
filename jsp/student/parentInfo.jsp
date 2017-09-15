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
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="PRAGMA" content="NO-CACHE">
<title><spring:message code="APPLICATION.NAME" />
</title>
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
<!-- START -->

<!-- msdropdown -->
<link rel="stylesheet" type="text/css" href="resources/css/dd.css" />
<script src="resources/js/jquery.dd.min.js"></script>
<!-- msdropdown> -->

<link rel="stylesheet" type="text/css" href="resources/css/skin2.css" />
<link rel="stylesheet" type="text/css" href="resources/css/flags.css" />

<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>	

<script>
$(document).ready(function(e) {
	try {
		var pages = $("#pages").msDropdown({on:{change:function(data, ui) {
												var val = data.value;
												if(val!="")
													window.location = val;
											}}}).data("dd");

		var pagename = document.location.pathname.toString();
		pagename = pagename.split("/");
		pages.setIndexByValue(pagename[pagename.length-1]);
		$("#ver").html(msBeautify.version.msDropdown);
	} catch(e) {
		//console.log(e);
	}

	$("#ver").html(msBeautify.version.msDropdown);

	//convert
	$("#contactResidence").msDropdown();
	$("#contactMobile").msDropdown();
	$("#contactOffice").msDropdown();
	$("#contactOfficeFax").msDropdown();

});
function showValue(h) {
	console.log(h.name, h.value);
}
$("#tech").change(function() {
	console.log("by jquery: ", this.value);
})
//
</script>
<!-- END -->
<script>
	$(function() {
		$("#datedDonation").datepicker({
			changeYear : true,
			changeMonth : true,
			yearRange:"c-50:c+50",
			maxDate : new Date(),
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "resources/images/calendar.jpg",
			buttonImageOnly : true
		});
	});
</script>
<!-- END Calender controll CSS and JS -->

<script type="text/javascript" >

	//check if this user is admin, if so enable the sms subscription check box and package drop down.
     $(document).ready(function(e) {
    	<sec:authorize access="hasRole('Enable Checked Subscribe SMS')">
    	
    	document.getElementById("isSmsSubscribed").disabled = false;
    	document.getElementById("smsPackageId").disabled = false;
    	
    	</sec:authorize>
     });
     
$(document).ready(function() {


<c:if test="${user.role eq 'ROLE_STUDENT'}" >

    var container = document.getElementById('form_val');

	var inputs = container.getElementsByTagName('input');
	for (var i = 0; i < inputs.length; ++i) {
	  inputs[i].disabled = true;
	}

	var nSelect = container.getElementsByTagName('select');
	for (var i = 0; i < nSelect.length; ++i) {
	  nSelect[i].disabled = true;
	}

	var nTextArea = container.getElementsByTagName('textarea');
	for (var i = 0; i < nTextArea.length; ++i) {
	  nTextArea[i].disabled = true;
	}
	
	
	var nSpan = container.getElementsByTagName('span');
	for (var i = 0; i < nSpan.length; ++i) {
	  nSpan[i].disabled = true;
	}
</c:if>
		var isPupil=document.getElementById("parentPastPupil");
		checkParentPupil(isPupil);

		var isTeacher=document.getElementById("parentPastTeacher");
		checkParentTeacher(isTeacher);

	});


	function swichRelarion(thisVal) {
		document.form.selectedRelationship.value = thisVal.value;
		document.getElementById("smsPackageId").value = '0';
		document.form.action = 'AdminParent.htm';
		document.form.submit();
	}

	function saveOrUpdateParent(){
		// need to clear donation amout if set
		document.getElementById("amount").value='0.0';

		document.form.action = 'SaveAdminParent.htm';
		document.form.submit();
	}

	// Save or update donation .
	function saveOrUpdateDonation(thisVal) {
		document.form.action = 'saveOrUpdateDonation.htm';
		document.form.submit();
	}

	function editDonation(thisVal, donationId, purpose, amount, date,
			donationTypeId) {
		setAddEditPane(thisVal, 'Edit');
		document.form.donationId.value = donationId;
		document.form.purpose.value = purpose;
		document.form.datedDonation.value = date;
		document.form.amount.value = amount;
		document.form.donationTypeId.value = donationTypeId;
		$('input[value=' + donationTypeId + ']:radio').attr('checked',
				'checked');
	}

	function addNew(thisVal) {
		setAddEditPane(thisVal, 'Add');
		document.form.donationId.value = 0;
		document.form.purpose.value = '';
		document.form.datedDonation.value = '';
		document.form.amount.value = '0.0';
		document.form.donationTypeId.checked=false;
	}

	function deleteDonation(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			document.form.action = 'deleteDonation.htm';
			document.form.submit();
		};

		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
	}

	function checkParentPupil(thisObj) {
		if (thisObj.checked) {
			//$(thisObj).closest('div .row').next('div .row').show();
			document.getElementById("alumniRow").style.visibility = 'visible';
		} else {
			//$(thisObj).closest('div .row').next('div .row').hide();
			document.getElementById("alumniRow").style.visibility = 'hidden';
		}
	}
	function checkParentTeacher(thisObj) {
		if (thisObj.checked) {
			document.getElementById("parentEmployeeRow").style.visibility = 'visible';
		} else {
			document.getElementById("parentEmployeeRow").style.visibility = 'hidden';
		}
	}


	//function for limit text in text area
    function limitText(limitField, limitNum) {
		//maxlength is not work in IE8
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		}
	 }

    function selectCountry(selectedResCountry,selectedMobCountry,selectedOfficeCountry,selectedOfficeFaxCountry) {
    	if(selectedResCountry != null && selectedResCountry != ""){
    		$('#contactResidence').msDropDown().data('dd').set('value',selectedResCountry);
    	}
    	if(selectedMobCountry != null && selectedMobCountry != ""){
    		$('#contactMobile').msDropDown().data('dd').set('value',selectedMobCountry);
    	}
    	if(selectedOfficeCountry != null && selectedOfficeCountry != ""){
    		$('#contactOffice').msDropDown().data('dd').set('value',selectedOfficeCountry);
    	}

    	if(selectedOfficeFaxCountry != null && selectedOfficeFaxCountry != ""){
    		$('#contactOfficeFax').msDropDown().data('dd').set('value',selectedOfficeFaxCountry);
    	}
    }
    
     //When user unchecks the suscribe check box, selected package will be set to "Please Select" option.	
     function packageResetter(smsSubscribeVal){
    	 
    	 var chkStatus = smsSubscribeVal.checked;
    	 
    	if(!chkStatus){

    		document.getElementById("smsPackageId").value = "0";
    		
    	}
    }
     
    //Enabled subscription / sms package fields Before save the parent.  
    function enableSubscribe(){
    	document.getElementById("isSmsSubscribed").disabled = false;
    	document.getElementById("smsPackageId").disabled = false;
     }
    
	function parentDetail(){			
			var selectedParentId = document.getElementById("parentNic").value;
			var url = '<c:url value="/findParentById.htm" />';			
			$.ajax({
	        	url:url,
		    	data:({
		        	'selectedParentId': selectedParentId
		        }),	
		        dataType:'json',
		        success: function(response) {
		        	$("#messageAreaSuccess").hide();
		        	$( "#messageArea" ).empty();
		        	if(response.isParentExists){
						<c:if test="${user.role != 'ROLE_STUDENT' && user.role != 'ROLE_PARENT'}" >
			        	$("#messageArea").append("<p Class='required_sign'><spring:message code='STU.UI.PARENT.DOES.EXISTS' /></p>");
						</c:if>
			        	$("#lastName").val(response.lastName);
			        	$("#fullName").val(response.fulltName);
			        	$("#nameWithInitials").val(response.nameWithInitials);
			        	$("#parentNic").val(response.parentNic);
			        	$("#designation").val(response.designation);
			        	$("#incomeLevel").val(response.incomeLevel);
			        	$("#parentAddress").val(response.address);
			        	$("#parentTempAddress").val(response.tempAddress);
	 		        	$("#parentEmail").val(response.email);	
	 		        	$("#officeName").val(response.officeName);
	 		        	$("#officeAddress").val(response.officeAddress);
	 		        	$("#officeEmail").val(response.officeEmail);
	 
	 		        	if(response.residenceNo!=null){
	 			        	$("#parentResidenceNo").val(response.residenceNo);
	 		        	}else{
	 		        		$("#parentResidenceNo").val(null);
	 		        	};
	 		        	if(response.mobileNo!=null){
	 		        		$("#parentMobileNo").val(response.mobileNo);
	 		        	}else{
	 		        		$("#parentMobileNo").val(null);
	 		        	};
	 		        	if(response.officeFaxNo!=null){
	 		        		$("#parentOfficeFaxNo").val(response.officeFaxNo);
	 		        	}else{
	 		        		$("#parentOfficeFaxNo").val(null);
	 		        	};
	 		        	if(response.officeNo!=null){
	 	 		        	$("#parentOfficeNo").val(response.officeNo);
	 		        	}else{
	 		        		$("#parentOfficeNo").val(null);
	 		        	};
	
	 		        	$("#parentValidate").val('validated');
			        	
			        	$("#selectReligion").val(response.religionId);
			        	$("#selectEmpStatus").val(response.employmentStatusId);
			        	$("#selectWorkingSegment").val(response.workingSegmentId);
			        	$("#selectParentCity").val(response.cityId);
			        	$("#selectParentTempCity").val(response.tempCityId);
			        	$("#selectParentOfficeCity").val(response.officeCityId);
			        	$('#contactResidence').msDropDown().data('dd').set('value',response.countryShortCodeRes);
			        	$('#contactMobile').msDropDown().data('dd').set('value',response.countryShortCodeMob);
			        	$('#contactOffice').msDropDown().data('dd').set('value',response.countryShortCodeOff);
			        	$('#contactOfficeFax').msDropDown().data('dd').set('value',response.countryShortCodeFax);
			        	
	 		        	if(response.alumniId!=null){
			        		$('#parentPastPupil').attr('checked',true);
			        		$("#alumniRow").css("visibility", "visible");
			        		$("#parentAlumniNo").val(response.alumniId);
			        	}else{
			        		$('#parentPastPupil').attr('checked',false);
			        		$("#alumniRow").css("visibility", "hidden");
			        		$("#parentAlumniNo").val(null);
			        	}
			        	if(response.teacherRegNo!=null){
			        		$('#parentPastTeacher').attr('checked',true);
			        		$("#parentEmployeeRow").css("visibility", "visible");
			        		$("#parentTeacherRegNo").val(response.teacherRegNo);
			        	}else{
			        		$('#parentPastTeacher').attr('checked',false);
			        		$("#parentEmployeeRow").css("visibility", "hidden");
			        		$("#parentTeacherRegNo").val(null);
			        	}
		        	}else{
						<c:if test="${user.role != 'ROLE_STUDENT' && user.role != 'ROLE_PARENT'}" >
		        		$("#messageArea").append("<p Class='required_sign'><spring:message code='STU.UI.PARENT.DOESNT.EXISTS' /></p>");
						</c:if>
		    			$('form').find("input[type=text], textarea").val("");
		    			$('select').val('0');
		    			$('#contactResidence').msDropDown().data('dd').set('value',0);
		            	$('#contactMobile').msDropDown().data('dd').set('value',0);
		            	$('#contactOffice').msDropDown().data('dd').set('value',0);
		            	$('#contactOfficeFax').msDropDown().data('dd').set('value',0);
		            	$('#parentPastPupil').attr('checked',false);
		            	$('#parentPastTeacher').attr('checked',false);		         
		            	$("#alumniRow").css("visibility", "hidden");
		            	$("#parentEmployeeRow").css("visibility", "hidden");
		            	$("#parentNic").val(selectedParentId);
		        	}
		        	   			        	
		        },
		        error: function(transport) {
		        	custom_alert("error");
		        }
			}); 
		};
		
   
</script>
</head>
<body onload="<c:if test="${parentWrapper != null}">selectCountry('<c:out value="${selectedResCountry}" />','<c:out value="${selectedMobCountry}" />','<c:out value="${selectedOfficeCountry}" />','<c:out value="${selectedOfficeFaxCountry}" />');</c:if>">
	<c:choose>
	<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="AdminParent.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11" page="AdminParent.htm" />
		</c:otherwise>
	</c:choose>

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
						<sec:authorize access="hasRole('Student Search')">
						<li><a href="studentSearch.htm"><spring:message
									code="STUDENT.STUDENTSEARCH" />
						</a>&nbsp;&gt;&nbsp;</li>
					</sec:authorize>
					<li><spring:message code="STUDENT.PARENT.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
					<a href="#"
						onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/parentDetailsHelp.html"/>','helpWindow',780,550)"><img
						src="resources/images/ico_help.png" width="20" height="20"
						align="absmiddle">
					<spring:message code="application.help" />
					</a>
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
		<h1>
			<spring:message code="STUDENT.PARENT.TITLE" />
		</h1>
		<div id="content_main">
			<div class="section_full_summary">
				<div class="box_border">
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.NAME" />&nbsp;</label>
						${student.nameWtInitials}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.ADDMISSION" />&nbsp;</label>
						${student.admissionNo}
					</div>
					<div class="float_left">
						<label><spring:message code="STUDENT.COMMON.CLASS" />&nbsp;</label>
						${studentClassDescription}
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<form:form action="SaveAdminParent.htm" method="POST"
				commandName="parentWrapper" name="form">

				<form:hidden path="parent.parentId" />
				<%-- to hold requesting relation when radio button checked  --%>
				<input type="hidden" name="selectedRelationship" />

				<div class="section_full">
					<div class="row"></div>
					<div class="row">
						<div class="frmlabel">
							<label><spring:message code="STUDENT.PARENT.RELATIONSHIP" />
							</label>
						</div>
						<div class="frmvalue">
							<form:radiobutton path="relationship"
								id="fatherRelationship"
								onclick="swichRelarion(this)" value="F"

								label="" cssClass="radio_btn" />
							<spring:message code="STUDENT.PARENT.RADIO.BUTTON.FATHER" />
							<form:radiobutton path="relationship"
								id="motherRelationship"
								onclick="swichRelarion(this)"
								value="M" label="" cssClass="radio_btn" />
							<spring:message code="STUDENT.PARENT.RADIO.BUTTON.MOTHER" />
							<form:radiobutton path="relationship"
								id="guardianRelationship"
								onclick="swichRelarion(this)"
								value="G" label="" cssClass="radio_btn" />
							<spring:message code="STUDENT.PARENT.RADIO.BUTTON.GUARDIAN" />
						</div>
					</div>
					<div class="row">
					<div id="messageArea">
						<c:if test="${message != null}">
							<div class="error">
								<label class="required_sign" id="errormsg">
								<c:out value="${message}" />
								</label>
							</div>
						</c:if>
						<div>
							<form:errors path="*" cssClass="required_sign" />
						</div>
					</div>
					<div id="messageAreaSuccess">
					<c:if test="${messageSuccess != null}">
						<div class="success_sign" id="statusEmail">
								<label class="success_sign">${messageSuccess}</label>
						</div>
					</c:if>
					</div>
					
					<sec:authorize access="hasAnyRole('Change Details Request')">
								<div class="error" id="emailErr">
									<label class="required_sign" id="errormsg">${errorEmail}</label>
								</div>
								<div class="success_sign" id="statusEmail">
									<label class="success_sign">${adminMailStatus}</label> <label
										class="success_sign">${userMailStatus}</label>
								</div>
					</sec:authorize>
					</div>

				</div>
				<div class="clearfix"></div>
				<div id="form_val" class="section_box">
					<div class="section_box_header">
					<h2>
						<c:if test="${parentWrapper.relationship eq 'F'}">
							<spring:message code="STUDENT.PARENT.GENERAL.INFO.FATHER" />
						</c:if>
						<c:if test="${parentWrapper.relationship eq 'M'}">
							<spring:message code="STUDENT.PARENT.GENERAL.INFO.MOTHER" />
						</c:if>
						<c:if test="${parentWrapper.relationship eq 'G'}">
							<spring:message code="STUDENT.PARENT.GENERAL.INFO.GUARDIAN" />
						</c:if>
					</h2>
					</div>

					<div class="column_equal">
						<div class="row">
							<div class="frmlabel">
								<label><span class="required_sign">*</span>
								<spring:message code="STUDENT.PARENT.FULLNAME" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="fullName" path="parent.fullName" maxlength="100" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.NAME.WITH.INITIALS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="nameWithInitials" path="parent.nameWithInitials" maxlength="45"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.LAST.NAME" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="lastName" path="parent.lastName" maxlength="45"/>
							</div>
						</div>
						<div class="row" style= "line-height: 20px">
							<div class="frmlabel">
								<label><span class="required_sign">*</span>
								<spring:message code="STUDENT.PARENT.NIC" />
								</label>
							</div>
							<div class="frmvalue" style= "width: 264px !important;">
								<form:input id="parentNic" path="parent.nationalIdNo" maxlength="45" style= "width: 255px !important;"/>
							</div>
							<img src="resources/images/userSearch.jpg"  class="icon" style="margin-top: 4px !important;"
										onClick="parentDetail();"
										title="<spring:message code="REF.UI.PARENT.SEARCH" />">
						</div>
						<div class="row">
							<div class="frmlabel">
								<label>
								<spring:message code="STUDENT.PARENT.RELIGION" /> </label>
							</div>
							<div class="frmvalue">
								<form:select path="parent.religionId" id="selectReligion">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${religionList}" itemValue="religionId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.IS.PAST.PUPIL" />
								</label>
							</div>
							<div class="frmvalue">
								<form:checkbox path="parent.pastPupil" id="parentPastPupil"
									cssClass="checkbox" value="checkbox"
									onclick="checkParentPupil(this);" />
							</div>
						</div>

						<div class="row" id="alumniRow">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.ALUMNI.NO" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="parentAlumniNo" path="parent.alumniId" maxlength="20"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.IS.TEACHER.OR.STAFF" /></label>
							</div>
							<div class="frmvalue">
								<form:checkbox path="parent.teacher" id="parentPastTeacher"
									cssClass="checkbox" value="checkbox"
									onclick="checkParentTeacher(this);" />
							</div>
						</div>
						<div class="row" id="parentEmployeeRow">
							<div class="frmlabel">
								<label><span class="required_sign">*</span>
								<spring:message
										code="STUDENT.PARENT.REGISTRATION.NO" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="parentTeacherRegNo" path="parent.teacherRegNo" maxlength="20"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.EMPLOYMENT.STATUS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="parent.employmentStatusId" id="selectEmpStatus">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${emplomentStatusList}"
										itemValue="employmentStatusId" itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.WORKING.SEGMENT" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="parent.workingSegmentId" id="selectWorkingSegment">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${workingSegmentList}"
										itemValue="workingSegmentId" itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.DESIGNATION" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="designation" path="parent.designation" maxlength="45"/>
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.INCOME.LEVEL" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="incomeLevel" path="parent.incomeLevel" maxlength="45"/>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="column_equal">
						<div class="row">
							<strong>
							<spring:message code="STUDENT.PARENT.PERMANENT.ADDRESS" /> </strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.ADDRESS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:textarea id="parentAddress" path="parent.address" cols="" rows="2" onkeydown="limitText(this,150);"
												onkeyup="limitText(this,150);" onkeypress="return disableEnterKey(event);"
												onpaste="limitText(this,150);" maxlength="150" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.CITY" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="parent.cityId" id="selectParentCity">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${cityList}" itemValue="cityId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<strong><spring:message
									code="STUDENT.PARENT.TEMPORARY.ADDRESS" />
							</strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.ADDRESS" />
								</label>
							</div>
							<div class="frmvalue">
								<form:textarea id="parentTempAddress" path="parent.tempAddress" cols="" rows="2" onkeydown="limitText(this,150);"
												onkeyup="limitText(this,150);" onkeypress="return disableEnterKey(event);"
												onpaste="limitText(this,150);" maxlength="150" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.CITY" />
								</label>
							</div>
							<div class="frmvalue">
								<form:select path="parent.tempCityId" id="selectParentTempCity">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${cityList}" itemValue="cityId"
										itemLabel="description" />
								</form:select>
							</div>
						</div>
						<div class="row">
							<strong><span class="required_sign">**</span>
							<spring:message code="STUDENT.PARENT.CONTACT.DETAILS" />
							</strong>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.PHONE.RES" />
								</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select style="width:130px" name="selectedCountryCodeRes" id="contactResidence">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>
									</c:forEach>
								</select>
								<form:input id="parentResidenceNo" path="parent.residenceNo" maxlength="12" class="phoneNo_text" />
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								<label><spring:message code="STUDENT.PARENT.PHONE.MOB" />
								</label>
							</div>
							<div class="frmvalue" style="line-height: 12px;">
								<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeMob" id="contactMobile">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>
									</c:forEach>
								</select>
								<form:input id="parentMobileNo" path="parent.mobileNo" maxlength="12" class="phoneNo_text" />
							</div>
						</div>

						<div class="row">
							<div class="frmlabel">
								<label><spring:message
										code="STUDENT.PARENT.EMAIL.PERSONAL" />
								</label>
							</div>
							<div class="frmvalue">
								<form:input id="parentEmail" path="parent.email" maxlength="45"/>
							</div>
						</div>
					</div>

					<div class="clearfix"></div>
					<div class="inside_separatot">

						<div class="row">
							<strong><spring:message
									code="STUDENT.PARENT.OFFICE.DETAILS" /> </strong>
						</div>

						<div class="column_equal">
							<div class="row">
								<div class="frmlabel">
									<label><spring:message
											code="STUDENT.PARENT.OFFICE.NAME" />
									</label>
								</div>
								<div class="frmvalue">
									<form:input id="officeName" path="parent.officeName" maxlength="45" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message code="STUDENT.PARENT.ADDRESS" />
									</label>
								</div>
								<div class="frmvalue">
									<form:textarea id="officeAddress" path="parent.officeAddress" cols="" rows="2" onkeydown="limitText(this,150);"
												onkeyup="limitText(this,150);" onkeypress="return disableEnterKey(event);"
												onpaste="limitText(this,150);" maxlength="150" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label>City:</label>
								</div>
								<div class="frmvalue">
									<form:select id="selectParentOfficeCity" path="parent.officeCityId">
										<option value="">
											<spring:message code="application.drop.down" />
										</option>
										<form:options items="${cityList}" itemValue="cityId"
											itemLabel="description" />
									</form:select>
								</div>
							</div>

						</div>
						
						<div class="column_equal">
							<div class="row">
								<div class="frmlabel">
									<label><spring:message code="STUDENT.PARENT.PHONE" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
									<select style="width:130px" name=selectedCountryCodeOffice id="contactOffice">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">
											<c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>
									</c:forEach>
								</select>
									<form:input id="parentOfficeNo" path="parent.officeNo" maxlength="12" class="phoneNo_text" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message code="STUDENT.PARENT.FAX" />
									</label>
								</div>
								<div class="frmvalue" style="line-height: 12px;">
									<select style="width:130px" name="selectedCountryCodeFax" id="contactOfficeFax">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach items="${countryListPhone}" var="countryListPhone" varStatus="status">
										    <c:set var="countryCode" value="${fn:split(countryListPhone.key, '=')}" />
											<option value='${countryListPhone.value.countryCode}' data-image="resources/images/blank.gif" data-imagecss="flag ${fn:toLowerCase(countryListPhone.value.countryCode)}" data-title='${countryListPhone.value.countryName}'>
												${countryCode[0]}
											</option>
									</c:forEach>
								</select>
									<form:input id="parentOfficeFaxNo" path="parent.officeFaxNo" maxlength="12" class="phoneNo_text" />
								</div>
							</div>
							<div class="row">
								<div class="frmlabel">
									<label><spring:message code="STUDENT.PARENT.EMAIL" />
									</label>
								</div>
								<div class="frmvalue">
									<form:input id="officeEmail" path="parent.officeEmail" maxlength="45"/>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
						<div class="clearfix"></div>
						<!--
				================================================================================
				 			SMS Application Related Code
				================================================================================
				
						-->
					<div class="inside_separatot">
					<div class="row">
							<strong>Subscribe To a Service </strong>
						</div>
						<div class="column_equal">
								<div class="frmlabel">
								<label>SMS Service :</label>
								</div>
								<div class="frmvalue">
									<form:checkbox path="isSmsSubscribed" id="isSmsSubscribed" cssClass="checkbox" value="checkbox" onclick="packageResetter(this);" disabled="true"/>
								</div>
								<div class="row">
								<div class="frmlabel">
									<label>Package Type:</label>
								</div>
								<div class="frmvalue">
								<form:select path="smsPackageId" id="smsPackageId" disabled="true">
									<form:option value="0">
										<spring:message code="application.drop.down" />
									</form:option>
									<c:forEach items="${smsPackagesMap}" var="smsPackage" varStatus="status">
											 <form:option value='${smsPackage.key}'>
												${smsPackage.value}
											 </form:option> 
									</c:forEach>
								</form:select>
								</div>
							</div>
							<div class="column_equal" style="text-align:left; padding-left:145px;">
								<label >** Package type is mandatory for SMS service subscription.</label><br>
							    <label >** Packages are displayed only when the sms service is available.</label>
							</div>
						</div>
						<!--
				================================================================================
				 			SMS Application Related Code
				================================================================================
				
						-->
					<div class="clearfix"></div>
					<div class="button_row">
						<div class="buttion_bar_type2">
						<input id="parentValidate" type="hidden" name="parentValidating" <c:if test="${parentvalidation == 'true'}">value='validated'</c:if> />
							<sec:authorize access="hasAnyRole('Save Parent Details')">
							
								<input type="button"
									value="<spring:message code="REF.UI.SAVE"/>" class="button" onClick="enableSubscribe();saveOrUpdateParent()" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('Change Details Request')">
								<input type="button"
									onclick="enableSubscribe();document.form.action = 'saveParentByParent.htm'; document.form.submit();"
									value="<spring:message code="REF.UI.SUBMIT"/>" class="button" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
							</sec:authorize>

							<sec:authorize access="hasAnyRole('Save Parent Details','Change Details Request')">
								<input type="button"
									value="<spring:message code="REF.UI.CANCEL"/>" class="button"
									onclick="document.location.href='AdminParent.htm'" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
							</sec:authorize>

						</div>
						<div class="clearfix"></div>
					</div>
				</div>

				<div class="section_box">
					<div>
						<c:if test="${assginMessage != null}">
							<font class="success_sign">&nbsp;&nbsp;&nbsp;<c:out value="${assginMessage}" escapeXml="false"/>
							</font>
						</c:if>
					</div>
					<div class="section_box_header">
						<h2>
							<spring:message code="STUDENT.PARENT.DONATION.TITLE" />
						</h2>
					</div>
					<div class="column_single">
						<table class="basic_grid" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<th><spring:message
										code="STUDENT.PARENT.DONATION.DONATIONS" />
								</th>
								<th><spring:message code="STUDENT.PARENT.DONATION.VALUE" />
								</th>
								<th width="42" class="right"><sec:authorize
										access="hasAnyRole('Add/Edit Donation')">
										<img src="resources/images/ico_new.gif" class="icon_new"
											onClick="clearMessages();addNew(this)" width="18" height="20"
											title="<spring:message code='STUDENT.PARENT.DONATION.ADD.NEW.DONATION' />" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
									</sec:authorize>
								</th>
							</tr>
							<c:set var="selectedDonationId" value="${ parentWrapper.donation.donationId}"></c:set>
							<c:forEach var="donation" items="${donationList}"
								varStatus="status">
								<tr
									<c:choose>
	            						<c:when test="${displayPanel && donation.donationId == selectedDonationId}">
	            								class="highlight"
	            						</c:when>
	            						<c:when test="${(status.count) % 2 == 0}">
	            								class="odd"
	            						</c:when>
	            						<c:otherwise>
	            								class="even"
	            						</c:otherwise>
            						</c:choose>
            					>
									<td><c:out value="${donation.purpose}"></c:out></td>

									<td><c:out value="${donation.amount}"></c:out></td>
									<td nowrap class="right"><sec:authorize
											access="hasAnyRole('Add/Edit Donation')">
											<img src="resources/images/ico_edit.gif"
												title="<spring:message code='STUDENT.PARENT.DONATION.EDIT.DONATION' />"
												onClick="clearMessages();editDonation(this,'<c:out value="${donation.donationId}"/>', '<c:out value="${donation.purpose}"/>',
              		'<c:out value="${donation.amount}"/>', '<c:out value="${donation.date}"/>', '<c:out value="${donation.donationType.donationTypeId}"/>');"
												width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
											<img src="resources/images/ico_delete.gif"
												onClick="clearMessages();document.form.donationId.value='${donation.donationId}'; deleteDonation(this)"
												title="<spring:message code='REF.UI.DELETE' />" width="18" height="20" class="icon" <c:if test="${student.statusId != 1}">style="display:none;"</c:if>>
										</sec:authorize>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>


					<spring:bind path="parentWrapper.donation.*">
						<c:set var="status" value="${status}"></c:set>
					</spring:bind>

					<div class="section_full_inside"
						style="display: ${displayPanel != null && displayPanel ?'block':'none'};">

					<h3>
						<spring:message code="STUDENT.PARENT.DONATION.ADD.NEW.DONATION" />
					</h3>
					<div class="box_border">
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><span class="required_sign">*</span>
									<spring:message code="STUDENT.PARENT.DONATION.PURPOSE.TITLE" />
									</label>
								</div>
								<form:hidden path="donation.donationId" id="donationId" />
								<form:input path="donation.purpose" id="purpose" maxlength="45" />
							</div>

							<div class="float_right" style="margin-right: 250px;">
								<div class="lbl_lock ">
									<label><span class="required_sign">*</span>
									<spring:message code="STUDENT.PARENT.DONATION.DATE" /> </label>
								</div>
								<form:input path="donation.date" id="datedDonation"
									cssClass="date_field" readonly="true" />
							</div>
						</div>
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><span class="required_sign">*</span>
									<spring:message code="STUDENT.PARENT.DONATION.AMOUNT" /> </label>
								</div>
								<form:input path="donation.amount" id="amount" maxlength="45"/>
							</div>

						</div>
						<div class="row">
						<div class="float_left" style="margin-right: 201px;">
								<div class="lbl_lock">
									<label><span class="required_sign">*</span>
									<spring:message code="STUDENT.PARENT.DONATION.TYPE" /> </label>
								</div>
								<c:forEach var="d" items="${donationTypeList}">
									<form:radiobutton path="donation.donationType.donationTypeId"
										id="donationTypeId" cssClass="radio_btn"
										value="${d.donationTypeId}" label="${d.description}" />
								</c:forEach>
							</div>
						</div>

						<div class="row">
							<div class="buttion_bar_type1">
								<sec:authorize access="hasRole('Add/Edit Donation')">
									<input type="button" value='<spring:message code="REF.UI.SAVE" />'
										onClick="saveOrUpdateDonation(this)" class="button">
								</sec:authorize>

								<input type="button" class="button"
									onClick="clearMessages();setAddEditPane(this,'Cancel')" value="<spring:message code='REF.UI.CANCEL'/>">
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="clearfix"></div>
			</form:form>
		</div>


	</div>
	</div>
	</div>
	<h:footer />
</body>
</html>
