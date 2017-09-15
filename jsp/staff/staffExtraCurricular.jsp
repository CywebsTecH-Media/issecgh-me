<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>

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
<script language="javascript" src="resources/js/main.js"></script>
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	
	//Limit the text area input.
	function limitText(limitField, limitNum) {
		
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} 
	}
	
	

	
	function hideErrorSection(){
		
		 $(document).ready(function() {
		$("#clubSocietyError").hide();
			$("#sportsError").hide();
			$("#externalActivityError").hide();
			$("#seminarError").hide();
			});
	}
	function hideSection(thisObj){
		 $(document).ready(function() {
		var elementWraper = $(thisObj).closest('.section_box');
		 $("tr").removeClass('highlight');
		 $(".section_full_inside").hide();
		 $(elementWraper).find('.section_full_inside').show();
		 });
	}
	// Remove highLight color from row.
	function hideHighLight(csMsg,sportMsg,extraMsg,seminarMsg){
		
		if((csMsg == '') && (sportMsg == '') && (extraMsg == '') && (seminarMsg == '')) {
			$("tr").removeClass('highlight');
		}

	}
	
	</script>
</head>
<body
	onload="hideHighLight('<c:out value="${ClubSocietyMessage}"/>','<c:out value="${SportMessage}"/>','<c:out value="${ExternalActivityMessage}"/>','<c:out value="${SeminarMessage}"/>')">
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currentYear" value="${now}" pattern="yyyy" />

<h:headerNew parentTabId="2" page="staffExtraCurricular.htm" />

<div id="page_container">

<div id="breadcrumb_area">
<div id="breadcrumb">
<ul>
	<li><a href="adminWelcome.htm"><spring:message
		code="application.home" /></a>&nbsp;&gt;&nbsp;</li>
	<sec:authorize access="hasRole('Search Staff Members')">
		<li><a href="staffSearch.htm"><spring:message
			code="STAFF.STAFF_EXTRA_CURRICU.STAFF_SEARCH" /></a>&nbsp;&gt;&nbsp;</li>
	</sec:authorize>
	<li><spring:message code="STAFF.STAFF_EXTRA_CURRICU" /></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/staffExtraCurricularHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"> <spring:message code="application.help" /></a></div>
</div>
<div class="clearfix"></div>
<h1><spring:message code="STAFF.STAFF_EXTRA_CURRICU" /></h1>
<div id="content_main">
<div class="section_full_summary">
<div class="box_border">
<div class="float_left"><label><spring:message
	code="STAFF.STAFF_EXTRA_CURRICU.NAME" />:&nbsp;</label>
${staff.nameWithIntials}</div>
<div class="float_left"><label><spring:message
	code="STAFF.STAFF_EXTRA_CURRICU.REG_NO" />:&nbsp;</label>
${staff.registrationNo}</div>
<div class="float_left"></div>
<div class="clearfix"></div>
</div>
</div>

<form action="staffExtraCurricular.htm" name="SelectedYear">
<div class="section_full">
	<div>
		<c:if test="${assginMessage != null}">
			<div>
				<label class="success_sign">${assginMessage}</label>
			</div>	
		</c:if>
	</div>
<div class="row"><label><strong><spring:message
	code="STAFF.STAFF_EXTRA_CURRICU.SELECT_YEAR" />:</strong></label> <select
	name="selectedYear" id="selectedYear"
	onchange="populateDataForSelectedYear(this)">
	<c:forEach items="${yearList}" var="year">
		<c:choose>
			<c:when test="${year == selectedYear}">
				<option selected="selected" value="${year}">${year}</option>
			</c:when>
			<c:otherwise>
				<option value="${year}">${year}</option>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</select></div>
</div>
<div class="clearfix"></div>
</form>
<!---------------------------- Start Clubs &amp; Societies section --------------------------------------------->

<form:form commandName="staffClubSociety" name="StaffClubSociety"
	method="POST" action="">

	<form:hidden path="staffClubSocietyId" />
	<input type="hidden" name="selectedYear" />

	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.CLUBS_AND_SOCIT" /></h2>
	</div>
	<label id="clubSocietyError" class="required_sign"> <c:if
		test="${ClubSocietyMessage != null }">
				${ClubSocietyMessage}
			</c:if> </label>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.CLUB_OR_SOCIETY" /></th>
			<th width="30%"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.POSITION" /></th>
			<th width="42" class="right"><c:if
				test="${departureDate == null}">
				<c:if test="${selectedYear eq currentYear}">
					<sec:authorize
						access="hasAnyRole('Add/Edit Staff Extra Curricular')">
							<img src="resources/images/ico_new.gif" class="icon_new"
								onClick="adNewStaffClubSociety(this),hideErrorSection(),hideSection(this);"
								width="18" height="20"
								title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.ADD_NEW_CS'/>">
					</sec:authorize>
				</c:if>
			</c:if></th>
		</tr>
		<c:choose>
			<c:when test="${not empty staffClubSocieties}">
				<c:forEach items="${staffClubSocieties}" var="staffClubSocietyData"
					varStatus="status">

					<c:set var="cssClass"
						value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />

					<c:if
						test="${((staffClubSociety != null) && (staffClubSociety.staffClubSocietyId gt 0)
					 		&& (staffClubSocietyData[0] eq staffClubSociety.staffClubSocietyId))}">
						<c:set var="cssClass" value="${cssClass} highlight" />
					</c:if>

					<tr class="${cssClass}">

						<td>${staffClubSocietyData[3]}</td>
						<td>${staffClubSocietyData[4]}</td>
						<td nowrap class="right"><c:if
							test="${departureDate == null}">
							<c:if test="${selectedYear eq currentYear}">
								<sec:authorize
									access="hasAnyRole('Add/Edit Staff Extra Curricular')">
										<img src="resources/images/ico_edit.gif"
											onClick="hideSection(this),updateStaffClubSociety(this,${staffClubSocietyData[0]},${staffClubSocietyData[1]},${staffClubSocietyData[2]}),hideErrorSection();"
											title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.EDIT_CS'/>"
											width="18" height="20" class="icon">
								</sec:authorize>
								<sec:authorize
									access="hasAnyRole('Delete Staff Extra Curricular')">
										<img src="resources/images/ico_delete.gif"
											onClick="hideErrorSection(),hideSection(this),deleteStaffClubSociety(this,${staffClubSocietyData[0]});"
											title="<spring:message code='REF.UI.DELETE'/>" width="18"
											height="20" class="icon">
								</sec:authorize>
							</c:if>
						</c:if></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td>
					<h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5>
					</td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	<div class="section_full_inside"
		style="display: ${not empty ClubSocietyMessage?'block':'none'}">
	<h3><spring:message code="${isEdit? 'STAFF.STAFF_EXTRA_CURRICU.EDIT_CS' : 'STAFF.STAFF_EXTRA_CURRICU.ADD_NEW_CS'}" /></h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.CLUB_OR_SOCIETY" />:</label></div>
	<form:select path="clubSocietyId">
		<option value="0"><spring:message
			code="application.drop.down" /></option>
		<form:options items="${clubSocietyList}" itemValue="clubSocietyId"
			itemLabel="name" />
	</form:select></div>
	<div class="float_right">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.POSITION" />:</label></div>
	<form:select path="positionId">
		<option value="0"><spring:message
			code="application.drop.down" /></option>
		<form:options items="${positionList}" itemValue="positionId"
			itemLabel="description" />
	</form:select></div>
	</div>
	<div class="row">
	<div class="buttion_bar_type1">
	<c:if test="${selectedYear eq currentYear}">
		<sec:authorize
			access="hasAnyRole('Add/Edit Staff Extra Curricular')">
				<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
					onClick="saveStaffClubSociety(this);" class="button">
				<input type="button" class="button"
					onClick="hideErrorSection(),hideSection(this),setAddEditPane(this,'Cancel');"
					value="<spring:message code='REF.UI.CANCEL'/>">
		</sec:authorize>
	</c:if></div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
</form:form> 

<!-- End Clubs &amp; Societies section --> 

<!-- Start Sports section -->
<form:form commandName="staffSport" name="StaffSport" method="POST"
	action="">

	<form:hidden path="staffSportId" />
	<input type="hidden" name="selectedYear" />

	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message code="STAFF.STAFF_EXTRA_CURRICU.SPORTS" /></h2></div>
	<label id="sportsError" class="required_sign"> <c:if
		test="${SportMessage != null }">
				${SportMessage}
			</c:if> </label>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th><spring:message code="STAFF.STAFF_EXTRA_CURRICU.SPORT" /></th>
			<th><spring:message code="STAFF.STAFF_EXTRA_CURRICU.TEAM" /></th>
			<th width="25%"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.POSITION" /></th>
			<th width="30%"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.DESCRIPTION" /></th>
			<th width="42" class="right">
			<c:if test="${departureDate == null}">
				<c:if test="${selectedYear eq currentYear}">
					<sec:authorize
						access="hasAnyRole('Add/Edit Staff Extra Curricular')">				
						<img src="resources/images/ico_new.gif" class="icon_new"
							onClick="adNewStaffSport(this),hideErrorSection(),hideSection(this);"
							width="18" height="20"
							title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.ADD_NEW_SPORT'/>">
					</sec:authorize>
				</c:if>
			</c:if></th>

		</tr>
		<c:choose>
			<c:when test="${not empty staffSports}">
				<c:forEach items="${staffSports}" var="staffSportData"
					varStatus="status">

					<c:set var="cssClass"
						value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />

					<c:if
						test="${((staffSport != null) && (staffSport.staffSportId gt 0)
					 		&& (staffSportData[0] eq staffSport.staffSportId))}">
						<c:set var="cssClass" value="${cssClass} highlight" />
					</c:if>

					<tr class="${cssClass}">

						<td>${staffSportData[1]}</td>
						<td>${staffSportData[2]}</td>
						<td>${staffSportData[3]}</td>
						<td>${staffSportData[4]}</td>
						<td nowrap class="right"><c:if
							test="${departureDate == null}">
							<c:if test="${selectedYear eq currentYear}">
								<sec:authorize
									access="hasAnyRole('Add/Edit Staff Extra Curricular')">
									<img src="resources/images/ico_edit.gif"
										onClick="hideSection(this),updateStaffSport(this,${staffSportData[0]},${staffSportData[6]},'<c:out value="${strEscapeUtil:escapeJS(staffSportData[4])}" />',${staffSportData[5]}),hideErrorSection();"
										title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.EDIT_SPORT'/>"
										width="18" height="20" class="icon">
								</sec:authorize>
								<sec:authorize
									access="hasAnyRole('Delete Staff Extra Curricular')">
									<img src="resources/images/ico_delete.gif"
										onClick="hideErrorSection(),hideSection(this),deleteStaffSport(this,${staffSportData[0]});"
										title="<spring:message code='REF.UI.DELETE'/>" width="18"
										height="20" class="icon">
								
								</sec:authorize>
							</c:if>
						</c:if></td>

					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td>
					<h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	<div class="section_full_inside"
		style="display: ${not empty SportMessage?'block':'none'}">
	<h3><spring:message code="${isEdit? 'STAFF.STAFF_EXTRA_CURRICU.EDIT_SPORT' : 'STAFF.STAFF_EXTRA_CURRICU.ADD_NEW_SPORT'}" />
	</h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.SPORT_CATEGORY" />:</label></div>
	<form:select path="sportCategoryId">
		<option value="0"><spring:message
			code="application.drop.down" /></option>
		<c:forEach items="${sportCategoriesList}" var="sportCategory">
			<form:option value="${sportCategory.sportCategoryId}">${sportCategory.sport.description} - ${sportCategory.sportSubCategory.description}</form:option>
		</c:forEach>
	</form:select></div>
	<div class="float_right">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.POSITION" />:</label></div>
	<form:select path="positionId">
		<option value="0"><spring:message
			code="application.drop.down" /></option>
		<form:options items="${positionList}" itemValue="positionId"
			itemLabel="description" />
	</form:select></div>
	</div>
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.DESCRIPTION" />:</label></div>
	<form:textarea path="description" id="sportDescription" rows="2"
		onkeydown="limitText(this.form.sportDescription,200);"
		onkeyup="limitText(this.form.sportDescription,200);" /></div>
	</div>

	<div class="row">
	<div class="buttion_bar_type1">
	<c:if test="${selectedYear eq currentYear}">
		<sec:authorize
			access="hasAnyRole('Add/Edit Staff Extra Curricular')">
			<input type="button" class="button" onClick="saveStaffSport(this)"
				value="<spring:message code='REF.UI.SAVE'/>">
			<input type="button" class="button"
				onClick="hideErrorSection(),hideSection(this),setAddEditPane(this,'Cancel');"
				value="<spring:message code='REF.UI.CANCEL'/>">
		</sec:authorize>
	</c:if>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	
	<div class="clearfix"></div>
	</div>
</form:form> 
<!-- End Sports section -->







 <!-- Start External Activities/Achievements section -->
<form:form commandName="staffExternalActivity"
	name="StaffExternalActivity" method="POST" action="">

	<form:hidden path="staffExternalActivityId" />
	<input type="hidden" name="selectedYear" />

	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.EXTERNAL_ACTI_ACHI" /></h2>
	</div>
	<label id="externalActivityError" class="required_sign"><c:if
		test="${ExternalActivityMessage != null }">
				${ExternalActivityMessage}
			</c:if>
				
			 </label>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th width="235"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.EXTERNAL_ACTIVITY" /></th>
			<th width="60"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.ACHIEVEMENT" /></th>
			<th width="42" class="right">
			<c:if test="${departureDate == null}">
				<c:if test="${selectedYear eq currentYear}">
					<sec:authorize
						access="hasAnyRole('Add/Edit Staff Extra Curricular')">
						<img src="resources/images/ico_new.gif" class="icon_new"
							onClick="addNewStaffExternalActivity(this),hideErrorSection(),hideSection(this);"
							width="18" height="20"
							title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.ADD_EXTERNAL_AA'/>">
					</sec:authorize>
				</c:if>
			</c:if></th>

		</tr>
		<c:choose>
			<c:when test="${not empty staffExternalActivities}">
				<c:forEach items="${staffExternalActivities}"
					var="staffExternalActivityData" varStatus="status">
					<c:set var="cssClass"
						value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />

					<c:if
						test="${((staffExternalActivity != null) && (staffExternalActivity.staffExternalActivityId gt 0)
					 		&& (staffExternalActivityData.staffExternalActivityId eq staffExternalActivity.staffExternalActivityId))}">
						<c:set var="cssClass" value="${cssClass} highlight" />
					</c:if>

					<tr class="${cssClass}">

						<td>${staffExternalActivityData.externalActivity}</td>
						<td>${staffExternalActivityData.achievement}</td>
						<td nowrap class="right"><c:if
							test="${departureDate == null}">
							<c:if test="${selectedYear eq currentYear}">
								<sec:authorize
									access="hasAnyRole('Add/Edit Staff Extra Curricular')">
									<img src="resources/images/ico_edit.gif"
										onClick="hideSection(this),updateStaffExternalActivity(this, '<c:out value="${strEscapeUtil:escapeJS(staffExternalActivityData.externalActivity)}"/>', '<c:out value="${strEscapeUtil:escapeJS(staffExternalActivityData.achievement)}"/>',${staffExternalActivityData.staffExternalActivityId}),hideErrorSection();"
										title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.EDIT_EXTERNAL_AA'/>"
										width="18" height="20" class="icon">
								</sec:authorize>
								<sec:authorize
									access="hasAnyRole('Delete Staff Extra Curricular')">
									<img src="resources/images/ico_delete.gif"
										onClick="hideErrorSection(),hideSection(this),deleteStaffExternalActivity(this,${staffExternalActivityData.staffExternalActivityId});"
										title="<spring:message code='REF.UI.DELETE'/>" width="18"
										height="20" class="icon">
								</sec:authorize>
							</c:if>
						</c:if></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td>
					<h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5>
					</td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	<div class="section_full_inside"
		style="display: ${not empty ExternalActivityMessage?'block':'none'}">
	<h3><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.ADD_EXTERNAL_AA" /></h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.EXTERNAL_ACTIVITY" />:</label></div>
	<form:input path="externalActivity" maxlength="250" /></div>
	<div class="float_right">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.ACHIEVEMENT" />:</label></div>
	<form:input path="achievement" maxlength="250" /></div>
	</div>
	<div class="row">
	<div class="buttion_bar_type1">
	<c:if test="${selectedYear eq currentYear}">
		<sec:authorize
			access="hasAnyRole('Add/Edit Staff Extra Curricular')">
			<input type="button" value="<spring:message code='REF.UI.SAVE'/>"
				onClick="saveStaffExternalActivity(this)" class="button">
			<input type="button" class="button"
				onClick="hideErrorSection(),hideSection(this),setAddEditPane(this,'Cancel');"
				value="<spring:message code='REF.UI.CANCEL'/>">
		</sec:authorize></c:if></div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
</form:form> <!-- End External Activities/Achievements section ----------------------------------------------------->








<!-- Start Seminars section ---------------------------------------------------------------->
<form:form commandName="staffSeminar" name="StaffSeminar" method="POST"
	action="">

	<form:hidden path="staffSeminarId" />
	<input type="hidden" name="selectedYear" />

	<div class="section_box">
	<div class="section_box_header">
	<h2><spring:message code="STAFF.STAFF_EXTRA_CURRICU.SEMINARS" /></h2>
	</div>
	<label id="seminarError" class="required_sign"> <c:if
		test="${SeminarMessage != null }">
				${SeminarMessage}
			</c:if> </label>
	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th width="235"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.SEMINAR" /></th>
			<th width="60"><spring:message
				code="STAFF.STAFF_EXTRA_CURRICU.DETAILS" /></th>
			<th width="42" class="right"><c:if
				test="${departureDate == null}">
				<c:if test="${selectedYear eq currentYear}">
					<sec:authorize
						access="hasAnyRole('Add/Edit Staff Extra Curricular')">
						<img src="resources/images/ico_new.gif" class="icon_new"
							onClick="adNewStaffSeminar(this),hideErrorSection(),hideSection(this);"
							width="18" height="20"
							title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.ADD_SEMINAR'/>">
					</sec:authorize>
				</c:if>
			</c:if></th>

		</tr>
		<c:choose>
			<c:when test="${not empty staffSeminars}">
				<c:forEach items="${staffSeminars}" var="staffSeminarData"
					varStatus="status">
					<c:set var="cssClass"
						value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />

					<c:if
						test="${((staffSeminar != null) && (staffSeminar.staffSeminarId gt 0)
					 		&& (staffSeminarData[0] eq staffSeminar.staffSeminarId))}">
						<c:set var="cssClass" value="${cssClass} highlight" />
					</c:if>

					<tr class="${cssClass}">

						<td>${staffSeminarData[2]}</td>
						<td>${staffSeminarData[3]}</td>
						<td nowrap class="right"><c:if
							test="${departureDate == null}">
							<c:if test="${selectedYear eq currentYear}">
								<sec:authorize
									access="hasAnyRole('Add/Edit Staff Extra Curricular')">
									<img src="resources/images/ico_edit.gif"
										onClick="hideSection(this),updateStaffSeminar(this, ${staffSeminarData[0]}, '${staffSeminarData[1]}','<c:out value="${strEscapeUtil:escapeJS(staffSeminarData[3])}"/>'),hideErrorSection();"
										title="<spring:message code='STAFF.STAFF_EXTRA_CURRICU.EDIT_SEMINAR'/>"
										width="18" height="20" class="icon">
								</sec:authorize>
								<sec:authorize
									access="hasAnyRole('Delete Staff Extra Curricular')">
									<img src="resources/images/ico_delete.gif"
										onClick="hideErrorSection(),hideSection(this),deleteStaffSeminar(this,${staffSeminarData[0]});"
										title="<spring:message code='REF.UI.DELETE'/>" width="18"
										height="20" class="icon">
								</sec:authorize>
							</c:if>
						</c:if></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td>
					<h5><spring:message code="APPLICATION.NORECORDSFOUND" /></h5>
					</td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	<div class="section_full_inside"
		style="display: ${not empty SeminarMessage?'block':'none'}">
	<h3><spring:message code="STAFF.STAFF_EXTRA_CURRICU.ADD_SEMINAR" /></h3>
	<div class="box_border">
	<div class="row">
	<div class="float_left">
	<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.SEMINAR" />:</label></div>
	<form:select path="seminarId">
		<option value="0"><spring:message
			code="application.drop.down" /></option>
		<form:options items="${seminarList}" itemValue="seminarId"
			itemLabel="description" />
	</form:select></div>
	<div class="float_right">
	<div class="lbl_lock"><label><spring:message
		code="STAFF.STAFF_EXTRA_CURRICU.DETAILS" />:</label></div>
	<form:textarea path="description" id="seminarDescription" rows="2"
		onkeydown="limitText(this.form.seminarDescription,200);"
		onkeyup="limitText(this.form.seminarDescription,200);" /></div>
	</div>
	<div class="row">
	<div class="buttion_bar_type1">
	<c:if test="${selectedYear eq currentYear}">
		<sec:authorize
			access="hasAnyRole('Add/Edit Staff Extra Curricular')">
			<input type="button" value='<spring:message code="REF.UI.SAVE"/>'
				onClick="saveStaffSeminar(this);" class="button">
			<input type="button" class="button"
				onClick="hideErrorSection(),hideSection(this),setAddEditPane(this,'Cancel');"
				value='<spring:message code="REF.UI.CANCEL"/>'>
		</sec:authorize>
	</c:if>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
	</div>
	<div class="clearfix"></div>
	</div>
</form:form> <!-- End Seminars section ---------------------------------------></div>


</div>
<h:footer />
</body>

<script type="text/javascript">
	var selectedYear = document.getElementById("selectedYear").value;

	function populateDataForSelectedYear(thisValue) {
		document.SelectedYear.submit();
	}

	function adNewStaffClubSociety(thisValue) {
		
		setAddEditPane(thisValue,'Add');

		document.StaffClubSociety.staffClubSocietyId.value = 0;
		document.StaffClubSociety.clubSocietyId.value = 0;
		document.StaffClubSociety.positionId.value = 0;

	}

	function saveStaffClubSociety(thisValue) {
		setAddEditPane(thisValue,'Save');

		document.StaffClubSociety.selectedYear.value = selectedYear;
		document.StaffClubSociety.action = "saveOrUpdateStaffClubSociety.htm";
		document.StaffClubSociety.submit();
	}

	function updateStaffClubSociety(thisValue, staffClubSocietyId, clubSocietyId, positonId) {
		setAddEditPane(thisValue,'Edit');

		document.StaffClubSociety.selectedYear.value = selectedYear;
		document.StaffClubSociety.staffClubSocietyId.value = staffClubSocietyId;
		document.StaffClubSociety.clubSocietyId.value = clubSocietyId;
		document.StaffClubSociety.positionId.value = positonId;

	}

	function deleteStaffClubSociety(thisValue, staffClubSocietyId) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.StaffClubSociety.staffClubSocietyId.value = staffClubSocietyId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.StaffClubSociety.selectedYear.value = selectedYear;
			document.StaffClubSociety.action = "deleteStaffClubSociety.htm";
			document.StaffClubSociety.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
		/* var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>');

		if (ans) {
			$(thisValue).parents('tr').hide();
			document.StaffClubSociety.selectedYear.value = selectedYear;
			document.StaffClubSociety.action = "deleteStaffClubSociety.htm";
			document.StaffClubSociety.submit();
		} else {
			$(thisValue).parents('tr').removeClass('highlight');
		} */
	}

	function addNewStaffExternalActivity(thisValue) {
		setAddEditPane(thisValue,'Add');

		document.StaffExternalActivity.staffExternalActivityId.value = 0;
		document.StaffExternalActivity.externalActivity.value = '';
		document.StaffExternalActivity.achievement.value = '';
	}

	function saveStaffExternalActivity(thisValue) {
		setAddEditPane(thisValue,'Save');

		document.StaffExternalActivity.selectedYear.value = selectedYear;
		document.StaffExternalActivity.action = "saveOrUpdateStaffExternalActivity.htm";
		document.StaffExternalActivity.submit();
	}

	function updateStaffExternalActivity(thisValue, externalActivity, achievement, staffExternalActivityId) {
		setAddEditPane(thisValue,'Edit');

		document.StaffExternalActivity.selectedYear.value = selectedYear;
		document.StaffExternalActivity.staffExternalActivityId.value = staffExternalActivityId;
		document.StaffExternalActivity.externalActivity.value = externalActivity;
		document.StaffExternalActivity.achievement.value = achievement;
	}

	function deleteStaffExternalActivity(thisValue, staffExternalActivityId) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.StaffExternalActivity.staffExternalActivityId.value = staffExternalActivityId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.StaffExternalActivity.selectedYear.value = selectedYear;
			document.StaffExternalActivity.action = "deleteStaffExternalActivity.htm";
			document.StaffExternalActivity.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
		/* var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>');

		if (ans) {
			$(thisValue).parents('tr').hide();
			document.StaffExternalActivity.selectedYear.value = selectedYear;
			document.StaffExternalActivity.action = "deleteStaffExternalActivity.htm";
			document.StaffExternalActivity.submit();
		} else {
			$(thisValue).parents('tr').removeClass('highlight');
		} */
	}

	function adNewStaffSeminar(thisValue) {
		setAddEditPane(thisValue,'Add');

		document.StaffSeminar.staffSeminarId.value = 0;
		document.StaffSeminar.description.value = '';
		document.StaffSeminar.seminarId.value = 0;

	}

	function saveStaffSeminar(thisValue) {
		setAddEditPane(thisValue,'Save');

		document.StaffSeminar.selectedYear.value = selectedYear;
		document.StaffSeminar.action = "saveOrUpdateStaffSeminar.htm";
		document.StaffSeminar.submit();
	}

	function updateStaffSeminar(thisValue, staffSeminarId, seminarId, description){
		setAddEditPane(thisValue,'Edit');

		document.StaffSeminar.selectedYear.value = selectedYear;
		document.StaffSeminar.staffSeminarId.value = staffSeminarId;
		document.StaffSeminar.seminarId.value = seminarId;
		document.StaffSeminar.description.value = description;

	}

	function deleteStaffSeminar(thisValue, staffSeminarId) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.StaffSeminar.staffSeminarId.value = staffSeminarId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.StaffSeminar.selectedYear.value = selectedYear;
			document.StaffSeminar.action = "deleteStaffSeminar.htm";
			document.StaffSeminar.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
		/* var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>');

		if (ans) {
			$(thisValue).parents('tr').hide();
			document.StaffSeminar.selectedYear.value = selectedYear;
			document.StaffSeminar.action = "deleteStaffSeminar.htm";
			document.StaffSeminar.submit();
		} else {
			$(thisValue).parents('tr').removeClass('highlight');
		} */
	}

	function adNewStaffSport(thisValue) {
		setAddEditPane(thisValue,'Add');

		document.StaffSport.staffSportId.value = 0;
		document.StaffSport.sportCategoryId.value = 0;
		document.StaffSport.positionId.value = 0;
		document.StaffSport.description.value = '';
	}

	function saveStaffSport(thisValue) {
		setAddEditPane(thisValue,'Save');

		document.StaffSport.selectedYear.value = selectedYear;
		document.StaffSport.action = "saveOrUpdateStaffSport.htm";
		document.StaffSport.submit();
	}

	function updateStaffSport(thisValue, staffSportId, sportCategoryId, description, positonId) {
		setAddEditPane(thisValue,'Edit');

		document.StaffSport.selectedYear.value = selectedYear;
		document.StaffSport.staffSportId.value = staffSportId;
		document.StaffSport.sportCategoryId.value = sportCategoryId;
		document.StaffSport.positionId.value = positonId;
		document.StaffSport.description.value = description;
	}

	function deleteStaffSport(thisValue, staffSportId) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.StaffSport.staffSportId.value = staffSportId;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.StaffSport.selectedYear.value = selectedYear;
			document.StaffSport.action = "deleteStaffSport.htm";
			document.StaffSport.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
		
		/* var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>');

		if (ans) {
			$(thisValue).parents('tr').hide();
			document.StaffSport.selectedYear.value = selectedYear;
			document.StaffSport.action = "deleteStaffSport.htm";
			document.StaffSport.submit();
		} else {
			$(thisValue).parents('tr').removeClass('highlight');
		} */
	}
</script>

</html>
