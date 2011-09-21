function clear_text(name, text){
	if (jQuery("#"+name).attr('value')==text){
		jQuery("#"+name).attr('value', '');
		jQuery("#"+name).removeClass("gray_text");
	}
	return false;
}