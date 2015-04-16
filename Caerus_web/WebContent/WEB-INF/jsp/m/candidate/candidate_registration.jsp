<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Registration</title>
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
<!-- <script type="text/javascript">
    $(document).ready(function () {
    	$("#datepicker").datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: "-30:+0"
		});
   
    	});
</script> -->
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
   <!--  <div id="submenu">
      <ul>
        <li><a href="home.htm">Search Jobs</a></li>
      </ul>
    </div> -->
    <div class="clear"></div>
    <section id="inner_container">
      <div class="notamember_txt">Not a Member? <span class="orange_font">Sign Up now</span></div> 
      
       	    <c:if test="${not empty success}">
          <span class="success" style="color:#0B99B3;">Successfully registered <a href="login.htm">click here to login</a>  </span>
        </c:if> 
      <div class="innerform">
        <form:form action="" class="stdform" method="post" commandName="studentCom" id="registration">
          <ul class="form_wrap">
            <li>
              <form:input path="firstName" type="text" tabindex="1" placeholder="First Name *"  class="user"  required="required" />
                <form:errors path="firstName" />
            </li>
             <li>
              <form:input path="lastName" type="text" tabindex="2" placeholder="Last Name *" class="user"  required="required" />
                <form:errors path="lastName" />
            </li>
             <li>
              <form:input path="emailID" type="email" tabindex="3" placeholder="Email Id *" id="emailID" required="required" />
               <c:if	test="${not empty addStudent.exception}">
					<div class="errorblock">${addStudent.exception}</div>
				</c:if>  
				<form:errors path="emailID" />
            </li>
            <li>
              <form:input path="password" type="Password" tabindex="4" placeholder="Password *"  id="password" required="required" />
              <form:errors path="password"/>
              <input type="hidden" name="authority" value="ROLE_STUDENT">     
            </li>
            <li>
              <form:input path="confirmPassword" type="Password"  tabindex="5" placeholder="Re-type Password *" required="required" />
              <form:errors  path="confirmPassword" />  
            </li>
            
               <li>
            <form:input path="dateOfBirth" type="text" tabindex="2" placeholder="Date Of Birth*" class="user"  required="required" />
                <form:errors path="dateOfBirth" />
            </li>
              <li class="text_center">
              <input name="Register" type="submit" value="Register" class="orangebutton" id="Register">
            </li>
          </ul>
          
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