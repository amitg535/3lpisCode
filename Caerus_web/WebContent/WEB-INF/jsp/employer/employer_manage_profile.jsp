<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Profile</title>
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
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery-loader.js"></script>

 <script type="text/javascript" src="http://platform.linkedin.com/in.js">
  api_key: 75eflau76qbl9b
  onLoad: onLinkedInLoad
  // authorize: true
  </script>  

   <script type="text/javascript">
   
   // Setup an event listener to make an API call once auth is complete
   function onLinkedInLoad() {
    IN.Event.on(IN, "auth", shareContent);
   } 
      
  // Handle the successful return from the API call
  function onSuccess(data) {
	  $('#dialog').dialog('close');
    	var employerDom = new Object();

    	if(null != data.companyType)
    		employerDom.companyType = data.companyType.name;
		if(null != data.description)
    		employerDom.companyDesc = data.description;

		if(null != data.employeeCountRange)
			employerDom.noOfEmployees = data.employeeCountRange.name;

		if(null != data.industries)
		{
			var industries = data.industries;
			var industryCount = industries._total;
			if(industryCount > 0)
			{
				employerDom.industry = industries.values[0].name;
			}
  		}
  		
		if(null != data.locations)
		{
			var locations = data.locations;
			var locationCount = locations._total;
			if(locationCount > 0)
			{
				if("" != locations.values[0].address.city)
					employerDom.city = locations.values[0].address.city;
				if("" != locations.values[0].address.street1)
					employerDom.addressLine1 = locations.values[0].address.street1;
				if("" != locations.values[0].address.state)
					employerDom.state = locations.values[0].address.state;
				if("" != locations.values[0].address.postalCode)
					employerDom.postalCode = locations.values[0].address.postalCode;
				if("" != locations.values[0].contactInfo.phone1)
					employerDom.phoneNumber = locations.values[0].contactInfo.phone1;
				if("" != locations.values[0].contactInfo.fax)
				{
					var arr = [];
					arr.push(locations.values[0].contactInfo.fax);
					employerDom.faxNumbers = arr;
				}
			}
  		}

  		if(null != data.websiteUrl)
			employerDom.companyWebsite = data.websiteUrl;

		  $.ajax({

			  	type : 'POST',
			 	url : 'employer_import_profile.json',						
				dataType : 'json',
				contentType : 'application/json',
				cache : false,
				data : JSON.stringify(employerDom),	
				
				success : function(data) {
					location.reload();
				},
				
				error : function(xhr,error) {
					alert("Failed");
				}
		  }); 

		 // added to clear linkedIn cache
	   	 IN.User.logout();
    	
  }

   // Handle an error response from the API call
   function onError(error) {
	$("#errorMsg").empty().append('Selected company is inactive. Please select another company');
    //console.log(error);
  } 

  // Use the API call wrapper to share content on LinkedIn
  function shareContent() {

	  var companyName = '<%=session.getAttribute("compName") %>';

	   $.ajax({

		  	type : 'GET',
		  	dataType : 'jsonp',
		 	url : 'https://www.linkedin.com/ta/federator?query='+companyName+'&types=company,group,sitefeature',						
			contentType : 'application/json',
			cache : false,
			
			success : function(data) {
				if(jQuery.isEmptyObject(data))
				{
					$('#myModalLabelHeading').empty().append("Company does not exist");
					$(".blutitle18").empty();
					$(".margin_top2").empty();
					$("#errorMsg").empty().append('Please enter the company details manually');
					
					// added to clear linkedIn cache
				   	IN.User.logout();
				}
				else
				{
					if(data.company.resultList.length > 1)
					{
						$('#myModalLabelHeading').empty().append("We found more than one result. Please select one company");
						$(".blutitle18").empty();
						$(".margin_top2").empty();
						for(i = 0; i < data.company.resultList.length; i++)
						{
							$(".margin_top2").append('<li><input type="radio" name="companyName" value="'+data.company.resultList[i].id+'" class="subscriberadio">&nbsp;'+ data.company.resultList[i].displayName+'</li>');
						} 
						
						$(".modal-footer").show();
						
					} 
					else
					{
						 var companyId = data.company.resultList[0].id;
						 getData(companyId); 
						 $('#dialog').dialog('close');
					}
				}
				
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
		});  

  }

function getData(companyId)
{
	 IN.API.Raw("/companies/" + companyId + ":(description,company-type,website-url,industries,logo-url,employee-count-range,locations:(address:(street1,city,state,postal-code),contact-info:(phone1,fax)))")
     .body()
     .result(onSuccess)
     .error(onError); 
}
  
function getCompany()
{
	if(null != $('input[name="companyName"]:checked').val() && $('input[name="companyName"]:checked').val() != "")
		getData($('input[name="companyName"]:checked').val()); 
	else
		$("#errorMsg").empty().append("Please select one company");
}
  
</script> 

<script type="text/javascript">
$(window).load(function(){
    // executes when complete page is fully loaded, including all frames, objects and images
    $('#loader').fadeOut();
}); 

$(document).ready( function(){

	$("#closeDialog").click(function(){
		$('#dialog').dialog('close');
	});

   $("#recruitmentTreeBtn").click(function(){

	$("#hplist").empty();
	var array = new Array();

	var vEmptyTextBox = $(".txt").filter(function(){
    return $.trim($(this).val()) == '';
	}).length;
		
	var maxIdCount = 4;
	if(vEmptyTextBox != 0)
	{
		maxIdCount = ( maxIdCount) - Number(vEmptyTextBox);
	}
	// Checking if all the text boxes are empty(vEmptyTextBox = 5 if all the text boxes are empty)
	if(vEmptyTextBox != Number(5))
    {	
		 $(':text').each(function( i ) {
		  i = Number(i);

		  if($.trim($("#stage_"+i).val()) != '')
		  	array.push($("#stage_"+i).val());

			    if(Number(i) < Number(maxIdCount))
				{
							var newIVal = i + 1;
							if( $("#stage_"+newIVal).val() != '' && $("#stage_"+i).val() == '')
							{
								alert("Please Enter Proper Values");
								return false;
							}
							if( $("#stage_"+newIVal).val() != '' && $("#stage_"+i).val() != '')
							{
								$("#hplist").last().append('<li style="width:10%;"><span class="bullet_number">'+ (i+1) +'</span>   '+$("#stage_"+i).val()+'</li>');
							}
			   }
						if(Number(i) == Number(maxIdCount))
						{	
							$("#hplist").last().append('<li style="width:10%;"><span class="bullet_number">'+ (i+1) +'</span>   '+$("#stage_"+i).val()+'</li>');
						}
				});
	}
	else
	 alert("Please Enter at Least one Recrutiment Stage");

	$('input[name=hiringProcess]').val("");
	$('input[name=hiringProcess]').val(array);
  });
});
	
$(function(){
//Emptying all the Existing Values on click of reset
  $('#resetButton').click(function(){
	  $("#hplist").empty();
	  $('input[name=hiringProcess]').val("");
	  $('div#recruitmentTreeDiv input[type="text"]').val('');
  });
});
</script>

<script type="text/javascript">

$(document).ready(function () {

	var loginAttempts = $("#loginAttempts").val();
    if(loginAttempts == "0")
    {
 			$("#dialog").dialog({
             modal: true,
    		 draggable: false,
     		});
    }
    
    $('#employerUpdateProfileForm').validate({
        rules: {
        	brochure: {
                extension: "pdf"
            }
        },
        messages: {
        	brochure: {
                extension: "Please upload a PDF Brochure"
            }
        }
    });
    
});

function getCityFunction()
{
	var zipCode=$("#postalCode").val();
	   
      $.ajax({
        
        url: 'get_city_name.htm',
        data : {
			'zipCode' : zipCode
		},
        cache: false,
   	    success: function(cityName) {
   	   	    if(cityName==" ()"){
   	   	  $("#city").val("");
   	   	  $("#state").val("");  
   	   	  $("#postalCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#postalCodeError").html("");  
   	   				values=cityName.split('(');
   	   				finalCity=values[0];
   	   				two=values[1];
   	   				$("#city").val(finalCity);
   	   				splitState=two.split(')');
   	   				finalState=splitState[0];
   	   				$("#state").val(finalState);
   	   	   	    }
             
     
        }
    });
 

}
	 
</script>

<style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
.list_widthstyle1{width:98% !important;}
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
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
    
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="#">Admin</a> / Company Profile</div> -->
      
      <section id="rightwrap" class="floatleft">
    
        <h1 class="sectionheading">Company Profile </h1>
          <div class="whitebackground">
        <p class="description">Easy Set up of your company details, this will help the visitors to your profile page to know the organization in a better way .</p>
        <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
          <div class="form_wrap" id="eddt">
            <div class="subheading_divider">Profile</div>
            <div class="clear"></div>            
            <input type="hidden" id="loginAttempts" value="${loginAttempts}"> 
            <form:form action="employer_manage_profile.htm" method="post" modelAttribute="employerDetails" name="employer_manage_profile" id="employerUpdateProfileForm" class="stdform" enctype="multipart/form-data">
              <div class="fullwidth_form">
                <div class="par">
                  <label class="floatleft">Company Name</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                  <form:input path="companyName" cssClass="input-xxlarge" tabindex="1" readonly="true" style="width:98%;" />
                  <form:errors path="companyName"  cssClass="validationnote"/>
                  </span> </div>
                <div class="par">
                  <label class="floatleft">Address</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                  <form:input path="addressLine1" cssClass="input-xxlarge" tabindex="2" style="width:98%;"/>
                  <form:errors path="addressLine1"  cssClass="validationnote"/> 
                  </span> </div>
              </div>
              
              <div class="leftsection_form">
              <div class="par">
                  <label class="floatleft">Zip Code</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <form:input path="postalCode" cssClass="input-xxlarge" tabindex="7" onChange="getCityFunction()"/>
                  <form:errors path="postalCode"  cssClass="validationnote"/>
                   </br>
		           <span class="errorblock" id="postalCodeError"></span>
                </div>
                <div class="par">
                  <label class="floatleft">City </label>
                  <div class="clear"></div>
                  <form:input path="city" cssClass="input-xxlarge" tabindex="3"/>
                  <form:errors path="city"  cssClass="validationnote"/> 
                </div>
				
                <div class="par">
                  <label class="floatleft">Industry </label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="formwrapper">                      
					<form:select path="industry" cssClass="chzn-select list_widthstyle1">
					  <spring:bind path="industry">
					 	 <c:set var="selectedIndustry" value="${status.value}"/>
					  </spring:bind>
					
					<form:option value="">Choose an Option</form:option>
										
					<c:forEach var="industry" items="${industryList}">
						  <c:choose>
		                      <c:when test="${selectedIndustry == industry}">
		                          <option value="${selectedIndustry}" selected="selected"><c:out value="${selectedIndustry}"/></option>
		                      </c:when>
		                      <c:otherwise>
		                          <option value="${industry}"><c:out value="${industry}"/></option>
		                      </c:otherwise>
	                   </c:choose>
                   </c:forEach>
                   </form:select>
                  </span> </div>
                  
                   
                 <div class="par">
            <label>Logo Upload </label>
             <span class="field">
                <input type="file" class="uniform-file" name="image"/>
             </span>
             <form:label path="image">
          			<spring:bind path="employerDetails.imageName">
          				<c:out value="${status.value}"/>
          			</spring:bind>
          		</form:label>
            <form:errors path="image" cssClass="validationnote floatleft" />
            </div>
                  
              </div>
              <div class="rightsection_form">
              
              <div class="par">
                  <label class="floatleft">Registration No.</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                   <form:input path="companyRegNumber" cssClass="input-xxlarge" tabindex="8" readonly="true"/>
                      <form:errors path="companyRegNumber"  cssClass="validationnote"/>
                  </span> </div>
                  
                <div class="par">
              <label class="floatleft">State</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="formwrapper">

					  <form:input path="state" cssClass="input-xxlarge" tabindex="8"/>
                      <form:errors path="state"  cssClass="validationnote"/>
                   
              </span> 
              </div>
              
                <div class="par">
              <label class="floatleft">Company Type</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="formwrapper">
       					<form:input path="companyType" cssClass="input-xxlarge" tabindex="8" readonly="true"/>
                        <form:errors path="companyType"  cssClass="validationnote"/>
              </span> 
              </div>
             
            
            
            
                <div class="par">
                  <label class="floatleft">Number Of Employees </label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                    <form:select path="noOfEmployees" cssClass="chzn-select list_widthstyle1">
					 <c:set var="selectedEmployeeStrength" value="${selectedEmployeeStrength}" />
					
					<form:option value="">Choose an Option</form:option>
										
					<c:forEach var="noOfEmployees" items="${noOfEmployees}">
						  <c:choose>
		                      <c:when test="${selectedEmployeeStrength == noOfEmployees}">
		                          <option value="${selectedEmployeeStrength}" selected="selected"><c:out value="${selectedEmployeeStrength}"/></option>
		                      </c:when>
		                      <c:otherwise>
		                          <option value="${noOfEmployees}"><c:out value="${noOfEmployees}"/></option>
		                      </c:otherwise>
	                   </c:choose>
                   </c:forEach>
                   </form:select>
                  
                  </span> </div>
                	  
              </div>
              
              
              <div class="clear"></div>
              <div class="subheading_divider">Who We Are</div>
              <div class="fullwidth_form">
                <div class="par">
	                <label class="floatleft">Overview</label>
	                <span class="star">*</span>
	                <div class="clear"></div>
	               <span class="field">
	                <form:textarea path="companyDesc" cssClass="span13 input-xxlarge" tabindex="9" rows="5" cols="80" style="width:97%;" />  
	                <form:errors path="companyDesc"  cssClass="validationnote"/>
	                </span> 
                </div>
              <spring:bind path="companyName">
              	<c:set var="companyName" value="${status.value }"/>
              </spring:bind>
              
              <div class="subheading_divider">Work Culture at <c:out value="${companyName}" /></div>
               <div class="par">
               <span class="field">
                <form:textarea path="workingWithUs" cssClass="span13 input-xxlarge" tabindex="10" rows="5" cols="80" style="width:97%;" />  
                <form:errors path="workingWithUs"  cssClass="validationnote"/>
                </span> 
              </div>
              
              
               <div class="subheading_divider">Hiring Process</div>
               <div class="par">
                		<form:hidden path="hiringProcess"/>
						
							<div id="recruitmentTreeDiv" class="floatleft width100">
							    <div class="leftsection_form">
								    <div class="par" style="position:relative;">
									   <span class="bullet_numbersteps">1</span> <input type="text" placeholder="Please Add your Recruitment Stages" id="stage_0" value="Telephonic" class="input-large txt">
									</div>
									<div class="par" style="position:relative;">
									     <span class="bullet_numbersteps">2</span> <input type="text" placeholder="Please Add your Recruitment Stages" id="stage_1" value="Written" class="input-large txt">
									</div>
									 <div class="par" style="position:relative;">
									     <span class="bullet_numbersteps">3</span> <input type="text" placeholder="Please Add your Recruitment Stages" id="stage_2" value="HR"class="input-large txt">
									 </div>   
							    </div>
						    <div class="rightsection_form">
							    <div class="par">
							    	<span class="bullet_numbersteps">4</span><input type="text" placeholder="Please Add your Recruitment Stages" id="stage_3" class="input-large txt">
							    </div>
							     <div class="par">
							    	<span class="bullet_numbersteps">5</span><input type="text" placeholder="Please Add your Recruitment Stages" id="stage_4" class="input-large txt">
							     </div>
						    </div>
						    <div class="center_align clear">
						     <div class="par">
						    	<input type="button" id="recruitmentTreeBtn" value="Create Recruitment Process Diagram" />
							
								<input type="button" id="resetButton" value="Reset"  />
							  </div>
						</div>
						</div>
						<div class="clear"></div>
						
						
						<div class="flaotleft padding_top stepwizardblue">
							
								<ul class="tabs" id="hplist">
            				   </ul>
								
								
						</div> 
			    </div>
              
              
              <div class="clear"></div>
              
               <div class="subheading_divider">More About Us</div>
             <div class="leftsection_form">  
	            <div class="par">
	            <label>Brochure upload </label>
		            <form:label path="brochureName" name="brochureName">
		          		<spring:bind path="employerDetails.brochureName"><c:out value="${status.value}"/></spring:bind>
		          	</form:label>
	            <form:errors path="brochureName" cssClass="validationnote" />
	             <span class="field">
	                <input type="file" class="uniform-file" name="brochure"/></span>
	            </div>
            </div>
            
             <div class="rightsection_form">
               <div class="par">
		            <label>Profile Videos Upload </label>
		            	<form:errors path="video" cssClass="validationnote" />
			            <form:label path="fileNameVideo" name="fileNameVideo">
			          		<spring:bind path="employerDetails.fileNameVideo"><c:out value="${status.value}"/></spring:bind>
			          	</form:label>
					 <span class="field">
		                <input type="file" class="uniform-file" name="video"/>
		             </span>
		           </div>
            </div>
               <div class="clear"></div>
               
                <div class="subheading_divider">Get In Touch With Us</div>
                <div class="clear"></div>
                  
            
           
              <div class="leftsection_form">
           
                <div class="par">
                  <label class="floatleft">Company URL </label>
                  <div class="clear"></div>
                  <form:input path="companyWebsite"cssClass="input-xxlarge" tabindex="10" /> 
				  <form:errors path="companyWebsite" cssClass="validationnote" />
                </div>
                <div class="par">
                  <label class="floatleft">Contact Person </label>
	                  <span class="star">*</span>
	                  <div class="clear"></div>
	                  <span class="field">                 
	                 <form:input path="contactPersonName"cssClass="input-xxlarge" tabindex="11" /> 
					  <form:errors path="contactPersonName" cssClass="validationnote" />
	                  </span>
                </div>
               
                <div class="par">
                  <label class="floatleft">Linked In</label>
                  <!-- 	<span class="star">*</span> -->
                  <div class="clear"></div>
                  <span class="field">
	                  <form:input path="linkedInAddress" cssClass="input-xxlarge" tabindex="14" />
	                  <form:errors path="linkedInAddress"  cssClass="validationnote" />
                  </span> 
              </div>
               
              </div>
              <div class="rightsection_form">
            
                <div class="par">
	                  <label class="floatleft">Contact Number</label>
	                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                  <form:input path="phoneNumber" cssClass="input-xxlarge" tabindex="13"/>
                  <form:errors path="phoneNumber"  cssClass="validationnote" />
                  </span>
                </div>
                  
                <div class="par">
                  <label class="floatleft">Email ID</label>
                  	<span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
	                  <form:input path="emailID" cssClass="input-xxlarge" tabindex="14" readonly="true"/>
	                  <form:errors path="emailID"  cssClass="validationnote" />
                  </span> 
              </div>
              <div class="par">
                  <label class="floatleft">Fax Number</label>
                  <!-- 	<span class="star">*</span> -->
                  <div class="clear"></div>
                  <span class="field">
	                  <form:input path="faxNumbers" cssClass="input-xxlarge" tabindex="15" />
	                  <form:errors path="faxNumbers"  cssClass="validationnote" />
                  </span> 
              </div>
              
              </div>
              
              
              <div class="clear"></div>
              
              <!-- <div class="subheading_divider"> Other Office Locations </div>
               <div class="clear"></div> -->
              	<%-- <div class="leftsection_form">
              		 <div class="par">
		                  <label class="floatleft">City </label>
		                  <div class="clear"></div>
		                  <form:input path="city"cssClass="input-xxlarge" tabindex="15" /> 
						  <form:errors path="city" cssClass="validationnote" />
               		 </div>
                	<div class="par">
	                	  <label class="floatleft">State </label>
		                  <span class="star">*</span>
		                  <div class="clear"></div>
		                  <span class="field">                 
		                  <form:input path="state"cssClass="input-xxlarge" tabindex="16" /> 
						  <form:errors path="state" cssClass="validationnote" />
		                  </span>
                	</div>
              	</div>
              	<div class="rightsection_form">
              	
              	 <div class="par">
		                  <label class="floatleft">Zip Code </label>
		                  <div class="clear"></div>
		                  <form:input path=""cssClass="input-xxlarge" tabindex="17" /> 
						  <form:errors path="" cssClass="validationnote" />
               		 </div>
                	 <div class="par">
		                <label class="floatleft">Address</label>
		               <!--  <span class="star">*</span> -->
		                <div class="clear"></div>
		               <span class="field">
		                <form:textarea path="" cssClass="span13 input-xxlarge width100" tabindex="9" rows="5" cols="80"/>  
		                <form:errors path=""  cssClass="validationnote"/>
		                </span> 
                </div>
              	</div> --%>
            <!--   </div> -->
              
              
              <div class="par">
                <div class="buttonwrap">
                  <input name="savePreviewBtn" type="submit" value="Save & Preview" tabindex="14">
                  <!-- <input name="" type="button" value="Cancel" tabindex="15" onClick="window.location.href='employer_manage_profile_preview.htm'"/> -->
                 <!--  <input name="cancelBtn" type="button" value="Cancel" tabindex="15" onClick="window.location.href='profile_preview.htm'"/> -->
                </div>
              </div>
              </div>
            </form:form>
            </div>
          </div>
          </div>
      </section>
      <div class="clear"></div>
    </div>
    <div class="bottomspace">&nbsp;</div>
  </div>
  <script type="text/javascript">

$(window).load(function(){

	var hiringProcess =  new Array();
	hiringProcess =  $('input[name=hiringProcess]').val();

	var array = new Array();
	if($.trim(hiringProcess) == '')
	{
		array.push('Telephonic');
		array.push('Written');
		array.push('HR');
	}
	else
		array = hiringProcess.split(",");

	$.each(array, function( index, value ) {
		$("#stage_"+index).val(value);
		$("#hplist").last().append('<li style="width:10%;"><span class="bullet_number">'+ (index+1) +'</span>   '+value+'</li>');
	});
});
</script>


  
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>


<div tabindex="-1" class="" id="dialog" style="display: none;">
		<div class="modal ui-dialog-content">
			<div class="modal-header">

				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" id="closeDialog">x</button>
				<h3 id="myModalLabelHeading">You Choose to fill your details from</h3>
			</div>
			<div class="modal-body">
				<h3 class="blutitle18" style="font-size: 18px;">Get your Profile from LinkedIn</h3>
				<span id="errorMsg" class="errorblock"></span>
				<ul class="margin_top2">
					<li class="padding_top">Sign in from linkedIn: &nbsp;&nbsp;
						 <div id="loader" style="display: inline-block;">
							<img src="images/loader.gif">
						</div> <a id="linkedIn"><script type="IN/Login"></script> </a>
					</li>
					
				</ul>
			</div>
			<div class="modal-footer" style="display:none;">
				<button class="btn" onclick="getCompany()">Add</button>
			</div>
		</div>
		
	<div class="modal-backdrop fade in" style="z-index: 999;"></div> 
	</div>


</body>
</html>