<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->

        <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Jobs From Campus</title>
        <meta name="title" content="">
        <meta name="description" content="">
        <meta name="author" content="Your Name Here">
        <meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

        <!-- Mobile Specific Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
        <!-- Mobile Specific Metas -->

        <!-- CSS -->
        <link rel="stylesheet" href="../mobile_html/css/style.css">
        <link type="text/css" rel="stylesheet" href="../mobile_html/css/mmenu.css" />
        <!-- CSS -->

        <!-- Favicons -->
        <link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
        <link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
        <link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
        <link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
        <!-- Favicons -->

        <!--<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>-->
        <script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="../mobile_html/js/jquery.mmenu.js"></script>
        <script src="../mobile_html/js/jquery.fs.selecter.js"></script> 
        <script type="text/javascript" language="javascript" src="../mobile_html/js/menu.js"></script>
        <script type="text/javascript">
			//	The menu on the right
			$(function() {
				$('nav#menu-right').mmenu({
					position: 'left'
				});
				//	Click a menu-item
				var $confirm = $('#confirmation');
				$('#menu-right a').not( '.mmenu-subopen' ).not( '.mmenu-subclose' ).bind(
					'click.example',
					function( e )
					{
						e.preventDefault();
						$confirm.show().text( 'You clicked "' + $(this).text() + '"' );
						$('#menu-right').trigger( 'close' );
					}
				);
			});
		</script>
   
 <script type="text/javascript">
$(document).ready(function(){
	 var slc=4;
	 $("ul.search_listing li").slice(slc).hide();
    	$(window).scroll(function(){
		if  ($(window).scrollTop() == $(document).height() - $(window).height()){
			  //alert("Bottom Reached");
			  $("ul.search_listing li:hidden").slice(0,slc).show();
		  }
		});
   	});
</script>


<!-- 
        </script>
     -->
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="student">

	<div id="main_wrap">
<%@ include file="includes/header.jsp"%>	
				
		<div id="mid_wrap" class="midwrap_toppadding">
			
			<div class="clear"></div>
			<section id="inner_container">
			<c:set var="broadcastedCount" value="0" scope="page"/>
        	<c:forEach items="${employerJobListForUniversity}" var="employerJobListForUniversity">
            <c:if test="${employerJobListForUniversity.status=='Broadcasted'}">
            <c:set var="broadcastedCount" value="${broadcastedCount + 1}" scope="page"/>
            </c:if>
            </c:forEach>
				<h1 class="page_heading">
					Search Results <span class="orange_font">(<c:out
							value="${broadcastedCount}" />)</span>
				</h1>
					<c:if test="${msg!=null}">
						<div class="margin20_top margin20_bottom">You've Successfully applied to this job!</div>
						</c:if>
				<c:choose>
					<c:when test="${count == 0}">
						<div class="margin20_top margin20_bottom">No Results to Display</div>
					</c:when>
					<c:otherwise>
						
					
							<div class="search_listing_wrap" >
							
								<ul class="search_listing">	
							<c:forEach items="${employerJobListForUniversity}" var="jobDetails">
							<c:if test="${jobDetails.status=='Broadcasted'}">
									<li onclick = "location.href='campus_job_preview.htm?jobId=${jobDetails.jobIdAndFirmId}&&universityName=${jobDetails.universityName}'"><a href="#">
										<c:choose>
											<c:when test="${jobDetails.photoName ne null}"> 
											<div class="company_logo">
											<a href="profile_preview.htm?companyName=${jobDetails.firmName}">
                   							<img src="view_image.htm?emailId=${jobDetails.firmId}"/></a>
											</div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						              
											<h1 class="heading">
												<a href="campus_job_preview.htm?jobId=${jobDetails.jobIdAndFirmId}&&universityName=${jobDetails.universityName}">
												<c:out value="${jobDetails.jobTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<a href="employer_profile_preview.htm?companyName=${jobDetails.firmName}"><c:out value="${jobDetails.firmName}"></c:out></a>
												,
												<c:out value="${jobDetails.jobLocation}" />
											</h2>
											<div class="jobtype">
												<c:out value="${jobDetails.functionalArea}" />
												, 
												<span class="postedon">Posted on 
												<fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>

											</div>
										</a>
									</li>
									</c:if>
									</c:forEach>
								</ul>
							</div>
						
					</c:otherwise>
				</c:choose>

				<div class="clear"></div>

		
<!-- <div id="lastPostsLoader"> -->

			</section>
		</div>
		   <div id="push"></div>
	</div>
<%--  <%@ include file="includes/footer.jsp"%> --%>
	
</body>
</html>