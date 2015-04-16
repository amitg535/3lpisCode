<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Dashboard</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/dashboard.css">
<!-- <link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" /> -->
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->


<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>

 <script type="text/javascript" src="../mobile_html/js/jquery.validate.min.js"></script>
 
 <script type="text/javascript">
 $(document).ready(function(){
	$('.search a').click(function(){
		$('.search div').slideToggle();
		});
 });
</script>

<script type ="text/javascript">
$(function(){
    $("#advancedSearch").submit(function(){
        var valid=0;
        
        $(this).find('input[type=text]').each(function(){
            if($(this).val() != "") valid+=1;
        });
        if(valid){
           return true;
        }
        else {
           
            $("#searchErrorLabel").html("");
            $("#searchErrorLabel").html("<label class='error_message'>Enter at least one search parameter!</label>");
            
            return false;
        }
    });
});
</script>

</head>

      <body class="dashboard">
      
      <div id="main_wrap">
      
      <div class="profile-details">
      	<div class="personal-details">
      		<!-- <img src="../../mobile_html/images/profile_pic.png"/> -->
      		<c:set var="photoName" value="${studentProfile.photoName}"/>
        	<c:choose>
                      <c:when test="${photoName == null}">
                       <img src="../mobile_html/images/blankimage.png" alt="" height = "123" width="127">   
                      </c:when>
                      <c:otherwise>
                       <img src="view_image.htm?emailId=${studentProfile.emailID}" height = "123" width="127">                 
                      </c:otherwise>
           </c:choose>
      		<div class="sub-details">
      			Welcome,
      			<h1><c:out value="${studentProfile.firstName}" /> <c:out value="${studentProfile.lastName}" /></h1>
      			<p><c:out value="${studentProfile.gender}"></c:out>
      			
      			</p>
      		</div>
      	</div>
      	<c:set var="newMessageCount" value= "${sessionScope.newMessageCount}" />
     	 <div class="messages">
     	 
        <c:choose>
        <c:when test="${newMessageCount != 0}">
        
			<c:choose>
			<c:when test="${newMessageCount == 1}">
			<a href="#">${newMessageCount} MESSAGE</a>
			</c:when>
			<c:otherwise>
			<a href="#">${newMessageCount} MESSAGES</a>
			</c:otherwise>
			</c:choose>  
		      
   		</c:when>
   		<c:otherwise>
   		<a href="#">0 MESSAGES</a>
   		</c:otherwise>
        </c:choose>       
   
      		
      	</div>
      </div>
     <div class="navigation">
     	<ul>
     	<li><a href="candidate_detail_view.htm">Portfolio</a></li>
     	<li><a href="candidate_job_activities.htm?selected=applied_jobs">Applied Jobs</a></li>
     	<li><a href="candidate_viewed_by_companies_thin_client.htm">Profile Views</a></li>
     	<li><a href="candidate_job_activities.htm?selected=saved_jobs">Saved Jobs</a></li>
     	</ul>
     	<div class="search"><a href="#"><img src="../../mobile_html/images/search_icn_0.png"/></a>
     	
     	 <form action="candidate_search_jobs_internships.htm" method="post" class="stdform" id ="advancedSearch" >
     	<div><input name="keyword" type="text" placeholder="Search jobs in your area" id="keyword" style="width:84%;"/> <input name="" type="submit" value="Search" class="orangebuttons">
     	<span id = "searchErrorLabel"></span>
     	</div>
     	   <input type="hidden" name="searchCriteria" value="jobs">
     	</form>
     	
     	</div>
     </div> 
     <div class="content">
     <div class="border-bottom">
     	<div class="google-map"><img src="../../mobile_html/images/map.png"/></div>
     		<div class="jobs-skills">
     			<h1>Jobs Matching Your Skills</h1>
     			<ul>
		     	<li><a href="#">Java <span>45</span></a></li>
		     	<li><a href="#">SQL <span>45</span></a></li>
		     	<li><a href="#">Cassandra <span>45</span></a></li>
		     	<li><a href="#">Spring <span>45</span></a></li>
		     	</ul>
     		</div>
     		
     </div>
     <div class="job-details">
     <ul>
		     	<li class="green"><a href="candidate_job_activities.htm?selected=recommended_jobs"><h4>recommended jobs</h4> <span>
		     	<c:choose>
		     	<c:when test="${not empty countRecommendedJobs}">
       			<c:out value="${countRecommendedJobs}"/>
       			</c:when>
         		<c:otherwise>0</c:otherwise>
        		</c:choose></span></a></li>
		     	<li class="red"><a href="candidate_broadcasted_jobs.htm"><h4>campus jobs</h4> <span>
		     	<c:set var="broadcastedCount" value="0" scope="page"/>
        	<c:forEach items="${employerJobListForUniversity}" var="employerJobListForUniversity">
            <c:if test="${employerJobListForUniversity.status=='Broadcasted'}">
            <c:set var="broadcastedCount" value="${broadcastedCount + 1}" scope="page"/>
            </c:if>
            </c:forEach>
            <c:out value="${broadcastedCount}"/>
		     	</span></a></li>
		     	<li class="yellow"><a href="candidate_broadcasted_corporate_invites.htm"><h4>campus events</h4> <span><c:out value="${upcomingEventsCount}"/></span></a></li>
		     	<li class="blue"><a href="candidate_broadcasted_internships.htm"><h4>Campus Internships</h4> <span>
		     	<c:set var="broadcastedInternshipCount" value="0" scope="page"/>
        	<c:forEach items="${campusInternshipList}" var="campusInternshipList">
            <c:if test="${campusInternshipList.status=='Broadcasted'}">
            <c:set var="broadcastedInternshipCount" value="${broadcastedInternshipCount + 1}" scope="page"/>
            </c:if>
            </c:forEach>
            <c:out value="${broadcastedInternshipCount}"/></span></a></li>
		     	</ul>
     </div>
     </div> 
      </div>

</body>
</html>