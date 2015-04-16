<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<title>Imploy.Me - Employer Home</title>
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
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
<!-- 
 <script type="text/javascript">
function saveSearchFunction()
{	
		if( $("#employerSaveSearchChkbox").is(':checked'))
		{
			var searchParameterNameValue=$("#parameterNameId").val();
			var searchTrimmed=$.trim(searchParameterNameValue);

				if(searchTrimmed!="" && searchTrimmed.length!=0)
				{		var formValue= document.getElementById("saveSearch");
						formValue.action="employer_candidateSaveSearch.htm";	
		    			formValue.submit();
		    			return true;
				}
				else
				{		$("#saveSearchErrorLabel").html("");
			          	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
			          	return false;
				}
		}
	
		else
			{
				$("#saveSearchErrorLabel").html("");
	        	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
	        	return false;
			}
	return false;

}
	
	
</script>
 -->

<!--@author BalajiI -->
<script type="text/javascript">

 $(function(){
    $("#saveSearch").submit(function(){

        var valid=0;
        
        $(this).find('input[type=text], select').each(function(){
            if($(this).val() != "") valid+=1;
        });

        if(valid){
           return true;
        }
        else {
           
            $("#saveSearchErrorLabel").html("");
            $("#saveSearchErrorLabel").html("<label class='error'>Enter at least one search parameter!</label>");
            
            return false;
        }
    });
});
</script>

<!-- <script>$(document).ready(function(){$(".vertical-nav").verticalnav({speed: 400,align: "right"});});</script> -->
</head>

<body class="employer">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>
<%--   <header id="topnav">
     <nav>
      <ul>
       <li><a href="<c:url value="employer_dashboard.htm" />">Search</a></li>
        <li><a href="<c:url value="employer_eventpreview_jobfair.htm" />">Events</a></li>
        <li><a href="<c:url value="employer_manage_profile.htm" />">Profile</a></li>
        <li><a href="<c:url value="employer_jobsinternships_listing.htm" />">Jobs/Interships</a></li>
        <li><a href="<c:url value="employer_dashboard.htm" />" target="_self"><span class="menu_img"><img src="../mobile_html/images/home.png" alt=""></span><span class="menutxt">Home</span></a></li>
        <li><a href="user_change_password.htm"><span class="menu_img"><img src="../mobile_html/images/changepassword.png" alt=""></span><span class="menutxt">Change Password</span></a></li>
        <li><a href="contactUs.htm"><span class="menu_img"><img src="../mobile_html/images/contactus.png" alt=""></span><span class="menutxt">ContactUs</span></a></li>
        <li><a href="<c:url value="/j_spring_security_logout" />"><span class="menu_img"><img src="../mobile_html/images/logout.png" alt=""></span><span class="menutxt">Logout</span></a></li>
      </ul>
    </nav>
<!--     <div class="back_icn">&nbsp;</div>
    <div class="logo"><a href="employer_dashboard.htm"><img src="../mobile_html/images/logo_small.png" alt="3Lpis"></a></div> -->
    <a href="#" id="navbtn"><img src="../mobile_html/images/menu.png"></a> 
       <a href="candidate_dashboard.htm"><img src="../mobile_html/images/home.png"></a> 
     <a href="home.htm"><img src="../mobile_html/images/search.png"></a> 
    </header> --%>
  <div id="mid_wrap" class="midwrap_toppadding">
   <%--  <div id="submenu">
<!--      <ul>
        <li><a href="#" class="active">Search<span></span></a></li>
        <li><a href="landing.html">Save Candidate</a></li>
        <li><a href="landing.html">Events</a></li>
      </ul>-->
      
      <ul class="nav nav-pills">
      <li class="active"><a href="<c:url value="employer_dashboard.htm" />">Search</a><span class="active_arrow"></span></li>
     <!--  <li><a href="#">Saved</a></li> -->
      <li> <a  href="employer_manage_receivedinvitations.htm">Events</a>
        <!-- <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="employer_manage_receivedinvitations.htm">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
        </ul> -->
      </li>
       <li><a href="employer_manage_profile_preview.htm">Profile</a></li>
    </ul>
    </div> --%>
    <div class="clear"></div>
    <section id="inner_container">
      <h1 class="page_heading">Find <span class="orange_font">Candidates</span></h1>
      <div class="innerform">
      <ul>
        <li id="saveSearchErrorLabel"></li>
        </ul>
        
      <form:form cssClass="stdform" action="employer_search_candidate.htm" method="post" commandName="searchCandidate"  id="saveSearch"> 
          <ul class="form_wrap">
            <li>
               <input name="keyword" type="text" tabindex="1" placeholder="Keywords, Skills, Designation" >
            </li>
            <li>
              <input name="location" type="text" tabindex="2" placeholder="Location" >
            </li>
            <li>
              <%-- <select name="state"  tabindex="3">
              <option value="">Choose State </option>
                  <c:forEach var="stateList1" items="${stateList}">
                     <option value="${stateList1}"><c:out value="${stateList1}" /></option>
                  </c:forEach>                 
             </select>
            </li>
            <li>
               <select name="universityName" tabindex="4">
               <option value="">Choose University</option>
                  <c:forEach var="universityList1" items="${universityList}">
                     <option value="${universityList1}"><c:out value="${universityList1}" /></option>
                  </c:forEach>                                  
               </select>
            </li> --%>
            
           <form:select path="state" multiple="multiple" tabindex="3"> 
               <form:options items="${stateList}" />                    
              </form:select>
            </li>
            <li>
               <form:select path="universityName" multiple="multiple" tabindex="4">
                   <form:options items="${universityList}" />                    
                 </form:select>
            </li>
                 <li class="par"> 
	              
                </li>
               <li class="par">
                 <!--  <div id="checked" class="showhide_text" style="display: none;">
	                  <label class="floatleft">Parameter Name</label>
	                  <span class="star">*</span>
	                  <div class="clear"></div>
	                  <span class="field">
	                    <input name="parameterName" type="text" id="parameterNameId" placeholder="Search Parameter Name" >
	                  </span> 
                  </div> -->
              </li> 
            
            
            <li class="text_center">
              <input name="" type="submit" value="Search" class="orangebutton">
             <!--  <input name="" type="button" value="Save this Search" class="orangebutton" onclick="saveSearchFunction()" > -->
            </li>
          </ul>
      <!--   </form> -->
      </form:form>
       
       
      </div>
      <div class="margin20_top">
        <p class="para">Explore the huge database of students across the country by signing in into the system , connect with universities to schedule drives and recruitments . Do you have better reasons to wait and think ?</p>
      </div>
    </section>
  </div>
  <div id="push"></div>
</div>
<%--  <%@ include file="includes/footer.jsp"%>
 --%>
</body>
</html>