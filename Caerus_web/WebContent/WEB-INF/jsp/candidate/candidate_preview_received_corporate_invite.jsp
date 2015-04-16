<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Preview Received Campus Invites </title>
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
				
				$("#successMessage").empty();
				
				if(status == 'accept')
					$("#successMessage").append("Event Accepted");
				else
					$("#successMessage").append("Event Rejected");
			    
			      $("#successModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#successModal').dialog('close')",2500);
			            }
		 			});

			      timeoutfunction();
			
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
				
				$("#successMessage").empty();
				
					$("#successMessage").append("Event Action Successfully Reverted");
			    
			      $("#successModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#successModal').dialog('close')",2500);
			            }
		 			});

			      timeoutfunction();
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function timeoutfunction()
{
	setTimeout(function(){window.location.reload();}, 2510);
} 
</script>

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
      <!-- <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_broadcasted_corporate_invites.htm">Upcoming Events </a>\ Event Preview </div> -->
      <%-- <section id="leftsection" class="floatleft">
        <h3>Useful Links</h3>
        <ul class="leftsectionlinks">
          <li><a href="#">Background Check Services</a></li>
          <li><a href="#">Checklist Employee Contract</a></li>
          <li><a href="#">Hire Overseas Employees</a></li>
        </ul>
        <div id="newsletterwrap">
          <h3>Newsletter</h3>
          <form>
            <input name="" type="text" class="textbox">
            <input name="" type="button" value="Subscribe">
          </form>
        </div>
        
      </section> --%>
    
     <section id="rightwrap" class="floatleft">
     <c:set var="studentEmailId" value="${studentEmailId}" />
     <%--  <c:forEach items="${eventDetails}" var="eventDetails">      --%>
   
   <div class="whitebackground">
   
      <h1 class="sectionheading">Campus Invitation Preview
      <c:if test="${(eventDetails.acceptedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)) &&
         (eventDetails.deniedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId))}">
         
   		   <a onclick="updateEventCorporate('${eventDetails.eventId}','deny')">
                    <div class="buttonwrap floatright"><img src="images/thumb_down_icon.png" alt="Reject" align="absmiddle" style="display:inline;"> Reject  </div></a> 
                   
   		   <a onclick="updateEventCorporate('${eventDetails.eventId}','accept','${eventDetails.eventName}','${eventDetails.emailId }')">
                    <div class="buttonwrap floatright"><img src="images/thumb_up_icon.png" alt="Accept" align="absmiddle" style="display:inline;"> Accept  &nbsp; &nbsp; &nbsp; &nbsp;</div></a>
        
        </c:if>
        <c:if test="${(eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)) || (eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId))}">
       <div class="buttonwrap floatright" style="text-transform:none; font-weight:normal;">
       <a onclick="undoActionCorporate('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.emailId }')">
        &nbsp; &nbsp; &nbsp; &nbsp;<img src="images/undo_icn.png" alt="Undo" align="absmiddle" /> Undo
				   </a></div>
        </c:if>
        
      </h1>
        <div class="left_logowrap">
          <h2 class="invitation_heading"> <c:out value="${eventDetails.eventName}"/> </h2>
          <div class="invitation_venue"> <span><c:out value="${eventDetails.participatingUniversity}"/> </span>
          	</br>  
          	    <fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>  
          	    <fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>       	
            	<fmt:formatDate type="date" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>  To <fmt:formatDate type="date" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>
            	         
            </div>
        </div>

		<div class="right_logowrap">
           <c:set var="photoName" value="${firmId}"/>
           <%-- <c:forEach items="${empdetailpreview}" var="empdetailpreview"> --%>
            <c:choose>
											<c:when test="${employerDetails.imageName ne null}"> 
											<div class="companylogo_rgt"><img src="view_image.htm?emailId=${eventDetails.emailId}" height="32" width="110"></div>
											</c:when>
											<c:otherwise>
						                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose> 
           <%--  </c:forEach> --%>
            <div class="clear"></div>
            <div class="Profile_margin"><a href="profile_preview.htm?companyName=<c:out value="${eventDetails.emailId}"/>" class="profile"> Company Profile </a></div>
          </div>
        
        <div class="clear"></div>
        
        <c:if test="${eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,studentEmailId)}">
           <div class="doubledashed_border">
         <div class="ofwhitebg">
         
      <div>Event was Accepted 
 			<c:if test="${not empty acceptedTime}">on <c:out value="${acceptedTime}"/> </c:if> &nbsp; &nbsp; <%-- <a onclick="undoActionCorporate('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.firmId }')">Undo Action
				   </a> --%></div>
				   </div>
				   </div>
      </c:if>
      <c:if test="${eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,studentEmailId)}">
       <div class="doubledashed_border">
       <div class="ofwhitebg">
      <div>Event was Rejected &nbsp; &nbsp; <%-- <a onclick="undoActionCorporate('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.firmId }')">Undo Action
				   </a> --%> </div>
				   </div>
				   </div>
      </c:if>
        
        <div class="top_margin">
          <h4 class="greytitle"> Visit Synopsis </h4>
          <p class="about_text"><c:out value="${eventDetails.eventDescription}"/></p>
          <h4 class="greytitle"> Who we are </h4>
          <p class="about_text">
          <c:out value="${employerDetails.companyDesc}" /></p>
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
              <div class="offer_salary"> Salary Offered </div>
              <h3 class="salary_title"><c:out value="${eventDetails.minimumSalaryOffered[0]}"/></h3>
              <div class="clear"></div>
            </li>
          </ul>
         <%--  <ul class="topborder_lists">
            <c:forEach begin="0" end="${eventDetails.multivalues}" var="i">
		    <% String k = pageContext.getAttribute("i").toString(); pageContext.setAttribute("ki", k);%>
            <li>
              <div class="floatleft">
                <div class="orangetxt14"><c:out value="${eventDetails.functionalAreaMulti[i]}"/> - <c:out value="${eventDetails.eligibleStreamsMultiDB[ki]}"></c:out></div>
                <ul class="recruitmentlist">
                  <li> No of Openings: <c:out value="${eventDetails.noOfHiringsMulti[i]}"/> </li>
                  <li> GPA Cut Off : Between <c:out value="${eventDetails.gpaFromMulti[i]}"/> to <c:out value="${eventDetails.gpaToMulti[i]}"/> </li>
                  <li> Batch Of Passing: <c:out value="${eventDetails.batchOfPassingMultiDB[ki]}"></c:out></li>
                </ul>
              </div>
              <h3 class="salary_title"><c:out value="${eventDetails.minSalaryOfferedMulti[i]}"/></h3>
              <div class="offer_salary"> offer Salary </div>
              <div class="clear"></div>
            </li>
            </c:forEach> 
          </ul>--%>
        </div>
        <div class="clear"></div>
         <c:forEach var="fileName" items="${eventDetails.employerRepositoryFileNames}">    
	         <c:if test="${not empty fileName}">
		        <div class="borderbottom"> <div class="preplace">
		          <h4 class="greytitle"> Preplacement Info </h4>
		          <p class="about_text"><c:out value="${fileName}"></c:out></p>
		        </div>
		        <%-- <div class="floatright top_margin"> <a href="download_file_from_repo.htm?repoFileName=<c:out value="${repoNameMulti}"></c:out>" class="add_repository">View &amp; Download </a> </div></div>	  --%>      
	        <div class="floatright top_margin"> <a href="download_file_from_repo.htm?fileName=<c:out value="${fileName}"></c:out>&companyName=<c:out value="${employerDetails.companyName}"></c:out>" class="add_repository">View &amp; Download </a> </div></div>
	        <div class="clear"></div>
	        </c:if> 
        </c:forEach>
         <div>
          <!-- <p class="about_text">Summar Recruitment 2013</p> -->
          
          
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
                  <param name="flashvars" value="controls=true&amp;file=employer_profile_video.htm" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>
          
              <script>var homePlayer=_V_("home_video1");</script> 
          
          
          <!-- <div class="rgt_video_container"> Video Container</div> -->
        </div>
        <div class="clear"></div>
        
        
       <%--  </c:forEach>      --%>
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

<!-- Success Modal -->

 <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="successModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessage"></span>
   </div>
   </div>
  </div>


<!-- Success Modal --> 

</body>
</html>
      