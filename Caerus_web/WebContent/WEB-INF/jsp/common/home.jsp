<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv="X-UA-Compatible" content="IE=9">
<meta name="author" content="Alvaro Trigo Lopez" />
	<meta name="description" content="fullPage full-screen backgrounds." />
	<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
	<meta name="Resource-type" content="Document" />
	<link rel="stylesheet" type="text/css" href="css/home.css" />
	<link rel="stylesheet" type="text/css" href="css/jquery.fullPage.css" />
	<link rel="stylesheet" type="text/css" href="css/flexislide.css" />
	<link rel="stylesheet" type="text/css" href="css/tinyboxstyle.css" />

<title>Imploy Me.</title>
<!--[if IE]>
		<script type="text/javascript">
			 var console = { log: function() {} };
		</script>
	<![endif]-->

	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery.fullPage.js"></script>
    <script type="text/javascript" src="js/jquery.flexisel.js"></script>
     <script type="text/javascript" src="js/analytics.js"></script>
     <script type="text/javascript" src="js/tinybox_js.js"></script>
     <script type="text/javascript" src="js/uservoice.js"></script>
     <script type="text/javascript">
 $(document).ready(function(){
	//alert($("#verificationSuccessMessage").text());
	if($("#verificationSuccessMessage").text() == '' || $("#verificationSuccessMessage").text().length == 0)
		{
		
		///alert($("#verificationSuccessMessage").text());
			//alert("no verify");
			$("#dialog").hide();
		}
	
}); 
    </script>
  <style>
  .tbox{z-index:1000 !important;}
  </style>  
 <script> 
<!-- UserVoice JavaScript SDK (only needed once on a page) -->
(function(){
	var uv=document.createElement('script');
	uv.type='text/javascript';
	uv.async=true;
	uv.src='//widget.uservoice.com/N4zwz868a5WdOIRIyoKx9w.js';
	var s=document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(uv,s)
	})()
	
</script>  
<!-- A tab to launch the Classic Widget -->
<script>
UserVoice = window.UserVoice || [];
UserVoice.push(['showTab', 'classic_widget', {
  mode: 'full',
  primary_color: '#56a89c',
  link_color: '#25b6e6',
  default_mode: 'support',
  forum_id: 270536,
  tab_label: 'Feedback & Support',
  tab_color: '#1e83c7',
  tab_position: 'bottom-right',
  tab_inverted: false
}]);


var cfJsHost = (("https:" == document.location.protocol) ? "https://" : "http://");
document.write(unescape("%3Cscript src='" + cfJsHost + "dflzqrzibliy5.cloudfront.net/includes/tinybox/tinybox.js?6595' type='text/javascript'%3E%3C/script%3E"));
</script>

<script type="text/javascript">
		$(document).ready(function() {
			var doc_val_check = $.trim( $('.searchform input[type="text"]').val() ); // take value of text 
                                                     // field using .val()
                                                     
     if (doc_val_check.length) {
        doc_val_check = ""; // this will not update your text field
    }
		$(".searchform input[type='text']").val("Search Jobs");	
			
			$('#fullpage').fullpage({
				verticalCentered: false,
				loopTop: true,
				loopBottom: true,
				navigation: true,
				navigationPosition: 'right',
				navigationTooltips: ['Login', 'Search Job', 'Best Student List', 'Search University']
			});
			
			
			
		$(".css-label-red").click(function(){
			$(".searchform input[type='text']").val("Search Internships");
		
		});
		
		$(".css-label").click(function(){
			$(".searchform input[type='text']").val("Search Jobs");
		
		});
		$(".searchform input[type='text']").focus(function(){
			$(".searchform input[type='text']").val("");
		}
		);
		
	 $("#keywords").on('change keyup paste',function(){
  		suggestKeywords();
 	}); 
		
		});
	</script>

<script type="text/javascript">
$(window).load(function() {  

    $("#flexiselDemo4").flexisel({
        clone:true,
		 visibleItems: 5,
    });
    
});


</script>
 <script type="text/javascript">


$(function() {
	$("#advancedSearch")
			.submit(
					function() {

						var valid = 0;

						$(this).find('input[type=text]').each(function() {
							if ($(this).val() != "")
								valid += 1;
						});

						if (valid) {
							return true;
						} else {

							$("#searchErrorLabel").html("");
							$("#searchErrorLabel")
									.html(
											"<label class='error_message'>Enter at least one search parameter!</label>");

							return false;
						}
					});
});
</script>

    <script type="text/javascript">
$(document).ready(function(){

	$("#university").val(null);
	 uni=JSON.parse('${universityNames}');
     
  var names=[];
     for (var prop in uni) {
    	 names.push(uni[prop]);
    	}
     $( "#university" ).autocomplete({
         source: names,
   focus: function( event, ui ) {
          
           var displayProperty=$(".ui-autocomplete").css("display");
             if(displayProperty=="block"){
              $.fn.fullpage.setKeyboardScrolling(false);
              $.fn.fullpage.setAllowScrolling(false);
             } 
           
            },
     close: function( event, ui ) {
      
      var displayProperty=$(".ui-autocomplete").css("display");
        if(displayProperty=="none"){
         $.fn.fullpage.setKeyboardScrolling(false);
         $.fn.fullpage.setAllowScrolling(true);
        } 
      
       }
       });
     
     $( "#university" ).on( "autocompletefocus", function( event, ui ) {} );
     $( "#university" ).on( "autocompleteclose", function( event, ui ) {} );
});
</script>
	<script type="text/javascript">
function closeDialog()
{
	$("#closeDialog").closest('div#dialog').hide();
}

</script>
<script type="text/javascript">
function getUrlsWithoutSpaces(url) {
	var output = url;
	var index = output.indexOf(' ');
	var b = "%20";

	if (index >= 0) {
		output = [ url.slice(0, index), b, url.slice(index + 1) ].join('');
	}
	return output;
}
</script>
<!-- <script>
	(function(i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function() {
			(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o), m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
	})(window, document, 'script', '//www.google-analytics.com/analytics.js',
			'ga');

	ga('create', 'UA-45817360-1', 'quinnox.com');
	ga('send', 'pageview');
</script> -->
<script type="text/javascript">
function clearClassFunction()
{
	/* $("#userName").removeClass("redborder");
	$("#password").removeClass("redborder");
	$(".loginpan").effect().stop(); */

	$("#errorMsg").empty();
}

</script> 

<script>
$(document).ready(function(){
	$("#searchUniversity").click(function(){
		var universityName=$("#university").val();
		window.location.href='view_university_profile.htm?universityName='+universityName;
	});
});
</script>
 <script type="text/javascript">
function suggestKeywords(){

	var enteredText=$("#keywords").val();
	$.getJSON( "/get_suggested_keywords.json",'enteredText='+enteredText, function( returnedWords ) {

	 var returned=[];
		returned=returnedWords;
		   $( "#keywords" ).autocomplete({
	         source: returned,
	 	 focus: function( event, ui ) {
	        	 
	        	 var displayProperty=$("#ui-id-2").css("display");
	             if(displayProperty=="block"){
	            	 $.fn.fullpage.setKeyboardScrolling(false);
	            	 $.fn.fullpage.setAllowScrolling(false);
	             }
	            },
	            close: function( event, ui ) {
	                
	                var displayProperty=$("#ui-id-2").css("display");
	                  if(displayProperty=="none"){
	                   $.fn.fullpage.setKeyboardScrolling(false);
	                   $.fn.fullpage.setAllowScrolling(true);
	                  } 
	                
	                 }
	       }); 
	   $( "#keywords" ).on( "autocompletefocus", function( event, ui ) {} );
	   $( "#keywords" ).on( "autocompleteclose", function( event, ui ) {} );
		 });

}

</script> 
<style type="text/css">
.modal-backdrop {
	position:fixed;
	top:0;
	right:0;
	bottom:0;
	left:0;
	z-index:1000;
	background-color:#000
}
.modal-backdrop.fade {
	opacity:0
}
.modal-backdrop, .modal-backdrop.fade.in {
	opacity:.8;
	filter:alpha(opacity=80)
}
.modal {
	position:fixed;
top: 17%;
left: 44%;
	z-index:1050;
	width:511px;
	margin-left:-420px;
	background-color:#fff;
	border:1px solid #999;
	*border:1px solid #999;
	-moz-border-radius:6px !important;
	-webkit-border-radius:6px !important;
	border-radius: 6px !important;
	outline:0;
	-webkit-box-shadow:0 3px 7px rgba(0, 0, 0, 0.3);
	-moz-box-shadow:0 3px 7px rgba(0, 0, 0, 0.3);
	box-shadow:0 3px 7px rgba(0, 0, 0, 0.3);
	-webkit-background-clip:padding-box;
	-moz-background-clip:padding-box;
	background-clip:padding-box;
	
}
.modal.fade {
	top:-25%;
-webkit-transition:opacity .3s linear, top .3s ease-out;
-moz-transition:opacity .3s linear, top .3s ease-out;
-o-transition:opacity .3s linear, top .3s ease-out;
transition:opacity .3s linear, top .3s ease-out
}
.modal.fade.in {
	top:3%
}
.modal-header {
	padding:9px 15px;
	border-bottom:1px solid #eee
}
.modal-header .close {
	margin-top:2px;
	float:right;
}
.modal-header h3 {
	color:#3399cc;
	font-size:20px;
	padding:0.5em 0 0 0;
	margin:0 0 0.5em 0;
}
.modal-body {
	position:relative;
	max-height:455px;
	padding:15px 20px;
	overflow-y:auto
}
.modal-form {
	margin-bottom:0
}
.modal-footer {
	padding:14px 15px 15px;
	margin-bottom:0;
	text-align:right;
	background-color:#f5f5f5;
	border-top:1px solid #ddd;
	-webkit-border-radius:0 0 6px 6px;
	-moz-border-radius:0 0 6px 6px;
	border-radius:0 0 6px 6px;
*zoom:1;
	-webkit-box-shadow:inset 0 1px 0 #fff;
	-moz-box-shadow:inset 0 1px 0 #fff;
	box-shadow:inset 0 1px 0 #fff
}
.modal-footer:before, .modal-footer:after {
	display:table;
	line-height:0;
	content:""
}
.modal-footer:after {
	clear:both
}
.modal-footer .btn+.btn {
	margin-bottom:0;
	margin-left:5px
}
.modal-footer .btn-group .btn+.btn {
	margin-left:-1px
}
.modal-footer .btn-block+.btn-block {
	margin-left:0
}
#success_message {
	background:#f3ffef;
	border:#e8f3e3 solid 1px;
	-webkit-border-radius:7px;
	border-radius:7px;
	margin-bottom:3.333em;
	padding:1.083em 1.250em 0 1.250em;
}
h2.error_message_heading {
	margin:0.2em 0 0 0;
	padding:0 0 0.5em 0;
	color:#4c4c4c;
	float:left;
	font-size:24px;
}
#success_message div.shortmessage {
	float:left;
	color:#5a5a5a;
	margin-top:0.3em;
}
.green_message img {
	margin:0 0.667em 0 0;
	float:left;
}
</style>
</head>
<body>

<a href="javascript:"  style="display:scroll;z-index:10;position:fixed;top:10px;right:2px;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<img border="0" src="images/feedback.png" ></a>
    <div id="fullpage">
 
      <div class="section" id="section0">
        <div class="logo"><a href="#"><img src="images/hlogo.png" width="231" height="108" alt=""></a></div>
  
        <div class="loginsection">
          <div class="login">
            <h1>Login to explore more features </h1>
            
            <form action="<c:url value='j_spring_security_check' />" method="post" id="submit"> <!-- autocomplete="off" -->      
            <div class="loginform">
            <label class="error floatleft" id="errorMsg"></label>
            <div class="clear"></div>
             <input type="email"  name="username" placeholder="Email ID" required id="userName" onfocus="clearClassFunction()" />
              <input type="password" name="password" placeholder="Password" maxlength="20" min="8" required id="password" onfocus="clearClassFunction()" />
              <input type="submit" value="login"  id="lgnBtn" /><br>
              <a href="user_forgot_password.htm" class="frgtpass">Forgot Password?</a>
              
        <c:if test="${not empty error}">
          <c:set var="securityMsg"
							value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" />
        </c:if>
        
        <script type="text/javascript">
						var error = "${securityMsg}";
						if (error.length > 0) {
							/* $("#userName").addClass("redborder");
							$("#password").addClass("redborder");
							$(".loginpan").effect("bounce", {
								times : 3,
								direction : "up"
							}, 1300); */

							$("#errorMsg").html('Incorrect Username or Password');
							
						}
					</script>
					
        <c:if test="${not empty Success}">
          <c:set var="Success"
							value="${Success}" />
        </c:if>
        <script type="text/javascript">
						var abc = "${Success}";
						if (abc.length > 0) {
							alert("Successfully Registered at Imploy.me");
						}
					</script>
     
            </div>
             </form>
          </div>
          
          
          <div class="register">
            <h1>Register As</h1>
            <div class="registerform">
              <ul>
                <li><a href="candidate_registration.htm" class="bluebg">Candidate</a></li>
                <li><a href="university_registration.htm" class="redbg">University</a></li>
                <li><a href="employer_registration.htm" class="greenbg">Employer</a></li>
              </ul>
            </div>
          </div>
        </div>
          
      </div>
      <div class="section" id="section1">
      <div id="bubbles">
        <div class="bubble x1"></div>
        <div class="bubble x2"></div>
        <div class="bubble x3"></div>
        <div class="bubble x4"></div>
        <div class="bubble x5"></div>

      	<div class="searchsection">
        	<h1>Easy Access to Thousands of <span>Jobs</span></h1>
        	
        	<form:form action="" method="post" cssClass="stdform" modelAttribute="studentSearchJobs">
        	<div class="searchform">
       		 <div id="searchErrorLabel" class="errormessage"></div>
            <div id="search">
            <form:input path="keyword" id="keywords" placeholder ="" cssClass="search"/>&nbsp;&nbsp;
           <!--  <input id="keywords"></input> -->
             <input name ="Submit" type="submit" value="">
            </div>
            <div class="clear"></div>
           	<div class="searchfilter">
           	<form:radiobutton path="searchCriteria"  id="searchCriteria1" class="css-checkbox" checked="true"  value="jobs"/>
            <!-- <input type="radio" name="searchCriteria" id="radio1"   checked="checked" /> -->
            <label for="searchCriteria1" class="css-label">Jobs</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            <form:radiobutton path="searchCriteria"  class="css-checkbox" id="searchCriteria2" value="internships"  />
            <!-- <input type="radio" name="radiog_lite" id="radio2" class="css-checkbox"/> -->
            <label for="searchCriteria2" class="css-label-red">Internships</label>
            
            </div>
            </div>
            </form:form>
           </div> 
        </div>
      </div>
      <div class="section" id="section2">
      	<div class="resume-gallery">
        		<h1>Explore our wide <span>profile</span> gallery<br> to find the right fit for your <span>organization</span>.</h1>
                <div class="resume-list">
                	<ul id="flexiselDemo4">
  <c:forEach var="student" items="${studentList}">        	
    <li>
    <c:set var="emailId" value="${student.emailID}"/>
                						 <c:choose>
											<c:when test="${student.photoName ne null}">  
											<img src="view_image.htm?emailId=${emailId}"/> 
											 </c:when>
											<c:otherwise>
						                      <img src="images/Not_available_icon1.png" />  
						                      </c:otherwise>
						                </c:choose> 
    <span class="details">
    	<label class="name"><c:out value="${student.firstName}"></c:out>
    	<c:out value="${student.lastName}"></c:out></label>
    	 <%-- <label class="university">${student.universityName} </label> --%>
    	<label class="score"><span>I-Score: </span> ${student.iScore} </label>
    </span>
    
    </li>
  </c:forEach>  
                                                    
</ul> 
                </div>
                <div class="clear"></div>
                <div class="note"><div>I-Score ensures less time sourcing and more time connecting with candidates</div></div>
      	</div>
      </div>
      <div class="section" id="section3">
      
      	<div class="university_section">
        <h1>CONNECT WITH YOUR <span>SCHOOL</span> TO KNOW LATEST JOBS, EVENTS &amp; FAIRS</h1></div>
         
         <div class="university-search">
            	<h2>FIND YOUR UNIVERSITY NOW</h2>
                <div class="university-searchform">
                	<input placeholder="Search University" id="university" />
                    <div><input type="submit" value="search" id="searchUniversity"/></div>
                </div>
            </div>  
      </div>
      <!--<div class="section" id="section4">&nbsp;</div>-->
    </div>

<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-2" class="modal hide fade in" id="dialog">
		<div class="modal-backdrop fade in" style="z-index: 999;"></div>
		<div style="z-index: 1000; position: absolute; margin: auto;"
			class="modal ui-dialog-content">
			<div class="modal-header">

				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button" id="closeDialog"  onclick="closeDialog()">x</button>
				<h3 id="myModalLabel">Verification Message</h3>
			</div>
			<div class="modal-body">
				<div id="success_message">
          <div class="shortmessage"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
          <h2 class="error_message_heading">&nbsp;&nbsp;&nbsp;Verification Successful</h2>
          <div class="clear"></div>
          <p class="error_message_para"> <strong>Congratulations! </strong></p>
          <p id="verificationSuccessMessage">${verificationSuccessMessage}</p>
        </div>
			</div>
		</div>
	</div>

</body>
</html>