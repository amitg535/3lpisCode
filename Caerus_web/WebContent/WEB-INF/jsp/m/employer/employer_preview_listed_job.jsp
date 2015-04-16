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
<title>Employer Job Preview</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!--19-07-2013 changes-->
<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<link href="../mobile_html/css/royalslider.css" rel="stylesheet">
<link rel="stylesheet" href="../mobile_html/css/uniform.tp.css" type="text/css" />
<script src="../mobile_html/js/jquery-1.7.min.js"></script>
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script>

<!--<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>-->
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script src="../mobile_html/js/jquery.royalslider.min.js"></script>
<script src="../mobile_html/js/prettify.js"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<script src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>


<script>
function goBack()
  {

  window.location.href='employer_jobs_internships.htm';
  //window.history.back();
  }
</script>

<script type="text/javascript">
function editJob()
{
 	var formDetails = document.getElementById('postedJob');
	formDetails.action="employer_edit_posted_job.htm";
	formDetails.submit();
}

function saveJob(){
	var formDetailsSave = document.getElementById('postedJob');
	document.forms[0].action = 'employer_update_posted_job_status.htm?action=save';
	formDetailsSave.submit();
}

function publishJob(){
	var formDetailsPublish = $("#postedJob");
	document.forms[0].action = 'employer_update_posted_job_status.htm?action=publish';
	formDetailsPublish.submit();
}
</script>

</head>
<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">

 <%-- <div id="submenu">
      <ul class="nav nav-pills">
        <li><a href="<c:url value="employer_dashboard.htm" />">Search</a></li>
        <li><a href="#">Saved</a></li>
        <li><a href="#">Events</a></li>
        <li class="active"><a href="#">Profile</a><span class="active_arrow"></span></li>
        <!--    <li class="dropdown"> <a class="dropdown-toggle" id="drop5" role="button" data-toggle="dropdown" href="#">Events <b class="caret"></b></a>
        <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
       </ul>
      </li>-->
      </ul>
    </div> --%>
    
      <section id="inner_container">      
      
         <form:form id="postedJob" modelAttribute="postJob" method="POST" >
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=<c:out value="${jobDetails.emailId }"/>" />
           </div> 
          <div class="details">
          
            <h1 class="heading"><c:out value="${jobDetails.jobTitle}"></c:out> 
            <form:hidden path="jobTitle" value="${jobDetails.jobTitle}" />   <span class="jobId">( Job Id <span id="jobid"><c:out value="${jobDetails.jobId}"/></span> )</span>  <form:hidden path="jobId" value="${jobDetails.jobId}" /></h1>
            	
            	<h2 class="subheading"> <c:out value="${jobDetails.companyName}"/>  <form:hidden path="companyName" value="${jobDetails.companyName}" /></h2>
            <h2 class="subheading"><c:out value="${jobDetails.location}"></c:out> <form:hidden path="location" value="${jobDetails.location}" />
            ,<c:out value="${jobDetails.zipCode}"></c:out>  <form:hidden path="zipCode" value="${jobDetails.zipCode}" />|  <form:hidden path="experienceTo" value="${jobDetails.experienceTo}" />  <form:hidden path="experienceFrom" value="${jobDetails.experienceFrom}" />
            <c:out value="${jobDetails.experienceFrom}"></c:out> - <c:out value="${jobDetails.experienceTo}"> </c:out> | <c:out value="${jobDetails.jobType}"></c:out> <form:hidden path="jobType" value="${jobDetails.jobType}" /> </h2>
          
         
          <h3 class="float_right innercount">
          <c:if test="${jobDetails.responseCount != 0 }">
	          <a href="employer_view_job_responses.htm?jobId=<c:out value="${jobDetails.jobIdAndFirmId}"></c:out>" class="countdetails">
	          <c:out value="${jobDetails.responseCount}"></c:out>
	          </a><br>Candidates Applied</c:if></h3>
         
          </div>
           <form:hidden path="jobIdAndFirmId" value="${jobDetails.jobIdAndFirmId}" />
        </div>
         <!--13-08-2013-->
        <div class="clear"></div>
       
       <!--13-08-2013-->
          <div class="eventdetail_wrap">
          <div class="eventinfo_wrap">
            <div class="event_innerwrap margin_right1">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
	              <span>Industry : </span><c:out value="${jobDetails.industry}"/><form:hidden path="industry" value="${jobDetails.industry}" /> <br>
	              <span>Functional Area : </span><c:out value="${jobDetails.functionalArea}"/> <form:hidden path="functionalArea" value="${jobDetails.functionalArea}" /><br/>
	               <span>Posted On : </span>
	                  <form:hidden path="postedOn" value="${jobDetails.postedOn}" />
	               <fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="previewOfJobDate"/>
              	   <fmt:formatDate type="date" value="${previewOfJobDate}" pattern="dd-MM-yyyy"/>
              	   <br/>
               </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
                <form:hidden path="primarySkills" id="" value="${jobDetails.primarySkills}"/>
              <span>Primary Skills : </span> <c:out value="${jobDetails.primarySkills}" /> <br>
              
                <form:hidden path="secondarySkills" value="${jobDetails.secondarySkills}"/>
              <span>Secondary Skills : </span><c:out value="${jobDetails.secondarySkills}"/><br>
              <span>Salary Per Week ($) : </span>   <form:hidden path="payPerWeek" value="${jobDetails.payPerWeek}"/> <c:out value="${jobDetails.payPerWeek}"/><br/>
              <span>GPA Cut Off : </span><c:out value="${jobDetails.gpaCutOffFrom}"/>	<form:hidden path="gpaCutOffFrom" value="${jobDetails.gpaCutOffFrom}"/>      To : <c:out value="${jobDetails.gpaCutOffTo}"/> <br/>
             <form:hidden path="gpaCutOffTo" value="${jobDetails.gpaCutOffTo}"/> 
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Job Description </h1>
      <p id="display"><c:out value="${jobDetails.jobDescription}"></c:out></p>
         <form:hidden path="jobDescription" value="${jobDetails.jobDescription}" />
      
      <form:hidden path="status" value="${jobDetails.status }"/>
      </div>
      
      
      
       
        <div id="candidate_registration_wrap">
          <div class="par">
              <div class="buttonwrap">
              <c:if test="${! jobStatus.equals('Closed') }">
              		 <c:if test="${! jobDetails.status.equals('Published')}">
	                   	 <input name="saveBtn" type="button" value="Save"  class="orangebuttons"  tabindex="22" onclick="saveJob()">
	                    </c:if> 
	                    <input name="publishBtn" type="button"  class="orangebuttons" value="Publish" tabindex="23" onclick="publishJob()">
	                   <input name="editBtn" type="button" class="orangebuttons" value="Edit" tabindex="24" onclick="editJob()"> 
	         </c:if>          
            </div>  
        </div>
          </div>
        </form:form>  
          </section>
    </div>
</div>

<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>