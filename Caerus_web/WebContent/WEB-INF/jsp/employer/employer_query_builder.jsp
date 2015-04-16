<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Employer Query Builder</title>
<meta name="description" content="">
<meta name="author" content="">

<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/carousal.js"></script>
<script src="js/custom-form-elements.js"></script>

<link rel="stylesheet" type="text/css" href="css/menu.css">
<link rel="stylesheet" media="screen" href="css/form_style.css" />

<script type="text/javascript" language="javascript" src="js/jquery.dropdownPlain.js"></script>



<!--New Scripts  -->
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/uielements/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/uniform.tp.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/jquery.ui.css" type="text/css">
  <link rel="stylesheet" href="css/uielements/jquery.chosen.css" type="text/css" />
  <link rel="stylesheet" href="css/uielements/style.default.css" type="text/css" />
  <link rel="stylesheet" href="css/jquery.wysiwyg.css" type="text/css" />
  <link rel="stylesheet" href="css/video-js.css" type="text/css" />

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
  <script src="js/video.js"></script>
  <script type="text/javascript" src="js/jquery.wysiwyg.js"></script>


<script type="text/javascript">
	$(function() {
		$('#wysiwyg').wysiwyg({
			controls : {

				increaseFontSize : {
					visible : true
				},
				decreaseFontSize : {
					visible : true
				}
			}
		});
	});
</script>





<script type="text/javascript" src="js/jquery-latest.min.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						/* $("div#modalQueryBuilderDiv").hide(); */
						$("div#successFormulaDiv").hide();

						$("#saveQuery")
								.click(function() {
											$('#queryBuilderForm')
													.attr('action',
															'employer_querybuilder_add_formula.htm?action=save');
											$('#queryBuilderForm').submit();
										});
						
						$("#deleteQuery")
								.click(function() {
											$('#queryBuilderForm')
													.attr('action',
															'employer_querybuilder_delete_formula.htm');
											$('#queryBuilderForm').submit();
										});

						// Back Space Functionality Code
						$("#backspaceBtn").click(function(){

						var str = $('#formula').val();
						
						// Regular expressions 
						var alphaRegex = new RegExp('[A-Za-z ]');
						var numRegex = new RegExp('[0-9.]');
						var oprtrRegex = new RegExp('[+/*-]');
						var openBcktRegex = new RegExp('[(]');
						var closeBcktRegex = new RegExp('[)]');

						var stringGrp= '';
						var groups =[];

				        for (var i=0; i<str.length; i++){

				        var j = str.charAt(i);
				        var k = str.charAt(i+1);

						// Character is alphabet check
				       if(j.match(alphaRegex)){
				       stringGrp = stringGrp + j;
				       }

					   // End of word ( Eg. Age, Graduation Year etc) check
				      if(k.match(numRegex) || k.match(oprtrRegex) || k.match(openBcktRegex) || k.match(closeBcktRegex) ){
				          if(stringGrp != ''){

					            // Push into expression group array
				                groups.push(stringGrp);
				                stringGrp = '';
				            }
				       }
				       
				       // Character is other than alphabet check 
				      if(j.match(numRegex) || j.match(oprtrRegex) || j.match(openBcktRegex) || j.match(closeBcktRegex)){
				                      groups.push(j); }
				            

				        }

						// Remove last expression from expression group
				        groups.pop();
				        var editedFormula= '';

				        
				          $.each( groups, function(i,j){
				        	  editedFormula = editedFormula + groups[i];
				        	  
				        	  });
				        
				          $('#formula').val(editedFormula);
							});


						//Add Formula
						$(".add_participants").click(function (){

							var formulaName = $("#formulaName").val();
							if($("#formulaName").val() == ""){
								$("#emptyFormulaName").html("Please Enter Formula Name");
								}

							else{

								
								var formula = "";
								var age_preference = null;
								var experience_preferenece = null;
								var gradyear_recency = null;
								var univ_gpa_preference = null;
								var school_gpa_preference = null;
								var university_rank_preference = null;
								var course_rank_preference = null;
								
								
							

							//Age 
							age_preference = $('input[name=age]:checked').val();
							if(null!= age_preference && age_preference == "younger"){

								formula = formula.concat("100/Age");
								//Experience
								experience_preferenece = $('input[name=experience]:checked').val();
								if(null!= experience_preferenece && experience_preferenece == "yes"){

									formula = formula.concat("+Years of Experience*2");
									
									}
									
								}
							if(null!= age_preference && age_preference == "senior"){

								formula = formula.concat("Age/6");
								//Experience
								experience_preferenece = $('input[name=experience]:checked').val();
								if(null!= experience_preferenece && experience_preferenece == "yes"){

									formula = formula.concat("+Years of Experience*2");
									
									}
									
								}

							if(null!= age_preference && age_preference == "doesn't matter"){
								
								//Experience
								experience_preferenece = $('input[name=experience]:checked').val();
								if(null!= experience_preferenece && experience_preferenece == "yes"){

									formula = formula.concat("Years of Experience*2");
									
									}
								}

							
							//Graduation Year 
							gradyear_recency = $('input[name=gradyear]:checked').val();
							if(null!= gradyear_recency && gradyear_recency == "yes"){

								//formula +=  "Graduation Year";
								//alert("formula age"+ formula);
								
								}

							//Percentage GPA Consideration 
							univ_gpa_preference = $('.univgpa').val();
							//alert("univ_gpa_preference"+univ_gpa_preference);
							if(univ_gpa_preference != 0){
								univ_gpa_preference = univ_gpa_preference/10;

								//Check prev not required
								if(null!= experience_preferenece && experience_preferenece == "yes"){
									formula = formula.concat("University GPA*"+univ_gpa_preference);
									}
								else
								formula = formula.concat("+University GPA*"+univ_gpa_preference);
								}
							
							
							school_gpa_preference = $('.schoolgpa').val();
							if(school_gpa_preference != 0){
								school_gpa_preference = school_gpa_preference/10;
								//alert("school_gpa_preference"+school_gpa_preference);
								formula = formula.concat("+High School GPA*"+school_gpa_preference);
								}

							university_rank_preference = $('input[name=univrank]:checked').val();
							if(null!= university_rank_preference && university_rank_preference == "yes"){

								formula +=  "+(1/University Rank)*10";
								//alert("formula age"+ formula);
								
								}

							course_rank_preference = $('input[name=univrank]:checked').val();
							if(null!= course_rank_preference && course_rank_preference == "yes"){

								formula +=  "+(1/Course Rank)*10";
								//alert("formula age"+ formula);
								
								}
							
							
							var action = "save";
 							var url='employer_querybuilder_add_formula.htm';
							$.ajax({

							type:"POST",
							url:url,
							cache : false,
							
							data:
							{
								'formulaName': formulaName,
								'formula':formula,
								'action':action
							}, 
							success : function (data) {

								//Hide success message on QueryBuilde Pane
						        $(".messageblock").html('');

						        //Display Success Message on Modal
						        $("#formulaHeader").html("Congratulations! Your Formula is created Successfully.");

								//Set Formula Name with created formula
								$("#formulaForm").hide();

								//Append success image 
								$("#createdFormula").html(formula);
								//$("#formula_Name").show();
								//$("#formula_Name").css('display', 'block');
								$("div#successFormulaDiv").show();


								$("#hiddenFormulaName").val(formulaName);
								  },

							  error : function (data) {
								  }

								});
						}
				    });

						//Dependable School and University GPA
						$(".univgpa")
						.change(function() {
						
							var univ_gpa_preference = $('.univgpa').val();
							$('.schoolgpa').val(100-univ_gpa_preference);
								});

						$(".schoolgpa")
						.change(function() {
						
							var school_gpa_preference = $('.schoolgpa').val();
							$('.univgpa').val(100-school_gpa_preference);
								});

						//Launch Query Builder Modal 
						$("#launchModal")
						.click(function() {
							 $("#successFormulaDiv").hide();
							 $("#formulaForm").show();
							 $("#generateResults").show();
							 $('#formulaModal').modal('show');
							 
							});	

						//Hide Query Builder Modal
						$("#hideModal")
						.click(function() {

							 $('#formulaModal').modal('hide');
							
					});

						//Select job title
						$("#jobTitleName")
						.change(function() {
							$("a#generateResults").attr("href", "employer_view_job_responses.htm?jobId="+$(this).val()+"&formulaName="+$("#hiddenFormulaName").val());

							
					});
						 
						
				
					}
					
				);



</script>


<style>
table.calc,fieldset {
	border: none;
	padding: 0;
	margin: 0;
}

input.calc {
	width: 95%;
	color: #808080;
	background: #efefef; /* Old browsers */
	background: -moz-linear-gradient(top, #efefef 1%, #ffffff 100%);
	/* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(1%, #efefef),
		color-stop(100%, #ffffff) ); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, #efefef 1%, #ffffff 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, #efefef 1%, #ffffff 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, #efefef 1%, #ffffff 100%);
	/* IE10+ */
	background: linear-gradient(to bottom, #efefef 1%, #ffffff 100%);
	/* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient(   startColorstr='#efefef',
		endColorstr='#ffffff', GradientType=0 ); /* IE6-9 */
	padding: 4px;
	border: 1px solid #9f9f9f;
	border-radius: 4px;
	margin: 5px 3px;
}
#saveQuery, #deleteQuery, #deleteQueryDisabled{box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important;}
#deleteQueryDisabled{background: #E8E8E8;
  border: 1px solid #777;
  color: #A6A1A6;}
.messageblock {color: #008000;}
</style>
</head>
<body>
	<div id="wrap">
		<!--------------  Header Section :: start ----------->
		<%@ include file="includes/header.jsp"%>
		<!--------------  Header Section :: end ----------->

		<!--------------  Middle Section :: start ----------->
		<div id="midcontainer">
			<div id="innerbanner_wrap">
				<div id="banner">
					<img src="images/university_innerbanner.jpg"
						alt="We will open the world of opportunities to take carrer to the next level">
				</div>
			</div>
			
			<div id="innersection">
				<section id="profilesection">
					<%-- <div id="breadcrums_wrap">
						You are here: <a href="<c:url value="employer_dashboard.htm"/>">Home</a>
						\ Query Builder
					</div> --%>
					<h1 class="sectionheading">Query Builder</h1>
					<p class="whitebackground">
					 
						The Custom Query Builder allows you to Rank Candidates based on
						Parameters of your choice. Create your Ranking Formulae
						And Check how the Candidates fare as per your Criteria. <br>
						You can check the results of your query on the <strong>"Manage
							Responses"</strong> page and <strong>"Candidate Search"</strong> page once
						you activate the <strong>I-Score</strong>.<br>We will ensure
						that your formulae results in candidates of your choice .<br>
						<br>
					 Query Builder Wizard to Create a Formula Or Use Query Builder Pane
						<!-- <a href="#formulaModal" data-toggle="modal">  -->
					    <input name="launchModalBtn" id="launchModal" type="button" value="Launch" class=""> 
					 <!-- </a> -->
					</p>
					<div class="selectExpressionBox whitebackground floatleft">

						<ul class="expressionlist">

							<li class="disabled"><a href="#">Create List of Formula
									<img src="images/arrow_left.png" width="13" height="28" alt="">
							</a></li>

							<c:forEach var="formulaeListVar" items="${formulaeList}">
								<li onclick="location.href='employer_querybuilder_edit_formula.htm?formulaName=<c:out value="${formulaeListVar.formulaName}"/>'" class=""><a href="employer_querybuilder_edit_formula.htm?formulaName=<c:out value="${formulaeListVar.formulaName}"/>"
									class="active"><c:out value="${formulaeListVar.formulaName}" /><img
										src="images/arrow_left.png" width="13" height="28" alt=""></a></li>
							</c:forEach>

						</ul>
						<div class="expressionformula" id="calculator">
						
								<form:form name="calculator" action="" method="post" modelAttribute="queryBuilderCom" id="queryBuilderForm">
							<div class="formulatitle">

								<div class="messageblock">
									<c:out value="${successMessage}"></c:out>
								</div>


								<span class="star">*</span>
									<form:input path="formulaName" type="text"
										class="smalltextboxstyle4" tabindex="1" id="validateId" maxlength="75" />

									<input name="saveBtn" id="saveQuery" type="button" value="Save" class="">
									<!-- <input name="" id="ed01" type="button" value="Edit" disabled="disabled"	class="disable"> -->
									
									
									<c:choose>
										<c:when test="${ queryBuilderCom.deleteAndEditButtonStatus.equals('enabled') }">
											<input name="deleteBtn" id="deleteQuery" type="button" value="Delete" >
										</c:when>
										<c:otherwise>
											<input name="deleteBtn" id="deleteQueryDisabled" type="button" value="Delete" disabled="disabled">
										</c:otherwise>
									</c:choose>

									<form:errors path="formulaName" cssClass="validationnote" />
									<form:errors path="formula" cssClass="validationnote" />
									</div>
									
										<form:textarea path="formula" name="formula" id = "formula" readonly="true" cssClass="calc contentBox" />
						
									<div class="calculator">
										<fieldset>
											<table class="calc" cellpadding=4 width="100%"
												cellspacing="0">
												<TR>
												<td><input type="button" class="calc operators"
														value="+" onclick="calculator.formula.value +='+'"></td>
													<td><input type="button" class="calc operators"
														value="-" onclick="calculator.formula.value +='-'"></td>
													<td><input type="button" class="calc operators"
														value="*" onclick="calculator.formula.value +='*'"></td>
												</TR>
												
												<tr>
													
													<td><input type="button" class="calc operators"
														value="(" onclick="calculator.formula.value +='('"></td>
													<td><input type="button" class="calc operators"
														value=")" onclick="calculator.formula.value +=')'"></td>
													<td><input type="button" class="calc operators"
														value="/" onclick="calculator.formula.value +='/'"></td>
												</tr>

												<tr>
													<td><input type="button" class="calc number" value="1"
												onclick="calculator.formula.value +='1'"></td>
													<td><input type="button" class="calc number" value="2"
														onclick="calculator.formula.value +='2'"></td>
													<td><input type="button" class="calc number" value="3"
														onclick="calculator.formula.value +='3'"></td>
													
												</tr>
												<tr>
													<td><input type="button" class="calc number" value="4"
														onclick="calculator.formula.value +='4'"></td>
													<td><input type="button" class="calc number" value="5"
														onclick="calculator.formula.value +='5'"></td>
													<td><input type="button" class="calc number" value="6"
														onclick="calculator.formula.value +='6'"></td>
												</tr>
												<tr>
													<td><input type="button" class="calc number" value="7"
														onclick="calculator.formula.value +='7'"></td>
													<td><input type="button" class="calc number" value="8"
														onclick="calculator.formula.value +='8'"></td>
													<td><input type="button" class="calc number" value="9"
														onclick="calculator.formula.value +='9'"></td>
												</tr>
												
												<tr><td colspan="2"><input type="button" class="calc number" value="0"
														onclick="calculator.formula.value +='0'"></td>
													<td><input type="button" class="calc number" value="."
														onclick="calculator.formula.value +='.'"></td>
														</tr>
														<tr>
													<td  colspan="2"><input type="button" class="calc clear" value="C"
														onclick="calculator.formula.value=''"></td>
													<!-- <td><input class="calc backspace" type="button"
														value='&larr;' onclick="calculator.formula.value +=''"></td> -->
														<td><input id ="backspaceBtn" class="calc backspace" type="button"
														value='&larr;'></td>
												</tr>
											</table>
										</fieldset>
									</div>


									<div class="expressionButton">
										<input type="button" value="University Rank"
											class="textbutton variable"
											onclick="calculator.formula.value +='University Rank'">

										<input type="button" value="Course Rank"
											class="textbutton variable"
											onclick="calculator.formula.value +='Course Rank'"> <input
											type="button" value="Graduation Year"
											class="textbutton variable"
											onclick="calculator.formula.value +='Graduation Year'">

										<input type="button" value="Years of Experience"
											class="textbutton variable"
											onclick="calculator.formula.value +='Years of Experience'">

										<input type="button" value="High School GPA"
											class="textbutton variable"
											onclick="calculator.formula.value +='High School GPA'">

										<input type="button" value="University GPA"
											class="textbutton variable"
											onclick="calculator.formula.value +='University GPA'">

										<input type="button" value="Age" class="textbutton variable"
											onclick="calculator.formula.value +='Age'">

									</div>
								</form:form>
							
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
<%-- <div id = "modalQueryBuilderDiv">
<form:form name="calculator" action="" method="post" modelAttribute="queryBuilderCom" id="modalQueryBuilderForm">
	<form:input path="formulaName" type="text"
	class="smalltextboxstyle4" tabindex="1" id="validateId" maxlength="75" />
    <form:textarea path="formula" name="formula" id = "formula" readonly="true" cssClass="calc contentBox" />
</form:form>
</div> --%>
 
 
 <div id="createFormulaModalDiv"> 
		<div aria-hidden="false" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-2" class="modal hide fade in" id="formulaModal">
			<div class="modal-header">
				 <button aria-hidden="true" data-dismiss="modal" class="close"
 					type="button">x</button>
				<h3 id="formulaHeader">Query Builder</h3> 
			</div>
			<div class="modal-body">
			
			
			
			
			
				 <form class="stdform" action="" method="get" id="formulaForm">
						<div class="par">
							<label class="floatleft">Formula Name</label> <span class="star">*</span>
							<input id="formulaName" name="formulaName" tabindex="1" class="smalltextboxstyle4 floatright" type="text" value="" maxlength="75" required>
							<span id="emptyFormulaName" class="validationnote"></span>
							<div class="clear"></div>
					</div>
				 
				 <table cellpadding="0" cellspacing="0" width="100%">
				 <tr>
				 <td style="font-size:35px;" colspan="2"><strong>Candidate Preferences</strong></td>
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 <tr>
				 <td width="38%"><label class="floatleft">Age</label></td>
				 <td  width="62%">
				 <input class="floatleft" type="radio" name="age" value="younger">Younger
					<input class="floatleft" type="radio" name="age" value="senior">Senior
					<input class="floatleft" type="radio" name="age" value="doesn't matter" checked>Doesn't Matter</td>
					
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 <tr>
				 <td  ><label class="floatleft">Experience Needed</label></td>
				 <td  ><input type="radio" name="experience" value="yes" checked>Yes
							<input type="radio" name="experience" value="no">No</td>
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 <tr>
				 <td  ><label class="floatleft">Graduation Year Recency</label></td>
				 <td  ><input type="radio" name="gradyear" value="yes" checked>Yes
					<input type="radio" name="gradyear" value="no">No</td>
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 <tr>
				 <td  ><label class="floatleft"><strong>Percentage GPA Consideration</strong></label></td></tr>
				 <tr><td height="10px"></td></tr>
				 
				 <tr>
				 <td  ><label class="floatleft">University GPA</label></td>
				 <td  ><input type="number" name="univgpa" max="100" min = "0" step="10" value="" class="input-small univgpa right_margin" />%</td>
				 </tr>
				 <tr><td height="10px"></td></tr>
				 <tr>
				 <td  ><label class="floatleft">High School GPA</label></td>
				 <td  ><input type="number" name="schoolgpa" max="100" min = "0" step="10" value="" class="input-small schoolgpa right_margin" />%</td>
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 
				 
				 <tr>
				 <td  ><label class="floatleft"><strong>Rankings Consideration</strong></label></td></tr>
				 <tr><td height="10px"></td></tr>
				 <tr>
				 <td  ><label class="floatleft">University Rank</label></td>
				 <td  ><input type="radio" name="univrank" value="yes" checked>High
							<input type="radio" name="univrank" value="no">Doesn't Matter</td>
				</tr>
				
				<tr><td height="10px"></td></tr>
				<tr>
				 <td  ><label class="floatleft">Course Rank</label></td>	
				 <td  ><input type="radio" name="courserank" value="yes" checked>High
							<input type="radio" name="courserank" value="no">Doesn't Matter</td>	
				 </tr>
				 <tr><td height="10px"></td></tr>
				 
				 
				 <tr>
				 <td  ><input type="button" value="Create Now" tabindex="21" class="add_participants floatright"></td>
				 <td  ><span id="formulaValidation" class="hideValidation"></span></td>
				 </tr>
				 
				 
				 
				 
				 </table>
				
						
				
					<div class="clear"></div>
				</form>  
			
			
			
			<div id = "successFormulaDiv" style="height:200px;">
			
			
			                <div class="par">
			                <p>Select a Job to Sort Job Responses based on Created Formula</p>
			                 <div class="details floatleft">
		               <span class="floatleft">
		              <select data-placeholder="Choose an Option" class="chzn-select input-xlarge" name="" id="jobTitleName" style="margin-left:12px">
			               <c:forEach var="employerJob" items="${employerJobsList}">
			             	  <option value="${employerJob.jobIdAndFirmId}" selected="selected"><c:out value="${employerJob.jobTitle}" /></option>
			               </c:forEach>
		              </select>  
		              
		            <!--  <select data-placeholder="Choose an Option" class="chzn-select list_widthstyle1" name="" id="jobTitleName" style="margin-left:12px">
		              <option>1</option>
		              </select> -->
		              </span>
		              <input type ="hidden" id = "jobIdAndFirmId"/>
		              <input type ="hidden" id = "hiddenFormulaName"/>
		  		  <a  id = "generateResults" href="#">
	              
	              <input type="button" value="Generate" id="generateScoresBtn"  class="floatleft" style="margin-left:15px;">
	              </a>
               </div>
						
						</div>
						
			            
			</div>
			
			</div>
			
			
			<div class="modal-footer">
				<button data-dismiss="modal" id = "hideModal" class="btn">Close</button>
			</div>
		
		<!-- Modal Body Div  -->
		</div>
	</div> 
	
	
	      
   <div  aria-hidden="false" aria-labelledby="myModalLabel" role="dialog" tabindex="-2" class="modal hide fade in"  id="exceptionModal1">
    <div class="modal-backdrop fade in" style="z-index: 999;"></div>
   <div style="z-index: 1000; position:absolute;" class="modal ui-dialog-content">
   <div class="modal-header">
    <h3 id="myModalLabel"> Error </h3>
   </div>
   <div class="modal-body"> 
       <span id="successMessageSpan"></span>
                  
    <c:out value="${successMessage}"></c:out>
   </div>
   </div>
  </div>
</body>
</html>