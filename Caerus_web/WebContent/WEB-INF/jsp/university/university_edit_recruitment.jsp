<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Edit Campus Fair</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/style.css">
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
<link rel="stylesheet" href="css/dots.css" type="text/css">
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>

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
 <script type="text/javascript" src="js/jquery-loader.js"></script> 
<script>
    
var sections = {
    'Job Fair': 'jobfair_wrap',
    'Recrutiment': 'recrutiment_wrap',
    'Seminar': 'seminar_wrap'   
};
    
var selection = function(select) 
{
    for(i in sections)
        document.getElementById(sections[i]).style.display = "none";    
		document.getElementById(sections[select.value]).style.display = "block";
}
</script>
<script type="text/javascript">
function searchCompanyListRecruitment() {
	 $.loader({content:"<div class='dots'>Loading Data from Server ...</div>"}); 
	 
   $.ajax({
	     url: 'test_sample.htm?keywords='+ $("#keyword_Id").val()+'&industry='+ $("#industryId").val()+'&companyName='+ $("#companyNameId").val(),
	     type: "GET",	    
	     cache: false,
	     success: function(data) {
	    	 $.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
			  $.loader('close');
	    	  $("#divIdRecruitment").html(data);
	     }
	     });
}


var addition = [];
var companyNameList = [];

function addCompanyList(eventName){

	 $("table#companyList tr :checked").each(function(i){ 
		 var flag = false;
		 var test=$(this).val();
	     var value=test.split(",");
	     var companyNames=value[0];
	     companyNameList.push( companyNames );
	     var companyEmailsId=value[3];
	     addition.push(companyEmailsId);
	  
		 var tr= $('<tr class="item">');
			tr.append('<td class="topvertical_align table_content leftalign"><span class="value">'+value[0]+'</span></td>');
			tr.append('<td class="topvertical_align table_content center_align">Pending</td>');
			tr.append('<td class="table_content center_align"><img src="oldfile/images/commnet_icn.gif" alt="Comment" class="actionbtn"></td>');
			tr.append('</tr>');
			if(eventName=='recruitment' && flag == false){

				$("tr.item").each(function(j) {
				  $this = $(this)
				  var companyValue = $this.find("span.value").html();
				  
				  //alert("companyValue:::"+companyValue);
				  // alert("companyNames:::"+companyNames);
				  if(companyValue==companyNames){
						 alert("Company "+companyValue+" already added to the list, Please choose another company");
						 flag = true;
						 return false;
					 }
				});
				if(flag == false){
					$('#addCompanySeminar').append(tr);
				}	
			}
			 
	    });
	// alert("addition:::"+addition);
	 if(eventName=='jobFair'){
		 $('#email_id_JobFair').val( addition );
		 $('#company_Name_JobFair').val( companyNameList );
		 
	 }else if(eventName=='recruitment'){
		// alert("Recrutiment:::");
		 $('#email_id_Recrutiment').val( addition );
		 $('#company_Name_Recrutiment').val( companyNameList );
	 }else{
		 //alert("Seminar:::");
		 $('#email_id_Seminar').val( addition );
		 $('#company_Name_Seminar').val( companyNameList );
	 }
	
  
}
</script>
<script>
$(function() {
    $( "#from" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      changeYear: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#to" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to" ).datepicker({
	  minDate: 0, 
      defaultDate: "+1w",
      changeMonth: true,
      changeYear: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#from" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
function goBack()
  {
  window.history.back();
  }
</script>

<script type="text/javascript">
	$().ready(function() {

		// validate signup form on keyup and submit
		$("#Company_Recrutiment").validate({
			rules : {
				
				venue : "required",
				/* startDate : {
					required : true,
					trioDate : true
				}, */

				//jobtable : "required",
				startTime : "required",
				endTime : "required",
				addCompanyRecrutiment : "required",
				tableRow : "required",
				/* endDate : {
					greaterThanEqual : "#datepicker3",
					required : true,
					trioDate : true
				}, */

			},
			messages : {
				
				venue : "Please provide  Venue",
				/* startDate : {
					required : "Please provide  Start Date",
					trioDate : "Enter Date in the format yyyy-mm-dd"
				},
				endDate : "Please provide  End Date", */
				startTime : "Please provide Start  Time ",
				endTime : "Please provide End  Time ",
				addCompanyRecrutiment : "Please provide  companies ",
				//jobtable : "Please provide  add table ",
				tableRow : "Please add one company",
				/* endDate : {
					required : "Please provide  End Date",
					greaterThanEqual : "End Date >= Start Date!",
					trioDate : "Enter Date in the format yyyy-mm-dd"
				} */
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
      <div id="banner"><img src="images/university_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div>
   
    <div id="innersection">
   
      <section id="rightwrap" class="floatleft">
       
         <div class="whitebackground">
       <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / Manage Events</div> -->
        <h1 class="sectionheading">Recruitment</h1>
        <p class="description"> Manage All Kind of your day to day events through our portal , Network with different companies to conduct job fairs , recruitments or seminars.</p>
        <div class="event_section" id="section1">
          <form class="stdform" action="" method="get">
            <div class="par" name="choose_event">
          
              <span class="field" >
              <select name="select" class="chzn-select list_widthstyle1" id="food" onchange="selection(this);" disabled>
                <option value="Recrutiment">Recrutiment</option>
              </select>
              </span> </div>
          </form>	
          <div class="clear"></div>
          <div id="recruitment_wrap" class="eventwrap">
            <div id="registration_form">
              <form:form class="stdform" action="" method="post" commandName="universityEventCmd" id="Company_Recrutiment">
                <div class="fullwidth_form">
                 <input type="hidden" name="eventId" value="${universityEventCmd.eventId}"/>
                <input type="hidden" name="eventType" value="${universityEventCmd.eventType}"/>
                 <input type="hidden" name="eventName" value="${universityEventCmd.eventName}"/>
                  <div class="par">
                    <label class="floatleft">Event Title</label>
                    <span class="star">*</span>
                    <div class="clear"></div>
                    <span class="field">
                    <form:input path="eventName" disabled="true" class="input-xxlarge" id="eventName"/>
                   <!--  <input type="hidden" name="eventType" value="Recrutiment"/> -->
                    <form:errors path="eventName"  cssClass="validationnote"/>
                    </span> </div>
                </div>
                <div class="leftsection_form">
                   <div class="par">
											   <div class="floatleft right_margin"> <label class="floatleft">When</label> <span class="star">*</span>
											<div class="clear"></div>
											
											<span class="field"> <form:input path="startDate"
													placeholder="Start Date" class="input-small1"
													id="from" readonly="true"/>
													
													
													
													</span>
													</div>
													
													<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
                    	<form:input path="startTime" id="timepicker1"
													class="input-small_date" />
												<span class="add-on"><i class="icon-time"></i></span></div>
              </div>
													
												
											
										</div>
                  <div class="clear"></div>
                  <div class="par">
                    <label class="floatleft">Venue</label>
                    <span class="star">*</span>
                    <div class="clear"></div>
                    <span class="field">
                    <form:input path="venue" class="input-xxlarge" id="venue"/>
                    <form:errors path="venue"  cssClass="validationnote"/>
                    </span> </div>
                </div>
                <div class="rightsection_form">
                  <div class="par">
											 <div class="floatleft right_margin"> <label class="floatleft">&nbsp;</label>
											<div class="clear"></div>
											<span class="field"> <form:input path="endDate"
													placeholder="End Date" class="input-small1"
													id="to" readonly="true"/>
													
											</span>
											</div>
											<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
													<form:input path="endTime" id="timepicker2"
													class="input-small_date" />
												   <span class="add-on"><i class="icon-time"></i></span></div>
												</div>
												
										</div>
                  <div class="clear"></div>
                  <div class="par">
											<label class="floatleft">Status</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  <form:select path="status"
													class="chzn-select list_widthstyle1">
                            <form:option value="Proposed">Proposed</form:option>
                            <form:option value="Re-Proposed">Re-Proposed</form:option>
                            <form:option value="Cancelled">Cancelled</form:option>
                            <form:option value="Published">Published</form:option>
                            <form:option value="Scheduled">Scheduled</form:option>
                    </form:select>
                    </span> </div>
                </div>
                <div class="clear"></div>
                <div class="fullwidth_form">
                  <div class="par">
                    <label>Description</label>
                    <span class="field">
                    <form:textarea path="description" cols="80" rows="5" class="spanfull width100" id="description" />
                    <form:errors path="description"  cssClass="validationnote"/>
                    </span></div>
                    
                    <div class="par">
                    <label class="floatleft">Invited Company</label>
                    <span class="star">*</span>
                    <div class="clear"></div>
                    <span class="field">
                    <form:input path="invitedCompanies" disabled="true" class="input-xxlarge"/>
                    </span> 
                    </div>
                    
                    
                  <%--  <div class="par">
                    <label class="floatleft">Invite Corporates to Event</label>
                    <span class="star">*</span> <span class="field floatright"> <a href="#companyListModal" data-toggle="modal">
                    <input name="" type="button" value="Add Company" class="no_right_margin addbtn">
                    </a> </span>
                    <div class="clear"></div>
                  </div> 
                  <div class="par">
                        <input type="hidden" id="email_id_Recrutiment" name="email_id_Recrutiment" value="" >
                        <input type="hidden" id="company_Name_Recrutiment" name="company_Name_Recrutiment" value="" >
                  
                        <table  id="addCompanyRecrutiment" width="100%" border="0" cellspacing="0" cellpadding="0" class="recordlisting_table">
                          <tr>
                            <th width="63%" class="table_heading leftalign">Company Name</th>
                            <th width="37%" class="table_heading center_align">Invitation Status</th>
                            <!-- <th width="15%" class="table_heading center_align">Actions</th> -->
                          </tr>
                          <c:forEach items="${invitedCompanyListEvent}" var="invitedCompanyListEvent">
                          <tr class="item">
                            <td class="topvertical_align table_content leftalign"><a href="view_company_profile.htm?companyId=<c:out value="${invitedCompanyListEvent.companyEmailId}" />"><span class="value"><c:out value="${invitedCompanyListEvent.inviteCompanyName}"/></span></a></td>
                            <td class="topvertical_align table_content center_align"><c:out value="${invitedCompanyListEvent.invitationStatus}"/></td>
                           <!--  <td class="table_content center_align"><img src="oldfile/images/commnet_icn.gif" alt="Comment" class="actionbtn"> </td> -->
                          </tr>                          
                          </c:forEach>
                        </table>
                  </div> --%>
                  <div class="doubletop_margin doublebottom_margin">
              <div class="buttonwrap">
                <c:if test="${eventStatus != 'Cancelled'}">
                     <input name="" type="submit" value="Preview" tabindex="21">
                     </c:if>
                <input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
              </div>
            </div>
                </div>
              </form:form>
            </div>
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

<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="companyListModal">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Invite Companies for Seminar</h3>
			</div>
			<div class="modal-body">
				<form:form class="stdform" action="" method="get" commandName="universityEventCmd" id="jobFair_form">
				
					<div class="leftsection_form">
						<div class="par">
											<label class="floatleft">Industry</label>

											<div class="clear"></div>
											<span class="field"> 
											 <form:select path="industry" class="uniformselect" id="industryId">
													<form:option value="">Choose a Option</form:option>
					<c:forEach var="industryList" items="${industryList}">
             
                   <spring:bind path="universityEventCmd.industry"><c:set var = "industrySelected" value="${status.value}"/></spring:bind>
                    
                      
                   <c:choose>
                      <c:when test="${industryList == industrySelected}">
                         <option value="${industryList}" selected="selected"><c:out value="${industryList}" /></option> 
                      </c:when>

                      <c:otherwise>
                         <option value="${industryList}"><c:out value="${industryList}" /></option>
                      </c:otherwise>
                   </c:choose> 
                  
                   </c:forEach>
					</form:select>
					<form:errors path="industry"  cssClass="chzn-select list_widthstyle1"/>
											</span>
										</div>
					</div>
					<div class="rightsection_form">
						<div class="par">
							<label class="floatleft">Company Name</label>
							<div class="clear"></div>
							<span class="field"> <input id="companyNameId"
								name="companyNameId" type="text" class="input-medium" />
							</span>
						</div>
						
					</div>
					<div class="clear"></div>
					<div class="fullwidth_form">
						<ul class="registration_form">
							<li><input name="" type="button"
								onclick="searchCompanyListRecruitment()" value="search"
								tabindex="21" class="add_participants floatleft"></li>
							<li class="twoem_margin">
								<div id="divIdRecruitment">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="recordlisting_table top_margin">
										<tr>
											<th width="5%" class="table_heading leftalign">&nbsp;</th>
											<th width="43%" class="table_heading leftalign">Company
												Name</th>
											<th width="25%" class="table_heading leftalign">Industry</th>
											<th width="27%" class="table_heading leftalign">Location</th>
										</tr>
										<tr>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
										</tr>
									</table>
								</div>
							</li>
							
						</ul>
					</div>
					<div class="clear"></div>
				</form:form>
			</div>
			<div class="modal-footer">
			
									<input name="" type="button" value="Add"
										class="modalCloseImg simplemodal-close"
										onclick="addCompanyList('recruitment')">
									<!--  <input name="" type="button" value="Cancel" class="modalCloseImg simplemodal-close" title="Close" >  -->
								
				<!-- <button data-dismiss="modal" class="btn">Close</button> -->
			</div>
		</div>
</body>
</html>