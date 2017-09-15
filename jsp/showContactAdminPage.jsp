<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib uri="/WEB-INF/tags/" prefix="el" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html>
<head>
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
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
  <div id="content_main">

      <div id="login_pane" class="section_full_search">
      	<div style=" float:left; "><img src="resources/images/akura-logo.png" width="100" height="41">  <span style="font-size:14px; color:#356BA7;"><spring:message code="APPLICATION.VERSION"/></span></div>
        <div class="float_right" style="margin:15px 0 5px 0; "><img src="resources/images/virtusa-logo.png"></div>
        <div class="clearfix"></div>
        <div class="box_border">
          <div class="Login_leftblock"><img src="resources/images/logo_large.jpg">
            <div class="school_name"><spring:message code="SCHOOL.NAME"/><span><spring:message code="SCHOOL.TRACKER"/></span></div>
          </div>
          <div class="Login_rightblock">
            <div class="clearfix"></div>
            <div class="box_border"
							style="margin: 23px 10px 0 0; background-image: none;">
							<div class="row">
								<div align="center">
									<span class="required_sign" style="font-size: 14px;"><spring:message
											code="application.contact.admin.error.message" /></span>
								</div>

							</div>
							<div class="clearfix"></div>
						</div>
            </div>
          <div class="clearfix"></div>
          </div>
        </div>
      </div>
  </div>
<h:footer/>
</body>
</html>
