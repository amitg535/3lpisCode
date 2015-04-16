<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Recommender View Recommendations</title>
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
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>
<link rel="stylesheet" href="css/dots.css" type="text/css">

 <link rel="stylesheet" href="css/jquery-ui-slider-pips.css" type="text/css"> 

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
<script type="text/javascript" src="js/jquery-loader.js"></script>
<script type="text/javascript" src="js/jquery.pajinate.js"></script>


<script type="text/javascript" src="js/jquery-ui-slider-pips.js"></script>
<script type="text/javascript">


$(document).ready(function(){

	$('.pending_paging_container').pajinate({
		num_page_links_to_display : 3,
		items_per_page : 10	
	});

	$('.submitted_paging_container').pajinate({
		num_page_links_to_display : 3,
		items_per_page : 10	
	});

	$("#a").css("display","block");
    $("#b").css("display","none");

    $("#completedRecos").click(function(){
        $("#b").css("display","block");
        $("#a").css("display","none");
        });

    $("#pendingRequests").click(function(){
        $("#a").css("display","block");
        $("#b").css("display","none");
        });
    
	var i =0;
    $('.recodiv').each(function(i){
        $(this)
            .attr("id", "id_" + i);
            
        i++;
    });

	var showChar = 100;
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


    $(".recommend").click(function(){
        $(this).closest('li').find('div.recodiv').show();
        });


    $(".recobtn").click(function(){

    	var parentElement = $(this).parent().prev();
    	var creativityRating = $(parentElement).find('#creativityRating').find("span.ui-slider-pip-selected").find("span.ui-slider-label").text();

    	var ethicRating = $(parentElement).find('#ethicRating').find("span.ui-slider-pip-selected").find("span.ui-slider-label").text();

    	var leadershipRating = $(parentElement).find('#leadershipRating').find("span.ui-slider-pip-selected").find("span.ui-slider-label").text();

    	var recommenderFirstName = $(parentElement).find("#recommenderFirstName").val();
        var recommenderLastName = $(parentElement).find("#recommenderLastName").val();
        var organization = $(parentElement).find("#organization").val();
        var yearsStudentKnown =$(parentElement).find("#yearsStudentKnown").val();
		var detailedReco = $(parentElement).find("#detailedReco").val();
		var yearsStudentKnown = $(parentElement).find("#yearsStudentKnown").val();
        var studentEmailId = $(this).closest('.jobslistingli').find('.studentemailid').text().trim();

        var recoDivId = $(this).closest('.recodiv').attr('id');
        
    	//jsp code
   	 $.ajax({
   	 
   		  	type : 'POST',
   		 	url : 'recommender_submit_recomendation.htm',						
   			cache : false,
   			data:
   			{
   				creativityRating: creativityRating,
   				leadershipRating: leadershipRating,
   				workEthicRating: ethicRating,
   				recommenderFirstName: recommenderFirstName,
   				recommenderLastName: recommenderLastName,
   				organization: organization,
   				yearsStudentKnown: yearsStudentKnown,
   				detailedReco: detailedReco,
   				studentEmailId: studentEmailId,
   				yearsStudentKnown: yearsStudentKnown
   				
   									
   			},

   			success: function(){
   				$('#'+recoDivId).hide();
   	   			},

   	        error: function(){
   	        	alert("error");
   	   	        }
   			
   	});

    });

  	$(".recodetails").click(function(){
  		 $(this).closest('li').find('div.completereco').show();
  	  	});
   
 // set up an array to hold the months
    var rating = ["Average", "Good", "Excellent", "Outstanding"];
    // lets be fancy for the demo and select the current month.
    var activeMonth = new Date().getMonth();

    $(".slider")
                        
        // activate the slider with options
        .slider({ 
            min: 0, 
            max: rating.length-1, 
          //  value: activeMonth 
        })
                        
        // add pips with the labels set to "months"
        .slider("pips", {
            rest: "label",
            labels: rating
        });
                       
   });

</script>

</head>
<body class="dashboard">
<div id="wrap">
 <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp" %>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     
     <div id="innerbanner_wrap">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
     </div> 
    
    
     <div id="innersection">
    
    <div class="clear"></div>
    <div class="container">
    
    <div id="tabs" class="ui-tabs-vertical">
   
       <ul class="ui-tabs-nav">
        
        <li  id="pendingRequests">
            <a href="#a" class="education blue"><span><c:out value="${pendingRequestCount}"/></span><label>Pending Requests</label></a>
        </li>
        <li id="completedRecos">
            <a href="#b" class="education green"><span><c:out value="${completedRecommendationCount}"/></span><label>Completed Requests</label></a>
        </li>
        
      </ul>
   
   
    <div id="a">
	
	<h1 class="sectionheading">Pending Requests<span>(<c:out value="${pendingRequestCount}" />)</span>
					</h1>

					<div class="clear"></div>

					 <div class="pending_paging_container">
					<div class="job_listing_wrap">
						<c:choose>
							<c:when test="${pendingRequestCount == 0}">
								<div class=""><c:out value="No Pending Recommendation Requests" /></div>
							</c:when>
							<c:otherwise>

								<ul class="jobslisting">

									<c:forEach items="${pendingRequestList}" var="pendingRequest">
										<li class="jobslistingli">

											<div class="details">
	
												<div class="jobtitle floatleft">
												    <c:out value="${pendingRequest.studentFirstName}"/> 
												      <c:out value="${pendingRequest.studentLastName}"/> 
												</div>
												
												<div class="clear"></div>
												<div class="bottom_margin">
													<span id="studenEmailId" class="orangetxt boldtxt studentemailid">								
											
						
                    <c:out value="${pendingRequest.studentEmailId}"></c:out>
													
													
													</span>,
												</div>
												 <div class="description comment more">
													<c:out value="${pendingRequest.requestMessage}" />
												</div>
											
											</div>
											<div class="actionsbtns">
												<div class="date">
													Requested On <br />
													
													<fmt:formatDate type="date" value="${pendingRequest.requestTime}"
														pattern="dd" />
													<br />
													<fmt:formatDate type="date" value="${pendingRequest.requestTime}"
														pattern="MMM" />
													<br />
													<fmt:formatDate type="date" value="${pendingRequest.requestTime}"
														pattern="yyyy" />
													<br />
												</div>
												<div class="clear"></div>
											
																	<div class="buttonwrap" >
																		<img src="images/correct_icn.png" class = "recommend" alt="Apply Job" >
																		<br />Recommend
																	</div> 
							
											</div>

											<div class="clear"></div>
											
											<div class="recodiv" style="display:none;">
											
											<p><c:out value="${pendingRequest.studentFirstName}"/> 
											 <c:out value="${pendingRequest.studentLastName}"/> 
										   has requested a recommendation for their profile on Imploy.me <br> 
										   Your valuable feedback will help candidate as well as employer a great deal in the decision making process </p>
										   
										   
											
										<form:form action="" method="post" modelAttribute="submitRecommendation" class="stdform" id="submitRecoForm"> 
										
										<div class="par ratingdiv">
										
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id="add_more_recruitmenttable">
<tr>
                     <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">First Name <span class="table_star">*</span></th>
                        <td width="39%" class="table_leftalign righ">
                        <form:input path="recommenderFirstName" class="input-small1" tabindex="9" placeholder="First Name" id="recommenderFirstName" value="${pendingRequest.recommenderFirstName}"/>
                        	<form:errors path="recommenderFirstName"  cssClass="validationnote"/>
                        
		                    	 </td> 
                        <th width="16%" class="table_leftalign">Last Name <span class="table_star">*</span></th>
                        <td width="39%"  class="table_leftalign">
                        <form:input path="recommenderLastName"  id="recommenderLastName" class="input-small1" tabindex="10" placeholder="Last Name" value="${pendingRequest.recommenderLastName}"/>
                        	<form:errors path="recommenderLastName"  cssClass="validationnote"/>
		                    	</td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
										
										
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">Organization <span class="table_star">*</span></th>
                        <td width="39%" class="table_leftalign">
                        <form:input path="organization" class="input-small1" tabindex="9" placeholder="Organization" id="organization" value="${pendingRequest.organization}"/>
                        	<form:errors path="organization"  cssClass="validationnote"/>
                        
		                    	 </td> 
                         <th width="16%" class="table_leftalign">How Long have you known the Candidate? <span class="table_star">*</span></th>
                        <td width="39%">
                        <div class="list_widthstyle2">
                            	<form:select path="yearsStudentKnown" tabindex="8" Class="uniformselect" id="yearsStudentKnown" items="${yearsStudentKnownList}" >
                            	</form:select> 
		                      	<%--  <form:errors path="functionalAreas"  cssClass="validationnote"/> --%>
                         </div>
                          
                        </td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
   <tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">Creativity Rating<span class="table_star">*</span></th>
                        <td width="39%" class="table_leftalign righ">
                       
                          <div id= "creativityRating"  class="slider"></div>
		                    	 </td> 
                                           
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         
                        <th width="16%" class="table_leftalign">Working Ethic Rating<span class="table_star">*</span></th>
                        <td width="39%"  class="table_leftalign">
                        <div id="ethicRating" class="slider"></div>
		                    	</td>
		                    	
		              </tr>
                    </table>
                    </td>
                  </tr>
                  
                  
 <tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        
		               <th width="16%" class="table_leftalign">Leadership Rating<span class="table_star">*</span></th>
                        <td width="39%"  class="table_leftalign">
                         <div id = "leadershipRating" class="slider"></div>
		                    	</td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">Could you please briefly describe the most noteworthy characterstics of the candidate that includes the strong points as well as the weak links<span class="table_star">*</span></th>
                        <td width="39%" class="table_leftalign">
                        
												<form:textarea path="detailedReco" class="input-large"
													id="detailedReco" style="height:100px;" tabindex="29" />
												<form:errors path="detailedReco" cssClass="validationnote" />
												<!-- <label class="error" id="errorWorkDescription"></label> -->
                        
                        
                        
                        
                          
                        	<form:errors path="detailedReco"  cssClass="validationnote"/>
		                    	 </td> 
                        
                      </tr>
                    </table>
                    </td>
                  </tr>
										
										</table>
										
										</div>
										<div class="par">
											<input  type="button" value="Submit" class="add_participants top_margin floatright recobtn"	>
										</div>
										<div class="clear"></div>

									 </form:form> 
											
											</div>
										</li>
									</c:forEach>

								</ul>
							</c:otherwise>
						</c:choose>
					</div>
					
					<c:if test="${pendingRequestCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
					
				</div>
	</div>
    
    
    <div id="b">
	
	<h1 class="sectionheading">Completed Recommendations<span>(<c:out value="${completedRecommendationCount}" />)</span>
					</h1>

					<div class="clear"></div>

					 <div class="submitted_paging_container">
					<div class="job_listing_wrap">
						<c:choose>
							<c:when test="${completedRecommendationCount == 0}">
								<div><c:out value="You have not submitted any Recommendation" /></div>
							</c:when>
							<c:otherwise>

								<ul class="jobslisting">

									<c:forEach items="${completedRecommendationList}" var="completedReco">
										<li class="jobslistingli">

											<div class="details">
	
												<div class="jobtitle floatleft">
												    <c:out value="${completedReco.studentFirstName}"/> 
												      <c:out value="${completedReco.studentLastName}"/> 
												</div>
												
												<div class="clear"></div>
												<div class="bottom_margin">
													<span id="studenEmailId" class="orangetxt boldtxt studentemailid">								
											
						
                    <c:out value="${completedReco.studentEmailId}"></c:out>
													
													
													</span>,
												</div>
												 <div class="description comment more">
													<c:out value="${completedReco.requestMessage}" />
												</div>
											
											</div>
											<div class="actionsbtns">
												<div class="date">
													Submitted On <br />
													
													<fmt:formatDate type="date" value="${completedReco.recommenderResponseTime}"
														pattern="dd" />
													<br />
													<fmt:formatDate type="date" value="${completedReco.recommenderResponseTime}"
														pattern="MMM" />
													<br />
													<fmt:formatDate type="date" value="${completedReco.recommenderResponseTime}"
														pattern="yyyy" />
													<br />
												</div>
												<div class="clear"></div>
											
											                        <div class="buttonwrap" >
																		<img src="images/correct_icn.png" class = "recodetails" alt="" >
																		<br /> Details
																	</div>
											   
							
											</div>

											<div class="clear"></div>
											
													<div class="par completereco" style="display:none;">
											
									
										
										<div class="par"> 
										
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id="add_more_recruitmenttable">

										
										
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        
                         <th width="16%" class="table_leftalign">How Long have you known the Candidate? </th>
                        <td width="39%">
                        <div class="list_widthstyle2">
                         <c:out value="${completedReco.yearsStudentKnown}"></c:out>
                            	
                         </div>
                          
                        </td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
   <tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">Creativity Rating:</th>
                        <td width="39%" class="table_leftalign righ">
                       
                       <c:out value="${completedReco.creativityRating}"></c:out>
		                    	 </td>  
                                           
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         
                        <th width="16%" class="table_leftalign">Working Ethic Rating:</th>
                        <td width="39%"  class="table_leftalign">
                        <c:out value="${completedReco.workEthicRating}"></c:out>
		                    	</td> 
		                    	
		              </tr>
                    </table>
                    </td>
                  </tr>
                  
                  
 <tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        
		               <th width="16%" class="table_leftalign">Leadership Rating:</th>
                        <td width="39%"  class="table_leftalign">
                        <c:out value="${completedReco.leadershipRating}"></c:out>
		                    	</td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
                  
<tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">Candidate Description provided by You:</th>
                        <td width="39%" class="table_leftalign">
                        
                        <p><c:out value="${completedReco.detailedReco}"></c:out></p>
											
		                    	 </td> 
                        
                      </tr>
                    </table>
                    </td>
                  </tr>
										
										</table>
										
										 </div>
										
										<div class="clear"></div>

									
											
											</div>
											
										</li>
									</c:forEach>

								</ul>
							</c:otherwise>
						</c:choose>
					</div>
					
					<c:if test="${completedRecommendationCount gt 10}">
          <div class="page_navigation"></div>
          </c:if>
					
				</div>
	</div>
   
   
   
   
   
   
   
   
   
   <!--tabs  -->
    </div>
    
    
    
    
    
    
    
    <!--container  -->
    </div>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!--innersection  -->
     </div>
    
    
    
    
    
    
    
   
   
   <!--mid container  -->
    </div>



<!--wrap  -->
</div>
Page test
</body>
</html>