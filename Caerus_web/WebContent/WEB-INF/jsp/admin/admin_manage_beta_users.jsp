<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Admin Manage Beta Users</title>
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
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
   
    <%@ include file="includes/header.jsp"%>
    
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
  
    <div id="innersection">
       <!--  <div id="breadcrums_wrap">You are here: Manage Beta Users</div> -->
       
        <section id="rightwrap" class="floatleft">
         
       <div class="whitebackground">
        <h1 class="sectionheading">Manage Beta Users</h1>
 		 <c:if	test="${not empty error}">
			<div class="errorblock">User Already exists</div>
		</c:if>
 		
 		<table class="table table-bordered" id="dyntable1">
                <thead>
                <tr>
                    <th width="20%" class="table_leftalign">Email Id</th>
                    <th width="20%" class="table_leftalign">Intended Role</th>
                    <th width="20%" class="table_centertalign">Status</th>
                    <th width="20%" class="table_centertalign">Time Registered</th>
                    <th width="20%" class="table_leftalign">Action</th>
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${betaUserList}" var="betaUser">
                <tr>
                    <td class="table_centertalign"><c:out value="${betaUser.emailId}" /></td>
                    <td class="table_centertalign"><c:out value="${betaUser.role}"/></td>
                    <td class="table_centertalign" align="center"><c:out value="${betaUser.status}"/></td>
                    <td class="table_centertalign" align="center"> 
	                    <fmt:formatDate var="formattedDate" pattern="dd MMM yyyy HH:mm" value="${betaUser.registeredTime}" />
	                  <%--   <c:out value="${betaUser.registeredTime.toString()}"/> --%>
	                    <c:out value="${ formattedDate}" />
                    </td>
                    <c:choose>
                    <c:when test="${betaUser.status eq 'Pending'}">
                    <td class="table_centertalign" align="center">
			     	 	<a href="admin_confirm_beta_user.htm?emailId=<c:out value="${betaUser.emailId}" />&role=<c:out value="${betaUser.role}"/>"><img src="images/check_icn.gif" class="table_actionbtn" alt="Confirm">
			     	 	</a> 
			     	 	<%-- <a href="admin_delete_beta_user.htm?emailId=<c:out value="${betaUser.emailId}"/>"><img src="images/delete_icn.png" class="table_actionbtn" alt="Delete">
			     	 	</a> 
			     	 	<a href="#"><img src="images/delete_icn.png" class="table_actionbtn" alt="Delete">--%>
			     	 	<a href="admin_resendmail_beta_user.htm?emailId=<c:out value="${betaUser.emailId}" />"><img src="images/mail_icn.png" class="table_actionbtn" alt="Resend" title="Resend E-mail">
			     	 	</a>
			     	</td>
                    </c:when>
                    <c:when test="${betaUser.status eq 'Confirmed'}">
                    <td class="table_centertalign" align="center">
			     	 	<%-- <a href="admin_delete_beta_user.htm?emailId=<c:out value="${betaUser.emailId}"/>"><img src="images/delete_icn.png" class="table_actionbtn" alt="Delete">
			     	 	</a> 
			     	 	<a href="#"><img src="images/delete_icn.png" class="table_actionbtn" alt="Delete">--%> 
			     	 	<a href="admin_resendmail_beta_user.htm?emailId=<c:out value="${betaUser.emailId}" />"><img src="images/mail_icn.png" class="table_actionbtn" alt="Resend" title="Resend E-mail">
			     	 	</a>
			     	</td>
                    </c:when>
                    <%-- <c:otherwise>
                    <td class="table_centertalign" align="center">
			     	 	<a href="admin_undo_delete_action.htm?emailId=<c:out value="${betaUser.emailId}"/>"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo">
			     	 	</a> 
			     	 	<a href="#"><img src="images/undo_icn.png" class="table_actionbtn" alt="Undo">
			     	 	</a>
			     	</td>
                    </c:otherwise> --%>
                    </c:choose>  
                </tr>
        	  </c:forEach>
              </tbody>
              </table>
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