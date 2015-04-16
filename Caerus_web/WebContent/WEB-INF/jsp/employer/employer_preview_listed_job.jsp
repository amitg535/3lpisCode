<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Job Preview</title>
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
function myFunction()
{
	window.location.href='employer_Preview_edit.htm';   
}
</script>
<script>
function goBack()
  {

  window.location.href='employer_jobs_internships.htm';
  //window.history.back();
  }
</script>

<script type="text/javascript">
function editJob()
{
 	var formDetails = document.getElementById('postedJob');
	formDetails.action="employer_edit_posted_job.htm";
	formDetails.submit();
}

function saveJob(){
	var formDetailsSave = document.getElementById('postedJob');
	document.forms[0].action = 'employer_update_posted_job_status.htm?action=save';
	formDetailsSave.submit();
}

function publishJob(){
	var formDetailsPublish = $("#postedJob");
	document.forms[0].action = 'employer_update_posted_job_status.htm?action=publish';
	formDetailsPublish.submit();
}
</script>

</head>
<body class="dashboard">
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
 <!--  <header>
    <div id="logo"><a href="home.html"><img src="images/logo.gif" alt="Caerus - your carrer hi-five"></a></div>
    <div id="loginwrap">
      <div id="studentlogin" class="floatleft">User: Quinnox Consultancy Services Pvt.Ltd. / Max D'Costa</div>
      <div class="floatleft" id="employerslogin"><a href="employers_registration_login.html" target="_self">Sign Out</a></div>
    </div>
    <div class="clear"></div>
  </header> -->
  
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
											 <div class="companylogo_rgt"><img src="view_image.htm?emailId=<c:out value="${jobDetails.emailId}"/>" height="32" width="110"></div>
											</c:when>
											<c:otherwise>
						                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose>
						                      
            <div class="clear"></div>
            <%-- <div class="Profile_margin"><a href="profile_preview.htm?companyName=${companyDetails.companyName}" class="profile"> Company Profile </a></div> --%>
          </div>
            <div class="line-border">&nbsp;</div>
            <div class="candidate_upcomingevents_wrap">
          <c:if test="${jobDetails.jobViewedCount != 0}">
            <div class="floatleft whitebackground marginbot" style="width:85%;">
            Total Views<span class="count floatright">${jobDetails.jobViewedCount}</span> 
          </div>
          </c:if>
          
            <c:if test="${jobDetails.responseCount != 0}">
            <div class="floatleft whitebackground" style="width:85%;">
            <h4><a href="employer_view_job_responses.htm?jobId=${jobDetails.jobIdAndFirmId}"> Application(s)<br> Received <span class="count floatright">${jobDetails.responseCount}</span></a></h4>
             </div>
          </c:if>
          
          </div>
          </div>
       </section>
      <section id="rightwrap" class="floatleft">
    
      
       <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_jobs_internships.htm">Publish Jobs &amp; Internships</a> \ Job Preview</div> -->
       <form:form id="postedJob" modelAttribute="postJob" method="POST" >
       
       <input type="hidden" name="jobIdAndFirmId" id="jobIdAndFirmId" value="${jobDetails.jobIdAndFirmId }"/>
              
          <form:hidden path="status" value="${jobDetails.status }"/>
           <div class="jobheader">
            <h1 class="sectionheading floatleft"><c:out value="${jobDetails.jobTitle}"/></h1>
            <form:hidden path="jobTitle" value="${jobDetails.jobTitle}" />
           
            <div class="jobid">( Job Id <c:out value="${jobDetails.jobId}"/> )</div>
            <form:hidden path="jobId" value="${jobDetails.jobId}" />
            <div class="clear"></div>
            <h3 class="black_heading"> <c:out value="${jobDetails.companyName}"/> </h3>
            <form:hidden path="companyName" value="${jobDetails.companyName}" />
            <ul class="greylist">
              <li> <c:out value="${jobDetails.location}"/>
              <form:hidden path="location" value="${jobDetails.location}" />, <c:out value="${jobDetails.zipCode}"/>
              <form:hidden path="zipCode" value="${jobDetails.zipCode}" />
               </li>
              <li><form:hidden path="experienceTo" value="${jobDetails.experienceTo}" /> <c:out value="${jobDetails.experienceFrom}"/> - 
              <form:hidden path="experienceFrom" value="${jobDetails.experienceFrom}" />
              <c:out value="${jobDetails.experienceTo}"/>  </li>
              
              <form:hidden path="jobType" value="${jobDetails.jobType}" />
              <li> <c:out value="${jobDetails.jobType}"/> </li>
            </ul>
            </div>
             
            <div class="clear"></div>
             <div class="whitebackground">
            <ul class="greylist width100 floatleft">
              <li><span class="boldtxt">Industry:</span> <form:hidden path="industry" value="${jobDetails.industry}" /><c:out value="${jobDetails.industry}"/> </li>
              <li><span class="boldtxt"> Functional Area:</span><form:hidden path="functionalArea" value="${jobDetails.functionalArea}" /> <c:out value="${jobDetails.functionalArea}"/> </li>
              <li><span class="boldtxt"> Posted on:</span> 
              
              <form:hidden path="postedOn" value="${jobDetails.postedOn}" />
              <fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="empPreviewDate"/>
              <fmt:formatDate type="date" value="${empPreviewDate}" pattern="${jobDateFormat}" />
              </li>              
            </ul>
          
         
           <div class="clear"></div>
<br>
        <div>
          <h4 class="bluehead border_dashed"> Job Description </h4>
          <form:hidden path="jobDescription" value="${jobDetails.jobDescription}" />
          <p class="about_text"><c:out value="${jobDescription}" /></p>
          
          <%-- <h4 class="bluehead"> Primary  Skills </h4>
          <form:hidden path="primarySkills" value="${jobDetails.primarySkills}"/>
          <p class="about_text"><c:out value="${jobDetails.primarySkills}"/></p> --%>
          
          <h4 class="bluehead"> Primary  Skills </h4>
          <form:hidden path="primarySkills" id="" value="${jobDetails.primarySkills}"/>
          <p class="about_text"><c:out value="${jobDetails.primarySkills.toString().replace('[', '').replace(']', '')}"/></p>
          
          
          
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <form:hidden path="secondarySkills" value="${jobDetails.secondarySkills}"/>
          <p class="about_text"><c:out value="${jobDetails.secondarySkills.toString().replace('[', '').replace(']', '')}"/></p>
          
          <h4 class="bluehead"> Salary Per Week ($) </h4>
          <form:hidden path="payPerWeek" value="${jobDetails.payPerWeek}"/>
          <p class="about_text"><c:out value="${jobDetails.payPerWeek}"/></p>
          
        <%--   <h4 class="bluehead"> Eligible Streams </h4>
          <p class="about_text"><c:out value="${EligibleStreams}"/></p> --%>
          
        <%--   <h4 class="bluehead"> GPA Cut Off </h4>
			<form:hidden path="gpaCutOffFrom" value="${jobDetails.gpaCutOffFrom}"/>          
          <p class="about_text"> <c:out value="${jobDetails.gpaCutOffFrom}"/> to  <form:hidden path="gpaCutOffTo" value="${jobDetails.gpaCutOffTo}"/> 
          <c:out value="${jobDetails.gpaCutOffTo}"/>   </p> --%>
        </div>
        
        
           <c:if test="${! jobStatus.equals('Closed') }">
           <div class="fullwidth_form">
                <div class="par">
	                <div class="buttonwrap">
	                    <!-- <input name="" type="submit" value="Save" tabindex="21"> -->
	                    
	                   <c:if test="${! jobDetails.status.equals('Published')}">
	                   	 <input name="saveBtn" type="button" value="Save" tabindex="22" onclick="saveJob()">
	                    </c:if> 
	                    <input name="publishBtn" type="button" value="Publish" tabindex="22" onclick="publishJob()">
	                   <input name="editBtn" type="button" value="Edit" tabindex="23" onclick="editJob()"> 
	              </div>
              </div>
          </div>
     </c:if> 
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