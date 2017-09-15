<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>
    
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>

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
<script language="javascript" src="resources/js/common.js"></script>


<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
	function addNew(thisValue) {
		setAddEditPane(thisValue, 'Add');
		if (document.staffLeaveTypeForm.description.value != null) {
			document.staffLeaveTypeForm.description.value = '';
		}
		if (document.getElementById('maxStaffLeaves').value != null) {
			document.getElementById('maxStaffLeaves').value =0;
		}
		
		document.staffLeaveTypeForm.staffLeaveTypeId.value = 0;
		$('input:radio[name=gender]').attr('checked',false);
		
	}

	function saveStaffLeaveType(thisValue, gender) {
		var newLeaveType= document.getElementById("inputLeaveType").value;
		var newMaxNum= document.getElementById("maxStaffLeaves").value;
		var newSelectedGender= $('input[name="gender"]:checked').val();
		var elementWraper = $(thisValue).closest('.section_box');
		
		
		
		var okfunction = function(){
			
			if(oldLeaveType == newLeaveType && oldMaxNum == newMaxNum && oldSelectedGender == newSelectedGender){
				$(".areaBot").show();
				document.querySelectorAll('.areaBot')[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
				oldLeaveType = "";
				oldMaxNum = "";
				oldSelectedGender = ""; 
				}
			else{
				setAddEditPane(thisValue, 'Save');
				document.staffLeaveTypeForm.action = "manageSaveOrUpdateStaffleaveTypes.htm";
				document.staffLeaveTypeForm.submit();
			}
			
		};
		
		var cancelfunction = function(){
			
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.SAVE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);
		
		
	}
	
	var oldLeaveType, oldMaxNum, oldSelectedGender;
	function updateStaffLeaveType(thisValue, selectedValue, description, maxStaffLeaves ) {
		setAddEditPane(thisValue, 'Edit');
		oldLeaveType= description;
		oldMaxNum= maxStaffLeaves;
		document.staffLeaveTypeForm.staffLeaveTypeId.value = selectedValue;
		document.staffLeaveTypeForm.description.value = description;
		document.getElementById('maxStaffLeaves').value = maxStaffLeaves;
	}

	/* function deleteStaffLeaveType(thisValue, selectedValue) {
		
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.staffLeaveTypeForm.staffLeaveTypeId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>' ;
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.staffLeaveTypeForm.action = "manageDeleteStaffLeaveType.htm";
			document.staffLeaveTypeForm.submit();
		};

		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};

		confirm_function(message , okfunction, cancelfunction );
	} */
	function deleteStaffLeaveType(thisValue, selectedValue) {
		
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.staffLeaveTypeForm.staffLeaveTypeId.value = selectedValue;
			document.staffLeaveTypeForm.action = "manageDeleteStaffLeaveType.htm";
			document.staffLeaveTypeForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);	
	}

	function showArea() {
		$(document).ready(function() {
			$(".areaTop").hide();
			$(".areaBot").hide();
			$(".area").hide();
		});
	}
	
	function selectRadioButton(gender){
		
		if (gender ==='A') {
			$('input:radio[name=gender]:nth(0)').attr('checked',true);
		} 
		if (gender ==='M') {
			$('input:radio[name=gender]:nth(1)').attr('checked',true);
		} 
		if (gender ==='F'){
			$('input:radio[name=gender]:nth(2)').attr('checked',true);
		}
		oldSelectedGender= $('input[name="gender"]:checked').val();   
	}

	function selectAllGender(){
		$('input:radio[name=gender]:nth(0)').attr('checked',true);
	}	  
		    

	
	function load(thisValue,maxValue){
		
        if (thisValue>0) {
       
                $(document).ready(function() {
                        $("#flag").parents('tr').addClass('highlight');
                        document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.CREATE"/>";
                        document.getElementById('maxStaffLeaves').value = maxValue;
                });             
        }
        
        if(maxValue == 100 || maxValue ==101){
          	
          	maxValue="";
          	document.getElementById('maxStaffLeaves').value = maxValue;
        }
        
        if(thisValue==0){
        	
        	  if(maxValue == 100 || maxValue ==101){
              	
              	maxValue="";
              
              }
        	
             document.getElementById('editpanetitle').innerHTML = "<spring:message code="REF.UI.STAFFLEAVETYPES.IMAGE.ADD"/>";
        	 document.getElementById('maxStaffLeaves').value = maxValue;
        }
	}
	
		function showDown(bool){			
			var name = '${editpane != null}';
			if(bool){
			$(document).ready(function() {
			if(!name){								
		        $(".section_full_inside").hide();			 
			}
			else{			
			$(".section_full_inside").show();
			var position = $(".section_full_inside").position();			
			scroll(0,position.top);	
			}
			});
			}
			else{
			var position = $(".section_full_inside").position();			
			scroll(0,position.top);	
			}
			}
		
		function showErrorMessage(){
			if(${del!= null}){	
				$(".areaBot").hide();
			}
			else{
				$(".areaTop").hide();
			}
		}
	
</script>

</head>
<body onload="showDown(false),showErrorMessage(),load('<c:out value="${selectedObj.staffLeaveTypeId}"></c:out>','<c:out value="${editedMaxStaffLeaveVal}"></c:out>')">

<h:headerNew parentTabId="26" page="referenceModule.htm" />
<div id="page_container">
<div id="breadcrumb_area">
<div id="breadcrumb">

<ul>
	<li><a href="adminWelcome.htm"><spring:message
		code="REF.UI.HOME" /> </a>&nbsp;&gt;&nbsp;</li>
	<li><a href="referenceModule.htm"><spring:message
		code="REF.UI.REFERENCE" /> </a>&nbsp;&gt;&nbsp;</li>
	<li><spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.TITLE" /></li>
</ul>
</div>
<div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageStaffLeaveTypeHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"><spring:message code="REF.UI.HELP" /></a></div>
</div>
<div class="clearfix"></div>
<h1><spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.TITLE" />
</h1>
<div id="content_main"><form:form action="" method="POST"
	name="staffLeaveTypeForm" commandName="staffLeaveType">

	<form:hidden path="staffLeaveTypeId" />

	<div class="section_box">
	<div id="search_results">
	<div class="section_box_header">
	<h2><spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES" /></h2>
	</div>

	<div class="area">
		<div>
		<!-- update success message comes through query string (after redirecting) -->
		<label class="success_sign"> ${param.addEditDelete}</label>
		</div>
	</div>
	<div class="areaTop"><c:if test="${!(message == null)}">
	<div class="error"><label id="errormsg" class="required_sign"><c:out
			value="${message}" /> </label></div>
	</c:if> <form:errors path="description" id="errormsg" class="required_sign" />
	<br />
	<form:errors path="maxStaffLeaves" id="errormsg" class="required_sign" />
	</div>

	<div class="column_single">
	<table class="basic_grid" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th width="500" class="left"><spring:message
				code="REF.UI.MANAGE.STAFFLEAVETYPE" /></th>
			<th><spring:message code="REF.UI.MANAGE.MAXIMUMNOOFSTAFFLEAVES" />
			</th>
			<th><spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER" />
			</th>
			<th width="78" class="right"><sec:authorize
				access="hasRole('Add/Edit Staff Leave Type')">

				<img src="resources/images/ico_new.gif" class="icon_new"
					onClick="showDown(true),addNew(this),showArea();selectAllGender()" width="18" height="20"
					title="<spring:message code="REF.UI.STAFFLEAVETYPES.IMAGE.ADD" />">
			</sec:authorize></th>
		</tr>
		<c:choose>
			<c:when test="${not empty staffleaveTypeList}">
				<c:forEach items="${staffleaveTypeList}" var="staffLeaveType"
					varStatus="status">
					<tr
						<c:choose>
	            		<c:when test="${status.count % 2 == 1}">class="odd"</c:when>
	            		<c:when test="${status.count % 2 == 0}">class="even"</c:when>
	            		</c:choose>>

						<td 
							<c:if test="${selectedObj.staffLeaveTypeId == staffLeaveType.staffLeaveTypeId }">
															id="flag" 
												</c:if>>${staffLeaveType.description}</td>
						
						<%-- <td align="center">${staffLeaveType.maxStaffLeaves}</td> --%>
						<td align="center">
							<c:if test = "${staffLeaveType.maxStaffLeaves == -1 }"> N/A </c:if>
							<c:if test = "${staffLeaveType.maxStaffLeaves != -1 }"> ${staffLeaveType.maxStaffLeaves}	</c:if>
						</td>
						<td align="center">
							<c:choose>
  								<c:when test="${fn:trim(staffLeaveType.gender) == 'A'}">
    								<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.ALL" />
  								</c:when>
  								<c:when test="${fn:trim(staffLeaveType.gender) == 'M'}">
    								<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.MALE" />
  								</c:when>
	  							<c:when test="${fn:trim(staffLeaveType.gender) == 'F'}">
    								<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.FEMALE" />
  								</c:when>
							</c:choose>
						</td>
						<td nowrap class="right"><sec:authorize
							access="hasRole('Add/Edit Staff Leave Type')">
							
							<c:if test = "${staffLeaveType.maxStaffLeaves != -1 }">
							<img src="resources/images/ico_edit.gif"
								title="<spring:message code="REF.UI.STAFFLEAVE.IMAGE.EDIT"/>"
								onClick="showDown(true),updateStaffLeaveType(this, '<c:out value="${staffLeaveType.staffLeaveTypeId}" />', '<c:out value="${strEscapeUtil:escapeJS(staffLeaveType.description)}" />', '<c:out value="${staffLeaveType.maxStaffLeaves}" />',showArea());selectRadioButton('<c:out value="${staffLeaveType.gender}" />');"
								width="18" height="20" class="icon" id="test" >
							</c:if>
						</sec:authorize> <sec:authorize access="hasRole('Delete Staff Leave Type')">
							<img src="resources/images/ico_delete.gif"
								title="<spring:message code="REF.UI.DELETE"/>"
								onClick="deleteStaffLeaveType(this, '<c:out value="${staffLeaveType.staffLeaveTypeId}" />',showArea());"
								width="18" height="20" class="icon">
						</sec:authorize></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td>
					<h5><spring:message
						code='REF.UI.MANAGE.NO.STAFFLEAVETYPES.FOUND' /></h5>
					</td>
					<td></td>
					<td></td>
					<td nowrap class="right"></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
	</div>
	
	<div class="areaBot"><c:if test="${!(message == null)}">
	<div class="error"><label id="errormsg" class="required_sign"><c:out
			value="${message}" /> </label></div>
	</c:if> <form:errors path="description" id="errormsg" class="required_sign" />
	<br />
	<form:errors path="maxStaffLeaves" id="errormsg" class="required_sign" />
	</div>

	<sec:authorize access="hasRole('Add/Edit Staff Leave Type')">

		<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
		<h3 id="editpanetitle"><spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.CREATE" /></h3>
		<div class="box_border">
		<div class="row">
		<div class="float_left">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="REF.UI.MANAGE.STAFFLEAVETYPE" />:</label></div>
		<form:input id="inputLeaveType" path="description"
			onkeypress="return disableEnterKey(event)" maxlength="44" /></div>
		<div class="float_right"">
		<div class="lbl_lock"><span class="required_sign">*</span><label><spring:message
			code="REF.UI.MANAGE.MAXIMUMNOOFSTAFFLEAVES" />:</label></div>
		<input type="text"  maxlength="2" name="maxStaffLeaves" id="maxStaffLeaves"/></div>

		</div>
		<div class="row">
			<div class="float_left">
			
				<div class="lbl_lock"><span class="required_sign">*</span> 
					<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER"/>:</div>
					
					<form:radiobutton path="gender" value="A" id="a" label="" cssClass="radio_btn" name="gender"/>
			 			<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.ALL" />
					<form:radiobutton path="gender" value="M" id="m" label="" cssClass="radio_btn" name="gender"/>
			 			<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.MALE"/>
					<form:radiobutton path="gender" value="F" id="f" label="" cssClass="radio_btn" name="gender"/>
						<spring:message code="REF.UI.MANAGE.STAFFLEAVETYPES.GENDER.FEMALE"/></div>
			
			
		</div>	
		<div class="row">
		<div class="buttion_bar_type1"><input type="button"
			class="button" onClick="saveStaffLeaveType(this,'<c:out value="${staffLeaveType.gender}" />');"
			value="<spring:message code="REF.UI.SAVE" />"> <input
			type="button" class="button"
			onClick="setAddEditPane(this,'Cancel'),showArea()"
			value="<spring:message code="REF.UI.CANCEL" />"></div>
		</div>
		<div class="clearfix"></div>
		</div>
		</div>
	</sec:authorize>


	<div class="clearfix"></div>
	</div>
</form:form></div>
</div>
<h:footer />
</body>
</html>