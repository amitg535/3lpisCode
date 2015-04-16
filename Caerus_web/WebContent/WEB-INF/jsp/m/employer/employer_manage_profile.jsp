<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>

<!--[if gt IE 9]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy - View Profile</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!--19-07-2013 changes-->
<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<link rel="stylesheet" href="../mobile_html/css/multiple-select.css" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
 <script src="../mobile_html/js/jquery.min.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="../mobile_html/js/jquery-1.7.1.min.js"></script>
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script> -->

<!--<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>-->
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<script src="../mobile_html/js/jquery.multiple.select.js"></script>




<script type="text/javascript">
$().ready(function() {
	$.validator.addMethod('numericOnly', function (value) {
	    return /^[0-9]+$/.test(value);
	}, 'Please only enter numeric values (0-9)');
	
	// validate signup form on keyup and submit
	$("#employerUpdateProfileForm").validate({
		rules: {
			addressLine1: "required",
			city: "required",
			postalCode:"required",
			industry:"required"
		},
		messages: {
			addressLine1: "Please enter Company Address",
			city: "Please provide  Location",
			postalCode: "Please provide  Postal Code",
			industry: "Please Select Industry"
		}
	});
});
 	</script>


<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	})
    }
	
</script>
<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>
<script>
  	$(document).ready(function() {
    	$(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		});
	});
  
	function selectCallback(value, index) {
        alert("SELECTED VALUE: " + value + ", INDEX: " + index);
	}
  
  function toggleEnabled() {
    if ($(".selecter_disabled").is(":disabled")) {
    	$(".selecter_disabled").selecter("enable");
      $(".enable_selecter").hide();
      $(".disable_selecter").show();
    } else {
      $(".selecter_disabled").selecter("disable");
      $(".enable_selecter").show();
      $(".disable_selecter").hide();
    }
    return false;
  }
</script>
<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	});
    }
</script>
<script>
  	 jQuery(document).ready(function($) {
  var opts = {
    controlNavigation:'thumbnails',
    imageScaleMode: 'fill',
    arrowsNav: false,
    arrowsNavHideOnTouch: true,
    fullscreen: false,
    loop: false,
    thumbs: {
      firstMargin: false,
      paddingBottom: 0
    },
    numImagesToPreload: 3,
    thumbsFirstMargin: false,
    autoScaleSlider: true, 
    keyboardNavEnabled: true,
    navigateByClick: true,
    fadeinLoadedSlide: true,
  };
  ///* if(!$.browser.webkit) {
    opts.imgWidth = 707;
  /*  opts.imgHeight = 397;*/
  //} */
  var sliderJQ = $('#homeSlider').royalSlider(opts);
});
</script>
<!-- <link href="../mobile_html/css/royalslider.css" rel="stylesheet"> -->
<script src="../mobile_html/js/jquery.royalslider.min.js"></script>

<!--31-07-2013-->
<link rel="stylesheet" href="../mobile_html/css/uniform.tp.css" type="text/css" />
<script type="text/javascript" src="../mobile_html/js/prettify.js"></script>
<script type="text/javascript" src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script>
jQuery(document).ready(function () {
   jQuery('.uniform-file').uniform();
});
</script>

<script>
function saveFunction()
{
	var formValue= document.getElementById("updateForm");
 	formValue.method='post';
	formValue.action='employer_update_manage.htm';
	formValue.submit();
}
	    
</script>

 <script type="text/javascript">
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


<!--31-07-2013-->
</head>

<body class="employer">
<div id="main_wrap">
  <%@ include file="includes/header.jsp"%>
  <div id="mid_wrap" class="midwrap_toppadding">
   <%--  <div id="submenu">
      <ul class="nav nav-pills">
        <li><a href="<c:url value="employer_dashboard.htm"/>">Search</a></li>
        <li><a href="employer_manage_receivedinvitations.htm">Events</a></li>
        <li class="active"><a href="employer_manage_profile_preview.htm">Profile</a><span class="active_arrow"></span></li>
        <!--    <li class="dropdown"> <a class="dropdown-toggle" id="drop5" role="button" data-toggle="dropdown" href="#">Events <b class="caret"></b></a>
        <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
       </ul>
      </li>-->
      </ul>
    </div> --%>
    <section id="inner_container">
    <h1 class="page_heading">Manage <span class="orange_font">Profile</span></h1>
    
   
       <form:form action="employer_manage_profile.htm" method="post" id="employerUpdateProfileForm" modelAttribute="employerDetails" name="employer_manage_profile" class="stdform" enctype="multipart/form-data">
             <!-- <div class="profiletabs_wrap"> -->
             <div class="details" id="editpersonal">
              <ul>

             
              <li>
              <div class="label">Company Name *</div> 
                   <div class="labeldetails"> <form:input path="companyName" cssClass="input-xxlarge1 width100" tabindex="1" readonly="true"/> </div>
                  	<form:errors path="companyName"  cssClass="validationnote"/>
              </li>
           
           
            <li>
           <div class="label">Address</div> 
                 <div class="labeldetails">  <form:input path="addressLine1" cssClass="input-xxlarge1 width100" tabindex="2"/> </div>
                  <form:errors path="addressLine1"  cssClass="validationnote"/> 
            </li>
            
             <li>
               <div class="label">Zip Code *</div>
                 <div class="labeldetails"> 
                 <form:input type = "number" path="postalCode" onChange="getCityFunction()" cssClass="input-medium" tabindex="3" /> 
                 <span id="postalCodeError"></span>
                 </div>
                  <form:errors path="postalCode"  cssClass="validationnote"/>
             </li>
             <li>
               <div class="label">City</div>
                 <div class="labeldetails"> 
                 <form:input type = "text" path="city"  cssClass="input-medium" tabindex="4" id="city"/> 
                 </div>
                  <form:errors path="city"  cssClass="validationnote"/>
             </li>
              <li>
            	<div class="label">State</div>
					  <div class="labeldetails"> <form:input path="state" cssClass="input-medium" tabindex="5" id="state"/> </div>
                  <form:errors path="state"  cssClass="validationnote"/>
                  </li> 
            
              
               <li>
          		<div class="label">Industry</div>
				 <div class="labeldetails">
				 	<form:select path="industry" cssClass="chzn-select list_widthstyle1" tabindex="6">
					  <spring:bind path="industry">
					  <c:set var="selectedIndustry" value="${status.value}"/>
					  </spring:bind>
						
						<form:option value="">Select Industry</form:option>
							<c:forEach var="industryList1" items="${industryList}">
					  			<c:choose>
                      				<c:when test="${selectedIndustry == industryList1}">
                          					<option value="${selectedIndustry}" selected="selected"><c:out value="${selectedIndustry}"/></option>
                      				</c:when>
                      				<c:otherwise>
	                         				 <option value="${industryList1}"><c:out value="${industryList1}"/></option>
    	                  			</c:otherwise>
        		          		 </c:choose>
                  		 </c:forEach>
                   </form:select> </div>
                  </li>
                  <li>
            	<div class="label">Company Type *</div>
					  <div class="labeldetails"> <form:input path="companyType" cssClass="input-medium" tabindex="7" readonly="true"/> </div>
                  <form:errors path="companyType"  cssClass="validationnote"/>
                  </li>
              
				<%-- 	
					<form:select path="state" cssClass="chzn-select list_widthstyle1">
					<form:option value="">Choose an Option</form:option>
										
					<c:forEach var="stateList" items="${stateList}">
                      <spring:bind path="state">
					  <c:set var="selectedState" value="${status.value}"/>
					  </spring:bind>
                             
                      <c:choose>
                      <c:when test="${selectedState == stateList}">
                    
                          <option value="${selectedState}" selected="selected"><c:out value="${selectedState}"/></option>
                      </c:when>
                      <c:otherwise>
                     
                          <option value="${stateList}"><c:out value="${stateList}"/></option>
                      </c:otherwise>
                   </c:choose>
					
                             
                      </c:forEach>
                   </form:select> --%>
                  
              <li>
            	 <div class="label">Registration Number </div>
                 <div class="labeldetails"><form:input path="companyRegNumber" cssClass="input-medium" tabindex="8" readonly="true" /></div>
                      <form:errors path="companyRegNumber"  cssClass="validationnote"/>
                </li>
                
              <li>
	            <div class="label">About Us</div> 
                <div class="labeldetails"><form:textarea path="companyDesc" cssClass="span13" tabindex="9" rows="5" cols="80"/></div>  
                <form:errors path="companyDesc"  cssClass="validationnote"/>
               </li>
                  <spring:bind path="companyName">
              	<c:set var="companyName" value="${status.value }"/>
              </spring:bind>
                <li>
	            <div class="label">Work Culture at <c:out value="${companyName}" /></div> 
                <div class="labeldetails"><form:textarea path="workingWithUs" cssClass="span13" tabindex="10" rows="5" cols="80"/></div>  
                <form:errors path="workingWithUs"  cssClass="validationnote"/>
               </li>
                
             <li>
              <div class="label">Logo</div>
           <div class="labeldetails"><input type="file" class="uniform-file" name="file" tabindex="11"/>
           	 &nbsp;&nbsp; <c:out value="${employerDetails.imageName}"></c:out></div>
            <form:errors path="file" cssClass="validationnote" />
            </li>
        
              <li>
              <div class="label">Video Profile</div>
            	<div class="labeldetails"><input type="file" class="uniform-file" name="fileVideo" tabindex="12"/>
           	 &nbsp;&nbsp; <c:out value="${employerDetails.fileNameVideo}"></c:out></div>
            <form:errors path="fileVideo" cssClass="validationnote" />
             </li>
             
              <li>
              <div class="label">Brochure</div>
            	<div class="labeldetails"><input type="file" class="uniform-file" name="brochure" tabindex="13"/>
           	 &nbsp;&nbsp; <form:label path="brochureName" name="brochureName">
		          		<spring:bind path="employerDetails.brochureName"><c:out value="${status.value}"/></spring:bind>
		          	</form:label></div>
            <form:errors path="brochure" cssClass="validationnote" />
             </li>
             
            <li>
         	 <div class="label">Company URL</div>
                  <div class="labeldetails"><form:input path="companyWebsite"cssClass="input-medium" tabindex="14"/></div>
				  <form:errors path="companyWebsite" cssClass="validationnote" />
            </li>
            
             <li>
         	 <div class="label">Linked In</div>
                  <div class="labeldetails"><form:input path="linkedInAddress"cssClass="input-medium" tabindex="15"/></div>
				  <form:errors path="linkedInAddress" cssClass="validationnote" />
            </li>
            
              <li>              
            	 <div class="label">Contact Person</div>
                  <div class="labeldetails"><form:input path="contactPersonName"cssClass="input-medium" tabindex="16"/></div>
				  <form:errors path="contactPersonName" cssClass="validationnote" />
               </li>
               
              <li>
            	 <div class="label">Email</div> 
                   <div class="labeldetails"><form:input path="emailID" cssClass="input-medium" tabindex="17" readonly="true" /></div>
                  <form:errors path="emailID"  cssClass="validationnote" />
               </li>
               
             <li>
              	<div class="label">Contact Number</div> 
                  <div class="labeldetails"><form:input type = "tel" path="phoneNumber" cssClass="input-medium" tabindex="18" /></div>
                  <form:errors path="phoneNumber"  cssClass="validationnote" />
                 </li>
                 
         
               <li>
               <div class="label">Number Of Employees</div> 
                 <div class="labeldetails"><form:select path="noOfEmployees" tabindex="19" class="chzn-select list_widthstyle1">
                 <form:option value=" "> Number Of Employees </form:option>
							<form:option value="0 - 500">0 - 500 </form:option>
							<form:option value="500 - 1000">500 - 1000</form:option>
							<form:option value="1000 & More">1000 &amp; More</form:option>
					  </form:select></div>
                 </li>
         </ul>
         </div>
             <!--  </div> -->
          <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
                  <input name="" type="Submit" value="Save & Preview" tabindex="20" class="orangebuttons">
                  <!-- <input name="" type="button" value="Cancel" tabindex="15" onClick="window.location.href='employer_manage_profile_preview.htm'"/> -->
                  <input name="" type="button" value="Cancel" tabindex="21" onClick="window.location.href='profile_preview.htm'" class="orangebuttons"/>
                </li>
                </ul>
                </div>
              </div>
            </form:form>
   </section>
    
  </div>
  <div id="push"></div>
</div>
 <%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>