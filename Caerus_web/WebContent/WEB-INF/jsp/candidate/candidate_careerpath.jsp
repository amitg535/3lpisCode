<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Candidate Career Path</title>

  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="css/tree-layout.css" />
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

$('#wrapper').slideUp().hide();

$('.generate').click (function(){
	  $('#wrapper').slideDown().show();
	 $('#dyntable_wrapper').slideUp().hide();
	 // $('.list_active').show();
	   $('.list').hide();
	  
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
					   $("#optionsWrapper").append("<label>Job Title: </label>"+rootObject.levelName);
					   //$(".callout").text(rootObject.years + " "+ rootObject.salary+ " "+rootObject.description);
					   $("#optionsWrapper").append("<label><b>Avg Salary: </b></label>"+rootObject.salary);
					   $("#optionsWrapper").append("<label><b>Job Responsibilities: </b></label>"+rootObject.description);
					   $("#optionsWrapper").append("<label><b>Exp. Required: </b></label>"+rootObject.years);
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
						  $("#optionsWrapper").append("<label>Job Title: </label>"+innerObject.levelName);
						   //$(".callout").text(rootObject.years + " "+ rootObject.salary+ " "+rootObject.description);
						   $("#optionsWrapper").append("<label>Avg Salary: </label>"+innerObject.salary);
						   $("#optionsWrapper").append("<label>Job Responsibilities: </label>"+innerObject.description);
						   $("#optionsWrapper").append("<label>Exp. Required: </label>"+innerObject.years);
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
</head>


<body>
<div id="wrap">
   
  <!--------------  Header Section :: start ----------->
  <%@ include file="includes/header.jsp" %>
  <!--------------  Header Section :: end ------------> 
  <!--------------  Middle Section :: start ----------->
  <div id="midcontainer">
     <div id="innerbanner_wrap">
      <div id="banner"><img src="images/candidate_innerbanner.jpg" alt="We will open the world of opportunities to take carrer to the next level"></div>
    </div> 

    <div id="innersection">
    <%-- <div id="breadcrums_wrap">
						You are here: <a href="<c:url value="candidate_dashboard.htm"/>">Home</a>
						\ Roadmap
    </div> --%>
    <section id="rightwrap" class="floatleft">
    
    
    <div  id="optionsWrapper" style="display: none;"></div> 
    <div class="whitebackground floatleft width100">
    
    <h1 class="sectionheading">Confused about your career road map?</h1>
    
    	<p class="borderbottom padding_bottom2 ">
    			Let us help you in understanding how you can move ahead in your professional life in the coming years. Lets Start ! 
    			
    					<br>
						<br>
					 Choose your area of Interest
					 
					 
					 
					 <select name="Select" class="input-small_date hasDatepicker" id="functionalareaTree">
          <option value=""></option>
              	<c:forEach var="functionalarea" items="${functionalArea}">
              		<option value="<c:out value="${functionalarea}"/>"><c:out value="${functionalarea}"/></option>
              	</c:forEach>
        </select>
        &nbsp;
        <input name="" type="button" value="Generate" class="generate" id="generate" >
					 
						
		</p>
    
    <!-- New Section -->
    
    <div id="wrapper" class="margin_top2">
       
       <div class="clear"></div>
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