/*
 * < ÀKURA, This application manages the daily activities of a Teacher and a Student of a School>
 *
 * Copyright (C) 2012 Virtusa Corporation.
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

 
 
 	function termMarkGridView(jsonData,subjectOptionalStatus,showMarkingComplete) {	
	
		var studentStatus= { "1":"Current", "2":"Past", "3":"Suspend", "4":"Temporary Leave"};
		
		var invalideFiledCount =[];
		
		
		
		var subjectNames = getSubjectNames(subjectOptionalStatus);
		
		var colNamesData = BuildCoulmnNames(subjectNames,true,subjectOptionalStatus);
		var colModelData = BuildColumnModel(subjectNames,true);
		
		$(document).ready(function () {
			$("#users").jqGrid({
				datatype: "jsonstring", 
				datastr: jsonData,   			    			  
		        colNames:colNamesData,
		        colModel:colModelData, 
				width: 900,
				height: 300,
				mtype: "POST",
				sortorder: "asc",					
				rownumbers: true,  		
				rowNum: 100,				
				cellsubmit:'clientArray',	
				 
				
				afterInsertRow: function(rowid, aData) 
				{ 
					setColorForUnEditableCells(subjectNames,rowid,studentStatus);
				},
				
				onCellSelect: function(rowid, index, contents, event)  
				{     
					
					editSelectedCell(rowid,index);	
				}, 
				
				beforeSaveCell: function (rowid, name, val, iRow, iCol) 
				{
				     invalideFiledCount=cellValidation(rowid,name,val,invalideFiledCount);	
				},
					
				shrinkToFit: false
			});

			$('#load_users').hide();
			$("#users").jqGrid('setFrozenColumns');

	 
	
			<!-- Save edited grid value  -->
		    $("#saveButton").click(function () {
		    	

		    	var isMarkingCompleteChecked = $('#markingCompleted').is(':checked');
		    	
		    	document.getElementById('toMarkComplete').value = isMarkingCompleteChecked;
		    	if(isFromUpload){
		    		populateJsonArrayEditedMarkFromUpload();
		    	}else{
		    		populateEditedMarkJsonArray();
		    	}
				
				
				if(!isMarkingCompleteChecked){
					saveMark(invalideFiledCount);
				}
				else{
					if(!showMarkingComplete){
					    saveMark(invalideFiledCount);	
					}
					else if(isMarkingCompleteChecked){
						var hasEmptyCell=checkEmptyCells(subjectNames,invalideFiledCount);
							if(!hasEmptyCell){	
								saveMark(invalideFiledCount);
							}
					}
					else{
						saveMark(invalideFiledCount);	
					}
				}
				 
			}); 

		});
	

}
 
	
	
	
	
	
	
	function subTermMarkGridView(jsonData,subjectOptionalStatus){
	
		
		var studentStatus= { "1":"Current", "2":"Past", "3":"Suspend", "4":"Temporary Leave"};
		 
		var invalideFiledCount =[];
		
		var subjectNames = getSubjectNames(subjectOptionalStatus);	
		
		var colNamesData = BuildCoulmnNames(subjectNames,false,subjectOptionalStatus);
		var colModelData = BuildColumnModel(subjectNames,false);

		$(document).ready(function () {
			
			$("#users").jqGrid({
				datatype: "jsonstring",
				datastr: jsonData,   			    			  
		        colNames:colNamesData, 
		        colModel:colModelData, 
				width: 900,
				height: 300,
				mtype: "POST",
				sortorder: "asc",			
				rownumbers: true, 	
				rowNum: 100,					
				cellsubmit:'clientArray',	
				
				afterInsertRow: function(rowid, aData)
				{
					setColorForUnEditableCells(subjectNames,rowid,studentStatus);
				},        
						
				onCellSelect: function(rowid, index, contents, event) 
				{   	
					editSelectedCell(rowid,index);	
				},
	
				beforeSaveCell: function (rowid, name, val, iRow, iCol) 
				{
					invalideFiledCount=cellValidation(rowid,name,val,invalideFiledCount);
				},
				
				shrinkToFit: false
			});
			
			
				
			jQuery("#users").jqGrid('setGroupHeaders', {
			  useColSpanStyle: true, 
			  groupHeaders:headers(subjectNames)
			});
			 
			$('#load_users').hide();
			$("#users").jqGrid('setFrozenColumns');
	     
	
	
			<!-- Save edited grid value  -->
		    $("#saveButton").click(function () {	
				populateEditedMarkJsonArray();
				saveMark(invalideFiledCount); 
			}); 

		});
	
	
	}
	

		
	function BuildCoulmnNames(subjectNames,isTermMarkGrid,subjectOptionalStatus){
		var columnNames = [];
		columnNames.push(admissionNo);
		columnNames.push(studentName);
		columnNames.push("Student Status");
			
		if(isTermMarkGrid){
			
			for (var i=0;i< subjectNames.length; i++) {
				var fieldVal=subjectNames[i];				
				var isOptional=subjectOptionalStatus[subjectNames[i]];	
				
				if(isOptional){
					fieldVal=fieldVal+" ("+optional+")";
				}
				
				columnNames.push(fieldVal); 
				columnNames.push(subjectNames[i]+isEditable); 
				columnNames.push(subjectNames[i]+termMarkID); 
			}
			columnNames.push(total);
			columnNames.push(studentAverage);
			columnNames.push(studentRank);
			
		}
		else{
			var fields = ["I", "II"];
			for(var i=0;i< subjectNames.length; i++){
				columnNames.push(fields[i%2]);
				columnNames.push(subjectNames[i]+isEditable);
				columnNames.push(subjectNames[i]+termMarkID);			
			}
		}
		
		return columnNames;
	}
	
	
	
	function BuildColumnModel(subjectNames,isTermMarkGrid){	
		var colModels = [];
		colModels.push({ name : admissionNo , index : admissionNo , width : 80 , align : 'center' ,frozen: true});
		colModels.push({ name : studentName , index : studentName , width : 160 , align : 'center' ,frozen: true});
		colModels.push({ name : "Student Status" , hidden: true});
			
		for(var i = 0;i< subjectNames.length; i++){
			colModels.push({ name : subjectNames[i] , index : subjectNames[i] , width : 120 , align : 'center' ,editable:true, sortable : false});
			colModels.push({ name: subjectNames[i]+isEditable, hidden: true});
			colModels.push({ name: subjectNames[i]+termMarkID, hidden: true});
		}
			
		if(isTermMarkGrid){
			colModels.push({ name : total , index : total , width : 120 , align : 'center' , sortable : false});
			colModels.push({ name : studentAverage, index : studentAverage , width : 120 , align : 'center' , sortable : false});
			colModels.push({ name : studentRank , index : studentRank , width : 120 , align : 'center' , sortable : false});	
		}
		return colModels;
	}		
			
	function populateJsonArrayEditedMarkFromUpload(){
		jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
		var editedMarksJsonArray = [];
		
		var allRowsInGrid = $('#users').jqGrid('getGridParam','data');
		for(var i =0;i<allRowsInGrid.length;i++){
			
			var termMarkRow = allRowsInGrid[i];
			
			$.each(subjectNames, function( index, subName ) {
				
				var termMarkIdKey = subName+termMarkID;
				var editedTermMarkId = termMarkRow[termMarkIdKey];
				if((editedTermMarkId === undefined )||(editedTermMarkId == null)){
				}else{
					var editedValue = termMarkRow[subName];
					editedMarksJsonArray.push({
						id: editedTermMarkId,
						value: editedValue 
					});	
				
				}
			});

		}
		
		var editedData = JSON.stringify(editedMarksJsonArray);
		document.getElementById('editedMarksJsonArray').value = editedData;
		
		return editedData;
		
	}

			
	function populateEditedMarkJsonArray(){
	
		jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
		jQuery('#users').jqGrid("editCell", 0, 0, false);				
		var returnEditedRow = $("#users").getChangedCells('all');		
		var returnEditedCol = $("#users").getChangedCells('dirty');		
				
		var editedMarksJsonArray = [];
		for(var i=0;i<returnEditedCol.length;i++){
			var editedColObj = returnEditedCol[i];
			var editedRowObj = returnEditedRow[i];
			for(var key in editedColObj){
				if(key!="id"){
					var editedTermMarkId = editedRowObj[key+termMarkID];
					var editedValue = editedRowObj[key];
									
					editedMarksJsonArray.push({
						id: editedTermMarkId,
						value: editedValue 
					});				
				}
			}
		}
		
		var editedData = JSON.stringify(editedMarksJsonArray);
		var sortColumn = jQuery('#users').jqGrid('getGridParam','sortname');
		var sortorder = jQuery('#users').jqGrid('getGridParam','sortorder');
		document.getElementById('editedMarksJsonArray').value = editedData;
		if(sortColumn === admissionNo)
			sortColumn = admissionNoIndex;
		else if(sortColumn === studentName)
			sortColumn = studentNameIndex;
		if(!!sortColumn && !!sortorder){
			$('input[name="sortCol"]').val(sortColumn);
			$('input[name="sortOrder"]').val(sortorder);
		}		
		return editedData;
	}
		
				
			
	function headers(subjectNames){
		var headerNames = [];

		for(var i = 0;i< subjectNames.length; i=(i+2)){
			var val=subjectNames[i].split("I");
			headerNames.push({startColumnName: subjectNames[i], numberOfColumns: 4, titleText: val[0]});	
		}
		return headerNames;
	}
		

	function getSubjectNames(subjectOptionalStatus){
		var subjectNames = [];

		for (var key in subjectOptionalStatus) {
			subjectNames.push(key);
		}
		return subjectNames;
	}
		
			
	function checkEmptyCells(subjectNames,invalideFiledCount){
			
		var hasEmptyCell = false;
		var allRowsInGrid = $('#users').jqGrid('getGridParam','data');
			
		for(var i=0;i<allRowsInGrid.length;i++){
			var rowDataObj = allRowsInGrid[i];
						
			for(var j=0;j<subjectNames.length;j++){
				var key= subjectNames[j];
				if(rowDataObj[key]=="" && rowDataObj[key+isEditable]==true){ 
				
					var rowid = rowDataObj["_id_"];
					var columnName = key;
					jQuery("#users").setCell (rowid,columnName,'',{ 'background-color':'#ff9999'});								
					hasEmptyCell = true;			
				}
			}
		}
				
				if(hasEmptyCell){	
					document.getElementById('validationErrorMessagelabel').innerHTML = "Mark Entry can not be completed, blank values are not allowed.";
					$('#validationErrorMessage').show();		
				}
				
		return hasEmptyCell;
	}


	
	function setColorForUnEditableCells(subjectNames,rowid,studentStatus){
		
		for(var i=0;i<subjectNames.length;i++){
			var editable = jQuery('#users').jqGrid('getCell', rowid, subjectNames[i]+isEditable);
			if (editable == "false"){
			$("#users").setCell(rowid,subjectNames[i],"",{"background-color":"#e6e6e6"});}		
		
		}	
		var rowStudentStatus = jQuery('#users').jqGrid('getCell', rowid, "Student Status");
		if(studentStatus[rowStudentStatus]!="Current"){
		  $("#users").setCell(rowid,admissionNo,'',{'background-color':'#aaaaaa'},{'title':studentStatus[rowStudentStatus]});	
		  $("#users").setCell(rowid,studentName	,'',{'background-color':'#aaaaaa'},{'title':studentStatus[rowStudentStatus]});
		}
		<!-- set row color in alternatively  -->
		$("tr.jqgrow:odd").addClass('alternativeRowColor');		
	}
	
	
	function editSelectedCell(rowid,index){
		var studentStatus= { "1":"Current", "2":"Past", "3":"Suspend", "4":"Temporary Leave"};
		var columnData = $("#users").jqGrid('getGridParam','colModel');   	
		var subjectName=columnData[index].name;
		var editable = jQuery('#users').jqGrid('getCell', rowid, subjectName+isEditable); 
		var rowStudentStatus = jQuery('#users').jqGrid('getCell', rowid, "Student Status");
		
		
		if(editable=='true' && (studentStatus[rowStudentStatus]=="Current" || studentStatus[rowStudentStatus]=="Suspend")){
			jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
			jQuery('#users').jqGrid('editCell', rowid, index, true);
			
			$(window).on( 'keyup', function( e ) {
				if( e.which == 9 ) {
					jQuery('#users').jqGrid('editCell', rowid, index+3, false);
				}
			});
		
		}
		else{
			jQuery('#users').jqGrid('setGridParam', {cellEdit: false});
			
		}
	}
	
	function cellValidation(rowid,name,val,invalideFiledCount){
	
	 var hasInvalidData=false;
	 var pattern=/^\d*[0-9](\.\d*[0-9])?$/;

	
		if(val.toLowerCase()!="ab"){
			if(!val.match(pattern) && !val=="" ){
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
				hasInvalidData=true;
			}
			else if(val<0 || val>100){
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});
				hasInvalidData=true;
			}
			else{
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
			}
		}
		else{
		jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
		}
					  
					
					  
		var id = jQuery('#users').jqGrid('getCell', rowid, name+termMarkID);
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
			$("#validationErrorMessagelabel").html(markErrorMsg);
			$('#validationErrorMessage').show();

		}
		else{
			$('#validationErrorMessage').hide();
		}
					 
		return invalideFiledCount;
					  

	}
	
	
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
	

	
	
	
	