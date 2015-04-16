<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.util.*" %>  
<%@ page import="java.util.*" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.BufferedOutputStream" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Advance Search Listing</title>
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
<link rel="stylesheet" href="css/jplayer.pink.flag.css" type="text/css" />
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
<script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
  <script type="text/javascript" src="js/jquery.pajinate.js"></script>
  
  
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
		var emailId=$('#'+buttonId).parents('.responseslisting').find("#emailId").val();
		
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
  
  <script>
 function getSelectedEmailCheckbox() {
	//alert("prem");
	document.form.action="employer_candidate_mail.htm";
	 document.form1.submit();
 }
 </script>
  
<script>
function editFunction()
{
window.history.back();
}
</script>

<script type="text/javascript">
function ShowOld()
{
	//alert('email check');
 $("input:checkbox");
 
	var emails= '';
	//alert(emails);
//if(emails != ""){
	//alert('nside if');
  $( "input:checked" ).each(function() {
emails= emails+","+ this.value;
});
  
  if(emails == ""){
	  
alert('Please select atleast one candidate');
	  
  }
	  
  
//alert(emails);
if(emails != ""){
window.location.href='employer_candidate_mail_list.htm?emailList='+emails;
//document.navigatepath ;
}
return false;
}
</script>


		<script type="text/javascript">
    		$(document).ready(function(){
				$('.saved_candidate_listing').pajinate({
					num_page_links_to_display : 3,
					items_per_page : 10	
				});
			});     
            
 
	    
		</script>  



</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <!-- <header>
    <div id="logo"><a href="home.html"><img src="images/logo.gif" alt="Caerus - your carrer hi-five"></a></div>
    <div id="loginwrap">
      <div id="studentlogin" class="floatleft">User: Quinnox Consulltancy Services Pvt.Ltd. / Max D'Costa</div>
      <div class="floatleft" id="employerslogin"><a href="employers_registration_login.html" target="_self">Sign Out</a></div>
    </div>
    <div class="clear"></div>
  </header> -->
  
      <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
   
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_search_candidate.htm">Search Candidates</a> / Advanced Search</div> -->
    
      <section id="rightwrap" class="floatleft">
      
          
          <h1 class="sectionheading"> Saved candidates <span>(${count})</span></h1>
         
			<div class="saved_candidate_listing">
			 <c:set var="count" scope="session" value="${count}"/>
			<c:if test="${count == 0}">
			<div class="error_message_span validationnote whitebackground">No results Found</div>
			</c:if>
			
			
        <div class="reponses_listing_wrap">
          <c:forEach var="studentDetails" items="${studentList}">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting jobslisting whitebackground margin_top2">
        
            <!-- <tr>
                <td colspan="2" class="padding_bottom">&nbsp;</td>
              </tr> -->
            <tr class="bg">
                <td>
                <div class="image_wrap"> 
                <c:choose>
					<c:when test="${studentDetails.photoName ne null}"> 
					<div class="candidate_photo"><img src="view_image.htm?emailId=${studentDetails.emailID}" width="100" height="100" alt="" /></div>
					</c:when>
					<c:otherwise>
                      <div class="companylogo_rgt"><img src="/images/Not_available_icon1.png" width="100" height="100" alt=""></div> 
                      </c:otherwise>
                  </c:choose>
                	</div>
                
                <div class="details_wrap searchtitle">
                    <div class="sectionleft floatleft">
                    <a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${studentDetails.emailID}"/>" ><span> 
                    <c:out value="${studentDetails.firstName}"></c:out></span>  <span><c:out value="${studentDetails.lastName}"></c:out></span>, &nbsp;<span><c:out value="${studentDetails.city}"></c:out>,<c:out value="${studentDetails.state}"></c:out> </span></a>
                    <div class="clear"></div><span class="orangetxt"><c:out value="${studentDetails.universityDetails.universityCourseName}"></c:out></span>, &nbsp;<span><c:out value="${studentDetails.universityDetails.universityName}"></c:out>,</span></div> 
                    
                    <div class="sectionright floatright"><span class="orangetxt boldtxt">GPA of <c:out value="${studentDetails.universityDetails.universityGpaFrom}"/> of <c:out value="${studentDetails.universityDetails.universityGpaTo}"/></span> </div>
 				                 
				<div class="clear"></div>
                
                    <p class="description"> <c:out value="${studentDetails.aboutYourSelf}"/>   </p>
                    
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                        <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                         
                            <c:forEach items="${studentDetails.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/> </li>
                        </c:forEach> 
                              </ul></td>
                      </tr>
                  
                  </table>
                    <ul class="actions_icns floatright top_margin">
                    
                    <li><c:if test="${not empty studentDetails.videoName}"> <a data-toggle="modal" class="buttonSelect" href="#myModal"><span><img src="images/video_icn.png" alt="video"></span>Video Profile</a></c:if></li>
                    <li><a href="employer_download_candidate_profile.htm?emailId=<c:out value="${studentDetails.emailID}"/>&jobId=null"><span><img src="images/list_download_icn.png" alt="Download"></span>Download</a></li>
                   
                  </ul> 
                  
                  <input id="emailId" type="hidden" value="${studentDetails.emailID}"></input> 
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
                <div class="clear"></div></td>
              </tr>
                         
          </table>
           </c:forEach>
          
          
          </div>
       
           <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
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
<script>
var idCount = 1;
 $('.buttonSelect').click(function() { 
$(this).attr('id', 'q' + idCount);
var buttonId = 'q' + idCount;
idCount++;
getVideo(buttonId);
});
</script>
<script>
 $('.close').click(function() { 
$("#jquery_jplayer_1").jPlayer( "destroy" );
});
</script>
<!-- <script>
$('#myModal').modal().on('shown', function(){
    $('body').css('overflow', 'hidden');
}).on('hidden', function(){
    $('body').css('overflow', 'auto');
});
</script> -->

</body>
</html>