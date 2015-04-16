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
<title>Imploy.Me - Search Results</title>
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
				url: "employer_sorted_candidate_listing.json",
				data : "sortedParameter="+selectedFormulaName,
				success : function(candidateResults){
					setDomElements(candidateResults);
					}
				});
			return true ;
			}
			
			
		/* 	
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
			  
			}); */

		else
		{
		  alert("Please select a Formula !!!");
		  return false;
		}
	});

		
		function setDomElements(candidateResults)
		{
			$("#form1").empty();
				$.each(candidateResults , function(key,value){
					for(var i=0;i<labels.length;i++){
						if(value.emailID == labels[i].id){
							/* $("#form1").append(labels[i]); */
							$("ul.search_listing").append(labels[i]);
						}
					}
				}); 
		}
		
	
	});

		 /* Code Added By BalajiI Ends */
		
</script>


 <script type="text/javascript">
function saveSearchFunction()
{	
		
			var searchParameterNameValue=$("#parameterNameId").val();
			var searchTrimmed=$.trim(searchParameterNameValue);
			if(searchTrimmed!="" && searchTrimmed.length!=0)
			{
				$.loader({content:"<div class='plus'> Saving Search...</div>"}); 
			  $.ajax({
				  type:"get",
				  url: "save_search.htm",
				  data:"searchName="+ searchTrimmed ,
				  error:function(xhr,error)
				  {
					
					console.log("Error");
					$.loader('close');
				  },
				  success:function(flag)
				  {
						$.loader('close');
					if(flag === true)
					{
						alert("Successfully Saved Search Name "+searchTrimmed);
					}
				  }
				});

			}
				else
				{	
						alert("Please Enter a Search Name");
						/* $("#saveSearchErrorLabel").html("");
			          	$("#saveSearchErrorLabel").html("<label class='error'>Search Name is Mandatory.</label>");
			          	 */
			          	 return false;
				}
		
}
</script>

</head>

<body class="employer">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>

    
    
  <div id="mid_wrap" class="midwrap_toppadding">
   
    <div class="clear"></div>
    <c:set var="count" scope="session" value="${count}"/>
    <section id="inner_container">
    
  <form:form id="form1"  method="post" commandName="searchCandidate" >
      <h1 class="page_heading">Search Results <span class="orange_font">(<c:out value="${count}"/>)</span>
       <!-- <li id="saveSearchErrorLabel"></li> -->
      </h1>
      
      
      <c:choose>
      <c:when test="${not empty source && source eq 'savedSearches'}">
      		
      </c:when>
      <c:otherwise>
       <div class="searchtitle">
       <a id="searchTab">
     				Add title to your search <img src="../mobile_html/images/menu.png" class="float_right">
     			</a>
     			<div class="left_searchfilter_label " style="display:none;">
               	<span class="formwrapper">
       <!-- <input type="checkbox" value="" /> Save Search Parameter -->
       				<span class="field">
                     	<input type="text" style="width:73%;" id="parameterNameId" placeholder="Save Parameter Name" name="parameterName"/>
                    	<input type="button" value="Save Search" class="orangebuttons float_right" onclick="saveSearchFunction()" style="width:auto;margin-top:38px;"/>
                 <!--   <input name="" type="button" value="Save Parameter Name" class="orangebuttons float_right" style="width:auto;margin-top:-54px;"  />  -->
                   </span>
                </span>
           </div>
     			</div>
      
      </c:otherwise>
      </c:choose>
      
   <%--    <c:if test=${not empty source && source eq 'savedSearches'}>
      
     			</c:if> --%>
     			
		<c:choose>
			<c:when test="${count == 0}">
				<div class="error_message_span validationnote">No results Found</div>
			</c:when>
			<c:otherwise>
				
			 
                  
                   <div class="details floatleft">
                 <span class="formwrapper floatleft">
                   <select name="formula_Name" id="formula_Name">
                     <option value="Change">Select Formula to filter</option>
                     <c:forEach var="formulaName" items="${sortParameters}">
                      <option value="${formulaName}"><c:out value="${formulaName}"/></option>
                     </c:forEach>
                   </select>
                </span>
                  </div>
		         	      <div class="search_listing_wrap">
      
   <ul class="search_listing">
     <c:forEach var="listForCandidate" items="${studentList}"> 
        <li id="${listForCandidate.emailID}" > <a href= "detail_view_candidate.htm?studentEmailId=<c:out value="${listForCandidate.emailID}"/>">
          <c:set var="photoEmailId" value="${listForCandidate.emailID}"/>
          			<c:choose>
						<c:when test="${listForCandidate.photoName ne null}"> 
							<div class="company_logo"><img src="view_image.htm?emailId=<c:out value="${photoEmailId}"/>">&nbsp;</div>
						</c:when>
						<c:otherwise>
                      		<div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""> &nbsp;</div> 
                      	</c:otherwise>
                   </c:choose>
         <h1 class="heading"><c:out value="${listForCandidate.firstName}"></c:out>   <c:out value="${listForCandidate.lastName}"></c:out></h1>
            <h2 class="subheading"><c:out value="${listForCandidate.courseName}"></c:out>,<c:out value="${listForCandidate.city}"></c:out> </h2>
            <div class="jobtype"><span class="postedon"><c:out value="${listForCandidate.universityName}"></c:out></span>  <span><%-- <c:out value="${listForCandidate.yearOfPassing}"/> --%></span><%--  GPA <c:out value="${listForCandidate.g_from_gpa}"/>/<c:out value="${listForCandidate.g_to_gpa}"/> --%></div>
           
           <div class="floatright" id="iScore">I Score :<span class="postedon"><c:out value="${listForCandidate.iScore}"></c:out></span></div>
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

<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
</body>
</html>