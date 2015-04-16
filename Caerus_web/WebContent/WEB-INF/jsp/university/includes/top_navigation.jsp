<div id="topnavigation" class="webwidget_menu_glide">
      <div class="webwidget_menu_glide_sprite"></div>
	  
	  <ul class="dropdown_nav">
	    <li> <a href="<c:url value="university_dashboard.htm"/>" id="dashboard">Dashboard</a> </li>  
	    
	    <li><%--  <a href="<c:url value="university_campus_jobs_internships.htm"/>" id="jobinternships">Jobs / Internships</a> --%>
	    		<a  id="jobinternships">Jobs / Internships</a>
	    		<ul class="sub_menu">	
				     <li><a  href="<c:url value="university_campus_jobs_internships.htm"/>" id="jobinternships"> Jobs / Internships</a></li> 
				  	 <li><a  href="<c:url value="university_internal_postings.htm"/>" id="jobinternships">Internal Postings</a></li> 
		  	 	</ul>
	    </li><!-- style="padding: 25px 15px;" -->	    
        <li> <a href="<c:url value="university_manage_connections.htm"/>" id="manageconnection">Manage Connections</a></li>
       
        <li> <a  id="scheduleevent">Manage Events</a>
	        <ul class="sub_menu">	
			     <li><a href="<c:url value="university_manage_scheduledevents.htm"/>" id="scheduleevent"> Scheduled Events</a></li> 
			  	 <li><a href="<c:url value="university_manage_received_invitations.htm"/>" id="scheduleevent">Corporate Invites</a></li> 
		  	</ul>
		</li>
       <c:set var="isAdmin" value='<%=request.getSession().getAttribute("isAdmin") %>' />
			<c:if test="${not empty isAdmin && isAdmin == true }">
		        <li><a  id="profile">Admin</a>
		        <ul class="sub_menu">
		        	<li> <a  href="<c:url value="view_university_profile.htm"/>" id="profile">My Account</a></li>
		        	<li> <a  href="<c:url value="university_add_user.htm"/>" id="profile">Add User</a></li>
		        </ul>  
		        </li> 
		   </c:if>
	</ul>
	   <div class="clear"></div>	    
	    
	    <%-- <ul class="dropdown_nav">
	    <li><a href="<c:url value="employer_recentlyposted_jobs.htm"/>" class="active">Dashboard</a> </li>  
	    <li><a href="<c:url value="employer_posta_job.htm"/>">Post Jobs</a>
	      <ul class="sub_menu">
	        <li><a href="<c:url value="employer_posta_job.htm"/>">Post a Vacancy</a></li>
	        <li><a href="<c:url value="employer_recentlyposted_jobs.htm"/>">Recently Posted Jobs</a></li>
	      </ul>
	    </li>
	     <li><a href="#">Manage Responses</a></li> 
	    <li> <a href="#">Search Candidates</a></li>
	    <li> <a href="#">FAQ's</a></li>
	    <li> <a href="#">Report a Problem</a></li>
	    <li> <a href="#">Help?</a></li>
	  </ul>
	   <div class="clear"></div> --%>
    </div>
    <script type="text/javascript">
   
    
    pagename();
   

function pagename(){
var sPath = window.location.pathname;
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
//alert(sPage);
switch(sPage)
	{
	case '<c:url value="university_dashboard.htm"/>':
	  $('#dashboard').parent().addClass('current')
	  break;
	
	case '<c:url value="university_campus_jobs_internships.htm"/>':
	  $('#jobinternships').parent().addClass('current')
	  break;
	
	case '<c:url value="university_manage_connections.htm"/>':
	  $('#manageconnection').parent().addClass('current')
	  break;

	case '<c:url value="university_add_connections.htm"/>':
		  $('#manageconnection').parent().addClass('current')
		  break;

	case '<c:url value="university_upload_file.htm"/>':
		  $('#manageconnection').parent().addClass('current')
		  break;
	
	  case '<c:url value="university_manage_scheduledevents.htm"/>':
	  $('#scheduleevent').parent().addClass('current')
	  break;
	 
	  case '<c:url value="university_manage_receivedinvitations.htm"/>':
	  $('#scheduleevent').parent().addClass('current')
	  break;
	  
	  case '<c:url value="view_university_profile.htm"/>':
		  $('#profile').parent().addClass('current')
		  break;

	  case '<c:url value="university_add_user.htm"/>':
		  $('#profile').parent().addClass('current')
		  break;
	  
	  case '<c:url value="campus_job_preview.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	  case '<c:url value="campus_internship_preview.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	  
	 /*  case '<c:url value="university_add_user.htm"/>':
		  $('#profile').parent().addClass('current')
		  break; */
	  
	 case '<c:url value="university_internal_postings.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	  
	 case '<c:url value="university_post_internship.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;	  
		  
	 case '<c:url value="internal_internship_preview.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;	
	 
	 case '<c:url value="university_manage_received_invitations.htm"/>':
		  $('#scheduleevent').parent().addClass('current')
		  break;
	
	 case '<c:url value="university_edit_internal_internship.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
		 
	 case '<c:url value="view_campus_internship_responses.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	 
	 case '<c:url value="view_campus_job_responses.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	 
	 case '<c:url value="view_internal_posting_responses.htm"/>':
		  $('#jobinternships').parent().addClass('current')
		  break;
	 
	default:case '<c:url value="university_dashboard.htm"/>':
		  $('#dashboard').parent().addClass('current')
	  break;
	}
}

    </script>
    