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
       
        <li><a href="university_manage_connections.htm"><i class="event"></i>Manage Connections</a></li>
        <!--  <li><a role="menuitem" href="university_manage_receivedinvitations.htm"><i class="event"></i>Received Events</a></li> -->
       <li><a role="menuitem" href="university_manage_received_invitations.htm"><i class="event"></i>Received Events</a></li> 
           <li  id="jobslinks"><a href="#jobs"><i class="jobs"></i>Jobs/Internships</a> <ul class="submenu" id="jobs">
  
  <li class="menuhead"><a href="#"><i>&nbsp;</i>Jobs/ Internships</a></li>
        	<%-- <li><a href="<c:url value="university_posted_jobinternships_listing.htm?selected=jobs" />"><i class="jobs"></i>Jobs</a></li>
        	<li><a href="<c:url value="university_posted_jobinternships_listing.htm?selected=internships" />"><i class="jobs"></i>Internships</a></li> --%>
        	<li><a href="<c:url value="university_campus_jobs_internships.htm?selected=jobs" />"><i class="jobs"></i>Jobs</a></li>
        	<li><a href="<c:url value="university_campus_jobs_internships.htm?selected=internships" />"><i class="jobs"></i>Internships</a></li>
        	</ul></li>
      </ul>		
    </nav>
    <div class="float_left">
     
 
     <!-- <a href="employer_dashboard.htm"><img src="../mobile_html/images/search.png"></a>  -->
      
    <a href="#menu"><img src="../mobile_html/images/menu.png"></a> 
       </div>
       
    <div class="float_right">
     <a href="<c:url value="/j_spring_security_logout" />"><img src="../mobile_html/images/logout.png"></a>
     <a class="topsublink"><img src="../mobile_html/images/settings.png"></a> 
         <a href="contact_us.htm"><img src="../mobile_html/images/contactus.png"></a>
           <a href="university_dashboard.htm"><img src="../mobile_html/images/home.png"></a>
     
     </div>
     <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
     </div>
    </header>
     