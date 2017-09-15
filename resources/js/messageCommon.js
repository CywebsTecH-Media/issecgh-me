function bulkUploadBlockUI(){

$.blockUI({
    blockMsgClass: 'black-on-white',
    message: 'Your request is being processed.. Please wait..'
});

}

function custom_alert(output_msg)
{
		
		var title_msg = 'System Alert!';
		
		if (!output_msg)
		    output_msg = 'No Message to Display.';
    
    	// Define the Dialog and its properties.
	  $("<div></div>").html(output_msg).dialog({
	        title: title_msg,
	        resizable: false,
	        modal: true,
	        buttons: {
	            "Ok": function() 
	            {
	                $( this ).dialog( "close" );
	            }
	        }
	    });
}

function custom_alert_for_bulkupload(output_msg,command)
{
		
		var title_msg = 'System Alert!';
		
		if (!output_msg)
		    output_msg = 'No Message to Display.';
    
    	// Define the Dialog and its properties.
	  $("<div></div>").html(output_msg).dialog({
	        title: title_msg,
	        resizable: false,
	        modal: true,
	        buttons: {
	            "Ok": command
	        }
	    });
}











function confirm_function(output_msg, okfunction, cancelfunction){
	
	var title_msg = 'System Alert!';
	
	if (!output_msg)
	    output_msg = 'No Message to Display.';
	
	 // Define the Dialog and its properties.
	$("<div></div>").html(output_msg).dialog({
		title: title_msg,
		resizable: false,
        modal: true,
        height: 200,
        width: 400,
        buttons: {
            "OK": function () {
                $(this).dialog('close');
                okfunction();
            },
            "Cancel": function () {
            $(this).dialog('close');
            cancelfunction();
            }
        },
		close: function () {
			$(this).dialog('close');
			cancelfunction();
		}
	});
}