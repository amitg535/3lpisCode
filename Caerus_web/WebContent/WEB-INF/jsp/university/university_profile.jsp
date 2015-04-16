
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Profile</title>
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

<style>
.errorblock {
	color: #ff0000;
}

.hover {
	cursor: pointer;
	cursor: hand;
}

</style>


<script>
 var recognitionListSize;
 var courseListSize;
$(document).ready(function(){

recognitionListSize = $("#recognitionListSize").val();
courseListSize = $("#courseListSize").val();

});


function addAwards(recognitionIndex)

{	
	$("#awards").append('<div class="par"><textarea name="awardsAndRecognitionList['+recognitionListSize+']" rows="2" cols="80" style="width:100%;" maxlength="200"></textarea></div>');

	recognitionListSize = Number(recognitionIndex) + 1;	
}

function addCourses(courseIndex)
{
	$("#tablebody").append('<tr><td style="padding:0; border:0;"><table class="table table-bordered" style="border-left:0px;border-right:0px;"><tr><td>'+
			'<select name="courseType['+courseListSize+']" class="chzn-select list_widthstyle1 width100">'+	
			'<option value="Associates">Associates</option>'+
			'<option value="Bachelors">Bachelors</option>'+
			'<option value="Masters">Masters</option></select></td></tr></table></td>'+
			'<td style="padding:0; border:0;"><table class="table table-bordered" style="border-left:0px;border-right:0px;"><tr><td><input name="courseName['+courseListSize+']" type="text" class="input-xxlarge courseNameField" style="width:98%;" /></td></tr></table></td></tr>');

	courseListSize = Number(courseIndex) + 1;
	
}

function goBack()
{
  window.history.back();
}

function checkEmpty()
{
	var formValue= document.getElementById("profileForm");
	 formValue.action='university_profile.htm';
	
	var courseName = $(".courseNameField").val();

	if(courseName == "")
	{
		$("#courseError").html('Enter atleast one Course Name');
	}

	else
	{
		formValue.submit(); 
	}
}

</script>

<script type="text/javascript">
    $(document).ready(function () {
    	
    	 $(function() {
    		$( "#autumnStartDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    		$( "#autumnEndDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    		$( "#springStartDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    		$( "#springEndDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    		$( "#summerStartDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    		$( "#summerEndDate" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: "-60:+2"
    		});
    	}); 
    
    });
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
   	   	    else{
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

  
  <%@ include file="includes/header.jsp"%>
  
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/university_innerbanner.jpg" alt="Great way to find talent. Sign Up Now!"></div>
      <div class="clear"></div>
    </div>
    
    <div id="innersection">
     <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> \ University Profile</div> -->
      <h1 class="sectionheading top_margin">University Profile</h1>
      <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
      <div class="clear"></div>
      <div id="candidate_registration_wrap">
        <h3 class="subheading_divider">Profile Details</h3>
      <c:if test="${not empty successMessage}">
      <span> ${successMessage} </span>
      </c:if>
        
        <form:form class="stdform" action="university_profile.htm" method="post" modelAttribute="universityDetailsCom" enctype="multipart/form-data" id="profileForm">
     
          <div class="leftsection_form">
            <div class="par">
              <label class="floatleft">University Name</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityName" cssClass="input-xlarge" tabindex="1" disabled="true"/>
                      <form:errors path="universityName"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">Phone Number</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
            <form:input path="phoneNumber" cssClass="input-xlarge" tabindex="1"/>
            <form:errors path="phoneNumber"  cssClass="validationnote" />
              </span>
               </div>
            <div class="par">
              <label class="floatleft">Zip Code</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
               <form:input path="zipCode" cssClass="input-xlarge" tabindex="6" onChange="getCityFunction()"/>
                      <form:errors path="zipCode"  cssClass="validationnote" />
                      <br>
                      <span class="errorblock" id="zipCodeError"></span>
              </span> </div>
             
            <div class="par">
              <label class="floatleft">City</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
              <form:input path="city" cssClass="input-xlarge" tabindex="1"/>
                      <form:errors path="city"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">Contact Person Name</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="contactPerson" cssClass="input-xlarge" tabindex="1" disabled= "true"/>
                      <form:errors path="contactPerson"  cssClass="validationnote" />
              </span> </div>
          </div>
          <div class="rightsection_form">
            <div class="par">
              <label class="floatleft">University Registration Number</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityRegistrationNumber" cssClass="input-xlarge" tabindex="1" disabled= "true"/>
                      <form:errors path="universityRegistrationNumber"  cssClass="validationnote" />
              </span> </div>
            
            <div class="par">
              <label class="floatleft">Address</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="universityAddress" cssClass="input-xlarge" tabindex="1"/>
             <form:errors path="universityAddress"  cssClass="validationnote" />
              </span> </div>
            <div class="par">
              <label class="floatleft">State</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
               <form:input path="state" cssClass="input-xlarge" tabindex="1" />
                      <form:errors path="state"  cssClass="validationnote" />
            
              </span> </div>
            <div class="par">
              <label class="floatleft">University Website</label>
               
             <span class="field">
             <form:input path="universityWebsite" cssClass="input-xlarge"/>
              <form:errors path="universityWebsite"  cssClass="validationnote" />
              </span> 
              <div class="clear"></div>
          
              </div>
            <div class="par">
              <label class="floatleft">Contact Person Email ID</label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:input path="contactPersonEmailId" cssClass="input-xlarge" tabindex="1" disabled= "true"/>
                      <form:errors path="contactPersonEmailId"  cssClass="validationnote" />
                      <c:if	test="${not empty universityRegCmd.caerusCommonExceptionMessage}">
						<div class="errorblock">${universityRegCmd.caerusCommonExceptionMessage}</div>
					  </c:if>
              </span> 
             
                    <input type="hidden" name="authority" value="ROLE_UNIVERSITY">                    
                 
              </div>
          </div>
          <div class="par">
			  <label>Logo upload </label>
			  
			 <c:out value="${logoName}" />
            <span class="field">
            <div class="uploader" id="uniform-undefined">
			  <span class="field doubletop_margin"><input type="file" class="uniform-file" name="universityLogo" id="uploadPhoto"/></span>
			</div>
           
             </span>  
			 </div>
          <div class="clear"></div>     
            <h3 class="subheading_divider">About Us</h3><br>
            <form:textarea path= "aboutUs" id="text-Simple" rows="5" style="width:100%;" ></form:textarea>
            <form:errors path="aboutUs"  cssClass="validationnote" >
             </form:errors>
            
           
           <div class="clear"></div>
           <input type="hidden" id="courseListSize" value="${courseListSize}">
              <div class="subheading_divider">Major Courses At University
              <a class="hover floatright" onclick="addCourses(courseListSize)" style="display: inline-block;">
           		<img src="images/addmore_icn.png" alt="Add More "> </a>
              </div>
              
              <table class="table table-bordered">
                <thead>
                <tr>
                    <th width="50%" class="table_centeralign">Course Type</th>
                    <th width="50%" class="table_centeralign">Course Name</th>    
                  </tr>
              </thead>
                <tbody id="tablebody">
                <tr>
                 <c:choose>
                <c:when test="${not empty universityDetailsCom.courseType}">
                <td style="padding:0; border:0;">
                <table class="table table-bordered" style="border-left:0px;border-right:0px;">
                <c:forEach items="${universityDetailsCom.courseType}" varStatus="status" var="courseType">  
                <c:set var="idValue" value="${status.index}"></c:set>               
                <tr>
                <td>
                <form:select path="courseType[${idValue}]" class="chzn-select list_widthstyle1 width100">
						
						<c:if test="${courseType.equalsIgnoreCase('Bachelors') }">
							<option value="Bachelors" selected="selected">Bachelors</option>
						</c:if>
						
						<c:if test="${courseType.equalsIgnoreCase('Associates') }">
							<option value="Associates" selected="selected">Associates</option>
						</c:if>
						<c:if test="${courseType.equalsIgnoreCase('Masters') }">
							<option value="Masters" selected="selected">Masters</option>
						</c:if>	
					  </form:select>
					  </td>
               </tr>
                </c:forEach>
                </table>
                 </td>
                </c:when>
                <c:otherwise>
                <td style="padding:0; border:0;">
                <table class="table table-bordered" style="border-left:0px;border-right:0px;">
                <tr>
                <td>
                <form:select path="courseType" class="chzn-select list_widthstyle1" multiple="">
						
						<option value="Associates">Associates</option>
						<option value="Bachelors">Bachelors</option>
						<option value="Masters">Masters</option>
							
					  </form:select>
					  </td>
					  </tr>
					  </table>
					  </td>
                </c:otherwise>
                </c:choose>
                 <c:choose>
                <c:when test="${not empty universityDetailsCom.courseName}">
                <td style="padding:0; border:0;">
                <table class="table table-bordered" style="border-left:0px;border-right:0px;">
                <c:forEach items="${universityDetailsCom.courseName}" varStatus="status">
                <c:set var="index" value="${status.index}"></c:set>
                <tr>
                <td>
                <form:input path="courseName[${index}]" class="input-xxlarge courseNameField"/>
                </td>
                </tr>
                </c:forEach>
                </table>
                </td>
                </c:when>
                <c:otherwise>
                 <td style="padding:0; border:0;">           
                 <table class="table table-bordered" style="border-left:0px;border-right:0px;">  
                <tr>
                <td>
                <form:input path="courseName" class="input-xxlarge courseNameField"/>
                </td>
                </tr>
               
                </table>
               
                </td>
                </c:otherwise>
                </c:choose> 
                
                </tr>
                </tbody>
                </table>
                <label class="error" id="courseError"></label>
           
           <div class="clear"></div>         
                <div class="subheading_divider">Major Statistics of University</div>  
                <h3 class="sectionheading margin_top2">Student Details</h3>
                <div class="width100 floatleft">   
                <div class="par">
             <span class="field">    
             
              <label class="floatleft" style="width:33%;">Under Graduate Students</label>             
             <form:input path="ugFullTimeStudents" cssClass="input-medium" placeholder="Full Time"/>
             
             &nbsp; &nbsp;
             <form:input path="ugPartTimeStudents" cssClass="input-medium"  placeholder="Part Time"/>
              </span> 
              </div>
               <div class="par">
               
              <label class="floatleft"  style="width:33%;">Post Graduate Students</label>
             <span class="field">
             
             <form:input path="pgFullTimeStudents" cssClass="input-medium " placeholder="Full Time"/>
              &nbsp; &nbsp;
             <form:input path="pgPartTimeStudents" cssClass="input-medium" placeholder="Part Time"/>
              </span> 
              </div>
            
              </div>
                 <div class="clear"></div> 
                 
                  <h3 class="sectionheading margin_top2">Staff Details</h3>
                   <div class="width100 floatleft">   
                <div class="par">
             <span class="field">    
             
             <form:input path="noOfTeachingStaff" cssClass="input-medium"  placeholder="Teaching Staff"/>
                    &nbsp; &nbsp;       
             <form:input path="noOfResearchStaff" cssClass="input-medium" placeholder="Research Staff"/>
             
             &nbsp; &nbsp;
             <form:input path="noOfSupportStaff" cssClass="input-medium"  placeholder="Support Staff"/>
              </span> 
              </div>

              </div>
           
           <div class="clear"></div>
           
           <div class="subheading_divider">Course Term Dates</div> 
             <div class="width100 floatleft">   
                <div class="par">
             <span class="field">    
             
              <label class="floatleft" style="width:33%;">Autumn Term</label>             
             <form:input path="autumnStartDate" cssClass="input-medium" placeholder="Start Date" id="autumnStartDate"/>
             
             &nbsp; &nbsp;
             <form:input path="autumnEndDate" cssClass="input-medium"  placeholder="End Date" id="autumnEndDate"/>
              </span> 
              </div>
               <div class="par">
               
              <label class="floatleft"  style="width:33%;">Spring Term</label>
             <span class="field">
             
             <form:input path="springStartDate" cssClass="input-medium " placeholder="Start Date" id="springStartDate"/>
              &nbsp; &nbsp;
             <form:input path="springEndDate" cssClass="input-medium" placeholder="End Date" id="springEndDate"/>
              </span> 
              </div>
            
            <div class="par">
               
              <label class="floatleft"  style="width:33%;">Summer Term</label>
             <span class="field">
             
             <form:input path="summerStartDate" cssClass="input-medium " placeholder="Start Date" id="summerStartDate"/>
              &nbsp; &nbsp;
             <form:input path="summerEndDate" cssClass="input-medium" placeholder="End Date" id="summerEndDate"/>
              </span> 
              </div>
            
              </div>   
           <div class="clear"></div>
           
           <div class="subheading_divider">Awards and Recognitions
           <input type="hidden" id="recognitionListSize" value="${recognitionListSize}">
           <a class="hover floatright" onclick="addAwards(recognitionListSize)" style="display: inline-block;">
           <img src="images/addmore_icn.png" alt="Add More "> </a>
           </div> 
           <div class="fullwidth_form" id="awards">
           <c:choose>    
           <c:when test="${not empty  universityDetailsCom.awardsAndRecognitionList}">
           <c:forEach items="${universityDetailsCom.awardsAndRecognitionList}" varStatus="status">
			<c:set var="index" value="${status.index}"></c:set>
           <div class="par">
			  <form:textarea path="awardsAndRecognitionList[${index}]" rows="2" cols="80" style="width:100%;" maxlength="200" ></form:textarea>
			   </div> 
			</c:forEach>
           </c:when>
           <c:otherwise>
           <div class="par">
			  <form:textarea path="awardsAndRecognitionList" rows="2" cols="80" style="width:100%;" maxlength="200" ></form:textarea>
			   </div> 
           </c:otherwise>
           </c:choose>
           
           
           </div>
           <div class="clear"></div>
           
          <div class="fullwidth_form">
            	
            <div class="par">
              <div class="buttonwrap">               
                <input name="" type="button" value="Back" tabindex="21" onclick="goBack()">
                <input name="" type="button"  value="Update" tabindex="22" onclick="checkEmpty()">
              </div>
            </div>
          </div>
        </form:form>
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

</body>
</html>