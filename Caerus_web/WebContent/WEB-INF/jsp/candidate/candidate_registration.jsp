<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/WEB-INF/jsp/include.jsp"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Registration</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/style.css" type="text/css" />
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

<style>
.errorblock {
	color: #ff0000;
}
</style>

<script type="text/javascript">
function clearClassFunction()
{
	$("#userName").removeClass("redborder");
	$("#password").removeClass("redborder");
	$(".loginpan").effect().stop();
}
</script>

<script type="text/javascript">
    $(document).ready(function () {
    	$("#datepicker").datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: "-30:+0"
		});
   
    	});
</script>


<body>
<div id="wrap"> 


  <!--------------  Header Section :: start ----------->
  <header>
   <div class="user_infobox">&nbsp;</div>
    <div id="logo"><a href="home.htm"><img src="images/logo.png" alt="Caerus - your carrer hi-five"></a></div>
    <div id="loginwrap">
    <div class="floatleft regiterationloginpan">
				<form action="<c:url value='j_spring_security_check' />"
					method="post" id="submit" class="stdform">
					<input type="email" name="username" placeholder="Email ID" required="required" id="username" style="width:150px;" onfocus="clearClassFunction()" tabindex="1"/> 
					<input type="password" name="password" placeholder="Password" required="required" id="password" maxlength="20" min="8" style="width:150px;" onfocus="clearClassFunction()" tabindex="2"/> 
					<input type="submit" id="lgnBtn" value="Login" tabindex="3" />
					
					<br><a href="user_forgot_password.htm" class="frgtpass" style="float:right; color:#fff;" tabindex="4">Forgot
						password ?</a>
					<c:if test="${not empty error}">
						<c:set var="securityMsg"
							value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" />
					</c:if>
					<script type="text/javascript">
						var abc = "${securityMsg}";
						if (abc.length > 0) {
							$("#userName").addClass("redborder");
							$("#password").addClass("redborder");
							$(".loginpan").effect("bounce", {
								times : 3,
								direction : "up"
							}, 1300);
						}
					</script>
				</form>
				</div>
			
	 
    </div>
    <div class="clear"></div>
  </header>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div class="candidate_registration_banner_new">
    	<div class="innerbanner"><img src="images/banner.png" alt="" title="" align="bottom" /></div>
        <div class="loginpan">
        <div class="quick_registration_wrap">
      
       	  <h3>Quick Registration</h3>
       	  
       	    <c:if test="${not empty success}">
          <span class="success" style="color:#0B99B3;">Successfully registered <a href="home.htm">click here to login</a>  </span>
        </c:if>
       	  
               <form:form class="stdform" method="post" modelAttribute="studentCom">
               <div class="fullwidth_form">
                <div class="par">
                <div class="floatleft" style="margin-right:20px;">
                <label class="floatleft">First Name</label>
                <span class="star">*</span>
                <span class="field">
               <form:input path="firstName" class="input-small1" tabindex="5"/>
                 <form:errors path="firstName"  cssClass="validationnote" />
              </span>
              </div> 
              <div class="floatleft" style="margin-right:20px;">
                <label class="floatleft">Last Name</label>
                <span class="star">*</span>
                <span class="field">
              <form:input path="lastName" class="input-small1" tabindex="6"/>
                 <form:errors path="lastName" cssClass="validationnote" />
              </span>
</div>
              
             <div class="floatleft" style="margin-right:20px;">
                <label class="floatleft">Email ID</label>
                <span class="star">*</span>
                <span class="field">
              <form:input path="emailID" class="input-small1" tabindex="7" />
                 <form:errors path="emailID" cssClass="validationnote" />
                 <c:if test="${not empty registered}">
                 <div class="errorblock">You are already Registered with Imploy.me!</div>
                 </c:if>              
              </span> 
              </div>
             
               <div class="floatleft" style="margin-right:20px;">
                <label class="floatleft">Password</label>
                <span class="star">*</span>
                <span class="field">
              <form:input path="password" class="input-small1" type="Password" maxlength="20" tabindex="8" onchange="form.confirmPassword.pattern = this.value;"/>
              <form:errors  path="password" cssClass="validationnote" style="font-size:10px;"/>
                 <input type="hidden" name="authority" value="ROLE_STUDENT">     
              </span> 
              </div>
              <div class="floatleft" style="margin-right:20px">
              <label class="floatleft">Re-type Password</label>
              <span class="star">*</span>
               <span class="field">
              <form:input path="confirmPassword" class="input-small1" type="Password" maxlength="20" tabindex="9"/>
              <form:errors  path="confirmPassword" cssClass="validationnote" />  
              </span> 
              </div>
              <div class="floatleft" style="margin-left:3px">
              <label class="floatleft">Date of Birth</label>
              <span class="star">*</span>
              <span class="field">
              <form:input path="dateOfBirth" class="input-small1" id="datepicker" value="" readonly="true" tabindex="10" style="width:85px;" />
              <form:errors  path="dateOfBirth" cssClass="validationnote" />
              </span> 
              </div>
              </div>
            
              <div class="bottom_margin floatright">
              
                <input name="register" type="submit" value="Register" class="no_right_margin" style="height: 75px;" tabindex="11">
               
              </div>
              
              </div>
               </form:form>
        </div>
    	</div>
    </div>
    <div class="tagline_wrap borderbottom">We will open the World of <span class="bluetxt" style="font-size:40px;">Opportunities</span> for you!</div>
  <div class="doubletop_margin networkwrap">
    	<div class="floatleft">
        	<h3 class="lefttxtalign">Download Us to Your Mobile for Faster Access</h3>
            <div><a href="#"><img src="images/apple_icn.png" alt="IOS" class="doubleright_margin"></a><a href="#"><img src="images/andriod_icn.png" alt="Andriod" class="doubleright_margin"></a><a href="#"><img src="images/windows_icn.png" alt="Windows 8" class="doubleright_margin"></a></div>
        </div>
        <div class="floatright">
        	<h3 class="righttxtalign">Connect with Us for latest job postings &amp; updates</h3>
             <div class="text-right"><a href="#"><img src="images/facebook_lrg_icn.png" alt="Facebook" class="doubleleft_margin"></a><a href="#"><img src="images/twitter_lrg_icn.png" alt="Twitter" class="doubleleft_margin"></a><a href="#"><img src="images/googleplus_icn.png" alt="Google Plus" class="doubleleft_margin"></a></div>
        </div>
      <div class="clear"></div>  
  </div>
   <div class="bottomspace">&nbsp;</div>
   </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
  
</div>


<!-- Terms and Conditions Modal -->

	<div id="sendJob">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="termsModal">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onClick="hideModal()">x</button>
				<h3 id="myModalLabel">Terms and Conditions</h3>
			</div>
			<div class="modal-body">
			<%@ include file="includes/candidate_terms.jsp"%>
			
			
				<!-- <iframe width="100%" frameBorder="0" src="html/terms.html"></iframe> -->
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>


<!-- Terms and Conditions Modal  -->


</body>
</html>