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
<title>Imploy.Me - Employer Saved Searches</title>
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
      <li> <a href="employer_manage_receivedinvitations.htm">Events </a>
        <!-- <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
        </ul> -->
      </li>
       <li><a href="employer_manage_profile_preview.htm">Profile</a></li>
    </ul>
    </div>
     --%><div class="clear"></div>
   
    <section id="inner_container">
      <h1 class="page_heading">Saved Searches <span class="orange_font">(<c:out value="${count}"/>)</span></h1>
      
       <c:set var="count" scope="session" value="${count}"/>
			
			<c:choose>
			
			<c:when test="${count == 0}">
			<div class="error_message_span validationnote">No results Found</div>
	</c:when>
      <%--   <div class="rightsection ">
            <div class="left_searchfilter_label floatleft" style="padding-top: 0.5em;">Sort By Formula </div>
              
                <div class="details floatleft">
               
                 
            <span class="formwrapper floatleft">
              <select name="formula_Name" id="formula_Name" style="height:46px;width:100%;">
               	<c:forEach var="formulaName" items="${employerFormulae}">
               		<option value="${formulaName.formulaName}"><c:out value="${formulaName.formulaName}"/></option>
               	</c:forEach>
              </select>
           </span>
              <input type="button" value="Generate" id="generateScoreBtn"  class="orangebutton1" style="margin-left:15px;">
               </div> 
          </div>
      --%>
      
      <c:otherwise>
      
      <div class="search_listing_wrap">
      
 <%--  <form:form id="form1"  method="post" commandName="searchCandidate"> --%>
 
   <ul class="event_listing">
     <c:forEach var="searchjobs" items="${searchjobs}"> 
        <li id="${searchjobs.parameterName}" > 
        
        <a href="employer_saved_search_candidates.htm?searchParameterName=<c:out value="${searchjobs.parameterName}"/> ">
         <h1 class="heading"><c:out value="${searchjobs.parameterName}"/></h1>
            <h2 class="subheading">
             <fmt:parseDate value="${searchjobs.savedSearchOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
	            Saved On : <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/>
	            
          </h2>
          <ul class="contactdetails_wrap">
              <li>
           <%-- <a href="employer_saved_search_delete.htm?searchParameterName=<c:out value="${searchjobs.searchParameterName}"/>" ><img src="../images/small_delete_icn.png" width="16" height="16" alt="delete" title="delete" class="table_actionbtn"> Delete </a> --%>
            <%-- <input type="button" value="Delete" class="orangebutton1" onclick="window.location.href='employer_saved_search_delete.htm?searchParameterName=<c:out value="${searchjobs.searchParameterName}"/>'" /> --%>
            </li>
            </ul>  
            <div class="clear"></div>
       </a> 
        </li>
     </c:forEach>
        </ul>
        <div class="clear"></div>
      <%--   </form:form> --%>
      </div>
      
      </c:otherwise>
      </c:choose>
    </section>
  </div>
  <div id="push"></div>
</div>
<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>