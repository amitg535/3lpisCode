<%@ page language="java" import="org.springframework.security.core.Authentication, org.springframework.security.core.context.SecurityContextHolder" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Admin Career Path</title>

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
<link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/tree-layout.css" />
<link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.webui-popover.css" type="text/css"  />

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
<script type="text/javascript" src="js/jquery.webui-popover.js"></script>

<script type="text/javascript"> 
$(document).ready(function(){
  $("#dropdown").click(function(){
    $("#mydiv").slideToggle();
  });
  
	   $('#wrapper').slideUp().hide();
	   $('.list_active').hide();

	 $('.generate').click (function(){
		 $('#wrapper').slideDown().show();
		 $('#dyntable_wrapper').slideUp().hide();
		  $('.list_active').show();
		   $('.list').hide();
		  
	 });
$('.list_active').click (function(){
	$('#dyntable_wrapper').slideDown().show();
	$('#wrapper').slideUp().hide();
	 $('.list_active').hide();
	 $('.list').show();
  });
  
});
</script>

<script type="text/javascript">
$(document).ready(function(){

 $("#addLevelBtn").click(function(){

	 
	 if($("#levelName").val() == "") {
	    $("#emptyLevelName").html("Please Enter Level Name");
	 }

	 if($("#functionalArea").val() == "") {
	    $("#emptyFunctionalArea").html("Please Choose Functional Area");
	 }
		
     if($("#salary").val() == "") {
        $("#emptySalary").html("Please Enter Salary Details");
        }

     if($("#years").val() == "") {
      $("#emptyYears").html("Please Enter Number of Years");
      }
    
     if($("#levelName").val() != "" && $("#functionalArea").val() != "" && $("#salary").val() != "" && $("#years").val() != ""){

    	 var formDetails = $("#introductory");
    		document.forms[0].action = 'admin_add_careerpathlevel.htm';
    		formDetails.submit();
         
       }
	  

}); 
	
$("#functionalArea").change(function(){
  var selectedValue = $(this).val();
 //alert("selectted value"+selectedValue);

 $.ajax({

	 type:"get",
 	 url:"admin_getParents_for_functional_area.json",
 	 data:"functionalArea="+selectedValue,
 	 success : function(levelNames){
 	 	// alert("admin_getParents_for_functional_area.htm"+levelNames);
 			 var dropdown2 = $('#parent');
           // $('>option', dropdown2).remove(); // Clean old options first.


		if(levelNames.length==0){

			 dropdown2.empty().append($('<option/>').val("").text(""));
			 dropdown2.append($('<option/>').val("").text("No Entries Found"));
			 
		 }

 		
		else
			
		{
			
			 dropdown2.empty().append($('<option/>').val("").text(""));
	 		$.each(levelNames, function( index, value )
	 		 {
				
	 			 dropdown2.append($('<option/>').val(value).text(value));
	 		});
 		}
 	 }
	});
 
});
});
</script>
<script type="text/javascript">
$(document).ready(function(){

	var careerPathJson;
	$("#generate").click(function(){
		var selectedFunctionalArea = $("#functionalareaTree").val();
	//alert("generate buttion clicked with value="+selectedFunctionalArea);
	$('#wrapper').empty();
	
	 $.ajax({

		 type:"get",
	 	 url:"admin_get_json_for_tree.htm",
	 	 data:"functionalArea="+selectedFunctionalArea,
	 	 success : function(data){
		 	//alert(data);
		 	value=JSON.parse(data);
		 	careerPathJson=value;
		 	$('#wrapper').empty();
			var $ul = $('<ul class="tree"></ul>');

			var pack=$('#wrapper');
			var el = {
			    treewrapUL : $("<ul>", {class: "tree", id: "treewrap"}),
				treewrapLI : $("<li>", {id: "treewrapLI"}),
			    areaDiv : $("<div>", {class: "parentbg", id: "areaDiv", text: selectedFunctionalArea}),
				areaSpan : $("<span>", {id: "areaSpan"})
			   }
			   
			   el.areaDiv.appendTo(el.areaSpan);
				el.areaSpan.appendTo(el.treewrapLI);
				el.treewrapLI.appendTo(el.treewrapUL);
				el.treewrapUL.appendTo(pack);


			 var g1={rootwrapUL : $("<ul>", {class: "root"}) }

			var currentTree;
					var i=1;
					var treeNode;
					//var rl;

					for(var key in value){
						//currentTree="tree"+i;
						//alert(currentTree);
				      //  alert(" json function reached");
					     
						//if(careerjson.hasOwnProperty( currentTree ))
						    treeNode=value[key];
						     if(treeNode.hasOwnProperty('root'))
							   var rootObject=treeNode.root;
							    /* r1= {
										rootwrapLI : $("<li>", {class: "last tooltiptest" , id: rootObject.levelName} ),
										rootDiv : $("<div>", {class: "childbg", text: rootObject.levelName}),
										rootSpan : $("<span>")
									} */
									//r1.rootDiv.text(rootObject.levelName);
									//r1.rootDiv.appendTo(r1.rootSpan);
									//r1.rootSpan.appendTo(r1.rootwrapLI);
									//r1.rootwrapLI.appendTo(g1.rootwrapUL);
									
									//var  x=r1.rootwrapLI;
									//if(i==1)
									//g1.rootwrapUL.appendTo(el.treewrapLI);
					    		//	alert(rootObject.levelName);
									//generateChildNodes(rootObject,x);
									$ul.appendTo(el.treewrapLI);
									getList(rootObject, $ul);
									//i=i+1;
					//			 alert(i);
							}   

					function getList(item, $list) {
						//alert("in function");
						    if ($.isArray(item)) {
						        $.each(item, function (key, value) {
						            getList(value, $list);
						        });
						        return;
						    }

						    if (item) {
						        var $li = $('<li />');
						        if (item.levelName) {
						           // $li.append($('<span><div><label  class="childbg">' + item.levelName + '</label><div class="callout"></div></div></span>'));
						            $li.append($('<span><div  class="tooltiptest"><label  class="childbg ">' + item.levelName + '</label><div class=""></div></div></span>'));
						        }
						        if (item.children && item.children.length) {
						            var $sublist = $("<ul/>");
						            getList(item.children, $sublist)
						            $li.append($sublist);
						        }
						        $list.append($li)
						    }

						    var i =0;
						    $('.tooltiptest').each(function(i){
						        $(this)
						            .attr("id", "id_" + i);
						            
					            i++;
						    });
						}

	 			
	 	 }
		});

	   $('body').on('mouseover', "div[id^='id']", function(){

		   var selected_option=$(this).text();



		   var selected_option=$(this).text();
			//currentLevel = alert($(this).attr('id'));
			for(var key in careerPathJson){
			treeNode=careerPathJson[key];
				     if(treeNode.hasOwnProperty('root'))
					   var rootObject=treeNode.root;
					  // if($(this).text()===rootObject.levelName)
					   //alert(rootObject.levelName +" "+rootObject.salary);
					   var result=showdetails(rootObject);
			}
				
				function showdetails(rootObject)
				{
				if(selected_option===rootObject.levelName)
					   {
					   //alert(selected_option);
					   //alert(rootObject.levelName +" "+rootObject.salary);
					   $("#optionsWrapper").empty();
					   $("#optionsWrapper").append("<label><b>Job Title</b></label><p>"+rootObject.levelName+"</p>");
					   //$(".callout").text(rootObject.years + " "+ rootObject.salary+ " "+rootObject.description);
					   $("#optionsWrapper").append("<label><b>Avg Salary</b></label><p>"+rootObject.salary+"</p>");
					   $("#optionsWrapper").append("<label><b>Job Responsibilities</b></label><p>"+rootObject.description+"</p>");
					   $("#optionsWrapper").append("<label><b>Exp. Required</b></label><p>"+rootObject.years+"</p>");
					   return true;
					   }
				if(rootObject.hasOwnProperty('children')){	
				     if(rootObject.children.length > 0){	
		     			 $(rootObject.children).each(function(i, innerObject){
						 if(innerObject.levelName===selected_option)
						 {
						 //alert(selected_option);
						 //alert(innerObject.levelName +" "+innerObject.salary);
						  $("#optionsWrapper").empty();
						  $("#optionsWrapper").append("<label>Job Title</label><p>"+innerObject.levelName+"</p>");
						   //$(".callout").text(rootObject.years + " "+ rootObject.salary+ " "+rootObject.description);
						   $("#optionsWrapper").append("<label>Avg Salary</label><p>"+innerObject.salary+"</p>");
						   $("#optionsWrapper").append("<label>Job Responsibilities</label><p>"+innerObject.description+"</p>");
						   $("#optionsWrapper").append("<label>Exp. Required</label><p>"+innerObject.years+"</p>");
						 return true;
						 }
						result=showdetails(innerObject);
						 
						});
					 }
					}
				
				}



			    $(this).webuiPopover({
			        constrains: 'horizontal', 
			        trigger:'mouseover',
			        multi: true,
			        placement:'right-bottom',
			        width:450,
			        closeable:true,
			        content: $('#optionsWrapper').html()
			}); 


		});

		});
});

</script>
<style type="text/css">
.ui-dialog-titlebar{
	display:none;
}
#myModal{
	width:820px !important;
}

.button{height:29px;
	padding:0.25em 2.3em !important;
	margin-right:0.5em;
	cursor:pointer;
	color:#000 !important;
	overflow:visible;
	font-size:14px;
	text-align:center;
	background:#8aecfd;
	border:none;
	-ms-border-radius: 2px;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	border-bottom:1px solid #242424;}
.button:hover{color:#000 !important;}
.list_active img{cursor:hand; cursor:pointer; display:inline-block; padding-top:10px; float:left;}
.list_active span{display:block; margin-top:10px; float:left; padding-left:5px; color:#3399cc;}

.list img{display:inline-block; padding-top:10px; float:left;}
.list span{display:block; margin-top:10px; float:left; padding-left:5px; color:#ccc;}

    /* tooltip styling. by default the element to be styled is .tooltip  */
  .tooltip {
    display:none;
    background:transparent url(../images/black_arrow.png);
    font-size:12px;
    height:70px;
    width:160px;
    padding:25px;
    color:#eee;
  }
    /* style the trigger elements */
  #demo img {
    border:0;
    cursor:pointer;
    margin:0 1px;
  }
</style>
<!--  -->
</head>
<body>
<div id="wrap"> 
  <!--------------  Header Section :: start ----------->
    <%@ include file="includes/header.jsp"%>

<!--------------  Header Section :: end -----------> 
<!--------------  Middle Section :: start ----------->
<div id="midcontainer">
  <div id="innerbanner_wrap">
    <div><img src="images/employer_innerbanner.jpg" alt="Kickstart your carrer. Sign Up Now!" ></div>
    <div class="clear"></div>
  </div>
  <div id="innersection">
  

  
    <section id="rightwrap" class="floatleft">
      <!-- <input type="button" value="Try" class="btnclass"/>
       <input type="button" value="Try" class="btnclass"/>
        <input type="button" value="Try" class="btnclass"/>
     
       -->
    
      
      <div  id="optionsWrapper" style="display: none;"></div> 
      
    <div class="floatright"><a class="list"><img src="images/list.png" width="22" height="22" alt=""> <span>Table View</span></a> <a  class="list_active"><img src="images/list_active.png" width="22" height="21" alt=""> <span>Table View</span> </a></div>
    <div class="par floatleft"> <span class="field">
       
        Area of Interest: &nbsp;
      
        
        <select name="Select" class="input-small_date hasDatepicker" id="functionalareaTree">
          <option value=""></option>
              	<c:forEach var="functionalarea" items="${functionalArea}">
              		<option value="<c:out value="${functionalarea}"/>"><c:out value="${functionalarea}"/></option>
              	</c:forEach>
        </select>
        &nbsp;
        <input name="" type="button" value="Generate" class="generate" id="generate" >
        </span> 
     
      <a class="lnkclr button" href="#myModal1" data-toggle="modal" >Add level</a>
     
      <div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade in" id="myModal1">
      <!-- <iframe src="admin_add_careerpathlevel_form.htm" border="0" width="100%" height="500"></iframe> -->
                 <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">x</button>
                    <h3 id="myModalLabel">Add Level</h3>
                  </div>
                  <div class="modal-body">
                    <div class="fullwidth" id="support">
          <form:form class="stdform"  id="introductory"  action="admin_add_careerpathlevel.htm" modelAttribute="careerPathlevel">
            <div class="doublebottom_margin padding_bottom">
              <div class="leftsection_form">
                <div class="par">
                  <form:label class="floatleft" path="levelName" id="levelform">What is the Role Name you want? </form:label>
                  <span class="star">*</span>
                  <div class="clear"></div>
                  <span class="field">
                   <form:input type="text" class="input-medium3" onfocus="if (this.value=='Role Name') this.value = ''" value="" id="levelName" path="levelName" ></form:input>
                  </span> 
                  <span id="emptyLevelName" class="validationnote"></span>
                  </div>
              </div>
            </div>
            <div class="clear"></div>
            <div class="par">
              <form:label class="floatleft" path="functionalArea" >What is the functionality area you want?</form:label>
              <div class="clear"></div>
              <span class="field">
              <form:select  path="functionalArea" id="functionalArea" >
              	<option value=""></option>
              	<c:forEach var="functionalarea" items="${functionalArea}">
              		<option value="<c:out value="${functionalarea}"/>"><c:out value="${functionalarea}"/></option>
              	</c:forEach>
              </form:select>
              </span> 
              <span id="emptyFunctionalArea" class="validationnote"></span>
              </div>
            <div class="clear"></div>
            <div class="par">
              <label class="floatleft">What is the parent for the level? </label>
             <!--  <span class="star">*</span> -->
              <div class="clear"></div>
              <span class="field">
              <form:select path="parent" id="parent">
 				  <option value=""></option> 
              </form:select>
              </span> 
              </div>
            <div class="clear"></div>
            <div class="par">
              <form:label class="floatleft" path="salary">What is the Average salary range? </form:label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
              <form:input type="text" class="input-medium3" onfocus="if (this.value=='60000') this.value = ''" value="" id= "salary" path="salary"></form:input>
              &nbsp;$ </span> 
               <span id="emptySalary" class="validationnote"></span>
              </div>
               <div class="par">
             <form:label class="floatleft" path="years">What is the Average year? </form:label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
                <form:input type="text"  class="input-medium3" onfocus="if (this.value=='60000') this.value = ''" value="" id="years" path="years"></form:input>
              &nbsp;$ </span> 
              <span id="emptyYears" class="validationnote"></span></div>
            <div class="clear"></div>
            <div class="par">
               <form:label class="floatleft" path="description">Give your decription? </form:label>
              <span class="star">*</span>
              <div class="clear"></div>
              <span class="field">
             <form:textarea style="width:100%;" id = "description" path="description"></form:textarea>
              </span> </div>
           <input id="addLevelBtn" type="button" value="ADD" tabindex="21" class="btn">
            <div class="clear"></div>
          </form:form>
        </div>
                  </div>
                  <div class="modal-footer">
                    <!-- <button data-dismiss="modal" class="btn">Add</button> -->
                  </div> 
                </div>
      </div>
      <!--<input name="" type="button" value="Add Levels" onclick="window.location.href='admin_addlevels.html'">-->
      <div class="clear"></div>
      <div class="borderbottom">&nbsp;</div>
      
      
      <div class="floatleft width100">
      <table class="table table-bordered " id="dyntable">
        <thead>
          <tr>
            <th width="4%" class="nosort">&nbsp;</th>
            <th width="47%" class="table_leftalign">Role Name</th>
            <th width="11%" class="table_leftalign">Functionality Area</th>
            <th width="10%" class="table_leftalign">Parent</th>
            <th width="10%" class="table_leftalign">Average Salary</th>
            <th width="10%" class="table_leftalign">Years required</th>
            <th width="8%" class="table_leftalign nosort">Actions</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="careerPathLevelsDetails" items="${careerPathLevelsDetails}">
          <tr>
            <td class="table_centeralign"><img src="images/green_circle.png" alt=""/></td>
            <td><a href="#"><c:out value="${careerPathLevelsDetails.levelName}"></c:out></a></td>
            <td class="table_centeralign"><c:out value="${careerPathLevelsDetails.functionalArea}"/></td>
            <td class="table_centeralign"><c:out value="${careerPathLevelsDetails.parent}"/></td>
            <td align="center"><a href="#"  class="center_align"><c:out value="${careerPathLevelsDetails.salary}"/></a></td>
            <td align="center"><a href="#"  class="center_align"><c:out value="${careerPathLevelsDetails.years}"/></a></td>
            <td class="table_centeralign"><a href="#"><img src="images/small_edit_icn.gif" class="table_actionbtn" alt="Edit" title="Edit"></a> <a href="#"><img src="images/small_copy_icn.gif" class="table_actionbtn" alt="Copy Job" title="Copy Job"></a></td>
          </tr>
          </c:forEach>
        </tbody>
      </table>
      </div>
      
      
      
      <div id="wrapper"  class="whitebackground margin_top2 floatleft width100">
       <ul class="tree">
          <li> <span>
            <div class="parentbg">Lucy</div>
            </span>
            <ul>
               <li> <a class="lnkclr"  data-toggle="modal" onclick="modalClicked()" href="#myModal" id="myModalClick"> <span> 
               <!-- <li class="tooltiptest"> <a class="lnkclr"  > <span> -->
                <div class="childbg">Biology</div>
                </span> </a>
                <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="myModal">
                  <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
                    <h3 id="myModalLabel">Biology</h3>
                  </div>
                  <div class="modal-body">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id = "grid">
                      <thead>
                        <tr>
                          <th width="60%" align="left">Content Here</th>
                        </tr>
                      </thead>
                      <tbody id="tableBodyEmployerDetails">
                      </tbody>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button data-dismiss="modal" class="btn">Close</button>
                  </div>
                </div>
              </li><li> <a class="lnkclr"  data-toggle="modal" onclick="modalClicked()" href="#myModal" id="myModalClick"> <span>
                <div class="childbg">Biology</div>
                </span> </a>
                <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in" id="myModal">
                  <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">x</button>
                    <h3 id="myModalLabel">Biology</h3>
                  </div>
                  <div class="modal-body">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="emp_scheduleevent_table" id = "grid">
                      <thead>
                        <tr>
                          <th width="60%" align="left">Content Here</th>
                        </tr>
                      </thead>
                      <tbody id="tableBodyEmployerDetails">
                      </tbody>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button data-dismiss="modal" class="btn">Close</button>
                  </div>
                </div>
              </li>
              <li> <span>
                <div class="childbg">Physics</div>
                </span>
                <ul>
                  <li class="origin"> <span>
                    <div class="childbg">Biophysics</div>
                    </span> </li>
                  <li class="origin"> <span>
                    <div class="childbg">Biophysics</div>
                    </span> </li>
                  <li> <span>
                    <div class="childbg">Geophysics</div>
                    </span> </li>
                </ul>
              </li>
              <li> <span>
                <div class="childbg">Chemistry</div>
                </span>
                <ul>
                  <li> <span>
                    <div class="childbg">Biochemistry</div>
                    </span> </li>
                  <li> <span>
                    <div class="childbg">Inorganic Chemistry</div>
                    </span>
                    <ul>
                      <li> <span>
                        <div class="childbg">AP Chemistry</div>
                        </span> </li>
                      <li> <span>
                        <div class="childbg">IB Chemistry</div>
                        </span> </li>
                    </ul>
                  </li>
                </ul>
              </li>
            </ul>
        </ul> 
       <div class="clear"></div>
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