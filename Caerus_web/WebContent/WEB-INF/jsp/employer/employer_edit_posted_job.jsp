<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Employer Edit Job</title>
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
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
 
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
$().ready(function(){
	 $("#postForm").validationEngine('attach');
	
});
</script>  
    <script type="text/javascript">
function previewJob()
{
	 var formValue = document.getElementById("postForm");
	 formValue.submit();
}
</script>
  
 <script>
function goBack(){
  window.location.href='employer_jobs_internships.htm';
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
   	   	  $("#Location").val("");  
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   				$("#Location").val(cityName);
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
        <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
     

    <div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_jobs_internships.htm">Publish Jobs &amp; Internships </a> / Publish a Job</div> -->
        
        <section id="rightwrap" class="floatleft">
        <div class="whitebackground">
        <h1 class="sectionheading">Edit a Job</h1>
        <p class="description">Post a Job to the world of fresh college graduates from various streams on a click of a button.</p>
        <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
            
            <form:form cssClass="stdform" action="employer_preview_edit_posted_job.htm" method="post" modelAttribute="postJob" id="postForm">
            <div class="leftsection_form">
                <div class="par">
                <label class="floatleft">Job ID</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  
                  <c:choose>
                  <c:when test="${not empty copyJob && copyJob }">
                  	<form:input path="jobId" tabindex="1" cssClass="input-medium" id="jobId" />
                  </c:when>	
                  
                  <c:otherwise>
                  	<form:input path="jobId" tabindex="1" cssClass="input-medium" readonly="true" id="jobId" />
                  </c:otherwise>
                  </c:choose>
                  	<form:errors path="jobId"  cssClass="input-medium"/>
                  </span> </div>
                  
                  <form:hidden path="jobIdAndFirmId" />
                  
              </div>
            <div class="rightsection_form">
                <div class="par">
                <label class="floatleft">Status</label>
                <div class="clear"></div>
                <span class="formwrapper">
               
              
                  <c:if test="${statusDisp != 'Closed'}">
                  <form:radiobutton path="status" value="${statusDisp}"  checked="true"/><c:out value="${statusDisp}"/> 
                   </c:if>
                  <form:radiobutton tabindex="2" path="status" value="Closed" />Closed 
           
                </span></div>
              </div>
            <div class="clear"></div>
            <div class="fullwidth_form">
                <label>Job Title</label>
                <span class="field">
              		
              		<c:choose>
              		<c:when test="${not empty copyJob && copyJob }">
              			<form:input tabindex="3" path="jobTitle" cssClass="input-xxlarge1 width100" id="jobTitle" maxlength="50" />
              		</c:when>
              		<c:otherwise>
              			<form:input tabindex="3" path="jobTitle" cssClass="input-xxlarge1 width100" readonly="true" id="jobTitle" />
              		</c:otherwise>
              		</c:choose>
              		
              		<form:errors path="jobTitle"  cssClass="input-xxlarge1"/>
              		
              </span> </div>
            <div class="leftsection_form">
                <div class="par">
                <label class="floatleft">Job Type</label>
                <div class="clear"></div>
                
                <span class="field">
                	<form:select tabindex="4" path="jobType" cssClass="chzn-select list_widthstyle1">
                	<form:option value="">Choose One</form:option>
					<form:option value="Full Time">Full Time</form:option>
					<form:option value="Part Time">Part Time</form:option> 	
					</form:select>
                </span>
                <div class="clear"></div>
                <label class="error" id="emptyJobType"></label>
                </div>
                 
                <div class="par">
                <label class="floatleft">Functional Area</label>
                <div class="clear"></div>
                
                <span class="formwrapper">

					
						<form:select tabindex="6" path="functionalArea" cssClass="chzn-select list_widthstyle1">
					<form:option value="Choose an Option">Choose an Option</form:option>
					<c:forEach var="functionalArea" items="${functionalAreaList}">
                         <spring:bind path="postJob.functionalArea"><c:set var = "functionalAreaSelected" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${functionalArea == functionalAreaSelected}">
                         <option value="${functionalArea}" selected="selected"><c:out value="${functionalArea}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${functionalArea}"><c:out value="${functionalArea}" /></option>
                      </c:otherwise>
                   </c:choose>
                   
                     </c:forEach>
                   
					</form:select>
					
                  </span>
                 </div>
                <div class="par">
                <label class="floatleft">Primary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                	<form:input tabindex="8" path="primarySkills" id="tags" cssClass="input-large" />
              		<form:errors path="primarySkills" id="tags"  cssClass="input-large"/>
                  </span> </div>
                  
                  
                     
                <div class="clear"></div>
                 <div class="par">
                <label class="floatleft">Zip code</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="10" path="zipCode" id="zipCode" cssClass="input-xlarge" onChange="getCityFunction()"/>
              		<form:errors path="zipCode" cssClass="input-xlarge"/>
              		<br>
              		<span class="errorblock" id="zipCodeError"></span>
                  </span> </div> 
                  
                   <div class="par">
                <label class="floatleft">Years Of Experience</label>
                <div class="clear"></div>
                <span class="field">
                	<form:input tabindex="12" path="experienceFrom" cssClass="input-small1" />
              		<form:errors path="experienceFrom" cssClass="input-small1"/>
               <!--  </span> </div>
                <div class="par floatright">
                <label>&nbsp;</label>
                <span class="field"> -->
                	<form:input tabindex="13" path="experienceTo" cssClass="input-small1" />
              		<form:errors path="experienceTo" cssClass="input-small1"/>
                 </span> </div>
                 
                  <div class="clear"></div>
              </div>
            <div class="rightsection_form">
                <div class="par">
                <label class="floatleft">Pay Per Week ($)</label>
                <div class="clear"></div>
                <span class="field">
                 	<form:input tabindex="5" path="payPerWeek" cssClass="input-xxlarge" />
              		<form:errors path="payPerWeek" cssClass="input-xxlarge"/>
                  </span> </div>
                <div class="par">
                <label class="floatleft">Industry</label>
                <div class="clear"></div>
                <span class="formwrapper">
 
                         <spring:bind path="postJob.industry">
                        	 <c:set var = "industrySelected" value="${status.value}"/>
                         </spring:bind>
					  <form:select tabindex="7" path="industry" cssClass="chzn-select list_widthstyle1">
					<form:option value="Choose an Option">Choose an Option</form:option>
				
				
					<c:forEach var="industry" items="${industryList}">
		                   <c:choose>
		                      <c:when test="${industry.equals(industrySelected)}">
		                         <option value="${industry}" selected="selected"><c:out value="${industry}" /></option> 
		                      </c:when>
		
		                      <c:otherwise>
		                         <option value="${industry}"><c:out value="${industry}" /></option>
		                      </c:otherwise>
		                   </c:choose>
                     </c:forEach>
                   
					</form:select>
					
                  </span> </div>
                <div class="par">
                <label class="floatleft">Secondary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="9" id="tags1" path="secondarySkills" cssClass="input-large" />
              		<form:errors path="secondarySkills"  cssClass="input-large"/>
                  </span> </div>
                           <div class="par">
            <%--     <label class="floatleft">GPA Cut-Off</label>
                <div class="clear"></div>
                <span class="field">
                 	<form:input  id="g_from_gpa" path="gpaCutOffFrom" cssClass="input-small1" />
              		<!-- 
                  </span> </div>
                <div class="par floatright">
                <label>&nbsp;</label>
                <span class="field"> -->
                  	<form:input id="g_to_gpa" path="gpaCutOffTo" cssClass="input-small1" />
              		  <label class="error" id="emptyGpaGraduation"></label>
                  </span> --%> </div>
                <div class="clear"></div>
              
                
                 <div class="par">
                <label class="floatleft">City</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="11" path="location" id="location" cssClass="input-xxlarge" />
              		<form:errors path="location" cssClass="input-xxlarge"/>
                  </span> </div>
                  <div class="clear"></div>
              </div>
              
            <div class="clear"></div>
            
            <input type="hidden" name="responseCount" value="${postJob.responseCount}">
             <%--    <div class="par">
                <label>Eligible Streams</label>
                <span class="field">
                  
                <form:select path="eligibleStreams" multiple="true" cssClass="list_widthstyle1" size="5">
					<form:option value="Selection One">Selection One</form:option>
					<form:option value="Selection Two">Selection Two</form:option>
					<form:option value="Selection Three">Selection Three</form:option>
					<form:option value="Selection Four">Selection Four</form:option>
					<form:option value="Selection Five">Selection Five</form:option>
				</form:select>
                
                  </span> </div>
                <small class="desc">Hold Control Key to Make Mulitple Selection</small> --%>
                
                     
                  
               
                  
          <div class="fullwidth_form">
                  
                <div class="par">
                <form:hidden path="postedOn"/>
                <label class="floatleft">Job Description</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <form:textarea path="jobDescription"  tabindex="14" rows="5" cols="47" cssClass="txteditor_width" />  
                <form:errors path="jobDescription" id="jobDescription" rows="5" cols="47"  cssClass="txteditor_width"/>
              </div>
                <div class="par">
                <div class="buttonwrap">
                	
                    <!-- <input name="" type="submit" value="Save" tabindex="21"> -->
                    <input name="previewBtn" type="button" value="Preview" tabindex="15" onclick="previewJob()">
                   <input name="backBtn" type="button" value="Back" tabindex="16" onclick="goBack()"> 
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
</body>
</html>