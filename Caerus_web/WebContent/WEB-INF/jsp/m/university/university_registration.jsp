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
<title>University Registration</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- 19-07-2013 changes
CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS

Favicons -->
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

<script type="text/javascript">

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
      <div class="notamember_txt">Not a Member? <span class="orange_font">Sign Up now</span></div>   
      <div class="innerform">
        <form:form action="" class="stdform" method="post" commandName="universityDetailsCom" id="registration">
        
         <c:if test="${not empty registered}">
           <div class="errorblock">University already Registered</div>
           </c:if>
        <form:errors path="exceptionOccured"  />
        
        
        <c:if test="${not empty success}">
          <div id="warning_image">
          	<img src="../mobile_htmlimages/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
          <h2 class="error_message_heading">You have successfully registered at Imploy.Me</h2>
          <div class="clear"></div>
          <p class="boldtxt">Please click on the link to login.<a href="login.htm">Login</a> </p>
        </c:if>
        
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
                     <%--  <c:if	test="${not empty universityRegCmd.caerusCommonExceptionMessage}">
						<div class="errorblock">${universityRegCmd.caerusCommonExceptionMessage}</div>
					  </c:if> --%>
		<div class="details" id="editpersonal">
          <ul>
            <li>
             <div class="labeldetails"> <form:input path="universityName" tabindex="1" placeholder="University Name *"/></div>
               <form:errors path="universityName" />
            </li>
             <li>
              <div class="labeldetails"> <form:input path="universityRegistrationNumber"  tabindex="2" placeholder="University Registration Number *"/></div>
              <form:errors path="universityRegistrationNumber"  />
            </li>
             <li>
             <div class="labeldetails"><form:input path="phoneNumber"  tabindex="3" placeholder="Phone Number * " type="tel"/></div>
             <form:errors path="phoneNumber"  />
            </li>
            <li>
             <div class="labeldetails"> <form:input path="universityAddress" tabindex="4" placeholder="Address*"/></div>
             <form:errors path="universityAddress" /> 
            </li>
            <li>
            <div class="labeldetails">  <form:input path="zipCode" onChange="getCityFunction()" tabindex="5" placeholder="Zip code*" type="number"/></div>
             <form:errors path="zipCode" />
  			<span class="errorblock" id="zipCodeError"></span>
            </li>
            <li>
             <div class="labeldetails"><form:input path="city" tabindex="6" id="location" placeholder="city"/></div>
          <form:errors path="city"/>
            </li>
            
             <li>
             <div class="labeldetails"><form:input path="state" tabindex="6" id="state" placeholder="State"/></div>
          <form:errors path="state"/>
            </li>
            
            <li>
              <div class="labeldetails"><form:input path="universityWebsite"  tabindex="7" placeholder="University Website"/></div>
              <form:errors path="universityWebsite" />
            </li>
            <li>
             <div class="labeldetails"><form:input path="contactPerson" tabindex="8" placeholder="Contact Person Name"/></div>
          	<form:errors path="contactPerson"  />
            </li>
            <li>
             <div class="labeldetails"><form:input path="emailID" tabindex="9" placeholder="Contact Person Name EmailId"/></div>
             <form:errors path="emailID" />
            </li><br>
            <li>
           <label>
  			<div class="labeldetails"><form:checkbox path="termsAndConditions" tabindex="10"/> Yes, I have read the <a href="termsnconditions.htm" target="_self">'Terms of Service'</a> </div><br>
         	 <form:errors path="termsAndConditions" />
         	 </label>
            </li>
              <li class="text_center">
               <input type="hidden" name="authority" value="ROLE_UNIVERSITY">
              <input name="Register" type="submit" value="Register" class="orangebutton" id="Register" required tabindex="11">
            </li>
          </ul>
       <div class="margin20_left margin20_right"><p class="para">
</p></div>

        </form:form>
      </div>
    </section>
  </div>
   <div id="push"></div>
   </div>
  
 <%--    <%@ include file="includes/footer.jsp"%>     --%>
</body>
</html>