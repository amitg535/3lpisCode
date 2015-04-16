<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Preview Broadcasted Invites</title>
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
</script>

<script>
function goBack()
{
 	 window.history.back();
}

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

function updateEventUniversity(eventId,status,eventName,universityId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'update_candidate_action_on_university_event.htm?eventId='+eventId,						
		cache : false,
		data:
		{
			status: status,
			eventName: eventName,
			universityId: universityId
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

function undoActionUniversity(eventId,eventName,universityId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'undo_candidate_action_on_university_event.htm?eventId='+eventId,						
		cache : false,
		data:
		{
			eventName: eventName,
			universityId: universityId
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

<script type="text/javascript" src="js/jquery.pajinate.js"></script>
		<script type="text/javascript">

    		$(document).ready(function(){
				$('.paging_container8').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
			});     
                
	</script>  

</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
 
 
   <%@ include file="includes/header.jsp"%>
  
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     <div id="innerbanner">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div> 
   
   
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ Upcoming Events</div> -->
      <section id="rightwrap" class="floatleft">
     
     <h1 class="sectionheading"> Upcoming Events (${count})</h1>
      <c:choose>
            <c:when test="${empty allEventsList}">
              <div class="whitebackground"><c:out value="NO RESULTS FOUND"></c:out></div>
             </c:when>
		<c:otherwise>
		<div class="paging_container8">
        <div class="job_listing_wrap">
            <ul class="jobslisting">        
            
             
            <c:forEach items="${allEventsList}" var="upcomingEvents">             
            
            <li>
           
                <div class="details">
                <c:set var="studentEmailId" value="${studentEmailId}" />
                <c:choose>
                <c:when test="${upcomingEvents.universityFlag eq false}">
                <div class="jobtitle floatleft width100">
<div class="floatleft" style="width:10%;">
<img src="images/jobfair_icon.png"></div>
<div class="floatleft" style="width:90%;"><a href="candidate_preview_received_corporate_invite.htm?event_id=<c:out value="${upcomingEvents.eventId}"/>"><c:out value="${upcomingEvents.eventName}"/></a>
                <p>
                 <c:choose>
                	<c:when test="${upcomingEvents.differenceInDays ne 0}">
                	(<c:out value="${upcomingEvents.differenceInDays}" /> Days To Go)
                	</c:when>
                	<c:otherwise>
                	(Ongoing Event)
                	</c:otherwise>
                	</c:choose>
                </p>
                <p>
                	 <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                    <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
                    <strong>Date:</strong> <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd-MM-yyyy"/> &nbsp; To &nbsp; <fmt:formatDate type="date" value="${formatedEndDate}" pattern="dd-MM-yyyy"/>
                     &nbsp;&nbsp;&nbsp;<strong>Time:</strong> <c:out value="${upcomingEvents.startTime}" /> &nbsp; To  &nbsp;<c:out value="${upcomingEvents.endTime}" /></p>
               <div>Posted By:<c:out value="${upcomingEvents.companyName}"/></div>
                </div>
                </div>
                 
                
                </c:when>
                <c:otherwise>
                 
                 <div class="jobtitle floatleft width100">
                	<div class="floatleft" style="width:10%;">
                	<c:choose>
                	<c:when test="${upcomingEvents.eventType == 'Job Fair'}">
                	<img src="images/jobfair_icon.png" />
                	</c:when>
                	<c:when test="${upcomingEvents.eventType == 'Seminar'}">
                	<img src="images/seminar_icon.png" />
                	</c:when>
                	<c:otherwise>
                	<img src="images/recruit_icon.png" />
                	</c:otherwise>
                	</c:choose>
                	</div>
                	<div class="floatleft" style="width:90%;">
                	 
                	<div class="floatleft"> <a href="preview_university_event.htm?eventId=${upcomingEvents.eventId}"><c:out value="${upcomingEvents.eventName}"/></a></div>
                	<%-- <c:out value="${upcomingEvents.eventType}"/>) --%>
                	<div class="clear">
                	<c:choose>
                	<c:when test="${upcomingEvents.differenceInDays ne 0}">	
                	(<c:out value="${upcomingEvents.differenceInDays}" /> Days To Go)
                	</c:when>
                	<c:otherwise>
                	<p>(Ongoing Event)</p>
                	</c:otherwise>
                	</c:choose>
                	<p>
                	 <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                    <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
                    <strong>Date:</strong> <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd-MM-yyyy"/> &nbsp; To &nbsp; <fmt:formatDate type="date" value="${formatedEndDate}" pattern="dd-MM-yyyy"/>
                     &nbsp;&nbsp;&nbsp;<strong>Time:</strong> <c:out value="${upcomingEvents.startTime}" /> &nbsp; To  &nbsp;<c:out value="${upcomingEvents.endTime}" /></p>
                    </div>
                	 </div>
               </div>
                </c:otherwise>
                </c:choose>
              
                	
                     
                    <div class="clear"></div>    
    
                   
					
                </div>
                <c:choose>
                <c:when test="${upcomingEvents.universityFlag eq false}">
                <c:if test="${upcomingEvents.acceptedByStudentsList != null && fn:containsIgnoreCase(upcomingEvents.acceptedByStudentsList,studentEmailId)}">
				<div class="actionsbtns">
				  <div class="buttonwrap fontsize16">Attending  </div>
				  <a onclick="undoActionCorporate('${upcomingEvents.eventId}','${upcomingEvents.eventName}','${upcomingEvents.firmId }')">
				  <div class="buttonwrap"><img src="images/undo_icn.png" alt="Undo Step"> <br/>Undo</div></a>
				 </div>
				</c:if>
				
				<c:if test="${upcomingEvents.deniedByStudentsList != null && fn:containsIgnoreCase(upcomingEvents.deniedByStudentsList,studentEmailId)}">
				 <div class="actionsbtns">
				  <div class="buttonwrap">Rejected <br><br> </div>
				   <a onclick="undoActionCorporate('${upcomingEvents.eventId}','${upcomingEvents.eventName}','${upcomingEvents.firmId }')">
				   <div class="buttonwrap"><img src="images/undo_icn.png" alt="Undo Step"> <br/>Undo</div></a>
				 </div>
		
				</c:if>
				
				<c:if test="${(upcomingEvents.acceptedByStudentsList == null || not fn:containsIgnoreCase(upcomingEvents.acceptedByStudentsList,studentEmailId)) && 
				(upcomingEvents.deniedByStudentsList == null || not fn:containsIgnoreCase(upcomingEvents.deniedByStudentsList,studentEmailId))}">
                 <div class="actionsbtns">
                   
                    <a onclick="updateEventCorporate('${upcomingEvents.eventId}','accept','${upcomingEvents.eventName}','${upcomingEvents.firmId}')">
                    <div class="buttonwrap"><img src="images/thumb_up_icon.png" alt="Accept"> <br/>Accept </div></a>
                    <a onclick="updateEventCorporate('${upcomingEvents.eventId}','deny')">
                    <div class="buttonwrap"><img src="images/thumb_down_icon.png" alt="Reject"> <br/>Reject </div></a>               
		          </div> 
		          </c:if>
                </c:when>
                <c:otherwise> 
                <c:if test="${upcomingEvents.acceptedByStudentsList != null && fn:containsIgnoreCase(upcomingEvents.acceptedByStudentsList,studentEmailId)}">
				 <div class="actionsbtns">
				  <div class="buttonwrap fontsize16">Attending</div>
				  <a onclick="undoActionUniversity('${upcomingEvents.eventId}','${upcomingEvents.eventName}','${upcomingEvents.universityId }')">
				  <div class="buttonwrap"><img src="images/undo_icn.png" alt="Undo Step"> <br/>Undo</div></a>
				 </div>
		
				</c:if>
				
				<c:if test="${upcomingEvents.deniedByStudentsList != null && fn:containsIgnoreCase(upcomingEvents.deniedByStudentsList,studentEmailId)}">
				 <div class="actionsbtns">
				  <div class="buttonwrap">Rejected <br><br> </div>
				   <a onclick="undoActionUniversity('${upcomingEvents.eventId}','${upcomingEvents.eventName}','${upcomingEvents.universityId }')">
				  <div class="buttonwrap"><img src="images/undo_icn.png" alt="Undo Step"> <br/>Undo</div></a>
				 </div>
		
				</c:if>
				
				<c:if test="${(upcomingEvents.acceptedByStudentsList == null || not fn:containsIgnoreCase(upcomingEvents.acceptedByStudentsList,studentEmailId)) &&
				(upcomingEvents.deniedByStudentsList == null || not fn:containsIgnoreCase(upcomingEvents.deniedByStudentsList,studentEmailId))}">
               <div class="actionsbtns">
                   
                    <a onclick="updateEventUniversity('${upcomingEvents.eventId}','accept','${upcomingEvents.eventName}','${upcomingEvents.universityId }')">
                    <div class="buttonwrap"><img src="images/thumb_up_icon.png" alt="Accept"> <br/>Accept </div></a>
                    <a onclick="updateEventUniversity('${upcomingEvents.eventId}','deny')">
                    <div class="buttonwrap"><img src="images/thumb_down_icon.png" alt="Reject "> <br/>Reject </div></a>
              
          </div> 
          </c:if>
                </c:otherwise>
                </c:choose>
               
				
          
                <div class="clear"></div>
                
            </li>
          
             </c:forEach>       
           
             
         </ul>
       
          </div>
          
          <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
          
          </div>
          </c:otherwise>
          </c:choose>
      
      <div class="clear"></div>
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