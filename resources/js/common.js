/*
 * <CYBERSCHOOL, This application manages the daily activities of a Teacher
 *		and a Student of a School> Copyright (C) 2017 a CywebsTech Media Coperation.
 *		Author = Eric Brown Appiah
 *		Contact = 0205212015
 */

function disableEnterKey(e) {
	var key;     
	
	if(window.event)
		key = window.event.keyCode; //IE
	else
	    key = e.which; //firefox     
	 
	return (key != 13);
}