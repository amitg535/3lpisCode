
  <%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%  			
Authentication auth = SecurityContextHolder.getContext().getAuthentication();
String authority = auth.getAuthorities().toString();
int mid = authority.lastIndexOf("_");
String role = authority.substring(mid+1, authority.length()-1);
pageContext.setAttribute("role", role);
%>
<c:choose>
  <c:when test="${role!='ANONYMOUS'}"> 
 
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
        <li><a href="candidate_job_activities.htm?selected=recommended_jobs"><i class="jobs"></i>Recommended Jobs</a></li>
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
     <a href="candidate_search_jobs_internships.htm"><img src="../mobile_html/images/search.png"></a>
      
       <a href="candidate_dashboard.htm"><img src="../mobile_html/images/home.png"></a> 
       </div>
        <div class="topmenu">
      <a href="<c:url value="user_change_password.htm" />">Change Password</a> 
       <a href="<c:url value="#" />">Mail Settings</a> 
     </div>
    </header>
    </c:when>
    <c:otherwise>
    <header>
    </header>
    </c:otherwise>
    </c:choose>
