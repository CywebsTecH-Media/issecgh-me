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
<script type="text/javascript" src="resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<!-- Calender controll CSS and JS -->
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>

<script type="text/javascript">
	function hideErrorField(){
		$("#areaTop").hide();
	}
</script>

</head>
<body>
	<h:headerNew parentTabId="57" page="templateDownloads.htm" />

	<div id="page_container">
		<div id="breadcrumb">
			<sec:authorize access="hasRole('Templates')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="BULK.UPLOAD.TEMPLATES" />
					</li>
				</ul>
			</sec:authorize>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/bulk/BulkTemplates.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		
		<h1><spring:message code="BULK.UPLOAD.TEMPLATES"/></h1>
		<div class="section_full_inside">
			<div id="areaTop">
				<c:if test="${message != null}">
					<div>
						<label class="required_sign">${message}</label>
					</div>
				</c:if>
				<div>
					<form:errors path="description" cssClass="required_sign" />
				</div>
			</div>
		
		<div class="box_border">
		<div id="content_main">

			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="uploadedFile" action="downloadTemplates.htm" name="">
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.STAFF.TEMPLATES.TITLE"/></h2>
					</div>
					<div>
						<div id="singleColumn">
						<div class="row">					
						<input type="checkbox" class="checkbox" name="templateDownload" value="staffTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=staffTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.STAFF"/></a>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>


				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.STUDENT.TEMPLATES.TITLE"/></h2>
					</div>
					<div>
						<div id="singleColumn">
						<div class="row">					
						<input type="checkbox" class="checkbox" name="templateDownload" value="studentTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=studentTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.STUDENT"/></a><br>
						<input type="checkbox" class="checkbox" name="templateDownload" value="parentTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=parentTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.PARENT"/></a><br>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>				
				</div>
			
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.REFERENCE.TEMPLATES.TITLE"/></h2>
					</div>
					<div>
						<div id="singleColumn">
						<div class="row">					
						<input type="checkbox" class="checkbox" name="templateDownload" value="classTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=classTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.CLASS"/></a><br>
						<input type="checkbox" class="checkbox" name="templateDownload" value="gradeTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=gradeTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.GRADE"/></a><br>
						<input type="checkbox" class="checkbox" name="templateDownload" value="subjectTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=subjectTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.SUBJECT"/></a><br>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.USERLOGIN.TEMPLATES.TITLE"/></h2>
					</div>
					<div>
						<div id="singleColumn">
						<div class="row">					
						<input type="checkbox" class="checkbox" name="templateDownload" value="ParentLoginTemplate"><a class="label_inline" href="downloadIndividualTemplate.htm?tempalateName=ParentLoginTemplate&fileType=xls" onClick="hideErrorField()"><spring:message code="BULK.UPLOAD.TEMPLATE.ADD.NEW.PARENT.LOGIN"/></a><br>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>

			<div class="row">
				<div class="row">
					<div class="buttion_bar_type1">
					<input type="submit" onClick="hideErrorField()" value="Download" class="button"  />
				</div>
				</div>
			</div>
			<div class="clearfix"></div>
			</form:form>			
		</div>
		</div>
		</div>
	</div>
<h:footer />
</body>
</html>