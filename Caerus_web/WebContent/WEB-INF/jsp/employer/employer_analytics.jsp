
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
<title>Analytics</title>
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
<style type="text/css">
.ui-dialog-titlebar{
	display:none;
}


.saveBookmark{cursor:pointer; cursor:hand;}

#profileViewsModal{
	width:820px !important;
}

</style>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>
<link rel="stylesheet" href="css/dots.css" type="text/css">

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
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>

<script type="text/javascript" src="js/jquery-loader.js"></script>


<script type="text/javascript" src="js/xcanvas.js"></script>
<script type="text/javascript" src="js/tbe.js"></script>
<script type="text/javascript" src="js/digitaldisplay.js"></script>
<script type="text/javascript" src="js/speedometer.js"></script>
<script type="text/javascript" src="js/example.js"></script>
<script type="text/javascript" src="js/controls.js"></script>
<script type="text/javascript" src="js/kitsch.js"></script>
<script type="text/javascript" src="js/default_theme_speedometer.js"></script>


<script type="text/javascript">
	$().ready(function (){
      
        var averageJobClosureTime = "${averageJobClosureTime}";
        
        var speedometer = new Speedometer ('speedometer', {});
        speedometer.draw ();
        speedometer.update(averageJobClosureTime);
        
        
		$("#durationAnalytics").change(function(){
			var durationAnalytics = $("#durationAnalytics").val();
			
			$.ajax({
			    url: "employer_analytics.json",
			    data: "durationAnalytics="+durationAnalytics,
			    success: function(result){
			        $("#jobsInTimeFrame").empty().append(result.jobsInTimeFrame);
			        $("#appliedCandidateCount").empty().append(result.appliedCandidateCount);
			        $("#candidateProfilesVisitedCount").empty().append(result.candidateProfilesVisitedCount);
			        $("#resumeDownloadedCount").empty().append(result.resumeDownloadedCount);
			        
			        console.log(result);
			    }
			});
			
			
		});  
		
		$("#durationReports").change(function(){
			var durationReports = $("#durationReports").val();
			
			$.ajax({
			    url: "employer_reports.json",
			    data: "durationReports="+durationReports,
			    success: function(result){
			        var averageJobClosureTime = result.averageJobClosureTime;
			        
			        $("#averageResponsesPerJob").empty().append(result.averageResponsesPerJob);
			        
			        var speedometer = new Speedometer ('speedometer', {});
			        speedometer.draw ();
			        speedometer.update(averageJobClosureTime);
			        
			        console.log(result);
			    }
			});
			
			
		});  
	});
	
</script>

<!-- Bookmark A Job  -->
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:58% !important;}
</style>

</head>
<body class="dashboard">
<div id="wrap">
   
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp" %>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     <div id="innerbanner_wrap">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div> 

    <div id="innersection">
    
    
    <c:choose>
    	<c:when test="${not empty noJobsYet }">
    		 <section id="rightwrap" class="floatleft">
    			<div>
    				<span><c:out value="${noJobsYet}"></c:out> </span>
    			</div>
    		
    		 </section>
    	</c:when>
    	<c:otherwise>
    	
    <section id="leftsection" class="floatleft">
    <div class="candidate_quickaction_wrap">
          <div class="line-border">&nbsp;</div>
         
          <div class="floatright">
        		<select id="durationAnalytics" class="input-small1">
			       	<c:forEach items="${durationDropDown}" var="duration">
			       		<option value="${duration}"> <c:out value="${duration}" /> </option>
			       	</c:forEach>
		       	</select>
        </div>
         <div class="clear"></div>
        <br>
         
           <ul>
            <li>
              <div class="top_notifications"><span id="jobsInTimeFrame"><c:out value="${jobsInTimeFrame}"/></span><a>Jobs Posted</a> </div>
              </li>
            <li class="blue">
              <div class="top_notifications">
             		<span id="appliedCandidateCount"><c:out value="${appliedCandidateCount}"/></span>
            	 	<a>Applied Candidates</a>
             	</div>
             	
             </li>
            
            <li class="green"> 
             <div class="top_notifications">
              <c:choose> 
       			<c:when test="${not empty candidateProfilesVisitedCount}">
       				<span id="candidateProfilesVisitedCount"><c:out value="${candidateProfilesVisitedCount}"/></span>
       			</c:when>
         		<c:otherwise><span id="candidateProfilesVisitedCount">0</span>></c:otherwise>
        		</c:choose>  <a>Profiles Visited</a> </div>
            </li>
            
            <li class="darkblue">
              <div class="top_notifications top_notifications_bluebg">
             	 	<span id="resumeDownloadedCount"><c:out value="${resumeDownloadedCount}"/></span>
             	<a>Resume Downloads</a>
              </div>
              </li>
          </ul>
           
           <div class="clear"></div>
           
        </div>
          <div class="line-border">&nbsp;</div>
         <a name="jobFair"></a>
        
        
        <%-- <div class="candidate_upcomingevents_wrap" id="vfe" >
        <h1 class="sectionheading fontsize14">Upcoming Virtual Job Fair Events  <span>
        (<c:choose> 
        <c:when test="${not empty virtualEvents}">${virtualEvents}</c:when>
         <c:otherwise>0</c:otherwise>
        </c:choose>)
        </span></h1>
       
        <c:choose>
        <c:when test="${virtualEvents !=0}">
       <form class="stdform">
          <ul>
           <c:forEach var="virtualFairDetails" items="${virtualFairDetails}"> 
            <li>
             <div class="floatleft width100"> 
              <div class="floatleft event_calendar doubleright_margin">
              <fmt:parseDate value="${virtualFairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="MMM"/><br/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd"/></div>
                
                    
              <c:set var="myScheme" value="${pageContext.request.scheme}"/>
              <c:set var="myServerName" value="${pageContext.request.serverName}"/>
              <c:set var="myServerPort" value="${pageContext.request.serverPort}"/>
              <c:set var="myContext" value="VJF"/>
              <jsp:useBean id="now" class="java.util.Date"/>             
              <c:set var="today" value="${now}"/>
              <c:set var="finalURL" value="${myScheme}://${myServerName}:${myServerPort}/${myContext}/student_virtual_jobfair_dashbord.htm"></c:set>
                
               
              <div  class="eventdetails_wrap floatleft" style="width: 76%;">
                <h5><a href="candidate_setup_preview.htm?fairId=<c:out value="${virtualFairDetails.virtualJobId}"></c:out>" class="blueheading"><c:out value="${virtualFairDetails.virtualJobName}"/></a> 
          
               <fmt:parseDate value="${virtualFairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
               <fmt:formatDate var="todayDate" value="${now}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="startDate" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="endDate" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>
               
			  <c:choose>
		          <c:when test="${(startDate <= todayDate) && (todayDate <= endDate)}">
		         	<a class="blueheading"> 
		         	<img src="images/live.gif" width="51" height="18" alt="" class="inlineimg"> </a>
		          </c:when>
		     </c:choose>

                </h5>
       
                <div><span class="event_date">
                <fmt:parseDate value="${virtualFairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate1"/>
                <fmt:parseDate value="${virtualFairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate1"/>
                
                <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="MMM"/>
                 to <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="MMM"/></span> <!-- | <span class="boldtxt orangetxt">Convocation Hall</span>, University of Texas --></div>
                <div class="smalltxt"> <c:out value="${virtualFairDetails.acceptedCompanyCount}"/> 
                <c:choose><c:when test = "${virtualFairDetails.acceptedCompanyCount==1}">Company</c:when><c:otherwise>Companies</c:otherwise></c:choose> Participating | <span class="boldtxt"><c:out value="${virtualFairDetails.invitedStudentsCount}"/> People Attending</span></div>
                 <div class="clear"></div>
              <div class="textAlignCenter"><input type="button" value="Quick Register" onclick="acceptBtnCLicked(${virtualFairDetails.virtualJobId},'${finalURL}')"  /></div>
</div>
<div class="textAlignCenter">
              <input type="button" value="Quick Register" onclick="acceptBtnCLicked(${virtualFairDetails.virtualJobId},'${finalURL}')"  /></div>
              </div>
              <!-- <div class="floatright candidate_event_type">Job Fair</div> -->
             
            </li>
            </c:forEach>
       
          </ul>
          
          </form>
               </c:when>
               <c:otherwise>
               <span> There are no Events against your Profile.</span>
               </c:otherwise>
        </c:choose>
        
           <!-- <div class="viewmore floatright">View more</div>  -->
        </div> --%>
       <%--  <c:if test="${eventsCount != 0}">
          <div class="candidate_upcomingevents_wrap">
         
        <h1 class="sectionheading">Upcoming Job Fairs</h1>
        <form class="stdform">
          <ul>
           <c:forEach var="upcomingEvents" items="${upcomingEventsList}"> 
            <li>
              
               
              <div class="floatleft width100"> 
              <div class="floatleft event_calendar doubleright_margin">
              <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="MMM"/><br/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd"/></div>
                
            
              <div class="eventdetails_wrap floatleft" style="width: 76%;">
              <h5>
              <c:choose>
                <c:when test="${upcomingEvents.universityFlag eq false}">
                <a href="candidate_preview_received_corporate_invite.htm?event_id=<c:out value="${upcomingEvents.eventId}"/>" class="blueheading"><c:out value="${upcomingEvents.eventName}"/></a> 
          </c:when>
          <c:otherwise>
          <a href="preview_university_event.htm?eventId=<c:out value="${upcomingEvents.eventId}"/>"></a>
          <a href="candidate_preview_university_event.htm?eventName=<c:out value="${upcomingEvents.eventName}"/>&eventId=<c:out value="${upcomingEvents.eventId}"/>&eventType=<c:out value="${upcomingEvents.eventType}"/>" class="blueheading"><c:out value="${upcomingEvents.eventName}"/></a>
          </c:otherwise>
          </c:choose>
               <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
               <fmt:formatDate var="todayDate" value="${now}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="startDate" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="endDate" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>
            
                </h5>
       
                <div><span class="event_date">
                <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate1"/>
                <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate1"/>
                
                <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="MMM"/>
                 to <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="MMM"/>
                | <c:out value="${upcomingEvents.startTime}" /> to <c:out value="${upcomingEvents.endTime}" /></span></div>
			</div>
              </div>
             
              <div class="clear"></div>
            </li>
            </c:forEach>
          
          </ul>
          <c:if test="${eventsCount > 3}">
        <div class="viewmore floatright">
        <a href="candidate_broadcasted_corporate_invites.htm">View more</a></div>
         </c:if>
          </form>
           
        </div>
        </c:if> --%>
    </section>
    
      <section id="rightwrap" class="floatleft">
      
       
        
        
        <h1 class="sectionheading">Reports and Analytics</h1>
        <div class="borderbottom padding_bottom doublebottom_margin">
          <div class="clear"></div>
        </div>
        <div class="clear"></div>
        <div class="floatright"></div>
        
        <div class="floatright">
        		<select id="durationReports" class="input-small1 floatright">
			       	<c:forEach items="${durationDropDown}" var="duration">
			       		<option value="${duration}"> <c:out value="${duration}" /> </option>
			       	</c:forEach>	
	       	    </select>
        </div>
        
        
        
		<div class="floatleft doubleright_margin top_margin" style="width:200px;">
	         <h1 class="sectionheading"> AVERAGE JOB CLOSURE TIME</h1>
	        <ul>
	        <!--  <ul class="recent_activities_wrap"> -->
	         		<%-- <c:forEach var="recentActivities" items="${recentActivitiesMapSorted}">
	         			<fmt:parseDate value="${recentActivities.value}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="rActivities"/>
	                	<li><span style="color:#818181;"><fmt:formatDate type="date" value="${rActivities}" pattern="dd MMMM yyyy"/></span> <br> <c:out value="${recentActivities.key}"></c:out></li>
	                </c:forEach> --%>
	                <li>
	                <div id="speedometer" style="width:100%;height: 200px;"></div>
       				<div id="controls"></div>
	                
	                </li>
	        </ul>
        </div>
        
        
        <div class="floatleft top_margin" style="width:15%;">
          <h1 class="sectionheading">AVERAGE JOB RESPONSES</h1>
          <!-- <p> Use the power of video to be more visible to the prospective recruiters by uploading  your resume. <span class="boldtxt"><a href="candidate_portfolio.htm#e" class="pinkcolor">Do it right Now</a></span></p>
          <div class="all_border candidate_video_cv"><a href="candidate_portfolio.htm#e"><img src="images/candidate_video.jpg" width="355" height="200" alt=""></a></div> -->
       	  <p><span class="boldtxt"><a class="pinkcolor"> <span id="averageResponsesPerJob"><c:out value="${averageResponsesPerJob }" /></span></a></span></p>
       	  <div class=""><a><img src="images/responses.png" height = "75" width="75" alt=""></a></div>  
        
        </div>
        
        
        
        <div class="floatleft top_margin" style="width:40%;">
        <!--   <h1 class="sectionheading">Video Resume</h1>
          <p> Use the power of video to be more visible to the prospective recruiters by uploading  your resume. <span class="boldtxt"><a href="candidate_portfolio.htm#e" class="pinkcolor">Do it right Now</a></span></p>
          <div class="all_border candidate_video_cv"><a href="candidate_portfolio.htm#e"><img src="images/candidate_video.jpg" width="355" height="200" alt=""></a></div>
        --> </div>
        
        <div class="clear"></div>
       
          
         
      </section>
      </c:otherwise>
    </c:choose>
      
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
