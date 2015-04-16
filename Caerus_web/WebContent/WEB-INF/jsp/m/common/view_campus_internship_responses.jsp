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
<!--[if gt IE 9]><!--><!--<![endif]-->
<html class="no-js" lang="en">


<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy.Me - Campus Job Responses</title>
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
<link rel="stylesheet" href="../mobile_html/css/plus.css">
<link rel="stylesheet" href="../css/jquery-loader.css" type="text/css"/>
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-loader.js"></script>
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

<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
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
		$(document).ready(function(){

		 /* Code Added by BalajiI  Starts */

		/** Fetching all the lis on the page */	
		var labels=$("ul.search_listing").find('li');

	/* 	$(".candidateStatus").click(function()
		{
			var clickedStatus = $(this).text();
			var statusArray = clickedStatus.split("(");
			clickedStatus = statusArray[0].trim();
			
			$("tr.bg").each(function(index){

				var pageStatus = $(this).find('.candidate_status').text().trim();

					if(clickedStatus =="All")
					{
						$(this).show();
					}
					else
					{
						if(pageStatus != clickedStatus)
							$(this).hide();
						else
							$(this).show();
					}
				});
		}); */
		
	$("#formula_Name").change(function ()
	{
		var selectedFormulaName = $(this).val();
		if (selectedFormulaName.trim())
		{	
		  	//$.loader({content:"<div class='dots'> Loading...</div>"}); 

			var emailIds = "";
			for(var i=0;i<labels.length;i++)
			{
				emailIds = emailIds.concat("'").concat(labels[i].id).concat("',");
			}
			$.loader({content:"<div class='plus'> Applying Formula...</div>"}); 
		  $.ajax({
			  type: "POST",
			  url: "generate_score_from_search_listing.htm",
			  data:"formulaName="+ selectedFormulaName +"&candidateEmailIds="+emailIds,
			  error:function(xhr,error)
			  {
				for(var i=0;i<labels.length;i++){
					$("ul.search_listing").append(labels[i]);
				}


				$.loader('close');
				console.log("Error");
			  },
			  success:function(candidateScores)
			  {
				  $("ul.search_listing").empty();
				$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
				setDomElements(candidateScores);
				$.loader('close');
			  }
			  
			});

			return true ;
		}
		else
		{
		  alert("Please select a Formula !!!");
		  return false;
		}
	});

		function setDomElements(candidateScore)
		{
				$.each(candidateScore , function(key,value)
				{
					for(var i=0;i<labels.length;i++)
					{
						if(key == labels[i].id)
						{
							/** Replacing @ and . to escape jquery selectors */
						    key=key.replace("@","\\@");
						    key=key.replace(".","\\.");
	
							/** Appending the Stored Lis*/
							$("ul.search_listing").append(labels[i]);
	
							/** Appending Iscore Value */
							$("li#"+key).find("div#iScore").empty().append("I Score: "+value);
						}
				  }
					
			  }); 
		}
	
	});

		 /* Code Added By BalajiI Ends */
		
</script>



</head>

<body class="employer">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>

    
    
  <div id="mid_wrap" class="midwrap_toppadding">
   
    <div class="clear"></div>
    <c:set var="count" scope="session" value="${totalStudentsCount}"/>
    <section id="inner_container">
    
  <form:form id="form1"  method="post" commandName="searchCandidate">
      <h1 class="page_heading">Responses <span class="orange_font">(<c:out value="${totalStudentsCount}"/>)</span>
       
       </h1>
      
        
       
      
      		
		<c:choose>
			<c:when test="${totalStudentsCount == 0}">
				<div class="error_message_span validationnote">No results Found</div>
			</c:when>
			<c:otherwise>
			      <div class="search_listing_wrap">
      
   <ul class="search_listing">
   
     <c:forEach var="candidateDetails" items="${appliedStudentDetails}"> 
    <%--  <c:forEach var="candidateDetails" items="${searchCandidateByEmail}">  --%>
        <li id="${candidateDetails.emailID}" > <a href= "detail_view_candidate.htm?studentEmailId=<c:out value="${candidateDetails.emailID}"/>">
          <c:set var="photoEmailId" value="${candidateDetails.emailID}"/>
          			<c:choose>
						<c:when test="${candidateDetails.photoName ne null}"> 
							<div class="company_logo"><img src="view_image.htm?emailId=<c:out value="${photoEmailId}"/>"></div>
						</c:when>
						<c:otherwise>
                      		<div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
                      	</c:otherwise>
                   </c:choose>
         <h1 class="heading"><c:out value="${candidateDetails.firstName}"></c:out></span>   <span><c:out value="${candidateDetails.lastName}"></c:out></h1>
            <h2 class="subheading"><c:out value="${candidateDetails.universityDetails.universityCourseName}"></c:out></span>,<span><c:out value="${candidateDetails.city}"></c:out> </h2>
            <div class="jobtype"><span class="postedon"><c:out value="${candidateDetails.universityDetails.universityName}"></c:out></span> 
             <span>GPA <c:out value="${candidateDetails.universityDetails.universityGpaFrom}"/> of <c:out value="${candidateDetails.universityDetails.universityGpaTo}"/></div>
           
           <div class="floatright" id="iScore">I Score :<span class="postedon"><c:out value="${candidateDetails.IScore}"></c:out></span></div>
            </a> 
            
        </li>
     </c:forEach>
  
        </ul>
        <div class="clear"></div>
      </div>
			</c:otherwise>
	</c:choose>
      
 </form:form>
      
    </section>
    
        
  </div>
  <div id="push"></div>
</div>
<%-- <%@ include file="includes/footer.jsp"%> --%>
</body>
</html>