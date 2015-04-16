<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Jobs and Internships</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	})
    }
	
</script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script> 
<script>
  	$(document).ready(function() {
    	$(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		});
	});
  
	function selectCallback(value, index) {
        alert("SELECTED VALUE: " + value + ", INDEX: " + index);
	}
  
  function toggleEnabled() {
    if ($(".selecter_disabled").is(":disabled")) {
    	$(".selecter_disabled").selecter("enable");
      $(".enable_selecter").hide();
      $(".disable_selecter").show();
    } else {
      $(".selecter_disabled").selecter("disable");
      $(".enable_selecter").show();
      $(".disable_selecter").hide();
    }
    return false;
  }
</script> 
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>


<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">
    <section id="inner_container">
     
   
							<c:if  test="${jobs eq true }">
							 <h1 class="page_heading">View <span class="orange_font">Jobs</span></h1>
							  <div class="search_listing_wrap" >
						
						<div class="float_right"><!-- <a href="employer_posta_job.htm" class="orangebuttons">Post Job</a> -->
						<input type="button" value="Post Jobs" class="orangebuttons" onclick="location.href='employer_post_job.htm'" /></div>
						
						  <div class="clear"></div>
								<ul class="search_listing count">	
						<c:forEach items="${jobDetail}" var="jobList">
						
						<li onclick = "location.href='employer_preview_listed_job.htm?jobId=<c:out value="${jobList.jobIdAndFirmId}"/>'">
						<a href="#">
						                <div class="company_logo">
						                 <c:if test="${jobList.responseCount == 0 }">
												<span class="inactive"><c:out value="${jobList.responseCount}"></c:out></span>
											</c:if>
							                <c:if test="${jobList.responseCount != 0 }">
												<span class="count"><c:out value="${jobList.responseCount}"></c:out></span>
											</c:if>
											<br>Candidate Responses
						                </div>
											<h1 class="heading">
												<a href="employer_preview_listed_job.htm?jobId=<c:out value="${jobList.jobIdAndFirmId}"/>">
												<c:out value="${jobList.jobTitle}"></c:out></a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${companyName}"></c:out>
												,
												<c:out value="${jobList.location}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${jobList.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
													
													
											</div> 
									</a>
								</li>
								
						</c:forEach>
						</ul>
						</div>	
						</c:if>
									
						<c:if test="${internships eq true }">
						<h1 class="page_heading">View <span class="orange_font">Internships</span></h1>
						  <div class="search_listing_wrap" >
						   <div class="float_right"><!-- <a href="employer_posta_internship.htm" class="orangebuttons">Post Internship</a> -->
						   <input type="button" value="Post Internship" class="orangebuttons" onclick="location.href='employer_post_internship.htm'"/>
						   </div>
						   <div class="clear"></div>
						  <ul class="search_listing count">	 
								
							<c:forEach items="${listInternship}" var="internshipList">		
								<li onclick = "location.href='employer_preview_listed_internship.htm?internshipIdAndFirmId=<c:out value="${internshipList.internshipIdAndFirmId}"/>'">
									<a href="#">
									
						                
						                 <div class="company_logo">
						                 <c:if test="${internshipList.responseCount == 0 }">
											<span class="inactive"> <c:out value="${internshipList.responseCount}"></c:out></span>
										</c:if>
						                <c:if test="${internshipList.responseCount != 0 }">
											<span class="count"> <c:out value="${internshipList.responseCount}"></c:out></span>
										</c:if>
										<br>Candidate Responses
						                </div>
						                
											<h1 class="heading">
											<a href="employer_preview_listed_internship.htm?internshipIdAndFirmId=<c:out value="${internshipList.internshipIdAndFirmId}"/>">
												<c:out value="${internshipList.internshipTitle}"></c:out>
											</a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${internshipList.companyName}"></c:out>
												,
												<c:out value="${internshipList.location}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${internshipList.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
													<c:if test="${internshipList.responseCount != 0 }">
														<%-- <span class="postedon">Candidates <c:out value="${internshipList.responseCount}"></c:out></span> --%>
													</c:if>
											</div> 
									</a>
						</li>
						
						</c:forEach>
						</ul>
						</c:if>
									
					
					
					<c:if test="${campusJobs eq true }">
						<h1 class="page_heading">View <span class="orange_font">Campus Jobs</span></h1>
						  <div class="search_listing_wrap" >
						   <div class="float_right">
						   <input type="button" value="Post Campus Jobs" class="orangebuttons" onclick="location.href='employer_post_campus_job.htm'"/>
						   </div>
						   <div class="clear"></div>
						  <ul class="search_listing count">	 
								
							<c:forEach items="${employerJobPostListForUniversity}" var="campusJob">		
								<li onclick = "employer_preview_posted_campus_job.htm?jobId=<c:out value="${campusJob.jobId}"/>_<c:out value="${campusJob.firmId}"/>&universityName=<c:out value="${campusJob.universityName}"/>">
									<a href="#">
									
						                
						                 <div class="company_logo">
						                 <c:if test="${campusJob.responseCount == 0 }">
											<span class="inactive">
											 <c:out value="${campusJob.responseCount}"></c:out>
											 </span>
										</c:if>
						                <c:if test="${campusJob.responseCount != 0 }">
											<span class="count"> 
											<c:out value="${campusJob.responseCount}"></c:out>
											</span>
										</c:if>
										<br>Candidate Responses
						                </div>
						                
											<h1 class="heading">
											<a href="employer_preview_posted_campus_job.htm?jobId=<c:out value="${campusJob.jobId}"/>_<c:out value="${campusJob.firmId}"/>&universityName=<c:out value="${campusJob.universityName}"/>">
												<c:out value="${campusJob.jobTitle}"></c:out>
											</a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${campusJob.universityName}"></c:out>
												,
												<c:out value="${campusJob.postedBy}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
													<c:if test="${campusJob.responseCount != 0 }">
														<%-- <span class="postedon">Candidates <c:out value="${internshipList.responseCount}"></c:out></span> --%>
													</c:if>
											</div> 
									</a>
						</li>
						
						</c:forEach>
						</ul>
				</c:if>
						
						
						<c:if test="${campusInternships eq true }">
						<h1 class="page_heading">View <span class="orange_font">Campus Internships</span></h1>
						  <div class="search_listing_wrap" >
						   <div class="float_right"><!-- <a href="employer_posta_internship.htm" class="orangebuttons">Post Internship</a> -->
						   <input type="button" value="Post Campus Internship" class="orangebuttons" onclick="location.href='employer_post_campus_internship.htm'"/>
						   </div>
						   <div class="clear"></div>
						  <ul class="search_listing count">	 
								
							<c:forEach items="${employerInternshipListForUniversity}" var="campusInternship">		
								<li onclick = "location.href='employer_preview_posted_campus_internship.htm?internshipId=<c:out value="${campusInternship.internshipId}"/>_<c:out value="${campusInternship.firmId}"/>&universityName=<c:out value="${campusInternship.universityName}"/>'">
									<a href="employer_preview_posted_campus_internship.htm?internshipId">
						                 <div class="company_logo">
						                 <c:if test="${campusInternship.responseCount == 0 }">
											<span class="inactive"> <c:out value="${campusInternship.responseCount}"></c:out></span>
										</c:if>
						                <c:if test="${campusInternship.responseCount != 0 }">
											<span class="count"> <c:out value="${campusInternship.responseCount}"></c:out></span>
										</c:if>
										<br>Candidate Responses
						                </div>
						                
											<h1 class="heading">
											<a href="employer_preview_posted_campus_internship.htm?internshipId=<c:out value="${campusInternship.internshipId}"/>_<c:out value="${campusInternship.firmId}"/>&universityName=<c:out value="${campusInternship.universityName}"/>">
												<c:out value="${campusInternship.internshipTitle}"></c:out>
											</a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${campusInternship.universityName}"></c:out>
												,
												<c:out value="${campusInternship.postedBy}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${campusInternship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
													<c:if test="${campusInternship.responseCount != 0 }">
													</c:if>
											</div> 
									</a>
						</li>
						
						</c:forEach>
						</ul>
						</c:if>
		
     
     
    </section>
    
    	</div>
      
</div>
<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>