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
<title>Employer Post Internship</title>
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
 <!-- <script src="../mobile_html/js/jquery.min.js"></script> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="../mobile_html/js/jquery-1.7.1.min.js"></script>
 -->
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script>
<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<!-- <script src="../mobile_html/js/jquery.multiple.select.js"></script> -->
<!-- <script src="../mobile_html/js/menu.js"></script> -->


<script type="text/javascript">

$().ready(function() {

	$.validator.addMethod('numericOnly', function (value) {
	    return /^[0-9]+$/.test(value);
	}, 'Please only enter numeric values (0-9)');
	
	// validate signup form on keyup and submit
	$("#postForm").validate({
		rules: {
			internshipId: "required",
			internshipTitle: {required:true,maxlength:35},
			zipCode:"required",
			location: "required",
			primarySkills1:"required",
			secondarySkills1:"required",
			internshipDescription:"required",
			experienceFrom: {
                numericOnly:true
            },
            experienceTo:{
               numericOnly:true
           }
		},
		messages: {
			internshipId: "Please enter Internship Id",
			internshipTitle: {required: "Please provide  Internship Title",maxlength:"Internship Title Cannot exceed 35 Characters"},
			zipCode:"Please Enter ZipCode",
			location: "Please provide  Location",
			primarySkills1: "Please provide  Primary Skills",
			secondarySkills1:"Please provide Secondary Skills",
			internshipDescription:"Please Fill Internship Description",

		}
	});

	

});


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
    	})
    }
	
</script>
<script>
  	$(document).ready(function() {
    	/* $(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		}); */
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
    	})
		
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
	
	
</script>
<script>
  

</script>

<!-- <script>
jQuery(document).ready(function () {

   jQuery('.uniform-file').uniform();

});
</script> -->
<script>
/*  $(function() {
  }); */


/* create datepicker */
$(document).ready(function() {

	
 /* jQuery('#datepicker').datepicker(
 {
	 changeMonth:true,
	 changeYear:true,
	 yearRange:"-100:+0"
 }); */
  
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
	var g = $.datepicker.formatDate( "mm-dd-yy", dateTypeVar)	   

	   $('#textbox2').val(g);
       $("#overlay").toggle( "slide",{direction:"down"});
	   $('#wrapper,#footer').removeClass('noscroll');	
//	   $('#wrapper').unbind('touchmove')	   	   	   	 
	   
    });	


});
  </script>
 <script type="text/javascript">
	
 function setupLabel() {
 
 if ($('.label_check input').length) {
			
				$('.label_check').each(function(){ 
					$(this).removeClass('c_on');
				});
			
				$('.label_check input:checked').each(function(){ 
					$(this).parent('label').addClass('c_on');
				});
		              
};
		

 if ($('.label_radio input').length) {	
		
				$('.label_radio').each(function(){ 
					$(this).removeClass('r_on');
				});
	
				$('.label_radio input:checked').each(function(){ 
					$(this).parent('label').addClass('r_on');
				});	
		
        };

    };

    $(document).ready(function () {
        $('.label_check, .label_radio').click(function () {
            setupLabel();
           
        });
        setupLabel();


    });


    $(document).ready(function () {
        $(".CloseMyProfile").click(function () {
            menu = $('nav ul');
            menuHeight = menu.height();
            menu.slideToggle();

            $(window).resize(function () {
                var w = $(window).width();
                if (w > 320 && menu.is(':hidden')) {
                    menu.removeAttr('style');
                }
            });
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
   	   	  $("#location").val("");  
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   				$("#location").val(cityName);
   	   	   	    }
             
     
        }
    });
 

}
	 
</script>
 
<script type="text/javascript">
	function previewInternship()
	{
		 var formValue= document.getElementById("postForm");
		 formValue.action="employer_post_internship.htm";
	     formValue.submit(); 
	}
</script>
<script type="text/javascript">
function goBack()
{
  window.history.back(); 
}
</script>



  <script>
/*   $(function() {
    $( "#from2" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#to2" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to2" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#from2" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  }); */

  $(document).on("pagecreate", function() {
	  var nativeDateInputIsSupported = Modernizr.inputtypes.date;
	  if (!nativeDateInputIsSupported) {
	    $("input[type='date']").mobipick();            
	  }
	});
  </script>
</head>

<body class="employer">
<div id="main_wrap">
   <%@ include file="includes/header.jsp"%>
      <div id="mid_wrap" class="midwrap_toppadding">
    <section id="inner_container">
    <h1 class="page_heading">Post An <span class="orange_font">Internship</span></h1>
    <!--13-08-2013-->
   
     <form:form cssClass="stdform" action="employer_post_internship.htm" method="POST" modelAttribute="postInternship" id="postForm">
    <%--  <form:form cssClass="stdform" action="" method="post" commandName="postInternship" id="postForm"> --%>
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
          
            <!-- <td class="label">Internship ID *</td> -->
           <li>
           <div class="labeldetails">
           
              <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                 	 <form:input path="internshipId" tabindex="1" placeholder="Internship Id *" readonly="true"/>
	                 </c:when>
	                 <c:otherwise>
	                 	 <form:input path="internshipId" tabindex="1" placeholder="Internship Id *" />
	                 </c:otherwise>
                 </c:choose>
                 
                  <form:errors path="internshipId"  cssClass="validationnote"/>
           
        <%--    <form:input path="internshipId" id="internshipId" type="text" tabindex="1" placeholder="Internship Id *" /> --%>
        </div>
					   <c:if test="${not empty postInternship.exceptionOccured}">
						<div class="errorblock">${postInternship.exceptionMessage}</div>
					  </c:if>
          </li>
          
            <!-- <td class="label">Status</td> -->
           <li style="height:69px;padding-top:26px;">
          <div class="labeldetails"> 
           <label class="label_radio r_on">
           
         <%--   <form:radiobutton path="status" value="Drafts" checked="true" disabled="true" />&nbsp; Status(Draft) --%>
         
         
               <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                   <c:if test="${! statusDisp.equals('Closed')}">
                 			 <form:radiobutton path="status" value="${statusDisp}"  checked="true"/> <c:out value="${statusDisp}"/> 
                		</c:if>
                  			<form:radiobutton path="status" value="Closed" />Closed 
	                 </c:when>
	                 <c:otherwise>
	                 	<form:radiobutton path="status" value="Drafts" checked = "true" readonly="true"  /> Drafts
	                 </c:otherwise>
                 </c:choose>
           
           </label>
           </div>
           </li>
          
            <!-- <td class="label">Internship Title</td> -->
          <li>
             <div class="labeldetails">
             <%-- 	<form:input path="internshipTitle" id="internshipTitle" placeholder = "Internship Title *" tabindex="2"/> --%>
                 <c:choose>
	                 <c:when test="${ not empty editMode && editMode }">
	                 	 <input type="hidden" value="true" name="jobUpdateFlag"/>
	                 	 <form:input path="internshipTitle" placeholder = "Internship Title *" tabindex="2" readonly="true"/>
	                 </c:when>
	                 <c:otherwise>
	                 	 <form:input path="internshipTitle" placeholder = "Internship Title *" tabindex="2" />
	                 </c:otherwise>
                 </c:choose>
                 
                  
                  
                  <form:errors path="internshipTitle"  cssClass="validationnote"/>
             </div>
          </li>
         
            <!-- <td class="label">Internship Type</td> -->
          <li>
           			 <spring:bind path="internshipType">
					 	<c:set var="selectedInternshipType" value="${status.value}"></c:set>
            		</spring:bind>
          		   
            
            <div class="labeldetails">
            <select name="internshipType" class="selecter_basic" tabindex="3">
                	<option value="">Choose Internship Type</option>
					
					 <c:forEach var="internshipType" items="${internshipTypes}">
					  	<c:choose>
					  	<c:when test="${ internshipType == selectedInternshipType}">
                         <option selected="selected" value="<c:out value="${internshipType}" />" ><c:out value="${internshipType}" /></option> 
					  	</c:when>
					    
					    <c:otherwise>
					     <option value="<c:out value="${internshipType}" />"><c:out value="${internshipType}" /></option> 
					     </c:otherwise>
                	 </c:choose>
                	 </c:forEach>
			</select>
			
			<form:errors path="internshipType" />
			</div>
         </li>
         
          <!-- <td class="label">Start Date</td> -->
         <li>
         <div class="labeldetails"> 
         <form:input type="date" path="startDate" id="from2" placeholder="Start Date" tabindex="4"/>
         
           <!-- <td class="label">End Date</td> -->
  
        <%-- <form:input path="endDate" id="to2" readonly="true" placeholder="End Date"/> --%>
        <form:input path="endDate" type="date" id="to2"  placeholder="End Date" tabindex="5"/> </div>
       <!--  <input type="date" /> -->
      </li>
           <!--  <td class="label">Required Primary Skills</td> -->
            <li>
            <div class="labeldetails">
	            <form:input id="primarySkills1" path="primarySkills" placeholder = "Primary Skills *" tabindex="6"/>
	            <form:errors path="primarySkills" />
             </div>
            </li>
            
     
            <!-- <td class="label">Required Secondary Skills</td> -->
          <li>
         	<div class="labeldetails">
         		<form:input  id="secondarySkills1" path="secondarySkills"  placeholder = "Secondary Skills *" tabindex="7"/>
         	  	<form:errors path="secondarySkills" />
         	</div>
          </li>
          
            <!-- <td class="label">Approximate Hours</td> -->
            <li>
            <div class="labeldetails">
            <form:input path="approximateHours" id ="ApproximateHours" placeholder = "Approximate Hours" tabindex="8"  type="number" /> </div>
           </li>
          
       
            <!-- <td class="label">Zip code (Internship is posted At)</td> -->
           <li> 
           <div class="labeldetails">
           <form:input path="zipCode" id="zipCode" onChange="getCityFunction()" placeholder = "Zip code (Internship is posted At) *" tabindex="9"  type="number" />
           <form:errors path="zipCode" />
           <span id="zipCodeError"></span>
           </div>
           <li>
           
           <!--  <td class="label">City *</td> -->
          <li>
           <div class="labeldetails">
           	<form:input path="location" id="location" placeholder = "City *" tabindex="10"/>
           	<form:errors path="location" />
           </div>
           </li>
           
           <!--  <td class="label">Pay Per Hour ($)</td> -->
          <li>
            <div class="labeldetails">
            	<form:input path="payPerHour" placeholder = "Pay Per Hour ($)" tabindex="11"/>
            	<form:errors path="payPerHour" />
            </div>
           </li>
            
          <!--   <td class="label">Internship Description</td> -->
            <li>
             <div class="labeldetails">
             	<form:textarea path="internshipDescription" id="internshipDescription" rows="5" cols="47" placeholder = "Internship Description *" tabindex="12"/>
             	<form:errors path="internshipDescription" />
             </div> 
            </li>
       </ul>
      </div>
      

      <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
              <input name="previewBtn" type="button" value="Preview"  class="orangebuttons" onclick="previewInternship()">
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
<!-- <footer>
  <div id="footer_links_wrap">
    <div id="footer_links"><a href="#" target="_blank">Full Site</a> | <a href="#" target="_self">Privacy Policy</a> | <a href="#" target="_self">Terms and Conditions</a></div>
    <div id="copyright">&copy; 2014 Imploy.Me All Rights Reserved</div>
  </div>
  <div id="social_icon_sprites">
    <div id="facebook_icn" class="icn_wrap"><a href="#" rel="Facebook" title="Facebook"></a></div>
    <div id="pinterest_icn" class="icn_wrap" ><a href="#" rel="Pinterest" title="Pinterest"></a></div>
    <div id="twitter_icn" class="icn_wrap"><a href="#" rel="Twitter" title="Twitter"></a></div>
  </div>
  <div class="clear"></div>
  <div id="copyright_320" class="margin10_top">&copy; 2013 3ELPIS. All Rights Reserved</div>
  <div class="clear"></div>
</footer> -->

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