<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Saved Search</title>
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
  
  
<script language="javascript" type="text/javascript">
 function callSaveSearch() {
	
	 var f = document.form2;
	 f.action = "<c:url value='/candidate_savedsearch.htm' /> ";
	 f.submit();
 }

</script>

<script language="javascript" type="text/javascript">
 function deleteSelectedCheckbox() {
	
	 var f = document.form1;
	 f.action = "<c:url value='/candidate_delete_savedsearch.htm' /> ";
	 f.submit();
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
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div> 

    <div id="innersection">
     <!--  <div id="breadcrums_wrap">You are here: <a href="candidate_dashboard.htm">Home</a> \ <a href="candidate_advancesearch.htm">Search Jobs</a></div> -->
      
      
    <%--   <section id="leftsection" class="floatleft">
        <h3 class="nomargin">Search Resumes</h3>
        <ul class="leftsectionlinks">
          <li><a href="candidate_advancesearch.htm">Advanced Search</a></li>
          <li>Saved Search</li>
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
      
      <section id="rightwrap" class="floatleft">
      <div class="whitebackground">
      
        <h1 class="sectionheading">Saved Search(<c:out  value="${count}"/>)</h1>
        <div id="candidate_registration_wrap">
          <div class="par">
          <c:choose>
    	<c:when test="${count== 0}">
     		<c:out value="No Records to Display"/>
   		</c:when>
    		<c:otherwise>
    		 
            <table class="table table-bordered"  id="dyntable_five1">
              <thead>
                <tr>                  
                  <th width="50%" class="table_leftalign">Search Title</th>
                  <th width="16%" class="table_centeralign">Saved on</th>
                  <th width="17%" class="table_centeralign">Searched for</th>
                  <th width="17%" class="table_centeralign nosort">Actions</th>
                </tr>
              </thead>
              <tbody>
               <c:forEach items="${savedSearches}" var="savedSearch">
              <%--  <form:form action="candidate_saved_search_jobs_available.htm" id = "searchParameters" method = "post"> --%>
              <form:form action="candidate_search_jobs_internships.htm" id = "searchParameters" method = "post" modelAttribute="searchJobsCommand">
	              <tr>
	              <td class="table_leftalign"><input name="${savedSearch.parameterName}" type="submit" value="${savedSearch.parameterName}" class="tabtitle"></td>
	              <td class="table_centeralign"> <fmt:formatDate var="formattedDate" pattern="dd MMM yyyy HH:mm" value="${savedSearch.savedSearchOn}" /><c:out value="${formattedDate}"/></td>
	              <td class="table_centeralign"> <c:out value="${savedSearch.searchCriteria}"/></td>
	              <td class="table_centeralign"> <a href="candidate_delete_saved_searches.htm?searchParameterName=<c:out value="${savedSearch.parameterName}"/>">
	              <img src="images/small_delete_icn.png" width="16" height="16" alt="delete" title="delete" class="table_actionbtn"></a>
	              </td>
	              </tr>
	              
	               <input type="hidden" name="searchParameterName" value="${savedSearch.parameterName}" />
	              <input type="hidden" name="keyword" value="${savedSearch.keyword}" />
	        		<input type="hidden" name="location" value="${savedSearch.location}" />
	        		<input type="hidden" name="functionalArea" value="${savedSearch.functionalArea}" />
	        		<input type="hidden" name="industry" value="${savedSearch.industry}" />
	        		<input type="hidden" name="searchCriteria" value="${savedSearch.searchCriteria}" />

              </form:form>
              
               </c:forEach>
      
              </tbody>
            </table>
            
            </c:otherwise>
          </c:choose>
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
