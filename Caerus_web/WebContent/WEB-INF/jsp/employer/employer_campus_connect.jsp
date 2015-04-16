<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Campus Connect</title>
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
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery.pajinate.js"></script>
<script type="text/javascript">
  $(function()
  {
      $('#wysiwyg1').wysiwyg({
    	controls: {
    		increaseFontSize   : { visible : true },
     		decreaseFontSize  : { visible : true }
    			}
  		});
	  $('#wysiwyg2').wysiwyg({
    	controls: {
    		increaseFontSize   : { visible : true },
     		decreaseFontSize  : { visible : true }
    			}
  		});
  });
  
  
  $(document).ready(function(){
  				$('.invitation_received').pajinate({
  					num_page_links_to_display : 3,
  					items_per_page : 4	
  				});
  				$('.invitation_closed').pajinate({
  					num_page_links_to_display : 3,
  					items_per_page : 4	
  				});
  				
  				
  				$(".action").css("display","none");
  					
  					
  				
  				
	/* 	$('.eventwrap li').mouseleave( function() {
  					
  					//alert("mousevoer");
  					$(this).children(".action").css("display","none");
  					
  				 
  				}); */
		$('.eventwrap li').hover( function() {
				
				//alert("mousevoer");
				$(this).children(".action").slideToggle();
				
			 
			});	
  			 	
  				/*  $(".eventwrap li a").mouseover(function(){
  					alert("action");
  					
  					$(this).child(".action").css("display","block");
  					
  				});  */
  				
  });	
  
</script>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
   <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
       <div class="clear"></div>
    </div>
   
    <div id="innersection">
    <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_manage_scheduledevents.htm">Campus Connect</a> / Manage Scheduled Events</div>
 -->
 

	 <section id="rightwrap" class="floatleft">
	 <div class="quickaction_wrap double_padding_bottom"> 
<ul>
 <li><a href="<c:url value="employer_campus_connect.htm"/>">
              <div class="floatleft iconwrap"><img src="images/postajob_icn.png" alt=""></div>
              <div class="floatleft textwrap">Scheduled Events</div>
              </a> </li>
  <li><a href="<c:url value="employer_campus_connect.htm?selected=receivedInvitations"/>">
              <div class="floatleft iconwrap"><img src="images/mail_icn.png" alt=""></div>
              <div class="floatleft textwrap">Received Invitations</div>
              </a> </li>
 
</ul>
</div>
	<c:choose>
	
	<c:when test="${universityInvitations eq true}">
	<div class="floatleft width100">
	<h1 class="sectionheading">Upcoming Events from Campus
	
	<ul class="eventtypelist"><li><img src="images/jobfair_icon.png" alt="Job Fair"><span>Job Fair</span></li><li> <img src="images/seminar_icon.png" alt="Seminar"> <span>Seminar</span></li><li><img src="images/recruit_icon.png" alt="Recruitment"> <span>Recruitment</span></li></ul>
	</h1> 
        <div class="clear"></div>
        <div id="candidate_registration_wrap" class="invitation_received">
          <div class="par">
          <c:choose>
          <c:when test="${empty universityEvents}">
           <label class="emptyMsg"> No Campus invitations received. </label>
          </c:when>
          <c:otherwise>
          
          <ul class="jobslisting eventwrap">
          <c:forEach items="${universityEvents}" var="universityEvent">
          <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="systemDate" />
          <%-- <fmt:formatDate var="UnivendDate" value="${universityEvent.endDate}" pattern="yyyy-MM-dd"/> --%>
         <%--  <fmt:formatDate type="time"  value="${now}" /> --%>
			<%-- <c:if test="${userBirthYear le 1970}"> --%>
          <c:if test="${universityEvent.invitationStatus eq 'Accepted' || universityEvent.invitationStatus eq 'Pending'}">
          <li><%-- ref="preview_university_event.htm?eventId=${universityEvent.eventId}" --%>
         
          <p class="eventtitle"><c:out value="${universityEvent.eventName}"/></p>
          
           <p class="eventstatus">Status: 
           <c:choose>
           <c:when test="${universityEvent.status eq 'Proposed'}"><span class="proposed"><c:out value="${universityEvent.status}"/></span></c:when>
           <c:when test="${universityEvent.status eq 'Published'}"><span class="published"> <c:out value="${universityEvent.status}"/></span></c:when>
           <c:when test="${universityEvent.status eq 'Scheduled'}"><span class="scheduled"> <c:out value="${universityEvent.status}"/></span></c:when>
           <c:otherwise><span class="cancel"> <c:out value="${universityEvent.status}"/></span></c:otherwise>
           </c:choose>
           </p>
         
          <p class="datetime">
          <fmt:parseDate value="${universityEvent.startDate}" type="DATE" pattern="${dbDateFormat}" var="manageStartDate"/>
                  <fmt:parseDate value="${universityEvent.endDate}" type="DATE" pattern="${dbDateFormat}" var="manageEndDate"/>
                  
                 <fmt:formatDate type="date" value="${manageStartDate}" pattern="${displayDateFormat}" /> - <fmt:formatDate type="date" value="${manageEndDate}" pattern="${displayDateFormat}"  />
                <br/><c:out value="${universityEvent.startTime}"/> - <c:out value="${universityEvent.endTime}"/>
          </p>
         
         <p class="line-border">&nbsp;</p>
       
          <span class="eventtype"><%-- <c:out value="${universityEvent.eventType}"/> --%>
         <c:choose>
     	 <c:when test="${universityEvent.eventType eq 'Job Fair'}"><img src="images/event_jobfair.png" alt="" /></c:when>
     	 <c:when test="${universityEvent.eventType eq 'Recruitment'}"><img src="images/event_recruit.png" alt="" /></c:when>
     	 <c:otherwise><img src="images/event_seminar.png" alt="" /></c:otherwise>
         </c:choose>
          </span>
          
          <p class="university_logo">
          <c:choose>
        <c:when test="${not empty universityEvent.universityId}">
        <img src="view_image.htm?emailId=${universityEvent.universityId}" />
        </c:when>
        <c:otherwise>
        <img src="images/Not_available_icon1.png"  />
        </c:otherwise>
        </c:choose>
        </p>
                    <%-- <c:out value="${universityEvent.universityName}"/> --%>
                   
          <p class="action"><a class="floatleft" href="preview_university_event.htm?eventId=${universityEvent.eventId}">Details</a> <a class="floatright" href="employer_update_invitation_status.htm?status=Accepted&eventId=<c:out value="${universityEvent.eventId}"/>&univEmail=<c:out value="${universityEvent.universityId}"/>&eventName=<c:out value="${universityEvent.eventName}"/>">Accept</a> </p>                              
          </li>
         </c:if> 
          
          
          
          
          
          
          </c:forEach>
          </ul>
          
            </c:otherwise>
          </c:choose>
          </div>
          <div class="clear"></div>
          <c:if test="${fn:length(universityEvents) gt 4}">
          <div class="page_navigation"></div>
          </c:if>
        </div>
	
	 
	</div>
	
	
	
	
	
	  <div class="floatleft width100">
	<h1 class="sectionheading">Closed Events from Campus</h1> 
        <div class="clear"></div>
        <div id="candidate_registration_wrap" class="invitation_closed">
          <div class="par">
          <c:choose>
          <c:when test="${empty universityEvents}">
           <label class="emptyMsg"> No Campus invitations received. </label>
          </c:when>
          <c:otherwise>
          
          <ul class="jobslisting eventwrap">
          <c:forEach items="${universityEvents}" var="universityEvent">
          <c:if test="${universityEvent.invitationStatus eq 'Rejected' || universityEvent.invitationStatus eq 'Scheduled' || universityEvent.invitationStatus eq 'Cancelled'}">
          <li>  
          <p class="eventtitle"><c:out value="${universityEvent.eventName}"/></p>
          
           <p class="eventstatus">Status: 
           <c:choose>
           <c:when test="${universityEvent.status eq 'Proposed'}"><span class="proposed"><c:out value="${universityEvent.status}"/></span></c:when>
           <c:when test="${universityEvent.status eq 'Published'}"><span class="published"> <c:out value="${universityEvent.status}"/></span></c:when>
           <c:when test="${universityEvent.status eq 'Scheduled'}"><span class="scheduled"> <c:out value="${universityEvent.status}"/></span></c:when>
           <c:otherwise><span class="cancel"> <c:out value="${universityEvent.status}"/></span></c:otherwise>
           </c:choose>
           </p>
         
          <p class="datetime">
          <fmt:parseDate value="${universityEvent.startDate}" type="DATE" pattern="${dbDateFormat}" var="manageStartDate"/>
                  <fmt:parseDate value="${universityEvent.endDate}" type="DATE" pattern="${dbDateFormat}" var="manageEndDate"/>
                  
                 <fmt:formatDate type="date" value="${manageStartDate}" pattern="${displayDateFormat}" /> - <fmt:formatDate type="date" value="${manageEndDate}" pattern="${displayDateFormat}"  />
                <br/><c:out value="${universityEvent.startTime}"/> - <c:out value="${universityEvent.endTime}"/>
          </p>
         
         <p class="line-border">&nbsp;</p>
       
          <span class="eventtype"><c:out value="${universityEvent.eventType}"/>
         <c:choose>
     	 <c:when test="${universityEvent.eventType eq 'Job Fair'}"><img src="images/event_jobfair.png" alt="" /></c:when>
     	 <c:when test="${universityEvent.eventType eq 'Recruitment'}"><img src="images/event_recruit.png" alt="" /></c:when>
     	 <c:otherwise><img src="images/event_seminar.png" alt="" /></c:otherwise>
         </c:choose>
          </span>
          
          <p class="university_logo">
          <c:choose>
        <c:when test="${not empty universityEvent.universityId}">
        <img src="view_image.htm?emailId=${universityEvent.universityId}" />
        </c:when>
        <c:otherwise>
        <img src="images/Not_available_icon1.png"  />
        </c:otherwise>
        </c:choose>
        </p>
                    <c:out value="${universityEvent.universityName}"/>
                   
          <p class="action"><a class="floatleft" href="preview_university_event.htm?eventId=${universityEvent.eventId}">Details</a> <a class="floatright" href="employer_update_invitation_status.htm?status=Accepted&eventId=<c:out value="${universityEvent.eventId}"/>&univEmail=<c:out value="${universityEvent.universityId}"/>&eventName=<c:out value="${universityEvent.eventName}"/>">Accept</a> </p>                              
         </li>
         </c:if> 
          
          
          
          
          
          
          </c:forEach>
          </ul>
          
            </c:otherwise>
          </c:choose>
          </div>
          <div class="clear"></div>
          <c:if test="${fn:length(universityEvents) gt 4}">
          <div class="page_navigation"></div>
          </c:if>
        </div>
	
	 
	</div> 
	 
	</c:when>
	
	<c:otherwise>
	<div class="whitebackground floatleft width100">
	 <h1 class="sectionheading floatleft">Scheduled Events</h1> 
        <a href="employer_schedule_event.htm" class="nounderline">
        <div class="postajob_wrap"><img src="images/postajob_icn.png" alt="Create an Event" title="Create Event">Create an Event</div>
        </a>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
          <div class="par">
          <c:choose>
          <c:when test="${empty employerEvents}">
          <label class="emptyMsg"> No Events posted by You. <a href="employer_schedule_event.htm">Post an Event soon </a></label>
          </c:when>
          <c:otherwise>
          
             <table class="table table-bordered" id="dyntable_columnthree">
              <thead>
                <tr>
                  <th width="35%" class="table_leftalign">Event Name</th>
                  <th width="20%" class="table_centeralign">University Name</th>
                  <th width="22%" class="table_centeralign">Date &nbsp; / &nbsp; Time</th>
                  <th width="13%" class="table_centeralign">Status</th>
                  <th width="10%" class="table_centeralign nosort">Actions</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${employerEvents}" var="employerEvents">
           		<c:set var="startDate">${employerEvents.startDate}</c:set>
                <tr>
                  <td class="table_leftalign"><a href="employer_event_preview.htm?eventId=<c:out value="${employerEvents.eventId}"/>"><c:out value="${employerEvents.eventName}"/></a></td>
                  <td class="table_leftalign"><c:out value="${employerEvents.participatingUniversity}"/></td>
                  <td  class="table_leftalign">
                   <fmt:parseDate value="${employerEvents.startDate}" type="DATE" pattern="${dbDateFormat}" var="manageEventStartDate"/>
                  <fmt:parseDate value="${employerEvents.endDate}" type="DATE" pattern="${dbDateFormat}" var="manageEventEndDate"/>
                    &nbsp;<strong>From : </strong><fmt:formatDate type="date" value="${manageEventStartDate}" pattern="${displayDateFormat}" />  &nbsp;  <strong>/</strong> &nbsp; <c:out value="${employerEvents.startTime}"/><br/>
                    &nbsp;<strong>To : </strong><fmt:formatDate type="date" value="${manageEventEndDate}" pattern="${displayDateFormat}" /> &nbsp; <strong>/</strong> &nbsp;   <c:out value="${employerEvents.endTime}"/></td>
                  <td class="table_leftalign"><c:out value="${employerEvents.eventStatus}"/></td>
                  <td class="table_centeralign"><a href="employer_schedule_event.htm?eventId=<c:out value="${employerEvents.eventId}"/>"><img src="images/small_edit_icn.gif" alt="Edit" title="Edit" class="table_actionbtn"></a></td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
            </c:otherwise>
          </c:choose>
          </div>
        </div>
	
	</div>
	</c:otherwise>
	
	</c:choose>
	
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