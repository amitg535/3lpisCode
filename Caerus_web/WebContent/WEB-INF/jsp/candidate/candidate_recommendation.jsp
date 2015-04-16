<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Recommendation</title>

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/tree-layout.css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />

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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>

<script type="text/javascript">


$(document).ready(function() {
	populateOrganization();

	$('input[type=radio][name=type]').change(function() {

		$.ajax({

		 type:"get",
	 	 url:"candidate_recommendation.htm",
	 	 success : function(data){
	 		var mySelect = $('#organizationSelect');
	 		var selectedRecoType = $('input[name=type]:checked').val();

	 		 if (selectedRecoType == 'Education') {

	 	     	var universityList = ${studentUniversitySet};
	 	     	mySelect.empty().append($('<option><option/>').val("").text("Choose an Option"));
	 	    	$.each(universityList,function(index, university) {
	 	    	    mySelect.append(
	 	    	        $('<option></option>').val(university).text(university));
	 	    	}); 
	 	       
	 	    }
	 	    else if (selectedRecoType == 'Work') {

	 	        var companyList = ${studentCompanySet};
	 	       mySelect.empty().append($('<option><option/>').val("").text("Choose an Option"));
	 	    	$.each(companyList, function( index, company )
	 	   	 		 {
	 	    		   mySelect.append($('<option/>').val(company).text(company));
	 	   	 		});
	 	    }

	 	 }
		}); });
	

	  var i =0;
	    $('.recolink').each(function(i){
	        $(this)
	            .attr("id", "id_" + i);
	            
          i++;
	    });

	$('#recoBtn').click(function(){
		
		$("#recoModal").modal('show');
		
		});

	$('.recolink').click(function(){
		
		$("#reminderModal").modal('show');
		localStorage.setItem("selectedLink",this.id);
		});

    $('#sendReminder').click(function(){

    	var selectedLink = localStorage.getItem("selectedLink");

    	recommenderEmailId = $('#'+selectedLink).closest('li').find(".recommenderid").val();   
    	recommenderFirstName = $('#'+selectedLink).closest('li').find(".firstname").val();   
    	recommenderLastName = $('#'+selectedLink).closest('li').find(".lastname").val();  
    	requestTime =  $('#'+selectedLink).closest('li').find(".date1").val();   

    	 $.ajax({

    		 type:"post",
    	 	 url:"candidate_recommendation.htm?sendReminder="+true,

    	 	data:
    		{
    	 		recommenderEmailId: recommenderEmailId,
    	 		recommenderFirstName: recommenderFirstName,
    	 		recommenderLastName: recommenderLastName,
    	 		requestTime : requestTime					
    		},

    	 	 success : function(data){

        	 	 alert("Remind email is sent successfully!");

    	 	 }, 

    	 	 error : function(){

 				alert("Error occurred!");
        	 	 
        	 	 }
    		});
        
        });

	
});



function populateOrganization(){

	var mySelect = $('#organizationSelect');
	var selectedRecoType = $('input[name=type]:checked').val();
	mySelect.empty().append($('<option><option/>').val("").text("Choose an Option"));
	
    if (selectedRecoType == 'Education') {

     	var universityList = ${studentUniversitySet};
        
    	$.each(universityList,function(index, university) {
    	    mySelect.append(
    	        $('<option></option>').val(university).text(university));
    	}); 
       
    }
    else if (selectedRecoType == 'Work') {

        var companyList = ${studentCompanySet};
    	$.each(companyList, function( index, company )
   	 		 {
    		   mySelect.append($('<option/>').val(company).text(company));
   	 		});
    }
	
}

</script>

<style type="text/css">
.remindermodal{left: 63% !important; width: 471px !important; }
</style>
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
      <img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level">
      </div>
      <div class="clear"></div>
    </div> 

    <div id="innersection">
   
    <section id="rightwrap">
   
    <h1 class="sectionheading">Ask for Recommendation</h1>
    
    	<p>
    			
					Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
					Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
					It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 
					
					 <br>
					 <br>
					 
				
        &nbsp;
         <input name="" type="button" value="Request a Recommendation" class="generate" id="recoBtn" > 
					 
					 
					
					</p>
    
    <h1 class="sectionheading">Requested Recommendations <span><c:out value=""></c:out></span></h1>
       
            <div class="clear"></div>
         <div class="appliedJob_paging_container">
        <div class="job_listing_wrap">
      
   		
            <ul class="jobslisting">        
            <c:forEach var="recommendation" items="${recommendationList}">
             <li class="test">
            
                <div class="details">
                
                	<div class="jobtitle floatleft">
                	<c:out value="${recommendation.recommenderFirstName}"></c:out>
                	<c:out value="${recommendation.recommenderLastName}"></c:out></div>
                    <div class="floatright jobtype"><c:out value="${recommendation.studentRecoStatus}"></c:out></div>
                     <div class="clear"></div>
                	 <div class="bottom_margin"><span class="orangetxt boldtxt">
                  
                    <c:out value="${recommendation.designation}"></c:out> at <c:out value="${recommendation.organization}"></c:out>
                    
                    </span></div>
                     <div class="clear"></div>
                     <input type = "hidden" class = "recommenderid" value="${recommendation.recommenderEmailId}">
                      <input type = "hidden" class = "firstname" value="${recommendation.recommenderFirstName}">
                       <input type = "hidden" class = "lastname" value="${recommendation.recommenderLastName}">
                	<div class="floatleft"> Recommender Email Address- <c:out value="${recommendation.recommenderEmailId}"></c:out> </div>
                
                  </div>
           <div class="actionsbtns">
                  <div class="date">Sent On 
                  <input type ="hidden" value="${recommendation.requestTime}" class="date1">
                   <fmt:parseDate value="${recommendation.requestTime}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="d"/> <br/> 
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/> </div> 
                   <div class="clear">
                   </div>
                   
                   <c:choose>
                   <c:when test="${not empty recommendation.recommenderResponseTime}">
                   <div class="date">Received On
                  <fmt:parseDate value="${recommendation.recommenderResponseTime}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="d"/> <br/> 
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="MMM"/><br/>
                  <fmt:formatDate type="date" value="${formatedDate}" pattern="yyyy"/>
                   </div>
                   </c:when>
                   
                   <c:otherwise>
                   <div class="buttonwrap"><a class="recolink" href="#"><img src="images/reminder_icn.png" alt="" /><br>Send Reminder</a></div>
                   </c:otherwise>
                   </c:choose>
            
          </div> 
              
                <div class="clear"></div>
            </li>
            </c:forEach> 
       </ul>
          
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
    <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-2" class="modal hide fade in" id="recoModal">
				<div class="modal-header">
		<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="formulaHeader" class="blutitle18"> Add your recommender details </h3>
			</div>
       <div class="modal-body"> 
         <div id="candidate_registration_wrap" >
      
       <form:form action="candidate_recommendation.htm" method="post" modelAttribute="studentRecommendationCom" class="stdform" id="requestRecoForm">
									

										<!-- <h3 class="blutitle18">Add your recommender details</h3> -->
										<div class="leftsection_form">
			
											 <div class="par">
							                <label class="floatleft">Type of Recommendation</label>
							                <div class="clear"></div>
							                <span class="formwrapper">
							                <form:radiobutton path="type" name = "type" value="Education" checked = "false"  />Education
							                <form:radiobutton path="type" name = "type" value="Work" checked = "true" />Work
							               
							                </span></div>
							                
							           	<div class="par">
											<label class="floatleft">Recommender First Name</label><span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> 
											
											<form:input path="recommenderFirstName"	placeholder="" 	class="input-xxlarge" tabindex="3" />
												
											</span>
											
										</div>
									
							          	<div class="par">
									<label class="floatleft">Oganization</label><span class="star">*</span>
									<div class="clear"></div>
									<span class="formwrapper"> 
									
										<form:select tabindex="" id = "organizationSelect"  path="organization" cssClass="">
											 
										</form:select>
									</span>
								</div>
								
									<div class="par">
											<label class="floatleft">Email Address</label><span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> 
											
											<form:input path="recommenderEmailId"	placeholder="" 	class="input-xxlarge" tabindex="4" />
												
											</span>
																			
										</div>
							         
									
										</div>
										
										<div class="rightsection_form">
										
										<div class="par" style="height:53px;">
										</div>
									
									 	<div class="par">
											<label class="floatleft">Recommender Last Name</label><span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> 
											
											<form:input path="recommenderLastName"	placeholder="" class="input-xxlarge" tabindex="3" />
												
											</span>
																			
										</div>
										
											<div class="par">
											<label class="floatleft">Designation</label><span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> 
											
											<form:input path="designation"	placeholder="" 	class="input-xxlarge" tabindex="3" />
												
											</span>
																			
										</div>
										
											 <div class="par">
												<label class="floatleft">Message (Optional)</label>  
												<form:textarea path="requestMessage" cols="80" rows="3"
													id="message2" class="span12" maxlength="2000"
													tabindex="23" />
												
											</div>
										
										
										</div>
										
										<div class="par floatright">
											<input name="" type="submit" value="Send" tabindex="" class="add_participants top_margin"	>
										</div>
										<div class="clear"></div>
									
								</form:form>
								
								</div>
   </div>
   </div>
   
   
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-2" class="modal hide fade in remindermodal" id="reminderModal">
				<div class="modal-header">
		<button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="formulaHeader" class="blutitle18"> Send Reminder </h3>
			</div>
       <div class="modal-body"> 
         <div id="candidate_registration_wrap" >
          <div class="par">
		
		  <h3 id="myModalLabel"> Are You Sure to Send the Reminder? </h3>  
		</div>
        
         <div class="par floatright">
			<input name="" id="sendReminder" type="button" value="OK" tabindex="" class="add_participants top_margin">
			<input name="" type ="button" data-dismiss="modal" value="Cancel" class="add_participants top_margin" >
		 </div>
		<div class="clear"></div>
		</div>
   </div>
   </div>
  <!-- </div> -->
</body>
</html>