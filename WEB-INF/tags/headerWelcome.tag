<%--
    < CYBERSCHOOL, This application manages the daily activities of a Teacher
   and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
   Author = Eric Brown Appiah
   Contact = 0205212015.
 --%>
 
<%@ taglib prefix="el" uri="/WEB-INF/tags/"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
</head>

<!-- load property file values into the 'data' variable -->
<fmt:setBundle basename="header" var="propData" scope="page"/>
<c:set var="data" value="${propData.resourceBundle}" scope="page"/>

<div id="topbar">
  <div id="topbar_wraper">
    <div class="date_stamp">${el:getDate()} &nbsp;&nbsp;<spring:message code="HEADER.WELCOME.ANYUSER"/></div>
    <div class="global_links"><a href='<c:url value="/login.htm"/>'><spring:message code="HEADER.WELCOME.LOGIN"/></a></div>
    <div class="clearfix"></div>
  </div>
</div>
<div id="banner">
  <div class="bannerwraper">
    <div id="logo"><a href='<c:url value="/"/>'><img src="resources/images/school_logo.jpg" hspace="10" border="0" align="middle"></a></div>
    <div class="school_name"><spring:message code="SCHOOL.NAME"/><span><spring:message code="SCHOOL.TRACKER"/></span></div>
    <div style="float:right;margin-top: 50px; margin-top: 55px; "><a href="//www.cywebstech.com" target="_blank"><img src="resources/images/abmsoft-logo.png" align="bottom"></a></div>
    <div class="clearfix"></div>
  </div> 
   <div class="clearfix"></div> 
   <div class="clearfix"></div> 
   <div id="menubar">
    <div class="menubarwraper">
    </div>
    </div>
</div>
