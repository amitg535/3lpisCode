<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
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
<title>Imploy - Home</title>
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

function searchJobsInternships(searchCriteria)
{
	 if (searchCriteria == "jobs") 
	 {
		 $("#industry").css('display','block');
	 }
	 else
     {
		 $("#industry").css('display','none');
	 }
}


$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
 
		var selectedCriteria = $("input[name=searchCriteria]:checked").val();

		if (selectedCriteria == "internships") 
		 {
			 $("#industry").css('display','none');
		 }
		
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
</head>
<body class="home">
<div id="main_wrap" class="loginBg">
  <header id="homeheader">
     <div class="logo"><a href="home.htm"><img src="../mobile_html/images/logo_big.png" alt="3Lpis"></a></div>
    <div class="signin_panel"><a href="login.htm" class="signin_btn">Sign In</a></div>
    <div class="clear"></div>
  </header>
  <div id="mid_wrap" class="midwrap_toppadding">
    <div id="search_wrap">
     
      <div id="searchform_wrap">
        <!-- <h2>Find Jobs</h2> -->
        <div class="searchform_wrap">
           <form:form action="candidate_search_jobs_internships.htm" method="post" commandName="studentSearchJobs" cssClass="stdform" id="advancedSearch" >
            <ul class="form_wrap">
             
             
             	<li>
			           <div class="clear"></div>
			           	<div class="searchfilter">
			           	 <label class="label_radio">
                 <!--  <input type="radio" value="radio1"  name="gender" id="radio-01" />
                  Male</label> -->
			           	
			           	<form:radiobutton path="searchCriteria"  id="searchCriteria1" class="css-checkbox" checked="true" OnClick="searchJobsInternships('jobs')" value="jobs"/>
			            <!-- <input type="radio" name="searchCriteria" id="radio1"   checked="checked" /> -->
			            <!-- <label for="searchCriteria1" class="css-label"> -->Jobs</label>
			            <label class="label_radio">
			            <form:radiobutton path="searchCriteria"  class="css-checkbox" id="searchCriteria2" value="internships" OnClick="searchJobsInternships('internships')" />
			            <!-- <input type="radio" name="radiog_lite" id="radio2" class="css-checkbox"/> -->
			            <!-- <label for="searchCriteria2" class="css-label-red"> -->Internships</label>
			            
			            </div>
            		
            		</li>
             
             
             
              <li>
                <input name="keyword" type="text" tabindex="1" placeholder="Keywords, Skills, Designation" id="keywords" >
              </li>
              <li>
                <input name="location" type="text" tabindex="2" placeholder="Location" >
              </li>
              <li>
                <select name="functionalArea"  tabindex="3">
                <option value="">Choose Functional Area </option>
                  <c:forEach var="functionalArea" items="${functionalAreaList}">
                                      
                         <option value="<c:out value="${functionalArea}" />" ><c:out value="${functionalArea}" /></option> 
 
                 </c:forEach>
                </select>
                
                
              </li>
              <li>
                <select name="industry"  tabindex="4" id="industry">
                <option value="">Choose Industry</option>
                   <c:forEach var="industry" items="${industryList}">
                   
                         <option value="<c:out value="${industry}" />"><c:out value="${industry}" /></option> 

                 </c:forEach>
                 </select>
              </li>
               <li class="text_center">
                <input name="search" type="submit" value="Search" class="orangebutton" id="search">
              </li>
            </ul>
          </form:form>
        </div>
        <div class="margin20_left margin20_right bottom_txt">Imploy.com takes you to the world of workforce recruitment with the best of openings , social networking and finest pieces of technology </div>
        
        <div class="registeration" >
          <div class="notamember_txt"><span>Not a Member?</span> Sign Up Now!!
          </div>
          
          	<div>
          	<a href="employer_registration.htm" class="employer"><img src="../mobile_html/images/employer_reg_icn.png" />Employer Registration</a>
          	<a href="candidate_registration.htm" class="candidate"><img src="../mobile_html/images/candidate_reg_icn.png"/>Candidate Registration</a>
          	<a href="university_registration.htm" class="university"><img src="../mobile_html/images/university_reg_icn.png"/>University Registration</a>
          	</div>
          </div>
      </div>
    </div>
 <script>
$(search).click(function() {
	//alert("w");
	
    

	// validate signup form on keyup and submit
	$("#advancedSearch").validate({
		rules: {
			keywords: "required"
			
		},
		messages: {
			keywords: "Please enter a Keyword to search jobs upon",
			
		}
	});

});
</script>
    
   
  </div>
		   <div id="push"></div>
  </div>
 <%-- <%@ include file="includes/footer.jsp"%> --%>
  
</body>
</html>