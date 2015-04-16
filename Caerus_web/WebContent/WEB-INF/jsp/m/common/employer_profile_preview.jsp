<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Company Profile</title>
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
  function goBack()
  {
 	 window.history.back();
  }
</script> 


<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

 <body class="student">
      <div id="main_wrap">
    
  <div id="mid_wrap" class="midwrap_toppadding">
   <%--  <div id="submenu">
      <ul class="nav nav-pills">
        <li class="active"><a href="candidate_dashboard.htm" >Search<span class="active_arrow"></span></a></li>
        <c:if test="${role!='ANONYMOUS'}">
					<li><a href="candidate_detail_view.htm">Profile</a></li>
					<li><a href="candidate_applied_jobs.htm">Jobs</a></li>
					  </c:if>
      </ul>
    </div> --%>
       
    <div class="clear"></div>
    <section id="inner_container">
          
      <div class="jobdetail_wrap">
			<div class="jobdetails">
            	<div class="company_logo float_left">
            	 
				<c:choose>
											<c:when test="${employerDetails.emailID ne null}"> 
											<img src="view_image.htm?emailId=${employerDetails.emailID}" > 
											</c:when>
											<c:otherwise>
						                      <img src="/images/Not_available_icon1.png" > 
						                      </c:otherwise>
						                      </c:choose> 
				
				</div>
            	<div class="details float_left">
            	
               	 <h1 class="heading" style="width:100%;"><c:out value="${employerDetails.companyName}"/></h1>
				 <h2 class="subheading"><c:out value="${employerDetails.addressLine1}"/></h2> 
                 <div class="jobtype"><c:out value="${employerDetails.city}" />, <c:out value="${employerDetails.postalCode}"/>, <c:out value="${employerDetails.state}"/></div> 
                
                 </div>              
   
              </div>
            <div class="clear"></div>
            
            <h1 class="jobdescp_title orange_font">Who We Are</h1>
			<div class="jobdescp_para_wrap"><p class="jobdescp_para"><c:out value="${employerDetails.companyDesc}" /></p></div>
			
			 <h1 class="jobdescp_title orange_font">Work Culture at <c:out value="${employerDetails.companyName}"/></h1>
			<div class="jobdescp_para_wrap"><p class="jobdescp_para"><c:out value="${employerDetails.workingWithUs}" /></p></div>
            
            <%--  <h1 class="jobdescp_title orange_font">Overview</h1>
			<div class="jobdescp_para_wrap"><p class="jobdescp_para"><c:out value="${companyDetails.companyDesc}" /></p></div> --%>
	<div id="accordion-container">
			
    <h2 class="accordion-header">Company Details</h2>
    <div class="accordion-content"> 
	   <p><span class="orange_font boldtxt">Contact Number: </span><c:out value="${employerDetails.phoneNumber}"/> <br/>
	<span class="orange_font">Website: </span> <a href="http://<c:out value="${employerDetails.companyWebsite}" />" target="_blank"> <c:out value="${employerDetails.companyWebsite}" /> </a><br/>
	<span class="orange_font">Email Address:</span> <c:out value="${employerDetails.emailID}"/><br>
	<span class="orange_font">Office Locations:</span>
	 <c:forEach var="companyLocations" items="${employerDetails.companyLocations}" varStatus="loop" >          	
          		
          		<c:set var="companyLocationsSize" value="${fn:length(employerDetails.companyLocations)}" />
          			<c:out value="${companyLocations.key}"/>          			
          			<c:choose>          			
        						<c:when test="${companyLocationsSize == loop.index+1}">
        							<c:out value=". "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=", "/>
        						</c:otherwise>
        				</c:choose>  
			</c:forEach>
	</div>
	
	
	
	<h2 class="accordion-header">More About Us</h2>
	<div class="accordion-content">
	<video id="home_video1" class="video-js vjs-default-skin" controls width="342" height="200">
            <!-- MP4 source must come first for iOS -->
            <source type="video/mp4" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
            <!-- WebM for Firefox 4 and Opera -->
            <source type="video/wmv" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
            <!-- OGG for Firefox 3 -->
            <source type="video/ogg" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
            
            <source type="video/mp3" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
            <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
                  <param name="movie" value="flashmediaelement.swf" />
                  <param name="flashvars" value="controls=true&amp;file=view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object>
          </video>
          
              <script>var homePlayer=_V_("home_video1");</script> 
              
             
             <%--  <c:choose> --%>
		          	<c:if  test="${ not empty employerDetails.brochureName }">
		          		 <a style="float:right;" title='<c:out value="${employerDetails.brochureName}"/>' href='view_brochure.htm?companyName=<c:out value="${employerDetails.companyName}"/>'  id="temp1" class="active" target="_blank">
					          <img src="../mobile_html/images/pdfIcon.gif" alt=""> 
					         <!--  <span style="padding-left: 85px;">Open</span> -->
				          </a>
				   </c:if>
		          <%-- <c:otherwise>
		          		   <img src="../mobile_html/images/pdfIcon.gif" alt="" style="float:right;"> 
		          </c:otherwise>
		          </c:choose> --%>
	</div>
	
	    <h2 class="accordion-header">Hiring Process</h2>
			    <div class="accordion-content">
			    <c:set var="hiringProcess" value="${employerDetails.hiringProcess}" />
	       				 <div style="float:left;padding-left:50px;width:100%;">
								<div>
									<ul class="tabs" id="hplist">
									</ul>
								</div>
						</div>
	                <%-- <span class="orange_font">Registration No: </span><c:out value="${companyDetails.companyRegNumber}"/><br>
	                <span class="orange_font">Industry: </span><c:out value="${companyDetails.industry}"/><br>
	                <span class="orange_font">No. of Employees: </span><c:out value="${companyDetails.noOfEmployees}"/><br>
	                <span class="orange_font">Contact Person: </span><c:out value="${companyDetails.contactPersonName}"/><br> --%>
					<div class="clear"></div>
    			</div>
    
   		<h2 class="accordion-header">Get In Touch With Us</h2>
			    <div class="accordion-content">
	                <span class="orange_font">Registration No: </span><c:out value="${employerDetails.companyRegNumber}"/><br>
	                <span class="orange_font">Industry: </span><c:out value="${employerDetails.industry}"/><br>
	                <span class="orange_font">No. of Employees: </span><c:out value="${employerDetails.noOfEmployees}"/><br>
	                <span class="orange_font">Contact Person: </span><c:out value="${employerDetails.contactPersonName}"/><br>
	                <span class="orange_font">LinkedIn: </span><c:out value="${employerDetails.linkedInAddress}"/><br>
					<div class="clear"></div>
			    </div>
	
    </div>
 <br>
 <div class="fullwidth_form">
  				<div class="par">
                  <div class="buttonwrap">
                 <%  Authentication headAuth = SecurityContextHolder.getContext().getAuthentication();
				String headAuthority = headAuth.getAuthorities().toString();
				int headMid = headAuthority.lastIndexOf("_");
			 	String headRole =headAuthority.substring(headMid+1, headAuthority.length()-1);
				pageContext.setAttribute("headRole", headRole);
				%>
				
                  <c:if test="${headRole == 'CORPORATE'}"> 
                     <input name="" type="button" value="Edit" class="orangebuttons" onClick="window.location.href='employer_manage_profile.htm'" />
					</c:if>
						<input name="search" type="button" value="Back" class="orangebuttons" onClick="goBack()">
                  </div>
           </div></div>
      </div>
    </section>
  </div>
     <div id="push"></div>  
</div>

<script type="text/javascript">
$(window).load(function(){
	var hiringProcess = "${hiringProcess}";
	if($.trim(hiringProcess) != '')
	{
		var array = new Array();
		array = hiringProcess.split(",");
		$.each(array, function( index, value ) {
			$("#hplist").last().append('<li style="width:10%;"><span class="bullet_number">'+ (index+1) +'</span>   '+value+'</li>');
		});
	}
});
</script>
 <%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>