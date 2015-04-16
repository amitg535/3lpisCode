<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.util.*" %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Employer Manage Responses</title>
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
  <link rel="stylesheet" href="css/dots.css" type="text/css">
   <link rel="stylesheet" href="css/jquery-loader.css" type="text/css">

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
  <script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="js/jquery.ui.button.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
  <script type="text/javascript" src="js/jquery-loader.js"></script>
  
  <style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal{
	width:690px !important;
	/*height: 470px !important;*/
	margin-left:-350px;
}
.modal-body{
height:auto;
}

</style>
  
  
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

		function getVideo(buttonId)
		{
		
		$("#jquery_jplayer_1").jPlayer( "destroy" );
		//var emailId=$('#'+buttonId).parents('.responseslisting').find("#emailId").val();
		var emailId = $('#'+buttonId).parents('.bg').attr('id');
		
		$("#jquery_jplayer_1").jPlayer({
			ready: function () {	
				$(this).jPlayer("setMedia", {
					m4v: "view_videoCV.htm?emailId="+emailId
				});
			},
				  
			swfPath: "js",
			supplied: "m4v",
			size: {
				width: "640px",
				height: "350px",
				cssClass: "jp-video-360p"
			},
			smoothPlayBar: true,
			keyEnabled: true
			
		});
	}

		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
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


			

			function getParameterByName( name ){
				  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
				  var regexS = "[\\?&]"+name+"=([^&#]*)", 
				      regex = new RegExp( regexS ),
				      results = regex.exec( window.location.href );
				  if( results == null ){
				    return "";
				  } else{
				    return decodeURIComponent(results[1].replace(/\+/g, " "));
				  }
				}

			var formulaName = getParameterByName("formulaName");
			
			if(formulaName.trim()){
				sortResponses();
				}

		 /* Code Added by TulsiC,PallaviD and BalajiI  Starts */

		/** Fetching all the trs on the page */	
		var labels = $("table.responseslisting").find('tr.bg');

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

		
	$("#generateScoresBtn").click(function (){
		sortResponses();
	});

		function setDomElements(candidateScore)
		{
				$.each(candidateScore , function(key,value){
					for(var i=0;i<labels.length;i++){
						if(key == labels[i].id){
							/** Replacing @ and . to escape jquery selectors */
						    key=key.replace("@","\\@");
						    key=key.replace(".","\\.");
	
							/** Appending the Stored Trs*/
							$("table.responseslisting").append(labels[i]);
	
							/** Appending Iscore Value */
							$("tr#"+key).find("label").empty().append("I Score: "+value);
						}
					}
					
				}); 
		}




		function sortResponses(){
			//$("table.responseslisting").empty();		
			var formulaSelect = $("#formula_Name").val();
			var jobIdAndFirmId = $("#jobIdAndFirmId").val();

			if(formulaSelect == "Default Formula")
			{
				//window.location.reload();
			}
			else
			{
				if (formulaSelect.trim())
				{	
					  	$.loader({content:"<div class='dots'> Loading...</div>"}); 
					  	 
					  $.ajax({
						  type: "POST",
					  url: "employer_generate_score.json?jobId="+jobIdAndFirmId,
					  data:'formulaName='+formulaSelect,
					  error:function(xhr,error)
					  {
						////$.loader('setContent', '<div style="color:#000000;">Sorry!<br /> This Formula Could not be Applied </div>');
						for(var i=0;i<labels.length;i++){
						$("table.responseslisting").append(labels[i]);
						}
						$.loader('close');
						console.log("Error");
					  },
					  success:function(candidateScores)
					  {
						$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
						setDomElements(candidateScores);
						$.loader('close');
					  }
					  
				});

				return true ;
				}
				else
				{
				  alert("Please select a Formula !!!");
				  return false;
				}
			}
		}
	
	});

		 /* Code Added by TulsiC,PallaviD and BalajiI Ends */
		
</script>

<script type="text/javascript">

</script>

  
<!--   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">
  </script> -->
  
  <!--   <script type="text/javascript">
  function downloadProfile(emailId,jobId){
  localStorage.setItem("emailId", emailId);
  localStorage.setItem("jobId", jobId);
	
  alert('emailId'+ emailId);
  
	$.ajax({
		
		url: 'employer_download_candidate_profile.htm',
		data : {
			'emailId' : emailId,
			'jobId': jobId,
		},
		cache : false,
		success : function(data) {
			
			$("#showStatus").empty();
			$("#showStatus").append("Download Complete.");
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
};
  </script>
  
  <script type="text/javascript">
	function emailCandidateProfile(candidateEmailIdModal) {
		
	var candidateEmailId = candidateEmailIdModal;
	var corporateEmailId=$("#corporateEmailId").val();
	var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if($("#corporateEmailId").val().length==0) {
		$("#validationMessage").html("Please enter email-id");
		
	}
	else if(pattern.test(corporateEmailId)==false){
		$("#validationMessage").html("Please enter valid email-id");
	}
	else{
		alert("Reached MAil Function");
	$.ajax({
 		
		url: '/employer_email_candidate_profile.htm',
		data : {
			'corporateEmailId' : corporateEmailId,
			'candidateEmailId' : candidateEmailId,
	   
		},
		cache : false,
		success : function(data) {
			$("#validationMessage").html("Your mail is sent Successfully");
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}}
</script>
   -->
  </head>
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
  
    <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
      
    
    <div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a>  / <a href="employer_jobs_internships.htm"> Jobs &amp; Internships </a> / Responses </div> -->
       
        <section id="rightwrap" class="floatleft">
        <h1 class="sectionheading"> <c:out value="${jobDetails.jobTitle}"/> at <c:out value="${companyName}"/>
         <c:out value="${jobDetails.location}"/> <span>(<c:out value="${totalStudentsCount}"/>)</span></h1>
      <input type="hidden" id="jobIdAndFirmId" value="${jobDetails.jobIdAndFirmId}">
      <!--  Changes 20-06-2013-->
        <div class="reponses_subheader">

            <div class="leftsection top_margin"><span class="boldtxt">Date of Posting : </span>
            <fmt:parseDate value="${jobDetails.postedOn}" type="DATE" pattern="${dbDateFormat}" var="formatedDate"/>
             <fmt:formatDate type="date" value="${formatedDate}" pattern="${displayDateFormat}" /><span class="boldtxt padding_left26"> Status : </span> 
             <c:if test="${jobDetails.status eq 'Published'}">
             <span class="activecolor">Active</span>
             </c:if>
             <c:if test="${jobDetails.status eq 'Closed'}">
             <span class="closecolor">Closed</span>
             </c:if>
             </div>
            
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
          <div class="rightsection ">
            <div class="left_searchfilter_label floatleft" style="padding-top: 0.5em;">By Formula &nbsp;&nbsp;</div>
               
                <div class="details floatleft">
		            <span class="formwrapper floatleft">
		           
		              <select data-placeholder="Choose an Option" class="chzn-select list_widthstyle1" name="formula_Name" id="formula_Name" style="margin-left:12px">
			               <c:forEach var="employerFormulaeName" items="${employerFormulaeNames}">
			             <c:choose>
			             	
			             	<c:when test="${ param.formulaName.equals(employerFormulaeName)}">
			             	 <option value="${employerFormulaeName}" selected="selected"><c:out value="${employerFormulaeName}"/></option>
			             	</c:when>
			             <c:otherwise>
			               <option value="${employerFormulaeName}"><c:out value="${employerFormulaeName}"/></option>
			             </c:otherwise>
			             </c:choose>	
			             
			             	
			             	  
			             	 <%--  <option value="${employerFormulaeName}"><c:out value="${employerFormulaeName}"/></option> --%>
			               </c:forEach>
		              </select>
		              </span>
	              <input type="button" value="Generate" id="generateScoresBtn"  class="floatleft" style="margin-left:15px;">
               </div>
               
          </div>
          </form>
          
            <div class="clear"></div>
          </div>
        <!--  Changes 20-06-2013-->
 
          
          <c:set var="count" scope="session" value="${totalStudentsCount}"/>
			<c:if test="${totalStudentsCount == 0}">
			<div class="error_message_span validationnote">No results Found</div>
			</c:if>
			
			<div>            
            <c:if test="${not empty model.exceptionMessage}">
			<div class="errorblock">${model.exceptionMessage}</div>
			</c:if></div>
          
        <div id="responses" class="reponses_listing_wrap">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting">

      <c:forEach var="candidateDetails" items="${appliedCandidates}"> 
            <tr class="bg whitebackground margin_top2" id="${candidateDetails.emailID}">
                <!-- <td class="table_topvertical_align right_padding"><input type="checkbox" name="check2" /></td> -->
                <td class="dummy">
                <div class="image_wrap">
                    <c:set var="candEmailId" value="${candidateDetails.emailID}"/>
                						<c:choose>
											<c:when test="${candidateDetails.photoName ne null}"> 
											<div class="candidate_photo"><img src="view_image.htm?emailId=${candidateDetails.emailID}" width="100" height="100" alt="" /></div>
											</c:when>
											<c:otherwise>
						                      <div class="candidate_photo"><img src="/images/Not_available_icon1.png" width="100" height="100" alt=""></div> 
						                      </c:otherwise>
						                </c:choose> 
                    <div class="candidate_status orangetxt">
					              	 <c:choose>  
											<c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && !appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('Applied')}">
											<c:out value="${appliedStudentEmailsWithStatus.get(candidateDetails.emailID) }"> </c:out>
										    </c:when>
									</c:choose>	
          			 </div>
				</div>
				
				
                <div class="details_wrap">
                    <div class="sectionleft floatleft">
                                        
                    <c:choose>
                    <c:when test="${not empty jobIdAndFirmId && jobIdAndFirmId ne 'null'}">
                     <a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span> 
                    </c:when>
                    
                     <c:when test="${not empty internshipIdAndFirmId && internshipIdAndFirmId ne 'null'}">
                     <a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span> 
                    </c:when>
                    <c:otherwise>
                      <a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${candidateDetails.emailID}"/>"><span> 
                    </c:otherwise> 
                    </c:choose>
                    
                    
                    <c:out value="${candidateDetails.firstName}"></c:out></span>  <span><c:out value="${candidateDetails.lastName}"></c:out></span>,&nbsp;
                    <span><c:out value="${candidateDetails.city}"></c:out>,<c:out value="${candidateDetails.state}"></c:out> </span></a>
                    
                   <div class="clear"></div>
                   <span class=" boldtxt"><c:out value="${candidateDetails.universityDetails.universityCourseName}"></c:out>,</span>&nbsp;<span><c:out value="${candidateDetails.universityDetails.universityName}"></c:out>,</span>
                   <span class=" boldtxt">GPA of <c:out value="${candidateDetails.universityDetails.universityGpaFrom}"/> of <c:out value="${candidateDetails.universityDetails.universityGpaTo}"/></span>
                   </div> 
                 <%-- <c:set var = "internship" value= <%=request.getParameter("internshipIdAndFirmId")%>></c:set> --%>
                 
                <div class="sectionright floatright"><span class="details iscorelabel"><label class="score"  ><span class="orangetxt boldtxt iScore">I-Score : </span><c:out value="${candidateDetails.IScore}" /></label></span></div>
                    <div class="clear"></div>
                    <p class="description comment more"><c:out value="${candidateDetails.aboutYourSelf}"></c:out></p>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                    <tr>
                        <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                        <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                        <c:forEach items="${candidateDetails.primarySkills}" var="skills" >  
                        <li><c:out value="${skills}"/></li>
                        </c:forEach>     

						</td>
                      </tr>
                  </table>
                  <c:set var="candidateEmailIdModal" value="${candidateDetails.emailID}"></c:set>
              
              <ul class="actions_icns floatright top_margin">        
              <c:choose>
              	<c:when test="${not empty internshipResponses && internshipResponses }">
              		
              	
                   <li>
                   <c:if test="${not empty candidateDetails.videoName}">
                    <a data-toggle="modal" class="buttonSelect" href="#myModal"><span style="margin-top:7px;">
                    <img src="images/video_icn.png" alt="video"></span>Video Profile
                    </a>
                    </c:if>
                    </li>
                <!--     <li><a href="#myModal1" data-toggle="modal"><span><img src="images/list_email_icn.png" alt="Email"></span>Email</a></li>
                    <li><a id="downloadProfile" href="#" onclick="downloadProfile('${candidateDetails.emailID}','
                    <%=request.getParameter("internshipIdAndFirmId")%>');"><span><img src="images/list_download_icn.png" alt="Email"></span>Download</a></li>
                 -->    
                 
                 <!-- Shortlist/OnHold/Reject buttons section for internship -->
                 <c:choose>
                  <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('Shortlisted')}">
                  <li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                  <li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                  </c:when>
                 	
                 
                 <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('OnHold')}">
                 <li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                 <li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                 </c:when>
                 
                 <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('Rejected')}">
                 <li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                 <li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                 </c:when>
                 
                 <c:otherwise>
                 <li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                 <li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                  <li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                 </c:otherwise>
                 </c:choose>	
           
           		<!-- Shortlist/OnHold/Reject buttons section for internship ends -->
           
              	</c:when>
              	<c:otherwise>
              	
                   <li>
                   <c:if test="${not empty candidateDetails.videoName}">
                    <a data-toggle="modal" class="buttonSelect" href="#myModal"><span style="margin-top:7px;">
                    <img src="images/video_icn.png" alt="video"></span>Video Profile
                    </a>
                    </c:if>
                    </li>
                <!--     <li><a href="#myModal1" data-toggle="modal"><span><img src="images/list_email_icn.png" alt="Email"></span>Email</a></li>
                    <li><a id="downloadProfile" href="#" onclick="downloadProfile('${candidateDetails.emailID}','
                    <%=request.getParameter("jobId")%>');"><span><img src="images/list_download_icn.png" alt="Email"></span>Download</a></li>
                 -->  
                 
                 
                 
                 <!-- Shortlist/OnHold/Reject buttons section for job -->
                 <c:choose>
                    <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('Shortlisted')}">
                    <li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                    <li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                    </c:when>  
                    
                    <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('OnHold')}">
                    <li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                    <li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                    </c:when> 
                    
                    <c:when test="${appliedStudentEmailsWithStatus.containsKey(candidateDetails.emailID) && appliedStudentEmailsWithStatus.get(candidateDetails.emailID).equals('Rejected')}">
                    <li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                    <li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                   </c:when> 
                   
                   <c:otherwise>
                   <li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                   <li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
                   <li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${candidateDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
                   </c:otherwise>
                   
                 </c:choose>
                 <!-- Shortlist/OnHold/Reject buttons section for job ends  -->
                 	
           
              	
              	
              	</c:otherwise>
              </c:choose>
                </ul>
                  <input id="emailId" type="hidden" value="${candidateDetails.emailID}"></input>
                  <input id="internshipIdAndFirmId" type="hidden" value="${jobDetails.internshipIdAndFirmId}"></input>
                  
                  
                  </div>
                <div class="clear"></div></td>
              </tr>
           <tr><td height="15px"></td></tr>
        </c:forEach> 
              </table>
          <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="myModal">
		
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Profile Video</h3>
			</div>
			<div class="modal-body">
				
				<div id="jp_container_1" class="jp-video jp-video-360p">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-video-play">
						<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-title">
							<ul>
								<li>Video Profile</li>
							</ul>
						</div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>

							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
								<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
								<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>
				
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
    
    <!-- <div id="emailProfileDetails">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" class="modal hide fade in" id="myModal1">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="myModalLabel">Recommend this job to your Friend</h3>
			</div>
			<div class="modal-body">
				<form class="stdform" action="" method="get" id="mailForm">
					<div class="leftsection_form">
						<div class="par">
							<label class="floatleft">EmailId</label> <span class="star">*</span>
							<div class="clear"></div>
							<span class="field"> <input id="corporateEmailId"
								name="corporateEmailId" type="text" class="input-medium" />
							</span>
						</div>
						</div>
					
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
						<li><input type="button" value="Send" tabindex="21" class="add_participants floatleft" onClick="emailCandidateProfile('${candidateEmailIdModal}')"></li> 
						<li><span id="validationMessage" class="hideValidation"></span></li>
						</ul>
					</div>
					<div class="clear"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div> -->
   </div>
 
<script>
var idCount = 1;
 $('.buttonSelect').click(function() { 

	 $(this).attr('id', 'q' + idCount);
	 var buttonId = 'q' + idCount;
	 idCount++;
	 
	 var emailId = $('#'+buttonId).parents('.bg').attr('id');
		//var emailId=$('#'+buttonId).parents('.responseslisting').find("#emailId").val();
		var jobId = $("#jobId").val();

		$.ajax({
			
			type : 'POST',
			url: 'employer_viewresponses.htm?emailId='+emailId,
			data : {
				'emailId' : emailId,
				'jobId' : jobId				
			},
			cache : false,
			success : function(data) {
				
			},
			failure : function() {
				alert("Failed");
			}
		}); 
	 
getVideo(buttonId);
});
</script>

<script>
 $('.close').click(function() { 
$("#jquery_jplayer_1").jPlayer( "destroy" );
});
</script>


</body>
</html>
