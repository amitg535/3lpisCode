<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Post Campus Internship</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!--19-07-2013 changes-->
<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<link rel="stylesheet" href="../mobile_html/css/multiple-select.css" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />

<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="../mobile_html/js/jquery-1.7.1.min.js"></script>
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script> -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
 <script src="../mobile_html/js/jquery.validate.min.js"></script>
<script src="../mobile_html/js/script.js"></script>

<script src="../mobile_html/js/jquery.fs.selecter.js"></script>

<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	});
    }
	
</script>
<script>
  	$(document).ready(function() {
    	$(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		});
	});
  
	function selectCallback(value, index) {
        alert("SELECTED VALUE: " + value + ", INDEX: " + index);
	}
  
  function toggleEnabled() {
    if ($(".selecter_disabled").is(":disabled")) {
    	$(".selecter_disabled").selecter("enable");
      $(".enable_selecter").hide();
      $(".disable_selecter").show();
    } else {
      $(".selecter_disabled").selecter("disable");
      $(".enable_selecter").show();
      $(".disable_selecter").hide();
    }
    return false;
  }
</script>
<script>

$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	});
		
		//Donebutton Function	
		
		//calenderIcon function
    $("#datepickerImage,#datepickerImage1").click(function() {
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').addClass('noscroll'); 

//	   $('#wrapper').bind('touchmove', function(e){e.preventDefault()})	   
    });
	$("#done1").click(function() {
	$( "#datepicker1" ).datepicker({ dateFormat: "yy-mm-dd" });
	var dateTypeVar = $('#datepicker1').datepicker('getDate');   
	var g = $.datepicker.formatDate( "mm-dd-yy", dateTypeVar);	   

	    	   	   	 
	   
    });	
	
	
    }


	function hideLabel (field_id, hide) {
		  var field_for;
		  var labels = document.getElementsByTagName('label');
		  for (var i = 0; i < labels.length; i++) {
		    field_for = labels[i].htmlFor || labels[i].getAttribute('for');
		    if (field_for == field_id) {
		      labels[i].style.textIndent = (hide) ? '-1000px' : '0px';
		      return true;
		    }
		  }
		}

		window.onload = function () {
		  setTimeout(initOverLabels, 50);
		};	
	
	
</script>
<script>
  

</script>

<script>
 
/* create datepicker */
$(document).ready(function() {


$('#textbox1,#textbox2').unbind('focus');
$("#logout-on").click(function()
{
    	$('#overlay-logout').removeClass('hide');	   	   
    	$('#overlay-logout').addClass('show');	   
	   $('body').addClass('noscroll');	
}

);


//calenderIcon function
    $("#datepickerImage,#datepickerImage1").click(function() {
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').addClass('noscroll'); 

//	   $('#wrapper').bind('touchmove', function(e){e.preventDefault()})	   
    });
//closeIcon Function	
	$("#close").click(function() {
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').removeClass('noscroll');	 
//	   $('#wrapper').unbind('touchmove')	   
	   
    });
//Donebutton Function	
	$("#done").click(function() {
	$( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });
	var dateTypeVar = $('#datepicker').datepicker('getDate');   
	var g = $.datepicker.formatDate( "mm-dd-yy", dateTypeVar);	   

	   $('#textbox1').val(g);
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').removeClass('noscroll');	
//	   $('#wrapper').unbind('touchmove')	   	   	   	 
	   
    });	
//Donebutton Function	
	$("#done1").click(function() {
	$( "#datepicker1" ).datepicker({ dateFormat: "yy-mm-dd" });
	var dateTypeVar = $('#datepicker1').datepicker('getDate');   
	var g = $.datepicker.formatDate( "mm-dd-yy", dateTypeVar);	   

	   $('#textbox2').val(g);
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').removeClass('noscroll');	
//	   $('#wrapper').unbind('touchmove')	   	   	   	 
	   
    });	


});
  </script>
 

<script type="text/javascript">
function getCityFunction()
{
	var zipCode=$("#zipCode").val();
	   
      $.ajax({
        
        url: 'get_city_name.htm',
        data : {
			'zipCode' : zipCode
		},
        cache: false,
   	    success: function(cityName) {
   	   	    if(cityName==" ()"){
   	   	  $("#internshipLocation").val("");  
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   				$("#internshipLocation").val(cityName);
   	   	   	    }
             
     
        }
    });
 

}
	 
</script>
<script type="text/javascript">
function goBack()
{
	window.history.back(); 
}

</script>

<script src="../mobile_html/js/menu.js"></script>
<style>
div#starting_date
{
    position:relative;
    float:left;
    margin-right:3px;
}

input#startDate
{
    width:10em;
}
div#ending_date
{
    position:relative;
    float:left;
    margin-right:3px;
}

input#endDate
{
    width:10em;
}

label.overlabel {
    color:#999;
    position: absolute;
	top: 28px;
}
label.overlabel-apply {
    position:absolute;
    top:3px;
    left:5px;
    z-index:1;
    color:#999;
    position: absolute;
	top: 28px;
}

</style>
</head>
<body class="employer">
<div id="main_wrap">
  <%@ include file="includes/header.jsp"%>
  <div id="mid_wrap" class="midwrap_toppadding">
   <%--  <div id="submenu">
      <ul class="nav nav-pills">
        <li><a href="<c:url value="employer_dashboard.htm" />">Search</a></li>
        <li><a href="#">Saved</a></li>
        <li><a href="#">Events</a></li>
        <li class="active"><a href="#">Profile</a><span class="active_arrow"></span></li>
        <!--    <li class="dropdown"> <a class="dropdown-toggle" id="drop5" role="button" data-toggle="dropdown" href="#">Events <b class="caret"></b></a>
        <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="drop5"><span></span>
          <li class="notopborder"><a role="menuitem" href="#">Received Events</a></li>
          <li><a role="menuitem" href="#">Manage Schedule Events</a></li>
       </ul>
      </li>-->
      </ul>
    </div> --%>
    
    
    <section id="inner_container">
    <h1 class="page_heading">Post <span class="orange_font">A Campus Internship</span></h1>
    <!--13-08-2013-->
   
     	<form:form class="stdform" action="employer_post_campus_internship.htm"  method="post" modelAttribute="campusInternshipCommand"  id="postInternshipForm" >
    <div class="par pickup_details_cont">
     <!--    <table class="pickup_details_cont" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100" class="label_col">Birth Date <span class="star">*</span></td>
            <td><input type="" id="textbox1" readonly> </td>
            <td width="46" align="center" valign="middle"><span id="datepickerImage" class="cal float_left"></span> </td>
          </tr>
          
        </table> -->
      </div>
      <div class="details" id="editpersonal">
       <ul>
         
          
           <li>
          <div class="labeldetails">
          	<c:choose>
										<c:when test="${not empty campusInternshipCommand.jobUpdateFlag }">
											<form:input path="internshipId" readonly="true"  />
										</c:when>
										<c:otherwise>
											<form:input path="internshipId" placeholder="Internship ID *" />
										</c:otherwise>
									</c:choose>
										
											<form:errors path="internshipId"/>
           </div>
          <c:if	test="${not empty campusInternshipCommand.exceptionOccured}">
			<div class="errorblock">${campusInternshipCommand.exceptionMessage}</div>
		 </c:if>
           </li>
           
           <li>
           <div class="labeldetails">
              <form:input path="internshipTitle" id="internshipTitle" placeholder="Internship Title*"/>
              </div>
            </li>
                      
            <li>
            <div class="labeldetails">
             <form:select data-placeholder="Choose an Option" path="internshipType">
                	<form:option value="">Select Internship Type*</form:option>
											<form:option value="type1">Type1</form:option>
											<form:option value="type2">Type2</form:option>
											<form:option value="type3">Type3</form:option>
											<form:option value="type4">Type4</form:option>	
			</form:select>
			<form:errors path="internshipType" />
			</div>
          </li>
          
                 
            <li>
            <div class="labeldetails">
              <form:input type="number" path="approximateHours" id="approximateHours" placeholder="Approximate Hours" />
              </div>
            </li>
            
               
            <li>
            <div class="labeldetails">
            <!-- <input type="date" id="from" readonly="true" placeholder="Start Date" name="startDate"> -->
            	 <%-- <form:input type="date" path="startDate" id="from2" placeholder="Start Date" style="width:40%;" /> --%>
            	 <div id="starting_date">
					<label for="startDate" class="overlabel">Start Date</label>
					<form:input path="startDate" id="startDate" type="date" name="starting_date"/>
					</div>
					<div id="ending_date">
					<label for="endDate" class="overlabel">End Date</label>
					<form:input path="endDate" id="endDate" type="date" name="ending_date"/>
					</div>
            	<%--  - <form:input type="date" path="endDate" id="to" placeholder="End Date" style="width:40%;" /> --%>
            	</div>
            	<div id="errorDate"></div>
            <%-- <form:input path="yearsOfExperienceFrom" id ="experienceFrom" />   --%>
            </li>
           
          
            <li>
            <div class="labeldetails">
              <form:input type="number" path="payPerHour" id="payPerHours" placeholder="Pay Per Hour ($)"  />
              </div>
              </li>
                    
            <li>
            <div class="labeldetails">
              <form:input type="number" path="numberOfVacancy" id="numberOfVacancy" placeholder="Number of Vaccancies"/>
              </div>
              </li>
                           
            <li>
            <div class="labeldetails">
           <form:select path="campusJobRecipients" multiple="multiple" data-placeholder="Universities to be Invited" id="universityNameList"> 
                            				<%-- <form:option value="">Select University*</form:option>    --%>  
                            				
                        					 <form:options items="${universityList}" />               
                        				</form:select>
                        				<form:errors path="campusJobRecipients" />
            </div>
            </li> 
          
            <li>
            <div class="labeldetails">
               <form:input id="primarySkills" path="primarySkills" placeholder="Primary Skills*"/>
               <form:errors path="primarySkills" />
           </div>
          </li>
                      
           <li>
           <div class="labeldetails">
          <form:input  id="tags1" path="secondarySkills" placeholder="Secondary Skills*"/>
          <form:errors path="secondarySkills" />
          </div>
          </li>
          
           
             
            <li>
            <div class="labeldetails">
           <form:input type="number" maxlength="6" path="zipCode" id="zipCode" placeholder="Zip code * " onChange="getCityFunction()"/>
           <span id="zipCodeError" class="errorblock"></span>
           <form:errors path="zipCode" />
           
           </div>
           </li>
                   
            <li>
            <div class="labeldetails">
           <form:input path="location" id="internshipLocation" placeholder="City * "/>
           <form:errors path="location" />
           </div>
            </li>
                                    
            <li>
            <div class="labeldetails">
            <form:textarea path="internshipDescription" id="internshipDescription" rows="5" cols="47" placeholder="Internship Description * "/>
            <form:errors path="internshipDescription" />
            </div>  
            </li>
          
            
          
        </ul>
      </div>
     <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
				<input name="previewBtn" type="submit" value="Preview"  class="orangebuttons">  
				<input name="backBtn" type="button" value="Back"  class="orangebuttons" onclick="goBack()">
		</li>
		</ul>
		</div>
</div>   
    </form:form>
 <!--13-08-2013-->
 </section>
  </div>
  <div id="push"></div>
</div>

<div class="par pickup_details_cont">
        <!-- <table class="pickup_details_cont" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100" class="label_col">Birth Date <span class="star">*</span></td>
            <td><input type="" id="textbox1" readonly> </td>
            <td width="46" align="center" valign="middle"><span id="datepickerImage" class="cal float_left"></span> </td>
          </tr>
          
        </table> -->
      </div>
    
</body>
</html>