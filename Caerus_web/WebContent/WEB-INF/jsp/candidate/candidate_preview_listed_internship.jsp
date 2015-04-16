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
<title> Internship Preview </title>
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
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />
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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
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


 <script>
 var referrer;
 var referrerUrl;
 $(document).ready(function () {

	 $('#functionalAreaPopOver').webuiPopover({
         constrains: 'horizontal', 
         trigger:'click',
         multi: true,
         placement:'right-bottom',
         width:675,
         closeable:true,
         content: $('#demo2_tip1').html()
 	});

	 $('#industryPopOver').webuiPopover({
         constrains: 'horizontal', 
         trigger:'click',
         multi: true,
         placement:'right-bottom',
         width:675,
         closeable:true,
         content: $('#demo2_tip2').html()
 	});

	 $('#locationPopOver').webuiPopover({
         constrains: 'horizontal', 
         trigger:'click',
         multi: true,
         placement:'right-bottom',
         width:675,
         closeable:true,
         content: $('#demo2_tip3').html()
 	});

	 $('#jobTypePopOver').webuiPopover({
         constrains: 'horizontal', 
         trigger:'click',
         multi: true,
         placement:'right-bottom',
         width:675,
         closeable:true,
         content: $('#demo2_tip4').html()
 	});

	 var resultCountMap = $("#resultCountMap").val();

	if(null == resultCountMap || resultCountMap == '0')
	{
		$("body").removeClass("dashboard");
		$("#leftsection").hide();
	}

 	var referrer =  document.referrer;
 	if(referrer.indexOf("?") > -1)
     {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.lastIndexOf("?"));        	
     }
 	else
     {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.length);
     }
 });

function getJobs(elementId)
{
 	var formId = $('#' + elementId).parents('form').attr('id');
 	$("#"+formId).submit();
}
 
function goBack()
{
  window.history.back();
}

function saveInternship()
{
	internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_save_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId
		},	
		
		success : function(data) {
				
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Saved Successfully");
			    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
			            }
		 			});
				
				//timeoutfunction(); 
			    //  location.reload();
				    $("#saveInternshipButton").hide();
				    $("#applyInternshipButton").hide();
				    $("#applySavedInternshipButton").show();
		
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function applyInternship()
{	

	internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId,
		},	
		
		success : function(exceptionOccured) {
			if(exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Applied Successfully");
			    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
			            }
		 			});
				
				timeoutfunction(); 
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function applySavedInternship()
{
	internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_saved_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId
		},	
		
		success : function(data) {
				
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Applied Successfully");
			    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
			            }
		 			});
				
				timeoutfunction(); 
		
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}
function timeoutfunction()
{
	if(referrerUrl === 'candidate_job_activities.htm')
	{
		setTimeout(function(){window.location='candidate_job_activities.htm';}, 2510);
	}

	if(referrerUrl === 'candidate_job_listing.htm')
	{
		setTimeout(function(){window.location='candidate_job_listing.htm';}, 2510);
	}

	if(referrerUrl === 'candidate_search_jobs_internships.htm')
	{
		setTimeout(function(){$("#hiddenForm").submit();}, 2510);
	}

	if(referrerUrl === 'candidate_basic_search.htm')
	{
		setTimeout(function(){ window.history.back();}, 2510);
	}

	if(referrerUrl === 'candidate_all_recent_jobs.htm')
	{
		setTimeout(function(){ window.history.back();}, 2510);
	}
} 

</script>
<style type="text/css">
.details form{margin-bottom:10px;"}
</style>
</head>
<body class="dashboard">
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
    <form action="candidate_search_jobs_internships.htm" method="post" id ="hiddenForm">
       <input type="hidden" name="searchCriteria" value="Internships" />
       <input type="hidden" name="keyword" value="${keyword}" />
       <input type="hidden" name="industry" value="${industry}" />
       <input type="hidden" name="location" value="${location}" />
       <input type="hidden" name="functionalArea" value="${functionalArea}" />
        <input type="hidden" name="jobType" value="${jobType}" />
       </form>
      <section id="rightwrap" class="floatleft">
      <!-- <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home </a> \ <a href="candidate_basic_search.htm">Advance Search</a> \ Internship Preview</div> -->
          
           <div class="whitebackground">
          <div class="left_logowrap">
            <h1 class="sectionheading floatleft"><c:out value="${internship.internshipTitle}"/></h1>
            <input type="hidden" id="internship_id_and_firm_id" value="${internship.internshipIdAndFirmId}" />
            <div class="jobid">( Internship Id <c:out value="${internship.internshipId}"/> )</div>
            <div class="clear"></div>
            <h3 class="black_heading"> <c:out value="${internship.companyName}"/></h3>
            <ul class="greylist">
              <li>  <c:out value="${internship.location}"/>  </li>
              <li>  <c:out value="${internship.startDate}"/>  to  <c:out value="${internship.endDate}"/>  </li>              
              <li>  <c:out value="${internship.internshipType}"/> </li>
            </ul>
            <div class="clear"></div>
            <ul class="greylist">
            <fmt:parseDate value="${internship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
              <li><span class="boldtxt"> Posted on:</span> <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/> </li>
            </ul>
          </div>
          <div class="right_logowrap">
      
         			
         							 <c:choose>
											<c:when test="${companyDetails.imageName ne null}"> 
											<div class="companylogo_rgt"><img src="view_image.htm?emailId=${companyID}" height="32" width="110"></div>
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
          <h4 class="bluehead"> Internship Description </h4>
          <p class="about_text"> <c:out value="${internship.internshipDescription}"/> </p> 
          
           <h4 class="bluehead"> Primary  Skills </h4>
          <p class="about_text"><c:out value="${internship.primarySkills.toString().replace('[', '').replace(']', '')}"/>  </p>
          
          <h4 class="bluehead"> Secondary  Skills </h4>
          <p class="about_text"> <c:out value="${internship.secondarySkills.toString().replace('[', '').replace(']', '')}"/> </p>
          
          <h4 class="bluehead"> Approximate Hours </h4>
          <p class="about_text"> <c:out value="${internship.approximateHours}"/> </p>          
          
          <h4 class="bluehead"> Pay Per Hour ($) </h4>
          <p class="about_text"> <c:out value="${internship.payPerHour}"/> </p>
        </div>
           <div id="candidate_registration_wrap">
           
           <form class="stdform" action="">
          <div class="par">
      	 <div class="buttonwrap">
      	  <c:choose>
                <c:when test="${internship.status eq 'Closed' || job.status eq 'closed'}">
                <input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
                </c:when>
                <c:otherwise>
                <c:choose>
                  <c:when test="${appliedInternshipIdsMap.containsKey(param.internshipId)}">
               <!--    <a href="#myModal1" data-toggle="modal"><input name="recommend" id="send01" type="button" value="Share" tabindex="22"></a> -->
                  <input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
               </c:when>
                
                 <c:when test="${savedInternshipIdsMap.containsKey(param.internshipId)}">
                  <input name="" type="button" value="Apply" tabindex="21" onclick="applySavedInternship()" >
                
                  <input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
                </c:when>
                <%-- <c:if test="${!savedJobIdsMap.containsKey(param.jobId) && !appliedJobIdsMap.containsKey(param.jobId)}"> --%>
                <c:otherwise>
                 <input name="" type="button" value="Save" tabindex="22" onclick="saveInternship()" id="saveInternshipButton">
                  <input name="" type="button" value="Apply" tabindex="21" onclick="applyInternship()" id="applyInternshipButton">
                  <input name="" type="button" value="Apply" tabindex="21" onclick="applySavedInternship()" id="applySavedInternshipButton" style="display: none;">
                  <input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
                  </c:otherwise>
             </c:choose>
      	 </c:otherwise>
      	 </c:choose>
      	 
      	  <input type = "hidden" name="internshipId" id = "internshipId"  value="<%= request.getParameter("internshipId") %>">
      	 
      	 
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
