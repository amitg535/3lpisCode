<%@ page language="java"
	import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Internal Postings</title>
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
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />

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
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript">
	$(function() {
		$('#wysiwyg1').wysiwyg({
			controls : {
				increaseFontSize : {
					visible : true
				},
				decreaseFontSize : {
					visible : true
				}
			}
		});
		$('#wysiwyg2').wysiwyg({
			controls : {
				increaseFontSize : {
					visible : true
				},
				decreaseFontSize : {
					visible : true
				}
			}
		});
	});
</script>

<script>
	function checkConfirm() {
		return confirm("Are you sure want to delete this Internship ?");
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
			<!-- <div id="innerbanner_wrap">
        <div><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div> -->


			<div id="innersection">
				<!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / <a href="university_campus_jobs_internships.htm">Jobs /&nbsp; Internships  </a> / Internal Postings </div> -->
				<section id="rightwrap" class="floatleft">


					<h1 class="sectionheading floatleft">View Postings</h1>
					<!-- <div class="floatright"> <input type="button" value="Some"></div> -->
					<a href="university_post_internship.htm">
						<div class="postajob_wrap">
							<img src="images/university_icn.png" alt="Post an Internship"
								title="Post a Job">Post an Internship
						</div>
					</a>
					<div class="whitebackground floatleft width100">
						<div id="candidate_registration_wrap">
							<div class="clear"></div>
							<div class="par">

								<c:choose>
									<c:when test="${empty internalPostings}">
										<div class="clear"></div>
										<label class="emptyMsg"> No Internships posted by You.
											<a href="university_post_internship.htm">Post an
												Internship soon </a>
										</label>
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
													<th width="46%" class="table_leftalign">Job Title</th>
													<th width="13%" class="table_leftalign">Status</th>
													<th width="13%" class="table_leftalign">Posted on</th>
													<th width="12%" class="table_leftalign">Responses</th>
													<th width="10%" class="table_leftalign nosort">Actions</th>
												</tr>
											</thead>
											<tbody>

												<c:forEach items="${internalPostings}" var="internalPosting">
													<tr>

														<c:choose>
															<c:when
																test="${internalPosting.status eq jobStatusDraft}">
																<td class="table_centeralign"><img
																	src="images/red_circle.png" alt="" /></td>
															</c:when>
															<c:when
																test="${internalPosting.status eq jobStatusPublished}">
																<td class="table_centeralign"><img
																	src="images/green_circle.png" alt="" /></td>
															</c:when>
															<c:otherwise>
																<td class="table_centeralign"><img
																	src="images/grey_circle.png" alt="" /></td>
															</c:otherwise>
														</c:choose>

														<td><a
															href="internal_internship_preview.htm?internshipIdAndFirmId=<c:out value="${internalPosting.internshipIdAndFirmId}" />"><c:out
																	value="${internalPosting.internshipTitle}" /></a></td>
														<td class="table_centeralign"><c:out
																value="${internalPosting.status}" /></td>
														<td class="table_centeralign"><fmt:parseDate
																value="${internalPosting.postedOn}" type="DATE"
																pattern="E MMM dd HH:mm:ss Z yyyy"
																var="internshipPostedOn" /> <fmt:formatDate type="date"
																value="${internshipPostedOn}" pattern="${jobDateFormat}" />
														</td>


														<c:choose>
															<c:when
																test="${internalPosting.appliedStudents.size() != 0}">
																<td align="center"><a
																	href="view_internal_posting_responses.htm?internshipIdAndFirmId=${internalPosting.internshipIdAndFirmId}"
																	class="center_align"> <c:out
																			value="${internalPosting.appliedStudents.size() }" /></a></td>
															</c:when>
															<c:otherwise>
																<td align="center">0</td>
															</c:otherwise>
														</c:choose>
														<td class="table_centeralign"><c:choose>
																<c:when
																	test="${internalPosting.status ne jobStatusPublished }">
																	<a
																		href="university_delete_internal_internship.htm?internshipIdAndFirmId=<c:out value="${internalPosting.internshipIdAndFirmId}" />"
																		onclick="return checkConfirm()"><img
																		src="images/small_delete_icn.png"
																		class="table_actionbtn" alt="Delete" title="Delete"></a>
																</c:when>

																<c:when
																	test="${internalPosting.status ne jobStatusDraft }">
																	<a
																		href="university_edit_internal_internship.htm?internshipIdAndFirmId=<c:out value="${internalPosting.internshipIdAndFirmId}" />"><img
																		src="images/small_edit_icn.gif"
																		class="table_actionbtn" alt="Edit" title="Edit"></a>
																</c:when>
															</c:choose> <!--  <img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"> -->

															<a
															href="university_copy_internal_internship.htm?internshipIdAndFirmId=<c:out value="${internalPosting.internshipIdAndFirmId}" />"><img
																src="images/small_copy_icn.gif" class="table_actionbtn"
																alt="Copy Internship" title="Copy Internship"></a></td>

													</tr>
												</c:forEach>



											</tbody>
										</table>
									</c:otherwise>
								</c:choose>
							</div>

						</div>
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
	<script type="text/javascript" src="js/nav_script.js"></script>

</body>
</html>