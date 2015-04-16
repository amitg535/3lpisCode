<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Candidate Profiles</title>
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
    }le>
 }
 <![endif]-->
 
  <style type="text/css">
  #successMessageModal{
	width:820px !important;
</style>

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
  
  <script type="text/javascript">
  $(document).ready(function()
{
	 var successMessage = "${successMessage}";
		  
	//Code to show success message on successful job post
	  if (successMessage)
	{
	 $("#successMessageSpan").empty().append(successMessage);
	    
	      $("#successMessageModal").dialog({
	            modal: true,
	            open: function(event, ui){
	                setTimeout("$('#successMessageModal').dialog('close')",2000);
	            }
});
	      
	  }

	  successMessage =null;
  });
  
 function confirmationPopup(isDefaultProfile)
 {

	if(isDefaultProfile)
	{
		alert("Please Mark Some other Profile as Default before Deleting your Default Profile.");
		return false;
	}

	//  alert(isDefaultProfile);
	  var confirmOutput = confirm("Are you sure want to Delete this Profile ?");
	  return confirmOutput;
 }
</script>
  
  
  </head>
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
   <%@ include file="includes/header.jsp" %>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner">
        <div id="banner">
        <img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!" ></div>
        <div class="clear"></div>
      </div>
   
    <div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \  Manage Profiles</div> -->
       <%--  <section id="leftsection" class="floatleft">
        <h3 class="nomargin">My Imploy</h3>
         <ul class="leftsectionlinks">
        <li><a href="<c:url value="candidate_view_profile.htm"/>">View Profile</a></li>
        <li><a href="<c:url value="candidate_addedit_photo.htm"/>">Add / Edit Photograph</a></li>
        <li><a href="<c:url value="candidate_addedit_videocv.htm"/>">Add / Edit Video CV</a></li>
        <li><a href="<c:url value="candidate_manage_profile.htm"/>">Create / Manage Profiles</a></li>
          <li><a href="#">Create / Manage Cover Letter</a></li>
          <li><a href="<c:url value="candidates_recommendedjobs.htm"/>">Imploy Recommended Jobs</a></li>
          <li><a href="#">My Saved Jobs</a></li>
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
       

        <h1 class="sectionheading floatleft">Manage Profiles </h1>
        <c:if test="${profileCount < 5}">
	        <a href="candidate_create_profile.htm">
	          <div class="postajob_wrap top_padding">
	          <img src="images/new_user.png" alt="Create Profile" title="Create Profile">Create New Profile</div>
	        </a>
        </c:if>
        <div class="clear"></div>
        <div class="manageprofiles_para borderbottom">
            You can create upto 5 different profiles on Imploy.me
          </div>
          
          
        <div class="job_listing_wrap">
            <ul class="profile_lists">
            <c:forEach items="${profiles}" var="studentProfile"> 
           
            <li>
                <div class="manageprofiles">
                <div>
                     <div class="jobtitle floatleft right_margin" id="Id"><span class="profilename"><c:out value="${studentProfile.profileName}"/></span></div>  
                    <div class="profilechk_wrap">
                     <c:if test="${studentProfile.isDefault}">
	                     <span class="defaultprofile">(</span>
	                     <span class="defaultprofile"><img src="images/check1_icn.gif" alt="" title=""></span>
	                     <span>)</span> 
                     </c:if>
                     </div>
         
                  
                    <div class="floatright date">Last Updated: <c:out value="${studentProfile.lastUpdate}"></c:out></div>
                    <div class="clear"></div>
                  </div>
                <div class="txtpadding">
                    
                    <c:out value="${studentProfile.aboutYourSelf}"></c:out>
                    </div>
                <div class="clear"></div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="10%" valign="top" class="keyskillstxt">Primary Skills</td>
                    
                    <td width="85%" valign="top" class="keyskills_padding">
                    <ul class="keyskillslist">
                    <c:forEach items="${studentProfile.primarySkills}"  var="primarySkill">
                    <li>
                    <c:out value="${primarySkill}">
                    </c:out>
                    </li>
                    </c:forEach>
                    </ul>
                      </td>
                  </tr>
                  </table>                  
                  <ul class="actions_icns floatright"> 
                  <c:if test="${!studentProfile.isDefault}">    
                   	<li><a href="candidate_set_default_profile.htm?profileName=<c:out value="${studentProfile.profileName}"/>"><span><img src="images/check1_icn.gif" alt="Email"></span>Mark as Default</a></li>
                  </c:if>
                  
                   <li><a href="candidate_edit_profile.htm?profileName=<c:out value="${studentProfile.profileName}"/> ">
                   <span><img src="images/update.png" alt="update"></span>Update</a></li>
                  
             
             <li>
             <a onclick="return confirmationPopup(${studentProfile.isDefault})" href="candidate_delete_profile.htm?profileName=<c:out value="${studentProfile.profileName}"/>"><span><img src="images/delete_icn.png" alt="update"></span>Delete</a>
             </li>
                  </ul>                  
              </div>
                <div class="clear"></div>
              </li>
            </c:forEach>
          </ul>
          </div>
      </section>
        <div class="clear"></div>
      </div>
      <div class="bottomspace">&nbsp;</div>
  </div>
    <!--------------  Middle Section :: end -----------> 
    <!--------------  Common Footer Section :: start ----------->
    <!-- <footer>
    <div id="bottom_wrap">
      <div class="section">
        <div id="bottomlogo"><a href="candidate_dashboard.htm"><img src="images/bottom_logo.png" alt="Imploy - your carrer hi-five" title="Imploy - your carrer hi-five"></a></div>
        <address>
        105, Main Street, Suite 240,<br/>
        Seattle, WA 1984 <br/>
        <a href="mailto:info@imploy.me?Subject=Hi">info@Imploy.me</a><br/>
        (877) 644 - 774
        </address>
        <div id="socialnetwork"> <span><a href="#"><img src="images/facebook_icn.png" alt="Facebook"></a></span> <span><a href="#"><img src="images/linkedin_icn.png" alt="Linked In"></a></span> </div>
      </div>
      <div class="section_leftmargin section">
        <h5>Job Seeker</h5>
        <ul>
          <li><a href="#">Candidate Sign-in </a></li>
          <li><a href="#">Post Resume </a></li>
          <li><a href="#">Search Jobs</a></li>
          <li><a href="#">Participate in Virtual Job Fairs </a></li>
          <li><a href="#">Report a Problem</a></li>
          <li><a href="#">Resume Spotlight</a></li>
          <li><a href="#">Job in your Mobile</a></li>
          <li><a href="#">Subscribe to Imploy Newsletter</a></li>
        </ul>
      </div>
      <div class="section section_leftmargin">
        <h5>Information</h5>
        <ul>
          <li> <a href="#">About Us </a></li>
          <li> <a href="#">Terms &amp; Conditions </a></li>
          <li> <a href="#">Privacy Policy </a></li>
          <li> <a href="#">Resources </a></li>
          <li> <a href="#">Careers with us</a></li>
          <li> <a href="#">Site Map </a></li>
          <li> <a href="#">Contact Us </a></li>
          <li> <a href="#">FAQ's</a></li>
          <li> <a href="#">Partner with us</a></li>
        </ul>
      </div>
      <div class="section section_leftmargin">
        <h5>Contact Imploy Support</h5>
        <ul>
          <li class="contact">Toll Free Helpline<br>
            1-866-444-1110</li>
          <li class="email"> Email incase of any queries. <br>
            <a href="mailto:support@Imploy.com">support@Imploy.com</a></li>
        </ul>
      </div>
      <div class="clear"></div>
      <div id="copyrights">&copy; 2012 Imploy.Me. All Rights Reserved &nbsp; | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></div>
      
      
         <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in"  id="successMessageModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div style="z-index: 1000; position:absolute;" class="modal ui-dialog-content">
   <div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button>
    <h3 id="myModalLabel"> Profile Deleted </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>
      
      
      
      
    </div>
  </footer> -->
    <!--------------  Common Footer Section :: end -----------> 
    
    <%@include file="includes/footer.jsp" %>
  </div>
</body>
</html>