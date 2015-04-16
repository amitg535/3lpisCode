<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>University Jobs and Internships Listing</title>
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
  <script src="js/jquery.dropdownPlain.js"></script>
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
  
  <script>
	function checkConfirm(){
		return confirm("Are you sure want to delete this record ?");
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
       <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / <a href="#">Jobs / Internships  </a> /  View Job &amp; Internships</div> -->
        <%-- <section id="leftsection" class="floatleft">
        <h3 class="nomargin"> Jobs / Internships</h3>
        <ul class="leftsectionlinks">
            <li class="active">View Job / Internships</li>
            <li><a href="#">View Campus  Jobs / Internships</a></li>
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
            <input name="" type="text" class="textbox">
            <input name="" type="button" value="Subscribe">
          </form>
          </div>
      </section> --%>
        <section id="rightwrap" class="floatleft">
        
        
          <div class="actionlegend_wrap floatright ">
                <ul>
                <li>Actions Legends:</li>
                <li><img src="images/green_circle.png">Broadcasted</li>
                <li><img src="images/red_circle.png">Published</li>
               <!--  <li><img src="images/grey_circle.png">Closed</li> -->
              </ul>
         </div>
        
        <div id="candidate_registration_wrap">
       
        <h1 class="sectionheading floatleft">View Jobs </h1>
<!--             <div class="actionlegend_wrap floatright doubletop_margin"> -->
<!--             <ul> -->
<!--                 <li>Actions Legends:</li> -->
<!--                 <li><img src="images/green_circle.png">Posted</li> -->
<!--                 <li><img src="images/grey_circle.png">Closed</li> -->
<!--               </ul> -->
<!--           </div> -->
            <div class="clear"></div>
            <div class="whitebackground margin_top2">
            <div class="par">
            <table class="table table-bordered" id="dyntable">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="46%" class="table_leftalign">Job Title</th>
                    <th width="11%" class="table_leftalign">Posted by</th>
                    <!-- <th width="13%" class="table_leftalign">Status</th> -->
                    <th width="13%" class="table_leftalign">Posted on</th>
                    <th width="12%" class="table_leftalign">Responses</th>
                    <th width="10%" class="table_leftalign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                
                 <c:forEach items="${campusJobs}" var="campusJob"> 
                <tr>                
               			    <c:choose>
      							<c:when test="${campusJob.status eq 'Published'}">
                    				 <td class="table_centeralign"><img src="images/red_circle.png" alt=""/></td>
                    				 <td><a href="campus_job_preview.htm?jobId=<c:out value="${campusJob.jobId}" />_<c:out value="${campusJob.firmId}"/>&universityName=<c:out value="${campusJob.universityName}"/>"><c:out value="${campusJob.jobTitle}" /></a></td>
					                 <td class="table_centeralign"><c:out value="${campusJob.firmName}" /> </td>
					                 <%-- <td class="table_centeralign"><c:out value="${campusJob.status}" /></td> --%>
					                 <td class="table_centeralign">
						                <%--  <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
	            						 <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/> --%>
            						 	<c:out value="${campusJob.postedOn}" />
            						 </td>
					                 <%-- <c:out value="${campusJob.postedOn}" /> --%>
					                 
					                 <c:choose>
					                 <c:when test="${fn:length(campusJob.campusJobAppliedStudents) != 0}">
					                 <td align="center"><a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}"></c:out>&universityName=<c:out value="${campusJob.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></a></td>
					                 </c:when>
					                 <c:otherwise>
					                 <td align="center">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></td>
					                 </c:otherwise>
					                 </c:choose>
					                 
				                     <td class="table_centeralign">
				                     <a href="university_campus_jobs_internships.htm?jobId=<c:out value="${(campusJob.jobIdAndFirmId)}"></c:out>&jobAction=Closed"  onclick="return checkConfirm()">
					                     <img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete">
				                     </a>
					                 <a href="university_campus_jobs_internships.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}"/>&jobAction=Broadcasted">
					                 <img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Job" title="Broadcast Job"></a></td>
                    			</c:when>
                    			
                    			<c:when test="${campusJob.status eq 'Broadcasted'}"> 
                    				<td class="table_centeralign"><img src="images/green_circle.png" alt=""/></td>
                    				 <td><a href="campus_job_preview.htm?jobId=<c:out value="${campusJob.jobId}" />_<c:out value="${campusJob.firmId}"/>&universityName=<c:out value="${campusJob.universityName}"/>"><c:out value="${campusJob.jobTitle}" /></a></td>
                    				 <td class="table_centeralign"><c:out value="${campusJob.firmName}" /> </td>
                    				 <%-- <td class="table_centeralign"><c:out value="${campusJob.status}" /></td> --%>
                    				 <td class="table_centeralign">
                    				 <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
            						 <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/> --%>
            						 <c:out value="${campusJob.postedOn}" />
            						 </td>
                    				 <%-- <c:out value="${campusJob.postedOn}" /> --%>
                    				 <c:choose>
					                 <c:when test="${fn:length(campusJob.campusJobAppliedStudents) != 0}">
					                 <td align="center"><a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}"></c:out>&universityName=<c:out value="${campusJob.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></a></td>
					                 </c:when>
					                 <c:otherwise>
					                 <td align="center">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></td>
					                 </c:otherwise>
					                 </c:choose>
                    				 <td class="table_centeralign"><!--  <img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"> --></td> 
                    			</c:when>
                    			
                    			<c:otherwise>
                    				<td class="table_centeralign"><img src="images/grey_circle.png" alt=""/></td>
                    				 <td><a href="campus_job_preview.htm?jobId=<c:out value="${campusJob.jobId}" />_<c:out value="${campusJob.firmId}"/>&universityName=<c:out value="${campusJob.universityName}"/>"><c:out value="${campusJob.jobTitle}" /></a></td>
				                     <td class="table_centeralign"><c:out value="${campusJob.firmName}" /> </td>
				                     <%-- <td class="table_centeralign"><c:out value="${campusJob.status}" /></td> --%>
				                     <td class="table_centeralign">
					                     <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
	            						 <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/> --%>
            						 <c:out value="${campusJob.postedOn}" />
            						 </td>
				                    <%--  <c:out value="${campusJob.postedOn}" /> --%>
				                    
				                 	 <c:choose>
					                 <c:when test="${fn:length(campusJob.campusJobAppliedStudents) != 0}">
					                 <td align="center"><a href="view_campus_job_responses.htm?jobId=<c:out value="${campusJob.jobIdAndFirmId}"></c:out>&universityName=<c:out value="${campusJob.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></a></td>
					                 </c:when>
					                 <c:otherwise>
					                 <td align="center">
					                 <c:out value="${fn:length(campusJob.campusJobAppliedStudents)}"></c:out></td>
					                 </c:otherwise>
					                 </c:choose>
				                     <td class="table_centeralign"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></td>
                    			</c:otherwise>
                    		</c:choose>                            
                   
                  </tr>
                  </c:forEach>
                
                
               
              </tbody>
              </table>
          </div>
         </div>
         <div class="clear"></div>
         
        
        </div>
          
         
          
            <h1 class="sectionheading floatleft doubletop_margin margin_top2">View Internships</h1>
            <div class="clear"></div>
             <div class="whitebackground">
            <div class="par">
            <table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
                    <th width="4%" class="nosort">&nbsp;</th>
                    <th width="31%" class="table_leftalign">Internship Title</th>
                    <th width="14%" class="table_leftalign">Posted by</th>
                   <!--  <th width="13%" class="table_leftalign">Status</th> -->
                    <th width="14%" class="table_centeralign">Posted on</th>
                    <th width="12%" class="table_centeralign">Responses</th> 
                    <th width="10%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                
                 <c:forEach items="${campusInternships}" var="campusInternship"> 
                	<tr> 
                			<td class="table_centeralign">
									<c:choose>
      									<c:when test="${campusInternship.status eq 'Published' }">
                    							<img src="images/red_circle.png" alt=""/>
                    					</c:when>
		                    			<c:when test="${campusInternship.status eq 'Broadcasted' }">
		                    				<img src="images/green_circle.png" alt=""/>
		                    			</c:when>
		                    			<c:otherwise>
		                    				<img src="images/grey_circle.png" alt=""/>
		                    			</c:otherwise>
                    			   </c:choose>
								
								</td>

                    				 <td><a href="campus_internship_preview.htm?internshipId=<c:out value="${campusInternship.internshipIdAndFirmId}" />&universityName=<c:out value="${campusInternship.universityName}"/>"><c:out value="${campusInternship.internshipTitle}" /></a></td>
					                 <td><c:out value="${campusInternship.firmName}" /> </td>
					                <%--  <td class="table_centeralign" id="JobStatus${loopCount.count}">
					                 	<c:out value="${campusJob.status}" />
					                 </td> --%>
					                 <td class="table_centeralign">
					                 <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/> --%>
            						<%--  <fmt:formatDate  value="${campusJob.postedOn}" pattern="dd-MM-yyyy"/> --%>
            						  <%-- <fmt:parseDate value="${campusJob.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                    				  <fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy" /> --%>
                    				  
                    				  <c:out value="${campusInternship.postedOn}" />
            						</td>
					                 
					                 <c:choose>
					                 <c:when test="${fn:length(campusInternship.campusInternshipAppliedStudents) != 0}">
					                 <td align="center"><a href="view_campus_internship_responses.htm?internshipIdAndFirmId=<c:out value="${campusInternship.internshipIdAndFirmId}" />&universityName=<c:out value="${campusInternship.universityName}"/>"  class="center_align">
					                 <c:out value="${fn:length(campusInternship.campusInternshipAppliedStudents)}"></c:out></a></td>
					                 </c:when>
					                 <c:otherwise>
					                  <td align="center">
					                 <c:out value="${fn:length(campusInternship.campusInternshipAppliedStudents)}"></c:out></td>
					                 </c:otherwise>
					                 </c:choose>
					      		 <c:choose>  
						             <c:when test="${campusInternship.status eq 'Published'}">
						                 <td class="table_centeralign">
						                 <a href="university_dashboard.htm?job_id=<c:out value="${campusInternship.internshipIdAndFirmId}"/>&job_action=Closed" onclick="return checkConfirm()"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></a>
						               
						               <a href="university_campus_jobs_internships.htm?internshipId=<c:out value="${campusInternship.internshipIdAndFirmId}"/>&internshipAction=Broadcasted">
					                 <img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Job" title="Broadcast Job"></a></td> 
						                
						               
	                    			</c:when>
	                    			
	                    			<c:when test="${campusInternship.status eq 'Broadcasted'}"> 
	                    			 <td class="table_centeralign"><!-- <img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"> --></td> 
	                    			</c:when>
	                    			
	                    			<c:otherwise>
	                    			<td class="table_centeralign"><img src="images/small_delete_icn.png" class="table_actionbtn" alt="Delete" title="Delete"></td>
	                    			</c:otherwise>
                    			</c:choose> 	
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
<script type="text/javascript" src="js/nav_script.js"></script> 

</body>
</html>