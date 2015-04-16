
			
			
			$(document).ready(function(){




   
  

  $(".portfolio_img").mouseover(function(){
	  
	    $(".portfolio_editbtn").css("display","block");
	  });

  $(".portfolio_img").mouseout(function(){
	  
	    $(".portfolio_editbtn").css("display","none");
	  });

  
  $(window).load(function() {

		jQuery('#list3').accordion({
				header: 'div.title',
				active: false,
				alwaysOpen: false,
				animated: false,
				autoheight: false
			});
			
			
			var accordions = jQuery('#list3');
		});
  
  
  
  $('#mydiv').hide();
  
  
  
  $('#dropdown').click(function(e){
  	//alert("HI");// <----you missed the '.' here in your selector.
      e.stopPropagation();
      $('#mydiv').slideToggle();
  });

  $('#mydiv').click(function(e){
     // e.stopPropagation();
  });

  $(document).click(function(){
       $('#mydiv').slideUp();
  });
});


 