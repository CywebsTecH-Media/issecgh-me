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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>
<script type="text/javascript">
	function populate(thisValue) {

		document.gradeForm.action = "populateFaithLifeData.htm";
		if (thisValue.value != "") {
			document.gradeForm.submit();
		}
	}

	function addFaithLife(thisValue) {

		document.faithLifeForm.faithLifeRatingId.value = 0;
		document.faithLifeForm.selectedGrade.value = selectedGrade;
		document.getElementById('selectCategory').value = document
				.getElementById('selectOptionCategory').value;
		document.getElementById('selectGrading').value = document
				.getElementById('selectOptionGrading').value;
		
		if (document.getElementById("faithLifeCommentId") != null) {
			document.getElementById("faithLifeCommentId").value = 0;
		}
		if (document.getElementById("faithLifeCommentDes") != null) {
			document.getElementById("faithLifeCommentDes").value = "";
		}
		setAddEditPane(thisValue, 'Add');
	}

	function updateFaithLife(thisValue, selectedValue, selectedCategory,
			selectedComment, selectedGrading) {

		
		setAddEditPane(thisValue, 'Edit');
		document.faithLifeForm.faithLifeRatingId.value = selectedValue;
		document.faithLifeForm.selectedGrade.value = selectedGrade;
		document.getElementById('selectCategory').value = selectedCategory;
		loadCommentContent(selectedCategory, selectedComment);
		document.getElementById('selectGrading').value = selectedGrading;

	}

	function deleteFaithLife(thisValue, selectedValue) {

		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();

		var ans = window
				.confirm('<spring:message code="REF.DELETE.CONFIRMATION"/>')

		if (ans) {
			document.faithLifeForm.faithLifeRatingId.value = selectedValue;
			document.faithLifeForm.selectedGrade.value = selectedGrade;
			document.faithLifeForm.action = "deleteFaithLifeRating.htm";
			document.faithLifeForm.submit();
		} else {
			$(thisValue).parents('tr').removeClass('highlight');
		}
	}
	function saveFaithLife(thisValue) {
		setAddEditPane(thisValue, 'Save');

		if(document.getElementById("selectCategory").value > 0){
		if(document.getElementById("selectCategory").value == 1){
			if (document.getElementById("faithLifeCommentDes").value != null && document.getElementById("faithLifeCommentDes").value != "") {

				document.faithLifeForm.faithLifeCommentDes.value = document
						.getElementById("faithLifeCommentDes").value;
			}
		}else{
			if (document.getElementById("faithLifeCommentId").value != null && document.getElementById("faithLifeCommentId").value != "") {

				document.faithLifeForm.faithLifeCommentId.value = document
						.getElementById("faithLifeCommentId").value;
			}
		}
		}
		document.faithLifeForm.selectedGrade.value = selectedGrade;
		document.faithLifeForm.action = "saveOrUpdateFaithLifeRating.htm";
		document.faithLifeForm.submit();
	}

	function load(flagValue) {

		var flagVal = null;
		if (!(flagValue == null || flagValue == "")) {
			flagVal = flagValue;
		}
		if (flagVal != null) {
			$(document).ready(function() {
				$("#flag").parents('tr').addClass('highlight');
			});
			updateFaithLife(this, flagVal, null, null, null);
		}else {
			$(document).ready(function() {
				$(".section_full_inside").hide();
			});
		}
	}

	function loadCommentContent(selectedValue, comments) {

		var url = '<c:url value="/populateFaithLifeComment.htm" />';

		$.ajax({
			url : url,
			data : ({
				'selectedValue' : selectedValue
			}),
			success : function(response) {

				var c = response;
				var a;

				a = c.split(",");

				var b;
				document.getElementById('selectComment').innerHTML = '';
				
				if (comments == null) {

					if (selectedValue == 1) {
						var textInput = document
								.getElementById('selectComment');

						var input = document.createElement('input');
						input.type = 'text';
						input.name = 'faithLifeCommentDes';
						input.id = 'faithLifeCommentDes';
						input.maxLength = '100';
						textInput.appendChild(input);

					} else {
						var dropDownDiv = document
								.getElementById('selectComment');

						var selector = document.createElement('select');
						selector.id = "faithLifeCommentId";
						selector.name = "faithLifeCommentId";
						dropDownDiv.appendChild(selector);

						var option = document.createElement('option');
						option.value = '0';
						option.appendChild(document
								.createTextNode('<spring:message code="OPT.PLEASE.SELECT"/>'));
								option.selected = 'selected';
						selector.appendChild(option);

						
				// alert(a.length);
						for ( var i = 0; i < a.length; i++) {
						
							b = a[i].split("_");
							if(b[0]!=""){
							option = document.createElement('option');
							option.value = b[1];
							
							option.appendChild(document.createTextNode(b[0]));
							selector.appendChild(option);
						}}
						
						
					}
					
				} else {
					var newComment = comments;

					if (selectedValue == 1) {
						var textInput = document
								.getElementById('selectComment');

						var input = document.createElement('input');
						input.type = 'text';
						input.name = 'faithLifeCommentDes';
						input.id = 'faithLifeCommentDes';
						input.maxLength = '100';
						input.value = newComment ;
						textInput.appendChild(input);

					} else {

					var dropDownDiv = document
					.getElementById('selectComment');

			var selector = document.createElement('select');
			selector.id = 'faithLifeCommentId';
			selector.name = 'faithLifeCommentId';
			dropDownDiv.appendChild(selector);

			var option = document.createElement('option');
			option.value = '0';
			option.appendChild(document
					.createTextNode('<spring:message code="OPT.PLEASE.SELECT"/>'));
			selector.appendChild(option);
					for ( var i = 0; i < a.length; i++) {
						b = a[i].split("_");
						if(b[0]!=""){
							option = document.createElement('option');
							option.value = b[1];
							if (newComment == b[0]) {
								option.selected = 'selected';
							}
						option.appendChild(document.createTextNode(b[0]));
						selector.appendChild(option);
					}}
				}
				}

			},
			error : function(transport) {
				
			},
			complete: function(jqXHR, textStatus){
				// load default data
				//document.getElementById('faithLifeCommentId').value = "${faithLifeCommentId}";
				
			}
			
		});
	}
	
	
	function loadOpenStateData(){
		loadCommentContent(document.getElementById('selectCategory').value, null);
	}
</script>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="CurrentYear" value="${now}" pattern="yyyy" />
</head>
<body onload="loadOpenStateData()">
	<c:choose>
		<%-- user object must in Session to get role to check Parent or Other user --%>
		<c:when test="${user.role eq 'ROLE_PARENT'}">
			<h:headerNew parentTabId="40" page="FaithLifeRating.htm" />
		</c:when>
		<c:otherwise>
			<h:headerNew parentTabId="11"
				page="FaithLifeRating.htm" />
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
					<li><spring:message code="STUDENT.RELIGIOUS_ACTIVITY.TITLE" />
					</li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/faithLifeHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle">
				<spring:message code="application.help" />
				</a>
			</div>
		</div>

		<c:if test="${showAcademicLifeBar eq 'on'}">
			<div id="progress_bar_wraper">
				<label><spring:message code="STUDENT.PROGRESS.ACADEMIC_LIFE" />
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
		<c:if test="${showReligiousActivitiesBar eq 'on'}">
			<div id="progress_bar_wraper">
				<label><spring:message
						code="STUDENT.PROGRESS.RELIGIOUS_ACTIVITY" /> </label>
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
		<div class="clearfix"></div>
		<h1>
			<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.TITLE" />
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

			<c:choose>
				<c:when test="${not empty studentGrade}">

					<form action="" method="POST" name="gradeForm">

						<div class="section_full">
							<div class="row">
								<label><strong></strong>
								<spring:message code="STUDENT.COCURRICULARS.STUDENTGRADE" />
								</label> <select name="selectedGrade" onchange="populate(this)"
									id="selectedGrade">

									<c:forEach items="${studentGradeList}" var="studentGrade">
										<option
											<c:if test="${selectedStudClassId == studentGrade.classGrade.grade.description and (studentGrade.year).toString().substring(0,4) == Year}">
															selected="selected"
												</c:if>
											value="<c:out value="${studentGrade.studentClassInfoId}" />">
											<c:out
												value="${(studentGrade.year).toString().substring(0,4)} - ${studentGrade.classGrade.grade.description}" />
										</option>
									</c:forEach>


								</select>
							</div>

						</div>
					</form>

					<form:form action="" method="POST" name="faithLifeForm"
						commandName="faithLifeRating">
						<form:hidden path="faithLifeRatingId" />
						<input type="hidden" name="selectedGrade" />
						<input type="hidden" name="selectedValue" />
						<!-- 				<input type="hidden" name="faithLifeCommentDes" /> -->
						<!-- 				<input type="hidden" name="faithLifeCommentId" /> -->
						<div class="clearfix"></div>
						<div class="section_box">
							<div id="search_results">
								<div class="section_box_header">
									<h2>
										<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.TITLE" />
									</h2>
								</div>
								<div>
									<div class="messageArea">
										<c:if test="${message != null}">
											<div>
												<label class="required_sign">${message}</label>
											</div>
										</c:if>

										<div>
											<form:errors path="faithLifeRatingId" id="errormsg"
												class="required_sign" />
										</div>
									</div>

									<div class="column_single">
										<table class="basic_grid" border="0" cellspacing="0"
											cellpadding="0">
											<tr>
												<th width="184"><spring:message
														code="STUDENT.RELIGIOUS_ACTIVITY.CATEGORY" />
												</th>
												<th width="198"><spring:message
														code="STUDENT.RELIGIOUS_ACTIVITY.COMMENT" />
												</th>
												<th width="198"><spring:message
														code="STUDENT.RELIGIOUS_ACTIVITY.VALUE" />
												</th>
												<th width="55" align="right" class="right">
												
												<sec:authorize access="hasAnyRole('Save Religious Activity')">

														<img src="resources/images/ico_new.gif" class="icon_new"
															onClick="clearMessages();addFaithLife(this);" width="18" height="20"
															title="<spring:message code='STUDENT.RELIGIOUS_ACTIVITY.SUB_FORM.TITLE' />"
															<c:if test="${student.statusId != 1}">style="display:none;"</c:if>
															<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
													</sec:authorize>
												</th>
											</tr>

											<c:choose>
												<c:when test="${not empty faithLifeList}">
													<c:forEach items="${faithLifeList}" var="faithLifeRating"
														varStatus="status">
															
														<tr
															<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>
															<td
																<c:if test="${selectedObj.faithLifeRatingId == faithLifeRating.faithLifeRatingId}">
															id="flag"
												</c:if>><c:if
																	test="${faithLifeRating.faithLifeComment != null}">${faithLifeRating.faithLifeComment.faithLifeCategory.description}</c:if>
																<c:if
																	test="${faithLifeRating.faithLifeDescription != null}"><spring:message code="REFERENCE.MAIN.CATEGORY6.TITLE"/></c:if>
															</td>

															<td><c:if
																	test="${faithLifeRating.faithLifeComment != null}">${faithLifeRating.faithLifeComment.description}</c:if>

																<c:if
																	test="${faithLifeRating.faithLifeDescription != null}">${faithLifeRating.faithLifeDescription}</c:if>
															</td>

															<td>${faithLifeRating.faithLifeGrading.description}(${faithLifeRating.faithLifeGrading.value})</td>
															<td nowrap class="right">
															
															<sec:authorize access="hasAnyRole('Save Religious Activity')">
																	
																	<img src="resources/images/ico_edit.gif"
																		title="<spring:message code='STUDENT.RELIGIOUS_ACTIVITY.EDIT_RA' />"
																		onClick="clearMessages();updateFaithLife(this,'<c:out value="${faithLifeRating.faithLifeRatingId}" />'
																<c:if test="${faithLifeRating.faithLifeComment != null}">,'<c:out value="${faithLifeRating.faithLifeComment.faithLifeCategory.faithLifeCategoryId}" />'
																,'<c:out value="${faithLifeRating.faithLifeComment.description}" />'</c:if>
																<c:if test="${faithLifeRating.faithLifeDescription != null}">,'1'
																,'<c:out value="${faithLifeRating.faithLifeDescription}" />'</c:if>
																,'<c:out value="${faithLifeRating.faithLifeGrading.gradingId}" />')"
																		width="18" height="20" class="icon"
																		<c:if test="${student.statusId != 1}">style="display:none;"</c:if>
																		<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
																</sec:authorize>
																
																	
															<sec:authorize access="hasAnyRole('Delete Religious Activity')">
																	
																	<img src="resources/images/ico_delete.gif"
																		onClick="clearMessages();deleteFaithLife(this,'<c:out value="${faithLifeRating.faithLifeRatingId}" />')"
																		title="<spring:message code='REF.UI.DELETE' />"
																		width="18" height="20" class="icon"
																		<c:if test="${student.statusId != 1}">style="display:none;"</c:if>
																		<c:if test="${EnableAddEditDelete eq null}">style="display:none;"</c:if>>
																</sec:authorize>
															</td>
														</tr>

													</c:forEach>

												</c:when>
												<c:otherwise>
													<tr>
														<td><h5>
																<spring:message code="APPLICATION.NORECORDSFOUND" />
															</h5></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</c:otherwise>
											</c:choose>
										</table>
									</div>

								</div>

								<sec:authorize access="hasAnyRole('Save Religious Activity')">
								
								<spring:bind path="faithLifeRating.*">
									<c:set var="status" value="${status}"></c:set>
								</spring:bind>
								<div class="section_full_inside" style="display: ${message != null or not empty status.errorMessages?'block':'none'}">
									<h3>
										<spring:message
											code="STUDENT.RELIGIOUS_ACTIVITY.SUB_FORM.TITLE2" />
									</h3>
									<div class="box_border">

										<div class="row">
											<div class="float_left">
												<div class="lbl_lock">
													<label><span class="required_sign">*</span>
													<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.CATEGORY" />:</label>
												</div>
												<form:select
													path="faithLifeComment.faithLifeCategory.faithLifeCategoryId"
													id="selectCategory"
													onchange="loadCommentContent(this.value,null)">
													<form:option value="0" id="selectOptionCategory">
														<spring:message code="application.drop.down" />
													</form:option>
													<form:options  items="${faithLifeCategoryList}"
														itemLabel="description" itemValue="faithLifeCategoryId" />
												</form:select>

											</div>
											<div class="float_right">
												<div class="lbl_lock">
													<label><span class="required_sign">*</span>
													<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.COMMENT" />:</label>
												</div>


												<div id="selectComment"></div>

											</div>

											<div class="row">
												<div class="float_left">
													<div class="lbl_lock">
														<label><span class="required_sign">*</span>
														<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.VALUE" />:</label>
													</div>

													<form:select path="faithLifeGrading.gradingId" id="selectGrading">
														<form:option value="0" id="selectOptionGrading">
															<spring:message code="application.drop.down" />
														</form:option>
														<form:options items="${gradingList}"
															itemLabel="description" itemValue="gradingId" />
													</form:select>

												</div>
												<div class="buttion_bar_type1">
													<input type="button"
														value='<spring:message code="REF.UI.SAVE"/>'
														onClick="saveFaithLife(this);" class="button"><input
														type="button" class="button"
														onClick="clearMessages();setAddEditPane(this,'Cancel')"
														value='<spring:message code="REF.UI.CANCEL"/>'>
												</div>
											</div>

											<div class="clearfix"></div>
										</div>
									</div>
									
									
									<div class="clearfix"></div>
								</div>
								
								</sec:authorize>
																
					</form:form>
				</c:when>
				<c:otherwise>
					<h3>
						<spring:message code="STUDENT.RELIGIOUS_ACTIVITY.ASSIGNCLASS" />
					</h3>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</div>
	</div>
	<h:footer />
</body>
<c:if test="${not empty studentGrade}">
	<script type="text/javascript">
	var selectedGrade = document.getElementById("selectedGrade").value;
</script>
</c:if>
</html>
