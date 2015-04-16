<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Job Preview </title>
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
<script type="text/javascript">
function publishJob()
{ 
	window.location.href='employer_save_job.htm?action=publish';
}
</script>
<script>
function goBack()
{
  window.history.back();
}
</script>

<script>
  function editJob()
  {
	  window.location.href='employer_post_job.htm?editMode=true';
  }  
</script>
<script type="text/javascript">
function saveJob(){

	window.location.href='employer_save_job.htm?action=save';
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
    <div id="innerbanner">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!" ></div>
      <div class="clear"></div>
    </div>
   
    <div id="innersection">
     <!--  <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_jobs_internships.htm">Publish  Jobs &amp; Internships</a> \ Preview of a job</div> -->
     
      <section id="rightwrap" class="floatleft">
              <div class="whitebackground">
          <div class="left_logowrap">
          
            <h1 class="sectionheading floatleft"><c:out value="${jobDetails.jobTitle}"/></h1>
            <div class="jobid">( Job Id <c:out value="${jobDetails.jobId}"/> )</div>
            <div class="clear"></div>
            <h3 class="black_heading"> <c:out value="${jobDetails.companyName}"/> </h3>
            <ul class="greylist">
              <li> <c:out value="${jobDetails.location}"/> , <c:out value="${jobDetails.zipCode}"/> </li>
              
              <li> <c:out value="${jobDetails.experienceFrom}"/> - <c:out value="${jobDetails.experienceTo}"/>  </li>
              <li> <c:out value="${jobDetails.jobType}"/> </li>
            </ul>
            <div class="clear"></div>
            <ul class="greylist">
              <li><span class="boldtxt">Industry:</span> <c:out value="${jobDetails.industry}"/> </li>
              <li><span class="boldtxt"> Functional Area:</span> <c:out value="${jobDetails.functionalArea}"/> </li>
              <li><span class="boldtxt"> Posted on:</span> 
              <fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="previewOfJobDate"/>
              <fmt:formatDate type="date" value="${previewOfJobDate}" pattern="${jobDateFormat}" />
              </li>              
            </ul>
          </div>
          <div class="right_logowrap">
             <div class="companylogo_rgt"><img src="view_image.htm?emailId=${jobDetails.emailId}" height="32" width="110"></div>
            <div class="clear"></div>
            <!-- <div class="Profile_margin"><a href="employer_manage_profile_preview.htm" class="profile"> Company Profile </a></div> -->
          </div>
  
        <div class="clear"></div>
        <div class="border_dashed">
          <h4 class="bluehead"> Job Description </h4>
          <p class="about_text"><c:out value="${jobDescription}"/></p>
            
                    
                      
          
          <h4 class="bluehead"> Primary  Skills </h4>
             <p class="about_text"><c:out value="${jobDetails.primarySkills.toString().replace('[', '').replace(']', '')}"/> </p>
       <%--    <p class="about_text"><c:out value="${PrimarySkills}"/></p> --%>
          
        <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text"><c:out value="${jobDetails.secondarySkills.toString().replace('[', '').replace(']', '')}"/></p>  
          <h4 class="bluehead"> Salary Per Week ($) </h4>
          <p class="about_text"><c:out value="${jobDetails.payPerWeek}"/></p>
          
        <%--   <h4 class="bluehead"> Eligible Streams </h4>
          <p class="about_text"><c:out value="${EligibleStreams}"/></p> --%>
          
        <%--   <h4 class="bluehead"> GPA Cut Off </h4>
          <p class="about_text"> <c:out value="${jobDetails.gpaCutOffFrom}"/> to   <c:out value="${jobDetails.gpaCutOffTo}"/>   </p> --%>
        </div>
         
        
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn" type="button" value="Edit" tabindex="1" onclick="editJob()">
                <input name="saveBtn" type="button" value="Save" tabindex="2" onclick="saveJob()">
                <input name="publishBtn" type="button" value="Publish" tabindex="3" onclick="publishJob()">
              </div>
              </div>
              
            </form>
          </div>
          </div>
      </section>
     
      <div class="clear"></div>
    </div>
    	</div>
  </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
 <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>
</body>
</html>