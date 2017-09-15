<%--
    < �KURA, This application manages the daily activities of a Teacher and a Student of a School>

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

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

	//delete staff
	function deleteStaff(thisObj, staffId) {

		$(thisObj).parents('tr').addClass('highlight');
		
		var okfunction = function(){
			document.getElementById('selectedStaffId').value = staffId;
			document.staffSearch.action = "deleteStaff.htm";
            document.staffSearch.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};
		
		var message = "<spring:message code='REF.DELETE.CONFIRMATION'/>";
		
		confirm_function(message, okfunction, cancelfunction);
		
	}

	//Used of pagination in onclick event of previous and next buttons
	function previousOrNext(value){
		pageSize = 10;

		if(value == "next"){
			startFrom = parseInt(${startFrom}) + pageSize;
			document.getElementById('startFrom').value = startFrom + "";
		}else if(value == "previous"){
			startFrom = parseInt(${startFrom}) - pageSize;
			document.getElementById('startFrom').value = startFrom + "";
		}
		
		// Set only boolean value for radio buttons which map
		// to boolean Staff.StaffCategory.academic property.
		if ($('#acdamicType').val() == "true") {
			$('#acadumic').attr('value', true);
			$('#nonAcadumic').removeAttr('value');
		} else if ($('#acdamicType').val() == "false") {
			$('#nonAcadumic').attr('value', false);
			$('#acadumic').removeAttr('value');
		} else {
			$('#acadumic').removeAttr('value');
			$('#nonAcadumic').removeAttr('value');
		}
		
		document.getElementById('actionType').value = value;
		document.staffSearch.submit();
	}

	function fillStaffDetails(staffId) {

		var url = '<c:url value="/loadStaffDetails.htm" />';

		$.ajax({
                url:url,
	        data:({
	              'staffId': staffId
	        }),
	        success: function(response) {
	        		<c:url value="/viewStaffMemberDetails.htm" var="gotourl" />
	         		location.replace('<c:out value="${gotourl}" escapeXml="true"/>');
	        },
	        error: function(transport) {
	        	custom_alert("An error has occurred.");
	        }
        });
     }

    function checkedStaffType(value) {
    	
    	if(document.getElementById('acdamicType').value == "true") {
			//document.getElementById('acadumic').checked = checked;
			$('#acadumic').attr('checked',true);
		} else if(document.getElementById('acdamicType').value == "false") {
			//document.getElementById('nonAcadumic').checked = checked;
			$('#nonAcadumic').attr('checked',true);
		}
    	
    }

	//open pop up menu window
	function openWindow(url){
		var newWindow=window.open(url,'_blank','status=0,toolbar=0,menubar=0,location=0,resizable=1,width = 980,scrollbars=1');
		newWindow.location=url;
	}
	
	function setAcademicStatus() {
		
		if ($('#acadumic').is(':checked')) {
			$('#acadumic').attr('value', true);
		} else if ($('#nonAcadumic').is(':checked')) {
			$('#nonAcadumic').attr('value', false);
		}
		
		document.staffSearch.submit();
		
	}

</script>

</head>
<body onload="<c:if test="${acdamicType != null}">checkedStaffType('<c:out value="${acdamicType}" />');</c:if>">
<h:headerNew parentTabId="1" page="staffSearch.htm"/>
<div id="page_container">
  <div id="breadcrumb">
    <ul>
      <li><a href="adminWelcome.htm"><spring:message code="application.home"/></a>&nbsp;&gt;&nbsp;</li>
      <li><spring:message code="STAFF.SEARCH_STAFF_MEMBER"/></li>
    </ul>
  </div>
  <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/staff/searchStaffMemberHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="application.help"/></a></div>
  <div class="clearfix"></div>
  <h1><spring:message code="STAFF.SEARCH_STAFF_MEMBER"/></h1>
        <label class="required_sign">
       <c:if test="${message != null}">
			${message}
		</c:if>
		</label>
  <div id="content_main">
    <form:form method="POST" commandName="staff" name="staffSearch" action="staffSearch.htm">

      <div class="clearfix"></div>
	  <div class="section_full_search">
          <div class="box_border">
            <div class="row">
              <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.SEARCH_STAFF_MEMBER.LAST_NAME"/></label>
                </div>
                <form:input path="lastName" />
              </div>
			  <div class="float_left">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.SEARCH_STAFF_MEMBER.EMP_NO"/></label>
                </div>
               <form:input path="registrationNo" />
              </div>
			  <div class="float_left" style="margin-right:30px;">
                <div class="lbl_lock">
                  <label><spring:message code="STAFF.SEARCH_STAFF_MEMBER.STAFF_TYPE"/></label>
                </div>
				<form:radiobutton id="acadumic" path="staffCategory.academic" cssClass="radio_btn" /><label class="label_inline"><spring:message code="STAFF.SEARCH_STAFF_MEMBER.ACADEMIC"/></label>
				<form:radiobutton id="nonAcadumic" path="staffCategory.academic" cssClass="radio_btn" /><label class="label_inline"><spring:message code="STAFF.SEARCH_STAFF_MEMBER.NON_ACADEMIC"/></label>
                </div>
                </div>

                <div class="row">
               <div class="float_left" >
								<div class="lbl_lock">
									 <label><spring:message
											code='STAFF.SEARCH_STAFF_MEMBER.STAFF_STATUS' />:</label>
								</div>


								<form:select path="staffStatus" name="selectStatus">



									<form:option value="0">
										<spring:message code="application.drop.down" />
									</form:option>
									<form:option value="1">
										<spring:message code='STAFF.SEARCH_STAFF_MEMBER.STAFF_PRESENT' />
									</form:option>
									<form:option value="2">
										<spring:message code='STAFF.SEARCH_STAFF_MEMBER.STAFF_PAST' />
									</form:option>
								</form:select>

							</div>


            <div class="float_right">

                 <div class="buttion_bar_type1">
                 <sec:authorize access="hasAnyRole('Search Staff Members')">
                	<input type="submit" value="<spring:message code='REF.UI.SEARCH'/>" onclick="setAcademicStatus();" class="button" />
                </sec:authorize>
              </div>
              </div>
            </div>

            <div class="clearfix"></div>
          </div>
      </div>
            <c:if test="${fn:length(staffList) > 0 || (staffList) == 'Empty' }">
      <div class="section_box"  id="search_results">

        <div class="section_box_header">
          <h2><spring:message code="STAFF.SEARCH_STAFF_MEMBER.SEARCH_RESULTS"/></h2>
        </div>


        <div class="column_single" >
          <table class="basic_grid"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th><spring:message code="STAFF.SEARCH_STAFF_MEMBER.EMP_NO"/></th>
              <th><spring:message code="STAFF.SEARCH_STAFF_MEMBER.STAFF_MEMBER_NAME"/></th>             
              <th width="150" class="right">
              		<c:if test="${numberOfRecords == 0}">${startFrom}</c:if>
              		<c:if test="${numberOfRecords > 0}">${startFrom+1}</c:if>
              		 - ${maxNumber} of ${numberOfRecords} <br><input
            		type="image" class="button" width="15" height="15" src="resources/images/leftSideArrow.png" title="<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.PREVIOUS"/>"
            		onclick="previousOrNext('previous')" <c:if test="${startFrom == 0}">disabled="disabled"</c:if>>
            		<input type="image" width="20" height="15" class="button" src="resources/images/rightSideArrow.png" title="<spring:message code="REF.UI.MANAGE.SYSTEM.USERS.NEXT"/>"
            		onclick="previousOrNext('next')" <c:if test="${maxNumber == numberOfRecords}">disabled="disabled"</c:if>>
              </th>
<!--              <th width="42" class="right"><a href="Staff_module_staff_member_details.html"><img src="../images/ico_new.gif" width="18" height="20" border="0" class="icon_new" title="Add New Staff Member"></a></th>-->
            </tr>

            <c:choose>
            	<c:when test="${(staffList) == 'Empty' }" >
            		<tr class="odd">
            			<td><h5><spring:message code="STAFF.SEARCH_STAFF_MEMBER.NO_RESULTS_FOUND"/></h5></td>
            			<td></td>
            		</tr>
            	</c:when>

            	<c:otherwise>
            		<c:forEach items="${staffList}" var="staff" varStatus="status">
						<tr class="<c:if test="${status.count % 2 == 0}">even</c:if>
						<c:if test="${status.count % 2 == 1}">odd</c:if>">
              			<td>${staff.registrationNo}</td>
              			<td><a href="javascript:fillStaffDetails(${staff.staffId})">${staff.nameWithIntials}</a> </td>
              			<td class="right">

              				<c:if test="${staff.dateOfDeparture == null}">

              				<sec:authorize access="hasAnyRole('Terminate Staff Member')">
              				<a href="#" onclick="openWindow('staffDepartureDetails.htm?selectedStaffId=${staff.staffId}')"><img class="icon" src="resources/images/ico_disableuser.gif" title="<spring:message code='REF.UI.TERMINATE.STAFF'/>" width="18" height="20" border="0" ></a>
              				</sec:authorize>

              				<sec:authorize access="hasAnyRole('Add/Edit Staff Member Page')">
              					<img class="icon" src="resources/images/ico_edit.gif" width="18" height="20" border="0" class="icon" onclick="fillStaffDetails(${staff.staffId})" title="<spring:message code='STAFF.SEARCH_STAFF_MEMBER.EDIT.STAFF'/>">
              				</sec:authorize>


              				<sec:authorize access="hasAnyRole('Delete Staff Member')">
              					<img class="icon" src="resources/images/ico_delete.gif" onClick="deleteStaff(this, ${staff.staffId})" title="<spring:message code='REF.UI.DELETE'/>" width="18" height="20">
              				</sec:authorize>

              				</c:if>

              				<c:if test="${staff.dateOfDeparture != null}">

              				<sec:authorize access="hasAnyRole('View Staff Service')">
              				<a href="#" onclick="openWindow('viewPastStaffService.htm?selectedStaffId=${staff.staffId}')"><img class="icon" src="resources/images/ico_user.gif" title="<spring:message code='REF.UI.VIEW.SERVICE'/>" width="18" height="20" border="0" ></a>
              				</sec:authorize>
              				</c:if>
              			</td>
            			</tr>
            		</c:forEach>
  				</c:otherwise>
			</c:choose>

          </table>
        </div>

        <div class="clearfix"></div>
      </div>
      </c:if>
	  <div class="button_row">
	  <div class="buttion_bar_type2" >
	  		<sec:authorize access="hasAnyRole('Add/Edit Staff Member Page')">
				<input type="button" value='<spring:message code="STAFF.UI.ADD_STAFF_BUTTON"/>' onClick="window.location='newStaffDetails.htm'" class="button">
			</sec:authorize>
        </div>
			  <div class="clearfix"></div>
	  </div>

	<input type="hidden" name="selectedStaffId" id="selectedStaffId"/>
	<input type="hidden" name="startFrom" id="startFrom" value="0"/>
	<input type="hidden" name="actionType" id="actionType" value="search"/>
	<input type="hidden" name="acdamicType" id="acdamicType" value="${acdamicType}"/>
   </form:form>
  </div>
</div>
<h:footer />
</body>
</html>