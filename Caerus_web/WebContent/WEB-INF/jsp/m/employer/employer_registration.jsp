<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Registration</title>
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
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
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
<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>

<script type="text/javascript">/* 

$("#Register").click(function() {
	//alert("w");
	
    

	// validate signup form on keyup and submit
	$("#registration").validate({
		rules: {
			emailID:{ 
			      email: true},
			      password:{minlength:10 }
			
		},
		messages: {
			emailID:{ 
			      email:"Please Enter a valid Email Address"},
			      password:{minlength:"Please enter a password with at least 6 characters"}
	
		}
	});

}); */
</script>

<script type="text/javascript">
function getCityFunction()
{
	var zipCode=$("#postalCode").val();
	   
      $.ajax({
        
        url: 'get_city_name.json',
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
function goBack()
{
  window.history.back(); 
}
</script>

<script src="../mobile_html/js/script.js" type="text/javascript"></script>
</head>
<body class="home">
<div id="main_wrap" class="loginBg">
  <%-- <%@ include file="includes/header.jsp"%> --%>
  <header id="homeheader">
   <!--<nav>
       <ul>
        <li><a href="home.htm" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        <li><a href="contactUs.htm"><span class="menu_img"><img src="../mobile_html/images/contactus.png" alt=""></span><span class="menutxt">ContactUs</span></a></li>
           </ul>
    </nav>
     <div class="back_icn"> <a href="login.htm" class="back"><img src="../mobile_html/images/login.png" alt=""></a></div> -->
    <div class="logo"><a href="home.htm"><img src="../mobile_html/images/logo_big.png" alt="3Lpis"></a></div>
 	<!-- <a href="#" id="navbtn"><img src="../mobile_html/images/menu.png"></a>  -->
 </header>
  <div id="mid_wrap" class="midwrap_toppadding">
   
    
     <div class="clear"></div>
    <section id="inner_container">
      <c:if test="${not empty success}">
      <script type="text/javascript">
		alert("You have Successfully Registered at Imploy.me");
		window.location.href="login.htm";
      </script>
  <!--        <div id="success_message">
          <div id="warning_image"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
          <h2 class="error_message_heading">You have successfully registered at Imploy.Me</h2>
          <div class="clear"></div>
          <p class="boldtxt">Please click on the link to login.<a href="home.htm">Login</a> </p>
          </div> -->
        </c:if>
    
    <div class="notamember_txt">Not a Member? <span class="orange_font">Sign Up now</span></div>   
      <div class="innerform">
    <!-- <h1 class="page_heading">Business <span class="orange_font">Details</span></h1> -->
    <!--13-08-2013-->
      <c:if test="${not empty error}">
						<c:set var="securityMsg"
							value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" />
					</c:if>
					<script type="text/javascript">
						var abc = "${securityMsg}";
						if (abc.length > 0) {
							$("#userName").addClass("redborder");
							$("#password").addClass("redborder");
							$(".loginpan").effect("bounce", {
								times : 3,
								direction : "up"
							}, 1300);
						}
					</script>
					
					  <c:if test="${not empty registered}">
           <div class="errorblock">You are already Registered with Imploy.me!</div>
      </c:if>
    <form:form method="POST" commandName="employerCom" class="stdform">	
    <ul class="form_wrap">
    		<li>
              <form:input path="companyName" tabindex="1" placeholder="Company Name *"/>
                      <form:errors path="companyName" />
            
            </li>
             <li>
              
               <form:input path="companyRegNumber"  tabindex="2" placeholder="Company Registration Number *"/>
              <form:errors path="companyRegNumber"  />
            </li>
             <li>
             <form:input path="phoneNumber"  tabindex="3" placeholder="Phone Number * "/>
             <form:errors path="phoneNumber"  />
            </li>
            
            <li>
              <form:input path="postalCode" onChange="getCityFunction()" tabindex="4" placeholder="Zip code *"/>
              <form:errors path="postalCode" />
  			<span class="errorblock" id="zipCodeError"></span>
            </li>
            <li>
             <form:input path="city" tabindex="5" id="location" placeholder="City *"/>
          <form:errors path="city"/>
            </li>
            
              <li>
              <form:input path="state" tabindex="9" placeholder="State *"/>
             <form:errors path="state" /> 
            </li> 
            
            <li>
              <form:input path="contactPersonName"  tabindex="6" placeholder="Contact Person Name *"/>
              <form:errors path="contactPersonName" />
            </li>
            
            <li>
             <form:select id="companyType" path="companyType" data-placeholder="Choose an Option" items="${companyTypeList}" class="chzn-select list_widthstyle1" tabindex="7">
                
                
                <%-- <form:option value="">Select Company Type</form:option>
                
                  <c:forEach var="companyTypes" items="${companyTypes}">
                   
                    <c:set var="companyType" value="${companyName}"/>
                   <c:choose>
                      <c:when test="${companyTypes == companyName}">
                         <option value="<c:out value="${companyTypes}" />" selected="selected"><c:out value="${companyTypes}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${companyTypes}" />"><c:out value="${companyTypes}" /></option>
                      </c:otherwise>
                   </c:choose>
                   
                   
                 </c:forEach> --%>
              </form:select>
              <form:errors path="companyType"/>
            </li>
            <li>
            <form:select id="industry" path="industry" data-placeholder="Choose an Option" tabindex="8" items="${industryList}">
              <%--   <form:option value="">Select Industry</form:option>
                  <c:forEach var="industryList" items="${industryList}">
                   
                    <c:set var="industry" value="${industryName}"/>
                   <c:choose>
                      <c:when test="${industryList == industryName}">
                         <option value="<c:out value="${industryList}" />" selected="selected"><c:out value="${industryList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${industryList}" />"><c:out value="${industryList}" /></option>
                      </c:otherwise>
                   </c:choose>
                   
                   </c:forEach> --%>
                 
              </form:select>
               <form:errors path="industry" />
            
            </li>
             <li>
              <form:input path="addressLine1" tabindex="9" placeholder="Address *"/>
             <form:errors path="addressLine1" /> 
            </li> 
            
            
            
            <li>
             <form:input path="companyWebsite" tabindex="10" placeholder="Company Website *"/>
             <form:errors path="companyWebsite" /> 
            </li>
            
            
            <li>
             <form:input path="firstName" tabindex="11" placeholder="Contact Person FirstName *"/>
             <form:errors path="firstName" /> 
            </li>
            <li>
            <li>
             <form:input path="lastName" tabindex="11" placeholder="Contact Person LastName *"/>
             <form:errors path="lastName" /> 
            </li>
            
            <li>
             <form:input path="emailID" tabindex="11" placeholder="Contact Person EmailId *"/>
             <form:errors path="emailID" /> 
            </li>
            <li>
            
            
            <li>
             <label >
  			<form:checkbox path="termsAndConditions" tabindex="12"/>
  			 	Yes, I have read the <a href="employer_termsnconditions.htm" target="_self">'Terms of Service'</a> <br>
         	 <form:errors path="termsAndConditions" />
         	 </label>
            </li>
              <li class="text_center">
              <input type="hidden" name="authority" value="ROLE_CORPORATE">
              <input name="Register" type="submit" value="Register" class="orangebutton" id="Register" tabindex="13">
            </li>
    
    </ul>  
    </form:form>
    </div>
    </section>
 <!--13-08-2013-->
  </div>
  <div id="push"></div>
</div>

    <div class="calender_overlay" id="overlay" style="display:none">
            <div class="date-pop-over">
                <div class="calender_close"><div id="close">+</div></div>
                <div class="calender_wrap">
                    	<div id="datepicker"></div> 
                    	<button value="done" class="done" id="done"> DONE</button>
				</div>              
            </div>    	
	</div>
</body>
</html>