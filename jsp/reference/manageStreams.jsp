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
	function manageDeleteStream(thisObj) {
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		var okfunction = function(){
			document.form.action='manageDeleteStream.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message , okfunction, cancelfunction);
		}
	
	function showArea(){
		   $(document).ready(function() {
				$(".areaTop").hide();
				$(".areaBot").hide();
				$(".area").hide();
			});
	   }
	function showDown(bool){
			var name = '${editpane}';
			if(bool){
			$(document).ready(function() {
			if(name == null){								
		        $(".section_full_inside").hide();			 
			}
			else{			
			$(".section_full_inside").show();
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+25);	
			}
			});
			}
			else{
			var position = $(".section_full_inside").position();			
			scroll(0,position.top+25);	
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
	
                                                                                                                                                                    	var oldDescription;
	function edit(thisVal,streamDescription,stramId){
		oldDescription= streamDescription;
		setAddEditPane(thisVal,'Edit');
		document.form.description.value= streamDescription;
		document.form.streamId.value= stramId;
	}
	
	function displayMessage(){
		var newDescription= document.getElementById("inputVal").value;
		if(newDescription == oldDescription){
			$(".areaBot").show();
			document.getElementsByClassName("areaBot")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
			document.form.action="manageSaveOrUpdateStream.htm"; 
			document.form.submit();
		}
	}

</script>
</head>
<body onLoad="showDown(false),showErrorMessage();">

<h:headerNew parentTabId="26" page="referenceModule.htm"/>

<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME"/></a>&nbsp;&gt;&nbsp;</li>
		<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE"/></a>&nbsp;&gt;&nbsp;</li>
		<li><spring:message code="REF.UI.MANAGE.STUDY.STREAM.TITLE"/></li>
      </ul>
    </div>
    <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageStudyStreamHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP"/></a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="REF.UI.MANAGE.STUDY.STREAM.TITLE"/></h1>
  <div id="content_main">
   <form:form action="#" method="post" commandName="stream" name="form">
   <div class="section_full_search">
   	<sec:authorize access="hasRole('Search Study Stream')">
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="REF.UI.MANAGE.STUDY.STREAM.NAME"/>:</label>
                </div>
                <input type="text" name="searchDescription" value="${searchDescription}">
              </div>
			  <div class="float_right">

                 <div class="buttion_bar_type1">
                <input type="button" value="<spring:message code="REF.UI.SEARCH"/>" onClick="showArea();document.form.action='manageSearchStream.htm'; document.form.submit();" class="button">
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
          </div></sec:authorize>
      </div>
	  <div class="clearfix"></div>
	  <div class="section_box">
	  <div id="search_results">
        <div class="section_box_header">
          <h2><spring:message code="REF.UI.SEARCH.RESULTS"/></h2>
        </div>
        <div class="area">
			<div>
			<!-- update success message comes through query string (after redirecting) -->
			<label class="success_sign"> ${param.addEditDelete}</label>
			</div>
        </div>
        		<div class="areaTop">
       		<div>
             	<c:if test="${message != null}">
               		<div><label class="required_sign">${message}</label> </div>
             	</c:if>
        	</div>
        	<div><form:errors path="description" cssClass="required_sign" /></div>
        </div>
        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th width="852%"><spring:message code="REF.UI.MANAGE.STUDY.STREAM"/></th>
              <th width="56" class="right">
              <sec:authorize access="hasRole('Add/Edit Study Stream')">
              <img src="resources/images/ico_new.gif" class="icon_new" onClick="showArea(),showDown(true);setAddEditPane(this,'Add')
                  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.form.streamId.value='0';
					}
                  " width="18" height="20" title="<spring:message code="REF.UI.MANAGE.STUDY.STREAM.ADD"/>"></sec:authorize></th>
            </tr>
            <c:choose>
            <c:when test="${searchStream != null }">
            <c:forEach var="searchStream" items="${searchStream}" varStatus="status">
             <tr <c:if test="${selectedObjId != null && (selectedObjId == searchStream.streamId)}">class="highlight"</c:if>
            <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              		<td><c:out value="${searchStream.description}"></c:out></td>
           	  		<td nowrap class="right">
           	  		<sec:authorize access="hasRole('Add/Edit Study Stream')">
           	  		<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.STUDY.STREAM.EDIT"/>"
              			onClick="showArea(),showDown(true),edit(this,'<c:out value="${searchStream.description}" />','<c:out value="${searchStream.streamId}"/>');"
              			width="18" height="20" class="icon"></sec:authorize>
              			
              			<sec:authorize access="hasRole('Delete Study Stream')"><img src="resources/images/ico_delete.gif"
              			onClick="showArea();document.form.streamId.value='${searchStream.streamId}';
                        manageDeleteStream(this);" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize></td>
            	</tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            
            <c:choose>
            <c:when test="${not empty streamList }">
            
            <c:forEach var="stream" items="${streamList}" varStatus="status">
            <tr <c:if test="${selectedObjId != null && (selectedObjId == stream.streamId)}">class="highlight"</c:if>
            <c:choose>
            	<c:when test="${(status.count) % 2 == 0}">
            		class="odd"
            	</c:when>
            	<c:otherwise>
            		class="even"
            	</c:otherwise>
            </c:choose>>
              <td><c:out value="${stream.description}"></c:out></td>
           	  		<td nowrap class="right">
           	  		<sec:authorize access="hasRole('Add/Edit Study Stream')">
           	  		<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.STUDY.STREAM.EDIT"/>"
              			onClick="showArea(),showDown(true),edit(this,'<c:out value="${stream.description}" />','<c:out value="${stream.streamId}"/>');"
              			width="18" height="20" class="icon">
              			</sec:authorize>
              			<sec:authorize access="hasRole('Delete Study Stream')">
              			<img src="resources/images/ico_delete.gif"
              			onClick="showArea();document.form.streamId.value='${stream.streamId}';
                        manageDeleteStream(this);" title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon"></sec:authorize></td>
            </tr>
           </c:forEach>
           
           </c:when>
           <c:otherwise>
           <tr>
					<td width="830">
							<h5><spring:message
						code='REF.UI.MANAGE.STUDY.STREAM.NO.RESULTS' /></h5>
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
		<div class="areaBot">
       		<div>
             	<c:if test="${message != null}">
               		<div><label class="required_sign">${message}</label> </div>
             	</c:if>
        	</div>
        	<div><form:errors path="description" cssClass="required_sign" /></div>
        </div>
		<div class="section_full_inside" style='display: ${editpane != null ?'block':'none'}'>
		
	      
		<c:choose>
		<c:when test="${selectedObjId > 0}">
		<h3><spring:message code="REF.UI.MANAGE.STUDY.STREAM.EDIT" /></h3>
		</c:when>
		<c:otherwise>
		<h3><spring:message code="REF.UI.MANAGE.STUDY.STREAM.ADD" /></h3>
		</c:otherwise>
		</c:choose>
		
         
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                   <span class="required_sign">*</span><label><spring:message code="REF.UI.MANAGE.STUDY.STREAM.NAME"/>:</label>
                </div>
              <form:input id="inputVal" path="description" maxlength="45"/>
               <form:hidden path="streamId"/>
              </div>
			  <div class="buttion_bar_type1" style="margin-top:15px; ">
                <input type="button" value="<spring:message code="REF.UI.SAVE"/>"
                onClick="showArea();displayMessage();"
                class="button"><input type="button" class="button" onClick="showArea();setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL"/>">
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
