<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Settings</title>
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
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery-loader.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	var profileVisibility = $("#profileVisibility").val();
	if(profileVisibility == "true")
	{
		$("#yes").attr("checked", true);
		$("#yes").parent().addClass("checked");
	}
	else
	{
		$("#no").attr("checked", true);
		$("#no").parent().addClass("checked");
	}
	
	var noUpdates = $("#noUpdates").val();
	if(noUpdates == "unsubscribe")
	{
		$("#option").css("display", "none");
		$("#unsubscribe").attr("checked", true);
		$("#unsubscribe").parent().addClass("checked");
	}
	var receiveUpdates = $("#receiveUpdates").val();
	if(receiveUpdates == "subscribe")
	{
		$("#subscribe").attr("checked", true);
		$("#subscribe").parent().addClass("checked");
	}
	var jobupdates = $("#jobupdates").val();
	if(jobupdates == "jobupdates")
	{
		$("input[type=checkbox][value="+jobupdates+"]").parent().addClass("checked");
		$("input[type=checkbox][value="+jobupdates+"]").attr('checked','checked');
	}
	var eventupdates = $("#eventupdates").val();
	if(eventupdates == "eventupdates")
	{
		$("input[type=checkbox][value="+eventupdates+"]").parent().addClass("checked");
		$("input[type=checkbox][value="+eventupdates+"]").attr('checked','checked');
	}
	var contactme = $("#contactme").val();
	if(contactme == "contactme")
	{
		$("input[type=checkbox][value="+contactme+"]").parent().addClass("checked");
		$("input[type=checkbox][value="+contactme+"]").attr('checked','checked');
	}
	
	
	var selected_radio=new Array();
	var selected_checkbox = new Array();
 	var sendajax= true; 
 	
 	$("#subscribe").click(function(){
 		$("#option").css("display", "block");
 		});
 	$("#unsubscribe").click(function(){
 		$("#option").css("display", "none");
 		});
 		
			
			$(".checkbox").click(function(){
				$("div#success_message").css("display","none");
				$("div#error_message").css("display","none");
			});
	
		
			$(".subscriberadio").click(function(){
				$("div#success_message").css("display","none");
				$("div#error_message").css("display","none");
				$('input[name=maiSettingsOptions]').change(function(){
					var selected_radiobutton =$('input[name=maiSettingsOptions]:radio:checked').val();
					 selected_radio.length=0;
					 selected_radio.push(selected_radiobutton);
					
					if(selected_radiobutton==="subscribe"){
						$("#option").css("display", "block");
						$("div.checker span").addClass("checked");
						$(".checkbox").attr('checked','checked');
					}
					if(selected_radiobutton==="unsubscribe"){
						$("#option").css("display", "none");
						$("div.checker span").removeClass("checked");
						if(selected_radio.length>0)
							selected_radio.pop();
						selected_radio.push($(this).val());
						$(".checkbox").removeAttr('checked');
						
					}
				});
				
			 
			
		});
		
		
		$("#applySettings").click(function(){
			var checked_option_radio = null;
			if($('#yes').is(':checked'))
			{
				checked_option_radio = true;
			}
			
			if ($('#no').is(':checked')) 
			{
				 checked_option_radio = false;
			}
			
			$.ajax({
				
				type:"POST",
				url:"candidate_apply_profile_visibility.json",
				
				data:{
					'visibility' : checked_option_radio,
				},
				
				success:function(data){
				},
				
				error:function(xhr,error){
					alert("error");
				}
				
			}); 
			
			
			sendajax=true;
			selected_checkbox.length = 0;
			 $("input:checkbox[name=subscribeoptions]:checked").each(function() {
				selected_checkbox.push($(this).val());
				});
			$("input:radio[name=maiSettingsOptions]:checked").each(function() {
				selected_radio.pop();
				selected_radio.push($(this).val());
				}); 
			if(selected_radio[0]==="subscribe" && selected_checkbox.length==0){
				sendajax=false;
				$("div#success_message").css("display","none");
				$("div#error_message").css("display","block").empty().append("<p style='margin-top:0;'>Please select one of the subcription options</p>");
			}
			if(selected_radio.length==0 && selected_checkbox.length==0){
				sendajax=false;
				$("div#success_message").css("display","none");
				$("div#error_message").css("display","block").empty().append("<p style='margin-top:0;'>Please select one of the options</p>");
			}
				
			  
			var map = new Object();
			map["selected_checkbox"]=selected_checkbox;
			map["selected_radio"]=selected_radio;
			
			 if(sendajax){
				$.ajax({
					type:"POST",
					data:JSON.stringify(map),
					 contentType: 'application/json',
					url:"candidate_apply_mail_settings.json",
					success:function(successFlag){
						if(successFlag)
							$("#error_message").css("display","none");
							$("#success_message").css("display","block");
							
					},
					error:function(xhr,error){
						alert("error");
					}
					
				}); 
				
				
				
			}
		
		
	});
});
</script>

</head>
<body>
<div id="wrap">
   
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp" %>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     <div id="innerbanner_wrap">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div> 
    <div id="innersection">
      
      <section id="rightwrap" class="floatleft">
      
      <div id="success_message" class="floatleft alertmessage" style="display:none;width:93%;">
		          <div id="warning_image"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
		          <p style="margin-top:0;">Your Settings have been updated successfully!!</p></div>
						
						<div id="error_message" style="display:none;" class="alertmessage"><div><img src="images/warningerror_icn.png" alt="Verification Successful" title="Verification Successful"></div>  </div>
      <div class="whitebackground">
      <h1 class="sectionheading">Profile Visibility</h1>
			<input type="hidden" id="profileVisibility" value="${profileVisibility}">
			
			<div class="par " >
			Set Profile Visibility 
		   <input type="radio" name="profileVisibility" value="true" id="yes" class="subscriberadio"> Yes &nbsp; <input type="radio" name="profileVisibility" id="no" value="false" class="subscriberadio"> No
		   <div class="clear"></div>
		   <!-- <input type="button" value="Apply" class="yellow_btn" id="applyProfileVisibility"> -->
		   </div>
			
			</div>
			
			<div class="clear"></div>
			<div class="whitebackground margin_top2">
				<h1 class="sectionheading">Mail Settings</h1>
			
			<div>
				<h5 class="bluehead">Leave it upon us to Keep you updated with the latest on job postings &amp; events.</h5>
			
				<form class="stdform">
				<input type="hidden" value="${mailSettingmap}" id="settings">
				
				<c:forEach items="${mailSettingmap}" var="mailSettingmap">
				
				<c:choose>
				<c:when test="${mailSettingmap.key eq 'unsubscribe' && mailSettingmap.value eq true}">
				<input type="hidden" id="noUpdates" value="unsubscribe">
				</c:when>
				<c:otherwise>
				<input type="hidden" id="receiveUpdates" value="subscribe">
				<c:if test="${mailSettingmap.key eq 'jobupdates'}">
				<input type="hidden" id="jobupdates" value="jobupdates">
				</c:if>
				<c:if test="${mailSettingmap.key eq 'eventupdates'}">
				<input type="hidden" id="eventupdates" value="eventupdates">
				</c:if>
				<c:if test="${mailSettingmap.key eq 'contactme'}">
				<input type="hidden" id="contactme" value="contactme">
				</c:if>
				</c:otherwise>
				</c:choose>
				</c:forEach>
				
				
						<div class="par clear"> <input type="radio" name="maiSettingsOptions" id="subscribe" value="subscribe" class="subscriberadio" >I want to subscribe for the E-mail Updates </div>
		  
			<div id="option" >
		   <div class="par"><input type="checkbox" name="subscribeoptions" value="jobupdates" class="checkbox" />Inform me of new job postings matching my profile every week</div>
		  <div class="par"><input type="checkbox" name="subscribeoptions"  value="eventupdates" class="checkbox" />Inform me of new events in my campus</div>
		   <div class="par"><input type="checkbox" name="subscribeoptions"  value="contactme" class="checkbox" />Allow the Employers to Contact me directly</div>
		   
		   </div>
		   
		   <div class="par" >
		   <input type="radio" name="maiSettingsOptions" id="unsubscribe" value="unsubscribe" class="subscriberadio">Dont disturb me with e-mails , I will check the latest updates on the website.
		   </div>
 		  </form>
			</div>
			
				<input type="button" value="Apply Settings" class="yellow_btn" id="applySettings">
     </div>
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
</body>
</html>