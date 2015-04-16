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
<title>Employer Campus Internship Preview</title>
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
	 
function editCampusInternship()
{
		  var formDetailsPublish = document.getElementById('postInternshipForm');
		  document.forms[0].action = 'employer_post_campus_internship.htm?editMode=true';
		  formDetailsPublish.submit();
}
function saveCampusInternship()
{
		  var formDetailsPublish = document.getElementById('postInternshipForm');
		  document.forms[0].action = 'employer_update_campus_internship_status.htm?action=save';
		  formDetailsPublish.submit();
}
function publishCampusInternship()
{
	  var formDetailsPublish = document.getElementById('postInternshipForm');
	  document.forms[0].action = 'employer_update_campus_internship_status.htm?action=publish';
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
			 <div class="companylogo_rgt"><img src="view_image.htm?emailId=${campusInternshipCommand.emailId }" height="32" width="110"></div>
			</c:when>
			<c:otherwise>
			<div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
			</c:otherwise>
			 </c:choose>
            
            <div class="clear"></div>
       </div>
         <div class="line-border">&nbsp;</div>
            <div class="candidate_upcomingevents_wrap">
        
         <c:if test="${campusInternshipCommand.jobViewedCount != 0}">
         <div class="floatleft whitebackground marginbot" style="width:85%;">
             Total Views <span class="count floatright">${campusInternshipCommand.jobViewedCount}</span>
          </div>
          </c:if>
          
          <c:if test="${not empty campusInternshipCommand.responseCount && campusInternshipCommand.responseCount != 0}">
         <div class="floatleft whitebackground" style="width:85%;">
            
            <h4>
            <a href="view_campus_job_responses.htm?jobId=<c:out value="${campusInternshipCommand.internshipIdAndFirmId}"></c:out>&universityName=<c:out value="${campusInternshipCommand.universityName}"/>">
             Application(s)<br> Received<span class="count floatright">${campusInternshipCommand.responseCount}</span> </a></h4>
             </div>
           </c:if>
          </div>
       </div>
       </section>
    
    
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_jobs_internships.htm?selected=campusInternships">Publish Jobs &amp; Internships</a> \ Campus Internship Preview</div> -->
    
      <section id="rightwrap" class="floatleft">
 
							
	 <form:form class="stdform" action="employer_post_campus_internship.htm"  method="post" modelAttribute="campusInternshipCommand"  id="postInternshipForm" >
          <div class="jobheader">
          <div class="left_logowrap" style="height: 140px;">
            <h1 class="sectionheading floatleft"><c:out value="${campusInternshipCommand.internshipTitle}"/>
            <input type="hidden" name="internshipTitle" value="${campusInternshipCommand.internshipTitle}"/> </h1>
            <div class="jobid">( Internship Id <c:out value="${campusInternshipCommand.internshipId}"/> )
            <input type="hidden" name="internshipId" value="${campusInternshipCommand.internshipId}"/>  </div>
            <div class="clear"></div>
            <h3 class="black_heading"><c:out value="${campusInternshipCommand.companyName}"/></h3>
            
             <input type="hidden" name="companyName" value="${campusInternshipCommand.companyName}"/> 
            <ul class="greylist">
              <li> <c:out value="${campusInternshipCommand.location}"/> 
              <input type="hidden" name="location" value="${campusInternshipCommand.location}"/>,
              <c:out value="${campusInternshipCommand.zipCode}"/> 
              <input type="hidden" name="zipCode" value="${campusInternshipCommand.zipCode}"/>
                </li>
              <li> <c:out value="${campusInternshipCommand.startDate}"/> to <c:out value="${campusInternshipCommand.endDate}"/> 
              <input type="hidden" name="startDate" value="${campusInternshipCommand.startDate}"/>
              <input type="hidden" name="endDate" value="${campusInternshipCommand.endDate}"/> </li>
              <li> <c:out value="${campusInternshipCommand.internshipType}"/>
              <input type="hidden" name="internshipType" value="${campusInternshipCommand.internshipType}"/> </li>
            </ul>
            </div>
            </div>
            <div class="clear"></div>
            
             <div class="whitebackground">
            <ul class="greylist">
             <li><span class="boldtxt"> Posted on:</span> 
             <fmt:parseDate value="${campusInternshipCommand.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
             <fmt:formatDate type="date" value="${formatedDate}" pattern="${jobDateFormat}" />
            <%--  <c:out value="${campusInternshipCommand.postedOn}"/> --%>
             <input type="hidden" name="postedOn" value="${campusInternshipCommand.postedOn}"/></li>
             
            </ul>
         
          <%--  <div class="right_logowrap" style="height: 140px;">
           <c:choose>
		   <c:when test="${companyDetails.imageName ne null}"> 
			 <div class="companylogo_rgt"><img src="view_image.htm?emailId=${campusInternshipCommand.emailId}" height="32" width="110"></div>
			</c:when>
			<c:otherwise>
			 <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
			</c:otherwise>
			</c:choose>
            
            <div class="clear"></div>
       <!--      <div class="Profile_margin"><a href="employer_manage_profile_preview.htm" class="profile"> Company Profile </a></div> -->
          </div> --%>
        <div class="clear"></div>
        <br>
 <%--  <div class="templatedetails">
  <c:if test="${fn:length(campusInternshipCommand.campusInternshipAppliedStudents) != 0}">
          <div class="basic_container" style="margin-left: 20px;">
            <div class="floatleft"><img src="images/responses_icn.jpg" alt="Home" width="36" height="36"/></div>
            <div class="basic_info">
            <h4>
            <a href="view_campus_internship_responses.htm?internshipId=<c:out value="${campusInternshipCommand.internshipIdAndFirmId}"></c:out>&universityName=<c:out value="${campusInternshipCommand.universityName}"/>">
            <span style="font-size:20px;">${fn:length(campusInternshipCommand.campusInternshipAppliedStudents)}</span> Application(s) Received </a></h4>
             </div>
          </div>
           </c:if>
           
         <c:if test="${campusInternshipCommand.jobViewedCount != 0}">
          <div class="basic_container">
            <div class="floatleft"><img src="images/views_icn.png" alt="Email" width="36" height="36"/></div>
            <div class="basic_info">
            <c:choose>
            <c:when test="${campusInternshipCommand.jobViewedCount == 1}">
            <span style="font-size:20px;">${campusInternshipCommand.jobViewedCount}</span> Person has viewed this internship
            </c:when>
            <c:otherwise>
            <span style="font-size:20px;">${campusInternshipCommand.jobViewedCount}</span> Persons have viewed this internship
            </c:otherwise>
            </c:choose>
          </div>
          </div>
          </c:if>
          
           </div> --%>
        <div class="clear"></div> 
        <div class="border_dashed">
          <h4 class="bluehead"> Internship Description </h4>
          <p class="about_text"><c:out value="${campusInternshipCommand.internshipDescription}"/>
          <input type="hidden" name="internshipDescription" value="${campusInternshipCommand.internshipDescription}"/></p>
          
            <h4 class="bluehead"> University Name(s) </h4>          
          		<p class="about_text">  
          		<input type="hidden" name="campusJobRecipients" value="${campusInternshipCommand.campusJobRecipients}"/>
          		<c:out value="${campusInternshipCommand.campusJobRecipients.toString().replace('[', '').replace(']', '')}"/>
          		 </p>
          	
          
          <h4 class="bluehead"> Primary  Skills </h4>
          <p class="about_text">
          <input type="hidden" name="primarySkills" value="${campusInternshipCommand.primarySkills}"/>
			<c:out value="${campusInternshipCommand.primarySkills.toString().replace('[', '').replace(']', '')}"></c:out>
		</p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text">
          <input type="hidden" name="secondarySkills" value="${campusInternshipCommand.secondarySkills}"/>
			<c:out value="${campusInternshipCommand.secondarySkills.toString().replace('[', '').replace(']', '')}"></c:out>
		  </p>
          
          <h4 class="bluehead"> Approximate Hours </h4>
          <p class="about_text"><c:out value="${campusInternshipCommand.approximateHours}"/>
          <input type="hidden" name="approximateHours" value="${campusInternshipCommand.approximateHours}"/></p>     
          
          <h4 class="bluehead"> Number of Internships </h4>
          <p class="about_text"><c:out value="${campusInternshipCommand.numberOfVacancy}"/>
          <input type="hidden" name="numberOfVacancy" value="${campusInternshipCommand.numberOfVacancy}"/></p>
          
          <h4 class="bluehead"> Pay Per Week ($) </h4>
          <p class="about_text"><c:out value="${campusInternshipCommand.payPerHour}"/>
          <input type="hidden" name="payPerHour" value="${campusInternshipCommand.payPerHour}"/></p>
          
        </div>
        
        <div id="candidate_registration_wrap">     
          <div class="par">
                <div class="buttonwrap">
                <input name="editBtn"  type="button" value="Edit"    tabindex="1" onclick="editCampusInternship()" >
				<c:if test="${! campusInternshipCommand.status.equals('Published') }">
              	  <input name="saveBtn"  type="button" value="Save"    tabindex="2" onclick="saveCampusInternship()" >
               </c:if>
                <input name="publishBtn"  type="button" value="Publish" tabindex="3" onclick="publishCampusInternship()" >
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