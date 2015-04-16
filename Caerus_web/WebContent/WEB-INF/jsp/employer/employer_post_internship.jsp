<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Employer Post Internship</title>
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
  /* 

	    $().ready(function() {
	    $("#postForm").submit(function() {
	        var inputVal= $("#tags").val();
	      
	        var characterReg = "";
	          
	        	  if(characterReg==inputVal) {
	        		  
	        		  $("#spn1").remove();
	            $("#tags_tagsinput").after('<span id="spn1" style="color: #f00; font-size: 11px;">Fill Primary skills </span>');
	            
	            
	        }  
	        	   if(characterReg!=inputVal){
	        		   
	        		   $("#spn1").remove();
	        		   $("#tags_tagsinput").after('<span class="important">    </span>');
	   	            
	        		   
	        	   }
	        	           
	    });
	    
	    });
	    
	    $().ready(function() {
		    $("#postForm").submit(function() {
		      	  
		        	  var inputVal= $("#tags1").val();
		    	     
		    	        var characterReg = "";
		    	       
		    	       
		    	        	  if(characterReg==inputVal) {
		    	        		  
		    	        		 
		    	        		  $("#spn2").remove();
		    	            $("#tags1_tagsinput").after('<span id="spn2"  style="color: #f00; font-size: 11px;">Fill Secondary skills</span>');
		    	            
		    	            
		    	        }  	  
		    	        	  if(characterReg!=inputVal){
		    	        		  $("#spn2").remove();
		    	        		  $("#tags1_tagsinput").after('<span class="error">  </span>');
		    	        		  
		    	        	  }
		    });
		    
		    }); */
	    
	    
	    
	    
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
		
	});


	function previewInternship()
	{
		 if($("#internshipTitle").val().trim().length > 50)
		 {
			 $("#internshipTitleError").empty().append("Only 50 characters allowed in Internship Title");
			 return false;
		 }
		
		 var formValue= document.getElementById("postForm");
		 formValue.action="employer_post_internship.htm";
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
		  //alert('hello');
		  
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
	

});
</script>

  <script>
  $(function() {
    $( "#from2" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#to2" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to2" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#from2" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
  </script>
 <!--  
<script type="text/javascript">

$().ready(function() {
	//alert("w");

	// validate signup form on keyup and submit
	
	$("#postForm").validate({
		
		rules: {
			
			internshipId: "required",
			internshipType: "required",
			internshipTitle: {required:true,maxlength:35},
			location: "required",
			primarySkills:"required",
			secondarySkills:"required",
			internshipDescription:"required",		
			/* endDate:{
               greaterThan: "#datepicker1"              
            }
 */
		},
		messages: {
			internshipId: "Please enter Internship Id",
			internshipType: "Please provide Internship Type",
			internshipTitle: {required:"Please enter Internship Title",maxlength:"Internship Title Cannot Exceed 35 Characters"},
			location: "Please provide  Location",
			primarySkills: "Please provide  Primary Skills",
			secondarySkills: "Please provide  Secondary Skills",
			internshipDescription:"Please Fill Internship Description",
			/* endDate:
            { 
                 greaterThan:"End Date < Start Date!"
            } */
			
		}
		
		
	});

});
</script>  
 -->
<script>
function goBack(){
  window.history.back();
	//window.location.href='employer_jobsinternships_listing.htm';
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
        <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_jobs_internships.htm">Publish Jobs &amp; Internships </a> / Publish an Internship</div> -->
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
        <h1 class="sectionheading">Publish an Internship</h1>
        <p class="description">Post a Internship to the world of fresh college graduates from various streams on a click of a button.</p>
        <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
            <form:form cssClass="stdform" action="employer_post_internship.htm" method="POST" modelAttribute="postInternship" id="postForm">
            <div class="leftsection_form">
                <div class="par">
                <label class="floatleft">Internship ID</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                 
                 <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                 	 <form:hidden path="jobUpdateFlag" value="true" />
	                 	 <form:input tabindex="1" path="internshipId" cssClass="input-medium" readonly="true"/>
	                 </c:when>
	                 <c:otherwise>
	                 	 <form:input tabindex="1" path="internshipId" cssClass="input-medium"/>
	                 </c:otherwise>
                 </c:choose>
                 
                  <form:errors path="internshipId"  cssClass="validationnote"/>
                 <c:if	test="${not empty postInternship.exceptionOccured}">
						<div class="errorblock">${postInternship.exceptionMessage}</div>
					  </c:if>
                  </span> </div>
                  
              </div>
            <div class="rightsection_form">
            <div class="par">
                <label class="floatleft">Status</label>
                <div class="clear"></div>
                <span class="formwrapper">
              
               <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                   <c:if test="${! statusDisp.equals('Closed')}">
                 			 <form:radiobutton path="status" value="${statusDisp}"  checked="true"/> <c:out value="${statusDisp}"/> 
                		</c:if>
                  			<form:radiobutton tabindex="2" path="status" value="Closed" />Close 
	                 </c:when>
	                 <c:otherwise>
	                 	<form:radiobutton path="status" value="Drafts" checked = "true" readonly="true"  /> Drafts
	                 </c:otherwise>
                 </c:choose>
               
               
             
               
                </span></div>
            </div>
  			<div class="clear"></div>
  			<div class="fullwidth_form">
  			<div class="par">
                <label class="floatleft">Internship Title</label>
                <span class="star">*</span>  
                <div class="clear"></div>
                <span class="field">
                  
                      <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                 	 <input type="hidden" value="true" name="jobUpdateFlag"/>
	                 	 <form:input tabindex="3" path="internshipTitle" cssClass="input-xxlarge1" readonly="true" id="internshipTitle"/>
	                 </c:when>
	                 <c:otherwise>
	                 	 <form:input tabindex="3" path="internshipTitle" cssClass="input-xxlarge1" maxlength="100" id="internshipTitle" />
	                 </c:otherwise>
                 </c:choose>
				  <span id="internshipTitleError" class="validationnote" ></span>
                  <form:errors path="internshipTitle"  cssClass="validationnote"/>
                  </span> </div>
  
  	  </div>
  
   			<div class="leftsection_form">
                
                <div class="par">
                <label class="floatleft">Internship Type</label>
                 <span class="star">*</span> 
                <div class="clear"></div>
                <span class="field">
                
                <form:select tabindex="4" path="internshipType" cssClass="uniformselect">
                	<form:option value="">Choose One</form:option>
					<form:option value="Full Time">Full Time</form:option>
					<form:option value="Part Time">Part Time</form:option> 
				</form:select> 
				
               	</span> </div>
               	
                <div class="par">
                <label class="floatleft">Duration</label>
                <div class="clear"></div>
                <span class="field floatleft">
	                <form:input tabindex="6" path="startDate" cssClass="input-small1" id="from2" readonly="true" placeholder="Start Date"/>
                </span>
                 <span class="field floatright">
	                 <form:input tabindex="7" path="endDate" cssClass="input-small1" id="to2" readonly="true" placeholder="End Date"/>
                 </span> </div>
                   <div class="clear"></div>
                  <div class="par">
                <label class="floatleft">Primary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                 	<form:input tabindex="9" id="tags" path="primarySkills" cssClass="input-large" />
                	<form:errors path="primarySkills" id="tags"  cssClass="validationnote"/>
                  </span> </div>
                 
                 <form:hidden path="postedOn" />
                 
                     <div class="par">
                <label class="floatleft">Zip code (Job is posted At)</label>
                <span class="star">*</span>
                <div class="clear"></div>
                
                <span class="field">
                  	<form:input tabindex="11" path="zipCode" cssClass="input-xlarge" id="zipCode" onChange="getCityFunction()"/>
              		<form:errors path="zipCode" cssClass="validationnote"/>
              		<span class="errorblock" id="zipCodeError"></span>
                  </span> </div>
              </div>
            <div class="rightsection_form">
            
                
                <div class="par">
                <label class="floatleft">Approximate Hours</label>
                <div class="clear"></div>
                <span class="field">
                  <form:input tabindex="5" path="approximateHours" cssClass="input-medium"/>
                  <form:errors path="approximateHours"  cssClass="input-medium"/>
                  </span> </div>
                <div class="par">
                <label class="floatleft">Pay Per Hour ($)</label>
                <div class="clear"></div>
                <span class="field">
                   <form:input tabindex="8" path="payPerHour" cssClass="input-medium"/>
                  <form:errors path="payPerHour"  cssClass="input-medium"/>
                  </span></div>
                  
                  <div class="par">
                <label class="floatleft">Secondary Skills Required</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  <form:input tabindex="10" id="tags1" path="secondarySkills" cssClass="input-large" />
              	<form:errors path="secondarySkills" id="tags1"  cssClass="validationnote"/>
                  </span> </div>
                  
                     <div class="par">
                <label class="floatleft">City</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                  	<form:input tabindex="12" path="location" cssClass="input-xxlarge" id="location"/>
                  	<form:errors path="location" cssClass="validationnote"/>
                </span> </div>
                  
                  
              </div>
            <div class="clear"></div>
            <div class="fullwidth_form">
                
                  <%-- 
                      <div class="par">
                <label class="floatleft">Where (Location)</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                <form:input path="location" cssClass="input-xxlarge"/>
                  <form:errors path="location"  cssClass="input-xxlarge"/>
                 </span> </div> --%>
                 
                  <div class="clear"></div>
                 
                 
                 
          			 <div class="par">
                <label class="floatleft">Internship Description</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <form:textarea tabindex="13" path="internshipDescription"  rows="5" cols="47" cssClass="txteditor_width" />  
                <form:errors path="internshipDescription" id="internshipDescription" rows="5" cols="47"  cssClass="validationnote"/>
              </div>
           			 <div class="par">
                       <div class="buttonwrap">
                    <input name="previewBtn" type="button" value="Preview" tabindex="14" onclick="return previewInternship();">
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