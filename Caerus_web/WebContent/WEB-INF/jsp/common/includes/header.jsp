<%@ include file="/WEB-INF/jsp/include.jsp"%>

<%  			Authentication headAuth = SecurityContextHolder.getContext().getAuthentication();
				String headAuthority = headAuth.getAuthorities().toString();
				int headMid = headAuthority.lastIndexOf("_");
			 	String headRole =headAuthority.substring(headMid+1, headAuthority.length()-1);
				pageContext.setAttribute("headRole", headRole);
	
	%>
	 <style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal{
	width:820px !important;
}
  .tbox{z-index:1000 !important;}
  </style>

<script> 

 		$().ready(function(){
			 	 $.ajax({
			    	  type : "GET",
			    	  url:'get_username.json',
			    	  cache:false,
			    	  async: false,
			    	  success: function(data){
				    	 
			    		  //alert("Success"+JSON.stringify(data)); 
			    		 
			    		// $("#studentlogin").html(data);
				    	  },
			    		 
			    	  error: function(xhr,error)
			    	  {
			    	 	// alert("Something Went Wrong");
			    	 	  
			    	  }
			    	 }); 
			 	
			});
				 </script>
	

<script type="text/javascript" src="js/analytics.js"></script>
<script type="text/javascript" src="js/feedback_and_support.js"></script>
<script type="text/javascript" src="js/tinybox_js.js"></script>
     <script type="text/javascript" src="js/uservoice.js"></script>
     <link rel="stylesheet" type="text/css" href="css/tinyboxstyle.css" />
<script type="text/javascript">
var viewAllFlag;
function clickLink()
{
	viewAllFlag = true;
	modalClicked();
	
}
function modalClicked()
{
	
	$(".viewAllProfileViews").click(function(){
		
		viewAllFlag = true;
		modalClicked();
		
	});
	 
	  $("#myModal").dialog({
	      
	   //modal: true,
	     //  close: false
	    });
  
	  if(viewAllFlag == true)
		{
	    	var url = "candidate_viewed_by_companies.json?viewAll=viewAll";
	    	$(".viewAllProfileViews").hide();
	    	$("#noProfileViews").hide();
		}
	    else
		{
	 		var url = "candidate_viewed_by_companies.json";
	 		$(".viewAllProfileViews").show();
		} 
	    
	    $.ajax({
	    	  type : "GET",
	    	  url:url,
	    	  cache:false,
	    	  
	    	  success: function(data){
	    		  $("#tableBodyEmployerDetails").empty(); 
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
					    	    	    	   
					    	   $("#tableBodyEmployerDetails").append('<tr><td>'+employerName+'</td><td>'+current_date + " " + month + " " + current_year+" at "+current_hours+
					    			   ":"+current_minutes+'</td></tr>');
					    	  
					    	   });
						
					}
			    	  
		    		  
		    		  if(data.exception != null)
		    		  {
		    			  $(".emp_scheduleevent_table").hide();
				    	  
				    	  $(".viewAllProfileViews").empty();
				    	  $("#noProfileViews").show();
				    	   $("#noProfileViews").empty().append("You have received no profile views in the last 10 days.<a onclick='clickLink()'>View past profile views</a>");
		    		  }
		    			
		    		  if(data.exceptionOccured == true)
			    	   {
				    	   $(".emp_scheduleevent_table").hide();
				    	  
				    	    $(".viewAllProfileViews").empty();
				    	    $("#noProfileViews").show();
				    	   $("#noProfileViews").empty().append('You have received no profile views in recent days.<a class="viewAllProfileViews" href="candidate_portfolio.htm">Update your profile now</a>');
				    	   
			    	   }
		    		  viewAllFlag = null;
		    	  },
	    		 
	    	  error: function(xhr,error)
	    	  {
	    	 	 alert("Something Went Wrong");
	    	  }
	    	 });
	 
	
	 
}
</script>

	<c:choose>
	   <c:when test="${headRole=='STUDENT'}">
	   <header>
	 
<a href="javascript:"  style="z-index: 1000;position: fixed;padding: 5px;text-decoration: underline;color: #fff;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfaction Survey</span></a>
	   <div class="user_infobox">
	          <div class="floatright iconwrap messagecount" style="margin-right: 30px;"> 
  <a href="<c:url value="message_inbox.htm"/>"><img src="images/message_alert.png" alt="Message Inbox"></a>
               <c:set var="newMessageCount" value= "${sessionScope.newMessageCount}" />
               
   <c:if test="${newMessageCount !=0}">
                <div class="top_notifications top_notifications_redbg" style="height: 20px;width: 20px;padding: 0 0 0 0;color: white;right: 23px;top: 3px;"><span><c:out value="${newMessageCount}" /></span></div></c:if>
   <c:if test="${newMessageCount ==0}">
                <div class="top_notifications top_notifications_redbg" style="height: 20px;width: 20px;padding: 0 0 0 0;color: white;right: 23px;top: 3px;"><span>0</span></div></c:if>
              
              
              </div>
			<div id="loginwrap">
			<div id="studentlogin" class="floatleft"> Welcome,<%--  <%= auth.getName() %> --%><%=session.getAttribute("username") %></div>  
			 <div id="dropdown"><div class="icon_info"></div></div>  
				<%-- <div id="studentlogin" class="floatleft">
					Welcome,
					 <%= auth.getName() %><%=session.getAttribute("username")%>
				</div>
				 <div id="dropdown"><div class="icon_info"></div></div> 
				</div> --%>
				<%-- <div class="floatleft" id="employerslogin">
				</div> --%>
				
				<div  id="mydiv" style="display:none;">
   <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a class="lnkclr mailsetting"  href="candidate_settings.htm"><span class="mail_seetingico"></span>Settings</a>
            <!-- <div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"  tabindex="-3" class="modal hide fade in" id="mailsetting">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close closeclass" type="button">x</button>
				<h3 id="myModalLabel">Mail Settings</h3>
			</div>
			<div class="modal-body">
				<h5 class="bluehead">Leave it upon us to Keep you updated with the latest on job postings &amp; events.</h5>
				
				
				<form class="stdform">
				<div id="success_message" class="floatleft alertmessage" style="display:none;width:93%;">
          <div id="warning_image"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
          <p style="margin-top:0;">Your Mail Settings have been updated successfully!!</p></div>
				
				<div id="error_message" style="display:none;" class="alertmessage"><div id="warning_image"><img src="images/warningerror_icn.png" alt="Verification Successful" title="Verification Successful"></div>  </div>
				<div class="par"> <input type="radio" name="maiSettingsOptions" id="subscribe" value="subscribe" class="subscriberadio" >I want to subscribe for the E-mail Updates </div>
  
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
			<div class="modal-footer">
			
				<button  class="btn" id="applymailsettings">Apply Mail Settings</button>
				<button data-dismiss="modal" class="btn closeclass">Close</button>
			</div>
		</div> -->
            </li>
            <li><a href="user_change_password.htm" class="lnkclr"><span class="change_password"></span>Change Password</a></li>
            <li><a class="lnkclr"  data-toggle="modal" onclick="modalClicked()" href="#myModal" id="myModalClick"><span class="user_profile"></span>Profile Views</a>
            <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="myModal">
		
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Profile Viewed By Companies</h3>
			</div>

			<div class="modal-body">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id = "grid">
				<thead>
                    <tr>
                        <th width="60%" align="left">Company Names</th>
                        <th width="40%" align="left">Viewed On</th>
                      </tr> 
                      
                </thead>
                <tbody id="tableBodyEmployerDetails">
                
                
                </tbody>   
              </table>
              <div class="floatright viewmore viewAllProfileViews"><a>View past profile views</a></div>
              <div id="noProfileViews"></div>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn">Close</button>
			</div>
		</div>
            
            </li>
            <!-- <li><a href="candidate_applied_jobs.htm" class="lnkclr"><span class="apply_jobs"></span>Applied Jobs</a></li>
            <li><a href="candidate_savedsearch.htm" class="lnkclr"><span class="saved_search"></span>Saved Searches</a></li>
            <li><a href="candidate_saved_jobs.htm" class="lnkclr"><span class="saved_jobs"></span>Saved Jobs</a></li> -->
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="logout"></span>Sign Out</a></li>
          </ul>
</div></div>
</div>
				<%-- <div class="floatleft" id="employerslogin">
					<a href="<c:url value="/j_spring_security_logout" />">Sign Out</a>
				</div> --%>
			

			
         <%-- <div  id="mydiv" style="display:none;">
   <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a href="#" class="lnkclr"><span class="mail_seetingico"></span>Mail Settings</a></li>
            <li><a href="user_change_password.htm" class="lnkclr"><span class="change_password"></span>Change Password</a></li>
            <li><a class="lnkclr"  data-toggle="modal" onclick="modalClicked()" href="#myModal" id="myModalClick"><span class="user_profile"></span>Profile Views</a>
            <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="myModal">
		
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Profile Viewed By Companies</h3>
			</div>
			<div class="modal-body">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id = "grid">
				<thead>
                    <tr>
                        <th width="60%" align="left">Company Names</th>
                        <th width="40%" align="left">Viewed On</th>
                      </tr> 
                      
                </thead>
                <tbody id="tableBodyEmployerDetails">
                
                
                </tbody>   
              </table>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn">Close</button>
			</div>
		</div>
            
            </li>
            <!-- <li><a href="candidate_applied_jobs.htm" class="lnkclr"><span class="apply_jobs"></span>Applied Jobs</a></li>
            <li><a href="candidate_savedsearch.htm" class="lnkclr"><span class="saved_search"></span>Saved Searches</a></li>
            <li><a href="candidate_saved_jobs.htm" class="lnkclr"><span class="saved_jobs"></span>Saved Jobs</a></li> -->
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="logout"></span>Sign Out</a></li>
          </ul>
</div></div> --%>
			</div>
			<div id="logo">
				<a href="candidate_dashboard.htm"><img src="images/logo.png"
					alt="Imploy - your carrer hi-five"></a>
			</div>

<%@ include file="../../candidate/includes/topnavigation.jsp"%>


 
  
</header>
		</c:when>
		
		<c:when test="${headRole=='CORPORATE'}">
		<header>
		
<a href="javascript:"  style="display:scroll;z-index:1000;position:fixed;top:10px;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfactory Survey</span></a>
		<div class="user_infobox">
		       <div class="floatright iconwrap messagecount" style="margin-right: 30px;"> 
  <a href="<c:url value="message_inbox.htm"/>"><img src="images/message_alert.png" alt="Message Inbox"></a>
               <c:set var="newMessageCount" value= "${sessionScope.newMessageCount}" />
               
   <c:if test="${newMessageCount !=0}">
                <div class="top_notifications top_notifications_redbg" style="height: 20px;width: 20px;padding: 0 0 0 0;color: white;right: 23px;top: 3px;"><span><c:out value="${newMessageCount}" /></span></div></c:if>
   <c:if test="${newMessageCount ==0}">
                <div class="top_notifications top_notifications_redbg" style="height: 20px;width: 20px;padding: 0 0 0 0;color: white;right: 23px;top: 3px;"><span>0</span></div></c:if>
              
              
              </div>
			<div id="loginwrap">
				<div id="studentlogin" class="floatleft">
					Welcome,<%=session.getAttribute("username") %>[<%=session.getAttribute("compName") %>]
					<%--  <%= auth.getName() %>[<%=role.charAt(0)+role.substring(1).toLowerCase()%>] --%>
				</div>
				 <div id="dropdown"><div class="icon_info"></div></div>
				<%-- <div class="floatleft" id="employerslogin">
					<a href="<c:url value="/j_spring_security_logout" />">Sign Out</a>
				</div> --%>
			</div>
			<div  id="mydiv" style="display:none;">
     <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a href="#" class="lnkclr"><span class="mail_seetingico"></span>Mail Settings</a></li>
            <li><a href="#" class="lnkclr"><span class="change_password"></span>Change Password</a></li>
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="saved_jobs"></span>Sign Out</a></li>
          </ul>
</div></div>
			</div>
			<div id="logo">
				<a href="<c:url value="employer_dashboard.htm" />"><img
					src="images/logo.png" alt="Imploy - your carrer hi-five"></a>
			</div>
			<%@ include file="../../employer/includes/top_navigation.jsp"%>
			
			
			<div class="clear"></div>
			</header>
		</c:when>
		<c:when test="${headRole=='UNIVERSITY'}">
		<header>
		
<a href="javascript:"  style="display:scroll;z-index:1000;position:fixed;top:10px;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfactory Survey</span></a>
		<div class="user_infobox">
			<div id="loginwrap">
				<div id="studentlogin" class="floatleft">
					Welcome,
					<%--  <%= auth.getName() %> --%><%= session.getAttribute("username") %>
					[
					<%= session.getAttribute("univName") %>]
				</div>
				 <div id="dropdown"><div class="icon_info"></div></div> 
				<%-- <div class="floatleft" id="employerslogin">
					<a href="<c:url value="/j_spring_security_logout" />">Sign Out</a>
				</div> --%>
			</div>
			
			 <div  id="mydiv" style="display:none;">
     <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a href="#" class="lnkclr"><span class="mail_seetingico"></span>Mail Settings</a></li>
            <li><a href="#" class="lnkclr"><span class="change_password"></span>Change Password</a></li>
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="saved_jobs"></span>Sign Out</a></li>
          </ul>
</div></div>
			
			</div>
			<div id="logo">
				<a href="university_dashboard.htm"><img src="images/logo.png"
					alt="Imploy - your carrer hi-five"></a>
			</div>
			<%@ include file="../../university/includes/top_navigation.jsp"%>
			
			

			<div class="clear"></div>
			</header>
		</c:when>
		<c:otherwise>
		<header>
		 <div class="user_infobox">&nbsp;</div>
		 <a href="javascript:"  style="display:scroll;z-index:1000;position:fixed;top:10px;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfactory Survey</span></a>
			<div id="logo">
				<a href="home.htm"><img src="images/logo.png"
					alt="Imploy - your carrer hi-five"></a>
			</div>
			 
	<div class="clear"></div>
	</header>
		</c:otherwise>
	</c:choose>