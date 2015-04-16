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
<title>Candidate All Recent Jobs</title>
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
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery.pajinate.js"></script>
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>

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
		jobDetailsDom.allJobsInternshipsFlag = true;
		callApplyFilter();
	}

	$('.search_candidate_listing').pajinate({
		num_page_links_to_display : 3,
		item_container_id : '.recentJobs',
		items_per_page : 50	
	});
	
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
		jobDetailsDom.allJobsInternshipsFlag = true;
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

				$('.recentJobsTable').remove();

				$(".reponses_listing_wrap").append('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching recentJobsTable">');
				
				$(data).each(function(index,item) {

					if(item.jobType == 'internship' || item.jobType == 'Internship')
					{
						$(".recentJobsTable").append('<tr class="recentJobs"><td width="5%"><div class="floatleft" style="width:10%;"><img src="view_image.htm?emailId='+item.emailId+'" height = "35" width="35"></div></td>'
							+'<td width="20%"><span class="boldtxt"> <a href="candidate_preview_listed_internship.htm?internshipId='+item.internshipIdAndFirmId+'">'+item.internshipTitle+'</a></span><br>'+item.companyName+'</td>'
							+'<td width="10%">'+item.location+'</td><td width="15%">'+item.differenceInDays+'</td><td width="10%">'+item.jobType+'</td></tr>');
					}

					else
					{
						$(".recentJobsTable").append('<tr class="recentJobs"><td width="5%"><div class="floatleft" style="width:10%;"><img src="view_image.htm?emailId='+item.emailId+'" height = "35" width="35"></div></td>'
							+'<td width="20%"><span class="boldtxt"> <a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId='+item.jobIdAndFirmId+'">'+item.jobTitle+'</a></span><br>'+item.companyName+'</td>'
							+'<td width="10%">'+item.location+'</td><td width="15%">'+item.differenceInDays+'</td><td width="10%">'+item.jobType+'</td></tr>');

					}

					});

				$(".reponses_listing_wrap").append('</table>');
				
				$('.search_candidate_listing').pajinate({
					num_page_links_to_display : 3,
					item_container_id : '.recentJobs',
					items_per_page : 50	
				});

		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		});
}

function getJobs(elementId)
{
	var formId = $('#' + elementId).parents('form').attr('id');
	$("#"+formId).submit();
}
</script>
<style type="text/css">
#innersection h1.sectionheading span{font-size:12px;}
.details form{margin-bottom:10px;"}
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
        <div class="search_candidate_listing">
        <div class="reponses_listing_wrap">
        <c:if test="${not empty recentJobs}">
        <h1 class="sectionheading"> RECENT JOBS  <div class="floatright"><input type="checkbox" name="jobType" value="fullTime" class="checkbox" />Full Time &nbsp;&nbsp; 
  			<input type="checkbox" name="jobType" value="partTime" class="checkbox" />Part Time &nbsp;&nbsp; 
  			<input type="checkbox" name="jobType" value="internship" class="checkbox" />Internship &nbsp;&nbsp;</div></h1>
        <div class="clear"></div>
         
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching recentJobsTable">
         <c:forEach items="${recentJobs}"  var="recentJobs" varStatus="status">
          <tr class="recentJobs">
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
         </c:forEach>
        </table>
       
          </c:if>
          </div>
           <c:if test="${fn:length(recentJobs) gt 10}">
          <div class="page_navigation"></div>
          </c:if>
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