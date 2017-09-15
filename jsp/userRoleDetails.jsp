<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><spring:message code="APPLICATION.NAME"/></title>


<link href="resources/css/jquery-ui_smoothness.css" rel="stylesheet" type="text/css">
<link href="resources/css/skin/ui.fancytree.css" rel="stylesheet" type="text/css">
<link href="resources/css/css_reset.css" rel="stylesheet" type="text/css">
<link href="resources/css/theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/main_style.css" rel="stylesheet" type="text/css">

<link rel="shortcut icon" href="resources/images/favicon.png" type="image/x-icon" />

<script type="text/javascript" src="resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui_smoothness.js"></script>
<script type="text/javascript" src="resources/js/jquery.fancytree.js"></script>

<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="resources/js/messageCommon.js"></script>

<script type="text/javascript">

$(function(){
    // Initialize the tree in the onload event
    $("#tree").fancytree({

    	title: "FancytreeTest", // Tree's name (only used for debug output)
        minExpandLevel: 1, // 1: root node is not collapsible
        imagePath: 'skin/', // Path to a folder containing icons. Defaults to 'skin/' subdirectory.
        //children: true, // Init tree structure from this object array.
        initId: null, // Init tree structure from a <ul> element with this ID.+
        isLazy: false,
        initAjax: null, // Ajax options used to initialize the tree strucuture.
        autoFocus: true, // Set focus to first child, when expanding or lazy-loading.
        keyboard: true, // Support keyboard navigation.
        persist: false, // Persist expand-status to a cookie
        autoCollapse: true, // Automatically collapse all siblings, when a node is expanded.
        clickFolderMode: 3, // 1:activate, 2:expand, 3:activate and expand
        activeVisible: true, // Make sure, active nodes are visible (expanded).
	    checkbox: (${!userRole.isSystemRole })?true:false, // Show checkboxes.
        selectMode: 3, // 1:single, 2:multi, 3:multi-hier
        fx: null, // Animations, e.g. null or { height: "toggle", duration: 200 }
        noLink: false, // Use <span> instead of <a> tags for all nodes
        // Low level event handlers: onEvent(dtnode, event): return false, to stop default processing
        onClick: null, // null: generate focus, expand, activate, select events.
        onDblClick: null, // (No default actions.)
        onKeydown: null, // null: generate keyboard navigation (focus, expand, activate).
        onKeypress: null, // (No default actions.)
        onFocus: null, // null: set focus to node.
        onBlur: null, // null: remove focus from node.
       isFolder: false
        
    });

    // create all the child elements in loading
    $("#tree").fancytree("getRootNode").visit(function (node) {	
	    node.setExpanded(true);
	    node.setExpanded(false);
	});
    

});

function submitData(){

	// Now get the root node object    
    var tree = $("#tree").fancytree("getTree");

	var tabList=new Array();
	var privilegeList=new Array();
	
	//get all the selected nodes
	var selecedNodes = tree.getSelectedNodes(false);
	
	var okfunction = function (){	
		
		
		
			//add partselected nodes.
			$(".fancytree-partsel:not(.fancytree-selected)").each(function () {
		         var partNode = $.ui.fancytree.getNode(this);
		         selecedNodes.push(partNode);
		    });
			var tab=0;
			var privilege=0;
			for(node in selecedNodes){				
				var nodeObj = selecedNodes[node];
				var selectedNodeKey = nodeObj['key'];
				if(selectedNodeKey.match(/TAB*/) != null){
					tabList[tab] = selectedNodeKey.substr(selectedNodeKey.indexOf("_")+1);
					tab++;
				}
				if(selectedNodeKey.match(/PRIVILEGE*/) != null){
					privilegeList[privilege] = selectedNodeKey.substr(selectedNodeKey.indexOf("_")+1);
					privilege++;
				}
			}
			//set tab and privilege lists and submit
			document.userRoleForm.roleList.value=tabList;
			document.userRoleForm.privilegeList.value=privilegeList;
			document.userRoleForm.action='saveOrUpdateUserRole.htm';
			document.userRoleForm.submit();		
		
	};
	
	var isEmpty = (selecedNodes.length!=0?true:false);
	
	if(!isEmpty){
		okfunction();
	}
	if(isEmpty){
		var message = '<spring:message code="USER.MANAGEMENT.MANAGE.DEPENDENCY.CONFIRMATION" />';
		var cancelfunction = function(){};
		confirm_function(message , okfunction ,cancelfunction);
	}
	
	
	
}



function resetForm(){
	if(${userRole.userRoleId==0}){
		document.userRoleForm.action='newUserRoleDetails.htm';
		document.userRoleForm.submit();
	}
	else if(${userRole.userRoleId>1}){
		document.userRoleForm.action='viewUserRoleDetails.htm';
		document.userRoleForm.submit();
	}
	
}

function maxLengthSize(description) 

{

    var maxlength = 100; 

    var object = document.getElementById(description.id) 

    if (object.value.length > maxlength) 

    {

        object.focus(); 

        object.value = description.value.substring(0, maxlength); 

        object.scrollTop = object.scrollHeight; 

        return false;

    }

    return true;

}

</script>
</head>
<body>

	<h:headerNew parentTabId="38" page="manageUserRoles.htm" />

	<div id="page_container">
  <div id="breadcrumb_area">
    <div id="breadcrumb">
      <ul>
        <li><a href="adminWelcome.htm"><spring:message code="REF.UI.HOME" /></a>&nbsp;&gt;&nbsp;</li>
        <li><a href="manageUserRoles.htm"><spring:message code="USER.ROLE.DETAIL.TITLE" /></a>&nbsp;&gt;&nbsp;</li>
        <li><spring:message code="USER.ROLE.DETAIL.SUB.TITLE" /></li>
      </ul>
    </div>
    <div class="help_link"><a href="#" onClick="PopupCenterScroll('<c:url value="resources/html/akura-help/topics/admin/userRoleDetailsHelp.html"/>','helpWindow',780,550)"><img src="resources/images/ico_help.png" width="20" height="20" align="absmiddle"> <spring:message code="REF.UI.HELP"/></a></div>
  </div>
  <div class="clearfix"></div>
  <h1><spring:message code="USER.ROLE.DETAIL.SUB.TITLE" /></h1>
  <div id="content_main">
			<form:form method="POST" commandName="userRole" action=""
				name="userRoleForm">
					
					<div class="section_box">
			        <div class="section_box_header">
			          <h2><spring:message code="USER.ROLE.DETAIL.SUB.TITLE" /></h2>
			        </div>
			        <label class="success_sign">
			         <c:if test="${success_message != null}"> <c:out value="${success_message}" escapeXml="false" />
			        </c:if>
			        </label>
			        <label class="required_sign">
			        <c:if test="${message != null}"> <c:out value="${message}" escapeXml="false" />
			        </c:if> </br>
			        <c:if test="${userRole!=null}">
			        <spring:bind path="userRole.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" />
									<br />
								</c:forEach>
							</c:if>
							
						</spring:bind>
					</c:if>			
					</label>
						
			        <div class="column">
                              <div class="row">
                                  <div class="float_left">
                                      <div class="frmlabel">
                                          <span class="required_sign">*</span><label><spring:message code="USER.ROLE.DETAIL.ROLE.NAME" /></label>
                                    </div>
                                    <div class="frmvalue">
                                          <form:input path="role" maxlength="20"/>
                                    </div>
                               
                                    <div class="frmlabel">
                                          <label><spring:message code="USER.ROLE.DETAIL.ROLE.DESCRIPTION" /></label>
                                    </div>
                                    <div class="frmvalue">
                                        <form:textarea path="description" id="description" cols="15" rows="2" onKeyUp="javascript:maxLengthSize(this);" onChange="javascript:maxLengthSize(this);"></form:textarea>
                                      </div>
                                </div>
                              </div>
                        </div>
					 
					        <div class="clearfix"></div>
					 
					        <div class="column_single">
					          <div>
					            <div class="frmlabel" style="width: 230px;">
					              <label><spring:message code="USER.ROLE.DETAIL.ROLE.ASSIGN.PRIVILEGES" /></label>
					            </div>
					            <div class="float_left">
					            
					              <div id="tree">  
			            
						            
						            <!--show tabs -->
					                <ul>
						            <c:forEach items="${moduleList}" var="module">
						            
						            <!--restrict `parent` and `userManagement` module for user defined roles. -->
							        <c:if test="${userRole.isSystemRole || module.moduleId ne '7' && module.moduleId ne '8'}">
							        
							            <c:forEach items="${module.tabs}" var="tab">
							            
											<!--show only parent tabs -->
								            <c:if test="${tab.parentTab eq null}">
								            
							                    <li id="TAB_${tab.tabId}" class="expanded">${tab.name}
						                    		
						                    		<!-- tab content -->
							                    	<ul>
													
						                    		<!--show child tabs -->
													<c:forEach items="${tab.tabs}" var="childTab">
														<li id="TAB_${childTab.tabId}" class="expanded">${childTab.name}
														
														<ul>
														<!--check for the child tabs -->
													    <c:if test="${childTab.tabs.size() ne '0'}">
															<c:set var="childTab" value="${childTab}" scope="request"/>
															<jsp:include page="tabContent.jsp"/>
														</c:if>
														
														<!--  show pages -->
															<c:forEach items="${childTab.pages}" var="page">
																<li id="PAGE_${page.pageId}" class="expanded">${page.name}
																<!--show privileges -->
																<ul>
																	<c:forEach items="${page.privileges}" var="privilege">
																		<c:set var="checkPrivilege" value=""/>
																		<c:forEach items="${rolePrivilegeList}" var="rolePrivilege">
																			<c:if test="${rolePrivilege.privilegeId eq privilege.privilegeId}">
																				<c:set var="checkPrivilege" value="selected"/>
																			</c:if>
																		</c:forEach>
																		<li id="PRIVILEGE_${privilege.privilegeId}" class="${checkPrivilege} expanded">${privilege.name}
																	</c:forEach>
																</ul>
																<!--end privileges -->
															</c:forEach>
														</ul>
														<!--  end pages -->
													</c:forEach>
													<!--end child tabs -->
						                    		
						                    		
								                    <!--  show pages -->
										            <c:forEach items="${tab.pages}" var="page">
									                    <li id="PAGE_${page.pageId}" class="expanded">${page.name}
															
															<!--show privileges -->
									                    	<ul>
												            <c:forEach items="${page.privileges}" var="privilege">
																<c:set var="checkPrivilege" value=""/>
																		<c:forEach items="${rolePrivilegeList}" var="rolePrivilege">
																			<c:if test="${rolePrivilege.privilegeId eq privilege.privilegeId}">
																				<c:set var="checkPrivilege" value="selected"/>
																			</c:if>
																		</c:forEach>
																<li id="PRIVILEGE_${privilege.privilegeId}" class="${checkPrivilege} expanded">${privilege.name}
								                    		</c:forEach>
									                    	</ul>
								                    		<!--end privileges -->
								                    		
						                    		</c:forEach>
						                    		<!--  end page -->
						                    		
							                    	</ul>
						                    		<!-- end of tab content -->
								            </c:if> 
								            <!--end parent tabs -->
											
				            			</c:forEach>
            						</c:if>
				            			
			            			</c:forEach>
					                </ul>
					                <!--end tabs -->
			            </div>
			            </div>
			          </div>
			        </div>
			        <br>
			        <div class="clearfix"></div>
			      </div>
			 
			      <div class="clearfix"></div>
			      
				      <div class="button_row">
				        <div class="buttion_bar_type2">
				          <sec:authorize access="hasRole('Save or update user role')">
				      		<c:if test="${!userRole.isSystemRole }" >
					  	      <input value="<spring:message code="REF.UI.RESET" />" class="button" onclick="resetForm()" type="reset">
					          <input onclick="submitData()" value="<spring:message code="REF.UI.SAVE" />" class="button" type="button">
					  	      <input value="<spring:message code="REF.UI.CANCEL" />" class="button" onclick="window.location='manageUserRoles.htm'" type="button">
			      			</c:if>
				        </sec:authorize>
				        </div>
				        <div class="clearfix"></div>
				      </div>
			      <div class="clearfix"></div>
							      
						<input type="hidden" name="selectedRole">
						<input type="hidden" name="roleList">
						<input type="hidden" name="privilegeList">
						<form:hidden path="userRoleId"/>
					</form:form>
		</div>
	</div>
	<h:footer />
</body>
</html>
