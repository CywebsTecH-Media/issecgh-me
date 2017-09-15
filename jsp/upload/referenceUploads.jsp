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
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
		
function loadZipFileDownloadGrade() {
			var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
			
			var command=function() 
            {
            	$( this ).dialog( "close" );
            	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#gradefileName').val()+"&filePaths="+$('#gradefilePaths').val());
            	
            };
			
			custom_alert_for_bulkupload(message,command);
			
			
	}
function loadZipFileDownloadClass() {
		
	var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
	
	var command=function() 
    {
    	$( this ).dialog( "close" );
    	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#classfileName').val()+"&filePaths="+$('#classfilePaths').val());    	
    	
    };
	
	custom_alert_for_bulkupload(message,command);
	
	
	}
	
function loadZipFileDownloadSubject() {
	
	var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
	
	var command=function() 
    {
    	$( this ).dialog( "close" );    	
		window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#subjectFileName').val()+"&filePaths="+$('#subjectFilePath').val());    	
    };
	
	custom_alert_for_bulkupload(message,command);
	
	
	}

/*
 * onClick function for class upload
 */
function onUploadClasses(){

	bulkUploadBlockUI();
	document.classUploadForm.action = 'classfileUpload.htm';
	document.classUploadForm.submit();
}

/*
 * onClick function for grade upload
 */
function onUploadGrades(){

	bulkUploadBlockUI();
	document.gradeUploadForm.action = 'gradefileUpload.htm';
	document.gradeUploadForm.submit();
}

/*
 * onClick function for subjects upload
 */
function onUploadSubjects(){

	bulkUploadBlockUI();
	document.subjectUploadForm.action = 'subjectfileUpload.htm';
	document.subjectUploadForm.submit();
}

</script>

</head>
<body>
	<h:headerNew parentTabId="57" page="referenceUploads.htm" />

	<div id="page_container">
		<div id="breadcrumb">
			<sec:authorize access="hasRole('Reference Uploads')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="BULK.UPLOAD.REFERENCE.IMPORTS" />
					</li>
				</ul>
			</sec:authorize>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/bulk/BulkReferenceAddClassGradeSubject.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="BULK.UPLOAD.REFERENCE.IMPORTS"/></h1>
		<div class="section_full_inside">
		<div class="box_border">
		<div id="content_main">
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedClassFile" action="classfileUpload.htm" name="classUploadForm">
				<input type="hidden" id="classfileName" value ="${zipPath}"/>				
				<input type="hidden" id="classfilePaths" value="${filePaths}" />
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.CLASSES.IMPORTS.TITLE"/></h2>
						</div>
											<div class="messageArea">
						<label class="success_sign">${classmessage}</label>
						<label class="required_sign">${classerrmessage}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exception}</label>
						
					</div>
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<!-- <input name="classFile" type="file" style="width: 290px;" value="">  -->
								<input name="classUpload" type="file" style="width: 290px;" id="classUpload" >
								
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploadClasses();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>

					</div>

					<div class="clearfix"></div>
				</div>
						<c:if test="${popupavailableClass != null}">
	
								<script>
								loadZipFileDownloadClass();
								</script>
							</c:if>


			</form:form>
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedGradeFile" action="gradefileUpload.htm" name="gradeUploadForm">
				<input type="hidden" id="gradefileName" value ="${zipPath}"/>				
				<input type="hidden" id="gradefilePaths" value="${filePaths}" />
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.GRADES.IMPORTS.TITLE"/></h2>
					</div>
																<div class="messageArea">
						<label class="success_sign">${grademessage}</label>
						<label class="required_sign">${gradeerrmessage}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exception}</label>
						
					</div>
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="gradeUpload" type="file" style="width: 290px;" id="gradeUpload">
								
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploadGrades();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>

					</div>



					<div class="clearfix"></div>
				</div>
					<c:if test="${popupavailableGrade != null}">
	
								<script>
								loadZipFileDownloadGrade();
								</script>
							</c:if>
			</form:form>
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedSubjectFile" action="subjectfileUpload.htm" name="subjectUploadForm">
				<input type="hidden" name="fileName" value ="${zipPath}" id="subjectFileName"/>
				<input type="hidden" name=fileType value ="zip"/>
				<input type="hidden" name=filePaths value="${filePaths}" id="subjectFilePath"/>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.SUBJECTS.IMPORTS.TITLE"/></h2>
					</div>
					<div class="messageArea">
						<label class="success_sign">${subjectmessage}</label>
						<label class="required_sign">${subjecterrmessage}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exception}</label>
						
					</div>
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="subjectUpload" type="file" style="width: 290px;" id="subjectUpload">
								
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploadSubjects();"  value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>

						
					</div>



					<div class="clearfix"></div>
				</div>
				<c:if test="${popupavailableSubject != null}">
	
								<script>
								loadZipFileDownloadSubject();
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