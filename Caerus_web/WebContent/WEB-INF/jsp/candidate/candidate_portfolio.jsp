<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Portfolio</title>
<meta name="description" content="">
<meta name="author" content="">
<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
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
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>
<link rel="stylesheet" href="css/dots.css" type="text/css">


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
<script type="text/javascript" src="js/jquery-loader.js"></script>
<script type="text/javascript" src="js/jquery.pajinate.js"></script>

<script type="text/javascript" src="js/portfolio_script.js"></script>
<script type="text/javascript" src="js/portfolio_linkedIn_script.js"></script>

<script type="text/javascript" src="http://platform.linkedin.com/in.js">
  api_key: 75eflau76qbl9b
  onLoad: onLinkedInLoad
  //authorize: true 
</script>

<script type="text/javascript">

$(window).load(function() 
{
    // executes when complete page is fully loaded, including all frames, objects and images
    $('#loader').fadeOut();
}); 

    $(document).ready(function () {

    	var emptyCheck = $("#emptyProfile").val();

    	if(emptyCheck != null && emptyCheck != "")
        {
    		$("#successMessageSpan").empty().append("Please fill in the Introductory and Education details");
    		
  	      	$("#chgPasswordModal").dialog({
  	            modal: true,
  	            open: function(event, ui){
  	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
  	            }
  			});
        }

    	var videoVerification = $("#videoVerification").val();

    	if(videoVerification != null && videoVerification != "")
        {
    		$("#myModalLabelHeading").empty().append("Verification");
            
    		$("#successMessageSpan").empty().append("Thank you for uploading your video , once the video verification is complete the corporates would be able to see your video profile.");
    		
  	      	$("#chgPasswordModal").dialog({
  	            modal: true,
  	            open: function(event, ui){
  	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
  	            }
  			});
        } 

	var fileUploadError = $("#fileUploadError").val();

	if(fileUploadError != null && fileUploadError.trim().length > 0)
		{
			$("#videoError").empty().append(fileUploadError);
		}

    	
    	// Setting the year range for publication date
		var dateOfBirth = $("#datepicker").val();
		var arr = new Array();
		arr =  dateOfBirth.split("-");
		var publicationYear = +arr[0] + +13;
		var yrRange = publicationYear + ":+ 0";
		
    	
    	$(function() {
    		$( "#datepicker" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-30:+0"
    		});
    		$( "#publicationDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: yrRange
    		});
    	});

    	var referrer =  document.referrer;
    	if(referrer.indexOf("?") > -1)
        {
    		var referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.lastIndexOf("?"));        	
        }
    	else
        {
    		var referrerUrl = referrer.substring(referrer.lastIndexOf("/") + 1, referrer.length);
        }
    	
    	
     	$(".recent_activities_wrap li").attr('id', function(i) {
  		  $(this).attr('id', "number" + i);
  		});

    	$(".recent_activities_wrap li a").attr('id', function(i) {
    		  $(this).attr('id', "q" + i);
    		}); 

    	$(".topborder_lists li ").attr('id', function(i) {
	  		  $(this).attr('id', "list" + i);
	  		});
	
    	$(".topborder_lists li div span").attr('id', function(i) {
	  		  $(this).attr('id', "listDetails" + i);
	  		});
    	
    	 //$('#loader').delay(4500).fadeOut();
        
        var languageList = $("#hideLanguage").val();
        if(languageList == "")
        {
        	$("#languagesKnown").hide();
        }
        
 		var certificationArray =  new Array();
 		certificationArray = $("#hideCertificates").val();
        
         if(typeof certificationArray === "undefined")
        {
        	$("#certificates").hide();     	
    	} 

         var publicationArray =  new Array();
         publicationArray = $("#hidePublications").val();
         
          if(typeof publicationArray === "undefined")
         {
         	$("#publicationsLabel").hide();     	
     	 } 

          var workArray =  new Array();
           workArray = $("#hideWork").val();   
           if(typeof workArray === "undefined")
           {
          	   $("#workDisplay").hide();     	
      	   } 
    	 
        $("#present").hide();
        
        var presentWork = $("#currentlyWorking").val();
        if(presentWork == "true")
        {
        	$("#endWorkDuration").hide();
        	$("#present").show();
        	
        	$("#currentCheckbox").prop("checked", true);
        	
        }
        
    var first = $("#first").val();
    if(first == "true")
    {
 			$("#dialog").dialog({
             
             modal: true,
    		draggable: false,
      });
    }

		$("#introduction").click(function(){
			$('#a').css("display", "block");
			$('#introduction').addClass("ui-tabs-active ui-state-active");
			sessionStorage.setItem("currentDiv","a");
			var prev=sessionStorage.getItem("previousTab");
			if(!(prev == "introduction"))
			switchClass();
			});
		$("#education").click(function(){
			sessionStorage.setItem("currentDiv","b");
			var prev=sessionStorage.getItem("previousTab");
			if(!(prev == "education"))
			switchClass();
			});
		$("#skills").click(function(){
			sessionStorage.setItem("currentDiv","c");
			var prev=sessionStorage.getItem("previousTab");
			if(!(prev == "skills"))
			switchClass();
			});
		$("#work").click(function(){
			sessionStorage.setItem("currentDiv","d");
			var prev=sessionStorage.getItem("previousTab");
			if(!(prev == "work"))
			switchClass();
			});
		$("#others").click(function(){
			sessionStorage.setItem("currentDiv","e");
			var prev=sessionStorage.getItem("previousTab");
			if(!(prev == "others"))
			switchClass();
			});


		var div = sessionStorage.getItem("currentDiv");
		//if(div === 'b' || div === 'c' || div === 'd' || div === 'e')
		
		if(referrerUrl === 'candidate_portfolio.htm')
		{
			if(!(div))
			{
				$("#a").css("display", "block");
				$('#introduction').addClass("ui-tabs-active ui-state-active");
			}

			else
			{
				$("#introduction").removeClass("ui-tabs-active ui-state-active");
					
				$("#a").css("display", "none");
				$('#'+div).css("display", "block");
			}

			if(div === 'a')
			{
				$('#introduction').addClass("ui-tabs-active ui-state-active");
				sessionStorage.setItem("previousTab","introduction");
				sessionStorage.setItem("previousDiv","a");
			}
			
			if(div === 'b')
			{
				$('#education').addClass("ui-tabs-active ui-state-active");
				sessionStorage.setItem("previousTab","education");
				sessionStorage.setItem("previousDiv","b");
			}

			if(div === 'c')
			{
				$('#skills').addClass("ui-tabs-active ui-state-active");
				sessionStorage.setItem("previousTab","skills");
				sessionStorage.setItem("previousDiv","c");
			}

			if(div === 'd')
			{
				$('#work').addClass("ui-tabs-active ui-state-active");
				sessionStorage.setItem("previousTab","work");
				sessionStorage.setItem("previousDiv","d");
			}

			if(div === 'e')
			{
				$('#others').addClass("ui-tabs-active ui-state-active");
				sessionStorage.setItem("previousTab","others");
				sessionStorage.setItem("previousDiv","e");
			}

		}
		else
		{
			$("#a").css("display", "block");
		}

	function switchClass()
	{
		var prev=sessionStorage.getItem("previousTab");
		$('#'+prev).removeClass("ui-tabs-active ui-state-active");

		var previousDiv = sessionStorage.getItem("previousDiv");
		$("#"+previousDiv).css('display','none');

	}


	if(referrerUrl === 'candidate_job_activities.htm' || referrerUrl === 'candidate_preview_listed_job.htm' || referrerUrl === 'candidate_recommended_jobs.htm' || referrerUrl === 'candidate_job_listing.htm' || referrerUrl === 'candidate_view_internship.htm')
	{
		$("#emptyPortfolioDiv").empty();
		$("#emptyPortfolioDiv").append("Please fill in your education details and upload your resume");
		
	}

	$("#message2").charCount({
		   allowed: 2000,  
		   warning: 20,
		   counterText: 'Characters left: ' 
		  });
	
	function suggestSkills(id,value){
		
		$.getJSON( "/suggest_skills.json",'skill='+value, function(returnedWords ) {
			var suggestedSkills = [];
			suggestedSkills = returnedWords;
			
			   $( "#"+id ).autocomplete({
		         		source: suggestedSkills,
		 				focus: function( event, ui ) {
		        	 
		        	 var displayProperty = $("#ui-id-2").css("display");
		             if(displayProperty == "block"){
		            	 $.fn.fullpage.setKeyboardScrolling(false);
		            	 $.fn.fullpage.setAllowScrolling(false);
		             }
		            },
		            close: function( event, ui ) {
		                
		                var displayProperty = $("#ui-id-2").css("display");
		                  if(displayProperty == "none"){
		                   $.fn.fullpage.setKeyboardScrolling(false);
		                   $.fn.fullpage.setAllowScrolling(true);
		                  } 
		                
		                 }
		       }); 

		   //Hide message shown after search is retrieved (Eg. 3 results match your search, use mouse keys)
		   $("span.ui-helper-hidden-accessible").hide();

		 	   
		   $( "#"+id ).on( "autocompletefocus", function( event, ui ) {} );
		   $(  "#"+id  ).on( "autocompleteclose", function( event, ui ) {} ); 
			 }); 
		
	}
	
	
	$("#primarySkills_tag").on('change keyup paste',function(){
		suggestSkills("primarySkills_tag",$("#primarySkills_tag").val());
	}); 
	
	
	$("#tags1_tag").on('change keyup paste',function(){
		suggestSkills("tags1_tag",$("#tags1_tag").val());
	}); 
	
	
	
	
	
    });
    
</script>


<script type="text/javascript">
$(document).ready(function (e) {
	
	
	/* function suggestSkills(){
		alert("Suggest"); 
		alert("Suggest");
		
		
		
		
	}
	 */
	
	
	
	
    $('#imgform').on('submit',(function(e) {
        e.preventDefault();
        var formData = new FormData(this);
		
        $.ajax({
            type:'POST',
            url: $(this).attr('action'),
            data:formData,
            cache:false,
            contentType: false,
            processData: false,
            success:function(data){

            //	window.location.reload();
        	 	$('.myDiv').empty();
        	 	$('.myDiv').append('<img src="view_image.htm?emailId=${emailId}" width="152" height="152" alt="">');


        	 	$("#myModalLabelHeading").empty().append("Verification");
                
        		$("#successMessageSpan").empty().append("Thank you for uploading your photo , once the photo verification is complete the corporates would be able to see you.");
        		
      	      	$("#chgPasswordModal").dialog({
      	            modal: true,
      	            open: function(event, ui){
      	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
      	            }
      			});
        	 	
                console.log(data);
            },
            error: function(data){
                alert("error");
                console.log(data);
            }
        });
    }));

    $("#uploadPhoto").on("change", function() {        
        $("#imgform").submit();
});
});

//Put event listeners into place
window.addEventListener("DOMContentLoaded", function() {
	
//Grab elements, create settings, etc.
var canvas = document.getElementById("canvas"),
context = canvas.getContext("2d"),
video = document.getElementById("video"),
videoObj = { "video": true },
errBack = function(error) {
console.log("Video capture error: ", error.code); 
};


//Put video listeners into place
if(navigator.getUserMedia) { // Standard
navigator.getUserMedia(videoObj, function(stream) {
video.src = stream;
video.play();
}, errBack);
} else if(navigator.webkitGetUserMedia) { // WebKit-prefixed
navigator.webkitGetUserMedia(videoObj, function(stream){
video.src = window.webkitURL.createObjectURL(stream);
video.play();
}, errBack);
} else if(navigator.mozGetUserMedia) { // WebKit-prefixed
navigator.mozGetUserMedia(videoObj, function(stream){
video.src = window.URL.createObjectURL(stream);
video.play();
}, errBack);
}


//Trigger photo take
document.getElementById("snap").addEventListener("click", function() {
	
context.drawImage(video, 0, 0, 352, 264);
//Littel effects
$('#video').css('display','none');
$('#canvas').css('display','block').fadeIn('slow');
$('#snap').css('display','none');
$('#new').show();

//Also show upload button
$('#upload').css('display','inline-block');
});


//Capture New Photo
document.getElementById("new").addEventListener("click", function() {
	
$('#video').css('display','block').fadeIn('slow');
$('#canvas').css('display','none');
$('#snap').show();
$('#new').hide();
});


//Upload image to sever 
document.getElementById("upload").addEventListener("click", function(){

	var dataUrl = canvas.toDataURL("image/jpeg");

	$.ajax({
	type: "POST",
	url: "capture_image.htm",
	
	cache : false,
	data : {
	'data' : dataUrl,
	},
	success : function(data) {

		$('#imageCapture').css('display','none');

		$('.myDiv').empty();
		$('.myDiv').append('<img src="view_image.htm?emailId=${emailId}" width="152" height="152" alt="">');

		$("#myModalLabelHeading").empty().append("Verification");
        
		$("#successMessageSpan").empty().append("Thank you for uploading your photo , once the photo verification is complete the corporates would be able to see you.");
		
	      	$("#chgPasswordModal").dialog({
	            modal: true,
	            open: function(event, ui){
	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
	            }
			});
		
	},
	error : function(xhr,error) {
		alert("Failed");
	}
	
	});
	
});
}, false);
</script>

<style type="text/css">
/* .smalltxt {
	font-size: 11px !important;
} */
a:link, a:hover, a:visited, .form_wrap a:hover{text-decoration:none;color:#000}

.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:20% !important;}

/* #workDisplay,#certificateDisplay,#publicationDisplay {
	
	width: 100%;
	margin-bottom: 5px;
}
 */
/* #workDisplay .topborder_lists,#certificateDisplay .topborder_lists,#publicationDisplay .topborder_lists
	{
	border-bottom: 1px solid #fff;
	float: left;
	width: 100%;
	margin:0;
	padding:0;
} */

.hover {
	cursor: pointer;
	cursor: hand;
}
/* .fullwidth{width:58em;}
.ui-tabs.ui-tabs-vertical .ui-tabs-panel{padding-left:0;}
.ui-tabs.ui-tabs-vertical .ui-tabs-nav li a span {font-size: 20px;text-transform: capitalize;}
.ui-tabs.ui-tabs-vertical .ui-tabs-nav li a, .ui-tabs.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active a{height:auto;}
 */

 .ui-tabs.ui-tabs-vertical .ui-tabs-nav li a label{margin-top:0em; color:#000;font-size: 20px;text-transform: capitalize;}
.ui-dialog-titlebar{
	display:none;
}
 </style>

</head>
<body class="dashboard">
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		<%@ include file="includes/header.jsp"%>
		<!--------------  Header Section :: end ----------->
		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
		
			<div id="innerbanner_wrap">
				<div id="banner">
					<img src="images/candidate_innerbanner.jpg"
						alt="Kickstart your carrer. Sign Up Now!">
				</div>
				<div class="clear"></div>
			</div>

			<div id="innersection">
				
				<c:if test="${not empty param.MSG}">
					<div class="error_message_span validationnote">
						<c:out value="${param.MSG}"></c:out>
					</div>
				</c:if>
				
				<div id="emptyPortfolioDiv" class="error_message_span validationnote"></div>
				<%-- <c:if test="${not empty errorMsg}">
					<div class="error_message_span validationnote">
						<c:out value="${errorMsg}"></c:out>
					</div>
				</c:if> --%>

				<div class="clear"></div>
				<div class="container">
					<div id="tabs" class="ui-tabs-vertical">
    <ul class="ui-tabs-nav">
        <li id="introduction">
            <a href="#a" class="education"><img src="images/introduction_icn.png" alt="About Me" align="absmiddle" style="text-align: center;
display: inline;width: 48px;height: 48px;"/> <label>Introduction</label> </a>
        </li>
        <li id="education">
            <a href="#b" class="education blue"><img src="images/education_icn.png" alt="Qualification Details" align="absmiddle" style="text-align: center;
display: inline;width: 48px;height: 48px;" /><label>education</label></a>
        </li>
        <li id="skills">
            <a href="#c" class="education green"><img src="images/skills_icn.png" alt="Skills Glossary" align="absmiddle" style="text-align: center;
display: inline;width: 48px;height: 48px;" /><label>skills</label></a>
        </li>
        <li id="work">
            <a href="#d" class="education darkblue"><img src="images/work_icn.png" alt="Experience Details" align="absmiddle" style="text-align: center;
display: inline;width: 48px;height: 48px;" /><label>Work</label></a>
        </li>
        <li id="others">
            <a href="#e" class="education floragreen"><img src="images/resume_icn.png" alt="Details for CV" align="absmiddle" style="text-align: center;
display: inline;width: 48px;height: 48px;" /><label>resume</label></a>
        </li>
    </ul>
   
    <div id="a" class="whitebackground">
       <div class="fullwidth">
       <input type="hidden" id="emptyProfile" value="${emptyProfile}">
       <input type="hidden" id="videoVerification" value="${videoVerification}">

								<div class="borderbottom doublebottom_margin padding_bottom margin_top2">
									<form:form action="candidate_upload_photo.htm" method="post"
										modelAttribute="addStudent" class="stdform"
										enctype="multipart/form-data" id="imgform">
										<c:set var="firstLogin" value="${firstLogin}" />
										<input type="hidden" id="first" value="${firstLogin}" />

										<h3 class="blutitle18">Introduction</h3>
										<div class="floatleft width100 par">
										<div class="leftsection_form" style="width:auto;">
											<div>
												
												<c:set var="photoName" scope="session" value="${photoName}" />
												<c:choose>
													<c:when test="${photoName == null}">
														<div class="candidate_protfolio_picture floatleft myDiv">
															<img src="images/Not_available_icon1.png" width="152"
																height="152" alt="">
														</div>
													</c:when>

													<c:otherwise>
														<div class="candidate_protfolio_picture floatleft myDiv">
															<img src="view_image.htm?emailId=${emailId}" width="152"
																height="152" alt="">
														</div>
													</c:otherwise>
												</c:choose>
												


											</div>
										</div>
										<div class="rightsection_form">
											<span class="field doubletop_margin"> <input
												type="file" class="uniform-file" name="filePhoto"
												id="uploadPhoto" /> 
												<div class="clear"></div><br>
												<span class="stdform"><a class="orangebuttons"  data-toggle="modal" href="#imageCapture">Take Your Photo (Webcam)</a></span>
												<div class="floatleft candidate_protfolio_picture_txt">
													<p class="smalltxt">
														Supported file formats: png, jpg, gif. Maximum file size:
														500 kb <br /> For Better Clarity Upload File of Dimension
														152 (width) X 152 (Height)
													</p>
												
												</div>
											</span>
									
										</div>
										
										</div>
										<div class="clear"></div>

									</form:form>
									<form:form action="" method="post" modelAttribute="addStudent" class="stdform" id="intro">
										<div class="leftsection_form">
											<div class="par">
												<label class="floatleft">First Name</label> <span
													class="star">*</span>
												<div class="clear"></div>
												<span class="field"> <form:input path="firstName"
														class="input-large" tabindex="1" ></form:input> <form:errors
														path="firstName" cssClass="validationnote" />
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="emptyFirstName"></label>
											<div class="par">
												<label class="floatleft">Email Id</label> <span class="star">*</span>
												<div class="clear"></div>
												<span class="field"> <form:input path="emailID"
														class="input-large" readonly="true" tabindex="3" /> <form:errors
														path="emailID" cssClass="validationnote" />
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Address</label>
												<div class="clear"></div>
												<span class="field"> <form:input path="address"
														class="input-large" tabindex="5" /> <form:errors
														path="address" cssClass="validationnote" />
												</span>
											</div>
											
											<div class="par floatleft" style="padding-top: 5px;">
												<label class="floatleft">Gender: &nbsp;&nbsp;</label> 
												<div class="clear"></div>
												<span class="field floatleft"> <c:choose>
														<c:when test="${status_M_F == 'Female'}">
															<form:radiobutton path="gender" value="Female"
																checked="true" name="radiofield" class="r1" />
														</c:when>
														<c:otherwise>
															<form:radiobutton path="gender" value="Female"
																name="radiofield" class="r1" />
														</c:otherwise>
													</c:choose> <span class="right_padding">Female</span> <c:choose>
														<c:when test="${status_M_F == 'Male'}">
															<form:radiobutton path="gender" value="Male"
																checked="true" name="radiofield" class="r2" />
														</c:when>
														<c:otherwise>
															<form:radiobutton path="gender" value="Male"
																name="radiofield" class="r2" />
														</c:otherwise>
													</c:choose> Male
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="emptyGender"></label>
										</div>
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">Last Name</label> <span
													class="star">*</span>
												<div class="clear"></div>
												<span class="field"> <form:input path="lastName"
														class="input-large" tabindex="2" /> <form:errors
														path="lastName" cssClass="validationnote" />
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="emptyLastName"></label>
											<div class="par">
												<label class="floatleft">Mobile No</label>
												<div class="clear"></div>
												<span class="field"> <form:input path="mobileNumber"
														class="input-large" tabindex="4" id="mobileNumber" /> <form:errors
														path="mobileNumber" cssClass="validationnote" />
														<span class="errorblock" id="phoneNumberErrorMessage"></span>
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Zip Code</label> <span class="star">*</span>
												<div class="clear"></div>
												<span class="field"> <form:input path="zipCode"
														maxlength="5" class="input-large" tabindex="6" /> <form:errors
														path="zipCode" cssClass="validationnote" /> <br> <span
													class="errorblock" id="zipCodeError"><c:out
															value="${zipCodeErrorMessage}" /></span>
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="errorZipCode"></label>
											
											<div class="par">

												<span class="field"> <label
													class="floatleft padding_top">Date of Birth</label> <span
													class="star">*</span> &nbsp;&nbsp;
													<div class="clear"></div>
													<form:input
														path="dateOfBirth" class="input-small_date"
														id="datepicker" value="" readonly="true" tabindex="7" />
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="emptyDOB"></label>
										</div>
										<div class="par floatright clear">
											<input name="submitIndroductory" type="button" value="Save"
												tabindex="8" class="add_participants top_margin"
												onclick="return validateIntro();">
										</div>
										<div class="clear"></div>

									</form:form>
								</div>
							</div>
    </div>
    <div id="b" class="whitebackground ">
        <div class="fullwidth margin_top2" id="presence">
										
										<h3 class="blutitle18">Education</h3>
        
        							<br>
        							<div class="borderbottom doublebottom_margin doubletop_margin padding_bottom">
        							<div class="top_margin">
        							 <h4 class="blutitle14">High School profile</h4>
        							 </div>
									 <div class="clear"></div>
										
										
										
											<%-- <div class="fullwidth doubleright_margin" id="schoolDisplay">
											<div class="right_detailswrap">
											<input type="hidden" id="schoolDetails" value="${schoolDetails}" />
												<ul class="topborder_lists">
													<li class="hover" onclick="fillSchoolDetails(this.id)">
														<div class="floatleft">
															<div class="orangetxt12">
																<span class="schoolNameDisplay"><c:out value="${schoolDetails.schoolName}" /> </span>
																<c:if test="${not empty schoolDetails.schoolState}"></c:if>
																(<span class="schoolStateDisplay" ><c:out value="${schoolDetails.schoolState}" /></span>)

															</div>
															
															<div class="greytxt_nomargin">
																<span class="schoolGpaDisplay"> <c:out value="${schoolDetails.schoolGpaFrom}" />/
																<c:out value="${schoolDetails.schoolGpaTo}" />
																</span>
															</div>

														</div>
														<div class="floatright">

															<div class="orangetxt12">
																<span class="schoolDurationDisplay"> <c:choose>
																		<c:when test="${schoolDetails.schoolPassingMonth == '1'}"> Jan </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '2'}">  Feb  </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '3'}">  March </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '4'}">   April </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '5'}">  May  </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '6'}">   June </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '7'}">    July  </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '8'}">   Aug  </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '9'}">  Sept </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '10'}">  Oct </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '11'}">   Nov </c:when>
																		<c:when test="${schoolDetails.schoolPassingMonth == '12'}">    Dec  </c:when>
																	</c:choose> 
																	<c:out value="${schoolDetails.schoolPassingYear}" /> 
																</span>
															</div>
															
														</div>

													</li>
													
												</ul>
												
											</div>
											<div class="clear"></div>	
									</div> --%>
									
										
				<form:form action="" method="post" modelAttribute="portfolioDetailsCmd" class="stdform borderbottom" id="candidateSchoolEducation">
											<div class="leftsection_form">
											<div class="par">
												<label class="floatleft">School Name</label>
												<div class="clear"></div>
												<span class="formwrapper"> 
												<form:input path="schoolName" id ="schoolName" class="input-large" tabindex="16" /> 
														<form:errors path="schoolName" cssClass="validationnote" />
														<label class="error" id="errorSchoolName"></label>
												</span>
											</div>
											<div class="par">
                  <label class="floatleft">State</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
				<c:set var="stateListSession" scope="session" value= "${schoolStateName}" />
						<form:select id ="schoolState" path="schoolState" cssClass="chzn-select" style="width:475px !important;" tabindex="19">
					<form:option value="">Choose an Option</form:option>
						<c:forEach var="stateList" items="${stateList}">
							<option value="<c:out value="${stateList}" />" <c:if test="${stateList == stateListSession}">selected="selected"</c:if>><c:out value="${stateList}" /></option>
	                   </c:forEach>
					</form:select>
					<label class="error" id="errorSchoolState"></label>
                  </span> </div>
				  </div>
										
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">GPA</label> <!-- <span class="star">*</span> -->
												<div class="clear"></div>
												<span class="field floatleft"> 
												<form:input
														id="schoolGpaFrom" path="schoolGpaFrom" placeholder="Score"
														class="input-profile" tabindex="17" />
												</span> 
												<span class="date_divider">/</span> 
												<span class="">
													<form:input id="schoolGpaTo" path="schoolGpaTo"
														placeholder="Out of" class="input-profile" tabindex="18" />
												<label class="error" id="errorSchoolGpa"></label>
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="emptyGpaSchool"></label>
											<div class="par">
												<label class="floatleft">Passing Month and Year</label>
												<div class="clear"></div>
												
												
													<span class="field floatleft input-small doubleright_margin">
													<form:select path="schoolPassingMonth" class="input-small month right_margin" id="schoolPassingMonth"
														tabindex="30">
														<form:option value="1">Jan</form:option>
														<form:option value="2">Feb</form:option>
														<form:option value="3">Mar</form:option>
														<form:option value="4">Apr</form:option>
														<form:option value="5">May</form:option>
														<form:option value="6">Jun</form:option>
														<form:option value="7">Jul</form:option>
														<form:option value="8">Aug</form:option>
														<form:option value="9">Sep</form:option>
														<form:option value="10">Oct</form:option>
														<form:option value="11">Nov</form:option>
														<form:option value="12">Dec</form:option>
													</form:select> 
													<small class="desc">Passing Month</small>
												     </span>
												
												<span class="floatleft"> 
												<form:select
														path="schoolPassingYear"
														class="input-small year right_margin increment_year"
														id="schoolPassingYear" tabindex="21">
														<c:forEach var="year" items="${year}">
														<spring:bind path="portfolioDetailsCmd.schoolPassingYear">
																<c:set var="hEndYear" value="${status.value}" />
															</spring:bind>
														   
															<%-- <spring:bind path="addStudent.h_endYear_duration">
																<c:set var="hEndYear" value="${status.value}" />
															</spring:bind> --%>
															<c:choose>
																<c:when test="${year == hEndYear}">
																	<option value="<c:out value="${year}" />"
																		selected="selected">
																		<c:out value="${year}" />
																	</option>
																</c:when>

																<c:otherwise>
																	<option value="<c:out value="${year}" />">
																		<c:out value="${year}" />
																	</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</form:select> <small class="desc">Passing Year</small>
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="errorSchoolDuration"></label> 


										</div>
										<div class="par floatright">
											<input name="" type="button" value="Save" onclick="resetSchoolForm()">
										</div>

										<div class="clear"></div>
				
									</form:form>
					
					  <div class="top_margin">
					  <h4 class="blutitle14">Post Secondary Education Profile</h4>
					  </div>
	                  <div class="clear"></div>
	                  
	                  
	                   <div class="fullwidth doubleright_margin margin_top2" id="universityDisplay">
	                  
	                  
	                  
	                  <div class="right_detailswrap">
											<input type="hidden" id="universityDetails"
													value="${universityList1}" />
												<ul class="topborder_lists">
												<c:forEach items="${universityList1}" var="university">
													<li class="hover" onclick="fillUniversityDetails(this.id)">
														<div class="floatleft">
															<div class="orangetxt12">
																<span class="universityname"><c:out value="${university.universityName}" /> </span>
																<c:if test="${not empty university.universityCourseType}"></c:if>
																(<c:if test="${university.universityCourseType ne 'null'}">
																<span class="universitycourse" >
																<c:out value="${university.universityCourseType}" /></c:if>
																<c:out value="${university.universityCourseName}" /></span>)

															</div>
															
															<div class="greytxt_nomargin">
																<span class="universitygpa"> <c:out value="${university.universityGpaFrom}" />/
																<c:out value="${university.universityGpaTo}" />
																</span>
															</div>

														</div>
												
												
														<div class="floatright">

															<div class="orangetxt12">
																<span> <c:choose>
																		<c:when test="${university.universityMonthFrom == '1'}"> Jan     </c:when>
																		<c:when test="${university.universityMonthFrom == '2'}">  Feb   </c:when>
																		<c:when test="${university.universityMonthFrom == '3'}">  March </c:when>
																		<c:when test="${university.universityMonthFrom == '4'}">   April     </c:when>
																		<c:when test="${university.universityMonthFrom == '5'}">     May     </c:when>
																		<c:when test="${university.universityMonthFrom == '6'}">     June </c:when>
																		<c:when test="${university.universityMonthFrom == '7'}">  July       </c:when>
																		<c:when test="${university.universityMonthFrom == '8'}"> Aug       </c:when>
																		<c:when test="${university.universityMonthFrom == '9'}">     Sept    </c:when>
																		<c:when test="${university.universityMonthFrom == '10'}">       Oct      </c:when>
																		<c:when test="${university.universityMonthFrom == '11'}">        Nov       </c:when>
																		<c:when	test="${university.universityMonthFrom == '12'}">      Dec     </c:when>
																	</c:choose> 
																	<c:out value="${university.universityYearFrom}" /> 
      																 to 
       																 <c:if test="${not empty university.universityMonthTo}">
																		<c:choose>
																			<c:when test="${university.universityMonthTo== '1'}">Jan</c:when>
																			<c:when test="${university.universityMonthTo== '2'}">Feb </c:when>
																			<c:when test="${university.universityMonthTo== '3'}">March</c:when>
																			<c:when test="${university.universityMonthTo== '4'}">April</c:when>
																			<c:when test="${university.universityMonthTo== '5'}"> May</c:when>
																			<c:when test="${university.universityMonthTo== '6'}">June</c:when>
																			<c:when test="${university.universityMonthTo== '7'}">      July   </c:when>
																			<c:when test="${university.universityMonthTo== '8'}">    Aug     </c:when>
																			<c:when test="${university.universityMonthTo== '9'}">      Sept       </c:when>
																			<c:when test="${university.universityMonthTo== '10'}">    Oct </c:when>
																			<c:when test="${university.universityMonthTo== '11'}"> Nov    </c:when>
																			<c:when test="${university.universityMonthTo== '12'}">   Dec    </c:when>
																		</c:choose>

																		<c:out value="${university.universityYearTo}" />
																	</c:if>
																</span>
															</div>
															
														</div>
													</li>
													</c:forEach>
												</ul>
												
											</div>
											<div class="clear"></div>
	                  
	                   
	                  <!-- Display -->
	                  </div> 
	                  
	                  
	                  
	                  
	             
	                  
	                  
	                  
	                  
	                  <form:form action="" method="post" modelAttribute="portfolioDetailsCmd"
									class="stdform" id="candidateUniversityEducation">
									
										 <div class="leftsection_form">
											<div class="par">
												<label class="floatleft">Course Type</label>
												<div class="clear"></div>
												<span class="formwrapper"> 
												<c:set var="coureTypeListSession" scope="session" value= "${coureType}" />
												<form:select id="coursedrop" path="universityCourseType"
														data-placeholder="Choose an Option"
														class="chzn-select" tabindex="9" style="width:405px !important;">
														<form:option value=""></form:option>
														<c:forEach var="coureTypeList" items="${coureTypeList}">
						<option value="<c:out value="${coureTypeList}" />" <c:if test="${coureTypeList == coureTypeListSession}">selected="selected"</c:if>><c:out value="${coureTypeList}" /></option>
														</c:forEach>
													</form:select>
													<label class="error" id="errorUniversityCourseType"></label>
												</span>
											</div>

											<div class="par">
												<label class="floatleft">University</label>
												<div class="clear"></div>
												<span class="formwrapper"> 
												 <c:set var="universityListSession" scope="session" value= "${universityName}" /> 
												<form:select id="Univdrop"
														path="universityName" data-placeholder="Choose a Option"
														class="chzn-select" style="width:405px !important;" tabindex="11">
														<form:option value=""></form:option>
														<c:forEach var="universityList" items="${universityList}">
											<option value="<c:out value="${universityList}" />" <c:if test="${universityList == universityListSession}">selected="selected"</c:if>><c:out value="${universityList}" /></option>
									
														</c:forEach>
													</form:select>
												<label class="error" id="errorUniversityName"></label>	
												</span>
											</div>

											<div class="par">
												<label class="floatleft">Duration</label>
												<div class="clear"></div>
												
													<span class="field floatleft input-small doubleright_margin">
													<form:select path="universityMonthFrom"
														class="input-small month right_margin" id="universityMonthFrom"
														tabindex="30">
														<form:option value="1">Jan</form:option>
														<form:option value="2">Feb</form:option>
														<form:option value="3">Mar</form:option>
														<form:option value="4">Apr</form:option>
														<form:option value="5">May</form:option>
														<form:option value="6">Jun</form:option>
														<form:option value="7">Jul</form:option>
														<form:option value="8">Aug</form:option>
														<form:option value="9">Sep</form:option>
														<form:option value="10">Oct</form:option>
														<form:option value="11">Nov</form:option>
														<form:option value="12">Dec</form:option>
													</form:select> 
													<small class="desc">From Month</small>
												     </span>
												
												
												
												<span class="floatleft"> 
												<form:select
														path="universityYearFrom"
														class="input-small year right_margin increment_year"
														id="universityYearFrom" tabindex="14">
														<c:forEach var="year" items="${year}">
																													
															<spring:bind path="universityYearFrom">
																<c:set var="gStartYear" value="${status.value}" />
															</spring:bind>
															<c:choose>
																<c:when test="${year == gStartYear}">
																	<option value="<c:out value="${year}" />"
																		selected="selected">
																		<c:out value="${year}" />
																	</option>
																</c:when>

																<c:otherwise>
																	<option value="<c:out value="${year}" />">
																		<c:out value="${year}" />
																	</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</form:select> 
													<small class="desc">From Year</small>
												</span>
												
												
													<span class="field floatleft input-small doubleright_margin">
													<form:select path="universityMonthTo"
														class="input-small month right_margin" id="universityMonthTo"
														tabindex="30">
														<form:option value="1">Jan</form:option>
														<form:option value="2">Feb</form:option>
														<form:option value="3">Mar</form:option>
														<form:option value="4">Apr</form:option>
														<form:option value="5">May</form:option>
														<form:option value="6">Jun</form:option>
														<form:option value="7">Jul</form:option>
														<form:option value="8">Aug</form:option>
														<form:option value="9">Sep</form:option>
														<form:option value="10">Oct</form:option>
														<form:option value="11">Nov</form:option>
														<form:option value="12">Dec</form:option>
													</form:select> 
													<small class="desc">To Month</small>
												     </span>
												
												
												<span class="floatleft"> <form:select
														path="universityYearTo"
														class="input-small year right_margin increment_year"
														id="universityYearTo" tabindex="15">
														<c:forEach var="year" items="${year}">
															<spring:bind path="universityYearTo">
																<c:set var="gEndYear" value="${status.value}" />
															</spring:bind>

															<c:choose>
																<c:when test="${year == gEndYear}">
																	<option value="<c:out value="${year}" />"
																		selected="selected">
																		<c:out value="${year}" />
																	</option>
																</c:when>

																<c:otherwise>
																	<option value="<c:out value="${year}" />">
																		<c:out value="${year}" />
																	</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</form:select> <small class="desc">To Year</small>
												</span>
											</div>
											<div class="clear"></div>
											<form:errors path="universityYearTo" cssClass="error"/>
											<label class="error" id="errorGraduationDuration"></label>
										</div>
										
										
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">Course Name</label>
												<div class="clear"></div>
												<span class="formwrapper">
												<c:set var="courseNameSession" scope="session" value= "${courseName}" />
												 <form:select
														path="universityCourseName" data-placeholder="Choose a Option"
														class="chzn-select"  style="width:405px !important;" id="courseNameDrop"
														tabindex="10">
														<option value=""></option>
														<c:forEach var="courseList" items="${courseList}">
											<option value="<c:out value="${courseList}" />" <c:if test="${courseList == courseNameSession}">selected="selected"</c:if>><c:out value="${courseList}" /></option>
														</c:forEach>
													</form:select>
												<label class="error" id="errorUniversityCourseName"></label>	
												</span>
											</div>


											<div class="par">
												<label class="floatleft">GPA</label> <!-- <span class="star">*</span> -->
												<div class="clear"></div>
												<span class="field floatleft"> <form:input
														id="universityGpaFrom" path="universityGpaFrom" placeholder="Score"
														class="input-profile" tabindex="12" />
												<label class="error" id="errorUniversityGpaFrom"></label>
												</span> 
												<span class="date_divider">/</span> 
												<span class="">
													<form:input id="universityGpaTo" path="universityGpaTo"
														placeholder="Out of" class="input-profile" tabindex="13" />
										     
												</span>
											</div>
											<div class="clear"></div>
											<label class="error" id="errorGpaGraduation"></label>
										</div>
										
										<div class="par floatright">
											<input name="" class="add_participants addbtn" type="button" value="Add" tabindex="22" onclick="resetUniversityForm()">
										</div>
											</form:form>
	       						
		<!--Mian div   -->							
			</div>
							</div>
    </div>
     <div id="c" class="whitebackground">
       <div class="fullwidth" id="skillglossary">
								<form:form action="" method="post" modelAttribute="addStudent" class="stdform" id="skillForm">
									<div class="borderbottom doublebottom_margin padding_bottom margin_top2">

										<h3 class="blutitle18">Skills Glossary</h3>
										<div class="fullwidth_form">
										
											<div class="par">
											<label class="floatleft">Profile Heading</label>
											<div class="clear"></div>
											<span class="field"> <form:input path="profileName"
													placeholder="Eg: Sales Executive-Entry level ,Software Analyst with 2 Years Experience"
													class="input-xxlarge" tabindex="36" />
												<div class="clear"></div> <label class="error"
												id="emptyProfileName"></label> <form:errors path="profileName"  cssClass="validationnote"/>
											</span>
										</div> 
										
											<div class="par">
												<label class="floatleft">About your self in few
													words</label>  
												<form:textarea path="aboutYourSelf" cols="80" rows="3"
													id="message2" class="span12" maxlength="2000"
													tabindex="23" />
												<form:errors path="aboutYourSelf" cssClass="input-large" />
											</div>
										</div>
										<div class="par">
											<label class="floatleft">Primary Skills</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input id="primarySkills"
													path="primarySkills1" cssClass="input-large" tabindex="24" />
												<form:errors path="primarySkills" cssClass="input-large" />
											</span>
										</div>
										<div class="par">
											<label class="floatleft">Secondary Skills</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input
													id="tags1" path="secondarySkills1" cssClass="input-large"
													tabindex="25" /> <form:errors path="secondarySkills"
													id="tags1" cssClass="input-large" />
											</span>
										</div>
										<div class="par floatright">
											<input name="" type="button" value="Save" tabindex="26"
												class="add_participants top_margin"
												onclick="validateSkills()">
										</div>
										<div class="clear"></div>
									</div>
								</form:form>
							</div>
    </div> 
    <div id="d" class="whitebackground">
      <div class="fullwidth clear margin_top2" id="presence">
      
								<h3 class="blutitle18 floatleft">Work</h3>
								<br>

								
									<div class="borderbottom doublebottom_margin doubletop_margin padding_bottom">
										
	 									<div class="fullwidth doubleright_margin" id="workDisplay">
											<div class="right_detailswrap">
											<input type="hidden" id="hideWork"
													value="${workList}" />
												<ul class="topborder_lists">
												<c:forEach items="${workList}" var="workCompany">
													<li class="hover" onclick="fillWorkDetails(this.id)">

														<div class="floatleft">
															<div class="orangetxt12">
																<span><c:out value="${workCompany.workCompanyName}" /> </span>
																<c:if test="${not empty workCompany.workDesignation}">
																(<span><c:out value="${workCompany.workDesignation}" /></span>)</c:if>

															</div>
															
															<div class="greytxt_nomargin">
															<c:if test="${workCompany.workDescription ne 'null'}">
																<span> <c:out value="${workCompany.workDescription}" /></span></c:if>
																
															</div>

														</div>
														<div class="floatright">

															<div class="orangetxt12">
																<span> <c:choose>
																		<c:when test="${workCompany.workMonthFrom == '1'}"> Jan
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '2'}">
                  Feb
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '3'}">
                  March
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '4'}">
                  April
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '5'}">
                  May
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '6'}">
                  June
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '7'}">
                  July
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '8'}">
                  Aug
                </c:when>
																		<c:when test="${workCompany.workMonthFrom == '9'}">
                  Sept
                </c:when>
																		<c:when
																			test="${workCompany.workMonthFrom == '10'}">
                  Oct
                </c:when>
																		<c:when
																			test="${workCompany.workMonthFrom == '11'}">
                  Nov
                </c:when>
																		<c:when
																			test="${workCompany.workMonthFrom == '12'}">
                  Dec
                </c:when>
																	</c:choose> <c:out value="${workCompany.workYearFrom}" /> - <c:if
																		test="${empty workCompany.workMonthTo}">
        Currently Working
        </c:if> <c:if test="${not empty workCompany.workMonthTo}">
																		<c:choose>
																			<c:when test="${workCompany.workMonthTo== '1'}">
                  Jan
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '2'}">
                  Feb
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '3'}">
                  March
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '4'}">
                  April
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '5'}">
                  May
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '6'}">
                  June
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '7'}">
                  July
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '8'}">
                  Aug
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '9'}">
                  Sept
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '10'}">
                  Oct
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '11'}">
                  Nov
                </c:when>
																			<c:when test="${workCompany.workMonthTo== '12'}">
                  Dec
                </c:when>
																		</c:choose>

																		<c:out value="${workCompany.workYearTo}" />
																	</c:if>
																</span>
															</div>
															
														</div>

													</li>
													</c:forEach>
												</ul>
												
											</div>
											<div class="clear"></div>
										</div> 
					
					<form:form action="" method="post" modelAttribute="portfolioDetailsCmd"
									class="stdform" id="candidateWork">
										<div class="clear"></div>
										<div class="leftsection_form" id="addWork">
											<div class="par">
												<label class="floatleft">Company Name</label>
												<div class="clear"></div>
												<span class="field"> <form:input path="workCompanyName"
														class="input-large" id="companyName" tabindex="27" /> <form:errors
														path="workCompanyName" cssClass="validationnote" />
												<label class="error" id="errorCompanyName"></label>
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Work Description</label>
												<div class="clear"></div>
												<form:textarea path="workDescription" class="input-large"
													id="workDesc" style="height:100px;" tabindex="29" />
												<form:errors path="workDescription" cssClass="validationnote" />
												<label class="error" id="errorWorkDescription"></label>
											</div>
											<div class="clear"></div>
										</div>
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">Designation</label>
												<div class="clear"></div>
												<span class="field"> <form:input path="workDesignation"
														class="input-large" id="designation" tabindex="28" /> <form:errors
														path="workDesignation" cssClass="validationnote" />
												</span>
												<label class="error" id="errorWorkDesignation"></label>
											</div>
											<div class="par">
												<label class="floatleft">Duration</label>
												<div class="clear"></div>
												<span class="field floatleft input-small doubleright_margin">
													<form:select path="workMonthFrom"
														class="input-small month right_margin" id="startMonth"
														tabindex="30">
														<form:option value="1">Jan</form:option>
														<form:option value="2">Feb</form:option>
														<form:option value="3">Mar</form:option>
														<form:option value="4">Apr</form:option>
														<form:option value="5">May</form:option>
														<form:option value="6">Jun</form:option>
														<form:option value="7">Jul</form:option>
														<form:option value="8">Aug</form:option>
														<form:option value="9">Sep</form:option>
														<form:option value="10">Oct</form:option>
														<form:option value="11">Nov</form:option>
														<form:option value="12">Dec</form:option>
													</form:select> <small class="desc">From Month</small>
												</span>
										
												<span class="field floatleft input-small doubleright_margin">
													<form:select path="workYearFrom"
														class="input-small year right_margin increment_year"
														id="startYear" tabindex="42">
														<c:forEach var="year" items="${year}">
															<option value="<c:out value="${year}" />">
																<c:out value="${year}" />
															</option>
														</c:forEach>
													</form:select> <small class="desc">From Year</small>
												</span>
												
												<input id=currentlyWorking type="hidden" value="${currentlyWorking}"></input>
												<div id="endWorkDuration">
													<span
														class="field floatleft input-small doubleright_margin">
														<form:select path="workMonthTo"
															class="input-small month right_margin" id="endMonth"
															tabindex="32">
															<form:option value="1">Jan</form:option>
															<form:option value="2">Feb</form:option>
															<form:option value="3">Mar</form:option>
															<form:option value="4">Apr</form:option>
															<form:option value="5">May</form:option>
															<form:option value="6">Jun</form:option>
															<form:option value="7">Jul</form:option>
															<form:option value="8">Aug</form:option>
															<form:option value="9">Sep</form:option>
															<form:option value="10">Oct</form:option>
															<form:option value="11">Nov</form:option>
															<form:option value="12">Dec</form:option>
														</form:select> <small class="desc">To Month</small>
													</span>
												
													<span class="field floatleft input-small doubleright_margin">
													<form:select path="workYearTo"
														class="input-small year right_margin increment_year"
														id="endYear" tabindex="42">
														<c:forEach var="year" items="${year}">
															<option value="<c:out value="${year}" />">
																<c:out value="${year}" />
															</option>
														</c:forEach>
													</form:select> <small class="desc">To Year</small>
												</span>	
									
												</div>
												<div id="present" style="font-size:18px;">
													-
													<c:out value="${workEndYear}" />
													<small class="desc" style="display: inline-block;">
														</small>
												</div>
												<div class="clear"></div>
												<div class="floatleft" id="presentlyWorking">
													<input id="currentCheckbox" type="checkbox" name="vehicle"
														value="Currently Working" onclick="callPresentlyWorking()"
														tabindex="34" />Currently Working
												</div>

											</div>
											<div class="clear"></div>
											<label class="error" id="errorDurationWork"></label>
										</div>
										<div class="par floatright">
											<input name="addMoreWorkBtn" type="button" id="addMoreWorkBtn" value="Add More" class="no_right_margin addbtn"  onclick="resetWorkForm()">
											<input name="updateWorkDetailsBtn" id="updateWorkDetailsBtn" type="button" value="Update" class="no_right_margin addbtn" onclick="updateExistingWorkDetails()" style="display: none;">
										</div>

										<div class="clear"></div>

									</form:form>	
									</div>
								
							</div>
						    </div>
						     <div id="e" class="whitebackground">
						     <div class="fullwidth margin_top2" id="name">
								
								<h3 class="blutitle18 top_padding">Resume, Certifications &amp;
									Others</h3>

								<div class="clear"></div>
								<div class="borderbottom  padding_bottom margin_top2">
								<h4 class="blutitle14">Resume</h4>
									<form:form action="" method="post" modelAttribute="addStudent" class="stdform" enctype="multipart/form-data" id="uploadResume">
										<div class="par">
											<c:set var="resumeName" scope="session" value="${resumeName}" />
												<c:if test="${not empty resumeName}">
													<label style="font-size: 16px; " id="successResumeUpload" ></label>
													<label class="orangetxt14" id="resumeUploaded"><a href="download_cv.htm" style="color:#33a3b8;">Current uploaded Resume is <c:out value="${resumeName}" /></a></label>
												</c:if>
											<span class="field">
											 <input type="file" class="uniform-file" name="fileResume" id="fileResume" /> 
											<form:errors path="fileResume" cssClass="validationnote" /> 
											<span class="floatleft">
											<input name="" type="button"value="Upload Your Resume" class="left_margin" onclick="checkResumeFile()" tabindex="37">
											</span>
												<div class="clear"></div> 
												<label class="error" id="emptyResume"></label>
											</span>

										</div>
									</form:form>
									
								</div>
								<input type="hidden" id="fileUploadError" value="${fileUploadError}" /> 
								<div class="borderbottom  padding_bottom">
								<h4 class="blutitle14 " id="media">Video Resume</h4>
									<form:form action="" method="post" modelAttribute="addStudent"
										class="stdform" enctype="multipart/form-data" id="videoForm">
										<!-- <div class="leftsection_form"> -->
											<div class="par">
												
												<c:set var="videoName" scope="session" value="${videoName}" />
											
												<c:if test="${not empty videoName}">
													<label>Current uploaded Video Resume is <c:out value="${videoName}" /></label>
												</c:if>
												
												<span class="field">
											 <input type="file" class="uniform-file" name="fileVideo" id="videoFile" /> 
											
											<span class="floatleft">
											<input name="" type="button"value="Upload Your Video" class="left_margin" onclick="checkUploadedVideo()" tabindex="59">
											</span>
												<div class="clear"></div> 
												
											</span>
												
											<label id="videoError"></label>
											<p class="smalltxt doubletop_margin">
												Maximum file size: 5 MB<br /> Supported file formats: mp4,
												avi, mpeg, 3gp</p>


											</div>
										<!-- </div> -->
										
										<c:if test="${not empty videoName}">
										
										<div class="floatleft video_wrap">

													<video id="home_video1" class="video-js vjs-default-skin"
														controls width=auto height="310">

														<!-- MP4 source must come first for iOS -->
														<source type="video/mp4" src="view_video.htm?emailId=${emailId}" />
														<!-- WebM for Firefox 4 and Opera -->
														<source type="video/wmv" src="view_video.htm?emailId=${emailId}" />
														<!-- OGG for Firefox 3 -->
														<source type="video/ogg" src="view_video.htm?emailId=${emailId}" />

														<source type="video/mp3" src="view_video.htm?emailId=${emailId}" />
														<!-- Fallback flash player for no-HTML5 browsers with JavaScript turned off -->
														<object width="180" height="150"
															type="application/x-shockwave-flash"
															data="videos/flashmediaelement.swf">
															<param name="movie" value="flashmediaelement.swf" />
															<param name="flashvars"
																value="controls=true&amp;file=candidate_view_videoCV.htm" />
															<!-- Image fall back for non-HTML5 browser with JavaScript turned off and no Flash player installed -->
															<img src="videos/echo-hereweare.jpg" width="180"
																height="150" alt="Here we are"
																title="No video playback capabilities" />
														</object>
													</video>

													<script>var homePlayer=_V_("home_video1");</script>

												</div>
										</c:if>
										<div class="clear"></div>
									</form:form>
								
								</div>

								
								<div class="fullwidth clear borderbottom  padding_bottom margin_top2" id="presence">
								<h4 class="blutitle14 floatleft width100">Certifications
									
								</h4>
								<br>
								<div class="fullwidth doubleright_margin"
											id="certificateDisplay">
											<div class="right_detailswrap">
												<input type="hidden" id="hideCertificates"
													value="${certificationList}" />
												<ul class="topborder_lists">
													<c:forEach items="${certificationList}" var="certification">
														<li class="hover"
															onclick="fillCertificateDetails(this.id)">
															<div class="floatleft">
																<div class="greytxt_nomargin">
																	<c:if test="${certification.certificateName ne 'null'}">
																		<span class="certificateName"> <c:out
																				value="${certification.certificateName}" /></span>
																	</c:if>
																</div>
																<div class="orangetxt12">
																	<c:if
																		test="${certification.certificateNumber ne 'null'}">
																		<span><c:out
																				value="${certification.certificateNumber}" /> </span>
																	</c:if>
																</div>
															</div>
															<div class="floatright">
																<div class="dark_greytitle" style="text-align:right;">
																	<c:if
																		test="${certification.certificateAuthority ne 'null'}">
																		<span> <c:out
																				value="${certification.certificateAuthority}" /></span>
																	</c:if>
																</div>
																<div class="orangetxt12 floatright">
																	<span> <c:if
																			test="${certification.certificationStartMonth ne 'null'}">

																			<c:choose>
																				<c:when
																					test="${certification.certificationStartMonth == '1'}">
                  Jan
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '2'}">
                  Feb
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '3'}">
                  March
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '4'}">
                  April
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '5'}">
                  May
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '6'}">
                  June
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '7'}">
                  July
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '8'}">
                  Aug
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '9'}">
                  Sept
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '10'}">
                  Oct
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '11'}">
                  Nov
                </c:when>
																				<c:when
																					test="${certification.certificationStartMonth == '12'}">
                  Dec
                </c:when>
																			</c:choose>
																		</c:if> 
																	
																		
																		<c:if
																			test="${certification.certificationStartYear ne 'null'}">
																			<c:out
																				value="${certification.certificationStartYear}" /> -</c:if>

																		<c:if
																			test="${certification.certificationEndMonth eq 'null'}">
        Certificate Does Not Expire
        </c:if> <c:if test="${certification.certificationEndMonth ne 'null'}">
																			<c:choose>
																				<c:when
																					test="${certification.certificationEndMonth == '1'}">
                  Jan
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '2'}">
                  Feb
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '3'}">
                  March
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '4'}">
                  April
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '5'}">
                  May
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '6'}">
                  June
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '7'}">
                  July
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '8'}">
                  Aug
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '9'}">
                  Sept
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '10'}">
                  Oct
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '11'}">
                  Nov
                </c:when>
																				<c:when
																					test="${certification.certificationEndMonth == '12'}">
                  Dec
                </c:when>
																			</c:choose>

																			<c:out value="${certification.certificationEndYear}" />
																		</c:if>
																	</span>
																</div>
															</div>
															<div class="clear"></div>
														</li>
													</c:forEach>
												</ul>
											</div>
											<div class="clear"></div>
										</div>
								
									<form:form action="" method="post"
										modelAttribute="portfolioDetailsCmd" class="stdform"
										id="certificateForm">

										<div class="clear"></div>
										<div class="leftsection_form">
											<div class="par">
												<label class="floatleft">Certificate Name</label>
												<div class="clear"></div>
												<span class="field"> <form:input
														path="certificateName" class="input-large"
														id="certificateName" tabindex="38" /> <form:errors
														path="certificateName" cssClass="validationnote" />
														<label class="error" id="errorCertificateName"></label>
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Certificate Number</label>
												<div class="clear"></div>
												<form:input path="certificateNumber" class="input-large"
													id="certificateNumber" tabindex="40" />
												<form:errors path="certificateNumber"
													cssClass="validationnote" />
													<label class="error" id="errorCertificateNumber"></label>
											</div>
											<div class="clear"></div>
										</div>
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">Certificate Authority Name</label>
												<div class="clear"></div>
												<span class="field"> <form:input
														path="certificateAuthority" class="input-large"
														id="certificateAuthority" tabindex="39" /> <form:errors
														path="certificateNumber" cssClass="validationnote" />
														<label class="error" id="errorCertificateAuthority"></label>
												</span>
											</div>
											
									<div class="par">
												<label class="floatleft">Duration</label>
												<div class="clear"></div>
												<span class="field floatleft input-small doubleright_margin">
													<form:select path="certificationStartMonth"
														class="input-small month right_margin"
														id="certificationStartMoth" tabindex="41">
														<form:option value="1">Jan</form:option>
														<form:option value="2">Feb</form:option>
														<form:option value="3">Mar</form:option>
														<form:option value="4">Apr</form:option>
														<form:option value="5">May</form:option>
														<form:option value="6">Jun</form:option>
														<form:option value="7">Jul</form:option>
														<form:option value="8">Aug</form:option>
														<form:option value="9">Sep</form:option>
														<form:option value="10">Oct</form:option>
														<form:option value="11">Nov</form:option>
														<form:option value="12">Dec</form:option>
													</form:select> <small class="desc" style="font-size: 10px;">From Month</small>
												</span>

												<span class="field floatleft input-small doubleright_margin">
													<form:select path="certificationStartYear"
														class="input-small year right_margin increment_year"
														id="certificationStartYear" tabindex="42">
														<c:forEach var="year" items="${year}">
															<option value="<c:out value="${year}" />">
																<c:out value="${year}" />
															</option>
														</c:forEach>
													</form:select> <small class="desc">From Year</small>
												</span>

												<div id="certificate">
													<input id=currentlyWorking type="hidden"
														value="${currentlyWorking}"></input> <span
														class="field floatleft input-small doubleright_margin">
														<form:select path="certificationEndMonth"
															class="input-small month right_margin"
															id="certificationEndMonth" tabindex="43">
															<form:option value="1">Jan</form:option>
															<form:option value="2">Feb</form:option>
															<form:option value="3">Mar</form:option>
															<form:option value="4">Apr</form:option>
															<form:option value="5">May</form:option>
															<form:option value="6">Jun</form:option>
															<form:option value="7">Jul</form:option>
															<form:option value="8">Aug</form:option>
															<form:option value="9">Sep</form:option>
															<form:option value="10">Oct</form:option>
															<form:option value="11">Nov</form:option>
															<form:option value="12">Dec</form:option>
														</form:select> <small class="desc">To Month</small>
													</span>
													
													<span class="field floatleft input-small"> 
													<form:select path="certificationEndYear"
															class="input-small year right_margin increment_year" items="${futureYears }" id="certificationEndYear" tabindex="44" />
															<%-- <c:forEach var="futureYear" items="${futureYears}">
																<option value="<c:out value="${year}" />">
																	<c:out value="${year}" />
																</option>
															</c:forEach> --%>
														<small class="desc">To Year</small>
													</span>
												</div>
												<div class="clear"></div>
												<form:errors path="certificationStartYear"
													cssClass="validationnote" />
												
												<div class="clear"></div>
												<div class="floatleft" id="certificateNoExpiry">
													<input id="certificationCheckbox" type="checkbox"
														onclick="callCertificateNoExpiry()" tabindex="45" />Certificate
													Does not Expire
												</div>
												<br>
												<label class="error" id="errorCertificateDuration"></label>
											</div>
											
										</div>
										<div class="clear"></div>
										<div class="par floatright ">
												
										<input name="" type="button" value="Add More" class="no_right_margin addbtn" onclick="resetCertificationForm()">
											</div>
											<div class="clear"></div>
									</form:form>
								</div>

								<div class="clear"></div>

								<div class="fullwidth clear borderbottom  padding_bottom margin_top2" id="presence">
									<h4 class="blutitle14">Interests</h4>
									<form:form action="" modelAttribute="addStudent" method="post"
										class="stdform">
										<div class="par">
											<label class="floatleft">Your Interests include : </label>
											<div class="clear"></div>
											<span class="field"> <form:input id="tags"
													class="input-large" path="interestList" tabindex="47" />
											</span>
										</div>

										<div class="par floatright">
											<input name="submitWorks" type="button" value="Save"
												class="add_participants top_margin" onclick="addInterests()"
												tabindex="48">
										</div>
										<div class="clear"></div>
								</div>
								<div class="fullwidth clear borderbottom padding_bottom">
									<h4 class="blutitle14">Languages</h4>
									<div class="par floatleft">
										<!-- <label class="floatleft">Add Languages known</label>  --><br><span
											class="field">&nbsp;&nbsp; <form:input path="language"
												type="text" class="input-medium3"
												onfocus="if (this.placeholder=='Language') this.placeholder = '';hideEmptyLanguage()"
												placeholder="Language" id="languagesList" tabindex="49" />
											&nbsp; &nbsp; <a class="hover" onclick="addLanguage()"
											style="display: inline-block;"><img
												src="images/addmore_icn.png" alt="Add More "> </a>
												
												

										</span><label class="error" id="emptyLanguage"></label>
									</div>
									<div class="smallsection_wrap floatright doubleright_margin"
										id="languagesDisplay">
										<label id="languagesKnown">Languages Known</label>
										<ul class="recent_activities_wrap">
											<c:forEach var="language" items="${languageList}">
												<li><c:out value="${language}"></c:out> <a
													class="floatright " style="display: inline-block;"
													onclick="deleteLanguage(this.id)"> <img
														src="images/list_cross_icn.png"></a> <input
													type="hidden" value="${language}" id="languages" /></li>

											</c:forEach>
										</ul>

									</div>
									<div class="clear"></div>
									<input type="hidden" value="${languageList}" id="hideLanguage" />
									<div class="clear"></div>
									</form:form>
									
									<div class="clear"></div>


								</div>
								<div class="clear"></div>
								<!-- </div> -->
								

								<div class="fullwidth clear borderbottom padding_bottom margin_top2">
								<h4 class="blutitle14">Publications
								
								</h4>
								<br>
								<div class="fullwidth doubleright_margin"
											id="publicationDisplay">
											<div class="right_detailswrap">
												<input type="hidden" id="hidePublications"
													value="${publicationList}" />
												<ul class="topborder_lists">
													<c:forEach items="${publicationList}" var="publication">
														<li class="hover"
															onclick="fillPublicationDetails(this.id)">
															<div class="floatleft">
																<div class="greytxt_nomargin">
																	<c:if test="${publication.publicationTitle ne 'null'}">
																		<span class="publicationTitle"><c:out
																				value="${publication.publicationTitle}" /> </span>
																	</c:if>
																	<c:if test="${publication.publicationUrl ne 'null'}">
                	    ( <a
																			href="http://<c:out value="${publication.publicationUrl}" />"
																			target="_blank"><span><c:out
																					value="${publication.publicationUrl}" /></span> </a>)</c:if>
																</div>
																<div class="orangetxt12">
																	<c:if test="${publication.publisherName ne 'null'}">
																		<span> <c:out
																				value="${publication.publisherName}" />
																		</span>
																	</c:if>
																</div>
																<div class="greytxt_nomargin">
																	<c:if
																		test="${publication.publicationSummary ne 'null'}">
																		<span> <c:out
																				value="${publication.publicationSummary}" />
																		</span>
																	</c:if>
																</div>
															</div>
															<div class="floatright">
																<div class="dark_greytitle">
																	<c:if
																		test="${publication.publisherAuthorFirstName ne 'null'}">
																		<span> <c:out
																				value="${publication.publisherAuthorFirstName}" />
																		</span>
																	</c:if>
																	<c:if
																		test="${publication.publisherAuthorLastName ne 'null'}">
																		<span> <c:out
																				value="${publication.publisherAuthorLastName}" />
																		</span>
																	</c:if>
																</div>
																<div class="orangetxt12">
																	<c:if test="${publication.publicationDate ne 'null'}">
																		<span> <c:out
																				value="${publication.publicationDate}" />
																		</span>
																	</c:if>
																</div>
															</div>
															<div class="clear"></div>
														</li>
													</c:forEach>
												</ul>
											</div>
											<div class="clear"></div>
										</div>
								
									<form:form action="" method="post"
										modelAttribute="portfolioDetailsCmd" class="stdform"
										id="publicationForm">

										<div class="leftsection_form">
											<div class="par">
												<label class="floatleft">Publication Title</label>
												<div class="clear"></div>
												<span class="field"> <form:input
														path="publicationTitle" class="input-large"
														id="publicationTitle" tabindex="51" /> <form:errors
														path="publicationTitle" cssClass="validationnote" />
														<label class="error" id="errorPublicationTitle"></label>
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Publication Author First
													Name</label>
												<div class="clear"></div>
												<form:input path="publisherAuthorFirstName"
													class="input-large" id="publisherAuthorFirstName"
													tabindex="53" />
												<form:errors path="publisherAuthorFirstName"
													cssClass="validationnote" />
													<label class="error" id="errorPublisherAuthorFirstName"></label>
											</div>
											<div class="par">
												<label class="floatleft">Publication Author URL</label>
												<div class="clear"></div>
												<form:input path="publicationUrl" class="input-large"
													id="publicationUrl" tabindex="55" />
												<form:errors path="publicationUrl" cssClass="validationnote" />
												<label class="error" id="errorPublicationUrl"></label>
											</div>
											
											<div class="clear"></div>
										</div>
										<div class="rightsection_form">
											<div class="par">
												<label class="floatleft">Publisher Name</label>
												<div class="clear"></div>
												<span class="field"> <form:input path="publisherName"
														class="input-large" id="publisherName" tabindex="52" /> <form:errors
														path="publisherName" cssClass="validationnote" />
														<label class="error" id="errorPublisherName"></label>
												</span>
											</div>
											<div class="par">
												<label class="floatleft">Publication Author Last
													Name</label>
												<div class="clear"></div>
												<span class="field"> <form:input
														path="publisherAuthorLastName" class="input-large"
														id="publisherAuthorLastName" tabindex="54" /> <form:errors
														path="publisherAuthorLastName" cssClass="validationnote" />
														<label class="error" id="errorPublisherAuthorLastName"></label>
												</span>
											</div>
											
											<div class="par">
											<label class="floatleft">Publication Date </label>
											<div class="clear"></div>
												 <form:input path="publicationDate" class="input-small_date dateclass" id="publicationDate" value="" readonly="true" tabindex="56" />
													<form:errors path="publicationDate"
														cssClass="validationnote" />
												<label class="error" id="errorPublicationDate"></label>
											</div>

											
											
										</div>
										<div class="width100 floatleft">
										<div class="par">
												<label class="floatleft">Publication Summary</label>
												<div class="clear"></div>
												<form:textarea path="publicationSummary"
													class="input-xxlarge" id="publicationSummary" tabindex="57" />
												<form:errors path="publicationSummary"
													cssClass="validationnote" />
													<label class="error" id="errorPublicationSummary"></label>
											</div></div>
										<div class="clear"></div>
										
										<div class="par floatright">
												
													<input name="" type="button" value="Add More" class="no_right_margin addbtn" onclick="resetPublicationForm()">
											</div>
										<div class="clear"></div>
									</form:form>
								</div>

								<div class="clear"></div>

							</div>
							</div>
							<div class="clear">&nbsp;</div>
							<form class="stdform" action="" id="previewForm">
								<div class="par clear">
									<div class="buttonwrap">
										 <input name="" type="button" value="Preview your Profile" tabindex="60" onclick="window.location.href='detail_view_candidate.htm?studentEmailId=${emailId}'">
									</div>
								</div>
							</form>
							
							
							
</div>

						</div>
			<div class="clear"></div>
					</div> 
				

		<div class="bottomspace">&nbsp;</div>

	</div>
	<!--------------  Middle Section :: end ----------->
	<!--------------  Common Footer Section :: start ----------->
	<%@ include file="includes/footer.jsp"%>
	<!--------------  Common Footer Section :: end ----------->
	</div>

	<div tabindex="-2" class="modal hide fade in" id="dialog" style="display: none;">
		<div class="modal ui-dialog-content">
			<div class="modal-header">

				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" id="closeDialog">x</button>
				<h3 id="myModalLabel">You Choose to fill your details from</h3>
			</div>
			<div class="modal-body">
				<h3 class="blutitle18" style="font-size: 18px;">Click the
					simplest way you think...</h3>
				<ul class="margin_top2">
					<li class="padding_top">Sign in from linkedIn: &nbsp;&nbsp;
						<div id="loader" style="display: inline-block;">
							<img src="images/loader.gif">
						</div> <a id="linkedIn"><script type="IN/Login"></script></a>
					</li>
					<li class="padding_top">Fill using Wizard: &nbsp;&nbsp; <input
						type="button" value="Enter Wizard"
						class="add_participants top_margin" onclick="closeDialog()" /></li>
				</ul>
			</div>
		</div>
		
		<div class="modal-backdrop fade in" style="z-index: 999;"></div>
	</div>

<div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="imageCapture">
		
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Image Capture</h3>
			</div>
			<div class="modal-body">
					<video id="video" autoplay style="width: 352px; height: auto; text-align:center;margin:auto; display:block;"></video>
				
				<canvas id="canvas" width="352" height="264" style="margin:auto; display:none;"></canvas>
				<div style="width: 305px; margin:auto; display:block;">
				<input type="button" id="snap" class="add_participants top_margin" value="Snap Now" /> 
					<input type="button" id="new" class="add_participants top_margin" value="Take A New Photo" style="display:none;" />
				<input type="button" id="upload" class="add_participants top_margin" value="Upload"  data-dismiss="modal" style="display:none;"/>
				</div>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn">Close</button>
			</div>
		</div>
	
      
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
    <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabelHeading"> Error </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>
    
	
<script type="text/javascript">
$("#linkedIn").click(function(){
	$('#dialog').dialog('close');
});

$("#closeDialog").click(function(){
	$('#dialog').dialog('close');
});

function closeDialog()
{
	window.location = 'candidate_wizard.htm';
	$('#dialog').dialog('close');
}

$("#choosePhoto").click(function(){
	$("#imageCapture").css('display','block');	
});

</script>
</body>
</html>