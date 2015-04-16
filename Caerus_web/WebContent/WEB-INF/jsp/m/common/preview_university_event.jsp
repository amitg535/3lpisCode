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
<title>University Event Preview</title>
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
function updateEventUniversity(eventId,status,eventName,universityId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'update_candidate_action_on_university_event.htm?eventId='+eventId,						
		cache : false,
		data:
		{
			status: status,
			eventName: eventName,
			universityId: universityId
		},
		
		success : function(data) {
				
			window.location.reload();
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

 function undoActionUniversity(eventId,eventName,universityId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'undo_candidate_action_on_university_event.htm?eventId='+eventId,						
		cache : false,
		data:
		{
			eventName: eventName,
			universityId: universityId
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
        <div class="jobdetails" style="padding-left: 0px;">
           
           		<h1 class="heading"><span><c:out value="${eventDetails.eventName}"/></span></h1>
            	<h2 class="subheading"><fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/><fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/><fmt:formatDate type="date" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>  To <fmt:formatDate type="date" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>         
            	<c:out value="${eventDetails.startTime}"></c:out> - <c:out value="${eventDetails.endTime}"></c:out>
            	<c:out value="${eventDetails.venue}" />
            	</h2>
         
          
        </div>
        <div class="clear"></div>
       
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
        
        <h2 class="accordion-header">University Details</h2>
	        <div class="accordion-content">
		     <p><span class="orange_font boldtxt"><c:out value="${universityDetails.universityName}" /></span><br/>
		<span class="orange_font">Address: </span> <c:out value="${universityDetails.universityAddress}"/><br/>
		<span class="orange_font">Contact Person: </span> <c:out value="${universityDetails.contactPersonEmailId}"></c:out><br>
		 <span class="orange_font">Phone No: </span> <c:out value="${universityDetails.phoneNumber}"/>
		<div class="clear"></div>
	      </div>
	      
	      <h2 class="accordion-header"><c:out value="${eventDetails.eventType}"/> Overview</h2> 
    <div class="accordion-content">
  <c:choose>
        <c:when test="${eventDetails.eventType == 'Seminar'}">
         <span class="orange_font">Speaker's Name: </span><c:out value="${eventDetails.speakerName}"/>
        <p>
        <c:choose>
       	<c:when test="${not empty eventDetails.topic}">
        <span class="orange_font"><c:out value="${eventDetails.topic}"/></span>
        </c:when>
        <c:otherwise>
        <span class="orange_font">No Topic Available</span>
        </c:otherwise>
        </c:choose>
        </p>
        </c:when>
        <c:otherwise>
        <p> 
        <c:choose>
       	<c:when test="${not empty eventDetails.description}">
       <span class="orange_font"> <c:out value="${eventDetails.description}"/></span>
        </c:when>
        <c:otherwise>
        <span class="orange_font">No Description Available</span>
        </c:otherwise>
        </c:choose>
        </p>
        
        </c:otherwise>
        </c:choose>
 	
		</div>
		
		<c:if test="${not empty attendingCorporates}">
	<h2 class="accordion-header">Attending Companies</h2> 
    <div class="accordion-content">
    
         <div class="doubledashed_border basic_info">
         
	    	<h2 class="resume_title"> Companies Attending the Event </h2>
		    <ul id="partnersiteslogos">
		    <c:forEach items="${attendingCorporates}" var="attendingCorporates">
		    <li style="width:120px;"><img src="view_image.htm?emailId=<c:out value="${attendingCorporates.firmId}"/>" alt="" title="${attendingCorporates.inviteCompanyName}"></li>
		    </c:forEach>
		    </ul>
		  
   		 </div>
      <div class="clear"></div>
     
		</div>
           </c:if>
        
      </div>
      
      
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
               <c:if test="${(eventDetails.acceptedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,emailId)) &&
         (eventDetails.deniedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.deniedByStudentsList,emailId))}">
        
        <input name="" type="button" value="Yes" class="orangebuttons" onclick="updateEventUniversity('${eventDetails.eventId}','accept','${eventDetails.eventName}','${eventDetails.universityId }')"/>
            <input name="" type="button" value="No" class="orangebuttons" onclick="updateEventUniversity('${eventDetails.eventId}','deny')"/>
         </c:if>
               
            <c:if test="${(eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,emailId)) || (eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,emailId))}">
            <input name="" type="button" value="Undo" class="orangebuttons" onclick="undoActionUniversity('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.universityId }')"/>
            
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