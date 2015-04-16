<%@ include file="/WEB-INF/jsp/include.jsp"%>

<%  			Authentication topAuths = SecurityContextHolder.getContext().getAuthentication();
				String topAuthority = topAuths.getAuthorities().toString();
				int topMid = topAuthority.lastIndexOf("_");
			 	String topRole =topAuthority.substring(topMid+1, topAuthority.length()-1);
				pageContext.setAttribute("topRole", topRole);
	
	%>
	

	<c:choose>
	   <c:when test="${topRole=='STUDENT'}">
	   <%
 String getURL=request.getRequestURL().toString();
 String uri = (String) request.getAttribute("javax.servlet.forward.request_uri");
 String jobsapplication = null;
 String dashboard = null;
 String manage_profile = null;
 if(uri.equals("/candidates_jobsapplication.htm") || uri.equals("/candidate_advancesearch.htm") ){
	 jobsapplication = "active";
 }
 else if(uri.equals("/candidate_dashboard.htm") || uri.equals("/welcome.htm")){
	 dashboard = "active";
 }
/*  else if(uri.equals("/Caerus/candidate_manage_profile.htm") || uri.equals("/Caerus/candidate_view_profile.htm")){
	 manage_profile = "active";
 } */
 
 else if(uri.equals("/candidate_create_profile.htm") || uri.equals("/candidate_view_new_profile.htm")){
	 manage_profile = "active";
 }
 %> 
		<div id="topnavigation" class="webwidget_menu_glide">
      <div class="webwidget_menu_glide_sprite"></div>
      <ul class="dropdown_nav">
        <li><a href="<c:url value="candidate_dashboard.htm"/>" class="<%=dashboard%>" id="dashboard">Dashboard</a> </li>   
         <li> <a  class="<%=manage_profile%>" id="manageprofile">My Caerus</a>    
	      	<ul class="sub_menu">
	      		<li><a href="<c:url value="candidate_recommended_jobs.htm"/>"  id="manageprofile"> Recommended Jobs</a></li> 		     
	      		<%-- <li><a href="<c:url value="candidate_view_new_profile.htm"/>"> My Profiles</a></li> --%>	
	      		<li> <a href="<c:url value="candidate_manage_profile.htm"/>" class="<%=manage_profile%>"  id="Manageprofile">My Profiles</a></li>      	
	     		<li><a href="<c:url value="candidate_applied_jobs.htm"/>"  id="manageprofile">Applied Jobs</a></li>
	     		<li><a href="<c:url value="candidate_saved_jobs.htm"/>"  id="manageprofile"> Saved Jobs</a></li> 
	     		<li><a href="<c:url value="candidate_applied_internships.htm"/>"  id="manageprofile">Applied Internships</a></li>	     
	     		<li><a href="<c:url value="candidate_saved_internships.htm"/>"  id="manageprofile">Saved Internships</a></li>	   
	    	</ul>
	    </li> 

<%--         <li><a href="<c:url value="#"/>" class="<%=jobsapplication%>" id="searchedjob">Search Jobs</a> --%>

	    
	    
        <li><a class="<%=jobsapplication%>" id="searchedjob">Search Jobs</a>

        	<ul class="sub_menu">	
	     		<li><a href="<c:url value="candidate_advancesearch.htm"/>" id="searchedjob"> Advanced Search</a></li> 	   
	     		<li><a href="<c:url value="candidate_savedsearch.htm"/>" id="searchedjob"> Saved Search</a></li> 
	    	</ul>
	    </li>
	    
        <li> <a id="campusconnect">Campus Connect</a>   
        <ul class="sub_menu">	
	     		<li><a href="<c:url value="candidate_broadcasted_jobs.htm"/>" id="campusconnect"> Jobs From Campus</a></li> 	   
	     		<li><a href="<c:url value="candidate_broadcasted_internships.htm"/>" id="campusconnect"> Internships From Campus</a></li> 	 
	     		<li><a href="<c:url value="candidate_broadcasted_corporate_invites.htm"/>" id="campusconnect"> Upcoming Events</a></li> 
	    </ul>
        </li> 

        <li> <a href="<c:url value="candidate_portfolio.htm"/>" id="portfolio">Portfolio</a></li>  
        <li> <a href="<c:url value="candidate_resumebuilder.htm"/>" id="resumebuilder">Resume Builder</a></li>   
        
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
		  $('#manageprofile').parent().addClass('current')
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
	
	case '<c:url value="#"/>':
		  $('#searchedjob').parent().addClass('current')
		  break;
	
	case '<c:url value="candidate_advancesearch.htm"/>':
		  $('#searchedjob').parent().addClass('current')
		  break;
		  
	case '<c:url value="candidate_savedsearch.htm"/>':
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
	
	
	default:case '<c:url value="candidate_dashboard.htm"/>':
		  $('#dashboard').addClass('current')
	  break
	}
}
    </script>
    	
		</c:when>
		<c:when test="${topRole=='CORPORATE'}">
			    <div id="topnavigation"> 
	    <ul class="dropdown">
	    <li><a href="<c:url value="employer_dashboard.htm"/>" id="dashboard">Dashboard</a> </li>  
	    <li><a href="<c:url value="#"/>" id="job">Publish  Jobs / Internships</a>
	      <ul class="sub_menu">	     
	        <li><a href="<c:url value="employer_jobsinternships_listing.htm"/>" id="job"> Job / Internship </a></li> 
	        <li><a href="<c:url value="employer_campus_postedjobsinternships_listing.htm"/>" id="job"> Campus Job / Internship </a></li> 	        	        
	      </ul>
	    </li>
	    <%-- <li><a href="<c:url value="employer_manage_responses_listing.htm"/>" id="manageresponse">Manage Responses</a></li> --%>
        <li><a href="<c:url value="#"/>" id="searchresume">Search Resumes</a>
       <ul class="sub_menu">
       	      <li><a href="<c:url value="employer_candidateSearch.htm"/>" id="searchresume">Search Candidates</a></li>
	        <li><a href="<c:url value="employer_saved_searches.htm"/>" id="searchresume"> Saved Searches </a></li> 
	         <li><a href="<c:url value="employer_save_search_candidate.htm"/>" id="searchresume">Saved Candidate</a></li>	        	        
	   </ul>
	   </li>
        <li><a href="<c:url value="#"/>" id="campusconnect">Campus Connect</a>
        <ul class="sub_menu">	     
	        <li><a href="<c:url value="employer_manage_scheduledevents.htm"/>" id="campusconnect"> Scheduled Events </a></li> 
	        <li><a href="<c:url value="employer_manage_receivedinvitations.htm"/>" id="campusconnect"> Received Invitations </a></li> 	        	        
	      </ul>
	      </li>

         
        
        <li><a href="<c:url value="#"/>" id="admin">Admin</a>

	      <ul class="sub_menu">	  
	       <li><a href="<c:url value="employer_manage_profile_preview.htm"/>" id="admin">My Account</a></li>    
	        <li><a href="<c:url value="employer_add_user_list.htm"/>" id="admin"> Add User </a></li> 
	        <li><a href="<c:url value="employer_querybuilder_add_formula.htm"/>" id="admin"> Query Builder </a></li> 	        	        
</ul>
</li>
	      
	   
        
	  </ul>
	  
	  
	<%--   <ul class="dropdown">
	    <li><a href="<c:url value="employer_dashboard.htm"/>" class="active">Dashboard</a> </li>  
	    <li><a href="<c:url value="employer_posta_job.htm"/>">Post Jobs</a>
	      <ul class="sub_menu">
	        <li><a href="<c:url value="employer_posta_job.htm"/>">Post a Vacancy</a></li>
	        <li><a href="<c:url value="employer_recentlyposted_jobs.htm"/>">Recently Posted Jobs</a></li>	   
	        <li><a href="<c:url value="employer_jobsinternships_listing.htm"/>">Recently Posted Jobs</a></li>	     
	        <li><a href="<c:url value="employer_campus_posta_job.htm"/>">Post a Job to University</a></li> 
	         <li><a href="<c:url value="employer_campus_posta_internship.htm"/>">Post a Internship to University</a></li> 
	        
	      </ul>
	    </li>
	     <li><a href="#">Manage Responses</a></li> 
	    <li> <a href="<c:url value="employer_candidateSearch.htm"/>">Search Candidates</a></li>
	    <li> <a href="employer_manage_scheduledevents.htm">Manage Events</a></li> 
	    <li> <a href="#">Report a Problem</a></li>
	    <li> <a href="#">Help?</a></li>
	  </ul> --%>
	  
	  
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
	case '<c:url value="employer_dashboard.htm"/>':
	  $('#dashboard').addClass('active')
	  break;
	
	case '<c:url value="#"/>':
		  $('#job').addClass('active')
		  break;
	
	case '<c:url value="employer_jobsinternships_listing.htm"/>':
		  $('#job').addClass('active')
		  break;
	
	
	case '<c:url value="employer_campus_postedjobsinternships_listing.htm"/>':
		  $('#job').addClass('active')
		  break;
	
	case '<c:url value="employer_manage_responses_listing.htm"/>':
		  $('#manageresponse').addClass('active')
		  break;
	
	case '<c:url value="#"/>':
		  $('#searchresume').addClass('active')
		  break;
	
	case '<c:url value="employer_candidateSearch.htm"/>':
		  $('#searchresume').addClass('active')
		  break;
	
	case '<c:url value="employer_saved_searches.htm"/>':
		  $('#searchresume').addClass('active')
		  break;
	
	
	case '<c:url value="employer_save_search_candidate"/>':
		  $('#searchresume').addClass('active')
		  break;
	
	case '<c:url value="#"/>':
		  $('#campusconnect').addClass('active')
		  break;
	
	case '<c:url value="employer_manage_scheduledevents.htm"/>':
		  $('#campusconnect').addClass('active')
		  break;
	
	case '<c:url value="employer_manage_receivedinvitations.htm"/>':
		  $('#campusconnect').addClass('active')
		  break;
	
	case '<c:url value="#"/>':
		  $('#admin').addClass('active')
		  break;
	
	case '<c:url value="employer_manage_profile_preview.htm"/>':
		  $('#admin').addClass('active')
		  break;
	
	case '<c:url value="employer_add_user_list.htm"/>':
		  $('#admin').addClass('active')
		  break;
	
	
	case '<c:url value="employer_querybuilder_add_formula.htm"/>':
		  $('#admin').addClass('active')
		  break;
	
	default:case '<c:url value="employer_dashboard.htm"/>':
		  $('#dashboard').addClass('active')
	  break
	}
}
    </script>
    
		</c:when>
		<c:when test="${topRole=='UNIVERSITY'}">
		    <div id="topnavigation"> 
	  <ul class="dropdown">
	    <li> <a href="<c:url value="university_dashboard.htm"/>" id="dashborad">Dashboard</a> </li>  
	    <li> <a href="<c:url value="university_posted_jobinternships_listing.htm"/>" id="jobinternships">Jobs / Internships</a></li>	    
        <li> <a href="<c:url value="#"/>" id="manageconnection">Manage Connections</a></li>
        <li> <a href="<c:url value="university_manage_scheduledevents.htm"/>" id="scheduleevent">Manage Events</a>
	        <ul>	
		     <li><a href="<c:url value="university_manage_scheduledevents.htm"/>"> Scheduled Events</a></li> 
		  	 <li><a href="<c:url value="university_manage_receivedinvitations.htm"/>" id="scheduleevent">Corporate Invites</a></li> 
		  	 </ul>
		  	 </li>
       
        <li> <a  id="profile">Admin</a> 
          	<ul>	
          	 <li> <a href="<c:url value="university_profile.htm"/>" id="profile">My Account</a></li>
	     		<li><a href="<c:url value="university_add_user.htm"/>" id="profile"> Add User</a></li> 
	  	 		 
	  	 	</ul> 
	  	</li>   
	  </ul>
	   <div class="clear"></div>	    
	    
	    <%-- <ul class="dropdown">
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
	  $('#dashborad').addClass('active')
	  break;
	case '<c:url value="university_posted_jobinternships_listing.htm"/>':
	  $('#jobinternships').addClass('active')
	  break;
	case '<c:url value="#"/>':
	  $('#manageconnection').addClass('active')
	  break;
	  case '<c:url value="university_manage_scheduledevents.htm"/>':
	  $('#scheduleevent').addClass('active')
	  break;
	 
	  case '<c:url value="university_manage_receivedinvitations.htm"/>':
	  $('#scheduleevent').addClass('active')
	  break;
	  case '<c:url value="university_profile.htm"/>':
		  $('#profile').addClass('active')
		  break;
	  
	  case '<c:url value="university_add_user.htm"/>':
		  $('#profile').addClass('active')
		  break;
	  case '<c:url value="campus_job_preview.htm"/>':
		  $('#jobinternships').addClass('active')
		  break;
	  case '<c:url value="campus_internship_preview.htm"/>':
		  $('#jobinternships').addClass('active')
		  break;
	  
	default:case '<c:url value="university_dashboard.htm"/>':
		  $('#dashborad').parent().addClass('active')
	  break
	}
}
    </script>
    	
		</c:when>
		<c:otherwise>
		<div>
		</div>	
		</c:otherwise>
	</c:choose>