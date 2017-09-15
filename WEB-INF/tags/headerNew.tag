<%--
    < CYBERSCHOOL, This application manages the daily activities of a Teacher
   and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
   Author = Eric Brown Appiah
   Contact = 0205212015.
 --%>
 
<%@ taglib prefix="el" uri="/WEB-INF/tags/"%>
<%@ attribute name="parentTabId" required="true" %>
<%@ attribute name="page" required="true" %>
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
    <div class="date_stamp">${el:getDate()} &nbsp;&nbsp;<spring:message code="HEADER.WELCOME.WELCOME"/> ${userLogin.firstName} ${userLogin.lastName}</div>
    <div class="global_links"><a href="adminWelcome.htm"><spring:message code="HEADER.WELCOME.HOME"/></a> | <a href='<c:url value="/j_spring_security_logout"/>'><spring:message code="HEADER.WELCOME.LOGOUT"/></a></div>
    <div class="clearfix"></div>
  </div>
</div>
<div id="banner">
  <div class="bannerwraper">
    <div id="logo"><img src="resources/images/school_logo.jpg" hspace="10" border="0" align="middle"></div>
    <div class="school_name"><spring:message code="SCHOOL.NAME"/><span><spring:message code="SCHOOL.TRACKER"/></span></div>
    <div style="float:right;margin-top: 50px; margin-top: 55px; "><img src="resources/images/virtusa-logo.png" align="bottom"></div>
    <div class="clearfix"></div>
  </div>
  <div class="clearfix"></div>
  <div id="menubar">
    <div class="menubarwraper">
      <ul>
      
     	 	<c:forEach var="tab" items="${el:getTabs(roleTabMap,parentTabId)}" varStatus="status">
     	 	
     	 		<c:set var="pageEle" value="${tab.pages.size() ne 0?tab.pages.toArray()[0]:tab.tabs.toArray()[0].pages.toArray()[0]}" scope="page" />
     	 		
   	 			<li class="${pageEle.url eq page?'selected':''}">
				<a href="${pageEle.url}">${tab.name}</a></li>     
			</c:forEach>
			

      </ul>
    </div>
  </div>
</div>
