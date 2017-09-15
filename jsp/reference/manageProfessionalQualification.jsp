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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	function addNew(thisValue) {
		setAddEditPane(thisValue,'Add');
	    if (document.professionalQualificationForm.description.value != null) {
	    	document.professionalQualificationForm.description.value='';
		}
	    document.professionalQualificationForm.professionalQualificationId.value = 0;
	}

	function saveProfessionalQualification(thisValue) {
		
		var textValue = document.getElementById("description").value;
		if(textValue == oldProfessionalQualification){
			$(".messageArea").show();
			document.getElementsByClassName("messageArea")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
		setAddEditPane(thisValue,'Save');
		document.professionalQualificationForm.action = "saveOrUpdateProfessionalQualification.htm";
		document.professionalQualificationForm.submit();
		}
	}
	
	
	var oldProfessionalQualification;
	function updateProfessionalQualification(thisValue, selectedValue, description) {
		oldProfessionalQualification=description;
		setAddEditPane(thisValue,'Edit');
		document.professionalQualificationForm.professionalQualificationId.value = selectedValue;
		document.professionalQualificationForm.description.value = description
	}


	function deleteProfessionalQualification(thisValue, selectedValue) {
		var elementWraper = $(thisValue).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');

		document.professionalQualificationForm.professionalQualificationId.value = selectedValue;

		$(thisValue).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			$(thisValue).parents('tr').hide();
			document.professionalQualificationForm.action = "manageDeleteProfessionalQualification.htm";
			document.professionalQualificationForm.submit();
		};
		
		var cancelfunction = function(){
			$(thisValue).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);

	}
	
	function changePanelTitle(professionalQualificationId) {
		if(professionalQualificationId > 0) {
			$('#panelTitle').empty();
			$('#panelTitle').append("<spring:message code='REF.UI.PROFESSIONAL_QUALIFICATION.IMAGE.EDIT' />");
		}
	}

</script>

</head>
<body onload="changePanelTitle('<c:out value="${professionalQualification.professionalQualificationId}"/>')" >
<h:headerNew parentTabId="26" page="referenceModule.htm"/>
<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
        <li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
		<li><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.TITLE"/></li>
      </ul>
    </div>
    <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/professionalQualificationHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"><spring:message code="REF.UI.HELP"/></a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.TITLE"/></h1>
  <div id="content_main">
   <form:form action="" method="POST" commandName="professionalQualification" name="professionalQualificationForm">

   <form:hidden path="professionalQualificationId"/>

   <div class="clearfix"></div>
	  <div class="section_box">
	  <div id="search_results">
        <div class="section_box_header">
          <h2><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.SUB_TITLE"/></h2>
        </div>
        <div class="messageArea">
        <label class="required_sign">
       		<form:errors path="professionalQualificationId"/>
       		<br/>
         	<form:errors path="description"/>
         </label>
         	<c:if test="${message != null}">
			    <label class="success_sign" id="area">
			    	${message}         		
			    </label>
         	</c:if>
         	<c:if test="${message_error != null}">
	         	<label class="required_sign" id="area">
	         		${message_error}        		
	         	</label>
         	</c:if> 
         </div>
        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th width="857"><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.DETAIL"/></th>
              <th width="51" class="right"><sec:authorize access="hasRole('Add/Edit Professional Qualification')"><img src="resources/images/ico_new.gif" class="icon_new" onClick="clearMessages(); addNew(this);" width="18" height="20" title="<spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.SUB_FORM.TITLE"/>"></sec:authorize></th>
            </tr>
            <c:choose>
	          	<c:when test="${not empty professionalQualificationList}">
		            <c:forEach items="${professionalQualificationList}" var="professionalQualificationData" varStatus="status">
			            
			            <c:set var="cssClass" value="${(status.count % 2 == 1) ? 'odd' : 'even'}" />
						<c:if test="${((showPanel != null) && (showPanel == 'TRUE')
						 	&& (professionalQualificationData.professionalQualificationId == professionalQualification.professionalQualificationId))}">
							<c:set var="cssClass" value="${cssClass} highlight" />
						</c:if>
			            
			            <tr class="${cssClass}" >
			              <td>${professionalQualificationData.description}</td>
			              <td nowrap class="right">
			              <sec:authorize access="hasRole('Add/Edit Professional Qualification')">
			              <img src="resources/images/ico_edit.gif" onClick="clearMessages(); updateProfessionalQualification(this,'<c:out value="${professionalQualificationData.professionalQualificationId}" />','<c:out value="${professionalQualificationData.description}" />');" title="<spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.IMAGE.EDIT"/>" width="18" height="20" class="icon">
			              </sec:authorize>
			              <sec:authorize access="hasRole('Delete Professional Qualification')">
			              <img src="resources/images/ico_delete.gif" onClick="clearMessages(); deleteProfessionalQualification(this,'<c:out value="${professionalQualificationData.professionalQualificationId}" />');" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></td>
			              </sec:authorize>
			            </tr>
		            </c:forEach>
	           	</c:when>
	            <c:otherwise>
	            	<tr>
		              <td width="830"><h5><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.EMPTY"/></h5></td>
		              <td nowrap class="right"></td>
		            </tr>
	            </c:otherwise>
            </c:choose>
          </table>
        </div>
		</div>
		
		<c:set var="displayStyle" value="${((showPanel != null) && (showPanel == 'TRUE')) ? 'display: block;' : 'display: none;' }" />
		
		<div class="section_full_inside" style="${displayStyle}">
          <h3 id="panelTitle"><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.SUB_FORM.TITLE"/></h3>
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <span class="required_sign">*</span><label><spring:message code="REF.UI.PROFESSIONAL_QUALIFICATION.DETAIL"/>:</label>
                </div>
               <form:input path="description" onkeypress="return disableEnterKey(event)" maxlength="45"
               			value="${((showPanel != null) && (showPanel == 'TRUE')) ? professionalQualification.description : ''}" />
              </div>
			  <div class="buttion_bar_type1" style="margin-top:15px; ">
			  <sec:authorize access="hasRole('Add/Edit Professional Qualification')">
                <input type="button" value="<spring:message code="REF.UI.SAVE"/>" onClick="saveProfessionalQualification(this);" class="button"><input type="button" class="button" onClick="setAddEditPane(this,'Cancel'); clearMessages();" value="<spring:message code="REF.UI.CANCEL"/>">
                </sec:authorize>
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
<h:footer/>
</body>
</html>
