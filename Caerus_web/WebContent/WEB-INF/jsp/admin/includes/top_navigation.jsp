    <div id="topnavigation" class="webwidget_menu_glide">
      <div class="webwidget_menu_glide_sprite"></div>
      <ul class="dropdown_nav">
	    <li> <a href="<c:url value="admin_manage_users.htm"/>" id="manageusers">Manage Users</a> </li>  
	    <li> <a href="<c:url value="admin_view_careerpaths.htm"/>" id="careerpath">Career Paths</a> </li> 
	     <li> <a href="<c:url value="admin_verification.htm"/>" id="verification">Verifications</a> </li> 
	     <li> <a href="<c:url value="admin_manage_beta_users.htm"/>" id="betaUsers">Manage Beta Users</a> </li>
	    <%--  <li> <a href="<c:url value="admin_manage_database.htm"/>" id="manageDatabase">Manage Database</a> </li>  --%>
	       <li> <a href="<c:url value="admin_manage_masters.htm"/>" id="manageMasters">Manage Masters</a> </li>
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
	case '<c:url value="admin_manage_users.htm"/>':
	  $('#manageusers').parent().addClass('current')
	  break;
	
	case '<c:url value="admin_view_careerpaths.htm"/>':
	  $('#careerpath').parent().addClass('current')
	  break;
	
	case '<c:url value="admin_verification.htm"/>':
		  $('#verification').parent().addClass('current')
		  break;
	  
	 default:case '<c:url value="admin_login.htm"/>':
		  $('#manageusers').parent().addClass('current')
	  break;

	 case '<c:url value="admin_manage_beta_users.htm"/>':
		  $('#betaUsers').parent().addClass('current');
		  break;

	/*  case '<c:url value="admin_manage_database.htm"/>':
		  $('#manageDatabase').parent().addClass('current'); */
		   
	 case '<c:url value="admin_manage_masters.htm"/>':
		  $('#manageMasters').parent().addClass('current');
		  break;
	}
}

    </script>
    