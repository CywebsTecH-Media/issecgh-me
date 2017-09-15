<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<script type="text/javascript">
	//function showErrorDetails(){
		//$("#errorDesc").toggle( "slow" );
	//}
</script>
</head>
<body>
<div id="topbar">
  <div id="topbar_wraper">
    <div class="date_stamp">${el:getDate()} &nbsp;&nbsp;<spring:message code="HEADER.WELCOME.WELCOME"/> ${userLogin.firstName} ${userLogin.lastName}</div>
    <div class="global_links"><a href="adminWelcome.htm"><spring:message code="HEADER.WELCOME.HOME"/></a> | <a href='<c:url value="/j_spring_security_logout"/>'><spring:message code="HEADER.WELCOME.LOGOUT"/></a></div>
    <div class="clearfix"></div>
  </div>
</div>
<div id="page_container">
  <div class="clearfix"></div>
  <div id="content_main">
      <div id="login_pane" class="section_full_search">
        <div class="float_right" style="margin:15px 0 5px 0; "><img src="resources/images/virtusa-logo.png"></div>
        <div class="clearfix"></div>
        <div class="box_border">
          <div class="Login_leftblock"><img src="resources/images/logo_large.jpg">
            <div class="school_name"><spring:message code="SCHOOL.NAME"/><span><spring:message code="SCHOOL.TRACKER"/></span></div>
          </div>
          <div class="Login_rightblock" style="margin: 10px 170px 0 0;">
			<div class="clearfix"></div>
			<div class="box_border" style="margin: 23px 10px 0 0; background-image: none; color:#637ED7;">
				<div class="row">
                	<p class="errorTitle"><spring:message code="ERROR.TITLE"/></p>
                	<div style="margin-bottom:-10px !important; "><spring:message code="ERROR.DESCRIPTION.HEADING"/></div>
					<div class="errorMsg">
				     	<spring:message code="ERROR.DESCRIPTION.DATABASE"/>
					</div>
				
					<div style="line-height:17px;">
						<spring:message code="ERROR.SUPPORT.DESCRIPTION.PART1"/> 
						<i><b> <spring:message code="ERROR.SUPPORT.EMAIL"/> </b></i> <spring:message code="ERROR.SUPPORT.DESCRIPTION.PART2"/>
					</div>
					<div><spring:message code="ERROR.APOLOGIZE"/> </div>
					
					
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

