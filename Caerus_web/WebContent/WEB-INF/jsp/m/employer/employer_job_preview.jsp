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


<script type="text/javascript">
function publishJob()
{ 
	window.location.href='employer_save_job.htm?action=publish';
}
</script>
<script>
function goBack()
{
  window.history.back();
}
</script>

<script>
  function editJob()
  {
	  window.location.href='employer_post_job.htm?editMode=true';
  }  
</script>
<script type="text/javascript">
function saveJob(){

	window.location.href='employer_save_job.htm?action=save';
}
</script>
  
  


</head>
<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">
    
      <section id="inner_container">      
      
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=${jobDetails.emailId}" />
           </div> 
          <div class="details">
            <h1 class="heading"><c:out value="${jobDetails.jobTitle}"></c:out></h1>
            	<div class="jobid">( Job Id <c:out value="${jobDetails.jobId}"/> )</div>
            	<h2> <c:out value="${jobDetails.companyName}"/> </h2>
            <h2 class="subheading"><c:out value="${jobDetails.location}"></c:out>,<c:out value="${jobDetails.zipCode}"></c:out>|  <c:out value="${jobDetails.experienceFrom}"></c:out> - <c:out value="${jobDetails.experienceTo}"> </c:out> | <c:out value="${jobDetails.jobType}"></c:out> </h2>
          </div>
          
        </div>
         <!--13-08-2013-->
        <div class="clear"></div>
       
       <!--13-08-2013-->
          <div class="eventdetail_wrap">
          <div class="eventinfo_wrap">
            <div class="event_innerwrap margin_right1">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
	              <span class="boldtxt">Industry : </span><c:out value="${jobDetails.industry}"/> <br>
	              <span class="boldtxt">Functional Area : </span><c:out value="${jobDetails.functionalArea}"/><br/>
	               <span class="boldtxt">Posted On : </span>
	               <fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="previewOfJobDate"/>
             	   <fmt:formatDate type="date" value="${previewOfJobDate}" pattern="dd-MM-yyyy"/>
              	   <br/>
               </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span class="boldtxt">Primary Skills : </span> <c:out value="${jobDetails.primarySkills}"/> <br>
              <span class="boldtxt">Secondary Skills : </span><c:out value="${jobDetails.secondarySkills}"/><br>
              <span class="boldtxt">Salary Per Week ($) : </span><c:out value="${jobDetails.payPerWeek}"/><br/>
              <span class="boldtxt">GPA Cut Off : </span><c:out value="${jobDetails.gpaCutOffFrom}"/> to   <c:out value="${jobDetails.gpaCutOffTo}"/> <br/>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Job Description </h1>
      <p id="display"><c:out value="${jobDetails.jobDescription}"></c:out></p>
      
      
      
      </div>
      
      
      
       
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn" type="button" class="orangebuttons" value="Edit" tabindex="21" onclick="editJob()">
                <input name="saveBtn" type="button" class="orangebuttons" value="Save" tabindex="21" onclick="saveJob()">
                <input name="publishBtn" type="button" class="orangebuttons" value="Publish" tabindex="22" onclick="publishJob()">
              </div>
              </div>
              
            </form>
          </div>
          
          </section>
   </div>   
      
</div>
</body>
</html>