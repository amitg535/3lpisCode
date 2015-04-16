<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Post Campus Job </title>
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
<link rel="stylesheet" href="css/uielements/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css"
	type="text/css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript"
	src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript">
  
$().ready(function(){

	$("#jobTitle").change(
		function(){
			if($("#jobTitle").val().trim().length > 50)
			{
				$("#jobTitleError").empty().append("Only 50 characters allowed in Job Title");
				return false;
			}
			else
				$("#jobTitleError").empty();
		}
	);
	
	$("#campusJobPostForm").submit(function(){
		
		 if($("#jobTitle").val().trim().length > 50)
		 {
			 $("#jobTitleError").empty().append("Only 50 characters allowed in Job Title");
			 return false;
		 }
		
		 $("#campusJobPostForm").submit();
		
	});
	
	
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

<!--  Commented on 30-1-2014 to provide Save Functionality only on Preview of Job-->
<!--  
<script type="text/javascript">

	$(document).ready(function(){	

 $('#button1').click(function(){ 
	 	
	 		 $('#campusJobPostForm').attr('action','employer_campus_posta_job.htm?paramName=save');		
	       	  $('#campusJobPostForm').submit();	   
	 	       
	  	});	
	 	 

	 	$('#button2').click(function(){

		if(sessionStorage.getItem("isEditedFromPreview")!=null)
		{
			$('#campusJobPostForm').attr('action','employer_campus_posta_job.htm?paramName=preview&isEditedFromPreview=true'); 
		}
		else
		{
			$('#campusJobPostForm').attr('action','employer_campus_posta_job.htm?paramName=preview');
		}		 

			$('#campusJobPostForm').attr('action','employer_campus_posta_job.htm?paramName=preview');

			$('#campusJobPostForm').submit();
   	 
   	  		
	});
	
	 });    
	 
</script>
 -->


 <script>
function goBack()
	{
	  window.history.back();
	}		
</script>
<script type="text/javascript">
function getCityFunction()
{
	var zipCode=$("#zipCode").val();
	   
      $.ajax({
        
        url: 'get_city_name.htm',
        data : {
			'zipCode' : zipCode
		},
        cache: false,
   	    success: function(cityName) {
   	   	    if(cityName==" ()"){
   	   	  $("#location").val("");  
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   				$("#location").val(cityName);
   	   	   	    }
        }
    });
 

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
				<div id="banner">
					<img src="images/employer_innerbanner.jpg" width="100%"
						alt="Great way to find talent. Sign Up Now!">
				</div>
				<div class="clear"></div>
			</div>
			<c:if test="${not empty param.msg}">
       <span class="errorblock"><c:out value="${param.msg}"></c:out>  </span>
       </c:if>
			
			<div id="innersection">
				<!-- <div id="breadcrums_wrap">
					You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_jobs_internships.htm">Publish
						Jobs &amp; Internships </a> / Publish a Campus Job
				</div> -->
				<%-- <section id="leftsection" class="floatleft">
					 <h3 class="nomargin">Publish Jobs / Internships</h3>
					<ul class="leftsectionlinks">
						<li><a href="employer_jobsinternships_listing.htm">View Job / Internships</a></li>
						<li><a href="employer_campus_postedjobsinternships_listing.htm">View Campus Jobs / Internships</a></li>
					</ul>
					<h3>Useful Links</h3>
					<ul class="leftsectionlinks">
						<li><a href="#">Background Check Services</a></li>
						<li><a href="#">Checklist Employee Contract</a></li>
						<li><a href="#">Hire Overseas Employees</a></li>
					</ul>
					<div id="newsletterwrap">
						<h3>Newsletter</h3>
						<form>
							<input name="" type="text" class="textbox"> <input
								name="" type="button" value="Subscribe">
						</form>
					</div> 
				</section> --%>
				<section id="rightwrap" class="floatleft">
				<div class="whitebackground">
					<h1 class="sectionheading">Post a Job to Campus</h1>
					<p class="description">Post a Job exclusively to the students
						in the Campus of your choice spread across United state.</p>
					<div class="form_messages">
						<span class="message">Denotes required fields</span><span
							class="star">*</span>
					</div>
					<div class="clear"></div>


					<div id="candidate_registration_wrap">
						<form:form action="employer_post_campus_job.htm" method="post" modelAttribute="campusJob" class="stdform" id="campusJobPostForm">
							<div class="leftsection_form">
								<div class="par">
								<input type="hidden" value="${campusJob.jobIdAndFirmId}" name="jobIdAndFirmId">
								<input type="hidden" value="${campusJob.campusJobAppliedStudents.size()}" name="responseCount">
								<input type="hidden" value="${campusJob.universityName}" name="universityName">
									<label class="floatleft">Job ID</label> 
									<span class="star">*</span>
									<div class="clear"></div>
									<span class="field"> 
									<c:choose>
										<c:when test="${campusJob.jobUpdateFlag}">
											<form:input  tabindex="1" path="jobId" readonly="true" cssClass="input-medium" /> 
											
										</c:when>
										<c:otherwise>
											<form:input tabindex="1" path="jobId" cssClass="input-medium" /> 
										</c:otherwise>
									</c:choose>
									 <form:errors path="jobId" cssClass="validationnote" /> 
									
										<%-- <form:errors path="jobId" cssClass="validationnote" /> --%>
										<c:if	test="${not empty campusJob.exceptionOccured}">
									<div class="errorblock">${campusJob.exceptionMessage}</div>
									  </c:if>
									</span>
								</div>
							</div>
							<div class="rightsection_form">
									<div class="par">
										<label class="floatleft">Status</label>
										<div class="clear"></div>
										<span class="formwrapper"> 
											<c:choose>
												<c:when test="${campusJob.jobUpdateFlag}">
													<form:hidden path="jobUpdateFlag" value="true"/>
													<form:hidden path="status" value="${campusJob.status}"/>
													
													<c:choose>
														<c:when test="${!campusJob.status.equals('Closed') }">
															<input type="radio" name="status" checked="checked" disabled="disabled" value="${campusJob.status}" />${campusJob.status} &nbsp;
															<!-- <input type="radio" name="status" value="Closed" />Close -->
														</c:when>
														<c:otherwise>
															<!-- <input type="radio" name="status" checked="checked" disabled="disabled" value="Closed" />Close -->
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<input type="radio" name="radiofield" checked="checked" disabled="disabled" />Drafts
												</c:otherwise>
											</c:choose>
											<c:if test="${campusJob.jobUpdateFlag}">
												
												
														
											</c:if>
									</span>
									</div>
								</div>
							<div class="clear"></div>
							<div class="fullwidth_form">
								<label class="floatleft">Job Title</label>
								<span class="star">*</span>
									<div class="clear"></div> 
								<span class="field"> 
									<c:choose>
										<c:when test="${campusJob.jobUpdateFlag}">
											<form:input  tabindex="2" 	 path="jobTitle" readonly="true" cssClass="input-xxlarge" id="jobTitle"/> 
										</c:when>
										<c:otherwise>
											<form:input	 tabindex="2"  path="jobTitle" cssClass="input-xxlarge" maxlength="100" id="jobTitle"/> 
										</c:otherwise>
									</c:choose>
									<span id="jobTitleError" class="validationnote"></span>
									<form:errors path="jobTitle"  cssClass="validationnote"/> 
								</span>
							</div>
							
							<div class="leftsection_form">
								<div class="par">
									<label class="floatleft">Job Type</label>
									<div class="clear"></div>
									<span class="field"> 									
										<form:select tabindex="3" path="jobType" cssClass="uniformselect">
											<form:option value="">Select</form:option>
											<form:option value="Part Time">Part Time</form:option>
											<form:option value="Full Time">Full Time</form:option>											
										</form:select>							
									</span>
									 <form:errors path="jobType" cssClass="validationnote" />
								</div>
								<div class="par">
									<label class="floatleft">Functional Area</label>
									<div class="clear"></div>
									<span class="formwrapper"> 
										 <spring:bind path="campusJob.functionalArea"><c:set var = "functionalAreaSelected" value="${status.value}"/></spring:bind>
										
										 <form:select tabindex="5" path="functionalArea" cssClass="chzn-select list_widthstyle1">
											<form:option value=" ">Choose a Option</form:option>
												<c:forEach var="functionalArea" items="${functionalAreaList}">
                         								<option value="<c:out value="${functionalArea}" />"
                         								 <c:if test="${functionalArea == functionalAreaSelected}"> selected="selected"</c:if>>
                         								 <c:out value="${functionalArea}" /></option>
                     								
                   								</c:forEach>
										</form:select>  	
										
									</span>
								</div>
								<div class="par">
									<label class="floatleft">Primary Skills Required</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> 
										<!-- <input type="text" name="primarySkills" id="tags" class="input-large" />  -->
										<form:input tabindex="7" path="primarySkills" id="tags" cssClass="input-large" /> 
										<form:errors path="primarySkills" cssClass="validationnote" />
									</span>
								</div>
								 <div class="par">
                <label class="floatleft">Zip code (Job is posted At)</label>
                <span class="star">*</span>
                <div class="clear"></div>
                
                <form:hidden path="postedOn" />
                
                <span class="field">
                  	<form:input path="zipCode" tabindex="9" cssClass="input-xlarge" id="zipCode" onChange="getCityFunction()"/>
              		<form:errors path="zipCode" cssClass="validationnote"/>
              		<span class="errorblock" id="zipCodeError"></span>
                  </span> </div>
                  <div class="clear"></div>
						<div class="par floatleft right_margin">
									<label class="floatleft">Years Of Experience</label>
									<div class="clear"></div>
									<span class="field"> 
										<form:input  tabindex="11" path="experienceFrom" cssClass="input-small1" /> 
										<form:errors path="experienceFrom"  cssClass="validationnote"/> 
																- 
										<form:input	 tabindex="12" path="experienceTo" cssClass="input-small1" /> 
										<form:errors path="experienceTo"  cssClass="validationnote"/>  
									</span>
									
								</div>
								<div class="clear"></div>		
								
							</div>
							<div class="rightsection_form">
								<div class="par">
									<label class="floatleft">Pay Per Week ($)</label>
									<div class="clear"></div>
									<span class="field"> 
										<form:input tabindex="4" path="payPerWeek"	cssClass="input-medium" /> 
										<form:errors path="payPerWeek"  cssClass="validationnote"/>  
									</span>
								</div>
								<div class="par">
									<label class="floatleft">Industry</label>
									<div class="clear"></div>
									<span class="formwrapper"> 	
											 <spring:bind path="campusJob.industry"><c:set var = "industrySelected" value="${status.value}"/></spring:bind>
										  <form:select tabindex="6" path="industry" cssClass="chzn-select list_widthstyle1">
												<form:option value="Choose an Option">Choose an Option</form:option>
													<c:forEach var="industry" items="${industryList}">
                     									
                         									<option value="<c:out value="${industry}" />" <c:if test="${industry == industrySelected}">selected="selected"</c:if>><c:out value="${industry}" /></option>
                     									
                   									</c:forEach>
										  </form:select> 
										
										
									</span>
								</div>
								<div class="par">
									<label class="floatleft">Secondary Skills Required</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> 
									
										<!-- <input type="text" name="secondarySkills" 	id="tags1"  class="input-large" /> --> 
										<form:input tabindex="8" path="secondarySkills"	id="tags1" cssClass="input-large" /> 
										<form:errors path="secondarySkills" cssClass="validationnote" />
									</span>
								</div>
								<div class="clear"></div>
								
								
								  <div class="par">
                <label class="floatleft">City</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="10" path="location" cssClass="input-xxlarge" id="location"/>
                  	<form:errors path="location" cssClass="validationnote"/>
                </span> </div>
                  <div class="clear"></div>
							</div>
							<div class="clear"></div>
							<div class="fullwidth_form">
								<div class="par">
									<label class="floatleft">Name Of the Universities</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="formwrapper">
									
										<form:select tabindex="13" path="campusJobRecipients" multiple="multiple" cssClass="chzn-select list_widthstyle1" >
                        					<form:options items="${universityList}" />                    
                        				</form:select>
									
								
									</span>
									<form:errors path="campusJobRecipients"cssClass="validationnote" />
								</div>
								
							<div class="par">
								<label class="floatleft">Job Description</label> 
								<span class="star">*</span>
									<div class="clear"></div>
										<%-- <form:textarea path="jobDescription" id="wysiwyg1" rows="5"	cols="47" cssClass="txteditor_width" /> --%>
										<form:textarea tabindex="14" path="jobDescription" id="jobDescription" rows="5" cols="47" cssClass="txteditor_width" />  
										<form:errors   path="jobDescription" cssClass="validationnote" />
										
							</div>
							<div class="par">
								<div class="buttonwrap">
									<input name="previewBtn"  type="submit" value="Preview" tabindex="15" >
									<input name="backBtn"  type="button" value="Back"    tabindex="16" onclick="goBack()">  
								</div>
							</div>
							</div>
						</form:form>
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
	</div>
	<script>Cufon.now();</script>
</body>
</html>