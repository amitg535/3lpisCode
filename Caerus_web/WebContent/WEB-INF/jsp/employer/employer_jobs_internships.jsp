<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Employer Jobs and Internships</title>
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
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />

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
  <!-- <script src="js/jquery.dropdownPlain.js"></script> -->
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
  <script type="text/javascript">

  // Campus Internship
  $(document).on('click', '.extendInternshipClass', function () {
	  $("#datepicker").val('');
	  $("#emptyMsg").empty();
	  
	  var id = $(this).attr('id');

	  var myRows = $('#'+id).parents().eq(1);
	  var universityName = $(myRows[0]).find('span.universityNameHidden').attr('id');
	  var internshipId = $(myRows[0]).find('span.internshipIdHidden').attr('id');
	 
	  $('#hiddenId').val(id);
	  $('#hiddenInternshipId').val(internshipId);
	  $('#hiddenUniversityName').val(universityName);
  });



  // Internship
  $(document).on('click', '.classExtendInternship', function () {
	  $("#datepickerInternship").val('');
	  $("#emptyMsgInternship").empty();
	  
	  var id = $(this).attr('id');

	  var myRows = $('#'+id).parents().eq(1);
	  var internshipId = $(myRows[0]).find('span.internshipIdHiddenVal').attr('id');
	 
	  $('#hiddenIdVal').val(id);
	  $('#hiddenInternshipIdVal').val(internshipId);
  });
  
  $(document).ready(function() {

	  // Campus Internship
	  $("#closeInternship").click(function(){

		 var internshipIdAndFirmId = $("#hiddenInternshipId").val();
		 var universityName = $("#hiddenUniversityName").val();
		 var aid = $('#hiddenId').val();

		 var myRows = $('#'+aid).parents().eq(1);
		 var imgId = $(myRows[0]).find('img').attr('id');
		 var tdId = $(myRows[0]).find('td').attr('id');
		 
		  $.ajax({

			  	type : 'POST',
			 	url : 'employer_close_campus_internship.json',						
				
				cache : false,
				data : 
				{
					'internshipIdAndFirmId' : internshipIdAndFirmId,
					'universityName' : universityName
				},	
				
				success : function(data) {
					
					$("#successMessageSpan").empty().append("Internship Closed Successfully");
					
					$("#successMessageModal").dialog({
			 	          
		 	            modal: true,
		 	            open: function(event, ui){
		 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
		 	            }
					
				});
					
				},
				
				error : function(xhr,error) {
					alert("Failed");
				}
				
				}); 

		  $('#'+aid).css('display','none');
		  $('#'+imgId).remove();
		  $('#'+tdId).empty().append('<img src="images/grey_circle.png" alt=""/>');

	  });

	  // Campus Internship
	  $("#extendInternship").click(function(){

			if(null == $("#datepicker").val() || "" == $("#datepicker").val())
				$("#emptyMsg").empty().append('Enter Date');
			
			else
			{
				$("#extendInternship").attr("data-dismiss","modal");
				
				 var internshipIdAndFirmId = $("#hiddenInternshipId").val();
				 var universityName = $("#hiddenUniversityName").val();
				 var endDate = $("#datepicker").val();
				 var aid = $('#hiddenId').val();
	
				  $.ajax({

					  	type : 'POST',
					 	url : 'employer_extend_campus_internship_endDate.json',						
						
						cache : false,
						data : 
						{
							'internshipIdAndFirmId' : internshipIdAndFirmId,
							'universityName' : universityName,
							'endDate' : endDate
						},	
						
						success : function(data) {
						$("#successMessageSpan").empty().append("Internship Date Extended Successfully");
						
						$("#successMessageModal").dialog({
				 	          
			 	            modal: true,
			 	            open: function(event, ui){
			 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
			 	            }
						
						});
							
						},
						
						error : function(xhr,error) {
							alert("Failed");
						}
						
						}); 
				
			  	$('#'+aid).css('display','none');
			}

		  });


	  // Internship
	  $("#closeInternshipId").click(function(){

			 var internshipIdAndFirmId = $("#hiddenInternshipIdVal").val();
			 var aid = $('#hiddenIdVal').val();

			 var myRows = $('#'+aid).parents().eq(1);
			 var imgId = $(myRows[0]).find('img').attr('id');
			 var tdId = $(myRows[0]).find('td').attr('id');
			 
			  $.ajax({

				  	type : 'POST',
				 	url : 'employer_close_internship.json',						
					
					cache : false,
					data : 
					{
						'internshipIdAndFirmId' : internshipIdAndFirmId,
					},	
					
					success : function(data) {
						
						$("#successMessageSpan").empty().append("Internship Closed Successfully");
						
						$("#successMessageModal").dialog({
				 	          
			 	            modal: true,
			 	            open: function(event, ui){
			 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
			 	            }
						
					});
						
					},
					
					error : function(xhr,error) {
						alert("Failed");
					}
					
					}); 

			  $('#'+aid).css('display','none');
			  $('#'+imgId).remove();
			  $('#'+tdId).empty().append('<img src="images/grey_circle.png" alt=""/>');

		  });


	  // Internship
	  $("#extendInternshipId").click(function(){

			if(null == $("#datepickerInternship").val() || "" == $("#datepickerInternship").val())
				$("#emptyMsgInternship").empty().append('Enter Date');
			
			else
			{
				$("#extendInternshipId").attr("data-dismiss","modal");
				
				 var internshipIdAndFirmId = $("#hiddenInternshipIdVal").val();
				 var endDate = $("#datepickerInternship").val();
				 var aid = $('#hiddenIdVal').val();
	
				  $.ajax({

					  	type : 'POST',
					 	url : 'employer_extend_internship_endDate.json',						
						
						cache : false,
						data : 
						{
							'internshipIdAndFirmId' : internshipIdAndFirmId,
							'endDate' : endDate
						},	
						
						success : function(data) {
						$("#successMessageSpan").empty().append("Internship Date Extended Successfully");
						
						$("#successMessageModal").dialog({
				 	          
			 	            modal: true,
			 	            open: function(event, ui){
			 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
			 	            }
						
						});
							
						},
						
						error : function(xhr,error) {
							alert("Failed");
						}
						
						}); 
				
			  	$('#'+aid).css('display','none');
			}

		  });
	  
	  
 	 var successMessageEdit = "<%=request.getParameter("successMessage") %>"; 
	 var successMessagePost = "${successMessage}";
	 var successMessageInternshipPost= "${successMessageInternshipPost}";
	 var successMessageInternshipEdit="${successMessageInternshipEdit}";
 	  
 	//Code to show success message on successful job edit
 	  if (successMessageEdit!="null"){
 	  $("#successMessageSpan").empty().append(successMessageEdit);
 	    
 	      $("#successMessageModal").dialog({
 	          
 	            modal: true,
 	            open: function(event, ui){
 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
 	            }
  });
 	      
 	  }

 	//Code to show success message on successful job post
 	  if (successMessagePost){
 	 	  $("#successMessageSpan").empty().append(successMessagePost);
 	 	    
 	 	      $("#successMessageModal").dialog({
 	 	          
 	 	            modal: true,
 	 	            open: function(event, ui){
 	 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
 	 	            }
 	  });
 	 	      
 	 	  }

 	//Code to show success message on successful internship post
 	  if (successMessageInternshipPost){
 	 	  $("#successMessageSpan").empty().append(successMessageInternshipPost);
 	 	    
 	 	      $("#successMessageModal").dialog({
 	 	          
 	 	            modal: true,
 	 	            open: function(event, ui){
 	 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
 	 	            }
 	  });
 	 	      
 	 	  }


 	//Code to show success message on successful internship edit
	  if (successMessageInternshipEdit){
 	 	  $("#successMessageSpan").empty().append(successMessageInternshipEdit);
 	 	    
 	 	      $("#successMessageModal").dialog({
 	 	          
 	 	            modal: true,
 	 	            open: function(event, ui){
 	 	                setTimeout("$('#successMessageModal').dialog('close')",2500);
 	 	            }
 	  });
 	 	      
 	 	  }

  });
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

  $(function() {

	  var dateToday = new Date();
	  dateToday.setDate(dateToday.getDate() + 3);

	  var yrRange = dateToday.getFullYear() + ":" + (dateToday.getFullYear() + 10);
	  
		$( "#datepicker" ).datepicker({
			minDate: dateToday,
			changeMonth: true,
			changeYear: true,
			yearRange: yrRange
		});

		$( "#datepickerInternship" ).datepicker({
			minDate: dateToday,
			changeMonth: true,
			changeYear: true,
			yearRange: yrRange
		});
  });
  </script>
  <script>
	function checkConfirm(){
		var r=confirm("Are you sure want to delete this record ?");
		if (r==true){
		  return true;
		}
		else{
		  return false;
		}	
	}

 </script>
  </head>
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
      
    <div id="innersection">

  <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="#">Publish Jobs &amp; Internships</a> \ Preview of a Campus Job to Internship</div> -->


      <section id="rightwrap" class="floatleft"> 
        <div class="quickaction_wrap double_padding_bottom"> 
           
  <ul>            
  <li class="floatleft textwrap"><a href="employer_jobs_internships.htm">
  		  <div class="floatleft iconwrap"><img src="images/postajob_icn.png" alt=""></div>
           <div class="floatleft textwrap">    
             Jobs</div>
              </a> </li>
  <li class="floatleft textwrap"><a href="employer_jobs_internships.htm?selected=internships">
             <div class="floatleft iconwrap"><img src="images/postajob_icn.png" alt=""></div>
             <div class="floatleft textwrap">  
             Internships</div>
              </a> </li>
  <li class="floatleft textwrap"><a href="employer_jobs_internships.htm?selected=campusJobs">
  	 <div class="floatleft iconwrap"><img src="images/campusjob_icn.png" alt=""></div>
            <div class="floatleft textwrap">   
            Campus Jobs</div>
              </a> </li>
   <li class="floatleft textwrap">
   <a href="employer_jobs_internships.htm?selected=campusInternships">
    <div class="floatleft iconwrap"><img src="images/campusjob_icn.png" alt=""></div>
             <div class="floatleft textwrap"> Campus Internships</div> 
            
              </a> </li>

</ul>
</div> 
       <c:choose>
       <c:when test="${internships eq true }">
       <div class="whitebackground floatleft width100">
          <h1 class="sectionheading floatleft">Internships</h1> 
         <a href="employer_post_internship.htm">
          <div class="postajob_wrap"><img src="images/university_icn.png" alt="Post a Internship" title="Post a Job">Post an Internship</div>
          </a> 
        <div class="clear"></div>
         <div id="candidate_registration_wrap"> 
        	
            <div class="clear"></div>
       
                 <div class="par">
                 <c:choose>
                 <c:when test="${empty listInternship}">
                  <div class="clear"></div>
                 <label class="emptyMsg"> No Internships posted by You. <a href="employer_post_internship.htm">Post an Internship soon </a></label>
                 </c:when>
                 <c:otherwise>   
                 <div class="actionlegend_wrap floatright doubletop_margin">
            	<ul>
                	<li>Actions Legends:</li>
                    <li><img src="images/green_circle.png">Posted</li>
                    <li><img src="images/red_circle.png">Drafts</li>
                    <li><img src="images/grey_circle.png">Closed</li>
                </ul>
          </div>     
           <div class="clear"></div>
           <table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="42%" class="table_leftalign">Internships Title</th>
                    <th width="19%" class="table_leftalign">Posted by</th>
                    <th width="13%" class="table_leftalign">Posted on</th>
                    <th width="10%" class="table_leftalign">Responses</th>
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                <c:forEach var="internship" items="${listInternship}">
                <tr>
	                    <c:choose>
	      				<c:when test="${internship.status =='Draft'}">
	                    <td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
	                    </c:when>
	                    <c:when test="${internship.status =='Published'}">
	                    <c:set var="internshipIdAndFirmIdVal" value="${internship.internshipIdAndFirmId.replace('@','').replace('.','').replace(' ','')}" />
	                    <td class="table_centeralign" id="td${internshipIdAndFirmIdVal}">
	                    <img src="images/green_circle.png" alt="" id="img${internshipIdAndFirmIdVal}"/></td>
	                    </c:when>
	                    <c:otherwise>
	                    <td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
	                    </c:otherwise>
	                    </c:choose>
                    <td><a href="employer_preview_listed_internship.htm?internshipIdAndFirmId=<c:out value="${internship.internshipIdAndFirmId}"></c:out>"> <c:out value="${internship.internshipTitle}"/> </a></td>
                    <td class="table_leftalign"><c:out value="${internship.companyName}"/></td>
                    <td class="table_centeralign">
                    <fmt:parseDate value="${internship.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="internshipPostedOn"/>
                    <fmt:formatDate type="date" value="${internshipPostedOn}" pattern="${jobDateFormat}" />
                    </td>
                    <c:choose>
                    <c:when test="${internship.responseCount != 0}">
                    <td class="table_centeralign"><a href="employer_view_internship_responses.htm?internshipIdAndFirmId=<c:out value="${internship.internshipIdAndFirmId}"></c:out>"><c:out value="${internship.responseCount}"></c:out></a></td>
                    </c:when>
                    <c:otherwise>
                    <td class="table_centeralign"><c:out value="${internship.responseCount}"></c:out></td>
                    </c:otherwise>
                    </c:choose>
                    <td class="table_centeralign">
                    
                     <fmt:parseDate value="${twoDaysAfter}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="twoDaysAfter"/>
                  <fmt:formatDate type="date" value="${twoDaysAfter}" pattern="yyyy-MM-dd" var="twoDaysAfterDate"/>
                   <fmt:parseDate value="${twoDaysAfterDate}" type="DATE" pattern="yyyy-MM-dd" var="twoDaysAfterDate"/>
                   
                  <fmt:parseDate value="${internship.endDate}" type="DATE" pattern="yyyy-MM-dd" var="endDate"/>
                  
                   <c:if test="${(endDate le twoDaysAfterDate) && internship.status eq 'Published'}">
                		<a class="orangebuttons classExtendInternship" data-toggle="modal" href="#warning_modal_internship" id="${internshipIdAndFirmIdVal}"><img src="images/warningerror_icn.png" class="table_actionbtn" alt="About to Expire" title="About to Expire"></a>
                   		<span class="internshipIdHiddenVal" id="${internship.internshipIdAndFirmId}"></span>
                   </c:if>
                    
                    <c:if test="${internship.status !='Closed'}">
                    <a href="employer_edit_internship.htm?internshipIdAndFirmId=<c:out value="${internship.internshipIdAndFirmId}"></c:out>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                    </c:if>
      				<c:if test="${internship.status !='Published'}">
                    <a href="employer_delete_internship.htm?internshipIdAndFirmId=<c:out value="${internship.internshipIdAndFirmId}"></c:out>" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                    </c:if>
                    <a href="employer_copy_internship.htm?internshipIdAndFirmId=<c:out value="${internship.internshipIdAndFirmId}"></c:out>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Internship" title="Copy Internship"></a></td>
                  </tr>
                 </c:forEach>  
              </tbody>
              </table>
  				</c:otherwise>
                 </c:choose>
          </div>
          </div>
          </div>
        </c:when>
       
       <c:when test="${campusJobs eq true }">
       <div class="whitebackground floatleft width100">
        <h1 class="sectionheading floatleft">Campus Jobs</h1> 
       <a href="employer_post_campus_job.htm">
          <div class="postajob_wrap"><img src="images/postajob_icn.png" alt="Post a Job" title="Post a Job">Post a Job to Campus</div>
          </a>
        <div class="clear"></div>
        <div id="candidate_registration_wrap">
        
         <div class="clear"></div> 
                <div class="par">
                <c:choose>
                <c:when test="${empty employerJobPostListForUniversity}">
                 <div class="clear"></div> 
                <label class="emptyMsg"> No Campus Jobs posted by You. <a href="employer_post_campus_job.htm">Post a Job soon </a></label>
                </c:when>
                <c:otherwise>
               <div class="actionlegend_wrap floatright doubletop_margin">
            	<ul>
                	<li>Actions Legends:</li>
                    <li><img src="images/green_circle.png">Posted</li>
                    <li><img src="images/red_circle.png">Drafts</li>
                    <li><img src="images/grey_circle.png">Closed</li>
                </ul>
                           <div class="clear"></div>
          </div>
            <table class="table table-bordered" id="dyntable">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="27%" class="table_leftalign">Job Title</th>
                    <th width="15%" class="table_leftalign">Posted to</th>
                    <th width="14%" class="table_leftalign">Posted by</th>
                    <th width="14%" class="table_centeralign">Posted on</th>
                    <th width="13%" class="table_centeralign">Responses</th>
                    <th width="13%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                
                 <c:forEach var="jobListForUniversity" items="${employerJobPostListForUniversity}"> 
                
                <tr>     
                			 	<c:choose>
      							<c:when test="${jobListForUniversity.status =='Draft'}">
                    				<td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:when test="${jobListForUniversity.status =='Published'||jobListForUniversity.status =='Broadcasted'}">
                    				<td class="table_centeralign"><img src="images/green_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:otherwise>
                    				<td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
                    			</c:otherwise>
                    		</c:choose>  
                             
                    <td><a href="employer_preview_posted_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><c:out value="${jobListForUniversity.jobTitle}"/></a></td>
                    <td><c:out value="${jobListForUniversity.universityName}"/></td>
                    <td class="table_leftalign"><c:out value="${jobListForUniversity.postedBy}"/></td>
                    <td class="table_centeralign">
                    <%-- <c:out value="${jobListForUniversity.postedOn}"/> --%>
                    <fmt:parseDate value="${jobListForUniversity.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="campusJobPostedOn"/>
                    <fmt:formatDate type="date" value="${campusJobPostedOn}" pattern="${jobDateFormat}" /> <%-- pattern="dd-MM-yyyy  hh:mm" --%>
                    
                    </td>
                  <c:choose>
                    		<c:when test="${fn:length(jobListForUniversity.campusJobAppliedStudents) != 0}">
                   
                     <td align="center"><a href="view_campus_job_responses.htm?jobId=<c:out value="${jobListForUniversity.jobIdAndFirmId}"></c:out>&universityName=<c:out value="${jobListForUniversity.universityName}"/>&campus=true"  class="center_align">
					                 <c:out value="${fn:length(jobListForUniversity.campusJobAppliedStudents)}"></c:out></a></td>
                    	</c:when>
                    	<c:otherwise>
                    	 <td align="center">
					                 <c:out value="${fn:length(jobListForUniversity.campusJobAppliedStudents)}"></c:out></td>
                    	</c:otherwise>
                    	</c:choose>
                    <%-- <td class="table_centeralign"><a href="employer_edit_posted_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a><a href="employer_delete_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a><a href="employer_copy_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a></td> --%>
                  
                 	 <td class="table_centeralign">
                 	<c:if test="${jobListForUniversity.status !='Closed'}">
                    <a href="employer_edit_posted_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                    </c:if>
                   
                    <c:if test="${jobListForUniversity.status =='Draft'}">
                    <a href="employer_delete_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                    </c:if>
                   
                    <a href="employer_copy_campus_job.htm?jobId=<c:out value="${jobListForUniversity.jobId}"/>_<c:out value="${jobListForUniversity.firmId}"/>&universityName=<c:out value="${jobListForUniversity.universityName}"/>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a>
                    
                   
                    </td>
                   </tr>
                  </c:forEach> 
              
              </tbody>
              </table>
               </c:otherwise>
                </c:choose>
          </div>
          </div>
          </div>
      </c:when>
       
       <c:when test="${campusInternships eq true }">
       <div class="whitebackground floatleft width100">
           <h1 class="sectionheading floatleft doubletop_margin">Campus Internships</h1> 
          <a href="employer_post_campus_internship.htm">
          <div class="postajob_wrap"><img src="images/university_icn.png" alt="Post a Internship" title="Post a Job">Post an Internship to Campus</div>
          </a> 
             <div class="clear"></div>
        <div id="candidate_registration_wrap">
        
         <div class="clear"></div> 
          
              <div class="par">
              <c:choose>
              <c:when test="${empty employerInternshipListForUniversity}">
              <div class="clear"></div>
              <label class="emptyMsg"> No Campus Internships posted by You. <a href="employer_post_campus_internship.htm">Post an Internship soon </a></label>
              </c:when>
              <c:otherwise>
              <div class="actionlegend_wrap floatright doubletop_margin">
            	<ul>
                	<li>Actions Legends:</li>
                    <li><img src="images/green_circle.png">Posted</li>
                    <li><img src="images/red_circle.png">Drafts</li>
                    <li><img src="images/grey_circle.png">Closed</li>
                </ul>
                           <div class="clear"></div>
          </div>
          <div class="clear"></div>
            <table class="table table-bordered" id="dyntable">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="27%" class="table_leftalign">Internships Title</th>
                    <th width="15%" class="table_leftalign">Posted to</th>
                    <th width="14%" class="table_leftalign">Posted by</th>
                    <th width="14%" class="table_centeralign">Posted on</th>
                    <th width="13%" class="table_centeralign">Responses</th>
                    <th width="13%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                <c:forEach var="internshipPostListForUniversityVar" items="${employerInternshipListForUniversity}"> 
                <tr>
                			<c:choose>
      							<c:when test="${internshipPostListForUniversityVar.status =='Draft'}">
                    				<td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
                    			</c:when>
                    			<c:when test="${internshipPostListForUniversityVar.status =='Published' || internshipPostListForUniversityVar.status =='Broadcasted' }">
                    				 <c:set var="internshipIdAndFirmIdVar" value="${internshipPostListForUniversityVar.internshipIdAndFirmId.replace('@','').replace('.','').replace(' ','')}" />
               						<c:set var="universityNameVar" value="${internshipPostListForUniversityVar.universityName.replace(' ','')}" />
                    				<td class="table_centeralign" id="td${internshipIdAndFirmIdVar}${universityNameVar}">
                    				<img src="images/green_circle.png" alt="" id="img${internshipIdAndFirmIdVar}${universityNameVar}" /></td>
                    			</c:when>
                    			<c:otherwise>
                    				<td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
                    			</c:otherwise>
                    		</c:choose>  
                    <td><a href="employer_preview_posted_campus_internship.htm?internshipId=<c:out value="${internshipPostListForUniversityVar.internshipId}"/>_<c:out value="${internshipPostListForUniversityVar.firmId}"/>&universityName=<c:out value="${internshipPostListForUniversityVar.universityName}"/>"><c:out value="${internshipPostListForUniversityVar.internshipTitle}"/></a></td>
                    <td><c:out value="${internshipPostListForUniversityVar.universityName}"/></td>
                    <td class="table_leftalign"><c:out value="${internshipPostListForUniversityVar.postedBy}"/></td>
                    <td class="table_centeralign">
                    
             		<c:out value="${internshipPostListForUniversityVar.postedOn}"></c:out>
             		</td>
                    <c:choose>
                    <c:when test="${fn:length(internshipPostListForUniversityVar.campusInternshipAppliedStudents) != 0}">
                    <td align="center"><a href="view_campus_internship_responses.htm?internshipIdAndFirmId=<c:out value="${internshipPostListForUniversityVar.internshipIdAndFirmId}"></c:out>&universityName=<c:out value="${internshipPostListForUniversityVar.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(internshipPostListForUniversityVar.campusInternshipAppliedStudents)}"></c:out></a></td>
                    </c:when>
                    <c:otherwise>
                     <td align="center">
					                 <c:out value="${fn:length(internshipPostListForUniversityVar.campusInternshipAppliedStudents)}"></c:out></td>
                    </c:otherwise>
                    </c:choose>
                 <td class="table_centeralign">
                 
                  <fmt:parseDate value="${twoDaysAfter}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="twoDaysAfter"/>
                  <fmt:formatDate type="date" value="${twoDaysAfter}" pattern="yyyy-MM-dd" var="twoDaysAfterDate"/>
                   <fmt:parseDate value="${twoDaysAfterDate}" type="DATE" pattern="yyyy-MM-dd" var="twoDaysAfterDate"/>
                   
                  <fmt:parseDate value="${internshipPostListForUniversityVar.endDate}" type="DATE" pattern="yyyy-MM-dd" var="endDate"/>
                  
                   <c:if test="${(endDate le twoDaysAfterDate) && internshipPostListForUniversityVar.status eq 'Published'}">
                		<a class="orangebuttons extendInternshipClass" data-toggle="modal" href="#warning_modal" id="${internshipIdAndFirmIdVar}${universityNameVar}"><img src="images/warningerror_icn.png" class="table_actionbtn" alt="About to Expire" title="About to Expire"></a>
                   		<span class="universityNameHidden" id="${internshipPostListForUniversityVar.universityName}"></span>
                   		<span class="internshipIdHidden" id="${internshipPostListForUniversityVar.internshipIdAndFirmId}"></span>
                   </c:if>
                    <c:if test="${internshipPostListForUniversityVar.status ne 'Closed'}">
                    <a href="employer_edit_posted_campus_internship.htm?internshipId=<c:out value="${internshipPostListForUniversityVar.internshipId}"/>_<c:out value="${internshipPostListForUniversityVar.firmId}"/>&universityName=<c:out value="${internshipPostListForUniversityVar.universityName}"/>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                    </c:if>
                   
                    <c:if test="${internshipPostListForUniversityVar.status eq 'Draft'}">
                    <a href="employer_delete_campus_internship.htm?internshipId=<c:out value="${internshipPostListForUniversityVar.internshipId}"/>_<c:out value="${internshipPostListForUniversityVar.firmId}"/>&universityName=<c:out value="${internshipPostListForUniversityVar.universityName}"/>" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                    </c:if>
                   
                     <a href="employer_copy_campus_internship.htm?internshipId=<c:out value="${internshipPostListForUniversityVar.internshipId}"/>_<c:out value="${internshipPostListForUniversityVar.firmId}"/>&universityName=<c:out value="${internshipPostListForUniversityVar.universityName}"/>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Internship" title="Copy Internship"></a>
                     </td>
                  </c:forEach>
              </table>
              </c:otherwise>
              </c:choose>
          </div>
          </div>
          </div>
       </c:when>
       
      <c:otherwise>
      <div class="whitebackground floatleft width100">
         <h1 class="sectionheading floatleft">Jobs</h1> 
         <a href="employer_post_job.htm">
          <div class="postajob_wrap"><img src="images/postajob_icn.png" alt="Post a Job" title="Post a Job">Post a Job</div>
          </a>
        <div class="clear"></div>
         <div id="candidate_registration_wrap"> 
        	
            <div class="clear"></div>
          <div class="par">
          <c:choose>
          <c:when test="${empty jobDetail}">
           <div class="clear"></div>
          <label class="emptyMsg"> No Jobs posted by You. <a href="employer_post_job.htm">Post a Job soon </a></label>
          </c:when>
          <c:otherwise>
          <div class="actionlegend_wrap floatright doubletop_margin">
            	<ul>
                	<li>Actions Legends:</li>
                    <li><img src="images/green_circle.png">Posted</li>
                    <li><img src="images/red_circle.png">Drafts</li>
                    <li><img src="images/grey_circle.png">Closed</li>
                </ul>
          </div>
           <div class="clear"></div>
            <table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="42%" class="table_leftalign">Job Title</th>
                    <th width="19%" class="table_leftalign">Posted by</th>
                    <th width="13%" class="table_leftalign">Posted on</th>
                    <th width="10%" class="table_leftalign">Responses</th>
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                           
                  <c:forEach var="jobDetail" items="${jobDetail}"> 
                <tr>
                	<c:choose>
      				<c:when test="${jobDetail.status =='Draft'}">
                    <td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
                    </c:when>
                    
                    <c:when test="${jobDetail.status =='Published'}">
                    <td class="table_centeralign"><img src="images/green_circle.png" alt=""/></td>
                    </c:when>
                    
                    <c:otherwise>
                    <td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
                    </c:otherwise>
                    
                    </c:choose>
               <%--      <td><a href="#"><c:out value="${jobDetail.jobTitle}"/></a></td> --%>
                <td class="table_leftalign">
                <a href="employer_preview_listed_job.htm?jobId=<c:out value="${jobDetail.jobIdAndFirmId}"></c:out>"><c:out value="${jobDetail.jobTitle}"/></a></td> 
                    <td class="table_leftalign"><c:out value="${companyName}"/></td>
                    <td class="table_centeralign">
                    <fmt:parseDate value="${jobDetail.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="jobDetailPostedOn"/>
                    <fmt:formatDate type="date" value="${jobDetailPostedOn}" pattern="${jobDateFormat}" />
                    </td>
                    <c:choose>
                    <c:when test="${jobDetail.responseCount != 0}">
                    <td class="table_centeralign"><a href="employer_view_job_responses.htm?jobId=<c:out value="${ (jobDetail.jobIdAndFirmId)}"></c:out>"  class="center_align"><c:out value="${jobDetail.responseCount}"></c:out></a></td>
                    </c:when>
                    <c:otherwise>
                    <td class="table_centeralign"><c:out value="${jobDetail.responseCount}"></c:out></td>
                    </c:otherwise>
                    </c:choose>
                    <td class="table_centeralign">
                    <c:if test="${jobDetail.status !='Closed'}">
                    <a href="employer_edit_posted_job.htm?action=edit&jobIdAndFirmId=<c:out value="${jobDetail.jobIdAndFirmId}"></c:out>"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a>
                    </c:if>
                    <c:choose>
      				<c:when test="${jobDetail.status !='Published'}">
                    <a href="employer_delete_existing_job.htm?jobId=<c:out value="${(jobDetail.jobIdAndFirmId)}"></c:out>&status=<c:out value="${jobDetail.status}"/>"  onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
                    </c:when>
                    
                    </c:choose>
                    <a href="employer_copy_job.htm?jobId=<c:out value="${jobDetail.jobIdAndFirmId}"></c:out>"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a></td>
                  </tr>
                  </c:forEach>
                  
              </tbody>
              </table>
              </c:otherwise>
          </c:choose>
          </div>
          </div>
          </div>
   </c:otherwise>
   </c:choose>
   </section> 
   <div class="clear"></div>
   
 </div>
      <div class="bottomspace">&nbsp;</div>
      </div>

  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
   
   </div>  


   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="successMessageModal" >
  <div class="modal-backdrop fade in" style="z-index: 999;"></div> 
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
               
   </div>
   </div>
  </div>
   
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="warning_modal">
		<input type="hidden" id="hiddenInternshipId" value="" />
		<input type="hidden" id="hiddenUniversityName" value="" />
		<input type="hidden" id="hiddenId" value="" />
		<div class="modal-header">
			<button aria-hidden="true" data-dismiss="modal" class="close" type="button">x</button>
			<h3 id="myModalLabel">Extend Date/Close Internship </h3>
		</div>
		<div class="modal-body">
			Extend Internship Date &nbsp;&nbsp;<input type="text" id="datepicker" value="" readonly="true" placeholder="End Date"/>
			<div id="emptyMsg"></div>
		</div>
		<div class="modal-footer">
			<button class="btn" id="extendInternship">Extend</button>
			<button data-dismiss="modal" class="btn" id="closeInternship">Close Internship</button>
		</div>
  </div>
  
  <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="warning_modal_internship">
		<input type="hidden" id="hiddenInternshipIdVal" value="" />
		<input type="hidden" id="hiddenIdVal" value="" />
		<div class="modal-header">
			<button aria-hidden="true" data-dismiss="modal" class="close" type="button">x</button>
			<h3 id="myModalLabel">Extend Date/Close Internship </h3>
		</div>
		<div class="modal-body">
			Extend Internship Date &nbsp;&nbsp;<input type="text" id="datepickerInternship" value="" readonly="true" placeholder="End Date"/>
			<div id="emptyMsgInternship"></div>
		</div>
		<div class="modal-footer">
			<button class="btn" id="extendInternshipId">Extend</button>
			<button data-dismiss="modal" class="btn" id="closeInternshipId">Close Internship</button>
		</div>
  </div>
   
    </body>
    </html>
        
