<%--
    < ÀKURA, This application manages the daily activities of a Teacher and a Student of a School>

    Copyright (C) 2012 Virtusa Corporation.
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<link href="resources/css/fixheaderTable.css" rel="stylesheet"
	type="text/css">

<script language="JavaScript" src="resources/js/list.js"
	type="text/JavaScript"></script>
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
    var queryString = new Array();
    $(function () {
        if (queryString.length == 0) {
            if (window.location.search.split('?').length > 1) {
                var params = window.location.search.split('?')[1].split('&');
                for (var i = 0; i < params.length; i++) {
                    var key = params[i].split('=')[0];
                    var value = decodeURIComponent(params[i].split('=')[1]);
                    queryString[key] = value;
                }
            }
        }
        if (queryString["year"] != null && queryString["classs"] != null) {
            var data = "<br />";
            data += " <b>Year:</b> " + queryString["year"]+ " &nbsp;<b>Class:</b> " + queryString["classDesc"] + " &nbsp;<b>Term:</b> " + queryString["term"];
            $("#col1").html(data);
			
			document.getElementsByName('year')[0].value = queryString["year"]+","+queryString["year"];
			document.getElementsByName('year')[1].value = queryString["year"];
			document.getElementsByName('sclass')[0].value = queryString["classs"];
			document.getElementsByName('selectedClass')[0].value = queryString["classs"];
			document.getElementsByName('term')[0].value = queryString["term"];
			document.getElementsByName('selectedTerm')[0].value = queryString["term"];
			document.getElementsByName('type')[0].value = queryString["type"];	
			
        }
    });
</script>
<script type="text/javascript">
	function downloadFile(){	
		document.forms[0].submit();
		return false;
	}
</script type="text/javascript" >
<script >
$(function(){
    var fileInput = $('.upload-file');
    var maxSize = 2097152;	 
    $('.upload-form').submit(function(e){
        if(fileInput.get(0).files.length){		
            var fileSize = fileInput.get(0).files[0].size; // in bytes			
            if(fileSize>maxSize){
            	custom_alert("Maximum file upload size exceeded.");
                
                return false;
            }else{						
				 if(fileInput.get(0).files[0].name.indexOf( ".xls" ) > -1 ) {
					setTimeout('self.close()',10);  
				}else{				  
					custom_alert("Please select an XLS file.");
					return false;
				}
            }
        }else{    
        	custom_alert("Please select a file to import.");
           return false;
        }        
    });
});
</script>
</head>
<body >
<div id="page_container">
	<div id="breadcrumb_area">	
		
	<div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/reporting/studentReportCard.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
	</div>
					<form name="template" method='post' action="termMarkExport.htm">
						<input type="hidden" name="year" value="">
						<input type="hidden" name="selectedClass" value="">
						<input type="hidden" name="selectedTerm" value="">
					</form> 
	<div class="clearfix"></div>
	<h1><spring:message code="STUDENT.STUDENTMARK.FILEUPLOAD.TITLE"/></h1>
	<div id="content_main">
		<div class="clearfix"></div>

		<div class="section_box">
			<div class="section_box_header">
				<h2><spring:message code="STUDENT.STUDENTMARK.FILEUPLOAD.TITLE"/></h2>
			</div>

			<div class="section_full_inside" >

				<div class="box_border">					
					<form:form class="upload-form"  target="student" method="post" action="markImport.htm" enctype="multipart/form-data" 
				 	modelAttribute="uploadFile"  name="studentMarkFileImport" >
						
				<div class="messageArea">
					<label class="success_sign">${successMessage}</label>
					<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
					<label class="required_sign">${exception}</label>
				</div>
				<span id="col1" > </span>		
				<div id="col2" align="right" >					
						<a href="javaScript:downloadFile()"   >
						<spring:message code='STUDENT.STUDENTMARK.TERMMARK.TEMPLATE' />
						</a> 
				</div>
				
							
					<div id="singleColumn">										
						<div class="row">			
						<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="STUDENT.STUDENTMARK.FILEUPLOAD.NAME"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input class="upload-file" name="importFile" type="file" style="width: 290px;" value="">	
								<input type="hidden" name="year" value="">
								<input type="hidden" name="sclass" value="">
								<input type="hidden" name="term" value="">
								<input type="hidden" name="type" value="">
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">
								
							</div>
							<div class="frmvalue">								
									<input type="submit" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
					</div>
					<div class="clearfix"></div>				
				</form:form>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<h:footer/>
</body>
</html>