/*
 * <CYBERSCHOOL, This application manages the daily activities of a Teacher
 *		and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
 *		Author = Eric Brown Appiah
 *		Contact = 0205212015
 */

function PopupCenter(pageURL, title,w,h) {
var left = (screen.width/2)-(w/2);
var top = (screen.height/2)-(h/2);
var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

function PopupCenterScroll(pageURL, title,w,h) {
var left = (screen.width/2)-(w/2);
var top = (screen.height/2)-(h/2);
var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

function PopupCenterReSize(pageURL, title,w,h) {
	var left = (screen.width/2)-(w/2);
	var top = (screen.height/2)-(h/2);
	var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	}

function clearMessages() {
	$('.messageArea').empty();
}

function setAddEditPane(thisObj,opt){
	var elementWraper = $(thisObj).closest('.section_box');
	$(elementWraper).find('.basic_grid tr').removeClass('highlight');
	
 if(opt === "Add"){
	// alert($(elementWraper).find('.section_full_inside').html());
	$(elementWraper).find('.section_full_inside').show();
	$(elementWraper).find('.section_full_inside').children('h3').html(thisObj.title);
	
	}
	
 if(opt === "Edit"){
	 $(thisObj).parents('tr').addClass('highlight');
	$(elementWraper).find('.section_full_inside').show();
	$(elementWraper).find('.section_full_inside').children('h3').html(thisObj.title);
	}
 if(opt === "Save"){
	 $(elementWraper).find('.section_full_inside').hide();
	}
 if(opt === "Cancel"){
	 $(elementWraper).find('.section_full_inside').hide();
	}
 if(opt === "Delete"){
	  $(thisObj).parents('tr').addClass('highlight');
	  $(elementWraper).find('.section_full_inside').hide();
	  
	var message = "Are you sure you want to delete this record?" ;
	
	var okfunction = function(){
		$(thisObj).parents('tr').hide();
	};
	
	var cancelfunction = function (){
		$(thisObj).parents('tr').removeClass('highlight');
	};
	
	confirm_function(message , okfunction, cancelfunction );
 }
}