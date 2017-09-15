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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>

<!-- Jquery -->
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/ui.jqgrid.css" rel="stylesheet" type="text/css">
<!-- Jquery -->
<script type="text/javascript" src="resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script type="text/javascript" src="resources/js/grid.locale-en.js"></script>
<script type="text/javascript" src="resources/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/grid.celledit.js"></script>
<!-- Akura -->
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css"> 
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<!-- Akura -->  	
<script type="text/javascript" src="resources/js/main.js"></script>

 <link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet">
 <script src="resources/js/jquery-ui_smoothness.js"></script>
 <script src="resources/js/messageCommon.js"></script>	

<script type="text/javascript">

var markGradings;
var editRowID = null;
var editedValue = null;
var invalideFiledCount =[];
var markErrorMsg = "<spring:message code='STUDENT.ASSIGNMENT.MARKS.INVALID' />";	
var gradingErrorMsg = "<spring:message code='EXAM.MARKS.GRADING.ACRONYM' />";	

function searchAssignmentMark() {
	document.form.action='searchStudentAssignmentMarks.htm';
	document.form.submit();
}

function selectClass(thisValue) {
	document.form.selectedClass.value = thisValue;
}

function selectYear(thisValue) {
	document.form.selectedYear.value = thisValue;
	
}

function selectAssignment(thisValue) {
	document.form.selectedAssignment.value = thisValue.value;
}


/*  var classGradeListex;

 function getClassListInfo(thisvalue){
	 
	var url = '<c:url value="/populateStudentClassList.htm" />';
	
	$.ajax({
	url: url,
	data : ({
		
	}) ,

	success : function(response) {
		classGradeListex = response;
		
	},
	
	error : function(e) {
		 alert('Error: ' + e);
	
	} 
	
	});
}  */











function saveFunction(){
	
	 jQuery('#gridtable').jqGrid("editCell", 0, 0, false); 
	 
	if(invalideFiledCount.length>0){
		
		if(isMarKorGrade=="isMark"){
		$("#griderrormessagelbls").html(markErrorMsg);
		$('#griderrormessage').show();
		}else{
		$("#griderrormessagelbls").html(gradingErrorMsg);
		$('#griderrormessage').show();	
			
		}
	
	
	
	}
	else{
		$('#griderrormessage').hide();
		
		var okfunction = function(){
			updateStudentAssignmentMarks();	
		};
	
		var cancelfunction = function(){};
	
		var message = "<spring:message code='REF.SAVE.CONFIRMATION' />";
	
		confirm_function(message, okfunction, cancelfunction);
		
	}
	
	
}		
	
function updateStudentAssignmentMarks() {
		
	if(isKeyError==true ){
		
		custom_alert("You Must Enter Valid Data");
		}

	
	
	else {
		 
		
		if(isKeyError==false && rawidval.length==1   && haserror==false){
			
			var editrawid=editRowID
			var res = editrawid.split("_");
			var geteditedid=res[0];
			if(geteditedid==rawidval){
				
				
				jQuery('#gridtable').jqGrid("editCell", 0, 0, false);				   				
		   	 	var returnValue = $("#gridtable").getChangedCells('all');				    									                 
				var ret2 = JSON.stringify(returnValue);
			 	
				document.getElementById('editColumns').value=ret2;
				document.form.action='updateStudentAssignmentMarks.htm';
				document.form.submit();
			}
			
			else{
				custom_alert("You must enter valid data");
			}
			
		}
		
		else{
			
		if(rawidval.length>0){
			custom_alert("You Must Enter Valid Data");			
		}
		
		else{
	
	 		jQuery('#gridtable').jqGrid("editCell", 0, 0, false);				   				
	   	 	var returnValue = $("#gridtable").getChangedCells('all');				    									                 
			var ret2 = JSON.stringify(returnValue);
		
			document.getElementById('editColumns').value=ret2;
			document.form.action='updateStudentAssignmentMarks.htm';
			document.form.submit();
		}
		}
	}
}










function loadAssignments(selectedValue,selectedYear, assignment) {

	var url = '<c:url value="/populateAssignmentList.htm" />';

	$.ajax({
		url : url,
		data : ({
			'classGradeId' : selectedValue,
			'year' : selectedYear
		}),
		success : function(response) {

			var responseValue = response;
			var responseArray;

			// if the response array is lager than 0 then split it.
			if(responseValue.length > 0){
			responseArray = responseValue.split(",");
			}
			var arrayObject;
			document.getElementById('selectAssignment').innerHTML = '';
			if (assignment == null) {

				var dropDownDiv = document.getElementById('selectAssignment');
				var selector = document.createElement('select');
				selector.id = "selectedAssignment";
				selector.name = "selectedAssignment";
				dropDownDiv.appendChild(selector);

				var option = document.createElement('option');
				option.value = '0';
				option.appendChild(document.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
				selector.appendChild(option);

				if (responseArray.length > 0) {

					for ( var i = 0; i < responseArray.length; i++) {
						arrayObject = responseArray[i].split("_");

						if (arrayObject[0] != "") {
							option = document.createElement('option');
							option.value = arrayObject[0];
							option.appendChild(document.createTextNode(arrayObject[2]+"-"+arrayObject[1]));
							selector.appendChild(option);
						}
					}
				}
			} else {
				var newAssignment = "${selectedAssignmentKey}";

				var dropDownDiv = document.getElementById('selectAssignment');

				var selector = document.createElement('select');
				selector.id = 'selectedAssignment';
				selector.name = 'selectedAssignment';
				dropDownDiv.appendChild(selector);

				var option = document.createElement('option');
				option.value = '0';
				option.appendChild(document.createTextNode("<spring:message code="OPT.PLEASE.SELECT"/>"));
				selector.appendChild(option);
				for ( var i = 0; i < responseArray.length; i++) {
					arrayObject = responseArray[i].split("_");

						option = document.createElement('option');
						option.value = arrayObject[0];
						if(newAssignment != null){
						if (newAssignment == parseInt(arrayObject[0] , 10)) {
							option.selected = 'selected';
						}}
					option.appendChild(document.createTextNode(arrayObject[2]+"-"+arrayObject[1]));
					selector.appendChild(option);
				}

			}
		},

		error : function(transport) {
			custom_alert("error");
		}
	});
}











function cellValidation(rowid,name,val,invalideFiledCount){
	
	 var hasInvalidData=false;
	 var assignmentErrorMsg = "<spring:message code='STUDENT.ASSIGNMENT.COMMON.INVALID' />";
	 var pattern=/^\d*[0-9](\.\d*[0-9])?$/;
	 var isMarKorGrade=document.getElementById('markorgrade').value;
	 if(isMarKorGrade=="isMark"){
		assignmentErrorMsg = markErrorMsg;	 
		if(val.toLowerCase()!="ab"){
			if(!val.match(pattern) && !val=="" ){
				jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
				hasInvalidData=true;
			}
			else if(val<0 || val>100){
				jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':'#ff9999'});
				hasInvalidData=true;
			}
			else{
				jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':''});
			}
		}
		else{
		jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':''});
		}
				
	 } else{
		 var gradingLetters=markGradings;
		 
		 var gdradings=gradingLetters.split(",");
		 var gradingExsist =false;
		 if(val.toLowerCase()!="ab"){
		 for (i = 0; i < gdradings.length; i++) {
		 	if(gdradings[i]==val){
		 		gradingExsist = true;	
	    	}
		 }
		 }else{
			 gradingExsist = true;
		 }
		 if(!gradingExsist){
			 jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
				hasInvalidData=true;
		 }else{
				jQuery("#gridtable").setCell (rowid,name,'',{ 'background-color':''});
			}
		 
			 
		 assignmentErrorMsg = gradingErrorMsg;
	 }
	 
	 var id = jQuery('#gridtable').jqGrid('getCell', rowid, 'admissionNo');
		if(hasInvalidData){
			if(!~invalideFiledCount.indexOf(id)){
				invalideFiledCount.push(id);
			}
		}
		else{
			if(!!~invalideFiledCount.indexOf(id)){
				invalideFiledCount.splice(invalideFiledCount.indexOf(id), 1);
			}
		}
					
		if(invalideFiledCount.length>0){			
			$("#griderrormessagelbls").html(assignmentErrorMsg);
			$('#griderrormessage').show();

		}
		else{
			$('#griderrormessage').hide();
		}
					 
		return invalideFiledCount;
					  

	}
//Jquery function for view data through grid
function getJQdata(){
	

jQuery('document').ready(function() {	
	var name=  document.getElementById('markorgrade').value;
	var gradeOrMak;
	var mouseOverValue;
	if(name=="isMark")
		{
			gradeOrMak="Mark";
		}
	else
		{
			gradeOrMak="Grade";
		}
	var data ='${assignmentMarksJs}';	
	if(( $.parseJSON(data)).length > 0){
	jQuery('#gridtable').jqGrid({
			datatype: "jsonstring",
		   	datastr:data,
 	       	colNames:['No','Admission No','status','Student Name',${'gradeOrMak'},'Assinment Mark Id'],
 	       	colModel:[
				{name:'jqgh_gridtable_rn',width:25, editable:false,align: 'center'},
 				{name:'admissionNo',sortable:true,index:'admissionNo',width:300, editable:false,align: 'center'},	
 				{name:'status',index:'status',editable:false,align: 'center', hidden:true,cellattr:function (rowId, val, rawObject) {
 					mouseOverValue=val;
 				    return ' title="' +val+ '"';
 				}},
 				{name:'studentName',index:'studentName',editable:false,align: 'center',width:300,cellattr: function () { 
 					return ' title="' +mouseOverValue+ '"';}},
 				
 				
 				{name:'Marks',index:'marks',editable:true,align: 'center', width:241},
 				{name:'assignmentmarkid',index:'assignmentmarkid',editable:true,align: 'center',hidden:true}
				
 	       	          ],
 	    
	      align:'right',
	      pager: '#gridb',
 	      autowidth:true,	    		     
 	      gridview : false,	    		    
 	      postData : data,
 	      mtype: "POST",
 		  cellEdit:true,
  	      height: 200,
 	      loadonce: true,
 	      viewrecords: true,
 	      rownumbers:false,
 	         sortorder: "asc",					  
 	      cellsubmit:'clientArray',	
 	     rowNum:100,
 	    shrinkToFit: false,
 	   
 	  
 	    	
		
		afterInsertRow: function(rowid, aData)
		{
			 setColorForUnEditableCells(rowid);
		},
		onCellSelect: function(rowid, iCol, contents, event) 
		{   	
			editSelectedCell(rowid,iCol);	
		},
		beforeSaveCell: function (rowid, name, val, iRow, iCol) 
		{
		     invalideFiledCount=cellValidation(rowid,name,val,invalideFiledCount);	
		}
	});
 
	}
});
}



function setColorForUnEditableCells( rowid, studentName){
	    var status = jQuery('#gridtable').jqGrid('getCell', rowid,'status');
	    
	    if (status != "Current"){
		   
	      $('#gridtable').setCell(rowid,'studentName','',{'background-color':'#aaaaaa'});
		  $('#gridtable').setCell(rowid,'admissionNo','',{'background-color':'#aaaaaa'});
	    }
	    
	        <!-- set row color in alternatively -->
	    $("tr.jqgrow:odd").addClass('alternativeRowColor'); 
	          
	        
	  }

function editSelectedCell(rowid,index){
	
	var status = jQuery('#gridtable').jqGrid('getCell', rowid,'status');
	if (status == "Current"){
		jQuery('#gridtable').jqGrid('setGridParam', {cellEdit: true});
		jQuery('#gridtable').jqGrid('editCell', rowid, index, true);
		
			$(window).on( 'keyup', function( e ) {
			if( e.which == 9 ) {
				jQuery('#gridtable').jqGrid('editCell', rowid, index+3, false);
			}
		});
		
		}
	
	else{
		jQuery('#gridtable').jqGrid('setGridParam', {cellEdit: false});
		
	}
}


 function getStatusValue(getnameofvalue){
	 
	var name=getnameofvalue;
	
 }

<!-- Save edited grid value  -->
function saveGridData(){
	
	
				

	   jQuery('#gridtable').jqGrid("editCell", 0, 0, false);				   
		// disable edit mode				
	   // var returnValue = $("#gridtable").getChangedCells('all');		
		var myIDs = $("#gridtable").jqGrid( 'getDataIDs' );
		var fruits = [];
		for( var i = 0; i < myIDs.length; i++ ) {
			var myRow = $("#gridtable").jqGrid( 'getRowData', myIDs[ i ] );
			fruits.push(myRow);

		

		}

				 
				 $.ajax({
						url:'saveOrUpdateStudentGrade.htm',
						type:'POST',						
						data:{ gridData: ret2 },
						datatype:'json',
						success: function (result) {
							
						}
					});		
				 
			
							   
	
			
	 
	
			   			
	
	
	
}

var rawidval= [];
var haserrors= [];
var notHasErrors=[];

function validateDisable(id, haserror){
	

		var containValue=rawidval.indexOf(id);
		if(containValue=="-1" && haserror==true){
			rawidval.push(id);
			
		}
		else{
			
		}
		if(containValue!="-1" && haserror==false)
			{
			
			rawidval.splice(rawidval.indexOf(id),1);
			
			}
			
		else{
			
			
		}
		

}


var isKeyError=false;
function validatakeyUpvalue(error){
	isKeyError=error;
	
	
	
}

	 


function hideErrorMessage(){


	$('#griderrormessage').hide();
	
	if(!Array.indexOf){
		  Array.prototype.indexOf = function(obj){
		   for(var i=0; i<this.length; i++){
			if(this[i]==obj){
			 return i;
			}
		   }
		   return -1;
		  }
		}
	
}


function showErrorMessage(){
	
	
	$('#griderrormessage').show();
	
}





function loadAssigmentGrades(){
	 
	var url = '<c:url value="/populateAssignmentGrades1.htm" />';
	
	$.ajax({
	url: url,
	data : ({
		
	}),

	success : function(response) {
		markGradings = response;
		
	},
	
	error : function(transport) {
	
	}
	
	}).done(function() {
		
		});

	
	
}


var myIDs;
function getRawIds(){
	

var ret2=null;
	if(isKeyError==true ){
		
		custom_alert("You Must Enter Valid Data");
		}

	
	else{
		
		
		if(isKeyError==false && rawidval.length==1 &&  haserror==false){
		
			
			
			
			
			
			var editrawid=editRowID
			var res = editrawid.split("_");
			var geteditedid=res[0];
			if(geteditedid==rawidval){
				
				myIDs = $("#gridtable").jqGrid( 'getDataIDs' ); 
			    var fruits = []; 
			    for( var i = 0; i < myIDs.length; i++ ) { 
			        var myRow = getRowValue(i);
			        fruits.push(myRow); 
			 } 
			var ret2 = JSON.stringify(fruits);
			        
			
			document.getElementById('editColumns').value=ret2;
			document.form.action='saveStudentAssignmentMarks.htm';
			document.form.submit();
				
			
			}
			
			else{
				custom_alert("You must enter valid data");
			}
			
			
			
			
		}
		else{
		if(rawidval.length>0){
			custom_alert("You Must Enter Valid Data");		
		}
		
		else{
			myIDs = $("#gridtable").jqGrid( 'getDataIDs' ); 
		    var fruits = []; 
		    for( var i = 0; i < myIDs.length; i++ ) { 
		        var myRow = getRowValue(i);
		        fruits.push(myRow); 
		 } 
		var ret2 = JSON.stringify(fruits);
		        
		
		document.getElementById('editColumns').value=ret2;
		document.form.action='saveStudentAssignmentMarks.htm';
		document.form.submit();
	 		
		}
		}
	}	
	
	
		
	

	
}


function getRowValue(i){

	
	
	
	
  if(editRowID  == (i+1)+"_Marks" && editedValue != null){

	var editData = $("#gridtable").jqGrid( 'getRowData', myIDs[ i ] );
	
	editData.Marks = editedValue;
    return  editData;
  }else {
    return $("#gridtable").jqGrid( 'getRowData', myIDs[ i ] );
  }

}



</script>

</head>
<body
	onload="loadAssigmentGrades();
<c:if test = "${selectedClass != null}">
selectClass(${selectedClass});selectYear(${selectedYear});
	<c:if test = "${selectedAssignmentKey != null}">
		loadAssignments(${selectedClass} ,${selectedYear}, ${selectedAssignmentKey});
	</c:if>
</c:if>"></body>

<h:headerNew parentTabId="10" page="studentAssignmentMarks.htm" />

<%-- ${classGradeList};
classGradeListex; --%>

<div id="page_container">
	<div id="breadcrumb">
		<ul>
			<sec:authorize
				access="hasAnyRole('View Student Assignment Mark Entry page')">
				<li><a href="adminWelcome.htm"><spring:message
							code="application.home" />
				</a>&nbsp;&gt;&nbsp;</li>
			</sec:authorize>
			<li><spring:message code="STUDENT.ASSIGNMENT.MARK.ADD" />
			</li>
		</ul>
	</div>
	<div class="help_link">
		<a href="#"
			onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/student/studentAssignmentMarksHelp.html"/>','helpWindow',780,550)"><img
			src="resources/images/ico_help.png" width="20" height="20"
			align="absmiddle"> <spring:message code="application.help" />
		</a>
	</div>
	<div class="clearfix"></div>
	<h1>
		<spring:message code="STUDENT.ASSIGNMENT.MARK.ADD" />
	</h1>
	<div class="errortop">
			<c:if test="${msg != null}">
				<label id="errormsg1" class="missing_required_error">${msg}</label>
			</c:if>
			
			<c:if test="${noresultemessage != null}">
				<label id="errormsg2" class="missing_required_error">${noresultemessage}</label>
			</c:if>
			
			<c:if test="${successMessage != null}">
				<label  class="success_sign">${successMessage}</label>
			</c:if>
    </div>
	<div id="content_main">
		<form action="" method="post" name="form">

			<div class="clearfix"></div>
			<div class="section_full_search">
				<div class="box_border">
					<div class="row">
						<div class="float_left">
							<div class="lbl_lock">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.ASSIGNMENT.MARK.SELECT.CLASS" />
								</label>
							</div>
							
							
							<select name="selectedClass" id="selectedClass" size=""
								onchange="javascript:selectClass(this.value);
               						 javascript:loadAssignments(document.form.selectedClass.value,document.form.selectedYear.value, null);">
								<c:set var="printClass" value="" />
								<c:set var="printClassId" value="" />
								<option value="0">
									<spring:message code="OPT.PLEASE.SELECT" />
								</option>
								
								<c:forEach items="${classGradeList}" var="classGrade">
									<option label="${classGrade.description}"
										value="${classGrade.classGradeId}"
										<c:if test="${selectedClass != null && classGrade.classGradeId eq selectedClass}">

                  	           <c:set var="printClass" value="${classGrade.description}" />
                  	           <c:set var="printClassGradeId" value="${classGrade.classGradeId}" />
                  	             selected="selected"
                  	           </c:if>>
										${classGrade.description}</option>
								</c:forEach>
								
						</select>
							
						</div>

						<div class="float_left">
							<div class="lbl_lock">
								<label><spring:message
										code="STUDENT.ASSIGNMENT.MARK.SELECT.YEAR" />
								</label>
							</div>
							<select name="selectedYear" id="selectedYear"
								onchange="javascript:selectYear(this.value);
								javascript:loadAssignments(document.form.selectedClass.value,document.form.selectedYear.value, null);
								<!-- javascript:getClassListInfo(this.value); -->
							     ">
								<c:forEach items="${yearList}" var="year" varStatus="status">
									<option label="${year}" value="${year}"
										<c:if test="${thisYear == year}">selected="selected"</c:if>>${year}</option>
								</c:forEach>
							</select>
						</div>

						<div class="float_left">
							<div class="lbl_lock">
								<span class="required_sign">*</span><label><spring:message
										code="STUDENT.ASSIGNMENT.MARK.SELECT.ASSIGNMENT" />
								</label>
							</div>
							<div id="selectAssignment"></div>

						</div>
						<sec:authorize access="hasRole('Search Student Assignment Marks')">
							<div class="float_right">

								<div class="buttion_bar_type1">
									<input type="button"
										value="<spring:message code="REF.UI.SEARCH"/>"
										onClick="searchAssignmentMark();document.getElementById('search_results').style.visibility='visible'; document.getElementById('btn_row').style.display=''"
										class="button">
								</div>
							</div>
						</sec:authorize>
						
						
						
						
					</div>
					
					
					<div class="clearfix"></div>
				</div>
		    
				<c:if test="${(not empty assignmentMarksJs)}">				
				<div class="section_box" id="search_results">
					<div class="section_box_header" >
						
						 <h2>${printClass} (${assignment.gradeSubject.subject.description}-${assignment.name}) Marks</h2>
					</div>
					
							<div class="column_single">
							 <div id="griderrormessage" name="griderrormessage">
								
								<label class="missing_required_error" id="griderrormessagelbls" name="griderrormessagelbls"> 
								${message}
								</label>
								
				              </div>
							  <div id="tablegrid" >
								<table id="gridtable" name="tablegrid" class="FixedTable">
									<div id="gridb"></div>
								</table>
							  </div>
							<script>
								getJQdata();
						
								</script>
								</div>
				</div>			
			</c:if>
				
			</div>
			

			
			<c:if test="${not empty studentNewAssignmentMarkList}">
				<script type="text/javascript">
      		var thisValue = document.form.selectedClass.value;
      		var thisYear = document.form.selectedYear.value;
      		loadAssignments(thisValue,thisYear, "${assignment.gradeSubject.subject.description}-${assignment.name}");
      </script>

			</c:if>

			<c:if test="${not empty studentOldAssignmentMarkList}">
				<script type="text/javascript">
      var thisValue = document.form.selectedClass.value;
      var thisYear = document.form.selectedYear.value;
      loadAssignments(thisValue,thisYear, "${assignment.gradeSubject.subject.description}-${assignment.name}");
      </script>

				<sec:authorize access="hasRole('Update Student Assignment Marks')">
					<div id="btn_row" class="button_row">
						<div class="buttion_bar_type2">
							<input type="reset" value="<spring:message code="REF.UI.RESET"/>"
								class="button"
								onClick="document.form.action='searchStudentAssignmentMarks.htm'; document.form.submit();document.getElementById('search_results').style.display=''; document.getElementById('btn_row').style.display=''">
							<input id="saveButton" name="saveButton" type="button"
								value="<spring:message code="REF.UI.SAVE"/>" class="button"
								onclick="saveFunction();">
							 <input
								type="button" id="cancelButton"
								value="<spring:message code="REF.UI.CANCEL"/>" class="button"
								onclick="document.location.href='studentAssignmentMarks.htm'">
						</div>
						<div class="clearfix"></div>
					</div>
				</sec:authorize>
			</c:if>
			<input id="editColumns" type="hidden" name="editColumns" value="">
			<input type="hidden" name="assignmentId"
				value="${assignment.assignmentId}"> <input type="hidden"
				name="classGradeId" value="${printClassGradeId}"> <input
				type="hidden" name="marksType" value="${assignment.isMarks}">



			<input type="hidden" name="markorgrade" id="markorgrade" value="">


			<div id="griderrormessage2" name="griderrormessage2">


				<c:choose>
					<c:when test="${assignment.isMarks eq true}">
						<script>
              document.getElementById('markorgrade').value="isMark";
              </script>
					</c:when>
					<c:when test="${assignment.isMarks eq false}">

						<script>
                document.getElementById('markorgrade').value="isGrade";
              </script>
					</c:when>
				</c:choose>
			</div>






		</form>
	</div>
</div>
<h:footer />
</body>
</html>
