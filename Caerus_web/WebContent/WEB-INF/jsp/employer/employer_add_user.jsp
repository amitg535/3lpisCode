<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
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

$().ready(function(){

	$("#addUserForm").submit(function(){

		if (document.getElementById('password').value != document.getElementById('confirmPassword').value) {
		    document.getElementById('confirmPassword').setCustomValidity('Passwords must match.');
		} else {
		    document.getElementById('confirmPassword').setCustomValidity('');
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
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
    
    <div id="innersection">
     <!--  <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="#">Admin</a> / Add User</div> -->
      
      <section id="rightwrap" class="floatleft">
      <div class="">
        <h1 class="sectionheading"> Add User </h1>
        <div class="clear"></div>
         <div class="doublebottom_margin whitebackground"> 
	         <form:form id="addUserForm" class="stdform" action="employer_add_user.htm"  method="post" modelAttribute="addUser" >
	             <table class="table table-bordered">
              <thead>
                <tr>
                  <th colspan="7"  class="table_leftalign">Add User
                  	<div class="floatright">
                  		<label class="error">Please  <img src="/images/check_icn.gif"/> the CheckBox to Provide Admin Rights</label>
                  	</div>
                  </th>
                  <!-- <th colspan="4" class="table_leftalign"> Please Check the CheckBox to Provide Admin Rights</th> -->
                  <!-- <th width="14%" class="table_centeralign">Last Name</th>
                  <th width="15%" class="table_centeralign">Email Id</th>
                  <th width="14%" class="table_centeralign">Is Admin</th>
                  <th width="14%" class="table_centeralign">Action</th> -->
                </tr>
              </thead>
              <tbody>
             
                <tr>
                  <td width="2%" class="table_centeralign"><form:checkbox path="adminFlag"  /></td>
                  <td width="14%" class="table_leftalign"><form:input path="firstName" class="input-small1" placeholder="First Name" required="true" /></td>
                  <td width="14%" class="table_centeralign"><form:input path="lastName"  class="input-small1" placeholder="Last Name" required="true" /> </td>
                  <td width="14%" class="table_centeralign">
	                  <c:choose>
	                  	<c:when test="${not empty editMode && editMode == true}">
	                  		<input type="hidden" value="true" name="editMode" id="editMode">
	                  		<form:input path="emailId"  class="input-small1" placeholder="Email Id" readonly="true"/>
	                  	</c:when>
	                  	<c:otherwise>
	                  		<form:input path="emailId"  class="input-small1" placeholder="Email Id" required="true"  />
	                  		<form:errors path="emailId"></form:errors>
	                  	</c:otherwise>
	                  </c:choose>
                  </td>
                    <c:choose>
	                  	<c:when test="${not empty editMode && editMode == true}"></c:when>
	                  	<c:otherwise>
	                  		<td width="14%" class="table_centeralign"><form:password path="password"  id="password" class="input-small1" placeholder="Password" required="true"  onchange="form.confirmPassword.pattern = this.value;"/> </td>
                   			<td width="14%" class="table_centeralign">
                   				<form:password path="confirmPassword"  id="confirmPassword" class="input-small1" placeholder="Confirm Password"  required="true" />
                   			 	<form:errors path="confirmPassword"></form:errors>
                   			 </td>
	                  	
	                  	</c:otherwise>
	                  </c:choose>
                 
                  <td class="table_centeralign">
                    <c:choose>
	                  	<c:when test="${not empty editMode && editMode == true}">
                  				<input type="submit" value="Update">
                  		</c:when>
	                  	<c:otherwise>
	                  		<input type="submit" value="Add">
	                  	</c:otherwise>
                  </c:choose>
                 </td>
                </tr>             
                  
              </tbody>
            </table>
	        </form:form>
        </div>
        </div>
        <div class="clear"></div>
        <span class="errormsg" id="errorMsgSpan">
        </span>
          <div class="clear"></div>
        <div id="candidate_registration_wrap" class="whitebackground">
          <div class="par">
            <table class="table table-bordered" id="dyntable_columntwo">
              <thead>
                <tr>
                  <th width="45%" class="table_leftalign">First Name</th>
                  <th width="14%" class="table_centeralign">Last Name</th>
                  <th width="15%" class="table_centeralign">Email Id</th>
                  <th width="14%" class="table_centeralign">Is Admin</th>
                  <th width="12%" class="table_centeralign nosort">Actions</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${employees}" var="employee">
                <tr>
                  <td class="table_leftalign"><a href="employer_user_details.htm?emailId=<c:out value="${employee.userName}"/>"><c:out value="${employee.firstName}"/></a></td>
                  <td class="table_centeralign">  <c:out value="${employee.lastName}"/></td>
                  <td class="table_centeralign"><c:out value="${employee.userName}"/></td>
                  <td class="table_centeralign"> <c:out value="${employee.adminFlag}"/></td>
                  <c:choose>
                  	<c:when test="${! employee.enabled}">
                  	  <td class="table_centeralign">
                  	  <a href="employer_enable_user.htm?emailId=<c:out value="${employee.userName}"/>">
                  	 	<img src="images/check_icn.gif" class="table_actionbtn"  title="Enable/Restore" alt="Confirm">
                  	 	</a>
                  	  </td> 
                  		
                  	</c:when>
                  	<c:otherwise>
                  	 <td class="table_centeralign"><a href="employer_delete_user.htm?emailId=<c:out value="${employee.userName}"/>"><img src="images/small_delete_icn.png" alt="Cancel" title="Delete" class="table_actionbtn"></a></td>
                  	</c:otherwise>
                  </c:choose>
                  
                 
                </tr>             
             </c:forEach>           
              </tbody>
            </table>
          </div>
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
<div id="mask"></div>
</body>
</html>