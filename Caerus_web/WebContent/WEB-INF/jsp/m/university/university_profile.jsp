
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
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
<title>View Profile</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>

<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);

		var text = $("#about").val();
		text = text.replace(/\n\r?/g, '<br />');
		$("#display").html(text);
		
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
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>
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

<script src="../mobile_html/js/vallenato.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
<script>
jQuery(document).ready(function () {

   jQuery('.uniform-file').uniform();

});
</script>

<script type="text/javascript">
var observe;
if (window.attachEvent) {
    observe = function (element, event, handler) {
        element.attachEvent('on'+event, handler);
    };
}
else {
    observe = function (element, event, handler) {
        element.addEventListener(event, handler, false);
    };
}
function init () {
    var text = document.getElementById('text');
    function resize () {
        text.style.height = 'auto';
        text.style.height = text.scrollHeight+'px';
    }
    /* 0-timeout to get the already changed text */
    function delayedResize () {
        window.setTimeout(resize, 0);
    }
    observe(text, 'change',  resize);
    observe(text, 'cut',     delayedResize);
    observe(text, 'paste',   delayedResize);
    observe(text, 'drop',    delayedResize);
    observe(text, 'keydown', delayedResize);

    text.focus();
    text.select();
    resize();
}
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
   	   	  $("#city").val("");
   	   	  $("#state").val("");  
   	   	  $("#postalCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#postalCodeError").html("");  
   	   				values=cityName.split('(');
   	   				finalCity=values[0];
   	   				two=values[1];
   	   				$("#city").val(finalCity);
   	   				splitState=two.split(')');
   	   				finalState=splitState[0];
   	   				$("#state").val(finalState);
   	   	   	    }
             
     
        }
    });
 

}
	 
</script>


<!--31-07-2013-->
</head>


<body class="university"  onLoad="init();">
<div id="main_wrap">
<%@ include file="includes/header.jsp"%>	
  <div id="mid_wrap" class="midwrap_toppadding">
   <!--  <div id="submenu">
      <ul class="nav nav-pills">
       
        <li class="active"><a href="university_dashboard.htm">Profile</a><span class="active_arrow"></span></li>
 		<li><a href="university_manage_receivedinvitations.htm">Events</a></li>
      </ul>
    </div> -->
    <div class="clear"></div>
    <section id="inner_container">
    <h1 class="page_heading">Update<span class="orange_font">Your Profile</span></h1>
<%--    <form:form class="stdform" action="university_profile.htm" method="post"  commandName="universityRegCmd"> --%>
    
    
    <form:form class="stdform" action="university_profile.htm" method="post" commandName="universityDetailsCom" enctype="multipart/form-data">
    <div class="details" id="editpersonal">
     <ul>
    		<li>
    		<div class="label">University Name *</div>
    		<div class="labeldetails"><form:textarea path="universityName" rows="1"   tabindex="1"  id="text" disabled="true"/> </div>
            <form:errors path="universityName"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">Address</div>
    		<div class="labeldetails"><form:textarea path="universityAddress"  tabindex="2" rows="2" id="text"/> </div>
            <form:errors path="universityAddress"  cssClass="validationnote" />
     		</li>
     		
     		
     		
     		<li>
    		<div class="label">Zip Code</div>
    		<div class="labeldetails"><form:input path="zipCode" type="number" tabindex="1"  onChange="getCityFunction()"/></div>
            <form:errors path="zipCode"  cssClass="validationnote" />
            </br>
		    <span class="errorblock" id="postalCodeError"></span>
     		</li>
     		
     		<li>
    		<div class="label">City</div>
    		<div class="labeldetails"><form:input path="city" type="text" tabindex="1" readonly="true"/></div>
            <form:errors path="city"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">State</div>
    		<div class="labeldetails">
    		<form:input path="state" type="text" tabindex="3"  readonly="true" />
    		<%-- <form:select path="state"> 
            <spring:bind path="state">
            <c:set var="stateSelected" value="${status.value}"/>
            </spring:bind>
            
            <c:forEach var="statelist" items="${stateList}">
                 <c:set var="statename" scope="session" value="${stateName}"/>
                 
                   <c:choose>
                      <c:when test="${statelist == stateSelected}">
                          <option value="${stateSelected}" selected="selected"><c:out value="${stateSelected}"/></option>
                      </c:when>
                      <c:otherwise>
                          <option value="${statelist}"><c:out value="${statelist}"/></option>
                      </c:otherwise>
                   </c:choose>
            </c:forEach>
            </form:select> --%></div>
     		</li>
     		
     		<li>
    		<div class="label">University Registration No</div>
    		<div class="labeldetails"><form:input path="universityRegistrationNumber"  type="text" tabindex="1"  disabled= "true"/></div>
            <form:errors path="universityRegistrationNumber"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">Email ID</div>
    		<div class="labeldetails"><form:input path="contactPersonEmailId" type="email" tabindex="1" disabled="true"/></div>
     		</li>
     		
     		<li>
    		<div class="label">University URL</div>
    		<div class="labeldetails"><form:input path="universityWebsite" type="text" tabindex="1" /></div>
    		<form:errors path="universityWebsite"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">Contact Person</div>
    		<div class="labeldetails"><form:input path="contactPerson" type="text" tabindex="1"/></div>
            <form:errors path="contactPerson"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">Contact Number</div>
    		<div class="labeldetails"><form:input path="phoneNumber"  type="number" tabindex="1" /></div>
           	<form:errors path="phoneNumber"  cssClass="validationnote" />
     		</li>
     		
     		<li>
    		<div class="label">Overview</div>
    		<div class="labeldetails"><form:textarea path= "aboutUs" id="text-Simple" rows="10" style="width:100%;" /></div>
            <form:errors path="aboutUs"  cssClass="validationnote" />
     		</li>
			
			<li>
    		<div class="label">Logo Upload</div>
    		<div class="labeldetails"><input type="file" class="uniform-file" name="universityLogo" />
                 &nbsp;&nbsp; <c:out value="${logoName}"></c:out></div>
           <form:errors path="universityLogo" cssClass="validationnote" />
     		</li>     		
        </ul>
        </div>
    
    <div class="applybtn_wrap">
        <div class="innerform">
          <ul class="form_wrap">
            <li class="text_center">
              <input name="" type="submit" value="Save Profile" class="orangebuttons" >
            </li>
          </ul>
        </div>
      </div>
      
    </form:form>
    </section>
  </div>
  <div id="push"></div>
</div>
 <%--  <%@ include file="includes/footer.jsp"%> --%>
<script>


  
   $(".editpersonal").click(function(){
	  $("#editpersonal").css("display", "block");
		$(".savepersonal").css("display", "block");
		$(".editpersonal").css("display", "none");
		$("#viewpersonal").css("display", "none");	 
	  	
	
		}); 
		
		
	 $(".savepersonal").click(function(){
	   
	  	$("#editpersonal").css("display", "none");
		$(".savepersonal").css("display", "none");
		$(".editpersonal").css("display", "block");
		$("#viewpersonal").css("display", "block");	
	
		}); 
	
	
	$(".editeducation").click(function(){
	  $("#editeducation").css("display", "block");
		$(".saveeducation").css("display", "block");
		$(".editeducation").css("display", "none");
		$("#vieweducation").css("display", "none");	 
	  	
	
		}); 
		
		
	 $(".saveeducation").click(function(){
	   
	  	$("#editeducation").css("display", "none");
		$(".saveeducation").css("display", "none");
		$(".editeducation").css("display", "block");
		$("#vieweducation").css("display", "block");	
	
		}); 
		
		
		$(".editresume").click(function(){
	  $("#editresume").css("display", "block");
		$(".saveresume").css("display", "block");
		$(".editresume").css("display", "none");
		$("#viewresume").css("display", "none");	 
	  	
	
		}); 
		
		
	 $(".saveresume").click(function(){
	   
	  	$("#editresume").css("display", "none");
		$(".saveresume").css("display", "none");
		$(".editresume").css("display", "block");
		$("#viewresume").css("display", "block");	
	
		}); 
	
	
	
    </script>
    
   
</body>
</html>