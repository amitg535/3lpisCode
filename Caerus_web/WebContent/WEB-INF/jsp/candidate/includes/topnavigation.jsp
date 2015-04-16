<%
 String getURL=request.getRequestURL().toString();
 String uri = (String) request.getAttribute("javax.servlet.forward.request_uri");
 String jobsapplication = null;
 String dashboard = null;
 String manage_profile = null;
 String portfolio = null;
 if(uri.equals("/candidates_jobsapplication.htm") || uri.equals("/candidate_search_jobs_internships.htm") ){
	 jobsapplication = "current";
 }
 else if(uri.equals("/candidate_dashboard.htm") || uri.equals("/welcome.htm")){
	 dashboard = "current";
 }
/*  else if(uri.equals("/Caerus/candidate_manage_profile.htm") || uri.equals("/Caerus/candidate_view_profile.htm")){
	 manage_profile = "current";
 } */
 
 else if(uri.equals("/candidate_create_profile.htm") || uri.equals("/candidate_view_new_profile.htm")){
	 manage_profile = "current";
 }
 %> 

<div id="topnavigation" class="webwidget_menu_glide">
      <div class="webwidget_menu_glide_sprite"></div>
      <ul class="dropdown_nav">
        <li><a href="<c:url value="candidate_dashboard.htm"/>" class="<%=dashboard%>" id="dashboard">Dashboard</a> </li>   
         
         
         
         <li> 
            <a  href="<c:url value="candidate_job_activities.htm"/>" class="<%=manage_profile%>" id="manageprofile">Job Activities</a>
           <%-- <a  class="<%=manage_profile%>" id="manageprofile">My Jobs</a>   --%>  
	      	<!-- <ul class="sub_menu"> -->
	      		<%-- <li><a href="<c:url value="candidate_recommended_jobs.htm"/>"  id="manageprofile"> Recommended Jobs</a></li>  --%>		     
	      		 <%-- <li><a href="<c:url value="candidate_view_new_profile.htm"/>"> My Profiles</a></li> 	 --%>
	      		   <%-- <li><a href="<c:url value="candidate_job_activities.htm"/>"  id="manageprofile">Job Activities</a></li> --%>
	     		 <%-- <li><a href="<c:url value="candidate_applied_jobs.htm"/>"  id="manageprofile">Applied Jobs</a></li>
	     		<li><a href="<c:url value="candidate_saved_jobs.htm"/>"  id="manageprofile"> Saved Jobs</a></li>    
	     		<li><a href="<c:url value="candidate_applied_internships.htm"/>"  id="manageprofile">Applied Internships</a></li>	     
	     		<li><a href="<c:url value="candidate_saved_internships.htm"/>"  id="manageprofile">Saved Internships</a></li> --%>	 
	    	<!-- </ul> -->
	    </li> 

<%--         <li><a href="<c:url value="#"/>" class="<%=jobsapplication%>" id="searchedjob">Search Jobs</a> --%>

	    
	    
        <li><a href="<c:url value="candidate_basic_search.htm"/>" class="<%=jobsapplication%>" id="searchedjob">Search Jobs</a>

        	<%-- <ul class="sub_menu">	
	     		<li><a href="<c:url value="candidate_search_jobs_internships.htm"/>" id="searchedjob"> Advanced Search</a></li> 	   
	     		<li><a href="<c:url value="candidate_saved_search.htm"/>" id="searchedjob"> Saved Search</a></li> 
	    	</ul> --%>
	    </li>
	    
        <li> <a id="campusconnect">Campus Connect</a>   
        <ul class="sub_menu">	
	     		<li><a href="<c:url value="candidate_broadcasted_jobs.htm"/>" id="campusconnect"> Jobs From Campus</a></li> 	   
	     		<li><a href="<c:url value="candidate_broadcasted_internships.htm"/>" id="campusconnect"> Internships From Campus</a></li> 	 
	     		<li><a href="<c:url value="candidate_broadcasted_corporate_invites.htm"/>" id="campusconnect"> Upcoming Events</a></li> 
	     		<li><a href="<c:url value="candidate_internal_postings.htm"/>" id="campusconnect"> Internal Postings </a></li> 	  
	    </ul>
        </li> 

        <li> <a id="portfolio">My Profile</a> 
         <ul class="sub_menu">
       		   <li> <a href="<c:url value="candidate_portfolio.htm"/>" id="portfolio">Portfolio</a></li> 
       		 <li> <a href="<c:url value="candidate_manage_profile.htm"/>" class="<%=manage_profile%>"  id="portfolio">Manage Profiles</a></li>
       		 <li> <a href="<c:url value="candidate_careerpath.htm"/>" class=""  id="roadmap">Roadmap</a></li>
       		  <li> <a href="<c:url value="candidate_recommendation.htm"/>" class=""  id="recommendations">Recommendations</a></li>
        </ul>
        </li> 
        <li> <a href="<c:url value="candidate_resume_builder.htm"/>" id="resumebuilder">Resume Builder</a></li>   
        
      </ul>
      <div class="clear"></div>
    </div>
    
    
     <script type="text/javascript">
   
    
    pagename();
   
function pagename(){
var sPath = window.location.pathname;
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
//alert(sPage);
switch(sPage)
	{
	case '<c:url value="candidate_dashboard.htm"/>':
	  $('#dashboard').parent().addClass('current')
	  break;
	
	case '<c:url value="candidate_recommended_jobs.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_manage_profile.htm"/>':
		  $('#portfolio').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_applied_jobs.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_saved_jobs.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_applied_internships.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_saved_internships.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_basic_search.htm"/>':
		  $('#searchedjob').parent().addClass('current')
		  break;
	
	 case '<c:url value="candidate_search_jobs_internships.htm"/>':
		  $('#searchedjob').parent().addClass('current')
		  break;
		  
	case '<c:url value="candidate_saved_search.htm"/>':
		  $('#searchedjob').parent().addClass('current')
		  break; 
		
	case '<c:url value="candidate_portfolio.htm"/>':
		  $('#portfolio').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_resumebuilder.htm"/>':
		  $('#resumebuilder').parent().addClass('current')
		  break;
	
	
	case '<c:url value="candidate_broadcasted_jobs.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_broadcasted_internships.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_broadcasted_corporate_invites.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	case '<c:url value="candidate_preview_university_event.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	case '<c:url value="candidate_preview_received_corporate_invite.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
		  
	case '<c:url value="candidate_detail_view.htm"/>':
		  $('#portfolio').parent().addClass('current')
		  break;
	case '<c:url value="candidate_job_activities.htm"/>':
		  $('#manageprofile').parent().addClass('current')
		  break;
	
	
	default:case '<c:url value="candidate_dashboard.htm"/>':
		  $('#dashboard').parent().addClass('current')
	  break
	}
}
    </script>
    