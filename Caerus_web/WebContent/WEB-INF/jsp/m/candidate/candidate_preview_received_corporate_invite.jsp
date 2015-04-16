<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<title>Campus Event Preview</title>
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
<script src="../mobile_html/js/prettify.js"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<script src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8" />

<script>
function updateEventCorporate(eventId,status,eventName,firmId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'update_candidate_action_on_corporate_event.htm',						
		cache : false,
		data:
		{
			eventId: eventId,
			studentAcceptStatus: status,
			eventName: eventName,
			firmId: firmId
		},
		
		success : function(data) {

			window.location.reload();
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function undoActionCorporate(eventId,eventName,firmId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'undo_candidate_action_on_corporate_event.htm',						
		cache : false,
		data:
		{	
			eventId: eventId,
			eventName: eventName,
			firmId: firmId
		},

		success : function(data) {

			window.location.reload();
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
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
           
            <c:choose>
											<c:when test="${employerDetails.imageName ne null}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${eventDetails.emailId}" height="32" width="110"></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="/images/Not_available_icon1.png" width="110" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose> 
            
          <div class="details">
           		<h1 class="heading"><span><c:out value="${eventDetails.eventName}"/></span></h1>
            	<h2 class="subheading"> <c:out value="${eventDetails.participatingUniversity}"/> </h2>
            	<h2 class="subheading"><fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/><fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/><fmt:formatDate type="date" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>  To <fmt:formatDate type="date" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>         
            	</h2>
         
          </div>
          
        </div>
         <!--13-08-2013-->
        <div class="clear"></div>
       
       <!--13-08-2013-->
          <div class="eventdetail_wrap">
          <div class="eventinfo_wrap">
        
          </div>
          <div class="clear"></div>
        </div>
        <div class="clear"></div>
         <c:if test="${eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)}">
          
         
      <div>Event was Accepted 
 			<c:if test="${not empty acceptedTime}">on <c:out value="${acceptedTime}"/> </c:if> &nbsp; &nbsp; </div>
				   
      </c:if>
      <c:if test="${eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId)}">
       
      <div>Event was Rejected &nbsp; &nbsp; </div>
				   
      </c:if>
        
        <h1 class="jobdescp_title orange_font">Company Description</h1>
	      <p id="display">
		      <c:out value="${employerDetails.companyDesc}" />
	      </p>
	      
	      <h2 class="accordion-header">Skills On Hire</h2> 
    <div class="accordion-content">
  
    <p><span class="orange_font boldtxt"><c:out value="${eventDetails.functionalAreas[0]}"/></span><br/>
		<span class="orange_font">No of Openings: </span> <c:out value="${eventDetails.numberOfHirings[0]}"/><br/>
		<span class="orange_font">Batch Of Passing: </span> <c:out value="${eventDetails.eligibleBatches[0]}"></c:out><br>
		 <span class="orange_font">Offered Salary: </span> <c:out value="${eventDetails.minimumSalaryOffered[0]}"/>
		<div class="clear"></div>	
		</div>
		
	<h2 class="accordion-header">Preplacement Info</h2> 
    <div class="accordion-content">
     <c:forEach var="fileName" items="${eventDetails.employerRepositoryFileNames}">    
	         <c:if test="${not empty fileName}">
	         <p class="about_text"><c:out value="${fileName}"></c:out></p>
	         <a href="download_file_from_repo.htm?repoFileName=<c:out value="${fileName}"></c:out>&companyName=<c:out value="${employerDetails.companyName}"></c:out>" class="add_repository">View &amp; Download </a> 
	         </c:if>
	         </c:forEach>
    
		<div class="clear"></div>	
		</div>
          
          <h2 class="accordion-header">Video Profile</h2> 
    <div class="accordion-content">
    <video id="home_video1" class="video-js vjs-default-skin" controls width="342" height="200"> 
            <!-- MP4 source must come first for iOS -->
            <source type="video/mp4" src="view_video.htm?emailId=<c:out value="${eventDetails.emailId}" />" />
            <!-- WebM for Firefox 4 and Opera -->
            <source type="video/wmv" src="view_video.htm?emailId=<c:out value="${eventDetails.emailId}" />" />
            <!-- OGG for Firefox 3 -->
            <source type="video/ogg" src="view_video.htm?emailId=<c:out value="${eventDetails.emailId}" />" />
            
            <source type="video/mp3" src="view_video.htm?emailId=<c:out value="${eventDetails.emailId}" />" />
            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
            <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
                  <param name="movie" value="flashmediaelement.swf" />
                  <param name="flashvars" value="controls=true&amp;file=employer_profile_video.htm" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>
          
               <script>var homePlayer=_V_("home_video1");</script> 
    <div class="clear"></div>
    </div>  
        
      </div>
      
      
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
             <!--    <input name="" type="button" class="orangebuttons" value="Edit" tabindex="21" onclick="editJob()">
               <input name="" type="button" class="orangebuttons" value="Back" tabindex="21" onclick="javascript:window.history.back(-1)"> -->
               
               
               <c:if test="${(eventDetails.acceptedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)) &&
         (eventDetails.deniedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId))}">
        
        <input name="" type="button" value="Yes" class="orangebuttons" onclick="updateEventCorporate('${eventDetails.eventId}','accept','${eventDetails.eventName}','${eventDetails.emailId }')"/>
            <input name="" type="button" value="No" class="orangebuttons" onclick="updateEventCorporate('${eventDetails.eventId}','deny')"/>
         </c:if>
               
            <c:if test="${(eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)) || (eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId))}">
            <input name="" type="button" value="Undo" class="orangebuttons" onclick="undoActionCorporate('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.emailId }')"/>
            
            </c:if>
            
               
              </div>
              </div>
              
            </form>
          </div>
          </section>
    </div>
</div>
</body>
</html>