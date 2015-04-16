<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Preview Invitation</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />

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
        <script>
           var $pop = Popcorn("#home_video1"),
        image = document.createElement("image");

        image.id = "capture";
        image.style.marginLeft = "10px";

        $pop.listen("canplayall", function() {

                this.media.parentNode.appendChild( image );

                this.listen("oncepersecond", function() {

                        if ( this.roundTime() % 2 ) {
                                this.capture({
                                        target: "img#capture",
                                        // do not set the poster
                                        set: false
                                });
                        }

                }).play();

        });

        // * "oncepersecond" is a special event hook available here:
        // https://gist.github.com/1074031
       </script>

</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
   <%@ include file="includes/header.jsp"%> 
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/university_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
   
     
    <div id="innersection">
     <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Dashboard</a> / <a href="university_manage_received_invitations.htm">Corporate Invitations</a> / Manage Corporate Invitations</div> -->
    
     <section id="rightwrap" class="floatleft">
   	<div class="whitebackground">
      <h1 class="sectionheading">Campus Invitation Preview</h1>
        <div class="left_logowrap">
          <h2 class="invitation_heading"> <c:out value="${eventDetails.eventName}"/> </h2>
          <div class="invitation_venue"> <span><c:out value="${eventDetails.eventLocation}"/> </span>
          	</br>  
          	<fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="startDate"/>
            <fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>        	
            	<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd"/>  To 
            	<fmt:formatDate type="date" value="${endDate}" pattern="yyyy-MM-dd"/>         
            </div>
        </div>
<!--         <div class="right_logowrap"> -->
<!--           <div class="companylogo_rgt"><img style="width: 110px; height: 32px;" src="university_view_employer_image.htm"></div> -->
<!--         </div> -->

		<div class="right_logowrap">
           							<c:choose>
											<c:when test="${employerDetails.imageName ne null}"> 
											<div class="companylogo_rgt"><img src="view_image.htm?emailId=${eventDetails.emailId}" height="32" width="110"></div>
											</c:when>
											<c:otherwise>
						                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose>
             
            <div class="clear"></div>
            <div class="Profile_margin"><a href="profile_preview.htm?companyName=${employerDetails.companyName}" class="profile"> Company Profile </a></div>
          </div>
        
        <div class="clear"></div>
        <div class="top_margin">
          <h4 class="greytitle"> Visit Synopsis </h4>
          <p class="about_text"><c:out value="${eventDetails.eventDescription}"/></p>
          <h4 class="greytitle"> Who we are </h4>
          <p class="about_text"><c:out value="${employerDetails.companyDesc}" /></p>
          <h4 class="greytitle">Skills On Hire</h4>
          <ul class="topborder_lists">
            <li>
              <div class="floatleft">
                <div class="orangetxt14"><c:out value="${eventDetails.functionalAreas[0]}"/><%--  - <c:out value="${eventDetails.eligibleStreams[0]}"></c:out> --%></div>
                <ul class="recruitmentlist">
                  <li> No of Openings: <c:out value="${eventDetails.numberOfHirings[0]}"/> </li>
                  
               <%--    <li style="border-left:none;"> GPA Cut Off : Between <c:out value="${eventDetails.gpaFromMulti[i]}"/> to <c:out value="${eventDetails.gpaToMulti[i]}"/></li> --%>
                  
                  <li style="border-left:none;"> Batch Of Passing: <c:out value="${eventDetails.eligibleBatches[0]}"></c:out></li>
                </ul>
              </div>
              <div class="offer_salary"> Salary Offered - <!-- <h3 class="salary_title"> --><c:out value="${eventDetails.minimumSalaryOffered[0]}"/><!-- </h3> --></div>
              
              <div class="clear"></div>
            </li>
          </ul>
        </div>
        <div class="clear"></div>
         <c:forEach var="fileName" items="${eventDetails.employerRepositoryFileNames}">    
	         <c:if test="${not empty fileName}">
		        <div class="borderbottom"> <div class="preplace">
		          <h4 class="greytitle"> Preplacement Info </h4>
		          <p class="about_text"><c:out value="${fileName}"></c:out></p>
		        </div>
		        <div class="floatright top_margin"> <a href="download_file_from_repo.htm?fileName=<c:out value="${fileName}"></c:out>&companyName=<c:out value="${employerDetails.companyName}"></c:out>" class="add_repository">View &amp; Download </a> </div></div>	       
	        <div class="clear"></div>
	        </c:if> 
        </c:forEach>
         <div>
         <!--  <p class="about_text">Summer Recruitment 2013</p> -->
           
          
          <!-- <video id="home_video1" class="video-js vjs-default-skin" controls preload=none width="342" height="118" poster="oldfile/images/video_bg.png"> -->
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
                  <param name="flashvars" value="controls=true&amp;file=view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>
          
              <script>var homePlayer=_V_("home_video1");</script> 
          
          
          
          <!-- <div class="rgt_video_container"> Video Container</div> -->
        </div>
        <div class="clear"></div>
        
           
   <div class="par">
          <div class="buttonwrap">
          
          <c:choose>
	          <c:when test="${eventDetails.invitationStatus == 'Accepted'}">
		          <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Broadcasted">
		          <input name="broadcastBtn" type="button" value="Broadcast" tabindex="17"></a>
		            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Undo">
		            <input name="undoBtn" type="button" value="Undo" tabindex="18"></a>
		          </c:when>
		          <c:when test="${eventDetails.invitationStatus == 'Broadcasted'}">
		            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=UndoBroadcast">
		            <input name="broadcastUndoBtn" type="button" value="Undo" tabindex="18"></a>
		          </c:when>
		          <c:when test="${eventDetails.invitationStatus == 'Rejected'}">
		            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Undo">
		            <input name="rejectUndoBtn" type="button" value="Undo" tabindex="18"></a>
		          </c:when>
		          
	          <c:otherwise>
		          <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Accepted">
		          <input name="acceptBtn" type="button" value="Accept" tabindex="17"></a>
		            <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventDetails.eventId}"/>&action=Rejected">
		            <input name="rejectBtn" type="button" value="Reject" tabindex="18"></a>
	          </c:otherwise>
          </c:choose>    
              
          </div>
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
      