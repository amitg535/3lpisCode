<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Employer Manage Campus Job Responses</title>
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
  <link rel="stylesheet" href="css/jplayer.pink.flag.css" type="text/css" />

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
  <script type="text/javascript" src="js/jquery.ui.dialog.js"></script>
  <script src="js/jquery.dropdownPlain.js"></script>
  <script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="js/jquery.ui.button.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
 
  <script type="text/javascript">
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
  </script>
<script type="text/javascript">
$(document).ready(function(){

 /* Code Added by TulsiC,PallaviD and BalajiI  Starts */

/** Fetching all the trs on the page */	
var labels=$("table.responseslisting").find('tr.bg');

$(".candidateStatus").click(function()
{
	var clickedStatus = $(this).text();
	var statusArray = clickedStatus.split("(");
	clickedStatus = statusArray[0].trim();
	
	$("tr.bg").each(function(index){

		var pageStatus = $(this).find('.candidate_status').text().trim();

			if(clickedStatus =="All")
			{
				$(this).show();
			}
			else
			{
				if(pageStatus != clickedStatus)
					$(this).hide();
				else
					$(this).show();
			}
		});
});

});

function redirectToSourcePage()
{
	/* var sourcePage = localStorage.getItem("sourcePage");
	location.href = sourcePage; */
	window.history.back();
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
       
        <section id="rightwrap" class="floatleft">
        <h1 class="sectionheading"> <c:out value="${jobTitle}"/> at <c:out value="${companyName}"/> <c:out value="${location}"/> <span>(<c:out value="${count}"/>)</span></h1>
      
        <div class="reponses_subheader">

            <div class="leftsection top_margin"><span class="boldtxt">Date of Posting:</span>
            <fmt:parseDate value="${date}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
             <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/><span class="boldtxt">| Status:</span> <span class="activecolor">Active</span></div>
            <div class="clear"></div>
          
          <c:if test="${headRole == 'CORPORATE'}">
       <form class="stdform" id="generateResults">
            <div class="rightsection list_widthstyle5 clear" style="float:left;">
            <span class="sortas_title">Sort As:</span>
                <ul>
                    <li>
                    <c:choose>
                    <c:when test="${totalStudentsCount == 0}">
                    <li>
                    <span class="candidateStatus" >All (<c:out value="${totalStudentsCount}"/>)</span>
                    </li>
                    </c:when>
                    <c:otherwise>
                    <li>
                    <a class="candidateStatus" >All (<c:out value="${totalStudentsCount}"/>)
                    </a>
                    </li>
                    </c:otherwise>
                    </c:choose>
                    
                    
                    <c:choose>
                    <c:when test="${shortlistedStudentCount == 0}">
                    <li>
                    <span>Shortlisted (<c:out value="${shortlistedStudentCount}"/>)</span>
                    </li>
                    </c:when>
                    <c:otherwise>
                    <li>
                    <a class="candidateStatus" >Shortlisted (<c:out value="${shortlistedStudentCount}"/>)
                    </a>
                    </li>
                    </c:otherwise>
                    </c:choose>
                    
                    
                    <c:choose>
                    <c:when test="${onHoldStudentCount == 0}">
                    <li>
                    <span>OnHold (<c:out value="${onHoldStudentCount}"/>)</span>
                    </li>
                    </c:when>
                    <c:otherwise>
                    <li>
                    <a class="candidateStatus" >OnHold (<c:out value="${onHoldStudentCount}"/>)
                    </a>
                    </li>
                    </c:otherwise>
                    </c:choose>
                    
                    <c:choose>
                    <c:when test="${rejectedStudentCount == 0}">
                    <li>
                    <span>Rejected (<c:out value="${rejectedStudentCount}"/>)</span>
                    </li>
                    </c:when>
                    <c:otherwise>
                    <li>
                    <a class="candidateStatus" >Rejected (<c:out value="${rejectedStudentCount}"/>)
                    </a>
                    </li>
                    </c:otherwise>
                    </c:choose>
                </ul>
          </div>
          </form>
       </c:if>
       </div>
       
             <c:set var="count" value="${count}"/>
			<c:if test="${count == 0}">
			<div class="error_message_span validationnote">No results Found</div>
			</c:if>
			
			<div>            
            <c:if test="${not empty model.exceptionMessage}">
			<div class="errorblock">${model.exceptionMessage}</div>
			</c:if></div>
          
        <div id="responses" class="reponses_listing_wrap">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting">
          <tr>
                <td colspan="2" class="padding_bottom">&nbsp;</td>
              </tr>
      <c:forEach var="listForCandidate" items="${appliedStudentDetails}"> 
            <tr class="bg whitebackground">
                <td>
                <div class="image_wrap">
                	<div class="candidate_photo">
					<c:choose>
					<c:when test="${listForCandidate.photoName == null}">
					<img src="images/Not_available_icon1.png"  width="100" height="100" alt="">					  
					</c:when>
					<c:otherwise>
                    <img src="view_image.htm?emailId=<c:out value="${listForCandidate.emailID}"/>" width="100" height="100" alt="" />
                    </c:otherwise>
                     </c:choose>
 					</div>
 					<div class="candidate_status orangetxt">
                
	              	 <c:choose>  
							<c:when test="${appliedStudentEmailsWithStatus.containsKey(listForCandidate.emailID) }">
								<c:choose>
									 <c:when test="${appliedStudentEmailsWithStatus.get(listForCandidate.emailID).equals('Applied')}"> <c:out value=""> </c:out> 
								 </c:when>
								<c:otherwise> 
								<c:out value="${appliedStudentEmailsWithStatus.get(listForCandidate.emailID)}"></c:out>
								</c:otherwise>
							 </c:choose>
						  </c:when>
					</c:choose>	
					              
          			 </div>
 					
                    </div>
                <div class="details_wrap">
                    <div class="sectionleft floatleft"><a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>&campus=true"/> 
                    <c:out value="${listForCandidate.firstName}"></c:out> 
                    <c:out value="${listForCandidate.lastName}"></c:out> , 
                    <c:out value="${listForCandidate.city}"></c:out>, 
                    <c:out value="${listForCandidate.state}"></c:out></a>
                    <div class="clear"></div>
                   <span class=" boldtxt"><c:out value="${listForCandidate.universityDetails.universityCourseName}"></c:out>,</span>&nbsp;<span><c:out value="${listForCandidate.universityDetails.universityName}"></c:out>,</span>
                   <span class=" boldtxt">GPA of <c:out value="${listForCandidate.universityDetails.universityGpaFrom}"/> of <c:out value="${listForCandidate.universityDetails.universityGpaTo}"/></span>
                    </div>
                <div class="sectionright floatright"><span>Applied On : <fmt:parseDate value="${listForCandidate.appliedDate}" type="DATE" pattern="dd-MM-yyyy" var="formatedDate"/>
             <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/></span></div>
                    <div class="clear"></div>
                    <p class="description"><c:out value="${listForCandidate.aboutYourSelf}"></c:out></p>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                        <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        <c:forEach items="${listForCandidate.primarySkills}" var="skills" >  
                        <li><c:out value="${skills}"/></li>
                        </c:forEach>     

						</td>
                      </tr>
                  </table>
                 <ul class="actions_icns floatright top_margin">        
                   <li>
                   <c:if test="${not empty candidateDetails.videoName}">
                    <a data-toggle="modal" class="buttonSelect" href="#myModal"><span style="margin-top:7px;">
                    <img src="images/video_icn.png" alt="video"></span>Video Profile
                    </a>
                    </c:if>
                    </li>
              	<c:if test="${headRole == 'CORPORATE'}">
                 	<li><a href="employer_shortlist_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                    <li><a href="employer_put_candidate_onhold_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                    <li><a href="employer_reject_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
           </c:if>
                </ul>
                  </div>
                
                <div class="clear"></div></td>
              </tr>
              <tr><td height="15px"></td></tr>
           </c:forEach>
              </table>
         
        
       
          </div>
          
           <!--  <input type="hidden" value="localStorage.getItem('sourcePage')" id="locationRedirect"> -->
            <!--  <div class="table_centeralign"><input type="button" value="Back" onclick="redirectToSourcePage()"></div> --> 
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