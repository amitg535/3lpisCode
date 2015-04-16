<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Event Preview</title>
<meta name="description" content="">
<meta name="author" content="">
<!--[if lt IE 7]>
	<style type="text/css">
		#wrap { height:100%; }
   </style>
<![endif]-->

<!--[if gte IE 9]>
  <style type="text/css">
    .gradient {
       filter: none;
    }
  </style>
<![endif]-->
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
 
     <script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>

 <script src="http://popcornjs.org/code/dist/popcorn-complete.js"></script>
 <script type="text/javascript" src="js/tytabs.jquery.min.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script> 

   <script>
$(document).ready(function() {
  var map = new google.maps.Map( document.getElementById("gmap"),  {
  center: new google.maps.LatLng(0,0),
  zoom: 3,
  mapTypeId: google.maps.MapTypeId.ROADMAP,
  panControl: false,
  streetViewControl: false,
  mapTypeControl: false
    });
  var geocoder = new google.maps.Geocoder(); 
  geocoder.geocode({
    address : $('#gs02').val(), 
    region: 'no' 
   },
      function(results, status) {
       if (status.toLowerCase() == 'ok') { 
     // Get center
     var coords = new google.maps.LatLng(
      results[0]['geometry']['location'].lat(),
      results[0]['geometry']['location'].lng()
     );
     //$('#coords').html('Latitute: ' + coords.lat() + '    Longitude: ' + coords.lng() );
     map.setCenter(coords);
     map.setZoom(15);
     // Set marker also
     marker = new google.maps.Marker({
      position: coords, 
      map: map, 
      title: $('#gs02').val()
     });            
       }
   }
  )
});
</script>    
       <script>
function finishOperation(){
  window.location.href = "employer_campus_connect.htm";
 }
</script> 
<script>

</script>

</head>
<body class="dashboard">
<div id="">

<!--------------  Header Section :: start ----------->
   <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  
 <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take your career to the next level"></div>
    </div>
   
    <div id="innersection">
    
    <section id="leftsection" class="floatleft">
	     
 
		     <div class="candidate_quickaction_wrap">
			     <c:choose>
				<c:when test="${employerDetails.imageName ne null}"> 
				<div class="portfolio_img "><img  src="view_image.htm?emailId=${eventDetails.emailId}"></div>
				</c:when>
				<c:otherwise>
				 <div class="portfolio_img"><img src="/images/Not_available_icon1.png" width="110" height="32" alt=""></div> 
				 </c:otherwise>
				</c:choose>
			</div>

	  <div class="subheading_divider job_listing_wrap whitebackground floatleft" style= "width:81.1%;">
         <h2 class="sectionheading invitation_heading">Eligible Batch </h2>
        <ul class="keyskillslist">
					          <c:forEach items="${eventDetails.eligibleBatches}" var="eligibleBatch">
					          	<li>
					         		<c:out value="${eligibleBatch}"></c:out>
					          	</li>
					          </c:forEach>
					          </ul>
      </div>	     
 
 <div class="floatleft whitebackground candidate_login_wrap padding_bottom"style= "width:81.1%;">
 
 <h2 class="invitation_heading">Preplacement Info</h2>
 <c:choose>
 <c:when test="${not empty eventDetails.employerRepositoryFileNames}">
   <c:forEach var="fileName" items="${eventDetails.employerRepositoryFileNames}">    
	         <c:if test="${not empty fileName}">
		        <div class="borderbottom padding_bottom padding_top"> 
		         <c:out value="${fileName}">
		          </c:out>
		        
		        <div class="floatright top_margin"> 
		        <a href="download_file_from_repo.htm?fileName=<c:out value="${fileName}"/>&companyName=<c:out value="${eventDetails.companyName }"/>" class="">
		       <img alt="" class="floatright" src="images/resumes_downloaded.png">
		        </a> 
		        </div>
		        
		        </div>	       
	        <div class="clear"></div>
	        </c:if> 
 </c:forEach>
 </c:when>
 <c:otherwise>
 <div class="borderbottom padding_bottom padding_top"> 
 No Preplacement Info Available
 </div>
 </c:otherwise>
  </c:choose>
 
 
 <h2 class="invitation_heading">Profile Video</h2>
 <c:choose>
 <c:when test="${not empty eventDetails.attachCompanyProfile && eventDetails.attachCompanyProfile }">
 
         <div>
         <!--  <div class="left_video_container">  -->
          
          <video id="home_video1" class="video-js vjs-default-skin" controls width="160" height="150" >
            
            <!-- MP4 source must come first for iOS -->
            <source type="video/mp4" src="view_video.htm?emailId=${eventDetails.emailId}" />
            <!-- WebM for Firefox 4 and Opera -->
            <source type="video/wmv" src="view_video.htm?emailId=${eventDetails.emailId}" />
            <!-- OGG for Firefox 3 -->
            <source type="video/ogg" src="view_video.htm?emailId=${eventDetails.emailId}" />
            
            <source type="video/mp3" src="view_video.htm?emailId=${eventDetails.emailId}" />
            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
            <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
                  <param name="movie" value="flashmediaelement.swf" />
                  <param name="flashvars" value="controls=true&amp;file=view_video.htm?emailId=${eventDetails.emailId}" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>
        </div>
  <script>var homePlayer=_V_("home_video1");</script> 
 </c:when>
 <c:otherwise>
 <div>
 No Company Video Available
 </div>
 
 </c:otherwise>
 </c:choose>

 
  
 

 </div>

</section>
  <section id="rightwrap" class="floatleft">
   <div class="subheading_divider whitebackground floatleft width98">
     <div class="floatleft" style="width:72%;">
        <h1 class="sectionheading">Campus Invitation Preview </h1>
        <p class="about_text ">
        <h2> <c:out value="${eventDetails.eventName}"/></h2>
          <div class="greytext" style="margin-top:10px;"> 
          <span><c:out value="${eventDetails.participatingUniversity}"/>  at <c:out value="${eventDetails.eventLocation}"/>
          </span>
          
          </br>
          <c:out value="${eventDetails.startDate}" />  <c:out value="${eventDetails.startTime}" /> 
        
          - <c:out value="${eventDetails.endDate}" /> <c:out value="${eventDetails.endTime}" />
            <br>
             
             </div>
       </p>
     </div>   
       <div class="floatright" style="width:28%;">
     <div class="" style="padding-bottom:10px;" class="padding_top">
    <div id="coords"></div>
   <div id="gmap" style="width:176x; height:163px;"></div> 
 </div>

 </div>        
      </div>
        <input type="hidden" value="<c:out value="${localAddress}"></c:out>" id="gs01">
    <input type="hidden" value="<c:out value="${eventDetails.eventLocation}"></c:out>" id="gs02">
     <div class="subheading_divider whitebackground clear">
        <h1 class="sectionheading">Visit Synopsis </h1>
        <p class="about_text "><c:out value="${eventDetails.eventDescription}" /></p>   </div>
        
        
         <div class="subheading_divider whitebackground">
         <h1 class="sectionheading">Who we are </h1>
        <p class="about_text"><c:out value="${employerDetails.companyDesc}" /></p>  </div>
        
    
            <div class="form_wrap">
          <div id="candidate_registration_wrap">
            <form class="stdform" action="">
            <div class="fullwidth_form">
  				<div class="par">
                <div class="buttonwrap">
        
        <input name="editBtn" type="button" value="Edit" tabindex="18" onclick="window.location.href='employer_schedule_event.htm?eventId=<c:out value="${eventDetails.eventId}"/>'" />
            <input name="backBtn" type="button" value="Finish" tabindex="22" onclick="finishOperation()" />
         
           		</div>
           </div>  
            </div>
          </form>
        </div>
        </div> 
    
    
    </section>
    
     <div class="clear"></div>
  </div>
    
     <div class="bottomspace">&nbsp;</div> 
   </div>
 
<!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>

</body>
</html>