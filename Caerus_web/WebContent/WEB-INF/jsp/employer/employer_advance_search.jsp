<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="keywords" content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
<title>Employer Advanced Search</title>
<meta name="description" content="">
<meta name="author" content="">
<!--[if lt IE 7]>
	<style type="text/css">
		#wrap { height:100%; }
   </style>
<![endif]-->

<!--[if gte IE 9]>
  <style type="text/css">
    .gradient {
       filter: none;
    }
  </style>
<![endif]-->
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jqcloud.css" type="text/css" />

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>

<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>
<script type="text/javascript" src="js/jqcloud-1.0.4.min.js"></script>
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery-loader.js"></script>
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:82.5% !important;}
ul.recent_activities_wrap li{background-image:none;}
div.jqcloud span.vertical {
        -webkit-writing-mode: vertical-rl;
        writing-mode: tb-rl;
      }
      .stdform div.par{margin-bottom:0;}
</style>
<script type="text/javascript">
  $(function()
  {
      $('#wysiwyg1').wysiwyg({
    	controls: {
    		increaseFontSize   : { visible : true },
     		decreaseFontSize  : { visible : true }
    			}
  		});
	  $('#wysiwyg2').wysiwyg({
    	controls: {
    		increaseFontSize   : { visible : true },
     		decreaseFontSize  : { visible : true }
    			}
  		});
  });
</script>

<script type="text/javascript">
function backButtonFunction()
{
window.history.back();
}
</script>

<!--@author BalajiI -->
<script type="text/javascript">
 $(function(){
    $("#saveSearch").submit(function(){
        var valid=0;

        if($("#state").val() != null || $("#universityName").val() != null || $("#city").val() != "" || $("#keywords").val() != "")
        {
           valid+=1;
        }
       
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
 
<script type="text/javascript">
function getCandidates(elementId)
{
	var formId = $('#' + elementId).parents('form').attr('id');
	$("#"+formId).submit();
}	
</script>
<script type="text/javascript">

$(document).ready(function(){

	$("#keywords").on('change keyup paste',function(){
		 if($("#keywords").val().trim().length > 0)
			suggestKeywords();
	}); 
	
	var popularJobs = new Array();
	popularJobs = $("#popularJobs").val();
	popularJobs = popularJobs.replace("[","").replace("]","");
	var popularJobsArray = popularJobs.split(",");
	var word_list = [];
	var weightValue = 20;

	for (var i = 0; i < popularJobsArray.length; i++) {

		if(i < 3 || i % 3 != 0)
		  word_list.push({text: popularJobsArray[i], weight: weightValue});
		else
			 word_list.push({text: popularJobsArray[i], weight: weightValue, html: {"class": "vertical"}});
		 
		  weightValue--;
	}
	$(function() {
        $("#otherSearches").jQCloud(word_list);
      });

});

function suggestKeywords(){

	var enteredText=$("#keywords").val();
	$.getJSON( "/get_employer_keywords_suggestions.json",'enteredText='+enteredText, function( returnedWords ) {
		
	 var returned=[];
		returned=returnedWords;
		   $( "#keywords" ).autocomplete({
	         source: returned,
	 	 focus: function( event, ui ) {
	        	 
	        	 var displayProperty=$("#ui-id-1").css("display");
	             if(displayProperty=="block"){
	            	 $.fn.fullpage.setKeyboardScrolling(false);
	            	 $.fn.fullpage.setAllowScrolling(false);
	             }
	            },
	            close: function( event, ui ) {
	                
	                var displayProperty=$("#ui-id-1").css("display");
	                  if(displayProperty=="none"){
	                   $.fn.fullpage.setKeyboardScrolling(false);
	                   $.fn.fullpage.setAllowScrolling(true);
	                  } 
	                
	                 }
	       }); 

	   //Hide message shown after search is retrieved (Eg. 3 results match your search, use mouse keys)
	   $("span.ui-helper-hidden-accessible").hide();

	 	   
	   $( "#keywords" ).on( "autocompletefocus", function( event, ui ) {} );
	   $( "#keywords" ).on( "autocompleteclose", function( event, ui ) {} ); 
		 });

}

 $(document).on('click', '#otherSearches span', function () {
	$("#popularJobForm").remove();
	
	var id = this.id;

    var jobTitle = $('#'+id).text();

    $("#formDiv").append('<form action="employer_search_candidate.htm" method="post" id="popularJobForm">'+
    	    '<input type="hidden" id="hiddenKeyword" name="keyword">');

    $("#hiddenKeyword").val(jobTitle);

	$("#popularJobForm").submit();

}); 
</script>
</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
 
    <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
    
    
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ Advanced Search</div> -->
      
      <section id="rightwrap" class="floatleft">
        
       
	  <div id="formDiv"></div>
	  
        <div id="candidate_registration_wrap">
        <div class="whitebackground floatleft" style="width:64.5%;">
        <h1 class="sectionheading"> Advanced Search</h1>
          <div class="form_wrap">
            <form:form class="stdform" action="" method="post" modelAttribute="jobDetailsCom" id="saveSearch">
              
             <span id="searchErrorLabel">
        	 </span>
              <div class="padding_bottom">  
              <div class="leftsection_form" style="width:auto;">
               <div class="par">             
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
                      <form:input path="keyword" class="input-medium" id="keywords"/>
                      <form:errors path="keyword"  class="input-medium"/>
                  </span> 
                 </div>
                 
                  <div class="par">
                  <label class="floatleft">State</label>
                  <div class="clear"></div>
                  <span class="field">
                      <form:select path="state" multiple="multiple" cssClass="chzn-select input-medium" id="state">
                 		<form:options items="${stateList}" />                    
                     </form:select>&nbsp; &nbsp;
                  </span> 
                  </div>
                  </div>
                  <div class="rightsection_form" style="width:auto;">
                    <div class="par">
                  <label class="floatleft">University</label>
                  <div class="clear"></div>
                  <span class="field">
                  <form:select path="universityName" multiple="multiple" cssClass="chzn-select input-medium" id="universityName">
                            				     
                        					<form:options items="${universityList}" />                    
                        				</form:select>&nbsp; &nbsp;
                        				</span>
                        				</div>
                 
                
                        				<div class="par">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                  <span class="field">
                  <form:input path="location" class="input-medium" id="city"/>
                      </span>
                        		&nbsp; &nbsp;	
                        		</div>
                        		 </div>
                        		  <div class="clear"></div>
                        		<div class="floatleft">	
                    <input name="" type="submit" value="Search">
            </div>
              <div class="clear"></div>
                  </div>
             </form:form>
          </div>
          </div>
          
			         <div class=" floatright" style="width: 32%">
			         <c:choose>
          			<c:when test="${not empty recentSearches}">
			         <div class="floatleft doublebottom_margin whitebackground"  style="height: 236px;width:95%;">
			        
	                <h1 class="sectionheading"> YOUR RECENT SEARCHES </h1>
	               <div class="floatleft job_listing_wrap">
			           <ul class="keyskillslist"> <!-- class="tagslists" !-->
			           <c:forEach items="${recentSearches}" var="recentSearch" varStatus="status"> 
			            
			          			<li> <form action="employer_search_candidate.htm" method="post" id="recentSearchForm${status.index}"> 
			       				 <a onclick="getCandidates(this.id)" id="recentSearch${status.index}"><c:out value="${recentSearch.key}"/></a>
			       				 <input type="hidden" value="${recentSearch.key}" name="keyword">
			       				 <c:if test="${recentSearch.value != 0}">
			       				 - (<c:out value="${recentSearch.value}" />) <!-- New Result(s) -->
			       				 </c:if>
			        			 </form>
			        			 </li> 
						</c:forEach>
						</ul>
       				 </div>
			         </div>
			        
			         </c:when>
			         <c:otherwise>
			         <div class="floatleft doublebottom_margin whitebackground"  style="height: 236px;width:95%;">
			        
	                <h1 class="sectionheading"> YOUR RECENT SEARCHES </h1>
	                No recent searches
	                </div>
			         </c:otherwise>
			         </c:choose>
			         <c:choose>
			          <c:when test="${savedSearchSize != 0}"> 
			          <div class=" floatleft whitebackground" style="min-height: 50px; width:95%;">
			       <a href="employer_saved_searches.htm" class="floatleft clear width100" style="font-size:30px;padding-top:10px;"> Saved Searches (${savedSearchSize})</a>
			       </div>
			        </c:when> 
			        <c:otherwise>
			         <div class=" floatleft whitebackground" style="min-height: 50px; width:95%;">
			        <p class="floatleft clear width100" style="font-size:30px;padding-top:10px;"> Saved Searches (${savedSearchSize})</p>
			        </div>
			        </c:otherwise>
			        </c:choose>
			       
			       </div> 
			         <div class="clear"></div>
          
         <div class="padding_bottom doublebottom_margin width100 floatleft">
         <c:choose>
         <c:when test="${not empty visitedProfilesMap}">
           <div class="smallsection_wrap floatleft doubleright_margin whitebackground margin_top2" style="width:30%; min-height:461px;">
                <h1 class="sectionheading"> RECENTLY VISITED PROFILES </h1>
			         <ul class="recent_activities_wrap">
			         <c:forEach items="${visitedProfilesMap}" var="candidateDetails" varStatus="status">
			         <c:if test="${status.index < 5}">
			         <li>
			      	   <c:choose>
			      	   <c:when test="${candidateDetails.photoName == null}">
			      	   <img alt="Employer Image" src="images/Not_available_icon1.png" title="${candidateDetails.firstName} ${candidateDetails.lastName}" style="height:50px;width:50px;float:left;margin-right: 1em;">
			      	   </c:when>
			      	   <c:otherwise>
			      	   <img alt="Employer Image" src="view_image.htm?emailId=<c:out value="${candidateDetails.emailID}"></c:out>" style="height:50px;width:50px;float:left;margin-right: 1em;" title="${candidateDetails.firstName} ${candidateDetails.lastName}">
			      	   </c:otherwise>
			      	   </c:choose>
			         	<p><a href="detail_view_candidate.htm?studentEmailId=${candidateDetails.emailID}">
			         	<c:out value="${candidateDetails.firstName} ${candidateDetails.lastName}" /><br> 
			         	<c:out value="${candidateDetails.profileName}" /></a></p>
			       </li>
			       </c:if>
			         </c:forEach>
			         </ul>
			         
			</div>
			</c:when>
			<c:otherwise>
			<div class="smallsection_wrap floatleft doubleright_margin whitebackground margin_top2" style="width:30%; height:461px;">
                <h1 class="sectionheading"> RECENTLY VISITED PROFILES </h1>
			No profiles visited
			</div>
			</c:otherwise>
			</c:choose>
			
			<c:choose>
			 <c:when test="${not empty candidateDetails}">
			        <div class="smallsection_wrap floatleft doubleright_margin whitebackground margin_top2" style="width:31%; min-height:461px;">
			        
			     	   <h1 class="sectionheading"> TRENDING PROFILES IN INDUSTRY</h1>
			     	    <ul class="recent_activities_wrap">
			      	   <c:forEach items="${candidateDetails}" var="candidateDetails" varStatus="status">
			      	   <c:if test="${status.index < 5}">
			      	   <li>
			      	   <c:choose>
			      	   <c:when test="${candidateDetails.photoName == null}">
			      	   <img alt="Employer Image" src="images/Not_available_icon1.png" title="${candidateDetails.firstName} ${candidateDetails.lastName}" style="height:50px;width:50px;float:left;" >
			      	   </c:when>
			      	   <c:otherwise>
			      	   <img alt="Employer Image" src="view_image.htm?emailId=<c:out value="${candidateDetails.emailID}"></c:out>" style="height:50px;width:50px;float:left;" title="${candidateDetails.firstName} ${candidateDetails.lastName}">
			      	   </c:otherwise>
			      	   </c:choose>
				    	<p><a href="detail_view_candidate.htm?studentEmailId=${candidateDetails.emailID}"><c:out value="${candidateDetails.firstName} ${candidateDetails.lastName}" /><br><c:out value="${candidateDetails.profileName}"/></a></p>
			   		 </li>
			      	   </c:if>
			      	   </c:forEach>
			      	   </ul>
			      	  
			      	   </div>
	      	   </c:when>
	      	   <c:otherwise>
	      	  	 <div class="smallsection_wrap floatleft doubleright_margin whitebackground margin_top2" style="width:31%; height:461px;">
			        
			     	   <h1 class="sectionheading"> TRENDING PROFILES IN INDUSTRY</h1>
			     	   No data Available
			     	   </div> 
	      	   </c:otherwise>
	      	   </c:choose>
	      	   
	      	   <c:choose>
			        <c:when test="${not empty popularJobs}">
			        <div class="floatleft whitebackground margin_top2" style="width:30.2%; min-height:461px;">
			       
              	    <h1 class="sectionheading"> WHAT OTHERS ARE SEARCHING </h1>
			        <div id="otherSearches" style="width: 380px; height: 395px; border: 1px solid #ccc;"></div>
			        <input type="hidden" value="${popularJobs}" id="popularJobs" />
			         
			         </div>
			         </c:when>
			         <c:otherwise>
			         <div class="floatleft whitebackground margin_top2" style="width:30.2%;height:461px;">
			       
              	    <h1 class="sectionheading"> WHAT OTHERS ARE SEARCHING </h1>
	      	  			 No profiles visited
	      	  			 </div>
	      	  		 </c:otherwise>
			   </c:choose>
			        </div>
			         <div class="clear"></div>
			        
        </div>
      </section>
      <div class="clear"></div>
    </div>
    <div class="bottomspace">&nbsp;</div>
  </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>
</body>
</html>