<%@ page language="java" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Change Password</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/style.css">

<!--[if lt IE 7]>
	<style type="text/css">
		#wrap { height:100%; }
       
	</style>
    
<![endif]-->
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>


<style>
.errorblock,#error {
	color: #ff0000;	
	border: 2px solid #ff0000;
	padding: 6px;
	margin: 6px;	
}
</style>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />


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
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
 
 <script language="javascript" type="text/javascript">
$(document).ready(function()
{
    $(".checkBox,.checkBoxClear").click(function(srcc)
    {
        if ($(this).hasClass("checkBox"))
        {
            $(this).removeClass("checkBox");
            $(this).addClass("checkBoxClear");
        }
        else
        {
            $(this).removeClass("checkBoxClear");
            $(this).addClass("checkBox");
        }
    });        
});
</script>
 
     <script language="javascript" type="text/javascript">
            $(function() {
                $("#topnavigation").webwidget_menu_glide({ sprite_speed:"normal", container:"topnavigation" });
            });
  </script>
    <script type="text/javascript"> 
$(function() {
			var pull 		= $('#dropdown');
				menu 		= $('#mydiv');
				menuHeight	= menu.height();
			$(pull).on('click', function(e) {
				e.preventDefault();
				menu.slideToggle();
			});
		
			$(window).resize(function(){
        		var w = $(window).width();
        		if(w > 200 && menu.is(':hidden')) {
        			menu.removeAttr('style');
        		}
    		});
		});
$(document).ready(function(){
 var width;
        var y = $('.dropdown_nav li').filter('.current');
        width = y.width() + 30;
        $('.webwidget_menu_glide_sprite').width(width);
        $('.dropdown_nav li').mousemove(function () {
            $('.webwidget_menu_glide_sprite').width($(this).width() + 30);
    
        }
         );
        $('.dropdown_nav li').mouseout(function () {
            $('.webwidget_menu_glide_sprite').width(width);
        });
   
   
});
</script>



<script>
function validateForm()
{
	if($("#oldPassword").val() == $("#newPassword").val())
	{
		$("#error").empty();

		$("#error").css('display','block');

		$(".errorblock").css('display','none');
		
		$("#error").html("New Password cannot be same as Old Password.");
		
		return false;
	}
	return true;
}


$(document).ready(function(){

var success = $("#success").val();

if(success != null && success != "")
{
	$("#successMessageSpan").empty().append("Password Changed Succesfully. Please login with New Credentials");
	
    	$("#chgPasswordModal").dialog({
          modal: true,
          open: function(event, ui){
              setTimeout("$('#chgPasswordModal').dialog('close')",2500);
          }

    	
		});

    	timeoutfunction();
}

function timeoutfunction()
{
	setTimeout(function(){window.location.href="<c:url value='/j_spring_security_logout' />";}, 2530);
} 

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
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
    <div id="innersection">
      <section id="rightwrap" class="floatleft">
        <div class="whitebackground floatleft width100" >
        <h1 class="sectionheading">Change Password</h1>
        <div id="candidate_login_wrap">
          <div class="form_wrap">
            <div class="leftsection_form_warning">
                                  
       <c:if test="${not empty oldPassword}">
		<div class="errorblock">Old Password Does not match our Records.</div>
	  </c:if>          
	  
	  <div id="error" style="display:none;"></div>
	  
              <c:if test="${not empty success}">
              <input type="hidden" id="success" value="${success}">
              </c:if>
              <form:form method="post" modelAttribute="loginCom" onsubmit="return validateForm()" class="stdform">
                <ul class="loginform">
                  <li>
                    <label class="labelfull floatleft">Old Password</label><span class="star">*</span>
                   
                     <form:password path="oldPassword" cssClass="input-xlarge" pattern="(.){8,20}" required="true"/>   
                    <form:errors path="oldPassword"  cssClass="validationnote"/>
                  </li>
                  <li style="position:relative;">
                    <label class="labelfull floatleft">New Password</label><span class="star">*</span>
                   
                     <form:password path="newPassword" cssClass="input-xlarge" pattern="(.){8,20}" required="true" onchange="form.confirmPassword.pattern = this.value;"/>                
                     <form:errors path="newPassword"  cssClass="validationnote"/>
                  </li>
                  <li>
                    <label class="labelfull floatleft">Re-type New Password</label><span class="star">*</span>
                   
                     <form:password path="confirmPassword" cssClass="input-xlarge" pattern="(.){8,20}" required="true"/> 
                    <form:errors path="confirmPassword"  cssClass="validationnote"/>
                  </li>

                  <li>
                    <input name="submitBtn" type="submit" value="Save Changes">
                  </li>
                </ul>
              </form:form>
              </div>
        </div>
          </div>
                </div>
                <div class="clear"></div>
              <div class="">
                <div id="login_contactdetails">
                <h2>Contact Us / Request Information</h2>
                Recruiter Helpline 1-866-444-1110 </div>
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
 
    
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
    <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Success </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>
 
</div>
</body>
</html>