<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Received Invites</title>
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
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>

<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);

		var text = $("#about").val();
		text = text.replace(/\n\r?/g, '<br />');
		$("#display").html(text);
		
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

<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="university">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>	
  <div id="mid_wrap" class="midwrap_toppadding">
    <div class="clear"></div>
    
     <section id="inner_container">
	      <h1 class="page_heading"><span class="orange_font">Received Event Invitations</span></h1>
   <c:choose>
   	<c:when test="${eventCount == 0}">
   		<div class="margin20_top margin20_bottom">No Records to Display</div>
   	</c:when>
   	<c:otherwise>
	      <div class="search_listing_wrap">
	        <ul class="event_listing">
	        <c:forEach items="${eventList}" var="eventList">
	          <%-- <li> <a href="university_preview_received_corporate_invite.htm?event_id=<c:out value="${eventList.eventId}"/>"> --%>
	          <li> <a href="university_preview_corporate_invitation.htm?eventId=<c:out value="${eventList.eventId}"/>">
	            <h1 class="heading"><c:out value="${eventList.eventName}"/></h1>
	            <h2 class="subheading">by <c:out value="${eventList.companyName}"/> <!-- | <span class="green_font font_italic boldtxt">Semiar</span> --></h2>
	            <ul class="contactdetails_wrap">
	              <li><img src="../mobile_html/images/calendar_icn.png" alt="Calendar">
	              <fmt:parseDate value="${eventList.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="startDate"/>
	              <fmt:parseDate value="${eventList.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>
	              <fmt:formatDate type="date" value="${startDate}" pattern="dd-MM-yyyy"/>  to 
	              <fmt:formatDate type="date" value="${endDate}" pattern="dd-MM-yyyy"/></li>
	              <li><img src="../mobile_html/images/clock_icn.png" alt="Time"><c:out value="${eventList.startTime} "/>  to <c:out value="${eventList.endTime}"/></li>
	              <li><img src="../mobile_html/images/task_icn.png" alt="Event Status">Status: <c:out value="${eventList.invitationStatus}"/></li>
	            </ul>
	            <div class="clear"></div>
	            </a> </li>
	       </c:forEach>
	        </ul>
	        </div>
	        <div class="clear"></div>
	          </c:otherwise>
	  
  
    </c:choose>
      </section>
  </div>
  <div id="push"></div>
</div>
<%--  <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>