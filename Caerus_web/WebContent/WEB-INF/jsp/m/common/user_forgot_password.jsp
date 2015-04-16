<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>3Lpis -Forgot Password</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

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
<script src="../mobile_html/js/jquery.fs.selecter.js"></script> 
<script src="../mobile_html/js/script.js" type="text/javascript"></script>
<script type="text/javascript">
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
<script type="text/javascript"  src="../mobile_html/js/menu.js"></script>
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

  <script type="text/javascript">
    $("#userForgotPasswordForm").validate(
  			 { rules: { emailId: "required" }, 
  				 messages: { emailId: "Please enter Your Email ID"} 
  			 });
  
   
   </script>
</head>

<body class="home">

<div id="main_wrap" class="loginBg">
 <div class="nonfooter"> 
 
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
      <h1 class="page_heading">Forgot <span class="orange_font">Password</span></h1>
       
      <div class="innerform">
      <form:form class="stdform" action="" method="post" modelAttribute="loginManagementCom" id="userForgotPasswordForm">
          <ul class="form_wrap">
            <li>
              <input name="emailId" type="email" tabindex="1" required="required" placeholder="Email Address *"  id="emailId"/>
              <form:errors path="emailId"></form:errors>
            </li>
	
	 <c:if test="${not empty error}">
		<div class="errorblock">
		Please activate your account!
		</div>
	</c:if>
	
	<c:if test="${not empty unregistered}">
		<div class="errorblock">
		Please register with Imploy.me
		</div>
	</c:if>
	
            <li class="text_center">
              <input name="" type="submit" value="Send Reset Instructions" class="orangebutton">
            </li>
          </ul>
          
            <c:if test="${not empty success}">
          <p>New password has been sent to your registered Email Id</p>
			</c:if>
	
        </form:form>
         <div class="margin20_top"><p class="para">Enter the email address you used when you joined and we'll send you instructions to reset your password.</p><p class="para">For security reasons, we do NOT store your password. So rest assured that we will never send your password via email.</p></div>
      </div>
    </section>
  </div>
    <div id="push"></div>
   </div>
 
</div>
<%--    <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>