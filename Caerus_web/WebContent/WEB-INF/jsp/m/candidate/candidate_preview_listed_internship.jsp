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
        <title>View Internship</title>
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
function applyCondition()
{
	 $("#msg").show();
}

function saveCondition()
{
	 $("#msg").show();
}

function goBack()
{
	window.history.back();
}

function applySavedInternship()
{
	
	var internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_saved_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId,
		},	
		
		success : function(data) {
			if(data.exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Applied Successfully");
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 

}

function applyInternship()
{
	
var internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId,
		},	
		
		success : function(data) {
			if(data.exceptionOccured == true)
			{
				window.location = 'candidate_portfolio.htm?errorMsg='+true;
			}

			else
			{ 
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Applied Successfully");
			    
			}
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function saveInternship()
{
	var internshipId = $("#internship_id_and_firm_id").val();
	
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_save_internship.json',						
		cache : false,
		data : 
		{
			internshipId: internshipId,
		},	
		
		success : function(data) {
			
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Saved Successfully");
			    
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}


</script>

<script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen" charset="utf-8">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

 <body class="student">



      <div id="main_wrap">
    <%@ include file="includes/header.jsp"%>	

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
          <div class = "error_msg" id = "msg" style="display:none"> Login to Apply for a Job / Register if not a member. </div>
      <div class="jobdetail_wrap">
			<div class="jobdetails">
            	<div class="company_logo float_left">
				<a href="profile_preview.htm?companyName=${companyDetails.companyName}">
				<img src="view_image.htm?emailId=${internship.emailId}"></a>
				</div>
				<input type="hidden" id="internship_id_and_firm_id" value="${internship.internshipIdAndFirmId}" />
            	<div class="details float_left">
                	 <h1 class="heading"><c:out value="${internship.internshipTitle}"/></h1>
					 <h2 class="subheading"><c:out value="${internship.companyName}"/>,<c:out value="${internship.location}"/></h2>
                     <fmt:parseDate value="${internship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
                     <div class="jobtype"><c:out value="${internship.internshipType}"/>, <span class="postedon">Posted on<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" />
                     </span>
                   </div>  
                   </div>              
            	<div class="applybtn_wrap float_right">
                	 <form>
                  
                  <c:choose>
                  
                  <c:when test="${role!='ANONYMOUS'}">
                   <c:choose>
                  <c:when test="${appliedInternshipIdsMap.containsKey(param.internshipId)}">
                  <input name="Back" type="button" value="Back" class="orangebuttons" onclick="goBack()">
                  </c:when>
                   <c:when test="${savedInternshipIdsMap.containsKey(param.internshipId)}">
                  <input name="" type="button" value="Apply" onclick="applySavedInternship()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:when>
                <c:otherwise>
                 <input name="" type="button" value="Save" onclick="saveInternship()" class="orangebuttons" >
                  <input name="" type="button" value="Apply" onclick="applyInternship()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:otherwise>
                  </c:choose>
                    </c:when>
                    
                    <c:otherwise>
                    <c:choose>
                  <c:when test="${appliedInternshipIdsMap.containsKey(param.internshipId)}">
                  <input name="Back" type="button" value="Back" class="orangebuttons" onclick="goBack()">
                  </c:when>
                   <c:when test="${savedInternshipIdsMap.containsKey(param.internshipId)}">
                  <input name="" type="button" value="Apply" onclick="applyCondition()" >
                  <input name="" type="button" value="Back" onclick="goBack()">
                </c:when>
                <c:otherwise>
                 <input name="" type="button" value="Save" onclick="saveCondition()" class="orangebuttons">
                  <input name="" type="button" value="Apply" onclick="applyCondition()" class="orangebuttons">
                  <input name="" type="button" value="Back" onclick="goBack()" class="orangebuttons">
                </c:otherwise>
                  </c:choose>
                    </c:otherwise>
                    
                  </c:choose>
                   </form>
                </div>                                
            
              </div>
            <div class="clear"></div>
            <div id="successMessageSpan"></div>
             <h1 class="jobdescp_title orange_font">Internship Description</h1>
<div class="jobdescp_para_wrap"><p class="jobdescp_para"><c:out value="${internship.internshipDescription}"/></p>
<p class="jobdescp_para"></p></div>
            <div id="accordion-container">
    <h2 class="accordion-header">Skills</h2>
    <div class="accordion-content">
    <ul class="keyskillslist">
                        <c:forEach items="${internship.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li>
                        </c:forEach>
                        <c:forEach items="${internship.secondarySkills}" var="secondarySkills">
                        <li><c:out value="${secondarySkills}"/></li>
                        </c:forEach>
                         </ul>
<div class="clear"></div>

    </div>
    <h2 class="accordion-header">View Contact Detail</h2>
    <div class="accordion-content">
    
   <%--  <c:forEach items="${companyDetails}" var="companyDetails">
         			<c:set var="companyId" value="${companyDetails.emailID}"/> --%>
         			  
   <p><span class="orange_font boldtxt">Company Name:</span><c:out value="${companyDetails.companyName}"/> <br/>
<span class="orange_font">Name:</span> <c:out value="${companyDetails.contactPersonName}"/><br/>
<span class="orange_font">Phone:</span> ${companyDetails.phoneNumber}<br/>
<span class="orange_font">Email Address:</span> <c:out value="${internship.emailId}"/>
<span class="orange_font">Email Address:</span> <address>
<c:out value="${companyDetails.addressLine1}"/>, <c:out value="${companyDetails.city}"/>, <c:out value="${companyDetails.state}"/>, 
<c:out value="${companyDetails.country}"/> - <c:out value="${companyDetails.postalCode}"/></address>
<%-- </c:forEach> --%>
    
    
  
 

</div>
    </div>
   
    
  
      </div>
    </section>
  </div>
     <div id="push"></div>  
</div>

 <%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>