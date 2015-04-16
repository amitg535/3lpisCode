<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Virtual Job Fairs</title>
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
</head>
<body>
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		<%@ include file="includes/header.jsp"%>
		<!--------------  Header Section :: end ------------>
		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
			<div id="innerbanner_wrap">
				<div id="banner">
					<img src="images/employer_innerbanner.jpg"
						alt="We will open the world of opportunities to take carrer to the next level">
				</div>
			</div>
			
			<div id="innersection">
				<!-- <div id="breadcrums_wrap">
					You are here: <a href="employer_dashboard.htm">Home</a> / <a
						href="employer_campus_connect.htm?selected=receivedInvitations">Campus Connect</a>
					/ Received Virtual Fair Invitations
				</div> -->
				<%-- <section id="leftsection" class="floatleft">
					<h3 class="nomargin">Campus Connect</h3>
					<ul class="leftsectionlinks">
						<li><a href="#">Manage Scheduled Events</a></li>
						<li>Received Invitations from Campus</li>
					</ul>
					<h3>Useful Links</h3>
					<ul class="leftsectionlinks">
						<li><a href="#">Background Check Services</a></li>
						<li><a href="#">Checklist Employee Contract</a></li>
						<li><a href="#">Hire Overseas Employees</a></li>
					</ul>
					<div id="newsletterwrap">
						<h3>Newsletter</h3>
						<form>
							<input name="" type="text" class="textbox"> <input
								name="" type="button" value="Subscribe">
						</form>
					</div>
				</section> --%>
				<section id="rightwrap" class="floatleft">
					<h1 class="sectionheading">Received Virtual Job Fair Invitations</h1>
					<div class="clear"></div>
					<div id="candidate_registration_wrap">
						<div class="par">
							<table class="table table-bordered" id="dyntable_five">
								<thead>
									<tr>
										<th width="50%" class="table_leftalign">Virtual Fair Name</th>
										<th width="20%" class="table_centeralign">Date</th>
										<th width="10%" class="table_centeralign">Status</th>
										<th width="10%" class="table_centeralign nosort">Actions</th>


									</tr>
								</thead>
								<tbody>
									<c:forEach items="${fairDetails}" var="fairDetails">

										<c:set var="myScheme" value="${pageContext.request.scheme}" />
										<c:set var="myServerName"
											value="${pageContext.request.serverName}" />
										<c:set var="myServerPort"
											value="${pageContext.request.serverPort}" />
										<c:set var="myContext" value="VJF" />
										<jsp:useBean id="now" class="java.util.Date" />
										<c:set var="today" value="${now}" />
										
										<fmt:formatDate var="todayDate" value="${now}" pattern="yyyy-MM-dd"/>
										<fmt:parseDate value="${fairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="fairDetailStartDate"/>
                                        <fmt:formatDate var="startDate" value="${fairDetailStartDate}" pattern="yyyy-MM-dd"/>
                                        <fmt:parseDate value="${fairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="fairDetailEndDate"/>
                                        <fmt:formatDate var="endDate" value="${fairDetailEndDate}" pattern="yyyy-MM-dd"/>
                                        
                                          <c:forEach items="${jobStatus}" var="jobStatus">
												<c:if test="${jobStatus.key eq fairDetails.virtualJobId}">
												 <c:if test="${jobStatus.value eq 'Accepted'}">
												   <c:set var="accepted" value="${jobStatus.value}" />
												   <%-- <c:out value="${accepted}" /> --%>
												 </c:if>
												</c:if>
											</c:forEach>  

										<tr>
											<td class="table_leftalign"><a
												href="employer_setup_preview.htm?fairId=<c:out value="${fairDetails.virtualJobId}"/>"><c:out
														value="${fairDetails.virtualJobName}" /></a> 
														
													<c:choose>
		                                               <c:when test="${(startDate <= todayDate) && (todayDate <= endDate) && (!empty accepted)}">
		                                               <a
														href="${myScheme}://${myServerName}:${myServerPort}/${myContext}/corporate_virtual_jobfair_chat.htm?fairId=<c:out value="${fairDetails.virtualJobId}"></c:out>"
														class="blueheading"> <img src="images/live.gif"
														width="51" height="18" alt="" class="inlineimg">
													   </a>
		                                               </c:when>
		                                            </c:choose>	
												</td>
											<td class="table_centeralign">
											<fmt:parseDate value="${fairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="virtualStartDate"/>
                                            <fmt:parseDate value="${fairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="virtualEndDate"/>
											 <fmt:formatDate type="date" value="${virtualStartDate}"
													pattern="dd-MM-yyyy" /> to <fmt:formatDate type="date"
													value="${virtualEndDate}" pattern="dd-MM-yyyy" /> <br />
												<c:out value="${fairDetails.startTime}" /> to <c:out
													value="${fairDetails.endTime}" /></td>
											<c:forEach items="${jobStatus}" var="jobStatus">
												<c:if test="${jobStatus.key eq fairDetails.virtualJobId}">
													<td class="table_centeralign"><c:out
															value="${jobStatus.value}" /></td>
												</c:if>
											</c:forEach>
											<%-- <c:choose>
				      <c:when test="${eventList.status=='Accepted' || eventList.status=='Rejected'}">
				     	<td class="table_centeralign"><a href="employer_manage_virtualfair_invitation.htm?fairId=<c:out value="${fairDetails.virtualJobId}"/>&action=undo">
						<img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>				
				      <c:otherwise> --%>
											<td class="table_centeralign">
											
											<c:forEach items="${jobStatus}" var="jobStatus">
												<c:if test="${jobStatus.key eq fairDetails.virtualJobId}">
												<c:set var="eventStatusVal" value="${jobStatus.value}"/>
												<c:choose>
													<c:when test="${(eventStatusVal eq 'Accepted') || (eventStatusVal eq'Rejected')}">
											<a href="employer_manage_virtualfair_invitation.htm?fairId=<c:out value="${fairDetails.virtualJobId}"/>&action=Pending">
						<img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a>
											
													</c:when>
													
													<c:otherwise>
											<a href="employer_manage_virtualfair_invitation.htm?fairId=<c:out value="${fairDetails.virtualJobId}"/>&action=Accepted"><img
													src="images/check_icn.gif" width="16" height="13"
													class="table_actionbtn"> </a> <a
												href="employer_manage_virtualfair_invitation.htm?fairId=<c:out value="${fairDetails.virtualJobId}"/>&action=Rejected"><img
													src="images/small_cancel_icn.gif" width="15"
													height="15" class="table_actionbtn"> </a>
													</c:otherwise>
													
												</c:choose>
												</c:if>
											</c:forEach>
													</td>
											
											<%--   </c:otherwise>
					</c:choose>  --%>
										</tr>

									</c:forEach>
								</tbody>
							</table>
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
	
	<div id="mask"></div>
</body>
</html>