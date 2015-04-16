<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty resultCountMap}">
       <div class="searchfilter_wrap">
       <h1 class="sectionheading"> BROWSE JOBS </h1>
        <div class="clear"></div>
        <ul id="sortable2">
        <li class="borderbottom">
        <c:if test="${resultCountMap.containsKey('functionalArea')}">
        <c:if test="${not empty resultCountMap.get('functionalArea')}">
        
	        <div class="left_searchfilter_label"><span class="boldtxt">By Functional Area</span><span class="icon-minus-sign showcnt floatright"></span></div>
	       <div class="details nodisplayelement">
	        <c:forEach items="${resultCountMap}" var="resultCountMap">
	        	<c:if test="${resultCountMap.key eq 'functionalArea'}">
	        	<c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
	        	<c:if test="${status.index < 5}">
	        	<form action="candidate_search_jobs_internships.htm" method="post" id="functionalAreaForm${status.index}"> 
	        <a onclick="getJobs(this.id)" id="functionalArea${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
	        <input type="hidden" value="${resultMap.key}" name="functionalArea">
	        <input type="hidden" name="searchCriteria" value="Jobs" />
	          </form> 
	          </c:if>
	            </c:forEach>
	            </c:if>
	            </c:forEach>
	             <c:if test="${fn:length(resultCountMap.get('functionalArea')) > 5}">
	             <a id="functionalAreaPopOver" class="table_rightalign" style="display:block;"> View All</a>
           </c:if>
	            </div>
	            </c:if>
            </c:if>
            
            </li>
            <li class="borderbottom">
             <c:if test="${resultCountMap.containsKey('industry')}">
              <c:if test="${not empty resultCountMap.get('industry')}">
                	<div class="left_searchfilter_label"><span class="boldtxt">By Industry</span><span class="icon-plus-sign showcnt floatright"></span></div>
                	<div class="details nodisplayelement" style="display:none;">
        <c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'industry'}">
           <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
           <c:if test="${status.index < 5}">
           <form action="candidate_search_jobs_internships.htm" method="post" id="industryForm${status.index}"> 
        <a onclick="getJobs(this.id)" id="industry${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="industry">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
          </c:if>
              </c:forEach>
              </c:if>
              </c:forEach>
           <c:if test="${fn:length(resultCountMap.get('industry')) > 5}">
       			 <a id="industryPopOver" class="table_rightalign" style="display:block;">View All </a>
           </c:if>
               </div>
               </c:if>
               </c:if>
               </li>
                <li class="borderbottom">
               <c:if test="${resultCountMap.containsKey('location')}">
               <c:if test="${not empty resultCountMap.get('location')}">
                	<div class="left_searchfilter_label"><span class="boldtxt">By Location</span><span class="icon-plus-sign showcnt floatright"></span></div>
                	<div class="details nodisplayelement"  style="display:none;">
        <c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'location'}">
            <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
            <c:if test="${status.index < 5}">
           <form action="candidate_search_jobs_internships.htm" method="post" id="locationForm${status.index}"> 
        <a onclick="getJobs(this.id)" id="location${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="location">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
          </c:if>
            </c:forEach>
           </c:if>
            </c:forEach>
              <c:if test="${fn:length(resultCountMap.get('location')) > 5}">
       			  <a id="locationPopOver" class="table_rightalign" style="display:block;">View All </a>
           </c:if>
             </div>
             </c:if>
             </c:if>
              </li>
                <li class="borderbottom">
              <c:if test="${resultCountMap.containsKey('jobType')}">
                <c:if test="${not empty resultCountMap.get('jobType')}">
                	<div class="left_searchfilter_label"><span class="boldtxt">By Type</span><span class="icon-plus-sign showcnt floatright"></span></div>
                	<div class="details nodisplayelement" style="display:none;">
        <c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'jobType'}">
           <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
           <c:if test="${status.index < 5}">
            <form action="candidate_search_jobs_internships.htm" method="post" id="jobTypeForm${status.index}"> 
        <a onclick="getJobs(this.id)" id="jobType${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="jobType">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
          </c:if>
           </c:forEach>
          
           </c:if>
           </c:forEach>
           <c:if test="${fn:length(resultCountMap.get('jobType')) > 5}">
       			  <a id="jobTypePopOver" class="table_rightalign" style="display:block;">View All </a>
           </c:if>
            </div>
           </c:if>
           </c:if>
            </li>
           </ul>
                <div class="clear"></div>
       </div>
       </c:if>
     
<div style="display:none;" id="demo2_tip1">
<c:forEach items="${resultCountMap}" var="resultCountMap">
	        	<c:if test="${resultCountMap.key eq 'functionalArea'}">
	        	<c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
	        	<form action="candidate_search_jobs_internships.htm" method="post" id="functionalAreaForm${status.index}" class="floatleft" style="width:30%; margin:10px 10px;"> 
	        <a onclick="getJobs(this.id)" id="functionalArea${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
	        <input type="hidden" value="${resultMap.key}" name="functionalArea">
	        <input type="hidden" name="searchCriteria" value="Jobs" />
	          </form> 
	            </c:forEach>
	            </c:if>
	            </c:forEach>
 </div>

<div id="demo2_tip2" style="display:none;">
<c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'industry'}">
           <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
           <form action="candidate_search_jobs_internships.htm" method="post" id="industryForm${status.index}" class="floatleft" style="width:30%; margin:10px 10px;"> 
        <a onclick="getJobs(this.id)" id="industry${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="industry">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
              </c:forEach>
              </c:if>
              </c:forEach>
 </div>

<div id="demo2_tip3" style="display:none;">
<c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'location'}">
            <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
           <form action="candidate_search_jobs_internships.htm" method="post" id="locationForm${status.index}" class="floatleft" style="width:30%; margin:10px 10px;"> 
        <a onclick="getJobs(this.id)" id="location${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="location">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
            </c:forEach>
           </c:if>
            </c:forEach>
 </div>

<div id="demo2_tip4" style="display:none;">
<c:forEach items="${resultCountMap}" var="resultCountMap">
           <c:if test="${resultCountMap.key == 'jobType'}">
           <c:forEach items="${resultCountMap.value}" var="resultMap" varStatus="status">
            <form action="candidate_search_jobs_internships.htm" method="post" id="jobTypeForm${status.index}" class="floatleft" style="width:30%; margin:10px 10px;"> 
        <a onclick="getJobs(this.id)" id="jobType${status.index}"><c:out value="${resultMap.key}" /> <span class="count floatright"><c:out value="${resultMap.value}" /></span></a><div class="clear"></div>
        <input type="hidden" value="${resultMap.key}" name="jobType">
        <input type="hidden" name="searchCriteria" value="Jobs" />
          </form>
           </c:forEach>
           </c:if>
           </c:forEach>
 </div>
 