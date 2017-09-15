
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
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
<!-- msdropdown -->
<link rel="stylesheet" type="text/css" href="resources/css/dd.css" />
<script src="resources/js/jquery.dd.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/skin2.css" />
<link rel="stylesheet" type="text/css" href="resources/css/flags.css" />

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>


<script>
$(document).ready(function(e) {		
	//no use
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
	$("#contactSchoolPhone").msDropdown();
	$("#contactSchoolPhoneEdit").msDropdown();
	$("#contactSchoolFax").msDropdown();
	$("#contactSchoolFaxEdit").msDropdown();

});
function showValue(h) {
	console.log(h.name, h.value);
}
$("#tech").change(function() {
	console.log("by jquery: ", this.value);
})


function selectCountry(selectedPhoneCountry,selectedFaxCountry) {
	if(selectedPhoneCountry != null && selectedPhoneCountry != ""){
		$('#contactSchoolPhone').msDropDown().data('dd').set('value',selectedPhoneCountry);
	}
	
	if(selectedFaxCountry != null && selectedFaxCountry != ""){
		$('#contactSchoolFax').msDropDown().data('dd').set('value',selectedFaxCountry);
	}
}

</script>
<!-- msdropdown> -->
<script>

		$(function() {
		$( "#StartedDate" ).datepicker({
			changeYear: true,
			changeMonth: true,
			dateFormat: 'yy-mm-dd',
			yearRange:"c-50:c+50",
			maxDate : new Date(),
			showOn: "button",
			buttonImage: "resources/images/calendar.jpg",
			buttonImageOnly: true
		});
	});

		function check() {

			if(isNaN(document.form.noOfStaff.value)) {
				return false;
				}

			}

		function cancel() {
			
			var okfunction = function(){
				document.form.action='welcome.htm';
				document.form.submit();
			};
			
			var cancelfunction = function(){};
			
			var message = '<spring:message code="SCHOOL.EXIT.CONFIRMATION" />';
			
			confirm_function(message, okfunction, cancelfunction);
		}
		
		//Limit the text area input.
		function limitText(limitField, limitCount, limitNum) {
			if (limitField.value.length > limitNum) {
				limitField.value = limitField.value.substring(0, limitNum);
			} else {
				limitCount.value = limitNum - limitField.value.length;
			}
		}
	</script>
<!-- END Calender controll CSS and JS -->

</head>
<body onload="<c:if test="${school != null}">selectCountry('<c:out value="${selectedPhoneCountry}" />','<c:out value="${selectedFaxCountry}" />');</c:if>">
<h:headerNew parentTabId="27" page="schoolDetail.htm" />
<div id="page_container">
<div id="breadcrumb_area">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message
		code="application.home" /></a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="REF.UI.SCHOOL.DETAILS" /></li>
</ul>
</div>
<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/schoolDetailsHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"><spring:message code="REF.UI.HELP" /></a>
			</div>
<div class="clearfix"></div>
<h1><spring:message code="REF.UI.SCHOOL.DETAILS" /></h1>
<div id="content_main"><form:form action=""
	method="post" commandName="school" name="form">
	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message code="REF.UI.SCHOOL.GENERAL_INFORMATION" /></h2>
	</div>
	
	
	<div><c:if test="${message != null}">
		<div><label class="success_sign">${message}</label></div>
	</c:if>
	<label class="required_sign"> <c:if test="${modelError != null}"> ${modelError}</c:if>
	</label>
	<label class="success_sign"><form:errors path="*" cssClass="required_sign" /></label>
	</div>
	
	
	
	<div class="column_equal"><c:choose>
		<c:when test="${editSchool != null}">
			<input type="hidden" name="schoolId" maxlength="45"
				value="${editSchool.schoolId}" />
		</c:when>
		<c:otherwise>
			<form:hidden path="schoolId" />
		</c:otherwise>
	</c:choose>
	<div class="row">
	<div class="frmlabel">
		<span class="required_sign">*</span><spring:message code="REF.UI.SCHOOL_NAME" />
	</div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<input name="name" value="${editSchool.name}" maxlength="45" />
		</c:when>
		<c:otherwise>
			<form:input path="name" maxlength="45" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.ADDRESS" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<input name="address" value="${editSchool.address}" maxlength="45" />
		</c:when>
		<c:otherwise>
			<form:input path="address" maxlength="45" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.EMAIL_ADDRESS" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<input name="email" value="${editSchool.email}" maxlength="45" />
		</c:when>
		<c:otherwise>
			<form:input path="email" maxlength="45" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.CONTACT_NO" /></label></div>
	<div class="frmvalue" style="line-height: 12px;"><c:choose>
		<c:when test="${editSchool != null}">
			<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodePhone" id="contactSchoolPhone">
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
			<input name="contactNo" value="${editSchool.contactNo}"
				maxlength="12"  class="phoneNo_text"/>
		</c:when>
		<c:otherwise>
		<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodePhone" id="contactSchoolPhone">
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
			<form:input path="contactNo" maxlength="12"  class="phoneNo_text" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.FAX_NO" /></label></div>
	<div class="frmvalue" style="line-height: 12px;"><c:choose>
		<c:when test="${editSchool != null}">
			<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeFax" id="contactSchoolFax">
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
			<input name="faxNo" value="${editSchool.faxNo}" maxlength="12"  class="phoneNo_text" />
		</c:when>
		<c:otherwise>
		<select onchange="test(this.value)" style="width:130px" name="selectedCountryCodeFax" id="contactSchoolFax">
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
			<form:input path="faxNo" maxlength="12"  class="phoneNo_text" />
		</c:otherwise>
	</c:choose></div>
	</div>


	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.WEB_SITE" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<input name="website" value="${editSchool.website}" maxlength="45" />
		</c:when>
		<c:otherwise>
			<form:input path="website" maxlength="45" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.SCHOOL.STARTED_DATE" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<input name="startedDate" value="${editSchool.startedDate}"
				id="StartedDate" class="date_field" readonly="readonly" />
		</c:when>
		<c:otherwise>
			<form:input path="startedDate" id="StartedDate" cssClass="date_field"
				readonly="true" />
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.SCHOOL.COUNTRY" /></label></div>
	<div class="frmvalue"><label> <c:choose>
		<c:when test="${editSchool != null}">
			<select name="country.countryId" id="select">
				<c:forEach items="${countryList}" var="country">

					<option value="${country.countryId}"
						<c:if test="${(country.countryId)==(editSchool.country.countryId)}"> selected="selected" </c:if>>${country.countryName}
					</option>
				</c:forEach>

			</select>
		</c:when>
		<c:otherwise>
			<form:select path="country.countryId" id="select">
				<option value="0"><spring:message
					code="application.drop.down" /></option>
				<form:options itemLabel="countryName" items="${countryList}"
					itemValue="countryId" />
			</form:select>
		</c:otherwise>
	</c:choose> </label></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.PROVINCE" /></label></div>
	<div class="frmvalue"><label> <c:choose>
		<c:when test="${editSchool != null}">
			<select name="province.provinceId" id="select">
				<option value="0" ><spring:message code="application.drop.down"/></option>	
				<c:forEach items="${provinceList}" var="province">
					<option value="${province.provinceId}"
						<c:if test="${(province.provinceId)==(editSchool.province.provinceId)}"> selected="selected"  </c:if>>${province.description}
					</option>
				</c:forEach>

			</select>
		</c:when>
		<c:otherwise>
			<form:select path="province.provinceId" id="select">
				<option value="0"><spring:message
					code="application.drop.down" /></option>
				<form:options itemLabel="description" items="${provinceList}"
					itemValue="provinceId" />
			</form:select>
		</c:otherwise>
	</c:choose> </label></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.DISTRICT" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<select name="district.districtId" id="select">
				<option value="0" ><spring:message code="application.drop.down"/></option>
				<c:forEach items="${districtList}" var="district">
					<option value="${district.districtId}"
						<c:if test="${(district.districtId)==(editSchool.district.districtId)}"> selected="selected" </c:if>>${district.description}
					</option>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
			<form:select path="district.districtId" id="select">
				<option value="0"><spring:message
					code="application.drop.down" /></option>
				<form:options itemLabel="description" items="${districtList}"
					itemValue="districtId" />
			</form:select>
		</c:otherwise>
	</c:choose></div>
	</div>
	</div>
	<div class="column_equal">
	<div class="clearfix"></div>

	<div class="row">
	<div class="frmlabel"><span class="required_sign">*</span><label><spring:message
		code="REF.UI.SCHOOL.PRINCIPAL" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<select name="principalId" id="select">
				<option value="0"><spring:message code="application.drop.down" /></option>
				<%-- <option value="${editSchool.principalId}" selected="selected">${principal}</option> --%>
				<c:forEach items="${staffList}" var="staff">
					<c:if test="${staff.staffId != editSchool.principalId}">
						<option  value="${staff.staffId}" >${staff.nameWithIntials}</option>
					</c:if>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
			<form:select path="principalId" id="select">
				<option value="0"><spring:message
					code="application.drop.down" /></option>
				<form:options itemLabel="nameWithIntials" items="${staffList}"
					itemValue="staffId" />
			</form:select>
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.VICE_PRINCIPAL" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${(editSchool != null) && (editSchool.vicePrincipalId != null)}">
			<select name="vicePrincipalId" id="select">
				<option value=""><spring:message code="application.drop.down" /></option>
				<option value="${editSchool.vicePrincipalId}" selected="selected">${vicePrincipal}</option>
				<c:forEach items="${staffList}" var="staff">
					<c:if test="${staff.staffId != editSchool.vicePrincipalId}">
						<option label="${staff.nameWithIntials}" value="${staff.staffId}" >${staff.nameWithIntials}</option>
					</c:if>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
			<form:select path="vicePrincipalId" id="select">
				<option value=""><spring:message
					code="application.drop.down" /></option>
				<form:options itemLabel="nameWithIntials" items="${staffList}"
					itemValue="staffId" />
			</form:select>
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.NO_OF_STAFF" /></label></div>
	<div class="frmvalue"><c:out value="${school.noOfStaff}" /></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.STUDENT_INFO" /></label></div>
	<div class="frmvalue"><c:out value="${school.noOfStudents}" /></div>
	</div>
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.P_AND_S_SCHOOL_INFO" /></label></div>

	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<textarea name="primaryAndSecondarySchoolInfo" rows="3" cols="45"
				style="width: 290px;" 
				onkeydown="limitText(this.form.primaryAndSecondarySchoolInfo,this.form.countdown,250);"
				onkeyup="limitText(this.form.primaryAndSecondarySchoolInfo,this.form.countdown,250);">${editSchool.primaryAndSecondarySchoolInfo}</textarea>
		</c:when>
		<c:otherwise>
			<form:textarea path="primaryAndSecondarySchoolInfo" rows="3"
				cssStyle="width:290px; " onkeydown="limitText(this.form.primaryAndSecondarySchoolInfo,this.form.countdown,250);"
				onkeyup="limitText(this.form.primaryAndSecondarySchoolInfo,this.form.countdown,250);" />
		</c:otherwise>
	</c:choose></div>
	</div>
	
	<div class="row">
	<div class="frmlabel"><label><spring:message
		code="REF.UI.SCHOOL.FACILITIES_P_BY_THE_SCHOOL" /></label></div>
	<div class="frmvalue"><c:choose>
		<c:when test="${editSchool != null}">
			<textarea name="facilities" rows="3" cols="45" style="width: 290px;" onkeydown="limitText(this.form.facilities,this.form.countdown,250);"
				onkeyup="limitText(this.form.facilities,this.form.countdown,250);">${editSchool.facilities}</textarea>
		</c:when>
		<c:otherwise>
			<form:textarea path="facilities" rows="3" cssStyle="width:290px; "
				cols="45" onkeydown="limitText(this.form.facilities,this.form.countdown,250);"
				onkeyup="limitText(this.form.facilities,this.form.countdown,250);"/>
		</c:otherwise>
	</c:choose></div>
	</div>
	<div class="clearfix"></div>
	</div>
	<div class="clearfix"></div>
	</div>
	<div class="button_row">
	<div class="buttion_bar_type2"><input type="reset" value="<spring:message code='REF.UI.RESET' />"

		class="button" name="button" onclick="document.location.href='schoolDetail.htm'; " > 
		<sec:authorize access="hasRole('Edit School Details')">
		<input type="button" value="<spring:message code='REF.UI.SAVE' />" onclick="document.form.action='saveOrUpdateSchool.htm'; document.form.submit();" class="button"> 
		<input type="button" value="<spring:message code='REF.UI.CANCEL' />" class="button" name="button" onclick="cancel()">
		</sec:authorize>
	</div>
	<div class="clearfix"></div>
	</div>

</form:form></div>
</div>
</div>
<h:footer />
</body>
</html>
