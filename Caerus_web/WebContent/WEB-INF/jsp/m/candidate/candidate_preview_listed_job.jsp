<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Job Preview</title>
        <meta name="title" content="">
        <meta name="description" content="">
        <meta name="author" content="Your Name Here">
        <meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

       <!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	})
    }
</script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script> 
<script>
  	$(document).ready(function() {
    	$(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		});
    	//$("#shareJob").hide();
	});
  
	function selectCallback(value, index) {
        alert("SELECTED VALUE: " + value + ", INDEX: " + index);
	}
  
  function toggleEnabled() {
    if ($(".selecter_disabled").is(":disabled")) {
    	$(".selecter_disabled").selecter("enable");
      $(".enable_selecter").hide();
      $(".disable_selecter").show();
    } else {
      $(".selecter_disabled").selecter("disable");
      $(".enable_selecter").show();
      $(".disable_selecter").hide();
    }
    return false;
  }
</script> 

<script type="text/javascript">
function applyCondition(){
	
	 $("#msg").show();
}
function saveCondition(){
	
	 $("#msg").show();
}

function goBack()
{
	window.history.back();
}

function applySavedJob()
{
	
	var jobId = $("#job_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_saved_job.json',						
		cache : false,
		data : 
		{
			jobId: jobId,
			isRecommendedJobs: true
		},	
		
		success : function(data) {
			if(data.exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Job Applied Successfully");
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 

}

function applyJob()
{
	
var jobId = $("#job_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_job.json',						
		cache : false,
		data : 
		{
			jobId: jobId,
			isRecommendedJobs: true
		},	
		
		success : function(data) {
			if(data.exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Job Applied Successfully");
			    
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function saveJob()
{
	var jobId = $("#job_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_save_job.json',						
		cache : false,
		data : 
		{
			jobId: jobId,
		},	
		
		success : function(data) {
			
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Job Saved Successfully");
			    
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

</script>

<script type="text/javascript">
function sendMailtoFriend() {
	var friendEmailId=$("#friendEmailId").val();
	var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if($("#friendEmailId").val().length==0) {
		$("#validationMessage").html("Please enter email-id");
		
	}
	else if(pattern.test(friendEmailId)==false){
		$("#validationMessage").html("Please enter valid email-id");
	}
	else{
		
	var jobId=$("#job_id_and_firm_id").val();
	var jobID=$("#jid").val();
	$.ajax({
 		
		url: 'candidate_preview_listed_job.htm?friendEmailId='+friendEmailId,
		request:"GET",
		data : {
			'friendEmailId' : friendEmailId,
			'jobId' : jobId,
			'jobID' :jobID
		   
		},
		cache : false,
		success : function(data) {
			$("#validationMessage").html("Your mail is sent Successfully");
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}}
function shareJob()
{
	$("#friendEmailId").empty();
}
</script>


<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8" />
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="student">

<div id="main_wrap">
 <%@ include file="includes/header.jsp"%>	
  <div id="mid_wrap" class="midwrap_toppadding">
    <%-- <div id="submenu">
      <ul class="nav nav-pills">
        <li class="active"><a href="candidate_dashboard.htm" >Search<span class="active_arrow"></span></a></li>
        <c:if test="${role!='ANONYMOUS'}">
					<li><a href="candidate_detail_view.htm">Profile</a></li>
					<li><a href="candidate_applied_jobs.htm">Jobs</a></li>
					  </c:if>
      </ul>
    </div> --%>
       
    <div class="clear"></div>
    <section id="inner_container">
          <div class = "error_msg" id = "msg" style="display:none"> Login to Save or Apply for a Job / Register if not a member. </div>
      <div class="jobdetail_wrap">
			<div class="jobdetails">
            	<div class="company_logo float_left">
				<a href="profile_preview.htm?companyName=${job.companyName}">
					<img src="view_image.htm?emailId=${companyID}">
				</a>
				</div>
            	<div class="details float_left clear">
                	 <h1 class="heading"><c:out value="${job.jobTitle}"/></h1>
					 <h2 class="subheading"><c:out value="${job.companyName}"/>,<c:out value="${job.location}"/></h2>
                     <div class="jobtype"><c:out value="${job.jobType}"/>, <span class="postedon">Posted on<fmt:parseDate value="${job.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/><fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
                     </div>  
                     
                   </div>              
            	<div class="applybtn_wrap clear">
                	 <form>
                	 
                	 
                  <c:choose>
                  
                  <c:when test="${role!='ANONYMOUS'}">
                   <c:choose>
                  <c:when test="${appliedJobIdsMap.containsKey(param.jobId)}">
                  <input name="Back" type="button" value="Back" class="orangebuttons" onclick="goBack()">
                  </c:when>
                   <c:when test="${savedJobIdsMap.containsKey(param.jobId)}">
                  <input name="" type="button" value="Apply" onclick="applySavedJob()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:when>
                <c:otherwise>
                 <input name="" type="button" value="Save" onclick="saveJob()" class="orangebuttons" >
                  <input name="" type="button" value="Apply" onclick="applyJob()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:otherwise>
                  </c:choose>
                    </c:when>
                    
                    <c:otherwise>
                    <c:choose>
                  <c:when test="${appliedJobIdsMap.containsKey(param.jobId)}">
                  <input name="Back" type="button" value="Back" class="orangebuttons" onclick="goBack()">
                  </c:when>
                   <c:when test="${savedJobIdsMap.containsKey(param.jobId)}">
                  <input name="" type="button" value="Apply" onclick="applyCondition()" >
                  <input name="" type="button" value="Back" onclick="goBack()">
                </c:when>
                <c:otherwise>
                 <input name="" type="button" value="Save" onclick="saveCondition()" class="orangebuttons">
                  <input name="" type="button" value="Apply" onclick="applyCondition()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:otherwise>
                  </c:choose>
                    </c:otherwise>
                    
                  </c:choose>
                      
                    </form>
                </div>                                
            
              </div>
            <div class="clear"></div>
            <div id="successMessageSpan"></div>
             <h1 class="jobdescp_title orange_font">Job Description</h1>
			<div class="jobdescp_para_wrap"><p class="jobdescp_para"><c:out value="${job.jobDescription}"/></p>
			<input type="hidden" id="job_id_and_firm_id" value="${job.jobIdAndFirmId}" />
			<input type="hidden" id="jid" value="${job.jobId}" />
			<p class="jobdescp_para"></p></div>
            <div id="accordion-container">
    <h2 class="accordion-header">Skills</h2>
    <div class="accordion-content">
    <ul class="keyskillslist">
                        <c:forEach items="${job.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li>
                        </c:forEach>
                        <c:forEach items="${job.secondarySkills}" var="secondarySkills">
                        <li><c:out value="${secondarySkills}"/></li>
                        </c:forEach>
                         </ul>
<div class="clear"></div>

    </div>
    <h2 class="accordion-header">View Contact Detail</h2>
    <div class="accordion-content">
    <p><span class="orange_font boldtxt">Company Name:</span><c:out value="${companyDetails.companyName}"/> <br/>
<span class="orange_font">Name:</span> <c:out value="${companyDetails.contactPersonName}"/><br/>
<span class="orange_font">Phone:</span> ${companyDetails.phoneNumber}<br/>
<span class="orange_font">Email Address:</span> <c:out value="${job.emailId}"/><br/>
<span class="orange_font">Address:</span> <address>
<c:out value="${companyDetails.addressLine1}"/>, <c:out value="${companyDetails.city}"/>, <c:out value="${companyDetails.state}"/>, 
<c:out value="${companyDetails.country}"/> - <c:out value="${companyDetails.postalCode}"/></address>


</div>
    </div>
   <c:if test="${role!='ANONYMOUS'}">
					<form>
						<div id="shareJob" class="clear">
						 <h1 class="jobdescp_title orange_font">Share Job</h1>
                     <span class="field"> <input id="friendEmailId" placeholder="Enter Email ID"  name="friendEmailId" type="text" />
							</span>
							<input type="button" value="Share" class="orangebuttons" onClick="sendMailtoFriend()">
							 
					
							
                     </div>
						
						
						<span id="validationMessage" class="hideValidation"></span>
						
						 <!-- <input name="" type="button" value="Share" class="orangebuttons" onclick="shareJob()"> -->
						</form>
					</c:if>
   
  
      </div>
    </section>
  </div>
     <div id="push"></div>  
</div>

<%--  <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>