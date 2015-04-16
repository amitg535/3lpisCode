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

      <meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Job Listing</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->


<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>

<script src="../mobile_html/js/script.js" type="text/javascript"></script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>
<script src="../mobile_html/js/portfolio_linkedIn_script.js" type="text/javascript"></script>
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

<!-- Added by PallaviD to display modify search div(18/07/2014) -->	
	<script type="text/javascript"> 
	 function modifySearchDivShow(){
		   $("#modifySearchDiv").show();

		   var selectedCriteria = $("input[name=searchCriteria]:checked").val();

			if (selectedCriteria == "internships") 
			 {
				 $("#industry").css('display','none');
			 }
			
		   
		}  

	 function searchJobsInternships(searchCriteria)
	 {
	 	 if (searchCriteria == "jobs") 
	 	 {
	 		 $("#industry").css('display','block');
	 	 }
	 	 else
	      {
	 		 $("#industry").css('display','none');
	 	 }
	 }

		
	</script>
	
    <script type="text/javascript">
		$(document).ready(function(){

			var selectedCriteria = $("input[name=searchCriteria]:checked").val();

			if (selectedCriteria == "internships") 
			 {
				 $("#industry").css('display','none');
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

<!-- 
        </script>
     -->
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>


<body class="student">
 
	
<div id="main_wrap">
  <%@ include file="includes/header.jsp"%>		 
		
		<div id="mid_wrap" class="midwrap_toppadding">
			<%-- <div id="submenu">
				<ul class="nav nav-pills">
				<c:if test="${role=='ANONYMOUS'}">
					<li class="active"><a href="home.htm">Search<span class="active_arrow"></span></a></li>
					</c:if>
					<c:if test="${role!='ANONYMOUS'}">
					<li class="active"><a href="candidate_dashboard.htm">Search<span class="active_arrow"></span></a></li>
					<li><a href="candidate_detail_view.htm">Profile</a></li>
					<li><a href="candidate_applied_jobs.htm">Jobs</a></li>
					  </c:if>
				</ul>
			</div> --%>
			<div class="clear"></div>
			<section id="inner_container">
				<h1 class="page_heading">
					Search Results <span class="orange_font">(<c:out
							value="${count}" />)</span>
					<input type="button" name="modifySearch"  value="Modify Search" id="modifySearch" class="orangebuttons" onclick="modifySearchDivShow()">
				</h1>
				
				<div id="modifySearchDiv" class="form_wrap" style="display: none;">
           
              <form:form action="candidate_search_jobs_internships.htm" method="post" modelAttribute="searchJobsCommand" cssClass="stdform" id="advancedSearch">
              <div class="par">
              <span id = "searchErrorLabel"></span>
              
                  <label class="floatleft" style="padding-top:0.2em"><strong>Search By:</strong> &nbsp;</label>
                <span class="formwrapper" >
              
                <c:choose>
                <c:when test="${criteria eq 'Jobs' || criteria eq 'jobs'}">
              <%--  <form:radiobutton path="searchCriteria" class="css-checkbox"  value="Jobs" checked = "checked"  OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; --%>
               
               <label class="label_radio">
			           	<input type="radio" name="searchCriteria"  id="searchCriteria1" class="css-checkbox" checked="true"  value="jobs" onclick="searchJobsInternships('jobs')"/>
			          	Jobs</label>
                
               </c:when>
               <c:otherwise>
              <%--  <form:radiobutton path="searchCriteria" class="css-checkbox"  value="Jobs" OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; --%> 
               <label class="label_radio">
			           	<input type="radio" name="searchCriteria"  id="searchCriteria1" class="css-checkbox" value="jobs" onclick="searchJobsInternships('jobs')"/>
			          	Jobs</label>
               </c:otherwise>
               </c:choose>
               
               <c:choose>
			<c:when test="${criteria eq 'Internships' || criteria eq 'internships'}">
						
               <%--  <form:radiobutton path="searchCriteria" class="css-checkbox"  value="Internships" checked="checked" OnClick="showhideFaculty('internships')" />Internships --%>
                
                <label class="label_radio">
			            <input type="radio" name="searchCriteria"  class="css-checkbox" checked="true" id="searchCriteria2" value="internships" onclick="searchJobsInternships('internships')" />
			            Internships</label>
                
                </c:when>
                <c:otherwise>
                <%-- <form:radiobutton path="searchCriteria" class="css-checkbox"  value="Internships" OnClick="showhideFaculty('internships')" />Internships --%>
               
                 <label class="label_radio">
			            <input type="radio" name="searchCriteria"  class="css-checkbox"  id="searchCriteria2" value="internships" onclick="searchJobsInternships('internships')" />
			            Internships</label>
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
				  <form:input path="keyword" cssClass="input-medium" id="keywords" value="${searchParametersMap[keyName]}"/>
                  <form:errors path="keyword"  cssClass="input-medium"/>                
                  </span> 
               </div>
                <div class="par" id="city">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                  <span class="field">
                  <c:set var="keyName" value="location" />  
                  <form:input path="location" cssClass="input-medium" value="${searchParametersMap[keyName]}" />
                  <form:errors path="location"  cssClass="input-medium"/>
                  </span> 
            	</div>

              </div>
              
             
             <div class="par" id="functionalarea">
               <label>Functional Area</label>
             <c:set var="keyName" value="functionalArea" />
               <form:select data-placeholder="Choose an Option" path="functionalArea" cssClass="chzn-select list_widthstyle1" style="width: 345px;" >
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
                
                <div class="par" id="industry">
                  <label class="floatleft">Industry</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                  <c:set var="keyName" value="industry" />
                  <form:select data-placeholder="Choose an Option" path = "industry"  cssClass="chzn-select list_widthstyle1" style="width: 345px;">
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
                
            
            
              <div class="clear"></div>
             
               	<input name="search" type="submit" class="orangebuttons" value="Search" >
 
            </form:form>
        </div>  
       <%--  </c:if> --%>
	<div class="clear"></div>
				
		
					<c:if test="${msg!=null}">
						<div class="margin20_top margin20_bottom">You've Successfully applied to this job!</div>
						</c:if>
				<c:choose>
					<c:when test="${count==0}">
						<div class="margin20_top margin20_bottom">No Results to Display</div>
					</c:when>
					<c:otherwise>
						
					
							<div class="search_listing_wrap" >
							
								<ul class="search_listing">	
								<c:choose>
								   <c:when test="${criteria=='Jobs'}">
								<c:forEach items="${searchJobs}" var="searchJobs">
									<li onclick = "location.href='candidate_preview_listed_job.htm?jobId=<c:out value="${searchJobs.jobIdAndFirmId}"/>'"><a href="#">
											
											<c:set var="photoName" value="${searchJobs.emailId}" />
										<c:choose>
											<c:when test="${not empty searchJobs.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${searchJobs.emailId}"/></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						               
											<h1 class="heading">
												<a href="candidate_preview_listed_job.htm?jobId=<c:out value="${searchJobs.jobIdAndFirmId}"/>"><c:out
														value="${searchJobs.jobTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${searchJobs.companyName}"></c:out>
												,
												<c:out value="${searchJobs.location}" />
											</h2>
											<div class="jobtype">
												<%-- <c:out value="${searchJobs.natureOfJob}" />
												,  --%>
												<span class="postedon">Posted on 
												<fmt:parseDate value="${searchJobs.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>

											</div>

									</a></li>
									
									</c:forEach>
									</c:when>
									
							 <c:when test="${criteria=='Internships'}">
								<c:forEach items="${searchJobs}" var="searchJobs">
									<li onclick = "location.href='candidate_preview_listed_internship.htm?internshipId=<c:out value="${searchJobs.internshipIdAndFirmId}"/>'"><a href="#">
											
											<c:set var="photoName" value="${searchJobs.emailId}" />
										<c:choose>
											<c:when test="${not empty searchJobs.emailId}"> 
											<div class="company_logo"><img src="view_image.htm?emailId=${searchJobs.emailId}"/></div>
											</c:when>
											<c:otherwise>
						                      <div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
						                      </c:otherwise>
						                </c:choose>
						               
											<h1 class="heading">
												<a href="candidate_view_internship.htm?internshipId=<c:out value="${searchJobs.internshipIdAndFirmId}"/>"><c:out
														value="${searchJobs.internshipTitle}" /></a>
											</h1>
											<h2 class="subheading">
												<c:out value="${searchJobs.companyName}"></c:out>
												,
												<c:out value="${searchJobs.location}" />
											</h2>
											<div class="jobtype">
												<c:out value="${searchJobs.internshipType}" />
												, 
												<span class="postedon">Posted on 
												<fmt:parseDate value="${searchJobs.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOn"/>
												<fmt:formatDate type="date" value="${postedOn}" pattern="dd-MMM-yyyy" /></span>

											</div>

									</a></li>
									
									</c:forEach>
									</c:when>
									</c:choose>
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
 <%-- <%@ include file="includes/footer.jsp"%> --%>
	
</body>
</html>