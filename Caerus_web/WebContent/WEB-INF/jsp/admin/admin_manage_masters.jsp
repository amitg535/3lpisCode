<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Admin Manage Masters</title>
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

<script type="text/javascript">
	$().ready(function(){
		
		$('#selectMaster').change(function()
		{
			$('#masterForm').submit();
		});
		
		$('#addNewField').click(function()
		{
			var masterType = "${masterType}";
			localStorage.setItem("mT",masterType);
			
			if(masterType.trim().length > 0)
			{
				$("#myModalLabel").empty().append("Add New Master Value");
				$("#addMasterLi").empty().append('<input type="button" value="Add" tabindex="21" class="add_participants floatleft" onClick="addMasterValue()">');
			}	
			else {
				alert("Please Select a Master type. For eg: Course Name,Course Type etc. ");
				return false;
			}
			
		});
		
		$('.editMasterValue').click(function()
		{
			var mT = "${masterType}";
			var mV = $(this).children(".eachMasterValue").val();

			localStorage.setItem("mT",mT);
			localStorage.setItem("mV",mV);
			
			$("#newMasterValue").val(mV);
		});
		
		
	});

	function deletePopUp(){
		return window.confirm("Are you sure you want to Delete this Record ? ");
	}
	
	function updateMasterValue(){
		var newValue = $("#newMasterValue").val();
		var masterType = localStorage.getItem("mT");
		var oldValue = localStorage.getItem("mV");
	
		$.ajax({
			  url: "admin_edit_result.htm",
			data:"masterType="+masterType+"&masterValue="+newValue+"&oldValue="+oldValue,
			async:false,
			cache:false
		}).done(function() {
				location.reload();
			});
	}
	
	
	function addMasterValue(){
		var newValue = $("#newMasterValue").val();
		var masterType = localStorage.getItem("mT");
	
		$.ajax({
			  url: "admin_add_master.htm",
			data:"masterType="+masterType+"&masterValue="+newValue,
			async:false,
			cache:false
		}).done(function() {
			location.reload();
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
  
    <div id="innersection">
      <!--   <div id="breadcrums_wrap">You are here: Manage Masters</div> -->
       
        <section id="rightwrap" class="floatleft">
          <div class="whitebackground">
       
        <h1 class="sectionheading">Manage Masters</h1>
 		<div>
 			<c:set value="${masterType}" var="masterType"></c:set>
 			<form action="admin_get_selected_master.htm" method="POST" id="masterForm" >
 				<select id="selectMaster" name="masterType">
 					<c:forEach items="${masters}" var="master">
 						<c:choose>
 							<c:when test="${master.equals(masterType) }">
 								<option value="${master}" selected="selected" ><c:out value="${master}"/></option>
 							</c:when>
 							<c:otherwise>
 								<option value="${master}"><c:out value="${master}"/></option>
 							</c:otherwise>
 						</c:choose>
 					</c:forEach>
 				</select>
 			</form>
 		</div>
 			<c:set value="${masterType}" var="masterType"/>
		<br>
		<br>
		
		<div>
		
			<div class="leftsection_form">
				<a id="addNewField" href="#myModal1" data-toggle="modal"><img src="images/addmore_icn.png" title="Add New" />Add New</a>
	 		</div>
	 	<%-- 	<div id="addMaster" style="display: none;">
	 			<form action="admin_add_master.htm" method="POST" id="masterForm" >
	 				<input type="text" name="masterValue" />
	 				<input type="hidden" name="masterType" value="${masterType}" />
	 				<input type="submit" value="Add" >
	 				
	 			</form>&nbsp;
	 			<c:if test="${not empty alreadyExists}">
	 				<c:out value="${alreadyExists}" />
	 			</c:if>
	 			
	 		</div> --%>
	 		<div class="rightsection_form">
		 		<form action="admin_upload_masters_file.htm" method="POST" enctype="multipart/form-data">
		 			<label for="excelOrCsv">Please Upload a CSV or an Excel File</label>
		 			<input type="file" name="excelOrCsv" id="excelOrCsv" >
		 			<input type="hidden" name="masterType" value="${masterType}" />
		 			<br>
		 			<input type="submit" value="Upload" >
		 		</form>
		 		&nbsp;
		 		<c:if test="${not empty alreadyExists}">
	 				<label class="error"><c:out value="${alreadyExists}" /></label>
	 		</c:if>
	 		</div>
 		</div>
 		
 		<div class="clear"></div>
 		
 		<table class="table table-bordered" id="dyntable1">
                <thead>
                   <tr>
                    <th width="75%" class="table_leftalign">Values</th>
                    <th width="25%" class="table_leftalign">Actions</th>
                  </tr>
              </thead>
                <tbody>
                	
                 <c:forEach items="${results}" var="result">
	                <tr>
	                    <td class="table_centertalign"><c:out value="${result}"/></td>
	                    <td class="table_centertalign">
	                    	<a onclick="return deletePopUp();" href='admin_delete_result.htm?masterType=<c:out value="${masterType}"/>&masterValue=<c:out value="${result}"/>'>
	                    		<img src="images/delete_icn.png" class="table_actionbtn" alt="Delete">&nbsp;
	                    	</a>
	                    	
	                    	<a class="editMasterValue" href="#myModal1" data-toggle="modal">
	                    		<input type="hidden" class="eachMasterValue" value="${result}" />
	                    		<img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit">
	                    	</a>
	                    </td>
	                </tr>
        	  	</c:forEach>
              </tbody>
        </table>
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



<!-- Edit Master Value Modal -->

	<div id="sendJob">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="myModal1">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onClick="hideModal()">x</button>
				<h3 id="myModalLabel">Edit Master Value</h3>
			</div>
			<div class="modal-body">
				<form class="stdform" action="" method="get" id="mailForm">
					<div class="leftsection_form">
						<div class="par">
							<label class="floatleft">New Value</label> <span class="star">*</span>
							<div class="clear"></div>
							<span class="field">
								 <input id="newMasterValue" type="text" class="input-medium" />
							</span>
						</div>
						</div>
					
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
						<li id="addMasterLi"><input type="button" value="Update" tabindex="21" class="add_participants floatleft" onClick="updateMasterValue()"></li> 
						<li><span id="validationMessage" class="hideValidation"></span></li>
						</ul>
					</div>
					<div class="clear"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn" onClick="hideModal()">Close</button>
			</div>
		</div>
	</div>


<!-- Edit Master Value Modal -->


</body>
</html>