<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy.Me - Campus Events</title>
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
      <h1 class="page_heading">Upcoming <span class="orange_font">Events (${count})</span></h1>
      
      
      <div class="search_listing_wrap">
       <c:choose>
       <c:when test="${empty allEventsList}">
       	<div><c:out value="NO RESULTS FOUND"></c:out></div>
       </c:when>
       <c:otherwise>
	        <ul class="event_listing">
	         <c:forEach items="${allEventsList}" var="upcomingEvents"> 
	         <c:choose>
                <c:when test="${upcomingEvents.universityFlag eq false}">
	          <li onclick="location.href='candidate_preview_received_corporate_invite.htm?event_id=<c:out value="${upcomingEvents.eventId}"/>'"> <a href="#">
	         
	          <h1 class="heading"><c:out value="${upcomingEvents.eventName}"/></h1>
	          <div>Event Type: Job Fair</div>
	          <p>
	           <c:choose>
                	<c:when test="${upcomingEvents.differenceInDays ne 0}">
                	(<c:out value="${upcomingEvents.differenceInDays}" /> Days To Go)
                	</c:when>
                	<c:otherwise>
                (Ongoing Event)   	
                	</c:otherwise>
                	</c:choose>
	         </p>
	            <h1 class="heading"><c:out value="${upcomingEvents.companyName}"/></h1>
	            <ul class="contactdetails_wrap">
	              <li><img src="../mobile_html/images/calendar_icn.png" alt="Calendar">
	              <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                    <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
	            
	              <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd-MM-yyyy"/>  To <fmt:formatDate type="date" value="${formatedEndDate}" pattern="dd-MM-yyyy"/> </li>
	              
	            </ul>
	            <ul class="contactdetails_wrap">
	              <li>
	             <c:out value="${upcomingEvents.startTime}" /> To <c:out value="${upcomingEvents.endTime}" /> 
	              </li>
	              
	            </ul>
	            <div class="clear"></div>
	             </a>
	          </li>
	          </c:when>
	          
	          <c:otherwise>
	          <li onclick="location.href='preview_university_event.htm?eventId=${upcomingEvents.eventId}'"> <a href="#">
	         
	          <h1 class="heading"><c:out value="${upcomingEvents.eventName}"/></h1>
	          <div>Event Type: <c:out value="${upcomingEvents.eventType}"/></div>
	          <p>
	           <c:choose>
                	<c:when test="${upcomingEvents.differenceInDays ne 0}">
                	(<c:out value="${upcomingEvents.differenceInDays}" /> Days To Go)
                	</c:when>
                	<c:otherwise>
                (Ongoing Event)   	
                	</c:otherwise>
                	</c:choose>
	         </p>
	            
	            <ul class="contactdetails_wrap">
	              <li><img src="../mobile_html/images/calendar_icn.png" alt="Calendar">
	              <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                    <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
	            
	              <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd-MM-yyyy"/>  To <fmt:formatDate type="date" value="${formatedEndDate}" pattern="dd-MM-yyyy"/> </li>
	              
	            </ul>
	            <ul class="contactdetails_wrap">
	              <li>
	             <c:out value="${upcomingEvents.startTime}" /> To <c:out value="${upcomingEvents.endTime}" /> 
	              </li>
	              
	            </ul>
	            <div class="clear"></div>
	             </a>
	          </li>
	          </c:otherwise>
	          </c:choose>
	         </c:forEach>
	        </ul>
	        
        <div class="clear"></div>
        </c:otherwise>
        </c:choose>
      </div>
    </section>
  </div>
  <div id="push"></div>
</div>
</body>
</html>