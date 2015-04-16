<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"><!--<![endif]-->

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Manage Connections</title>
<meta name="title" content="">
<meta name="description" content="">
<meta name="author" content="Your Name Here">
<meta name="Copyright" content="Copyright Your Name Here 2011. All Rights Reserved.">

<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Mobile Specific Metas -->

<!-- CSS -->
<link rel="stylesheet" href="../mobile_html/css/style.css">
<link rel="stylesheet" href="../mobile_html/css/jquery.fs.selecter.css" type="text/css" media="all" />
<!-- CSS -->

<!-- Favicons -->
<link rel="shortcut icon" href="../mobile_html/images/favicon.ico">
<link rel="apple-touch-icon" href="../mobile_html/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="../mobile_html/images/apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="../mobile_html/images/apple-touch-icon-114x114.png" />
<!-- Favicons -->

<script src="../mobile_html/js/jquery-latest.min.js" type="text/javascript"></script>
<script src="../mobile_html/js/hide-address-bar.js" type="text/javascript"></script>
<script type="text/javascript" src="../mobile_html/js/menu.js"></script>

<script type="text/javascript"> 
function registerStudentDivShow(){
		   $("#emailAddress").val('');
		   $("#batch").prop("selectedIndex", 0);
		   $("#registerStudentDiv").show();
		}  
</script>

<script type="text/javascript"> 
$(document).ready(function() {
 
 $("#registerStudentDiv").hide();

 //Error display on form
 var error = "${error}" ;
 var invalid="${invalid}";
 var duplicate="${duplicate}";
 
 if(error!="" || invalid!="" || duplicate!=""){
  
   $("#registerStudentDiv").show();
   } 
 
}); 
</script>

<script>
$(document).ready(function(){
		$(window).bind("orientationchange.fm_optimizeInput", fm_optimizeInput);

		var text = $("#about").val();
		text = text.replace(/\n\r?/g, '<br />');
		$("#display").html(text);
		
	});
	
	function fm_optimizeInput(){
    	$("input[placeholder],textarea[placeholder]").each(function(){
    		var tmpText = $(this).attr("placeholder");
    		if ( tmpText != "" ) {
				$(this).attr("placeholder", "").attr("placeholder", tmpText);
    		}
    	})
    }
</script>
<script src="../mobile_html/js/jquery.fs.selecter.js"></script>
 <script>
  	$(document).ready(function() {
  	  	$(".selecter_basic").selecter();
		
    	$(".selecter_label").selecter({
			defaultLabel: "Select An Item"
		});

    });
  
	function selectCallback(value, index) {
        alert("SELECTED VALUE: " + value + ", INDEX: " + index);
	}
  
  function toggleEnabled() {
    if ($(".selecter_disabled").is(":disabled")) {
    	$(".selecter_disabled").selecter("enable");
      $(".enable_selecter").hide();
      $(".disable_selecter").show();
    } else {
      $(".selecter_disabled").selecter("disable");
      $(".enable_selecter").show();
      $(".disable_selecter").hide();
    }
    return false;
  }
</script> 




<script type="text/javascript">
function addCandidate(){
	
	$("#addCandidateForm").submit();
}
</script>
 <script>
function deleteStudents(){
	var selectedStudentsMap = new Object();
	var n = $( "input:checked" ).length;

	if(n!=0){

		var selectedIds = $('input:checked').map(function(){

		      var emailElem = $(this).parent();
		      //setting key of map as candidate mail id and value as his/her batch
		      selectedStudentsMap[emailElem.attr('id')] = emailElem.find('span#batchYear').html();
		      return JSON.stringify(selectedStudentsMap);
		        
		    });
	    
			//Retrieving selected students map
			var deleteStudentsMap = selectedIds.get(n-1);
				
		    $.ajax(
					  {
			   
			      type: "POST",
			      url:"university_delete_students.htm",
			      cache : false,
			      contentType :'application/json',
			      data: deleteStudentsMap,
			      success: function(data) {
				   alert("You Have Successfully Deleted the Students"); 
				   //Reload page to reflect deleted Candidates
			       window.location.href = 'university_manage_connections.htm';
			      },

			      error: function(xhr, error){
				      alert ("error"+error.status);
				      } 
			    } ); 
		}

}
</script> 
<script type="text/javascript"> 
$(document).ready(function() {
	
	$("#registerStudentDiv").hide();

	//Error display on form
	var error = "${error}" ;
	var invalid="${invalid}";
	var duplicate="${duplicate}";
	
	if(error!="" || invalid!="" || duplicate!=""){
		
			$("#registerStudentDiv").show();
			} 
	
}); 
</script>


<script src="../mobile_html/js/vallenato.js" type="text/javascript"></script>
<link rel="stylesheet" href="../mobile_html/css/vallenato.css" type="text/css" media="screen">
<script src="../mobile_html/js/bootstrap-dropdown.js"></script>
</head>

<body class="university">
<div id="main_wrap">

<!--------------  Header Section :: start ----------->
    
   <%@ include file="includes/header.jsp"%>	
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    
    <div id="mid_wrap" class="midwrap_toppadding">
    <div class="clear"></div>
    <section id="inner_container">
    <h1 class="page_heading"><span class="orange_font">Register Students </span>
    <input type="button" name="addConnections"  value="ADD CONNECTIONS" id="addConnections" class="orangebuttons" onclick="registerStudentDivShow()">
    <input type="button" name="deleteConnections"  value="DELETE CONNECTIONS" id="deleteConnections" class="orangebuttons" onclick="deleteStudents()">
    </h1>
    <div id="errorMsgDisplay" >
 
    
    	  <!-- Duplicate Data in other university message error message -->
            <span class="field">
               <label class="orange_font">
               <c:set var="existingStudents"  value="${existingStudents}"/>
               <c:if test="${not empty existingStudents}">
                <c:out value="Student already Registered"/> 
               <c:forEach items="${existingStudents}" var="existingStudents">
               <c:out value="${existingStudents}" />
               </c:forEach>
               </c:if>
               </label>  
              </span> 
          
           <!-- Invitation is being sent to Unregistered Candidate -->
            <span class="field">
               <label class="orange_font">
               <c:set var="invitedStudents"  value="${invitedStudents}"/>
               <c:if test="${not empty invitedStudents}">
                <c:out value="An Invitation is being sent to"/> 
               <c:forEach items="${invitedStudents}" var="invitedStudents">
               <c:out value="${invitedStudents.key}" />
               </c:forEach>
               </c:if>
               </label>  
              </span> 
    
    </div>
    <!--Add Students Form  -->
    <div id ="registerStudentDiv" class="borderbottom padding_bottom doublebottom_margin">
     <form:form class="stdform" id="addCandidateForm" action="university_add_connections.htm" method="post"  modelAttribute="universityLoginCmd">
            <div class="par floatleft right_margin"> <span class="field">
              <!-- <input type="text" name="input3" class="input-medium3" placeholder="Email" tabindex="1" /> -->
              <form:input path="emailAddress" id ="emailAddress" class="input-medium3"  placeholder="Add Students Email Id*" name="j_username" style="padding:11px 7px"  />
              </span>
              
           <!-- Blank Data error message -->
            <span class="field">
            <c:set var="error"  value="${error}"/>
            <label class="orange_font">
            <c:out value="${error}" /> 
            </label>
            </span>
            
            <!-- Invalid emailId error message -->
            <span class="field">
            <c:set var="invalid"  value="${invalid}"/>
            <label class="orange_font">
            <c:out value="${invalid}" /> 
            </label>
            </span>
            
              <!-- Duplicate Data error message -->
             <span class="field">
            <c:set var="duplicate"  value="${duplicate}"/>
            <label class="orange_font">
            <c:out value="${duplicate}" />
            </label>
            </span>
          
            </div>
            <div class="par floatleft left_margin"> <span class="field">
              <div class="controls"> <span class="field">
                   <span class="formwrapper"> 
                <form:select data-placeholder="Year of Passing*"  class="chzn-select" tabindex="2" path="batch"> 
                <form:option value="" label="--Please Select--"/>
                  <c:forEach items="${batch}" var="batch"> 
                    		<form:option value="${batch}"><c:out value="${batch}" /></form:option>
                  	</c:forEach>
                </form:select>
                </span>
                    </span> </div>
              </span> </div>
            <div class="float_left advancesearch_topmargin left_margin">
              <input name="" type="button" value="Add" tabindex="21" onclick="addCandidate()" class="no_right_margin orangebuttons">
            </div>
            <div class="clear"></div> 
          </form:form>         
</div>
    
    <div class="clear"></div>
   
   <div class="search_listing_wrap">
      
  <form:form id="form1"  method="post" commandName="searchCandidate">
   <ul class="search_listing">
     <c:forEach var="student" items="${student}"> 
        <li id="${student.emailID}" > 
       <%--  <a href= "university_view_candidate_details.htm?emailId=<c:out value="${student.emailID}"/>"> --%>
        <a href= "detail_view_candidate.htm?studentEmailId=<c:out value="${student.emailID}"/>"> 
          <c:set var="photoEmailId" value="${student.emailID}"/>
          			<c:choose>
						<c:when test="${student.photoName ne null}"> 
							<div class="company_logo"><img src="view_image.htm?emailId=<c:out value="${photoEmailId}"/>"></div>
						</c:when>
						<c:otherwise>
                      		<div class="company_logo"><img src="../mobile_html/images/blankimage.png" alt=""></div> 
                      	</c:otherwise>
                   </c:choose>
         <h1 class="heading"><c:out value="${student.firstName}"></c:out></span>   <span><c:out value="${student.lastName}"></c:out></h1>
            <h2 class="subheading"><c:out value="${student.courseName}"></c:out></span>,<span><c:out value="${student.state}"></c:out> </h2>
            <div class="jobtype"><span class="postedon"><c:out value="${student.universityName}"></c:out></span>  <span id="batchYear"><c:out value="${student.g_endYear_duration}"/></span> GPA <c:out value="${student.g_from_gpa}"/> / <c:out value="${student.g_to_gpa}"/></div>
           
           <div class="floatright" id="iScore">I Score :<span class="postedon"><c:out value="${student.IScore}"></c:out></span></div>
            </a> 
            <input id="selectedStudent" type="checkbox" class="float_right checkboxex">
        </li>
     </c:forEach>
        </ul>
        <div class="clear"></div>
        </form:form>
      </div>
    </section>
    </div>
</div>

</body>
</html>