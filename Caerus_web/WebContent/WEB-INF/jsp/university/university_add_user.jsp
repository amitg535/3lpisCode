<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
<title>University Add User</title>
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

$(document).ready(function(){

	$("#addUserForm").submit(function(){

		if (document.getElementById('password').value != document.getElementById('confirmPassword').value) {
		    document.getElementById('confirmPassword').setCustomValidity('Passwords must match.');
		} else {
		    document.getElementById('confirmPassword').setCustomValidity('');
		}
		
		});
	
	
});

function getUserDetails(firstName, lastName, emailId, flag)
{
	$("#addUser").css('display','none');
	$("#updateUser").css('display','block');
	
	$("#userFirstName").val(firstName);
	$("#userLastName").val(lastName);
	$("#userEmailID").val(emailId);

	if(flag == "true")
	{
		$("#adminFlag").attr("checked", true);
		$("#adminFlag").parent().addClass("checked");
	}

	else
	{
		$("#adminFlag").attr("checked", false);
		$("#adminFlag").parent().removeClass("checked");
	}
	
}

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
     <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / <a href="#">Admin</a> / Add User</div> -->
      
      <section id="rightwrap" class="floatleft">
     
        <h1 class="sectionheading"> Add User </h1>
        <div class="clear"></div>
          <div class="whitebackground">
          <div class="doublebottom_margin" id="addUser"> 
	         <form:form id="addUserForm" class="stdform" action="university_add_user.htm"  method="post" modelAttribute="addUser" >
	             <table class="table table-bordered">
              <thead>
                <tr>
                  <th colspan="7"  class="table_leftalign">Add User
                  	<div class="floatright">
                  		<label class="error">Please  <img src="/images/check_icn.gif"/> the CheckBox to Provide Admin Rights</label>
                  	</div>
                  </th>  
                </tr>
              </thead>
              <tbody>
             
                <tr>
                  <td width="2%" class="table_centeralign"><form:checkbox path="adminFlag"/></td>
                  <td width="14%" class="table_leftalign"><form:input path="firstName" class="input-small1" placeholder="First Name" required="true" /></td>
                  <td width="14%" class="table_centeralign"><form:input path="lastName"  class="input-small1" placeholder="Last Name" required="true" /> </td>
                  <td width="14%" class="table_centeralign">
	                 <form:input path="emailID"  class="input-small1" placeholder="Email Id" required="true" />
	                 <form:errors path="emailID"></form:errors>
                  </td>
                 <td width="14%" class="table_centeralign"><form:password path="password"  id="password" class="input-small1" placeholder="Password" required="true"  onchange="form.confirmPassword.pattern = this.value;"/> </td>
           			<td width="14%" class="table_centeralign">
           				<form:password path="confirmPassword"  id="confirmPassword" class="input-small1" placeholder="Confirm Password"  required="true" />
           			 	<form:errors path="confirmPassword"></form:errors>
           			 </td>
	                  
                  <td class="table_centeralign">
            	<input type="submit" value="Add">      
                 </td>
                </tr>             
                  
              </tbody>
            </table>
	        </form:form>
        </div> 
        <div class="clear"></div>
        </div>
         <div class="whitebackground">
          <div class="doublebottom_margin" id="updateUser" style="display:none;"> 
	         <form:form id="addUserForm" class="stdform" action="university_update_user.htm"  method="post" modelAttribute="addUser" >
	             <table class="table table-bordered">
              <thead>
                <tr>
                  <th colspan="7"  class="table_leftalign">Update User
                  	<div class="floatright">
                  		<label class="error">Please  <img src="/images/check_icn.gif"/> the CheckBox to Provide Admin Rights</label>
                  	</div>
                  </th>  
                </tr>
              </thead>
              <tbody>
             
                <tr>
                  <td width="2%" class="table_centeralign"><form:checkbox path="adminFlag" id="adminFlag" /></td>
                  <td width="14%" class="table_leftalign"><form:input path="firstName" class="input-small1" required="true" id="userFirstName"/></td>
                  <td width="14%" class="table_centeralign"><form:input path="lastName"  class="input-small1" required="true" id="userLastName" /> </td>
                  <td width="14%" class="table_centeralign">
               		<form:input path="emailID"  class="input-small1" required="true" readonly="true" id="userEmailID"/>
               		<form:errors path="emailID"></form:errors>     
      				</td>
                  <td class="table_centeralign">
                   <input type="submit" value="Update">
                 </td>
                </tr>             
                  
              </tbody>
            </table>
	        </form:form>
        </div> 
        
        <div class="clear"></div>
        
        <span class="errormsg" id="errorMsgSpan">
        </span>
          <div class="clear"></div>
         <div id="candidate_registration_wrap">
          <div class="par">
            <table class="table table-bordered" >
              <thead>
                <tr>
                  <th width="25%" class="table_leftalign">First Name</th>
                  <th width="25%" class="table_centeralign">Last Name</th>
                  <th width="25%" class="table_centeralign">Email Id</th>
                  <th width="25%" class="table_centeralign">Is Admin</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${userDetailsList}" var="userDetails">
                <tr>
                  <td class="table_leftalign"><a onclick="getUserDetails('${userDetails.firstName}','${userDetails.lastName}','${userDetails.userName}','${userDetails.adminFlag}')"><c:out value="${userDetails.firstName}"/></a></td>
                  <td class="table_centeralign">  <c:out value="${userDetails.lastName}"/></td>
                  <td class="table_centeralign"><c:out value="${userDetails.userName}"/></td> 
                  <td class="table_centeralign"> <c:out value="${userDetails.adminFlag}"/></td>  
                </tr>             
             </c:forEach>           
              </tbody>
            </table>
          </div>
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