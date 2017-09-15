/*
 * <CYBERSCHOOL, This application manages the daily activities of a Teacher
 *		and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
 *		Author = Eric Brown Appiah
 *		Contact = 0205212015
 */
 
 	//set properties in jqgrid
	function studentMarkGridView(subjectName, data) {
		var invalideFiledCount =[];		
		var subjectOptionalStatus = subjectName; 		
		var subjectNames = getSubjectNames(subjectOptionalStatus);
		var colname = BuildCoulmnNames(subjectNames, subjectOptionalStatus);
		var columns = BuildColumnModel(subjectNames);
		$(document).ready(function(){	
		jQuery('#users').jqGrid({
		
			datatype: "jsonstring",
			datastr: data,   			    			  
		    colNames:colname,
		    colModel:columns,
		    pager: '#usersPage',
			width: 900,
			height: 300,
			rowNum: 500,
			mtype: "POST",
			sortorder: "asc",					
			rownumbers: true,			
			cellsubmit:'clientArray',
				
			afterInsertRow: function(rowid, aData)
			{
				setColorForUnEditableCells(rowid,studentName);
			},        
						
			onCellSelect: function(rowid, index, contents, event) 
			{   	
				editSelectedCell(rowid,index);	
			},		
			
			
			beforeSaveCell: function (rowid, name, val, iRow, iCol) 
			{
			var isMarKorGrade=document.getElementById('markorgrade').value;
			if(isMarKorGrade=="isMark"){
				if(name == indexno){
					invalideFiledCount = cellIndexValidation(rowid, name, val, invalideFiledCount);
				}
				else{
					invalideFiledCount = cellMarksValidation(rowid, name, val, invalideFiledCount);
				}
				
				}
				else{
					if(name == indexno){
					invalideFiledCount = cellIndexValidation(rowid, name, val, invalideFiledCount);
					}
				else{
					invalideFiledCount = cellGradeValidation(rowid, name, val, invalideFiledCount);					
					}
					}
				},
				
				shrinkToFit: false
				
			});
			
			$('#load_users').hide();
			 $("#users").jqGrid('setFrozenColumns');
			 
			
		
		
		$("#saveButton").click(function () {
				populateEditedMarkJsonArray();
				saveExam(invalideFiledCount,subjectNames);	  
			}); 
	});

}

	
	
	//create colums names
	function BuildCoulmnNames(subjectNames, subjectOptionalStatus){

       var columns = [];
		columns.push(studentName);
		columns.push(studentName+'Status');
		columns.push(indexno);
		columns.push(indexno+"IsEditable");
		columns.push(indexno+"IndexID");
		
        for(var i=0;i< subjectNames.length; i++){
		var fieldVal = subjectNames[i];
		var isOptional=subjectOptionalStatus[subjectNames[i]];
		if(isOptional){
			fieldVal=fieldVal+" (optional)";
		}
		columns.push(fieldVal);
		columns.push(subjectNames[i]+'IsEditable');
		columns.push(subjectNames[i]+'Optional');
		columns.push(subjectNames[i]+"MarkID");
        }
        return columns;
	}
	
	function BuildColumnModel(subjectNames){
        var uFields = subjectNames;
        var columns = [];
		columns.push({ name : studentName , index : studentName, width : 300 , align : 'left' ,frozen: true});
		columns.push({ name : studentName+'Status', hidden: true});
		columns.push({ name : indexno , index : indexno , editable: true, width : 250 , align : 'center' , frozen: true,editoptions: {size:18, maxlength: 15}});
		
		columns.push({ name: indexno+'IsEditable', hidden: true});
		columns.push({ name: indexno+"IndexID", hidden: true});
        for(var i = 0;i< uFields.length; i++){
           columns.push({ name : uFields[i] , index : uFields[i] , width : 150 , align : 'center' , editable : true,
		   editoptions: { dataInit: function (el) { $(el).css('text-transform', 'uppercase'); }}});
		   columns.push({ name: uFields[i]+'IsEditable', hidden: true});
		   columns.push({ name: uFields[i]+'Optional', hidden: true});
		   columns.push({ name: uFields[i]+"MarkID", hidden: true});
       
		}
        return columns;
	}
	
	function getSubjectNames(subjectOptionalStatus){
		var subjectNames = [];

		for (var key in subjectOptionalStatus) {
			subjectNames.push(key);
		}
		return subjectNames;
	}
	
	
	//get edited grid data that id and value	
	function populateEditedMarkJsonArray(){
		jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
		jQuery('#users').jqGrid("editCell", 0, 0, false);				
		var returnEditedRow = $("#users").getChangedCells('all');		//returns all members in the changed rows
		var returnEditedCol = $("#users").getChangedCells('dirty');		//returns only the changed cells' keys and values in the rows
		var editedMarksJsonArray = [];
		var editedIndexJsonArray = [];
		for(var i=0;i<returnEditedCol.length;i++){
			var editedColObj = returnEditedCol[i];
			var editedRowObj = returnEditedRow[i];
			for(var key in editedColObj){
			if(key!="id"){
				var markId = editedRowObj[key+"MarkID"];
				var editedValue = editedRowObj[key];
				var indexId = editedRowObj[key+"IndexID"];
				
				if(indexId!=null){
					editedIndexJsonArray.push({
						id: indexId,
						value: editedValue
						
					});
				}
				if(markId!=null){
					 editedMarksJsonArray.push({
						id: markId,
						value: editedValue
						
					});
					}
					
				}
			}
		}
			
		document.getElementById('editedMarksJsonArray').value = JSON.stringify(editedMarksJsonArray);
		document.getElementById('editedIndexJsonArray').value = JSON.stringify(editedIndexJsonArray);
										 
	}
	
	
	//indexno validation that without indexno can't enter the mark
	function indexNoValidation(subjectNames, invalideFiledCount){
		var returnValue = $("#users").getChangedCells('all');				    									                    	
		var indexstatus = false;		   
		for(var i=0;i<returnValue.length;i++){
			var rawId=returnValue[i]['rn'];
			var status = jQuery('#users').jqGrid('getCell',rawId, indexno);
			var id = jQuery('#users').jqGrid('getCell',rawId, indexno + "IndexID");
			if(!~invalideFiledCount.indexOf(id)){
				jQuery("#users").setCell (rawId,indexno,'',{ 'background-color':'#ffffff'});
			}
			for(var j=0; j<subjectNames.length; j++){
				var subject = jQuery('#users').jqGrid('getCell', rawId, subjectNames[j]);							
				if(status == '' && subject != ''){
					jQuery("#users").setCell (rawId,indexno,'',{ 'background-color':'#ff9999'});
					indexstatus = true;
				}
			}
		}
		return indexstatus;
	}
			  
	// set colour for non current students			  
	function setColorForUnEditableCells( rowid, studentName){
		var studentStatus= { "1":"Current", "2":"Past", "3":"Suspend", "4":"Temporary Leave"};
		var status = jQuery('#users').jqGrid('getCell', rowid, studentName+'Status');					
		
		if(studentStatus[status]!="Current"){			  	
			  $("#users").setCell(rowid,studentName	,'',{'background-color':'#aaaaaa'},{'title':studentStatus[status]});
		}
				
        <!-- set row color in alternatively  -->
		$("tr.jqgrow:odd").addClass('alternativeRowColor');											
	}
	
	// set cell for editable
	function editSelectedCell(rowid,index){
	
		var columnData = $("#users").jqGrid('getGridParam','colModel');   	
		var subjectName=columnData[index].name;
		var editable = jQuery('#users').jqGrid('getCell', rowid, subjectName+'IsEditable');		
		if(editable=='true'){
			jQuery('#users').jqGrid('setGridParam', {cellEdit: true});
			jQuery('#users').jqGrid('editCell', rowid, index, true);			
		}	
		else{
			jQuery('#users').jqGrid('setGridParam', {cellEdit: false});
		}
	}
	
	// function for MarksValidation
	function cellMarksValidation(rowid, name, val, invalideFiledCount){
	var hasInvalidData=false;
	var pattern=/^\d*[0-9](\.\d*[0-9])?$/;
	var optional = jQuery('#users').jqGrid('getCell', rowid, name+'Optional');	
	var absent = val.toLowerCase();
	
	var examIndexVal=jQuery('#users').jqGrid('getCell', rowid, indexno);
	
	if(absent!="ab" && absent!=="na"){
		if(!val.match(pattern) && !val=="" ){
			jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
			hasInvalidData=true;
			var text = document.getElementById('validationErrorMessagelabel');
				if(text.innerText != undefined){
					text.innerText = markError;
				}
				else{
					text.textContent = markError;
				}
												
				$('#validationErrorMessage').show();
			}
		else if(val<0 || val>100){
			  jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});
			   hasInvalidData=true;
			   var text = document.getElementById('validationErrorMessagelabel');
			   if(text.innerText != undefined){
					text.innerText = markError;
				}
				else{
					text.textContent = markError;
				}
											
				$('#validationErrorMessage').show();
		 }
		else{
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
				$('#validationErrorMessage').hide();						
		    }
	 }
					  
	 else{
			if(optional != 'true' && absent == 'na'){
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});
			   hasInvalidData=true;
			   var text = document.getElementById('validationErrorMessagelabel');
			if(text.innerText != undefined){
				text.innerText = notApplyError;
			}
			else{
				text.textContent = notApplyError;
			}
									
			$('#validationErrorMessage').show();
			}
		
			else{
				jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
				$('#validationErrorMessage').hide();
			}
	}

  	var id = jQuery('#users').jqGrid('getCell', rowid, name+'MarkID');				
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
	return invalideFiledCount;	  

	}
	
	// function for Grade Validation
	function cellGradeValidation(rowid, name, val, invalideFiledCount){ 
		var hasInvalidData=false;
		var greadingacrc=markGradings;
		var pattern=/^\d*[0-9](\.\d*[0-9])?$/;
        var gradings=greadingacrc.split(",");
		var isGrade = false;
		var optional = jQuery('#users').jqGrid('getCell', rowid, name+'Optional'); 
		for (var i = 0; i < gradings.length; i++) {
			if(val.toUpperCase() == gradings[i]){
				isGrade = true;
			}
		}
		var absent = val.toLowerCase();
		if(absent!="ab" && absent!=="na"){
			if(isGrade == false){
					if(val.match(pattern)){
					jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
					hasInvalidData=true;
					var text = document.getElementById('validationErrorMessagelabel');
					if(text.innerText != undefined){
						text.innerText = gradeInvalidError;
					}
					else{
						text.textContent = gradeInvalidError;
					}
					$('#validationErrorMessage').show();
					}
					else{
					jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
					hasInvalidData=true;
					var text = document.getElementById('validationErrorMessagelabel');
					if(text.innerText != undefined){
						text.innerText = gradeAcronymError;
					}
					else{
						text.textContent = gradeAcronymError;
					}
					$('#validationErrorMessage').show();
					}
				}
				else{
					jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
					$('#validationErrorMessage').hide();
				}
			}
			else{
				if(optional != 'true' && absent == 'na'){
							jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});
						   hasInvalidData=true;
						   var text = document.getElementById('validationErrorMessagelabel');
						if(text.innerText != undefined){
							text.innerText = notApplyError;
						}
						else{
							text.textContent = notApplyError;
						}
												
						$('#validationErrorMessage').show();
						}
						else{
						jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
						$('#validationErrorMessage').hide();
						}
			}
		
			var id = jQuery('#users').jqGrid('getCell', rowid, name+'MarkID');
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
				return invalideFiledCount;
		
	} 
	
	//function for IndexNumber Validation
	function cellIndexValidation(rowid, name, val, invalideFiledCount){
		var hasInvalidData=false;
		var pattern='^[a-zA-Z0-9]+$';
        var indexNo = $("#users").jqGrid('getCol',name);		
		var isDulicate = false;
		for(var i=0;i<indexNo.length;i++){
			if(val == ""){
			isDulicate = false;
			}
			else if(val == indexNo[i]){
			isDulicate = true;
			}
			
		}
		if(isDulicate == true){
			jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
			hasInvalidData=true;
			var text = document.getElementById('validationErrorMessagelabel');
				if(text.innerText != undefined){
					text.innerText = indexDupError;
				}
				else{
					text.textContent = indexDupError;
				}
					$('#validationErrorMessage').show();
		}
		else if(!val.match(pattern) && !val=="" ){
		
			jQuery("#users").setCell (rowid,name,'',{ 'background-color':'#ff9999'});	
			hasInvalidData=true;
			var text = document.getElementById('validationErrorMessagelabel');
				if(text.innerText != undefined){
					text.innerText = indexInvalidError;
				}
				else{
					text.textContent = indexInvalidError;
				}
					$('#validationErrorMessage').show();
		}
		else{
			jQuery("#users").setCell (rowid,name,'',{ 'background-color':''});
			$('#validationErrorMessage').hide();
		}
		
		var id = jQuery('#users').jqGrid('getCell', rowid, name+'IndexID');
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
				return invalideFiledCount;
						  
	}
	
	//function for support IE
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