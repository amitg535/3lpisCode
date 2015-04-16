<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	function goBack()
	{
		window.history.back();
	}

	function saveCampusJob(){
		var formDetailsSave = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_update_campus_job_status.htm?action=save';
		formDetailsSave.submit();
	}
	
	function publishCampusJob(){
		var formDetailsPublish = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_update_campus_job_status.htm?action=publish';
		formDetailsPublish.submit();
	}
	
	function editCampusJob(){
		var formDetailsPublish = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_post_campus_job.htm?editMode=true';
		formDetailsPublish.submit();
	}
	
</script> 


</head>
<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">
    
      <section id="inner_container">      
       <form:form modelAttribute="campusJob" id="postCampusJob">
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=${campusJob.emailId }" />
           </div> 
          <div class="details">
            <h1 class="heading"> <c:out value="${campusJob.jobTitle}"/> <input type="hidden" name="jobTitle" value="${campusJob.jobTitle}"/> <span class="jobId">( Job Id <span id="jobid"><c:out value="${campusJob.jobId}"/>  <input type="hidden" name="jobId" value="${campusJob.jobId}"/></span> )</span></h1>
            	
            	<h2 class="subheading"><%-- <a href="view_company_profile.htm?companyId=<c:out value="${firmId}"></c:out>"> --%><c:out value="${firmNameAttr}"/></h2>
            <h2 class="subheading"><c:out value="${campusJob.location}"/> <input type="hidden" name="location" value="${campusJob.location}"/>,<c:out value="${campusJob.zipCode}"/> <form:hidden path="zipCode" value="${campusJob.zipCode }"/>|  <c:out value="${campusJob.experienceFrom}"/> - <c:out value="${campusJob.experienceTo}"/>  |  <input type="hidden" name="jobType" value="${campusJob.jobType}"/> </h2>
         
          <h3 class="float_right innercount">
          <c:if test="${fn:length(campusJob.campusJobAppliedStudents) != 0 }">
	          <a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}" />&universityName=<c:out value="${campusJob.universityName }"/>" class="countdetails" style="margin-top: -84px;">
	          <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out>
	          </a><br>Candidates Applied</c:if></h3>
         
          </div>
        
          <input type="hidden" name="experienceFrom" value="${campusJob.experienceFrom}"/> 
          <input type="hidden" name="experienceTo" value="${campusJob.experienceTo}"/>
          
        </div>
         <!--13-08-2013-->
        <div class="clear"></div>
       
       <!--13-08-2013-->
          <div class="eventdetail_wrap">
          <div class="eventinfo_wrap">
            <div class="event_innerwrap margin_right1">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
	              <span>Industry- </span><c:out value="${campusJob.industry}"/> <input type="hidden" name="industry" value="${campusJob.industry}"/> <br>
	              <span>Functional Area- </span><c:out value="${campusJob.functionalArea}"/> <input type="hidden" name="functionalArea" value="${campusJob.functionalArea}"/><br/>
	               <span>Posted On: </span>
              	   <c:out value="${campusJob.postedOn}"/> <input type="hidden" name="postedOn" value="${campusJob.postedOn}"/>
              	   <br/>
               </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span> Universities Invited- </span>		
        	<c:out value="${campusJob.campusJobRecipients}"/>
           <input type="hidden" name="campusJobRecipients" value="${campusJob.campusJobRecipients}"/> 
          <br>
              <span>Primary Skills- </span>   <input type="hidden" name="primarySkills" value="${campusJob.primarySkills}"/> 
			<c:out value="${campusJob.primarySkills.toString().replace('[', '').replace(']', '')}"></c:out> <br>
              <span>Secondary Skills- </span>  <input type="hidden" name="secondarySkills" value="${campusJob.secondarySkills}"/> 
          <c:out value="${campusJob.secondarySkills.toString().replace('[', '').replace(']', '')}"></c:out> <br>
              <span>Salary Per Week ($)- </span><c:out value="${campusJob.payPerWeek}"/>
           <input type="hidden" name="payPerWeek" value="${campusJob.payPerWeek}"/><br/>
              <span>GPA Cut Off :</span> <c:out value="${campusJob.gpaCutOffFrom}" /> to <c:out value="${campusJob.gpaCutOffTo}"/>
           <input type="hidden" name="gpaCutOffFrom" value="${campusJob.gpaCutOffFrom}"/> <input type="hidden" name="gpaCutOffTo" value="${campusJob.gpaCutOffTo}"/> <br/>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Job Description</h1>
      <p id="display"><c:out value="${campusJob.jobDescription}"/> <input type="hidden" name="jobDescription" value="${campusJob.jobDescription}"/></p>
      
      </div>
       
        <div id="candidate_registration_wrap">
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn" type="button" class="orangebuttons" value="Edit" tabindex="1" onclick="editCampusJob()">
                <input name="saveBtn" type="button" class="orangebuttons" value="Save" tabindex="2" onclick="saveCampusJob()">
                <input name="publishJob" type="button" class="orangebuttons" value="Publish" tabindex="3" onclick="publishCampusJob()">
               
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