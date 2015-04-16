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
  <title>Admin Verifications</title>
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
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />
<link rel="stylesheet" href="css/video-js.css" type="text/css" /> 
<!-- <script>var homePlayer=_V_("home_video");</script>   -->
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>
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
  <script src="js/jquery.easytabs.min.js" type="text/javascript" ></script>
  <script type="text/javascript" src="js/jquery.quicksearch.js"> </script>
  <script type="text/javascript" src="js/jquery.quick.pagination.min.js"> </script> 

<script type="text/javascript">
  $(document).ready( function() {

      $('#tab-container').easytabs();
	  
	var qs = $('input#id_search_list').quicksearch('ul#list_example li');
	var rs = $('input#id_search_video').quicksearch('ul#list_video li');

	var videoVerificationVar = $("#videoVerificationTab").val();

	  if(videoVerificationVar != null && videoVerificationVar != "")
	  {
		  $("#tabs1").css('display','none');
		  $("#tabs_video").css('display','block');

		  $("#photoTab").removeClass('active');
		  $("#videoTab").addClass('active');
	  }	  

	  $("ul.pagination1").quickPagination({pageSize:"12"});
	  $("ul.videolist").quickPagination({pageSize:"12"});
	  
});
  </script>

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

  function switchClass()
  {
	  $("#videoTab").removeClass('active');
  }

$(document).ready(function(){

	var array = new Array();

	$(".callToolTip").each(function(){
		var id = $(this).attr('id');
		var emailId=  $('#'+id).find('img').attr('id');
		
		$('#'+id).webuiPopover({
	          trigger:'click',
	          placement:'top',
	          width:350,
	          closeable:true,
	          content: '<img src="view_image.htm?emailId='+emailId+'" alt="" width="325" height="325">'
	  	  });
		
	});
  	  
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
    
    <div id="innersection">
       <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm"> Home </a>/ Manage Connections</div> -->
        
        <section id="rightwrap" class="floatleft">
        
          <div class="whitebackground">
        <h1 class="sectionheading">Admin Verifications</h1>
       
   <div class="clear"></div>
      <input type="hidden" value="${videoTab}" id="videoVerificationTab"> 
        <div id="tab-container" class='doublebottom_margin ui-tabs ui-widget ui-widget-content ui-corner-all'>
 <ul>
 
   <li class='tab' onclick="switchClass()"><a href="#tabs1" id="photoTab">Photo Verification</a></li>
   <li class='tab'><a href="#tabs_video" id="videoTab">Video Verification</a></li>
 </ul>
  
 <div class='panel-container'>
  <div id="tabs1">		
        	 
        	 <div id="list" style="display: block;" class="margin_top2">
        	<c:choose>
        	<c:when test="${empty studentList}">
        	 NO DATA AVAILABLE
			</c:when>
			<c:otherwise>
			<div class="clear"></div>
	<form class="stdform">
    	Search: <input type="text" value="" class="input-medium3"  id="id_search_list" />
    	<div class="clear">&nbsp;</div>
    </form>
				<ul id="list_example" class="pagination1">
				 <c:forEach items="${studentList}" var="student" varStatus="loop">
                    <li> 
                    <c:set var="escapedId" value="${student.emailID.replace('@','').replace('.','')}" />
                    <a id="${escapedId}" class="callToolTip">
                    <img src="view_image.htm?emailId=<c:out value="${student.emailID}"/>" alt="" id="${student.emailID}"></a>
                    <p><a href="detail_view_candidate.htm?studentEmailId=<c:out value="${student.emailID}"/>"> <c:out value="${student.firstName}" /> <c:out value="${student.lastName}" /></a><br>
                     <a href="admin_verify_user_photo.htm?userName=${student.emailID}&verifyFlag=verify"><img src="images/thumb_up_icon.png" style="width:28px; height:26px;" title="Verify Image"></a>&nbsp; &nbsp;
                     <a href="admin_verify_user_photo.htm?userName=${student.emailID}&verifyFlag=reject"> <img src="images/thumb_down_icon.png" style="width:28px; height:26px;" title="Reject Image"></a>
                     </p></li>
                   
                     </c:forEach>    
                        
                </ul>
		</c:otherwise>
		</c:choose>
</div> 
  </div>
   <div id="tabs_video">		
        	 
        	 <div style="display: block;" class="margin_top2 listings">
        	<c:choose>
        	<c:when test="${empty candidateList}">
        	 NO DATA AVAILABLE
			</c:when>
			<c:otherwise>
			<div class="clear"></div>
	<form class="stdform">
    	Search: <input type="text" value="" class="input-medium3"  id="id_search_video" />
    	<div class="clear">&nbsp;</div>
    </form>
				 <ul id="list_video" class="videolist">
				 <c:forEach items="${candidateList}" var="student" varStatus="loop">
                    <li> 
                    <video class="video-js vjs-default-skin" controls width="294" height="210"> 
            <!-- MP4 source must come first for iOS -->
            <source type="video/mp4" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- WebM for Firefox 4 and Opera -->
            <source type="video/webm" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- OGG for Firefox 3 -->
            <source type="video/ogg" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
             
            <source type="video/mp3" src="view_video.htm?emailId=<c:out value="${student.emailID}" />" ></source>
            <!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
             <object width="180" height="150" type="application/x-shockwave-flash" data="videos/flashmediaelement.swf">
                  <param name="movie" value="flashmediaelement.swf" />
                  <param name="flashvars" value="controls=true&amp;file=videos/echo-hereweare.mp4" />
                  Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed 
                  <img src="videos/echo-hereweare.jpg" width="180" height="150" alt="Here we are" title="No video playback capabilities" />
                </object> 
          </video>
          
                     <p><a href="detail_view_candidate.htm?studentEmailId=<c:out value="${student.emailID}"/>"> <c:out value="${student.firstName}" /> <c:out value="${student.lastName}" /></a><br>
                     <a href="admin_verify_user_video.htm?userName=${student.emailID}&verifyFlag=verify"><img src="images/thumb_up_icon.png" style="width:28px; height:26px;" title="Verify Image"></a>&nbsp; &nbsp;
                     <a href="admin_verify_user_video.htm?userName=${student.emailID}&verifyFlag=reject"> <img src="images/thumb_down_icon.png" style="width:28px; height:26px;" title="Reject Image"></a>
                     </p> 
                     
                     </li>
                   
                     </c:forEach>    
                        
                </ul> 
		</c:otherwise>
		</c:choose>
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
    <!--------------  Common Footer Section :: end -----------> 
  </div>
</body>
</html>