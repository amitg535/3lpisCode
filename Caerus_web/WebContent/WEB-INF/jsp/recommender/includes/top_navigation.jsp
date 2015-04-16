    <div id="topnavigation" class="webwidget_menu_glide">
      <div class="webwidget_menu_glide_sprite"></div>
      <ul class="dropdown_nav">
	    <li> <a href="<c:url value="recommender_view_requests.htm"/>" id="recorequest">View Requests</a> </li>  
	  </ul>
	   <div class="clear"></div>	    
	    
	 
    </div>
    <script type="text/javascript">
   
    
    pagename();
   

function pagename(){
var sPath = window.location.pathname;
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
switch(sPage)
	{
	case '<c:url value="recommender_view_requests.htm"/>':
	  $('#recorequest').parent().addClass('current')
	  break;

	}
}

    </script>
    