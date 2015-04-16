<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">
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
<script>
function checkUploadedVideo()
{
	var formValue = document.getElementById("uploadFileForm");
	formValue.action = 'employer_upload_file.htm';

	var videoFile = document.getElementById("uploadedFile").value;

	if(videoFile == "")
	{
		$("#emptyVideo").empty().html('Please Choose a File');
		return false;
	}
	else
	{
		var keys = new Array();
		var uploadedFile=$("#uploadedFile").val();
		uploadedFile = uploadedFile.split('\\').pop();

		$('td.table_leftalign').each(function() 
			{
	    	  var tableRowId=$(this).attr('id');
	    	  var tableRowValue=$('#'+tableRowId).html();
			  keys.push(tableRowValue);

			});

			var flagValue=$.inArray(uploadedFile,keys);//Checks if uploadedFile is present inside the 'keys' array.
		 
			if(flagValue==-1)
			{
				formValue.submit();
				$("#errorMsgSpan").empty().append('File Uploaded Successfully');
				return true;//Not Present
			}
			else
			{
				$("#emptyVideo").empty().append('Duplicate File.This File Already Exists.Please Delete and Upload Again.');
				return false;
			}
	}
}
</script> 
<script type="text/javascript">


$(document).ready(
		function(){

		var idCount = 1;
		//Assigning Dynamic IDs to the Table Columns
	    $('td.table_leftalign').each(function() {
	    	   $(this).attr('id', 'tableRow' + idCount);
	    	   idCount++;
	    	});


			
			var keys=[];

			/* $("#uploadFileForm").submit(function(){

				var uploadedFile=$("#uploadedFile").val();
				uploadedFile = uploadedFile.split('\\').pop();

				alert("emptyVideo "+uploadedFile);
				
				$('td.table_leftalign').each(function() 
					{
			    	  var tableRowId=$(this).attr('id');
			    	  var tableRowValue=$('#'+tableRowId).html();
					  keys.push(tableRowValue);

					});

					var flagValue=$.inArray(uploadedFile,keys);//Checks if uploadedFile is present inside the 'keys' array.
				 
					if(flagValue==-1)
					{
						return true;//Not Present
					}
					else
					{
						$("#errorMsgSpan").empty().append('Duplicate File.This File Already Exists');
					}

					var formValue = $("#uploadFileForm");
					formValue.action = 'employer_upload_file.htm';

					if(uploadedFile == "")
					{
						$("#emptyVideo").html('Please Choose a File');
						return false;
					}
					else
					{
						formValue.submit();
					}
					
			});	 */
		
		});
</script>
<style type="text/css">

.uploader{float:left;}
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
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
    
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="#">Admin</a> / Manage Files</div> -->
      
      <section id="rightwrap" class="floatleft">
      <div class="whitebackground">
        <h1 class="sectionheading">Manage Files </h1>
        <div class="clear"></div>
         <div class="doublebottom_margin"> 
	         <form:form class="stdform" action="" enctype="multipart/form-data" method="post" modelAttribute="employerCom" id="uploadFileForm">
	            <div class="par">
		              <label>Select a file to upload to Repository</label>
		              <span class="field">
			              <input type="file" class="uniform-file" name="file" id="uploadedFile" />
			              <div class="float_left">&nbsp;&nbsp;<input name="" type="submit" value="Upload" onclick="return checkUploadedVideo();"></div>
			              <label class="error clear" id="emptyVideo"></label>
		              </span> 
		              
		              
	             </div>
	        </form:form>
        </div>
        </div>
        <div class="clear"></div>
        <span class="errormsg" id="errorMsgSpan">
        </span>
          <div class="clear"></div>
        <div id="candidate_registration_wrap" class="whitebackground margin_top2">
          <div class="par">
            <table class="table table-bordered" id="dyntable_columntwo">
              <thead>
                <tr>
                  <th width="45%" class="table_leftalign">File Name</th>
                  <th width="14%" class="table_centeralign">Posted On</th>
                  <th width="15%" class="table_centeralign">Mime Type</th>
                  <th width="14%" class="table_centeralign">File Size (KBs)</th>
                  <th width="12%" class="table_centeralign nosort">Actions</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${employerRepoFiles}" var="employerRepoFile">
                <tr>
                  <td class="table_leftalign"><c:out value="${employerRepoFile.fileName}"/></td>
                  <td class="table_centeralign">
                  <fmt:parseDate value="${employerRepoFile.postedOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="filesPostedOn"/>
                  <fmt:formatDate type="date" value="${filesPostedOn}" pattern="yyyy-MM-dd"/>
                  </td>
                  <td class="table_centeralign"><c:out value="${employerRepoFile.fileMimeType}"/></td>
                  <td class="table_centeralign"> <c:out value="${employerRepoFile.fileSize}"/></td>
                  <td class="table_centeralign"><a href="employer_delete_file.htm?fileId=${employerRepoFile.fileId}">
                  <img src="images/small_delete_icn.png" alt="Cancel" title="Cancel" class="table_actionbtn"></a></td>
                </tr>               
             </c:forEach>          
              </tbody>
            </table>
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
<div id="mask"></div>
</body>
</html>
