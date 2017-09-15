<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE HTML>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME" />
</title>
<link href="resources/css/css_reset.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet"
	type="text/css">
<script language="javascript" src="resources/js/jquery-1.6.2.min.js"></script>
<script language="javascript" src="resources/js/main.js"></script>




<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui_smoothness.css" />
<script src="resources/js/jquery-ui_smoothness.js"></script>
<script src="resources/js/messageCommon.js"></script>


<script type="text/javascript">
	function deleteSchoolClass(thisObj) {
		
		var elementWraper = $(thisObj).closest('.section_box');
		$(elementWraper).find('.basic_grid tr').removeClass('highlight');
		$(thisObj).parents('tr').addClass('highlight');
		$(elementWraper).find('.section_full_inside').hide();
		
		
		
		var okfunction = function(){
			document.form.action = 'manageDeleteSchoolClass.htm';
			document.form.submit();
		};
		
		var cancelfunction = function(){
			$(thisObj).parents('tr').removeClass('highlight');
		};


		var message='<spring:message code="REF.DELETE.CONFIRMATION"/>';
		confirm_function(message, okfunction, cancelfunction);	
	}
	

	
	
	
	var oldSchoolClass;
	var oldClassId;
	function edit(thisVal,schoolClass,classId ){
		oldSchoolClass= schoolClass;
		oldClassId= classId;	
		 setAddEditPane(thisVal,'Edit');
			document.form.description.value= schoolClass;
			document.form.classId.value= classId;
	}
	
	function showArea() {
		$(document).ready(function() {
			$(".areaTop").hide();
			$(".areaBot").hide();
			$(".area").hide();
		});
	}
	
	function addEditPanelTitle(classId) {
		if(classId > 0) {
			$('#addEditPanelTitle').empty();
			$('#addEditPanelTitle').append("<spring:message code='REF.UI.MANAGE.CLASSES.EDIT' />");
		}
	}

		function showDown(bool){
			var name = '${editpane}';
			if(bool){
			$(document).ready(function() {
				if(name == null){								
				$(".section_full_inside").hide();			 
				}
				else{			
				$(".section_full_inside").show();
				var position = $(".section_full_inside").position();			
				scroll(0,position.top);	
				}
			});
			}
			else
			{
			var position = $(".section_full_inside").position();			
			scroll(0,position.top);	
			}
	}
		
	function showErrorMessage(){
		if(${del!= null}){	
			$(".areaBot").hide();
		}
		else{
			$(".areaTop").hide();
		}
	}
	
	function displayMessage(){
		var textValue = document.getElementById("inputVal").value;
		if(textValue == oldSchoolClass){
			$(".areaBot").show();
			document.getElementsByClassName("areaBot")[0].innerHTML ="<p Class='required_sign'><spring:message code='REF.UI.SECTION.EDIT' /></p>";
		}
		else{
			var changeButtonType = document.getElementById("saveButton");
			//changeButtonType.type = "submit";Because it causes problems in Internet Explorer.			 
			document.form.submit();
		}
	}

</script>
</head>
<body onload="showDown(false),showErrorMessage(),addEditPanelTitle(${selectedObjId});">

	<h:headerNew parentTabId="26" page="referenceModule.htm" />

	<div id="page_container">
		<div id="breadcrumb_area">
			<div id="breadcrumb">
				<ul>
					<li><a href="adminWelcome.htm"><spring:message
								code="REF.UI.HOME" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><a href="referenceModule.htm"> <spring:message
								code="REF.UI.REFERENCE" />
					</a>&nbsp;&gt;&nbsp;</li>
					<li><spring:message code="REF.UI.MANAGE.CLASSES.TITLE"/></li>
				</ul>
			</div>
			<div class="help_link">
				<a href="#"
					onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/manageSchoolClassHelp.html"/>','helpWindow',780,550)"><img
					src="resources/images/ico_help.png" width="20" height="20"
					align="absmiddle"> <spring:message code="application.help" /></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<h1><spring:message code="REF.UI.MANAGE.CLASSES.TITLE"/></h1>
		<div id="content_main">
			<form:form action="manageSaveOrUpdateSchoolClass.htm" method="post"
				commandName="schoolClass" name="form">

				<div class="section_box">
					<div id="search_results">
						<div class="section_box_header">
							<h2><spring:message code="REF.UI.MANAGE.CLASSES.CLASS.DETAILS"/></h2>
						</div>
						<div class="area">
							<div>
								<!-- update success message comes through query string (after redirecting) -->
								<label class="success_sign"> ${param.addEditDelete}</label>
							</div>
						</div>
						<div class="areaTop">
							<c:if test="${message != null}">
								<div>
									<label class="required_sign">${message}</label>
								</div>
							</c:if>
							<div>
								<form:errors path="description" cssClass="required_sign" />
							</div>
						</div>
						<form:errors path="classId" cssClass="required_sign" />
						<div class="column_single">
							<table class="basic_grid" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<th width="830"><spring:message code="REF.UI.MANAGE.CLASSES.CLASSES"/></th>
									<th width="78" class="right">
									
									<sec:authorize access="hasRole('Save or Update a Class')">
									
									<img src="resources/images/ico_new.gif" class="icon_new"
										onClick="showArea(),showDown(true),setAddEditPane(this,'Add')
                  if (document.form.description.value != null) {
						 document.form.description.value='';
						 document.form.classId.value='0';
					}
                  "
										width="18" height="20" title="<spring:message code="REF.UI.MANAGE.CLASSES.ADD"/>">
									
									</sec:authorize>	
										
									</th>
								</tr>
								<c:forEach var="schoolClass" items="${schoolClassList}"
									varStatus="status">
									<c:choose>
										<c:when test="${(status.count) % 2 == 0}">
											<tr class="odd">
										</c:when>
										<c:otherwise>
											<tr class="even">
										</c:otherwise>
									</c:choose>
									<c:if test="${selectedObjId != null && (selectedObjId == schoolClass.classId)}"><tr class="highlight"></c:if>
									<td><c:out value="${schoolClass.description}"></c:out>
									</td>
									<td nowrap class="right">
									
									<sec:authorize access="hasRole('Save or Update a Class')">
									
									<img src="resources/images/ico_edit.gif" title="<spring:message code="REF.UI.MANAGE.CLASSES.EDIT"/>"
										onClick="showArea(),showDown(true),edit(this,'<c:out value="${schoolClass.description}" />','<c:out value="${schoolClass.classId}"/>');"
            	  	document.form.description.value='${schoolClass.description}';
           	 		document.form.classId.value='${schoolClass.classId}';"
										width="18" height="20" class="icon"> 
										
									</sec:authorize>
										
									<sec:authorize access="hasRole('Delete a Class')">
										
										<img src="resources/images/ico_delete.gif"
										onClick="showArea(),document.form.classId.value='${schoolClass.classId}';
                  deleteSchoolClass(this);"
										title="<spring:message code="REF.UI.DELETE"/>" width="18" height="20" class="icon">
									
									</sec:authorize>
									</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					
					<sec:authorize access="hasRole('Save or Update a Class')">
					<div class="areaBot">
						<c:if test="${message != null}">
							<div>
								<label class="required_sign">${message}</label>
							</div>
						</c:if>
						<div>
							<form:errors path="description" cssClass="required_sign" />
						</div>
					</div>
					<div class="section_full_inside" <c:if test="${editpane == null}"> style="display:none" </c:if>>
						<h3 id="addEditPanelTitle"><spring:message code="REF.UI.MANAGE.CLASSES.ADD"/></h3>
						<div class="box_border">
							<div class="row">
								<div class="float_left">
									<div class="lbl_lock">
										<span class="required_sign">*</span>
										<label><spring:message code="REF.UI.MANAGE.CLASSES.CLASS"/> :</label>
									</div>
									<form:hidden path="classId" />
									
									<form:input id= "inputVal" path="description" maxlength="10" />
								</div>
								<div class="float_right"></div>
							</div>
							<div class="row">
								<div class="buttion_bar_type1">
									<input type="button" id="saveButton" class="button" onClick="displayMessage()" 
									value="<spring:message code="REF.UI.SAVE" />"><input
										type="button" class="button"
										onClick="showArea(),setAddEditPane(this,'Cancel')" value="<spring:message code="REF.UI.CANCEL" />">
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					
					</sec:authorize>
					
					<div class="clearfix"></div>
				</div>

			</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>

