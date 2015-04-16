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
<title>Employer Post Campus Job</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!--19-07-2013 changes-->
<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- <link rel="stylesheet" href="../mobile_html/css/multiple-select.css" /> -->
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
<script src="../mobile_html/js/jquery.validate.min.js"></script>
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>

<!--  <script src="../mobile_html/js/jquery.min.js"></script>
    <script src="../mobile_html/js/jquery.multiple.select.js"></script> -->
<!-- <script>
    $(function() {
        $('.ms').change(function() {
            console.log($(this).val());
        }).multipleSelect();
    });
    
</script> -->

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
	
	
</script>
<script>
  

</script>

<!-- <script>
jQuery(document).ready(function () {

   jQuery('.uniform-file').uniform();

});
</script> -->
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
function goBack()
{
  window.history.back(); 
}

/* $(document).ready(function(){
$('#datepicker').datepicker(
		 {
			 changeMonth:true,
			 changeYear:true,
			 yearRange:"-100:+0"
		 });

});		  */ 
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
    <h1 class="page_heading">Post <span class="orange_font">A Campus Job</span></h1>
    <!--13-08-2013-->
   
    <form:form action="employer_post_campus_job.htm" method="post" modelAttribute="campusJob" class="stdform" id="campusJobPostForm">
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
               <!--  <li>
                <div class="label">Update CV</div>
                <div class="labeldetails"><input type="file"  value="Upload your CV"></div>
              </li>  -->
              
                   
            <li>
           <!-- <input name="jobId" id="jobId" type="text" tabindex="1" placeholder="Job ID"/> -->
           <div class="labeldetails">
          
        						  <c:choose>
										<c:when test="${campusJob.jobUpdateFlag}">
											<form:input  path="jobId" readonly="true" placeholder="Job ID*"  /> 
											
										</c:when>
										<c:otherwise>
											<form:input  path="jobId"  placeholder="Job ID*" /> 
										</c:otherwise>
									</c:choose>
									<form:errors path="jobId"  />
          
          
          
           </div>
         						<c:if	test="${not empty campusJob.exceptionOccured}">
									<div class="errorblock">${campusJob.exceptionMessage}</div>
							    </c:if>
           </li>
                
          <li style="height:69px;padding-top:26px;">
          <div class="labeldetails"> 
           <label class="label_radio r_on">
           
           <form:radiobutton path="status" value="Drafts" checked="true" disabled="true" />&nbsp;Status(Draft)
           
           </label>
           </div>
           </li>
                      
            <li>
              <div class="labeldetails">
             <c:choose>
										<c:when test="${campusJob.jobUpdateFlag}">
											<form:input	 path="jobTitle" readonly="true" placeholder="Job Title *"/> 
										</c:when>
										<c:otherwise>
											<form:input	 path="jobTitle"  placeholder="Job Title *"/> 
										</c:otherwise>
									</c:choose>
									<form:errors path="jobTitle"  /> 
              </div>
            </li>
                                 
            <li class="content">
            
              <spring:bind path="campusJob.jobType">
		    <c:set var="selectedJobType" value="${status.value}"></c:set>
		             </spring:bind>
		              
		             <div class="label">Job Type</div>
		            <div class="labeldetails"> <select name="jobType" id="jobType" tabindex="3">
		                <option value="Choose One"> Select Job Type</option>
		      <c:forEach var="jobType" items="${jobTypes}">
		       <c:choose>
		       <c:when test="${jobType == selectedJobType}">
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
                                
            <li>
            <div class="labeldetails">
            <form:select path="functionalArea" cssClass="chzn-select list_widthstyle1" >
					<form:option value="">Functional Area</form:option>
					<c:forEach var="functionalAreaList" items="${functionalAreaList}">
                     
                     
                    <spring:bind path="campusJob.functionalArea"><c:set var = "functionalAreaSelected" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${functionalAreaList == functionalAreaSelected}">
                         <option value="${functionalAreaList}" selected="selected"><c:out value="${functionalAreaList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${functionalAreaList}"><c:out value="${functionalAreaList}" /></option>
                      </c:otherwise>
                   </c:choose>
                     
                   </c:forEach>
					</form:select>
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
            <form:input path="experienceFrom" id ="experienceFrom" type="number"  style="width:40%;" placeholder="Years Of Experience From"/><form:errors path="experienceFrom"/> - <form:input path="experienceTo" id = "experienceTo" type="number"  style="width:40%;" placeholder="Years Of Experience To" /><form:errors path="experienceTo"/>
            </div>  
            </li>
                       
            <li>
            <div class="labeldetails">
           <form:input type="number" maxlength="6" path="zipCode" id="zipCode" placeholder="Zip code*" onChange="getCityFunction()"/>
           <span id="zipCodeError" class="errorblock"></span>
           <form:errors path="zipCode" />
           </div>
           </li>
                          
            <li>
            <div class="labeldetails">
           <form:input path="location" id="location" placeholder="City*"/>
           <form:errors path="location" />
           </div>
           </li>
           
            <li>
            <div class="labeldetails">
            <form:input path="payPerWeek" type="number" placeholder="Pay Per Week ($)"/>
            <form:errors path="payPerWeek" />
            </div>
            </li>
                                 
            <li>
            <div class="labeldetails">
             <form:select path="industry" cssClass="chzn-select list_widthstyle1">
					<form:option value="">Select Industry</form:option>
					<c:forEach var="industryList" items="${industryList}">
                     
                     
                   <spring:bind path="campusJob.industry"><c:set var = "industrySelected" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${industryList == industrySelected}">
                         <option value="${industryList}" selected="selected"><c:out value="${industryList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${industryList}"><c:out value="${industryList}" /></option>
                      </c:otherwise>
                   </c:choose>
                                          
                   </c:forEach>
                   
					</form:select>
					</div>
			</li>
          
               
            <li>
            <div class="labeldetails">
             <form:input type="number" path="gpaCutOffFrom" id = "from1"  style="width:40%;" placeholder="GPA From"/><form:errors path="gpaCutOffFrom"/> - <form:input type="number" path="gpaCutOffTo" id = "to1"  style="width:40%;" placeholder="GPA To" /><form:errors path="gpaCutOffTo"/>
             </div>   
            </li>
              
           <li>
		    	<div class="labeldetails">
		           <form:select path="campusJobRecipients"   multiple="multiple" placeholder="Select University" items="${universityList}" />
		           	<form:errors path="campusJobRecipients"	/>
		        </div>
            </li>
                  
            <li>
            <div class="labeldetails">
            <form:textarea path="jobDescription" id="jobDescription" placeholder="Job Description*" rows="5" cols="47" />
            <form:errors   path="jobDescription" />
            </div>  
           </li>
          
        </ul>
        
      </div>
       <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
              <input name="previewBtn" type="submit" value="Preview"  class="orangebuttons" >
              <input name="backBtn" type="button" value="Back"  class="orangebuttons" onclick="goBack()">
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


		<div class="par pickup_details_cont">
        </div>
     
</body>
</html>