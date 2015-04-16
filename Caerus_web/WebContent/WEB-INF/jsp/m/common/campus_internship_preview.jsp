<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <title>Campus Internship Preview</title>
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

<script type="text/javascript">
function applyCondition(){
	
	 $("#msg").show();
}
function saveCondition(){
	
	 $("#msg").show();
}
function goBack()
{
	 window.history.back();
}
</script>

<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8" />
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="student">

<div id="main_wrap">
 <%@ include file="includes/header.jsp"%>	
  <div id="mid_wrap" class="midwrap_toppadding">
    <%-- <div id="submenu">
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
          <div class = "error_msg" id = "msg" style="display:none"> Login to Apply for a Job / Register if not a member. </div>
          <c:if test="${not empty applied}">
          Internship Applied Successfully!
          </c:if>
      <div class="jobdetail_wrap">
			<div class="jobdetails" style="min-height:165px;">
            	<div class="company_logo float_left">
				<a href="profile_preview.htm?companyName=${campusInternshipDetails.companyName}">
				
				<c:choose>
				<c:when test="${companyDetails.imageName ne null}"> 
				<div class="company_logo">
				<img src="view_image.htm?emailId=${campusInternshipDetails.emailId}" height="32" width="110">
				</div>
				</c:when>
				<c:otherwise>
                     <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
                     </c:otherwise>
               </c:choose>

				</a>
				
				</div>
            	<div class="details float_left">
                	 <h1 class="heading"><c:out value="${campusInternshipDetails.internshipTitle}"/> ( Internship Id <span id="iid"><c:out value="${campusInternshipDetails.internshipId}"/></span> )</h1>
					 <h2 class="subheading"><a href="profile_preview.htm?companyName=${campusInternshipDetails.companyName}"><c:out value="${campusInternshipDetails.companyName}"/>,</a><c:out value="${campusInternshipDetails.location}"/></h2>
					 <h2 class="subheading">Duration: <c:out value="${campusInternshipDetails.startDate}"/> - <c:out value="${campusInternshipDetails.endDate}"/></h2>
                     <div class="jobtype"><c:out value="${campusInternshipDetails.internshipType}"/>, <span class="postedon">Posted on:<fmt:parseDate value="${campusInternshipDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/><fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>
                      
                     </div>  
				     </div>              
      <c:if test="${ not fn:containsIgnoreCase(campusInternshipDetails.campusInternshipAppliedStudents,emailId) && headRole == 'STUDENT'}">         
     <div class="applybtn_wrap float_right">
     <a href="candidate_apply_broadcasted_internship.htm?internshipId=<c:out value="${campusInternshipDetails.internshipIdAndFirmId}"></c:out>"><input name="" type="button" value="Apply" class="orangebuttons"></a>
     </div>
     </c:if>
              </div>
              
            <div class="clear"></div>
             <h1 class="jobdescp_title orange_font">Internship Description</h1>
			<div class="jobdescp_para_wrap">
			<p class="jobdescp_para"><c:out value="${campusInternshipDetails.internshipDescription}"/></p>	
			</div>
			
			<div class="clear"></div>
             <h1 class="jobdescp_title orange_font">Salary Per Week ($)</h1>
			<div class="jobdescp_para_wrap">
			<p class="jobdescp_para"> <c:out value="${campusInternshipDetails.payPerHour}"/></p>
			</div>
			
			<%-- <div class="clear"></div>
             <h1 class="jobdescp_title orange_font">Functional Area</h1>
			<div class="jobdescp_para_wrap">
			<p class="jobdescp_para"> <c:out value="${campusJobDetails.functionalArea}"/></p>
			</div> --%>
			
			<div class="clear"></div>
             <h1 class="jobdescp_title orange_font">No of Vacancy</h1>
			<div class="jobdescp_para_wrap">
			<p class="jobdescp_para"> <c:out value="${campusInternshipDetails.numberOfVacancy}"/></p>
			</div>
			
			<div class="clear"></div>
             <h1 class="jobdescp_title orange_font">Approximate Hours</h1>
			<div class="jobdescp_para_wrap">
			<p class="jobdescp_para"> <c:out value="${campusInternshipDetails.approximateHours}"/></p>
			</div>
			
            <div id="accordion-container">
    <h2 class="accordion-header">Skills</h2>
    <div class="accordion-content">
    <ul class="keyskillslist">
                       <c:forEach var="primarySkillsVar" items="${campusInternshipDetails.primarySkills}" varStatus="loop" >          	
          		<c:set var="primarySkillsVar" value="${fn:replace(primarySkillsVar, '[', ' ')}" />          	
          		<c:set var="primarySkillsVar" value="${fn:replace(primarySkillsVar, ']', ' ')}" /> 
          		<c:set var="primarySkillsListSize" value="${fn:length(campusInternshipDetails.primarySkills)}" />
          			<li><c:out value="${primarySkillsVar}"/>          			
          			<c:choose>          			
        						<c:when test="${primarySkillsListSize == loop.index+1}">
        							<c:out value=". "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=", "/>
        						</c:otherwise>
        				</c:choose>  
        				</li>
			</c:forEach>
                       <c:forEach var="secondarySkillsVar" items="${campusInternshipDetails.secondarySkills}" varStatus="loop" >          	
          		<c:set var="secondarySkillsVar" value="${fn:replace(secondarySkillsVar, '[', ' ')}" />          	
          		<c:set var="secondarySkillsVar" value="${fn:replace(secondarySkillsVar, ']', ' ')}" />
          	<c:set var="secondarySkillsListSize" value="${fn:length(campusInternshipDetails.secondarySkills)}" />
          	          <li>	<c:out value="${secondarySkillsVar}"/>
          	          	<c:choose>          			
        						<c:when test="${secondarySkillsListSize == loop.index+1}">
        							<c:out value=" "/>
        						</c:when>
        				
        						<c:otherwise>
        							<c:out value=" "/>
        						</c:otherwise>
        				</c:choose>    
          	     </li>
			</c:forEach>
                         </ul>
<div class="clear"></div>

    </div>
    </div>
   <br>
 
  <div class="fullwidth_form">
  				<div class="par">
                  <div class="buttonwrap">
						 <input name="search" type="button" value="Back" class="orangebuttons" onclick="goBack()">
                  </div>
           </div></div>
      </div>
    </section>
  </div>
     <div id="push"></div>  
</div>

<%--  <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>