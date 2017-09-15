<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="/WEB-INF/tags/" prefix="el"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<html>
<head>
<title><spring:message code="APPLICATION.NAME"/> <spring:message code="application.verificationCode.pagetitle"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script language="javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<script type="text/javascript">

	// Reset VerificationCode form and error section.
	function reSet() {
		document.forms["enterVerification"]["verificationCode"].value = "";
		document.getElementById('errorSection').style.display = 'none';
	}
	
</script>

</head>
<body>
	<div id="topbar">
		<div id="topbar_wraper">
			<div class="date_stamp">${el:getDate()} | <a style="color: white;" href="login.htm"><spring:message code="application.login.url"/></a></div>
			<div class="clearfix"></div>
		</div>
	</div>
	<div id="page_container">
		<div class="clearfix"></div>
		<div id="content_main"></div>

		<form:form method="POST" action="submitUserVerificationCode.htm" commandName="userLogin"
			name="enterVerification">

			<div id="login_pane" class="section_full_search">
				<div class="float_right" style="margin: 15px 0 5px 0;">
					<img src="resources/images/virtusa-logo.png">
				</div>
				<div class="clearfix"></div>
				<div class="box_border">
				<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/enterverificationcode.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"><spring:message code="application.help"/></a></div>
					<div class="Login_leftblock">
						<img src="resources/images/logo_large.jpg">
						<div class="school_name">
							<span><spring:message code="SCHOOL.NAME"/></span><span><spring:message code="SCHOOL.TRACKER"/></span>
						</div>
					</div>
					<div class="Login_rightblock">

						<div class="clearfix"></div>
						<div class="box_border"
							style="margin: 23px 10px 0 0; background-image: none;">
							<div class="row" name="errorSection" id="errorSection">
								<div class="frmvalue">
									<span class="required_sign"><c:if
											test="${verifyError != null}">${verifyError}
									</c:if>                                    
									</span>
								</div>
							</div>
							<div class="row" name="errorMessage" id="errorMessage">
								<div class="frmvalue">
									<label class="required_sign"> <spring:bind
											path="userLogin.*">
											<c:forEach items="${status.errorMessages}" var="error">
												<c:out value="${error}" />
												<br>
											</c:forEach>
										</spring:bind></label>
								</div>
							</div>
							<div class="row">
								<div class="frmlabel" align="left" style="width: 150px">
									<span class="required_sign">*</span><label><spring:message code="application.verificationCode.verification"/></label>
								</div>
								<div class="frmvalue" style="width: 150px">
						
									<form:input style="width: 160px" path="verificationCode" />
				
								</div>
									<form:hidden path="username" />
									</div>
							<div class="row">
								<div class="frmlabel">&nbsp;</div>
								<div class="frmvalue">
									<div class="buttion_bar_type3">

										<input type="submit"
											value='<spring:message code="ADMIN.WELCOME.NEXT"/>' class="button"> <input type="button"
											name="reset" value='<spring:message code="REF.UI.RESET"/>' class="button" onclick="reSet();">
									</div>
								</div>			
							</div>
							

							<div class="clearfix"></div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</form:form>
	</div>
	<h:footer />
</body>
</html>
