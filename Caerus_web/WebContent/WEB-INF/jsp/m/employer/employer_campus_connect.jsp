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
<title>Employer Events </title>
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
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
 <!-- <style>
/* Demo Styles */
html {
  height: 100%;
}
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 13px;
  line-height: 1.5;
  position: relative;
  height: 100%;
  background: #333;
  box-shadow: 0px 0px 100px #000 inset;
}
.preloader {
  position: absolute;
  left: 0;
  top: -100px;
  z-index: 0;
  color: #fff;
  text-align: center;
  line-height: 100px;
  height: 100px;
  width: 100%;
  opacity: 0;
  font-size: 25px;
  -webkit-transition: 300ms;
  -moz-transition: 300ms;
  -ms-transition: 300ms;
  -o-transition: 300ms;
  transition: 300ms;
  background: rgba(0,0,0,0.1);
}
.preloader.visible {
  top: 0;
  opacity: 1;
}
.swiper-container {
	margin:0 auto;
	position:relative;
	overflow:hidden;
	-webkit-backface-visibility:hidden;
	-moz-backface-visibility:hidden;
	-ms-backface-visibility:hidden;
	-o-backface-visibility:hidden;
	backface-visibility:hidden;
	/* Fix of Webkit flickering */
	z-index:1;
}
.swiper-wrapper {
	position:relative;
	width:100%;
	-webkit-transition-property:-webkit-transform, left, top;
	-webkit-transition-duration:0s;
	-webkit-transform:translate3d(0px,0,0);
	-webkit-transition-timing-function:ease;
	
	-moz-transition-property:-moz-transform, left, top;
	-moz-transition-duration:0s;
	-moz-transform:translate3d(0px,0,0);
	-moz-transition-timing-function:ease;
	
	-o-transition-property:-o-transform, left, top;
	-o-transition-duration:0s;
	-o-transform:translate3d(0px,0,0);
	-o-transition-timing-function:ease;
	-o-transform:translate(0px,0px);
	
	-ms-transition-property:-ms-transform, left, top;
	-ms-transition-duration:0s;
	-ms-transform:translate3d(0px,0,0);
	-ms-transition-timing-function:ease;
	
	transition-property:transform, left, top;
	transition-duration:0s;
	transform:translate3d(0px,0,0);
	transition-timing-function:ease;
}
.swiper-free-mode > .swiper-wrapper {
	-webkit-transition-timing-function: ease-out;
	-moz-transition-timing-function: ease-out;
	-ms-transition-timing-function: ease-out;
	-o-transition-timing-function: ease-out;
	transition-timing-function: ease-out;
	margin: 0 auto;
}
.swiper-slide {
	float: left;
}

/* IE10 Windows Phone 8 Fixes */
.swiper-wp8-horizontal {
	-ms-touch-action: pan-y;
}
.swiper-wp8-vertical {
	-ms-touch-action: pan-x;
}
.swiper-container {
  width: 100%;
  height: 100%;
  color: #fff;
  position: relative;
  z-index: 10;
  
}

/* .swiper-slide {
  height: 100px;
  width: 100%;
  line-height: 100px;
  opacity: 0.2;
  -webkit-transition: 300ms;
  -moz-transition: 300ms;
  -ms-transition: 300ms;
  -o-transition: 300ms;
  transition: 300ms;
} */
.swiper-slide-visible {
  opacity: 1;
}
.swiper-slide .title {
  font-style: italic;
  font-size: 42px;
}
  </style> -->
</head>


<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
 <div id="mid_wrap" class="midwrap_toppadding">
    <section id="inner_container">
      <h1 class="page_heading">Scheduled <span class="orange_font">Events</span></h1>
      <!-- <div class="preloader">
    Loading...
  </div> -->
     <div class="search_listing_wrap" >
						<div class="float_right"><!-- <a href="employer_posta_job.htm" class="orangebuttons">Post Job</a> -->
						<input type="button" value="Schedule An Event" class="orangebuttons" onclick="location.href='employer_schedule_event.htm'"/></div>
						
						
						  <div class="clear"></div>
 
								  <ul class="search_listing">
						
					   <c:forEach items="${employerEvents}" var="eventDetails">
						
						<li onclick="location.href='employer_event_preview.htm?eventId=<c:out value="${eventDetails.eventId}"/>'" class="swiper-slide">
								<a href="#">
											<h1 class="heading">
												
												<c:out value="${eventDetails.eventName}"/>
											</h1>
											 <h2 class="subheading">
												<c:out value="${eventDetails.participatingUniversity}"/>
												,
												<c:out value="${eventDetails.eventLocation}" />
											</h2>
											<div class="jobtype">
												<span class="postedon">From 											
												<fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="manageEventStartDate"/>
                  								<fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="manageEventEndDate"/>
                  								<fmt:formatDate type="date" value="${manageEventStartDate}" pattern="dd-MM-yyyy"/> to  <fmt:formatDate type="date" value="${manageEventEndDate}" pattern="dd-MM-yyyy"/> <br/>
                    							<c:out value="${eventDetails.startTime}"/> To <c:out value="${eventDetails.endTime}"/></td>
												
												<%-- <fmt:parseDate value="${jobList.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /> --%>
												</span>
													
													
											</div> 
											
											<div class="jobtype">
											<c:out value="${eventDetails.eventStatus}"/>
											</div>
											
									</a>
								</li>
								
						</c:forEach>
						</ul>
						
						
									
					
			</div>
     
     
    </section>
    
    
      <section id="rightwrap" class="floatleft">
              
        
      </section>
</div>
</div>
<script src="../mobile_html/js/jquery-1.10.1.min.js"></script>
  <script src="../mobile_html/js/idangerous.swiper-2.1.min.js"></script>
 <!--  <script>
  $(document).ready(function() {
	  onTouchStart: function() {
		  
      holdPosition = 0;
  }

  });
  var holdPosition = 0;
  var mySwiper = new Swiper('.swiper-container',{
    slidesPerView:'auto',
    mode:'vertical',
    watchActiveIndex: true,
    onTouchStart: function() {
      holdPosition = 0;
    },
    onResistanceBefore: function(s, pos){
      holdPosition = pos;
    },
    onTouchEnd: function(){
      if (holdPosition>100) {
        // Hold Swiper in required position
        mySwiper.setWrapperTranslate(0,100,0)

        //Dissalow futher interactions
        mySwiper.params.onlyExternal=true

        //Show loader
        $('.preloader').addClass('visible');

        //Load slides
        loadNewSlides();
      }
    }
  })
  var slideNumber = 0;
  function loadNewSlides() {
    /* 
    Probably you should do some Ajax Request here
    But we will just use setTimeout
    */
    setTimeout(function(){
      //Prepend new slide
      var colors = ['red','blue','green','orange','pink'];
      var color = colors[Math.floor(Math.random()*colors.length)];
      mySwiper.prependSlide('<div class="title">New slide '+slideNumber+'</div>', 'swiper-slide '+color+'-slide')

      //Release interactions and set wrapper
      mySwiper.setWrapperTranslate(0,0,0)
      mySwiper.params.onlyExternal=false;

      //Update active slide
      mySwiper.updateActiveSlide(0)

      //Hide loader
      $('.preloader').removeClass('visible')
    },1000)

    slideNumber++;
  }
  </script> -->
<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>