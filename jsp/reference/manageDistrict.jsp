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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	function deleteDistrict(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		var okfunction = function(){
			document.form.action='manageDeleteDistrict.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = '<spring:message code="REF.DELETE.CONFIRMATION" />';
		
		confirm_function(message, okfunction, cancelfunction);
		
		}
	
	function edit(thisVal,discrict,districtId,province ){		
		 setAddEditPane(thisVal,'Edit');
			document.form.description.value= discrict;
			document.form.districtId.value= districtId;
		
			if(province == ""){
				document.getElementById('select').value = document.getElementById('selectOption').value;
			}
			else{
				document.getElementById('select').value = province ;
			}
	}
	
	function showArea() {
		$(document).ready(function() {
			$("#area").hide();
			$(".areaTop").hide();
		});
	}
	function addEditPanelTitle(districtId) {
		if(districtId > 0) {
			$('#addEditPanelTitle').empty();
			$('#addEditPanelTitle').append("<spring:message code='REF.UI.MANAGE.DISTRICT.EDIT' />");
		}
	}
	
	function districtSaveAction(){
		
		var districtLength = $.trim($('#description').val()).length;
		if(districtLength>0){
			document.form.description.value = $.trim($('#description').val());
			document.form.action='manageSaveOrUpdateDistrict.htm'; 
			document.form.submit();
		}else{
			$('#description').val('');
			$('#messageArea').empty();
			var messageDiv = $('<div></div>');
			var errorMessage = $('<label></label>').addClass('required_sign').text("<spring:message code='REF.UI.MANAGE.DISTRICT.REQUIRED.MESSAGE' />");
			errorMessage.appendTo(messageDiv);
			messageDiv.appendTo('#messageArea');
			$("#area").show();
		}
		
	}
	
	function showErrorMessage(){
		if(${del!= null}){	
			$("#area").hide();
		}
		else{
			$(".areaTop").hide();
		}
	}
	
</script>
</head>
<body onload="showErrorMessage(),addEditPanelTitle(${selectedObjId});">
<h:headerNew parentTabId="26" page="referenceModule.htm"/>

<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
        <li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
		<li><spring:message code="REF.UI.MANAGE.DISTRICT.TITLE"/></li>
      </ul>
    </div>
  </div>
  <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageDistrictHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"><spring:message code="REF.UI.HELP"/></a></div>
  <div class="clearfix"></div>
  <h1><spring:message code="REF.UI.MANAGE.DISTRICT.TITLE"/></h1>
  <div id="content_main">
   <form:form action="#" method="post" name="form" commandName="district">
   <div class="section_full_search">
   	<sec:authorize access="hasRole('Search District')">
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                   <label><spring:message code="REF.UI.MANAGE.DISTRICT.NAME"/>:</label>
                </div>
                <input type="text" name="searchDescription" value="${searchDescription}">
              </div>
			  <div class="float_right">

                 <div class="buttion_bar_type1">
                   <input type="button" value="<spring:message code="REF.UI.SEARCH" />" onClick="document.form.action='manageSearchDistrict.htm'; document.form.submit();"
                   class="button">
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
          </div></sec:authorize>
      </div>
	  <div class="section_box">
	  <div id="search_results">
	  
        <div class="section_box_header">
      
          <h2><spring:message code="REF.UI.SEARCH.RESULTS" /></h2>
         
        </div>
        <div class="areaTop">
			<c:if test="${message != null}">
				<div>
					<label class="required_sign">${message}</label>
				</div>
			</c:if>
				<div>
					<form:errors path="description" cssClass="required_sign" />
				</div>
		</div>
  	
        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th width="45%"><spring:message code="REF.UI.MANAGE.DISTRICT.NAME"/></th>
              <th><spring:message code="REF.UI.MANAGE.DISTRICT.PROVINCE"/></th>
              <th width="42" class="right"><sec:authorize access="hasRole('Add/Edit District')"><img src="resources/images/ico_new.gif" class="icon_new" onClick="showArea(),setAddEditPane(this,'Add')
                   if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.getElementById('select').value = document.getElementById('selectOption').value;
						 document.form.districtId.value='0';
					}
                  " width="18" height="20" title="<spring:message code="REF.UI.MANAGE.DISTRICT.ADD"/>"></sec:authorize></th>
            </tr>
            
            <c:choose>
            <c:when test="${searchDistrict != null }">
            <c:forEach var="searchDistrict" items="${searchDistrict}" varStatus="status">
            	<tr <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              		<td><c:out value="${searchDistrict.description}"></c:out></td>
             	 	<td><c:out value="${searchDistrict.province.description}"></c:out></td>
           	  		<td nowrap class="right">
           	  		<sec:authorize access="hasRole('Add/Edit District')">
           	  		<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.DISTRICT.EDIT"/>"
              			onClick=" showArea(),edit(this,'<c:out value="${searchDistrict.description}" />','<c:out value="${searchDistrict.districtId}"/>','<c:out value="${searchDistrict.province.description}" />');"
              			width="18" height="20" class="icon"></sec:authorize>
              			<sec:authorize access="hasRole('Delete District')">
              			<img src="resources/images/ico_delete.gif"
              			onClick="showArea(),document.form.districtId.value='${searchDistrict.districtId}';
                        deleteDistrict(this);" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize></td>
            	</tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
        
           	 	<c:choose>
            	<c:when test="${not empty districtList }">
            	<c:forEach var="district" items="${districtList}" varStatus="status">
           		 <tr <c:if test="${selectedObjId != null && (selectedObjId == district.districtId)}">class="highlight"</c:if>
           		  <c:choose>
            		<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
           		 </c:choose>>
	              <td><c:out value="${district.description}"></c:out></td>
	              <td><c:out value="${district.province.description}"></c:out></td>
	           	  <td nowrap class="right">
	           	  <sec:authorize access="hasRole('Add/Edit District')">
	           	  <img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.DISTRICT.EDIT"/>"
	              onClick=" showArea(),edit(this,'<c:out value="${district.description}" />','<c:out value="${district.districtId}"/>','<c:out value="${district.province.description}" />');"
         	              width="18" height="20" class="icon">
	              </sec:authorize>
	              <sec:authorize access="hasRole('Delete District')">
	              <img src="resources/images/ico_delete.gif"
	              onClick="showArea(),document.form.districtId.value='${district.districtId}';
	              deleteDistrict(this);" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
	              </sec:authorize>
	              </td>
	            </tr>
		           </c:forEach>
		           </c:when>
		           <c:otherwise>
						<tr>
						<td width="830">
									<h5><spring:message
										code='REF.UI.MANAGE.DISTRICT.EMPTY' /></h5>
									</td>
									<td nowrap class="right"></td>
									<td></td>
								
								</tr>
					</c:otherwise>
           
           </c:choose>
           
           </c:otherwise>
           </c:choose>
          </table>
        </div>
		</div>
		<div id="area">
        <div id="messageArea">
       <c:if test="${message != null}">
           <div><label class="required_sign">${message}</label> </div>
        </c:if>
  		</div>
  		<div>
  			<form:errors path="description" cssClass="required_sign" />
  		</div>
  		<div>
  			<form:errors path="province.description" cssClass="required_sign" />
  		</div>
  		</div>
		<div class="section_full_inside" style='display: ${showEditSection != null ?'block':'none'}'>
          <h3 id="addEditPanelTitle"><spring:message code="REF.UI.MANAGE.DISTRICT.ADD"/></h3>
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <label><span class="required_sign">*</span><spring:message code="REF.UI.MANAGE.DISTRICT.NAME"/>:</label>
                </div>
               	    	<form:input path="description" maxlength="45"/>
                		<form:hidden path="districtId"/>
              </div>
			  <div class="float_right">
                <div class="lbl_lock">
                  <label><spring:message code="REF.UI.MANAGE.DISTRICT.PROVINCE"/>:</label>
                </div>
                <form:select path="province.description" id="select">
                	<form:option value="select" id="selectOption"> <spring:message code="application.drop.down"/> </form:option>
                	<form:options itemLabel="description" items="${provinceList}" itemValue="description"/>
                  </form:select>
              </div>
            </div>
            <div class="row">
              <div class="buttion_bar_type1">
                <input type="button" class="button" onClick="districtSaveAction();"
                     value="<spring:message code="REF.UI.SAVE" />"><input type="button" class="button" onClick="showArea(),setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL" />">
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
