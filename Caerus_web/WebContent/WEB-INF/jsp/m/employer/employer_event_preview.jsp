<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Employer Event Preview</title>
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
function editJob()
{
	var jobId  = '<%=request.getParameter("jobId") %>';
 	window.location.href='employer_edit_postedjob.htm?jobId='+ jobId;
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
       <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
       			 <img src="view_image.htm?emailId=${eventDetails.emailId}" />
           </div> 
          <div class="details">
           		<h1 class="heading"><span><c:out value="${eventDetails.eventName}"/></span></h1>
            	<h2 class="subheading"> <c:out value="${eventDetails.participatingUniversity}"/> </h2>
          </div>
        </div>
      
        <div class="clear"></div>
        
        <div class ="eventdetail_wrap">
        <div class="eventinfo_wrap">
        <div class="event_innerwrap margin_right1">
            <div class="event_img_wrap"><img src="../mobile_html/images/calendar_icn.png" alt="Calender" /></div>
            <div class="event_content_wrap">
             
            <c:out value="${eventDetails.startDate}" />  to  <c:out value="${eventDetails.endDate}" />  
           	
            <span class="margin10_left margin10_right">|</span> Timing:  <c:out value="${eventDetails.startTime}"></c:out> - <c:out value="${eventDetails.endTime}"></c:out></div>
          </div>
          
          <div class="event_innerwrap">
            <div class="event_img_wrap"><img src="../mobile_html/images/email_icn.png" alt="Download" />
            		
        		
            
            
            </div>
            <%-- <c:forEach   var="empdetails" items="${empdetailpreview}">  --%>
            <div class="event_content_wrap">
            Email Id :  <c:out value="${eventDetails.emailId}" /> 
            <span class="margin10_left margin10_right">|</span> Phone No. : <c:out value="${employerDetails.phoneNumber}"></c:out> </div>
          <%--   </c:forEach>
             --%>
            
            
            
            
          </div>
          
          <!-- <div class="event_innerwrap">
            <div class="event_img_wrap"><img src="../mobile_html/images/download_icn.png" alt="Download Resume" /></div>
            <div class="event_content_wrap">
             </div>
          </div> -->
          
        </div>
        </div>
        
        <div class="clear"></div>
  
        <h1 class="jobdescp_title orange_font"> Event Description :  </h1>
        <p class = "borderbottom">
           <c:out value="${eventDetails.eventDescription}"/>
        </p>
        
        
        <h1 class="jobdescp_title orange_font">Who we are : </h1>
	      <p class = "borderbottom">
		     <c:out value="${employerDetails.companyDesc}" />
	      </p>
      <div class="clear"></div>
        <div class="event_innerwrap">
       <h1 class="jobdescp_title orange_font">Hiring For :   <c:out value="${eventDetails.eligibleBatches}" /></h1>
       <div class="event_content_wrap ">
       <ul>
      	<%-- 	<c:forEach begin="0" end="${eventDetails.multivalues}" var="i">
      		<% String k = pageContext.getAttribute("i").toString(); pageContext.setAttribute("ki", k);%> --%>
      		<li>
                <span><c:out value="${eventDetails.functionalAreas[0]}"/> - <c:out value="${eventDetails.eligibleBatches[0]}"></c:out></span><br/>
                <span>No of Openings: </span> <c:out value="${eventDetails.numberOfHirings[0]}"/><br/>
             <%--  <h3 class="float_right innercount">Salary Offered : <c:out value="${eventDetails.minimumSalaryOffered[0]}"/></h3> --%>
                <span><!-- GPA Cut Off : --> Min. Salary Offered </span><!-- Between  --><c:out value="${eventDetails.minimumSalaryOffered[0]}"/> <%-- to <c:out value="${eventDetails.gpaToMulti[0]}"/> --%><br/>
               	<%-- <span>  Batch Of Passing: </span><c:out value="${eventDetails.batchOfPassingMultiDB[ki]}"></c:out> --%>
              <div class="clear"></div>
            </li>
              
      		<%-- </c:forEach> --%>
      </ul>
      </div>
		</div>      
      </div>
      

        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
            <input name="editBtn" type="button" value="Edit" class="orangebutton1"
             onclick="window.location.href='employer_schedule_event.htm?eventId=<c:out value="${eventDetails.eventId}"/>'" />
            <input name="finishBtn" type="button" value="Finish" class="orangebutton1"  onclick="window.location.href='employer_campus_connect.htm'" />
               
              </div>
              </div>
              
            </form>
          </div>
          </section>
    </div>
</div>

<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>