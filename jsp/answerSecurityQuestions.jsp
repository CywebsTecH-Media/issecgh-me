<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="/WEB-INF/tags/" prefix="el" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title><spring:message code="application.securityquestions.pagetitle"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />
<script language="javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<script type="text/javascript">
  function submitAnswers(){
	document.submitAnswers.action="submitAnswers.htm";
	document.submitAnswers.submit();

  }

  function reset(){
	  document.submitAnswers.action="answerSecurityQuestions.htm";
	  document.submitAnswers.submit();
	
  }
  
</script>
</head>
<body>
<div align="center">
<div id="topbar">
  <div id="topbar_wraper">
    <div id="topbar_wraper">
			<div class="date_stamp">${el:getDate()} | <a style="color: white;" href="login.htm"><spring:message code="application.login.url"/></a></div>
			<div class="clearfix"></div>
		</div>
  </div>
</div>
<div id="page_container">
  <div class="clearfix"></div>
  <div id="content_main">
   <form:form method="POST" action="submitAnswers.htm" commandName="submitAnswers" name="submitAnswers">

      <div id="login_pane" class="section_full_search">
        <div class="float_right" style="margin:15px 0 5px 0; "><img src="resources/images/virtusa-logo.png"></div>
        <div class="clearfix"></div>
        <div class="box_border">
        <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/answerSecurityQuestions.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
          <div class="Login_leftblock"><img src="resources/images/logo_large.jpg">
            <div class="school_name"><span><spring:message code="SCHOOL.NAME"/></span><span><spring:message code="SCHOOL.TRACKER"/></span></div>
          </div>
          <div class="Login_rightblock">
            <div class="clearfix"></div>
            <div class="box_border" style="margin:40px 20px 0 0; background-image:none; ">
			<div class="row" name="questionsExistMessage" id="questionsExistMessage">
								<div class="frmvalue">
									<span class="required_sign"><c:if
											test="${questionsExistMessage != null}">${questionsExistMessage}
									</c:if>                                    
											
									</span>
								</div>
							</div>
            <label class="required_sign"> <spring:bind path="submitAnswers.*">
		<c:forEach items="${status.errorMessages}" var="error">
			<c:out value="${error}" />
			<br>
		</c:forEach>
	</spring:bind></label>
	
          
			
							
            <div class="row">
            <div class="frmlabel"><label><spring:message code="application.securityquestions.questionone"/>
	</label></div>
	<div class="frmvalue">
			<form:hidden path="userQuestionOne.securityQuestions.securityQuestionsId" id="userQuestionOne.securityQuestions.securityQuestionsId"/>
		</div>
		<div class="frmvalue">
			<form:input path="userQuestionOne.securityQuestions.securityQuestion" id="userQuestionOne.securityQuestions.securityQuestion" readonly="true"/>
		</div>
		
		<div class="row">
            					
								<div class="frmlabel">
									<span class="required_sign">*</span><label><spring:message code="application.securityquestions.answer"/></label>
								</div>
								
								
								<div class="frmvalue">
									<form:input path="userQuestionOne.answer" id="userQuestionOne.answer"/>
									</div>
									
							</div>
	
	 <div class="frmlabel"><label><spring:message code="application.securityquestions.questiontwo"/>
	</label></div>
	<div class="frmvalue">
			<form:hidden path="userQuestionTwo.securityQuestions.securityQuestionsId" id="userQuestionTwo.securityQuestions.securityQuestionsId" />
		</div>
		<div class="frmvalue">
			<form:input path="userQuestionTwo.securityQuestions.securityQuestion" id="userQuestionTwo.securityQuestions.securityQuestion" readonly="true"/>
		</div>
		
		</div>
		
		<div class="row">
            					
								<div class="frmlabel">
									<span class="required_sign">*</span><label><spring:message code="application.securityquestions.answer"/></label>
								</div>
								
								
								<div class="frmvalue">
									<form:input path="userQuestionTwo.answer" id="userQuestionTwo.answer" />
									</div>
									
							</div>
		
           
	<div class="clearfix"></div>
              <div class="row">
                <div class="frmlabel"> &nbsp; </div>
                <div class="frmvalue">
                  <div class="buttion_bar_type3" >
              
                   <input type="submit" value='<spring:message code="REF.UI.SUBMIT"/>' class="button" onclick=""/>
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
  </div>

<h:footer/>
</div>
</body>
</html>
