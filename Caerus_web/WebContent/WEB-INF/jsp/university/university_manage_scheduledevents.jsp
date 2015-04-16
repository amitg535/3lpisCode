<%@page import="java.text.DateFormat"%>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Manage Scheduled Events</title>
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
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css" />

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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		
	/* $(".bg").click(function() {
		var eventId= $(this).attr('id');
		//var eventName = $(this).find('span#eventName').html();
	    window.document.location = 'preview_university_event.htm?eventId='+eventId;
	}); */
});



$(document).ready(function(){

	var array = new Array();

	$(".callToolTip").each(function(){
		var id = $(this).attr('id');
		var array = id.split('_');
		
		var eventId = "demo2_tip_"+array[0]+"_"+array[1];
		
		$('#'+id).webuiPopover({
	          trigger:'click',
	          placement:'top',
	          width:350,
	          closeable:true,
	          content: $("#"+eventId).html()
	  	  });
		
	});
  	  
  });

</script>
<style type="text/css">
.tooltipblock{width:212px !important;}
div#mcTooltip{overflow-y:auto;}
</style>
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
      <!-- <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / <a href="#">Manage Events</a> / Manage Scheduled Events</div> -->
      <%-- <section id="leftsection" class="floatleft">
        <h3 class="nomargin">Corporate Connect</h3>
        <ul class="leftsectionlinks">
          <li><a href="<c:url value='university_manage_scheduledevents.htm'/>">Manage Scheduled Events</a></li>
          <li><a href="university_manage_receivedinvitations.htm">Received Invitations for Campus Vists</a></li>
        </ul>
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
       
       
        <h1 class="sectionheading floatleft">Manage Scheduled Events</h1>
        <a href="university_schedule_anevent.htm">
        <div class="postajob_wrap"><img src="images/postajob_icn.png" alt="Schedule An Event" title="Schedule An Event">Schedule an Event</div>
        </a>
        <div class="clear"></div>
        
        <div id="tabs" class="doublebottom_margin">
            <ul>
            <li><a href="#tabs-1">Upcoming Events (${fn:length(upcomingEvents)})</a></li>
            <li><a href="#tabs-2">Ongoing Events (${fn:length(ongoingEvents)})</a></li>
            <li><a href="#tabs-3">Closed Events (${fn:length(closedEvents)})</a></li>
          </ul>
         <!--   <div class="whitebackground"> -->
        <div id="tabs-1" class="reponses_listing_wrap">
       	<c:set value="${upcomingEvents}"  var="upcomingEvents" />
       
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting">
       
        <c:forEach items="${upcomingEvents}" var="upcomingEvents" varStatus="status">
           
         <tr>
           		<td class="dummy double_padding_bottom whitebackground">
                <div class="image_wrap">
                <div class="candidate_photo">
                <c:if test="${upcomingEvents.eventType eq 'Job Fair'}"><img src="/images/jobfair_icon.png" alt="Job Fair"></c:if>
                <c:if test="${upcomingEvents.eventType eq 'Recruitment'}"><img src="/images/recruit_icon.png" alt="Recruitment"></c:if>
                <c:if test="${upcomingEvents.eventType eq 'Seminar'}"><img src="/images/seminar_icon.png" alt="Seminar"></c:if>
                </div>
                </div>
                <div class="details_wrap" style="width:85%;">
                <div class="sectionleft floatleft"> 
                    <a href="preview_university_event.htm?eventId=${upcomingEvents.eventId}"><span id="eventName"><c:out value="${upcomingEvents.eventName}"/></span></a>
                    <br><span> Starts In <c:out value="${upcomingEvents.daysRemaining}"/> at <c:out value="${upcomingEvents.venue}"/> </span> 
                 </div>
                 <c:set var="attendingCandidates" value="${upcomingEvents.acceptedByStudentsList}"></c:set>
                <div class="sectionright floatright">
                   <a id="upcoming_${status.index}" class="callToolTip" style="display: block; float: left;">
	                <span class="details corporate_count" >
		                <label class="score"><span class="orangetxt boldtxt iScore">
		                <c:out value="${upcomingEvents.companyNameStatusMap.size()}"/>
		                </span>
		                </label> 
	               		Corporate(s) <br> Attending
	                </span>
	                	
						<div id="demo2_tip_upcoming_${status.index}" class="tooltipup" style="display: none;">
						 <ul>
						 
								<c:forEach items="${upcomingEvents.companyNameStatusMap}" var="companyNameAndStatus">
									<li>
										<div class="floatleft" style="width:67%;"><c:out value="${companyNameAndStatus.key}" /> </div><span><c:out value="${companyNameAndStatus.value}" /></span>
										
									</li>
								</c:forEach>
							</ul> 
						</div>
	                
	                </a>
	                <span class="candidate_count">
	                	    <label class="score"><c:out value="${fn:length(attendingCandidates)}"/> </label>
	                	     Candidate(s)
	                	    <br> Attending
	                </span>
	                
                </div>
                    
                  </div>  
                  <div class="clear"></div>
                </td>
         </tr>
         <tr><td style="height:25px;">&nbsp;</td></tr>
         </c:forEach>
        </table>
        </div>
          
          
            
          
    
        <div id="tabs-2" class="reponses_listing_wrap">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting">
        <c:forEach items="${ongoingEvents}" var="ongoingEvents" varStatus="status">
           
         <tr id="${ongoingEvents.eventId}">
           		<td class="dummy double_padding_bottom whitebackground">
                <div class="image_wrap">
                <div class="candidate_photo">
                <c:if test="${ongoingEvents.eventType eq 'Job Fair'}"><img src="/images/jobfair_icon.png" alt="Job Fair"></c:if>
                <c:if test="${ongoingEvents.eventType eq 'Recruitment'}"><img src="/images/recruit_icon.png" alt="Recruitment"></c:if>
                <c:if test="${ongoingEvents.eventType eq 'Seminar'}"><img src="/images/seminar_icon.png" alt="Seminar"></c:if>
                </div>
                </div>
                <div class="details_wrap" style="width:85%;">
                <div class="sectionleft floatleft"> 
                    <span id="eventName"><a href="preview_university_event.htm?eventId=${ongoingEvents.eventId}"><c:out value="${ongoingEvents.eventName}"/></a> , <c:out value="${ongoingEvents.venue}"/> </span>
                    <br><span> Ends In <c:out value="${ongoingEvents.daysRemaining}"/> </span>
                 </div>
                 <c:set var="attendingCandidates" value="${ongoingEvents.acceptedByStudentsList}"></c:set>
                <div class="sectionright floatright">
			       <a id="ongoing_${status.index}" class="callToolTip"   style="display: block; float: left;">
                	<span class="details corporate_count">
		                <label class="score">
			                <span class="orangetxt boldtxt iScore">
			                  <c:out value="${ongoingEvents.companyNameStatusMap.size()}"/>
			                </span>
		                </label> Corporate(s)<br>
	                			Attending
	                </span>
	                <div id="demo2_tip_ongoing_${status.index}"  class="tooltipup" style="display: none;">
						 <ul>
								<c:forEach items="${ongoingEvents.companyNameStatusMap}" var="companyNameAndStatus">
									<li>
										<div class="floatleft" style="width:67%;"><c:out value="${companyNameAndStatus.key}" /></div>  <span style="float:right; display:block;"><c:out value="${companyNameAndStatus.value}" /></span>
										
									</li>
								</c:forEach>
							</ul> 
						</div>
	             </a>   
	                <span class="candidate_count">
	                	<label class="score"><c:out value="${fn:length(attendingCandidates)}"/></label> 
	                	Candidate(s)<br> Attending
	                	
	                </span>
                </div>
                    
                  </div>  
                </td>
         </tr>
         
			<tr><td style="height:25px;">&nbsp;</td></tr>			
         
         </c:forEach>
        </table>
        </div>
        
        <div id="tabs-3" class="reponses_listing_wrap">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting">
        <c:forEach items="${closedEvents}" var="closedEvents">
           
         <tr id="${closedEvents.eventId}">
           		<td class="dummy double_padding_bottom whitebackground">
                <div class="image_wrap">
                <div class="candidate_photo">
                <c:if test="${closedEvents.eventType eq 'Job Fair'}"><img src="/images/jobfair_icon.png" alt="Job Fair"></c:if>
                <c:if test="${closedEvents.eventType eq 'Recruitment'}"><img src="/images/recruit_icon.png" alt="Recruitment"></c:if>
                <c:if test="${closedEvents.eventType eq 'Seminar'}"><img src="/images/seminar_icon.png" alt="Seminar"></c:if>
                </div>
                </div>
                <div class="details_wrap" style="width:85%;">
                <div class="sectionleft floatleft"> 
                    <a href="preview_university_event.htm?eventId=${closedEvents.eventId}"><span id="eventName"><c:out value="${closedEvents.eventName}"/></span></a>
                    <fmt:parseDate value="${closedEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>
                    <br><span> Ended on <fmt:formatDate type="date" value="${endDate}" pattern="MM-dd-yyyy"/></span> 
                 </div>
                <!-- <div class="sectionright floatright"><span class="details iscorelabel"><label class="score"><span class="orangetxt boldtxt iScore">1025</span></label> Attending</span></div> -->
                    
                  </div>  
                  <div class="clear"></div>
                </td>
         </tr>
         <%-- 
         
         
         
         		  <div style="display:none;margin-top:20px;">
						<div id="demo2_tip_closed${status.index}" >
						 <ul>
								<c:forEach items="${closedEvents.companyNameStatusMap}" var="companyNameAndStatus">
									<li>
										<c:out value="${companyNameAndStatus.key}" /> &nbsp;&nbsp;&nbsp;<c:out value="${companyNameAndStatus.value}" />
										<br>
									</li>
								</c:forEach>
							</ul> 
						</div>
				</div> --%>
         <tr><td style="height:25px;">&nbsp;</td></tr>
         </c:forEach>
        </table>
        </div>
        
          
        <!-- </div> -->
        
       </div> 
        
        
      <%--   <div class="recordlisting_wrap">
          
          
          
          
          <div class="par">
            <table class="table table-bordered" id="dyntable2">
              <thead>
                <tr>
                  <th width="35%" class="table_leftalign">Event Name</th>
                  <th width="20%" class="table_leftalign">Invitation Type</th>
                  <th width="22%" class="table_leftalign">Date</th>
                  <th width="13%" class="table_centeralign">Status</th>
                  <th width="10%" class="table_centeralign">Actions</th>
                </tr>
              </thead>
              <tbody>
               <c:forEach items="${eventList}" var="eventList">
               
               <c:set var="eventStatus" value="${eventList.status}">
               </c:set>
                <tr>
                  <td><a href="university_employer_eventpreview_jobfair.htm?eventName=<c:out value="${eventList.eventName}"/>&eventId=<c:out value="${eventList.eventId}"/>&eventType<c:out value="${eventList.eventType}"/>"><c:out value="${eventList.eventName}"/></a></td>
                  <td><c:out value="${eventList.eventType}"/></td>
                  <td class="table_leftalign">
                  <fmt:parseDate value="${eventList.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="startDate"/>
           		  <fmt:parseDate value="${eventList.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>
                  <fmt:formatDate type="date" value="${startDate}" pattern="MM-dd-yyyy"/> to 
                  <fmt:formatDate type="date" value="${endDate}" pattern="MM-dd-yyyy"/> <br/>
                    <c:out value="${eventList.startTime}"/> to <c:out value="${eventList.endTime}"/></td>
                  <td class="table_centeralign"><c:out value="${eventList.status}"/></td>
                  
                  <c:choose>
                  <c:when test="${eventList.eventType=='Job Fair'}">
                  		<c:choose>
                  		<c:when test="${eventList.status =='Published' || eventList.status =='Scheduled'}">
                  		<td class="table_centeralign"><a href="university_edit_campusfair.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a></td>
                  		</c:when>
                  		<c:otherwise>
                  		<td class="table_centeralign"><a href="university_edit_campusfair.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
                  		</c:otherwise>
                  		</c:choose>
                  
                  </c:when>
                  <c:when test="${eventList.eventType=='Recruitment'}">
                  <c:choose>
                  		<c:when test="${eventList.status =='Published' || eventList.status =='Scheduled'}">
                  		<td class="table_centeralign"><a href="university_edit_recruitment.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a>
                  		</c:when>
                  		<c:otherwise>
                  		<td class="table_centeralign"><a href="university_edit_recruitment.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
                  		</c:otherwise>
                  		</c:choose>
                  </c:when>
                  <c:when test="${eventList.eventType=='Seminar'}">
                  <c:choose>
                  <c:when test="${eventList.status =='Published' || eventList.status =='Scheduled'}">
                   <td class="table_centeralign"><a href="university_edit_seminar.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a>
                  </c:when>
                  <c:otherwise>
                  <td class="table_centeralign"><a href="university_edit_seminar.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
                  </c:otherwise>
                  </c:choose>
                  </c:when>
                  
                  </c:choose>
                  
                  
                   <c:choose>
      				 <c:when test="${eventList.eventType=='Job Fair' && eventList.status ne 'Published' && eventList.status ne 'Scheduled'}">
                        <td class="table_centeralign"><a href="university_edit_campusfair.htm?event_id=<c:out value="${eventList.eventId}"/>&emailList=<c:out value="${eventList.invitedCompanies}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="#"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 <td class="table_centeralign"><a href="university_edit_campusfair.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 </c:when>
      				 <c:when test="${eventList.eventType=='Recruitment' && eventList.status ne 'Published' && eventList.status ne 'Scheduled'}">
                        <td class="table_centeralign"><a href="university_edit_recruitment.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 </c:when>
      				 <c:when test="${eventList.eventType=='Seminar' && eventList.status ne 'Published' && eventList.status ne 'Scheduled'}">
                        <td class="table_centeralign"><a href="university_edit_seminar.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 </c:when>
      				 <c:otherwise>
      				 <c:choose>      				
      				 <c:when test="${eventStatus!='Cancelled'}">
                        <td class="table_centeralign"><a href="university_edit_seminar.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" class="table_actionbtn"></a><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 </c:when>
      				 <c:otherwise> 
      				<td align="center"><!-- <a onclick="callFunction()"> --><a href="university_event_delete.htm?event_id=<c:out value="${eventList.eventId}"/>&&eventStatus=<c:out value="${eventStatus}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a></td>
      				 </c:otherwise>
      				 
      				 </c:choose>
      				 
      				 </c:otherwise>
				   </c:choose>
                 </tr>
                </c:forEach>
              
              </tbody>
            </table>
          </div>
        </div> --%>
      
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
<script type="text/javascript" src="js/nav_script.js"></script> 

</body>
</html>