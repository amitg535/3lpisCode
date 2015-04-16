<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Internal Postings</title>
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
  
  <script type="text/javascript" src="js/jquery.pajinate.js"></script>
		<script type="text/javascript">
    		$(document).ready(function(){
				$('.paging_container8').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
						
			});     
                
	</script>  
  <script>
  
  $(document).ready(function() {
	  
    var showChar = 360;
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
    
    
    $(".apply").mouseover(function() {$(this).attr("src", "images/correct_icn_disable.png");});

    $(".apply").mouseout(function() { $(this).attr("src", "images/correct_icn.png");});
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
    <div id="innerbanner">
      <div id="banner">
      <img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!" ></div>
      <div class="clear"></div>
    </div>
    
    <div id="innersection">
        <!-- div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_internal_postings.htm"> Internal Postings </div> -->
        <section id="rightwrap" class="floatleft">
            
            <c:set var="broadcastedCount" value="0" scope="page"/>
        	<c:forEach items="${employerJobListForUniversity}" var="employerJobListForUniversity">
	            <c:if test="${employerJobListForUniversity.status=='Broadcasted'}">
	            <c:set var="broadcastedCount" value="${broadcastedCount + 1}" scope="page"/>
	            </c:if>
            </c:forEach>
        <h1 class="sectionheading"> Jobs From Your University <span>(<c:out value="${internalPostingCount}"/>)</span></h1>
      
       <div class="clear"></div>
     
        
        <c:choose>
           <c:when test="${internalPostingCount == 0}">
     		<c:out value="No Records to Display"/>
   		</c:when>
		<c:otherwise>
		<div class="paging_container8">
        <div class="job_listing_wrap">
            <ul class="jobslisting">        
            
            <c:forEach items="${internalPostings}" var="internalPosting">
            <c:if test="${internalPosting.status ne draftStatus}">
            <li>
            
                <div class="details">
                
                	<div class="jobtitle floatleft">
	                	<a href="internal_internship_preview.htm?internshipIdAndFirmId=${internalPosting.internshipIdAndFirmId}&universityName=${internalPosting.universityName}">
	                	<c:out value="${internalPosting.internshipTitle}"/>
	                	</a>
                	</div> 
                    
                    <div class="floatright jobtype"><c:out value="${internalPosting.internshipType}"/></div> 
                    <div class="clear"></div>
                    <div class="bottom_margin"><span class="orangetxt boldtxt">                   
                     <a href="view_university_profile.htm?universityName=${internalPosting.universityName}">
                    <c:out value="${internalPosting.universityName}"/></a>
                    
                    </span>, <c:out value="${internalPosting.location}"/></div>
                    <div class="description comment more"><c:out value="${internalPosting.internshipDescription}"/></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                    <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        <c:forEach items="${internalPosting.primarySkills}" var="primarySkills">
                        	<li><c:out value="${primarySkills}"/></li>
                        </c:forEach>
                      
                        
                        
                      </ul></td>
                  </tr>
                  </table>
                </div>
                
              <div class="actionsbtns">
                   <div class="date" style="border-bottom:0px solid #000;"> 
                   <fmt:parseDate value="${internalPosting.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formattedDate"/>
                   <fmt:formatDate type="date" value="${formattedDate}" pattern="${displayDateFormat}" /> <br/> 
                <%--   <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/> --%>
                  
                  <%-- <c:out value="${internalPosting.postedOn}" /> --%>
                  </div>
                  
                  <c:choose>
						<c:when test="${! appliedInternalPostingIds.contains(internalPosting.internshipIdAndFirmId)}">
							<a href="candidate_apply_internal_posting.htm?internshipIdAndFirmId=<c:out value="${internalPosting.internshipIdAndFirmId}" />&universityName=${internalPosting.universityName}">
								<div class="buttonwrap">
									<img src="images/correct_icn.png" alt="Apply Job" class="apply">
									<br />Apply
								</div>
							</a>
						</c:when>
						<c:otherwise>
							<div class="buttonwrap">
									<img src="images/correct_icn_disable.png" alt="Applied">
									<br />Already Applied
								</div>
						</c:otherwise>
				</c:choose>
         
             </div>
          
                <div class="clear"></div>
            </li>
            </c:if>
            
             </c:forEach>
                         
         </ul>
       
          </div>
          
          <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
          
          </div>
          </c:otherwise>
          </c:choose>
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
