<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>University Dashboard</title>
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
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
  <link rel="stylesheet" href="css/video-js.css" type="text/css" />

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
  <script src="js/video.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
 
  <script type="text/javascript">

  $().ready(function(){

	  /** Code added By BalajiI on 7/10/2014 to retain the page in the dyntable */
	  localStorage.setItem("sourcePage",window.location.pathname);
	  
	  if(localStorage.getItem("lastClickedPageId"))
	  {
			var fiveLink = $("#dyntable_wrapper").find("a.paginate_button:contains("+localStorage.getItem('lastClickedPageId')+")");
			$(fiveLink).trigger('click');
			localStorage.setItem("lastClickedPageId",1);
			
	  }
	  $("#dyntable_wrapper a.paginate_button").click(function(){

	if( Number($(this).text() ) )
	{	
		localStorage.setItem("lastClickedPageId",Number($(this).text()));
	}
	else
	{
		var flag = false;
		
		if($(this).text() === 'Previous')
		{
			var lastId = Number(localStorage.getItem("lastClickedPageId"));
			var newId = Number(lastId - 1);

			localStorage.setItem("lastClickedPageId",newId);
			flag = true;
			
		}

		if($(this).text() === 'Next')
		{
			var lastId = Number(localStorage.getItem("lastClickedPageId"));
			var newId = Number(lastId + 1);
			localStorage.setItem("lastClickedPageId",newId);
			flag = true;
		}

		if(! flag)
			localStorage.setItem("lastClickedPageId",$(this).text());	
	}	
	  });

	  });

  /** Code addition by BalajiI Ends */
  </script>
  
  
  <script type="text/javascript">
  /** Code added by BalajiI and PallaviD */
	function broadcastCampusJob(jobId,count)
	{
		 $.ajax({
			 
			  	type : 'POST',
			 	url : 'university_broadcast_job.json',						
				cache : false,
				data: 'jobId='+jobId,
				success: function (successFlag) 
				{
	                if (successFlag)
		            {
	                	var size = Number($("#jobSize").html());
						if(size !=0){
							size = size - 1;
							}
						
						$("#jobSize").empty();

						$("#jobSize").append(size);

	                     $('a.broadcastJob#'+count).parent().find('a').hide();
	                     $('#JobStatus'+count).html("Broadcasted");
	            		 $("#successMessageSpan").empty().append("You've Successfully Broadcasted the Job");
	            	      $("#chgPasswordModal").dialog({
	            	            modal: true,
	            	            open: function(event, ui){
	            	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
	            	            }
	            });
	                }
	            }
				
		});

		 

	}
	/** Code added by BalajiI and PallaviD */
	function broadcastCampusInternship(internshipId, count)
	{

		 $.ajax({
			 
			  	type : 'POST',
			 	url : 'university_broadcast_internship.json',						
				cache : false,
				data: 'internshipId='+internshipId,
				success: function (successFlag) 
				{
	                if (successFlag)
		            {
	                     $('a.broadcastInternship#'+count).parent().find('a').hide();
	                     $('#InternshipStatus'+count).html("Broadcasted");
	                     $("#successMessageSpan").empty().append("You've Successfully Broadcasted the Internship");
	           	     	 $("#chgPasswordModal").dialog({
	           	            modal: true,
	           	            open: function(event, ui){
	           	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
	           	            }
	            });
	                }
	            }
				
		});
		

		
	}
  </script>
   
 <script type="text/javascript">
$(document).ready(function(){

var userBrowsingPatternsObject = new Object ();

var objappVersion = navigator.appVersion; 
var objAgent = navigator.userAgent; 
var objbrowserName = navigator.appName; 
var objfullVersion = ''+parseFloat(navigator.appVersion);
var objBrMajorVersion = parseInt(navigator.appVersion,10);
var objOffsetName,objOffsetVersion,ix; 
 

// In Chrome 
if ((objOffsetVersion=objAgent.indexOf("Chrome"))!=-1) 
{ 
objbrowserName = "Chrome"; 
objfullVersion = objAgent.substring(objOffsetVersion+7);
 } 

// In Microsoft internet explorer 
else if ((objOffsetVersion=objAgent.indexOf("MSIE"))!=-1)
 { 
objbrowserName = "Microsoft Internet Explorer"; 
objfullVersion = objAgent.substring(objOffsetVersion+5); 
}

 // In Firefox 
else if ((objOffsetVersion=objAgent.indexOf("Firefox"))!=-1) 
{ 
objbrowserName = "Firefox"; 
} 

// In Safari
 else if ((objOffsetVersion=objAgent.indexOf("Safari"))!=-1) 
{ 
objbrowserName = "Safari"; 
objfullVersion = objAgent.substring(objOffsetVersion+7);
 if ((objOffsetVersion=objAgent.indexOf("Version"))!=-1)
 objfullVersion = objAgent.substring(objOffsetVersion+8);
 } 

// For other browser "name/version" is at the end of userAgent
 else if ( (objOffsetName=objAgent.lastIndexOf(' ')+1) < (objOffsetVersion=objAgent.lastIndexOf('/')) ) 
{ 
objbrowserName = objAgent.substring(objOffsetName,objOffsetVersion); 
objfullVersion = objAgent.substring(objOffsetVersion+1);

 if (objbrowserName.toLowerCase()==objbrowserName.toUpperCase()) 
{ 
	objbrowserName = navigator.appName;
} 
}

// trimming the fullVersion string at semicolon/space if present
 if ((ix=objfullVersion.indexOf(";"))!=-1) 
objfullVersion=objfullVersion.substring(0,ix); 

if ((ix=objfullVersion.indexOf(" "))!=-1) 
objfullVersion=objfullVersion.substring(0,ix); 
objBrMajorVersion = parseInt(''+objfullVersion,10); 

if (isNaN(objBrMajorVersion))
 { 
	objfullVersion = ''+parseFloat(navigator.appVersion);
 	objBrMajorVersion = parseInt(navigator.appVersion,10); 
} 

var OSName="Unknown OS";
if (window.navigator.userAgent.indexOf("Windows NT 6.2") != -1) OSName="Windows 8";
if (window.navigator.userAgent.indexOf("Windows NT 6.1") != -1) OSName="Windows 7";
if (window.navigator.userAgent.indexOf("Windows NT 6.0") != -1) OSName="Windows Vista";
if (window.navigator.userAgent.indexOf("Windows NT 5.1") != -1) OSName="Windows XP";
if (window.navigator.userAgent.indexOf("Windows NT 5.0") != -1) OSName="Windows 2000";
if (window.navigator.userAgent.indexOf("Mac")!=-1) OSName="Mac/iOS";
if (window.navigator.userAgent.indexOf("X11")!=-1) OSName="UNIX";
if (window.navigator.userAgent.indexOf("Linux")!=-1) OSName="Linux";

userBrowsingPatternsObject.browserName = objbrowserName;
userBrowsingPatternsObject.browserVersion = objfullVersion;
userBrowsingPatternsObject.os = OSName;

$.get("http://ipinfo.io", function(response) {
	var locationDetails = response.loc.split(",");

  userBrowsingPatternsObject.latitude = locationDetails[0];
  userBrowsingPatternsObject.longitude = locationDetails[1];
  userBrowsingPatternsObject.city = response.city;
  userBrowsingPatternsObject.state = response.region;
  userBrowsingPatternsObject.country = response.country;
  userBrowsingPatternsObject.organization = response.org;
  userBrowsingPatternsObject.ipAddress = response.ip;

  savePattern(userBrowsingPatternsObject);
  
}, "jsonp");

});

function savePattern(userBrowsingPatternsObject)
{
	$.ajax({
		
	  	type : 'POST',
	 	url : 'user_browsing_patterns.htm',						
		dataType : 'json',
		cache : false,
		data : JSON.stringify(userBrowsingPatternsObject),	
		contentType : 'application/json',
		
		success : function(data) {
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
	}); 
		
}

</script> 
  
  
  <script type="text/javascript">
  

  $(document).ready(function() {
 	 	 var successMessage = "<%=request.getParameter("successMessage") %>";
 	     //Code to show success message on successful job post
 	  if (successMessage!=null && successMessage != "null"){
 	  $("#successMessageSpan").append(successMessage);
 	      $("#chgPasswordModal").dialog({
 	            modal: true,
 	            open: function(event, ui){
 	                setTimeout("$('#chgPasswordModal').dialog('close')",2500);
 	            }
  });
 	      
 	  }
  });
  
  
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
	function checkConfirm(){
		var r = confirm("Are you sure want to delete this record ?");
		if (r==true){
		  return true;
		}
		else{
		  return false;
		}	
	}
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
        <div id="banner"><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
   
    <div id="innersection">
      <!--   <div id="breadcrums_wrap">You are here: Dashboard</div> -->
        
        <section id="rightwrap" class="floatleft">
       
       
        <div class="quickaction_wrap">
            <ul>
            <li>
                <div class="top_notifications top_notifications_redbg" id="jobSize"><c:out value="${newJobAlerts}" /></div>
                <a href="university_campus_jobs_internships.htm">
              <div class="floatleft iconwrap"><img src="images/jobalert_icn.png" alt=""></div>
              <div class="floatleft textwrap">New Job Alerts</div>
              </a> </li>
            <li>
                <div class="top_notifications top_notifications_redbg"><c:out value="${noOfUpcomingEvents}" /></div>
                <a href="university_manage_scheduledevents.htm">
              <div class="floatleft iconwrap"><img src="images/calendar_icn.png" alt=""></div>
              <div class="floatleft textwrap">Upcoming Events </div>
              </a> </li>
            <li>
                <div class="top_notifications top_notifications_redbg"><c:out value="${pendingInvitations}" /></div>
                <a href="university_manage_received_invitations.htm">
              <div class="floatleft iconwrap"><img src="images/mail_icn.png" alt=""></div>
              <div class="floatleft textwrap">New Invitations</div>
              </a> </li>
            <li>
            <!-- <div class="top_notifications top_notifications_redbg">2</div> -->
            <a href="university_schedule_anevent.htm">
              <div class="floatleft iconwrap"><img src="images/createprofile_icn.png" alt=""></div>
              <div class="floatleft textwrap">Schedule an Event</div>
              </a> </li>
          </ul>
          </div>
        <div class="clear"></div>
        
        <div class="whitebackground margin_top2">
        
         <div class="actionlegend_wrap floatright ">
                <ul>
                <li>Actions Legends:</li>
                <li><img src="images/green_circle.png">Broadcasted</li>
                <li><img src="images/red_circle.png">Published</li>
               <!--  <li><img src="images/grey_circle.png">Closed</li> -->
              </ul>
         </div>
            <div class="clear"></div>
        
        <h2 class="smallsectionheading">View Published Jobs</h2>
        <div id="tabs" class="doublebottom_margin">
            <ul>
            <li><a href="#tabs-1">Jobs ( <c:out value="${campusJobCount}" /> )</a></li>
            <li><a href="#tabs-2">Internships  ( <c:out value="${campusInternshipCount}" /> )</a></li>
          </ul>
            <div id="tabs-1">

            <div class="clear"></div> 
            <table class="table table-bordered" id="dyntable">
                <thead>
                <tr>
               		<th width="5%" class="table_leftalign">&nbsp;</th>
                    <th width="36%" class="table_leftalign">Job Title</th>
                    <th width="21%" class="table_leftalign">Posted by</th>
                    <!-- <th width="13%" class="table_centeralign">Status</th> -->
                    <th width="13%" class="table_leftalign">Posted on</th>
                    <th width="12%" class="table_leftalign">Responses</th>
                    <th width="10%" class="table_leftalign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                <c:forEach items="${campusJobs}" var="campusJob" varStatus="loopCount"> 
                <tr>                

								<td class="table_centeralign">
									<c:choose>
      									<c:when test="${campusJob.status eq 'Published' }">
                    							<img src="images/red_circle.png" alt=""/>
                    					</c:when>
		                    			<c:when test="${campusJob.status eq 'Broadcasted' }">
		                    				<img src="images/green_circle.png" alt=""/>
		                    			</c:when>
		                    			<c:otherwise>
		                    				<img src="images/grey_circle.png" alt=""/>
		                    			</c:otherwise>
                    			   </c:choose>
								
								</td>

                    				 <td><a href="campus_job_preview.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}" />&universityName=<c:out value="${campusJob.universityName}"/>"><c:out value="${campusJob.jobTitle}" /></a></td>
					                 <td><c:out value="${campusJob.firmName}" /> </td>
					                <%--  <td class="table_centeralign" id="JobStatus${loopCount.count}">
					                 	<c:out value="${campusJob.status}" />
					                 </td> --%>
					                 <td class="table_centeralign">
					                 <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/> --%>
            						<%--  <fmt:formatDate  value="${campusJob.postedOn}" pattern="dd-MM-yyyy"/> --%>
            						  <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                    				  <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy" /> --%>
                    				  
                    				  <c:out value="${campusJob.postedOn}" />
            						</td>
					                 
					                 <c:choose>
					                 <c:when test="${fn:length(campusJob.campusJobAppliedStudents) != 0}">
					                 <td align="center"><a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}" />&universityName=<c:out value="${campusJob.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></a></td>
					                 </c:when>
					                 <c:otherwise>
					                  <td align="center">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></td>
					                 </c:otherwise>
					                 </c:choose>
					       <c:choose>  
					             <c:when test="${campusJob.status eq 'Published'}">
					                 <td class="table_centeralign"><a href="university_dashboard.htm?job_id=<c:out value="${campusJob.jobIdAndFirmId}"/>&job_action=Closed" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
					                 <a  id="${loopCount.count }" class="broadcastJob" onclick="broadcastCampusJob('${campusJob.jobIdAndFirmId}',this.id)" ><img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Job" title="Broadcast Job"></a></td>
                    			</c:when>
                    			
                    			<c:when test="${campusJob.status eq 'Broadcasted'}"> 
                    			 <td class="table_centeralign"><!-- <img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"> --></td> 
                    			</c:when>
                    			
                    			<c:otherwise>
                    			<td class="table_centeralign"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></td>
                    			</c:otherwise>
                    			</c:choose>    
                  </tr>
                  </c:forEach>
               
              </tbody>
              </table>
          </div>
            <div id="tabs-2">

            <div class="clear"></div>
            <table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
					<th width="5%" class="table_leftalign">&nbsp;</th>
                    <th width="31%" class="table_leftalign">Internship Title</th>
                    <th width="14%" class="table_leftalign">Posted by</th>
                   <!--  <th width="13%" class="table_centeralign">Status</th> -->
                    <th width="14%" class="table_centeralign">Posted on</th>
                    <th width="12%" class="table_centeralign">Responses</th> 
                    <th width="10%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${campusInternships}" var="campusInternship" varStatus="loopCount"> 
                <tr>
                				<td class="table_centeralign">
									<c:choose>
      									<c:when test="${campusInternship.status eq 'Published' }">
                    							<img src="images/red_circle.png" alt=""/>
                    					</c:when>
		                    			<c:when test="${campusInternship.status eq 'Broadcasted' }">
		                    				<img src="images/green_circle.png" alt=""/>
		                    			</c:when>
		                    			<c:otherwise>
		                    				<img src="images/grey_circle.png" alt=""/>
		                    			</c:otherwise>
                    			   </c:choose>
								
								</td>
                
                    				<td><a href="campus_internship_preview.htm?internshipId=<c:out value="${campusInternship.internshipIdAndFirmId}" />&universityName=<c:out value="${campusInternship.universityName}"/>"><c:out value="${campusInternship.internshipTitle}" /></a></td>
				                    <td><c:out value="${campusInternship.firmName}" /></td>
				                  <%--   <td class="table_centeralign" id="InternshipStatus${loopCount.count}"><c:out value="${campusInternship.status}" /></td> --%>
				                    <td class="table_centeralign">
				                   <%--  <fmt:parseDate value="${campusInternship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/> --%>
            						<%--  <fmt:formatDate  value="${campusInternship.postedOn}" pattern="dd-MM-yyyy"/> --%>
				               <%--   <fmt:parseDate value="${campusInternship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                    			 <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy" /> --%>
                    			 
                    			   <c:out value="${campusInternship.postedOn}" />
				                  </td>
				                   
				                    <c:choose>
				                    <c:when test="${fn:length(campusInternship.campusInternshipAppliedStudents) != 0}">
				                    <td align="center"><a href="view_campus_internship_responses.htm?internshipIdAndFirmId=<c:out value="${campusInternship.internshipIdAndFirmId}" />&universityName=<c:out value="${campusInternship.universityName}"/>"  class="center_align">
				                    <c:out value="${fn:length(campusInternship.campusInternshipAppliedStudents)}"></c:out></a></td>
				                    </c:when>
				                    <c:otherwise>
				                     <td align="center">
				                    <c:out value="${fn:length(campusInternship.campusInternshipAppliedStudents)}"></c:out></td>
				                    </c:otherwise>
				                    </c:choose>
				                   	<c:choose>
      									<c:when test="${campusInternship.status eq 'Published'}">
						                     <td class="table_centeralign"><a href="university_dashboard.htm?internship_id=<c:out value="${campusInternship.internshipIdAndFirmId}"/>&internship_action=Closed" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a> 
						                     <a id="${loopCount.count}" class="broadcastInternship" onclick="broadcastCampusInternship('${campusInternship.internshipIdAndFirmId}', this.id)"><img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Job" title="Broadcast Internship"></a></td>
                    					</c:when>
                    					<c:when test="${campusInternship.status eq 'Broadcasted'}">
                    						<td class="table_centeralign"><!-- <a href="#"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a> --></td>
                    					</c:when>
                    					<c:otherwise>
                    						 <td class="table_centeralign"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></td>
                    					</c:otherwise>
                    				</c:choose>
                    
                  </tr>
                  
                  </c:forEach>
               
              </tbody>
              </table>
          </div>
          </div>
         </div> 
          
         <div class="whitebackground margin_top2"> 
        <h2 class="smallsectionheading">Corporate Invitations</h2>
        <div class="par">
            <table class="table table-bordered" id="dyntable2">
            <thead>
                <tr>
                <th width="35%" class="table_leftalign">Event Name</th>
                <th width="20%" class="table_leftalign">Company Name</th>
                <th width="22%" class="table_leftalign">Date</th>
                <th width="10%" class="table_centeralign">Status</th>
                <th width="12%" class="table_centeralign">Actions</th>
              </tr>
              </thead>
            <tbody>
            <c:forEach items="${eventList}" var="corporateinvitevar">
                <tr>
                <td><a href="university_preview_corporate_invitation.htm?eventId=<c:out value="${corporateinvitevar.eventId}"/>"><c:out value="${corporateinvitevar.eventName}"></c:out></a></td>
                <td><c:out value="${corporateinvitevar.companyName}"></c:out></td>
                <td class="table_leftalign">
                <fmt:parseDate value="${corporateinvitevar.startDate}" type="DATE" pattern="${dbDateFormat}" var="formatedStartDate"/>
                <fmt:parseDate value="${corporateinvitevar.endDate}" type="DATE"  pattern="${dbDateFormat}" var="formatedEndDate"/>
                <fmt:formatDate type="date" value="${formatedStartDate}"  pattern="${displayDateFormat}" />
			to <fmt:formatDate type="date" value="${formatedEndDate}"  pattern="${displayDateFormat}" /> <br/>
                    <c:out value="${corporateinvitevar.startTime}"></c:out> to <c:out value="${corporateinvitevar.endTime}"></c:out> </td>
                <td class="table_centeralign"><c:out value="${corporateinvitevar.invitationStatus}"></c:out></td>
               
					    <c:choose>
				      <c:when test="${corporateinvitevar.invitationStatus=='Accepted'}">
				      	<td class="table_centeralign"><a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=undo"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a>
				     <a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=Broadcasted"><img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Job" title="Broadcast Job"></a></td>
				      </c:when>	
				      <c:when test="${corporateinvitevar.invitationStatus=='Broadcasted'}">
				      	<td class="table_content center_align"><a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=UndoBroadcast"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>	
				      <c:when test="${corporateinvitevar.invitationStatus=='Rejected'}">
				      	<td class="table_centeralign"><a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=undo"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>				
				      <c:otherwise>
				     	 <td class="table_centeralign" align="center"><a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=Accepted"><img src="images/check_icn.gif" width="16" height="13" class="table_actionbtn"></a> <a href="university_dashboard.htm?event_id=<c:out value="${corporateinvitevar.eventId}"/>&action=Rejected"><img src="images/small_cancel_icn.gif" width="15" height="15" class="table_actionbtn"></a></td>				      	
				      </c:otherwise>
					</c:choose>
              </tr>
              </c:forEach>
                
              </tbody>
          </table>
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
    
    
    
        <!-- Change Password Modal Success Message -->
    
      
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
    <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
                  
    <c:out value="${successMessage}"></c:out>
   </div>
   </div>
  </div>
    
    <!-- Change Password Modal Ends -->
    
    
    
    
  </div>
</body>
</html>