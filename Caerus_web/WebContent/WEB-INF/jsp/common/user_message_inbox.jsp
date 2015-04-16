<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.net.URLEncoder" %>
<%  			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				String authority = auth.getAuthorities().toString();
				int mid = authority.lastIndexOf("_");
			 	String role = authority.substring(mid+1, authority.length()-1);
				pageContext.setAttribute("role", role);
				pageContext.setAttribute("userid", auth.getName());
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>User Message Inbox</title>
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
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />

	<link rel="stylesheet" href="css/demo.css" />
	<link href="css/jquery.mCustomScrollbar.css" rel="stylesheet" />
	
	<script src="js/cufon-yui.js"></script>
	<script src="js/Myriad_Pro_300.font.js"></script>
	<script src="js/cufon_fonts.js"></script>
	<script src="js/jquery.min.js"></script>


	<!-- custom scrollbars plugin -->
	
  

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

 <script type="text/javascript">

  $(document).ready(function() {
	 	 
	 	 
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
  <style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal1{
	width:690px !important;
	/*height: 470px !important;*/
	margin-left:-350px;
}
 .modal-body{
height:auto;
} 

#exceptionModal{
	width:820px !important;
} 
</style>

 
 <script type="text/javascript" src="js/jquery.accordion.js"></script> 
  <script type="text/javascript">

	$(window).load(function() {

	jQuery('#list3').accordion({
			header: 'div.title',
			active: false,
			alwaysOpen: false,
			animated: false,
			autoheight: false
		});
		
		
		var accordions = jQuery('#list3');
	});
	</script> 
	<script type="text/javascript">

	$(document).ready(function(){

		//Distinguish unread message from read one
	     $('.messageunread').each(function(){
		     $(this).closest('li').find('div.title').addClass('newmessage');
		     });

		//Open reply text area and store details of latest message after which reply is generated
		 $('.reply_btn').click(function(){
		 
		 var emailElem = $(this).closest('div.contentlist');
		 var receiverEmailId = $(emailElem).parent().find('.receiverid').val();
		 
		 var jobIdAndFirmId =  $(emailElem).parent().find('.jobidspan').val();
		 var latestMessageId = $(emailElem).parent().find('#latestMessageId').val();
		 var jobTitle=$(emailElem).parent().find('.jobtitle').val();
		 var companyName= $(emailElem).parent().find('.companyname').val();
		 var candidateName = $(emailElem).parent().find('.candidatename').val();

		 localStorage.setItem("latestMessageId", latestMessageId);
		 localStorage.setItem("receiverEmailId", receiverEmailId);
		 localStorage.setItem("jobIdAndFirmId", jobIdAndFirmId);
		 localStorage.setItem("jobTitle", jobTitle);
		 localStorage.setItem("companyName",companyName);
		 localStorage.setItem("candidateName",candidateName);
		 
		 
		 $(this).closest('li.selected').find('div.replymessage').show();
	 });

		 //Highlight selected messages
		 $('.padding_bottom2').click(function(){

			 //Remove highlighted class if clicked again on div
			 if($(this).hasClass('highlighted')){
				 
				 $(this).removeClass('highlighted');

				 }
			 
			 else{
				 
			 $(this).addClass('highlighted');

			 }
			 });

	/* 	   //Delete selected messages
		   $('.delete_btn').click(function(){

			 var selectedMessages =$('.highlighted');
		     var deletedMessageArray = new Array();
			 selectedMessages.each(function(){

		      var deletedMessage=$(this).attr('id');
			  deletedMessageArray.push(deletedMessage);
		        }  	        
			    ); 
			    //Check if messages are selected
                        if (deletedMessageArray.length != 0) {
			 $.ajax({
					type : 'POST',
					url: '/delete_message.htm',
					cache : false,
					data :JSON.stringify(deletedMessageArray),
					contentType : 'application/json',
					cache : false,
					success : function() {
						alert("Selected messages have been deleted successfully");
						window.location.href = 'message_inbox.htm';
					},
					error : function(data) {
						alert("Failed");
					}
				});}
			 }); */

			 //Highlight all messages before delete
			 $('.checkboxex').change(function(){

				 if(this.checked) {
					 
					 $(this).closest('li.selected').find('.padding_bottom2').addClass('highlighted');

						 }

				 if(!this.checked) {
						 
					 $(this).closest('li.selected').find('.padding_bottom2').removeClass('highlighted');

						 }
			 
			 });
		 
	 });

 
</script>
 
 <script type="text/javascript">

function deleteMessage(deleteButton){
	
	 var selectedMessages =$('.highlighted');
	 var deletedMessageArray = new Array();
	 selectedMessages.each(function(){

			      var deletedMessage=$(this).attr('id');
				  deletedMessageArray.push(deletedMessage);
			        }  	        
				    );
	    

			//Check if messages are selected
			                 if (deletedMessageArray.length != 0) {

			                	 var r=confirm("Are you sure want to delete this record ?");
			             		if (r==true){

			             		    $.ajax({
										type : 'POST',
										url: '/delete_message.htm',
										cache : false,
										data :JSON.stringify(deletedMessageArray),
										contentType : 'application/json',
										cache : false,
										success : function() {
											//alert("Selected messages have been deleted successfully");
											window.location.href = 'message_inbox.htm';
										},
										error : function(data) {
											alert("Failed");
										}
									});

			                	  return true;
			         		}
			         		else{

			         			
			         			$(deleteButton).parents().children('div.padding_bottom2').removeClass('highlighted');
			         			$(deleteButton).parents().find('.checkboxex').closest('span').removeClass('checked');
			         			
			         			
			         		  return false;
			         		}
        
					
                
							}
		
	 }


</script>
	<script>
  
  $(document).ready(function() {

	$(".replymessage").hide();  
    var showChar = 300;
    var ellipsestext = "...";
    var moretext = "READ MORE";
    var lesstext = "COLLAPSE";
    $('.more').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar) {
 
            var c = content.substr(0, showChar);
            var h = content.substr(showChar-1, content.length - showChar);
 
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
 
            $(this).html(html);
        }
  });

    var showChar1 = 100;
    var ellipsestext1 = "...";
 
    $('.more1').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar1) {
 
            var c = content.substr(0, showChar1);
           
            var html = c + '<span class="moreellipses">' + ellipsestext1;
 
            $(this).html(html);
        }
 
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });

    //Set unread message status read on expand of accordion
	 $(".title").on("click", function(){
		 
	 var $this = $(this);
   
     var readMessageMap = {};
   	 var readMessages = $(this).parent().find('div.padding_bottom2');
   	 readMessages.each(function(){

     //Message Id(key) and Receiver EmailId(value)
   	 readMessageMap[$(this).attr('id')] = $(this).find('.receivermailid').val();
    });
   
	 $.ajax({
			type : 'POST',
			url: '/read_message.htm',
			cache : false,
			data :JSON.stringify(readMessageMap),
			contentType : 'application/json',
			success : function() {

				$this.removeClass('newmessage');
				 var currentMessageCount = Number('${sessionScope.newMessageCount}');
					if(currentMessageCount != 0){
						//Change unread message count on page
						$('#messageCount').html(currentMessageCount-1);
						} 
			},
			error : function(data) {
				alert("Failed");
			}
		});
    }); 

});
 </script>
 <script>

    //Send reply function
	function messageCandidate(){

		var currentAccordion=$('.selected');
			
		var currentReplyMessage=$(currentAccordion).find('#modalMessage').val();
		
	    var message= new Object();		
	if(currentReplyMessage.length==0){

		$(currentAccordion).find("#validationMessage").html("Please Enter Your Message");
		$(currentAccordion).find('#modalMessage').val('');
		}

	else{

		$(currentAccordion).find('#modalMessage').val('');
        $(currentAccordion).find('#messageDiv').hide();
		message.message = currentReplyMessage;
		
		var latestMessageId=localStorage.getItem("latestMessageId");
		var jobIdAndFirmId=localStorage.getItem("jobIdAndFirmId");
		var receiverEmailId=localStorage.getItem("receiverEmailId");
		var jobTitle=localStorage.getItem("jobTitle");
		var companyName=localStorage.getItem("companyName");
		var candidateName=localStorage.getItem("candidateName");
		
		
		message.receiverEmailId=receiverEmailId;
		message.jobIdAndFirmId=jobIdAndFirmId;
		message.prevMessageId=latestMessageId;
		message.jobTitle=jobTitle;
		message.companyName=companyName;
		message.candidateName=candidateName;
		
		message.isFirstMessage = "False"; 
		message.read= "False";
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
				alert("Your Message has been sent successfully");
				window.location.href = 'message_inbox.htm';
			},
			error : function(data) {
				alert("Failed");
			}
		});  
		}

}
</script> 
 </head>
  <body>
<div id="wrap"> 
    
  <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
      
    <div id="innersection">
       <!--  <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a></div> -->
        
        <section id="centersection" class="floatleft width100" style="padding:0;">



<div class="clear"></div>


<ul id="list3">
<c:choose>
<c:when test="${messageInboxListSize == 0}">
There are No New Messages for You !
</c:when>
<c:otherwise>

<c:forEach items="${messageInboxList}"  var="messageInboxListMessageRelay"> 
  
  <c:set var="latestMessage" scope="page" value="${messageInboxListMessageRelay[0]}"></c:set>
<li>

<div class="title">

<input type="hidden" id="latestMessageId" name="latestMessageId" value="${latestMessage.messageId}" />
 <c:if test="${role=='CORPORATE'}">
 <c:choose> 
 <c:when test="${latestMessage.photoName == null}">
 <img src="images/Not_available_icon1.png" width="60" height="60" alt="" class="floatleft" align="absmiddle">
 </c:when>
 <c:otherwise>
 <c:if test="${userid eq latestMessage.receiverEmailId}">

<img src="view_image.htm?studentEmailId=<c:out value="${latestMessage.senderEmailId}"/>&isMessagePage=true" width="60" height="60" alt="" class="floatleft" align="absmiddle" /> 
</c:if>
<c:if test="${userid eq latestMessage.senderEmailId}">
<img src="view_image.htm?studentEmailId=<c:out value="${latestMessage.receiverEmailId}"/>&isMessagePage=true" width="60" height="60" alt=""  class="floatleft" align="absmiddle" /> 
</c:if>
 </c:otherwise>
 </c:choose>

</c:if>

<c:if test="${role=='STUDENT'}"> 
<c:choose>
<c:when test="${'admin@caerus.com' eq latestMessage.senderEmailId}">
<img src="images/Not_available_icon1.png" width="60" height="60" alt="" class="floatleft" align="absmiddle" /> 
</c:when>
<c:otherwise>
<c:choose>
<c:when test="${latestMessage.photoName == null}">
 <img src="images/Not_available_icon1.png" width="60" height="60" alt="" class="floatleft" align="absmiddle">
</c:when>
<c:otherwise>
<img src="view_image.htm?companyName=<c:out value="${latestMessage.companyName}"/>&isMessagePage=true" width="60" height="60" alt="" class="floatleft" align="absmiddle" /> 
</c:otherwise>
</c:choose>
</c:otherwise>
</c:choose>
</c:if>


<!--Receiver ID of latest message  -->
<span  class="listtitle">
<c:if test="${role=='CORPORATE'}">
<c:if test="${userid eq latestMessage.receiverEmailId}"> 
<input type="hidden"  class="receiverid" value="${latestMessage.senderEmailId}" />
</c:if>

<c:if test="${userid eq latestMessage.senderEmailId}">
<input type="hidden" class="receiverid" value="${latestMessage.receiverEmailId}" />
</c:if>
</c:if>

<c:if test="${role=='STUDENT'}"> 
<c:if test="${userid eq latestMessage.receiverEmailId}"> 
<input type="hidden" class="receiverid" value="${latestMessage.senderEmailId}" />
</c:if>
<c:if test="${userid eq latestMessage.senderEmailId}"> 
<input type="hidden" class="receiverid" value="${latestMessage.receiverEmailId}" />
</c:if>
</c:if> 
</span>

<input type="hidden" class="jobidspan" value="${latestMessage.jobIdAndFirmId}" />
<input type="hidden" class="companyname" id="" name="" value="${latestMessage.companyName}" />
<input type="hidden" class="candidatename" id="" name="" value="${latestMessage.candidateName}" />
<input type="hidden" class="jobtitle" id="" name="" value="${latestMessage.jobTitle}" />

<span class="listlittle">
<c:if test="${role=='STUDENT'}"> 
<c:choose>
<c:when test="${'admin@caerus.com' eq latestMessage.senderEmailId}">
<c:out value="${latestMessage.messageSubject}"></c:out>
</c:when>
<c:otherwise>
<c:out value="${latestMessage.jobTitle}"/> at <c:out value="${latestMessage.companyName}"/>
</c:otherwise>
</c:choose>

</c:if>

<c:if test="${role=='CORPORATE'}">
<c:out value="${latestMessage.jobTitle}"/>
<br> 
<c:out value="${latestMessage.candidateName}"/>
(
<c:if test="${userid eq latestMessage.receiverEmailId}"> 
<c:out value="${latestMessage.senderEmailId}"></c:out>
</c:if>

<c:if test="${userid eq latestMessage.senderEmailId}">
<c:out value="${latestMessage.receiverEmailId}"></c:out>
</c:if>
)
</c:if>
</span> 



  <label  class="description more1"><c:out value="${latestMessage.message}"/></label>
<div class="date" style="float: right;margin-top: -32px;margin-right: 50px;">
              	<fmt:parseDate value="${latestMessage.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOnDate"/>
                <fmt:formatDate type="date" value="${postedOnDate}" pattern="${dateFormat}"/>
              </div>
   </div>
 

  
<div class="content_1 contentlist">
<form class="stdform">
<div class="contain">


<div class="textAlignRight width100">
  <input id="" type="checkbox" class="floatleft checkboxex"><label class="floatleft"> Select All</label>
  
  <c:if test="${'admin@caerus.com' ne latestMessage.senderEmailId}">
  <img src="images/list_email_icn.png" alt="Reply" id="replyButton" title="Reply" class="table_actionbtn reply_btn">
  </c:if>
<img src="images/delete_icn.png"  alt="Delete" title="Delete" class="table_actionbtn delete_btn" onclick="return deleteMessage(this)">
</div>


<div id="messageDiv" class="replymessage">
<label class="floatleft">Message Text</label> <span class="star">*</span>
<textarea  tabindex="2" id="modalMessage" name="address"  style="width:600px; height:50px"></textarea>
<input type="button" value="Send" tabindex="21" class="add_participants floatright" onClick="messageCandidate()">
<span id="validationMessage" class="hideValidation"></span>
</div>

<c:forEach items="${messageInboxListMessageRelay}" var="message">
<c:choose>
<c:when test="${message.read eq false && message.receiverEmailId eq userid}">
<div id="${message.messageId}" class="borderbottom marginbot padding_bottom2 messageunread">
<input type="hidden" class="receivermailid" value="${message.receiverEmailId}"/>
	  <p class="date" style="float: right;margin-top: -32px;margin-right: 50px;">
              <fmt:parseDate value="${message.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOnDate"/>
                <fmt:formatDate type="date" value="${postedOnDate}" pattern="${dateFormat}"/></p>
			<%-- <p><c:out value="${message.messageId}"/></p> 
			  <p class="date">
              <fmt:parseDate value="${message.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOnDate"/>
                <fmt:formatDate type="date" value="${postedOnDate}" pattern="dd-MM-yyyy HH:mm:ss"/></p>--%>
                
                <%-- <c:choose>
                <c:when test="${'admin@caerus.com' eq latestMessage.senderEmailId}">
                <p  class="sendermail"> Photo Verification Failed</p>
                </c:when>
                <c:otherwise>
                <p  class="sendermail"><c:out value="${message.jobTitle}"/> at  <c:out value="${message.senderEmailId}"/> </p>
                </c:otherwise>
                </c:choose>
                
                <c:if test="${role=='CORPORATE'}">
                 <p><c:out value="${message.companyName}"/></p>
                </c:if> --%>
                 <p class="jobid"><c:set var="jobIdAndFirmId" value="${message.jobIdAndFirmId}"/></p>
                 <p class="msg description comment more"><c:out value="${message.message}"/></p>
</div>
</c:when>
<c:otherwise> 
<div id="${message.messageId}" class="borderbottom marginbot padding_bottom2 messageread">
<input type="hidden" class="receivermailid" value="${message.receiverEmailId}"/>
 <p class="date" style="float: right;margin-top: -32px;margin-right: 50px;">
              <fmt:parseDate value="${message.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOnDate"/>
                <fmt:formatDate type="date" value="${postedOnDate}" pattern="${dateFormat}"/></p>
			<%-- <p><c:out value="${message.messageId}"/></p>
			  <p class="date">
              <fmt:parseDate value="${message.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="postedOnDate"/>
                <fmt:formatDate type="date" value="${postedOnDate}" pattern="dd-MM-yyyy HH:mm:ss"/></p> --%>
               <%--  <c:choose>
                <c:when test="${'admin@caerus.com' eq latestMessage.senderEmailId}">
                <p  class="sendermail"> Photo Verification Failed</p>
                </c:when>
                <c:otherwise>
                <p  class="sendermail"><c:out value="${message.jobTitle}"/> at  <c:out value="${message.senderEmailId}"/> </p>
                </c:otherwise>
                </c:choose>
                <c:if test="${role=='CORPORATE'}">
                 <p><c:out value="${message.companyName}"/></p>
                </c:if> --%>
                 <p class="jobid"><c:set var="jobIdAndFirmId" value="${message.jobIdAndFirmId}"/></p>
                 <p class="msg description comment more"><c:out value="${message.message}"/></p>
</div>
</c:otherwise>
</c:choose> 
</c:forEach>
</div>
</form>
</div>
</li>
</c:forEach>

</c:otherwise>
</c:choose>
</ul>

</section>

      <div class="clear"></div>
      </div>
      <div class="bottomspace">&nbsp;</div>
  </div>
    <!--------------  Middle Section :: end -----------> 
    <!--------------  Common Footer Section :: start ----------->
   <%@ include file="includes/footer.jsp"%>
    <!--------------  Common Footer Section :: end -----------> 
    
      <!-- Post Job/Internship Modal Success Message -->
    
      
    <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="successMessageModal" >
  <div class="modal-backdrop fade in" style="z-index: 999;"></div> 
   <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button>
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
               
   </div>
   </div>
  </div> 
    
    <!-- Change Password Modal Ends -->
    
  </div>

</body>
</html>
