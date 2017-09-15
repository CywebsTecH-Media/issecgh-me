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

<!DOCTYPE HTML>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/main.js"></script>

<script type="text/javascript">
	function preview(){
		var comment =  document.getElementById("id").value;
		document.form.action = "studentProgressPdf.htm";
		document.form.target = "blank";
		if (comment.length == 0){
			document.getElementById("errorComment").style.display = "";
			} else {
				document.getElementById('errorComment').style.display="none";
		document.form.submit();
			}
	}
	
	//Limit no of characters in the text area input .
	function limitText(limitField, limitCount, limitNum) {
		if (limitField.value.length > limitNum) {
			limitField.value = limitField.value.substring(0, limitNum);
		} else {
			limitCount.value = limitNum - limitField.value.length;
		}
	}

	function submitForm(){
		document.form.action = "EmailProgressSummary.htm";
		document.form.submit();
	}
</script>
</head>
<body>
<h:headerNew parentTabId="11" page="studentProgressReport.htm"/>

<div id="page_container">

  <div id="breadcrumb_area">
  <div id="breadcrumb">
    <ul>
      <li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
      <sec:authorize access="hasAnyRole('Student Search')">
			<li><a href="studentSearch.htm"><spring:message code="STUDENT.PROGRESS.SUMMARY.STUDENT.SEARCH.LINK"/></a>&nbsp;&gt;&nbsp;</li>
		</sec:authorize>
      <li><spring:message code="STUDENT.PROGRESS.SUMMARY.TITLE"/> </li>
    </ul>
  </div>
  <div class="help_link"><a href="#"
	onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentProgressHelp.html"/>','helpWindow',780,550)"><img
	src="resources/images/ico_help.png" width="20" height="20"
	align="absmiddle"><spring:message code="application.help"/> </a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="STUDENT.PROGRESS.SUMMARY.TITLE"/> </h1>
  <div id="content_main">

<c:choose><c:when test="${not empty studentGrade}">

  <c:if test="${message != null}">
       <div class="required_sign">&nbsp;&nbsp;&nbsp;${message}</div>
  </c:if>
  <div id="errorComment" class="required_sign" style="display:none;"><spring:message code="STUDENT.PROGRESS.SUMMARY.COMMENT.MASSEGE"/></div>
<form action="" method="post" name="form" target="">

    <div class="clearfix"></div>

	<div class="section_full_inside">
          <h3><span class="required_sign">*</span><spring:message code="STUDENT.PROGRESS.SUMMARY.GENERAL.COMMENTS"/></h3>
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <textarea name="comments" cols="" rows="5" style="width:895px;" id="id" onkeydown="limitText(this.form.id,this.form.countdown,450);" onkeyup="limitText(this.form.id,this.form.countdown,450);" >${comments}</textarea>
              </div>
            </div>
			<div class="buttion_bar_type2" >
			<sec:authorize access="hasRole('Preview Message Board Report')">
          <input type="button" value="<spring:message code="STUDENT.PROGRESS.UI.PREVIEW.REPORT"/>" class="button" onclick="preview()" >
          </sec:authorize>
          <sec:authorize access="hasRole('Send Message Board Email')">
          <input type="button" value="<spring:message code="STUDENT.PROGRESS.UI.SEND.EMAIL"/>" class="button" onClick="submitForm()" >
          </sec:authorize>
        </div>
            <div class="clearfix"></div>
          </div>
        </div>
		<div>

        <div class="clearfix"></div>
      </div>
</form>
</c:when>
		<c:otherwise>
			<h3><spring:message code="STUDENT.SWIP.IN.OUT.UI.ASSIGN_CLASS" /></h3>
		</c:otherwise>
</c:choose>

  </div>
</div>
<h:footer />
</body>
</html>

