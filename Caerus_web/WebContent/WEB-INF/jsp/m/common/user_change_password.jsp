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
<title>Imploy.Me - Candidate Details</title>
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
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>

<script>
function validateForm()
{
	if($("#oldPassword").val() == $("#newPassword").val())
	{
		$("#error").empty();

		$("#error").css('display','block');

		$(".errorblock").css('display','none');
		
		$("#error").html("New Password cannot be same as Old Password.");
		
		return false;
	}
	return true;
}

$(document).ready(function(){

	var success = $("#success").val();

	if(success != null && success != "")
	{
		$("#successDiv").empty();

		$("#successDiv").html("Password changed Successfully!  Please login with New Credentials.");

		timeoutfunction();
	
	}

	function timeoutfunction()
	{
		setTimeout(function(){window.location.href="<c:url value='/j_spring_security_logout' />";}, 2500);
	} 

	});

</script>
</head>
  <%Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				String authority = auth.getAuthorities().toString();
				int mid = authority.lastIndexOf("_");
			 	String role = authority.substring(mid+1, authority.length()-1);
				 pageContext.setAttribute("role", role);
				 %>
				<%--  <c:set var="role" value="${role}"></c:set>
				    <c:if test="${role=='STUDENT'}"> --%>
<body class="student">
<div id="main_wrap">
 
    <%@ include file="includes/header.jsp"%>
  <div id="mid_wrap" class="midwrap_toppadding">
    
    <div class="clear"></div>
    <section id="inner_container">
      <h1 class="page_heading">Change <span class="orange_font">Password</span></h1>
           
      <div class="innerform">
                   
       <c:if test="${not empty oldPassword}">
		<div class="errorblock">Old Password Does not match our Records.</div>
	  </c:if>          
	  
	  <div id="error" style="display:none;"></div>
	  <div id="successDiv"></div>
	  
	  <c:if test="${not empty success}">
              <input type="hidden" id="success" value="${success}">
              </c:if>
      <form:form  action="" method="post" commandName="userCommand" onsubmit="return validateForm()">
          <ul class="form_wrap">
            <li>
              <input name="oldPassword" type="password" tabindex="1" required pattern="(.){8,20}" placeholder="Old Password *" id="oldPassword">
               <form:errors path="oldPassword"  cssClass="validationnote"/>
            </li>
          <li>
              <input id="newPassword" name="newPassword" type="password" tabindex="1" pattern="(.){8,20}" required onchange="form.confirmPassword.pattern = this.value;" placeholder="New Password *" >
              <form:errors path="newPassword"  cssClass="validationnote"/>
            </li>
             <li>
              <input name="confirmPassword" type="password" tabindex="1" required pattern="(.){8,20}" placeholder="Confirm New Password *" >
              <form:errors path="confirmPassword"  cssClass="validationnote"/>
            </li>
              
	
            <li class="text_center">
              <input name="" type="submit" value="Update Password" class="orangebutton">
            </li>
          </ul>
       
        </form:form>
      </div>
    </section>
  </div>
    <div id="push"></div>
   </div>

</body>
</html>