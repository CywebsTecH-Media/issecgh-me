
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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>

<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">

<style type="text/css">
a.inactiveRef {
	cursor: default !important;
	color: #b8b8ba !important;
	text-decoration: none !important;
}
</style>

</head>
<body>
	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.REFERENCE" />
					</li>
				</ul>
			</div>
		</div>

		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('resources/html/akura-help/topics/admin/referenceModule.htm','helpWindow',780,550)">
				<img src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle" /> <spring:message code="application.help" /> </a>
		</div>

		<div class="clearfix"></div>

		<h1>
			<spring:message code="REF.UI.REFERENCE" />
		</h1>


		<div id="content_main">
			<div class="clearfix"></div>
			<div class="section_box">
				<div class="column_single reference_module">
					<div class="refBox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY1.TITLE" /> </span>
						<div class="reftopGap"></div>
						<div class="refInside">
							<div class="imgWrapper">
								<img src="resources/images/imgCommon.jpg" class="imgborder">
							</div>
							<div class="reftopGap"></div>
							<div class="topicbar">
								<spring:message code="REFERENCE.MAIN.CATEGORY1.SUB1.TITLE" />
							</div>
							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.CLASSES"/>"><a 
										href="manageClass.htm"
										<sec:authorize access="!hasRole('View Manage classes page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.MENU1" /> </a> <span
										class="required_sign">*</span></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.GRADES"/>"><a 
										href="manageGrade.htm"
										<sec:authorize	access="!hasRole('View Manage Grade')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.MENU2" /> </a><span
										class="required_sign">*</span>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.STREAMS"/>"><a
										href="manageStreams.htm"
										<sec:authorize access="!hasRole('View manage Study Stream')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.MENU3" /> </a><span
										class="required_sign">*</span>
									</li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SUBJECTS"/>"><a
										href="manageSubjects.htm"
										<sec:authorize access="!hasRole('View manage Subjects')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.MENU4" /> </a><span
										class="required_sign">*</span>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.GRADESUBJECTS"/>"><a
										href="manageSubjectGrade.htm"
										<sec:authorize
										access="!hasRole('View Manage Grade Subjects page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB1.MENU5" /> </a><span
										class="required_sign">*</span>
									</li>

								</ul>
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.RACE" />" />
									<a href="manageRace.htm"
										<sec:authorize access="!hasRole('View Race Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
											code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU1" /> </a>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SEMINAR"/>" />
									<a href="manageSeminar.htm"
										<sec:authorize access="!hasRole('View manage Seminars')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
											code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU2" /> </a>
									</li>



									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.CLUBS"/>"><a
										href="manageClubSociety.htm"
										<sec:authorize
										access="!hasRole('View Manage Club and Societies page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU3" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.POSITION"/>"><a
										href="managePosition.htm"
										<sec:authorize
										access="!hasRole('View Manage Membership positions page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU4" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SPORT"/>"><a
										href="manageSport.htm"
										<sec:authorize access="!hasRole('View Manage Sports')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU5" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SPORTSUB"/>"><a
										href="manageSportSub.htm"
										<sec:authorize access="!hasRole('View Manage Sport Subs')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU6" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SPORTCATEGORY"/>"><a
										href="manageSportCategory.htm"
										<sec:authorize
										access="!hasRole('View Manage Sports Categories')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU7" /> </a></li>

									<%-- <li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.COUNTRY"/>"><a
										href="manageCountry.htm"
										<sec:authorize access="!hasRole('View Manage Country page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU8" /> </a></li> --%>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.CITY"/>"><a
										href="manageCity.htm"
										<sec:authorize access="!hasRole('View Manage Cities page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU9" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.RELIGION"/>"><a
										href="manageReligion.htm"
										<sec:authorize access="!hasRole('View Religion Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY1.SUB1.SUB2.MENU10" /> </a></li>

								</ul>
							</div>

						</div>
					</div>


					<div class="refBox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY2.TITLE" /> </span>
						<div class="reftopGap"></div>

						<div class="refInside">
							<div class="imgWrapper">
								<img src="resources/images/refStudent.jpg" class="imgborder">
							</div>
							<div class="reftopGap"></div>
							<div class="topicbar">
								<spring:message code="REFERENCE.MAIN.CATEGORY2.SUB1.TITLE" />
							</div>
							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.STUDYMEDIUM"/>"><a
										href="manageStudyMediums.htm"
										<sec:authorize access="!hasRole('View Manage Study Medium')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB1.MENU1" /> </a>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.NATIONALITY"/>"><a
										href="manageNationality.htm"
										<sec:authorize access="!hasRole('View Nationality Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB1.MENU2" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.HOUSE"/>"><a
										href="manageHouse.htm"
										<sec:authorize access="!hasRole('View Manage House page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB1.MENU3" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.METHODOFTRAVEL"/>"><a
										href="manageMethodOfTravel.htm"
										<sec:authorize
										access="!hasRole('View Manage Method of Travel page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB1.MENU4" /> </a></li>

								</ul>
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB2.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.PREFECTTYPE"/>"><a
										href="managePrefectType.htm"
										<sec:authorize
										access="!hasRole('View Manage Prefect Type page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB2.MENU1" /> </a>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SCOLARSHIP"/>"><a
										href="manageScholarship.htm"
										<sec:authorize
										access="!hasRole('View Manage Scholarship page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB2.MENU2" /> </a></li>

								</ul>

								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB3.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.WARNINGLEVEL"/>"><a
										href="manageWarningLevel.htm"
										<sec:authorize access="!hasRole('View Warning Level Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB1.SUB3.MENU1" /> </a><span
										class="required_sign">*</span></li>

								</ul>
							</div>
							<div class="reftopGap"></div>
							<div class="reftopGap"></div>
							<div class="topicbar">
								<spring:message code="REFERENCE.MAIN.CATEGORY2.SUB2.TITLE" />
							</div>

							<div id="middleContent">
								<ul>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SPECIALEVENTS"/>"><a
										href="manageSpecialEvents.htm"
										<sec:authorize
										access="!hasRole('View Manage Special Events Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB2.MENU1" /> </a><span
										class="required_sign">*</span></li>

								</ul>
							</div>
							<div class="reftopGap"></div>
							<div class="reftopGap"></div>
							<div class="topicbar">
								<spring:message code="REFERENCE.MAIN.CATEGORY2.SUB3.TITLE" />
							</div>

							<div id="middleContent">
								<ul>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.GRADINGINFORMATON"/>"><a
										href="manageGradingInformation.htm"
										<sec:authorize
										access="!hasRole('View Manage Grading Information page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB3.MENU1" /> </a><span
										class="required_sign">*</span>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.EXAMS"/>"><a
										href="manageExam.htm"
										<sec:authorize access="!hasRole('View Manage Exams page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB3.MENU2" /> </a><span
										class="required_sign">*</span>
									</li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.EXAMSUBJECT"/>"><a
										href="manageExamSubject.htm"
										<sec:authorize access="!hasRole('View Exam Subject Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB3.MENU3" /> </a><span
										class="required_sign">*</span>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.MANAGEASSIGNMENTS"/>"><a
										href="manageAssignment.htm"
										<sec:authorize access="!hasRole('View Manage Assignments Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY2.SUB3.MENU4" /> </a><span
										class="required_sign">*</span>
									</li>

								</ul>
							</div>
						</div>
					</div>

					<div class="refBox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY3.TITLE" /> </span>
						<div class="reftopGap"></div>
						<div class="refInside">
							<div class="imgWrapper">
								<img src="resources/images/imgStaff.jpg" class="imgborder">
							</div>
							<div class="reftopGap"></div>
							<div class="topicbar">
								<spring:message code="REFERENCE.MAIN.CATEGORY3.SUB1.TITLE" />
							</div>
							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.SECTION"/>"><a
										href="manageSection.htm"
										<sec:authorize access="!hasRole('View Manage Sections page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU1" /> </a>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.CIVILSTATUS"/>"><a
										href="manageCivilStatus.htm"
										<sec:authorize
										access="!hasRole('View Manage Civil Status Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU2" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.STAFFCATEGORY"/>"><a
										href="manageStaffCategory.htm"
										<sec:authorize
										access="!hasRole('View Staff Category Information')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU3" /> </a><span
												class="required_sign">*</span></li>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.APPOINTMENTNATURE"/>"><a
										href="manageAppointmentNature.htm"
										<sec:authorize access="!hasRole('View Appointment Nature Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU4" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.APPOINTMENTCLASSIFICATION"/>"><a
										href="manageAppointmentClassification.htm"
										<sec:authorize
										access="!hasRole('View AppointmentClassification Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU5" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.STAFFSERVICECATEGORY"/>"><a
										href="manageStaffServiceCategory.htm"
										<sec:authorize
										access="!hasRole('View Manage Staff Service Category Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB1.MENU6" /> </a></li>

								</ul>
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB2.TITLE" /> </strong>
									<div class="reftopGap"></div>
									<div class="reftopGap"></div>
											<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.TITLE"/>"><a
										href="manageTitle.htm"
										<sec:authorize
										access="!hasRole('View Title Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB2.MENU0" /> </a>
									</li>
									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.EDUCATIONQUALIFICATION"/>"><a
										href="manageEducationalQualification.htm"
										<sec:authorize
										access="!hasRole('View Educational Qualification')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB2.MENU1" /> </a>
									</li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.PROFESSIONALQUALIFICATION"/>"><a
										href="manageProfessionalQualification.htm"
										<sec:authorize
										access="!hasRole('View Professional Qualification')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB2.MENU2" /> </a></li>
												
									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.INSTITUTE"/>"><a
										href="manageInstitute.htm"
										<sec:authorize
										access="!hasRole('View Institute')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB2.MENU3" /> </a></li>

								</ul>

								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB3.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.STAFFLEAVETYPES"/>"><a
										href="manageStaffLeaveTypes.htm"
										<sec:authorize access="!hasRole('View Staff Leave Type Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY3.SUB1.SUB3.MENU1" /> </a><span
										class="required_sign">*</span></li>

								</ul>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="refSmallbox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY4.TITLE" /> </span>
						<div class="reftopGap"></div>

						<div class="refSmallboxInside">
							<div class="reftopGap"></div>
							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY4.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.PROVINCES"/>"><a
										href="manageProvince.htm"
										<sec:authorize access="!hasRole('View Manage Province Page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY4.SUB1.MENU1" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.DISTRICS"/>"><a
										href="manageDistrict.htm"
										<sec:authorize access="!hasRole('View Manage District page')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY4.SUB1.MENU2" /> </a></li>

								</ul>
							</div>
						</div>
					</div>
					<div class="refSmallbox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY5.TITLE" /> </span>
						<div class="reftopGap"></div>

						<div class="refSmallboxInside">
							<div class="reftopGap"></div>

							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY5.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.EMPLOYMENTSTATUS"/>"><a
										href="manageEmploymentStatus.htm"
										<sec:authorize access="!hasRole('View Employment Status')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY5.SUB1.MENU1" /> </a></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.WORKINGSEGMENT"/>"><a
										href="manageWorkingSegment.htm"
										<sec:authorize
										access="!hasRole('View Manage Working Segment page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY5.SUB1.MENU2" /> </a></li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.DONATIONTYPE"/>"><a
										href="manageDonationType.htm"
										<sec:authorize
										access="!hasRole('View Manage donation type page.')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY5.SUB1.MENU3" /> </a></li>

								</ul>
							</div>
						</div>
					</div>



					<div class="refSmallbox">
						<span class="headingtxt"><spring:message
								code="REFERENCE.MAIN.CATEGORY6.TITLE" /> </span>
						<div class="reftopGap"></div>

						<div class="refSmallboxInside">
							<div class="reftopGap"></div>
							<div id="middleContent">
								<ul>
									<strong><spring:message
											code="REFERENCE.MAIN.CATEGORY6.SUB1.TITLE" /> </strong>
									<div class="reftopGap"></div>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.HOLIDAY"/>"><a
										href="manageHoliday.htm"
										<sec:authorize access="!hasRole('View Manage Calendar')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY6.SUB1.MENU1" /> </a><span
										class="required_sign">*</span></li>

									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.MANAGE.PUBLICATIONS"/>"><a
										href="managePublication.htm"
										<sec:authorize access="!hasRole('View Manage News And Events')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY6.SUB1.MENU2" /> </a>
									</li>


									<li
										title="<spring:message code="REF.UI.REFERENCEMODULE.VIEW.AUDIT.DETAILS"/>"><a
										href="viewAuditDetails.htm"
										<sec:authorize access="!hasRole('View Audit Details')">class="inactiveRef" onclick="this.href='#'"</sec:authorize>><spring:message
												code="REFERENCE.MAIN.CATEGORY6.SUB1.MENU3" /> </a>
									</li>

								</ul>
							</div>
						</div>
					</div>

					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<h:footer />
</body>
</html>

