<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<head>
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
</head>
<%-- Redirected because we can't set the welcome page to a virtual URL. --%>
<%-- <c:redirect url="/login.htm"/> --%>
<sec:authorize access="isAnonymous()">
<c:redirect url="/welcomeAll.htm"/>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
<c:redirect url="/adminWelcome.htm"/>
</sec:authorize>

