<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Admin Login</title>
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
 <!--  <link rel="stylesheet" href="css/video-js.css" type="text/css" /> -->

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
<!--   <script src="js/video.js"></script> -->
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
  <script src="js/jquery.easytabs.min.js" type="text/javascript" ></script>
  <script type="text/javascript" src="js/jquery.quicksearch.js"> </script>
  <script type="text/javascript" src="js/jquery.quick.pagination.min.js"> </script>
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
	 });
	 
	  $("#tabs1 .list").click(function(){
		  $(".list img").attr("src","images/grid_active.png").css("width","22","height","22");
		  $(".grid img").attr("src","images/list.png").css("width","22","height","22");
		 $("#dyntable_wrapper").css("display","none");
		  $("#list").css("display","block").fadeIn("slow");
		  $(".searchfilter").css("display","block").fadeIn("slow");
	 });
	 
	 $("a").click(function(){
	 	$("#tab3").focus();
	 });
	  	
	 
	var qs = $('input#id_search_list').quicksearch('ul#list_example li');
	
	$("ul.pagination1").quickPagination({pageSize:"12"});

});
  </script>
  
  <script type="text/javascript">
  $(document).ready( function() {
 
	
	$("ul.pagination1").quickPagination({pageSize:"50"});

	//Select All students
	$(".selectallstudents").change(function() {
	    if(this.checked) {
	    	//Set other checkboxes on page checked	 
	    	$( ".selectstudent").prop('checked', true);
	    }

	    if(!this.checked) {
	    	//Set other checkboxes on page unchecked	 
	    	$( ".selectstudent").prop('checked', false);
	    }
	});

	//Select All corporates
	$(".selectallcorp").change(function() {
	    if(this.checked) {
	    	//Set other checkboxes on page checked	    	
	    	$( ".selectcorp").prop('checked', true);
	    }

	    if(!this.checked) {
	    	//Set other checkboxes on page unchecked	 
	    	$( ".selectcorp").prop('checked', false);
	    }
	    
	});

   //Select All universities
	$(".selectalluniv").change(function() {
	    if(this.checked) {
	    	//Set other checkboxes on page checked	 
	    	$( ".selectuniv").prop('checked', true);
	    }

	    if(!this.checked) {
	    	//Set other checkboxes on page unchecked	 
	    	$( ".selectuniv").prop('checked', false);
	    }
	});


	    $('#enableUsers').click(function(){

		$( ".selectallstudents").prop('checked', false);
		$( ".selectallcorp").prop('checked', false);
		$( ".selectalluniv").prop('checked', false);

		
		var selectedUsersMap = new Object();
		var n = $( "input:checked" ).length;
	
		if(n!=0){

			var selectedIds = $('input:checked').map(function(){

			      var userElem = $(this).closest('tr');
			     			     
			      //setting key of map as user mail id and value as role
			      selectedUsersMap[userElem.attr('id')] = userElem.find('td.authority').html();
			    
			      return JSON.stringify(selectedUsersMap);
			        
			    });
		    
				 //Retrieving selected users map
				var enableUsersMap = selectedIds.get(n-1); 

				 $.ajax(
						  {
				   
				      type: "POST",
				      url:"admin_enable_users.htm",
				      cache : false,
				      contentType :'application/json',
				      data: enableUsersMap,
				      success: function(data) {
					   alert("You Have Successfully Enabled Selected Users"); 
					   //Reload page to reflect enabled Users
				       window.location.href = 'admin_manage_users.htm';
				      },

				      error: function(xhr, error){
					      alert ("error"+error.status);
					      } 
				    } ); 
			}
	});

	$('#disableUsers').click(function(){

		$( ".selectallstudents").prop('checked', false);
		$( ".selectallcorp").prop('checked', false);
		$( ".selectalluniv").prop('checked', false);		
		var selectedUsersMap = new Object();
		var n = $( "input:checked" ).length;

		if(n!=0){

			var selectedIds = $('input:checked').map(function(){

			      var userElem = $(this).closest('tr');
			     
			      //setting key of map as user mail id and value as role
			      selectedUsersMap[userElem.attr('id')] = userElem.find('td.authority').html();
			    
			      return JSON.stringify(selectedUsersMap);
			        
			    });
		    
				 //Retrieving selected users map
				var disableUsersMap = selectedIds.get(n-1); 
				
			    $.ajax(
						  {
				   
				      type: "POST",
				      url:"admin_disable_users.htm",
				      cache : false,
				      contentType :'application/json',
				      data: disableUsersMap,
				      success: function(data) {
					   alert("You Have Successfully Disabled Selected Users"); 
					   //Reload page to reflect disabled Users
				       window.location.href = 'admin_manage_users.htm';
				      },

				      error: function(xhr, error){
					      alert ("error"+error.status);
					      } 
				    } ); 
			}
		
		});
	

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
        <div id="banner"><img src="images/university_innerbanner.jpg" width="100%" alt="Great way to find talent. Sign Up Now!"></div>
        <div class="clear"></div>
      </div>
 
      
    
    <div id="innersection">
       <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm"> Dashboard </a>\ Manage Users</div> -->
       
        <section id="rightwrap" class="floatleft">
        
          <div class="whitebackground">
        <h1 class="sectionheading">Manage Users</h1>
        
         
         
        <div id="tab-container" class='tab-container'>
         <div class="actionlegend_wrap floatright ">
                <ul>
                <li>Change Status:</li>
                <li><a href="#"><img src="images/green_circle.png" id="enableUsers"/>Enable</a></li>
                <li><a href="#"><img src="images/red_circle.png" id="disableUsers"/>Disable</a></li>
              </ul>
              </div>
 <ul class='etabs'>
   <li class='tab'><a href="#tabs1">Employers</a></li>
   <li class='tab'><a href="#tabs2">Students</a></li>
   <li class='tab'><a href="#tabs3">Universities</a></li>
 </ul>
 
 <div class='panel-container'>
 <!--Employer Tab Starts-->
 <div id="tabs1" class="pagination1">
   <c:choose>
			<c:when test="${empty corporateList}">
			<c:out value="NO DATA AVAILABLE"/>
			</c:when>
			<c:otherwise>
     		   <table class="table table-bordered" id="dyntable">
                <thead>
              	  <tr>
              	    <th width="1%" class="table_centeralign nosort"><input type="checkbox" class="float_left checkboxex selectallcorp"></th>
                    <th width="5%" class="table_centeralign nosort">Status</th>
                    <th width="25%" class="table_leftalign  nosort">Company Name</th>
                    <th width="20%" class="table_leftalign">User Name</th>
                     <th width="25%" class="table_leftalign">User mail Id</th>
                    <th width="24%" class="table_centeralign nosort">Company Admin</th>
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${corporateList}" var="company"> 
				   		
                	   <tr id="${company.userName}">
                	        <td><input type="checkbox" class="float_left checkboxex selectcorp"></td>
                	        <td align="center">
                    		<c:choose>
                    		<c:when test="${company.enabled==true}">
                    		<img src="images/green_circle.png"/>
                    		</c:when>
                    	    <c:otherwise><img src="images/red_circle.png"/>
                    		</c:otherwise>
                    		</c:choose>
                    		</td>
                	   		<td><c:out value="${company.entityName}" /></td>
                	   		<td><c:out value="${company.firstName}" /> <c:out value="${company.lastName}" /></td>
                			<td><c:out value="${company.userName}" /></td>
                			<td>
                    		<c:choose>
                    		<c:when test="${company.adminFlag==true}">
                    		True
                    		</c:when>
                    	    <c:otherwise>False
                    		</c:otherwise>
                    		</c:choose>
                    		</td>
                    		
                  		</tr>
                  
                  	
                   	</c:forEach>              	
              </tbody>
              </table>
        	</c:otherwise>
        	</c:choose>
     
      <div class="clear"></div>  
       </div>
  <!--Employer Tab Ends-->
  <!--Student Tab Starts-->
   <div id="tabs2" class="pagination1">
   <c:choose>
			<c:when test="${empty studentList}">
			<c:out value="NO DATA AVAILABLE"/>
			</c:when>
			<c:otherwise>
     		   <table class="table table-bordered" id="dyntable1">
                <thead>
              	  <tr>
              	    <th width="1%" class="table_centeralign nosort"><input type="checkbox" class="float_left checkboxex selectallstudents"></th>
              	    <th width="5%" class="table_centeralign nosort">Status</th>
                    <th width="20%" class="table_leftalign  nosort">First Name</th>
                    <th width="20%" class="table_leftalign">Last Name</th>
                     <th width="30%" class="table_leftalign">User Name</th>
                    <!-- <th width="24%" class="table_centeralign nosort">Role</th> -->
                    <!--  <th width="12%" class="table_centeralign nosort">Action</th> -->
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${studentList}" var="student"> 
                 		
                	   <tr id="${student.userName}">
                	   		<td><input type="checkbox" class="float_left checkboxex selectstudent"></td>
                	   		<td align="center"><c:choose>
                    		<c:when test="${student.enabled==true}">
                    		<img src="images/green_circle.png"/>
                    		</c:when>
                    	    <c:otherwise><img src="images/red_circle.png"/>
                    		</c:otherwise>
                    		</c:choose></td>
                	   		<td><c:out value="${student.firstName}" /></td>
                	   		<td><c:out value="${student.lastName}" /></td>
                			<td><c:out value="${student.userName}" /></td>
                    		
                    	    		
                  		</tr>
                
                   	</c:forEach>              	
              </tbody>
              </table>
        	</c:otherwise>
        	</c:choose>
     
      <div class="clear"></div> 
      </div> 
   <!--Student Tab Ends-->
   <!--University Tab Starts--> 
   <div id="tabs3" class="pagination1">
   <c:choose>
			<c:when test="${empty universityList}">
			<c:out value="NO DATA AVAILABLE"/>
			</c:when>
			<c:otherwise>
     		   <table class="table table-bordered" id="dyntable2">
                <thead>
              	  <tr>
              	  <th width="1%" class="table_centeralign nosort"><input type="checkbox" class="float_left checkboxex selectalluniv"></th>
                    <th width="5%" class="table_centeralign nosort">Status</th>
                     <th width="25%" class="table_leftalign  nosort">University Name</th>
                    <th width="24%" class="table_leftalign">User Name</th>
                     <th width="25%" class="table_leftalign">User Email Id</th>
                    <th width="20%" class="table_centeralign nosort">University Admin</th>
                  </tr>
              </thead>
                <tbody>
                 <c:forEach items="${universityList}" var="university"> 
				        	
                	   <tr id="${university.userName}">
                	        <td><input type="checkbox" class="float_left checkboxex selectuniv"></td>
                	        <td align="center">
                    		<c:choose>
                    		<c:when test="${university.enabled==true}">
                    		<img src="images/green_circle.png"/>
                    		</c:when>
                    	    <c:otherwise><img src="images/red_circle.png"/>
                    		</c:otherwise>
                    		</c:choose>
                    		</td>
                	   		<td><c:out value="${university.entityName}" /></td>
                	   		<td><c:out value="${university.firstName}" /> <c:out value="${university.lastName}" /></td>
                			<td><c:out value="${university.userName}" /></td>
                    		<td>
                    		<c:choose>
                    		<c:when test="${university.adminFlag==true}">
                    		True
                    		</c:when>
                    	    <c:otherwise>False
                    		</c:otherwise>
                    		</c:choose>
                    		</td>
                  		</tr>
                  	
                   	</c:forEach>              	
              </tbody>
              </table>
        	</c:otherwise>
        	</c:choose>
     
      </div> 
<!--University Tab Ends-->     
 </div>
  
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


  
</body>
</html>