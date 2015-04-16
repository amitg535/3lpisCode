<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>3Lpis - Jobs/Internships</title>
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
<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="employer">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>
  <div id="mid_wrap" class="midwrap_toppadding">
    
    <div class="clear"></div>
    <section id="inner_container">
    <c:if  test="${jobs eq true }">
							 <h1 class="page_heading">View <span class="orange_font">Jobs</span></h1>
							  <div class="search_listing_wrap" >
						
						  <div class="clear"></div>
								<ul class="search_listing">	
						<c:forEach items="${employerJobListForUniversity}" var="employerCampusJobListVar">
						
						<%-- <li onclick = "location.href='university_job_posted_list_preview.htm?jobId=<c:out value="${employerCampusJobListVar.jobId}" />_<c:out value="${employerCampusJobListVar.firmId}"/>&universityName=<c:out value="${employerCampusJobListVar.universityName}"/>'"> --%>
						<li onclick = "location.href='campus_job_preview.htm?jobId=<c:out value="${employerCampusJobListVar.jobId}" />_<c:out value="${employerCampusJobListVar.firmId}"/>&universityName=<c:out value="${employerCampusJobListVar.universityName}"/>'">
						<a href="#">
										
						                <div class="company_logo" style="height:130px; width:100px;">
						                 <c:if test="${fn:length(employerCampusJobListVar.campusJobAppliedStudents) == 0 }">
												<span class="inactive"><c:out value="${fn:length(employerCampusJobListVar.campusJobAppliedStudents)}"></c:out></span>
											</c:if>
							                <c:if test="${fn:length(employerCampusJobListVar.campusJobAppliedStudents) != 0 }">
												<span class="count"><c:out value="${fn:length(employerCampusJobListVar.campusJobAppliedStudents)}"></c:out></span>
											</c:if>
											<br>Candidate Responses
						                </div>
											<h1 class="heading">
												<a href="campus_job_preview.htm?jobId=<c:out value="${employerCampusJobListVar.jobId}" />_<c:out value="${employerCampusJobListVar.firmId}"/>&universityName=<c:out value="${employerCampusJobListVar.universityName}"/>"><c:out value="${employerCampusJobListVar.jobTitle}" /></a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${employerCampusJobListVar.firmName}"></c:out>
												,
												<c:out value="${employerCampusJobListVar.jobLocation}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${employerCampusJobListVar.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span><br>
												Status- <c:out value="${employerCampusJobListVar.status}"></c:out>
													
													
											</div> 
									</a>
								</li>
								
						</c:forEach>
						</ul>
						</div>	
						</c:if>
     
     			 <c:if  test="${internships eq true }">
							 <h1 class="page_heading">View <span class="orange_font">Internships</span></h1>
							  <div class="search_listing_wrap" >
						
						  <div class="clear"></div>
								<ul class="search_listing">	
						<c:forEach items="${employerInternshipListForUniversity}" var="employerInternshipListForUniversity">
						
					<%-- 	<li onclick = "location.href='university_internship_posted_list_preview.htm?internshipId=<c:out value="${employerInternshipListForUniversity.internshipId}" />_<c:out value="${employerInternshipListForUniversity.firmId}"/>&universityName=<c:out value="${employerInternshipListForUniversity.universityName}"/>'"> --%>
						<li onclick = "location.href='campus_internship_preview.htm?internshipId=<c:out value="${employerInternshipListForUniversity.internshipId}" />_<c:out value="${employerInternshipListForUniversity.firmId}"/>&universityName=<c:out value="${employerInternshipListForUniversity.universityName}"/>'"> 
						<a href="#">
										
						                <div class="company_logo" style="height:130px; width:100px;">
						                 <c:if test="${fn:length(employerInternshipListForUniversity.campusInternshipAppliedStudents) == 0 }">
												<span class="inactive"><c:out value="${fn:length(employerInternshipListForUniversity.campusInternshipAppliedStudents)}"></c:out></span>
											</c:if>
							                <c:if test="${fn:length(employerInternshipListForUniversity.campusInternshipAppliedStudents) != 0 }">
												<span class="count"><c:out value="${fn:length(employerInternshipListForUniversity.campusInternshipAppliedStudents)}"></c:out></span>
											</c:if>
											<br>Candidate Responses
						                </div>
											<h1 class="heading">
												<a href="campus_internship_preview.htm?internshipId=<c:out value="${employerInternshipListForUniversity.internshipId}" />_<c:out value="${employerInternshipListForUniversity.firmId}"/>&universityName=<c:out value="${employerInternshipListForUniversity.universityName}"/>"><c:out value="${employerInternshipListForUniversity.internshipTitle}" /></a>
											</h1>
											 <h2 class="subheading">
												<c:out value="${employerInternshipListForUniversity.postedBy}"></c:out>
												,
												<c:out value="${employerInternshipListForUniversity.internshipLocation}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">Posted on 
												<fmt:parseDate value="${employerInternshipListForUniversity.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span><br>
													Status- <c:out value="${employerInternshipListForUniversity.status}"></c:out>
													
											</div> 
									</a>
								</li>
								
						</c:forEach>
						</ul>
						</div>	
						</c:if>
      
    </section>
  </div>
  <div id="push"></div>
</div>
 <%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>