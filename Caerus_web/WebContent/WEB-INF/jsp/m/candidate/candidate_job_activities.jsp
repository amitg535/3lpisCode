<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Job Activities</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link type="text/css" rel="stylesheet" href="../mobile_html/css/mmenu.css" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<!--<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>-->
<script type="text/javascript" src="../mobile_html/js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../mobile_html/js/uielements/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../mobile_html/js/jquery.mmenu.js"></script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script> 
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
    
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>

 <script type="text/javascript">
$(document).ready(function(){
	$("#appliedJobs").css("display", "none");
	$("#appliedInternships").css("display", "none");
	$("#savedJobs").css("display", "none");
	$("#savedInternships").css("display", "none");
	$("#recommendedJobs").css("display", "none");
	$("#emptyResultSet").css("display", "none");
	
	if("${appliedJobsCount}"!=0){
		$("#appliedJobs").css("display", "block");
	}
	else if("${appliedInternshipsCount}"!=0){
		$("#appliedInternships").css("display", "block");
	}
	else if("${savedJobsCount}"!=0){
		$("#savedJobs").css("display", "block");
	}
	else if("${savedInternshipsCount}"!=0){
		$("#savedInternships").css("display", "block");
	} 
	else if("${recommendedJobsCount}"!=0){
		$("#recommendedJobs").css("display", "block");
	}
	else {
		$("#emptyResultSet").css("display", "block");
	}	
		
   	});
	</script>
</head>

 <body class="student">

  
      <div id="main_wrap">
    <%@ include file="includes/header.jsp"%>	 
				
		<div id="mid_wrap" class="midwrap_toppadding">
			
			<div class="clear"></div>
			
			<section id="inner_container">
			
			<section id ="recommendedJobs">
							<h1 class="page_heading">Recommended Jobs <span class="orange_font">(<c:out value="${recommendedJobsCount}"/>)</span></h1>
							 <c:choose>
    						<c:when test="${recommendedJobsCount==0}">
     						<c:out value="No Records to Display"/>
   							</c:when>
   							<c:otherwise>
							<div class="search_listing_wrap" >
										<ul class="search_listing">	
								<c:forEach items="${recommendedJobs}" var="recommendedJobs">
									<li onclick = "location.href='candidate_preview_listed_job.htm?jobId=<c:out value="${recommendedJobs.jobIdAndFirmId}"/>'"><a href="#">
											 
										<c:choose>
											<c:when test="${not empty recommendedJobs.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${recommendedJobs.emailId}"></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						                
											<h1 class="heading">
												<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${recommendedJobs.jobIdAndFirmId}"/>"><c:out
														value="${recommendedJobs.jobTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${recommendedJobs.companyName}"></c:out>
												,
												<c:out value="${recommendedJobs.location}" />
											</h2>
											<div class="jobtype">
												 
												<c:out value="${recommendedJobs.jobType}"></c:out>
												
											</div>
											

									</a></li>
									</c:forEach>
								</ul>
								</div>
								</c:otherwise>
								</c:choose>
							</section>
			
			
				
							<section id ="appliedJobs">
							<h1 class="page_heading">Job Application Summary <span class="orange_font">(<c:out value="${appliedJobsCount}"/>)</span></h1>
							 <c:choose>
    						<c:when test="${appliedJobsCount==0}">
     						<c:out value="No Records to Display"/>
   							</c:when>
   							<c:otherwise>
							<div class="search_listing_wrap" >
										<ul class="search_listing">	
								<c:forEach items="${appliedJobs}" var="appliedJobs">
									<li onclick = "location.href='candidate_preview_listed_job.htm?jobId=<c:out value="${appliedJobs.jobIdAndFirmId}"/>'"><a href="#">
											 
										<c:choose>
											<c:when test="${not empty appliedJobs.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${appliedJobs.emailId}"></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						                
											<h1 class="heading">
												<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${appliedJobs.jobIdAndFirmId}"/>"><c:out
														value="${appliedJobs.jobTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${appliedJobs.companyName}"></c:out>
												,
												<c:out value="${appliedJobs.location}" />
											</h2>
											<div class="jobtype">
												 
												<c:out value="${appliedJobs.jobType}"></c:out>
												
											</div>

									</a></li>
									</c:forEach>
								</ul>
								</div>
								</c:otherwise>
								</c:choose>
							</section>
							
							<section id ="appliedInternships">
							<h1 class="page_heading">Internship Application Summary <span class="orange_font">(<c:out value="${appliedInternshipsCount}"/>)</span></h1>
							<c:choose>
    						<c:when test="${appliedInternshipsCount==0}">
     						<c:out value="No Records to Display"/>
   							</c:when>
   							<c:otherwise>
							<div class="search_listing_wrap" >
										<ul class="search_listing">	
								<c:forEach items="${appliedInternships}" var="appliedInternships">
									<li onclick = "location.href='candidate_preview_listed_internship.htm?internshipId=<c:out value="${appliedInternships.internshipIdAndFirmId}"/>'"><a href="#">
											
										<c:choose>
											<c:when test="${not empty appliedInternships.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${appliedInternships.emailId}"></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						               
											<h1 class="heading">
												<a href="candidate_preview_listed_internship.htm?internshipId="${appliedInternships.internshipIdAndFirmId}"><c:out
														value="${appliedInternships.internshipTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${appliedInternships.companyName}"></c:out>
												,
												<c:out value="${appliedInternships.location}" />
											</h2>
											<div class="jobtype">
												<c:out value="${appliedInternships.internshipType}" />
												
											</div>

									</a></li>
									</c:forEach>
								</ul>
								</div>
								</c:otherwise>
								</c:choose>
							</section>
							
					        <section id ="savedJobs">
							<h1 class="page_heading">My Saved Jobs <span class="orange_font">(<c:out value="${savedJobsCount}" />)</span></h1>
							<c:choose>
							<c:when test="${savedJobsCount==0}">
								<c:out value="No Records to Display" />
							</c:when>
							<c:otherwise>
							 <div class="search_listing_wrap" >
							 <ul class="search_listing">	
								<c:forEach items="${savedJobs}" var="savedJobs">
									<li onclick = "location.href='candidate_preview_listed_job.htm?jobId=<c:out value="${savedJobs.jobIdAndFirmId}"/>'"><a href="#">
											
										<c:choose>
											<c:when test="${not empty savedJobs.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${savedJobs.emailId}"/></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						                
											<h1 class="heading">
												<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${savedJobs.jobIdAndFirmId}"/>"><c:out
														value="${savedJobs.jobTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${savedJobs.companyName}"></c:out>
												,
												<c:out value="${savedJobs.location}" />
											</h2>
											<div class="jobtype">
												<c:out value="${savedJobs.jobType}" />
												
											</div>

									</a></li>
									</c:forEach>
								</ul>
								</div>
								</c:otherwise>
								</c:choose>
							</section>							
							
							<section id ="savedInternships">
							<h1 class="page_heading">My Saved Internships <span class="orange_font">(<c:out value="${savedInternshipsCount}"/>)</span></h1> 
							<div class="search_listing_wrap" >
							<c:choose>
							<c:when test="${savedInternshipsCount==0}">
								<c:out value="No Records to Display" />
							</c:when>
							<c:otherwise>
							<ul class="search_listing">	
								<c:forEach items="${savedInternships}" var="savedInternships">
									<li onclick = "location.href='candidate_preview_listed_internship.htm?source=saved_internships&internshipId=<c:out value="${savedInternships.internshipIdAndFirmId}"/>'"><a href="#">
											
										<c:choose>
											<c:when test="${not empty savedInternships.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${savedInternships.emailId}"/></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						               
											<h1 class="heading">
												
														<c:out value="${savedInternships.internshipTitle}" ></c:out> 
											</h1>
											<h2 class="subheading">
												<c:out value="${savedInternships.companyName}"></c:out>
												,
												<c:out value="${savedInternships.location}" />
											</h2>
											<div class="jobtype">
												<c:out value="${savedInternships.internshipType}" />
												
												
											</div>

									</a></li>
									</c:forEach>
								</ul>
								</c:otherwise>
								</c:choose>
							</div>
							</section>
							<section id="emptyResultSet">
							<h1 class="page_heading">No Records To Display</h1> 
							</section>
					
							<!-- </div>  -->
					

				<div class="clear"></div>

		
<!-- <div id="lastPostsLoader"> -->

			</section>
		</div>
		   <div id="push"></div>
	</div>
<%--  <%@ include file="includes/footer.jsp"%> --%>
	
</body>
</html>