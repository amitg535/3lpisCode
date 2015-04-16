<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>University Manage Connections</title>
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


 <link rel="stylesheet" href="css/video-js.css" type="text/css" /> 

  <script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
     
  <script type="text/javascript">
  $(document).ready( function() {
      $('#tab-container').easytabs();
	  
	 $("#dyntable_wrapper").css("display","block").fadeIn("slow");
	   $(".grid img").attr("src","images/list_active.png").css("width","22","height","22");
		  $(".list img").attr("src","images/grid.png").css("width","22","height","22");
		  $("#list").css("display","none");
		  
	 $("#tabs1 .grid").click(function(){
		 $(".grid img").attr("src","images/list_active.png").css("width","22","height","22");
		  $(".list img").attr("src","images/grid.png").css("width","22","height","22");
		  $("#dyntable_wrapper").css("display","block").fadeIn("slow");
		  $("#list").css("display","none");
		  $("#dyntable").css("display","block");
	 });
	 
	  $("#tabs1 .list").click(function(){
		  $(".list img").attr("src","images/grid_active.png").css("width","22","height","22");
		  $(".grid img").attr("src","images/list.png").css("width","22","height","22");
		  $("#dyntable_wrapper").css("display","none");
		  $("#list").css("display","none").fadeIn("slow");
		  $(".searchfilter").css("display","block").fadeIn("slow");
		  $("#dyntable").css("display","none");
	 });
	 
	 $("a").click(function(){
	 	$("#tab3").focus();
	 });
	  	
	 
	var qs = $('input#id_search_list').quicksearch('ul#list_example li');
	
	$("ul.pagination1").quickPagination({pageSize:"12"});
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
   <script src="js/jquery.easytabs.min.js" type="text/javascript" ></script>
  <script type="text/javascript" src="js/jquery.quicksearch.js"> </script>
  <script type="text/javascript" src="js/jquery.quick.pagination.min.js"> </script>
  <script type="text/javascript" src="js/jquery.easytabs.min.js"> </script> 

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
function deleteStudents(selectedElement){
	var selectedStudentsMap = new Object();
	var selectedIds = $(selectedElement).map(function(){
		
	var emailElem = $(selectedElement).closest('tr');
	//setting key of map as candidate mail id and value as his/her batch
	selectedStudentsMap[$(selectedElement).closest('tr').attr('id')] = emailElem.find('td#batchYearElement').html();
	return JSON.stringify(selectedStudentsMap);
	        
	    });
	   //Retrieving selected students map
		var deleteStudentsMap = selectedIds.get(0);
	
	   $.ajax(
				  {
		   
		      type: "POST",
		      url:"university_delete_students.htm",
		      cache : false,
		      contentType :'application/json',
		      data: deleteStudentsMap,
		      success: function(data) {
		       alert("You Have Successfully Deleted the Student"); 
		     //Reload page to reflect deleted Candidate
		      window.location.href = 'university_manage_connections.htm'; 
		     
		      },
		      error: function(xhr, error){
			      alert ("error"+error.status);
			      } 
		    } ); 
}
</script>  
  
  
  <style type="text/css">
  
  .grid, .list{cursor:pointer; cursor:hand;}
  </style>
  </head>
  <body>
<div id="wrap"> 
    <!--------------  Header Section :: start ----------->
    
    <%@ include file="includes/header.jsp"%>
    <!--------------  Header Section :: end ------------> 
    <!--------------  Middle Section :: start ----------->
    <div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
 
     
    
    <div id="innersection">
     <!--    <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm"> Home </a>/ Manage Connections</div> -->
        
        <section id="rightwrap" class="floatleft">
         
        <h1 class="sectionheading">Manage Connections</h1>
        <div class="padding_bottom2"><p class="description">Imploy.me provides a platform to connect the universities to their students enabling a environment to communicate informations related to job and internship postings, 
		upcoming job fairs and recruitment drive in the calendar year.</p></div>
         <div class="clear"></div>
         
          <c:set var="uploadFile"  value="${uploadFile}"/>
                      <c:if test="${uploadFile != null}">    
                         <div id="success_message" class="doubletop_margin" >
                  <div id="warning_image"><img src="images/success_icn.gif" alt="Verification Successful" title="Verification Successful"></div>
                  <div class="shortmessage">File Uploaded Successfully</div>
                  <div class="clear"></div>
                </div>   
                      </c:if>
                      
				<c:set var="errorMsg"  value="${errorMsg}"/>
                      <c:if test="${errorMsg != null}">
                             <div id="error_message" class="doubletop_margin" >
                  <div id="warning_image"><img src="images/warningerror_icn.png" alt="Error Message" title="Error Message"></div>
                  <h2 class="error_message_heading">Unsupported File Type</h2>
                   <div class="clear"></div>
          <p class="error_message_para">  
           <div class="shortmessage">
                 <c:out value="${errorMsg}"/>
                 </div> 
                 </p>
                  <div class="clear"></div>
                </div> 
                      </c:if>    
                      
                      <c:set var="errorTemplate"  value="${errorTemplate}"/>
                      <c:if test="${ errorTemplate != null}">
                        <div id="error_message" class="doubletop_margin" >
                  <div id="warning_image"><img src="images/warningerror_icn.png" alt="Error Message" title="Error Message"></div>
                  <h2 class="error_message_heading">File Not Uploaded</h2>
                  <div class="clear"></div>
          		<p class="error_message_para">
          		 <div class="shortmessage">
                       <c:out value="${errorTemplate}"/>
                       </div>
                       </p>
                       <div class="clear"></div>
                </div>
                 </c:if>
                 
             
              
              
        <div class="whitebackground">         
       <h1 class="sectionheading">Register Students</h1>
        <div class="borderbottom padding_bottom doublebottom_margin greybackground">
         
        <form:form class="stdform" action="university_add_connections.htm" method="post"  modelAttribute="universityLoginCmd">
            <div class="par floatleft right_margin" style="width:auto;"> <span class="field">
              <!-- <input type="text" name="input3" class="input-medium3" placeholder="Email" tabindex="1" /> -->
              <form:input path="emailAddress" class="input-medium3"  placeholder="Add Students Email Id" name="j_username" style="padding:11px 7px"  />
              
              </span> 
              <!-- Blank Data error message -->
               <span class="field">
            <c:set var="error"  value="${error}"/>
            <label class="error">
            <c:out value="${error}" /> 
            </label>
            </span>
            
            <!-- Invalid emailId error message -->
               <span class="field">
            <c:set var="invalid"  value="${invalid}"/>
            <label class="error">
            <c:out value="${invalid}" /> 
            </label>
            </span>
            
               <!-- Duplicate Data error message -->
              <span class="field">
            <c:set var="duplicate"  value="${duplicate}"/>
            <label class="error">
            <c:out value="${duplicate}" />
            </label>
            </span>
            
            <!-- Duplicate Data in other university message error message -->
            <span class="field">
               <label class="error">
               <c:set var="existingStudents"  value="${existingStudents}"/>
               <c:if test="${not empty existingStudents}">
                <c:out value="Student already Registered"/> 
               <c:forEach items="${existingStudents}" var="existingStudents">
               <c:out value="${existingStudents}" />
               </c:forEach>
               </c:if>
               </label>  
              </span> 
            
            
            </div>
            <div class="par floatleft left_margin" style="width:auto;"> <span class="field">
              <div class="controls"> <span class="field">
                   <span class="formwrapper">
                <form:select data-placeholder="Year of Passing"  class="chzn-select" tabindex="2" path="batch"> 
                <form:option value="" label="--Graduation Year--"/>
                  <c:forEach items="${batch}" var="batch"> 
                    		<form:option value="${batch}"><c:out value="${batch}" /></form:option>
                  	</c:forEach>
                </form:select>
                </span>
                    </span> </div>
              </span> </div>
            <div class="par floatleft advancesearch_topmargin left_margin" style="width:auto;">
              <input name="" type="submit" value="Add Connections" tabindex="21" class="no_right_margin orangebuttons">
            </div>
           
            
            <div class="clear"></div> 
            
          </form:form>         
		</div>

	</div>

   <div class="clear"></div>
      
      
       <div class="whitebackground margin_top2">
      
        <div id="tab-container" class='doublebottom_margin ui-tabs ui-widget ui-widget-content ui-corner-all'>
 <ul>
 
   <li class='tab'><a href="#tabs1">Registered Students</a></li>
   <li class='tab'><a href="#tabs2">Invited Students</a></li>
  <li class='tab floatright'><a href="#tabs3">Bulk Upload</a></li>
 </ul>
  
 <div class='panel-container'>
  <div id="tabs1">		
  <div class="floatright" id="icon" style="z-index:100;margin-top:10px;"><a class="grid"><img src="images/list.png" width="22" height="22" alt="" style="display:inline;"></a> <a class="list"><img src="images/grid.png" width="22" height="22" alt="" style="display:inline;"></a></div>
  <div class="clear"></div>
  <c:choose>
  <c:when test="${empty studentDataList}">
         <c:out value="NO DATA AVAILABLE"/>
			</c:when>
			<c:otherwise>
     		   <table class="table table-bordered" id="dyntable"> 
     		   <thead>
              	  <tr>
                    <th width="20%" class="table_leftalign  nosort">Email ID</th>
                    <th width="11%" class="table_centeralign">Graduation Year</th> 
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
                	    <c:forEach items="${studentDataList.registeredStudents}" var="studentDataRegisteredMap">         	
                	   <tr id="${studentDataRegisteredMap.key}">
                			<td><a href="detail_view_candidate.htm?studentEmailId=<c:out value="${studentDataRegisteredMap.key}" />"><c:out value="${studentDataRegisteredMap.key}" /></a></td>
                    		<td id="batchYearElement" class="table_centeralign"><c:out value="${studentDataRegisteredMap.value}" /></td>	
                    		<td class="table_centeralign nosort">
                    		<img src="images/small_delete_icn.png" onclick="deleteStudents(this)" class="table_actionbtn" alt="Delete" title="Delete"/>
                    	    <a href="#"><img src="images/mail_icn.png" class="table_actionbtn" alt="Mail" title="Mail"></a>
                    	    </td>
                  		</tr>
                  	</c:forEach>          	
              </tbody>
              </table>
        	</c:otherwise>
        	</c:choose>
        	 <div class="clear"></div>    
        	<div id="list">
        	<c:choose>
        	<c:when test="${empty student}">
        	 NO DATA AVAILABLE
			</c:when>
			<c:otherwise>
			<div class="clear"></div>
	<form class="stdform" style="margin-top:-22px;width: 80%;">
    	Search: <input type="text" value="" class="input-medium3"  id="id_search_list" />
    	<div class="clear">&nbsp;</div>
    </form>
				<ul id="list_example" class="pagination1">
				<c:forEach items="${student}" var="student">
					<c:choose>
					<c:when test="${student.photoName == null}">
					<li><a href="detail_view_candidate.htm?studentEmailId=<c:out value="${student.emailID}"/>"> <img src="images/Not_available_icon1.png" alt="">
					<p><c:out value="${student.firstName}" /> <c:out value="${student.lastName}" /><br><c:out value="${student.batch}" /></a></p></li>  
					</c:when>
					<c:otherwise>
                     <li> <a href="detail_view_candidate.htm?studentEmailId=<c:out value="${student.emailID}"/>"><img src="view_image.htm?emailId=<c:out value="${student.emailID}"/>" alt="">
                     <p><c:out value="${student.firstName}" /> <c:out value="${student.lastName}" /><br><c:out value="${student.batch}" /></a></p></li>  
                    </c:otherwise>
                     </c:choose>
                     </c:forEach>   
                        
                </ul>
		</c:otherwise>
		</c:choose>
</div>
   <div class="clear"></div>
        	
              </div>
   <div id="tabs2">
   <c:choose>
			<c:when test="${empty studentDataList}">
			<c:out value="NO DATA AVAILABLE"/>
			</c:when>
			<c:otherwise>
     		   <table class="table table-bordered" id="dyntable1">
                <thead>
              	  <tr>
                    <th width="20%" class="table_leftalign  nosort">Email ID</th>
                    <th width="11%" class="table_leftalign">Year of Passing</th>          
                    <th width="12%" class="table_centeralign nosort">Actions</th>
                  </tr>
              </thead>
                <tbody>
				    <c:forEach items="${studentDataList.unregisteredStudents}" var="studentDataUnRegisteredMap">         	
                	   <tr id="${studentDataUnRegisteredMap.key}">
                			<td><c:out value="${studentDataUnRegisteredMap.key}" /></td>
                    		<td id="batchYearElement"><c:out value="${studentDataUnRegisteredMap.value}" /></td>
                    		<td>
                    		<img src="images/small_delete_icn.png" onclick="deleteStudents(this)" class="table_actionbtn" alt="Delete" title="Delete"/>
                         	<a href="#"><img src="images/mail_icn.png" class="table_actionbtn" alt="Mail" title="Mail"></a></td>
                  		</tr>
                  	</c:forEach>          	
              </tbody>
              </table>
        	</c:otherwise>
        	</c:choose>
  </div>    
      <div class="clear"></div>          
  </div>
 </div>
 </div>
 
 <div class="clear"></div>
 
 
   <div class="whitebackground margin_top2">
 <div class="borderbottom padding_bottom doublebottom_margin greybackground">
<a name="tabs3"></a>
          <form:form class="stdform" action="university_upload_file.htm" method="post"  modelAttribute="uploadedFile" id = "uploadedFile" enctype="multipart/form-data">    
            <div class="par">
            <span class="xl_download"><a href="download_template.htm" class="table_centeralign display"><img src="images/download_small.png" alt="" align="absmiddle"> <br>Download Template</a></span>
              
                <label>File Upload</label>
                <c:if test="${not empty uploadFile}">
               Uploaded File is - <c:out value="${uploadFile}"/> 
               </c:if>
               
                 <span class="field">
                <input type="file" class="uniform-file" name="uploadFile"/>
               
                &nbsp;&nbsp;
                <input type="submit" class="orangebuttons" value="Upload" /> 
                </span>
                 <c:set var="errorMessage"  value="${errorMessage}"/>
                      <c:if test="${ errorMessage != null}">
                      <span class="field">
                      <label class="error">
                       <c:out value="${errorMessage}"/>
                       </label>
                       </span>
                      </c:if> 
                
                 <span class="field">     
               <c:set var="invalidEmailId"  value="${invalidEmailId}"/>
               <label class="error">
               <c:out value="${invalidEmailId}"/>
               </label>
               </span>
               <span class="field">
               <c:set var="invalidBatch"  value="${invalidBatch}"/>
               <label class="error">
               <c:out value="${invalidBatch}"/>
               </label>
              </span> 
              <span class="field">
               <c:set var="duplicateMsg"  value="${duplicateMsg}"/>
               <label class="error">
               <c:out value="${duplicateMsg}"/>
               </label>  
              </span> 
               <span class="field">
               <label class="error">
               <c:set var="existingStudentsList"  value="${existingStudentsList}"/>
               <c:if test="${not empty existingStudentsList}">
                <c:out value="Students already Registered"/> 
               <c:forEach items="${existingStudentsList}" var="existingStudentsList">
               <c:out value="${existingStudentsList}" />
               </c:forEach>
               </c:if>
               </label> 
              </span> 
                </div>
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
    <!--------------  Common Footer Section :: end -----------> 
  </div>
</body>
</html>