<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Post Internship</title>
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
  
  $().ready(function(){
	  $("#internshipTitle").change(
				function(){
					if($("#internshipTitle").val().trim().length > 50)
					{
						$("#internshipTitleError").empty().append("Only 50 characters allowed in Internship Title");
						return false;
					}
					else
						$("#internshipTitleError").empty();
				}
			);
		
	  
	  $("#postInternshipForm").submit(function(){
			
			 if($("#internshipTitle").val().trim().length > 50)
			 {
				 $("#internshipTitleError").empty().append("Only 50 characters allowed in Internship Title");
				 return false;
			 }
			
			 $("#postInternshipForm").submit();
			
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
   <script>
function goBack()
	{
	  window.history.back();
	}		
</script>
  
<!--  Commented on 31-1-2014 to provide Save Functionality only on Preview of Job-->
<!-- <script>
 $(document).ready(function(){	
	 
	 
	$('#button1').click(function(){ 
		$('#postInternshipForm').attr('action','employer_campus_posta_internship.htm?paramName=save');
		$('#postInternshipForm').submit();		
	});	 
	 
	 
	 $(document).ready(function(){ 
		$('#button2').click(function(){										
		 	$('#postInternshipForm').attr('action','employer_campus_posta_internship.htm?paramName=preview');
			$('#postInternshipForm').submit();	
		});	
	 });  
 
 });
	 
			
</script> -->

<script>
  $(function() {
    $( "#from" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#to" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#from" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
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
<style>
.errorblock {
	color: #ff0000;
}
</style>


</head>
<body>
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		
		<%@ include file="includes/header.jsp"%>
	
		<!--------------  Header Section :: end ------------>
		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
			<div id="innerbanner_wrap">
				<div>
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
					You are here: <a href="university_dashboard.htm">Home</a> / 
					<a href="university_internal_postings.htm">Internal Postings </a> / Publish an Internship to Campus
				</div> -->
			<%-- 	<section id="leftsection" class="floatleft">
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
					<h1 class="sectionheading">Publish an Internship to Campus</h1>
					<p class="description">Post an Internship exclusively to your Students.</p>
					<div class="form_messages">
						<span class="message">Denotes required fields</span><span
							class="star">*</span>
					</div>
					<div class="clear"></div>
					<div id="candidate_registration_wrap">
						<form:form class="stdform" action="university_post_internship.htm?post=true"  method="post" modelAttribute="universityJobCom"  id="postInternshipForm" >
							<div class="leftsection_form">
								<div class="par">
									<label class="floatleft">Internship ID</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> 
									
									<c:choose>
										<c:when test="${not empty universityJobCom.updateFlag &&  universityJobCom.updateFlag}">
											<form:input tabindex="1" path="internshipId" readonly="true" cssClass="input-medium" />
										</c:when>
										<c:otherwise>
											<form:input tabindex="1" path="internshipId" cssClass="input-medium" />
										</c:otherwise>
									</c:choose>
										
											<form:errors path="internshipId"cssClass="validationnote" />
											<%--  <c:if	test="${not empty universityJobCom.exceptionOccured}">
												<div class="errorblock">${universityJobCom.exceptionMessage}</div>
					  						 </c:if> --%>
					  						 
									</span>
								</div>
								
								<form:hidden path="status" value="${universityJobCom.status}"/>
								<form:hidden path="updateFlag" value="${universityJobCom.updateFlag}"/>
								
								<div class="par">
									<label class="floatleft">Internship Type</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> 
									
									<form:select tabindex="3" path="internshipType" items="${internshipTypes}" data-placeholder="Choose an Option" class="chzn-select list_widthstyle1">
									</form:select> 	
									</span>
									<form:errors path="internshipType"cssClass="validationnote" />
								</div>
								<div class="par">
									<label class="floatleft">Duration</label>
									<div class="clear"></div>
									<span class="field floatleft"> <form:input tabindex="5"	path="startDate" cssClass="input-small1" id="from" readonly="true" placeholder="Start Date"/>
									</span> <span class="field floatright"> <form:input tabindex="6" path="endDate" class="input-small1" id="to" readonly="true" placeholder="End Date"/>
									</span>
									<div class="clear"></div>
								</div>
								<div class="par">
									<label class="floatleft">Primary Skills Required</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> <form:input tabindex="10" path="primarySkills" id="tags" class="input-large" />
											<form:errors path="primarySkills"cssClass="validationnote" />
									</span>
								</div>
								
								<form:hidden path="postedOn"/>
								 <div class="par">
								                <label class="floatleft">Zip code (Job is posted At)</label>
								                <span class="star">*</span>
								                <div class="clear"></div>
								                
								                <span class="field">
								                  	<form:input tabindex="12" path="zipCode" cssClass="input-xlarge" id="zipCode" onChange="getCityFunction()"/>
								              		<form:errors path="zipCode" cssClass="validationnote"/>
								              		<span class="errorblock" id="zipCodeError"></span>
                 								 </span>
                 			  </div>
								
								
								<div class="par">
									<label class="floatleft">Number of Vacancies</label>
									<div class="clear"></div>
									<span class="field"> <form:input path="vacancyCount" tabindex="8" class="input-medium" />
											
									</span>
								</div>
								
							</div>
							<div class="rightsection_form">
								<div class="par">
									<label class="floatleft">Internship Title</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field">
									<%-- <c:choose>
										<c:when test="${not empty universityJobCom.updateFlag &&  universityJobCom.updateFlag}">
											 <form:input tabindex="2" path="internshipTitle" readonly="true" class="input-medium" />
										</c:when>
										<c:otherwise> --%>
											 <form:input tabindex="2" path="internshipTitle" class="input-medium" maxlength="100" id="internshipTitle" />
									<%-- 	</c:otherwise>
									</c:choose> --%>
											<span id="internshipTitleError" class="validationnote"></span>
											<form:errors path="internshipTitle"cssClass="validationnote" />
									</span>
								</div>
								<div class="par">
									<label class="floatleft">Approximate Hours</label>
									<div class="clear"></div>
									<span class="field"> 
									<form:input tabindex="4" path="approximateHours" class="input-medium" /> 
											
									</span>
								</div>
								<div class="par">
									<label class="floatleft">Pay Per Hour ($)</label>
									<div class="clear"></div>
									<span class="field"> <form:input tabindex="7" path="payPerHour" class="input-medium" />
									</span>
								</div>
								
								<div class="par"></div>
								<%-- <div class="par">
									<label class="floatleft">Name Of the Universities</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="formwrapper">
									
										<form:select tabindex="9" path="campusJobRecipients" multiple="multiple" cssClass="chzn-select list_widthstyle1" >
                        					<form:options items="${universityList}" />                    
                        				</form:select>
									
								
									</span>
									<form:errors path="campusJobRecipients"cssClass="validationnote" />
								</div> --%>
								<div class="par">
									<label class="floatleft">Secondary Skills Required</label> <span
										class="star">*</span>
									<div class="clear"></div>
									<span class="field"> <form:input path="secondarySkills"
											tabindex="11" id="tags1" class="input-large" />
											
											
											<form:errors path="secondarySkills"cssClass="validationnote" />
									</span>
								</div>
								
								
								 <div class="par">
                <label class="floatleft">City</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="13" path="location" cssClass="input-xxlarge" id="location"/>
                  	<form:errors path="location" cssClass="validationnote"/>
                </span> </div>
                  <div class="clear"></div><div class="clear"></div>
								
							</div>
							<div class="clear"></div>
							<div class="fullwidth_form">

								<div class="par">
									<label class="floatleft">Internship Description</label> <span
										class="star">*</span>
									<div class="clear"></div>
										 <form:textarea tabindex="14" path="internshipDescription" id="internshipDescription" rows="5" cols="47" cssClass="txteditor_width" />  
										<form:errors path="internshipDescription"cssClass="validationnote" />
									
								</div>
								<div class="par">
									<div class="buttonwrap">
										<input name="submitBtn" type="submit"  value="Preview" tabindex="15" >								
										<input name="backBtn" type="button"  value="Back" tabindex="16" onclick="goBack()">
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
	<script type="text/javascript" src="js/nav_script.js"></script>
	<script>Cufon.now();</script>
</body>
</html>