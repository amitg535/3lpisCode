<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>University Schedule Event</title>
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
<link rel="stylesheet" href="css/uielements/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css"
	type="text/css" />
 <link rel="stylesheet" href="css/uielements/jquery.ui.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css"
	type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css"
	type="text/css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
<link rel="stylesheet" href="css/dots.css" type="text/css">
<link rel="stylesheet" href="css/jquery-loader.css" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript"
	src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript"
	src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/script.js"></script>

<script type="text/javascript" src="js/jquery-loader.js"></script>


<script>
	function start() {
		var f = document.getElementById("jobfair_wrap");
		var s = document.getElementById("recruitment_wrap");
		var l = document.getElementById("seminar_wrap");
		f.style.display = 'display';
		s.style.display = 'none';
		l.style.display = 'none';
	}
	function disp_div() {
		var word = document.eventform.events.selectedIndex;
		var selected_text = document.eventform.events.options[word].text;
		var f = document.getElementById("jobfair_wrap");
		var s = document.getElementById("recruitment_wrap");
		var l = document.getElementById("seminar_wrap");
		if (selected_text == 'Job Fair') {
			f.style.display = 'block';
			s.style.display = 'none';
			l.style.display = 'none';
		} else if (selected_text == 'Recruitment') {
			f.style.display = 'none';
			s.style.display = 'block';
			l.style.display = 'none';
		} else if (selected_text == "Seminar") {
			f.style.display = 'none';
			s.style.display = 'none';
			l.style.display = 'block';
		}
		$("tr.item").remove();
		$("tr.item1").remove();
		$("tr.item2").remove();
		// $("tr.item").html("");
	}
</script>

<script type="text/javascript">


	function searchCompanyListJobFair() {
		$("#divIdRecruitment").html("");
		$("#divIdSeminar").html("");

		/* $.loader({content:"<div style='color:#aaedf9;'>Loading Data from Server ...</div>"}); */
		
		 $.loader({content:"<div class='dots'> Loading...</div>"});
		$.ajax({
			url : 'search_companies_for_universityJobFair.htm?keywords=' + $("#keywordId").val()
					+ '&industry=' + $("#industryId").val() + '&companyName='
					+ $("#companyNameId").val(),
			type : "GET",
			dataTye: "json",
			cache : false,
			success : function(data) {
				$.loader('setContent', '<div style="color:#aaedf9;">Data Received !<br /> Still processing ...</div>');
				$.loader('close');
				//$("#divIdJobFair").html(data);
							  var data = $.parseJSON(data);

							  
					     addSearchedCompanies(data);
					     
					
				  
			},
			error:function(xhr,error)
			{
			$.loader('close');
			}
		});
	}

	function addSearchedCompanies(data){

		var tableRow= $("#searchedCompaniesList");

		tableRow.empty();
		
		for(var key in data){
			var newAddedRow = $('<tr/>');
			var checkboxvalue=data[key].companyName+","+data[key].industry+","+data[key].city;
			var chkbox = $('<input>').attr('type', 'checkbox').attr('value',checkboxvalue);
			var tdCheckBox=$('<td class= "topvertical_align table_content leftalign">');
			var tdCompany=$('<td  class= "topvertical_align table_content leftalign"/>');
			var tdIndustry=$('<td class= "topvertical_align table_content leftalign"/>');
			var tdLocation=$('<td class= "topvertical_align table_content leftalign"/>');

			tdCheckBox.append(chkbox);
			tdCompany.html(data[key].companyName);
			tdIndustry.html(data[key].industry);
			tdLocation.html(data[key].city);
			newAddedRow.append(tdCheckBox);
			newAddedRow.append(tdCompany);
			newAddedRow.append(tdIndustry);
			newAddedRow.append(tdLocation);

			//tableRow.empty();
			tableRow.append(newAddedRow);
			

			};
		

		}

	
	
	

	var addition = [];
	var companyNameList = [];

	function addCompanyList(eventName) {

		$("table#companyList tr :checked")
				.each(
						function(i) {
							var jobflag = false;
							var recrflag = false;
							var seminarflag = false;

							if (eventName == 'jobFair' && jobflag == false) {
								

								var test = $(this).val();
								var value = test.split(",");
								var companyNames = value[0];
								var tr = $('<tr class="item">');
								tr.append('<td class="topvertical_align table_content leftalign"><span class="value">'+ value[0] + '</span></td>');
								tr.append('<td class="topvertical_align table_content center_align">Pending</td>');
								tr.append('</tr>');

								$("tr.item")
										.each(
												function(j) {
													$this = $(this);
													var companyValue = $this
															.find("span.value")
															.html();

													//  alert("companyValue:::"+companyValue);
													//  alert("companyNames:::"+companyNames);
													if (companyValue == companyNames) {
														alert("Company "
																+ companyValue
																+ " already added to the list, Please choose another company");
														jobflag = true;
														return false;
													}
												});
								if (jobflag == false) {
									$('#addCompanyJobFair').append(tr);
									// var companyNames=value[0];
									companyNameList.push(companyNames);
									var companyEmailsId = value[3];
									addition.push(companyEmailsId);
									$('#email_id_JobFair').val(addition);
									$('#company_Name_JobFair').val(
											companyNameList);
									$("#jobFair_form").append('<input type="hidden" name="invitedCompanies['+i+']" value="'+companyNames+'"/>');
								}


								
								} 

						});

		

	}

	
</script>

<script type="text/javascript">
	$().ready(function() {

		// validate signup form on keyup and submit
		$("#jobFair_form").validate({
			rules : {
				eventName : "required",
				venue : "required",
				startDate : {
					required : true,
					trioDate : true
				},

				jobtable : "required",
				time : "required",
				addCompanyJobFair : "required",
				tableRow : "required",
				 endDate : {
					//greaterThanEqual : "#datepicker1",
					required : true,
					trioDate : true
				}, 

			},
			messages : {
				eventName : "Please enter your event Title",
				venue : "Please provide  Venue",
				startDate : {
					required : "Please provide  Start Date",
					trioDate : "Enter Date as yyyy-mm-dd"
				},
				endDate : "Please provide  End Date",
				time : "Please provide  Time ",
				addCompanyJobFair : "Please provide  addCompanyJobFair ",
				jobtable : "Please provide  add table ",
				tableRow : "Please add one company",
				/* endDate : {
					required : "Please provide  End Date",
					greaterThanEqual : "End Date cannot be before Start Date!",
					trioDate : "Enter Date as yyyy-mm-dd"
				} */
			}
		});

	});
</script>

<script type="text/javascript">
	$().ready(function() {
		//alert("w");

		// validate signup form on keyup and submit
		$("#Company_Recrutiment").validate({
			rules : {
				eventName : "required",
				venue : "required",
				startDate : {
					required : true,
					trioDate : true
				},
			 	endDate : {
					//greaterThanEqual : "#datepicker3",
					required : true,
					trioDate : true
				}, 
				time : "required",
				inviteCompanyName : "required"

			},
			messages : {
				eventName : "Please enter your event Title",
				venue : "Please provide  Venue",
				startDate : {
					required : "Please provide  Start Date",
					trioDate : "Enter Date as yyyy-mm-dd"
				},
				 endDate : "Please provide  End Date",
				time : "Please provide  Time ", 
				inviteCompanyName : "Please select a Company"
				
				/* endDate : {
					required : "Please provide  End Date",
					greaterThanEqual : "End Date cannot be before Start Date!",
					trioDate : "Enter Date as yyyy-mm-dd"
				} */
			}
		});

	});
</script>

<script type="text/javascript">
	$().ready(function() {
		//alert("w");

		// validate signup form on keyup and submit
		$("#Seminar_Schedule").validate({
			rules : {
				eventName : "required",
				venue : "required",
				invitedCompanies : "required",
				speakerName : "required",
				topic : "required",
				startDate : {
					required : true,
					trioDate : true
				},
				 endDate : {
					//greaterThanEqual : "#datepicker5",
					required : true,
					trioDate : true
				}, 
				time : "required"
			},
			messages : {
				eventName : "Please enter your event Title",
				venue : "Please provide  Venue that is Non Numeric",
				invitedCompanies : "Please provide  Company Name",
				speakerName : "Please provide  speaker Name",
				topic : "Please provide  Topic",
				startDate : {
					required : "Please provide  Start Date",
					trioDate : "Enter Date in the format yyyy-mm-dd"
				},
				time : "Please provide  Time ",
				endDate : "Please provide  End Date"
				/* endDate : {
					required : "Please provide  End Date",
					greaterThanEqual : "End Date cannot be before Start Date!",
					trioDate : "Enter Date in the format yyyy-mm-dd"
				} */
			}
		});

	});
</script>

<script type="text/javascript">
	function JobSubmit() {
		var rowCount = $('#addCompanyJobFair tr').length;
		var form = $("#jobFair_form");
		//alert(rowCount);
		if (rowCount == 1) {
			alert("Add atleast one company for the participant");
			return false;
		}
		form.validate();
		if (!form.valid()) {
			return false;
		}
		if (rowCount > 1 && form.valid()) {
			//alert(rowCount);
			
			return true;
		}
		return false;
	}
</script>

<!-- <script type="text/javascript">
	function recrSubmit() {
		var rowCount = $('#addCompanyRecrutiment tr').length;
		if (rowCount == 1) {
			alert("Add atleast one company for the participant");
			return false;
		}
		var form = $("#Company_Recrutiment");
		form.validate();
		if (!form.valid()) {
			return false;
		}
		if (rowCount >1 && form.valid())

		{
			return true;
		}
return false;
	}
</script>

<script type="text/javascript">
	function SeminarSubmit() {
		var rowCount = $('#addCompanySeminar tr').length;
		if (rowCount == 1) {
			alert("Add atleast one company for the participant");
			return false;
		}
		var form = $("#Seminar_Schedule");
		form.validate();
		if (!form.valid()) {
			return false;
		}
		if (rowCount > 1 && form.valid()) {
			return true;
		}
		return false;
	}
</script>

 -->
<style type="text/css">
form.cmxform label.error,label.error {
	color: red;
	font-style: italic;
}

#commentForm {
	width: 500px;
}

#commentForm label {
	width: 250px;
}

#commentForm label.error,#commentForm input.submit {
	margin-left: 253px;
}

#signupForm {
	width: 670px;
}

#signupForm label.error {
	margin-left: 10px;
	width: auto;
	display: inline;
}

#newsletter_topics label.error {
	display: none;
	margin-left: 103px;
}
</style>
<script>
	function goBack() {
		window.history.back();
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
 
 $(function() {
	    $( "#from1" ).datepicker({
		  minDate: 0, 
	      defaultDate: "+1w",
	      changeMonth: true,
	      changeYear: true,
	      numberOfMonths: 1,
	      onClose: function( selectedDate ) {
	        $( "#to1" ).datepicker( "option", "minDate", selectedDate );
	      }
	    });
	    $( "#to1" ).datepicker({
		  minDate: 0, 
	      defaultDate: "+1w",
	      changeMonth: true,
	      changeYear: true,
	      numberOfMonths: 1,
	      onClose: function( selectedDate ) {
	        $( "#from1" ).datepicker( "option", "maxDate", selectedDate );
	      }
	    });
	  });
 
 $(function() {
	    $( "#from2" ).datepicker({
		  minDate: 0, 
	      defaultDate: "+1w",
	      changeMonth: true,
	      changeYear: true,
	      numberOfMonths: 1,
	      onClose: function( selectedDate ) {
	        $( "#to2" ).datepicker( "option", "minDate", selectedDate );
	      }
	    });
	    $( "#to2" ).datepicker({
		  minDate: 0, 
	      defaultDate: "+1w",
	      changeMonth: true,
	      changeYear: true,
	      numberOfMonths: 1,
	      onClose: function( selectedDate ) {
	        $( "#from2" ).datepicker( "option", "maxDate", selectedDate );
	      }
	    });
	  });
 
 </script>
 
<!-- <script>

$(document).ready(function() {	
 	var watermark = "Start Date";
	$('#datepicker1').val(watermark);
	$('#datepicker1').click(function(){
  		if ($(this).val() == watermark){
    		$(this).val('');
		}
 	}); 
	
	var watermark1 = "End Date";
	$('#datepicker2').val(watermark1);
	$('#datepicker2').click(function(){
  		if ($(this).val() == watermark1){
    		$(this).val('');
		}
 	});
	
	var watermark2 = "Start Date";
	$('#datepicker3').val(watermark2);
	$('#datepicker3').click(function(){
  		if ($(this).val() == watermark2){
    		$(this).val('');
		}
 	});
	
	var watermark3 = "End Date";
	$('#datepicker4').val(watermark3);
	$('#datepicker4').click(function(){
  		if ($(this).val() == watermark3){
    		$(this).val('');
		}
 	});
	
	var watermark4 = "Start Date";
	$('#datepicker5').val(watermark4);
	$('#datepicker5').click(function(){
  		if ($(this).val() == watermark4){
    		$(this).val('');
		}
 	});
	
	var watermark5 = "End Date";
	$('#datepicker6').val(watermark5);
	$('#datepicker6').click(function(){
  		if ($(this).val() == watermark5){
    		$(this).val('');
		}
 	});
});

</script> -->

</head>
<body onLoad="start()">
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		<%@ include file="includes/header.jsp"%>
		<!--------------  Header Section :: end ------------>
		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
			<div id="banner">
	<img src="images/university_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level" >
				
			</div>
			
			<div id="innersection">
				<!-- <div id="breadcrums_wrap">
					You are here: <a href="university_dashboard.htm">Dashboard</a> / <a href="university_manage_scheduledevents.htm">Manage
						Events</a> / Schedule An Event
				</div> -->
				<%-- <section id="leftsection" class="floatleft">
					<h3 class="nomargin">Corporate Connect</h3>
					<ul class="leftsectionlinks">
						<li><a
							href="<c:url value='university_manage_scheduledevents.htm'/>">Manage
								Scheduled Events</a></li>
						<li><a href="university_manage_receivedinvitations.htm">Manage
								Received Invitations</a></li>
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
							<input name="" type="text" class="textbox"> <input
								name="" type="button" value="Subscribe">
						</form>
					</div>
				</section> --%>
				<section id="rightwrap" class="floatleft">
				  <div class="whitebackground">
					<h1 class="sectionheading">Schedule An Event</h1>
					<p class="description">Manage All Kind of your day to day
						events through our portal , Network with different companies to
						conduct job fairs , recruitments or seminars.</p>
					<div class="required_feilds_note">
						<div class="message floatright"><span class="star">*</span>Denotes required fields</div>
						<!-- <div class="star floatright">*</div> -->
						<div class="clear"></div>
					</div>
					
						 <div class="event_section" id="section1">
						
							<form class="stdform" action="" name="eventform">
							<div class="par" name="choose_event" id="choose_event">
								<label>Please Select Event which you want to Schedule</label>
								<div class="clear"></div>
                
                <span class="field">
									
									<select name="events" onChange="disp_div()" class="chzn-select list_widthstyle1">
											<option value="jobfair">Job Fair</option>
											<option value="recruitment">Recruitment</option>
											<option value="seminar">Seminar</option>
									</select>
									</span>
								</div>
								
						</form>
						
						<!-- Job fair  -->
						 <div id="jobfair_wrap" class="eventwrap">
							<div id="registration_form">
						
								<form:form class="stdform"
									action="university_schedule_anevent.htm" method="post"
									commandName="universityEventCmd" id="jobFair_form">
									
									<div class="leftsection_form">
									<input type="hidden" value="true" name="jobFairFlag">
										<div class="par">
											<label class="floatleft">Job Fair Title</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="eventName"
													class="input-xxlarge" id="eventName" /> <input
												type="hidden" name="eventType" value="Job Fair" /> <form:errors
													path="eventName" cssClass="validationnote" />
											</span>
										</div>
										
										
										<div class="clear"></div>
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
											<label class="floatleft">Venue</label> <span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="venue"
													class="input-xxlarge" id="venue" /> <form:errors
													path="venue" cssClass="validationnote" />
											</span>
										</div>
										
										
										
										<div class="clear"></div>
									</div>
									
									<div class="rightsection_form">
									
										<div class="par">
											<label class="floatleft">Status</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  <form:select path="status"
													class="chzn-select list_widthstyle1">
													<form:option value="Proposed">Proposed</form:option>
													<%--                             <form:option value="Re-Proposed">Re-Proposed</form:option>
                            <form:option value="Cancelled">Cancelled</form:option>
                            <form:option value="Publish">Publish</form:option>
                            <form:option value="Scheduled">Scheduled</form:option> --%>
												</form:select>
											</span>
										</div>
										<div class="clear"></div>
										
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
									</div>
									<div class="fullwidth_form clear">
										<div class="par">
											<label>Description</label> <span class="field"> <form:textarea
													path="description" cols="80" rows="5" class="spanfull width100"
													id="description" /> <form:errors path="description"
													cssClass="validationnote" />
											</span>
										</div>
										<div class="par">
											<label class="floatleft">Invite Corporates to Event</label> <span
												class="star">*</span> <span class="field floatright">
												<a href="#myModal1" data-toggle="modal"> 
												<input name="" type="button" value="Add Participants" class="no_right_margin addbtn">
											</a>
											</span>
											<div class="clear"></div>
										</div>
										<div class="par">

											<input type="hidden" id="email_id_JobFair"
												name="email_id_JobFair" value=""> <input
												type="hidden" id="company_Name_JobFair"
												name="company_Name_JobFair" value="">

											<table id="addCompanyJobFair" width="100%" border="0"
												cellspacing="0" cellpadding="0" class="recordlisting_table">
												<tr>
													<th width="73%" class="table_heading leftalign">Company
														Name</th>
													<th width="27%" class="table_heading center_align">Invitation
														Status</th>
													<!-- <th width="15%" class="table_heading center_align">Actions</th> -->
												</tr>
												<!--                           <tr class="item">
                            <td class="topvertical_align table_content leftalign">-</td>
                            <td class="topvertical_align table_content center_align">-</td>
                            <td class="table_content center_align">-</td>
                          </tr> -->
											</table>
										</div>
										<div class="doubletop_margin doublebottom_margin">
											<div class="buttonwrap">
												<input name="" type="submit" value="Preview" tabindex="21"
													onclick="return JobSubmit()"> <input name="" type="button"
													value="Back" tabindex="22" onclick="goBack()">
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
						<!-- recrutiment -->
						<div id="recruitment_wrap" class="eventwrap">
							<div id="registration_form">
								<form:form class="stdform"
									action="university_schedule_anevent.htm" method="post"
									commandName="universityEventCmd" id="Company_Recrutiment">
									<div class="fullwidth_form">
									<input type="hidden" value="true" name="recruitmentFlag">
										<div class="par">
											<label class="floatleft">Event Title</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="eventName"
													class="input-xxlarge" id="eventName" /> <input
												type="hidden" name="eventType" value="Recruitment" /> <form:errors
													path="eventName" cssClass="validationnote" />
											</span>
										</div>
									</div>
									<div class="leftsection_form">
									
									<div class="par">
											   <div class="floatleft right_margin"> <label class="floatleft">When</label> <span class="star">*</span>
											<div class="clear"></div>
											
											<span class="field"> <form:input path="startDate"
													placeholder="Start Date" class="input-small1"
													id="from1" readonly="true"/>
													
													
													
													</span>
													</div>
													
													<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
                    	<form:input path="startTime" id="timepicker3"
													class="input-small_date" />
												<span class="add-on"><i class="icon-time"></i></span></div>
              </div>
													
												
											
										</div>
									
									
										<div class="clear"></div>
										<div class="par">
											<label class="floatleft">Venue</label> <span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="venue"
													class="input-xxlarge" id="venue" /> <form:errors
													path="venue" cssClass="validationnote" />
											</span>
										</div>
									</div>
									<div class="rightsection_form">
											<div class="par">
											 <div class="floatleft right_margin"> <label class="floatleft">&nbsp;</label>
											<div class="clear"></div>
											<span class="field"> <form:input path="endDate"
													placeholder="End Date" class="input-small1"
													id="to1" readonly="true"/>
													
											</span>
											</div>
											<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
													<form:input path="endTime" id="timepicker4"
													class="input-small_date" />
												   <span class="add-on"><i class="icon-time"></i></span></div>
												</div>
												</div>
										<div class="clear"></div>
										<div class="par">
											<label class="floatleft">Status</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  <select class="chzn-select list_widthstyle1">
													<option value="Proposed">Proposed</option>		
												</select>
											</span>
										</div>
									</div>
									<div class="clear"></div>
									<div class="fullwidth_form clear">
										<div class="par">
											<label>Description</label> <span class="field"> <form:textarea
													path="description" cols="80" rows="5" class="spanfull width100"
													id="description" /> <form:errors path="description"
													cssClass="validationnote" />
											</span>
										</div>
										<div class="par">
											<label class="floatleft">Invite Company</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  
											
											<form:select path="invitedCompanyRecruitment" class="chzn-select" items="${companyList}">
													<%-- 	<c:forEach var="companyList" items="${companyList}">
													<option value="${companyList.companyName}"><c:out value="${companyList.companyName}"/></option>
														</c:forEach> --%>
													</form:select>
											
											</span>
										</div>
										
										<!-- <div class="par">
											<label class="floatleft">Invite Corporates to Event</label> <span
												class="star">*</span> <span class="field floatright">
											
							<a href="#myModal2" data-toggle="modal"> 
												<input name="" type="button" value="Add Company" class="no_right_margin">
											</a>
											
											
											<a href="#recruitement" data-toggle="modal"> 
												<input name="" type="button" value="Add Participants" class="no_right_margin addbtn">
											</a>
											</span>
											<div class="clear"></div>
										</div> -->
										<!-- <div class="par">
											<input type="hidden" id="email_id_Recrutiment"
												name="email_id_Recrutiment" value=""> <input
												type="hidden" id="company_Name_Recrutiment"
												name="company_Name_Recrutiment" value="">

											<table id="addCompanyRecrutiment" width="100%" border="0"
												cellspacing="0" cellpadding="0" class="recordlisting_table">
												<tr>
													<th width="63%" class="table_heading leftalign">Company
														Name</th>
													<th width="22%" class="table_heading center_align">Invitation
														Status</th>
													<th width="15%" class="table_heading center_align">Actions</th>
												</tr>
											</table>
										</div> -->
										<div class="doubletop_margin doublebottom_margin">
											<div class="buttonwrap">
												
												<input name="" type="submit" value="Preview" tabindex="21"> 
												<input name="" type="button" value="Back" tabindex="22" onclick="goBack()">
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>

						<!-- Seminar -->
						<div id="seminar_wrap" class="eventwrap">
							<div id="registration_form">
								<form:form class="stdform"
									action="university_schedule_anevent.htm" method="post"
									commandName="universityEventCmd" id="Seminar_Schedule">
									<div class="fullwidth_form">
									<input type="hidden" value="true" name="seminarFlag">
										<div class="par">
											<label class="floatleft">Event Title</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="eventName"
													class="input-xxlarge" id="eventName" /> <form:errors
													path="eventName" cssClass="validationnote" /> <input
												type="hidden" name="eventType" value="Seminar" />
											</span>
										</div>
									</div>
									<div class="leftsection_form">
											<div class="par">
											   <div class="floatleft right_margin"> <label class="floatleft">When</label> <span class="star">*</span>
											<div class="clear"></div>
											
											<span class="field"> <form:input path="startDate"
													placeholder="Start Date" class="input-small1"
													id="from2" readonly="true"/>
													
													
													
													</span>
													</div>
													
													<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
                    	<form:input path="startTime" id="timepicker5"
													class="input-small_date" />
												<span class="add-on"><i class="icon-time"></i></span></div>
              </div>
													
												
											
										</div>
									
										<div class="clear"></div>
										<div class="par">
											<label class="floatleft">Speaker Name</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="speakerName"
													class="input-xxlarge" id="speakerName" /> <form:errors
													path="speakerName" cssClass="validationnote" />
											</span>
										</div>
										
										<div class="par">
											<label class="floatleft">Venue</label> <span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:input path="venue"
													class="input-xxlarge" id="venue" /> <form:errors
													path="venue" cssClass="validationnote" />
											</span>
										</div>
									</div>
									<div class="rightsection_form">
											<div class="par">
											 <div class="floatleft right_margin"> <label class="floatleft">&nbsp;</label>
											<div class="clear"></div>
											<span class="field"> <form:input path="endDate"
													placeholder="End Date" class="input-small1"
													id="to2" readonly="true"/>
													
											</span>
											</div>
											<div class="">
                <label>&nbsp;</label>
                <div class="input-append bootstrap-timepicker">
													<form:input path="endTime" id="timepicker6"
													class="input-small_date" />
												   <span class="add-on"><i class="icon-time"></i></span></div>
												</div>
												</div>
										<div class="clear"></div>
										<div class="par">
											<label class="floatleft">Status</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  <select class="chzn-select list_widthstyle1">
													<option value="Proposed">Proposed</option>
													
												</select>
											</span>
										</div>
									</div>
									<div class="clear"></div>
									<div class="fullwidth_form">
										
										<div class="par">
											<label class="floatleft">Topic</label> <span class="star">*</span>
											<div class="clear"></div>
											<span class="field"> <form:textarea path="topic"
													cols="80" rows="5" class="spanfull width100" id="topic" /> <form:errors
													path="topic" cssClass="validationnote" />
											</span>
										</div>
										<div class="par">
											<label class="floatleft">Invite Company</label> <span
												class="star">*</span>
											<div class="clear"></div>
											<span class="field">  
											
											<form:select path="invitedCompanySeminar" class="chzn-select" items="${companyList}">
														<%-- <c:forEach var="companyList" items="${companyList}">
													<option value="${companyList.companyName}"><c:out value="${companyList.companyName}"/></option>
														</c:forEach> --%>
													</form:select>
											
											</span>
										</div>
										<!-- <div class="par">
											<label class="floatleft">Invite Corporates to Event</label> <span
												class="star">*</span> <span class="field floatright">
												<a href="#myModal3" data-toggle="modal"> <input name=""
													type="button" value="Add Company" class="no_right_margin">
											</a>
											
											<a href="#myModal3" data-toggle="modal"> 
												<input name="" type="button" value="Add Participants" class="no_right_margin addbtn">
											</a>
											
											</span>
											<div class="clear"></div>
										</div> -->
										<!-- <div class="par">

											<input type="hidden" id="email_id_Seminar"
												name="email_id_Seminar" value=""> <input
												type="hidden" id="company_Name_Seminar"
												name="company_Name_Seminar" value="">

											<table id="addCompanySeminar" width="100%" border="0" cellspacing="0" cellpadding="0" class="recordlisting_table">
												<tr>
													<th width="63%" class="table_heading leftalign">Company
														Name</th>
													<th width="22%" class="table_heading center_align">Invitation
														Status</th>
													<th width="15%" class="table_heading center_align">Actions</th>
												</tr>
											</table>
										</div> -->

										<div class="doubletop_margin doublebottom_margin">
											<div class="buttonwrap">
												
												<input name="" type="submit" value="Preview" tabindex="21"> 
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
	<div id="campusfair_section">
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" class="modal hide fade in" id="myModal1">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
				<h3 id="myModalLabel">Invite Companies for Campus Fair</h3>
			</div>
			<div class="modal-body">
				<form:form class="stdform" action="" method="get" modelAttribute="universityEventCmd" id="jobFair_form">
				
					<div class="leftsection_form" style="width:48%;">
						<div class="par">
											<label class="floatleft">Industry</label>

											<div class="clear"></div>
											<span class="field"> 
											 <form:select path="industry" class="uniformselect" id="industryId">
													<form:option value="">Choose an Option</form:option>
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
								onclick="searchCompanyListJobFair()" value="search"
								tabindex="21" class="add_participants floatleft"></li>
							<li class="twoem_margin">
								<div id="divIdJobFair">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="recordlisting_table top_margin" id="companyList">
										<tr >
											<th width="5%" class="table_heading leftalign">&nbsp;</th>
											<th width="43%" class="table_heading leftalign">Company
												Name</th>
											<th width="25%" class="table_heading leftalign">Industry</th>
											<th width="27%" class="table_heading leftalign">Location</th>
										</tr>
										<tbody id = "searchedCompaniesList">
										<tr>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
											<td class="topvertical_align table_content leftalign">-</td>
										</tr>
										</tbody>
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
										onclick="addCompanyList('jobFair')">
									<!--  <input name="" type="button" value="Cancel" class="modalCloseImg simplemodal-close" title="Close" >  -->
								
				<!-- <button data-dismiss="modal" class="btn">Close</button> -->
			</div>
		</div>
	</div>
			
</body>
</html>