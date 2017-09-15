<%@page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
</head>

<html>
<title><spring:message code="application.session.timeout.title"/></title>
<body>
<h2><spring:message code="application.session.invalid"/></h2>

<p>
<spring:message code="application.session.timeout.message.partone"/> <a href="<c:url value='/'/>"><spring:message code="application.session.timeout.message.parttwo"/></a>.
</p>
</body>
</html>
