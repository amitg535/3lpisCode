<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />

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
function goBack()
{
	window.history.back();
}
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
  scrollwheel: false,
  streetViewControl: false,
  mapTypeControl: false,
  scaleControl : false,
  zoomControl: false,
  disableDoubleClickZoom : true,
  zoomControlOptions : false
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





	 var map1 = new google.maps.Map( document.getElementById("gmap1"),  {
		  center: new google.maps.LatLng(0,0),
		  zoom: 3,
		  mapTypeId: google.maps.MapTypeId.ROADMAP,		  
		   panControl: false,		   
		   streetViewControl: false,		   
		   mapTypeControl: false,
		   disableAutoPan : true,
		    });
		  var geocoder1 = new google.maps.Geocoder();
		  var city1= $('#gs01').val();
		  var addr1= $('#gs02').val();
		  var compl_addr1=addr1+" " +city1;
		  geocoder1.geocode({
		    address : compl_addr1, 
		    region: 'no' 
		   },
		      function(results, status) {
		       if (status.toLowerCase() == 'ok') { 
		     // Get center
		     var coords1 = new google.maps.LatLng(
		      results[0]['geometry']['location'].lat(),
		      results[0]['geometry']['location'].lng()
		     );
		     $('#coords1').html('Latitute: ' + coords1.lat() + '    Longitude: ' + coords1.lng() );
		     map1.setCenter(coords1);
		     map1.setZoom(15);
		     // Set marker also
		     marker = new google.maps.Marker({
		    	 
		      position: coords1, 
		      map: map1, 
		      title: compl_addr1
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
	
$(".expandmap").click(function(){

	$("#mapModal").modal().css("visibility", "visible");
	
});
  
});

</script>



</head>
<body  class="dashboard">
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  
   <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     
  <!-- <div id="innerbanner_wrap">
  
        <div><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div> -->
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
   <section id="leftsection" class="floatleft">
    
   
    <div class="candidate_quickaction_wrap">
     <div class="portfolio_img"> 
        <c:choose>
        <c:when test="${not empty universityDetails.universityLogoName}">
        <img src="view_image.htm?emailId=${universityDetails.contactPersonEmailId}" />
        </c:when>
        <c:otherwise>
        <img src="images/Not_available_icon1.png"  />
        </c:otherwise>
        </c:choose>
        
        </div>
        
        <div class="candidate_upcomingevents_wrap floatleft">
       
          <h1 class="resumetitle"><c:out value="${universityDetails.universityName}"></c:out></h1>
          <div class="line-border">&nbsp;</div>
            <span class="orangetxt">Registration number: </span><c:out value="${universityDetails.universityRegistrationNumber}" /><br>
          <div class="floatleft width100">
    
			<c:out value="${universityDetails.universityAddress}" />,<br>
			<c:out value="${universityDetails.city}" />,<br>
			<c:out value="${universityDetails.state}" />

	<div class="floatleft">
		Tel: <c:out value="${universityDetails.phoneNumber}"></c:out><br>
		Email: <%-- <a href="emailto:<c:out value="${universityDetails.contactPersonEmailId}" />"><c:out value="${universityDetails.contactPersonEmailId}"></c:out></a><br> --%>
		Web: <a href="http://<c:out value="${universityDetails.universityWebsite}" />"><c:out value="${universityDetails.universityWebsite}"></c:out></a>
	</div>
        </div>
        
        </div>
        	 <div class="line-border">&nbsp;</div>
          <div class="whitebackground floatleft width100">
            <div class="candidate_upcomingevents_wrap"><h1 class="resumetitle">Location</h1></div>
			<div class="border candidate_upcomingevents_wrap">
       <!--  <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d39495.35710132217!2d-1.2937434196872641!3d51.77948172930488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1soxford+university+map+html+code!5e0!3m2!1sen!2sin!4v1392111991644" width="100%" height="auto" frameborder="0" style="border:0;" class="frames"></iframe> -->

		        <input type="hidden" value="<c:out value="${universityDetails.city}" />" id="gs01" />
		       <input type="hidden" value="<c:out value="${universityDetails.universityAddress}" />" id="gs02" />
		        <div style="border:1px solid #c1c1c1;float:left;"><div class="darkgreyborder expandmap" id="gmap" style="width:149px; height:150px;"> </div> </div>   
              </div>
    </div>
   </div> 
    </section>
    
    
    
     <section id="rightwrap" class="floatleft">
   <c:choose>
   <c:when test="${empty universityDetails}">
    <h3>Your University is not <span>registered</span> yet...<br/>
    Be the first to tell your <span>Placement Officer</span>.
   </h3>
	</c:when>
	<c:otherwise>
	
      <div class="whitebackground width100">
           <div class="subheading_divider">About Us</div>
       		 <div>
                     <p id="display"></p><input type = "hidden" id="about" value="${universityDetails.aboutUs}" />
	         </div>
        <div class="clear"></div>
      </div>
      
      <div class="clear"></div>
      
        <div class="whitebackground margin_top2 floatleft width100">
	      <div class="subheading_divider">Major Courses at <c:out value="${universityDetails.universityName}" /></div>
	      
	       <div class="reg_number width100">
	          <ul  style="width:50%;">
	           <c:forEach items="${universityDetails.courseType}" var="courseType">
	          <li><span >Course Type : </span><c:out value="${courseType}"/></li>   
	          </c:forEach>
	          </ul>
	          
	          <ul style="width:50%;" class="floatleft">
	            <c:forEach items="${universityDetails.courseName}" var="courseName">
	          <li><span>Course Name : </span><c:out value="${courseName}"/></li>   
	          </c:forEach>   
	          </ul>
	        </div>  
      
      </div>
      
      <div class="clear"></div>
      
       <div class="whitebackground margin_top2 floatleft width100">
      <div class="subheading_divider">Major Statistics of <c:out value="${universityDetails.universityName}" /></div>
      <h3 class="sectionheading" style="text-align: left;">Student Details</h3>
      <div class="reg_number width100">
          <ul  style="width:50%;">
          <li>Under-Graduate Students</li>
          <li><span class="boldtxt">Full Time : </span><c:out value="${universityDetails.ugFullTimeStudents}"/></li>
           <li><span class="boldtxt">Part Time :</span> <c:out value="${universityDetails.ugPartTimeStudents}"/></li>
          </ul>
          <div class="bluetxt"></div>
          <ul style="width:50%;" class="floatleft">
          <li>Post-Graduate Students</li>
            <li><span>Full Time : </span><c:out value="${universityDetails.pgFullTimeStudents}"/></li>
           <li><span>Part Time :</span> <c:out value="${universityDetails.pgPartTimeStudents}"/></li>
            
          </ul>
        </div> 
       
       
       
         
      <h3 class="sectionheading" style="text-align: left;">Staff Details</h3>
       <div class="reg_number width100">
          <ul  style="width:50%;">
          <li><span>Teaching Staff : </span><c:out value="${universityDetails.noOfTeachingStaff}"/></li>
           <li><span>Research Staff :</span> <c:out value="${universityDetails.noOfResearchStaff}"/></li>
          </ul>
          
          <ul style="width:50%;" class="floatleft">
            <li><span>Support Staff : </span><c:out value="${universityDetails.noOfSupportStaff}"/></li>
          
            
          </ul>
        </div> 
 		</div>
        
       <div class="clear"></div>
       
         <div class="whitebackground margin_top2 floatleft width100">
	       <div class="subheading_divider">Course Term Dates</div>
	          <div class="reg_number width100">
	          <ul  style="width:50%;">
	          <li><span>Autumn Term :</span><c:out value="${universityDetails.autumnStartDate}"/> to <c:out value="${universityDetails.autumnEndDate}"/></li>
	          <li><span>Spring Term :</span><c:out value="${universityDetails.springStartDate}"/> to <c:out value="${universityDetails.springEndDate}"/></li>
	         </ul>
	         <ul style="width:50%;" class="floatleft">
	          <li><span>Summer Term :</span> <c:out value="${universityDetails.summerStartDate}"/> to <c:out value="${universityDetails.summerEndDate}" /></li>
	            
	          </ul>
	       
	        </div> 
	   </div>    
       <div class="clear"></div>
      
       <c:choose> 
       
      <c:when test="${fn:length(universityDetails.awardsAndRecognitionList) gt 0}">
         <div class="whitebackground margin_top2 floatleft width100 ">
       	 <div class="subheading_divider">Awards and Recognition</div> 
      		<div class="smallsection_wrap floatleft doubleright_margin top_margin" style="width: 100%;">
	        	<ul class="recent_activities_wrap">
	      		 	<c:forEach items="${universityDetails.awardsAndRecognitionList}" var="awardsAndRecognition">  
	                	<li><c:out value="${awardsAndRecognition}"></c:out></li>
	                </c:forEach>
	        	</ul>
       		 </div>
       		 
       		
       	</div>	 
      </c:when>
      <c:otherwise>
      </c:otherwise>
      </c:choose>
      
  
    <%--   <div class="clear"></div>
      <div class="innercontainer noborder">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%"><h2 class="subheading_divider">Location</h2></td>
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
              </div></div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div> --%>
	</c:otherwise>
   </c:choose>
 
     
      
      <%-- <form:form class="stdform" action="" > --%>
        <div class="padding_top">
          <div class="buttonwrap">
             <c:choose>
		<c:when test="${headRole == 'ANONYMOUS'}"> 
         <input type="button" value="Connect Now" tabindex="18" onclick="window.location='candidate_registration.htm'">
         <input name="" type="button" value="Back" tabindex="17" onClick="goBack()" >
         </c:when>
         <c:otherwise>
         <c:choose>
         <c:when test="${headRole == 'UNIVERSITY'}">
         <a href="university_profile.htm" ><input name="" type="button" value="Edit" tabindex="17"></a>
         </c:when>
         <c:otherwise>
         <input name="" type="button" value="Back" tabindex="17" onClick="goBack()" >
         </c:otherwise>
         </c:choose>
         </c:otherwise>
         </c:choose>
          </div>
        </div>
    <%--   </form:form> --%>
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

<div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-2" class="modal fade in" id="mapModal" style="visibility: hidden;">
				<div class="modal-header">
		<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="formulaHeader" class="blutitle18"> Location </h3>
			</div>
       <div class="modal-body"> 
       
        <div class="darkgreyborder" id="gmap1" style="width:100%; height:395px;"> </div>
       
   </div>
   </div>


</body>
</html>