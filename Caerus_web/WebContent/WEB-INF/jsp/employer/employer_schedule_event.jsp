<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>  
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Schedule An Event</title>
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
<!--<script src="js/cufon-yui.js"></script>
<script src="js/Myriad_Pro_300.font.js"></script>
<script src="js/cufon_fonts.js"></script>-->
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/uielements/prettify.js"></script>
<script type="text/javascript" src="js/uielements/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.cookie.js"></script>
<script type="text/javascript" src="js/uielements/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap.min.js"></script>
<script type="text/javascript" src="js/uielements/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.uniform.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/uielements/jquery.tagsinput1.min.js"></script>
<script type="text/javascript" src="js/uielements/charCount.js"></script>
<script type="text/javascript" src="js/uielements/ui.spinner.min.js"></script>
<script type="text/javascript" src="js/uielements/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/uielements/modernizr.min.js"></script>
<script type="text/javascript" src="js/uielements/detectizr.min.js"></script>
<script type="text/javascript" src="js/uielements/custom.js"></script>
<script src="js/jquery.dropdownPlain.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/tytabs.jquery.min.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script> 
<script>


$(document).ready(function(){
	google.maps.event.addDomListener(window, 'load', loadDefaultMap);
	
	
 $('#venue').focusout(function() {

	  var map = null; 
	
	 var address = $("#venue").val();
	if(address != ''){

		

		if ($('#parentDiv').length) {
			$('#parentDiv').remove();}

		if ($('#defaultMapDiv').length) {
			$('#defaultMapDiv').remove();}
		
 
			   $('#mapDiv').append("<div id='parentDiv' class='parentDiv floatright'>"+
					   "<div id='coords'></div>"+
					   "<div id='gmap' style='width:450px; height:250px;'></div>");

				map = new google.maps.Map( document.getElementById("gmap"),  {
					  center: new google.maps.LatLng(0,0),
					  zoom: 3,
					  mapTypeId: google.maps.MapTypeId.ROADMAP,
					  panControl: false,
					  streetViewControl: false,
					  mapTypeControl: false
					    });
					
					  var geocoder = new google.maps.Geocoder(); 
					  geocoder.geocode({
					    address : address, 
					    region: 'no' 
					   },
					      function(results, status) {
					       if (status.toLowerCase() == 'ok') { 
					     // Get center
					     var coords = new google.maps.LatLng(
					      results[0]['geometry']['location'].lat(),
					      results[0]['geometry']['location'].lng()
					     );
					    // $('#coords').html('Latitute: ' + coords.lat() + '    Longitude: ' + coords.lng() );
					     map.setCenter(coords);
					     map.setZoom(15);
					     // Set marker also
					     marker = new google.maps.Marker({
					      position: coords, 
					      map: map, 
					      title: address
					     });            
					       }
					   }
					  )
			
		}

	else{
		
	    $('#parentDiv').remove();
	    loadDefaultMap();
		
		}
	
	

	
});


   // checkbox for preplacement videos is selected div is to be displayed 
	 if($("#attachPreplacementFilesChkBox").is(':checked')){
		 $('#checked').slideDown('slow'); }
	 
	   
	 
	    

 
});
	




</script>



<script>

function editPostedEvent(){
	var formDetails = $("#employerScheduleEventForm");
	document.forms[0].action = 'employer_update_event.htm?'+<%=request.getParameter("eventId") %>;
	formDetails.submit();
}

function loadDefaultMap(){
	var map = null; 
	var address =null;
	//For Edit View check venue is entered
	if($("#venue").val() !=''){
	 address = $("#venue").val();
		}
	else {

	  address = $("#localAddress").val();
		}
	 //alert('address'+address);
	if(address != ''){
 
			   $('#mapDiv').append("<div id='defaultMapDiv' class='padding_top parentDiv floatright'>"+
					   "<div id='defaultCoords'></div>"+
					   "<div id='defaultGmap' style='width:450px; height:250px;'></div>");

				map = new google.maps.Map( document.getElementById("defaultGmap"),  {
					  center: new google.maps.LatLng(0,0),
					  zoom: 1,
					  mapTypeId: google.maps.MapTypeId.ROADMAP,
					  panControl: false,
					  streetViewControl: false,
					  mapTypeControl: false
					    });
					
					  var geocoder = new google.maps.Geocoder(); 
					  geocoder.geocode({
					    address : address, 
					    region: 'no' 
					   },
					      function(results, status) {
					       if (status.toLowerCase() == 'ok') { 
					     // Get center
					     var coords = new google.maps.LatLng(
							    
					     results[0]['geometry']['location'].lat(),
					      results[0]['geometry']['location'].lng()
					     );

					    // $('#coords').html('Latitute: ' + coords.lat() + '    Longitude: ' + coords.lng() );
					     map.setCenter(coords);
					     map.setZoom(15);
					     // Set marker also
					     marker = new google.maps.Marker({
					      position: coords, 
					      map: map, 
					      title: address
					     });            
					       }
					   }
					  )
			
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
 </script>
<!--   <script type="text/javascript">
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
  </script> -->
  <script type="text/javascript">
  var repoNames = [];
  var i= 0;
	$(document).ready(function(){

	  var i =  parseInt($("#multivalues").val());
	  
	  if(isNaN(i)){
		  i=0;
	  }
	  
	  $('#multitextbox').val( i );
		
	  $("#addMore").click(function(){
		  var repoData = $("#repositoryselect").val();
		  if(repoData){

			var a=$("#repositoryselect_chzn").children(".chzn-drop").children("ul.chzn-results").children("li.result-selected").attr('id');
			var selectedDropdownValue=$("#"+a).text();
			$("#"+a).remove(":contains("+selectedDropdownValue+")");

			//$("#repositoryselect option:selected").remove();
			
			 var array = new Array();
			$('#repositorytable .table_content').each(function()
			{
			  array.push($(this).html());
			});
			
			Array.prototype.contains = function ( string ) {
				   for (i in this) {
				       if (this[i] == string) 
					       return true;
				   }
				   return false;
				}
			
		  	if(!(array.contains(repoData)))
			 {
		  		$('#repositorytable').append('<tr><td class="table_content left_align">'+repoData+'</td></tr>');
		  		$('#dynamic_input').append('<input type="hidden" id="repoNameMulti" name="repoNameMulti" value="'+repoData+'" >');
			 }
		  	

		  	//$('#repositoryselect option:contains("Select")').prop('selected',true);
		  	
		  	
		  }
		
	  });
	  
	  $("#add_more_recruitment").click(function(){
		  i = i+1;
		  $('#multitextbox').val( i );
		  $('#add_more_recruitmenttable').append('<tr>'+
                  '<td colspan="2" class="table_topvertical_align"><table width="100%" border="0" cellspacing="0" cellpadding="0">'+
                  '<tr>'+
                  '<th width="16%" class="table_leftalign">Functional Area <span class="table_star">*</span></th>'+
                  '<td width="39%"><div class="list_widthstyle2">'+
                      	'<select name="functionalAreas['+i+']" tabindex="8" Class="uniformselect" id="functionalAreaMulti'+i+'">'+
	                            '<option value="FinancialAnaylst"> Financial Anaylst </option>'+
	                            '<option value="Accounts">Accounts</option>'+
	                      	'</select>'+
                    '</div></td>'+
                    '<th width="16%" class="table_topvertical_align table_leftalign">Batch of Passing</th>'+
                    '<td width="39%" class="table_topvertical_align">'+
                   				'<select name="eligibleBatches['+i+']" tabindex="12" data-placeholder="Choose a Option" class="chzn-select" style="width:210px;">'+
                                    '<option value="Spring2012"> Spring-2013 </option>'+
                                    '<option value="Winter2012">Winter-2013</option>'+
                                    '<option value="Spring2013"> Spring-2014 </option>'+
                                    '<option value="Winter2013">Winter-2014</option>'+
                              	'</select>'+
                              	'<div>'+
                      '</td>'+
                    
                '</tr>'+
                '</table></td>'+
            '</tr>'+
          
            
      
      '<tr>'+
          '<td class="table_topvertical_align" colspan="2">'+
          	'<table width="100%" border="0" cellspacing="0" cellpadding="0">'+
            '<tr>'+
              '<th width="16%" class="table_leftalign">No. Of Hirings <span class="table_star">*</span></th>'+
              '<td width="39%" class="table_leftalign righ">'+
              '<input name="numberOfHirings['+i+']" class="input-mini" tabindex="9" placeholder="" id="noOfHiringsMulti'+i+'"/>'+
                  	'</td>'+
              '<th width="16%" class="table_leftalign">Min Salary Offered</th>'+
              '<td width="39%" class="table_leftalign"><input name="minimumSalaryOffered['+i+']" class="input-mini" tabindex="10" placeholder=""/>'+
                  	'</td>'+
           
            '</tr>'+
          '</table>'+
          '</td>'+
        '</tr>');
		  jQuery(".chzn-select").chosen();
	  });
	});
  </script>
   <script type="text/javascript">
      function load() {
       	if($('#prePlacementfiles').is(':checked')){
       		$('#checked').slideDown('slow');
       	}         	
      }
      window.onload = load;
   </script>
   
   <script type="text/javascript">

$().ready(function() {
	$.validator.setDefaults({ ignore: ":hidden:not(select)" });
	$("#employerScheduleEventForm").validate({
		rules: {
			eventName: "required",
			participatingUniversity: "required",
			functionalAreaMulti: "required",
			eventDescription:"required",
			eventLocation: "required",
			/* startDate: {
				 required : true,                 
				 trioDate: true
			},
			endDate:{
	              // greaterThan: "#datepicker1",
	               required : true,                 
	  			   trioDate:true
	            }, */
			
		},
		messages: {
			eventName: "Please enter your event name",
			participatingUniversity: "Please enter the Participating University name",
			functionalAreaMulti: "Please enter your university name",
			eventDescription:"Please mention your Expectations",
			eventLocation: "Please Enter Event Location",
			/* startDate: { 
				required: "Please provide  Start Date",
                trioDate:"Enter format yyyy-mm-dd"
            },
			endDate:
            { 
				required: "Please provide  End Date",
				//greaterThan:"End Date < Start Date!",
                trioDate:"Enter format yyyy-mm-dd"
            } */
		}
	});
	
	
	$('[id*="noOfHiringsMulti"]').each(function () {
        $(this).rules('add', {
            required: true,
            messages: {
                required: "Please provide number of hirings"
            }
        });
    });
	
	$('[id*="functionalAreaMulti"]').each(function () {
        $(this).rules('add', {
            required: true,
            messages: {
                required: "Please select Functional Area"
            }
        });
    });
	

});

function checkDate(){	
	 var fromDate = $("#from").val();
	 var toDate = $("#to").val();
	if (Date.parse(fromDate) > Date.parse(toDate)) {
	    alert("Invalid Date Range!\n Start Date cannot be after End Date!")
	    return false;
	} 
}
</script>
<style type="text/css">

span.text1, .stdform label.error{width:85%;}
.tabscontent{padding: 8px 0 34px 0;}
</style>

<script>
function goBack()
{
  window.history.back();
}
</script>
 
</head>

<body>
<div id="wrap">
 <!--------------  Header Section :: start ----------->
    <%@ include file="includes/header.jsp"%>
 <!--------------  Header Section :: end ------------> 
<div id="midcontainer">
    <div id="innerbanner_wrap">
        <div id="banner"><img src="images/employer_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
      </div>
<div id="innersection">
        <!-- <div id="breadcrums_wrap">You are here: <a href="employer_dashboard.htm">Home</a> / <a href="employer_campus_connect.htm">Campus Connect</a> / Schedule an Event</div> -->

        <section id="rightwrap" class="floatleft">
        <h1 class="sectionheading">Schedule an Event</h1>
        <p class="description">Connect to your preferred universities to send an invite for your next recruitment drive. Communicate your requirements and offer details upfront for better visibility of your drive.</p>
        <div class="form_messages"><span class="message">Denotes required fields</span><span class="star">*</span></div>
        <div class="clear"></div>

 <div id="candidate_registration_wrap">
 
 <div class="container">
   <form:form action="employer_schedule_event.htm" method="post" modelAttribute="employerEventCom" class="stdform" id="employerScheduleEventForm">      
      
       
 <div class="tabscontent whitebackground floatleft width100 margin_top2 padding_bottom2"><div class="tabs_column1">&nbsp;</div>
<div class="tabs_column2"><div class="title_portfolio">
<div class="bullet_count">1</div>
 <div class="titile_port">Event Details</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth">
 
    <div class="doublebottom_margin padding_bottom">
        <div class="par">
          <label class="floatleft">Event Name<span class="table_star">*</span></label>
          
          <span class="field floatleft text1">
                  <form:input path="eventName" class="input-xlarge" tabindex="1" />
                  <form:errors path="eventName"  cssClass="validationnote"/> 
                  </span>  
         </div>
    </div>
	<div class="clear"></div>
    <div class="par">
      <label class="floatleft">About the Event<span class="table_star">*</span></label>
      
      
      <span class="controls field floatleft text1">
                    <form:textarea path="eventDescription" class="input-xxlarge width100" id="eventDescription" tabindex="3" cols="80" rows="5"/>
                    <form:errors path="eventDescription"  cssClass="validationnote"/> 
                  </span> </div>
    <div class="clear"></div>
    
    

</div>
</div>
</div>


 <div class="tabscontent whitebackground floatleft width100 margin_top2 padding_bottom2"><div class="tabs_column1">&nbsp;</div>
<div class="tabs_column2"><div class="title_portfolio">
<div class="bullet_count">2</div>
 <div class="titile_port">Participating University</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth">
 
    <div class="doublebottom_margin padding_bottom">
        <c:choose>
                  <c:when test="${status eq 'Broadcasted'}">
                  <div class="par">
                <label class="floatleft">University Name</label>
                <span class="star">*</span>
                <span class="field floatleft">
                  <form:input path="universityName" class="input-xxlarge" tabindex="2" readonly="true"/>   
                  </span> </div>
                  </c:when>
                  <c:otherwise>
                  <div class="par">
                <label class="floatleft">University Name<span class="table_star">*</span></label>
                <span class="formwrapper floatleft text1">                 
                	<form:select path="participatingUniversity" id="participatingUniversity" data-placeholder="Choose an Option" class="chzn-select list_widthstyle3" items="${universityList }">
                         <%--   <form:option value=""></form:option>
                        	<form:options items="${universityList}" />    --%>                 
                     </form:select>
                     
                      <form:errors path="participatingUniversity"  cssClass="validationnote"/> 
                  </span> </div>
                  </c:otherwise>
                  </c:choose>
    </div>
	<div class="clear"></div>
 
</div>
</div>
</div>


 <div class="tabscontent whitebackground floatleft width100 margin_top2 padding_bottom2" id="mapDiv"><div class="tabs_column1">&nbsp;</div>
<div class="tabs_column2"><div class="title_portfolio">
<div class="bullet_count">3</div>
 <div class="titile_port">Dates And Location</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth">
 
    <div class="doublebottom_margin padding_bottom">
                <div class="floatleft par">
                <label class="floatleft">Start Date</label>
                <span class="field floatleft">
                  <form:input path="startDate" placeholder="Start Date" class="input-small1" tabindex="4" id="from"/>      
                  <form:errors path="startDate" cssClass="validationnote"/>                    
                  </span> &nbsp; &nbsp; &nbsp; &nbsp;<div class="input-append bootstrap-timepicker">
                    <form:input path="startTime" class="input-small_date" tabindex="5" id="timepicker1" />
                    <form:errors path="startTime"  cssClass="validationnote"/>
                    <span class="add-on"><i class="icon-time"></i></span></div></div>
                
               
              
                <div class="clear"></div>
                <div class="floatleft par">
                <label class="floatleft">End Date</label>
                <span class="field floatleft">
                  <form:input path="endDate" placeholder="End Date" class="input-small1" tabindex="6" id="to"/>  
                  <form:errors path="endDate"  cssClass="validationnote"/>
                  </span>  &nbsp; &nbsp; &nbsp; &nbsp;
                <div class="input-append bootstrap-timepicker">
                    <form:input path="endTime" class="input-small_date" tabindex="7" id="timepicker2" />
               		
                    <span class="add-on"><i class="icon-time"></i></span><form:errors path="endTime"  cssClass="validationnote"/></div>
              </div>
              <div class="clear"></div>
              
              <div class="par">
     		 <label class="floatleft">Event Location<span class="table_star">*</span></label>
      		<span class="controls field floatleft">
                    <form:input path="eventLocation" id="venue" class="input-medium" tabindex="1"/>
                    <form:errors path="eventLocation"  cssClass="validationnote"/> 
                  </span> </div>
             
    </div>
  
    <input type="hidden" value="<c:out value="${localAddress}"></c:out>" id="localAddress"> 
    

</div>
</div>
</div>


 <div class="tabscontent whitebackground floatleft width100 margin_top2 padding_bottom2"><div class="tabs_column1">&nbsp;</div>
<div class="tabs_column2">
<div class="title_portfolio">
<div class="bullet_count">4</div>
 <div class="titile_port">Recruitment Details</div>
 <div class="addrows_btn" style="margin-top: -46px;"><a href="javascript:void(0)"><img src="images/addmore_icn.png" id="add_more_recruitment"/></a></div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth">
 
    <div class="doublebottom_margin padding_bottom">
            <div class="par">            
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id="add_more_recruitmenttable">
               <%--  <c:forEach begin="0" end="${multivalues}" var="m">
                <% 
                	String k = pageContext.getAttribute("m").toString(); 
                    pageContext.setAttribute("ki", k);                    
                %>
                 <c:set var="bop" value="${bp[ki]}"/>
                 <c:set var="elstream" value="${es[ki]}"/> --%>
                <tr>
                    <td colspan="2" class="table_topvertical_align">
                    
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <th width="16%" class="table_leftalign">Functional Area <span class="table_star">*</span></th>
                        <td width="39%">
                        <div class="list_widthstyle2">
                            	<form:select path="functionalAreas[0]" tabindex="8" Class="uniformselect" id="functionalArea" items="${functionalAreaList}" >
                            		
		                           <%--  <option value="Financial Anaylst"  <c:if test="${fa[m] == 'Financial Anaylst'}">selected="selected"</c:if>> Financial Anaylst </option>
		                            <option value="Accounts" <c:if test="${fa[m] == 'Accounts'}">selected="selected"</c:if>>Accounts</option> --%>
		                      	</form:select>
		                      	 <form:errors path="functionalAreas"  cssClass="validationnote"/>
                         </div>
                          
                        </td>
                          
                         <th width="16%" class="table_topvertical_align table_leftalign">Batch of Passing</th>
                          <td width="39%"><div class="table_topvertical_align ">
                   				<form:select  path="eligibleBatches[0]" tabindex="12" data-placeholder="Choose Options" class="chzn-select" style="width:210px;" items="${eligibleBatches }">
                   				 
                   				 <%--  <c:forEach var="bopval" items="${fn:split(bop, ',')}">                   
		                            <option value="Spring2012" <c:if test="${fn:trim(bopval) == 'Spring2012'}">selected="selected"</c:if>> Spring-2012 </option>
		                            <option value="Winter2012" <c:if test="${fn:trim(bopval) == 'Winter2012'}">selected="selected"</c:if>>Winter-2012</option>
		                            <option value="Spring2013" <c:if test="${fn:trim(bopval) == 'Spring2013'}">selected="selected"</c:if>> Spring-2013 </option>
		                            <option value="Winter2013" <c:if test="${fn:trim(bopval) == 'Winter2013'}">selected="selected"</c:if>>Winter-2013</option>
		                          </c:forEach>name="batchOfPassingMulti<c:out value="${m}"/>" --%>
		                      	</form:select>
		                      	<form:errors path="eligibleBatches"  cssClass="validationnote"/>
		                      	</div>
		                      	
		                 </td>
                      </tr>
                      
                      </table>
                      
                      </td>
                        
                  </tr>
               
                <tr>
                    <td class="table_topvertical_align" colspan="2">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                         <th width="16%" class="table_leftalign">No. Of Hirings <span class="table_star">*</span></th>
                        <td width="39%" class="table_leftalign righ">
                        <form:input path="numberOfHirings[0]" class="input-mini" tabindex="9" placeholder="Hirings" id="numberOfHirings"/>
                        	<form:errors path="numberOfHirings"  cssClass="validationnote"/>
                        
                       <!--  <input name="numberOfHirings[0]" class="input-mini" tabindex="9" placeholder="Hirings" id="numberOfHirings"/> -->
		                    	 </td> 
                        <th width="16%" class="table_leftalign">Min Salary Offered</th>
                        <td width="39%"  class="table_leftalign">
                        <form:input path="minimumSalaryOffered[0]"  class="input-mini" tabindex="10" placeholder="Min. Salary Offered" />
                        	<form:errors path="minimumSalaryOffered"  cssClass="validationnote"/>
                        <!-- <input name="minimumSalaryOffered[0]" class="input-mini" tabindex="10" placeholder="Min. Salary Offered" /> -->
		                    	</td>
                    
                      </tr>
                    </table>
                    </td>
                  </tr>
               <%--    </c:forEach> --%>
              </table>
              </div>       
    </div>
	<div class="clear"></div>
  
    
    

</div>
</div>
</div>


 <div class="tabscontent whitebackground floatleft width100 margin_top2 padding_bottom2"><div class="tabs_column1">&nbsp;</div>
<div class="tabs_column2"><div class="title_portfolio">
<div class="bullet_count">5</div>
 <div class="titile_port">Additional Details</div>
  </div>
  <div class="clearfix"></div>
  <div class="fullwidth">
 
       <div class="doublebottom_margin padding_bottom">
       
       
        <div class="par"> <span class="formwrapper">
        <form:checkbox path="attachCompanyProfile"/>
        
             <!--  <input type="checkbox" name="attachCompanyProfile" /> -->
              Company Profile</span> </div>
            <div class="doublebottom_margin"> <span class="formwrapper floatleft">
            
         <c:set var="attachPreplacementFiles" value="${employerEventCom.attachPreplacementFiles}"/>
            
            
            
            <form:checkbox path="attachPreplacementFiles" id="attachPreplacementFilesChkBox" onClick="$(this).is(':checked') && $('#checked').slideDown('slow') || $('#checked').slideUp('slow');"/>
             <%-- <form:checkbox path="attachPreplacementFiles" id="attachPreplacementFilesChkBox" onClick="$(this).is(':checked') && $('#checked').slideDown('slow') || $('#checked').slideUp('slow');"/> --%>
            <%--   <input type="checkbox" id="prePlacementfiles" name="attachPreplacementFiles" onClick="$(this).is(':checked') && $('#checked').slideDown('slow') || $('#checked').slideUp('slow');" <c:if test="${prePFiles}"> checked </c:if>/> --%>
              Pre-Placement Videos &amp; Presentations </span> </div>
       
              <div id="checked" class="showhide_text"> 
             
          
             <div class="sectionsubheading no_top_margin bottom_margin"> <br> Add Files From Repository</div>
             	<div class="doublebottom_margin">
                <label class="floatleft">File Name <span class="table_star"> * &nbsp;</span></label>
                
                <span class="formwrapper floatleft">
                <form:select path="employerRepositoryFileNames"  items="${repositoryFiles }" data-placeholder="Choose Options" class="chzn-select input-large1" id="repositoryselect" />
                
                  </span> 
                 <!--   <div class="floatleft doubleleft_margin top_margin"><a href="javascript:void(0)"><img src="images/addmore_icn.png"  id="addMore" alt="Add File" style="display:inline-block;"/> Add File</a></div> -->     
                   <div class="clear"></div>
    			</div>  
              <%--  
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="recordlisting_table" id="repositorytable">
	                <tr>
	                    <th align="left" valign="middle" class="table_heading left_align">File Details</th>
	                </tr>
	                <c:if test="${fn:length(RepoNameMultiFiles) > 0}">
		                <c:forEach begin="0" end="${fn:length(RepoNameMultiFiles)-1}" var="files">
		                <c:forEach items="${RepoNameMultiFiles}" var="files">
		                	<tr><td class="table_content left_align"><c:out value="${files}"/></td></tr>
		                </c:forEach>
	                </c:if>
              	</table> --%>
              	
            <%--   	<div id="dynamic_input">
              		<input type="hidden" id="repoNameMulti" name="repoNameMulti" value="" >
              		<input type="hidden" id="eventIdEdit" name="eventIdEdit" value="<c:out value="${evid}"/>" />
              		<input type="hidden" id="multivalues" name="multivalues" value="<c:out value="${multivalues}"/>" />
              	</div> --%>
              	
 				 <!-- <input type="hidden" id="fileName" name="fileName" value="" > -->
 				<!--  <input name="maultiplevalues" type="hidden" value="0" id="multitextbox"/> -->
 				<!-- <div id="dynamic_input"></div> -->
              </div>
    
	<div class="clear"></div>
  
    
    

</div>
</div>
</div>

  <!-- <div class="">
      <ul class="tabsbtn"><li id="tab2"><input name="" type="button" value="Save &amp; Next" class="top_margin" style="width:625px;font-size:20px;font-family:roboto;height:40px;">
      </li></ul>
      <div class="clear"></div>
    </div> -->
      <div class="doubletop_margin floatleft width100">
                <div class="buttonwrap">
	            <c:choose>
	            	<c:when test="${ not empty editMode && editMode}">
	            		<form:hidden path="eventId" value='<%= request.getParameter("eventId") %>' />
	            		<input type="button" onclick="editPostedEvent()" value = "Preview &amp; Post"/>
	            	</c:when>
	            	<c:otherwise>
		                <input name="submitBtn" type="submit" value="Preview &amp; Post" tabindex="21" onclick="return checkDate();">
	            	</c:otherwise>
	            </c:choose>    
               <!--  <input name="" type="button" value="Cancel" tabindex="22" onclick="window.location.href='employer_manage_scheduledevents.htm'" /> -->
                <input name="backBtn" type="button" value="Cancel" tabindex="22" onclick="goBack()" />
              </div>
              </div>

</div>
</form:form>
<!--center  -->



</div>




<!-- candidate registration wrap -->
</div>

</section>
	  
<div class="clear"></div>
<!-- innersection  -->
</div>

 <div class="bottomspace">&nbsp;</div>
<!-- midcontainer -->
</div>







 <!--------------  Middle Section :: end -----------> 
    <!--------------  Common Footer Section :: start ----------->
    <%@ include file="includes/footer.jsp"%>
    <!--------------  Common Footer Section :: end -----------> 


<!-- wrap -->
</div>
  
  
  
  
  </html>