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
<title>Profile Views</title>
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
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>
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
			 // alert("Bottom Reached");
			  $("ul.search_listing li:hidden").slice(0,slc).show();
		  }
		});
		
   	});

function clickme()
{
	window.location.href="candidate_viewed_by_companies_thin_client.htm?viewAll=viewAll";
}
</script>

<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="student">

	<div id="main_wrap">
<%@ include file="includes/header.jsp"%>	
				
		<div id="mid_wrap" class="midwrap_toppadding">
			
			<div class="clear"></div>
			<section id="inner_container">
			<h1 class="page_heading">Profile Views</h1>
			<div class="search_listing_wrap" >
			
		<c:choose>
			<c:when test="${not empty noViews}">
			You have received no profile views in recent days.<a class="viewAll" href="candidate_portfolio.htm">Update your profile now</a>
			</c:when>
			
			<c:when test="${not empty recentViews}">
			You have received no profile views in the last 10 days.<a onclick='clickme()'>View past profile views</a>
			</c:when>
			
			<c:otherwise>
				<ul class="event_listing removearrow">	
							<c:forEach items="${viewedByCompaniesMap}" var="viewedByCompaniesMap">		
								<li>
								<h1 class="heading">Viewed By: <c:out value="${viewedByCompaniesMap.key}" /> </h1>
								
								<h2 class="subheading">On: <c:out value="${viewedByCompaniesMap.value}" /> </h2>
								</li>
							</c:forEach>
						</ul>
			</c:otherwise>
			
		</c:choose>
		<c:if test="${(empty noViews && empty recentViews) && empty viewAll}">
			<div class="viewmore viewAll"><a onclick='clickme()' style="float: right;">View past profile views</a></div>
			</c:if>
			</div>
				<div class="clear"></div>

			</section>
		</div>
		   <div id="push"></div>
	</div>
	
</body>
</html>