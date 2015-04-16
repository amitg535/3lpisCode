<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Internship Preview</title>
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
function publishInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_update_internship_status.htm?action=publish';
	formDetails.submit();
}
</script>

<script>
function editInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_post_internship.htm?editMode=true';
	formDetails.submit();
}
</script>
<script>
function saveInternship(){
	var formDetails = document.getElementById('postInternshipDetails');
	document.forms[0].action = 'employer_update_internship_status.htm?action=save';
	formDetails.submit();
}
</script>
 <script type="text/javascript">
function backFunction(){
 history.go(-1);
 return true;
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
			<div class="companylogo_rgt"><img src="view_image.htm?emailId=${internshipDetails.emailId}" height="32" width="110"></div>
			</c:when>
			<c:otherwise>
			<div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
			</c:otherwise>
			</c:choose>
         <div class="clear"></div>
        </div>
        
        
         <div class="line-border">&nbsp;</div>
            <div class="candidate_upcomingevents_wrap">
        <c:if test="${internshipDetails.jobViewedCount != 0}">
         <div class="floatleft whitebackground marginbot" style="width:85%;">
            Total Views <span class="count floatright">${internshipDetails.jobViewedCount}</span> 
          </div>
          </c:if>
          
           <c:if test="${internshipDetails.responseCount != 0}">
          <div class="floatleft whitebackground" style="width:85%;">
            <h4><a href="employer_view_internship_responses.htm?internshipIdAndFirmId=${internshipDetails.internshipIdAndFirmId}">Application(s)<br> Received <span class="count floatright">${internshipDetails.responseCount}</span> </a></h4>
             </div>
          
          </c:if>
        </div>
        </section>
      
      
      
      
      <section id="rightwrap" class="floatleft">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_jobs_internships.htm?selected=internships">Publish Jobs &amp; Internships</a> \ Internship Preview </div> -->
      <form:form id="postInternshipDetails" modelAttribute="postInternship" method="POST">
          
          <div class="jobheader">
            <h1 class="sectionheading floatleft"><c:out value="${internshipDetails.internshipTitle}"/></h1>
            
            <form:hidden path="internshipTitle"/>
            
            <div class="jobid">( Internship Id <c:out value="${internshipDetails.internshipId}"/> )</div>
            
             <form:hidden path="internshipId"/>
            <div class="clear"></div>
            <h3 class="black_heading"> <c:out value="${companyName}"/></h3>
             <form:hidden path="companyName" value="${companyName}" />
             <form:hidden path="status" value="${internshipDetails.status}" /> 
            <ul class="greylist">
              <li>  <c:out value="${internshipDetails.location}"/>,  <form:hidden path="location"/> <c:out value="${internshipDetails.zipCode}"/>  <form:hidden path="zipCode"/> </li>
              <li>  <c:out value="${internshipDetails.startDate}"/> <form:hidden path="startDate"/> to  <c:out value="${internshipDetails.endDate}"/> <form:hidden path="endDate"/> </li>              
              <li>  <c:out value="${internshipDetails.internshipType}"/>  <form:hidden path="internshipType"/></li>
            </ul>
            </div>
            <div class="clear"></div>
            
            <div class="whitebackground">
            <ul class="greylist width100 floatleft">
              <li><span class="boldtxt"> Posted on:</span>  <form:hidden path="postedOn"  value="${internshipDetails.postedOn}"/>
              <fmt:parseDate value="${internshipDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="internPostedOn"/>
              <fmt:formatDate type="date" value="${internPostedOn}" pattern="${jobDateFormat}" /> 
              <form:hidden path="postedOn" value="${ internshipDetails.postedOn}"/>
              </li>
            </ul>
          
          

        <div class="clear"></div>
        <div class="border_dashed">        
          <h4 class="bluehead"> Internship Description </h4>  <form:hidden path="internshipDescription"/>
          <p class="about_text"> <c:out value="${internshipDescription}"/> </p> 
          
           <h4 class="bluehead"> Primary  Skills </h4>  <form:hidden id="ps" path="primarySkills"/>
           
          <p class="about_text"> <c:out value="${internshipDetails.primarySkills.toString().replace('[', '').replace(']', '')}"/></p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>  <form:hidden path="secondarySkills"/>
          <p class="about_text"> <c:out value="${internshipDetails.secondarySkills.toString().replace('[', '').replace(']', '')}"/> </p>
          
          <h4 class="bluehead"> Approximate Hours </h4>  <form:hidden path="approximateHours"/>
          <p class="about_text"> <c:out value="${internshipDetails.approximateHours}"/> </p>          
          
          <h4 class="bluehead"> Pay Per Hour ($) </h4>  <form:hidden path="payPerHour"/>
          <p class="about_text"> <c:out value="${internshipDetails.payPerHour}"/> </p>
        </div>
       
          <div id="candidate_registration_wrap">
	        
	         	<div class="par">
	       		 <div class="buttonwrap">
					                <input name="editBtn" type="button" value="Edit" tabindex="1" onclick="editInternship()">
					                <input name="publishBtn" type="button" value="Publish" tabindex="3" onclick="publishInternship()" >
					         <c:choose>
				           			 <c:when test="${! internshipDetails.status.equals('Closed') && empty statusDisp }">
							              
							              	<c:if test="${! internshipDetails.status.equals('Published')}">
							                	<input name="saveBtn" type="button" value="Save" tabindex="2" onclick="saveInternship()">
							               	</c:if>
							               
				           			</c:when>  
		           			  </c:choose>  
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