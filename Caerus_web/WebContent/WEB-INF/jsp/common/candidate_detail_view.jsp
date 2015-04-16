<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.util.Date"%>
<%@ page import="java.io.OutputStream"%>

<%@ page import="java.net.URLEncoder" %>
<%-- <%  			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				String authority = auth.getAuthorities().toString();
				int mid = authority.lastIndexOf("_");
			 	String role = authority.substring(mid+1, authority.length()-1);
				pageContext.setAttribute("role", role);
				pageContext.setAttribute("userid", auth.getName());
	%> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Detail View</title>
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
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />

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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>

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
  
   $(document).ready(function(){

	   $('#qrcodePopOver').webuiPopover({
           constrains: 'horizontal', 
           trigger:'click',
           multi: true,
           placement:'right-bottom',
           width:275,
           closeable:true,
           content: '<img src="student_qrcode.htm?emailId=<c:out value="${studentDetails.emailID}"/>" height="200" width= "200" id="qrcode">'+
           '<br><br><input type="text" placeholder="Email ID" id="friendEmailId" value="" /><br><span id="successMessage" class="hideValidation"></span>'+
               '<br><br><input name="" type="button" value="Share" onclick="sendQRCodeToFriend()" >'
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

	    //Disable message in case of searched candidate
	    if(referrerUrl === 'employer_search_candidate.htm'){
		    $("#messageLi").hide();
		    }

	    //Disable message in case of saved searched candidate
	    if(referrerUrl === 'employer_saved_candidates.htm'){
		    $("#messageLi").hide();
		    }
	/*	 alert("Hiiii"+"${authority}");
	  $.ajax({
	  url : "candidate_view_profile_resume.htm",
	  success : function (data) {
	  $("#contentArea").html(data);
	  }
	  }); */
	  }); 
  
  
  
  
</script>
 <script type="text/javascript">
	function emailCandidateProfile(candidateEmailIdModal) {
		
	var candidateEmailId = candidateEmailIdModal;
	var corporateEmailId=$("#corporateEmailId").val();
	var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if($("#corporateEmailId").val().length==0) {
		$("#validationMessage").html("Please enter email-id");
		
	}
	else if(pattern.test(corporateEmailId)==false){
		$("#validationMessage").html("Please enter valid email-id");
	}
	else{
		
	$.ajax({
 		
		url: '/employer_email_candidate_profile.json',
		data : {
			'corporateEmailId' : corporateEmailId,
			'candidateEmailId' : candidateEmailId,
	   
		},
		cache : false,
		success : function(data) {
			$("#validationMessage").html("Your mail is sent Successfully");
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}}
</script>

 <script type="text/javascript">
	function messageCandidate() {

 	var message= new Object();
 	if($("#messageId").val().length==0) {
		$("#messageValidation").html("Please Enter Your Message");
	}	

 	else{

 		message.message = $("#messageId").val();
 		 		
 		message.receiverEmailId= "${studentDetails.emailID}";

 		var jobIdAndFirmId = "${jobId}";
 		message.jobIdAndFirmId=jobIdAndFirmId;

		message.jobTitle="${jobTitle}";
		message.companyName = "${companyName}";

		message.candidateName=$("#candidateName").html();
 		
 		var isFirstMessage="True";
 		message.isFirstMessage = isFirstMessage;

 		var requestMessage=JSON.stringify(message);
 		console.log(requestMessage);
 		
 		$.ajax({
 			type : 'POST',
 	 		url: '/send_message.htm',
 			cache : false,
 			data :requestMessage,
 			contentType : 'application/json',
 			cache : false,
 			success : function() {
 				$("#messageValidation").html("Your message has been sent Successfully");
 				$("#messageId").val("");
 				
 			},
 			error : function(data) {
 				alert("Failed");
 			}
 		});

 	 	}	
 
}
</script>
<script type="text/javascript">
function hideModal()
{
	$("#messageValidation").html("");
	$("#messageId").val("");
}
</script>
<script type="text/javascript">
function sendQRCodeToFriend() {
	var friendEmailId = $("#friendEmailId").val();
	var pattern = new RegExp("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	
	if($("#friendEmailId").val().length==0) {
		$("#successMessage").empty().html("Please enter email-id");
	}
	else if(pattern.test(friendEmailId) == false){
		$("#successMessage").empty().html("Please enter valid email-id");
	}
	
	else {
		var studentEmailId = '<%=request.getParameter("studentEmailId") %>';
		var url = 'detail_view_candidate.htm?studentEmailId='+studentEmailId+'&friendEmailId='+friendEmailId;
		
		$.ajax({
	 		
			url: url,
			request:"GET",
			data : {
				'friendEmailId' : friendEmailId,
			},
			cache : false,
			success : function(data) {
				$("#successMessage").css('display','block');
				$("#successMessage").empty().append("Your mail has been sent Successfully");
			},
			failure : function() {
				alert("Failed");
			}
		});  
	}
}
</script>

<script>
function goBack()
{
  window.history.back();
}
</script>
</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
<%@ include file="includes/header.jsp" %>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div> 
  <%-- <div style="display: none;" id="optionsWrapper">
  <img src="student_qrcode.htm?emailId=<c:out value="${studentDetails.emailID}"/>" height="200" width= "200" id="qrcode">
           <br><br><input type="text" placeholder="Email ID" id="friendEmailId" value="" /><br><span id="successMessage" class="hideValidation"></span>
           <br><br><input name="" type="button" value="Share" onclick="sendQRCodeToFriend()" >
  </div> --%>
  
    <c:set var="candidateEmailIdModal" value="${studentDetails.emailID}"></c:set>
    <div id="innersection">
  <!--     <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ Portfolio</div> -->
 
  
  
  
      <section class="floatleft" id="rightwrap">
      
       <c:if test="${authority == 'ROLE_CORPORATE'}">
  <ul class="actions_icns floatright top_margin bottom_margin" id="toolbarCandidate">
 					<li><a href="#myModal1" data-toggle="modal"><span><img src="images/list_email_icn.png" alt="Email"></span>Email</a></li>
    				<li id="messageLi"><a href="#myModal10" data-toggle="modal"><span><img src="images/list_email_icn.png"></span>Message</a></li>
 					
                    <li><a id="downloadProfile" href="employer_download_candidate_profile.htm?emailId=<c:out value="${candidateEmailIdModal}"/>"><span><img src="images/list_download_icn.png" alt="Email"></span>Download</a></li>
 
                    <%  
						String internshipId=request.getParameter("internshipIdAndFirmId");  
					%>
					
						
                   	<%  
						String jobId=request.getParameter("jobId");  
					%> 
					
					<input type="hidden" id="jobId" value="${jobId}" />
					<input type= "hidden" id="internshipIdAndFirmId" value= "${internshipIdAndFirmId}" />
					<input type= "hidden" id="campus" value="${campus}" />
					 
					<c:choose>
					<c:when test="${not empty internshipIdAndFirmId && internshipIdAndFirmId ne 'null' && campus != true}">
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Shortlisted'}">
					<li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'OnHold'}">
					<li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Rejected'}">
					<li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
                    <li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Applied'}">
					<li><a href="employer_shortlist_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate.htm?isInternship=true&candidateEmailId=<c:out value="${studentDetails.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
           
					</c:when>
					
					<c:when test="${not empty jobId && jobId ne 'null' && campus != true}">
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Shortlisted'}">
					<li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'OnHold'}">
					<li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Rejected'}">
					<li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Applied'}">
					<li><a href="employer_shortlist_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate.htm?candidateEmailId=<c:out value="${studentDetails.emailID}"/>&jobId=<%=request.getParameter("jobId")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					</c:when>
					
					
					
					
				
					
					<c:when test="${campus && not empty jobId && jobId ne 'null'}">
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Shortlisted'}">
					<li><a href="employer_put_candidate_onhold_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'OnHold'}">
					<li><a href="employer_shortlist_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_reject_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Rejected'}">
					<li><a href="employer_shortlist_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					</c:if>			
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Accepted'}">
					<li><a href="employer_put_candidate_onhold_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_put_candidate_onhold_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate_campus.htm?candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&jobId=<%=request.getParameter("jobId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					</c:when>
					 
					<c:when test="${campus && not empty internshipIdAndFirmId && internshipIdAndFirmId ne 'null'}">
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Shortlisted'}">
					<li><a href="employer_put_candidate_onhold_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'OnHold'}">
					<li><a href="employer_shortlist_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_reject_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Rejected'}">
					<li><a href="employer_shortlist_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					</c:if>
					
					<c:if test="${not empty candidateStatus && candidateStatus ne 'null' && candidateStatus eq 'Accepted'}">
					<li><a href="employer_shortlist_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_check_icn.png" alt="Email"></span>Shortlist</a></li>
					<li><a href="employer_put_candidate_onhold_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_onhold_icn.png" alt="Email"></span>On-Hold</a></li>
					<li><a href="employer_reject_candidate_campus.htm?isInternship=true&candidateEmailId=<c:out value="${listForCandidate.emailID}"/>&internshipIdAndFirmId=<%=request.getParameter("internshipIdAndFirmId")%>&universityName=<%=request.getParameter("universityName")%>"><span><img src="images/list_cross_icn.png" alt="Email"></span>Reject</a></li>
					
					</c:if>
					</c:when>
					
					</c:choose>
					
					</ul>
  
  </c:if>
      <div class="innercontainer">
       <c:set var="photoName" value="${studentDetails.photoName}"/>
                <c:choose>
                      <c:when test="${photoName == null}">
                      <div class="cv_img"><img src="images/Not_available_icon1.png" width="152" height="152" alt=""><br>
                      <c:if test="${not empty candidateStatus && candidateStatus ne 'null'}">
                  <span class="orangetxt12"><c:out value="${candidateStatus}" /></span>
                   </c:if>
                      <a id="qrcodePopOver" class="clear display">View Your QR Code</a>
                      </div>
                      </c:when>
                       <c:otherwise>
                        <div class="cv_img"><img src="view_image.htm?emailId=<c:out value="${studentDetails.emailID}"/>" width="152" height="152" alt=""><br>
                        <c:if test="${not empty candidateStatus && candidateStatus ne 'null'}">
                  <span class="orangetxt12"> <c:out value="${candidateStatus}" /></span>
                   </c:if>
                        <a id="qrcodePopOver" class="clear display">View Your QR Code</a>
                        </div>
                      </c:otherwise>
                   </c:choose>                             
 
        <div class="cv_details whitebackground">
          <h1 id="candidateName" class="resumetitle floatleft"> <c:out value="${studentDetails.firstName}"/> <c:out value="${studentDetails.lastName}"/></h1>
          <form class="stdform" action="candidate_portfolio.htm">
          <c:if test="${authority == 'ROLE_STUDENT'}">
          <div class="floatright">
            <input name="" type="submit" value="Edit Your Portfolio" tabindex="17">
          </div>
          </c:if>
          </form>
          <div class="clear"></div>
          <span class="floatright orangetxt">Last Updated :<c:out value="${studentDetails.lastUpdate}"/></span>
          <h2 class="cv_subheading"><c:out value="${studentDetails.profileName}"/></h2>
           
          <div class="txtpadding"><c:out value="${studentDetails.aboutYourSelf}"/></div>
          <div class="basic_info_container">
            <div class="floatleft"><img src="images/home.png" alt="Home" width="28" height="28"/></div>
            <div class="basic_info"><c:out value="${studentDetails.address}"/>, <c:out value="${studentDetails.city}"/>, <br />
              <c:out value="${studentDetails.state}"/>, <c:out value="${studentDetails.zipCode}"/> </div>
          </div>
          <div class="basic_info_container">
            <div class="floatleft"><img src="images/tel_email.png" alt="Email" width="28" height="28"/></div>
            <div class="basic_info">Tel:   <c:out value="${studentDetails.mobileNumber}"/> <br />
              Email:  <c:out value="${studentDetails.emailID}"/> </div>
          </div>
          <div class="basic_info_container">
            <div class="floatleft"><img src="images/birth.png" alt="Email" width="28" height="28"/></div>
            <div class="basic_info">Birth:  <c:out value="${studentDetails.dateOfBirth}"/><br />
              Gender:  <c:out value="${studentDetails.gender}"/> </div>
          </div>
        </div>
        <div class="clear"></div>
      </div>
      
      
      <div class="innercontainer">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Education Profile</h2></td>
            <td width="80%" class="whitebackground"><div class="right_detailswrap">
                <ul class="topborder_lists">
                <c:forEach items="${universityList}" var="universityDetails">
                  <li>
                    <div class="floatleft">
                      <div class="greytxt_nomargin">
                      <c:if test="${universityDetails.universityCourseType ne 'null'}">
                      <c:out value="${universityDetails.universityCourseType}"/> 
                      </c:if>
                      <c:out value="${universityDetails.universityCourseName}"/>, <c:out value="${universityDetails.universityName}"/></div>
                      <div class="orangetxt12"> <c:choose>
                <c:when test="${universityDetails.universityMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose>
               
                 <c:out value="${universityDetails.universityYearFrom}"/> - 
                 
                  <c:choose>
                  <c:when test="${universityDetails.universityMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '12'}">
                  Dec
                </c:when></c:choose> <c:out value="${universityDetails.universityYearTo}"/>
                </div>
                    </div>
                    <div class="floatright">
                      <div class="dark_greytitle">GPA: <c:out value="${universityDetails.universityGpaFrom}"/> / <c:out value="${universityDetails.universityGpaTo}"/></div>
                    </div>
                    <div class="clear"></div>
                  </li>
                  </c:forEach>
                  <li>
                    <div class="floatleft">
                      <div class="greytxt_nomargin"><c:out value="${schoolDetails.schoolName}"/>, <c:out value="${schoolDetails.schoolState}"/></div>
                      <div class="orangetxt12">
                      Passing Date: <c:out value="${schoolDetails.schoolPassingMonth}"/>, <c:out value="${schoolDetails.schoolPassingYear}"/>
                      </div>
                    </div>
                    <div class="floatright">
                      <div class="dark_greytitle">GPA: <c:out value="${schoolDetails.schoolGpaFrom}"/> / <c:out value="${schoolDetails.schoolGpaTo}"/></div>
                    </div>
                    <div class="clear"></div>
                  </li>
                </ul>
              </div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      <div class="innercontainer">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Experience Profile</h2></td>
            <td width="80%" class="whitebackground"><div class="right_detailswrap">
                <ul class="topborder_lists">
                <c:forEach items="${workList}" var="workDetails">
                  <li>
                    <div class="floatleft">
                      <div class="grey_nomargin"><c:out value="${workDetails.workCompanyName}"/></div>
                      <c:if test="${workDetails.workDesignation ne 'null'}">
                      <div class="orangetxt12"><c:out value="${workDetails.workDesignation}"/></div>
                      </c:if>
                    </div>
                    <div class="duartion">
                      <div class="dark_greytitle">
                      
                      <c:choose>
                  <c:when test="${workDetails.workMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '12'}">
                  Dec
                </c:when></c:choose>
          <c:out value="${workDetails.workYearFrom}"/> - 
          
         <c:choose>
                  <c:when test="${workDetails.workMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '12'}">
                  Dec
                </c:when></c:choose> <c:out value="${workDetails.workYearTo}"/></div>
                    </div>
                      <div class="clear"></div>
                    <c:if test="${workDetails.workDescription ne 'null'}"> <div class="txtpadding floatleft"><c:out value="${workDetails.workDescription}"/></div></c:if>
                    <div class="clear"></div>
                  </li>
                  </c:forEach>
                </ul>
              </div>
              <div class="clear"></div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      <div class="innercontainer">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Skills Glossary</h2></td>
            <td width="80%" class="whitebackground"><div class="right_detailswrap">
            
            <div class="primary_container">
          <h3 class="greytxt_14">Primary Skills</h3>
           <c:forEach var="primarySkillsVar" items="${studentDetails.primarySkills}" varStatus="loop" > 
            <ul class="tagslists">
          			<li><c:out value="${primarySkillsVar}"/></li>
          	 </ul>         
			</c:forEach>
        </div>
        <div class="second_container">
          <h3 class="greytxt_14">Secondary Skills</h3>
                      <c:forEach var="secondarySkillsVar" items="${studentDetails.secondarySkills}" varStatus="loop" > 
          			 <ul class="tagslists">
          					<li><c:out value="${secondarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
        </div>
        
        </td>
        </tr>
        </table>
        
        <div class="clear"></div>
      </div>
      <div class="innercontainer">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Certifications</h2></td>
            <td width="80%" class="whitebackground"><div class="right_detailswrap">
                <ul class="topborder_lists">
                <c:forEach items="${certificationList}" var="certification">
                <li>
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
              </div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      <div class="innercontainer">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Publications</h2></td>
            <td width="80%" class="whitebackground"><div class="right_detailswrap">
                <ul class="topborder_lists">
                <c:forEach items="${publicationList}" var="publication">
                <li>
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
              </div></td>
          </tr>
        </table>
        <div class="clear"></div>
      </div>
      
      
      
      
      <div class="innercontainer">
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"><h2 class="resume_centr_subtitle">Others</h2></td>
            <td width="80%" class="whitebackground">
            
          
        <div class="primary_container ">
          <h3 class="greytxt_14">Interests</h3>
           <c:forEach var="interests" items="${studentDetails.interestList}" varStatus="loop" > 
            <ul class="tagslists">
          			<li><c:out value="${interests}"/></li>
          	 </ul>         
			</c:forEach>
        </div>
        <div class="second_container">
          <h3 class="greytxt_14">Languages</h3>
                      <c:forEach var="languages" items="${studentDetails.languagesList}" varStatus="loop" > 
          			 <ul class="tagslists">
          					<li><c:out value="${languages}"/></li>
          			</ul>       
			</c:forEach>
        </div>
            </td>
            </tr>
            </table>
            
       
         
        <div class="clear"></div>
      </div>
    
      <div class="clear"></div>
      <form class="stdform" action="candidate_portfolio.htm">
        <div class="doubletop_margin doublebottom_margin margin_top2">
          <div class="buttonwrap">
            <input name="" id = "btnBack" type="button" value="Back" tabindex="17" onclick="goBack()">
             <c:if test="${authority == 'ROLE_STUDENT'}">
            <input name="" type="submit" value="Edit Your Portfolio" tabindex="17">
            </c:if>
          </div>
        </div>
      </form>
    </section>
    <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <div class="bottomspace">&nbsp;</div>
  </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
 <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
  
  
  <div id="emailProfileDetails">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" class="modal hide fade in" id="myModal1">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="myModalLabel">Email Candidate Profile</h3>
			</div>
			<div class="modal-body">
				<form class="stdform" action="" method="get" id="mailForm">
					<div class="leftsection_form">
						<div class="par">
							<label class="floatleft">EmailId</label> <span class="star">*</span>
							<div class="clear"></div>
							<span class="field"> <input id="corporateEmailId"
								name="corporateEmailId" type="text" class="input-medium" />
							</span>
						</div>
						</div>
					
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
						<li><input type="button" value="Send" tabindex="21" class="add_participants floatleft" onClick="emailCandidateProfile('${candidateEmailIdModal}')"></li> 
						<li><span id="validationMessage" class="hideValidation"></span></li>
						</ul>
					</div>
					<div class="clear"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>
	
	
		<!-- Message Modal -->
	  <div id="messageCandidateModal">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-2" class="modal hide fade in" id="myModal10">
			<div class="modal-header">
				 <button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="">Message Candidate</h3> 
			</div>
			<div class="modal-body">
				<form class="stdform" action="" method="get" id="mailForm">
					<div class="leftsection_form">
						<div class="par">
							<label class="floatleft">Message Text</label> <span class="star">*</span>
							<div class="clear"></div>
							<span class="field"> 
							 <textarea  tabindex="2" id="messageId" class="input-large" name="address" style="width:600px; height:50px"></textarea> 
							<!-- <input id="messageId"
								name="messageId" style="width:600px; height:50px" type="text" class="input-large" /> -->
							</span>
						</div>
						</div>
					
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
						<li><input type="button" value="Send" tabindex="21" class="add_participants floatleft" onClick="messageCandidate()"></li> 
						<li><span id="messageValidation" class="hideValidation"></span></li>
						</ul>
					</div>
					<div class="clear"></div>
				</form> 
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>
	
	
	
	
	
	
    
    <!-- Exception Message Modal Message -->
    
      
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in"  id="exceptionModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div style="z-index: 1000; position:absolute;" class="modal ui-dialog-content">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Error </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
                  
    <c:out value="${successMessage}"></c:out>
   </div>
   </div>
  </div>
    
    <!-- Exception Message Modal Ends -->
  
  
  
  
</div>
</body>
</html>