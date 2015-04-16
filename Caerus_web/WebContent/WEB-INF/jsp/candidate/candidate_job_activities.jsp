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
<title>Candidate Job Activities</title>
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
<link rel="stylesheet" href="css/dashboard.css">
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
<script type="text/javascript" src="js/jquery.pajinate.js"></script>

<script type="text/javascript">
$(document).ready(function(){
				$('.appliedJob_paging_container').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});

				
				$('.appliedInternship_paging_container').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});

				$('.savedJob_paging_container').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
				
				$('.savedInternship_paging_container').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});

				$('.recommendedjobs_paging_container').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
				
			
    var showChar = 360;
    var ellipsestext = "...";
    var moretext = "READ MORE";
    var lesstext = "COLLAPSE";
    $('.more').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar) {
 
            var c = content.substr(0, showChar);
            var h = content.substr(showChar-1, content.length - showChar);
 
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
 
            $(this).html(html);
        }
        
        $(".saveJob ").attr('id', function(i) {
			  $(this).attr('id', "div" + i);
			});

        $(".applied ").attr('id', function(i) {
			  $(this).attr('id', "siblingDiv" + i);
			});
        
        $(".saveJob img").attr('id', function(i) {
			  $(this).attr('id', "number" + i);
			});

        $(".saveJob .hidden").attr('id', function(i) {
			  $(this).attr('id', "count" + i);
			});


        $(".saveInternship ").attr('id', function(i) {
			  $(this).attr('id', "internshipDiv" + i);
			});

      $(".appliedInternship ").attr('id', function(i) {
			  $(this).attr('id', "siblingInternshipDiv" + i);
			});
      
      $(".saveInternship img").attr('id', function(i) {
			  $(this).attr('id', "q" + i);
			});

      $(".saveInternship .hidden").attr('id', function(i) {
			  $(this).attr('id', "c" + i);
			});
        
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });

    $(".bookmark").mouseover(function() {$(this).attr("src", "images/saved_active_icn.png");});

    $(".bookmark").mouseout(function() { $(this).attr("src", "images/saved_icn.png");});

    var referrer =  document.referrer;
    if(referrer.indexOf("?") > -1)
    {
		var referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.lastIndexOf("?"));        	
    }
	else
    {
		var referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.length);
    }

    var appliedJobsListing = $("#appliedJobsListing").val();
    if(appliedJobsListing != "")
    {
    	$("#e").css('display','none');
    	$("#a").css('display','block');

    	$('#recommendedJobs').removeClass("ui-tabs-active ui-state-active");
    	$('#appliedJobs').addClass("ui-tabs-active ui-state-active");

		sessionStorage.setItem("selectedDiv", "a");
		sessionStorage.setItem("previousTab", "appliedJobs");
		
    }
    else
    {
		var prev=sessionStorage.getItem("selectedTab");
		
		if(referrerUrl === 'candidate_job_activities.htm')
		{
			if(prev === 'c' || prev === 'd')
			{
				$("#appliedJobs").removeClass("ui-tabs-active ui-state-active");
				//$('#'+prev).addClass("ui-tabs-active ui-state-active");
					
				$("#a").css("display", "none");
				$('#'+prev).css("display", "block");
		
				if(prev === 'c')
				{
					$("#savedJobs").addClass("ui-tabs-active ui-state-active");
				}
		
				if(prev === 'd')
				{
					$("#savedInternships").addClass("ui-tabs-active ui-state-active");
				}
				
				sessionStorage.removeItem("selectedTab");
			}
		}
		else
		{
			$("#e").css('display','block');
		}
    }
	$("#recommendedJobs").click(function(){
		$("#e").css('display','block');
		//var prev=sessionStorage.getItem("previousTab");
		//if(!(prev == "savedInternships"))
		switchClass();
		});
	$("#appliedJobs").click(function(){
		$("#a").css('display','block');
		var prev=sessionStorage.getItem("previousTab");
		if(!(prev == "appliedJobs"))
		switchClass();
		});
	$("#appliedInternships").click(function(){
		$("#b").css('display','block');
		switchClass();
		});
	$("#savedJobs").click(function(){
		$("#c").css('display','block');
		var prev=sessionStorage.getItem("previousTab");
		if(!(prev == "savedJobs"))
		switchClass();
		});
	$("#savedInternships").click(function(){
		$("#d").css('display','block');
		var prev=sessionStorage.getItem("previousTab");
		if(!(prev == "savedInternships"))
		switchClass();
		});
	
});
	function switchClass()
	{
		var prev=sessionStorage.getItem("previousTab");
		$('#'+prev).removeClass("ui-tabs-active ui-state-active");

		var selectedDiv = sessionStorage.getItem("selectedDiv");
		$("#"+selectedDiv).css('display','none');
	}

	function applySavedJobFunction(elementId)
	{
		var aId = $('#'+elementId).siblings('input').attr('id');

		var jobId = $('#'+aId).val();

		var divId = $('#'+elementId).parent('div').attr('id');

		var siblingDivId = $('#'+divId).siblings('div').attr('id');

		sessionStorage.setItem("selectedTab", "c");
		sessionStorage.setItem("selectedDiv", "c");
		sessionStorage.setItem("previousTab", "savedJobs");

		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_apply_saved_job.json',						
			
			cache : false,
			data : 
			{
				jobId: jobId
			},	
			
			success : function(exceptionOccured) {
				if(exceptionOccured == true)
				{
					window.location = 'candidate_portfolio.htm?errorMsg='+true;
				}

				else
				{ 
					$("#successMessageSpan").empty();
					$("#successMessageSpan").append("Job Applied Successfully");
				    
				      $("#appliedJobModal").dialog({
				          
				            modal: true,
				            open: function(event, ui){
				                setTimeout("$('#appliedJobModal').dialog('close')",2500);
				            }
			 			});
					
					$("#"+divId).css('display','none');
					$("#"+siblingDivId).css('display','block');

					timeoutfunction(); 
				}
				
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

	function applySavedInternshipFunction(elementId)
	{
		var aId = $('#'+elementId).siblings('input').attr('id');

		var internshipId = $('#'+aId).val();

		var divId = $('#'+elementId).parent('div').attr('id');

		var siblingDivId = $('#'+divId).siblings('div').attr('id');

		sessionStorage.setItem("selectedTab", "d");
		sessionStorage.setItem("selectedDiv", "d");
		sessionStorage.setItem("previousTab", "savedInternships");
		
		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_apply_saved_internship.json',						
			
			cache : false,
			data : 
			{
				internshipId: internshipId
			},	
			
			success : function(exceptionOccured) {

				if(exceptionOccured == true)
				{
					window.location = 'candidate_portfolio.htm?errorMsg='+true;
				}

				else
				{ 
					$("#successMessage").empty();
					$("#successMessage").append("Internship Applied Successfully");
				    
				      $("#appliedInternshipModal").dialog({
				          
				            modal: true,
				            open: function(event, ui){
				                setTimeout("$('#appliedInternshipModal').dialog('close')",2500);
				            }
			 		});
					
					$("#"+divId).css('display','none');
					$("#"+siblingDivId).css('display','block');
	
					timeoutfunction();
			}
			
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
			}); 
		
	}

</script> 


<!--  -->
<script type="text/javascript">
function sendMailtoFriend() {
	var friendEmailId=$("#friendEmailId").val();
	var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if($("#friendEmailId").val().length==0) 
	{
		$("#validationMessage").html("Please enter email-id");
	}
	else if(pattern.test(friendEmailId)==false)
	{
		$("#validationMessage").html("Please enter valid email-id");
	}
	else
	{
		var jobId = localStorage.getItem("clickedJobId");

		console.log("selected job id : "+jobId);

		 $.loader({content:"<div class='dots'> Loading...</div>"}); 
		<!--Ajax -->
		$.ajax({
	 		
			url: 'candidate_preview_listed_job.htm?friendEmailId='+friendEmailId,
			request:"GET",
			data : {
				'friendEmailId' : friendEmailId,
				'jobId' : jobId
			},
			cache : false,
			success : function(data) {
				$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
				$.loader('close');
				$("#validationMessage").html("You've Shared this Job with "+friendEmailId+" Successfully");
			},
			error : function(xhr,error) {
				$.loader('close');
				console.log("Failed");
			}
			}); 
		<!--Ajax -->
		
	}
}
</script>

<script type="text/javascript">
function hideModal()
{
	$("#validationMessage").html("");
	$("#friendEmailId").val("");
}

function applyJob(jobId)
{	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_job.json',						
		cache : false,
		data : 
		{
			jobId: jobId,
			isRecommendedJobs: true
		},	
		
		success : function(exceptionOccured) {
			if(exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Job Applied Successfully");
			    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
			            }
		 			});
				
				timeoutfunction(); 
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function saveJob(jobId)
{
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_save_job.json',						
		cache : false,
		data : 
		{
			jobId: jobId,
			isRecommendedJobs: true
		},	
		
		success : function(data) {
				
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Job Saved Successfully");
			    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
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

<!--  -->

<style>
.saveJob,.saveInternship{cursor:pointer; cursor:hand;}
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
    <div class="clear"></div>
    <div class="container">
    
     <div id="tabs" class="ui-tabs-vertical">
    <ul class="ui-tabs-nav">
        <li id="recommendedJobs">
            <a href="#e" class="education"><span><c:out value="${recommendedJobsCount}"/></span><label>Recommended Jobs</label></a>
        </li>
        <li  id="appliedJobs">
            <a href="#a" class="education blue"><span><c:out value="${appliedJobsCount}"/></span><label>Applied Jobs</label></a>
        </li>
        <li id="appliedInternships">
            <a href="#b" class="education green"><span><c:out value="${appliedInternshipsCount}"/></span><label>Applied Internships</label></a>
        </li>
        <li id="savedJobs">
            <a href="#c" class="education darkblue"><span><c:out value="${savedJobsCount}" /></span><label>Saved Jobs</label></a>
        </li>
        <li id="savedInternships">
            <a href="#d" class="education floragreen"><span><c:out value="${savedInternshipsCount}" /></span><label>Saved Internships</label></a>
        </li>
        
    </ul>
    	
 	<div id="e">
	
		<h1 class="sectionheading">Recommended Jobs <span>(<c:out value="${recommendedJobsCount}"/>)</span></h1>
       
            <div class="clear"></div>
         
         <div class="recommendedjobs_paging_container">
        <div class="job_listing_wrap">
        <c:choose>
    	<c:when test="${recommendedJobsCount == 0}">
     		<div class="error_message_span validationnote">
			<a href="candidate_portfolio.htm"><c:out value="${ noRecommendedJobsMessage }" />   </a></div>
   		</c:when>
   		<c:otherwise>
            <ul class="jobslisting">        
              
            <c:forEach items="${recommendedJobs}" var="recommendedJobDetails">
            <li>
            <input type="hidden" id="appliedJobsListing" value="${appliedJobsListing}">
                <div class="details">
                
                	<div class="jobtitle floatleft"><a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId=<c:out value="${recommendedJobDetails.jobIdAndFirmId}"/>">
                	<c:out value="${recommendedJobDetails.jobTitle}"/></a></div>
                    <div class="floatright jobtype"><c:out value="${recommendedJobDetails.jobType}"/></div>
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">
                  
                    
                    <a href="profile_preview.htm?companyName=<c:out value="${recommendedJobDetails.companyName}"></c:out>">
                    <c:out value="${recommendedJobDetails.companyName}"/></a>	
                    
                    </span>, <c:out value="${recommendedJobDetails.location}"/></div>
                     <div class="description comment more"><c:out value="${recommendedJobDetails.jobDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        
                        <c:forEach items="${recommendedJobDetails.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li> </c:forEach> 
                   
                      </ul>
                      </td>
                  </tr>
                  </table>
                  </div>
                      <div class="actionsbtns">
                   
                  <div class="date"> 
                   <fmt:parseDate value="${recommendedJobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="d"/> <br/> 
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/> </div>
                
			
			<c:out value=""></c:out>
			
			<c:choose>
	             
	             <c:when test="${savedJobIds.contains(recommendedJobDetails.jobIdAndFirmId)}">
	             
	              <div class="buttonwrap">
		              <img src="images/saved_active_icn.png" alt="Save Job">
	                  <br/>Already Saved
                    </div>
	             </c:when>
	             <c:otherwise>
		             <a onclick="saveJob('${recommendedJobDetails.jobIdAndFirmId}')">
		              	<div class="buttonwrap">
			              	<img src="images/saved_icn.png" alt="Save Job" class="bookmark" />
		                    <br/>Save 
	                    </div>
	                 </a>
	             </c:otherwise>
             </c:choose>
                   
                   <a onclick="applyJob('${recommendedJobDetails.jobIdAndFirmId}')">
                  <%--  <input type="hidden" id="job_id_and_firm_id" value="${searchJobs.jobid_and_firmid }">--%>
                     <%-- <a href="candidate_apply_job.htm?isRecommendedJobs=true&jobId=<c:out value="${searchJobs.jobid_and_firmid}"></c:out>"> --%>
                    <div class="buttonwrap"><img src="images/correct_icn.png" alt="Apply Job"> <br/>Apply</div></a> 
                   
                    <a href="#shareJobModal"  onclick="javascript:localStorage.setItem('clickedJobId','${recommendedJobDetails.jobIdAndFirmId}');" data-toggle="modal" >
                    <div class="buttonwrap"><img src="images/share_icn.png" alt="Save Job"><br> Share</div></a>
                    
          </div>
              
                <div class="clear"></div>
            </li>
            </c:forEach> 
                         
          </ul>
          </c:otherwise>
          </c:choose>
          </div>
          
          <c:if test="${recommendedJobsCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
          
          </div>	
	</div>
	 
	<div id="a">
	
		<h1 class="sectionheading">Applied Jobs <span>(<c:out value="${appliedJobsCount}"/>)</span></h1>
       
            <div class="clear"></div>
         
         <div class="appliedJob_paging_container">
        <div class="job_listing_wrap">
        <c:choose>
    	<c:when test="${appliedJobsCount == 0 }">
     		<div class="whitebackground"><c:out value="No Records to Display"/></div>
   		</c:when>
   		<c:otherwise>
            <ul class="jobslisting">        
              
            <c:forEach items="${appliedJobs}" var="appliedJobDetails">
            <li>
            
                <div class="details">
                
                	<div class="jobtitle floatleft"><a href="candidate_preview_listed_job.htm?jobId=<c:out value="${appliedJobDetails.jobIdAndFirmId}"/>"><c:out value="${appliedJobDetails.jobTitle}"/></a></div>
                    <div class="floatright jobtype"><c:out value="${appliedJobDetails.jobType}"/></div>
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">
                  
                    
                    <a href="profile_preview.htm?companyName=<c:out value="${appliedJobDetails.companyName}"></c:out>">
                    <c:out value="${appliedJobDetails.companyName}"/></a>	
                    
                    </span>, <c:out value="${appliedJobDetails.location}"/></div>
                     <div class="description comment more"><c:out value="${appliedJobDetails.jobDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        
                        <c:forEach items="${appliedJobDetails.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li> </c:forEach> 
                   
                      </ul>
                      </td>
                  </tr>
                  </table>
                  </div>
           <div class="actionsbtns">
           <fmt:parseDate value="${appliedJobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                   <div class="date">Posted On
                    <br/> 
                   <fmt:formatDate type="date" value="${formatedDate}" pattern="dd"/>
                   <br/>
                  
                   <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/>
                    <br/>
                     <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/>
                   </div> 
                   <div class="clear">
                   </div>
                   <div class="date">Applied On 
                   <br/>
                    <fmt:parseDate value="${appliedJobDetails.appliedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formattedDate"/>
                    <fmt:formatDate type="date" value="${formattedDate}" pattern="dd"/>
                   
                    <br/> 
                    <fmt:formatDate type="date" value="${formattedDate}" pattern="MMM"/>
                   
                    <br/> 
                    <fmt:formatDate type="date" value="${formattedDate}" pattern="yyyy"/>
                   </div>
            
          </div>
              
                <div class="clear"></div>
            </li>
            </c:forEach> 
                         
          </ul>
          </c:otherwise>
          </c:choose>
          </div>
          
          <c:if test="${appliedJobsCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
          
          </div>	
	</div>
	
	<div id="b">	
	 <h1 class="sectionheading">Applied Internships <span>(<c:out value="${appliedInternshipsCount}"/>)</span></h1>
       
            <div class="clear"></div>
         <div class="appliedInternship_paging_container">
        <div class="job_listing_wrap">
        <c:choose>
    	<c:when test="${appliedInternshipsCount == 0}">
     		<div class="whitebackground"><c:out value="No Records to Display"/></div>
   		</c:when>
   		<c:otherwise>
            <ul class="jobslisting">        
              
            <c:forEach items="${appliedInternships}" var="appliedInternshipDetails">
            <li>
            
                <div class="details">
                
                	<div class="jobtitle floatleft"><a href="candidate_preview_listed_internship.htm?internshipId=<c:out value="${appliedInternshipDetails.jobIdAndFirmId}"></c:out>">
                	<c:out value="${appliedInternshipDetails.jobTitle}"/></a></div>
                    <div class="floatright jobtype"><c:out value="${appliedInternshipDetails.jobType}"/></div>
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">
                    
                    <a href="profile_preview.htm?companyName=<c:out value="${appliedInternshipDetails.companyName}"></c:out>">
                    <c:out value="${appliedInternshipDetails.companyName}"/></a>	
                    
                    
                    </span>, <c:out value="${appliedInternshipDetails.location}"/></div>
                     <div class="description comment more"><c:out value="${appliedInternshipDetails.jobDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        
                        <c:forEach items="${appliedInternshipDetails.primarySkills}" var="primarySkills">
                        	<li><c:out value="${primarySkills}"/></li> 
                        </c:forEach> 
	                    <c:forEach items="${appliedInternshipDetails.secondarySkills}" var="secondarySkills">
	                        <li><c:out value="${secondarySkills}"/></li>
	                    </c:forEach> 
                      </ul>
                      </td>
                  </tr>
                  </table>
                  </div>
           <div class="actionsbtns">
                  <fmt:parseDate value="${appliedInternshipDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                   <div class="date">Posted On
                    <br/> 
                   <fmt:formatDate type="date" value="${formatedDate}" pattern="dd"/>
                   <br/>
                  
                   <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/>
                    <br/>
                     <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/>
                   </div> 
                   <div class="clear">
                   </div>
                   
                   <div class="date">Applied On 
                   <br/>
                    <fmt:formatDate type="date" value="${appliedInternshipDetails.appliedOn}" pattern="dd"/>
                   
                    <br/> 
                    <fmt:formatDate type="date" value="${appliedInternshipDetails.appliedOn}" pattern="MMM"/>
                   
                    <br/> 
                    <fmt:formatDate type="date" value="${appliedInternshipDetails.appliedOn}" pattern="yyyy"/>
                   </div>
            
          </div>
              
                <div class="clear"></div>
            </li>
            </c:forEach> 
                         
          </ul>
          </c:otherwise>
          </c:choose>
          </div>
            <c:if test="${appliedInternshipsCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
   </div>
	</div>
	<div id="c">
	
	<h1 class="sectionheading">My Saved Jobs <span>(<c:out value="${savedJobsCount}" />)</span>
					</h1>

					<div class="clear"></div>

					 <div class="savedJob_paging_container">
					<div class="job_listing_wrap">
						<c:choose>
							<c:when test="${savedJobsCount == 0}">
								<div class="whitebackground"><c:out value="No Records to Display" /></div>
							</c:when>
							<c:otherwise>

								<ul class="jobslisting">

									<c:forEach items="${savedJobs}" var="savedJobDetails">
										<li>

											<div class="details">

												<div class="jobtitle floatleft">
													<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${savedJobDetails.jobIdAndFirmId}"/>"><c:out value="${savedJobDetails.jobTitle}" /></a>
												</div>
												<div class="floatright jobtype">
													<c:out value="${savedJobDetails.jobType}" />
												</div>
												<div class="clear"></div>
												<div class="bottom_margin">
													<span class="orangetxt boldtxt">								
											
					<a href="profile_preview.htm?companyName=<c:out value="${savedJobDetails.companyName}"></c:out>">
                    <c:out value="${savedJobDetails.companyName}"/></a>			
													
													
													</span>,
													<c:out value="${savedJobDetails.location}" />
												</div>
												 <div class="description comment more">
													<c:out value="${savedJobDetails.jobDescription}" />
												</div>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="9%" valign="top" class="keyskillstxt">Key
															Skills</td>
														<td width="91%" valign="top" class="keyskills_padding"><ul
																class="keyskillslist">

																<c:forEach items="${savedJobDetails.primarySkills}"
																	var="primarySkills">
																	<li><c:out value="${primarySkills}" /></li>
																</c:forEach>
															</ul>
														</td>
														
													</tr>
												</table>
											</div>
											<div class="actionsbtns">
												<div class="date">
													Saved On <br />
													
													<fmt:formatDate type="date" value="${savedJobDetails.savedOn}"
														pattern="dd" />
													<br />
													<fmt:formatDate type="date" value="${savedJobDetails.savedOn}"
														pattern="MMM" />
													<br />
													<fmt:formatDate type="date" value="${savedJobDetails.savedOn}"
														pattern="yyyy" />
													<br />
												</div>
												<div class="clear"></div>
												<div>
											
											<c:choose>
											<c:when test="${savedJobDetails.status eq 'Closed' || savedJobDetails.status eq 'closed'}">
												<div class="buttonwrap saveJob" style="cursor: default;">
													<img src="images/correct_icn.png" alt="Apply Job">
													<br /> Job Closed
													<input type ="hidden" id="jobId" value="${savedJobDetails.jobIdAndFirmId}" class="hidden disabled"/>
												</div> 
											</c:when>
											<c:otherwise>
											
															<c:choose>
																<c:when test="${savedJobDetails.appliedFlag}">
																	<div class="buttonwrap">
																		<img src="images/correct_icn_disable.png" alt="Applied">
																		<br />Already Applied
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="buttonwrap saveJob" >
																		<img src="images/correct_icn.png" alt="Apply Job" onclick="applySavedJobFunction(this.id)">
																		<br />Apply
																		<input type ="hidden" id="jobId" value="${savedJobDetails.jobIdAndFirmId}" class="hidden"/>
																		
																	</div> 
																</c:otherwise>
															</c:choose>
																	<%-- <div class="buttonwrap saveJob" >
																			<img src="images/correct_icn.png" alt="Apply Job" onclick="applySavedJobFunction(this.id)">
																			<br />Apply
																			<input type ="hidden" id="jobId" value="${savedJobDetails.jobIdAndFirmId}" class="hidden"/>
																	</div>  --%>
												</c:otherwise>
											
											</c:choose>
												</div>

											</div>

											<div class="clear"></div>

										</li>
									</c:forEach>

								</ul>
							</c:otherwise>
						</c:choose>
					</div>
					
					<c:if test="${savedJobsCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
					
				</div>
	</div>
	<div id="d">
	
	<h1 class="sectionheading">My Saved Internships <span>(<c:out value="${savedInternshipsCount}" />)</span></h1>
			<div class="clear"></div>
					<div class="savedInternship_paging_container">
					<div class="job_listing_wrap">
						<c:choose>
							<c:when test="${savedInternshipsCount == 0}">
								<div class="whitebackground"><c:out value="No Records to Display" /></div>
							</c:when>
							<c:otherwise>

								<ul class="jobslisting">

									<c:forEach items="${savedInternships}" var="savedInternshipDetails">
										<li>

											<div class="details">

												<div class="jobtitle floatleft">
													<a href="candidate_preview_listed_internship.htm?internshipId=<c:out value="${savedInternshipDetails.jobIdAndFirmId}"></c:out>">
													<c:out value="${savedInternshipDetails.jobTitle}" /></a>
												</div>
												<div class="floatright jobtype">
													<c:out value="${savedInternshipDetails.jobType}" />
												</div>
												<div class="clear"></div>
												<div class="bottom_margin">
													<span class="orangetxt boldtxt">
												<a href="profile_preview.htm?companyName=<c:out value="${savedInternshipDetails.companyName}"></c:out>">
                    							<c:out value="${savedInternshipDetails.companyName}"/></a>	
													</span>,
													<c:out value="${savedInternshipDetails.location}" />
												</div>
												 <div class="description comment more">
													<c:out value="${savedInternshipDetails.jobDescription}" />
												</div>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="9%" valign="top" class="keyskillstxt">Key
															Skills</td>
														<td width="91%" valign="top" class="keyskills_padding">
															<ul class="keyskillslist">
																<c:forEach items="${savedInternshipDetails.primarySkills}" var="primarySkills">
																	<li><c:out value="${primarySkills}" /></li>
																</c:forEach>
															</ul>
														</td>
													</tr>
												</table>
											</div>
											<div class="actionsbtns">
											 	<div class="date">
													Saved On <br />
							<fmt:parseDate value="${savedInternshipDetails.savedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
													<fmt:formatDate type="date" value="${formatedDate}"
														pattern="dd" />
													<br />
													<fmt:formatDate type="date" value="${formatedDate}"
														pattern="MMM" />
													<br />
													<fmt:formatDate type="date" value="${formatedDate}"
														pattern="yyyy" />
													<br />
												</div> 
												<div class="clear"></div>
												<div>
												
												<c:choose>
											<c:when test="${savedInternshipDetails.status eq 'Closed' || savedInternshipDetails.status eq 'closed'}">
											<div class="buttonwrap saveJob" >
												<img src="images/correct_icn.png" alt="Apply Internship">
												<br />Apply
												<input type ="hidden" id="internshipId" value="${savedInternshipDetails.jobIdAndFirmId}" class="hidden disabled"/>
											</div> 
											</c:when>
											<c:otherwise>
											<c:choose>
												<c:when test="${savedInternshipDetails.appliedFlag}">
															<div class="buttonwrap appliedInternship">
																<img src="images/correct_icn_disable.png" alt="Applied">
																<br />Already Applied
															</div>
													</c:when>
													<c:otherwise>
													<div class="buttonwrap saveInternship" >
															<img src="images/correct_icn.png" alt="Apply Internship" onclick="applySavedInternshipFunction(this.id)">
															<br />Apply
															<input type ="hidden" id="internshipId" value="${savedInternshipDetails.jobIdAndFirmId}" class="hidden"/> 
																	</div>
																	
												
													</c:otherwise>
													</c:choose>
											
																	<%-- <div class="buttonwrap saveInternship" >
																		<img src="images/correct_icn.png" alt="Apply Internship" onclick="applySavedInternshipFunction(this.id)">
																		<br />Apply
																		 <input type ="hidden" id="internshipId" value="${savedInternshipDetails.internshipIdAndFirmId}" class="hidden"/> 
																	</div> --%>
																	
												
													
													</c:otherwise>
													</c:choose>
												</div>

											</div>

											<div class="clear"></div>

										</li>
									</c:forEach>

								</ul>
							</c:otherwise>
						</c:choose>
					</div>
  			<c:if test="${savedInternshipsCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
      </div>
	</div>
</div>
     
     
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
    
    
      
    <!-- Share Job Modal -->  
	<div id="sendJob">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="shareJobModal">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onClick="hideModal()">x</button>
				<h3 id="myModalLabel">Recommend this job to your Friend</h3>
			</div>
			<div class="modal-body">
				<form class="stdform" action="" method="get" id="mailForm">
					<div class="leftsection_form">
						<div class="par">
							<label class="floatleft">EmailId</label> <span class="star">*</span>
							<div class="clear"></div>
							<span class="field"> <input id="friendEmailId"
								name="friendEmailId" type="text" class="input-medium" />
							</span>
						</div>
						</div>
					
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
						<li><input type="button" value="Send" tabindex="21" class="add_participants floatleft" onClick="sendMailtoFriend()"></li> 
						<li><span id="validationMessage" class="hideValidation"></span></li>
						</ul>
					</div>
					<div class="clear"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>
      
      <!-- Share Job Modal --> 
    
    
    
    
    <!-- Job Applied Modal -->

 <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="appliedJobModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>


<!-- Job Applied Modal -->
    
    
  <!-- Internship Applied Modal -->

 <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="appliedInternshipModal">
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


<!-- Internship Applied Modal -->   
    
    </body>
</html>
