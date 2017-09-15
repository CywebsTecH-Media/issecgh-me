
// JavaScript Document
//=====================================================
//' Purpose       :   Add items from one list to other
//' Source        :   Java Script
//' Author        :   Upendra Haputantry
//' Date Created  :   31-January-2012
//' Date Modified :   
//' Copyright By  :   Copyright � 2012 Virtusa Crop.
//'====================================================
var previousSelectedItem = false;


document.onclick = function(event){
    var event = event || window.event;
    if (!event.target) {
        event.target = event.srcElement
    }
    if (previousSelectedItem) {
    
        if ((event.target.parentNode.tagName !== "LI" && event.target.tagName !== "UL") && (previousSelectedItem.className === "item_selected")) {
        
            previousSelectedItem.className = "";
            
        }
    }
    
}

function add(){
    fromList = document.getElementById("FromList");
    toList = document.getElementById("ToList");
    var len = fromList.length;
	var toListItems = $('#ToList').find('li');
	
	var list= [];
	
 	
	for (var k = 0; k < len; k++) {
        if (fromList.options[k].selected) {
			list.push({
				text: fromList.options[k].text,
				value: fromList.options[k].value
			});	
        }
    }
	
	/*toListItems.each(function( index ) {   
		var divList = $(this).find('div').find('div');   
		list.push({
			text: divList.first().text(),
			value:  divList.eq(1).find('input').val()						
		});	
        
	});
	*/

	list.sort(function (a, b) {
		if (a.text > b.text) {
			return 1;
		}
		if (a.text < b.text) {
			return -1;
		}
		// a must be equal to b
		return 0;
		});

	/*
	toListItems.each(function( index ) {       
		$(this).remove();  
	});
 	*/
    for (i = 0; i < list.length; i++) {
        
		var newOption = document.createElement("li");
	    newOption.style.width='435px';
        newOption.innerHTML ="<div style='width:435px;'> <div style='width:200px;'>" + list[i].text + "</div><div style='margin-left:5px;;width:70px;'><input type='checkbox' value='" + list[i].value + "' name='optionalSubjects'></div><div style='margin-left:5px;width:40px;'><input type='text' style='width: 40px; border: 1px solid rgb(70, 130, 180);display:none;' title='Enter to Maximum Mark relevant to Term ' value='100' ></div> <div style='margin-left:45px;width:40px;'><input type='text' style='width: 40px; border: 1px solid rgb(70, 130, 180);display:none;' title='Enter The Grade Subject Config Code' value='" + list[i].text + "'></div><div class='clearfix'></div> </div>"; 

		toList.appendChild(newOption);
        
    }
    
    for (j = 0; j < len; j++) {
        if (fromList.options[j].selected) {
            fromList.remove(j);
            j--;
            len--;
        }
    }
}


function removeGradeSubject() {	
   
	var fromList = $('#FromList');      
    var toListItems = $('#ToList').find('li');
	var fromListToSort = document.getElementById("FromList");
	var len = fromListToSort.length;
	var lenTo = toListItems.length;
	
	var list= [];
	
 	for (var k = 0; k < len; k++) {
			list.push({
				text: fromListToSort.options[k].text,
				value: fromListToSort.options[k].value
			});	
    }
	
	toListItems.each(function( index ) {  
		if($(this).hasClass('item_selected')){
		var divList = $(this).find('div').find('div');   
		list.push({
			text: divList.first().text(),
			value:  divList.eq(1).find('input').val()						
		});	
			$(this).remove();
        }
	});
	
	for(var num=0;num<len;num++){
		fromListToSort.remove(0);
	}
	
	list.sort(function (a, b) {
		if (a.text > b.text) {
			return 1;
		}
		if (a.text < b.text) {
			return -1;
		}
		// a must be equal to b
		return 0;
	});
	
	var length = list.length;
	
	for(var i = 0; i<length;i++){
	    $("<option></option>", 
        {value: list[i].value , text: list[i].text})
        .appendTo('#FromList');
	}	
	
}

