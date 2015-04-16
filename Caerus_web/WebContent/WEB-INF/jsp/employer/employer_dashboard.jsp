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
  <title>Employer Dashboard</title>
  <meta name="description" content="">
  <meta name="author" content="">
  <!--[if lt IE 7]>
	<style type="text/css">appl
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
/*   #chgPasswordModal{
	width:600px !important;
}  */
</style>

  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css">
  <link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
  <link rel="stylesheet" href="css/video-js.css" type="text/css" />
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
  <script src="js/jquery.dropdownPlain.js"></script>
  <script src="js/video.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
  
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

function deleteSavedSearch(){
	return confirm("Are you Sure you want to Delete?");
}


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
			//alert("Failed");
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
	var jobs = $("#jobList").val();
	var campusJobs = $("#campusJobList").val();
	if(jobs == 'jobList' || campusJobs == 'campusJobList')
	{
		$("#tabs").removeClass("borderbottom");
	}
	var invites = $("#receivedInvites").val();
	if(invites == 'receivedInvites')
	{
		$("#invitations").removeClass("borderbottom");
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

  </head>
  <body class="dashboard">
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
  
  
      <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
    <div id="innersection">
		<div class="clear">&nbsp;</div>
       <section id="leftsection" class="floatleft">
    <div class="candidate_quickaction_wrap">
         <!-- <h1 class="sectionheading">Profile Statistics</h1> -->
       
         
         
         
          
    
         
    <div class="portfolio_img"> 
        
          <c:set var="imageName" value="${corporateDetails.imageName}"/>
        <c:choose>
                      <c:when test="${imageName == null}">
                        <img src="images/Not_available_icon1.png" height = "123" width="127">
                      </c:when>
                      <c:otherwise>
                       <img src="view_image.htm?emailId=${corporateDetails.emailID}" height = "123" width="127">
                      </c:otherwise>
                   </c:choose>
               <div class="portfolio_editbtn" style="display:none;"><span class="buttonwrap floatleft"><a href="employer_manage_profile.htm"><img src="images/edit_portfolio.png" alt="Edit Profile" title="Edit Profile" ></span></a></div>
        </div> 
        </div>
          
              
           <div class="line-border clear">&nbsp;</div>
           
           <div class="candidate_quickaction_wrap">
           <ul>
          
          
            
            <li  class="green"> 
             <div class="top_notifications">
                <c:out value="${virtualFairCount}" />
                <a href="employer_virtualfair_invitations.htm">
             
             Virtual Fair Invitations
              </a> </div></li>
              
              <li>
                 <div class="top_notifications"><c:out value="${inviteCount}" />
                <a href="<c:url value="employer_campus_connect.htm?selected=receivedInvitations"/>" style="line-height:23px;">
             
             New Campus <br>Invitations 
              </a> </div></li>
        
             
           
           
           </ul>
      </div>
     
       
       <div class="line-border clear">&nbsp;</div>
      
       <c:if test="${fn:length(savedSearches) != 0}">
      
      <div class="dashboard_searchwrap floatleft width100 margin_top2">
            <h1 class="sectionheading solidborder_bottom left_padding">Saved Searches</h1>
            <div class="par">
           <c:choose>
    	 <c:when test="${fn:length(savedSearches) == 0}">
    	 <label class="emptyMsg"> No Records to display </label>
   		</c:when> 
   		
    		<c:otherwise>
            <ul class="searchlisting">
             <c:forEach items="${savedSearches}" var="savedSearchDetails">
	                <li class="whitebackground">
		                <div class="searchname"><c:out value="${savedSearchDetails.parameterName}"/></div>
		                <div>
		                    <div class="date floatleft">Saved on: 
		                    <fmt:parseDate value="${savedSearchDetails.savedSearchOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                    			<fmt:formatDate type="date" value="${formatedDate}" pattern="dd MMM yyyy E HH:mm" />
		                    </div>
		                    <div class="clear"></div>
		                    <div class="searchbtn floatleft">
		                       <a onclick="return deleteSavedSearch();" href="employer_delete_saved_search.htm?searchParameterName=<c:out value="${savedSearchDetails.parameterName}"/>"><img src="images/delete_icn.png" alt="delete" title="delete"/>
		              		</a> 
		                    </div>
		                    <div class="searchbtn right_margin floatleft">
		                    <a href="employer_saved_search_candidates.htm?searchParameterName=<c:out value="${savedSearchDetails.parameterName}"/>"><img src="images/search_icn.png" alt=""></a>
		               </div>
		                  </div>
		                <div class="clear">
		                </div>
	              </li>
               </c:forEach>
              
                <li class="viewall table_rightalign"><a href="employer_saved_searches.htm">View all</a></li>
               </ul> 
            </c:otherwise>
          </c:choose>
          </div>
          </div>
        </c:if>
        
        
         <div class="line-border clear">&nbsp;</div>
        
        
        <c:if test="${ not empty studentList}">
        <div class="dashboard_searchwrap  whitebackground margin_top2 floatleft width100">
            <h1 class="sectionheading solidborder_bottom left_padding">Recommended Profiles</h1>
            <c:choose>
    <c:when test="${empty studentList}">
    <label class="emptyMsg"> No Records to display </label>
  </c:when>
    <c:otherwise>
            <div class="empdashboard_videowrap">
            
            <ul id="list_example" class="pagination1 empdashboard_videolist">
				  <c:forEach items="${studentList}" var="student">
				 <li style="width=37.8%;" >
				 
				  <video class="video-js vjs-default-skin" controls width="223" height="140"> 
            <!-- MP4 source must come first for iOS -->
            <source type="video/mp4" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- WebM for Firefox 4 and Opera -->
            <source type="video/webm" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- OGG for Firefox 3 -->
            <source type="video/ogg" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
             
            <source type="video/mp3" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
            <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
                  <param name="movie" value="flashmediaelement.swf" />
                  <param name="flashvars" value="controls=true&amp;file=videos/echo-hereweare.mp4" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>        
              <script>var homePlayer=_V_("home_video");</script> 
              
             <a href ="employer_view_candidate_details.htm?emailId=<c:out value="${student.emailID}"/>" style="font-size: 14px;"><c:out value="${student.firstName}" /> <c:out value="${student.lastName}" /></a> <div class="floatright"><c:out value="${student.viewVideoProfileCount}" /> Views</div><br>
              </li>
				 </c:forEach>
				 </ul>
            
              </div>
              </c:otherwise>
   		 </c:choose>
              <br><br>
              <c:if test="${studentListSize gt 2}">
              <a href="employer_view_recommended_candidate_profiles.htm" style="float:right;"> View All &nbsp;</a>
              </c:if>
          </div>
         </c:if> 
          
    </section>     
          
    
       <section id="rightwrap" class="floatleft">  
       
       <div class="quickaction_wrap double_padding_bottom"> 
           
  <ul>            
  <li class="floatleft textwrap"><a href="${EMPLOYER_POST_JOB}">
  		  <div class="floatleft iconwrap"><img src="images/postajob_icn.png" alt=""></div>
           <div class="floatleft textwrap">    
             Publish a Job</div>
              </a> </li>
  
   <li class="floatleft textwrap">
   <a href="${EMPLOYER_POST_CAMPUS_JOB}">
    <div class="floatleft iconwrap"><img src="images/campusjob_icn.png" alt=""></div>
             <div class="floatleft textwrap"> Publish Campus Job</div> 
            
              </a> </li>

</ul>
</div>
     
        <div class="clear"></div>
        <div class="whitebackground">
        <h1 class="sectionheading">Quick Search</h1>
        <div class="doublebottom_margin">
            <form class="stdform" action="employer_search_candidate.htm" method="post" id="searchcandidate">
            
            <div class="floatleft right_margin vallabel"> <span class="field">
            <span class="starright" >*</span>
              <input type="text" name="keyword" class="input-xxlarge1 floatleft" placeholder="Find Candidates On Skills/Locations/Universities/Colleges" />
              </span> </div>
            <div class="floatleft advancesearch_topmargin" style="margin-left:15px;">
			<input name="" type="Submit" value="Search" tabindex="21" class="no_right_margin yellow_btn">
			<div class="clear"></div>
			<div class="floatleft"> <a href="employer_search_candidate.htm"> Advanced Search</a></div>
			</div>
          </form>
            <div class="clear"></div>
            
          </div>
          </div>
          <div class="whitebackground margin_top2">
        <h1 class="sectionheading">Publish Jobs</h1>
        <div id="tabs" class="doublebottom_margin borderbottom">
            <ul>
            <li><a href="#tabs-1">Jobs for All ( <c:out value="${jobCount}" /> )</a></li>
            <li><a href="#tabs-2">Jobs for Campus  ( <c:out value="${campusJobCount}" /> )</a></li>
          </ul>
            <div id="tabs-1">
            <div class="clear"></div>
            <c:choose>
            <c:when test="${empty sortedEmployerJobs}">
            <div class="clear"></div>
            <label class="emptyMsg"> No Jobs posted by You. <a href="employer_post_job.htm">Post a Job soon </a></label>
            </c:when>
           <c:otherwise>
           <input type="hidden" id="jobList" value="jobList">
           <div class="actionlegend_wrap floatright ">
                <ul>
                <li>Actions Legends:</li>
                <li><img src="images/green_circle.png">Posted</li>
                <li><img src="images/red_circle.png">Drafts</li>
                <li><img src="images/grey_circle.png">Closed</li>
              </ul>
              </div>
            <div class="clear"></div>
            <table class="table table-bordered" id="dyntable">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="41%" class="table_centeralign">Job Title</th>
                    <!-- <th width="19%" class="table_centeralign">Posted by</th> -->
                    <th width="13%" class="table_centeralign">Posted on</th>
                    <th width="30%" class="table_centeralign">Responses</th>
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                	
                	<!-- Iterate job list  -->
                	
                	<c:forEach items="${sortedEmployerJobs}" var="sortedEmployerJob">                	
                   <tr>
                		 	<c:choose>
      							<c:when test="${sortedEmployerJob.status =='Draft'}">
                    				<td class="table_leftalign"><img src="images/red_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:when test="${sortedEmployerJob.status =='Published'}">
                    				<td class="table_leftalign"><img src="images/green_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:otherwise>
                    				<td class="table_leftalign"><img src="images/grey_circle.png" alt=""/></td>
                    			</c:otherwise>
                    		</c:choose>
                    		
                    		<td><a href="employer_preview_listed_job.htm?jobId=${sortedEmployerJob.jobIdAndFirmId}"><c:out value="${sortedEmployerJob.jobTitle}" /></a></td>
                    		<%-- <td class="table_leftalign"><c:out value="${sortedEmployerJob.companyName}" /></td> --%>
                    		
                    		<td class="table_centeralign">
                    			<fmt:parseDate value="${sortedEmployerJob.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formatedDate"/>
                    			<fmt:formatDate type="date" value="${formatedDate}" pattern="${jobDateFormat}" />
                    		</td>
                    		
                    		<!-- Profile photos of applied candidates and remaining response count  -->
                    		<c:choose>
                    	
                    		<c:when test="${not empty sortedEmployerJob.jobAppliedStudents && sortedEmployerJob.jobAppliedStudents.size() != 0}">
                    		
                    		<td class="">
                    		<c:forEach items="${sortedEmployerJob.jobAppliedStudents}" var="appliedCandidateMap" begin="0" end="3">
                    		<a href="detail_view_candidate.htm?studentEmailId=<c:out value="${appliedCandidateMap.key}"/>&jobId=<c:out value="${sortedEmployerJob.jobIdAndFirmId}"></c:out>">
                    		<img width="50px" height="50px" src="view_image.htm?emailId=<c:out value="${appliedCandidateMap.key}"/>">
                    		</a>
                    		</c:forEach>
                			
                			
                    		<c:if test="${sortedEmployerJob.responseCount gt 4}">
                    		<div class="responses">
                			<span>+</span>  
                  			<a href="employer_view_job_responses.htm?jobId=<c:out value="${sortedEmployerJob.jobIdAndFirmId}"></c:out>">
                    		<c:out value="${sortedEmployerJob.responseCount - 4}"></c:out>
                    		</a>
                    		</div>
                    		</c:if>
                  
                    	
                    		</td>
                    		</c:when>
                    		
                    		<c:otherwise>
                    		<td class="">No Candidate has yet applied for the Job</td>
                    		</c:otherwise>
                    		</c:choose>
                    		
                    		<td class="table_centeralign">
                    		<c:if test="${sortedEmployerJob.status !='Closed'}">
                    		<a href="employer_edit_posted_job.htm?action=edit&jobIdAndFirmId=<c:out value="${sortedEmployerJob.jobIdAndFirmId}"></c:out>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                    		</c:if>
                    		<a href="employer_copy_job.htm?jobId=<c:out value="${sortedEmployerJob.jobIdAndFirmId}"></c:out>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a>
                    		 <c:choose>
      							<c:when test="${sortedEmployerJob.status !='Published'}">
                   				 <a href="employer_dashboard.htm?jobid=<c:out value="${(sortedEmployerJob.jobIdAndFirmId)}"></c:out>&status=<c:out value="${sortedEmployerJob.status}"/>"  onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                    			</c:when>
                         	</c:choose>
                    		 </td>
                  		</tr>
                  	</c:forEach>
                  
             
                </tbody>
              </table>
               
            </c:otherwise>
            </c:choose>
          </div>
            <div id="tabs-2">
             <div class="clear"></div>
            <c:choose>
            <c:when test="${empty sortedCampusJobs}">
            <div class="clear"></div>
            <label class="emptyMsg"> No Campus Jobs posted by You. <a href="employer_post_campus_job.htm">Post a Job soon </a></label>
            </c:when>
            <c:otherwise>
            <input type="hidden" id="campusJobList" value="campusJobList">
             <div class="actionlegend_wrap floatright ">
                <ul>
                <li>Actions Legends:</li>
                <li><img src="images/green_circle.png">Posted</li>
                <li><img src="images/red_circle.png">Drafts</li>
                <li><img src="images/grey_circle.png">Closed</li>
              </ul>
              </div>
            <div class="clear"></div>
            <table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="26%" class="table_leftalign">Job Title</th>
                    <th width="15%" class="table_leftalign">Posted to</th>
                    <!-- <th width="14%" class="table_leftalign">Posted by</th> -->
                    <th width="13%" class="table_centeralign">Posted on</th>
                    <th width="30%" class="table_centeralign">Responses</th>
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                
                <!-- Iterate campus job list  -->
                 
                  <c:forEach items="${sortedCampusJobs}" var="sortedCampusJob">
                	<tr>
                	
                	<c:choose>
      						<c:when test="${sortedCampusJob.status =='Draft'}">
                    				<td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:when test="${sortedCampusJob.status =='Published'||sortedCampusJob.status =='Broadcasted'}">
                    				<td class="table_centeralign"><img src="images/green_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:otherwise>
                    				<td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
                    			</c:otherwise>
                    </c:choose>
                	
                    
                    	<td><a href="employer_preview_posted_campus_job.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}"/>&universityName=<c:out value="${sortedCampusJob.universityName}" />"><c:out value="${sortedCampusJob.jobTitle}"/></a></td>
                    	<td><c:out value="${sortedCampusJob.universityName}" /></td>
                    	<%-- <td class="table_centeralign"><c:out value="${sortedCampusJob.firmName}" /></td> --%>
                    	<td class="table_centeralign">
                    			<fmt:parseDate value="${sortedCampusJob.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formatedDate"/>
                    			<fmt:formatDate type="date" value="${formatedDate}" pattern="${jobDateFormat}" />
                    	
                    			<%--  <c:out value="${sortedCampusJob.postedOn}" />  --%>
                    	
                    	
                    	</td>
                    	
                    <!-- Profile photos of campus applied candidates and remaining response count  -->
                     <c:choose>
                     
                     	<c:when test="${not empty sortedCampusJob.appliedCampusJobStatusMap && sortedCampusJob.appliedCampusJobStatusMap.size() != 0}">
                    		
                    		<td class="">
                    		<c:forEach items="${sortedCampusJob.appliedCampusJobStatusMap}" var="appliedCandidateMap" begin="0" end="3">
                    		<a href="detail_view_candidate.htm?studentEmailId=<c:out value="${appliedCandidateMap.key}"/>&jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}"></c:out>&campus=true">
                    		<img width="50px" height="50px" src="view_image.htm?emailId=<c:out value="${appliedCandidateMap.key}"/>">
                    		</a>
                    		</c:forEach>
                			
                			
                    		<c:if test="${sortedCampusJob.responseCount gt 4}">
                    		<div class="responses">
                			<span>+</span>  
                  			<a href="view_campus_job_responses.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}">
                    	   </c:out>&universityName=<c:out value="${sortedCampusJob.universityName}"/>"   class="center_align">
                    		<c:out value="${sortedCampusJob.responseCount - 4}"></c:out>
                    		</a>
                    		</div>
                    		</c:if>
                  
                    	
                    		</td>
                    		</c:when>
                    		
                    		<c:otherwise>
                    		<td class="">No Candidate has yet applied for the Job</td>
                    		</c:otherwise>
                     
                     
                     
                    	<%-- 	<c:when test="${fn:length(sortedCampusJob.campusJobAppliedStudents) != 0}">
                    	 <td align="center">
                    	<a href="view_campus_job_responses.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}">
                    	 </c:out>&universityName=<c:out value="${sortedCampusJob.universityName}"/>"   class="center_align">
					      <c:out value="${fn:length(sortedCampusJob.campusJobAppliedStudents)}"></c:out>
					      </a>
					     </td>
                    	</c:when>
                    	<c:otherwise>
                    	<td align="center">
					    <c:out value="${fn:length(sortedCampusJob.campusJobAppliedStudents)}"></c:out></td>
                    	</c:otherwise> --%>
                    	</c:choose> 
                    	
                    	<!-- <td class="table_centeralign"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"> <img src="images/small_copy_icn.gif" class="table_actionbtn"><img src="images/small_magnifier_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></td> -->
                  		<td class="table_centeralign">
                  		<c:if test="${sortedCampusJob.status ne 'Closed'}">
                  		<a href="employer_edit_posted_campus_job.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}"/>&universityName=<c:out value="${sortedCampusJob.universityName}" />"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                  		</c:if>
                  		<a href="employer_copy_campus_job.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}"/>&universityName=<c:out value="${sortedCampusJob.universityName}" />"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a>
                  		<c:if test="${sortedCampusJob.status =='Draft'}">
                  		<a href="employer_delete_campus_job.htm?jobId=<c:out value="${sortedCampusJob.jobIdAndFirmId}"/>&universityName=<c:out value="${sortedCampusJob.universityName}" />" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                  		</c:if>
                         
                  		</td>
                  	</tr>                  
                  </c:forEach>
                  
               
              </tbody>
              </table>
              </c:otherwise>
            </c:choose>
          </div>
          </div>
          </div>
          
          
     <%--  <div class="whitebackground margin_top2">
        <h1 class="sectionheading"><!-- <a href="#"> -->Received Campus Invitations (<c:out value="${eventListsize}" />)<!-- </a> --></h1>
            <div class="par borderbottom" id="invitations">
            <c:choose>
            <c:when test="${empty eventList}">
            <label class="emptyMsg"> No Campus Invitations received. </label>
            </c:when>
            <c:otherwise>
            <input type="hidden" id="receivedInvites" value="receivedInvites">
            <table class="table table-bordered" id="dyntable2">
                <thead>
                <tr>
                    <th width="26%" class="table_centeralign">Event Name</th>
                    <th width="18%" class="table_centeralign">University Name</th>
                    <th width="14%" class="table_centertalign">Event Type</th>
                    <th width="24%" class="table_centeralign">Date</th>
                    <th width="10%" class="table_centeralign">Status</th>
                    <th width="8%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${eventList}" var="eventList">
                <tr>
                    <td><a href="preview_university_event.htm?eventId=${eventList.eventId}"><c:out value="${eventList.eventName}"/></a></td>
                    <td><c:out value="${eventList.universityName}"/></td>
                    <td><c:out value="${eventList.eventType}"/></td>
                    <td class="table_leftalign">
                    <fmt:parseDate value="${eventList.startDate}" type="DATE" pattern="${dbDateFormat}" var="formatedStartDate"/>
                    <fmt:parseDate value="${eventList.endDate}" type="DATE" pattern="${dbDateFormat}" var="formatedEndDate"/>
                    <fmt:formatDate type="date" value="${formatedStartDate}" pattern="${jobDateFormat}" /> to 
                    <fmt:formatDate type="date" value="${formatedEndDate}" pattern="${jobDateFormat}" /> <br/>
                    <c:out value="${eventList.startTime}"/> to <c:out value="${eventList.endTime}"/></td>
                    <td class="table_leftalign"><c:out value="${eventList.invitationStatus}"/></td>
                    <c:choose>
				      <c:when test="${eventList.invitationStatus eq 'Accepted' || invitationStatus.status eq 'Rejected'}">
				      	<td class="table_leftalign"><a href="employer_dashboard.htm?event_id=<c:out value="${eventList.eventId}"/>&action=undo&uni_email=<c:out value="${eventList.universityId}"/>&eventName=<c:out value="${eventList.eventName}"/>"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>				
				      <c:otherwise>
				     	 <td class="table_leftalign">
				     	 	<a href="employer_dashboard.htm?event_id=<c:out value="${eventList.eventId}"/>&action=Accepted&uni_email=<c:out value="${eventList.universityId}"/>&eventName=<c:out value="${eventList.eventName}"/>"><img src="images/check_icn.gif" class="table_actionbtn">
				     	 	</a> 
				     	 	<a href="employer_dashboard.htm?event_id=<c:out value="${eventList.eventId}"/>&action=Rejected&uni_email=<c:out value="${eventList.universityId}"/>&eventName=<c:out value="${eventList.eventName}"/>"><img src="images/small_cancel_icn.gif"  class="table_actionbtn">
				     	 	</a>
				     	 </td>				      	
				      </c:otherwise>
					</c:choose>
                </tr>
        	  </c:forEach>
              </tbody>
              </table>
              </c:otherwise>
            </c:choose>
          </div>
          </div> --%>
          
          
          <!-- New Event Layout (Card Pattern) Starts -->
          
          		<div class=" margin_top2 floatleft width100">
         	<h1 class="sectionheading">Campus Invitations</h1>
          <c:choose>
          
          	<c:when test="${not empty campusEvents}">
          <div id="list" style="display: block;">
          		<%-- <ul id="list_example" class="pagination1">
          		
          	
						
		          
          		
					<c:forEach items="${eventList}" var="eventDetails" varStatus="loopCount">
						<!-- <div class="whitebackground margin_top2"> -->
							 
							<c:if test="${loopCount.index < 6}">
							 
							 <li>
							 
							 <br/>
							  <a href="preview_university_event.htm?eventId=<c:out value="${eventDetails.eventId}"/>">
								 <div>
									<div style="float: left; width: 50%;">
									 	<img src="view_image.htm?emailId=<c:out value="${eventDetails.universityId}" />" height="100px" width="100px" alt="">
				                     </div>
				                     <div style="float: left; width: 50%;">
				                     	<span style="font-style: large; font-weight: bold; color: rgb(75,179,179); display: block;text-align: center;">
				                     	<fmt:parseDate var="origDate"  value="${eventDetails.startDate}" pattern="${dbDateFormat}" />
				                     	<fmt:formatDate value="${origDate}" pattern="${jobDateFormat}" />
				                     	
				                     	</span>
				                     </div>
			                     </div>
			                    <span style="font-style: large; font-weight: bold; color: rgb(75,179,179); display: block;text-align: center;">${eventDetails.eventName }</span>	
			                    <br>
			                     <span style="font-style: large; font-weight: bold; color: rgb(75,179,179); display: block;text-align: center;">${eventDetails.universityName }</span>
			                     
			                     	<ul><li><c:out value="${eventDetails.universityName}" /></li><br><li> <c:out value="${eventDetails.startDate}" /></li></ul><br><c:out value="${eventDetails.eventType}" /></p>
			                   </a>
		                     </li>
		                 </c:if>
		                     
		                     
	                     <!-- </div>   -->
	               </c:forEach>   
              </ul> --%>
              
              <table cellspacing="0" cellpadding="0" id="list_example" width="100%">
          	
						
		          
          		
					
						<!-- <div class="whitebackground margin_top2"> -->
							
							 
							 <tr>
							 <c:forEach items="${campusEventsFirstDiv}" var="eventDetails" varStatus="loopCount"> 
							 
							 <td style="width:23%;" class="whitebackground"> 
								 
									 	<a href="preview_university_event.htm?eventId=<c:out value="${eventDetails.eventId}"/>">
									<div class="floatleft" style="width:35%;">
									
				                     	<img src="view_image.htm?emailId=<c:out value="${eventDetails.universityId}" />" height="100px" width="100px" alt=""  class="floatleft">
				                     	
				                     	
									 	</div>
									 	<div class="floatleft" style="width:60%;">
									 		
				                     
			                 
			                    <span>${eventDetails.eventName }</span>	
			                    <br>
			                     <span style="color:#000;" >${eventDetails.universityName }</span>
			                 <%--     <c:out value="${eventDetails.universityName}" /> --%>
			                      <br>
			                    <%--  <c:out value="${eventDetails.startDate}" />  --%>
			                    <span style="color:#000;" >
			                    <fmt:parseDate var="origDate"  value="${eventDetails.startDate}" pattern="${dbDateFormat}" />
				                <fmt:formatDate value="${origDate}" pattern="${jobDateFormat}" />
				                </span>
			                    <br>
			                      <span style="color:#E5A742;"><c:out value="${eventDetails.eventType}" /></span>
			                     	
			                     </div>	
			                   </a>
			                   </td>
			                   <td style="width:2%;"></td>
			                     </c:forEach>
			                     
			                     </tr>
			                     
			                 <tr>
			                 	<td style="height: 20px;">&nbsp;</td>
			                 </tr>    
		                     
		                     <tr>
		                     
			                 <c:forEach items="${campusEventsSecondDiv}" var="eventDetails" varStatus="loopCount"> 
		                     <td style="width:23%;" class="whitebackground"> 
								 <a href="preview_university_event.htm?eventId=<c:out value="${eventDetails.eventId}"/>">
									<div class="floatleft" style="width:35%;">
									 	<img src="view_image.htm?emailId=<c:out value="${eventDetails.universityId}" />" height="100px" width="100px" alt=""  class="floatleft">
									 	
									 	</div>
									 	<div class="floatleft" style="width:60%;">
									 		
				                     
			                 
			                    <span>${eventDetails.eventName }</span>	
			                    <br>
			                     <span style="color:#000;">${eventDetails.universityName }</span>
			                 <%--     <c:out value="${eventDetails.universityName}" /> --%>
			                      <br>
			                    <%--  <c:out value="${eventDetails.startDate}" />  --%>
			                    <span style="color:#000;">
			                    <fmt:parseDate var="origDate"  value="${eventDetails.startDate}" pattern="${dbDateFormat}" />
				                <fmt:formatDate value="${origDate}" pattern="${jobDateFormat}" />
				                </span>
			                    <br>
			                    <span style="color:#E5A742;"><c:out value="${eventDetails.eventType}" /></span>
			                     	
			                     </div>	
			                   </a>
			                   </td>
			                   <td style="width:2%;"></td>
		                     </c:forEach> 
			                   </tr>
		                     
		                   <%--  </c:forEach>  --%>
		                    
	                     <!-- </div>   -->
	             
          </table>
              
          </div>
          	</c:when>
          	<c:otherwise>
          		<div class="whitebackground floatleft" style="width:99%;">No Campus Invitations</div>
          		
          	
          	</c:otherwise>
          	
          </c:choose>
		</div>		
          
       
          
		
		 <!-- New Event Layout (Card Pattern) Ends -->
		
          <div class="clear">&nbsp;</div>
      
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
    
      
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal" >
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
  <script type="text/javascript">
  
  $("#searchcandidate").validate({
		rules: {
			keyword:"required",
		},
		messages: {
			keyword:"Please enter keyword",
			
		}
	});
</script>
<script>
	function checkConfirm(){
		var r=confirm("Are you sure want to delete this record ?");
		if (r==true){
		  return true;
		}
		else{
		  return false;
		}	
	}
</script>
</body>
</html>