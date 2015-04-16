<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  <title>Employer Post Job</title>
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
  <script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
 
     <script type="text/javascript" src="js/script.js"></script>
  
  <script type="text/javascript" src="js/jquery-1.7.min.js"></script>
  <script type="text/javascript" src="js/uielements/prettify.js"></script>
  <script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
  <script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
  <script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
 
  
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
     <script type="text/javascript" src="js/script.js"></script>
<style type="text/css">
h1.intro {color:blue;}
p.important {color:green;}
</style>
 
  
<script type="text/javascript">
	function postJob()
	{
		 var formValue= document.getElementById("postForm");
		 
		 if($("#jobTitle").val().trim().length > 50)
		 {
			 $("#jobTitleError").empty().append("Only 50 characters allowed in Job Title");
			 return false;
		 }
		 
		 formValue.action='employer_preview_of_job.htm';
		 formValue.submit(); 
	}  	  
</script>


 <script>
$(document).ready(function () {

var inputVal= $("#from").val();
var inputVal1= $("#to").val();
var inputVal2= $("#from1").val();
var inputVal3= $("#to1").val();

var characterReg = "";
  
	  if(characterReg==inputVal) {
		  
		  var watermark = "From";
			$('#from').val(watermark);
			$('#from').click(function(){
		  		if ($(this).val() == watermark){
		    		$(this).val('');
				}
		 	});
			  
}
	  
	  if(characterReg==inputVal1) {
		  
		  var watermark1 = "To";
			$('#to').val(watermark1);
			$('#to').click(function(){
		  		if ($(this).val() == watermark1){
		    		$(this).val('');
				}
		 	});
			  
}
	  if(characterReg==inputVal2) {

		  var watermark2 = "From";
			$('#from1').val(watermark2);
			$('#from1').click(function(){
		  		if ($(this).val() == watermark2){
		    		$(this).val('');
				}
		 	});
			  
}
	  
	  if(characterReg==inputVal3) {
		  
		  var watermark3 = "To";
			$('#to1').val(watermark3);
			$('#to1').click(function(){
		  		if ($(this).val() == watermark3){
		    		$(this).val('');
				}
		 	});
			  
}

});
</script>


<script>
function goBack(){
  window.history.back(); 
 // window.location.href='employer_jobsinternships_listing.htm';
 }
</script>

<script type="text/javascript">

$().ready(function() {

	
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
	
	/* $.validator.addMethod('numericOnly', function (value) {
	    return /^[0-9]+$/.test(value);
	}, 'Please only enter numeric values (0-9)');
	
	// validate signup form on keyup and submit
	$("#postForm").validate({
		rules: {
			jobId: "required",
			jobTitle: {required:true,maxlength:35},
			location: "required",
			primarySkills:"null",
			jobDescription:"required",
			jobType:"required",
			experienceFrom: {
                numericOnly:true
            },

            experienceTo:
            {
            	 numericOnly:true
           }

		},
		messages: {
			jobId: "Please enter job Id",
			jobTitle: {required: "Please provide  Job Title",maxlength:"Job Title Cannot exceed 35 Characters"},
			location: "Please provide  Location",
			primarySkills: "Please provide  Primary Skills",
			jobDescription:"Please Fill Job Description",
			jobType: "Please select Job Type"

		}
	}); */

	

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
     
 	<c:if test="${not empty param.msg}">
       <span class="errorblock"><c:out value="${param.msg}"></c:out>  </span>
       </c:if>
    <div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_jobs_internships.htm">Publish Jobs &amp; Internships </a> / Publish a Job</div> -->
        <%-- <section id="leftsection" class="floatleft">
        <h3 class="nomargin">Publish Jobs / Internships</h3>
        <ul class="leftsectionlinks">
            <li><a href="#">View Job / Internships</a></li>
            <li><a href="#">View Campus  Jobs / Internships</a></li>
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
            <input name="" type="text" class="textbox">
            <input name="" type="button" value="Subscribe">
          </form>
          </div>
      </section> --%>
        <section id="rightwrap" class="floatleft">
        <div class="whitebackground">
        <h1 class="sectionheading">Post a Job Vacancy</h1>
        
        <p class="description">Post a Job to the world of fresh college graduates from various streams on a click of a button.</p>
        <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
            
            <form:form cssClass="stdform" action="" method="post" modelAttribute="postJob" id="postForm">
            <div class="leftsection_form">
                <div class="par">
                <label class="floatleft">Job ID</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input path="jobId" tabindex="1"  cssClass="input-medium" id="jobId"/>
                  	<form:errors path="jobId"  cssClass="validationnote"/>
        
       				<c:if test="${not empty postJob.exceptionOccured}">
						<div class="errorblock">${postJob.exceptionMessage}</div>
					</c:if> 
                  </span> </div>
              </div>
            <div class="rightsection_form">
                <div class="par">
                <label class="floatleft">Status</label>
                <div class="clear"></div>
                <span class="formwrapper">
               <form:radiobutton path="status" value="Drafts" checked = "true" disabled="true"  />Drafts
               
                </span></div>
              </div>
            <div class="clear"></div>
            <div class="fullwidth_form">
               <!--  <label>Job Title</label> -->
                <label class="floatleft">Job Title</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
              		<form:input path="jobTitle" tabindex="2" cssClass="input-xxlarge width100" id="jobTitle" maxlength="100" />
              		<span id="jobTitleError" class="validationnote"></span>
              		<form:errors path="jobTitle"  cssClass="validationnote"/>
              </span> </div>
            <div class="leftsection_form">
                <div class="par">
                <label class="floatleft">Job Type</label>
                <div class="clear"></div>
                
                  <span class="formwrapper">
                	<form:select path="jobType" tabindex="3" cssClass="chzn-select list_widthstyle1">
					<form:option value="Full Time">Full Time</form:option>
					<form:option value="Part Time">Part Time</form:option> 	
					</form:select>
					<form:errors path="jobType"  cssClass="validationnote"/>
                </span></div>
                 
                <div class="par">
                <label class="floatleft">Functional Area</label>
                <div class="clear"></div>
                
                <span class="formwrapper">
                
                	<form:select path="functionalArea" tabindex="5" cssClass="chzn-select list_widthstyle1" >
					<form:option value="Choose an Option">Choose an Option</form:option>
					<c:forEach var="functionalAreaList" items="${functionalAreaList}">
                     
                     
                    <spring:bind path="postJob.functionalArea"><c:set var = "functionalAreaSelected" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${functionalAreaList == functionalAreaSelected}">
                         <option value="${functionalAreaList}" selected="selected"><c:out value="${functionalAreaList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${functionalAreaList}"><c:out value="${functionalAreaList}" /></option>
                      </c:otherwise>
                   </c:choose>
                     
                   </c:forEach>
					</form:select>
					<form:errors path="functionalArea"  cssClass="validationnote"/>
                  </span>
                 </div>
                <div class="par">
                <label class="floatleft">Primary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                	<form:input id="primarySkills" tabindex="7" path="primarySkills" cssClass="input-large" />
                	<form:errors path="primarySkills"  cssClass="validationnote"/>
                  </span> </div>


                <div class="clear"></div>
                
                <form:hidden path="postedOn"/>
                
                <div class="par">
                <label class="floatleft">Zip code (Job is posted At)</label>
                <span class="star">*</span>
                <div class="clear"></div>
                
                <span class="field">
                  	<form:input tabindex="9" path="zipCode" cssClass="input-xlarge" id="zipCode" onChange="getCityFunction()"/>
              		<form:errors path="zipCode" cssClass="validationnote"/>
              		<span class="errorblock" id="zipCodeError"></span>
                  </span> </div>
                  
                   <div class="par">
                <label class="floatleft">Years Of Experience</label>
                <div class="clear"></div>
                <span class="field">
                	  <form:input tabindex="11" path="experienceFrom" cssClass="input-small1" id = "experienceFrom" placeholder="from"/>  
                	<%-- <form:input path="experienceFrom" cssClass="input-small1" onfocus="if (this.value == 'From') this.value = '';" onblur="if (this.value == '') this.value = 'From';" /> --%>
              		<form:errors path="experienceFrom" cssClass="validationnote"  />
              		
              		 <form:input tabindex="12" path="experienceTo" cssClass="input-small1" id = "experienceTo" placeholder="to"/>  
                	<%-- <form:input path="experienceTo" cssClass="input-small1" onfocus="if (this.value == 'To') this.value = '';" onblur="if (this.value == '') this.value = 'To';" /> --%>
              		<form:errors path="experienceTo" cssClass="validationnote"/>
              	<!-- 	<div id="experienceFromError" class="errorblock" >Please Enter an Integer Value</div> -->
              		
                </span> </div>
               
                  <div class="clear"></div>
                  
                     <%-- <div class="par">
                <label class="floatleft">Years Of Experience</label>
                <div class="clear"></div>
                <span class="field">
                	  <form:input path="experienceFrom" cssClass="input-small1" id = "experienceFrom" />  
                	<form:input path="experienceFrom" cssClass="input-small1" onfocus="if (this.value == 'From') this.value = '';" onblur="if (this.value == '') this.value = 'From';" />
              		<form:errors path="experienceFrom" cssClass="validationnote"  />
              		
              		 <form:input path="experienceTo" cssClass="input-small1" id = "experienceTo" />  
                	<form:input path="experienceTo" cssClass="input-small1" onfocus="if (this.value == 'To') this.value = '';" onblur="if (this.value == '') this.value = 'To';" />
              		<form:errors path="experienceTo" cssClass="validationnote"/>
              	<!-- 	<div id="experienceFromError" class="errorblock" >Please Enter an Integer Value</div> -->
              		
                </span> </div> --%>
              </div>
            <div class="rightsection_form">
                <div class="par">
                <label class="floatleft">Pay Per Week ($)</label>
                <div class="clear"></div>
                <span class="field">
                 	<form:input path="payPerWeek" tabindex="4" cssClass="input-xxlarge" />
              		<form:errors path="payPerWeek" cssClass="input-xxlarge"/>
                  </span> </div>
                <div class="par">
                <label class="floatleft">Industry</label>
                <div class="clear"></div>
                <span class="formwrapper">
                  <form:select path="industry" tabindex="6" cssClass="chzn-select list_widthstyle1">
					<form:option value="Choose an Option">Choose a Option</form:option>
					<c:forEach var="industryList" items="${industryList}">
                     
                     
                   <spring:bind path="postJob.industry">
                   	<c:set var = "industrySelected" value="${status.value}"/>
                   </spring:bind>
                    
                   <c:choose>
                      <c:when test="${industryList == industrySelected}">
                         <option value="${industryList}" selected="selected"><c:out value="${industryList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${industryList}"><c:out value="${industryList}" /></option>
                      </c:otherwise>
                   </c:choose>
                                          
                   </c:forEach>
                   
					</form:select>
					<form:errors path="industry"  cssClass="chzn-select list_widthstyle1"/>
                  </span> </div>
                <div class="par">
                <label class="floatleft">Secondary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="8" id="tags1" path="secondarySkills" cssClass="input-large" />
              		<form:errors path="secondarySkills" id="tags1"  cssClass="validationnote"/>
                  </span> </div>
                           <div class="par">
               <%--  <label class="floatleft">GPA Cut-Off</label>
                <div class="clear"></div>
                <span class="field">
                  <form:input path="gpaCutOffFrom" cssClass="input-small1" id = "from1" />  
                 	<form:input path="gpaCutOffFrom" cssClass="input-small1" onfocus="if (this.value == 'From') this.value = '';" onblur="if (this.value == '') this.value = 'From';" />
              		<form:errors path="gpaCutOffFrom" cssClass="input-small1" />
              		
              		 <form:input path="gpaCutOffTo" cssClass="input-small1" id = "to1" /> 
                  	<form:input path="gpaCutOffTo" cssClass="input-small1" onfocus="if (this.value == 'To') this.value = '';" onblur="if (this.value == '') this.value = 'To';" />
              		<form:errors path="gpaCutOffTo" cssClass="input-small1"/>
                  </span> --%> </div>
               
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
                <%-- <div class="par">
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
                
                
                  
                 
                <div class="par">
                <label class="floatleft">Job Description</label>
                <span class="star">*</span>
                <div class="clear"></div>
                
               <!--   <textarea name="wysiwyg" id="wysiwyg1" rows="5" cols="47" class="txteditor_width"></textarea> -->
                 <form:textarea path="jobDescription"  tabindex="13" rows="5" cols="47" cssClass="txteditor_width" />   
                <form:errors path="jobDescription" id="jobDescription" rows="5" cols="47"  cssClass="validationnote"/>
              </div>
                <div class="par">
                <div class="buttonwrap">
	
                   <!--  <input name="" type="submit" value="Save" tabindex="21" > -->
                   <!--  <input name="" type="button" value="Preview" tabindex="22"  onClick ="window.location.href='employer_preview_of_job.htm'"> -->
                    <input name="previewBtn" type="button" value="Preview" tabindex="14" onclick="return postJob()">
                    <input name="backBtn" type="button" value="Back" tabindex="15" onclick="goBack()">
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
