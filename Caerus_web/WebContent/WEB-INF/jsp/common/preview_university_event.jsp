<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.util.*" %>  
<%@ page import="java.util.*" %>
<%  			
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String authority = auth.getAuthorities().toString();
		int mid = authority.lastIndexOf("_");
		String role = authority.substring(mid+1, authority.length()-1);
		pageContext.setAttribute("role", role);
		pageContext.setAttribute("userid", auth.getName());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Event Preview </title>
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/theme.css" type="text/css" />

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

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<!-- <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script> -->
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
    // $('#coords').html('Latitute: ' + coords.lat() + '    Longitude: ' + coords.lng() );
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
function myEdit(enventID, eventName)
{
	if(eventName == 'Job Fair'){
		window.location.href='university_edit_campusfair.htm?event_id='+enventID+'&eventNamess='+eventName;
	}
	if(eventName == 'Recruitment'){
		window.location.href='university_edit_recruitment.htm?event_id='+enventID+'&eventNamess='+eventName;
	}
	if(eventName == 'Seminar'){
		window.location.href='university_edit_seminar.htm?event_id='+enventID+'&eventNamess='+eventName;
	}
	
}
</script>
<script>
function goBack()
  {
  window.history.back();
  }
</script>

<script type="text/javascript">

var src;

$(document).ready(function()
{
	var divId = ${eventDetails.divId};
	if(divId!=null)
	{
		$('.event_banner').attr('id','eventDetails'+divId);
	}
		
	$(".relatedjobs li").click(function() 
	{
		var id = $(this).attr("id");
		var newId = 'eventDetails'+id;
		$('.event_banner').attr('id',newId);
		src = $("img", this).prop("src");
		$('#'+newId).css('background-image', 'url('+src+')'); 
	});
});

function saveTemplate(eventId)
{
	if(src!=null)
	{
		$.post("/university_save_event_template.htm?template="+src+'&eventId='+eventId,[window.location.href='university_manage_scheduledevents.htm']);
	}
	else
	{
		window.location.href='university_manage_scheduledevents.htm';
	}
}

</script>

<script>

var eventId = ${eventDetails.eventId};
var univName="${eventDetails.universityId}";
var eventName="${eventDetails.eventName}";


function updateStatus(status)
{
	$.ajax({

	  	
	 	url : 'employer_update_invitation_status.htm?status='+status+'&eventId='+eventId+'&univEmail='+univName+'&eventName='+eventName,						
		cache : false,
		success : function(data) {
				
				$("#successMessage").empty();
				
				if(status == 'Accept'|| status == 'Accepted')
				{
					$("#successMessage").append("You have succesfully subscribed for the event");
				}
				else if(status == 'Reject' || status == 'Rejected')
				{
					$("#successMessage").append("Your declination to the event will be communicated to university");
				}
				else
				{
					$("#successMessage").append("Event Action Successfully Reverted");
				}
				
			      $("#successModal").dialog({
			          
			            modal: true,
			            open: function(event, ui)
			            {
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

function callReceivedInvitationListing()
{
	window.location.href = 'employer_campus_connect.htm?selected=receivedInvitations';
}

function goBack()
{
  	window.history.back();
}
</script>

<script>
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
					$("#successMessage").append("You have succesfully subscribed for the event");
				else
					$("#successMessage").append("Your declination to the event will be communicated to university");
			    
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

function timeoutfunction()
{
	setTimeout(function(){window.location.reload();}, 2510);
} 
</script>


</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
    <%@ include file="includes/header.jsp"%>  
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/university_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>

     
    <div id="innersection">
      	<div id="breadcrums_wrap">You are here: 
      	<c:if test="${role=='UNIVERSITY'}">
      	<a href="university_dashboard.htm">Home</a> \ <a href="university_manage_scheduledevents.htm">Manage Events</a>
		</c:if>
		<c:if test="${role=='STUDENT'}">
      	<a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_broadcasted_corporate_invites.htm">Upcoming Events</a>
		</c:if>
		<c:if test="${role=='CORPORATE'}">
      	<a href="employer_dashboard.htm">Home</a> \ <a href="employer_campus_connect.htm?selected=receivedInvitations">Campus Connect </a>\ Received Invitations
		</c:if>
		</div> 
		<div class="clear"></div>
		<c:if test="${eventDetails.showPublish eq true}">
		<div id = "template_div">		
			
		<h4 class="relatedjobs"> Choose Template </h4>
			<ul class="relatedjobs border_bottom width100">
			    <li id = "1">
			     <span class="jobname"> Basic </span>
			    	<img title="Template 1" src="/images/1.png">
			    </li>
			    <li id = "2">
			     <span class="jobname"> Default </span> 
			    	<img title="Template 2" src="/images/2.png">
			    </li>
			    <li id = "3">
			      <span class="jobname"> Classic </span> 
			    	<img title="Template 3" src="/images/3.png">
			    </li>
			    <li id = "4">
			      <span class="jobname"> Design </span> 
			    	<img title="Template 4" src="/images/4.png">
			    </li>    
		    </ul>
	</div>				
	<div class="clear"></div>
	</c:if>
	<div class="width100 padding_top">
	
      <section id="rightwrap" class="floatleft">
           
        <c:choose>
        <c:when test="${not empty eventDetails.templateName}">
        <c:set var = "templateName" value="${eventDetails.templateName}"></c:set>
      	</c:when>
      	<c:otherwise>
      	<c:set var = "templateName" value="/images/2.png"></c:set>
      	</c:otherwise>
      	</c:choose>
        <div id = "eventDetails" class="event_banner template" 
        	 style="background-image: url(${templateName}); background-size:100%;">
        	<div class="templateholder"> <!-- style="display:none;"  -->
        <h1 class="sectiontitle"><span><c:out value="${eventDetails.eventName}" /></span><c:out value="${universityDetails.universityName}"></c:out></h1>
       
      	<div class="templatedetails">
          <div class="basic_container">
            <div class="floatleft"><img src="images/duration.png" alt="Home" /></div>
         
            <div class="basic_info">
            <fmt:parseDate value="${eventDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="startDate"/>
            <fmt:parseDate value="${eventDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="endDate"/>
            <fmt:formatDate type="date" value="${startDate}" pattern="MM-dd-yyyy"/>  
             to <fmt:formatDate type="date" value="${endDate}" pattern="MM-dd-yyyy"/> <br>
             <c:out value="${eventDetails.startTime}"></c:out> - <c:out value="${eventDetails.endTime}"></c:out><br>
             <c:out value="${eventDetails.venue}" />
             </div>
          </div>
         
          <div class="basic_container">
            <div class="floatleft"><img src="images/venue.png" alt="Email" /></div>
            <div class="basic_info"><c:out value="${universityDetails.universityAddress}"></c:out> <br />
            <a href="view_university_profile.htm?universityName=${universityDetails.universityName}">View University Profile</a>
          </div>
          </div>
          
          <div class="basic_container">
            <div class="floatleft"><img src="images/tel_email2.png" alt="Email" /></div>
            <div class="basic_info"><c:out value="${universityDetails.contactPersonEmailId}"></c:out> <br />
            <c:out value="${universityDetails.phoneNumber}"></c:out>
             <input type="hidden" value="<c:out value="${locAddress}"></c:out>" id="gs02">
             </div>
          </div>
           
           </div>
           <div class="clear"></div>
           
           </div>
         </div>
        
      <c:if test="${role == 'CORPORATE'}"> 
      <c:if test="${inivitationStatus != 'Pending'}">  
      <div class="doubledashed_border">
       <div class="eventdetail_wrap">
        <div class="eventinfo_wrap">
       <div class="event_innerwrap">
        
        <c:if test="${inivitationStatus == 'Accepted' || inivitationStatus == 'Published' || inivitationStatus == 'Scheduled' || inivitationStatus == 'Publish' || inivitationStatus == 'Accept'}">
        
        <div class="event_content_wrap whitebackground"><img src="../mobile_html/images/info_icon.png" alt="Email" /> <span class="boldtxt">This event has been Accepted </span> 
        <c:if test="${not empty date}">
       <span class="boldtxt"> on <c:out value="${date}" /></span>
        </c:if>
        </div>
        </c:if>
        <c:if test="${inivitationStatus == 'Rejected' || inivitationStatus == 'Reject'}">
       
        <div class="event_content_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /> <span class="boldtxt">This event has been Rejected </span>  
        <c:if test="${not empty date}">
        <span class="boldtxt">on <c:out value="${date}" /></span>
        </c:if>
        </div>
        </c:if>
        </div>
       </div>
       </div>
       </div>
       </c:if>  
       </c:if> 
       
       <c:if test="${role=='STUDENT'}">
          <c:if test="${eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,emailId)}">
           	<div class="doubledashed_border">
           	<div class="eventdetail_wrap">
        	<div class="eventinfo_wrap">
     		  <div class="event_innerwrap">
        		<div class="event_content_wrap">
        		 <div><img src="../mobile_html/images/info_icon.png" alt="Email" /> <span class="boldtxt"> Event was Accepted 
				   <c:if test="${not empty acceptedTime}">on <c:out value="${acceptedTime}"/> </c:if> &nbsp; &nbsp; </span></div>
        		</div>
				</div>
				</div>
				</div>
				</div>
   			   </c:if>
   			   
   		<c:if test="${eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,emailId)}">
      		 <div class="doubledashed_border">
      		 <div class="eventdetail_wrap">
        	<div class="eventinfo_wrap">
       		<div class="event_innerwrap">
      		 <div class="event_content_wrap">
      		
    		    <div class="event_content_wrap"><img src="../mobile_html/images/info_icon.png" alt="Email" /> <span class="boldtxt">This event has been Rejected </span> </div>
        	</div>
			</div>
			</div>
			</div>
			</div>
     	 </c:if>
    	</c:if>
    	  
          <div class="clear"></div>
     
     
     <div class="whitebackground">         
        <div class="ofwhitebg">
        
          <h2 class="resume_title floatleft"><c:out value="${eventDetails.eventType}"/> Overview  <c:if test="${role=='CORPORATE'}">
          <div class="floatright right_margin">
           		
				      <c:if test="${(eventDetails.status=='Proposed' || eventDetails.status=='Publish' || eventDetails.status=='Published' || eventDetails.status=='Scheduled') && inivitationStatus == 'Pending'}">
				     	<form class="stdform" action="">
				              <input name="" type="button" value="Accept" tabindex="21" class="yellow_btn" onclick="updateStatus('Accept')">				                
				            </form>
				     	
				      </c:if>	
				      
				      <c:if test="${eventDetails.status == 'Cancelled'}">
				      <form class="stdform" action="">
				              <input name="" type="button" value="Back" tabindex="21" class="yellow_btn" onclick="callReceivedInvitationListing()">				                
				            </form>
				      </c:if>        
          </div>
          </c:if></h2>
         
        <c:if test="${role=='STUDENT'}">
          <c:if test="${(eventDetails.acceptedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,emailId)) &&
         (eventDetails.deniedByStudentsList == null || not fn:containsIgnoreCase(eventDetails.deniedByStudentsList,emailId))}">
   		   
   		   <div class="buttonwrap floatright">
   		       
   		   <a onclick="updateEventUniversity('${eventDetails.eventId}','accept','${eventDetails.eventName}','${eventDetails.universityId }')">
                    <img src="images/thumb_up_icon.png" alt="Accept" align="absmiddle" style="display:inline;"> Accept  &nbsp; &nbsp; &nbsp; &nbsp;</a>
                    
            <a onclick="updateEventUniversity('${eventDetails.eventId}','deny')">
            <img src="images/thumb_down_icon.png" alt="Reject" align="absmiddle" class="displayinline"> Reject  </a> 
                    </div>
                 </c:if>
                 
              <c:if test="${(eventDetails.acceptedByStudentsList != null && fn:containsIgnoreCase(eventDetails.acceptedByStudentsList,emailId)) || (eventDetails.deniedByStudentsList != null && fn:containsIgnoreCase(eventDetails.deniedByStudentsList,emailId))}">
                 <div class="buttonwrap floatright">
                 <a onclick="undoActionUniversity('${eventDetails.eventId}','${eventDetails.eventName}','${eventDetails.universityId }')">
                  &nbsp; &nbsp; &nbsp; &nbsp;<img src="images/undo_icn.png" alt="Undo" align="absmiddle" /> Undo
				   </a>   
            </div>           
        </c:if>
        </c:if>
        
        </div>
         <div class="clear"></div>
        
        <div class="border_dashed">
        <c:choose>
        <c:when test="${eventDetails.eventType == 'Seminar'}">
        <div class="darkgrey_normal"><img src="images/user.png" class="floatleft right_margin" /> Speaker's Name: <span class="dark_greytitle" style="color:#0B99B3;"><c:out value="${eventDetails.speakerName}"/></span></div>
        <p>
        <c:choose>
       	<c:when test="${not empty eventDetails.topic}">
        <c:out value="${eventDetails.topic}"/>
        </c:when>
        <c:otherwise>
        No Topic Available
        </c:otherwise>
        </c:choose>
        </p>
        </c:when>
        <c:otherwise>
        <p> 
        <c:choose>
       	<c:when test="${not empty eventDetails.description}">
        <c:out value="${eventDetails.description}"/>
        </c:when>
        <c:otherwise>
        No Description Available
        </c:otherwise>
        </c:choose>
        </p>
        
        </c:otherwise>
        </c:choose>  
        </div>
         
        </div> 
         <div class="clear"></div>
         <c:if test="${not empty attendingCorporates}">
         <div class="whitebackground margin_top2">         
         <div class="basic_info floatleft width100">
         <!--  <div class="basic_info"> -->
	    	<h2 class="resume_title"> Companies Attending the Event </h2>
		    <ul id="partnersiteslogos" class="border_dashed">
		    <c:forEach items="${attendingCorporates}" var="attendingCorporates">
		    	<li style="width:120px;"><img src="view_image.htm?emailId=<c:out value="${attendingCorporates.firmId}"/>" alt="" title="${attendingCorporates.inviteCompanyName}"></li>
		    </c:forEach>
		    </ul>
		   <!--  </div> -->
   		 </div>
      <div class="clear"></div>
      </div>
      </c:if>
       <div class="whitebackground margin_top2">
        <div style="padding-bottom:10px;" class="padding_top">
   <%-- <input type="text" name="address" id="gs01" value="<c:out value="${cityLoc}"></c:out>" style="width:400px;border:1px solid black" readonly> --%>
   <input type="hidden" value="<c:out value="${cityLoc}"></c:out>" id="gs01">
    
      
   
  <!--  <input type="button" name="search" id="btnsrch" value="Geocode"> -->
 
   <div id="coords"></div>
   <div id="gmap" style="width:757x; height:175px;"></div> 
 </div>
 </div>
 
    <div id="candidate_registration_wrap">
          <form class="stdform" action="">
            <div class="fullwidth_form doubletop_margin">
              <div class="par">
                <div class="buttonwrap">
                <c:if test="${role=='UNIVERSITY'}">  
                <c:if test="${eventDetails.status!='Cancelled'}">
                <c:choose>
                <c:when test="${eventDetails.showPublish eq true}">
                <input name="" type="button" value="Publish" tabindex="17" onclick="saveTemplate(${eventDetails.eventId})"  />                
                </c:when>
                <c:otherwise>
                <input name="" type="button" value="Edit" tabindex="17" onclick="myEdit('<c:out value="${eventDetails.eventId}"/>', '<c:out value="${eventDetails.eventType}"/>')" />
                </c:otherwise>
                </c:choose>
                </c:if>
                  <input name="" type="button" value="Back" tabindex="18" onclick="goBack()" />
                </c:if>
                
                <c:if test="${role=='CORPORATE'}">
                 <c:choose>
                <c:when test="${(eventDetails.status=='Proposed' || eventDetails.status=='Published' || eventDetails.status=='Scheduled') && inivitationStatus=='Pending'}">
                <input name="" type="button" value="Accept" tabindex="17" onclick="updateStatus('Accept')">
                <input name="" type="button" value="Reject" tabindex="17" onclick="updateStatus('Reject')">	
                <input name="" type="button" value="Back" tabindex="17" onclick="callReceivedInvitationListing()">
                </c:when>
                
                <c:when test="${eventDetails.status=='Proposed' && inivitationStatus!='Pending'}">
                <input name="" type="button" value="Undo" tabindex="17"onclick="updateStatus('Undo')">
				<input name="" type="button" value="Back" tabindex="17" onclick="callReceivedInvitationListing()">
                </c:when>
                
                <c:when test="${(eventDetails.status=='Published' || eventDetails.status=='Scheduled' || eventDetails.status=='Cancelled') && inivitationStatus!='Pending'}">
                <input name="" type="button" value="Back" tabindex="17" onclick="callReceivedInvitationListing()">
                </c:when>
                <%-- <c:when test="${(eventDetails.status=='Published' || eventDetails.status=='Scheduled') && inivitationStatus=='Pending'}">
                <input name="" type="button" value="Accept" tabindex="17" onclick="updateStatus('Accept')">
                <input name="" type="button" value="Reject" tabindex="17" onclick="updateStatus('Reject')">	
                <input name="" type="button" value="Back" tabindex="17" onclick="callReceivedInvitationListing()">
                </c:when> --%>
                <c:otherwise>
                <input name="" type="button" value="Back" tabindex="17" onclick="callReceivedInvitationListing()">
                </c:otherwise>
                </c:choose>
                </c:if>  
                <c:if test="${role == 'STUDENT'}">
                <input name="" type="button" value="Back" tabindex="17" onclick="goBack()">
                </c:if>
                </div>
              </div>
            </div>
          </form>
        </div>
      </section>
      </div>
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