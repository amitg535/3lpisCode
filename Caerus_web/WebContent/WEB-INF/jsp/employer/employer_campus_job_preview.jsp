<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Campus Job Preview</title>
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
<link rel="stylesheet" href="css/dashboard.css">

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


<script type="text/javascript">
	function goBack()
	{
		window.history.back();
	}

	function saveCampusJob(){
		var formDetailsSave = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_update_campus_job_status.htm?action=save';
		formDetailsSave.submit();
	}
	
	function publishCampusJob(){
		var formDetailsPublish = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_update_campus_job_status.htm?action=publish';
		formDetailsPublish.submit();
	}
	
	function editCampusJob(){
		var formDetailsPublish = document.getElementById('postCampusJob');
		document.forms[0].action = 'employer_post_campus_job.htm?editMode=true';
		formDetailsPublish.submit();
	}
	
</script> 


</head>
<body class="dashboard">
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!" ></div>
      <div class="clear"></div>
    </div>
    
    <div id="innersection">
      <section id="leftsection" class="floatleft">
      <div class="candidate_quickaction_wrap">
        <div class="portfolio_img"> 
         <c:choose>
			<c:when test="${companyDetails.imageName ne null}"> 
			 <div class="companylogo_rgt"><img src="view_image.htm?emailId=${campusJob.emailId }" height="32" width="110"></div>
			</c:when>
			<c:otherwise>
			<div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
			</c:otherwise>
			 </c:choose>
            
            <div class="clear"></div>
       </div>
         <div class="line-border">&nbsp;</div>
            <div class="candidate_upcomingevents_wrap">
        
         <c:if test="${campusJob.jobViewedCount != 0}">
        <div class="floatleft whitebackground marginbot" style="width:85%;">
            Total Views <span class="count floatright">${campusJob.jobViewedCount}</span>
          </div>
          </c:if>
          
          <c:if test="${not empty campusJob.responseCount && campusJob.responseCount != 0}">
         <div class="floatleft whitebackground" style="width:85%;">
            
            <h4>
            <a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}"></c:out>&universityName=<c:out value="${campusJob.universityName}"/>">
             Application(s)<br> Received<span class="count floatright">${campusJob.responseCount}</span> </a></h4>
             </div>
           </c:if>
          </div>
       </div>
       </section>
     
      <section id="rightwrap" class="floatleft">
       <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_jobs_internships.htm?selected=campusJobs">Publish Jobs &amp; Internships</a> \ Campus Job Preview</div> -->
          <form:form modelAttribute="campusJob" id="postCampusJob">
         
           <div class="jobheader">
            <h1 class="sectionheading floatleft"> <c:out value="${campusJob.jobTitle}"/> <input type="hidden" name="jobTitle" value="${campusJob.jobTitle}"/></h1>
            <div class="jobid">( Job Id <c:out value="${campusJob.jobId}"/>  <input type="hidden" name="jobId" value="${campusJob.jobId}"/>)</div>
            <div class="clear"></div>
            <h3 class="black_heading"><c:out value="${campusJob.companyName}"/> <input type="hidden" name="companyName" value="${campusJob.companyName}"/></h3>
            <ul class="greylist">
              <li> <c:out value="${campusJob.location}"/> <input type="hidden" name="location" value="${campusJob.location}"/>
              , <input type="hidden" name="zipCode" value="${campusJob.zipCode}"/> <c:out value="${campusJob.zipCode}"/>
              </li>
              <li> <c:out value="${campusJob.experienceFrom}"/> - <c:out value="${campusJob.experienceTo}"/> yrs 
               <input type="hidden" name="experienceFrom" value="${campusJob.experienceFrom}"/> 
               <input type="hidden" name="experienceTo" value="${campusJob.experienceTo}"/></li>              
              <li> <c:out value="${campusJob.jobType}"/> <input type="hidden" name="jobType" value="${campusJob.jobType}"/> </li>            
            </ul>
           </div>
            
            <div class="clear"></div>
             <div class="whitebackground">
            <ul class="greylist width100 floatleft">
              <li><span class="boldtxt">Industry:</span> <c:out value="${campusJob.industry}"/> <input type="hidden" name="industry" value="${campusJob.industry}"/></li>
              <li><span class="boldtxt"> Functional Area:</span> <c:out value="${campusJob.functionalArea}"/> <input type="hidden" name="functionalArea" value="${campusJob.functionalArea}"/></li>
              <li><span class="boldtxt"> Posted on:</span> 
              	  <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="${jobDateFormat}" />
              
	             <%--  <c:out value="${campusJob.postedOn}"/>  --%>
	              <input type="hidden" name="postedOn" value="${campusJob.postedOn}"/>
              </li>
            </ul>
         
        <div class="clear"></div>
        <div class="border_dashed">
          <h4 class="bluehead"> Job Description </h4>
          <p class="about_text"><c:out value="${campusJob.jobDescription}"/> <input type="hidden" name="jobDescription" value="${campusJob.jobDescription}"/></p>
          
           <h4 class="bluehead"> University Names </h4>
          <p class="about_text">
          	<c:out value="${campusJob.campusJobRecipients.toString().replace('[', '').replace(']', '')}"/>
          </p>
           <input type="hidden" name="campusJobRecipients" value="${campusJob.campusJobRecipients}"/>
          <h4 class="bluehead"> Primary  Skills </h4>
          <p class="about_text">
          
          <input type="hidden" name="primarySkills" value="${campusJob.primarySkills}"/> 
			<c:out value="${campusJob.primarySkills.toString().replace('[', '').replace(']', '')}"></c:out>
          </p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text">
            <input type="hidden" name="secondarySkills" value="${campusJob.secondarySkills}"/> 
          <c:out value="${campusJob.secondarySkills.toString().replace('[', '').replace(']', '')}"></c:out>
          
          </p>   
          
          <%-- <h4 class="bluehead"> Eligible Streams </h4>
          <p class="about_text"><c:out value="${eligibleStreamsAttr}"/>  <input type="hidden" name="eligibleStreams" value="${eligibleStreamsAttr}"/></p> --%>
         <%--  
          <h4 class="bluehead"> GPA Cut Off </h4>
          <p class="about_text"><c:out value="${campusJob.gpaCutOffFrom}"/> to <c:out value="${campusJob.gpaCutOffTo}"/>
           <input type="hidden" name="gpaCutOffFrom" value="${campusJob.gpaCutOffFrom}"/> <input type="hidden" name="gpaCutOffTo" value="${campusJob.gpaCutOffTo}"/></p> --%>
         
          <h4 class="bluehead"> Pay Per Week ($) </h4>
          <p class="about_text"><c:out value="${campusJob.payPerWeek}" />
           <input type="hidden" name="payPerWeek" value="${campusJob.payPerWeek}" /></p>          
           <input type="hidden" name="status" value="${campusJob.status}" />
        </div>
        
        <div id="candidate_registration_wrap">
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn" type="button" value="Edit" tabindex="1" onclick="editCampusJob()" >
                <c:if test="${!campusJob.status eq 'Published' ||  !campusJob.status eq 'Broadcasted'}">
                	<input name="saveBtn" id="saveBtn" type="button" value="Save" tabindex="2" onclick="saveCampusJob()">
                </c:if>
                <input name="publishBtn" type="button" value="Publish" tabindex="3" onclick="publishCampusJob()" >
              </div>
              </div>
          </div>
          </div>
       </form:form> 
          
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