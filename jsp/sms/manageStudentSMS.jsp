<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.virtusa.akura.api.dto.ClassGrade"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script src="resources/js/jquery-1.8.2.min.js"></script>
<script src="resources/js/jquery-ui-1.10.2.custom.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<script type="text/javascript">
	
	
	function cancel() {
			document.searchStudent.action='resetFormSms.htm';
			}
	
	function hideErrorSection(){
		 $(document).ready(function() {
		 $("#pageErrors").hide();
		 $("#searchErrors").hide();
							});
	}

	function search() {
			document.searchStudent.action='SearchSmsStudent.htm';
			}
	
	
	function sendSms(form){
		var result = new Array();
		var selectBox =document.getElementById('ToList'); 
		var stuId;
		for (i=0;i<selectBox.length;i++)
		      {
			stuId=selectBox.options[i].value;
			result[i]=stuId;
				} 
		document.searchStudent.sendingSmsArray.value = result;
		document.searchStudent.action='sendStudentSms.htm';
	}
	
function listbox_moveacross(sourceID, destID) {
		
		var src = document.getElementById(sourceID);
		var dest = document.getElementById(destID);
		var individualOptions = new Array();
		
		for ( var count = 0; count < src.options.length; count++) {
		
			if (src.options[count].selected == true) {
				var option = src.options[count];
				var newOption = document.createElement("option");
				newOption.value = option.value;
				newOption.text = option.text;
				newOption.setAttribute('title',option.title);
				
				try {
					if(newOption.title == 'school'){
						newOption.setAttribute('class', "sms_school_quota_senders");
					}
					dest.add(newOption, null);
					
					//dest.add(newOption, null);
					src.remove(count, null);
				} catch (error) {
					dest.add(newOption);
					src.remove(count);
				}
				count--;
			}
		}
						
		for ( var count = 0; count < dest.options.length; count++) {
					var option1 = dest.options[count];
			//alert('a');
			if( option1.title == 'individual'){
			dest.add(option1, null);
					}
			}  
		
		for ( var count = 0; count < dest.options.length; count++) {
			var option2 = dest.options[count];
			//alert('b');
			if(option2.title == 'school'){
				option2.setAttribute('class', "sms_school_quota_senders");
				dest.add(option2, null);
			}
			} 
		}
		
	function listbox_selectall(listID, isSelect) {
		var listbox = document.getElementById(listID);
		for ( var count = 0; count < listbox.options.length; count++) {
			listbox.options[count].selected = isSelect;
		}
	}
	
	function limitText(limitField, limitCount, limitNum) {
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} else {
			limitCount.value = limitNum - limitField.value.length;
		}
	}
	function clearMeaasage(id){
		document.getElementById(id).value = "";
	}
	
</SCRIPT>
</head>
<body>

	<h:headerNew parentTabId="53" page="studentNotification.htm" />

	<div id="page_container">
		<div id="breadcrumb">
			<ul>
				<li><a href="adminWelcome.htm"><spring:message
							code="application.home" /> </a>&nbsp;&gt;&nbsp;</li>
				<li><spring:message code="SMS.STUDENTS.TITLE" /></li>
			</ul>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/other/StudentSMS.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code="application.help" />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1>
			<spring:message code="SMS.STUDENTS.TITLE" />
		</h1>
		<div style="padding-left:16px;">
			<label class="required_sign"> <c:if test="${message != null}"> ${message}</c:if>
			</label>
		</div>
			<form:form method="POST" commandName="critiria" name="searchStudent" id="form"
				action="">
		<div id="content_main">
		
		<div style="padding-left:16px;">
		<c:choose> 
		  <c:when test="${(remaingSchoolMessages) eq  -1}">
         <label class="required_sign" id="searchErrors">
		<spring:message code='STUDENT.SMS.NO.SERVICE' /> </label> 
    
    </c:when>
    <c:otherwise>
    	<label class="required_sign" id="pageErrors"> <c:if
									test="${nocriteria != null}">${nocriteria}</c:if> </label>
									
									<label class="success_sign"> <c:if
									test="${successMessage != null}">${successMessage}</c:if></label>
		
    </c:otherwise>
</c:choose> 
							
						</div>
						
						
			<%-- <form:form method="POST" commandName="critiria" name="searchStudent" id="form"
				action=""> --%>
				<div class="clearfix"></div>
				<div class="section_full_search">
					<div class="box_border">
						<%-- <div>
							<label class="required_sign" id="pageErrors"> <c:if
									test="${nocriteria != null}">${nocriteria}</c:if> </label>
						</div> --%>
						<div class="row">

							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.LAST.NAME" />
									</label>
								</div>
								<form:input path="lastName" id="lastName" />
								
							</div>

							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STUDENT.SEARCH.ADMISSION.NO" /> </label>
								</div>
								<form:input path="admissionNumber" id="admissionNo" />
								
							</div>

						
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.GRADE" />
									</label>
								</div>

								<form:select path="grade" class="commboSpecific" id="gradeList">
									<option value="">
										<spring:message code="application.drop.down" />
									</option>
									<option value="New" <c:if test='${isSelectNew}'> selected="selected" </c:if>  >
										<spring:message code="STUDENT.SEARCH.UI.NEW.STUDENT.LABEL" />
									</option>
									<form:options items="${gradeList}" itemValue="description"
										itemLabel="description" />
								</form:select>

							</div>

						</div>
						<div class="row">

							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.CLASS" />
									</label>
								</div>
								<form:select path="clazzId" id="clazzList"
									class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${classList}" itemValue="classGradeId"
										itemLabel="description" />
								</form:select>
							</div>



							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.SPORT" />
									</label>
								</div>

								<form:select path="sportId" id="sportsList"
									class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${sportList}" itemValue="sportId"
										itemLabel="description" />
								</form:select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.SUBJECT" />
									</label>
								</div>
								<form:select path="subjectId" id="subjectList"
									class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${subjectList}" itemValue="subjectId"
										itemLabel="description" />
								</form:select>

							</div>


						</div>

						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message
											code="STUDENT.SEARCH.PREFECT.TYPE" /> </label>
								</div>
								<form:select path="prefectTypeId" id="prefectTypeList"
									class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${prefectTypeList}"
										itemValue="prefectTypeId" itemLabel="description" />
								</form:select>
							</div>
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="SMS.STUDENT.CLUBORSOCIETY" />
									</label>
								</div>
								<form:select path="clubSocietyId" id="clubSocietyList"
									class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${clubSocietyList}"
										itemValue="clubSocietyId" itemLabel="name" />
								</form:select>
							</div>



							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="STUDENT.SEARCH.STATUS" />
									</label>
								</div>

								<form:select path="studentStatusId" id="studentStatusList" class="commboSpecific">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<form:options items="${studentStatusList}"
										itemValue="studentStatusId" itemLabel="description" />
								</form:select>

							</div>
							<div class="buttion_bar_type1">
								<input type="submit"
									value="<spring:message code="REF.UI.SEARCH"/>" class="button"
									onclick="search(),hideErrorSection(),clearMeaasage('messageArea')">
							</div>
						</div>
						
						
						
						<div class="clearfix"></div>
					</div>
				</div>
				<c:choose>
				   <c:when test="${(remaingSchoolMessages) eq  -1}">
          <%--  <label class="required_sign" id="searchErrors">
		<spring:message code='STUDENT.SMS.NO.SERVICE' /> </label> --%>
    
   		 </c:when>
   			 <c:otherwise>
    		
 			<label class="required_sign" id="searchErrors" >&nbsp;&nbsp;
							<c:out value="${noSearchResults}" />  </label> 
		
    	</c:otherwise>
			</c:choose> 
				
				
				
				<%-- <label class="required_sign" id="searchErrors" >&nbsp;&nbsp;
							<c:out value="${noSearchResults}" />  </label> --%>

			<div class="section_box" id="search_results">

				<div class="column_single">
					<div id="add_remove_list">
						<%-- <label ><spring:message code='SMS.REMAING.SCHOOL.MESSAGES' />
							<c:out value="${remaingSchoolMessages}" />  </label> --%>
										<c:choose>
    		<c:when test="${(remaingSchoolMessages) eq  -1}">
          <%--  <label class="required_sign" id="searchErrors">
		<spring:message code='STUDENT.SMS.NO.SERVICE' /> </label> --%>
  	  
   			 </c:when>
    		<c:otherwise>
    		
        	<label ><spring:message code='SMS.REMAING.SCHOOL.MESSAGES' />
		<c:out value="${remaingSchoolMessages}" />  </label>
		
    </c:otherwise>
</c:choose> 
						<div>


							<!--from list---------------------------------------------------------------------------------  -->

							<div class="studentNotification">
								<label><spring:message code='SMS.STUDENTS.STUDENTS' />
								</label><br> <select name="select" size="15" multiple id="FromList"
									style="width: 400px;">
								
						     <c:forEach items="${individualList}" var="individualListItem"
															                  varStatus="status">
								
											<c:if test="${(individualList) != 'Empty' }">
											<option title="individual" id="New" value="${individualListItem[0]}" >${individualListItem[4]} - ${individualListItem[1]} - ${individualListItem[2]} 
											
												</option> 
										    </c:if>
										
							</c:forEach>

						         <c:forEach items="${schoolList}" var="schoolListItem"
															               varStatus="status">

								
											<c:if test="${(schoolList) != 'Empty' }">
											<option title="school" id="New" value="${schoolListItem[0]}" class="sms_school_quota_senders">${schoolListItem[4]} - ${schoolListItem[1]}
												- ${schoolListItem[2]} </option>  
											</c:if>
										
								</c:forEach>


								</select>
							</div>

							<!--end from list----------------------------------------------------------------  -->

							<div id="selected_list" class="controller" style="width: 108px;">
								<input type="button" class="button" name="Button" value="&gt;"
									onClick="listbox_moveacross('FromList', 'ToList')"><br>
								<br> <input type="button" class="button" name="Button"
									value="&lt;" onClick="listbox_moveacross('ToList', 'FromList')">
							</div>



							<input type="hidden" name="sendingSmsArray" /> <input
								type="hidden" name="removedFromArray" />

							<!-- To List------------------------------------------------------ -->
							<span class="required_sign">*</span> <label><spring:message
									code='SMS.STUDENTS.SELECTED.STUDENTS' /> </label>
							<div>
								<!-- <input id="tList" name="rem1" type="checkbox" />Select all -->
							</div>
							<div class="studentNotification">
								<select name="select" size="15" multiple id="ToList"
									style="width: 400px;">
								</select>
							</div>

							<!-- End To List------------------------------------------------------ -->

							<div class="clearfix"></div>
							<spring:message code='SMS.STUDENT.NOTE' />
							<img src="resources/images/student_allocated.png">
							<spring:message code='SMS.STUDENT.OVER.MESSAGES.NOTE' />
						</div>
						<div class="row">&nbsp;</div>

						<div class="lbl_lock">
							<span class="required_sign">*</span> <label><spring:message
									code='SMS.STUDENT.MESSAGE' /> </label>
						</div>
						<br>
			
						<form:textarea path="smsMessage"  rows="4" cols="100" style="width: 395px;"  id="messageArea"  onkeydown="limitText(this.form.messageArea,this.form.countdown,114);"
										onkeyup="limitText(this.form.messageArea,this.form.countdown,114);"/>			
					</div>

				</div>

				<div class="clearfix"></div>
	
		
			</div>
				<div class="button_row">
					<div class="buttion_bar_type2">
						<input type="submit" value="<spring:message code='SMS.STUDENT.SEND'/>"
							class="button" onclick="sendSms()"> 
							<input type="submit"
							value="<spring:message code='SMS.STUDENT.CANCEL'/>" class="button"
							onclick="cancel(),hideErrorSection()">

					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			</form:form>
		</div>
		<h:footer />
</body>

</html>