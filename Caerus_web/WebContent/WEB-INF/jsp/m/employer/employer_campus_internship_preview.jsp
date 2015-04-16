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
<title>Employer Internship Preview</title>
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
	 
function editCampusInternship()
{
		  var formDetailsPublish = document.getElementById('postInternshipForm');
		  document.forms[0].action = 'employer_post_campus_internship.htm?editMode=true';
		  formDetailsPublish.submit();
}
function saveCampusInternship()
{
		  var formDetailsPublish = document.getElementById('postInternshipForm');
		  document.forms[0].action = 'employer_update_campus_internship_status.htm?action=save';
		  formDetailsPublish.submit();
}
function publishCampusInternship()
{
	  var formDetailsPublish = document.getElementById('postInternshipForm');
	  document.forms[0].action = 'employer_update_campus_internship_status.htm?action=publish';
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
      
      <form:form class="stdform" action="employer_post_campus_internship.htm"  method="post" modelAttribute="campusInternshipCommand"  id="postInternshipForm" >
         <input type="hidden" name="internshipTitle" value="${campusInternshipCommand.internshipTitle}"/> 
		 <input type="hidden" name="internshipId" value="${campusInternshipCommand.internshipId}"/>
		 <input type="hidden" name="companyName" value="${campusInternshipCommand.companyName}"/>
		 <input type="hidden" name="location" value="${campusInternshipCommand.location}"/>
		 <input type="hidden" name="zipCode" value="${campusInternshipCommand.zipCode}"/>
		 <input type="hidden" name="startDate" value="${campusInternshipCommand.startDate}"/>
         <input type="hidden" name="endDate" value="${campusInternshipCommand.endDate}"/> 
		 <input type="hidden" name="internshipType" value="${campusInternshipCommand.internshipType}"/>
		  <input type="hidden" name="postedOn" value="${campusInternshipCommand.postedOn}"/>
		 <input type="hidden" name="internshipDescription" value="${campusInternshipCommand.internshipDescription}"/>
		<input type="hidden" name="campusJobRecipients" value="${campusInternshipCommand.campusJobRecipients}"/>
		  <input type="hidden" name="primarySkills" value="${campusInternshipCommand.primarySkills}"/>
          <input type="hidden" name="secondarySkills" value="${campusInternshipCommand.secondarySkills}"/>
		<input type="hidden" name="approximateHours" value="${campusInternshipCommand.approximateHours}"/>
		 <input type="hidden" name="numberOfVacancy" value="${campusInternshipCommand.numberOfVacancy}"/>
		  <input type="hidden" name="payPerHour" value="${campusInternshipCommand.payPerHour}"/>
      </form:form>
      
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=<c:out value="${campusInternshipCommand.emailId }"/>" />
           </div> 
          <div class="details">
            <h1 class="heading"><c:out value="${campusInternshipCommand.internshipTitle}"></c:out> <span class="jobId">( Internship Id <span id="jobid"><c:out value="${campusInternshipCommand.internshipId}"/></span> )</span></h1>
            	<input type="hidden" name="internshipIdAndFirmId" value="${campusInternshipCommand.internshipIdAndFirmId}"/> 
            	<%-- <input type="hidden" id="universityName" value="${internshipDetails.universityName}"> --%>
            	<h2 class="subheading"><a href="profile_preview.htm?companyName=<c:out value="${internshipDetails.companyName}"></c:out>"><c:out value="${campusInternshipCommand.companyName}"/> </a></h2>
            <h2 class="subheading"><c:out value="${campusInternshipCommand.location}"></c:out>,<c:out value="${campusInternshipCommand.zipCode}"></c:out>| <c:out value="${ campusInternshipCommand.startDate}"/> To  <c:out value="${ campusInternshipCommand.endDate}"/> | <c:out value="${campusInternshipCommand.internshipType}"></c:out> </h2>
         
           <c:if test="${fn:length(campusInternshipCommand.campusInternshipAppliedStudents) != 0 }">
          <h3 class="float_right"><a href="view_campus_internship_responses.htm?internshipId=<c:out value="${campusInternshipCommand.internshipIdAndFirmId}"></c:out>&universityName=<c:out value="${campusInternshipCommand.universityName}"/>" class="countdetails">
          <c:out value="${fn:length(campusInternshipCommand.campusInternshipAppliedStudents)}"></c:out></a><br>Candidates Applied </h3></c:if> 
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
	              <span>No of openings- </span><c:out value="${campusInternshipCommand.numberOfVacancy}"/> <br>
	              <span>Approximate Hours- </span><c:out value="${campusInternshipCommand.approximateHours}"/><br/>
	               <span>Posted On: </span>
	                <%-- <fmt:parseDate value="${dateP}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="jobpreviewPostedOn"/>
              <fmt:formatDate type="date" value="${jobpreviewPostedOn}" pattern="dd-MM-yyyy"/> --%>
	               <fmt:parseDate value="${campusInternshipCommand.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="previewPostedOn"/>
               <fmt:formatDate type="date" value="${previewPostedOn}" pattern="dd-MM-yyyy"/> 
               <%-- <c:out value="${previewPostedOn}"></c:out> --%>
              	   <br/>
              	   <span>Universities Invited- </span><c:out value="${campusInternshipCommand.campusJobRecipients}"></c:out>
               </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span>Primary Skills- </span> <c:out value="${campusInternshipCommand.primarySkills}"/> <br>
              <span>Secondary Skills- </span><c:out value="${campusInternshipCommand.secondarySkills}"/><br>
              <span>Salary Per Hour ($)- </span><c:out value="${campusInternshipCommand.payPerHour}"/><br/>
              <br/>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Internship Description</h1>
      <p id="display"><c:out value="${campusInternshipCommand.internshipDescription}"></c:out></p>
      
      
      
      </div>
      
      
      
       
        <div id="candidate_registration_wrap">
          <div class="par">
                <div class="buttonwrap">
	                <input name="editBtn"  type="button" value="Edit" class="orangebuttons" tabindex="21" onclick="editCampusInternship()" >
	                <input name="saveBtn"  type="button" value="Save"    class="orangebuttons"  tabindex="22" onclick="saveCampusInternship()" >
	                <input name="publishBtn"  type="button" value="Publish"  class="orangebuttons" tabindex="23" onclick="publishCampusInternship()" >
              </div>
              </div>
          </div>
          
          </section>
    </div>
</div>

<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>