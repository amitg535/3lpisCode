<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
 
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy Me - Login</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->
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
    <!--   <div id="submenu">
       <ul>
        <li><a href="home.htm">Search</a></li>
      </ul>
            </div> -->
    <div class="clear"></div>
    <section id="inner_container">
      <!-- <h1 class="page_heading"><span class="orange_font">Login</span></h1> -->
      <div class="innerform">
        <form action="/j_spring_security_check" method="post" >
        <label id="errorMsg"></label>
          <ul class="form_wrap"> 
            <li>
              <input name="username" type="email" tabindex="1" placeholder="Email Address *" required="required" >
            </li>
            <li>
              <input name="password" type="password" tabindex="1" placeholder="Password *" required="required" >
            </li>
            <c:if test="${not empty error}">
          <c:set var="securityMsg" value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" />
        </c:if>
        
        <script type="text/javascript">
						var error = "${error}";
						if (error.length > 0) {
							$("#errorMsg").html('Incorrect Username or Password');							
						}
					</script>
            <li>
              <!-- <div class="float_left">
                <input id="j_remember" class="css-checkbox" type="checkbox" name="_spring_security_remember_me" value="true"/>
                <label for="j_remember" name="j_remember" class="css-label">Remember Me</label>
              </div> -->
              <div class="float_right"><a href="user_forgot_password.htm" class="forgotpass">Forgot Password ?</a></div>
              <div class="clear"></div>
            </li>
            <li class="text_center">
              <input name="" type="submit" value="Login" class="orangebutton">
            </li>
          </ul>
          <div class="registeration" >
          <div class="notamember_txt"><span>Not a Member?</span> Sign Up Now!!
          </div> 
          
          	<div>
          	<a href="employer_registration.htm" class="employer"><img src="../mobile_html/images/employer_reg_icn.png" />Employer Registration</a>
          	<a href="candidate_registration.htm" class="candidate"><img src="../mobile_html/images/candidate_reg_icn.png"/>Candidate Registration</a>
          	<a href="university_registration.htm" class="university"><img src="../mobile_html/images/university_reg_icn.png"/>University Registration</a>
          	</div>
          </div>
        </form>
      </div>
    </section>
  </div>
<div id="push"></div>
</div>
 <%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>