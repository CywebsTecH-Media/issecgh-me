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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="strEscapeUtil" uri="/WEB-INF/stringEscapeUtil/"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<!-- Jquery -->
<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/ui.jqgrid.css" rel="stylesheet" type="text/css">
<script src="resources/js/messageCommon.js"></script>
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

<script type="text/javascript">

var data = '${JsonData}';
//var data = '${LeaveJsonData}';

var selectedStatus;

 $(document).ready(function(){
	jQuery("#users").jqGrid({
		datatype: "jsonstring",
		datastr: data,
		colNames: ["Reg. No.","Name","Staff Leave Id", "Staff Id", "Leave Type Id", "From Date","To Date","No. of Days","Leave Type","Reason","Applied Date","Date Type","Leave Status","Status Id",""],
		colModel: [	{name:'regNo', index:'regNo', width:52},
					{name:'name', index:'name', width:90},
					{name:'staffLeaveId', index:'staffLeaveId', width:150, hidden:true },
					{name:'staffId', index:'staffId', width:150, hidden:true},
					{name:'staffLeaveTypeId', index:'staffLeaveTypeId', width:150, hidden:true },
					{name:'fromDate', index:'fromDate', width:67},
					{name:'toDate', index:'toDate', width:67},
					{name:'totalDays', index:'totalDays', width:71},
					{name:'leaveType', index:'leaveType', width:140},
					{name:'reason', index:'reason', width:110},
					{name:'appliedDate', index:'appliedDate', width:99},
					{name:'dateType', index:'dateType', width:120, hidden:true},
					{name:'leaveStatus', index:'leaveStatus', width:110},
					{name:'leaveStatusId', index:'leaveStatusId', width:120, hidden:true},
					{name:'button', index:'button', width:15,formatter: 
						function(cellvalue, options, rowObject) {
						var statusID = rowObject['leaveStatusId'];								
						if((statusID == 1) || (statusID == '1') || (statusID == 4) || (statusID == '4')){								
							return ''; 
						} else {								
							return '<img src="resources/images/icon_accept.png" title="Approve/Reject Applied Staff Leave" onclick="jsonEditStaffLeave('+options.rowId+');"></span>'; 
						}
					}
				    }
					],
		pager: '#usersPage',
		width: 900,
		height: 200,
		rowNum: 500,
		rownumbers: true,
		sortname: 'appliedDate',
		viewrecords: true,
		sortorder: 'asc',
		shrinkToFit: false		
	});
});
 

function jsonEditStaffLeave(rowid) {
	$('.section_full_inside').show();
	
	var rowData = $("#users").getRowData(rowid);
	selectedStatus = rowData["leaveStatusId"];
	
	if(selectedStatus == 2 || selectedStatus == 5){
		document.getElementById('rejectedStatusId').checked = true;
	}

	document.showLeaveApprovalProcessForm.staffLeaveId.value =rowData["staffLeaveId"];
	document.showLeaveApprovalProcessForm.staffId.value =rowData["staffId"];
	document.showLeaveApprovalProcessForm.fromDate.value =rowData["fromDate"];
	document.showLeaveApprovalProcessForm.toDate.value =rowData["toDate"];
	document.showLeaveApprovalProcessForm.reason.value =rowData["reason"];
	document.showLeaveApprovalProcessForm.noOfDays.value =rowData["totalDays"];
	document.showLeaveApprovalProcessForm.staffLeaveTypeId.value =rowData["staffLeaveTypeId"];
	document.showLeaveApprovalProcessForm.appliedDate.value =rowData["appliedDate"];
	document.showLeaveApprovalProcessForm.dateType.value =rowData["dateType"];
	document.showLeaveApprovalProcessForm.staffLeaveStatusId.value ='0';
	document.showLeaveApprovalProcessForm.comment.value ='';


}

function jsonSaveStaffLeave() {
	if(!document.getElementById('approvedStatusId').checked && !document.getElementById('rejectedStatusId').checked){
		document.getElementById("errmsg").innerHTML ="<p Class='required_sign'><spring:message code='STA.UI.MANDATORY.FIELD.REQUIRED' /></p>";  
	}else{
		if(selectedStatus == 3 || selectedStatus == 2){
			if(document.getElementById('approvedStatusId').checked){
				document.getElementById('approvedStatusId').value ='1';
			}
			else if(document.getElementById('rejectedStatusId').checked){
				document.getElementById('rejectedStatusId').value ='2';
			}
		}
		else if(selectedStatus == 6 || selectedStatus == 5){
			if(document.getElementById('approvedStatusId').checked){
				document.getElementById('approvedStatusId').value = '4';
			}
			else if(document.getElementById('rejectedStatusId').checked){
				document.getElementById('rejectedStatusId').value ='5';
			}
		}
		document.showLeaveApprovalProcessForm.action = "saveStaffLeaveApproval.htm";
		document.showLeaveApprovalProcessForm.submit();
	}
}

function onClickCancel(){
	$('.section_full_inside').hide();
	document.getElementById("errmsg").innerHTML = "";
}

function Search(){	
	document.showLeaveApprovalProcessForm.action = "searchStaffLeaves.htm";
	document.showLeaveApprovalProcessForm.submit();
}	
	
	function holidayExist() {


		
			if("${approvalMessage}"=='<spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.All_ARE_HOLIDAYS"/>'){
			
				var r=confirm('<spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.QUESTION.All_ARE_HOLIDAYS"/>');
				if (r==true) {
					document.showLeaveApprovalProcessForm.comment.value ='<spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.EMAIL.All_ARE_HOLIDAYS"/>';
					document.showLeaveApprovalProcessForm.staffLeaveStatusId.value ='2';
					document.showLeaveApprovalProcessForm.action = "saveStaffLeaveApproval.htm";
					document.showLeaveApprovalProcessForm.submit();
				}
			}
			else{
				var r=confirm('<spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.QUESTION.HOLYDAY_EXIST"/>');
				if (r==true) {
					document.showLeaveApprovalProcessForm.comment.value ='<spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.EMAIL.HOLYDAY_EXIST"/>';
					document.showLeaveApprovalProcessForm.staffLeaveStatusId.value ='2';
					document.showLeaveApprovalProcessForm.action = "saveStaffLeaveApproval.htm";
					document.showLeaveApprovalProcessForm.submit();
				}
			}
		
				
		
	
		
	}
	
</script>

</head>
<body >
	<h:headerNew parentTabId="1" page="leaveApprovalProcess.htm" />
	
	<div id="page_container">
	  <div id="breadcrumb_area">
	    <div id="breadcrumb">
	      <ul>
	        <li><a href="adminWelcome.htm"><spring:message code="application.home" /></a>&nbsp;&gt;&nbsp;</li>
	        <li><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS" /></li>
	      </ul>
	    </div>
	    <div class="help_link">
			<a href="#"
				onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/staffLeaveApprovalHelp.html"/>','helpWindow',780,550)"><img
				src="resources/images/ico_help.png" width="20" height="20"
				align="absmiddle"> <spring:message code="application.help" />
			</a>
		</div>
	  </div>
	  <div class="clearfix"></div>
	  <h1><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS" /></h1>
	  <div id="content_main">
	    
		<form:form method="POST" commandName="staffLeave" name="showLeaveApprovalProcessForm">
		
	
		
		<div class="clearfix"></div>
		<div class="messageArea" style="padding-left:14px;">
					<label class="required_sign"> 
					<c:if test="${message != null}">
					${message}</c:if>
						<form:errors path="staffLeaveId" />
					</label>
					<label class="success_sign"> 
						<c:if test="${successMessage != null}">${successMessage}</c:if>
					</label><br>
					<label class="required_sign"> 
						<c:if test="${emailMessage != null}">${emailMessage}</c:if>
					</label>
					<label class="required_sign">
						<c:if test="${noRecords != null}">${noRecords}</c:if>
					</label>
		</div>
		<div id="errmsg" name="errmsg">	</div>
		<div class = "section_full_search">
			<div class = "box_border">
				<div class = "row">
					<div class = "float_left">
						<div class = "lbl_lock">
							<label> <spring:message code = 'STAFF.LEAVE_APPROVAL_PROCESS.LEAVE_STATUS' /> </label>
							<select path="staffLeaveStatusId" id="statusId" name="statusId" >
								<option value="0">
									<spring:message code="application.drop.down" />
								</option>
								<c:forEach items="${leaveStatusList}" var="status">
									<option value="${status.staffLeaveStatusId}"> ${status.description} </option>
								</c:forEach>
				  			</select>
						</div>
					</div>
					<div class = "float_left">
						<div class = "lbl_lock">
							<label> <spring:message code = 'STAFF.SEARCH_STAFF_MEMBER.EMP_NO' /> </label>
							<input type="text" name="empNumber" id="empNumber" value=""/>
						</div>
					</div>
					<div class="float_right">
						<div class="buttion_bar_type1">
							<input type="button" value="<spring:message code='REF.UI.SEARCH' />" onClick="Search()" class="button">
						</div>
					</div>
				</div>
			<div class = "clearfix"></div>
			</div>
		</div>
		<div class="section_box" id="search_results">
			<div class="section_box_header">
	         	<h2><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS_TABLE_HEADER" /></h2>
	        </div>
	        <div class="column_single">
	        	<div id="tableDiv_General" class="tableDiv">
					<table id="users" class="FixedTables"></table>
					<div id="usersPage" ></div>
				</div>	
					
	        </div>
		</div> 
		<div class="section_full_inside" id="showApproveRejectPane"  style='display: ${editpane != null ?'block':'none'}'>
	          <h3><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.APPROVE_REJECT_LEAVE"/></h3>
	          <div class="box_border">
			 
			  <div class="row">
	              <div class="float_left">
	                <div class="lbl_lock">
	                  <span class="required_sign">*</span><label><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.LEAVE_STATUS"/></label>
	                </div>
				  		<form:radiobutton path="staffLeaveStatusId" value="" id="approvedStatusId" label="" cssClass="radio_btn" name="approvedStatusId" />
				  			<spring:message code="STAFF.LEAVE.APPROVED" />
				  		<form:radiobutton path="staffLeaveStatusId" value="" id="rejectedStatusId" label="" cssClass="radio_btn" name="rejectedStatusId"/>
				  				<spring:message code="STAFF.LEAVE.REJECTED" />				  		
	              </div>
				  <div class="float_right">
	                <div class="lbl_lock">
	                  <label><spring:message code="STAFF.LEAVE_APPROVAL_PROCESS.COMMENT"/></label>
	                </div>
	                <form:textarea path="comment" maxlength="150"/>
	                <form:hidden path="staffLeaveId" id="staffLeaveId"/>
	                <form:hidden path="staffId" id="staffId"/>
	                <form:hidden path="fromDate" id="fromDate"/>
	                <form:hidden path="toDate" id="toDate"/>
	                <form:hidden path="reason" id="reason"/>
	                <form:hidden path="noOfDays" id="noOfDays"/>
	                <form:hidden path="staffLeaveTypeId" id="staffLeaveTypeId"/>
	                <form:hidden path="appliedDate" id="appliedDate"/>
	                <form:hidden path="dateType" id="dateType"/>
	              </div>
	            </div>
				
				<div class="row">
	              <div class="buttion_bar_type1">
				    <input type="button" class="button" onClick="jsonSaveStaffLeave()" value="<spring:message code="REF.UI.SAVE"/>">
	                <input type="button" class="button" onClick="onClickCancel(); clearMessages()" value="<spring:message code="REF.UI.CANCEL"/>">
	              </div>
	            </div>
	            
	            <div class="clearfix"></div>
	          </div>
	        </div> 
		
		 
		 	<c:if test="${approvalMessage != null}">   
				<script>
					holidayExist(); 
				</script>
			</c:if>
		 
	    </form:form>
	  </div>
	</div>
<h:footer />
</body>
</html>