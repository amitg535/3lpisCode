<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Dashboard</title>
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
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>

</head>

<body class="university">
<div id="main_wrap">
 <%@ include file="includes/header.jsp"%>	
  <div id="mid_wrap" class="midwrap_toppadding">
    <!-- <div id="submenu">
      <ul class="nav nav-pills">
        <li class="active"><a href="university_dashboard.htm">Profile</a><span class="active_arrow"></span></li>        
        <li><a href="university_manage_receivedinvitations.htm">Events</a></li>
           <li class="dropdown"> <a class="dropdown-toggle" id="drop5" role="button" data-toggle="dropdown" href="#">Events <b class="caret"></b></a>
        <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
       </ul>
      </li>
      </ul>
    </div> -->
    <div class="clear"></div>
    <section id="inner_container">
      <div class="jobdetail_wrap">
        <div class="jobdetails">
           <div class="company_logo">
           <c:choose>
        <c:when test="${not empty university.universityLogoName}">
       <!--  <img src="view_university_logo.htm" /> -->
      <img  src="view_image.htm?emailId=${university.contactPersonEmailId}" />
        </c:when>
        <c:otherwise>
        <img src="../mobile_html/images/blankimage.png" alt="">
        </c:otherwise>
        </c:choose>
           </div> 
          <div class="details">
          
            <h1 class="heading"><c:out value="${university.universityName}"></c:out>
            <%-- <c:out value="${universityName}"></c:out> --%></h1>
            <h2 class="subheading"><c:out value="${university.universityAddress}"></c:out>,<c:out value="${university.city}"></c:out>, <c:out value="${university.state}"></c:out> - <c:out value="${university.zipCode}"></c:out> </h2>
          </div>
          
        </div>
         <!--13-08-2013-->
        <div class="clear"></div>
         <div class="applybtn_wrap margin20_top">
        <div class="innerform">
          <form>
            <ul class="form_wrap">
              <li>
             <input name="" type="button" value="Edit Profile" class="orangebuttons" onClick="window.location.href='university_profile.htm'" class="float_right">
              </li>
            </ul>
          </form>
        </div>
      </div> 
       <!--13-08-2013-->
          <div class="eventdetail_wrap">
          <div class="eventinfo_wrap">
            <div class="event_innerwrap margin_right1">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span class="boldtxt">Registration No:</span> <c:out value="${university.universityRegistrationNumber}" /><br>
              <span class="boldtxt">Company URL: </span><a href="http://<c:out value="${university.universityWebsite}" />"><c:out value="${university.universityWebsite}"></c:out></a>
              </div>
            </div>
            <div class="event_innerwrap">
              <div class="event_img_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /></div>
              <div class="event_content_wrap">
              <span class="boldtxt">Contact Person:</span><c:out value="${university.contactPerson}" /><br>
              <span class="boldtxt">Contact Number: </span><c:out value="${university.phoneNumber}"></c:out><br>
              <span class="boldtxt">Contact Email ID: </span><c:out value="${university.contactPersonEmailId}"></c:out>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <h1 class="jobdescp_title orange_font">Overview</h1>
        <%-- <p class="jobdescp_para"><c:out value="${university.contactPerson}"></c:out>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus augue sem, blandit ac molestie id, tincidunt at elit. Quisque laoreet lectus nunc, quis ullamcorper orci laoreet non. Vestibulum consequat pulvinar dui nec lacinia. Nullam vehicula felis vel rhoncus feugiat. Nam sed leo sit amet nibh placerat malesuada at vulputate mi. Duis eget augue nisl. Vivamus vel egestas mauris, et tincidunt lectus. </p>
        <p class="jobdescp_para">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus augue sem, blandit ac molestie id, tincidunt at elit. Quisque laoreet lectus nunc, quis ullamcorper orci laoreet non. Vestibulum consequat pulvinar dui nec lacinia. Nullam vehicula felis vel rhoncus feugiat. Nam sed leo sit amet nibh placerat malesuada at vulputate mi. Duis eget augue nisl. Vivamus vel egestas mauris, et tincidunt lectus. </p>
        <p class="jobdescp_para">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus augue sem, blandit ac molestie id, tincidunt at elit. Quisque laoreet lectus nunc, quis ullamcorper orci laoreet non. Vestibulum consequat pulvinar dui nec lacinia. Nullam vehicula felis vel rhoncus feugiat. Nam sed leo sit amet nibh placerat malesuada at vulputate mi. Duis eget augue nisl. Vivamus vel egestas mauris, et tincidunt lectus. </p> --%>
      <p id="display" class="desc"></p>
      <input type = "hidden" id="about" value="${university.aboutUs}" />
      </div>
      
    </section>
  </div>
  <div id="push"></div>
</div>
 <%--  <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>