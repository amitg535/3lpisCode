<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="keywords"  content="fullpage,jquery,demo,screen,fullscreen,backgrounds,full-screen" />
<title>Candidate Advanced Search</title>
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
function saveSearchFunction()
{

		if( $("#check2").is(':checked'))
		{
			var searchParameterNameValue=$("#searchParameterName").val();
			var searchTrimmed=$.trim(searchParameterNameValue);
			
				if(searchTrimmed!="" && searchTrimmed.length!=0)
				{
					var formDetailsPublish = document.getElementById('advancedSearch');
				 	 document.forms[0].action = "candidate_search_jobs_internships.htm?action=saveSearch";
				 	 formDetailsPublish.submit();
				 	 return true;
				}
				else
				{		$("#saveSearchErrorLabel").html("");
			          	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
			          	return false;
				}
		}
	
		else
			{
				$("#saveSearchErrorLabel").html("");
	        	$("#saveSearchErrorLabel").html("<label class='error'>Save Search Name is Mandatory.</label>");
	        	return false;
			}
	return false;

}
	
	
</script>

<script>
function goBack()
{
  window.history.back();
}
  
  
  
</script>
<script type="text/javascript">
function showhideFaculty(faculty_type) {
    
	if (faculty_type == "jobs") 
	{
		 $("#industry").css('display','block');
	}
	else
    {
		 $("#industry").css('display','none');
	}
	
}
</script>
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:38.5% !important;}
</style>

<script type="text/javascript">

$(document).ready(function () {

    $('#saveSearchForm').validate({
        rules: {
            check2: {
                required: 'input[type="checkbox"]:checked',
                
            },
            searchParameterName:{required:true}
    
        },
        messages: {
            check2: {
                required: "You must check this box"
               
            },
            searchParameterName:{required:"You must Enter a Search Paramter Name"}
        }
    });

    $("#keywords").on('change keyup paste',function(){
   	 
		suggestKeywords();
	}); 

});
</script>


<!-- Added by Trishna R -->
<script type ="text/javascript">
$(function(){
    $("#advancedSearch").submit(function(){

        var valid=0;
        
        $(this).find('input[type=text], select').each(function(){
            if($(this).val() != "") valid+=1;
        });

        if(valid){
           return true;
        }
        else {
           
            $("#searchErrorLabel").html("");
            $("#searchErrorLabel").html("<label class='error'>Enter at least one search parameter!</label>");
            
            return false;
        }
    });
});
</script>
<style>
.ui-autocomplete{background: rgb(255, 255, 255) !important; border: 1px solid rgb(204, 204, 204) !important; width:38.5% !important;}
</style>
 <script type="text/javascript">
function suggestKeywords(){

	var enteredText=$("#keywords").val();
	$.getJSON( "/get_suggested_keywords.json",'enteredText='+enteredText, function( returnedWords ) {
  /* alert("returnedWords"+returnedWords); */
	 var returned=[];
		returned=returnedWords;
		   $( "#keywords" ).autocomplete({
	         source: returned,
	 	 focus: function( event, ui ) {
	        	 
	        	 var displayProperty=$("#ui-id-2").css("display");
	             if(displayProperty=="block"){
	            	 $.fn.fullpage.setKeyboardScrolling(false);
	            	 $.fn.fullpage.setAllowScrolling(false);
	             }
	            },
	            close: function( event, ui ) {
	                
	                var displayProperty=$("#ui-id-2").css("display");
	                  if(displayProperty=="none"){
	                   $.fn.fullpage.setKeyboardScrolling(false);
	                   $.fn.fullpage.setAllowScrolling(true);
	                  } 
	                
	                 }
	       }); 

	   //Hide message shown after search is retrieved (Eg. 3 results match your search, use mouse keys)
	   $("span.ui-helper-hidden-accessible").hide();

	 	   
	   $( "#keywords" ).on( "autocompletefocus", function( event, ui ) {} );
	   $( "#keywords" ).on( "autocompleteclose", function( event, ui ) {} ); 
		 });

}

</script>

</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp"%>
  <!--------------  Header Section :: end -----------> 
  
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
    <div id="innerbanner">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!"></div>
      <div class="clear"></div>
    </div> 
  


    
    <div id="innersection">
        <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a>\ Advanced Search</div>
  
      <section id="rightwrap" class="floatleft">
        <h1 class="sectionheading"> Advanced Search</h1>
        <div id="candidate_registration_wrap">
          <div class="form_wrap">
            <form:form action="" method="post" modelAttribute="searchJobs" cssClass="stdform" id="advancedSearch">
              <div class="fullwidth_form">
              <div class="par">
              
              <span id = "searchErrorLabel"></span>
              
                  <label class="floatleft" style="padding-top:0.2em"><strong>Search By:</strong> &nbsp;</label>
                <span class="formwrapper" >
               <form:radiobutton path="searchCriteria" value="Jobs" checked = "checked"  OnClick="showhideFaculty('jobs')"  />Jobs &nbsp;&nbsp;&nbsp;&nbsp; 
                <form:radiobutton path="searchCriteria" value="Internships" OnClick="showhideFaculty('internships')" />Internships
                </span>
                
              </div>
             
                  
                  </div>
              <div class="leftsection_form">
                
              <div class="par">
                  <label class="floatleft">Keyword</label>
                  <div class="clear"></div>
                  <span class="field">
				  <form:input path="keyword" cssClass="input-xxlarge" id="keywords" />
                  <form:errors path="keyword"  cssClass="input-xxlarge"/>                
                  </span> </div> 
                  
                   <div class="par" >
                 <label>Functional Area</label>
               <form:select data-placeholder="Choose an Option" path="functionalArea" cssClass="chzn-select list_widthstyle1" >
              
                  <form:option value="">Choose an Option</form:option>
                <c:forEach var="functionalArea" items="${functionalAreaList}">
                 
                   
                         <option value="<c:out value="${functionalArea}" />"><c:out value="${functionalArea}" /></option> 
                                     
                   </c:forEach>
                 
                  </form:select>
                </div>
                  
              </div>
              <div class="rightsection_form">
                <div class="par" id="city">
                  <label class="floatleft">City</label>
                  <div class="clear"></div>
                    <span class="field">
                    <form:input path="location" cssClass="input-xxlarge" />
                    <form:errors path="location"  cssClass="input-xxlarge"/>
                  </span>  </div>
                  
                  
             <div class="par" id="industry">
                  <label class="floatleft">Industry</label>
                  <div class="clear"></div>
                  <span class="formwrapper">
                  <form:select data-placeholder="Choose an Option" path = "industry"  cssClass="chzn-select list_widthstyle1">
                   
                    <form:option value="">Choose an Option</form:option>
                    <c:forEach var="industryList" items="${industryList}">
                   
                         <option value="<c:out value="${industryList}" />"><c:out value="${industryList}" /></option> 
                                     
                   </c:forEach>
                 
                  </form:select>
                  </span> </div>
               
               
                  
              </div>
              <div class="clear"></div>
              <form id="saveSearchForm">
              <span id = "saveSearchErrorLabel"></span>
              
              <div class="fullwidth_form">
              	<div class="par"> <span class="formwrapper">
                  <input type="checkbox" name="check2"  id="check2" onClick="$(this).is(':checked') && $('#checked').slideDown('slow') || $('#checked').slideUp('slow');" />
                  Save Search Parameter </span> </div>
                <div class="par">
                	<div id="checked" class="showhide_text">
                  <label class="floatleft">Parameter Name</label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <%-- <span class="field">
                  <form:input path="searchParameterName" cssClass="input-xxlarge1" id="searchParameterName"/>
                  <form:errors path="searchParameterName"  cssClass="input-xxlarge1"/>
                  </span> --%> 
                  <span class="field">
                  <form:input path="parameterName" cssClass="input-xxlarge1" id="searchParameterName"/>
                  <form:errors path="parameterName"  cssClass="input-xxlarge1"/>
                  </span>
                  </div>
                </div>
                <div class="doublebottom_margin">
                <div class="buttonwrap">
                <input name="saveSearch" type="button" value="Save Search" id="saveSearch" onclick="saveSearchFunction()">
               	<input name="search" type="submit" value="Search" >
                <input name="" type="button" value="Back" onclick="goBack()">
              </div>
              </div>
              
              </div>
            </form>
            </form:form>
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


 <script type="text/javascript">


$(document).ready(function(){
	$("#advancedSearch").validate({
		rules: {
			keywords:"required",
			searchParameterName:"required"
			
		},
		messages: {
			keywords:"Keyword can't be left Empty",
			searchParameterName:"Search Parameter Needs to be entered"
		}
	});
	
	
	
});
</script>  
</body>
</html>