<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>3Lpis - Search Results</title>
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
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="home">
<div id="main_wrap">
  <header id="topnav">
  <c:choose>
  <c:when test="${ROLE=='ROLE_ANONYMOUS'}">
    <nav>
      <ul>
        <li><a href="home.htm" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        </ul>
    </nav>
    </c:when>
  <c:when test="${ROLE=='ROLE_STUDENT'}">
    <nav>
      <ul>
        <li><a href="candidate_dashboard.htm" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        <li><a href="user_change_password.htm"><span class="menu_img"><img src="../mobile_html/images/changepassword.png" alt=""></span><span class="menutxt">Change Password</span></a></li>
        <li><a href="<c:url value="Caerus/j_spring_security_logout" />"><span class="menu_img"><img src="../mobile_html/images/logout.png" alt=""></span><span class="menutxt">Logout</span></a></li>
      </ul>
    </nav>
    </c:when>
     <c:when test="${ROLE=='ROLE_CORPORATE'}">
    <nav>
      <ul>
        <li><a href="<c:url value="employer_dashboard.htm" />" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        <li><a href="user_change_password.htm"><span class="menu_img"><img src="../mobile_html/images/changepassword.png" alt=""></span><span class="menutxt">Change Password</span></a></li>
        <li><a href="<c:url value="/j_spring_security_logout" />"><span class="menu_img"><img src="../mobile_html/images/logout.png" alt=""></span><span class="menutxt">Logout</span></a></li>
      </ul>
    </nav>
    </c:when>
     <c:when test="${ROLE=='ROLE_UNIVERSITY'}">
    <nav>
      <ul>
        <li><a href="university_dashboard.htm" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        <li><a href="user_change_password.htm"><span class="menu_img"><img src="../mobile_html/images/changepassword.png" alt=""></span><span class="menutxt">Change Password</span></a></li>
        <li><a href="<c:url value="/j_spring_security_logout" />"><span class="menu_img"><img src="../mobile_html/images/logout.png" alt=""></span><span class="menutxt">Logout</span></a></li>
      </ul>
    </nav>
    </c:when>
    </c:choose>
    <!-- <div class="back_icn">&nbsp;</div>
    <div class="logo"><a href="home.htm"><img src="../mobile_html/images/logo_small.png" alt="3Lpis"></a></div> -->
    <a href="#" id="navbtn"><img src="../mobile_html/images/menu.png"></a> </header>
  <div id="mid_wrap" class="midwrap_toppadding">
    
    <section id="inner_container">
      <div class="jobdetail_wrap">
        
        <div class="clear"></div>
        <div class="">
          <div class="innerwrap margin_right1" style="width:100%;">
            <div class="contactUS"><p>Mumbai, India</p>
Unit 107, "Multistoried Building"<br>
SEEPZ - SEZ,
Andheri (E)<br>
Mumbai-400 096.<br>
<strong>Tel:</strong> +91 22 3081 2300<br>
<strong>Fax:</strong> +91 22 2829 1430<br>
              <strong>Email</strong>:  mariaw@gmail.com</div>
          </div>
          
          
          <div class="clear"></div>
        </div>
        
        
        
       
        
        
      </div>
    </section>
  </div>
  <div id="push"></div>
</div>

</body>
</html>