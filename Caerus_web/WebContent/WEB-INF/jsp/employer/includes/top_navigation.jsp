<%@ include file="/WEB-INF/jsp/include.jsp" %>
<div id="topnavigation" class="webwidget_menu_glide">
	<div class="webwidget_menu_glide_sprite"></div>
	<ul class="dropdown_nav">
		<li><a href="<c:url value="employer_dashboard.htm"/>"
			id="dashboard">Dashboard</a></li>
		<li><a href="<c:url value="employer_jobs_internships.htm"/>" id="jobinternships">Publish Jobs /
				Internships</a> <!-- style="padding: 25px 15px;" -->
			<%--<ul class="sub_menu">
				 <li><a
					href="<c:url value="employer_jobsinternships_listing.htm"/>"
					id="job"> Job / Internship</a></li>
				<li><a
					href="<c:url value="employer_campus_postedjobsinternships_listing.htm"/>"
					id="job"> Campus Job / Internship</a></li> 
			</ul>--%></li>
		<%-- <li><a href="<c:url value="employer_manage_responses_listing.htm"/>" id="manageresponse">Manage Responses</a></li> --%>
		<li><a id="searchresume">Search</a>
			<ul class="sub_menu">
				<li><a href="<c:url value="employer_search_candidate.htm"/>"
					id="searchresume">Search Candidates</a></li>
				<%-- <li><a href="<c:url value="employer_saved_searches.htm"/>"
					id="searchresume"> Saved Searches</a></li> --%>
				<li><a
					href="<c:url value="employer_saved_candidates.htm"/>"
					id="searchresume">Saved Candidates</a></li>
				<li><a
					href="<c:url value="employer_querybuilder_add_formula.htm"/>"
					id="searchresume"> Query Builder</a></li>
			</ul></li>
		<li><a a href="<c:url value="employer_campus_connect.htm"/>" id="campusconnect">Campus Connect</a>
			<%-- <ul class="sub_menu">
				<li><a
					href="<c:url value="employer_manage_scheduledevents.htm"/>"
					id="campusconnect"> Scheduled Events </a></li>
				<li><a
					href="<c:url value="employer_manage_receivedinvitations.htm"/>"
					id="campusconnect"> Received Invitations </a></li>
			</ul> --%></li>


	<c:set var="isAdmin" value='<%=request.getSession().getAttribute("isAdmin") %>' />
	<c:if test="${not empty isAdmin && isAdmin == true }">
		<li class="last"><a id="admin">Admin</a>
			<ul class="sub_menu">
				<li><a href="<c:url value="employer_analytics.htm"/>" id="admin">Analytics</a></li>
				<li><a href="<c:url value="profile_preview.htm" />" id="admin">My Account</a></li>
				<li><a href="<c:url value="employer_files_repository.htm"/>" id="admin">Manage Files</a></li>
			 	<li><a href="<c:url value="employer_add_user.htm"/>" id="admin"> Add User </a></li> 
				<%-- <a href="<c:url value="employer_generate_report.htm"/>" id="admin">Reports</a> --%>
				<%-- 	
						<ul class="sub_menu thirdlevel">
				<li><a href="<c:url value="employer_generate_report.htm"/>"
					id="admin">Job Responses Report</a></li>
						<li><a href="<c:url value="employer_analytics.htm"/>"
					id="admin">Analytics</a></li>
					<!-- <li><a href="#"
					id="admin">Report 1</a></li>
					<li><a href="#"
					id="admin">Report 2</a></li> -->
					</ul> --%>
					
			</ul>
		</li>

</c:if>

	</ul>


	<%--   <ul class="dropdown_nav">
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
	  $('#dashboard').parent().addClass('current')
	  break;
	
	case '<c:url value="employer_jobs_internships.htm"/>':
	 $('#jobinternships').parent().addClass('current')
     break;	

	case '<c:url value="employer_campus_connect.htm"/>':
		 $('#campusconnect').parent().addClass('current')
	     break;

	 
	/* case '<c:url value="employer_jobsinternships_listing.htm"/>':
		  $('#job').parent().addClass('current')
		  break;
	
	
	case '<c:url value="employer_campus_postedjobsinternships_listing.htm"/>':
		  $('#job').parent().addClass('current')
		  break; */
	
	case '<c:url value="employer_manage_responses_listing.htm"/>':
		  $('#manageresponse').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_search_candidate.htm"/>':
		  $('#searchresume').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_candidateSearch.htm"/>':
		  $('#searchresume').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_saved_searches.htm"/>':
		  $('#searchresume').parent().addClass('current')
		  break;
	
	
	case '<c:url value="employer_save_search_candidate"/>':
		  $('#searchresume').parent().addClass('current')
		  break;
	
	
	
	/* case '<c:url value="employer_manage_scheduledevents.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_manage_receivedinvitations.htm"/>':
		  $('#campusconnect').parent().addClass('current')
		  break;
	 */
	
	
	case '<c:url value="profile_preview.htm"/>':
		  $('#admin').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_add_user_list.htm"/>':
		  $('#admin').parent().addClass('current')
		  break;

	case '<c:url value="employer_files_repository.htm"/>':
		  $('#admin').parent().addClass('current')
		  break;
	
	case '<c:url value="employer_querybuilder_add_formula.htm"/>':
		  $('#searchresume').parent().addClass('current')
		  break;

	case '<c:url value="employer_save_search_candidate.htm"/>':
		  $('#searchresume').parent().addClass('current')
		  break;


	case '<c:url value="employer_generate_report.htm"/>':
		  $('#admin').parent().addClass('current')
		  break;
	
	default:case '<c:url value="employer_dashboard.htm"/>':
		  $('#dashboard').parent().addClass('current')
	  break
	}
}

    </script>