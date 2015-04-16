jQuery(document).ready(function(){
	//alert('animation');
	jQuery('#mid_wrap').addClass("slideDown");
	
	//jQuery.noConflict();
	
	// to toggle save search tab on candidate listing page
	 $("#searchTab").click(function(){
		  // alert("menu.js");
	    $('.left_searchfilter_label').slideToggle();
	   });
	
});