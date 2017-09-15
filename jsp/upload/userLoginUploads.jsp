<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.blockUI.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>

<script type="text/javascript" src="resources/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="resources/js/messageCommon.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>

<script type="text/javascript">
	function loadZipFileDownload() {
			var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
			
			var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
			
			var command=function() 
		    {
		    	$( this ).dialog( "close" );
		    	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#fileName').val()+"&filePaths="+$('#filePaths').val());    	
		    	
		    };
			
			custom_alert_for_bulkupload(message,command);
						
	}
	
	
	function onUploaduserlogin(){

		bulkUploadBlockUI();
		document.loginUpload.submit();
	}
	
	
	</script>
</head>
<body>
	<h:headerNew parentTabId="57" page="userLoginUpload.htm" />

	<div id="page_container">
		<div id="breadcrumb">
			<sec:authorize access="hasRole('User Login Uploads')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="BULK.UPLOAD.USER.LOGIN.IMPORTS" />
					</li>
				</ul>
			</sec:authorize>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/bulk/BulkParenLoginUpload.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="BULK.UPLOAD.USER.LOGIN.IMPORTS"/></h1>
		<div class="section_full_inside">	
		<div class="box_border">
		<div id="content_main">
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="bulkUploadedFile" action="parentLoginUpload.htm" name="loginUpload">
				<input type="hidden" id="fileName" value ="${zipPath}"/>
				<input type="hidden" id="filePaths" value="${filePaths}" />
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.PARENT.USER.LOGIN.IMPORTS.TITLE"/></h2>
					</div>
					<div class="messageArea">
						<label class="success_sign">${message}</label>
						<label class="required_sign">${parenterrmessage}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exception}</label>
					</div>	
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="loginUpload" type="file" style="width: 290px;" value=""/>								
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploaduserlogin();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<c:if test="${popupavailableStaff != null}">
	
								<script>
								loadZipFileDownload();
								</script>
							</c:if>
			</form:form>
			
			
		</div>
		</div>
		</div>
	</div>
<h:footer />
</body>
</html>