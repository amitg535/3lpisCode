
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Registration</title>
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


<script>
function goBack()
  {
  window.history.back();
  }
</script>

<script type="text/javascript">
function getCityFunction()
{
	var zipCode=$("#zipCode").val();
	   
      $.ajax({
        
        url: 'get_city_name.htm',
        data : {
			'zipCode' : zipCode
		},
        cache: false,
   	    success: function(cityName) {
   	   	    if(cityName==" ()"){
   	   	  $("#city").val("");
   	   	  $("#state").val("");   
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   	  			values=cityName.split('(');
  					finalCity=values[0];
  					two=values[1];
  					$("#city").val(finalCity);
  					splitState=two.split(')');
  					finalState=splitState[0];
  					$("#state").val(finalState);
   	   	   	    }
             
     
        }
    });
 
}
	 
</script>

</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <header>
   <div class="user_infobox">&nbsp;</div>
    <div id="logo"><a href="home.htm"><img src="images/logo.png" alt="Caerus - your carrer hi-five"></a></div>
    <div id="loginwrap">
       <div class="floatleft regiterationloginpan">
       <form action="<c:url value='j_spring_security_check' />" method="post" id="submit" class="stdform">
         
              <input type="email" name="username" placeholder="Email ID" required="required"  style="width:150px;" onfocus="clearClassFunction()" tabindex="1"/> 
					<input type="password" name="password" placeholder="Password" required="required" id="password" maxlength="20" min="8" style="width:150px;" onfocus="clearClassFunction()" tabindex="2"/> 
					<input type="submit" id="lgnBtn" value="Login" tabindex="3" />
            <br>
              <a href="<c:url value="user_forgot_password.htm"/>" class="forgotpass" style="padding-bottom:0;color:#fff;" tabindex="3">Forgot Password?</a>
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
                </form></div>
    </div>
    <div class="clear"></div>
  </header>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
   <!--  <div id="innerbanner_wrap">
      <div><img src="images/university_innerbanner.jpg" alt="Great way to find talent. Sign Up Now!"></div>
      <div class="clear"></div>
    </div> -->
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="home.htm">Home</a> \ University Registration</div> -->
      <div class="whitebackground margin_top2">
        <c:if test="${not empty success}">
          <div id="warning_image"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
          <h2 class="error_message_heading">You have successfully registered at Imploy.Me</h2>
          <div class="clear"></div>
          <p class="boldtxt">Please click on the link to login.<a href="home.htm">Login</a> </p>
        </c:if>
      <h1 class="sectionheading top_margin">University Registration</h1>
      <p class="description">Create your account. It's quick, free one-time process. You'll be on your way to recruiting the best 
        qualified college students and recent graduates to meet your organization's specific human capital
        needs in no time.</p>
      <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
      <div class="clear"></div>
      <div id="candidate_registration_wrap">
        <h3 class="sectionheading margin_top2">Profile Details</h3>
        
        <form:form class="stdform" action="" method="post" modelAttribute="universityDetailsCom">
        
          <div class="leftsection_form">
           <form:errors path="exceptionOccured"  cssClass="validationnote" />
           <c:if test="${not empty registered}">
           <div class="errorblock">University already Registered</div>
           </c:if>
            <div class="par">
              <label class="floatleft">University Name</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityName" cssClass="input-xlarge" tabindex="5"/>
                      <form:errors path="universityName"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">Phone Number</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
            <form:input path="phoneNumber" cssClass="input-xlarge" tabindex="7"/>
            <form:errors path="phoneNumber"  cssClass="validationnote" />
              </span>
               </div>
            <div class="par">
              <label class="floatleft">Zip Code</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
               <form:input path="zipCode" cssClass="input-xlarge" onChange="getCityFunction()" tabindex="9"/>
                      <form:errors path="zipCode"  cssClass="validationnote" />
                      
		              <span class="errorblock" id="zipCodeError"></span>
              </span> </div>
             
            <div class="par">
              <label class="floatleft">City</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
              <form:input path="city" cssClass="input-xlarge" tabindex="11"/>
                      <form:errors path="city"  cssClass="validationnote" />
              </span> </div>
          </div>
          <div class="rightsection_form">
            <div class="par">
              <label class="floatleft">University Registration Number</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityRegistrationNumber" cssClass="input-xlarge" tabindex="6"/>
                      <form:errors path="universityRegistrationNumber"  cssClass="validationnote" />
              </span> </div>
            
            <div class="par">
              <label class="floatleft">Address</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityAddress" cssClass="input-xlarge" tabindex="8"/>
                      <form:errors path="universityAddress"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">State</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="state" cssClass="input-xlarge" tabindex="10"/>
                      <form:errors path="state"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">University Website</label>
            
              <div class="clear"></div>
             <span class="field">
             <form:input path="universityWebsite" cssClass="input-xlarge" tabindex="12"/>
              <form:errors path="universityWebsite" cssClass="validationnote"  />
              </span> 
              <div class="clear"></div>           
          
              </div>
          </div>
          
          <div class="clear"></div>
          <input type="hidden" name="authority" value="ROLE_UNIVERSITY"> 
          <h3 class="sectionheading margin_top2">Admin Details</h3>
          
          <div class="leftsection_form">
           <div class="par">
              <label class="floatleft">First Name</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="firstName" cssClass="input-xlarge" tabindex="10"/>
                      <form:errors path="firstName"  cssClass="validationnote" />
              </span> </div>
              <div class="par">
              <label class="floatleft">Admin Email ID</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="emailID" cssClass="input-xlarge" tabindex="10"/>
                      <form:errors path="emailID"  cssClass="validationnote" />
              </span> </div>
          </div>
          
          <div class="rightsection_form">
          <div class="par">
              <label class="floatleft">Last Name</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="lastName" cssClass="input-xlarge" tabindex="10"/>
                      <form:errors path="lastName"  cssClass="validationnote" />
              </span> </div>
          </div>
          
          <div class="clear"></div>
          <div class="fullwidth_form">
            	<div class="par"> 
               <form:checkbox path="termsAndConditions"  class="styled" tabindex="15"/> Yes, I have read the <a href="#termsModal" data-toggle="modal">'Terms of Service'</a>
                <form:errors path="termsAndConditions"  cssClass="validationnote" /> 
              </div>
            <div class="par">
              <div class="buttonwrap">               
                <input name="" type="button" value="Back" onclick="goBack()"tabindex="16">
                <input name="" type="submit"  value="Submit" tabindex="17">
              </div>
            </div>
          </div>
        </form:form>
      </div>
      <div class="clear"></div>
    </div>
    <div class="bottomspace">&nbsp;</div>
    
    </div>
  </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
 <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>
</body>


<!-- Terms and Conditions Modal -->

	<div id="sendJob">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="termsModal">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onClick="hideModal()">x</button>
				<h3 id="myModalLabel">Terms and Conditions</h3>
			</div>
			<div class="modal-body">
			<%@ include file="includes/university_terms.jsp"%>
			
			
				<!-- <iframe width="100%" frameBorder="0" src="html/terms.html"></iframe> -->
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>


<!-- Terms and Conditions Modal  -->


</html>