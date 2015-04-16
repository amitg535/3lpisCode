<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>

	<script type="text/javascript" src="../mobile_html/js/jquery.mmenu.min.js"></script>
		<script type="text/javascript">
		$(function() {
			$('nav#menu').mmenu();
		});

		$(document).ready(function(){
			//alert('animation');
			$('#mid_wrap').addClass("slideDown");
			
			//jQuery.noConflict();

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
			
		});
		</script>	

   
        	
        	 
  
 <header id="topnav">
 <nav id="menu">
				<ul class="vertical-nav">
       
        <li><a href="<c:url value="profile_preview.htm" />"><i class="profile"></i>Profile</a></li>
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
        <li><a href="<c:url value="employer_saved_candidates.htm" />"><i class="saved"></i>Saved Candidates</a></li> 
         <li><a href="<c:url value="employer_campus_connect.htm?selected=receivedInvitations" />"><i class="event"></i>Received Invitations</a></li>
          <li><a href="<c:url value="employer_campus_connect.htm" />"><i class="event"></i>Scheduled Events</a></li>
         
  </ul>
  </nav>
    <div class="float_left">
     
    <a href="#menu"><img src="../mobile_html/images/menu.png"></a>
     <!-- <a href="contactUs.htm"><img src="../mobile_html/images/contactus.png"></a>  -->
       </div>
       
    <div class="float_right">
     <a href="employer_dashboard.htm"><img src="../mobile_html/images/search.png"></a> 
       <a href="employer_dashboard.htm"><img src="../mobile_html/images/home.png"></a>  
   
     <a class="topsublink"><img src="../mobile_html/images/settings.png"></a> 
     <a href="<c:url value="/j_spring_security_logout" />"><img src="../mobile_html/images/logout.png"></a>  
     </div>
     <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
     </div>
    </header>