<%@ include file="/WEB-INF/jsp/include.jsp" %>  
<% 
 	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	String authority = auth.getAuthorities().toString();
	int mid = authority.lastIndexOf("_");
 	String role = authority.substring(mid+1, authority.length()-1);
 	pageContext.setAttribute("role", role);
 	//role.substring(1, role.length()).toLowerCase();
 	
 
%>
<style>
  .tbox{z-index:1000 !important;}
  </style>
   <link rel="stylesheet" type="text/css" href="css/tinyboxstyle.css" />
<header>

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
    
<c:choose>
<c:when test="${role == 'CORPORATE'}"> 
 
<a href="javascript:"  style="z-index: 1000;position: fixed;padding: 5px;text-decoration: underline;color: #fff;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfaction Survey</span></a>   
            
              <!-- <div class="floatleft textwrap">Inbox </div> -->
              
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
   <%-- <div id="logo"><a href="<c:url value="employer_dashboard.htm" />"><img src="images/logo.png" alt="3lpis - your carrer hi-five"></a></div> --%>
      <div id="studentlogin" class="floatleft"> Welcome,<%=session.getAttribute("username") %>[<%=session.getAttribute("compName") %>]
      <%--  <%= auth.getName() %>[<%=role.charAt(0)+role.substring(1).toLowerCase()%>] --%></div>
      <div id="dropdown"><div class="icon_info"></div></div>
     <%--  <div class="floatleft" id="employerslogin"><a href="<c:url value="/j_spring_security_logout" />">Sign Out</a></div> --%>
    </div>
        <div  id="mydiv" style="display:none;">
     <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a href="#" class="lnkclr"><span class="mail_seetingico"></span>Mail Settings</a></li>
            <li><a href="user_change_password.htm" class="lnkclr"><span class="change_password"></span>Change Password</a></li>
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="saved_jobs"></span>Sign Out</a></li>
          </ul>
</div></div></div>
  <div id="logo"><a href="employer_dashboard.htm"><img src="images/logo.png" alt="Imploy - your carrer hi-five"></a></div>
  	
     <%@ include file="top_navigation.jsp"%>
     


  </c:when>
  <c:otherwise>
  <div class="user_infobox">&nbsp;</div>
  <a href="javascript:"  style="display:scroll;z-index:1000;position:fixed;top:10px;"  onclick="var tinybox_width = window.innerWidth || document.documentElement.clientWidth; tinybox_width=Math.round(tinybox_width*0.6);TINY.box.show({iframe:'http://www.123contactform.com/form-1161341/Customer-Satisfaction-Survey',boxid:'frameless',width:tinybox_width,height:500,fixed:false,maskid:'bluemask',maskopacity:40})">
<!-- <img border="0" src="images/feedback_small.png" > --><span style="color:#fff;">Satisfactory Survey</span></a>
    <div id="logo"><a href="home.htm"><img src="images/logo.png" alt="Imploy - your carrer hi-five"></a></div>
  </c:otherwise>
    </c:choose>
    <div class="clear"></div>
  </header>
  
  
  