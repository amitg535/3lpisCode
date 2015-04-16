<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Company Profile Preview</title>
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
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />

<style>
#navlist li
{
	display: inline-block;
	list-style-type: none;
	padding-right: 20px;
	width:16%;
}
.width250
{
	width:250px;
}
.icon-plus-sign{background: url("images/expand_b.png") no-repeat left top;width: 21px;
  height: 21px;margin-top:0 !important;}
.icon-minus-sign{background: url("images/collapse_b.png") no-repeat left top;width: 21px;
  height: 21px; margin-top:0 !important;}
</style>

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
 
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
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
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>


<script type="text/javascript">
  $(function()
  {
	  $(document).on("click",".applyBtn",function(){
			var jobId = $(this).parents('tr').attr('id');
			
			$.ajax
			({
				 	async : false,
				 	cache : false,		 
					url : 'candidate_apply_job.json?jobId='+jobId+'&bookmarkJob=true',
					success : function(data)
					{
						//Make the button look blue
						successFlag=true;	
			
						//$(this).parent().find('.saveactive').show();
					},
					error : function(xhr,error)
					{
						console.log("Error while Applying to job");
					}
		   });
			
			if(successFlag){
				$(this).attr("src","images/correct_icn_disable.png");
				$(this).attr("title","Already Applied");
				}
		});
	  
		 $(document).on("click",".saveBtn",function(){
				var jobId = $(this).parents('tr').attr('id');
				
				$.ajax
				({
					 	async : false,
					 	cache : false,		 
						url : 'candidate_save_job.json?jobId='+jobId+'&bookmarkJob=true',
						success : function(data)
						{
							//Make the button look blue
							successFlag=true;	
				
							//$(this).parent().find('.saveactive').show();
						},
						error : function(xhr,error)
						{
							console.log("Error while Saving job");
						}
			   });
				
				if(successFlag){
					$(this).attr("src","images/saved_active_icn.png");
					$(this).attr("title","Already Saved");
				}
			});	
		
	  
	  $("#allJobsDiv").hide();
	  $(".icon-minus-sign").hide();
	  
	  $("span.icon-minus-sign").click(function(){
		  $("#allJobsDiv").toggle();
		  $(".icon-plus-sign").show();
		  $(".icon-minus-sign").hide();
	  });
		
	  $("span.icon-plus-sign").click(function(){
		  $("#allJobsDiv").toggle();
		  $(".icon-minus-sign").show();
		  $(".icon-plus-sign").hide();
	  });
	  
	  
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

	 // $('a.title').cluetip({splitTitle: '|'});
		
  });
</script>
<script>
var referrer;
var referrerUrl;
$(document).ready(function(){	

	referrer =  document.referrer;
 	if(referrer.indexOf("?") > -1)
    {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.lastIndexOf("?"));        	
    }
 	else
    {
 		referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.length);
    }
});
function goBack(){

	if(referrerUrl == 'campus_internship_preview.htm' || 'campus_job_preview.htm')
		window.location.href=referrer;
	else
  		window.history.back();
}
</script>


        <script>
           var $pop = Popcorn("#home_video1"),
        image = document.createElement("image");

        image.id = "capture";
        image.style.marginLeft = "10px";

        $pop.listen("canplayall", function() {

                this.media.parentNode.appendChild( image );

                this.listen("oncepersecond", function() {

                        if ( this.roundTime() % 2 ) {
                                this.capture({
                                        target: "img#capture",
                                        // do not set the poster
                                        set: false
                                });
                        }

                }).play();

        });

        // * "oncepersecond" is a special event hook available here:
        // https://gist.github.com/1074031
       </script>

</head>
<body class="dashboard">
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take your career to the next level"></div>
    </div>
   
    <div id="innersection">
    <!--   <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \  Company Profile</div> -->
       <section id="leftsection" class="floatleft">
    <div class="candidate_quickaction_wrap floatleft">
     <div class="portfolio_img"> 
           							<c:choose>
											<c:when test="${not empty employerDetails.imageName}"> 
												<img src="view_image.htm?emailId=<c:out value="${employerDetails.emailID}"/>">
											</c:when>
											<c:otherwise>
						                       <img src="/images/Not_available_icon1.png" width="100" height="32" alt="">
						                    </c:otherwise>
						           </c:choose>
        					</div>
      
       
        <div class="candidate_upcomingevents_wrap" style="padding-top: 0;padding-bottom: 0;">
          <h2 class="invitation_heading"><c:out value="${employerDetails.companyName}"></c:out></h2>
          <div class="greytext" style="margin-top:10px;"> <c:out value="${employerDetails.addressLine1}"></c:out></br>
            <c:out value="${employerDetails.city}"/> ,<c:out value="${employerDetails.postalCode}" /> ,
            <c:out value="${employerDetails.state}" /><c:out value="${employerDetails.country}" /><br>
             <span> Registration No:</span><c:out value="${employerDetails.companyRegNumber}" />
             </div>
        </div>
      <div class="line-border floatleft">&nbsp;</div>
        <!-- <div class="left_video_container"> -->
      
      <c:if test="${ not empty employerDetails.brochureName || not empty employerDetails.fileNameVideo }">
      
        <div class="floatleft width100 candidate_upcomingevents_wrap whitebackground margin_top2">
      	<h2 class="invitation_heading">More About Us</h2>
		          <c:choose>
		          	<c:when  test="${ not empty employerDetails.brochureName }">
		          		 <a title='<c:out value="${employerDetails.linkedInAddress}"/>' href='view_brochure.htm?companyName=<c:out value="${param.companyName}"/>'  id="temp1" class="active center_align display" target="_blank">
					          <img src="images/pdfIcon.gif" alt="" class=""> 
					         <!--  <span style="padding-left: 85px;">Open</span> -->
				          </a>
				   </c:when>
		          <%-- <c:otherwise>
		          		   <i class="center_align display"><img src="images/pdfIcon.gif"  alt="" class="center_align display"> </i>
		          </c:otherwise> --%>
		          </c:choose>
	         
          
           <c:if test="${not empty employerDetails.fileNameVideo }">
	     	   <div class="center_align display">
		            <video id="home_video1" class="video-js vjs-default-skin display center_align" controls width="160" height="150">
		            <!-- MP4 source must come first for iOS -->
		            <source type="video/mp4"src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
		            <!-- WebM for Firefox 4 and Opera -->
		            <source type="video/wmv" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />"  />
		            <!-- OGG for Firefox 3 -->
		            <source type="video/ogg" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />"  />
		            
		            <source type="video/mp3" src="view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />"  />
		            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
		            <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
		                  <param name="movie" value="flashmediaelement.swf" />
		                  <param name="flashvars" value="controls=true&amp;file=view_video.htm?emailId=<c:out value="${employerDetails.emailID}" />" />
		                  <!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed --> 
		                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
		                </object>
		          </video>
	          
	          </div>
          </c:if>
          
       </div>
              <script>var homePlayer=_V_("home_video1");</script> 
     </c:if>   
    </div>
    
    
    </section>
      <section id="rightwrap" class="floatleft">
    <%--   <c:forEach   var="employerDetails" items="${employerDetails}">  --%>
       		
       
       <%-- <c:out value="${empdetailpreviewreg}"></c:out> --%>
      <!--   <h1 class="sectionheading">Company Profile</h1> -->
      
       						
        
        <div class="subheading_divider whitebackground">
	        <h1 class="sectionheading">Who We Are</h1>
	        <p class="about_text "><c:out value="${employerDetails.companyDesc}" /></p>   
        </div>
        
        <div class="subheading_divider whitebackground">
	        <%-- <h1 class="sectionheading">Offerings of ${employerDetails.companyName}</h1> --%>
	        
	         <h1 class="sectionheading">View All Jobs by ${employerDetails.companyName}
	          <span class="icon-minus-sign showcnt floatright"></span>
	        <span class="showcnt floatright icon-plus-sign"></span>
	         </h1>
	       
	       <%--  <p class="about_text "><c:out value="${employerDetails.companyDesc}" /></p>  --%>
        
        
        
        <div id="allJobsDiv" class="margin_top2 doublebottom_margin padding_bottom">
	
<%-- 			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching" id="recentJobsTable">
				<tbody>
				
					<c:forEach items="${allEmployerJobs}" var="jobDetails">
						<tr>
						<!-- <td width="5%">
							<div class="floatleft" style="width:10%;">
								<img src="view_image.htm?emailId=netflix@caerus.com" height="35" width="35">
							</div>
						</td> -->
						<td width="20%">
							<span class="boldtxt">
								<a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId=<c:out value="${jobDetails.jobIdAndFirmId}"/>">
			                		<c:out value="${jobDetails.jobTitle}"/>
			                	</a>
		                	</span>
		                	<br>
		                </td>
						<td width="10%"><c:out value="${jobDetails.location}"/></td>
						<td width="15%">
							<fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formattedDate"/>
							 <fmt:formatDate type="date" value="${formattedDate}" pattern="${displayDateFormat}"/> <br/> 
							</td>
						</tr>
					</c:forEach>


			  </tbody>
		</table> --%>
	
	
	<div class="clear"></div>
        <a name="event"></a>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching">
          <tr>
            <!-- <th width="5%">&nbsp;</th> -->
            <th width="25%" class="text-left">Job Title</th>
            <th width="20%">Location</th>
            <!-- <th width="20%">Company</th> -->
            <th width="11%">Job Type</th>
             <th width="12%">Job Posted</th> 
             <th width="12%" style="text-align:center">Actions</th> 
          </tr>
          <c:forEach items="${allEmployerJobs}"  var="jobDetails" varStatus="status">
          
          <tr id="${jobDetails.jobIdAndFirmId}">
            <!-- <td>&nbsp;</td> -->
            <td>
            	<span class="boldtxt"><a href="candidate_preview_listed_job.htm?jobId=<c:out value="${jobDetails.jobIdAndFirmId}"></c:out>"><c:out value="${jobDetails.jobTitle}"/></a></span><br/>
            </td>
            <td><c:out value="${jobDetails.location}"/></td>
          <%--   <td><a href="profile_preview.htm?companyName=${recommendedjobs.companyName}"><c:out value="${recommendedjobs.companyName}"/></a></td> --%>
            <td><c:out value="${jobDetails.jobType}"/></td>
           <!--   <td>15 mins</td>  -->
             <td>
             	<fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formattedDate"/>
			  	<fmt:formatDate type="date" value="${formattedDate}" pattern="${displayDateFormat}"/> 
			  </td>
             
             <td class="table_centeralign">
             <span>
             </span>
            <c:choose>
	             <c:when test="${savedJobIds.contains(jobDetails.jobIdAndFirmId)}">
	             <img src="images/saved_active_icn.png"  class="table_actionbtn saveactive" alt="Saved" title="Already Saved"> 
	              <%-- <a onclick="javascript:localStorage.setItem('clickedJobId','${recommendedjobs.jobIdAndFirmId}');" href="#myModal1" data-toggle="modal" class="share"> --%>
		             
			    </c:when>
	             <c:otherwise>
	             <img src="images/saved_icn.png" alt="Bookmark your jobs" class="table_actionbtn saveBookmark saveBtn" title="Save" >
	            <%--   <a onclick="javascript:localStorage.setItem('clickedJobId','${recommendedjobs.jobIdAndFirmId}');" href="#myModal1" data-toggle="modal" class="share"> --%>
			 	<%-- <a class="share callToolTip" id="${status.index}">            
             		<img src="images/share_icn.png" alt="Share Your Jobs" class="table_actionbtn" title="Share">
               </a> --%>
	             </c:otherwise>
             </c:choose>
		         
		         
		      <c:choose> 
		       	<c:when test="${! appliedJobIds.contains(jobDetails.jobIdAndFirmId)}">
		       		<a class="callToolTip" id="${status.index}">  
		             	<img src="images/correct_icn.png" alt="Apply To Job" class="table_actionbtn applyBtn" title="Apply">
		            </a>
		       	</c:when>
             	<c:otherwise>
             		<img src="images/correct_icn_disable.png" alt="Applied" class="table_actionbtn" title="Already Applied">
             	</c:otherwise>
             </c:choose>     
             	<%-- <a class="share callToolTip" id="${status.index}">  
		             	<img src="images/share_icn.png" alt="Share Your Jobs" class="table_actionbtn" title="Share">
		        </a> --%>
             
             </td>
          </tr>
        </c:forEach>
          
        </table>
		<%-- <h1 class="sectionheading">All Jobs By ${param.companyName}<span>(<c:out value="${allJobCount}"/>)</span></h1> --%>
       
            <div class="clear"></div>
         
         
         
         
         
		</div>  
        
        
       </div> 
        
        
        
         <c:if test="${not empty  employerDetails.workingWithUs}">
	        <div class="subheading_divider whitebackground">
		         <h1 class="sectionheading">Work Culture at <c:out value="${employerDetails.companyName}" /></h1>
		         <p class="about_text"><c:out value="${employerDetails.workingWithUs}" /></p> 
	        </div>
        </c:if>
       
        <c:if test="${not empty  employerDetails.hiringProcess}">
	        <div class="subheading_divider whitebackground width98 floatleft">
	        <h1 class="sectionheading"> Hiring Process</h1>
	        <c:set var="hiringProcess" value="${employerDetails.hiringProcess}" />
	        <div class="floatleft width100">
								<div>
									<ul class="tabs" id="hplist">
									</ul>
								</div>
			</div>
			</div>
        </c:if>
        <div class="clear"></div>
        
        <!-- Company Locations -->
          
            <c:if test="${not empty  employerDetails.companyLocations}">
          	
          	 <div class="subheading_divider whitebackground floatleft"  style="width:97.9%;">
          	 <h1 class="sectionheading">Office Locations</h1>
           	 <div class="fullwidth_form">
  				<div class="par">
               	<div class="reponses_listing_wrap clear">
  					<div class="details_wrap" style="width:97.3%;">          
   							<ul class="tagslists">
	                    		<c:forEach items="${employerDetails.companyLocations }" var="companyLocation">
	                    			<li style="font-size:15px;">
		                    			<span class="title" title='<c:out value="${companyLocation.value}"/>'>
		                    				<c:out value="${companyLocation.key}"/>
		                    			</span>
	                    			</li>
	                    		</c:forEach>
	                    	</ul>
                 		 </div>
           			</div>
         		</div>
        	  </div>
            </div>
        </c:if>
        <div class="clear"></div>
          
        
        <!-- </div> -->
        <!-- <div class="rgt_video_container"> Video Container</div> -->
        <div class="clear"></div>
        
        
        
        <div class="subheading_divider whitebackground">
         <h1 class="sectionheading">Get In Touch With Us</h1>
        <div class="reg_number width100">
          <ul  style="width:50%;">
          <li><span class="boldtxt">Website :</span><a href="<c:out value="${employerDetails.companyWebsite}" />" class="noline" target="_blank"> <c:out value="${employerDetails.companyWebsite}" /> </a></li>
           <li><span class="boldtxt">Phone :</span><c:out value="${employerDetails.phoneNumber}" /></li>
         <%--    <li><span class="boldtxt"> Registration No:</span><c:out value="${employerDetails.companyRegNumber}"></c:out></li> --%>
            <li><span class="boldtxt"> Industry : </span> <c:out value="${employerDetails.industry}"></c:out></li>
            <li><span class="boldtxt"> No. of Employees : </span> <c:out value="${employerDetails.noOfEmployees}"></c:out></li>
           
          </ul>
          
          <ul style="width:50%;" class="floatleft">
            <li><span class="boldtxt"> Contact Person : </span> <c:out value="${employerDetails.contactPersonName}"></c:out></li>
            <li><span class="boldtxt">Email Id :</span><c:out value="${employerDetails.emailID}" /> </li>
            <li><span class="boldtxt">Fax Number:</span><c:forEach items="${employerDetails.faxNumbers}" var="faxNumber"><c:out value="${faxNumber}"></c:out></c:forEach> </li>
            <c:if test="${not empty employerDetails.linkedInAddress}">
            <li><span class="boldtxt">Linked In :</span> <a href="<c:out value="${employerDetails.linkedInAddress}" />" class="noline" target="_blank"><img src="images/linkedin_grey.gif" alt="Linkedin Url" style="display:inline;"> &nbsp;&nbsp;<c:out value="${employerDetails.linkedInAddress}" /></a></li>
            </c:if>
          </ul>
        </div>
       
        <div class="clear"></div>
          
     
        <div class="form_wrap">
          <div id="candidate_registration_wrap">
            <form class="stdform" action="">
            <div class="fullwidth_form">
  				<div class="par">
                <div class="buttonwrap">
         <% 
		 	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String authority = auth.getAuthorities().toString();
			int mid = authority.lastIndexOf("_");
		 	String role = authority.substring(mid+1, authority.length()-1);
		 	pageContext.setAttribute("role", role); 
		%>
                    <!-- <input name="" type="button" value="Back" tabindex="17"> -->
                    <c:if test="${role == 'CORPORATE'}"> 
                     <input name="" type="button" value="Edit" tabindex="17" onClick="window.location.href='employer_manage_profile.htm'" />
					</c:if>
					 <input name="" type="button" value="Back" tabindex="18" onClick="goBack()"/>
           		</div>
           </div>  
            </div>
          </form>
        </div>
        </div>
        </div>
    <%--     </c:forEach> --%>
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
<!-- <script>Cufon.now();</script> -->


<script type="text/javascript">

$(window).load(function(){
	var hiringProcess = "${hiringProcess}";

	if($.trim(hiringProcess) != '')
	{
		var array = new Array();
		array = hiringProcess.split(",");

		$.each(array, function( index, value ) {
			$("#hplist").last().append('<li><span class="bullet_number">'+ (index+1) +'</span>   '+value+'</li>');
		});
	}
});
</script>

</body>
</html>