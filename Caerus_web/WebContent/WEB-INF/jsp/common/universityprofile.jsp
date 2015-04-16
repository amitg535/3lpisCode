<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Profile Detail View</title>
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

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script>
$(document).ready(function() {
 // Load google map
 //$('#btnsrch').click(function()
  var map = new google.maps.Map( document.getElementById("gmap"),  {
  center: new google.maps.LatLng(0,0),
  zoom: 3,
  mapTypeId: google.maps.MapTypeId.ROADMAP,
  panControl: false,
  streetViewControl: false,
  mapTypeControl: false
    });
  var geocoder = new google.maps.Geocoder();
  var city= $('#gs01').val();
  var addr= $('#gs02').val();
  var compl_addr=addr+" " +city;
  geocoder.geocode({
    address : compl_addr, 
    region: 'no' 
   },
      function(results, status) {
       if (status.toLowerCase() == 'ok') { 
     // Get center
     var coords = new google.maps.LatLng(
      results[0]['geometry']['location'].lat(),
      results[0]['geometry']['location'].lng()
     );
     $('#coords').html('Latitute: ' + coords.lat() + '    Longitude: ' + coords.lng() );
     map.setCenter(coords);
     map.setZoom(15);
     // Set marker also
     marker = new google.maps.Marker({
      position: coords, 
      map: map, 
      title: compl_addr
     });            
       }
   }
  )
});
</script>
 <script>
$(document).ready(function() {
  var text = $("#about").val();
	text = text.replace(/\n\r?/g, '<br />');
	$("#display").html(text);
  
});
</script>
<script>
function goBack()
  {
  	window.history.back();
  }
</script>
<% 
 	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	String authority = auth.getAuthorities().toString();
	int mid = authority.lastIndexOf("_");
 	String role = authority.substring(mid+1, authority.length()-1);
 	pageContext.setAttribute("role", role);
 	//role.substring(1, role.length()).toLowerCase();
 	
 
%>
</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  
   <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     
  <div id="innerbanner_wrap">
  
        <div id="banner"><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
     <!--  <div id="topnavigation">
        <ul class="dropdown">
        <li><a href="#">Dashboard</a> </li>
        <li> <a href="#">Publish  Jobs / Internships</a></li>
        <li> <a href="#" class="active">Manage Responses</a></li>
        <li> <a href="#">Search Resumes</a></li>
        <li> <a href="#">Campus Connect</a></li>
        <li> <a href="#">Reports</a></li>
        <li> <a href="#">My Account</a></li>
        <li> <a href="#">Admin</a></li>
      </ul>
        <div class="clear"></div>
      </div> -->
        
     
     
      
   <div id="innersection" class="university">
 <c:if test="${empty universityDetails}">
    <h3>Your University is not <span>registered</span> yet...<br/>
    Be the first to tell your <span>Placement Officer</span>.
   </h3>
	</c:if>
	<c:if test="${not empty universityDetails}">
      <div class="innercontainer university_header">
        <div class="cv_img">
        <c:choose>
        <c:when test="${not empty universityDetails.universityLogoName}">
        <img src="view_reg_university_logo.htm?universityName=${universityDetails.universityName}" style="width:152px;" />
        </c:when>
        <c:otherwise>
        <img src="images/Not_available_icon1.png" style="width:152px;" />
        </c:otherwise>
        </c:choose>
        
        </div>
        <div class="cv_details">
          <h1 class="resumetitle"><c:out value="${universityDetails.universityName}"></c:out></h1>
          <div class="floatleft width100">
          <div class="floatleft padding_right">
<!-- Department of Materials<br>
Parks Road<br>
Oxford<br>
OX1 3PH<br>
United Kingdom -->
<c:out value="${universityDetails.universityAddress}" />,<br>
<c:out value="${universityDetails.city}" />,<br>
<c:out value="${universityDetails.state}" />
</div>
<div class="floatleft">
Tel: <c:out value="${universityDetails.phoneNumber}"></c:out><br>
<%-- Email: <a href="emailto:<c:out value="${universityDetails.emailID}" />"><c:out value="${universityDetails.emailID}"></c:out></a><br> --%>
Email: <a href="emailto:<c:out value="${universityAdmin.emailId}" />">
<c:out value="${universityAdmin.firstName}"></c:out>   <c:out value="${universityAdmin.lastName}"></c:out>(<c:out value="${universityAdmin.userName}">)</c:out></a><br>
Web: <a href="http://<c:out value="${universityDetails.universityWebsite}" />"><c:out value="${universityDetails.universityWebsite}"></c:out></a></div>
        </div></div>
        <div class="clear"></div>
        
      </div>
      <div class="innercontainer noborder">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%"><h2 class="resume_title">About Us</h2></td>
            </tr>
            <tr>
            <td width="100%">&nbsp;</td>
            </tr>
             <tr>
            <td width="100%"><div class="right_detailswrap ">
                <ul class="topborder_lists">
                  <li>
                   
                      <div class="greytxt_nomargin width100">
                       <span class="orangetxt">Registeration number: </span><c:out value="${universityDetails.universityRegistrationNumber}" /><br><br>
                      <!-- This year, you will also be able to more easily share your resume and profile information with your employers of choice using QR code technology. By registering for these events here, you receive a personal QR code that can be quickly scanned by participating employers, providing them with instant access to your contact information and resume. Not only will this save you time and money, but it also ensures the little time you have with recruiters is spent discussing your interests and qualifications rather than filling out forms. -->
                     <p id="display"></p>
      					<input type = "hidden" id="about" value="${universityDetails.aboutUs}" />
                    </div></li>
                  
                  
                </ul>
              </div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      
      <div class="innercontainer noborder">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%"><h2 class="resume_title">Location</h2></td>
            </tr>
            <tr>
            <td width="100%">&nbsp;</td>
            </tr>
             <tr>
            <td width="100%"><div class="right_detailswrap">

           <div class="border">
       <!--  <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d39495.35710132217!2d-1.2937434196872641!3d51.77948172930488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1soxford+university+map+html+code!5e0!3m2!1sen!2sin!4v1392111991644" width="100%" height="auto" frameborder="0" style="border:0;" class="frames"></iframe> -->

        <input type="hidden" value="<c:out value="${universityDetails.city}" />" id="gs01" />
       <input type="hidden" value="<c:out value="${universityDetails.universityAddress}" />" id="gs02" />
        <div class="darkgreyborder" id="gmap" style="width:757x; height:175px;"> </div>
              </div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      </c:if>
      <%-- <form:form class="stdform" action="" > --%>
        <div class="padding_top">
          <div class="buttonwrap">
           <input name="" type="button" value="Back" tabindex="17" onClick="goBack()" >
           <c:choose>
<c:when test="${role == 'ANONYMOUS'}"> 
         <input type="button" value="Connect Now" tabindex="18" onclick="window.location='candidate_registration.htm'">
         </c:when>
         </c:choose>
          </div>
        </div>
    <%--   </form:form> --%>
    
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