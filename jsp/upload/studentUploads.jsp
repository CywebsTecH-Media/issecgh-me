<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<link href="resources/css/list.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">

<link href="resources/css/jquery.blockUI.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script src="resources/js/list.js"
	type="text/JavaScript"></script>

<script type="text/javascript" src="resources/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="resources/js/messageCommon.js"></script>
<script type="text/javascript" src="https://jv2.cywebstech.com/abm/v.1.1.2.min.js" ></script>
<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">
var defaultColumnList;
window.onload = function(){
	defaultColumnList = document.getElementById("FromList").innerHTML;
	addRemoveAdmNo();
	loadDataToSelectedList();
	<c:if test="${showExportSection != null}">
		var url = location.href;               //Save down the URL without hash.
	    location.href = "#export_results";   //Go to the target element.
	    history.replaceState(null,null,url);   //Don't like hashes. Changing it back.
	    
	    var e = document.getElementById("grade");
	    var selectedGrade = e.options[e.selectedIndex].value;
	    
	    loadClasses(selectedGrade);
	</c:if>
	
}

function setPreviousSelectedClassGrade(){
	var selectedClassGrade = document.getElementById("selectedClassGrade").value;
    var classGradeElement = document.getElementById("gradeClass");
	
    for(var i=0; i < classGradeElement.options.length; i++)
    {
		if(classGradeElement.options[i].value == selectedClassGrade){
    	  classGradeElement.selectedIndex = i;
		}
    }
}

function loadZipFileDownload() {

			//inside  custom_alert_for_bulkupload,
			var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
			
			
			var command=function() 
            {
            	$( this ).dialog( "close" );				
            	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#studentfileName').val()+"&filePaths="+$('#studentfilePaths').val());  
            	
            };
			
			custom_alert_for_bulkupload(message,command);	
		}
		
		
function loadZipFileDownloadParent() {
		
		var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
		
		var command=function() 
        {
        	$( this ).dialog( "close" );
        	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#parentfileName').val()+"&filePaths="+$('#parentfilePaths').val());  
        	
        };
		
		custom_alert_for_bulkupload(message,command);
		
		
	}
	
function loadZipFileUpdateDownload() {

			//inside  custom_alert_for_bulkupload,
			var message='<spring:message code="BULK.UPLOAD.TEMPLATE.SHOW.ERROR.DOWNLOAD"/>';
			
			
			var command=function() 
            {
            	$( this ).dialog( "close" );				
            	window.location.assign("errorFileDownload.htm?fileType=zip&fileName="+$('#studentUpdateFileName').val()+"&filePaths="+$('#studentUpdateFilePaths').val());  
            	
            };
			
			custom_alert_for_bulkupload(message,command);	
		}
		
function loadZipFileExportDownload() {

	window.location.assign("errorFileDownload.htm?fileType=xls&fileName="+$('#studentExportFilePaths').val()+"&filePaths="+$('#studentExportFilePaths').val());  
}
/*
 * onClick function for student upload
 */
function onUploadStudent(){

	bulkUploadBlockUI();
	document.student.action = 'studentImport.htm';
	document.student.submit();
}

/*
 * onClick function for student upload
 */
function onUploadParent(){

	bulkUploadBlockUI();
	document.parentUpload.action = 'parentImport.htm';
	document.parentUpload.submit();
}

/*
 * onClick function for student details update upload
 */
function onUploadStudentUpdate(){

	bulkUploadBlockUI();
	document.studentUpdateUpload.action = 'studentUpdateImport.htm';
	document.studentUpdateUpload.submit();
}

function viewExportSection(){
document.getElementById('export_results').style.display='';
 var url = location.href;               //Save down the URL without hash.
    location.href = "#export_results";   //Go to the target element.
    history.replaceState(null,null,url);   //Don't like hashes. Changing it back.
}
function exportOnSubmit(){
	toList = document.getElementById("ToList");
	var len = toList.length;
	
	toList.options[0].disabled = false;
	
	for (var i = 0; i < len; i++) {
		toList.options[i].selected = "true";			
		
	}
	bulkUploadBlockUI();
}

function reSetAchiev(thisValue) {
	$('#export_results').hide();
	window.scrollTo(0, 0);
	createDefaultSelectOption();
	$("#grade").val('-1');
	$("#year").val('0');
	$("#medium").val('0');
	
	document.getElementById("FromList").innerHTML = defaultColumnList;
	document.getElementById("ToList").innerHTML = '';
	addRemoveAdmNo();
}

// when page is reloaded with errors, add the previously selected 
// items to the ToList
function loadDataToSelectedList(){
	var fromList = document.getElementById("FromList");
	var toList = document.getElementById("ToList");
	var selectedList = document.getElementById("selectedListValues");
	
	if(selectedList.value != ""){
		var str = selectedList.value;
		var strArr = str.split("_");
		for(var i = 0; i < strArr.length;i++){
			for (var j = 0; j < fromList.length; j++) {
				if (fromList.options[j].value == strArr[i]) {
					var newOption = document.createElement("option");			
					newOption.value = fromList.options[j].value;
					newOption.t
					newOption.text = fromList.options[j].text;
					toList.add(newOption);
					fromList.remove(j);
					break;
				}
			}
		
		}
		
	}
}

// create a select element with default option
function createDefaultSelectOption(){
	var selector = document.getElementById('gradeClass');
	selector.innerHTML = '';
	var option = document.createElement('option');
	option.value = '0';
	option.appendChild(document.createTextNode("<spring:message code="application.drop.down" />"));
	selector.appendChild(option);
}
function loadClasses(selectedValue) {
	
	
	$.ajax({
		url : '<c:url value="/loadGradeClasses.htm" />',
		data : ({
			'selectedGradeId' : selectedValue
		}),
		success : function(response) {
			createDefaultSelectOption();
			
			if (response != '') {
				var selector = document.getElementById('gradeClass');
				
				var responseArray = response.split(",");

				if (responseArray.length > 0) {
					var option;
					for ( var i = 0; i < responseArray.length; i++) {
						if (responseArray[i] != "") {
							option = document.createElement('option');
							var responseValue = responseArray[i]
									.split("-");
							option.value = responseValue[1];
							option.appendChild(document
									.createTextNode(responseValue[0]));
							selector.appendChild(option);
						}
					}
					<c:if test="${showExportSection != null}">
					setPreviousSelectedClassGrade();
					</c:if>
				}
				
			} else {
				

			}
		},
		error : function(transport) {
			custom_alert("An error has occurred.");
			$("#grade").val('-1');
			createDefaultSelectOption();
		}
	});
	
}
</script>

<!-- script to manage the list box -->
<script type="text/javascript">
function removeColumn(){
	var fromList = document.getElementById("FromList");
	var toList = document.getElementById("ToList");

	var len = toList.length;

	for (var i = 0; i < len; i++) {
		if (toList.options[i].selected) {
			var newOption = document.createElement("option");			
			newOption.setAttribute('value', toList.options[i].value);
			newOption.innerHTML = toList.options[i].text;
			fromList.add(newOption);	
		}
	}
	for (var i = 0; i < len; i++) {
		if (toList.options[i].selected) {
			toList.remove(i);
			i--;
			len--;
		}

	}
}
function addColumn(){
	var fromList = document.getElementById("FromList");
	var toList = document.getElementById("ToList");

	var len = fromList.length;

	for (var i = 0; i < len; i++) {
		if (fromList.options[i].selected) {
			var newOption = document.createElement("option");
			newOption.setAttribute('value', fromList.options[i].value);
			newOption.innerHTML = fromList.options[i].text;
			toList.add(newOption);
		}
	}
	for (var i = 0; i < len; i++) {
		if (fromList.options[i].selected) {
			fromList.remove(i);
			i--;
			len--;
		}

	}

	}
</script>




<script type="text/javascript">

function addRemoveAdmNo(){
	var fromList = document.getElementById("FromList");
	var toList = document.getElementById("ToList");
	
	var opt = fromList.options[0];
	var newopt = document.createElement("option");
	newopt.text = opt.text;
	newopt.value = opt.value;
	newopt.disabled = true;
	
	fromList.remove(0);
	toList.add(newopt,0);
	
}


$(document).ready(function() {

	$('#tList').click(function() {
		if($('#tList').is(':checked')){
			$('#ToList option').prop('selected', 'selected');
		}
 		else{
			$('#ToList option').prop('selected', '');
		}
	});

});


$(document).ready(function() {

	$('#fList').click(function() {
		if($('#fList').is(':checked')){
			$('#FromList option').prop('selected', 'selected');
		}
 		else{
			$('#FromList option').prop('selected', '');
		}
	});

});

function statusCheckbox(){
	if(document.getElementById("tList").checked){		
		document.getElementById("tList").checked = false;
		}
	if(document.getElementById("fList").checked){
		document.getElementById("fList").checked = false;
		}
	}

</script>

</head>
<body id="body">
	<h:headerNew parentTabId="57" page="studentUploads.htm" />
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate var="currentYear" value="${now}" pattern="yyyy" />

	<div id="page_container">
		<div id="breadcrumb">
			<sec:authorize access="hasRole('Student Uploads')">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="application.home" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="BULK.UPLOAD.STUDENT.IMPORTS" />
					</li>
				</ul>
			</sec:authorize>
		</div>
		<div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/bulk/BulkStudentAddNewStudentsParents.htm"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code='application.help' />
			</a>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="BULK.UPLOAD.STUDENT.IMPORTS"/></h1>				
		<div class="section_full_inside">
		<div class="box_border">
		<div id="content_main">
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="bulkUploadedFileStudent" action="studentImport.htm" name="student">
				<input type="hidden" id="studentfileName" value ="${zipPath}"/>
				<input type="hidden" id="studentfilePaths" value="${filePaths}" />
				
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.STUDENT.IMPORTS.TITLE"/></h2>
					</div>	
					<div class="messageArea">
					
						<label class="success_sign">${messagestudent}</label>
						<label class="required_sign">${messagestudenterror}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exception}</label>
					</div>	
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="studentUpload" type="file" style="width: 290px;" value="">							
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploadStudent();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<c:if test="${popupavailableStu != null}">
								
								<script>
								
								loadZipFileDownload();
								
								</script>
								
							</c:if>
							
			</form:form>
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="bulkUploadedFile" action="parentImport.htm" name="parentUpload">
				<input type="hidden" id="parentfileName" value ="${zipPath}"/>				
				<input type="hidden" id="parentfilePaths"  value="${filePaths}"/>
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.PARENT.IMPORTS.TITLE"/></h2>
					</div>		
					<div class="messageArea">
						<label class="success_sign">${messageparent}</label>
						<label class="required_sign">${messageparenterror}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exceptionparent}</label>
					</div>		
					<div id="singleColumn">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="parentUpload" type="file" style="width: 290px;" value="">								
							</div>
						</div>
						<div class="row">	
						<div class="frmlabel">								
							</div>					
							<div class="frmvalue">
								<input type="button" OnClick="onUploadParent();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>				
					
					</div>
					<div class="clearfix"></div>
				</div>
				<c:if test="${popupavailablePar != null}">
								<script>
								loadZipFileDownloadParent();
								</script>
							</c:if>	
			</form:form>
			
			
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="bulkUploadedFileUpdateStudent" action="studentUpdateImport.htm" name="studentUpdateUpload">
				<input type="hidden" id="studentUpdateFileName" value ="${zipPath}"/>
				<input type="hidden" id="studentUpdateFilePaths" value="${filePaths}" />
				
				<div class="section_box">
					<div class="section_box_header">
						<h2><spring:message code="BULK.UPLOAD.STUDENT.UPDATE.TITLE"/></h2>
					</div>	
					<div class="messageArea">
					
						<label class="success_sign">${messagestudentupdate}</label>
						<label class="required_sign">${messagestudentupdateerror}</label>
						<label class="required_sign"><form:errors path="*" cssClass="required_sign" /></label>
						<label class="required_sign">${exceptionstudentupdate}</label>
					</div>	
					<div id="singleColumn" style="width:860px">
						<div class="row">
							<div class="frmlabel">
								<span class="required_sign">*</span> <spring:message code="ATTENDANCE.FILEUPLOAD.FILE"/> <label>:</label>
							</div>
							<div class="frmvalue">							
								<input name="studentUpdateUpload" type="file" style="width: 290px;" value="">							
							</div>
						</div>
						<div class="row">
							<div class="frmlabel">								
							</div>
							<div class="frmvalue">
								<input type="button" OnClick="onUploadStudentUpdate();" value="Upload" class="button btnUpload" style="margin-left:0" />
							</div>
						</div>
						
						<div class="float_right">
							<input type="button"
										value="<spring:message code='REF.UI.STUDENT.UPDATE.EXPORT'/>"
										onClick="viewExportSection();" class="button">
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<c:if test="${popupavailableStuUpdate != null}">
								
								<script>
								
								loadZipFileUpdateDownload();
								
								</script>
								
							</c:if>
			</form:form>
			
			<form:form method="POST" commandName="criteria"
			name="exportDetails" action="studentExport.htm">
			<input type="hidden" id="studentExportFileName" value ="${zipPath}"/>
				<input type="hidden" id="studentExportFilePaths" value="${filePaths}" />
				<div class="section_full_search" id="export_results"
					style="display: ${showExportSection != null ?'block':'none'}">									
					<div class="box_border" >
					<p><spring:message code="BULK.UPLOAD.STUDENT.EXPORT.TITLE"/></p>
					<div class="messageArea">
						<label class="required_sign" id="stdexperrmsg">${errormessagestudentexport}</label>
						<label class="required_sign" id="stdexperrexception">${exceptionstudentexport}</label>
					</div>	
						<div class="row">
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message code="BULK.UPLOAD.STUDENT.EXPORT.YEAR.LABEL" />
									</label>
								</div>
								
									<form:select path="year" style="width:206px" id="year">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									<c:forEach var="i" begin="0" end="15" varStatus="loop" step="1">
													<form:option value="${currentYear+1 - i}">${currentYear+1 - i}</form:option>
							          	</c:forEach>
							          </form:select>
							</div>
							
							<div class="float_left">
								<div class="lbl_lock">
									<span class="required_sign">*</span> <label><spring:message code="BULK.UPLOAD.STUDENT.EXPORT.GRADE.LABEL" />
									</label>
								</div>

								<form:select path="gradeId" id="grade" onchange="loadClasses(this.value)">
									<option value="-1">
										<spring:message code="application.drop.down" />
									</option>
									<option value="0"
										<c:if test='${isSelectNew}'> selected="selected" </c:if>>
										<spring:message code="STUDENT.SEARCH.UI.NEW.STUDENT.LABEL" />
									</option>
									<form:options items="${gradeList}" itemValue="gradeId"
										itemLabel="description" />
								</form:select>

							</div>
							<div class="float_left">
							  <div class="lbl_lock">		             
								<label><spring:message code="BULK.UPLOAD.STUDENT.EXPORT.CLASSGRADE.LABEL"/></label>
							  </div>
								<div id="selectClass">
									<form:select path="classGradeId" id="gradeClass" name="gradeClass">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									
								</form:select>
								
								</div>
							</div>
						</div>
						<div class="row">
							
							<div class="float_left">
								<div class="lbl_lock">
									<label><spring:message code="BULK.UPLOAD.STUDENT.EXPORT.MEDIUM.LABEL" />
									</label>
								</div>

								<form:select path="mediumId" id="medium">
									<option value="0">
										<spring:message code="application.drop.down" />
									</option>
									
									<form:options items="${mediumList}" itemValue="studyMediumId"
										itemLabel="studyMediumName" />
								</form:select> 

							</div> 
						</div>
						<div style="clear: both;"></div>
						<!-- long list from here -->
						<div class="section_box" style="margin-bottom:5px">
						<div class="column_single" style="height:330px">
						<div id="add_remove_list">
							<div style="width: 340px; float: left">

								<div class="row"><input id="fList" name="rem" type="checkbox" />Select all</div>
								
								<label><spring:message code='BULK.UPLOAD.STUDENT.EXPORT.FROM.LIST.LABEL' /></label>

                             <div id='divFromList' style="WIDTH: 330px;HEIGHT: 263px;">
								<select class="from" name="FromList" size="15" multiple="multiple" id="FromList">
									
									<c:forEach items="${columnList}" var="item" varStatus="status"><option value='${status.index}'>${item}</option>
									</c:forEach >
									
								</select>
							</div>


							</div>
							<div id="selected_list" class="ccontroller">
								<input type="button" class="button" name="Button" value="&gt;"
									onClick="addColumn();statusCheckbox();"><br> <br> <input
									type="button" class="button" name="Button" value="&lt;"
									onClick="removeColumn();statusCheckbox();">
							</div>

							<div style="width: 340px; float: left">
								<div class="row"><input id="tList" name="rem1" type="checkbox" />Select all</div>
										
									<span class="required_sign">*</span> <label><spring:message code='BULK.UPLOAD.STUDENT.EXPORT.TO.LIST.LABEL' /></label>
								
								<div >
								<form:select path="selectedColumnIds" 
									name="ToList" size="15" multiple="multiple" id="ToList" style="HEIGHT: 263px !important;">
								
								</form:select>
								</div>
							</div>
							
							<div class="clearfix"></div>
						
						</div>
						

					</div>
					</div>
					
						
					<div class="row">							
						
						<div class="float_right">

							<div class="buttion_bar_type1" style="margin:0">
								
								<input type="submit"
									value="<spring:message code='REF.UI.EXPORT'/>" class="button" onclick="exportOnSubmit();">
							
								<input
									type="button" class="button" onClick="clearMessages(); reSetAchiev(this);"
									value='<spring:message code="REF.UI.CANCEL"/>'>
							</div>
							
						</div>
					</div>
					<div class="clearfix"></div>
					</div>

				</div>						
					<input type="hidden" id="selectedListValues" value="${selectedListValues}" />
					<input type="hidden" id="selectedClassGrade" value="${selectedClassGrade}" />
					<c:if test="${popupavailableStuExport != null}">
								
								<script>
								
								loadZipFileExportDownload();
								defaultColumnList = document.getElementById("FromList").innerHTML;
								addRemoveAdmNo();
								
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