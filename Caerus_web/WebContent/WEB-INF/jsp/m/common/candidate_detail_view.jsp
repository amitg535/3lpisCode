<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy.Me - Candidate Profile</title>
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

<body class="employer">
<div id="main_wrap">
 <%@ include file="includes/header.jsp"%>
  <div id="mid_wrap" class="midwrap_toppadding">
    <%-- <div id="submenu">
     <!-- <ul>
        <li><a href="#" class="active">Search<span></span></a></li>
        <li><a href="landing.html">Save Candidate</a></li>
        <li><a href="landing.html">Events</a></li>
      </ul>-->
      <ul class="nav nav-pills">
      <li class="active"><a href="<c:url value="employer_dashboard.htm" />">Search</a><span class="active_arrow"></span></li>
     <!--  <li><a href="#">Saved</a></li> -->
      <li> <a  href="employer_manage_receivedinvitations.htm">Events </a>
        <!-- <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
        </ul> -->
      </li>
       <li><a href="employer_manage_profile_preview.htm">Profile</a></li>
    </ul>
    </div> --%>
    <div class="clear"></div>
    <section id="inner_container">
      <div class="jobdetail_wrap">
        <div class="jobdetails">
        
          <c:set var="candidateEmailId" value="${studentDetails.emailID}"></c:set>
          <div class="company_logo float_left"> <img src="view_image.htm?emailId=<c:out value="${candidateEmailId}"/>"></div>
          <div class="details">
            <h1 class="heading"> <c:out value="${studentDetails.firstName}"/><span>  </span><c:out value="${studentDetails.lastName}"/>, <span class="orange_font"><c:out value="${studentDetails.designation}"/></span> </h1>
            <h2 class="subheading"><c:out value="${studentDetails.address}"/>, <c:out value="${studentDetails.city}"/>,
              <span class="font_italic"><c:out value="${studentDetails.state}"/>, <c:out value="${studentDetails.zipCode}"/> </span></h2>
          </div>
          <div class="applybtn_wrap">
            <div class="innerform">
              <form>
                <ul class="form_wrap">
                  <li>
                 <%--  <c:if test="${studentDetails.savedCandidate eq false}">
	              
	              <c:if test="${not empty source && source eq 'viewResponses'}">
	              	<a href="employer_save_candidate.htm?source=viewResponses&mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	              </c:if>
	              
	               <c:if test="${not empty source && source eq 'internshipResponses'}">
	              	<a href="employer_save_candidate.htm?source=internshipResponses&mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	              </c:if>
	              
	              <c:if test="${empty source }">
	              	<a href="employer_save_candidate.htm?mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	              </c:if>
	              
	                <c:choose>
	                	<c:when test="${not empty source && source eq 'viewResponses'}">
	                  		<a href="employer_save_candidate.htm?source=viewResponses&mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	                    </c:when>
	                    <c:otherwise>
	                  		<a href="employer_save_candidate.htm?mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	                    </c:otherwise>
                   </c:choose>
                   
                     <c:choose>
	                	<c:when test="${not empty source && source eq 'internshipResponses'}">
	                  		<a href="employer_save_candidate.htm?source=internshipResponses&mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	                    </c:when>
	                    <c:otherwise>
	                  		<a href="employer_save_candidate.htm?mailIdSave=<c:out value="${studentDetails.emailID}"/>"><span><input name="Save Candidate" type="button" value="Save Candidate" class="orangebuttons"></span></a>
	                    </c:otherwise>
                   </c:choose>
                   
                  </c:if> --%>
                  
                 
                  </li>
                </ul>
              </form>
            </div>
          </div>
        </div>
        <div class="clear"></div>
        <div class="basicinfo_wrap">
          <div class="innerwrap margin_right1">
            <div class="img_wrap"><img src="../mobile_html/images/email_icn.png" alt="Email" /></div>
            <div class="content_wrap">Mobile:  <c:out value="${studentDetails.mobileNumber}"/> <br />
              Email: <c:out value="${studentDetails.emailID}"/> </div>
          </div>
          <div class="innerwrap margin_right1">
            <div class="img_wrap"><img src="../mobile_html/images/user_icn.png" alt="User Information" /></div>
            <div class="content_wrap">Birth: <c:out value="${studentDetails.dateOfBirth}"/><br />
              Gender:   <c:out value="${studentDetails.gender}"/> </div>
          </div>
          <%-- <div class="innerwrap"> <a href="download_resume.htm?mailIdSave=<c:out value="${listForCandidate.email}"/>">
            <div class="img_wrap"><img src="../mobile_html/images/download_icn.png" alt="Download Resume" /></div>
            <div class="content_wrap">Download<br />
              Resume</div>
            </a> </div> --%>
          <div class="clear"></div>
        </div>
         <p class="jobdescp_para"><c:out value="${studentDetails.aboutYourSelf}"/> </p>
           <div id="accordion-container">
        <h1 class="accordion-header">Education</h1>
        <div  class="accordion-content">
        <ul class="education_list">
        
         <c:forEach items="${universityList}" var="universityDetails">
        	<li>
           <c:out value="${universityDetails.universityCourseType}"/> <c:out value="${universityDetails.universityCourseName}"/>, <c:out value="${universityDetails.universityName}"/><br/>
            <span class="orange_font font_italic"><c:choose>
                <c:when test="${universityDetails.universityMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose>
               
                 <c:out value="${universityDetails.universityYearFrom}"/> - 
                 
                  <c:choose>
                  <c:when test="${universityDetails.universityMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '12'}">
                  Dec
                </c:when></c:choose> <c:out value="${universityDetails.universityYearTo}"/>
               </span>
            </li>
            </c:forEach>
            
            <li>
           <c:out value="${schoolDetails.schoolName}"/>, <c:out value="${schoolDetails.schoolState}"/><br/>
           <span class="orange_font font_italic">
            <c:out value="${schoolDetails.schoolPassingMonth}"/>, <c:out value="${schoolDetails.schoolPassingYear}"/>
           </span>
            </li>
        </ul>
        </div>
        </div>
        <div id="accordion-container">
        <h1 class="accordion-header">Primary Skills</h1>
        <div  class="accordion-content">
          <ul class="keyskillslist">
          <c:forEach var="primarySkillsVar" items="${studentDetails.primarySkills}" varStatus="loop" > 
            
          			<li><c:out value="${primarySkillsVar}"/></li>
          	      
			</c:forEach>
            <!-- <li>J2EE</li>
            <li>Hibernate</li>
            <li>J2EE</li> -->
          </ul>
          <div class="clear"></div>
          
        </div>
        </div>
          <div id="accordion-container">
          <h1 class="accordion-header">Secondary Skills</h1>
        <div  class="accordion-content">
          <ul class="keyskillslist">
          <c:forEach var="secondarySkillsVar" items="${studentDetails.secondarySkills}" varStatus="loop" > 
          			 
          					<li><c:out value="${secondarySkillsVar}"/></li>
          			       
			</c:forEach>
           <!--  <li>J2EE</li>
            <li>Hibernate</li>
            <li>J2EE</li> -->
          </ul>
          <div class="clear"></div>
        </div>
        </div>
        <div id="accordion-container">
          <h2 class="accordion-header">Experience</h2>
          <div class="accordion-content">

  		<ul class="education_list">
        	
        	  <c:forEach items="${workList}" var="workDetails">
        	
        	<li><c:out value="${workDetails.workCompanyName}"/><br/>
            <span class="orange_font font_italic"><c:out value="${workDetails.workDesignation}"/>, <span class="boldtxt">
            <%-- <c:out value="${studentDetails.w_startMonth_duration}"/> <c:out value="${studentDetails.w_startYear_duration}"/> - <c:out value="${studentDetails.w_endMonth_duration}"/> <c:out value="${studentDetails.w_endYear_duration}"/> --%>
            
              <c:choose>
                  <c:when test="${workDetails.workMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '12'}">
                  Dec
                </c:when></c:choose>
          <c:out value="${workDetails.workYearFrom}"/> - 
          
         <c:choose>
                  <c:when test="${workDetails.workMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '12'}">
                  Dec
                </c:when></c:choose> <c:out value="${workDetails.workYearTo}"/>
            
            
            </span></span>
              <p class="jobdescp_para"><c:out value="${studentDetails.workDesc}"/> </p>
            </li>
            </c:forEach>
            <!-- <li>
   <span class="orange_font font_italic">Intern Programmer, <span class="boldtxt">5 months</span></span>
              <p class="jobdescp_para">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus augue sem, blandit ac molestie id, tincidunt at elit. Quisque laoreet lectus nunc, quis ullamcorper orci laoreet non. </p>
            </li> -->
        </ul>

            <div class="clear"></div>
          </div>
         
          
        </div>
      </div>
    </section>
  </div>
  <div id="push"></div>
</div>
<%--  <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>