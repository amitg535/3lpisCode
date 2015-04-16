<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Saved Searches</title>
<meta name="description" content="">
<meta name="author" content="">
<!--[if lt IE 7]>
	<style type="text/css">
		#wrap { height:100%; }       
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
<script type="text/javascript">
  $(function()
  {
      $('#wysiwyg').wysiwyg({
    controls: {
    
     increaseFontSize   : { visible : true },
     decreaseFontSize  : { visible : true }
    }
  });
  });
  </script>
  
  
<!-- <script language="javascript" type="text/javascript">
 function callSaveSearch() {
	
	 var f = document.form2;
	 f.action = "<c:url value='/candidate_savedsearch.htm' /> ";
	 f.submit();
 }
</script>

<script language="javascript" type="text/javascript">
 function deleteSelectedCheckbox() {
	 var f = document.form1;
	 f.action = "<c:url value='/employer_delete_savedsearch.htm' /> ";
	 f.submit();
 }
</script>
 
 
 
</script>
</script> -->
<script type="text/javascript">
function confirmDelete(){
	 return confirm("Are you Sure you want to Delete?");
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
    <div id="innerbanner_wrap">
      <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
 
     
    <div id="innersection">
      <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> \ <a href="employer_search_candidate.htm">Search Candidates</a></div> -->
      
      
     <%--  <section id="leftsection" class="floatleft">
        <h3 class="nomargin">Search Resumes</h3>
        <ul class="leftsectionlinks">
          <li><a href="employer_candidateSearch.htm">Advanced Search</a></li>
          <li><a href="employer_saved_searches.htm">Saved Search</a></li>
        </ul>        
        <h3>Useful Links</h3>
        <ul class="leftsectionlinks">
          <li><a href="#">Background Check Services</a></li>
          <li><a href="#">Checklist Employee Contract</a></li>
          <li><a href="#">Hire Overseas Employees</a></li>
        </ul>
        <div id="newsletterwrap">
          <h3>Newsletter</h3>
          <form>
            <input name="" type="text" class="textbox">
            <input name="" type="button" value="Subscribe">
          </form>
        </div>
        
      </section> --%>
      
      <section id="" class="">
      <div class="whitebackground margin_top2">
        <h1 class="sectionheading">Saved Searches (<c:out  value="${count}"/>)</h1>
        <div id="candidate_registration_wrap">
          <div class="par">
          <c:choose>
    	<c:when test="${count==0}">
     		<c:out value="No Records to Display"/>
   		</c:when>
    		<c:otherwise>
            <table class="table table-bordered" id="dyntable">
              <thead>
                <tr>                  
                  <th width="67%" class="table_leftalign">Search Title</th>
                  <th width="16%" class="table_centeralign">Saved on</th>
                  <th width="17%" class="table_centeralign nosort">Actions</th>
                </tr>
              </thead>
              <tbody>
               <c:forEach items="${searchjobs}" var="searchjobs">
              <tr>
              <td class="table_leftalign"> <a href="employer_saved_search_candidates.htm?searchParameterName=<c:out value="${searchjobs.parameterName}"/>"><c:out value="${searchjobs.parameterName}"/>
              </a></td>
              <fmt:parseDate value="${searchjobs.savedSearchOn}" type="DATE" pattern="E MMM dd HH:mm:ss Z yyyy" var="formatedDate"/>
              <td class="table_centeralign"><fmt:formatDate type="date" value="${formatedDate}" pattern="dd-MM-yyyy"/></td>
              <td class="table_centeralign"> <a onclick="return confirmDelete();" href="employer_delete_saved_search.htm?searchParameterName=<c:out value="${searchjobs.parameterName}"/>">
              <img src="images/small_delete_icn.png" width="16" height="16" alt="delete" title="delete" class="table_actionbtn"></a>
              </td>
              </tr>
               </c:forEach>
      
              </tbody>
            </table>
            </c:otherwise>
          </c:choose>
          </div>
         </div>
    
        </div>
      </section>
    
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