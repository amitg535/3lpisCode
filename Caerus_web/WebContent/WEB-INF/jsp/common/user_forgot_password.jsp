<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Imploy-Forgot Password</title>
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

<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
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

<style>
.errorblock {
	color: #ff0000;	
	border: 2px solid #ff0000;
	padding: 6px;
	margin: 6px;	
}
</style>

</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <header>
    <div id="logo"><a href="home.htm"><img src="images/logo.png" alt="Imploy - your carrer hi-five"></a></div>
    <div class="clear"></div>
  </header>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
    
    <div id="innersection">
           <div id="breadcrums_wrap">You are here: <a href="home.htm">Home</a> / Forgot Password</div>
           
            <c:if test="${not empty success}">
		
		<div id="success_message">
          <div id="warning_image"><img title="Verification Successful" alt="Verification Successful" src="images/success_icn.gif"></div>
          <h2 class="error_message_heading">
          <cufon class="cufon cufon-canvas" alt="Verification " style="width: 112px; height: 24px;">
          <!-- <canvas width="129" height="24" style="width: 129px; height: 24px; top: 0px; left: -1px;"></canvas> -->
          <cufontext>Verification Successful</cufontext></cufon>
          <!-- <cufon class="cufon cufon-canvas" alt="Successful" style="width: 99px; height: 24px;">
          <canvas width="116" height="24" style="width: 116px; height: 24px; top: 0px; left: -1px;"></canvas>
          <cufontext>Successful</cufontext></cufon> --></h2>
          <div class="clear"></div>
          <p>New password has been sent to your registered Email Id</p>
        </div>
		
	</c:if>
           
      <section id="rightwrap" class="floatleft">
        <div id="candidatelogin_notice">
          <div id="warning_image"><img src="images/warning_icn.png" alt="Warning" title="Warning"></div>
          <h2 class="error_message_heading">Important Notice</h2>
          <span class="error_message_span">- Keep your account safe.</span>
          <div class="clear"></div>
          <p class="error_message_para"> Imploy.me never sends any email asking for your username and password.
            If you receive an email requesting your account details, please do not respond or click on
            any link in those emails. </p>
          <p class="error_message_para">Imploy.me never threatens to close your account.</p>
          <p class="error_message_para">In case of any queries or to report any fraud, please contact <a href="mailto:support@imploy.me?Subject=Hi">support@imploy.me</a></p>
        </div>
        <h1 class="sectionheading">Forgot Password</h1>
        
        
            <c:if test="${not empty error}">
		<div class="errorblock">
		Please activate your account!
		</div>
	</c:if>
	
	<c:if test="${not empty unregistered}">
		<div class="errorblock">
		Please register with Imploy.me
		</div>
	</c:if>
            
        <div id="candidate_login_wrap">
          <form:form class="stdform" action="" method="post" modelAttribute="loginManagementCom">
            <div class="leftsection_form_warning">
              <fieldset>
                <div class="par">
                  <label class="floatleft">Email Address </label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                   <form:input path="emailId" class="input-medium" required="required"/>
                       <form:errors path="emailId"  cssClass="validationnote"/>
                  
                  </span> </div>
                 <div class="par">
                  <input name="" type="submit" value="Submit">
                </div>
               
              </fieldset>
            </div>
          </form:form>
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