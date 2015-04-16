<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Advance Search Listing</title>
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
<link rel="stylesheet" href="css/jplayer.pink.flag.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />

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
<script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/jquery.pajinate.js"></script>
  
  <style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal{
	width:690px !important;
	/*height: 470px !important;*/
	margin-left:-350px;
}
.modal-body{
height:auto;
}
</style>

<script>


$().ready(function(){
	
	$(".saveCandidateAnchor").click(function (){
		
		var candidateEmailId = $(this).attr('id');
		
		$.ajax({
		  	type : 'POST',
		 	url : 'employer_save_candidate.htm?candidateEmailId='+candidateEmailId,						
			
			cache : false,	
			
			success : function(data) {

				$(this).css('display','none');

				$("#successMessage").append("Candidate has been saved");


				$("#successModal").dialog({
							          
							            modal: true,
							            open: function(event, ui)
							            {
							                setTimeout("$('#successModal').dialog('close')",2500);
							            }
						 			});

							 timeoutfunction();
				
			},
			
			error : function(xhr,error) {
				//alert("Failed");
			}
			
			}); 
		
	});
	
});


/* function saveCandidate(candidateEmailId)
{
	$.ajax({
	  	type : 'POST',
	 	url : 'employer_save_candidate.htm?candidateEmailId='+candidateEmailId,						
		
		cache : false,	
		
		success : function(data) {

			candidateEmailId = candidateEmailId.replace('@','').replace('.','');

			$("#li_"+candidateEmailId).css('display','none');

			$("#successMessage").append("Candidate has been saved");


			$("#successModal").dialog({
						          
						            modal: true,
						            open: function(event, ui)
						            {
						                setTimeout("$('#successModal').dialog('close')",2500);
						            }
					 			});

						 timeoutfunction();
			
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
		
		}); 
} */
function timeoutfunction()
{
	setTimeout(function(){window.location.reload();}, 2510);
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
  
  <script>
		function getVideo(buttonId)
		{
		
		$("#jquery_jplayer_1").jPlayer( "destroy" );
		var emailId=$('#'+buttonId).parents('.responseslisting').find("#emailId").val();
		
		$("#jquery_jplayer_1").jPlayer({
			ready: function () {	
				$(this).jPlayer("setMedia", {
					m4v: "view_videoCV.htm?emailId="+emailId
				});
			},
				  
			swfPath: "js",
			supplied: "m4v",
			size: {
				width: "640px",
				height: "350px",
				cssClass: "jp-video-360p"
			},
			smoothPlayBar: true,
			keyEnabled: true
			
		});
	}
		</script>
		
  <script>
 function getSelectedEmailCheckbox() {
	//alert("prem");
	document.form.action="employer_candidate_mail.htm";
	 document.form1.submit();
 }
 </script>
  
<script>
function editFunction()
{
window.history.back();
}
</script>

<script type="text/javascript">
function ShowOld()
{
	//alert('email check');
 $("input:checkbox");
 
	var emails= '';
	//alert(emails);
//if(emails != ""){
	//alert('nside if');
  $( "input:checked" ).each(function() {
emails= emails+","+ this.value;
});
  
  if(emails == ""){
	  
alert('Please select atleast one candidate');
	  
  }
	  
  
//alert(emails);
if(emails != ""){
window.location.href='employer_candidate_mail_list.htm?emailList='+emails;
//document.navigatepath ;
}
return false;
}
</script>

<script type="text/javascript">
$(document).ready(function(){
	$('.search_candidate_listing').pajinate({
		num_page_links_to_display : 3,
		items_per_page : 10	
	});
});     
</script>


<script type="text/javascript">

$(function(){
    $("#saveSearch").submit(function(){
        var valid=0;

        if($("#stateVal").val() != null || $("#universityNameVal").val() != null || $("#cityVal").val() != "" || $("#keywords").val() != "")
        {
           valid+=1;
        }
       
        if(valid){
           return true;
        }
        else {
           
            $("#searchErrorLabel").html("");
            $("#searchErrorLabel").html("<label class='error'>Enter at least one search parameter!</label>");
            
            return false;
        }
    });
});

function openModifySearch()
{
	$("#modifySearchDiv").show();
}

function hideDiv()
{
	$("#modifySearchDiv").hide();
}


function saveSearchFunction()
{	
		if( $("#employerSaveSearchChkbox").is(':checked'))
		{
			var searchParameterNameValue=$("#parameterNameId").val();
			var searchTrimmed=$.trim(searchParameterNameValue);
			
				if(searchTrimmed!="" && searchTrimmed.length!=0)
				{		var formValue= document.getElementById("saveSearch");
						formValue.action="employer_save_search_parameter.htm";	
		    			formValue.submit();
		    			return true;
				}
				else
				{		$("#saveSearchErrorLabel").html("");
			          	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
			          	return false;
				}
		}
	
		else
			{
				$("#saveSearchErrorLabel").html("");
	        	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
	        	return false;
			}
	return false;
}

$(document).ready(function(){
	var keyword = $("#keyword").val();
	var city = $("#city").val();
	var state = $("#state").val();
	var universityName = $("#universityName").val();

	var jobDetailsCom = new Object();

	if(null != keyword && "" != keyword)
		jobDetailsCom.keyword=keyword;
	if(null != city && "" != city)
		jobDetailsCom.city=city;
	if(null != state && "" != state)
		jobDetailsCom.state=state;
	if(null != universityName && "" != universityName)
		jobDetailsCom.universityName=universityName;

	var labels=$("table.responseslisting");
	$('select').on('change',function(){
		
		sortedParameter = this.value;
		jobDetailsCom.sortedParameter = sortedParameter;
		
		$.ajax({
			type : 'POST',
			url: "employer_sorted_candidate_listing.json",
			dataType : 'json',
			cache : false,
			data : JSON.stringify(jobDetailsCom),
			contentType : 'application/json',
			
			success : function(candidateResults){
			setDomElements(candidateResults);
			},
			
			error : function(xhr,error) {
			alert("Failed");
		}
		});
	});
	
	function setDomElements(candidateResults)
	{
		$("#form1").empty();
			$.each(candidateResults , function(key,value){
				for(var i=0;i<labels.length;i++){
					if(value.emailID == labels[i].id){
						$("#form1").append(labels[i]);
					}
				}
			}); 
	}
	});
</script>  


		


</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
      <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
   
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_search_candidate.htm">Search Candidates</a> / Advanced Search</div> -->
      <input type="hidden" value="${keyword}" id="keyword">
      <input type="hidden" value="${city}" id="city">
      <input type="hidden" value="${universityName}" id="universityName">
      <input type="hidden" value="${state}" id="state">
      <section id="rightwrap" class="floatleft">
     
      <a onclick="openModifySearch()" class="floatright">Modify Search</a>
      
     <div id="modifySearchDiv" class="form_wrap whitebackground margin_top2" style="display: none;">
             <div id="candidate_registration_wrap">
          <div class="form_wrap">
             <form:form class="stdform" action="" method="post" modelAttribute="jobDetailsCom" id="saveSearch">  
              <span id="searchErrorLabel">
        	 </span>
              <div class="fullwidth_form">               
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
                 <!--  <input type="text" name="input5" class="input-xxlarge1" /> -->
                      <form:input path="keyword" class="input-xxlarge" id="keywords"/>
                      <form:errors path="keyword"  class="input-xxlarge"/>
                  </span> </div>
              <div class="leftsection_form">
                  
                  <div class="par">
									<label class="floatleft">State</label> 
									<div class="clear"></div>
									<span class="formwrapper">
									
										<form:select path="state" multiple="multiple" cssClass="chzn-select list_widthstyle1" style="width:511px;" id="stateVal">
                            				<c:forEach items="${stateList}" var="stateNameVar">
	                            				      <c:choose>
	                            				      	<c:when test="${jobDetailsCom.state.contains(stateNameVar)}">
	                            				     		<form:option value="${stateNameVar}" selected="selected">${stateNameVar}</form:option>
	                            				     	</c:when>
	                            				     	<c:otherwise>
	                            				     		<form:option value="${stateNameVar}" >${stateNameVar}</form:option>
	                            				     	</c:otherwise>
	                            				      </c:choose>
                            				     </c:forEach>                 
                        				</form:select>
									
								
									</span>
									
								</div>
                  
                  <div class="par">
									<label class="floatleft">University</label> 
									<div class="clear"></div>
									<span class="formwrapper">
									
										<form:select path="universityName" multiple="multiple" cssClass="chzn-select list_widthstyle1" style="width:511px;" id="universityNameVal">
                            				      <c:forEach items="${universityList}" var="universityNameVar">
	                            				      <c:choose>
	                            				      	<c:when test="${jobDetailsCom.universityName.contains(universityNameVar)}">
	                            				     		<form:option value="${universityNameVar}" selected="selected">${universityNameVar}</form:option>
	                            				     	</c:when>
	                            				     	<c:otherwise>
	                            				     		<form:option value="${universityNameVar}" >${universityNameVar}</form:option>
	                            				     	</c:otherwise>
	                            				      </c:choose>
                            				     </c:forEach> 
                        				</form:select>
									
								
									</span>
									
								</div>
                
                <div class="clear"></div>
               
              </div>
              <div class="rightsection_form">
                
                <div class="par">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                  <span class="field">
                    <form:input path="location" class="input-xxlarge" id="cityVal"/>
                  </span> </div>
              </div>
              <div class="clear"></div>
              <div class="fullwidth_form">
              <span id="saveSearchErrorLabel"></span>
                <div class="par"> <span class="formwrapper">
                  <form:checkbox path="saveSearchParameter" id="employerSaveSearchChkbox" onClick="$(this).is(':checked') && $('#checked').slideDown('slow') || $('#checked').slideUp('slow');" />
                  Save Search Parameter </span> </div>
               <div class="par">
                	<div id="checked" class="showhide_text">
                  <label class="floatleft">Parameter Name</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                  <form:input path="parameterName" class="input-xxlarge1" id="parameterNameId" />
                  <form:errors path="parameterName"  cssClass="input-xxlarge1"/>
                  </span> </div>
                </div>  
                <div class="par">
                <div class="buttonwrap">
                   <input name="" type="button" value="Save this Search" onclick="saveSearchFunction()" >
                    <input name="" type="submit" value="Search">
                    <input name="" type="button" value="Hide" onclick="hideDiv()">
                    <!-- <input name="" type="button" value="Back" onclick="backButtonFunction()"> -->
              </div>
              </div>
              </div>
            
             </form:form>
             </div>
             </div>
            </div> 
     
        <div class="searchfilter_wrap borderbottom" id="firstDiv">
       
            <h1 class="sectionheading">
            
            <c:choose>
            <c:when test="${not empty count}">
            Search Results <span>(${count})</span>
            
             <div class="floatright" style="width:20%;">
            <!--  Sort By :&nbsp;&nbsp;&nbsp;&nbsp; -->
            <select>
          <c:forEach var="sortparameter" items="${sortParameters}">
          <option value="${sortparameter}"> <c:out value="${sortparameter}"/></option>
          </c:forEach>
          </select>
            </div>
            </c:when>
            <c:otherwise>
            No Results Found
            </c:otherwise>
            </c:choose>
            
            </h1>
            
          </div>
       
            
            <div>            
            
            <c:if test="${not empty model.exceptionMessage}">
			<div class="errorblock">${model.exceptionMessage}</div>
			</c:if>
			
			</div>
			<div class="search_candidate_listing">
        <div class="reponses_listing_wrap">
          
          <form:form id="form1" action="employer_candidate_mail.htm"  method="post" commandName="searchCandidate">
          
             <c:forEach var="studentDetails" items="${studentList}"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="0" class="responseslisting jobslisting whitebackground margin_top2" id="${studentDetails.emailID}">
           <!--  <tr>
                <td colspan="2" class="padding_bottom">&nbsp;</td>
              </tr> -->      
              
            <tr class="bg">
                
                <td><div class="image_wrap"> <c:set var="photoEmailId" value="${studentDetails.emailID}"/>
                
                						<c:choose>
											<c:when test="${studentDetails.photoName ne null}"> 
											<div class="candidate_photo"><img src="view_image.htm?emailId=${studentDetails.emailID}" width="100" height="100" alt="" /></div>
											</c:when>
											<c:otherwise>
						                      <div class="candidate_photo"><img src="/images/Not_available_icon1.png" width="100" height="100" alt=""></div> 
						                      </c:otherwise>
						                      </c:choose>
                	</div>
                <div class="details_wrap">

                    
                     <div class="sectionleft floatleft">
                     <a href = "detail_view_candidate.htm?studentEmailId=<c:out value="${studentDetails.emailID}"/>" ><span> 
                    <c:out value="${studentDetails.firstName}"></c:out></span>  <span><c:out value="${studentDetails.lastName}"></c:out></span>,&nbsp;
                    <span><c:out value="${studentDetails.city}"></c:out>,<c:out value="${studentDetails.state}"></c:out> </span></a>
                   <div class="clear"></div>
                   <span class="orangetxt boldtxt"><c:out value="${studentDetails.universityDetails.universityCourseName}"></c:out>,</span>&nbsp;<span><c:out value="${studentDetails.universityDetails.universityName}"></c:out>,</span></div> 
                    
                    <div class="sectionright floatright"><span class="orangetxt boldtxt">GPA of <c:out value="${studentDetails.universityDetails.universityGpaFrom}"/> of <c:out value="${studentDetails.universityDetails.universityGpaTo}"/></span> </div>
                    
                    <div class="clear"></div>
                 
                    <p class="description"> <c:out value="${studentDetails.aboutYourSelf}"/>   </p>
                    
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="9%" valign="top" class="keyskillstxt">Key Skills</td>
                        <td width="91%" valign="top" class="keyskills_padding"><ul class="keyskillslist">
                         
                             <c:forEach items="${studentDetails.primarySkills}" var="primarySkills">
                        <li><c:out value="${primarySkills}"/> </li>
                        </c:forEach>
                              </ul></td>
                      </tr>
                  
                  </table>
                    <ul class="actions_icns floatright top_margin">
                    <li><c:if test="${not empty studentDetails.videoName}"> <a data-toggle="modal" class="buttonSelect" href="#myModal" ><span style="margin-top:0;"><img src="images/video_icn.png" alt="video"></span>Video Profile</a></c:if></li>
                    
                     <c:if test="${studentDetails.savedCandidate eq false}">
	                    <c:set var="candidateEmailId" value="${studentDetails.emailID}" />
	                    
	                    	<%-- <c:set var="escaped" value="${candidateEmailId.replace('@','').replace('.','')}" /> --%>
	                   
	                    <c:set var="escapedId" value="li_${escaped}"></c:set>
	                    <li>
		                    <a class="saveCandidateAnchor" id="${candidateEmailId}"><span>
		                   	 <img src="images/addtolist.png" alt="Save Candidate" title="Save Candidate"></span>Save Candidate
		                    </a>
	                    </li>
                 </c:if> 
                <c:if test="${not empty studentDetails.resumeName}"> 
	                <li>
	                <a href="employer_download_candidate_profile.htm?emailId=<c:out value="${studentDetails.emailID}"/>&jobId=null">
		                <span><img src="images/list_download_icn.png" alt="Email">
		                </span>Download
	                </a>
	                </li>
	           </c:if>     
                  </ul>
                  <input id="emailId" type="hidden" value="${studentDetails.emailID}"></input>
                  
                  </div>
                <div class="clear"></div></td>
               
              </tr>
                   
          </table>
          <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="myModal">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Profile Video</h3>
			</div>
			<div class="modal-body">
				
				<div id="jp_container_1" class="jp-video jp-video-360p">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-video-play">
						<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-title">
							<ul>
								<li>Video Profile</li>
							</ul>
						</div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>

							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
								<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
								<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>
		</div>
                  </div>
          </c:forEach>
          </form:form>
          
          </div>
       
           <c:if test="${count gt 10}">
          <div class="page_navigation"></div>
          </c:if>
         
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
<script type="text/javascript" src="js/nav_script.js"></script> 
<script>
	function checkNull(){
		var formulaSelect = document.getElementById("formula_Name").value;		
		if (formulaSelect.trim()){		  
		  return true;
		}
		else{
		  alert("Please select formula !!!");
		  return false;
		}	
	}
</script> 
<script>
var idCount = 1;
 $('.buttonSelect').click(function() { 
	 $(this).attr('id', 'q' + idCount);
	 var buttonId = 'q' + idCount;
	 idCount++;
	 
		var emailId=$('#'+buttonId).parents('.responseslisting').find("#emailId").val();
		var jobId = $("#jobId").val();
		$.ajax({
			
			type : 'POST',
			url: 'employer_candidate_listing.htm?emailId='+emailId,
			data : {
				'emailId' : emailId,
				//'jobId' : jobId				
			},
			cache : false,
			success : function(data) {
				
			},
			failure : function() {
				alert("Failed");
			}
		}); 
	 
getVideo(buttonId);
});
</script>
<script>
 $('.close').click(function() { 
$("#jquery_jplayer_1").jPlayer( "destroy" );
});
</script>

<!-- Success Modal -->

 <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="successModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessage"></span>
   </div>
   </div>
  </div>


<!-- Success Modal --> 

</body>

</html>