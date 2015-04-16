<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>University Manage Received Invitations</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="css/style.css">

    <!--[if lt IE 7]>
	<style type="text/css">
		#wrap { height:100%; }
       
	</style>
    
    
<![endif]-->

    <script language="javascript" type="text/javascript">
$(document).ready(function()
{
    $(".checkBox,.checkBoxClear").click(function(srcc)
    {
        if ($(this).hasClass("checkBox"))
        {
            $(this).removeClass("checkBox");
            $(this).addClass("checkBoxClear");
        }
        else
        {
            $(this).removeClass("checkBoxClear");
            $(this).addClass("checkBox");
        }
    });        
	
	
});
</script>
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
 
     <script language="javascript" type="text/javascript">
            $(function() {
                $("#topnavigation").webwidget_menu_glide({ sprite_speed:"normal", container:"topnavigation" });
            });
  </script>
   <script type="text/javascript"> 
$(function() {
			var pull 		= $('#dropdown');
				menu 		= $('#mydiv');
				menuHeight	= menu.height();

			$(pull).on('click', function(e) {
				e.preventDefault();
				menu.slideToggle();
			});
		

			$(window).resize(function(){
        		var w = $(window).width();
        		if(w > 200 && menu.is(':hidden')) {
        			menu.removeAttr('style');
        		}
    		});
		});
$(document).ready(function(){  $('.dropdown_nav li').mousemove(function () {

      var listItem = $(this).index();
      //alert($(this).width())
      $('.webwidget_menu_glide_sprite').width($(this).width()+30);
      //alert($('.webwidget_menu_glide_sprite').width());
      
  }
   );
   $('.dropdown_nav li.current').width(function () {

            var listItem1 = $(this).index();
            //alert($(this).width())
            $('.webwidget_menu_glide_sprite').width($(this).width()+30);
            //alert($('.webwidget_menu_glide_sprite').width());
            
        }
         );
});
</script>
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
    <script type="text/javascript" charset="utf-8">
    var $ = jQuery.noConflict();
    $(window).load(function() {
    $('.flexslider').flexslider({
          animation: "fade"
    });
	
	$(function() {
		$('.show_menu').click(function(){
				$('.menu').fadeIn();
				$('.show_menu').fadeOut();
				$('.hide_menu').fadeIn();
		});
		$('.hide_menu').click(function(){
				$('.menu').fadeOut();
				$('.show_menu').fadeIn();
				$('.hide_menu').fadeOut();
		});
	});
  });
</script>
    <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
    <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
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
    <script>

$(document).ready(function() {	

	//select all the a tag with name equal to modal
	$('a[name=modal]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = $(this).attr('href');
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
		  		
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/1.8);
		$(id).css('left', winW/2-$(id).width()/1.8);
	
		//transition effect
		$(id).fadeIn(2000); 
		

	
	});
	
	//if close button is clicked
	$('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		//transition effect		
		
		$('#mask').hide();
		$('.window').hide();
		
		
		
	});		
	
	//if mask is clicked
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});			

	$(window).resize(function () {
	 
 		var box = $('#boxes .window');
 
        //Get the screen height and width
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();
      
        //Set height and width to mask to fill up the whole screen
        $('#mask').css({'width':maskWidth,'height':maskHeight});
               
        //Get the window height and width
        var winH = $(window).height();
        var winW = $(window).width();

        //Set the popup window to center
        box.css('top',  winH/2 - box.height()/2);
        box.css('left', winW/2 - box.width()/2);
	 
	});
	
});

</script>
    <link rel="stylesheet" href="css/tabs.css">
    <script src="js/organictabs.jquery.js"></script>
    <script>
        $(function() {
    
            $("#example-two").organicTabs({
                "speed": 200
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
       <!--  <div id="breadcrums_wrap">You are here: <a href="university_dashboard.htm">Home</a> / <a href="#">Manage Events</a> / Received Invitations for Campus Visits</div> -->
       
        <h1 class="sectionheading">Received Invitations for Campus Visits</h1>
        <div class="clear"></div>
        
         <div class="whitebackground">
               <div class="par"> 
              <table  id="dyntable" class="table table-bordered" >
              <colgroup>
                  <col class="con0"  />
                  <col class="con1" />
                  <col class="con0" />
                  <col class="con1" />
                  <col class="con0" />
                  </colgroup>
                  <thead>
            <tr>
                  <th width="35%" class="table_heading leftalign">Event Name</th>
                  <th width="18%" class="table_heading center_align">Company Name</th>
                  <th width="22%" class="table_heading center_align">Date</th>
                  <th width="13%" class="table_heading center_align">Status</th>
                  <th width="12%" class="table_heading center_align">Actions</th>
                </tr>
           </thead>
           <tbody>
           
           <c:forEach items="${eventList}" var="eventList">
            <tr>
                  <td  width="35%" class="topvertical_align table_content leftalign"><a href="university_preview_corporate_invitation.htm?eventId=<c:out value="${eventList.eventId}"/>"><c:out value="${eventList.eventName}"/></a></td>
                  <td width="18%"  class="topvertical_align table_content leftalign"><c:out value="${eventList.companyName}"/></td>
                  <td width="22%"  class="topvertical_align table_content leftalign">
            <fmt:parseDate value="${eventList.startDate}" type="DATE" pattern="${dbDateFormat}" var="startDate"/>
            <fmt:parseDate value="${eventList.endDate}" type="DATE" pattern="${dbDateFormat}" var="endDate"/>
                  <fmt:formatDate type="date" value="${startDate}" pattern="${displayDateFormat}" />
			to <fmt:formatDate type="date" value="${endDate}" pattern="${displayDateFormat}" /> <br/>
        <c:out value="${eventList.startTime}"/>
            to
         <c:out value="${eventList.endTime}"/>  </td> 
                <td  width="13%"  class="topvertical_align table_content center_align"><c:out value="${eventList.invitationStatus}"/></td>
                <%-- <td class="table_content center_align"><a href="university_manage_receivedinvitations.htm?event_id=<c:out value="${eventList.eventId}"/>&action=Accepted"><img src="images/check_icn.gif" width="16" height="13" class="actionbtn"></a> <a href="university_manage_receivedinvitations.htm?event_id=<c:out value="${eventList.eventId}"/>&action=Rejected"><img src="images/small_cancel_icn.gif" width="15" height="15" class="actionbtn"></a></td> --%>
                  <c:choose>
				      <c:when test="${eventList.invitationStatus eq 'Accepted'}">
				      	<td width="12%"  class="table_content center_align">
				      	<a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=undo&eventName=${eventList.eventName}">
				      	<img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a>
				     <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=Broadcasted&eventName=${eventList.eventName}">
				     <img src="images/broadcast_action.gif" class="table_actionbtn" alt="Broadcast Event" title="Broadcast Event"></a></td>
				      </c:when>	
				      <c:when test="${eventList.invitationStatus eq 'Broadcasted'}">
				      	<td width="12%"  class="table_content center_align">
				      	<a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=UndoBroadcast&eventName=${eventList.eventName}">
				      	<img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>	
				      <c:when test="${eventList.invitationStatus eq 'Rejected'}">
				      	<td width="12%"  class="table_content center_align"><a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=undo&eventName=${eventList.eventName}">
				      	<img src="images/undo_icn.png" class="table_actionbtn" alt="Undo Step" title="Undo Step"/></a></td>
				      </c:when>				
				      <c:otherwise>
				     	 <td width="12%"  class="table_content" align="center">
				     	 <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=Accepted&eventName=${eventList.eventName}">
				     	 <img src="images/check_icn.gif" width="16" height="13" class="actionbtn" title="Accept"></a>
				     	  <a href="university_update_corporate_invitation_status.htm?eventId=<c:out value="${eventList.eventId}"/>&action=Rejected&eventName=${eventList.eventName}">
				     	  <img src="images/small_cancel_icn.gif" width="15" height="15" class="actionbtn" title="Reject"></a></td>				      	
				      </c:otherwise>
					</c:choose>
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



</body>
</html>