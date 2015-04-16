<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Candidate Create New Profile</title>
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
  </head>
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
<!--     <header>
    <div id="logo"><a href="home.htm"><img src="images/logo.gif" alt="Caerus - your carrer hi-five"></a></div>
    <div id="loginwrap">
        <div id="studentlogin" class="floatleft">User:John Smith</div>
        <div class="floatleft" id="employerslogin"><a href="employers_registration_login.html" target="_self">Sign Out</a></div>
      </div>
    <div class="clear"></div>
  </header> -->
  
   <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner">
        <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
        <div class="clear"></div>
      </div> 

        <div class="clear"></div>
    <div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_manage_profile.htm">My Caerus</a> \ Create New Profile</div> -->
       <%--  <section id="leftsection" class="floatleft">
        <h3 class="nomargin">My Caerus</h3>
        <ul class="leftsectionlinks">
            <li><a href="#">Manage Profiles</a></li>
            <li>Create New Profile</li>
          </ul>
        <h3>Useful Links</h3>
        <ul class="leftsectionlinks">
            <li><a href="#">Background Check Services</a></li>
            <li><a href="#">Checklist Employee Contract</a></li>
            <li><a href="#">Hire Overseas Employees</a></li>
          </ul>
        <div id="newsletterwrap">
            <h3>Newsletter</h3>
            <form>
            <input name="" type="text" class="textbox">
            <input name="" type="button" value="Subscribe">
          </form>
          </div>
      </section> --%>
        <section id="rightwrap" class="floatleft">
        <div class="whitebackground">
        
        <h1 class="sectionheading">Create New Profile </h1>
        <div id="candidate_registration_wrap">
            <div class="form_wrap">
          
          
            <form:form class="stdform" action="candidate_create_profile.htm" modelAttribute="profileDetails" enctype="multipart/form-data" >
            
                <div class="fullwidth_form">
                <div class="par">
                    <label class="floatleft">Profile Name</label>
                    <span class="star">*</span>
                    <div class="clear"></div>
                    <span class="field">
                   <c:choose>
                   	<c:when test="${not empty editMode && editMode }">
                   		 <form:hidden path="editMode" value="true" />
                   		 <form:input path="profileName" readonly="true" cssClass="input-xxlarge" />
                   	</c:when>
                   <c:otherwise>
                 	     <form:hidden path="editMode" value="false" />
                   		 <form:input path="profileName" class="input-xxlarge" />
                   </c:otherwise>
                   </c:choose>
                   
                 	<form:errors path="profileName"  cssClass="validationnote"/>
                  </span> </div> 
                              
                <div class="par">
                <label class="floatleft">Profile Description</label>
                <span class="star">*</span> 
                <div class="clear"></div>
                	<form:textarea path="aboutYourSelf" rows="5" cols="80" class="span13 input-xxlarge"/>
              	 	<form:errors path="aboutYourSelf"  cssClass="validationnote"/>
              </div>
              
                <div class="par">
                <label class="floatleft">Primary Skills</label>
                <span class="star">*</span>
                <div class="clear"></div>
                <span class="field">
                	<form:input path="primarySkills"  id="tags" rows="2" class="input-xxlarge1"  />
                	<form:errors path="primarySkills"  cssClass="validationnote"/>
                  </span> </div>
                  
                <div class="par">
                <label>Secondary Skills</label>
                <div class="clear"></div>
                <span class="field">
                	<form:input path="secondarySkills" id="tags1" class="input-xxlarge1" />
                	<form:errors path="secondarySkills"  cssClass="validationnote"/>               
                  </span> </div>
                  
                <div class="par">
                <label class="floatleft">Upload Resume</label>
                <span class="star">*</span>
                 <div class="clear"></div>
                <span class="field">                
                  	<input type="file" class="uniform-file" name="file" />
                  	<form:errors path="file"  cssClass="validationnote"/>
                  </span>
                  	<c:out value="${profileDetails.resumeName }" />
                  
                   </div>
                  
                </div>
                
                <div class="doubletop_margin">
                <div class="buttonwrap">
                    <input name="saveBtn" type="submit" value="Save">
                    <input name="cancelBtn" type="button" value="Cancel" onClick="window.history.back()">
                  </div>
              </div>
              
              </form:form>
              
              
              
              
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
<script>Cufon.now();</script>
</body>
</html>