<%@ page language="java"
	import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Generate Reports</title>
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
<link rel="stylesheet" href="css/uielements/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css"
	type="text/css" />
<link rel="stylesheet" href="css/jplayer.pink.flag.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css">
<link rel="stylesheet" href="css/dots.css" type="text/css">
<script type="text/javascript"
	src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.validate.min.js"></script>

<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript"
	src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery-loader.js"></script>


<script type="text/javascript">
    $(document).ready(function () {
    	$(function() {
    		$( "#datepicker" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+0"
    		});
    	});
    	  $("#postForm").submit(function(){
    	        var valid=0;
    	        
    	        $(this).find('input[type=text]').each(function(){
    	            if($(this).val() != "") valid+=1;
    	        });
    	        if(valid){
    	           return true;
    	        }
    	        else {
    	           
    	            $("#searchErrorLabel").html("");
    	            $("#searchErrorLabel").html("Enter at least one search parameter!");
    	            
    	            return false;
    	        }
    	        
    	    });
  	    
    	$("#jobId").val("");
  	    $("#jobTitle").val("");
  	    $("#datepicker").val("");
  	    
  	  /* $(".table-bordered tr td a.hover").attr('id', function(i) {
		  $(this).attr('id', "q" + i);
		}); 
  	$(".table-bordered tr ").attr('id', function(i) {
		  $(this).attr('id', "count" + i);
		});  */
	        
   });
function createReport(elementId)
{	
	var myRows = $('#'+elementId).parents().eq(1);
	
	var jobIdAndFirmId = $(myRows[0]).find('input').val();
	window.location = 'employer_download_report.htm?jobIdAndFirmId='+jobIdAndFirmId;
	$("#studentDetails").empty();
	$("#buttons").hide();
	
	$("#studentDetails").show();
}
</script>

<style>
.hover {
	cursor: pointer;
	cursor: hand;
}
</style>

</head>
<body>
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		<%@ include file="includes/header.jsp"%>
		<!--------------  Header Section :: end ------------>
		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
			<div id="innersection">
				<!-- <div id="breadcrums_wrap">
					You are here: <a href="employer_dashboard.htm">Home</a> / Generate
					Reports
				</div> -->
				<section id="rightwrap" class="floatleft">
					<h1 class="sectionheading">Job Responses Report</h1>
					<div id="candidate_registration_wrap">
					<div class="whitebackground">
						<form:form cssClass="stdform" action="" method="post"
							id="postForm" modelAttribute="jobDetailsDom">
							<label id="searchErrorLabel" class="error"></label>
							<div class="par">
								<label class="floatleft">Job ID</label>
								<div class="clear"></div>
								<span class="field"> <form:input path="jobId"
										cssClass="input-medium" id="jobId" tabindex="1" />
								</span>
							</div>
							<div class="par">
								<label class="floatleft">Job Title</label>
								<div class="clear"></div>
								<span class="field"> <form:input path="jobTitle"
										cssClass="input-medium" id="jobTitle" tabindex="2" />
								</span>
							</div>
							<div class="par">
								<label class="floatleft">Posted On</label>
								<div class="clear"></div>
								<span class="field"> <form:input path="postedOn"
										class="input-small_date" id="datepicker" readonly="true"
										tabindex="3" />
								</span>
							</div>
							<div class="par">
								<div class="buttonwrap">
									<input name="" type="submit" value="Search" tabindex="4">
								</div>
							</div>
							<div class="clear"></div>
							
						</form:form>
						</div>
						<c:choose>
							<c:when test="${getMethod eq true}">
							</c:when>
							<c:when test="${getMethod ne true && empty jobsList}">
			   No Records Found
			   </c:when>
							<c:otherwise>
							<div class="whitebackground margin_top2">
								<div class="par">
									<table class="table table-bordered" id="dyntable">
										<thead>
											<tr>
												<th width="14%" class="table_centeralign">Job Id</th>
												<th width="46%" class="table_centeralign">Job Title</th>
												<th width="12%" class="table_centeralign">Posted On</th>
												<th width="12%" class="table_centeralign">Responses</th>
												<th width="16%" class="table_centeralign">Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${jobsList}" var="jobsDetails" varStatus="loopCount">
												<tr>
												<input type="hidden" value="${jobsDetails.jobIdAndFirmId}" />
													<td class="table_centeralign"><c:out
															value="${jobsDetails.jobId}" /></td>
													<td class="table_centeralign"><c:out
															value="${jobsDetails.jobTitle}" /></td>
													<td class="table_centeralign"><fmt:parseDate
															value="${jobsDetails.postedOn}" type="DATE"
															pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn" /> <fmt:formatDate
															type="date" value="${postedOn}" pattern="yyyy-MM-dd" /></td>
													<td class="table_centeralign"><c:out
																value="${jobsDetails.responseCount}"></c:out><!-- </a> --></td>			
													<td class="table_centeralign">
													<c:choose>
													<c:when test="${jobsDetails.responseCount eq 0}">
													</c:when>
													<c:otherwise>
													<a class="center_align hover" onclick="createReport(this.id)" id="${loopCount.index}">Execute</a>
													</c:otherwise>
													</c:choose>																										
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								</div>
								<div class="clear"></div>
								<br>
							</c:otherwise>
						</c:choose>			

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