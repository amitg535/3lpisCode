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
<title>Campus Job Preview</title>
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

<script type='text/javascript'>
var referrer;
var referrerUrl;
$(document).ready(function(){	
	referrer =  document.referrer;
 	if(referrer.indexOf("?") > -1)
    {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.lastIndexOf("?"));        	
    }
 	else
    {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.length);
    }

 	
    if(referrerUrl != 'profile_preview.htm')
	{
    	sessionStorage.setItem("referrerUrl",referrerUrl);
    	
		var jobApplied = $("#jobApplied").val();
	
		if(jobApplied != null && jobApplied != "")
	    {
			$("#successMessageSpan").empty().append("Job Applied Successfully");
			
		      	$("#successModal").dialog({
		            modal: true,
		            open: function(event, ui){
		                setTimeout("$('#successModal').dialog('close')",2000);
		            }
				});
	    }
	}
	
	$('#button1').click(function(){ 
		//alert("Button1");
		$('#button1').attr('#button1', 'disabled');	
	});	
	
	$('#button2').click(function(){			
		//alert("Button2");
		$('#button2').attr('#button2', 'disabled');
	});
	
});  
	 
/* $(function(){
     $('#searchInput').onkeyup(function(){
          if ($(this).val() == '') {
               $('.enableOnInput').prop('disabled', true);
          } else {
               $('.enableOnInput').prop('disabled', false);
          }
     });
});
 */
</script>


<script type="text/javascript">
	function broadcastCampusJob(jobId)
	{
		 $.ajax({
			 
			  	type : 'POST',
			 	url : 'university_broadcast_job.json',						
				cache : false,
				data: 'jobId='+jobId,
				success: function (successFlag) 
				{
	                if (successFlag)
		            {

	            		 $("#successMessageSpan").empty().append("You've Successfully Broadcasted the Job");
	            	      $("#successModal").dialog({
	            	            modal: true,
	            	            open: function(event, ui){
	            	                setTimeout("$('#successModal').dialog('close')",2000);
	            	            }
	            });
	            	      $('#broadcast_job').hide();
	            	      $('#delete_job').hide();
	                }
	            }
				
		});

		

	}

	function checkConfirm(){
		var r = confirm("Are you sure want to delete this record ?");
		if (r==true){
		  return true;
		}
		else{
		  return false;
		}	
	}



	function deleteJob(job_id){
		 var confirmDelete=checkConfirm();
		 if(true){


			 $.ajax({
				 
				 	url : 'campus_job_preview.htm',						
					cache : false,
					data: 'jobId='+job_id+"&job_action=Closed",
					success: function (successFlag) 
					{
		             if (successFlag)
			            {
		                  $("#successMessageSpan").empty().append("You've Successfully deleted the Job");
		        	     	 $("#successModal").dialog({
		        	            modal: true,
		        	            open: function(event, ui){
		        	                setTimeout("$('#successModal').dialog('close')",2000);
		        	            }
		         });
		        	     	$('#broadcast_job').hide();
		       	      $('#delete_job').hide();
		             }
		         }
					
			});

			 

			}

			
		}

function goBack()
{
	if(referrerUrl === 'welcome.htm' || referrerUrl === 'university_dashboard.htm')
	{
		 window.location.href="university_dashboard.htm";
	}
	else
	{
		//window.history.back();
		window.location.href = sessionStorage.getItem("referrerUrl");
	}
	
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
      <div id="banner"><img src="images/university_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
    
    <div id="innersection">
    <!--   <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> \ <a href="#">Publish  Jobs / Internships</a> \ Preview of a campus job</div> -->
      
      <section id="leftsection" class="floatleft">
      <div class="candidate_quickaction_wrap">
        <div class="portfolio_img"> 
		<c:choose>
			<c:when test="${companyDetails.imageName ne null}"> 
			<div class="companylogo_rgt"><img src="view_image.htm?emailId=<c:out value="${campusJobDetails.emailId}"/>" height="32" width="110"></div>
			</c:when>
			<c:otherwise>
                    <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
           </c:otherwise>
       </c:choose>
						                     
            <div class="clear"></div>
            <div class="Profile_margin"><a href="profile_preview.htm?companyName=<c:out value="${campusJobDetails.companyName}"/>" class="profile"> Company Profile </a></div>
						                      
            <div class="clear"></div>
            <%-- <div class="Profile_margin"><a href="profile_preview.htm?companyName=${companyDetails.companyName}" class="profile"> Company Profile </a></div> --%>
          </div>
            <div class="line-border">&nbsp;</div>
          <%--   <div class="candidate_upcomingevents_wrap" >
          <c:if test="${jobDetails.jobViewedCount != 0}">
            <div class="floatleft width100 whitebackground">
            <c:choose>
            <c:when test="${jobDetails.jobViewedCount == 1}">
            Person has  <br>viewed this job<span class="count floatright">${jobDetails.jobViewedCount}</span> 
            </c:when>
            <c:otherwise>
            Persons have <br>viewed this job <span class="count floatright">${jobDetails.jobViewedCount}</span>
            </c:otherwise>
            </c:choose>
          </div>
          </c:if>
          
            <c:if test="${jobDetails.responseCount != 0}">
            <div class="floatleft width100 whitebackground">
            <h4><a href="employer_view_job_responses.htm?jobId=${jobDetails.jobIdAndFirmId}"> Application(s)<br> Received <span class="count floatright">${jobDetails.responseCount}</span></a></h4>
             </div>
          </c:if>
          
          </div> --%>
          </div>
       </section>
      
      
      
      
     <!--  <section id="rightwrap" class="floatleft"> -->
      <section id="rightwrap" class="floatleft">
      <div class="whitebackground">
      <c:if test="${not empty success}">
      <input type="hidden" id="jobApplied" value="${success}">
      </c:if>
    
          <div class="left_logowrap">
            <h1 class="sectionheading floatleft"> <c:out value="${campusJobDetails.jobTitle}"/> </h1>
            <div class="jobid">( Job Id <c:out value="${campusJobDetails.jobId}"/>)</div>
            <div class="clear"></div>
            <h3 class="black_heading"><c:out value="${campusJobDetails.companyName}"/></h3>
            <div class="clear"></div>
            <ul class="greylist">
              <li> <c:out value="${campusJobDetails.location}"/> </li>
              <li> <c:out value="${campusJobDetails.experienceFrom}"/> - <c:out value="${campusJobDetails.experienceTo}"/> yrs</li>              
              <li> <c:out value="${campusJobDetails.jobType}"/> </li>            
            </ul>
            <div class="clear"></div>
            <ul class="greylist">
              <li><span class="boldtxt"> Industry:</span> <c:out value="${campusJobDetails.industry}"/> </li>
              <li><span class="boldtxt"> Functional Area:</span> <c:out value="${campusJobDetails.functionalArea}"/> </li>
              <li><span class="boldtxt"> Posted on:</span> <c:out value="${campusJobDetails.postedOn}"/> </li>
            </ul>
          </div>
       <%--    <div class="right_logowrap">
           							<c:choose>
											<c:when test="${companyDetails.imageName ne null}"> 
											<div class="companylogo_rgt"><img src="view_image.htm?emailId=<c:out value="${campusJobDetails.emailId}"/>" height="32" width="110"></div>
											</c:when>
											<c:otherwise>
						                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="32" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose>
						                     
            <div class="clear"></div>
            <div class="Profile_margin"><a href="profile_preview.htm?companyName=<c:out value="${campusJobDetails.companyName}"/>" class="profile"> Company Profile </a></div>
          </div> --%>
    
        <div class="clear"></div>
        <div class="border_dashed">
          <h4 class="bluehead"> Job Description </h4>
          <p class="about_text"><c:out value="${campusJobDetails.jobDescription}"/> </p>
          
           <h4 class="bluehead"> University Name </h4>
          <p class="about_text">
          
          <c:forEach var="universityNames" items="${campusJobDetails.campusJobRecipients}" varStatus="loop" >          	
          		<c:set var="universityNames" value="${fn:replace(universityNames, '[', ' ')}" />          	
          		<c:set var="universityNames" value="${fn:replace(universityNames, ']', ' ')}" /> 
          		<c:set var="universityNamesListSize" value="${fn:length(campusJobDetails.campusJobRecipients)}" />
          			<c:out value="${universityNames}"/>          			
          			<c:choose>          			
        						<c:when test="${universityNamesListSize == loop.index+1}">
        							<c:out value=". "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=", "/>
        						</c:otherwise>
        				</c:choose>  
			</c:forEach>
          </p>
          
          <h4 class="bluehead"> Primary  Skills </h4>
          <p class="about_text">
          
          
          	<c:forEach var="primarySkillsVar" items="${campusJobDetails.primarySkills}" varStatus="loop" >          	
          		<c:set var="primarySkillsVar" value="${fn:replace(primarySkillsVar, '[', ' ')}" />          	
          		<c:set var="primarySkillsVar" value="${fn:replace(primarySkillsVar, ']', ' ')}" /> 
          		<c:set var="primarySkillsListSize" value="${fn:length(campusJobDetails.primarySkills)}" />
          			<c:out value="${primarySkillsVar}"/>          			
          			<c:choose>          			
        						<c:when test="${primarySkillsListSize == loop.index+1}">
        							<c:out value=". "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=", "/>
        						</c:otherwise>
        				</c:choose>  
			</c:forEach>
          
          </p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text">    
            
          	<c:forEach var="secondarySkillsVar" items="${campusJobDetails.secondarySkills}" varStatus="loop" >          	
          		<c:set var="secondarySkillsVar" value="${fn:replace(secondarySkillsVar, '[', ' ')}" />          	
          		<c:set var="secondarySkillsVar" value="${fn:replace(secondarySkillsVar, ']', ' ')}" />
          	<c:set var="secondarySkillsListSize" value="${fn:length(campusJobDetails.secondarySkills)}" />
          	          	<c:out value="${secondarySkillsVar}"/>
          	          	<c:choose>          			
        						<c:when test="${secondarySkillsListSize == loop.index+1}">
        							<c:out value=" "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=" "/>
        						</c:otherwise>
        				</c:choose>    
          	     
			</c:forEach>
          
          
          </p>   
        
         <%-- <h4 class="bluehead"> GPA Cut Off </h4>
          <p class="about_text"><c:out value="${campusJobDetails.gpaCutOffFrom}"/> to <c:out value="${campusJobDetails.gpaCutOffTo}"/></p>
         --%>
          <h4 class="bluehead"> Pay Per Week ($) </h4>
          <p class="about_text"><c:out value="${campusJobDetails.payPerWeek}"/></p>          
          
        </div>
        
        <div id="candidate_registration_wrap">
           <form class="stdform" action="">
          <div class="par">
                <div class="buttonwrap">
                
                <c:if test="${!fn:contains(campusJobDetails.campusJobAppliedStudents, emailId) && headRole == 'STUDENT'}">
                <input name="" type="button" value="Apply" tabindex="23" onclick="window.location.href='candidate_apply_broadcasted_job.htm?jobId=<c:out value="${campusJobDetails.jobIdAndFirmId}"/>'">
                </c:if>
                
                	<c:if test="${campusJobDetails.status =='Published'}">
                	<input name="" id="broadcast_job" type="button" value="Broadcast" tabindex="24"  onclick="broadcastCampusJob('${campusJobDetails.jobIdAndFirmId}')">
                	<%-- <a href="campus_job_preview.htm?jobId=<c:out value="${campusJobDetails.jobIdAndFirmId}"/>&job_action=Closed" onclick="return checkConfirm()"><input name="" id="delete_job" type="button" value="Delete" tabindex="25" ></a> --%>
                	<input name="" id="delete_job" type="button" value="Delete" tabindex="25" onclick="deleteJob('${campusInternshipDetails.internshipIdAndFirmId}')" >
                	</c:if>
                	<input name="backBtn" type="button" value="Back" tabindex="23" onclick="goBack()">
              	</div>
              </div>
            </form>
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

<div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="successModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
    <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>

</body>
</html>
