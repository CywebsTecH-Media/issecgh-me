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
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" /></title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>
<script language="javascript" src="resources/js/common.js"></script>
<script type="text/javascript" src="resources/js/grid.locale-en.js"></script>
<script type="text/javascript" src="resources/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/grid.celledit.js"></script>

<!-- Calender controll CSS and JS -->

<link href="resources/css/jquery.ui.core.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/jquery.ui.datepicker.css" rel="stylesheet"
	type="text/css">
	
<!-- Akura -->
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css"> 
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<!-- Akura -->  	
<script type="text/javascript" src="resources/js/main.js"></script>

<script src="resources/js/jquery.ui.core.min.js"></script>
<script src="resources/js/jquery.ui.widget.min.js"></script>
<script src="resources/js/jquery.ui.datepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<!-- Jquery -->
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/ui.jqgrid.css" rel="stylesheet" type="text/css">

<style type="text/css">
.section_full_search .float_left{
	margin-right: 35px;
}

div .section_full_search select{
	width: 180px;
}

#selectedUser{
	width: 174px;
}

.date_field {
	width: 145px;
}

input.button {
	margin-left: -15px;
}
#specificSelectDiv {
	margin-right: 0px;
}
</style>

<script>

$( document ).ready(function() {
    $('.required_sign:not(:first)').hide();
    $('#search_results').hide();
});

var date = new Date();
var currentMonth = date.getMonth();
var currentDate = date.getDate();
var currentYear = date.getFullYear();
	$(function() {
		var dates = $("#auditSearchFromDate, #auditSearchToDate")
				.datepicker(
						{
							defaultDate : "+1w",
							changeYear : true,
							changeMonth : true,
							dateFormat: 'yy-mm-dd',
							numberOfMonths : 1,
							showOn : "button",
							buttonImage : "resources/images/calendar.jpg",
							buttonImageOnly : true,
							maxDate : new Date(currentYear, currentMonth,
									currentDate),
							onSelect : function(selectedDate) {
								var option = this.id == "auditSearchFromDate" ? "minDate"
										: "maxDate", instance = $(this).data(
										"datepicker"), date = $.datepicker
										.parseDate(
												instance.settings.dateFormat
														|| $.datepicker._defaults.dateFormat,
												selectedDate, instance.settings);
								dates.not(this).datepicker("option",
	option,
										date);
								displayTodate();
							}

						});
	});
	
	
	$(function() {    	 
	    $( "#selectedUser" ).autocomplete({
	      source: '<c:url value="/loadUsersWithPartofUsername.htm"/>',
	      minLength: 2	      
	    });
	  });
	
</script>

<script type="text/javascript">
function showMoreDetails(audit){

	var url = "showMoreDetails.htm?auditDetailId="+audit;
	window.open(url, 'myPop1','width=750,height=400,scrollbars=yes');

}

function loadClasses(){
	var selectedGradeId = parseInt(document.getElementById('selectedGrade').value);
	$('#selectedClassGrade').find('option:not(:first)').remove();
	var selector = document.getElementById('selectedClassGrade');
	selector.disabled = true;
	if(selectedGradeId > 0){
		$.ajax({
	        url:'<c:url value="/loadClassGrades.htm" />',
		    data: ({'selectedGradeId' : selectedGradeId}),
		    success: function(response) {
		    	if(response != ''){
			        var responseArray = response.split(",");								        
																							
					if (responseArray.length > 0) {
						var option;
						for ( var i = 0; i < responseArray.length; i++) {
							if (responseArray[i] != "") {
								option = document.createElement('option');
								var responseValue = responseArray[i].split("-");
								option.value = responseValue[1];
								option.appendChild(document.createTextNode(responseValue[0]));
								selector.appendChild(option);								
							}
						}

					}
					selector.disabled = false;
			    }
		    	else{
		    		$('#selectedClassGrade').find('option:not(:first)').remove();
		    		
			    }
		    },
		    error: function(transport) {
	        	custom_alert("An error has occurred.");	        	
	        }
		});		
	}
	else{
		$('#selectedClassGrade').find('option:not(:first)').remove();		
	}
}

function BuildColumnModel(subjectNames){
        var uFields = subjectNames;
        var columns = [];
		
        for(var i = 0;i< uFields.length; i++){
           columns.push({ name : uFields[i] , index : uFields[i] ,sortable:(uFields.length == 2 ? true:((i+2==uFields.length || i+3==uFields.length) ? false:true )), width : (uFields.length==6 ? 142:120) , align : 'center' , editable : false,
		   editoptions: { dataInit: function (el) { $(el).css('text-transform', 'uppercase'); }}});	         
		}
        
        return columns;
	}

function displayGrid(response){
	$("#users").jqGrid('GridUnload');
	if(response[0]!="["){
		custom_alert(response);
	}
	else{
		var parsedData = JSON.parse(response);		
		if(parsedData.length > 0){
			$('#search_results').show();
			var colname = Object.keys(parsedData[0]);
			var lastindex = colname.length-1;
			
			
			jQuery('#users').jqGrid({
				firstsortorder: 'desc',		
				datatype: "jsonstring",
				datastr: response,   			    			  
				colNames: colname,
				mtype: 'GET',
				colModel: BuildColumnModel(colname),
				pager: '#usersPage',
				width: 905,
				height: 300,
				rowNum: 500,
				sortorder: 'desc',
				sortname:colname[lastindex],
				rownumbers: true,			
				cellsubmit:'clientArray',
					shrinkToFit: false			
				}).trigger("reloadGrid");						
		}
		else{
			$('#search_results').hide();
			var errorMessageLabel = document.getElementById("errorMessagelabel");
			errorMessagelabel.innerHTML = '<spring:message code="REF.UI.VIEWAUDITDETAILS.NODATA.TODISPLAY" />';
		}
	}	
}
	

function loadAuditDetails(){
	var auditCategory = parseInt(document.getElementById('selectedAuditCategory').value);
	clearErrorMessage();
	var userName = document.getElementById('selectedUser').value;
	var fromDate = $('#auditSearchFromDate').datepicker({ dateFormat: 'yyyy-mm-dd' }).val(); 
	var toDate = $( '#auditSearchToDate' ).datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
	var classGrade = parseInt(document.getElementById('selectedClassGrade').value);
	var year = parseInt(document.getElementById('selectedYear').value);	
	var specificSelectorId = parseInt(document.getElementById('specificIdSelector').value);
	if(!!auditCategory && !!classGrade && !!year && !!specificSelectorId)
	{
		var url = "";
		var data = {};
		switch(auditCategory){
		case 1:		
			data = {'userName' : userName , 'fromDate' : fromDate, 'toDate' : toDate, 'selectedYear' : year, 'classGrade' : classGrade, 'selectedTerm': specificSelectorId};
			url = '<c:url value="/loadTermMarkAudit.htm" />';		
			break;
		case 2:		
			data = {'userName' : userName , 'fromDate' : fromDate, 'toDate' : toDate, 'selectedYear' : year, 'classGrade' : classGrade, 'selectedTerm': specificSelectorId};
			url = '<c:url value="/loadMonthlyGradeAudit.htm" />';
			break;
		case 3:		
			data = {'userName' : userName , 'fromDate' : fromDate, 'toDate' : toDate, 'selectedYear' : year, 'classGrade' : classGrade, 'selectedExamId': specificSelectorId};
			url = '<c:url value="/loadExamMarkAudit.htm" />';
			break;
		case 4:
			data = {'userName' : userName , 'fromDate' : fromDate, 'toDate' : toDate, 'selectedYear' : year, 'classGrade' : classGrade, 'selectedAssignmentId': specificSelectorId};
			url = '<c:url value="/loadAssignmentMarkAudit.htm" />';
			break;
		case 5:
			data = {'userName' : userName , 'fromDate' : fromDate, 'toDate' : toDate, 'selectedYear' : year, 'classGrade' : classGrade, 'selectedTerm': specificSelectorId};
			url = '<c:url value="/loadMarkCompleteAudit.htm" />';
			break;
		}
		$.ajax({
	        url:url,
		    data:data,
		    success: function(response) {
		    	displayGrid(response);
		    },
		    error: function(transport) {
	        	custom_alert("An error has occurred.");
	        }
		});
	}
	else{		
		$("#users").jqGrid('GridUnload');
		$('#search_results').hide();
		var errorMessageLabel = document.getElementById("errorMessagelabel");
		errorMessagelabel.innerHTML = '<spring:message code="REF.UI.VIEWAUDITDETAILS.MANDATORY.NOTFILLED" />';
	}
}

function loadSpecificSelect(){
	clearErrorMessage();
	$('.required_sign:not(:first)').hide();
	var auditCategory = parseInt(document.getElementById('selectedAuditCategory').value);	
	var year = parseInt(document.getElementById('selectedYear').value);
	var gradeId = parseInt(document.getElementById('selectedGrade').value);
	var classGradeId = parseInt(document.getElementById('selectedClassGrade').value);
	var selector = document.getElementById('specificIdSelector');
	selector.disabled = true;
	$('#specificIdSelector').find('option:not(:first)').remove();
	if(!!auditCategory){
		$('.required_sign').show();
		var specificLabel = document.getElementById('specificSelectLabel');		
		var url = "";
		var data = {'selectedGradeId': gradeId, 'specSelectedYear': year};
		var option;
		switch(auditCategory){
		case 1:
		case 2:
		case 5:
			specificLabel.innerHTML = '<spring:message code="REF.UI.AUDIT.DETAILS.TERM" />' ;
			<c:forEach items="${termList}" var="term" varStatus="termStatus">
				option = document.createElement('option');
				option.value = "${term.termId}";
				option.appendChild(document.createTextNode("${term.description}"));
				selector.appendChild(option);
			</c:forEach>
			document.getElementById('specificSelectDiv').style.display = "block";			
			break;
		case 3:
			specificLabel.innerHTML = '<spring:message code="REF.UI.AUDIT.DETAILS.EXAM" />';
			document.getElementById('specificSelectDiv').style.display = "block";
			break;
		case 4:
			specificLabel.innerHTML = '<spring:message code="REF.UI.AUDIT.DETAILS.ASSIGNMENT" />';	
			document.getElementById('specificSelectDiv').style.display = "block";
			break;
		}
		if(!!year && !!classGradeId){	//If all existing mandatory fields are filled
			if(auditCategory == 3){	//load exams
				url = '<c:url value="/loadExamsForAudit.htm" />';
				data = {'selectedGradeId': gradeId, 'specSelectedYear': year};
				loadOptions(url, data, selector);
			}
			else if(auditCategory == 4){	//load assignments
				url = '<c:url value="/loadAssignmentsForAudit.htm" />';
				data = {'selectedClassGradeId': classGradeId, 'specSelectedYear': year};
				loadOptions(url, data, selector);
			}
			selector.disabled = false;	//do for all the categories
		}		
	}
	else
		document.getElementById('specificSelectDiv').style.display = "none";
}

function loadOptions(url, data, selector){
	var option;
	$.ajax({
        url:url,
	    data:data,
	    success: function(response) {
	    	if(response != ''){
		        var responseArray = response.split(",");						        																							
				if (responseArray.length > 0) {							
					for ( var i = 0; i < responseArray.length; i++) {
						if (responseArray[i] != "") {
							option = document.createElement('option');
							var responseValue = responseArray[i].split("_");
							option.value = responseValue[1];
							option.appendChild(document.createTextNode(responseValue[0]));
							selector.appendChild(option);								
						}
					}
				}
		    }
	    	else{
	    		$('#specificIdSelector').find('option:not(:first)').remove();
		    }
	    },
	    error: function(transport) {
        	custom_alert("An error has occurred.");
        }
	});
}

function clearErrorMessage(){
	var errorMessageLabel = document.getElementById("errorMessagelabel");
	errorMessagelabel.innerHTML = '';
}

function toggleRequiredFields(selector){
	var disabledVal = (selector.value == "0" ? true : false) ;
	document.getElementById('selectedGrade').disabled = disabledVal;
	document.getElementById('selectedYear').disabled = disabledVal;
	document.getElementById('selectedClassGrade').disabled = disabledVal;
}

function previousOrNext(value){
	pageSize = 10;

	if(value == "next"){
		startFrom = parseInt(${startFrom}) + pageSize;
		document.getElementById('startFrom').value = startFrom + "";
	}else if(value == "previous"){
		startFrom = parseInt(${startFrom}) - pageSize;
		document.getElementById('startFrom').value = startFrom + "";
	}

	document.getElementById('actionType').value = value;
	document.staffSearch.submit();
}

function displayTodate(){
	fromDate = document.getElementById('auditSearchFromDate').value;

	if(fromDate == null || fromDate == ""){

		$("#todate").css("display", "none");

	} else {
		$("#todate").css("display", "inline");

	}


}


</script>
</head>
<body >
<h:headerNew parentTabId="26" page="referenceModule.htm" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currentYear" value="${now}" pattern="yyyy" />
<div id="page_container">
	<div id="breadcrumb_area">
	  <div id="breadcrumb">
		<ul>

				<li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
				<li><a href="referenceModule.htm"><spring:message code="REF.UI.REFERENCE" /></a>&nbsp;&gt;&nbsp;</li>
				<li><spring:message code="REF.UI.AUDIT.DETAILS.TITLE" /></li>

		</ul>
	  </div>
	  <div class="help_link">
		<a href="#"
		onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/AuditDetailsHelp.html"/>','helpWindow',780,550)"><img
		src="resources/images/ico_help.png" width="20" height="20"
		align="absmiddle"><spring:message code="REF.UI.HELP"/></a>
	  </div>
	</div>
  	<div class="clearfix"></div>
  	<h1><spring:message code="REF.UI.AUDIT.DETAILS.TITLE" /></h1>
  	<div>
			<label class="missing_required_error" id="errorMessagelabel" ></label>
	</div> 
  	<div id="content_main">

      <div class="clearfix"></div>
      <div class="section_full_search">
        <div class="box_border">       					
          <div class="row">
          <div class="float_left">
                <div class="lbl_lock">
                	<span class="required_sign">*</span>
					<label><spring:message code="REF.UI.AUDIT.DETAILS.AUDIT.CATEGORY"/></label>
                </div>

					<select id="selectedAuditCategory" name="auditCategory" onchange = "toggleRequiredFields(this);loadSpecificSelect();">
					<option value ="0"><spring:message code="application.drop.down"/></option>
					<c:forEach items="${auditCategoryList}" var="auditCategory" >
						<option value="${auditCategory.auditCategoryId}">${auditCategory.auditCategoryDescription}
						</option>
					</c:forEach>
					</select>


            </div>
            <div class="float_left">
                <div class="lbl_lock">
					<label><spring:message code="REF.UI.AUDIT.DETAILS.USER.LABEL"/></label>
                </div>
				<input id = "selectedUser" >

            </div>
            <div class="float_left">
				<div class="lbl_lock">
					<label><spring:message code="REF.UI.AUDIT.DETAILS.FROM.DATE"/></label>
				</div>
				<input id="auditSearchFromDate" class="date_field" onchange="displayTodate(); document.getElementById('auditSearchToDate').value = '';"/>
            </div>
            <div class="float_left">
				<div class="lbl_lock">
					<label><spring:message code="REF.UI.AUDIT.DETAILS.TO.DATE"/></label>
				</div>
				<input id="auditSearchToDate" class="date_field" onchange="displayTodate(); document.getElementById('auditSearchToDate').value = '';"/>
            </div>          
					
          </div>
		  <div class="row">
		  <div class="float_left">
              <div class="lbl_lock">
              <span class="required_sign">*</span>
                <label><spring:message code="REF.UI.AUDIT.DETAILS.GRADE"/></label>
              </div>
               <select name="grade" id="selectedGrade" disabled = true onchange="loadClasses();loadSpecificSelect();">
					<option value ="0"><spring:message code="application.drop.down"/></option>
					<c:forEach items="${gradeList}" var="grade" >
						<option value="${grade.gradeId}">${grade.description}</option>
					</c:forEach>
				</select>
            </div>		
<div class="float_left">
              <div class="lbl_lock">
              <span class="required_sign">*</span>
                <label><spring:message code="REF.UI.AUDIT.DETAILS.CLASS"/></label>
              </div>
              <div id = "classGradeDiv" >
               <select name="classGrade" id="selectedClassGrade"  disabled = true onchange = "loadSpecificSelect();">
					<option value ="0"><spring:message code="application.drop.down"/></option>					
				</select>
				</div>
            </div>	
            <div class="float_left">
              <div class="lbl_lock">
              <span class="required_sign">*</span>
                <label><spring:message code="REF.UI.AUDIT.DETAILS.YEAR"/></label>
              </div>
               <select name="selectedYear" id="selectedYear" disabled = true onchange = "loadSpecificSelect();">					
									<c:forEach var="i" begin="0" end="5" varStatus="loop" step="1">
													<option value="${currentYear - i}" <c:if test="${i == 0}">selected="selected"</c:if>>${currentYear - i}</option>
							          	</c:forEach>
				</select>
            </div>	
            <div class="float_left" id = "specificSelectDiv" style="display:none">
              <div class="lbl_lock">
              	<span class="required_sign">*</span>
                <label id = "specificSelectLabel"><spring:message code="REF.UI.AUDIT.DETAILS.EXAM"/></label>
              </div>
               <select name="specific_select" id="specificIdSelector" onchange = "clearErrorMessage();">
					<option value ="0"><spring:message code="application.drop.down"/></option>					
				</select>
            </div>	
			
			<div class="float_right">
              <div class="buttion_bar_type1">

              	<sec:authorize access="hasRole('Search Audit Details')">

                	<input type="button" value="<spring:message code="REF.UI.SEARCH" />" onClick="loadAuditDetails();" class="button"/>

              	</sec:authorize>

              </div>
            </div>
			
</div>
          <div class="clearfix"></div>
        </div>
      </div>
      
<div class="section_box" id="search_results">
	<div class="section_box_header">
		<h2><label>Audit View</label></h2>
	</div>
	<div class="column_single">

	 	<div id="validationErrorMessage" name="validationErrorMessage">
			<label class="missing_required_error" id="validationErrorMessagelabel" name="validationErrorMessagelabel"></label>
		</div>
	 
							<div id="tableDiv_General" class="tableDiv">
							<table id="users" class="FixedTables">
							</table>
							<div id="usersPage" ></div>
								
							</div>				
		<input type="hidden" id="editedMarksJsonArray" name="editedMarksJsonArray" value="" />
		<input type="hidden" id="editedIndexJsonArray" name="editedIndexJsonArray" value="" />				
	</div>
	</div>
		<div class="clearfix"></div>
		
     <input type="hidden" name="startFrom" id="startFrom" value="0"/>
	 <input type="hidden" name="actionType" id="actionType" value="search"/>

    </div>
    </div>
 

<h:footer />
</body>
</html>
