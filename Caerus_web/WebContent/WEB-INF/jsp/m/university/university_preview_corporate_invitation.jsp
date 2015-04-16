<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Preview Received Invites</title>
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
   
      <div class="eventdetail_wrap">
      <c:choose>
											<c:when test="${employerDetails.imageName ne null}"> 
											<div class="company_logo float_left"><img src="view_image.htm?emailId=${eventDetails.emailId}"></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo float_left"><img src="/images/Not_available_icon1.png"></div> 
						                      </c:otherwise>
						                      </c:choose>
    
        <div class="jobdetails">
          <div class="details">
            <h1 class="heading"> <c:out value="${eventDetails.eventName}"/> </h1>
            <h2 class="subheading">
            by <c:out value="${employerDetails.companyName}" />
            <c:out value="${eventDetails.emailId}"/> </h2>
          </div>
        </div>
        <div class="clear"></div>
        <div class="eventinfo_wrap">
          <div class="event_innerwrap margin_right1">
            <div class="event_img_wrap"><img src="../mobile_html/images/user_icn.png" alt="User Information" /></div>
            <div class="event_content_wrap">
            <fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="startDate"/>
            <fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>
            <fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd"/>  To
            <fmt:formatDate type="date" value="${endDate}" pattern="yyyy-MM-dd"/>       
              <span class="margin10_left margin10_right">|</span> Timing: <c:out value="${eventDetails.startTime}"/>  - <c:out value="${eventDetails.endTime}"/></div>
          </div>
          <div class="event_innerwrap">
            <div class="status_wrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/download_icn.png" alt="Download Resume" /></div>
              <div class="event_content_wrap">Status:<c:out value="${eventDetails.invitationStatus}"/> </div>
            </div>
            <div class="button_wrap float_right">
              <form>
              
                      <c:choose>
         
          <c:when test="${eventDetails.invitationStatus == 'Accepted'}">
          <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Broadcasted"><input name="" type="button" value="Broadcast" class="orangebutton1  float_right"></a>
            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Undo"><input name="" type="button" value="Undo" class="orangebutton1 float_right margin20_right"></a>
          </c:when>
          
           
          <c:when test="${eventDetails.invitationStatus == 'Broadcasted'}">
            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=UndoBroadcast"><input name="" type="button" value="Undo" class="orangebutton1  float_right"></a>
          </c:when>
          
          <c:when test="${eventDetails.invitationStatus == 'Rejected'}">
            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Undo"><input name="" type="button" value="Undo" class="orangebutton1  float_right"></a>
          </c:when>
          
          <c:otherwise>
          <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Accepted"><input name="" type="button" value="Accept" class="orangebutton1  float_right"></a>
            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Rejected"><input name="" type="button" value="Reject" class="orangebutton1 float_right margin20_right"></a>
          </c:otherwise>
          </c:choose>  
              
              </form>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        
        <h1 class="jobdescp_title orange_font">Visit Synopsis</h1>
        <p class="jobdescp_para"><c:out value="${eventDetails.eventDescription}"/></p>
        
        <h1 class="jobdescp_title orange_font"> Who we are </h1>
         <p class="jobdescp_para"><c:out value="${employerDetails.companyDesc}" /></p>
         
       
         <h1 class="jobdescp_title orange_font">Skills On Hire</h1>    <ul class="topborder_lists">
            <li>
              <div class="floatleft">
                <div class="orangetxt14"><c:out value="${eventDetails.functionalAreas[0]}"/><%--  - <c:out value="${eventDetails.eligibleStreams[0]}"></c:out> --%></div>
                <ul class="recruitmentlist">
                  <li> No of Openings: <c:out value="${eventDetails.numberOfHirings[0]}"/> </li>
                  
                  
                  <li style="border-left:none;"> Batch Of Passing: <c:out value="${eventDetails.eligibleBatches[0]}"></c:out></li>
                </ul>
              </div>
              <div class="offer_salary"> Salary Offered </div>
              <h3 class="salary_title"><c:out value="${eventDetails.minimumSalaryOffered[0]}"/></h3>
              <div class="clear"></div>
            </li>
          </ul>

        
      </div>
    </section>
  </div>
  <div id="push"></div>
</div>
</body>
</html>