<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>Employer Schedule Event</title>
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
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- <link href="../mobile_html/css/royalslider.css" rel="stylesheet"> -->
<link rel="stylesheet" href="../mobile_html/css/uniform.tp.css" type="text/css" />
<!-- <script src="../mobile_html/js/jquery-1.7.min.js"></script> -->
<script src="../mobile_html/js/jquery-ui-1.9.2.min.js"></script>
<script src="../mobile_html/js/jquery-ui.js"></script>

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery-1.8.3.js" type="text/javascript"></script> -->
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<!-- <script src="../mobile_html/js/jquery.royalslider.min.js"></script> -->
<script src="../mobile_html/js/prettify.js"></script>
<script src="../mobile_html/js/jquery.validate.min.js"></script>
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
function editPostedEvent(){
	var formDetails = $("#employerScheduleEventForm");
	document.forms[0].action = 'employer_update_event.htm?'+<%=request.getParameter("eventId") %>;
	formDetails.submit();
}


</script>

<!-- <script>
jQuery(document).ready(function () {

   jQuery('.uniform-file').uniform();

});
</script> -->
<script>
 /* $(function() {
  }); */


/* create datepicker */
jQuery(document).ready(function() {

	
/*  jQuery('#datepicker').datepicker(
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
function postJob()
{
	 var formValue= document.getElementById("postForm");
	 formValue.action='employer_preview_of_job.htm';

	  var inputVal= $("#tags1").val();
	  
	  var inputVal1= $("#primarySkills").val();
	  var characterReg1 = "";
    	     
 	        var characterReg = "";
 	        
 	  if(characterReg1==inputVal1) 
 	  {
 	 	$("#spn1").remove();
        $("#primarySkills_tagsinput").after('<span id="spn1"  style="color: #f00; font-size: 11px;">Fill Primary skills</span>');
      }
	 	  if(characterReg1!=inputVal1)
		  {
			  $("#spn1").remove();
			  $("#primarySkills").after('<span class="error">  </span>');   		  
		  } 
		   	
      	  if(characterReg==inputVal)
          {  
	    	$("#spn2").remove();
	        $("#tags1_tagsinput").after('<span id="spn2"   style="color: #f00; font-size: 11px;">Fill Secondary skills</span>');   
    	  }  	  
      	  
    	  if(characterReg!=inputVal)
    	  {
    		  $("#spn2").remove();
    		  $("#tags1_tagsinput").after('<span class="error">  </span>');   		  
    	  }
	 
	 	if($('#postForm').valid())
		{
	    	  if(characterReg!=inputVal && characterReg1!=inputVal1)
	    	  {
	    			formValue.submit(); 
	    	  }
		}  	  


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
	$.validator.setDefaults({ ignore: ":hidden:not(select)" });
	$("#employerSched").validate({
		rules: {
			eventName: "required",
			universityName: "required",
			functionalAreaMulti: "required",
			expectations:"required",
			startDate: {
				 required : true,                 
				 trioDate: true
			},
			endDate:{
	              // greaterThan: "#datepicker1",
	               required : true,                 
	  			   trioDate:true
	            },
			
		},
		messages: {
			eventName: "Please enter your event name",
			universityName: "Please enter your university name",
			functionalAreaMulti: "Please enter your university name",
			expectations:"Please mention your Expectations",
			startDate: { 
				required: "Please provide  Start Date",
                trioDate:"Enter format yyyy-mm-dd"
            },
			endDate:
            { 
				required: "Please provide  End Date",
				//greaterThan:"End Date < Start Date!",
                trioDate:"Enter format yyyy-mm-dd"
            }
		}
	});
	
	
	$('[id*="noOfHiringsMulti"]').each(function ()
	{
        $(this).rules('add', {
            required: true,
            messages: {
                required: "Please provide number of hirings"
            }
        });
    });
	
	$('[id*="functionalAreaMulti"]').each(function () {
        $(this).rules('add', {
            required: true,
            messages: {
                required: "Please select Functional Area"
            }
        });
    });
	

});

function checkDate()
{	
	var fromDate = $("#datepicker1").val();
	var toDate = $("#datepicker2").val();
	if (Date.parse(fromDate) > Date.parse(toDate)) 
	{
	    alert("Invalid Date Range!\n Start Date cannot be after End Date!")
	    return false;
	} 
}

$(document).on("pagecreate", function() {
	  var nativeDateInputIsSupported = Modernizr.inputtypes.date;
	  if (!nativeDateInputIsSupported) {
	    $("input[type='date']").mobipick();  
	    $("input[type='time']").mobipick();             
	  }
	});
</script>


</head>
<body class="employer">
<div id="main_wrap">
  <%@ include file="includes/header.jsp"%>
 
  <div id="mid_wrap" class="midwrap_toppadding">
    <section id="inner_container">
    <h1 class="page_heading">Schedule <span class="orange_font">Event</span></h1>
    <!--13-08-2013-->
   
    <form:form action="employer_schedule_event.htm" method="post" modelAttribute="employerEventCom" class="stdform" id="employerScheduleEventForm" >
    <div class="par pickup_details_cont">
      </div>
      <div class="profiletabs_wrap">
      <ul class="form_wrap">
    		<li>
    		<div class="label">Event Name*</div>
    		
            <div class="labeldetails">
            <form:input path="eventName" tabindex="1" />
            <form:errors path="eventName" > </form:errors></div>
    		</li>
    		
    		<li>
    		<div class="label">University Name * </div>
    		 <div class="labeldetails">
    		<form:select path="participatingUniversity" id="participatingUniversity" tabindex="2" data-placeholder="Choose an Option" items="${universityList }" />
	    		<%--  <form:select path="universityName"  data-placeholder="Choose an Option" tabindex="2" >
	                <form:option value="">University Name</form:option>
	                <form:options items="${universityList}" />                    
	            </form:select> --%>
              <form:errors path="participatingUniversity" /> 
            </div>
    		</li>
    		
    		<li>
    		<div class="label">Expectations from the Event * </div>
    		 <div class="labeldetails">
	    		 <form:textarea path="eventDescription" id="expectations" tabindex="3" cols="80" rows="5"/>
	             <form:errors path="eventDescription" > </form:errors>
             </div>
    		</li>
    		
    			<li>
    		<div class="label">Event Location * </div>
    		
            <div class="labeldetails">
            <form:input path="eventLocation" tabindex="4" />
            <form:errors path="eventLocation" > </form:errors></div>
    		</li>
       
	       <li>
	       <div class="label">Proposed Start Date * </div>
	       <div class="labeldetails"><form:input type="date" path="startDate" placeholder="Start Date" tabindex="5" id="datepicker1"/>      
             <form:errors path="startDate" > </form:errors></div>
	       </li>
	       
	        <li>
          <div class="label">Proposed End Date * </div>
          <div class="labeldetails"><form:input  type="date" path="endDate" placeholder="Start Date" tabindex="6" id="datepicker2"/>      
             <form:errors path="endDate" ></form:errors> </div>
          </li>
          
	       
	       <li>
	       <div class="label">Proposed Start Time * </div>
	       <div class="labeldetails"><form:input type="time"  path="startTime" tabindex="7" id="timepicker1" />
              <form:errors path="startTime" ></form:errors></div>
	       </li>

          <li>
          <div class="label">Proposed End Time * </div>
          <div class="labeldetails"><form:input type="time" path="endTime" tabindex="8" id="timepicker2" />     
             <form:errors path="endTime" ></form:errors> </div>
          </li>
         
          <li>
          <div class="label">Functional Area</div>
          <div class="labeldetails">
          
          <form:select path="functionalAreas[0]" items="${functionalAreaList}" tabindex="9">
          	
          </form:select>
          <%-- 
          <select name="functionalArea" tabindex="6">
                <option value="">Functional Area </option>
                  <c:forEach var="functionalArea" items="${functionalAreaList}">
                         <option value="<c:out value="${functionalArea}" />" ><c:out value="${functionalArea}" /></option> 
                 </c:forEach>
                </select> --%>
                
                </div>
          </li>
        
          <%--  <c:forEach begin="0" end="${multivalues}" var="m">
         <c:set var="m" value="${multivalues}"></c:set> --%>
          
          <li>
	          <div class="label"> Hiring Count * </div>
	          <div class="labeldetails">
	          <form:input path="numberOfHirings[0]" tabindex="10" placeholder="" id="noOfHiringsMulti" />
	          <form:errors path="numberOfHirings" />
	          </div>
          </li>
          
          <li>
          	 <div class="label"> Minimum Salary Offered </div>
	         <div class="labeldetails">
		         <form:input path="minimumSalaryOffered[0]" tabindex="11" placeholder="Min. Salary" class="valid" />
		          <form:errors path="minimumSalaryOffered" />
	         </div>
          </li>
          
          <li>
         <div class="label"> Batch Of Passing </div><br>
           <div class="labeldetails">
          <%--  <input type="text" name="gpaFromMulti" placeholder="From" tabindex="9" class="valid" value="<c:out value="${gpaFromEdit[m]}"/>" style="width:40%;"/>-
           <input type="text" name="gpaToMulti"  placeholder="To" tabindex="10" class="valid" value="<c:out value="${gpaToEdit[m]}"/>" style="width:40%;"/> --%>
           <form:select  path="eligibleBatches[0]" tabindex="12" items="${eligibleBatches }" />
           	<form:errors path="eligibleBatches"  />
           
           </div>
          </li>
          
          
        <%--   </c:forEach> --%>
       
        </ul>
      </div>
      

      <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
            
               <c:choose>
	            	<c:when test="${ not empty editMode && editMode}">
	            		<form:hidden path="eventId" value='<%= request.getParameter("eventId") %>' />
	            		<input type="submit" class="orangebuttons" onclick="editPostedEvent()" value = "Preview &amp; Post"/>
	            	</c:when>
	            	<c:otherwise>
		                <input name="submitBtn" type="submit" class="orangebuttons" value="Preview &amp; Post" tabindex="21" onclick="return checkDate();">
	            	</c:otherwise>
	            </c:choose> 
	            <input name="cancelBtn" type="button" value="Cancel" class="orangebuttons" onclick="window.location.href='employer_campus_connect.htm'" />
            
	          <!--   <input name="submitBtn" type="submit" value="Preview &amp; Post" class="orangebuttons" onclick="return checkDate();"> -->
            
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