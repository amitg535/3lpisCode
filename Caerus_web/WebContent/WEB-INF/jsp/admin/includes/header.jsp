<%@ include file="/WEB-INF/jsp/include.jsp" %>  

<%

  			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				String authority = auth.getAuthorities().toString();
				int mid = authority.lastIndexOf("_");
			 	String role = authority.substring(mid+1, authority.length()-1);
				pageContext.setAttribute("role", role);
	%>
<header>
<c:choose>
<c:when test="${role == 'ADMIN'}">
 <div class="user_infobox">
    <div id="loginwrap">
      <div id="studentlogin" class="floatleft"> Welcome, <%--  <%= auth.getName() %> --%><%= session.getAttribute("username") %>
      [ <%= session.getAttribute("adminName") %>]
      </div>
      <div id="dropdown"><div class="icon_info"></div></div>  
      <%-- <div class="floatleft" id="employerslogin"><a href="<c:url value="/j_spring_security_logout" />">Sign Out</a></div> --%>
    </div>
    
    <div  id="mydiv" style="display:none;">
   <div class="popup">
     <div class="pop_title">Preferences</div>
<ul>
            <li><a href="<c:url value="/j_spring_security_logout" />" class="lnkclr"><span class="logout"></span>Sign Out</a></li>
            </ul>
            </div>
            </div>
            </div>
    <div id="logo"><a href="admin_manage_users.htm"><img src="images/logo.png" alt="Imploy - your carrer hi-five"></a></div>
     <%@ include file="top_navigation.jsp"%>
    
    </c:when>
    <c:otherwise>
    <div id="logo"><a href="admin_manage_users.htm"><img src="images/hlogo.png" alt="Imploy - your carrer hi-five"></a></div>
    </c:otherwise>
    </c:choose>
    <div class="clear"></div>
  </header>