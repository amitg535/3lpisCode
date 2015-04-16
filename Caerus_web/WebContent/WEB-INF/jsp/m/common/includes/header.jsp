<%@ include file="/WEB-INF/jsp/include.jsp"%>

<%  			Authentication headAuth = SecurityContextHolder.getContext().getAuthentication();
				String headAuthority = headAuth.getAuthorities().toString();
				int headMid = headAuthority.lastIndexOf("_");
			 	String headRole =headAuthority.substring(headMid+1, headAuthority.length()-1);
				pageContext.setAttribute("headRole", headRole);
	
	%>
	
	<c:choose>
	   <c:when test="${headRole=='STUDENT'}">
	    
		<script type="text/javascript" src="../mobile_html/js/jquery.mmenu.min.js"></script>
		<script type="text/javascript">
		$(function() {
			$('nav#menu').mmenu();
		});

		$(document).ready(function(){
			  
			 
			  
			  

			  //$('.topmenu').css("display","none");
			  $('.topsublink').on('click', function(){
				// alert("topmenu");
				  if($(".topmenu").css("display") == "block"){ 
					  $(".topmenu").slideUp().css("display","none");
					  
				  }
				  
				  else if($(".topmenu").css("display") == "none"){
					  $(".topmenu").slideDown().css("display","block");  
					  
				  }
			  });

			  $(' #mid_wrap ').click(function(){
				  
					 
				  
					

				  $(".topmenu").slideUp().css("display","none");
				 
			});
		});
		
		$(document).ready(function(){
			//alert('animation');
			$('#mid_wrap').addClass("slideDown");
			
			//jQuery.noConflict();
			
		});
		
		</script>

 <header id="topnav">
    
   <nav id="menu">
				<ul class="vertical-nav">
<!-- <li><a href="#"><i class="search"></i>Search</a></li> -->
        <li><a href="candidate_detail_view.htm"><i class="profile"></i>Portfolio</a></li>
        <li><a href="candidate_recommended_jobs.htm"><i class="jobs"></i>Recommended Jobs</a></li>
        <li><a href="candidate_job_activities.htm?selected=applied_jobs"><i class="jobs"></i>Applied Jobs</a></li>
        <li><a href="candidate_job_activities.htm?selected=applied_internships"><i class="jobs"></i>Applied Internships </a></li>
        <li><a href="candidate_job_activities.htm?selected=saved_jobs"><i class="jobs"></i>Saved Jobs</a></li>
        <li><a href="candidate_job_activities.htm?selected=saved_internships"><i class="jobs"></i>Saved Internships</a></li>
       <!--  <li><a href="candidate_view_virtualfairs.htm"><i class="event"></i>Virtual Fairs</a></li> -->
        
  
  </ul>
  </nav>
   
    
    <div class="float_left"><!-- id="navbtn"  -->
       <a href="#menu"><img src="../mobile_html/images/menu.png"></a>
    <!--  <a href="contactUs.htm"><img src="../mobile_html/images/contactus.png"></a>  -->
     </div>
      <div class="float_right">
     <a href="<c:url value="/j_spring_security_logout" />"><img src="../mobile_html/images/logout.png"></a>
      <a class="topsublink"><img src="../mobile_html/images/settings.png"></a> 
     <a href="candidate_advancesearch.htm"><img src="../mobile_html/images/search.png"></a>
      
       <a href="candidate_dashboard.htm"><img src="../mobile_html/images/home.png"></a> 
       </div>
        <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
       <a href="<c:url value="#" />">Mail Settigs</a> 
     </div>
    </header>
    </c:when>
	   
	   
	   <c:when test="${headRole=='CORPORATE'}">
	   
		<script type="text/javascript" src="../mobile_html/js/jquery.mmenu.min.js"></script>
		<script type="text/javascript">
		$(function() {
			$('nav#menu').mmenu();
		});

		$(document).ready(function(){
			//alert('animation');
			$('#mid_wrap').addClass("slideDown");

			//$('.topmenu').css("display","none");
			  $('.topsublink').on('click', function(){
				// alert("topmenu");
				  if($(".topmenu").css("display") == "block"){ 
					  $(".topmenu").slideUp().css("display","none");
					  
				  }
				  
				  else if($(".topmenu").css("display") == "none"){
					  $(".topmenu").slideDown().css("display","block");  
					  
				  }
			  });
			
			//jQuery.noConflict();
			
		});
		</script>

   
        	
        	 
  
 <header id="topnav">
 <nav id="menu">
				<ul class="vertical-nav">
       
        <li><a href="<c:url value="employer_manage_profile_preview.htm" />"><i class="profile"></i>Profile</a></li>
        <li  id="jobslinks"><a href="#jobs"><i class="jobs"></i>Jobs/Internships</a>
        <ul id="jobs">
  <!-- <li class="back"><a href="#"><i class="jobs"></i>Back Menu</a></li> -->
  
        	<li><a href="<c:url value="employer_jobs_internships.htm" />"><i class="jobs"></i>Jobs</a></li>
        	<li><a href="<c:url value="employer_jobs_internships.htm?selected=internships" />"><i class="jobs"></i>Internships</a></li>
        	</ul>
        </li>
        <li id="cjobslinks"><a href="#campusJobs"><i class="jobs"></i>Campus Jobs/Internships</a>
        <ul id="campusJobs">
  
  
        	<li><a href="<c:url value="employer_jobs_internships.htm?selected=campusJobs" />"><i class="jobs"></i>Jobs</a></li>
        	<li><a href="<c:url value="employer_jobs_internships.htm?selected=campusInternships" />"><i class="jobs"></i>Internships</a></li>
        	</ul>
        
        </li>
        <li><a href="<c:url value="employer_saved_searches.htm" />"><i class="saved"></i>Saved Searches</a></li>
        <li><a href="<c:url value="employer_save_search_candidate.htm" />"><i class="saved"></i>Saved Candidates</a></li> 
         <li><a href="<c:url value="employer_manage_receivedinvitations.htm" />"><i class="event"></i>Received Invitations</a></li>
          <li><a href="<c:url value=" employer_manage_scheduledevents.htm" />"><i class="event"></i>Scheduled Events</a></li>
         
  </ul>
  </nav>
    <div class="float_left">
     
    <a href="#menu"><img src="../mobile_html/images/menu.png"></a>
     <!-- <a href="contactUs.htm"><img src="../mobile_html/images/contactus.png"></a>  -->
       </div>
       
    <div class="float_right">
     <a href="employer_dashboard.htm"><img src="../mobile_html/images/search.png"></a> 
       <a href="employer_dashboard.htm"><img src="../mobile_html/images/home.png"></a>  
   
     <a href="#" class="topsublink"><img src="../mobile_html/images/settings.png"></a> 
     <a href="<c:url value="/j_spring_security_logout" />"><img src="../mobile_html/images/logout.png"></a>  
     </div>
     <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
     </div>
    </header>
	   </c:when>
	   
	   
	   <c:when test="${headRole=='UNIVERSITY'}">
	   
		<script type="text/javascript" src="../mobile_html/js/jquery.mmenu.min.js"></script>
		<script type="text/javascript">
		$(function() {
			$('nav#menu').mmenu();
		});
		
		$(document).ready(function(){
			//alert('animation');
			$('#mid_wrap').addClass("slideDown");

			//$('.topmenu').css("display","none");
			  $('.topsublink').on('click', function(){
				// alert("topmenu");
				  if($(".topmenu").css("display") == "block"){ 
					  $(".topmenu").slideUp().css("display","none");
					  
				  }
				  
				  else if($(".topmenu").css("display") == "none"){
					  $(".topmenu").slideDown().css("display","block");  
					  
				  }
			  });
			
			//jQuery.noConflict();
			
		});
		
		</script>
  
    
        	
    <header id="topnav">
   <nav id="menu">
				<ul class="vertical-nav">
       
        <li><a href="university_manage_connections.htm"><i class="event"></i>Manage Connections</a></li>
         <li><a role="menuitem" href="university_manage_receivedinvitations.htm"><i class="event"></i>Received Events</a></li>
           <li  id="jobslinks"><a href="#jobs"><i class="jobs"></i>Jobs/Internships</a> <ul class="submenu" id="jobs">
  
  <li class="menuhead"><a href="#"><i>&nbsp;</i>Jobs/ Internships</a></li>
        	<li><a href="<c:url value="university_posted_jobinternships_listing.htm?selected=jobs" />"><i class="jobs"></i>Jobs</a></li>
        	<li><a href="<c:url value="university_posted_jobinternships_listing.htm?selected=internships" />"><i class="jobs"></i>Internships</a></li>
        	</ul></li>
      </ul>		
    </nav>
    <div class="float_left">
     
 
     <!-- <a href="employer_dashboard.htm"><img src="../mobile_html/images/search.png"></a>  -->
      
    <a href="#menu"><img src="../mobile_html/images/menu.png"></a> 
       </div>
       
    <div class="float_right">
     <a href="<c:url value="/j_spring_security_logout" />"><img src="../mobile_html/images/logout.png"></a>
     <a href="#" class="topsublink"><img src="../mobile_html/images/settings.png"></a> 
         <a href="contactUs.htm"><img src="../mobile_html/images/contactus.png"></a>
           <a href="university_dashboard.htm"><img src="../mobile_html/images/home.png"></a>
     
     </div>
     <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
     </div>
    </header>
	   </c:when>
	   
	   </c:choose>