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
<!-- <link href="../mobile_html/css/royalslider.css" rel="stylesheet">-->
<!-- <script src="../mobile_html/js/jquery-1.7.min.js"></script> -->
<!-- <script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script> -->

<link rel="stylesheet" href="../mobile_html/css/uniform.tp.css" type="text/css" />
<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery.royalslider.min.js"></script> -->
 <script src="../mobile_html/js/prettify.js"></script> 
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<!-- <script src="../mobile_html/js/menu.js"></script> -->
 <script src="../mobile_html/js/jquery.fs.selecter.js"></script>

<script type="text/javascript">
function publishInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_update_internship_status.htm?action=publish';
	formDetails.submit();
}
</script>

<script>
function editInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_post_internship.htm?editMode=true';
	formDetails.submit();
}
</script>
<script>
function saveInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_update_internship_status.htm?action=save';
	formDetails.submit();
}
</script>
 <script type="text/javascript">
function backFunction(){
 history.go(-1);
 return true;
}

</script>  

</head>
<body class="employer">

 <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">

<%--  <div id="submenu">
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
      
      <form:form id="postInternshipDetails" modelAttribute="postInternship" method="POST">
      
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=${internshipDetails.emailId }" />
           </div> 
          <div class="details">
            <h1 class="heading"><c:out value="${internshipDetails.internshipTitle}"></c:out></h1>
            	<div id="jobid">( Internship Id <span id="internshipId"><c:out value="${internshipDetails.internshipId}"/></span> )</div>
            	<h2> <c:out value="${companyName}"/> </h2>
            <h2 class="subheading"><c:out value="${internshipDetails.location}"></c:out>,<c:out value="${internshipDetails.zipCode}"></c:out>|  <c:out value="${internshipDetails.startDate}"></c:out> - <c:out value="${internshipDetails.endDate}"> </c:out> | <c:out value="${internshipDetails.internshipType}"/>  </h2>
          
          <h3 class="float_right innercount">
          <a href="employer_view_internship_responses.htm?internshipIdAndFirmId=<c:out value="${internshipDetails.internshipIdAndFirmId}"></c:out>" class="countdetails"><c:out value="${internshipDetails.responseCount}"></c:out></a>
          <br><span>Candidates Applied</span></h3>
          
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
	               <span class="boldtxt">Posted On</span>
	              <fmt:parseDate value="${internshipDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="internPostedOn"/>
             	  <fmt:formatDate type="date" value="${internPostedOn}" pattern="dd-MM-yyyy"/> 
              	   <br/>
               </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span class="boldtxt">Primary Skills</span>
             
              <c:out value="${internshipDetails.primarySkills}"/>
             <br>
              <span class="boldtxt">Secondary Skills </span>
             
              <c:out value="${internshipDetails.secondarySkills}"/>
             
               <br>
              <span class="boldtxt">Salary Per Hour ($) </span><c:out value="${internshipDetails.payPerWeek}"/><br/>
              <span class="boldtxt">Approximate Hours</span><c:out value="${internshipDetails.approximateHours}"/> <br/>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Internship Description</h1>
      <p id="display"><c:out value="${internshipDetails.internshipDescription}"></c:out></p>
      
      </div>
      
      
      
       
        <div id="candidate_registration_wrap">
        
         <c:if test="${! internshipDetails.status.equals('Closed')}">
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn" type="button" class="orangebuttons" value="Edit" tabindex="21" onclick="editInternship()">
              
              	<c:if test="${! internshipDetails.status.equals('Published')}">
                 <input name="saveBtn" type="button" class="orangebuttons" value="Save" tabindex="22" onclick="saveInternship()">
               </c:if>
                  <input name="publishBtn" type="button" class="orangebuttons" value="Publish" tabindex="23" onclick="publishInternship()" >
                
                 
              </div>
              </div>
        </c:if>      
              
          </div>
        
        
        <form:hidden path="internshipTitle" value="${internshipDetails.internshipTitle}" />
		<form:hidden path="internshipId" value="${internshipDetails.internshipId}"/>
		<form:hidden path="companyName" value="${internshipDetails.companyName}"/>
		<form:hidden path="status" value="${internshipDetails.status}"/> 
		<form:hidden path="location" value="${internshipDetails.location}"/> 
		<form:hidden path="zipCode" value="${internshipDetails.zipCode}"/>
		<form:hidden path="startDate" value="${internshipDetails.startDate}"/> 
		<form:hidden path="endDate" value="${internshipDetails.endDate}"/>
		<form:hidden path="internshipType" value="${internshipDetails.internshipType}"/>
		<form:hidden path="postedOn" value="${internshipDetails.postedOn}"/>
		<form:hidden path="internshipDescription" value="${internshipDetails.internshipDescription}"/>
		<form:hidden id="ps" path="primarySkills" value="${internshipDetails.primarySkills}"/>
		<form:hidden path="secondarySkills" value="${internshipDetails.secondarySkills}"/>
		 <form:hidden path="approximateHours" value="${internshipDetails.approximateHours}"/>
		 <form:hidden path="payPerHour" value="${internshipDetails.payPerHour}"/>
		<form:hidden path="internshipIdAndFirmId" value="${internshipDetails.internshipIdAndFirmId}"/> 
        
        
</form:form>
 
          </section> 
      
</div>
</body>
</html>