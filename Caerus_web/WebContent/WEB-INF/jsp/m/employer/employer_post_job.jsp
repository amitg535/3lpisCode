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
<title>Employer Post Job</title>
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
 <script src="../mobile_html/js/jquery.min.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="../mobile_html/js/jquery-1.7.1.min.js"></script>
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script> -->

<!--<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>-->
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<script src="../mobile_html/js/jquery.multiple.select.js"></script>
<script>
    $(function() {
        $('.ms').change(function() {
            console.log($(this).val());
        }).multipleSelect();
    });
    
</script>

<!-- <script src="../mobile_html/js/menu.js"></script> -->
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
    	})
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

<script>
 $(function() {
  });


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
	var g = $.datepicker.formatDate( "mm-dd-yy", dateTypeVar)	   

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
function postJob()
{
	 var formValue= document.getElementById("postForm");
	 formValue.action='employer_preview_of_job.htm';
	 formValue.submit(); 
}
	 
</script>
<script type="text/javascript">
function goBack()
{
  window.history.back(); 
}


</script>
<script type="text/javascript">

$().ready(function() {

 	
	$(document).on("pagecreate", function() 
	{
	  var nativeDateInputIsSupported = Modernizr.inputtypes.date;
	  if (!nativeDateInputIsSupported)
	  {
	    $("input[type='date']").mobipick();            
	  }
   });

	/* $('#datepicker').datepicker(
	{
		 changeMonth:true,
		 changeYear:true,
		 yearRange:"-100:+0"
	}); */
});


 

</script>
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
    <h1 class="page_heading">Post A <span class="orange_font">Job</span></h1>
    <!--13-08-2013-->
   
     <form:form cssClass="stdform" action="" method="post"  modelAttribute="postJob" id="postForm" >
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
      
       <!--  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="formelement_table"> -->
         <ul>
         
           <!--  <td class="label">Job ID *</td> -->
           <li>
           <!-- <input name="jobId" id="jobId" type="text" tabindex="1" placeholder="Job ID"/> -->
           <div class="labeldetails"> <form:input path="jobId" id="jobId" placeholder="Job Id *" tabindex="1"/> </div>
           
           <c:if test="${not empty postJob.exceptionOccured}">
				<div class="errorblock">${postJob.exceptionMessage}
				</div>
		   </c:if>
         </li>
         
           <!--  <td class="label">Status</td> -->
           <li style="height:69px;padding-top:26px;">
          <div class="labeldetails"> 
           <label class="label_radio r_on">
           
           <form:radiobutton path="status" value="Drafts" checked="true" disabled="true" />&nbsp; Status(Draft)
           
           </label>
           </div>
           </li>
          
         
           <!--  <td class="label">Job Title</td> -->
            <li>
             <div class="labeldetails"> 
             <form:input path="jobTitle" id="jobTitle" placeholder = "Job Title *" tabindex="2"/> 
             <form:errors path="jobTitle" />
             </div>
         	 </li>  
          
        
           <!--  <td class="label">Job Type</td> -->
           <li>
            		<spring:bind path="jobType">
					<c:set var="selectedJobType" value="${status.value}"></c:set>
            		</spring:bind>
          		   
            
            	<div class="labeldetails"> 
            	<select name="jobType" id="jobType" tabindex="3">
                	<option value="Choose One"> Select Job Type</option>
					  <c:forEach var="jobType" items="${jobTypes}">
					  	<c:choose>
					  	<c:when test="${ jobType == selectedJobType}">
                         <option selected="selected" value="<c:out value="${jobType}" />" ><c:out value="${jobType}" /></option> 
					  	</c:when>
					    
					    <c:otherwise>
					     <option value="<c:out value="${jobType}" />"><c:out value="${jobType}" /></option> 
					     </c:otherwise>
                	 </c:choose>
                	 </c:forEach>
						
					
					
			</select>
			   <form:errors path="jobType" />
			
			 </div>
         </li>
          
          
            <!-- <td class="label">Functional Area</td> -->
          <li>
            		<spring:bind path="functionalArea">
					<c:set var="selectedfunctionalArea" value="${status.value}"></c:set>
            		</spring:bind>
            
             <div class="labeldetails">   <select name="functionalArea"  tabindex="4">
                <option value=""> Select Functional Area </option>
                  <c:forEach var="functionalArea" items="${functionalAreaList}">
                        
                        <c:choose>
					  	<c:when test="${ selectedfunctionalArea == functionalArea}">
                         <option selected="selected" value="<c:out value="${selectedfunctionalArea}" />" ><c:out value="${selectedfunctionalArea}" /></option> 
					  	</c:when>
					    
					    <c:otherwise>
					     <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option> 
					     </c:otherwise>
                	 </c:choose>
                        
                       <%--   <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option>  --%>
                 </c:forEach>
                </select> 
                
                 <form:errors path="functionalArea" />
                </div>
         </li>
          
        
            <!-- <td class="label">Industry</td> -->
           <li>
            		<spring:bind path="industry">
						<c:set var="selectedIndustry" value="${status.value}"></c:set>
            		</spring:bind>
         			
            
             <div class="labeldetails">   <select name="industry" tabindex="5" >
                <option value=""> Select Industry </option>
                  <c:forEach var="industry" items="${industryList}">
                        
                        
                         <c:choose>
					  	<c:when test="${ selectedIndustry == industry}">
                         <option selected="selected" value="<c:out value="${selectedIndustry}" />" ><c:out value="${selectedIndustry}" /></option> 
					  	</c:when>
					    
					    <c:otherwise>
					     <option value="<c:out value="${industry}" />"><c:out value="${industry}" /></option> 
					     </c:otherwise>
                	 </c:choose>
                        
                     <%--                  
                         <option value="<c:out value="${industry}" />" ><c:out value="${industry}" /></option>  --%>
 
                 </c:forEach>
                </select> 
                 <form:errors path="industry" />
                </div>
             </li>
			
         
           <!--  <td class="label">Required Primary Skills</td> -->
         <li>
              <div class="labeldetails">
               <form:input id="primarySkills" path="primarySkills" placeholder = "Primary Skills *" tabindex="6"/>
               <form:errors path="primarySkills" />
              </div>
          </li>
           
           <!--  <td class="label">Required Secondary Skills</td> -->
            <li>
         <div class="labeldetails">
        	 <form:input  id="secondarySkills" path="secondarySkills"  placeholder = "Secondary Skills *" tabindex="7"/>
             <form:errors path="primarySkills" />
         </div>
         </li>
          
          
            <!-- <td class="label">Years Of Experience</td> -->
            <li>
           <div class="labeldetails">
           <form:input path="experienceFrom" type="number" id ="experienceFrom"  style="width:40%;" placeholder="Years Of Experience From" tabindex="8" /> 
             <form:errors path="experienceFrom" />
           - <form:input path="experienceTo" id = "experienceTo"  type="number"  style="width:40%;" placeholder="Years Of Experience To"  tabindex="9"/> 
             <form:errors path="experienceTo" /> </div>  
          </li>
        
            <!-- <td class="label">GPA Cut-Off</td> -->
          <li>
          <div class="labeldetails">
          <form:input path="gpaCutOffFrom" id = "gpaCutOffFrom" style="width:40%;" placeholder = "From" tabindex="10"/>  
          - <form:input path="gpaCutOffTo" id = "gpaCutOffTo"  style="width:40%;" placeholder = "To" tabindex="11"/>  </div>
          </li>
         
            <!-- <td class="label">Zip code (Job is posted At)</td> -->
            <li>
           <div class="labeldetails"><form:input path="zipCode" id="zipCode" onChange="getCityFunction()" placeholder="Zip code (Job is posted At) *" tabindex="12" />
            <form:errors path="zipCode" />
             <span id="zipCodeError"></span>
           </div>
           </li>
           
            <!-- <td class="label">City *</td> -->
           <li>
           <div class="labeldetails"><form:input path="location" id="location" placeholder = "City *" tabindex="13"/>
           <form:errors path="location" />
           </div>
          </li>
          
           <!--  <td class="label">Pay Per Week ($)</td> -->
           <li>
            <div class="labeldetails">
            <form:input path="payPerWeek" placeholder = "Pay Per Week ($)" tabindex="14"/>
               <form:errors path="payPerWeek" />
            </div>
           </li>
           
          
           <!--  <td class="label">Job Description</td> -->
           <li>
            <div class="labeldetails">
            	<form:textarea path="jobDescription" id="jobDescription" rows="5" cols="47" placeholder = "Job Description *" tabindex="15"/>
            	<form:errors path="jobDescription" />
            </div>
            </li>
          
          </ul>
      <!--   </table> -->
      </div>
      
 <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
                <div class="buttonwrap">
                <input name="" type="button" value="Preview"  class="orangebuttons" onclick="return postJob();">
                <input name="" type="button" value="Back"  class="orangebuttons" onclick="goBack()">

                </div>
               </li>
          </ul>
        </div>
      </div>
    </form:form>
    </section>
 <!--13-08-2013-->
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