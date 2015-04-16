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
<title>Candidate Dashboard</title>
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

<script src="../mobile_html/js/script.js" type="text/javascript"></script>
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
 <script type="text/javascript" src="../mobile_html/js/jquery.validate.min.js"></script>
 <script type="text/javascript" src="../mobile_html/js/additional-methods.js"></script>
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
    	})
    }
</script>
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
 <script type="text/javascript">
 $(function(){
	    $("#advancedSearch").submit(function(){
	        var valid=0;	        
	        $(this).find('input[type=text], select').each(function(){
	            if($(this).val() != "")
	            	{
	            		valid+=1;
	                }
	        });
	        if(valid){
	        	return true;        
	        }
	        else {
	        	$("#searchErrorLabel").html("");
	            $("#searchErrorLabel").html("<label class='error'>Enter at least one search parameter!</label>");	            
	            return false;
	         }
	    });
	});
	
</script>

</head>

      <body class="student">
      <div id="main_wrap">
   	<%@ include file="includes/header.jsp"%>
          <div id="mid_wrap" class="midwrap_toppadding">
          
    <!-- <div id="submenu">
      <ul class="nav nav-pills">
        <li class="active"><a href="#" >Search<span class="active_arrow"></span></a></li>
        <li><a href="candidate_detail_view.htm">Profile</a></li>
        <li><a href="candidate_applied_jobs.htm">Jobs</a></li>
        <li><a href="candidate_view_virtualfairs.htm">Virtual Fairs</a></li>
      </ul>
   </div> -->
    <div class="clear"></div>
    <section id="inner_container">
              <h1 class="page_heading">Find <span class="orange_font">Jobs</span></h1>
               <span id = "searchErrorLabel"></span>
              <div class="innerform">
        <form:form action="candidate_search_jobs_internships.htm" method="post"  class="stdform" id="advancedSearch" modelAttribute="searchJobs">
         
                  <ul class="form_wrap">
            		
            		<li>
			           <div class="clear"></div>
			           	<div class="searchfilter">
			            
			             <label class="label_radio">
                 <!--  <input type="radio" value="radio1"  name="gender" id="radio-01" />
                  Male</label> -->
			           	
			           	<form:radiobutton path="searchCriteria"  id="searchCriteria1" class="css-checkbox" checked="true"  value="jobs" onclick="searchJobsInternships('jobs')"/>
			            <!-- <input type="radio" name="searchCriteria" id="radio1"   checked="checked" /> -->
			            <!-- <label for="searchCriteria1" class="css-label"> -->Jobs</label>
			            <label class="label_radio">
			            <form:radiobutton path="searchCriteria"  class="css-checkbox" id="searchCriteria2" value="internships" onclick="searchJobsInternships('internships')" />
			            <!-- <input type="radio" name="radiog_lite" id="radio2" class="css-checkbox"/> -->
			            <!-- <label for="searchCriteria2" class="css-label-red"> -->Interships</label>
			            
			            </div>
            		
            		</li>
            		
            		<li>
            		 <!-- <span class="starright" >*</span> -->
                     <input name="keyword" id="keyword" type="text" tabindex="1" placeholder="Keywords, Skills, Designation" class="validate" >
            		</li>
           			
           			<li>
                      <input name="location" id="location" type="text" tabindex="2" placeholder="Location"  class="validate">
           			 </li>
            		
            		<li>
              		<select name="functionalArea" id="functionalArea"  tabindex="3">
              		<option value="">Choose Functional Area</option>
                   	<c:forEach var="functionalArea" items="${functionalAreaList}">
                   	
                               <option value="<c:out value="${functionalArea}" />" ><c:out value="${functionalArea}" /></option> 
                   	</c:forEach>
                 	
                	</select>
                    </li>
                    
            		<li>
          			<select name="industry" id="industry" size="1" tabindex="4">
          			<option value="">Choose Industry</option>
                	<c:forEach var="industryList" items="${industryList}">
                   	
	                         <option value="<c:out value="${industryList}" />" ><c:out value="${industryList}" /></option> 
                    
                 	</c:forEach>
                			
                	</select>
                    </li>
                     
            		<li class="text_center">
                      <input name="search" type="submit" value="Search" class="orangebutton">
                    </li>
          			</ul>
              </form:form>
      </div>
              <div class="margin20_top">
        <p class="para"> </p>
      </div>
            </section>
  </div>
           <div id="push"></div> 
        </div>
<%--  <%@ include file="includes/footer.jsp"%> --%>

</body>
</html>