
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
<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
<title>Candidate Dashboard</title>
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
<style type="text/css">
.ui-dialog-titlebar{
	display:none;
}


.saveBookmark{cursor:pointer; cursor:hand;}

#profileViewsModal{
	width:820px !important;
}

</style>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/dashboard.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>
<link rel="stylesheet" href="css/dots.css" type="text/css">
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css" />

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
 
<!--   -->
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
<!-- <script src="js/jquery.dropdownPlain.js"></script> -->
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>

<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>

<script type="text/javascript" src="js/jquery-loader.js"></script>
 <script type="text/javascript">
 $(document).on('click','.sendBtn',function(){
		var friendEmailId = $(this).parents(".shareJobDiv").find(".friendEmailId").val();
		var jobId = $(this).parents(".shareJobDiv").find(".hiddenJobId").val();
		
		var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if(friendEmailId.trim().length == 0) {
		$(this).parents(".fullwidth_form").find(".hideValidation").empty().html("Please enter Email-ID");
	}
	else if(pattern.test(friendEmailId) == false) {
		$(this).parents(".fullwidth_form").find(".hideValidation").empty().html("Please enter valid Email-ID");
	}
	else {
	console.log("selected job id : "+jobId);

	 $.loader({content:"<div class='dots'> Loading...</div>"}); 
	
	<!--Ajax -->
	$.ajax({
 		
		url: 'candidate_preview_listed_job.htm',
		request:"GET",
		data : {
			'friendEmailId' : friendEmailId,
			'jobId' : jobId
		},
		cache : false,
		async : false,
		success : function(data) {
			$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
			$.loader('close');
			//$(this).parents("form.stdform").find(".hideValidation").empty().html("You've Shared this Job with "+friendEmailId+" Successfully");
		},
		error : function(xhr,error) {
			$.loader('close');
			console.log("Failed");
		}
		}); 
	
	$(this).parents(".fullwidth_form").find(".hideValidation").empty().html("You've Shared this Job with "+friendEmailId+" Successfully");
	<!--Ajax -->
	
	}
		
		
		
 });
 
 $(document).ready(function(){
		var array = new Array();
		//$("#shareJobDiv").hide();

		$(".callToolTip").each(function(){
			var id = $(this).attr('id');
			var parentId = $(this).parents('tr').attr('id');
			
			$('#'+id).webuiPopover({
		          trigger:'click',
		          placement:'left',
		          width:350,
		          closeable:true,
		    	 // content: $("div#shareJobDiv").html()
		    	 content: '<div class="shareJobDiv"><form class="stdform" action="" method="get" id="mailForm"><div class="leftsection_form"><div class="par"><label class="floatleft">EmailId</label> <span class="star">*</span><div class="clear"></div><span class="field"> <input type="text" class="input-medium3 friendEmailId" /></span></div></div><div class="clear"></div><div class="fullwidth_form"><input type="hidden" class="hiddenJobId" value="'+parentId+'"><ul class="registration_form"><li><input type="button"  value="Send" tabindex="21" class="add_participants floatleft sendBtn"></li> <li><span class="hideValidation"></span></li></ul></div><div class="clear"></div></form></div>'
		  	  }); 
			
		});
	  	 
	  });
	
	/*  $(document).on("click",".callToolTip",function (){
		var id = $(this).attr('id');
		alert("id " +id);
		localStorage.setItem("clickedJobId",id);
	});  */
 
 function showAdvancedSearchDiv(){
		$("div#advancedSearchDiv").toggle();
	}

	function hideAdvancedSearchDiv(){
		$("div#advancedSearchDiv").toggle();
	}

	
	
 
 $(document).ready(function() {

	 $("div#advancedSearchDiv").hide();
	 
	 var successMessage = "<%=request.getParameter("successMessage") %>";
	  
	//Code to show success message on successful job post
	  if (successMessage!=null && successMessage != "null"){

	  $("#successMessageSpan").append(successMessage);
	    
	      $("#chgPasswordModal").dialog({
	          
	            modal: true,
	            open: function(event, ui){
	                setTimeout("$('#chgPasswordModal').dialog('close')",2500);
	            }
 });
	      
	  }
 });
 
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

<script type="text/javascript">
var flag;

$(document).ready(function(){
	
	$(".viewAll").click(function(){
			
			flag = true;
			getProfileViews();
			
		});
	
	
});

function clickme()
{
	flag = true;
	getProfileViews();
	
}

function getProfileViews()
{ 
	
	  $("#profileViewsModal").dialog({
	  
	  });

	    if(flag == true)
		{
	    	var url = "candidate_viewed_by_companies.json?viewAll=viewAll";
	    	$(".viewAll").hide();
	    	$("#noViews").hide();
	    	
		}

	    else
		{
	 		var url = "candidate_viewed_by_companies.json";
	 		$(".viewAll").show();
		}
		
	    $.ajax({

	    	  type : "GET",
	    	  url:url,
	    	  cache:false,
	    	  
	    	  success: function(data){

		    	  $("#tableBody").empty(); 
		    	  
				if(data.exception == null && data.exceptionOccured == false)
				{
					$(".emp_scheduleevent_table").show();

					 $.each(data.viewedByCompaniesMap, function(key,value) {
	    	       		  
				    		var employerName=key;
				    	    var timestamp=new Date(value);
				    	    var current_date = timestamp.getDate();
				    	    var current_month = timestamp.getMonth() + 1; //Months are zero based
				    	    var current_year = timestamp.getFullYear();

				    	    var data = new Array("Jan", "Feb", "Mar",
									"Apr", "May", "June", "July", "Aug",
									"Sep", "Oct", "Nov", "Dec");
							month = (data[current_month - 1]);
				    	    
				    	    var current_hours = timestamp.getHours();
				    	    var current_minutes = timestamp.getMinutes();
				    	    current_minutes = current_minutes > 9 ? current_minutes : '0' + current_minutes; // to get minutes in 2 digits
			
				    	  // var current_seconds = timestamp.getSeconds();
				    	    	    	   
				    	   $("#tableBody").append('<tr><td>'+employerName+'</td><td>'+current_date + " " + month + " " + current_year+" at "+current_hours+
				    			   ":"+current_minutes+'</td></tr>');
				    	  
				    	   });
					
				}
		    	  
	    		  

	    		  if(data.exception != null)
	    		  {
	    			  $(".emp_scheduleevent_table").hide();
			    	  
			    	  $(".viewAll").empty();
			    	  $("#noViews").show();
			    	   $("#noViews").empty().append("You have received no profile views in the last 10 days.<a onclick='clickme()'>View past profile views</a>");
	    		  }
	    			
	    		  if(data.exceptionOccured == true)
		    	   {
			    	   $(".emp_scheduleevent_table").hide();
			    	  
			    	    $(".viewAll").empty();
			    	    $("#noViews").show();
			    	   $("#noViews").empty().append('You have received no profile views in recent days.<a class="viewAll" href="candidate_portfolio.htm">Update your profile now</a>');
			    	   
		    	   }

	    			flag = null;
	    	  },
	    	  error: function(xhr,error)
	    	  {
	    	  }
	    	 });
	 
	
	 
}

</script>

<!-- Added by Trishna R -->
<script type ="text/javascript">
$(function(){
    $("#advancedSearch").submit(function(){

        var valid=0;
        
        $(this).find('input[type=text]').each(function(){
            if($(this).val() != "") valid+=1;
        });

        if(valid){
           return true;
        }
        else {
           
            $("#searchErrorLabel").html("");
            $("#searchErrorLabel").html("<label class='error_message'>Enter at least one search parameter!</label>");
            
            return false;
        }
    });
});
</script>

<!-- Added by TrishnaR,BalajiI -->



<script type="text/javascript">

function acceptBtnCLicked(fairId,finalURL)
{
	$.ajax({
		url:'candidate_manage_virtualfair_invitation.htm?fairId='+fairId+'&action=Accepted',
		success:function(data)
		{
			console.log("Success in candidate_setup_preview.htm");
			window.location.href=finalURL+"?fairId="+fairId;
		},
		error:function(xhr,error)
		{
			console.log("Error in candidate_setup_preview.htm");
		}
		});
}
</script>


<!-- Bookmark A Job -->

<script type="text/javascript">

$(document).ready(function() {
	
	
	
	
	$(".saveBookmark").click(function() {

var successFlag=false;
var jobId = $(this).attr('id');

	 $.ajax({
		 async:false,
		 cache:false,		 
url:'candidate_save_job.json?jobId='+jobId+'&bookmarkJob=true',
success:function(data)
{
	
	//Make the button look blue
	successFlag=true;	

	//$(this).parent().find('.saveactive').show();
},
error:function(xhr,error)
{
	console.log("Error in bookmarkJob");
}
});
if(successFlag){
//$(this).hide();
//$(this).append('<img src="images/saved_active_icn.png"  class="table_actionbtn saveactive" alt="Save Job"> &nbsp;');
//$(this).parent().children('.share').append('<img src="images/share_icn.png" alt="Share Your Jobs" class="table_actionbtn">');
  $(this).attr("src", "images/saved_active_icn.png");
  $(this).attr("title", "Already Saved");
    
//$(this).parent().find('.saveactive').show();
}	
	});


	function scrollToAnchor(aid){
	    var aTag = $("a[name='"+ aid +"']");
	    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
	}

	/* $("#virtualevent").click(function() {
	   scrollToAnchor('event');
	}); */

	$("#virtualevent").click(function() {
		   scrollToAnchor('jobFair');
		});
	
});

</script>
<!-- Bookmark A Job  -->
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:58% !important;}
</style>

<script type="text/javascript">
function hideModal()
{
	$(".hideValidation").html("");
	$(".friendEmailId").val("");
}
</script>
<script type="text/javascript">

function validateSkills()
{
	var formValue= document.getElementById("skillForm");
 	formValue.action='candidate_dashboard_skills_update.htm';

 	var inputVal= $("#primarySkills").val();

    	  if(inputVal=="")
          {
              $("#spn1").remove();
        	  $("#primarySkills_tagsinput").after('<span id="spn1" style="color: #f00; font-size: 11px;">Enter atleast 1 Primary skill</span>');
    	  }  
    	  if(inputVal!= "")
          {
           	 $("#spn1").remove();
    		 $("#primarySkills_tagsinput").after('<span class="important">    </span>');
    	  }

    	 var inputVal1= $("#tags1").val();
	        	  if(inputVal1=="") 
		       	  {
	        		$("#spn2").remove();
	            	$("#tags1_tagsinput").after('<span id="spn2"  style="color: #f00; font-size: 11px;">Enter atleast 1 Secondary skill</span>');
	        	  }  	  
	        	  if(inputVal1!="")
		          {
	        		  $("#spn2").remove();
	        		  $("#tags1_tagsinput").after('<span class="error">  </span>');
	        	  }
	        	  
	       	if($('#skillForm').valid())
	     	{
	         	  if(inputVal!="" && inputVal1!="")
	         	  {
	         			formValue.submit(); 
	         	  }
	    	 }  
}

</script>

 <script type="text/javascript">
$(document).ready(function(){
var userBrowsingPatternsObject = new Object ();

var objappVersion = navigator.appVersion; 
var objAgent = navigator.userAgent; 
var objbrowserName = navigator.appName; 
var objfullVersion = ''+parseFloat(navigator.appVersion);
var objBrMajorVersion = parseInt(navigator.appVersion,10);
var objOffsetName,objOffsetVersion,ix; 
 

// In Chrome 
if ((objOffsetVersion=objAgent.indexOf("Chrome"))!=-1) 
{ 
objbrowserName = "Chrome"; 
objfullVersion = objAgent.substring(objOffsetVersion+7);
 } 

// In Microsoft internet explorer 
else if ((objOffsetVersion=objAgent.indexOf("MSIE"))!=-1)
 { 
objbrowserName = "Microsoft Internet Explorer"; 
objfullVersion = objAgent.substring(objOffsetVersion+5); 
}

 // In Firefox 
else if ((objOffsetVersion=objAgent.indexOf("Firefox"))!=-1) 
{ 
objbrowserName = "Firefox"; 
} 

// In Safari
 else if ((objOffsetVersion=objAgent.indexOf("Safari"))!=-1) 
{ 
objbrowserName = "Safari"; 
objfullVersion = objAgent.substring(objOffsetVersion+7);
 if ((objOffsetVersion=objAgent.indexOf("Version"))!=-1)
 objfullVersion = objAgent.substring(objOffsetVersion+8);
 } 

// For other browser "name/version" is at the end of userAgent
 else if ( (objOffsetName=objAgent.lastIndexOf(' ')+1) < (objOffsetVersion=objAgent.lastIndexOf('/')) ) 
{ 
objbrowserName = objAgent.substring(objOffsetName,objOffsetVersion); 
objfullVersion = objAgent.substring(objOffsetVersion+1);

 if (objbrowserName.toLowerCase()==objbrowserName.toUpperCase()) 
{ 
	objbrowserName = navigator.appName;
} 
}

// trimming the fullVersion string at semicolon/space if present
 if ((ix=objfullVersion.indexOf(";"))!=-1) 
objfullVersion=objfullVersion.substring(0,ix); 

if ((ix=objfullVersion.indexOf(" "))!=-1) 
objfullVersion=objfullVersion.substring(0,ix); 
objBrMajorVersion = parseInt(''+objfullVersion,10); 

if (isNaN(objBrMajorVersion))
 { 
	objfullVersion = ''+parseFloat(navigator.appVersion);
 	objBrMajorVersion = parseInt(navigator.appVersion,10); 
} 

var OSName="Unknown OS";
if (window.navigator.userAgent.indexOf("Windows NT 6.2") != -1) OSName="Windows 8";
if (window.navigator.userAgent.indexOf("Windows NT 6.1") != -1) OSName="Windows 7";
if (window.navigator.userAgent.indexOf("Windows NT 6.0") != -1) OSName="Windows Vista";
if (window.navigator.userAgent.indexOf("Windows NT 5.1") != -1) OSName="Windows XP";
if (window.navigator.userAgent.indexOf("Windows NT 5.0") != -1) OSName="Windows 2000";
if (window.navigator.userAgent.indexOf("Mac")!=-1) OSName="Mac/iOS";
if (window.navigator.userAgent.indexOf("X11")!=-1) OSName="UNIX";
if (window.navigator.userAgent.indexOf("Linux")!=-1) OSName="Linux";

userBrowsingPatternsObject.browserName = objbrowserName;
userBrowsingPatternsObject.browserVersion = objfullVersion;
userBrowsingPatternsObject.os = OSName;

$.get("http://ipinfo.io", function(response) {
	var locationDetails = response.loc.split(",");

  userBrowsingPatternsObject.latitude = locationDetails[0];
  userBrowsingPatternsObject.longitude = locationDetails[1];
  userBrowsingPatternsObject.city = response.city;
  userBrowsingPatternsObject.state = response.region;
  userBrowsingPatternsObject.country = response.country;
  userBrowsingPatternsObject.organization = response.org;
  userBrowsingPatternsObject.ipAddress = response.ip;

  savePattern(userBrowsingPatternsObject);
  
}, "jsonp");

$("#keywords").on('change keyup paste',function(){
	 
		suggestKeywords();
	}); 

});

function savePattern(userBrowsingPatternsObject)
{
	$.ajax({
		
	  	type : 'POST',
	 	url : 'user_browsing_patterns.htm',						
		dataType : 'json',
		cache : false,
		data : JSON.stringify(userBrowsingPatternsObject),	
		contentType : 'application/json',
		
		success : function(data) {
		},
		
		error : function(xhr,error) {
		}
	}); 
		
}

</script> 
 <script type="text/javascript">
function suggestKeywords(){

	var enteredText=$("#keywords").val();
	$.getJSON( "/get_suggested_keywords.json",'enteredText='+enteredText, function( returnedWords ) {
  /* alert("returnedWords"+returnedWords); */
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

	   //Hide message shown after search is retrieved (Eg. 3 results match your search, use mouse keys)
	   $("span.ui-helper-hidden-accessible").hide();

	 	   
	   $( "#keywords" ).on( "autocompletefocus", function( event, ui ) {} );
	   $( "#keywords" ).on( "autocompleteclose", function( event, ui ) {} ); 
		 });

}

</script>
  <script type="text/javascript">
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
</head>
<body class="dashboard dashboard3">
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
    <section id="leftsection" class="floatleft">
    <div class="candidate_quickaction_wrap">
         <!-- <h1 class="sectionheading">Profile Statistics</h1> -->
         
          
         
         
         
          
    
         
    <div class="portfolio_img"> 
          
          <c:set var="photoName" value="${studentProfile.photoName}"/>
        <c:choose>
                      <c:when test="${photoName == null}">
                        <img src="images/Not_available_icon1.png" height = "123" width="127">
                         
                        
                      </c:when>
                      <c:otherwise>
                        <img src="view_image.htm?emailId=${studentProfile.emailID}" height = "123" width="127">
                        
                     
                      </c:otherwise>
                   </c:choose>
                   <h4 class="portfolio_candidate_name"><c:out value="${studentProfile.firstName}"/> <c:out value="${studentProfile.lastName}"/><br>
                   <span><c:out value="${studentProfile.age}"/>&nbsp;|&nbsp;<c:out value="${studentProfile.gender}"/></span></h4>
          <%-- <h5 class="portfolio_candidate_designation"><c:out value="${studentProfile.designation}"/></h5>
          <p class="portfolio_candidate_descp"><c:out value="${studentProfile.aboutYourSelf}"/></p> --%>
               <div class="portfolio_editbtn" style="display:none;"><span class="buttonwrap floatleft"><a href="candidate_portfolio.htm"><img src="images/edit_portfolio.png" alt="Edit Profile" title="Edit Profile" ></span></a></div>      
          </div>
          <div class="line-border">&nbsp;</div>
           <ul>
            <li class="blue">
              <div class="top_notifications"><c:out value="${countappliedjobs}"/><a href="candidate_job_activities.htm?selected=applied_jobs">Jobs Applied</a> </div>
              </li>
            <li class="darkblue">
              <div class="top_notifications">
              <c:choose> 
       			<c:when test="${not empty countRecommendedJobs}">
       			<c:out value="${countRecommendedJobs}"/>
       			</c:when>
         		<c:otherwise>0</c:otherwise>
        		</c:choose> <a href="<c:url value="candidate_job_activities.htm"/>">Recommended Jobs</a> </div>
             </li>
            
            <li  class="green"> 
             <div class="top_notifications">
              <c:choose> 
       			<c:when test="${not empty viewedByCompaniesCount}">
       			<c:out value="${viewedByCompaniesCount}"/>
       			</c:when>
         		<c:otherwise>0</c:otherwise>
        		</c:choose>  <a data-toggle="modal" onclick="getProfileViews()" href="#profileViewsModal">
            Profile Views</a> </div>
          
            <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="profileViewsModal">
		
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Profile Viewed By Companies</h3>
			</div>
			<div class="modal-body">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table">
				<thead>
                    <tr>
                        <th width="60%" align="left">Company Names</th>
                        <th width="40%" align="left">Viewed On</th>
                      </tr> 
                      
                </thead>
                <tbody id="tableBody">
                
                
                </tbody>   
              </table>
              <div class="clear"></div>
              <div class="floatright viewmore viewAll"><a>View past profile views</a></div>
              <div id="noViews"></div>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn">Close</button>
			</div>
		</div>
            
            </li>
            <li>
              <div class="top_notifications top_notifications_bluebg">
              <c:out value="${eventsCount}"/> <a>Job Fairs</a>
              </div>
             <c:choose>
             <c:when test="${eventsCount != 0}">
              <a href="#" id="virtualevent">Job Fairs</a> 
              </c:when>
             
              </c:choose>
              </li>
          </ul>
           
           <div class="clear"></div>
           
        </div>
          <div class="line-border">&nbsp;</div>
       <%--  <a name="jobFair"></a>
         <div class="candidate_upcomingevents_wrap" id="vfe" >
        <h1 class="sectionheading fontsize14">Upcoming Virtual Job Fair Events  <span>
        (<c:choose> 
        <c:when test="${not empty virtualEvents}">${virtualEvents}</c:when>
         <c:otherwise>0</c:otherwise>
        </c:choose>)
        </span></h1>
       
        <c:choose>
        <c:when test="${virtualEvents !=0}">
       <form class="stdform">
          <ul>
           <c:forEach var="virtualFairDetails" items="${virtualFairDetails}"> 
            <li>
             <div class="floatleft width100"> 
              <div class="floatleft event_calendar doubleright_margin">
              <fmt:parseDate value="${virtualFairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="MMM"/><br/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd"/></div>
                
                    
              <c:set var="myScheme" value="${pageContext.request.scheme}"/>
              <c:set var="myServerName" value="${pageContext.request.serverName}"/>
              <c:set var="myServerPort" value="${pageContext.request.serverPort}"/>
              <c:set var="myContext" value="VJF"/>
              <jsp:useBean id="now" class="java.util.Date"/>             
              <c:set var="today" value="${now}"/>
              <c:set var="finalURL" value="${myScheme}://${myServerName}:${myServerPort}/${myContext}/student_virtual_jobfair_dashbord.htm"></c:set>
                
               
              <div  class="eventdetails_wrap floatleft" style="width: 76%;">
                <h5><a href="candidate_setup_preview.htm?fairId=<c:out value="${virtualFairDetails.virtualJobId}"></c:out>" class="blueheading"><c:out value="${virtualFairDetails.virtualJobName}"/></a> 
          
               <fmt:parseDate value="${virtualFairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
               <fmt:formatDate var="todayDate" value="${now}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="startDate" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="endDate" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>
               
			  <c:choose>
		          <c:when test="${(startDate <= todayDate) && (todayDate <= endDate)}">
		         	<a class="blueheading"> 
		         	<img src="images/live.gif" width="51" height="18" alt="" class="inlineimg"> </a>
		          </c:when>
		     </c:choose>

                </h5>
       
                <div><span class="event_date">
                <fmt:parseDate value="${virtualFairDetails.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate1"/>
                <fmt:parseDate value="${virtualFairDetails.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate1"/>
                
                <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="MMM"/>
                 to <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="MMM"/></span> <!-- | <span class="boldtxt orangetxt">Convocation Hall</span>, University of Texas --></div>
                <div class="smalltxt"> <c:out value="${virtualFairDetails.acceptedCompanyCount}"/> 
                <c:choose><c:when test = "${virtualFairDetails.acceptedCompanyCount==1}">Company</c:when><c:otherwise>Companies</c:otherwise></c:choose> Participating | <span class="boldtxt"><c:out value="${virtualFairDetails.invitedStudentsCount}"/> People Attending</span></div>
                 <div class="clear"></div>
              <div class="textAlignCenter"><input type="button" value="Quick Register" onclick="acceptBtnCLicked(${virtualFairDetails.virtualJobId},'${finalURL}')"  /></div>
</div>
<div class="textAlignCenter">
              <input type="button" value="Quick Register" onclick="acceptBtnCLicked(${virtualFairDetails.virtualJobId},'${finalURL}')"  /></div>
              </div>
              <!-- <div class="floatright candidate_event_type">Job Fair</div> -->
             
            </li>
            </c:forEach>
       
          </ul>
          
          </form>
               </c:when>
               <c:otherwise>
               <span> There are no Events against your Profile.</span>
               </c:otherwise>
        </c:choose>
        
           <!-- <div class="viewmore floatright">View more</div>  -->
        </div> --%>
        <c:if test="${eventsCount != 0}">
          <div class="candidate_upcomingevents_wrap whitebackground">
         
        <h1 class="sectionheading">Upcoming Job Fairs</h1>
        <form class="stdform">
          <ul>
           <c:forEach var="upcomingEvents" items="${upcomingEventsList}"> 
            <li>
              
               
              <div class="floatleft width100"> 
              <div class="floatleft event_calendar doubleright_margin">
              <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate"/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="MMM"/><br/>
                <fmt:formatDate type="date" value="${formatedStartDate}" pattern="dd"/></div>
                
            
              <div class="eventdetails_wrap floatleft" style="width: 76%;">
              <h5>
              <c:choose>
                <c:when test="${upcomingEvents.universityFlag eq false}">
                <a href="candidate_preview_received_corporate_invite.htm?event_id=<c:out value="${upcomingEvents.eventId}"/>" class="blueheading"><c:out value="${upcomingEvents.eventName}"/></a> 
          </c:when>
          <c:otherwise>
          <a href="preview_university_event.htm?eventId=<c:out value="${upcomingEvents.eventId}"/>"></a>
          <%-- <a href="candidate_preview_university_event.htm?eventName=<c:out value="${upcomingEvents.eventName}"/>&eventId=<c:out value="${upcomingEvents.eventId}"/>&eventType=<c:out value="${upcomingEvents.eventType}"/>" class="blueheading"><c:out value="${upcomingEvents.eventName}"/></a> --%>
          </c:otherwise>
          </c:choose>
               <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate"/>
               <fmt:formatDate var="todayDate" value="${now}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="startDate" value="${formatedStartDate}" pattern="yyyy-MM-dd"/>
               <fmt:formatDate var="endDate" value="${formatedEndDate}" pattern="yyyy-MM-dd"/>
            
                </h5>
       
                <div><span class="event_date">
                <fmt:parseDate value="${upcomingEvents.startDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedStartDate1"/>
                <fmt:parseDate value="${upcomingEvents.endDate}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedEndDate1"/>
                
                <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedStartDate1}" pattern="MMM"/>
                 to <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="dd"/> <fmt:formatDate type="date" value="${formatedEndDate1}" pattern="MMM"/>
                | <c:out value="${upcomingEvents.startTime}" /> to <c:out value="${upcomingEvents.endTime}" /></span></div>
			</div>
              </div>
             
              <div class="clear"></div>
            </li>
            </c:forEach>
          
          </ul>
          <c:if test="${eventsCount > 3}">
        <div class="viewmore floatright">
        <a href="candidate_broadcasted_corporate_invites.htm">View more</a></div>
         </c:if>
          </form>
           
        </div>
        </c:if>
    </section>
    
      <section id="rightwrap" class="floatleft">
      
       
        
        
        <div class=" padding_bottom doublebottom_margin whitebackground">
        <h1 class="sectionheading">Quick Search</h1>
          
           <form action="candidate_search_jobs_internships.htm" method="post" class="stdform" id ="advancedSearch">
            <div class="floatleft right_margin"> <span class="field">
              <input type="text" name="keyword" class="input-xxlarge1" placeholder="Find Jobs On Skills/Locations" id = "keywords" />
              <input type="hidden" name="searchCriteria" value="Jobs" />
              </span> </div>
            <!-- <div class="par floatleft left_margin"> <span class="field">
              <input type="text" name="location" class="input-medium3" placeholder="Search In" id= "location"/>
              </span> </div> -->
            <div class="floatleft advancesearch_topmargin left_margin">
              <input name="" type="submit" value="Search" tabindex="21" class="no_right_margin yellow_btn">
              <div class="clear"></div>
               <div class="floatleft"> <!-- <a href="candidate_search_jobs_internships.htm"> Advanced Search</a> -->
               	<a onclick="showAdvancedSearchDiv()"> Advanced Search</a>
               </div>
            </div>
          </form>
         
          <div class="clear"></div>
          
          <span id = "searchErrorLabel"></span>
          
        </div>
        
        <div id="advancedSearchDiv" class="marginbot whitebackground">
        	 <h1 class="sectionheading"> Advanced Search</h1>
        <div id="candidate_registration_wrap">
          <div class="form_wrap">
            <form:form action="candidate_search_jobs_internships.htm" method="post" modelAttribute="searchJobs" cssClass="stdform" id="advancedSearchFrm">
              <div class="fullwidth_form">
              <div class="par">
              
              <span id = "searchErrorLabel"></span>
              
                  <label class="floatleft" style="padding-top:0.2em"><strong>Search By:</strong> &nbsp;</label>
                <span class="formwrapper" >
               <form:radiobutton path="searchCriteria" value="Jobs" checked = "checked"  OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; 
                <form:radiobutton path="searchCriteria" value="Internships" OnClick="showhideFaculty('internships')" />Internships
                </span>
                
              </div>
             
                  
                  </div>
              <div class="leftsection_form">
                
              <div class="par">
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
				  <form:input path="keyword" cssClass="input-xxlarge" id="keywords" />
                  <form:errors path="keyword"  cssClass="input-xxlarge"/>                
                  </span> </div> 
                  
                   <div class="par" >
                 <label>Functional Area</label>
              
               <form:select data-placeholder="Choose an Option" path="functionalArea" cssClass="chzn-select list_widthstyle1" >
                  <form:option value="">Choose an Option</form:option>
                	<c:forEach var="functionalArea" items="${functionalAreas}">
                         <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option> 
                  	</c:forEach>
                  </form:select>
              
                </div>
                  
              </div>
              <div class="rightsection_form">
                <div class="par" id="city">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                    <span class="field">
                    <form:input path="location" cssClass="input-xxlarge" />
                    <form:errors path="location"  cssClass="input-xxlarge"/>
                  </span>  </div>
                               
             <div class="par" id="industry">
                  <label class="floatleft">Industry</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                  
                  <form:select data-placeholder="Choose an Option" path = "industry"  cssClass="chzn-select list_widthstyle1">
                    <form:option value="">Choose an Option</form:option>
                    <c:forEach var="industry" items="${industries}">
                         <option value="<c:out value="${industry}" />"><c:out value="${industry}" /></option> 
                   </c:forEach>
                  </form:select>
                  
                  </span> </div>
               
               
                  
              </div>
              <div class="clear"></div>
              <div class="doublebottom_margin">
                <div class="buttonwrap">
               	<input name="search" type="submit" value="Search" >
                <input name="" type="button" value="Hide" onclick="hideAdvancedSearchDiv()">
              </div>
              </div>
              
            </form:form>
          </div>
        </div>
        
        </div>
        
         <div class="clear"></div>
     <div class="doublebottom_margin padding_bottom whitebackground">
        <h1 class="sectionheading">Jobs Matching Your Profile  <span>
        (<c:choose> 
        <c:when test="${not empty countRecommendedJobs}">${countRecommendedJobs}</c:when>
         <c:otherwise>0</c:otherwise>
        </c:choose>)
       
        </span></h1>
       <c:choose>
     
        <c:when test="${countRecommendedJobs != 0}">
        
       <!--  <div class="actionlegend_wrap floatright bottom_margin">
          <ul>
            <li>Actions Legends:</li>
            <li><img src="images/campusjob_icn.png" class="bigicons" alt="Campus" title="Campus">Campus</li>
          </ul>
        </div> -->
        <div class="clear"></div>
        <a name="event"></a>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="candidate_jobmatching">
          <tr>
            <!-- <th width="5%">&nbsp;</th> -->
            <th width="25%" class="text-left">Job Title</th>
            <th width="20%">Location</th>
            <th width="20%">Company</th>
            <th width="11%">Job Type</th>
             <th width="12%">Job Posted</th> 
             <th width="12%" style="text-align:center">Actions</th> 
          </tr>
          <c:forEach items="${recommendedjobs}"  var="recommendedjobs" varStatus="status">
          <tr id="${recommendedjobs.jobIdAndFirmId}">
            <!-- <td>&nbsp;</td> -->
            <td><span class="boldtxt"><a href="candidate_preview_listed_job.htm?isRecommendedJob=true&jobId=<c:out value="${recommendedjobs.jobIdAndFirmId}"></c:out>"><c:out value="${recommendedjobs.jobTitle}"/></a></span><br/>
               
              
              <span class="date">
              <fmt:parseDate value="${recommendedjobs.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="rActivities"/>
                <fmt:formatDate type="date" value="${rActivities}" pattern="E MMM dd yyyy"/>
              </span></td>
            <td><c:out value="${recommendedjobs.location}"/></td>
            <td><a href="profile_preview.htm?companyName=${recommendedjobs.companyName}"><c:out value="${recommendedjobs.companyName}"/></a></td>
            <td><c:out value="${recommendedjobs.jobType}"/></td>
           <!--   <td>15 mins</td>  -->
             <td><c:out value="${recommendedjobs.differenceInDays}"/></td>
             
             <td class="table_centeralign">
             <span>
             </span>
            <c:choose>
	             <c:when test="${savedJobIds.contains(recommendedjobs.jobIdAndFirmId)}">
	             <img src="images/saved_active_icn.png"  class="table_actionbtn saveactive" alt="Save" title="Already Saved"> 
	              <%-- <a onclick="javascript:localStorage.setItem('clickedJobId','${recommendedjobs.jobIdAndFirmId}');" href="#myModal1" data-toggle="modal" class="share"> --%>
		             <a  class="share callToolTip" id="${status.index}">  
		             	<img src="images/share_icn.png" alt="Share Your Jobs" class="table_actionbtn" title="Share">
		             </a>
			    </c:when>
	             <c:otherwise>
	             <img src="images/saved_icn.png" alt="Bookmark your jobs" class="table_actionbtn saveBookmark" title="Save" id="${recommendedjobs.jobIdAndFirmId}">
	            <%--   <a onclick="javascript:localStorage.setItem('clickedJobId','${recommendedjobs.jobIdAndFirmId}');" href="#myModal1" data-toggle="modal" class="share"> --%>
			 	<a class="share callToolTip" id="${status.index}">            
             		<img src="images/share_icn.png" alt="Share Your Jobs" class="table_actionbtn" title="Share">
               </a>
	             </c:otherwise>
             </c:choose>
             </td>
          </tr>
        </c:forEach>
          
        </table>
        <c:if test="${countRecommendedJobs > 6}">
        <div class="viewmore table_rightalign">
        <a href="candidate_job_activities.htm">View more</a></div>
         </c:if>
        </c:when>
        <c:otherwise>
       
       
       
       <c:choose>
       	
      
        
        <c:when test="${not empty noJobsMessage }">
      	 <span><c:out value="${noJobsMessage }"></c:out> </span>
      	 <div class="clear"></div>
     	</c:when>
       <c:otherwise>
         <div class="fullwidth" id="skillglossary"> 
         <h1 class="sectionheading">Skills Glossary</h1>
              <form:form action="" method="post" modelAttribute="addStudent" class="stdform" id ="skillForm">   
		<div class="borderbottom doublebottom_margin padding_bottom">
	 <div class="leftsection_form"><div class="par">
                <label class="floatleft">Primary Skills</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                    <form:input id="primarySkills" path="primarySkills" cssClass="input-xlarge"  />
                	<form:errors path="primarySkills1"  cssClass="input-xlarge"/>
                </span> </div></div>
              <div class="rightsection_form" style="width:47%;">  
              <div class="par">
                <label class="floatleft">Secondary Skills</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                 <form:input  id="tags1" path="secondarySkills" cssClass="input-xlarge" />
              	 <form:errors path="secondarySkills1" id="tags1"  cssClass="input-xlarge"/>
                </span> </div>
                </div>
                <div class="par floatright">
                
                <form:hidden path="hiddenValue" value="dashboardPage"/>
                <input name="" type="button" value="Save" tabindex="21" class="add_participants top_margin" onclick="validateSkills()">
              </div>
              <div class="clear"></div>
              </div>
                </form:form>
            </div>
           </c:otherwise> 
        </c:choose>
        
        </c:otherwise>
         </c:choose>    
      </div>
        <div class="clear"></div>
       
        
        
       
       
     
      </section>
      <section id="rightsection">  <c:choose>
			<c:when test="${empty recentActivitiesMapSorted}">
			</c:when>
			<c:otherwise>
			<div class="floatleft doubleright_margin top_margin whitebackground">
         <h1 class="sectionheading">Recent Activities</h1>
        <ul class="recent_activities_wrap">
        <c:forEach var="recentActivities" items="${recentActivitiesMapSorted}">
        <fmt:parseDate value="${recentActivities.value}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="rActivities"/>
                <li><span style="color:#818181;"><fmt:formatDate type="date" value="${rActivities}" pattern="dd MMMM yyyy"/></span> <br> <c:out value="${recentActivities.key}"></c:out></li>
                </c:forEach>
        </ul>
        </div>
        
        </c:otherwise>
        </c:choose>
  
        
        <div class="floatleft whitebackground margin_top2" style="width:87%;">
          <h1 class="sectionheading">Video Resume</h1>
          <p> Use the power of video to be more visible to the prospective recruiters by uploading  your resume. <span><a href="candidate_portfolio.htm#e" class="pinkcolor">Do it right Now</a></span></p>
          <div class="candidate_video_cv"><a href="candidate_portfolio.htm#e"><img src="images/candidate_video.jpg" width="220" height="127" alt=""></a></div>
        </div></section>
       <div class="clear"></div>
    </div>
    <div class="bottomspace">&nbsp;</div>
  
  </div>
  <!--------------  Middle Section :: end -----------> 
  
  
  <!--------------  Common Footer Section :: start ----------->
 <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
  
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
                  
    <c:out value="${successMessage}"></c:out>
   </div>
   </div>
  </div>
  
  
  
  
</div>

  
			


</body>
</html>
