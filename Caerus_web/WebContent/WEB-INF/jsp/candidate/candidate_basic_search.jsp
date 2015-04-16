<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
<title>Candidate Basic Search</title>
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
function saveSearchFunction()
{

		if( $("#check2").is(':checked'))
		{
			var searchParameterNameValue=$("#searchParameterName").val();
			var searchTrimmed=$.trim(searchParameterNameValue);
			
				if(searchTrimmed!="" && searchTrimmed.length!=0)
				{
					var formDetailsPublish = document.getElementById('advancedSearchFrm');
				 	 document.forms[0].action = "candidate_search_jobs_internships.htm?action=saveSearch";
				 	 formDetailsPublish.submit();
				 	 return true;
				}
				else
				{		$("#saveSearchErrorLabel").html("");
			          	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
			          	return false;
				}
		}
	
		else
			{
				$("#saveSearchErrorLabel").html("");
	        	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
	        	return false;
			}
	return false;

}
	
	
</script>

<script>
var selected_checkbox = new Array();
var jobDetailsDom = new Object();
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
	
	
	$("input:checkbox[name=jobType]:checked").each(function() {
		selected_checkbox.push($(this).val());
	});

	if(null != selected_checkbox)
	{
		jobDetailsDom.jobFilterValues = selected_checkbox;
		callApplyFilter();
	}
	
	$("div#advancedSearchDiv").hide();
	
	var resultCountMap = $("#resultCountMap").val();

	if(null == resultCountMap || resultCountMap == '0')
	{
		$("body").removeClass("dashboard");
		$("#leftsection").hide();
	}
	
	$('.checkbox').click(function() {

		//empty the selected values array
		selected_checkbox = [];
		
		$("input:checkbox[name=jobType]:checked").each(function() {
			selected_checkbox.push($(this).val());
		});
			
		jobDetailsDom.jobFilterValues = selected_checkbox;
		callApplyFilter();

    }); 

});

function callApplyFilter()
{
	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_apply_filter_on_jobs.json',						
		cache : false,
		data : JSON.stringify(jobDetailsDom),	
		contentType : 'application/json',
		
		success : function(data) {
				
				$("#recentJobsTable").empty();
				
				$(data).each(function(index,item) {

					if(item.jobType == 'internship' || item.jobType == 'Internship')
					{
						$("#recentJobsTable").append('<tr><td width="2%"><div class="floatleft" style="width:10%;"><img src="view_image.htm?emailId='+item.emailId+'" height = "55" width="55"></div></td>'
							+'<td width="20%"><span class="boldtxt"> <a href="candidate_preview_listed_internship.htm?internshipId='+item.internshipIdAndFirmId+'">'+item.internshipTitle+'</a></span><br>'+item.companyName+'</td>'
							+'<td width="10%">'+item.location+'</td><td width="15%">'+item.differenceInDays+'</td><td width="10%">'+item.jobType+'</td></tr>');
					}

					else
					{
						$("#recentJobsTable").append('<tr><td width="2%"><div class="floatleft" style="width:10%;"><img src="view_image.htm?emailId='+item.emailId+'" height = "55" width="55"></div></td>'
							+'<td width="20%"><span class="boldtxt"> <a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId='+item.jobIdAndFirmId+'">'+item.jobTitle+'</a></span><br>'+item.companyName+'</td>'
							+'<td width="10%">'+item.location+'</td><td width="15%">'+item.differenceInDays+'</td><td width="10%">'+item.jobType+'</td></tr>');

					}

					});
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
}

function showAdvancedSearchDiv(){
	$("div#advancedSearchDiv").show();
}

function hideAdvancedSearchDiv(){
	$("div#advancedSearchDiv").hide();
}

function getJobs(elementId)
{
	var formId = $('#' + elementId).parents('form').attr('id');
	$("#"+formId).submit();
}

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
 <style type="text/css">
#innersection h1.sectionheading  .checker span{font-size:12px !important;}

</style> 
</head>
<body class="dashboard">
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div> 
  

    <div id="innersection">
    <input type="hidden" id="resultCountMap" value="${fn:length(resultCountMap)}"> 
  <section id="leftsection" class="floatleft">
      <%@ include file="includes/browse_jobs.jsp"%>
       </section>
       
       <section id="rightwrap" class="floatleft">
       <div class="whitebackground">
        <h1 class="sectionheading floatleft"> Search</h1>
        
            <div class="padding_bottom doublebottom_margin borderbottom margin_top2 width100">
          
           <form action="candidate_search_jobs_internships.htm" method="post" class="stdform" id ="advancedSearch">
            <div class="floatleft width100"> 
            <span class="field">
            <input type="hidden" name="searchCriteria" value="Jobs" />
             <div class="floatleft"><input type="text" name="keyword" class="input-medium" placeholder="What Type of job are you looking for" id = "keywords" />&nbsp; &nbsp; &nbsp;<br>
              <span class="greytxt"><i>eg: "Sales Executive" , "Accounting", etc.</i> </span></div> 
              <div  class="floatleft"> <input type="text" name="location" class="input-medium" placeholder="in which area"/>&nbsp; &nbsp; &nbsp;<br>
             <span class="greytxt"><i>eg: "Texas" , "Chicago", etc.</i> </span></div>
              <div class="floatleft advancesearch_topmargin left_margin">
              <input name="" type="submit" value="Search" class="no_right_margin yellow_btn">
               <div class="clear"></div>
               <div class="floatleft">
              <!-- href="candidate_search_jobs_internships.htm" --> <a onclick="showAdvancedSearchDiv()"> Advanced Search</a></div>
               </div>
              </span> 
             
              </div>
          </form>
         
          <div class="clear"></div>
        </div>
        </div>
        
        <div id="advancedSearchDiv" class="whitebackground margin_top2">
               	 <h1 class="sectionheading"> Advanced Search</h1>
        <div id="candidate_registration_wrap">
          <div class="form_wrap">
            <form:form action="candidate_search_jobs_internships.htm" method="post" modelAttribute="searchJobs" cssClass="stdform" id="advancedSearchFrm">
              <div class="fullwidth_form">
              <div class="par">
              
              <span id = "searchErrorLabel"></span>
              
                  <label class="floatleft" style="padding-top:0.2em"><strong>Search By:</strong> &nbsp;</label>
                <span class="formwrapper" >
               <form:radiobutton path="searchCriteria" value="Jobs" checked = "checked"  OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; 
                <form:radiobutton path="searchCriteria" value="Internships" OnClick="showhideFaculty('internships')" />Internships
                </span>
                
              </div>
             
                  
                  </div>
              <div class="leftsection_form">
                
              <div class="par">
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
				  <form:input path="keyword" cssClass="input-xxlarge" id="keywords" />
                  <form:errors path="keyword"  cssClass="input-xxlarge"/>                
                  </span> </div> 
                  
                   <div class="par" >
                 <label>Functional Area</label>
              
               <form:select data-placeholder="Choose an Option" path="functionalArea" cssClass="chzn-select list_widthstyle1" >
                  <form:option value="">Choose an Option</form:option>
                	<c:forEach var="functionalArea" items="${functionalAreas}">
                         <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option> 
                  	</c:forEach>
                  </form:select>
              
                </div>
                  
              </div>
              <div class="rightsection_form">
                <div class="par" id="city">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                    <span class="field">
                    <form:input path="location" cssClass="input-xxlarge" />
                    <form:errors path="location"  cssClass="input-xxlarge"/>
                  </span>  </div>
                               
             <div class="par" id="industry">
                  <label class="floatleft">Industry</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                  
                  <form:select data-placeholder="Choose an Option" path = "industry"  cssClass="chzn-select list_widthstyle1">
                    <form:option value="">Choose an Option</form:option>
                    <c:forEach var="industry" items="${industries}">
                         <option value="<c:out value="${industry}" />"><c:out value="${industry}" /></option> 
                   </c:forEach>
                  </form:select>
                  
                  </span> </div>
               
               
                  
              </div>
              <div class="clear"></div>
              <div class="doublebottom_margin">
                <div class="buttonwrap">
               	<input name="search" type="submit" value="Search" >
                <input name="" type="button" value="Hide" onclick="hideAdvancedSearchDiv()">
              </div>
              </div>
              
            </form:form>
          </div>
        </div>
        
        </div>
        
        <c:choose>
        <c:when test="${not empty recentJobs}">
        <div class="whitebackground margin_top2">
        
        <h1 class="sectionheading"> RECENT JOBS  <div class="floatright"><input type="checkbox" name="jobType" value="fullTime" class="checkbox" />Full Time &nbsp;&nbsp; 
  			<input type="checkbox" name="jobType" value="partTime" class="checkbox" />Part Time &nbsp;&nbsp; 
  			<input type="checkbox" name="jobType" value="internship" class="checkbox" />Internship &nbsp;&nbsp;</div></h1>
        <div class="clear"></div>
         
  			
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching" id="recentJobsTable">
          <c:forEach items="${recentJobs}"  var="recentJobs" varStatus="status">
           <c:if test="${status.index < 5}">
          <tr>
          <td width="5%">
          <div class="floatleft" style="width:10%;">
              <img src="view_image.htm?emailId=${recentJobs.emailId}" height = "35" width="35">
          </div>
          </td>
            <td width="20%">
            <c:choose>
            <c:when test="${recentJobs.jobFlag == true}">
           <span class="boldtxt"> <a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId=<c:out value="${recentJobs.jobIdAndFirmId}"></c:out>"><c:out value="${recentJobs.jobTitle}"/></a></span>
            </c:when>
            <c:otherwise>
            <span class="boldtxt"><a href="candidate_preview_listed_internship.htm?internshipId=<c:out value="${recentJobs.internshipIdAndFirmId}"></c:out>"><c:out value="${recentJobs.internshipTitle}"/></a></span>
            </c:otherwise>
            </c:choose>
            <br/>
               <c:out value="${recentJobs.companyName}"/></td>
            <td width="10%"><c:out value="${recentJobs.location}"/></td>
            <td width="15%"><c:out value="${recentJobs.differenceInDays}"/></td>
            <td width="10%"><c:out value="${recentJobs.jobType}"/></td>
          </tr>
          </c:if>
        </c:forEach>
        </table>
        <c:if test="${recentJobsSize > 5}">
        <div class="viewmore table_rightalign">
        <a href="candidate_all_recent_jobs.htm">View more</a></div>
        </c:if>
        </div>
        
        <div class="clear"></div>
       <div class=" borderbottom margin_top2 floatleft whitebackground">
        <h1 class="sectionheading"> NOW RECRUITING </h1>
        <div class="clear"></div>
        
        <ul class="relatedjobs">
			    <c:forEach items="${nowRecruitingCompanies}" var="nowRecruitingCompanies" varStatus="status">
			    <c:if test="${status.index < 6}">
			    <li onclick='location.href="profile_preview.htm?companyName=<c:out value="${nowRecruitingCompanies.key}"></c:out>"'>
			    	<c:choose>
			    		<c:when test="${not empty nowRecruitingCompanies.value}">
			    			<img alt="Employer Image" src="view_image.htm?emailId=<c:out value="${nowRecruitingCompanies.value}"></c:out>" style="height:79px;" title="${nowRecruitingCompanies.key}">
			    		</c:when>
			    		<c:otherwise>
			    			<img alt="Employer Image" src="images/Not_available_icon1.png" title="${nowRecruitingCompanies.key}">
			    		</c:otherwise>
			    	</c:choose>
			    </li>
			    </c:if>
			    </c:forEach>
		    </ul>
		    
       </div>
          </c:when>
          <c:otherwise>
          <div class="whitebackground margin_top2">
        
        <h1 class="sectionheading"> RECENT JOBS  </h1>
        No data Available
        </div>
       
          </c:otherwise>
          </c:choose>
        <div class="clear"></div>
        
        
     <div class="padding_bottom doublebottom_margin  margin_top2 width100 floatleft">
     <c:choose>
        <c:when test="${not empty recentSearches}">
         <div class="floatleft job_listing_wrap whitebackground" style="width: 42%;padding-right: 20px;">
                <h1 class="sectionheading"> RECENT SEARCHES </h1>
			        <div class="clear"></div>
			         
			          <ul class="keyskillslist">
			        <c:forEach items="${recentSearches}" var="recentSearch" varStatus="status">
			       <li>
			       <form action="candidate_search_jobs_internships.htm" method="post" id="recentSearchForm${status.index}"> 
			       <a onclick="getJobs(this.id)" id="recentSearch${status.index}"><c:out value="${recentSearch}"/></a><br>
			        <input type="hidden" value="${recentSearch}" name="keyword">
			        <input type="hidden" name="searchCriteria" value="Jobs" />
			        </form>
			        </li>
			        </c:forEach>
			        </ul>
			        
			        <div class="clear"></div>
			        </div>
			        </c:when>
			        
			        <c:otherwise>
			        <div class="floatleft job_listing_wrap whitebackground" style="width: 42%;padding-right: 20px;">
                <h1 class="sectionheading"> RECENT SEARCHES </h1>
                 There are no recent Searches
                </div>
			        </c:otherwise>
		      </c:choose>
		
		
      <c:choose>
       <c:when test="${not empty popularTags}">
         <div class="floatright job_listing_wrap whitebackground" style="width:50%;padding-left: 20px;">
         <h1 class="sectionheading"> POPULAR TAGS </h1>
         
          <ul class="keyskillslist">
         <c:forEach var="popularTag" items="${popularTags}" varStatus="status">
         <li>
         <form action="candidate_search_jobs_internships.htm" method="post" id="myform${status.index}"> 
        <a onclick="getJobs(this.id)" id="popularTag${status.index}"><c:out value="${popularTag}"/></a><br>
        <input type="hidden" value="${popularTag}" name="keyword">
        <input type="hidden" name="searchCriteria" value="Jobs" />
        </form>
         </li>
        
         </c:forEach>
         </ul>
         
        </div>
        </c:when>
        <c:otherwise>
         <div class="floatright job_listing_wrap whitebackground" style="width:50%;padding-left: 20px;">
         <h1 class="sectionheading"> POPULAR TAGS </h1>
         No Data Available
         </div>
        </c:otherwise>
        </c:choose>
        
        
        
        
       </div>
       <div class="clear"></div>
       <c:choose>
        <c:when test="${savedSearchSize != '0'}"> 
          <a href="candidate_saved_search.htm" class="floatleft clear width100" style="font-size:30px;"> Saved Searches (${savedSearchSize})</a>
	         </c:when> 
	         <c:otherwise>
	         <p class="floatleft clear width100" style="font-size:30px;"> Saved Searches (${savedSearchSize})</p>
	         </c:otherwise>
	         </c:choose>
       
        <div class="clear"></div>
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