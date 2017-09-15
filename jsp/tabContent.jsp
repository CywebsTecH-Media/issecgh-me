<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
<head>
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
</head>	

<!--show child tabs -->
<c:forEach items="${childTab.tabs}" var="childTab">
	<li id="TAB_${childTab.tabId}" class="folder">${childTab.name}
	
	<ul>
	<!--check for the childTab tabs -->
    <c:if test="${childTab.tabs.size() ne '0'}">
    	<div>test </div>
		<c:set var="childTab" value="${childTab}" scope="request"/>
		<jsp:include page="tabContent.jsp"/>
	</c:if>
	
	<!--  show pages -->
	<c:forEach items="${childTab.pages}" var="page">
		<li id="PAGE_${page.pageId}" class="folder">${page.name}
		<!--show privileges -->
		<ul>
			<c:forEach items="${page.privileges}" var="privilege">
				<c:set var="checkPrivilege" value="" />
				<c:forEach items="${rolePrivilegeList}" var="rolePrivilege">
					<c:if test="${rolePrivilege.privilegeId eq privilege.privilegeId}">
						<c:set var="checkPrivilege" value="selected" />
					</c:if>
				</c:forEach>
				<li id="PRIVILEGE_${privilege.privilegeId}" class="${checkPrivilege}">${privilege.name}
				
			</c:forEach>
		</ul>
		<!--end privileges -->
	</c:forEach>
	<!--  end pages -->
	</ul>
</c:forEach>
<!--end child tabs -->
