<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="/WEB-INF/tld/pd4ml.tld" prefix="pd4ml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<pd4ml:usettf from="/windows/fonts"/>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Resume-Builder</title>
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

<link rel="stylesheet" href="css/style.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link type="text/css"   href="css/cvtheme.css" rel="stylesheet" />

<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />

<script type="text/javascript" src="js/jquery.min.js"></script>
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
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>

    <script type="text/javascript" src="js/script.js"></script>

<script type="text/javascript">
	// A $( document ).ready() block.
$( document ).ready(function() {
	$("#customize-Simple").show();
	$("#customize-expertise").hide();
	$("#customize-executive").hide();
	$("#text-Simple").hide();
	$("#text-Expertize").hide();
	$("#text-Executive").hide();
	$("#contentSimpleDone").hide();
	$("#contentExpertiseDone").hide();
	$("#contentExecutiveDone").hide();
	$("#expertiseDiv").hide();
	$("#expertisecoment").hide(); 
	 $("#doneSimple").hide();
	 $("#divExpertise").hide();
	 $("#doneExecutive").hide();
	 $("#executiveComent").hide();
	
	
    $("#temp1").click(function(){
    	$("#temp1").addClass("active");	
		$("#temp2").removeClass("active");	
		$("#temp3").removeClass("active");
        
		$("#customize-Simple").show(function(){
			$("#text-Simple").hide();
			$("#contentSimpleDone").hide();
			$("#content-Simple").show();
			$("#expertise-Simple").show();
			$("#expertisecoment").hide(); 
			 $("#doneSimple").hide();
		});
		
		$("#customize-expertise").hide();
		$("#customize-executive").hide();
		
		});
		
		 $("#temp2").click(function(){
			    $("#temp2").addClass("active");	
				$("#temp1").removeClass("active");	
				$("#temp3").removeClass("active");	
				
		$("#customize-expertise").show(function(){
			$("#expertiseDiv").hide();
			$("#content-Expertize").show();
			$("#text-Expertize").hide();
			$("#contentExpertiseDone").hide();
			$("#divExpertise").hide();
			
		});
		
		$("#customize-executive").hide();
		$("#customize-Simple").hide();
		});
		
		 $("#temp3").click(function(){
			    $("#temp3").addClass("active");	
				$("#temp1").removeClass("active");	
				$("#temp2").removeClass("active");	
					
		$("#customize-executive").show(function(){
			
			$("#content-Executive").show();
			$("#text-Executive").hide();
			$("#contentExecutiveDone").hide();
			 $("#doneExecutive").hide();
			 $("#executiveComent").hide();
			
		});
		$("#customize-Simple").hide();
		$("#customize-expertise").hide();
		
		});
			
});
</script>

<script type="text/javascript">
function createPDF(){ 
	 var formValue = document.getElementById("download");
	 formValue.method = "post";
	 
	if($("#temp1").hasClass("active")){
 		// alert('Testing');
		 formValue.action='candidate_resume_download.htm?template=customize-Simple';
	    
	}
	
	else if($("#temp2").hasClass("active")){
		 //  alert('Testing2');
				 formValue.action='candidate_resume_download.htm?template=customize-expertise';
			}
	
	else if($("#temp3").hasClass("active")){
		//   alert('Testing3');
				 formValue.action='candidate_resume_download.htm?template=customize-executive';
			}
	
	  formValue.submit();
	  
	  
}
</script>

<script type="text/javascript">
function editContentSimple()
{
	$("#text-Simple").empty();
	var value = $("#content-Simple").text();
	$("#content-Simple").hide();
	$("#text-Simple").append(value);
	$("#text-Simple").show();
	
	$("#contentSimpleDone").show();
}
function editContentExpertize()
{
	$("#text-Expertize").empty();
	var value = $("#content-Expertize").text();
	$("#content-Expertize").hide();
	$("#text-Expertize").append(value);
	$("#text-Expertize").show();
	$("#contentExpertiseDone").show();
	$("#expertiseDiv").show();
}
function editContentExecutive()
{
	$("#text-Executive").empty();
	var value = $("#content-Executive").text();
	$("#content-Executive").hide();
	$("#text-Executive").append(value);
	$("#text-Executive").show();
	$("#contentExecutiveDone").show();
}
function replaceContentSimple()
{
	var content = $("#text-Simple").val();
	$("#text-Simple").hide();
	$("#contentSimpleDone").hide();
	$("#content-Simple").empty();
	$("#text-Simple").empty();
	
	$("#content-Simple").show();
	$("#content-Simple").html(content);
	$("#content-Expertize").empty();
	$("#content-Expertize").show();
	$("#content-Expertize").html(content);
	$("#content-Executive").empty();
	$("#content-Executive").show();
	$("#content-Executive").html(content);
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?content='+content,
		request:"POST",
		data : {
			'content' : content
		},
		cache : false,
		success : function(data) {
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
function replaceContentExpertize()
{
	var content = $("#text-Expertize").val();
	$("#text-Expertize").hide();
	$("#content-Expertize").empty();
	$("#contentExpertiseDone").hide();
	$("#expertiseDiv").hide();
	$("#text-Expertize").empty();
	$("#contentExpertiseDone").hide();
	$("#content-Expertize").show();
	$("#content-Expertize").html(content);
	$("#content-Simple").empty();
	$("#content-Simple").show();
	$("#content-Simple").html(content);
	
	$("#content-Executive").empty();
	$("#content-Executive").show();
	$("#content-Executive").html(content);
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?content='+content,
		request:"POST",
		data : {
			'content' : content
		},
		cache : false,
		success : function(data) {
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
function replaceContentExecutive()
{
	var content = $("#text-Executive").val();
	$("#text-Executive").hide();
	$("#content-Executive").empty();
	$("#contentExecutiveDone").hide();
	$("#text-Executive").empty();
	
	$("#content-Executive").show();
	$("#content-Executive").html(content);
	$("#content-Expertize").empty();
	$("#content-Expertize").show();
	$("#content-Expertize").html(content);
	$("#content-Simple").empty();
	$("#content-Simple").show();
	$("#content-Simple").html(content);
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?content='+content,
		request:"POST",
		data : {
			'content' : content
		},
		cache : false,
		success : function(data) {
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
function editExpertiseSimple()
{
	 $("#expertisecoment").empty();
	
	 var data = $("#expertise-Simple").text().trim();
	var expertise = data.split("\n");
	$("#expertise-Simple").hide();
	
	$.each(expertise,function(i){
		var noSpaceData = expertise[i].trim();
		 $("#expertisecoment").append(noSpaceData + '&#xA;'); 
		});
	
	  $("#expertisecoment").show(); 
	  $("#doneSimple").show();
}
function replaceExpertiseSimple()
{
	var array = $('#expertisecoment').val().split("\n");
	$("#expertisecoment").hide(); 
	$("#expertise-Simple").empty();
	$("#expertisecoment").empty(); 
	$("#expertise-Simple").show();
	
	$("#expertiseVal").empty();
	$("#divExecutive").empty();
	 $("#doneSimple").hide();
	
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?expertise='+array,
		request:"POST",
		data : {
			'expertise' : array
		},
		cache : false,
		success : function(data) {
			$.each(array,function(i){
				$("#expertise-Simple").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#expertiseVal").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#divExecutive").append('<ul><li> ' + array[i] + '</li></ul>');
				});
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
function editExpertiseFunction()
{
	$("#expertizeText").empty();
	var data= $("#expertiseVal").text().trim();
	var expertise = data.split("\n");
	
	$("#expertiseVal").hide();
	
	$.each(expertise,function(i){
		var noSpaceData = expertise[i].trim();
		 $("#expertizeText").append(noSpaceData + '&#xA;'); 
		});
	
	$("#divExpertise").show(); 
	
}
function replaceExpertise()
{
	var array = $('#expertizeText').val().split("\n");
	
	$("#divExpertise").hide(); 
	$("#expertiseVal").empty();
	$('#expertizeText').empty();
	$("#expertiseVal").show();
	$("#expertise-Simple").empty();
	$("#divExecutive").empty();
	
	
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?expertise='+array,
		request:"POST",
		data : {
			'expertise' : array
		},
		cache : false,
		success : function(data) {
			$.each(array,function(i){
				$("#expertiseVal").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#expertise-Simple").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#divExecutive").append('<ul><li> ' + array[i] + '</li></ul>');
				});
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
function editExecutiveFunction()
{
	 $("#executiveComent").empty();
	 
	var data= $("#divExecutive").text().trim();
	var expertise = data.split("\n");
	
	$("#divExecutive").hide();
	
	$.each(expertise,function(i){
		var noSpaceData = expertise[i].trim();
		 $("#executiveComent").append(noSpaceData + '&#xA;'); 
		});
	
	$("#executiveComent").show(); 
	$("#doneExecutive").show(); 
	
}
function replaceExecutive()
{
	var array = $('#executiveComent').val().split("\n");
	
	$("#executiveComent").hide(); 
	$("#executiveComent").empty();
	$("#doneExecutive").hide();
	$("#divExecutive").empty();
	
	$("#divExecutive").show();
	$("#expertiseVal").empty();
	$("#expertise-Simple").empty();
	$.ajax({
 		
		url: 'candidate_resume_builder.htm?expertise='+array,
		request:"POST",
		data : {
			'expertise' : array
		},
		cache : false,
		success : function(data) {
			$.each(array,function(i){
				$("#expertiseVal").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#expertise-Simple").append('<ul><li> ' + array[i] + '</li></ul>');
				$("#divExecutive").append('<ul><li> ' + array[i] + '</li></ul>');
				
				});
			
		},
		failure : function() {
			alert("Failed");
		}
	}); 
}
</script>
<script>
$(document).ready(function(){
function modalClicked()
{
	
	  $("#myModal").dialog({
	      
	      //  modal: true,
	      //  close: false
	    });
};
});

</script>
<style type="text/css">
#download{margin:30px 0;}
</style>
</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
 
     <%@ include file="includes/header.jsp"%>
 
  <!--------------  Header Section :: end -----------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
 
    <div id="innersection">
    <form name = "download" id="download" >
    
     <!--  <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> / Resume Builder -->
      
      <div class="buttonPan"><input name="download" type="button" value="Download PDF" class="download" onclick="createPDF()"></div>
      </div>
       
      <div class="container">
      <div class="templates">
        <ul>
          <li><a href="#" id="temp1" class="active"><img src="images/resumebuilder/temp1.jpg" width="120" height="94" alt="" /> <span>Simple</span></a></li>
          <li><a href="#"  id="temp2"><img src="images/resumebuilder/temp2.jpg" width="120" height="94" alt="" /> <span>Expertise</span></a></li>
          <li><a href="#"  id="temp3"><img src="images/resumebuilder/temp3.jpg" width="120" height="94" alt="" /> <span>Executive</span></a></li>
        </ul>
      </div>
      <div id="customize-Simple">
        <div class="view-resume">
          
          <div class="sections">
           <h1 class="floatright" style="color: rgb(88, 155, 206); text-transform: uppercase; font-size: 40px;padding-bottom:20px;"><c:out value="${studentDetails.firstName}"/> &nbsp; <c:out value="${studentDetails.lastName}"/></h1>
            <div class="content address"><c:if test="${not empty studentDetails.address}"><c:out value="${studentDetails.address}"/>,<c:out value="${studentDetails.zipCode}"/>,<c:out value="${studentDetails.city}"/> (<c:out value="${studentDetails.state}"/>)</c:if>
            <br><span class="mobileno">Mobile No:</span> <span><c:out value="${studentDetails.mobileNumber}"/></span>  <span class="emailid">Email Id :</span> <span><c:out value="${studentDetails.emailID}"/></span></div>
          </div>
          
         
          <div class="sections">
           <div class ="floatright cvdate"><input type="button" value="Edit" class="orangebuttons" onclick="editContentSimple()" id="buttonSimple"></div>
            <h1 class="headings">Career Objective</h1><textarea id="text-Simple" rows="3" cols="80" class="resume_buildtxtarea" ></textarea>
             <div class ="floatright cvdate" ><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceContentSimple()" id="contentSimpleDone"></div>
            <c:choose>
            <c:when test="${empty studentDetails.careerObjective}">
            <div class="content" id="content-Simple">To make a sound position in corporate world and work enthusiastically in team to achieve goal of the organization/MNC with devotion and hard work.</div>
            
            </c:when>
            <c:otherwise>
            <div class="content" id="content-Simple"><c:out value="${studentDetails.careerObjective}"></c:out></div>
            </c:otherwise>
            </c:choose>
            
            
          </div> 
          <c:choose>
         	<c:when test="${empty studentDetails.aboutYourSelf}">
    		<div class="sections disable">
    		<h1 class="headings">Summary</h1>
            <div class="content">Summary is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
			</c:when>
			
			<c:otherwise>
			<div class="sections">
			<h1 class="headings">Summary</h1>
            <div class="content"><c:out value="${studentDetails.aboutYourSelf}"/></div>
			</div>
			</c:otherwise>
          </c:choose>
    
           <div class="sections">
            <h1 class="headings">Education</h1>
            <div class="content education">
            <ul>
                    
            <c:choose>
         	<c:when test="${empty universityList}">
         	<div class="sections disable">
    		
            <div class="content">University Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
            <c:otherwise>
            <c:forEach items="${universityList}" var="universityDetails">
            <c:if test="${null!= universityDetails.universityCourseType && universityDetails.universityCourseType !='null' && not empty universityDetails.universityCourseType}">
            <li><span><c:out value="${universityDetails.universityCourseType}"/></span></li></c:if>
            <li><p class="floatright cvdate"><c:choose>
                <c:when test="${universityDetails.universityMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${suniversityDetails.universityMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${universityDetails.universityYearFrom}"/> - <c:choose>
                <c:when test="${universityDetails.universityMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${universityDetails.universityYearTo}"/></p>
            <c:out value="${universityDetails.universityName}"/>
            </li>
             <li class="clear">
            </li>
             <li><p class="floatright cvdate"><c:out value="${universityDetails.universityGpaFrom}"/> Out of <c:out value="${universityDetails.universityGpaTo}"/></p>
            <c:out value="${universityDetails.universityCourseName}"/>
            </li>
            </c:forEach>
            </c:otherwise>
            </c:choose>
            
         <c:choose>
         	<c:when test="${empty schoolDetails}">
         	<div class="sections disable">
    		
            <div class="content">School Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         <c:otherwise>  
         
         <li><span>High School</span></li>
            <li><p class="floatright cvdate"><c:choose>
                <c:when test="${schoolDetails.schoolPassingMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>  <c:out value="${schoolDetails.schoolPassingYear}"/><%--  - <c:choose>
                <c:when test="${studentDetails.h_endMonth_duration == '1'}">
                  Jan
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '2'}">
                  Feb
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '3'}">
                  March
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '4'}">
                  April
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '5'}">
                  May
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '6'}">
                  June
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '7'}">
                  July
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '8'}">
                  Aug
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '9'}">
                  Sept
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '10'}">
                  Oct
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '11'}">
                  Nov
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${studentDetails.h_endYear_duration}"/> --%></p>
            <c:out value="${schoolDetails.schoolName}"/>
            </li>
             <li class="clear">
            </li>
             <li><p class="floatright cvdate"><c:out value="${schoolDetails.schoolGpaFrom}"/> Out of <c:out value="${schoolDetails.schoolGpaTo}"/></p>
            <c:out value="${schoolDetails.schoolState}"/>
             </c:otherwise>
            </c:choose>
      
            </ul>
            </div>
          </div>
         
           <c:choose>
         	<c:when test="${empty certificationList}">
          <div class="sections disable">
            <h1 class="headings">Certifications</h1>
            <div class="content">Certifications is empty and will not be part of cv . Please update portfolio to add.</div>
          </div>
          </c:when>
          
          <c:otherwise>
          <div class="sections">
            <h1 class="headings">Certifications</h1>
            <div class="content education">
            
            <c:forEach items="${certificationList}" var="certification">  
           <span><c:out value="${certification.certificateName}"/>(<c:out value="${certification.certificateNumber}"/>)</span>
            <p class="floatright cvdate">  
            <c:choose>
                <c:when test="${certification.certificationStartMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationStartMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationStartMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationStartYear}" /> - 
                	   
        <c:if test="${empty certification.certificationEndMonth}">
        Certificate Does Not Expire
        </c:if>
        <c:if test="${not empty certification.certificationEndMonth}"> 
                	     <c:choose>
                <c:when test="${certification.certificationEndMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationEndMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationEndMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationEndYear}" />
                	   </c:if>  
                	   </p>    
                	   <div class="smallfontitalic">
                	   <c:out value="${certification.certificateAuthority}"/>
             </div>
             <br>
            </c:forEach>
           
            </div>
            </div>
          </c:otherwise>
          </c:choose>
          
          
           <c:choose>
         	<c:when test="${empty workDetails}">
         	<div class="sections disable">
    		<h1 class="headings">Experience</h1>
            <div class="content">Experience is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise>
          <div class="sections">
            <h1 class="headings">Experience</h1>
            <div class="content experience">
            <c:forEach items="${workDetails}" var="workDetails">
             <p class="floatright cvdate">
               <c:choose>
                <c:when test="${workDetails.workMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose>
               
               <c:out value="${workDetails.workYearFrom}"/> - 
 
                 <c:choose>
                <c:when test="${workDetails.workMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose>
                <c:out value="${workDetails.workYearTo}"/></p> 
            <span><strong><c:out value="${workDetails.workCompanyName}"/></strong></span> 
            <c:choose>
            <c:when test="${workDetails.workYearTo > workDetails.workYearFrom}">
	            <c:set var = "duration" value="${workDetails.workYearTo - workDetails.workYearFrom}"></c:set>
	            <c:choose>
	            <c:when test="${duration > 1}">
	            <label>- ${duration} years </label>
	            </c:when>
	            <c:otherwise>
	            <label>- ${duration} year </label>
	            </c:otherwise>
	            </c:choose>
            </c:when>
            <c:otherwise>
            <c:set var = "duration" value="${workDetails.workMonthTo - workDetails.workMonthFrom}"></c:set>
            <c:choose>
            <c:when test="${duration > 1}">
            <label>- ${duration} months </label>
            </c:when>
            <c:otherwise>
            <label>- ${duration} month </label>
            </c:otherwise>
             </c:choose>
            </c:otherwise>   
            </c:choose>
             <div class="smallfontitalic">
             <ul class="dashlisting">
            	<li> Designation - <c:out value="${workDetails.workDesignation}"/></li>
            <li> Responsibilities - <c:out value="${workDetails.workDescription}"/></li>
             
           </ul></div>
           </c:forEach>
            </div>
          </div>
          </c:otherwise>
          </c:choose>
          
           <c:choose> 
         	<c:when test="${empty studentDetails.primarySkills}">
         	<div class="sections disable">
    		<h1 class="headings">Skills</h1>
            <div class="content">Skills is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Skills</h1>
            <div class="content skills">
             
              <c:forEach var="primarySkillsVar" items="${studentDetails.primarySkills}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${primarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			
		 	<c:choose> 
			<c:when test="${studentDetails.secondarySkills != '[]'}">
			<c:forEach var="secondarySkillsVar" items="${studentDetails.secondarySkills}" varStatus="loop" > 
          			 <ul>
          					<li><c:out value="${secondarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			</c:when>
         </c:choose> 
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
          
          <div class="sections">
          <div class ="floatright cvdate"><input type="button" value="Edit" class="orangebuttons" onclick="editExpertiseSimple()" id="buttonSimpleExpertise"></div>
            <h1 class="headings">Expertise</h1><textarea id="expertisecoment" rows="3" cols="80" class="resume_buildtxtarea" ></textarea>
           <!--  <div class="par" id="expertisecoment" style="display:none;" >
                <div class="clear"></div>
                <span class="field">
                    <input  type="text" name="tags1" id="tags1" class="input-large" /> 
                    
                     <div class ="floatright cvdate"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExpertiseSimple()"></div>
                </span> </div> -->
                <div class ="floatright cvdate"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExpertiseSimple()" id="doneSimple"></div>
            <c:choose>
             <c:when test="${empty studentDetails.expertizeList|| fn:length(studentDetails.expertizeList) eq 0}" >
            <div class="content expertise" id="expertise-Simple">
               <ul id="simple-expertise">
                <li> Expertise in various languages and the platforms.</li>
                <li> Expertise in coding and using cutting edge tools.</li>
                <li> Proficient in articulate the strong presentation and technical documents.</li>
                <li> Expertise in training of new recruits.</li>
              </ul>
              </div>
              </c:when>
              <c:otherwise>
              <div class="content expertise" id="expertise-Simple">
              <c:forEach var="expertise" items="${studentDetails.expertizeList}">
              <ul>
              <li><c:out value="${expertise}"></c:out></li>
              </ul>
              </c:forEach>
              </div>
              </c:otherwise>
              </c:choose>
            
          </div>
          
          <c:choose>
         	<c:when test="${empty publicationList}">
          <div class="sections disable">
            <h1 class="headings">Publications</h1>
            <div class="content">Publications is empty and will not be part of cv . Please update portfolio to add.</div>
          </div>
          </c:when>
          
          <c:otherwise>
          <div class="sections">
            <h1 class="headings">Publications</h1>
            <div class="content education">
            
            <c:forEach items="${publicationList}" var="publication">  
           <span><c:out value="${publication.publicationTitle}"/>(<c:out value="${publication.publicationUrl}"/>)</span>
            <p class="floatright cvdate">  
            <c:out value="${publication.publicationDate}" /></p>    
                	   <div class="smallfontitalic">
                	   <ul class="dashlisting">
                	   <li><c:out value="${publication.publisherName}"/></li>
                	   <li><c:out value="${publication.publisherAuthorFirstName}" /> <c:out value="${publication.publisherAuthorLastName}" /></li>
                	   <li><c:out value="${publication.publicationSummary}" /> </li>
                	   </ul>
             </div>
             <br>
            </c:forEach>
           
            </div>
            </div>
          </c:otherwise>
          </c:choose>
          
          <c:choose>           
         	<c:when test="${empty studentDetails.interestList}">
         	<div class="sections disable">
    		<h1 class="headings">Interests</h1>
            <div class="content">Interests is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Interests</h1>
            <div class="content skills">
             
              <c:forEach var="interests" items="${studentDetails.interestList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${interests}"/></li>
          			</ul>       
			</c:forEach>
			
		 	
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
                 
                 <c:choose> 
         	<c:when test="${empty studentDetails.languagesList}">
         	<div class="sections disable">
    		<h1 class="headings">Languages Known</h1>
            <div class="content">Languages Known is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Languages Known</h1>
            <div class="content skills">
             
              <c:forEach var="languages" items="${studentDetails.languagesList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${languages}"/></li>
          			</ul>       
			</c:forEach>
			
		 	
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
                 
          
        </div>
      </div>
        
        <div id="customize-expertise">
          <div class="view-resume">
            <h1 class="name"> 

			<c:set var="photoName" value="${studentDetails.photoName}"/>
                <c:choose>
                      <c:when test="${photoName == null}">
                        <img src="images/Not_available_icon1.png" width="84" height="84" alt="">
                      </c:when>

                      <c:otherwise>
                      <img src="view_image.htm?emailId=${studentDetails.emailID}" width="84" height="84" alt="">
                      </c:otherwise>
                   </c:choose>

	<span class="fullname"><c:out value="${studentDetails.firstName}"/> &nbsp; <c:out value="${studentDetails.lastName}"/></span>
<p class="designation"><c:out value="${studentDetails.designation}"/></p>
	<div class="address"><c:out value="${studentDetails.address}"/>,<c:out value="${studentDetails.zipCode}"/>,<c:out value="${studentDetails.city}"/> (<c:out value="${studentDetails.state}"/>)
	<br><span class="mobileno">Mobile No:</span> <span><c:out value="${studentDetails.mobileNumber}"/></span>  <span class="emailid">Email Id :</span> <span><c:out value="${studentDetails.emailID}"/></span></div>
	</h1>
            <div class="sections">
            <div class ="floatright clear"><input type="button" value="Edit" class="orangebuttons" onclick="editContentExpertize()" id="buttonExpertize"></div>
              <h1 class="headings">Career Objective</h1>
             <div class="float_left clear width100" id="expertiseDiv" style="display: block;width: 100%;"><textarea id="text-Expertize" rows="3" cols="92" class="resume_buildtxtarea"></textarea>
              <div class="floatright clear"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceContentExpertize()" id="contentExpertiseDone"></div></div>
              
              <c:choose>
            <c:when test="${empty studentDetails.careerObjective}">
            <div class="content" id="content-Expertize">To make a sound position in corporate world and work enthusiastically in team to achieve goal of the organization/MNC with devotion and hard work.</div>
            </c:when>
            <c:otherwise>
            <div class="content" id="content-Expertize"><c:out value="${studentDetails.careerObjective}"></c:out></div>
            </c:otherwise>
            </c:choose>
              
            </div>
            
            <c:choose>
         	<c:when test="${empty studentDetails.aboutYourSelf}">
    		<div class="sections disable">
    		 <h1 class="headings">Summary</h1>
            <div class="content">Summary is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
			</c:when>
			
			<c:otherwise>
			<div class="sections">
			 <h1 class="headings">Summary</h1>
            <div class="content"><c:out value="${studentDetails.aboutYourSelf}"/></div>
			</div>
			</c:otherwise>
          </c:choose>
          
         
            <div class="sections">
              <h1 class="headings">Education</h1>
              <div class="content education">
                <ul>
                
                 <c:choose>
         	<c:when test="${empty universityList}">
         	<div class="sections disable">
    		
            <div class="content">University Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
            <c:otherwise>
 					<c:forEach items="${universityList}" var="universityDetails">
                  <li> <p class="floatright cvdate"><c:choose>
                <c:when test="${universityDetails.universityMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${universityDetails.universityYearFrom}"/> - <c:choose>
                <c:when test="${universityDetails.universityMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${universityDetails.universityYearTo}"/></p>
               <span><c:out value="${universityDetails.universityCourseType}"/>
                <span class="smallfontitalic">(<c:out value="${universityDetails.universityGpaFrom}"/> Out of <c:out value="${universityDetails.universityGpaTo}"/>) </span></span>
               
                    <label>${universityDetails.universityCourseName} - ${universityDetails.universityName} </label>
                  </li>
                  </c:forEach>
                  </c:otherwise>
            </c:choose>
            
         <c:choose>
         	<c:when test="${empty schoolDetails}">
         	<div class="sections disable">
            <div class="content">School Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         <c:otherwise>  
                  
                  <li><p class="floatright cvdate"><c:choose>
                <c:when test="${schoolDetails.schoolPassingMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>  <c:out value="${schoolDetails.schoolPassingYear}"/> <%-- - <c:choose>
                <c:when test="${studentDetails.h_endMonth_duration == '1'}">
                  Jan
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '2'}">
                  Feb
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '3'}">
                  March
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '4'}">
                  April
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '5'}">
                  May
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '6'}">
                  June
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '7'}">
                  July
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '8'}">
                  Aug
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '9'}">
                  Sept
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '10'}">
                  Oct
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '11'}">
                  Nov
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${studentDetails.h_endYear_duration}"/> --%>
               </p>
               <span>${schoolDetails.schoolName}
                <span class="smallfontitalic">(<c:out value="${schoolDetails.schoolGpaFrom}"/> Out of <c:out value="${schoolDetails.schoolGpaTo}"/>)</span> 
               </span>
              
                    
                    <label>${schoolDetails.schoolState}</label>
         
                  </li>
                
                
                 </c:otherwise>
            </c:choose>
            </ul>
                
              </div>
            </div>
            <c:choose>
         	<c:when test="${empty certificationList}">
            <div class="sections disable">
              <h1 class="headings">Certifications</h1>
              <div class="content">Certifications is empty and will not be part of cv . Please update portfolio to add.</div>
            </div>
            </c:when>
            
            <c:otherwise>
            <div class="sections">
              <h1 class="headings">Certifications</h1>
              <div class="content experience">
              <c:forEach items="${certificationList}" var="certification">  
           <span><c:out value="${certification.certificateName}"/>(<c:out value="${certification.certificateNumber}"/>)</span>
            <p class="floatright cvdate">  
            <c:choose>
                <c:when test="${certification.certificationStartMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationStartMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationStartMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationStartYear}" /> - 
                	   
        <c:if test="${empty certification.certificationEndMonth}">
        Certificate Does Not Expire
        </c:if>
        <c:if test="${not empty certification.certificationEndMonth}"> 
                	     <c:choose>
                <c:when test="${certification.certificationEndMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationEndMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationEndMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationEndYear}" />
                	   </c:if>  
                	   </p>    
                	   <div class="smallfontitalic">
                	   <c:out value="${certification.certificateAuthority}"/>
             </div>
             <br>
            </c:forEach>
              </div>
              </div>
            </c:otherwise>
            </c:choose>
            
             <c:choose>
         	<c:when test="${empty workDetails}">
         	<div class="sections disable">
    		<h1 class="headings">Experience</h1>
            <div class="content">Experience is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise>
            
            <div class="sections">
           
              <h1 class="headings">Experience</h1>
              <div class="content experience"> 
               <c:forEach items="${workDetails}" var="workDetails">
                <p class="floatright cvdate">
                <c:choose>
                <c:when test="${workDetails.workMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose>
               
               <c:out value="${workDetails.workYearFrom}"/> - 
 
                 <c:choose>
                <c:when test="${workDetails.workMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose>
                <c:out value="${workDetails.workYearTo}"/>
                </p>
                <span> <c:out value="${workDetails.workCompanyName}"/></span>
                
                <c:choose>
            <c:when test="${workDetails.workYearTo > workDetails.workYearFrom}">
	            <c:set var = "duration" value="${workDetails.workYearTo - workDetails.workYearFrom}"></c:set>
	            <c:choose>
	            <c:when test="${duration > 1}">
	            <label>- ${duration} years </label>
	            </c:when>
	            <c:otherwise>
	            <label>- ${duration} year </label>
	            </c:otherwise>
	            </c:choose>
            </c:when>
            <c:otherwise>
            <c:set var = "duration" value="${workDetails.workMonthTo - workDetails.workMonthFrom}"></c:set>
            <c:choose>
            <c:when test="${duration > 1}">
            <label>- ${duration} months </label>
            </c:when>
            <c:otherwise>
            <label>- ${duration} month </label>
            </c:otherwise>
             </c:choose>
            </c:otherwise>   
            </c:choose>
             
                <div class="smallfontitalic">
                  <ul class="dashlisting">
                    <li> - Designation - <c:out value="${workDetails.workDesignation}"/></li>
                    <li> - Responsibilities - <c:out value="${workDetails.workDescription}"/></li>
                    
                  </ul>
                </div>
                </c:forEach>
              </div>
            </div>
            </c:otherwise>
            </c:choose>
        
            <c:choose> 
         	<c:when test="${empty studentDetails.primarySkills}">
         	<div class="sections disable">
    		<h1 class="headings">Skills</h1>
            <div class="content">Skills is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Skills</h1>
            <div class="content skills">
             
              <c:forEach var="primarySkillsVar" items="${studentDetails.primarySkills}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${primarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			
		 	<c:choose> 
			<c:when test="${studentDetails.secondarySkills != '[]'}">
			<c:forEach var="secondarySkillsVar" items="${studentDetails.secondarySkills}" varStatus="loop" > 
          			 <ul>
          					<li><c:out value="${secondarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			</c:when>
         </c:choose> 
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
            
            <div class="sections">
            <div class ="floatright clear"><input type="button" value="Edit" class="orangebuttons" onclick="editExpertiseFunction()" id="editExpertise"></div>
              <h1 class="headings">Expertise</h1>
               <!--   <div class="par" id="divExpertise" style="display:none;" >
                <div class="clear"></div>
                <span class="field">
                  <input  type="text" name="tags" id="tags" class="input-large" />  
                    
                     <div class ="floatright clear"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExpertise()"></div>
                </span> </div> -->
                
                <div class="float_left clear width100" id="divExpertise" style="display: block;width: 100%;"><textarea id="expertizeText" rows="3" cols="92" class="resume_buildtxtarea"></textarea>
              <div class="floatright clear"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExpertise()" id="expertiseDone"></div></div>
              
              <c:choose>
             <c:when test="${empty studentDetails.expertizeList|| fn:length(studentDetails.expertizeList) eq 0}" >
              <div class="content expertise" id="expertiseVal">
                <ul>
                  <li> Expertise in various languages and the platforms.</li>
                  <li> Expertise in coding and using cutting edge tools.</li>
                  <li> Proficient in articulate the strong presentation and technical documents.</li>
                  <li> Expertise in training of new recruits.</li>
                </ul>
              </div>
              </c:when>
                 <c:otherwise>
              <div class="content expertise" id="expertiseVal">
              <c:forEach var="expertise" items="${studentDetails.expertizeList}">
              <ul>
              <li><c:out value="${expertise}"></c:out></li>
              </ul>
              </c:forEach>
              </div>
              </c:otherwise>
              </c:choose>
              </div>
              <c:choose>
         	<c:when test="${empty publicationList}">
          <div class="sections disable">
            <h1 class="headings">Publications</h1>
            <div class="content">Publications is empty and will not be part of cv . Please update portfolio to add.</div>
          </div>
          </c:when>
          
          <c:otherwise>
           <div class="sections">
            <h1 class="headings">Publications</h1>
            <div class="content experience">
            <c:forEach items="${publicationList}" var="publication">  
           <span><c:out value="${publication.publicationTitle}"/>(<c:out value="${publication.publicationUrl}"/>)</span>
            <p class="floatright cvdate">  
            <c:out value="${publication.publicationDate}" /></p>    
                	   <div class="smallfontitalic">
                	   <ul class="dashlisting">
                	   <li><c:out value="${publication.publisherName}"/></li>
                	   <li><c:out value="${publication.publisherAuthorFirstName}" /> <c:out value="${publication.publisherAuthorLastName}" /></li>
                	   <li><c:out value="${publication.publicationSummary}" /> </li>
                	   </ul>
             </div>
             <br>
            </c:forEach>
            </div>
            </div>
          </c:otherwise>
          </c:choose>
              
              <c:choose>           
         	<c:when test="${empty studentDetails.interestList}">
         	<div class="sections disable">
    		<h1 class="headings">Interests</h1>
            <div class="content">Interests is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Interests</h1>
            <div class="content skills">
             
              <c:forEach var="interests" items="${studentDetails.interestList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${interests}"/></li>
          			</ul>       
			</c:forEach>
			
		 	
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
                 
                 <c:choose> 
         	<c:when test="${empty studentDetails.languagesList}">
         	<div class="sections disable">
    		<h1 class="headings">Languages Known</h1>
            <div class="content">Languages Known is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise> 
          <div class="sections">
            <h1 class="headings">Languages Known</h1>
            <div class="content skills">
             
              <c:forEach var="languages" items="${studentDetails.languagesList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${languages}"/></li>
          			</ul>       
			</c:forEach>
			
		 	
          </div>
          </div>
          </c:otherwise> 
                 </c:choose> 
                 
              
            
          </div>
        </div>
      
      
      <div id="customize-executive">
          <div class="view-resume">
            <h1 class="name">
              <div class="first-name"><c:out value="${studentDetails.firstName}"/> &nbsp; <c:out value="${studentDetails.lastName}"/></div>
              <div class="address"><c:out value="${studentDetails.address}"/>,<c:out value="${studentDetails.zipCode}"/>,<br><c:out value="${studentDetails.city}"/> (<c:out value="${studentDetails.state}"/>)
               <span class="mobileno">Mobile No: <span><c:out value="${studentDetails.mobileNumber}"/></span> </span><span class="emailid">Email Id : <span><c:out value="${studentDetails.emailID}"/></span></span> </div>
            </h1>
            <div class="sections">
			<h1 class="headings">Career Objective <div class ="floatright cvdate"><input type="button" value="Edit" class="bluebutton" onclick="editContentExecutive()" id="buttonExecutive"></div></h1>
			<textarea id="text-Executive" rows="3" cols="80" class="resume_buildtxtarea"></textarea>
             <div class ="floatright cvdate"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceContentExecutive()" id="contentExecutiveDone"></div>
             <c:choose>
            <c:when test="${empty studentDetails.careerObjective}">
            <div class="content" id="content-Executive">To make a sound position in corporate world and work enthusiastically in team to achieve goal of the organization/MNC with devotion and hard work.</div>
            </c:when>
            <c:otherwise>
            <div class="content" id="content-Executive"><c:out value="${studentDetails.careerObjective}"></c:out></div>
            </c:otherwise>
            </c:choose>
             
            </div>
                       
            <c:choose>
         	<c:when test="${empty studentDetails.aboutYourSelf}">
    		<div class="sections disable">
    		<h1 class="headings">Summary</h1>
            <div class="content">Summary is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
			</c:when>
			
			<c:otherwise>
			<div class="sections">
			<h1 class="headings">Summary</h1>
            <div class="content"><c:out value="${studentDetails.aboutYourSelf}"/></div>
			</div>
			</c:otherwise>
          </c:choose>
            
            
            <div class="sections">
              <h1 class="headings">Education</h1>
              <div class="content">
                <div class="contdetails">
                
                <c:choose>
         	<c:when test="${empty universityList}">
         	<div class="sections disable">
    		
            <div class="content">University Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
            <c:otherwise>
                <c:forEach items="${universityList}" var="universityDetails">
                  <div class="title">
                  <p class="cvdate"><c:choose>
                <c:when test="${universityDetails.universityMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${universityDetails.universityYearFrom}"/> - <c:choose>
                <c:when test="${universityDetails.universityMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${universityDetails.universityMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${universityDetails.universityMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${universityDetails.universityMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose> 
               <c:out value="${universityDetails.universityYearTo}"/></p>
               <c:out value="${universityDetails.universityCourseType}"/>
                  <span class="smallfontitalic">(<c:out value="${universityDetails.universityGpaFrom}"/> Out of <c:out value="${universityDetails.universityGpaTo}"/>)</span>
                   </div>
                  <div class="label"><c:out value="${universityDetails.universityCourseName}"/> - <c:out value="${universityDetails.universityName}"/>
                  </div>
                  </c:forEach>
           </c:otherwise>
            </c:choose>
            </div>
        
         <div class="contdetails">
          <c:choose>
         	<c:when test="${empty schoolDetails}">
         	<div class="sections disable">
    		
            <div class="content">School Details incomplete and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>

                 <c:otherwise>  
                 
                  <div class="title"><p class="cvdate"><c:choose>
                  <c:when test="${schoolDetails.schoolPassingMonth == '1'}">
                  Jan			
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${schoolDetails.schoolPassingMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${schoolDetails.schoolPassingMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${schoolDetails.schoolPassingMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>  <c:out value="${schoolDetails.schoolPassingYear}"/><%--  - <c:choose>
                <c:when test="${studentDetails.h_endMonth_duration == '1'}">
                  Jan
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '2'}">
                  Feb
                </c:when>
                <c:when test="${studentDetails.h_endMonth_duration == '3'}">
                  March
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '4'}">
                  April
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '5'}">
                  May
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '6'}">
                  June
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '7'}">
                  July
                </c:when>
                  <c:when test="${studentDetails.h_endMonth_duration == '8'}">
                  Aug
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '9'}">
                  Sept
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '10'}">
                  Oct
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '11'}">
                  Nov
                </c:when>
                 <c:when test="${studentDetails.h_endMonth_duration == '12'}">
                  Dec
                </c:when>
               </c:choose> <c:out value="${studentDetails.h_endYear_duration}"/> --%>
               </p>
               <c:out value="${schoolDetails.schoolName}"/>
                  <span class="smallfontitalic">(<c:out value="${schoolDetails.schoolGpaFrom}"/> Out of <c:out value="${schoolDetails.schoolGpaTo}"/>) </span>
                  
               </div>
                  <div class="label"><c:out value="${schoolDetails.schoolState}"/> </div>
                 
                  
                  </c:otherwise>
            </c:choose>
                  
                </div>
             
                
              </div>
            </div>
            
            <c:choose>
         	<c:when test="${empty certificationList}">
            <div class="sections disable">
              <h1 class="headings">Certifications</h1>
              <div class="content">Certifications is empty and will not be part of cv . Please update portfolio to add.</div>
            </div>
            </c:when>
            
            <c:otherwise>
            <div class="sections">
              <h1 class="headings">Certifications</h1>
              <div class="content">
               <div class="contdetails">
               <c:forEach items="${certificationList}" var ="certification">
                <div class="title">  
                 <c:out value="${certification.certificateName}"/>(<c:out value="${certification.certificateNumber}"/>)
                 <p class="cvdate">
                 <c:choose>
                <c:when test="${certification.certificationStartMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationStartMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationStartMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationStartMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationStartMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationStartYear}" /> - 
                	   
        <c:if test="${empty certification.certificationEndMonth}">
        Certificate Does Not Expire
        </c:if>
        <c:if test="${not empty certification.certificationEndMonth}"> 
                	     <c:choose>
                <c:when test="${certification.certificationEndMonth == '1'}">
                  Jan
                </c:when>
                <c:when test="${certification.certificationEndMonth == '2'}">
                  Feb
                </c:when>
                <c:when test="${certification.certificationEndMonth == '3'}">
                  March
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '4'}">
                  April
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '5'}">
                  May
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '6'}">
                  June
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '7'}">
                  July
                </c:when>
                  <c:when test="${certification.certificationEndMonth == '8'}">
                  Aug
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '9'}">
                  Sept
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '10'}">
                  Oct
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '11'}">
                  Nov
                </c:when>
                 <c:when test="${certification.certificationEndMonth == '12'}">
                  Dec
                </c:when>
               </c:choose>
                	    
                	    <c:out value="${certification.certificationEndYear}" />
                	   </c:if>  
                </p>  
                </div>
                <div class="smallfontitalic">
                  <c:out value="${certification.certificateAuthority}" />
                </div>
                <br>
                </c:forEach>
                
               
               </div>
               </div>
              </div>
            </c:otherwise>
            </c:choose>
            
            
            <c:choose>
         	<c:when test="${empty workDetails}">
         	<div class="sections disable">
    		<h1 class="headings">Experience</h1>
            <div class="content">Experience is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         <c:otherwise>
             <div class="sections">
              <h1 class="headings">Experience</h1>
              <div class="content">
               <div class="contdetails">
 				<c:forEach items="${workDetails}" var="workDetails">
                <div class="title">  <p class="cvdate">
                <c:choose>
                <c:when test="${workDetails.workMonthFrom == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthFrom == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthFrom == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthFrom == '12'}">
                  Dec
                </c:when>
               </c:choose>
               
               <c:out value="${workDetails.workYearFrom}"/> - 
 
                 <c:choose>
                <c:when test="${workDetails.workMonthTo == '1'}">
                  Jan
                </c:when>
                <c:when test="${workDetails.workMonthTo == '2'}">
                  Feb
                </c:when>
                <c:when test="${workDetails.workMonthTo == '3'}">
                  March
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '4'}">
                  April
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '5'}">
                  May
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '6'}">
                  June
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '7'}">
                  July
                </c:when>
                  <c:when test="${workDetails.workMonthTo == '8'}">
                  Aug
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '9'}">
                  Sept
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '10'}">
                  Oct
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '11'}">
                  Nov
                </c:when>
                 <c:when test="${workDetails.workMonthTo == '12'}">
                  Dec
                </c:when>
               </c:choose>
                <c:out value="${workDetails.workYearTo}"/>
                </p>
                <c:out value="${workDetails.workCompanyName}"/>
                
                </div>
                <c:choose>
            <c:when test="${workDetails.workYearTo > workDetails.workYearFrom}">
	            <c:set var = "duration" value="${workDetails.workYearTo - workDetails.workYearFrom}"></c:set>
	            <c:choose>
	            <c:when test="${duration > 1}">
	            <label>- ${duration} years </label>
	            </c:when>
	            <c:otherwise>
	            <label>- ${duration} year </label>
	            </c:otherwise>
	            </c:choose>
	            </c:when>
            <c:otherwise>
            <c:set var = "duration" value="${workDetails.workMonthTo - workDetails.workMonthFrom}"></c:set>
            <c:choose>
            <c:when test="${duration > 1}">
            <label>- ${duration} months </label>
            </c:when>
            <c:otherwise>
            <label>- ${duration} month </label>
            </c:otherwise>
             </c:choose>
            </c:otherwise>   
            </c:choose>
                
                <div class="smallfontitalic">
                  <ul class="dashlisting">
                    <li> - Designation - <c:out value="${workDetails.workDesignation}"/></li>
                    <li> - Responsibilities - <c:out value="${workDetails.workDescription}"/></li>
                    <!-- <li>- Unit testing of the modules coded on</li> -->
                  </ul>
                </div>
                </c:forEach>
                </div>
              </div>
            </div>
            </c:otherwise>
            </c:choose>
            
            <c:choose> 
         	<c:when test="${empty studentDetails.primarySkills}">
         	<div class="sections disable">
    		<h1 class="headings">Skills</h1>
            <div class="content">Skills is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         	<c:otherwise> 
            
             <div class="sections">
              <h1 class="headings">Skills</h1>
              <div class="content">
              <div class="contdetails skills">
               <!--  <ul>
                  <li>Code Reviews</li>
                  <li>Agile</li>
                  <li>HTML/XML</li>
                  <li>Ruby</li>
                  <li>Linux</li>
                </ul> -->
                
                <c:forEach var="primarySkillsVar" items="${studentDetails.primarySkills}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${primarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			
		 	<c:choose> 
			<c:when test="${studentDetails.secondarySkills != '[]'}">
			<c:forEach var="secondarySkillsVar" items="${studentDetails.secondarySkills}" varStatus="loop" > 
          			 <ul>
          					<li><c:out value="${secondarySkillsVar}"/></li>
          			</ul>       
			</c:forEach>
			</c:when>
         </c:choose> 
                
                </div>
              </div>
            </div>
            
            </c:otherwise>
            </c:choose>
            
            <div class="sections">
              <h1 class="headings">Expertise<div class ="floatright cvdate"><input type="button" value="Edit" class="bluebutton" onclick="editExecutiveFunction()" id="editExecutive"></div></h1>
              <div class="content">
                <!--   <div class="par" id="executiveComent" style="display:none;" >
                <div class="clear"></div>
                <span class="field">
                    <input  type="text" name="primarySkills" id="primarySkills" class="input-large"></input>
                    
                     <div class ="floatright cvdate"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExecutive()"></div>
                </span> </div> -->
                <textarea id="executiveComent" rows="3" cols="80" class="resume_buildtxtarea"></textarea>
             <div class ="floatright cvdate"><input type="button" value="Done" class="orangebuttons margintop15" onclick="replaceExecutive()" id="doneExecutive"></div>
                <c:choose>
            <c:when test="${empty studentDetails.expertizeList|| fn:length(studentDetails.expertizeList) eq 0}" >
               <div class="contdetails expertise" id="divExecutive">
                <ul>
                  <li> Expertise in various languages and the platforms.</li>
                  <li> Expertise in coding and using cutting edge tools.</li>
                  <li> Proficient in articulate the strong presentation and technical documents.</li>
                  <li> Expertise in training of new recruits.</li>
                </ul>
                </div>
              
                </c:when>
                <c:otherwise>
                 <div class="contdetails expertise" id="divExecutive">
              <c:forEach var="expertise" items="${studentDetails.expertizeList}">
              <ul>
              <li><c:out value="${expertise}"></c:out></li>
              </ul>
              </c:forEach>
              </div>
             
                </c:otherwise>
                </c:choose>
              </div>
            </div>
            
            <c:choose>
         	<c:when test="${empty publicationList}">
          <div class="sections disable">
            <h1 class="headings">Publications</h1>
            <div class="content">Publications is empty and will not be part of cv . Please update portfolio to add.</div>
          </div>
          </c:when>
          
          <c:otherwise>
          <div class="sections">
            <h1 class="headings">Publications</h1>
            <div class="content experience">
            <div class="content">
               <div class="contdetails">
               
            <c:forEach items="${publicationList}" var="publication">  
            <div class="title">
           <span><c:out value="${publication.publicationTitle}"/>(<c:out value="${publication.publicationUrl}"/>)</span>
            <p class="floatright cvdate">  
            <c:out value="${publication.publicationDate}" /></p>
            </div>
                	   <div class="smallfontitalic">
                	   <ul class="dashlisting">
                	   <li><c:out value="${publication.publisherName}"/></li>
                	   <li><c:out value="${publication.publisherAuthorFirstName}" /> <c:out value="${publication.publisherAuthorLastName}" /></li>
                	   <li><c:out value="${publication.publicationSummary}" /> </li>
                	   </ul>
             </div>
             <br>
            </c:forEach>
           </div>
           </div>
            </div>
            </div>
          </c:otherwise>
          </c:choose>
          
            <c:choose> 
         	<c:when test="${empty studentDetails.interestList}">
         	<div class="sections disable">
    		<h1 class="headings">Interests</h1>
            <div class="content">Interests is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         	<c:otherwise> 
            
             <div class="sections">
              <h1 class="headings">Interests</h1>
              <div class="content">
              <div class="contdetails skills">
                <c:forEach var="interests" items="${studentDetails.interestList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${interests}"/></li>
          			</ul>       
			</c:forEach>
		   </div>
              </div>
            </div>
            
            </c:otherwise>
            </c:choose>
            
            <c:choose> 
         	<c:when test="${empty studentDetails.languagesList}">
         	<div class="sections disable">
    		<h1 class="headings">Languages Known</h1>
            <div class="content">Languages Known is empty and will not be part of cv . Please update portfolio to add.</div>
          	</div>
         	</c:when>
         
         	<c:otherwise> 
            
             <div class="sections">
              <h1 class="headings">Languages Known</h1>
              <div class="content">
              <div class="contdetails skills">
               
                <c:forEach var="languages" items="${studentDetails.languagesList}" varStatus="loop" > 
          			 <ul>
          				<li><c:out value="${languages}"/></li>
          			</ul>       
			</c:forEach>
			</div>
              </div>
            </div>
            
            </c:otherwise>
            </c:choose>
            
          </div>
        </div>
      
        <div class="buttonPan"><input name="download" type="button" value="Download PDF" class="download margin_top2" onclick="createPDF()"></div>
   	<div class="clear"></div>
  
    </div>
    </form>  
    </div>
  
    
  
    <div class="clear"></div>
    <div class="bottomspace">&nbsp;</div>
  </div>
  <!--------------  Middle Section :: end -----------> 
  <!--------------  Common Footer Section :: start ----------->
  <%@ include file="includes/footer.jsp"%>
  <!--------------  Common Footer Section :: end -----------> 
</div>
</body>
</html>
