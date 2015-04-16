<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Candidate Preview of a Job</title>
		<meta name="description" content="">
		<meta name="author" content="">
		
		<!-- Facebook Shared Job properties  -->
		<meta property="og:title" content="${job.jobTitle}" />
		<meta property="og:image" content="view_image.htm?emailId=${companyID}" />
		<meta property="og:decription" content="${job.jobDescription}"  />
		
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
		<link rel="stylesheet" href="css/dashboard.css" type="text/css" />
		<link rel="stylesheet" href="css/uielements/bootstrap.css" 			type="text/css" />
		<link rel="stylesheet" href="css/uielements/uniform.tp.css"			type="text/css" />
		<link rel="stylesheet" href="css/uielements/jquery.ui.css"			type="text/css" />
		<link rel="stylesheet" href="css/uielements/jquery.chosen.css"			type="text/css" />
		<link rel="stylesheet" href="css/uielements/style.default.css"			type="text/css" />
		<link rel="stylesheet" href="css/jquery-loader.css"			type="text/css" />
		<link rel="stylesheet" href="css/dots.css" type="text/css">
		<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />
		<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
		<script type="text/javascript"			src="js/uielements/prettify.js">
		</script>
		<script type="text/javascript"
			src="js/uielements/jquery-ui-1.9.2.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/jquery.cookie.js">
		</script>
		<script type="text/javascript"	src="js/uielements/jquery.validate.min.js">
		</script>
		<script type="text/javascript"	src="js/webwidget_menu_glide.js">
		</script>
		<script type="text/javascript" src="js/script.js"></script>
		<script type="text/javascript"	src="js/uielements/jquery.dataTables.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/bootstrap.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/bootstrap-timepicker.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/jquery.uniform.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/jquery.tagsinput.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/charCount.js">
		</script>
		<script type="text/javascript"	src="js/uielements/ui.spinner.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/chosen.jquery.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/modernizr.min.js">
		</script>
		<script type="text/javascript"	src="js/uielements/detectizr.min.js">
		</script>
		<script type="text/javascript" src="js/uielements/custom.js"></script>
		<script src="js/jquery.dropdownPlain.js"></script>
		<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
		<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
		<script type="text/javascript" src="js/jquery-loader.js"></script>
		<script type="text/javascript">
			$(function() { $('#wysiwyg1').wysiwyg({ controls: {
			increaseFontSize : { visible : true }, decreaseFontSize : {
			visible : true } } }); $('#wysiwyg2').wysiwyg({ controls: {
			increaseFontSize : { visible : true }, decreaseFontSize : {
			visible : true } } }); });
		</script>
		<script type="text/javascript">
			function getJobs(elementId) { 
			var formId = $('#' +
			elementId).parents('form').attr('id');
			$("#"+formId).submit(); }

			function sendMailtoFriend() { var
			friendEmailId=$("#friendEmailId").val(); var pattern = new
			RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");

			if($("#friendEmailId").val().length==0) {
			$("#validationMessage").html("Please enter email-id");

			} else if(pattern.test(friendEmailId)==false){
			$("#validationMessage").html("Please enter valid email-id");
			} else{

			var jobId=$("#job_id_and_firm_id").val(); var
			jobID=$("#jid").text(); $.loader({content:"<div	class='dots'> Loading...</div>"}); $.ajax({

			url:
			'candidate_preview_listed_job.htm?friendEmailId='+friendEmailId,
			request:"GET", data : { 'friendEmailId' : friendEmailId,
			'jobId' : jobId, 'jobID' :jobID

			}, cache : false, success : function(data) {
			$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
			$.loader('close'); $("#validationMessage").html("Your mail is sent Successfully"); }, failure : function() {
			$.loader('close'); alert("Failed"); } }); }}
		</script>

		<script>
			var referrer; var referrerUrl; $(document).ready(function ()
			{

			 var resultCountMap = $("#resultCountMap").val();

			if(null == resultCountMap || resultCountMap == '0') {
			$("body").removeClass("dashboard");
			$("#leftsection").hide(); }

			var referrer = document.referrer; 
			if(referrer.indexOf("?") > -1) { 
			referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1,
			referrer.lastIndexOf("?")); }
			else { referrerUrl =	referrer.substring(referrer.lastIndexOf("/") + 1,
			referrer.length); 
			} });

			function goBack() { if(referrerUrl === 'welcome.htm' ||	referrerUrl === 'candidate_dashboard.htm') { 
			window.location	= 'candidate_dashboard.htm'; } 
			else { window.history.back();
			}

			}


			function timeoutfunction() { if(referrerUrl ===	'candidate_job_activities.htm') {
			setTimeout(function()
			{window.location='candidate_job_activities.htm';},
			2510); }

			if(referrerUrl === 'candidate_recommended_jobs.htm') {
			setTimeout(function()
			{window.location='candidate_recommended_jobs.htm';},
			2510); }

			if(referrerUrl === 'candidate_search_jobs_internships.htm')
			{ setTimeout(function(){window.history.back();}, 2510); } }

		</script>
		<script type="text/javascript">
			function hideModal() { $("#validationMessage").html("");
			$("#friendEmailId").val(""); }
		</script>
		
		<!-- LinkediIn Share Job  -->
		<script type="text/javascript" src="http://platform.linkedin.com/in.js">
         api_key: 75eflau76qbl9b
        </script>
	
	
		<!-- Facebook Share Job  -->
		<script>
		  window.fbAsyncInit = function() {
		    FB.init({
		      appId      : '728597353893552',
		      xfbml      : true,
		      version    : 'v2.2'
		    });
		  };
		
		  (function(d, s, id){
		     var js, fjs = d.getElementsByTagName(s)[0];
		     if (d.getElementById(id)) {return;}
		     js = d.createElement(s); js.id = id;
		     js.src = "//connect.facebook.net/en_US/sdk.js";
		     fjs.parentNode.insertBefore(js, fjs);
		   }(document, 'script', 'facebook-jssdk'));
		</script> 

</head>
<body class="dashboard">

<!-- div for Facebook Share Job -->
<div id="fb-root"></div>


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
    
    <input type="hidden" id="resultCountMap" value="${fn:length(resultCountMap)}"> 
   <section id="leftsection" class="floatleft">
      <%@ include file="includes/browse_jobs.jsp"%>
       </section> 
    
       
       <% String jobId =(String) request.getParameter("jobId"); %>
       
      <section id="rightwrap" class="floatleft">
     <!--  <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">\ Preview of a job </a> </div> -->
      
      <div>
      <!-- Share Functions  -->
      
      <ul class="actions_icns floatright top_margin">
     <c:choose>
     <c:when test="${job.status ne 'Closed' || !job.status ne 'closed'}">
     
     <c:choose>
     <c:when test="${savedJobIdsMap.containsKey(param.jobId)}">
     <li><span class= "savejobimg"><img src="images/saved_active_icn.png"></span></li>
     </c:when>
     
     <c:otherwise>
     <li><a href="candidate_registration.htm?msg=Please Register On Imploy.me to save this internship">
    <img src="images/saved_icn.png" class= "savejob"></a></li>
     </c:otherwise>
     </c:choose>
    
     
      <li><a href="#myModal1" data-toggle="modal"><span><img name="recommend" id="send01" src="images/share_icn.png"></span></a></li>
      
       
      <li> <div class="fb-share-button"  data-href="http://imploy.me/preview_job.htm?jobId=<c:out value="${job.jobIdAndFirmId}" ></c:out>" data-layout="button"></div></li> 
      <li><script type="IN/Share" data-url="http://imploy.me/preview_job.htm?jobId=<c:out value="${job.jobIdAndFirmId}" ></c:out>"></script></li> 
     
     </c:when>
    </c:choose> 
        </ul>
      
      </div>
      
      
      
       <div class="whitebackground">
            <h1 class="sectionheading floatleft" id="JobTitle"> <c:out value="${job.jobTitle}"/> </h1>
           <div class="left_logowrap">
            <input type="hidden" id="job_id_and_firm_id" value="${job.jobIdAndFirmId}" />
          
            <div class="jobid" >( Job Id <span id="jid"><c:out value="${job.jobId}"/></span> )</div>
            <div class="clear"></div>
            <h3 class="black_heading" id="companyName"> <c:out value="${job.companyName}"/> </h3>
            <ul class="greylist">
              <li id="location"> <c:out value="${job.location}"/> </li>
              <li id="experience"> <c:out value="${job.experienceFrom}"/> - <c:out value="${job.experienceTo}"/>yrs  </li>
              <li id="jobType"> <c:out value="${job.jobType}"/> </li>
            </ul>
            <div class="clear"></div>
            <ul class="greylist">
              <li><span class="boldtxt">Industry:</span><span id="industry"><c:out value="${job.industry}"/></span></li>
              <li><span class="boldtxt"> Functional Area:</span> <span id="func"> <c:out value="${job.functionalArea}"/></span> </li>
              <li ><span class="boldtxt"> Posted on:</span><span id="postedon"> 
              <fmt:parseDate value="${job.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
              <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/></span></li>       
          </ul>
          </div>
          
  
             <div class="right_logowrap">
          								<c:choose>
											<c:when test="${companyDetails.imageName ne null}"> 
											<div class="companylogo_rgt"><img src="view_image.htm?emailId=${companyID}" alt="" height="32" width="110"> </div>
											</c:when>
											<c:otherwise>
						                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="110" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose> 
            <div class="clear"></div>
                        <div class="Profile_margin"><a href="profile_preview.htm?companyName=<c:out value="${companyDetails.companyName}"></c:out>" class="profile"> Company Profile </a></div>
            
          </div>

        <div class="clear"></div>
        <div class="border_dashed">
          <h4 class="bluehead"> Job Description </h4>
          <p class="about_text" id="jobDescription"><c:out value="${job.jobDescription}"/></p>
          
          <h4 class="bluehead"> Primary  Skills </h4>
          <p class="about_text" id="primarySkill"><c:out value="${job.primarySkills}"/></p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text"  id="secondarySkills"><c:out value="${job.secondarySkills}"/></p>
          
          <h4 class="bluehead"> Salary Per Week ($) </h4>
          <p class="about_text"  id="payPerWeek"><c:out value="${job.payPerWeek}"/></p>
          
         </div>
        
        
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
                 </div>
              </div>
              
            </form>
          </div>
          </div>
          
           <div class="whitebackground margin_top2 floatleft">
         <c:if test="${ relatedJobCount != 0 }">
          <h4 class="relatedjobs"> Similar Jobs </h4>
		    <ul class="relatedjobs">
			    <c:forEach items="${relatedJobs}" var="relatedJob">
			    <li onclick='location.href="candidate_preview_listed_job.htm?jobId=<c:out value="${relatedJob.jobIdAndFirmId}"/>"'>
			     <a class="jobname"><c:out value="${relatedJob.jobTitle}" /><br><c:out value="${relatedJob.location}" /></a> 
			   <%-- 	<c:choose>
			    		<c:when test="${not empty companyDetails.imageName }">
			    			<img alt="Employer Image" src="view_company_logo.htm?firmId=<c:out value="${relatedJob.emailId}"></c:out>">
			    		</c:when>
			    		<c:otherwise>
			    			<img alt="Employer Image" src="images/Not_available_icon1.png">
			    		</c:otherwise>
			    </c:choose> 
			    	<a href="view_image.htm?emailId=<c:out value="${relatedJob.emailId}"></c:out>">
			    		<c:out value="${relatedJob.companyName }"></c:out>
			    	</a> --%>
			    	
			    	<c:choose>
			    		<c:when test="${not empty relatedJob.emailId }">
			    			<img alt="Employer Image" src="view_image.htm?emailId=<c:out value="${relatedJob.emailId}"></c:out>">
			    		</c:when>
			    		<c:otherwise>
			    			<img alt="Employer Image" src="images/Not_available_icon1.png">
			    		</c:otherwise>
			    	</c:choose>
			    	<a href="profile_preview.htm?companyName=<c:out value="${relatedJob.companyName}"></c:out>">
			    		<c:out value="${relatedJob.companyName }"></c:out>
			    	</a>
			    </li>
			    </c:forEach>
		    </ul>
		    </c:if> 
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

<div id="sendJob">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" class="modal hide fade in" id="myModal1">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="myModalLabel">Recommend this Job to your Friend</h3>
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
    
	
</body>
</html>
