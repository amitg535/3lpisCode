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
<title>Candidate Wizard</title>
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
 
 <script type="text/javascript" src="js/candidate_wizard_script.js"></script>
 
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" >
$(document).ready(function (e) {

	$(".skipbutton").click(function(){

		$("#content2").css("display", "none");
		$("#content3").css("display", "block");
		
		$("#tab2").removeClass("current");
		$("#tab3").addClass("current"); 
		
		localStorage.setItem("prev", "tab3");

	});

	$(function() {
		$( "#datepicker" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: "-30:+0"
		});
	});

	$(".recent_activities_wrap li").attr('id', function(i) {
		  $(this).attr('id', "number" + i);
		});

	$(".recent_activities_wrap li a").attr('id', function(i) {
		  $(this).attr('id', "q" + i);
		});


	$("#degree").show();
	$("#highSchool").hide();
	$("#buttonGraduate").show();
	
	function switchClass()
	{
		var prev=localStorage.getItem("prev");
		$('#'+prev).removeClass("current");
	}
	
	$("#tab1").click(switchClass);
	$("#tab2").click(switchClass);
	$("#tab3").click(switchClass);
	$("#tab4").click(switchClass);
	$("#tab5").click(switchClass);
	
    $('#imageform').on('submit',(function(e) {
        e.preventDefault();
        var formData = new FormData(this);
		
        $.ajax({
            type:'POST',
            url: $(this).attr('action'),
            data:formData,
            cache:false,
            contentType: false,
            processData: false,
            success:function(data){

            	    
            		$("#successMessageSpan").empty().append("Thank you for uploading your photo , once the photo verification is complete the corporates would be able to see you.");
            		
            	      	$("#chgPasswordModal").dialog({
            	            modal: true,
            	            open: function(event, ui){
            	                setTimeout("$('#chgPasswordModal').dialog('close')",2000);
            	            }
            			});
               
                
                $("#content1").css("display", "none");
        	 	$("#content5").css("display", "block");
        	 	
        	 	$("#tab1").removeClass("current");
        	 	$("#tab5").addClass("current"); 

        	 	localStorage.setItem("prev", "tab5");

        	 	$('.myDiv').empty();
        	 	$('.myDiv').append('<img src="view_image.htm?emailId=${emailId}" width="152" height="152" alt="">');
        	 	
                console.log(data);
            },
            error: function(data){
                alert("error");
                console.log(data);
            }
        });
    }));

    $("#photoimg").on("change", function() {        
        $("#imageform").submit();
});
});
</script>

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

<style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal{
	width:820px !important;
}
.candidate_upcomingevents_wrap{
	margin-top:40px;
}
.tabs_column2 .fullwidth div.par label{width:auto;}
</style>
</head>

<body>
<div id="wrap">
<!--------------  Header Section :: start ----------->
<%@ include file="includes/header.jsp" %>
<!--------------  Header Section :: end -----------> 
<!--------------  Middle Section :: start ----------->
<div id="midcontainer">
<div id="innerbanner_wrap">
  <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
  <div class="clear"></div>
</div>
<div id="innersection">

  <div class="clear"></div>
  <div class="container">
    <div class="about-dotco">
      <h3 class="blutitle18">PORTFOLIO</h3>
      <div class="center">
        <p>&nbsp;</p>
        <!-- Tabs -->
        <div id="tabsholder">
          <ul class="tabs">
            <li id="tab1"><span class="bullet_number">1</span> Personal Details</li>
            <li id="tab2"><span class="bullet_number">2</span> Education </li>
            <li id="tab3"><span class="bullet_number">3</span> Skills Glossary</li>
            <li id="tab4"><span class="bullet_number">4</span> Work Experience</li>
            <li id="tab5"><span class="bullet_number">5</span> Other Details</li>
          </ul>
          		<div id="content1" class="tabscontent">
          		<div class="tabs_column1">&nbsp;</div>
          		<div class="tabs_column2">
    
    
     <div class= "whitebackground">     		
     <div class="title_portfolio">
    <div class="bullet_count">1</div>
    <div class="titile_port">Personal Details</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth" id="support">
  
  <form:form action="" method="post" modelAttribute="addStudent" class="stdform" id="introductory" >
    
        <div class="par">
          <label class="floatleft">Tell us something about Yourself </label>
          <span class="star">*</span>
          <div class="clear"></div>
          <span class="field">          
          <form:textarea name="input4" class="span12" cols="80" rows="3" id="aboutYourself" style="width:752px;" onfocus="hideEmptyAboutYourself()" path="aboutYourSelf"></form:textarea>
                
          </span> </div>
      <label class="error" id="emptyAboutYourself"></label>
   
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">Where are you located (Zip Code)? </label>
      <div class="clear"></div>
      <span class="field">
      <form:input path="zipCode" name="input4" class="input-medium3" onfocus="if (this.placeholder=='Zip Code') this.placeholder = '';hideErrorZipCode()" placeholder="Zip Code" id="zipcode" maxlength="5" onChange="getCityFunction()"></form:input>
      </span><span class="errorblock" id="zipCodeError"></span> </div>
      <label class="error" id="errorZipCode"></label>
      <input type="hidden" id="city" value="">
      <input type="hidden" id="state" value="">
    <div class="clear"></div>
    <div class="par2 floatleft right_margin">
                        <label class="floatleft">Your Gender : </label>
                        <c:choose>
                        <c:when test="${gender == 'Female'}">
                        <span class="field floatleft">
                        <div class="radio"><span>
                          <input type="radio" name="radiofield" style="opacity: 0;" value="Male">
                          </span></div>
                        <span class="right_padding">Male</span>
                        <div class="radio"><span>
                        <input type="radio" name="radiofield" style="opacity: 0;" value="Female" checked="true"/>
                        </span></div>
                        Female </span>
                        </c:when>
                        <c:otherwise>
                        <span class="field floatleft">
                        <div class="radio"><span>
                          <input type="radio" name="radiofield" style="opacity: 0;" value="Male" checked="true">
                          </span></div>
                        <span class="right_padding">Male</span>
                        <div class="radio"><span>
                        <input type="radio" name="radiofield" style="opacity: 0;" value="Female" />
                        </span></div>
                        Female </span>
                        </c:otherwise>
                        </c:choose>
                        </div>
                    
                      <div class="clear"></div>
                      <label class="error" id="emptyGender"></label>
                      <div class="par">

      <label class="floatleft">You were born on : </label>
      <div class="clear"></div>
      <span class="field">
      <form:input path="dateOfBirth" name="input4" class="input-large2" onfocus="if (this.placeholder=='Birth Date') this.placeholder = '';hideEmptyDOB()" placeholder="Birth Date" id="datepicker" readonly="true"></form:input>
      </span> </div>
    <div class="clear"></div>
    <label class="error" id="emptyDOB"></label>
    <div class="">
      <ul class="tabsbtn"><li >
      <input name="" type="button" value="Save &amp; Next" class="top_margin save" onclick="addIntroductory()">
       <input name="" type="button" value="Skip" class="top_margin save" onclick="skipIntroductory()">
      </li></ul>
    </div>
  </form:form>
</div>
</div>

</div>
</div>
               <div id="content2" class="tabscontent"><div class="tabs_column1">&nbsp;</div><div class="tabs_column2">
               
               
     <div class="whitebackground">          
               <div class="title_portfolio">
    <div class="bullet_count">2</div>
    <div class="titile_port">Education</div>
    
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth" id="support">
  <form:form class="stdform" action="" method="post" modelAttribute="addStudent">
  
      <div id ="degree">
      <div class="par">
      <label class="floatleft" style="font-size:16px;">Graduate Profile </label>
      </div>
      <div class="clear"></div>
        <div class="par">
          <label class="floatleft">The University you attended was? </label>
          <span class="star">*</span>
          <div class="clear"></div>
          <span class="field">
          
          <form:select path="universityName" id="universityName" data-placeholder="Choose an Option" class="input-medium3">
                <form:option value=""> -- Please Select University -- </form:option>
                  <c:forEach var="universityList" items="${universityList}">
                  	<c:set var="uniName" scope="session" value="${universityName}" />
						<c:choose>
							<c:when test="${universityList == uniName}">
								<option value="<c:out value="${universityList}" />"
									selected="selected">
									<c:out value="${universityList}" />
								</option>
							</c:when>

							<c:otherwise>
								<option value="<c:out value="${universityList}" />">
									<c:out value="${universityList}" />
								</option>
							</c:otherwise>
						</c:choose>
                 </c:forEach>
              </form:select>
          </span> </div>
      <div class="clear"></div>
    <label class="error" id ="emptyUniversityName"></label>
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">Which Course did you attend ? </label>
      <div class="clear"></div>
      <span class="field">
      
          <form:select path="courseName" id="courseName" data-placeholder="Choose an Option" class="input-medium3">
                <form:option value=""> -- Please Select Course Name -- </form:option>
                  <c:forEach var="courseList" items="${courseList}">
                   <c:set var="couName" scope="session" value="${courseName}" />
				<c:choose>
					<c:when test="${courseList == couName}">
						<option value="<c:out value="${courseList}" />"
							selected="selected">
							<c:out value="${courseList}" />
						</option>
					</c:when>

					<c:otherwise>
						<option value="<c:out value="${courseList}" />">
							<c:out value="${courseList}" />
						</option>
					</c:otherwise>
				</c:choose>
                 </c:forEach>
              </form:select>
      </span> </div>
      <div class="clear"></div>
      <label class="error" id ="emptyCourseName"></label>
      
    <div class="clear"></div>
    <label class="floatleft">What was your GPA Score</label>
      <div class="clear"></div>
      <div class="par">
              
                <form:input path="g_from_gpa" id="g_from_gpa" class="input-profile" onfocus="if (this.placeholder=='Score') this.placeholder = '';hideEmptyGpa()" placeholder="Score"></form:input>
                / 
                <form:input path="g_to_gpa" id="g_to_gpa" class="input-profile" onfocus="if (this.placeholder=='Out Of') this.placeholder = '';hideEmptyGpa()" placeholder="Out Of"></form:input>
                 </div>
                 <div class="clear"></div>
  <label class="error" id ="emptyGpa"></label>
    <div class="clear"></div>
    
     <div class="par">
                <label class="floatleft">Dates Attended</label>
                <div class="clear"></div>
                 <span class="floatleft">
               
                  
                  <form:select path="g_startYear_duration" class="input-small year right_margin increment_year" id="id_g_from_year"> 
                  <c:forEach var="year" items="${year}">
                   <spring:bind path="addStudent.g_startYear_duration"><c:set var = "gStartYear" value="${status.value}"/></spring:bind> 
                    
                   <c:choose>
                      <c:when test="${year == gStartYear}">
                         <option value="<c:out value="${year}" />" selected="selected"><c:out value="${year}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${year}" />"><c:out value="${year}" /></option>
                      </c:otherwise>
                   </c:choose>
                 </c:forEach>
                </form:select>
                  
                  
                <small class="desc">From Year</small> </span> <span class="floatleft">
               
               
                 
                 <form:select path="g_endYear_duration" class="input-small year right_margin increment_year" id="id_g_to_year"> 
                  <c:forEach var="year" items="${year}">
                    <spring:bind path="addStudent.g_endYear_duration"><c:set var = "gEndYear" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${year == gEndYear}">
                         <option value="<c:out value="${year}" />" selected="selected"><c:out value="${year}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${year}" />"><c:out value="${year}" /></option>
                      </c:otherwise>
                   </c:choose>
                 </c:forEach>
                </form:select>
                 
                <small class="desc">To Year</small> </span> </div>
                    <div class="clear"></div>
                    <label class="error" id="errorDuration"></label>
                    <div><a onclick="addHighSchool()" style="font-size:16px;"><img src="images/addmore_icn.png" alt="Add High School Details" style="display:inline-block;"> Add High School Details</a></div>
                   
                   <div class="" id="buttonGraduate">
      <ul class="tabsbtn"><li >
      <input name="" type="button" value="Save &amp; Next" class="top_margin save" onclick="addGraduateDetails()">
       <input name="" type="button" value="Skip" class="top_margin save skipbutton">
      </li></ul>
    </div>  
                   
                    </div>
                   <div id="highSchool">
   <div class="par">
      <label class="floatleft" style="font-size:16px;">High School </label>
      </div>
      <div class="clear"></div>
        <div class="par">
          <label class="floatleft">The School you attended was? </label>
          <span class="star">*</span>
          <div class="clear"></div>
          <span class="field">
          <form:input path="schoolName" name="input4" class="input-medium3" onfocus="if (this.placeholder=='High School Name') this.placeholder = '';hideEmptySchoolName()" placeholder="High School Name" id="schoolName"></form:input>
          </span> </div>
      <label class="error" id ="emptySchoolName"></label>
    
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">Where is your school located?</label>
      <div class="clear"></div>
      <span class="field">
      
      <form:select path="schoolState" id="schoolState" data-placeholder="Choose a Option" class="input-medium3">
                <form:option value=""> -- Please Select State -- </form:option>
                  <c:forEach var="stateList" items="${stateList}">

					<c:set var="schoolStateName" scope="session" value="${schoolStateName}" />
					<c:choose>
						<c:when test="${stateList == schoolStateName}">
							<option value="<c:out value="${stateList}" />"
								selected="selected">
								<c:out value="${stateList}" />
							</option>
						</c:when>

						<c:otherwise>
							<option value="<c:out value="${stateList}" />">
								<c:out value="${stateList}" />
							</option>
						</c:otherwise>
					</c:choose>
                 </c:forEach>
              </form:select>
      </span> </div>
      <label class="error" id ="emptySchoolSate"></label>
      
    <div class="clear"></div>
    <label class="floatleft">What was your GPA Score</label>
      <div class="clear"></div>
      <div class="par">
              
                
                <form:input path="h_from_gpa" id="h_from_gpa" class="input-profile" onfocus="if (this.placeholder=='From') this.placeholder = '';hideEmptyGpaSchool()" placeholder="Score"></form:input>
                / 
                
                <form:input path="h_to_gpa" id="h_to_gpa" class="input-profile" onfocus="if (this.placeholder=='To') this.placeholder = '';hideEmptyGpaSchool()" placeholder="Out Of"></form:input>
                 </div>
  <label class="error" id ="emptyGpaSchool"></label>
    <div class="clear"></div>
    
     <div class="par">
                <label class="floatleft">Dates Attended</label>
                <div class="clear"></div>
                  <span class="floatleft">
                <form:select path="h_startYear_duration" class="input-small month right_margin" id="id_h_from_year">
                  <form:option value="1">Jan</form:option>
                  <form:option value="2">Feb</form:option>
                  <form:option value="3">Mar</form:option>
                  <form:option value="4">Apr</form:option>
                  <form:option value="5">May</form:option>
                  <form:option value="6">Jun</form:option>
                  <form:option value="7">Jul</form:option>
                  <form:option value="8">Aug</form:option>
                  <form:option value="9">Sep</form:option>
                  <form:option value="10">Oct</form:option>
                  <form:option value="11">Nov</form:option>
                  <form:option value="12">Dec</form:option>
                </form:select>
                <small class="desc">From Month</small> </span> 
               
			<span class="floatleft">
                 <form:select path="h_endYear_duration" class="input-small year right_margin increment_year" id="id_h_to_year"> 
                  <c:forEach var="year" items="${year}">
                  <spring:bind path="addStudent.h_endYear_duration"><c:set var = "hEndYear" value="${status.value}"/></spring:bind>
                    
                   <c:choose>
                      <c:when test="${year == hEndYear}">
                         <option value="<c:out value="${year}" />" selected="selected"><c:out value="${year}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${year}" />"><c:out value="${year}" /></option>
                      </c:otherwise>
                   </c:choose>
                 </c:forEach>
                </form:select>
                 
                <small class="desc">To Year</small> </span> </div>
                <div class="clear"></div>
                    <label class="error" id="errorDurationSchool"></label>
                    <div class="clear"></div>
                    <label class="error" id="errorHighSchoolDuration"></label>
                    
           <div class="" id="buttonEducation">
      <ul class="tabsbtn"><li >
      <input name="" type="button" value="Save &amp; Next" class="top_margin save" onclick="addEducationDetails()">
       <input name="" type="button" value="Skip" class="top_margin save skipbutton">
      </li></ul>
    </div>  
   
      </div>
                   
  </form:form>
</div>

</div>
</div></div>
                 
     <div id="content3" class="tabscontent"><div class="tabs_column1">&nbsp;</div><div class="tabs_column2">
     
   <div class="whitebackground">        
    <div class="title_portfolio">
    <div class="bullet_count">3</div>
    <div class="titile_port">Skills glossary</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth" id="support">
  <form:form action="candidate_upload_resume.htm" method="post" modelAttribute="addStudent" class="stdform" enctype="multipart/form-data" id = "uploadResume" >
    <div class="par">            
                <label>Upload your resume (Supported types - .pdf, .doc, .docx, .txt)</label>
                <div id ="resumeName">
                          <c:out value="${resumeName}" />
                </div>
                <span class="field">
                <input type="file" class="uniform-file" name="fileResume" accept="*.txt,application/pdf,application/msword,application/rtf" id="fileResume" />
                      <span class="top_margin"><input name="" type="submit" value="Upload Your Resume"  class="left_margin" onclick="uploadResume();return false;"></span>
                <form:hidden path="hiddenValue" value="${aboutYourself}" />
                
                </span> 
               <div id="invalidFile"> </div>
                </div>
                
                
            <div class="clear"></div>  
            </form:form>  
  <form:form class="stdform" action=""  modelAttribute="addStudent" method="post">
    <div class="doublebottom_margin padding_bottom">
      
        <div class="par">
          <label class="floatleft">Your primary skills are : </label>
          <span class="star">*</span>
          <div class="clear"></div>
                <span class="field" style="width:752px;">
                 <form:input path="primarySkills1" id="primarySkills" cssClass="input-large"></form:input>
              	 
                </span> </div>
      
      </div>
    
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">Your secondary skills are : </label>
      <div class="clear"></div>
      <span class="field" style="width:752px;">
      <form:input path="secondarySkills1" id="tags"  cssClass="input-large" ></form:input>
      
      </span> </div>
    <div class="clear"></div>
    <div class="">
    <ul class="tabsbtn"><li>
      <input name="" type="button" value="Save &amp; Next" class="top_margin save" onclick="addSkills()">
      <input name="" type="button" value="Skip" class="top_margin save" onclick="skipSkills()">
      </li></ul>
    </div>
     
  </form:form>
   
   </div>

</div>    
</div>
</div>
                 <div id="content4" class="tabscontent"><div class="tabs_column1">&nbsp;</div>
                 
                 
    <div class="tabs_column2">
      <div class="whitebackground">      
     <div class="title_portfolio">
                
    <div class="bullet_count">4</div>
    <div class="titile_port">Work Experience</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth" id="support">
  <form:form class="stdform" action="" method="post" modelAttribute="addStudent">
  
    
        <div class="par">
          <label class="floatleft">Have you worked for any other company : </label>
          <span class="star">*</span>
          <div class="clear"></div>
          <span class="field">
          <form:input path="companyName" name="input4" class="input-medium3" onfocus="if (this.placeholder=='Company Name') this.placeholder = '';hideEmptyCompanyName()" placeholder="Company Name" id="companyName"></form:input>
          </span> </div>
     <label class="error" id="emptyCompanyName"></label>
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">Your designation was : </label>
      <div class="clear"></div>
      <span class="field">
      <form:input path="designation" name="input4" class="input-medium3" onfocus="if (this.placeholder=='Designation') this.placeholder = '';hideEmptyDesignation()" placeholder="Designation" id="designation"></form:input>
      </span> </div>
      <label class="error" id="emptyDesignation"></label>
    <div class="clear"></div>
  
    
    <div class="par">
      <label class="floatleft">Your responsibilities included : </label>
      <div class="clear"></div>
      <span class="field">
      <form:textarea path="workDesc" name="input4" class="span12" cols="80" rows="3" id="workDesc" style="width:752px;" onfocus="hideEmptyWorkDesc()"></form:textarea>
      </span> </div>
      <label class="error" id="emptyWorkDesc"></label>
    <div class="clear"></div>
   <div class="par">
                <label class="floatleft">Work Duration</label>
                <div class="clear"></div>
                <span class="floatleft">
                <form:select path="w_startMonth_duration" class="input-small month right_margin" id="work_start_month">
                  <form:option value="1">Jan</form:option>
                  <form:option value="2">Feb</form:option>
                  <form:option value="3">Mar</form:option>
                  <form:option value="4">Apr</form:option>
                  <form:option value="5">May</form:option>
                  <form:option value="6">Jun</form:option>
                  <form:option value="7">Jul</form:option>
                  <form:option value="8">Aug</form:option>
                  <form:option value="9">Sep</form:option>
                  <form:option value="10">Oct</form:option>
                  <form:option value="11">Nov</form:option>
                  <form:option value="12">Dec</form:option>
                </form:select>
                <small class="desc">From Month</small> </span> 
                
                 <span class="floatleft">   
                  <form:select path="w_startYear_duration" class="input-small year right_margin increment_year" id="from_year"> 
                  <c:forEach var="year" items="${year}"> 
                  <spring:bind path="addStudent.w_startYear_duration">
																<c:set var="wStartYear" value="${status.value}" />
															</spring:bind>
                   <c:choose>
                      <c:when test="${year == wStartYear}">
                         <option value="<c:out value="${year}" />" selected="selected"><c:out value="${year}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${year}" />"><c:out value="${year}" /></option>
                      </c:otherwise>
                   </c:choose>
                 </c:forEach>
                </form:select>    
                <small class="desc">From Year</small> </span> 
                <span class="floatleft">
               <form:select path="w_endMonth_duration" class="input-small month right_margin" id="work_end_month">
                  <form:option value="1">Jan</form:option>
                  <form:option value="2">Feb</form:option>
                  <form:option value="3">Mar</form:option>
                  <form:option value="4">Apr</form:option>
                  <form:option value="5">May</form:option>
                  <form:option value="6">Jun</form:option>
                  <form:option value="7">Jul</form:option>
                  <form:option value="8">Aug</form:option>
                  <form:option value="9">Sep</form:option>
                  <form:option value="10">Oct</form:option>
                  <form:option value="11">Nov</form:option>
                  <form:option value="12">Dec</form:option>
                </form:select>
                <small class="desc">To Month</small> </span>
                <span class="floatleft"> 
                 
                 <form:select path="w_endYear_duration" class="input-small year right_margin increment_year" id="to_year"> 
                  <c:forEach var="year" items="${year}">    
                  <spring:bind path="addStudent.w_endYear_duration">
																	<c:set var="wEndYear" value="${status.value}" />
																</spring:bind>             
                   <c:choose>
                      <c:when test="${year == wEndYear}">
                         <option value="<c:out value="${year}" />" selected="selected"><c:out value="${year}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="<c:out value="${year}" />"><c:out value="${year}" /></option>
                      </c:otherwise>
                   </c:choose>
                 </c:forEach>
                </form:select>
                 
                <small class="desc">To Year</small> </span>
                 </div>
    <div class="clear"></div>
    <label class="error" id="errorDurationWork"></label>
    <div class="">
    <ul class="tabsbtn"><li>
      <input name="" type="button" value="Save &amp; Next" class="top_margin save" onclick="addWork()">
      <input name="" type="button" value="Skip" class="top_margin save" onclick="skipWork()">
      </li></ul>
    </div>
   
    </form:form>

</div>
</div>  

</div>
</div>

                <div id="content5" class="tabscontent"><div class="tabs_column1">&nbsp;</div>
                <div class="tabs_column2" id="languageDiv">
      <div class="whitebackground">      
      <div class="title_portfolio">
                
  
    <div class="bullet_count">5</div>
    <div class="titile_port">Other Details</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth" id="support">
 
			    <form:form action="candidate_upload_photo.htm" method="post" modelAttribute="addStudent" class="stdform" enctype="multipart/form-data" id="imageform">
               <div class="par">
              	<label>How would you like to be seen by Corporates ? (Supported types - .jpg, .bmp, .png)</label>
              	 <c:set var="photoName" scope="session" value="${photoName}"/>
                <c:choose>
                      <c:when test="${photoName == null}">
                        <div class="candidate_protfolio_picture floatleft myDiv"><img src="images/Not_available_icon1.png" width="152" height="152" alt=""></div>
                      </c:when>

                      <c:otherwise>
                        <div class="candidate_protfolio_picture floatleft myDiv"><img src="view_image.htm?emailId=${emailId}" width="152" height="152" alt=""></div>
                      </c:otherwise>
                   </c:choose>
      
           </div>  
    	         <div class="rightsection_form">  
                <span class="field doubletop_margin">
                <input type="file" class="uniform-file" name="filePhoto" id="photoimg"/>
                </span>
            <div id="emptyFile"> </div>
            </div>
                <div class="clear"></div>
                </form:form>
                
 	<form:form class="stdform" action="" method="post" modelAttribute="addStudent">
           
           <div class="clear"></div>
           <div class="par">
           <span class="floatleft">
      <input type="text" class="input-medium3" onfocus="if (this.placeholder=='Language') this.placeholder = '';hideEmptyLanguage()" placeholder="Language" id="languagesList"/> 
           &nbsp; &nbsp;</span> </div>
  	<input name="" type="button" value="Add Language" class="top_margin bottom_margin" onclick="addLanguage()">
  	 <label class="error" id="emptyLanguage"></label>
	<div class="clear"></div>
         
			<div class="smallsection_wrap floatleft doubleright_margin" id="languagesDisplay">
         <label>Languages Known</label>
        <ul class="recent_activities_wrap">    
        <c:forEach var="language" items="${languageList}">
        <li><c:out value="${language}"></c:out>
        <a class="floatright " style="display:inline-block;" onclick="deleteLanguage(this.id)">
        <img src="images/list_cross_icn.png" ></a>
        <input type="hidden" value="${language}" id="languages" /></li>
        </c:forEach>
        </ul>
        </div>
	
	</form:form>
	
	
	<div class="clear"></div>
	<form:form class="stdform" action="" method="post" modelAttribute="addStudent">
    <div class="par">
      <label class="floatleft">Your Interests include : </label>
      <div class="clear"></div>
      <span class="field" style="width:752px;">
      <form:input path="interestList" id="tags1" cssClass="input-large" /> 
      </span></div>
      
    <div class="clear"></div>
    <div class="" style="text-align:center;">
      <input name="" type="button" value="SUBMIT" class="top_margin" style="width:625px;font-size:20px;font-family:robotoregular;height:40px;" onclick="addOtherDetails()">
    </div>
  
    
  </form:form>
  </div>
  </div>
  </div> 

</div>
</div>
</div>
              </div>
            
          <!-- /Tabs -->
          
   </div>
   
       <div class="clear"></div>
          </div>
       
      
     <div class="bottomspace">&nbsp;</div>
    </div>
  
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
   <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 


<script>
   function toggle(obj) {
	var item = document.getElementById(obj);
	if(item.style.visibility == 'visible') { item.style.visibility = 'hidden'; }
	else { item.style.visibility = 'visible'; }
}
</script>

<script type="text/javascript" src="js/tytabs.jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#tabsholder").tytabs({
							tabinit:"1",
							fadespeed:"fast"
							});
	$("#tabsholder2").tytabs({
							prefixtabs:"tabz",
							prefixcontent:"contentz",
							classcontent:"tabscontent",
							tabinit:"3",
							catchget:"tab1",
							fadespeed:"normal"
							});
});

</script>
</div>

<div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in hideShadow"  id="chgPasswordModal">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
    <div class="modal ui-dialog-content popModalMessage">
   <div class="modal-header">
   <!--  <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="javascript:">x</button> -->
    <h3 id="myModalLabel"> Verification </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
   </div>
   </div>
  </div>

</body>
</html>
