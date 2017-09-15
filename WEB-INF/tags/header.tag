<%--
    < CYBERSCHOOL, This application manages the daily activities of a Teacher
       and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
       Author = Eric Brown Appiah
       Contact = 0205212015.
 --%>
 
<%@ taglib prefix="el" uri="/WEB-INF/tags/"%>
<%@ attribute name="tabName" required="true" %>
<%@ attribute name="page" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
    <div style="float:right;margin-top: 50px; margin-top: 55px; "><img src="resources/images/virtusa-logo.jpg" align="bottom"></div>
    <div class="clearfix"></div>
  </div>
  <div class="clearfix"></div>
  <div id="menubar">
    <div class="menubarwraper">
      <ul>
      
      
     	 	<c:forEach var="item" items="${el:getTabContent(data,tabName)}" varStatus="status">
     	 	
     	 	<sec:authorize access="hasRole('ROLE_ADMIN')">
     	 		<c:if test="${fn:split(item,':')[0] ne ' Message To Teacher'}"> 
					<li class="${page eq fn:split(item,':')[1]? 'selected': ''}">
					<a href="${page eq fn:split(item,':')[1]? '#':fn:split(item,':')[1]}">${fn:split(item,':')[0]}</a></li>     
				</c:if>		 	
     	 	</sec:authorize>
     	 	<sec:authorize access="hasRole('ROLE_TEACHER')">
     	 		<c:if test="${fn:split(item,':')[0] ne 'Reference Module' and fn:split(item,':')[0] ne ' School Module' and fn:split(item,':')[0] ne ' Staff Attendance' and fn:split(item,':')[0] ne ' Staff General Reports' and fn:split(item,':')[0] ne ' Staff Attendance Reports' and fn:split(item,':')[0] ne ' Message To Teacher' and fn:split(item,':')[0] ne ' User Management'}">  
					<li class="${page eq fn:split(item,':')[1]? 'selected': ''}">
					<a href="${page eq fn:split(item,':')[1]? '#':fn:split(item,':')[1]}">${fn:split(item,':')[0]}</a></li>  
				</c:if>   	 	
     	 	</sec:authorize>
     	 	<sec:authorize access="hasRole('ROLE_CLERICALSTAFF')">
     	 		<c:if test="${fn:split(item,':')[0] eq ' Staff Module' or fn:split(item,':')[0] eq 'Staff Search' or fn:split(item,':')[0] eq 'Staff Member Details' or fn:split(item,':')[0] eq ' Qualifications' or fn:split(item,':')[0] eq ' Extra Curricular' or fn:split(item,':')[0] eq ' Leave'}">    
					<li class="${page eq fn:split(item,':')[1]? 'selected': ''}">
					<a href="${page eq fn:split(item,':')[1]? '#':fn:split(item,':')[1]}">${fn:split(item,':')[0]}</a></li>  
				</c:if>   	 	
     	 	</sec:authorize>
     	 	<sec:authorize access="hasRole('ROLE_STUDENT')">
     	 		<c:if test="${tabName eq 'StudentDetails' and fn:split(item,':')[0] ne ' Message Board' and fn:split(item,':')[0] ne ' Message To Teacher'}">     	 		
     	 			<li class="${page eq fn:split(item,':')[1]? 'selected': ''}">
					<a href="${page eq fn:split(item,':')[1]? '#':fn:split(item,':')[1]}">${fn:split(item,':')[0]}</a></li>
     	 		</c:if>
     	 	</sec:authorize>
     	 	<sec:authorize access="hasRole('ROLE_PARENT')">
     	 		<c:if test="${tabName eq 'ParentMain' or tabName eq 'StudentDetails' and fn:split(item,':')[0] ne ' Message Board'}">     	 		
     	 			<li class="${page eq fn:split(item,':')[1]? 'selected': ''}">
					<a href="${page eq fn:split(item,':')[1]? '#':fn:split(item,':')[1]}">${fn:split(item,':')[0]}</a></li>
     	 		</c:if>
     	 	</sec:authorize>
     	 	
			</c:forEach>
			
<%-- 			<c:forEach var="item" items="${el:getTabContent(data,tabName)}" varStatus="status"> --%>
<!-- 					set the selected link lable -->
<%-- 					<c:if test="${page eq item.split(":")[1]">  --%>
<%-- 						<c:set var="selected" value="${item.split(":")[0]}" scope="page"/> --%>
<%-- 					</c:if> --%>
					
<%-- 					<li class="${page eq item.split(":")[1]? 'selected': ''}"> --%>
<%-- 					<a href="${page eq item.split(":")[1]? '#':item.split(":")[1]}">${item.split(":")[0]}</a></li> --%>
<%-- 			</c:forEach> --%>

      </ul>
    </div>
  </div>
</div>
<!-- <div id="page_container"> -->
<!-- <div id="breadcrumb"> -->
<!--     <ul> -->
<!--       <li><a href="AdminWelcome.htm">Home</a>&nbsp;&gt;&nbsp;</li> -->
<!--       <li><a href="AdminWelcome.htm">Home</a>&nbsp;&gt;&nbsp;</li> -->
<%--       <li>${selected}</li><br> --%>
<!--     </ul> -->
<!--   </div> -->