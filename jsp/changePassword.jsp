<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="/WEB-INF/tags/" prefix="el" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title><spring:message code="application.changePassword.pagetitle"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script language="javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<script language="javascript">
//score the password
function scorePassword(pass) {
    var score = 0;
    if (!pass)
        return score;

    // award every unique letter until 5 repetitions
    var letters = new Object();
    for (var i=0; i<pass.length; i++) {
        letters[pass[i]] = (letters[pass[i]] || 0) + 1;
        score += 4.0 / letters[pass[i]];
    }

    // bonus points for mixing it up
    var variations = {
        digits: /\d/.test(pass),
        lower: /[a-z]/.test(pass),
        upper: /[A-Z]/.test(pass),
        nonWords: /\W/.test(pass),
    }

    variationCount = 0;
    for (var check in variations) {
        variationCount += (variations[check] == true) ? 1 : 0;
    }
    score += (variationCount -1) * 15;

    return parseInt(score);
}

//Good passwords start to score around 60 or so, here's function to translate that in words:
function checkPassStrength(pass) {
	
	if(pass.length>=8){
		var score = scorePassword(pass);
	    if (score >= 80)
	        return "strong|Strong";
	    if (score < 80 && score >= 60)
	        return "good|Good";
	    if (score < 60 && score >= 30)
	        return "average|Average";
	    if (score < 30)
	        return "weak|Weak";
	}
    return "tooshort|Too Short";
}

//rate and populate the password strenghBar
function populateStrengthBar(pass){
	
		var bar = document.getElementById("strengthBar");
		var label = document.getElementById("strengthBarLabel");
		var div = document.getElementById("strengthBarLabeldiv");
		
	if(pass.length>0){
		var rate = checkPassStrength(pass);
		div.style.display = 'block';
		bar.className=rate.split('|')[0];
		label.innerText=rate.split('|')[1]; 
		label.textContent =rate.split('|')[1]; 
	}else{
		div.style.display = 'none';
	}
}

</script>


<!-- css & js for tool tip -->
<link rel="stylesheet" href="resources/css/jquery.tooltip.css" type="text/css" />
<script type="text/javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.tooltip.js"></script>
<script type="text/javascript">
  $j = jQuery.noConflict();
  $j(document).ready(function(){
    $j("input.item").tooltip();

  });
</script>

</head>
<body>
<div align="center">
<div id="topbar">
  <div id="topbar_wraper">
    <div class="date_stamp">${el:getDate()} | <a style="color: white;" href="login.htm"><spring:message code="application.login.url"/></a></div>
  </div>
</div>
<div id="page_container">
  <div class="clearfix"></div>
  <div id="content_main">
   <form:form method="POST" action="submitPassword.htm" commandName="submitPassword" name="submitPassword">

      <div id="login_pane" class="section_full_search">
        <div class="float_right" style="margin:15px 0 5px 0; "><img src="resources/images/virtusa-logo.png"></div>
        <div class="clearfix"></div>
        <div class="box_border">
        <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/changePasswordHelp.html"/>','helpWindow',780,580)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
          <div class="Login_leftblock"><img src="resources/images/logo_large.jpg">
           <div class="school_name">
							<span><spring:message code="SCHOOL.NAME"/></span><span><spring:message code="SCHOOL.TRACKER"/></span>
						</div>
          </div>
          <div class="Login_rightblock">
            <div class="clearfix"></div>
            <div class="box_border" style="margin:40px 20px 0 0; background-image:none; ">
            <label class="required_sign"> <spring:bind path="submitPassword.*">
		<c:forEach items="${status.errorMessages}" var="error">
			<c:out value="${error}" />
			<br>
		</c:forEach>
	</spring:bind></label>
					
            <div class="row">
            <div class="frmlabelchangepassword"><span class="required_sign">*</span><label><spring:message code="application.changePassword.oldpassword"/> 
	</label><p></div>
	<div class="frmvaluechangepassword">
			<form:password path="oldPassword" id="userLogin.oldPassword" />
		</div>
		</div>
		<div class="row">
	 <div class="frmlabelchangepassword"><span class="required_sign">*</span><label><spring:message code="application.changePassword.newpassword"/> 
	</label><p></div>
	
	
	<div class="frmvaluechangepassword">
			<form:password path="newPassword" id="userLogin.newPassword" onchange="populateStrengthBar(this.value)" onkeyup="populateStrengthBar(this.value)" onpaste="return false" class="item"/>
	
			<div class="tooltip_description" style="display: none">
					<div align="left" style="font-weight:bold;" >To secure your password:</div>
					<div id="toolpipText">
		                                    <ul  >
						<li> - Use both letters and numbers</li>
						<li> - Add special characters (such as $, &, ?)</li>
						<li> - Mix uppercase and lowercase letters</li>
					</ul>
		        	</div>
				</div>
	</div>
		
		
		</div>
		<div class="row">
	 <div class="frmlabelchangepassword"><span class="required_sign">*</span><label><spring:message code="application.changePassword.confirmpassword"/> 
	</label></div>
	<div class="frmvaluechangepassword">
			<form:password path="confirmPassword" id="userLogin.confirmPassword" onpaste="return false"/>
		</div>
		</div>
		
		<div class="row" id="strengthBarLabeldiv" style="display: none; ">
	         <div class="frmlabel"> </div>
	         <div class="frmvalue">
	          <div class="passwordrow">
	          <div class="strengthBar">
	          <div id="strengthBar" class="average"></div></div> 
	          <div class="clearfix"></div>
	          <div>
	          	<strong>Password strength:</strong>
	          	 <span id="strengthBarLabel"></span>
	          </div>
	         	</div>
	         </div>
     	</div>
           
	<div class="clearfix"></div>
              <div class="row">
                <div class="frmlabel"> &nbsp; </div>
                <div class="frmvalue">
                  <div class="buttion_bar_type3" >
              
                   <input type="submit" value='<spring:message code="ADMIN.WELCOME.NEXT"/>' class="button" />
</div>
                </div>
                
              </div>
              <div class="clearfix"></div>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
     </div>
     
     <form:hidden path="username" value="${submitPassword.username }"/>
     <form:hidden path="email" value="${submitPassword.email }"/>
     
    </form:form>
     </div>
  </div>
<h:footer/>
</div>
</body>
</html>
