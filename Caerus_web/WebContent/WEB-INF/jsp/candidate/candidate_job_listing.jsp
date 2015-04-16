<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
  <title>Candidate Manage Responses</title>
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
  <link rel="stylesheet" href="css/dashboard.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
  <link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />
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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
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

	function scrollToAnchor(aid){
	    var aTag = $("a[name='"+ aid +"']");
	    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
	}

	/* $("#virtualevent").click(function() {
	   scrollToAnchor('event');
	}); */

	$("#virtualevent").click(function() {
		   scrollToAnchor('jobFair');
		});
	


</script>
  
  
  <!--changes 28-06-2013-->          
  <script>
  
  $(document).ready(function() {

	  $('#functionalAreaPopOver').webuiPopover({
	         constrains: 'horizontal', 
	         trigger:'click',
	         multi: true,
	         placement:'right-bottom',
	         width:675,
	         closeable:true,
	         content: $('#demo2_tip1').html()
	 	});

		 $('#industryPopOver').webuiPopover({
	         constrains: 'horizontal', 
	         trigger:'click',
	         multi: true,
	         placement:'right-bottom',
	         width:675,
	         closeable:true,
	         content: $('#demo2_tip2').html()
	 	});

		 $('#locationPopOver').webuiPopover({
	         constrains: 'horizontal', 
	         trigger:'click',
	         multi: true,
	         placement:'right-bottom',
	         width:675,
	         closeable:true,
	         content: $('#demo2_tip3').html()
	 	});

		 $('#jobTypePopOver').webuiPopover({
	         constrains: 'horizontal', 
	         trigger:'click',
	         multi: true,
	         placement:'right-bottom',
	         width:675,
	         closeable:true,
	         content: $('#demo2_tip4').html()
	 	});

	 var resultCountMap = $("#resultCountMap").val();

	if(null == resultCountMap || resultCountMap == '0')
	{
		$("body").removeClass("dashboard");
		$("#leftsection").hide();
	}
	  
    var showChar = 360;
    var ellipsestext = "...";
    var moretext = "READ MORE";
    var lesstext = "COLLAPSE";
    $('.more').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar) {
 
            var c = content.substr(0, showChar);
            var h = content.substr(showChar-1, content.length - showChar);
 
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
 
            $(this).html(html);
        }
 
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
});
  </script>
  
  	<!--changes 28-06-2013-->
  	
  	<script type="text/javascript" src="js/jquery.pajinate.js"></script>
		<script type="text/javascript">

    		$(document).ready(function(){
				$('.paging_container8').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
			});     

		</script>
		
	<!-- Added by TrishnaR to display modify search div(22/05/2014) -->	
	<script type="text/javascript">  
	$(document).ready(function(){
		$("#modifySearch").click(function(){
		    $("div#modifySearchDiv").show();
		  });

	$("#keywords").on('change keyup paste',function(){
		suggestKeywords();
	}); 
	});
	</script>
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:38.5% !important;}
</style>


<script type="text/javascript">

$(document).ready(function() {
	
	$(".saveInternship").click(function() {

var successFlag=false;
var internshipId = $(this).attr('id');

	 $.ajax({	 
			url : 'candidate_save_internship.json',						
			cache : false,
			async : false,
			data : 
			{
				internshipId: internshipId
			},	
		success:function(data)
		{
			
			//Make the button look blue
			successFlag=true;	
		
			//$(this).parent().find('.saveactive').show();
		},
		error:function(xhr,error)
		{
			console.log("Error in bookmarkJob");
		}
	});
		if(successFlag) {
			
				$("#successMessageSpan").empty();
				$("#successMessageSpan").append("Internship Saved Successfully");
		    
			      $("#appliedJobModal").dialog({
			          
			            modal: true,
			            open: function(event, ui){
			                setTimeout("$('#appliedJobModal').dialog('close')",2500);
			            }
		 			});
		      
	 		 $(this).find("img.bookmark").attr("src", "images/saved_active_icn.png");
	  		 $(this).find("img.bookmark").attr("title", "Already Saved");
		}	
	});

	
	$(".saveJob").click(function() {

		var successFlag=false;
		var jobId = $(this).attr('id');

			 $.ajax({	 
					url : 'candidate_save_job.json',						
					cache : false,
					async : false,
					data : 
					{
						jobId: jobId
					},	
				success:function(data)
				{
					
					//Make the button look blue
					successFlag=true;	
				
					//$(this).parent().find('.saveactive').show();
				},
				error:function(xhr,error)
				{
					console.log("Error in bookmarkJob");
				}
			});
				if(successFlag) {
					
						$("#successMessageSpan").empty();
						$("#successMessageSpan").append("Job Saved Successfully");
				    
					      $("#appliedJobModal").dialog({
					          
					            modal: true,
					            open: function(event, ui){
					                setTimeout("$('#appliedJobModal').dialog('close')",2500);
					            }
				 			});
				      
			 		 $(this).find("img.bookmark").attr("src", "images/saved_active_icn.png");
			  		 $(this).find("img.bookmark").attr("title", "Already Saved");
				}	
			});

	

	function scrollToAnchor(aid){
	    var aTag = $("a[name='"+ aid +"']");
	    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
	}

	/* $("#virtualevent").click(function() {
	   scrollToAnchor('event');
	}); */

	$("#virtualevent").click(function() {
		   scrollToAnchor('jobFair');
		});
	
});

</script>


<script type="text/javascript">
function getJobs(elementId)
{
	var formId = $('#' + elementId).parents('form').attr('id');
	$("#"+formId).submit();
}

function suggestKeywords(){

	var enteredText=$("#keywords").val();
	$.getJSON( "/get_suggested_keywords.json",'enteredText='+enteredText, function( returnedWords ) {
  /* alert("returnedWords"+returnedWords); */
	 var returned=[];
		returned=returnedWords;
		   $( "#keywords" ).autocomplete({
	         source: returned,
	 	 focus: function( event, ui ) {
	        	 
	        	 var displayProperty=$("#ui-id-2").css("display");
	             if(displayProperty=="block"){
	            	 $.fn.fullpage.setKeyboardScrolling(false);
	            	 $.fn.fullpage.setAllowScrolling(false);
	             }
	            },
	            close: function( event, ui ) {
	                
	                var displayProperty=$("#ui-id-2").css("display");
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

</script>
<script type="text/javascript">
	$(document).ready(function(){
   var searchCriterion = '${criteria}';
   if(searchCriterion=='Internships')
	   showhideFaculty('internships');
	});

function showhideFaculty(faculty_type) {
    
	 if (faculty_type == "internships") {
		 document.getElementById("industry").style.display = 'none';
    } else {
		 document.getElementById("industry").style.display = 'block';
    }
	
}
</script>
	
	<script type ="text/javascript">
	$(function(){
	    $("#advancedSearch").submit(function(){
	
	        var valid=0;
	        
	        $(this).find('input[type=text], select').each(function(){
	            if($(this).val() != "") valid+=1;
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
	
	<script>
	function goBack()
	{
	  window.history.back();
	}


	
	function applyJob(jobId)
	{	
		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_apply_job.json',						
			cache : false,
			data : 
			{
				jobId: jobId,
			},	
			
			success : function(exceptionOccured) {
				if(exceptionOccured == true)
				{
					window.location = 'candidate_portfolio.htm?errorMsg=true';
				}

				else
				{ 
					$("#successMessageSpan").empty();
					$("#successMessageSpan").append("Job Applied Successfully");
				    
				      $("#appliedJobModal").dialog({
				          
				            modal: true,
				            open: function(event, ui){
				                setTimeout("$('#appliedJobModal').dialog('close')",2500);
				            }
			 			});
					
					//timeoutfunction();
						location.reload(); 
				}
				
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
			}); 
	}

	
	function applyInternship(internshipId)
	{	
		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_apply_internship.json',						
			cache : false,
			data : 
			{
				internshipId: internshipId,
			},	
			
			success : function(exceptionOccured) {
				if(exceptionOccured == true)
				{
					window.location = 'candidate_portfolio.htm?errorMsg='+true;
				}

				else
				{ 
					$("#successMessageSpan").empty();
					$("#successMessageSpan").append("Internship Applied Successfully");
				    
				      $("#appliedJobModal").dialog({
				          
				            modal: true,
				            open: function(event, ui){
				                setTimeout("$('#appliedJobModal').dialog('close')",2500);
				            }
			 			});
					
					//timeoutfunction();
						location.reload(); 
				}
				
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
			}); 
	}

	
	function timeoutfunction()
	{
		setTimeout(function(){
			window.location.reload();
			}, 3000);
	} 
	</script>
<style type="text/css">
.details form{margin-bottom:10px;"}
</style>
</head>
<body class="dashboard">

 <c:set var="role" value="${role}"></c:set>
  
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->

  <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
   <div id="innerbanner">
      <div id="banner">
      <img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
   
    <div id="innersection">
    
    <input type="hidden" id="resultCountMap" value="${fn:length(resultCountMap)}"> 
  <section id="leftsection" class="floatleft">
      <%@ include file="includes/browse_jobs.jsp"%>
       </section>
    
	   <section id="rightwrap" class="floatleft">
	<%--    <c:if test="${role!='ANONYMOUS'}"> 
        <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_search_jobs_internships.htm">Search Jobs</a> \ Advanced Search</div>
 
      </c:if> --%>
	   
        <h1 class="sectionheading"> Advanced Search Results <span>(${count})</span> 
    
  <input name="" type="button" value="Modify Search" id="modifySearch" class="floatright"></h1>
             <span>You have searched for
       <c:if test="${not empty searchParametersMap}">
       <c:forEach var="searchParametersMapEntry" items="${searchParametersMap}">
       <c:out value="${searchParametersMapEntry.key}"></c:out>  
       =<b><c:out value="${searchParametersMapEntry.value}"></c:out></b> &nbsp;            
       </c:forEach>
       </c:if>
       </span>
        
        <div id="modifySearchDiv" class="form_wrap  whitebackground" style="display: none;">
           
             <%--  <form:form action="candidate_advancesearch.htm" method="post" modelAttribute="searchJobsCommand" cssClass="stdform" id="advancedSearch"> --%>
              
              <form:form action="candidate_search_jobs_internships.htm" method="post" modelAttribute="searchJobsCommand" cssClass="stdform" id="advancedSearch">
              <div class="par">
              <span id = "searchErrorLabel"></span>
              
                  <label class="floatleft" style="padding-top:0.2em"><strong>Search By:</strong> &nbsp;</label>
                <span class="formwrapper" >
              
                <c:choose>
                <c:when test="${criteria eq 'Jobs'}">
               <form:radiobutton path="searchCriteria" value="Jobs" checked = "checked"  OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; 
               </c:when>
               <c:otherwise>
               <form:radiobutton path="searchCriteria" value="Jobs" OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; 
               </c:otherwise>
               </c:choose>
               
               <c:choose>
			<c:when test="${criteria eq 'Internships'}">
							
                <form:radiobutton path="searchCriteria" value="Internships" checked="checked" OnClick="showhideFaculty('internships')" />Internships
                </c:when>
                <c:otherwise>
                <form:radiobutton path="searchCriteria" value="Internships" OnClick="showhideFaculty('internships')" />Internships
                </c:otherwise>
                </c:choose>
                
                </span>
                
              </div>
              
              <div class="leftsection_form">
                <div class="par">
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
                  <c:set var="keyName" value="keyword" />  
				  <form:input path="keyword" cssClass="input-xxlarge" id="keywords" value="${searchParametersMap[keyName]}"/>
                  <form:errors path="keyword"  cssClass="input-xxlarge"/>                
                  </span> 
               </div> 
               
                <div class="par" id="functionalarea">
               <label>Functional Area</label>
             <c:set var="keyName" value="functionalArea" />
               <form:select data-placeholder="Choose an Option" path="functionalArea" cssClass="chzn-select list_widthstyle1" style="width: 408px;"> 
              	<form:option value="">Choose an Option</form:option>
                <c:forEach var="functionalArea" items="${functionalAreaList}">
                <c:choose>
                   	<c:when test="${not empty searchParametersMap[keyName] && functionalArea eq searchParametersMap[keyName]}">
                 	<option value="<c:out value="${functionalArea}" />" selected="selected"><c:out value="${functionalArea}" /></option> 
                 	</c:when>
                 	<c:otherwise>
                         <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option> 
                     </c:otherwise>
                 </c:choose>
                </c:forEach>
               </form:select>
                </div>
               
              </div>
              
             <%--  <c:if test="${criteria eq 'Jobs'}"> --%>
               <div class="rightsection_form" >
                <div class="par" id="city">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                  <span class="field">
                  <c:set var="keyName" value="location" />  
                  <form:input path="location" cssClass="input-xxlarge" value="${searchParametersMap[keyName]}" />
                  <form:errors path="location"  cssClass="input-xxlarge"/>
                  </span> 
            	</div>
               
                <div class="par" id="industry">
                  <label class="floatleft">Industry</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                  <c:set var="keyName" value="industry" />
                  <form:select data-placeholder="Choose an Option" path = "industry"  cssClass="chzn-select list_widthstyle1"  style="width: 408px;" >
                   	<form:option value="">Choose an Option</form:option>
                    <c:forEach var="industryList" items="${industryList}">    
                   	<c:choose>
                   	<c:when test="${not empty searchParametersMap[keyName] && industryList eq searchParametersMap[keyName]}">
                   	 <option value="<c:out value="${industryList}" />" selected="selected"><c:out value="${industryList}" /></option>  
                   	</c:when>
                   	<c:otherwise>
                         <option value="<c:out value="${industryList}" />"><c:out value="${industryList}" /></option> 
                     </c:otherwise>
                     </c:choose>               
                   </c:forEach>
                  </form:select>
                  </span>
                </div>
               
                
               </div> 
            
              <div class="clear"></div>
             
               	<input name="search" type="submit" value="Search" >
 
            </form:form>
        </div> 
	<div class="clear"></div>
	<div class="clear"></div>
          <c:set var="count" scope="session" value="${count}"/>
			<c:if test="${count == 0}">
			<div class="error_message_span validationnote">No results Found</div>
			</c:if>
			
          
          <c:choose>
          
          <c:when test="${criteria=='Internships'}">
          <div class="paging_container8">
           <div class="job_listing_wrap">
            <ul class="jobslisting">        
           <!--  <div class="candidate_status orangetxt">  
           
            </div>  -->
            <c:forEach items="${searchJobs}" var="searchJobs">
          
            <c:out value="${escaped}"></c:out>
            <li>
            
                <div class="details">
                
                	<div class="jobtitle floatleft"><a href="candidate_preview_listed_internship.htm?internshipId=<c:out value="${searchJobs.internshipIdAndFirmId}"></c:out>"><c:out value="${searchJobs.internshipTitle}"/></a></div>
                    <div class="floatright jobtype"><c:out value="${searchJobs.internshipType}"/></div>
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">
                 <%--    <a href="candidate_view_employer_profile.htm?employerName=<c:out value="${searchJobs.companyName}">
                    </c:out>"><c:out value="${searchJobs.companyName}"/></a>
                     --%>
                        <a href="profile_preview.htm?companyName=<c:out value="${searchJobs.companyName}"></c:out>">
                    <c:out value="${searchJobs.companyName}"/></a>
                    
                    
                    </span>, <c:out value="${searchJobs.location}"/></div>
                    <div class="description comment more"><c:out value="${searchJobs.internshipDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        
                        <c:forEach items="${searchJobs.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li>
                        </c:forEach>
                        
                      </ul></td>	
                  </tr>
                  </table>
                </div>
                
              <div class="actionsbtns">
                   <div class="date"> 
                  <fmt:parseDate value="${searchJobs.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="d"/> <br/> 
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/> </div>

  				<c:choose>
				  <c:when test="${role!='ANONYMOUS'}"> 
				  	  <c:choose>
				  
				        <c:when test="${ savedInternshipIdsMap.containsKey(searchJobs.internshipIdAndFirmId) }">
	             
	              <div class="buttonwrap savediv">
		              <img src="images/saved_active_icn.png" alt="Save Internship">
	                  <br/>Already Saved
                    </div>
	        
	             </c:when>
	             <c:otherwise>
	             <a class ="saveanchor saveInternship" id="${searchJobs.internshipIdAndFirmId}" >
	           
	              <div class="buttonwrap savediv">
	             	 <img src="images/saved_icn.png" alt="Save Internship" class="bookmark" />
                    <br/>Save 
                    </div>
                    </a>
	             </c:otherwise>
	          
                    </c:choose>
			        <a onclick="applyInternship('${searchJobs.internshipIdAndFirmId}')">
                    <div class="buttonwrap"><img src="images/correct_icn.png" alt="Apply Internship"> <br/>Apply</div></a> 
                    </c:when>
                    <c:otherwise>
                     <a href="candidate_registration.htm?msg=Please Register On Imploy.me to save this internship">
                    <div class="buttonwrap"><img src="images/saved_icn.png" alt="Save Internship"> <br/>Save </div></a>
                     <a href="candidate_registration.htm?msg=Please Register On Imploy.me to apply to this internship">
                    <div class="buttonwrap"><img src="images/correct_icn.png" alt="Apply Internship"> <br/>Apply</div></a>
                    </c:otherwise>
                    </c:choose>
                    
                    
          </div>
          
                <div class="clear"></div>
            </li>
            </c:forEach>
                         
          </ul>
          </div>
          
           <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
         
                </div>

          </c:when>
          
          <c:otherwise>
 		<div class="paging_container8">
        <div class="job_listing_wrap">
            <ul class="jobslisting">        
           <!--  <div class="candidate_status orangetxt">  
           
            </div>  -->
            <c:forEach items="${searchJobs}" var="searchJobs">
            <li id="${searchJobs.jobIdAndFirmId}">
            
                <div class="details">
                
                	<div class="jobtitle floatleft">
                	 <c:choose>
				  		<c:when test="${role!='ANONYMOUS'}"> 
                	<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${searchJobs.jobIdAndFirmId}"></c:out>"><c:out value="${searchJobs.jobTitle}"/></a>
                	</c:when>
                	<c:otherwise>
                	<a href="candidate_registration.htm?msg=Please Register To Imploy.me to view the job details"><c:out value="${searchJobs.jobTitle}"/></a>
                	</c:otherwise>
                	</c:choose>
                	</div>
                	
                    <div class="floatright jobtype"><c:out value="${searchJobs.jobType}"/></div>
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">
<%--                     <a href="candidate_view_employer_profile.htm?employerName=<c:out value="${searchJobs.companyName}">
                    </c:out>"><c:out value="${searchJobs.companyName}"/></a> --%>
                       <a href="profile_preview.htm?companyName=<c:out value="${searchJobs.companyName}"></c:out>">
                    <c:out value="${searchJobs.companyName}"/></a>
                    
                    
                    </span>, <c:out value="${searchJobs.location}"/></div>
                    <div class="description comment more"><c:out value="${searchJobs.jobDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        
                        <c:forEach items="${searchJobs.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/></li>
                        </c:forEach>
                        
                         <c:forEach items="${searchJobs.secondarySkills}" var="secondarySkills">
                        <li><c:out value="${secondarySkills}"/></li>
                        </c:forEach>
                      
                      </ul></td>
                  </tr>
                  </table>
                </div>
                
              <div class="actionsbtns">
                   <div class="date"> 
                  <fmt:parseDate value="${searchJobs.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate1"/>
                  <fmt:formatDate type="date" value="${formatedDate1}" pattern="d"/> <br/> 
                  <fmt:formatDate type="date" value="${formatedDate1}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate1}" pattern="yyyy"/> </div>
                  
                 <%--  <c:forEach var="item" items="${fn:split(${searchJobs.postedOn},'-')}">
       						 ${item}
				  </c:forEach> --%>
				  <c:choose>
				  <c:when test="${role!='ANONYMOUS'}"> 
				  <c:choose>
				  
				        <c:when test="${ savedJobIdsMap.containsKey(searchJobs.jobIdAndFirmId) }">
	             
	              <div class="buttonwrap savediv">
		              <img src="images/saved_active_icn.png" alt="Save Job">
	                  <br/>Already Saved
                    </div>
	        
	             </c:when>
	             <c:otherwise>
	             <a class ="saveanchor saveJob" id="${searchJobs.jobIdAndFirmId}">
	           
	              <div class="buttonwrap savediv">
	              <img src="images/saved_icn.png" alt="Save Job" class="bookmark" />
                    <br/>Save 
                    </div>
                    </a>
	             </c:otherwise>
	          
                    </c:choose>
                    
      
                    <a onclick="applyJob('${searchJobs.jobIdAndFirmId}')">
                    <div class="buttonwrap"><img src="images/correct_icn.png" alt="Apply Job"> <br/>Apply</div></a>
                 </c:when>
               
                 <c:otherwise>
                   <a href="candidate_registration.htm?msg=Please Register On Imploy.me to save this job">
                    <div class="buttonwrap"><img src="images/saved_icn.png" alt="Save Job"> <br/>Save </div></a>
                     <a href="candidate_registration.htm?msg=Please Register On Imploy.me to apply to this job">
                    <div class="buttonwrap"><img src="images/correct_icn.png" alt="Apply Job"> <br/>Apply</div></a>
                 </c:otherwise>
                 </c:choose>   
                  
                  
                    
          </div>
          
                <div class="clear"></div>
            </li>
            </c:forEach>
                         
          </ul>
          </div>
          <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
      </div>
          </c:otherwise>
          
           </c:choose>

               <input name="" type="button" value="Back" onclick="goBack()">     
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
    
       <!-- Job Applied Modal -->

 <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="appliedJobModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>


<!-- Job Applied Modal -->
</body>
</html>
