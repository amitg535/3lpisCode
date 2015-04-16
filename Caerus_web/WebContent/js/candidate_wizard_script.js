/* add introductory section */
function addIntroductory()
{
	var student = new Object();
	var checked_option_radio = $('input:radio[name=radiofield]:checked').val();
	var aboutYourself = document.getElementById("aboutYourself").value;
	localStorage.setItem("aboutYourself", aboutYourself);
	var zipcode = document.getElementById("zipcode").value;
	var n = zipcode.length;
	var dob = document.getElementById("datepicker").value;
	var city=document.getElementById("city").value;
	var state=document.getElementById("state").value;
	
	if(aboutYourself == "" || $.trim(aboutYourself) == "")
		{
			$("#emptyAboutYourself").html('Enter About Yourself');
		}

	 if(zipcode == "" || $.trim(zipcode) == "" || n!=5)
		{
			$("#errorZipCode").html('Enter Zip Code (5 digits)');
		}
	
	 if (isNaN(zipcode)) 
		{
			$("#errorZipCode").html('Zip Code should only contain Numbers');
    	}
	 
	if (typeof checked_option_radio === "undefined")
		{
			$("#emptyGender").html('Please select your Gender');
		}

	if (!(typeof checked_option_radio === "undefined"))
	{
		$("#emptyGender").empty();
	}

	 if (dob == "")
		{
			$("#emptyDOB").html('Enter Date Of Birth');
		}

		
	if(!(aboutYourself == "" || $.trim(aboutYourself) == "" || zipcode == "" || $.trim(zipcode) == "" || n!=5 || isNaN(zipcode) || typeof checked_option_radio === "undefined" || dob == "" || city=="" || state==""))
	  { 
		$("#emptyAboutYourself").empty();
		$("#errorZipCode").empty();
		$("#emptyGender").empty();
		$("#emptyDOB").empty();
		
		student.aboutYourSelf = document.getElementById("aboutYourself").value ;
		student.zipCode = document.getElementById("zipcode").value ;
		student.dateOfBirth = document.getElementById("datepicker").value ;
		student.gender = checked_option_radio;
		student.city= city;
		student.state= state;
			
		
		 $.ajax({
	
			  	type : 'POST',
			 	url : 'candidate_wizard_introductory.htm',						
				dataType : 'json',
				cache : false,
				data : JSON.stringify(student),	
				contentType : 'application/json',
				
				success : function(data) {
		
				},
				
				error : function(xhr,error) {
					alert("Failed");
				}
			}); 
	
			$("#content1").css("display", "none");
			$("#content2").css("display", "block");
			
			$("#tab1").removeClass("current");
			$("#tab2").addClass("current"); 
	
			localStorage.setItem("prev", "tab2");
		}	
}

function hideEmptyAboutYourself()
{
	$("#emptyAboutYourself").empty();
}

function hideErrorZipCode()
{
	$("#errorZipCode").empty();
}

function hideEmptyDOB()
{
	$("#emptyDOB").empty();
}

/* skip introductory section */
function skipIntroductory()
{
	$("#content1").css("display", "none");
	$("#content2").css("display", "block");
	
	$("#tab1").removeClass("current");
	$("#tab2").addClass("current"); 

	localStorage.setItem("prev", "tab2");
}

/* add skills section */
function addSkills()
{
	var inputVal= $("#primarySkills").val();

	  if(inputVal=="") 
		{  
		  $("#spn1").remove();
          $("#primarySkills_tagsinput").after('<span id="spn1" style="color: #f00; font-size: 11px;">Enter atleast 1 Primary skill</span>');

   		}  
	   if(inputVal!= "")
	   {
		   $("#spn1").remove();
		   $("#primarySkills_tagsinput").after('<span class="important">    </span>');
   
	   }

	   var inputVal1= $("#tags").val();
	 
      	  if(inputVal1=="") 
        { 
      		$("#spn2").remove();
            $("#tags_tagsinput").after('<span id="spn2"  style="color: #f00; font-size: 11px;">Enter atleast 1 Secondary skill</span>');       
        }  	  
          
      	  if(inputVal1!="")
          {
      		  $("#spn2").remove();
      		  $("#tags_tagsinput").after('<span class="error">  </span>');		  
      	  }

    if(inputVal!="" && inputVal1!="")
    {
		var student = new Object();
		
		student.primarySkills1 = document.getElementById("primarySkills").value;
		student.secondarySkills1 = document.getElementById("tags").value;
		student.aboutYourSelf = localStorage.getItem("aboutYourself");
		
		
		$.ajax({
	
		  	type : 'POST',
		 	url : 'candidate_wizard_skills.htm',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
	
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
		}); 
	
		$("#content3").css("display", "none");
		$("#content4").css("display", "block");
		
		$("#tab3").removeClass("current");
		$("#tab4").addClass("current"); 
	
		localStorage.setItem("prev", "tab4");
     }
}

/* skip skills section */
function skipSkills()
{
	$("#content3").css("display", "none");
	$("#content4").css("display", "block");
	
	$("#tab3").removeClass("current");
	$("#tab4").addClass("current"); 

	localStorage.setItem("prev", "tab4");
}

function hideEmptyCompanyName()
{
	$("#emptyCompanyName").empty();
}

function hideEmptyDesignation()
{
	$("#emptyDesignation").empty();
}

function hideEmptyWorkDesc()
{
	$("#emptyWorkDesc").empty();
}

/* add work section */
function addWork()
{
	var companyName = document.getElementById("companyName").value;
	var designation = document.getElementById("designation").value;
	var workDesc = document.getElementById("workDesc").value;
	var work_start_month = document.getElementById("work_start_month").value;
	var w_startYear_duration = document.getElementById("from_year").value;
	var work_end_month = document.getElementById("work_end_month").value;
	var w_endYear_duration = document.getElementById("to_year").value;

	if(companyName == "" || $.trim(companyName) == "")
	{
		$("#emptyCompanyName").html('Enter a Company Name');
	}

	if(designation == "" || $.trim(designation) == "")
	{
		$("#emptyDesignation").html('Enter designation');
	}

	if(workDesc == "" || $.trim(workDesc) == "")
	{
		$("#emptyWorkDesc").html('Describe your work responsibilities');
	}

	if(+w_startYear_duration > +w_endYear_duration)
	{
		$("#errorDurationWork").html('From duration cannot be greater than To duration');
	}

	if(+w_startYear_duration == +w_endYear_duration)
	{
		if(+work_start_month > +work_end_month)
		{
			$("#errorDurationWork").html('From duration cannot be greater than To duration');
		}
	}

	if(!(+w_startYear_duration > +w_endYear_duration))
	{
		$("#errorDurationWork").empty();
	}

	if(!(companyName == "" || $.trim(companyName) == "" || designation == "" || $.trim(designation) == "" || workDesc == "" || $.trim(workDesc) == "" || +w_startYear_duration > +w_endYear_duration))
	{

		if(+w_startYear_duration < +w_endYear_duration)
		{
			workFunction();
		}
		
		if(+w_startYear_duration == +w_endYear_duration)
		{
			if(!(+work_start_month > +work_end_month))
			{
				workFunction();
			}				
		}
	 }	
	
}
/* add work section */
function workFunction()
{
	$("#emptyCompanyName").empty();
	$("#emptyDesignation").empty();
	$("#emptyWorkDesc").empty();
	$("#errorDurationWork").empty();

	var student = new Object();
	var workDetails = {};
	var i = 0;
	
	workDetails[[i+ 1] + "_workCompanyName"] = document.getElementById("companyName").value;
	workDetails[[i+ 1] + "_workDesignation"] = document.getElementById("designation").value;
	workDetails[[i+ 1] + "_workMonthFrom"] = document.getElementById("work_start_month").value;
	workDetails[[i+ 1] + "_workYearFrom"] = document.getElementById("from_year").value;
	workDetails[[i+ 1] + "_workMonthTo"] = document.getElementById("work_end_month").value;
	workDetails[[i+ 1] + "_workYearTo"] = document.getElementById("to_year").value;
	workDetails[[i+ 1] + "_workDescription"] = document.getElementById("workDesc").value;
	
	student.workMap = workDetails;
	
 	$.ajax({

	  	type : 'POST',
	 	url : 'candidate_wizard_work.htm',						
		dataType : 'json',
		cache : false,
		data : JSON.stringify(student),	
		contentType : 'application/json',
		
		success : function(data) {

		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
	}); 

	$("#content4").css("display", "none");
	$("#content5").css("display", "block");
	
	$("#tab4").removeClass("current");
	$("#tab5").addClass("current"); 

	localStorage.setItem("prev", "tab5");
}

/* skip work section */
function skipWork()
{
	$("#content4").css("display", "none");
	$("#content5").css("display", "block");
	
	$("#tab4").removeClass("current");
	$("#tab5").addClass("current"); 

	localStorage.setItem("prev", "tab5");
}

/* add skills */
function addOtherDetails()
{
	 var inputVal1= $("#tags1").val();
	 
 	  if(inputVal1=="") 
	   { 
	 	   $("#spn2").remove();
	       $("#tags1_tagsinput").after('<span id="spn2"  style="color: #f00; font-size: 11px;">Enter atleast 1 Hobby</span>');       
	   }  	  
     
 	  if(inputVal1!="")
      {
 		  $("#spn2").remove();
 		  $("#tags1_tagsinput").after('<span class="error">  </span>');		  

		var student = new Object();
		
		interestDetails = document.getElementById("tags1").value;
		
		var array = [];
		array = interestDetails.split(",");
		student.interestList = array;
		
		 $.ajax({

		  	type : 'POST',
		 	url : 'candidate_wizard_interests.json',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
				window.location = 'candidate_portfolio.htm';
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
		}); 
 	 }	
}

function hideEmptyLanguage()
{
	$("#emptyLanguage").empty();
}

/* delete language */
function deleteLanguage(elementId)
{
	var student = new Object();

	var aId = $('#'+elementId).parent().attr('id');

	var liText = $('#'+aId).text();
	
	var language = liText.replace( /[\s\n\r]+/g, '');
	
	  $("#" + aId).remove();

	  student.language = language;

		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_wizard_remove_languages.json',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
				
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
			}); 
	
}

/* add language */
function addLanguage()
{
	var student = new Object();

	var language = document.getElementById("languagesList").value;

	if(language == "" || $.trim(language) == "")
	{
		$("#emptyLanguage").html('Enter a Language');
	}

	if(!(language == "" || $.trim(language) == ""))
	{
		$("#languagesDisplay .recent_activities_wrap").append('<li>' + language + '<a class="floatright " style="display:inline-block;" onclick="deleteLanguage(this.id)"><img src="images/list_cross_icn.png" ></a></li>');

		$(".recent_activities_wrap li").attr('id', function(i) {
			  $(this).attr('id', "number" + i);
			});

	  	$(".recent_activities_wrap li a").attr('id', function(i) {
	  		  $(this).attr('id', "q" + i);
	  		});
  		
	  	$("#languagesList").val('');
		
		student.language = language;

		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_wizard_add_languages.json',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
			
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
			
			}); 
	}
	
}

function hideEmptyGpa()
{
	$("#emptyGpa").empty();
}

function hideEmptyGpaSchool()
{
	$("#emptyGpaSchool").empty();
}


function hideEmptySchoolName()
{
	$("#emptySchoolName").empty();
}

function addHighSchool()
{
	$("#buttonGraduate").slideToggle();
	$("#highSchool").slideToggle();
}

/* add graduate details */
function addGraduateDetails()
{
	var student = new Object();

	var universityName = document.getElementById("universityName").value;
	var courseName = document.getElementById("courseName").value;
	var g_from_gpa = document.getElementById("g_from_gpa").value;
	var g_to_gpa = document.getElementById("g_to_gpa").value;
	var g_startYear_duration = document.getElementById("id_g_from_year").value;
	var g_endYear_duration = document.getElementById("id_g_to_year").value;


	if(universityName == "")
	{
		$("#emptyUniversityName").html('Please select a University');
	}

	if(!(universityName == ""))
	{
		$("#emptyUniversityName").empty();
	}
	
	if(courseName == "")
	{
		$("#emptyCourseName").html('Please select a Course');
	}

	if(!(courseName == ""))
	{
		$("#emptyCourseName").empty();
	}
	
	if(+g_from_gpa > +g_to_gpa)
	{
		$("#emptyGpa").html('From value cannot be greater than To value');
	}

	/* if(g_from_gpa % 1 != 0 || g_to_gpa % 1 != 0)
	{
		$("#emptyGpa").html('Decimal Numbers not allowed');
	} */

	if(g_from_gpa =="" || g_to_gpa == "" || $.trim(g_from_gpa) == "" || $.trim(g_to_gpa) == "")
	{
		$("#emptyGpa").html('Enter GPA Score');
	}

	if(isNaN(g_from_gpa) || isNaN(g_to_gpa))
	{
		$("#emptyGpa").html('GPA Score should only be in Numbers');
	}
	
	if(+g_startYear_duration >= +g_endYear_duration)
	{
		$("#errorDuration").html('From duration cannot be greater than To duration');
	}
	
	if(!(universityName == "" || courseName == "" || +g_from_gpa > +g_to_gpa || +g_startYear_duration >= +g_endYear_duration || g_from_gpa =="" || g_to_gpa == "" || $.trim(g_from_gpa) == "" || $.trim(g_to_gpa) == "" || isNaN(g_from_gpa) || isNaN(g_to_gpa) ))
	{

		$("#emptyUniversityName").empty();
		$("#emptyCourseName").empty();
		$("#emptyGpa").empty();
		$("#errorDuration").empty();

		var i = 0;
		var universityDetails = {};
		
		universityDetails[[i+1] + "_universityGpaFrom"] = g_from_gpa;
		universityDetails[[i+1] + "_universityGpaTo"] = g_to_gpa;
		universityDetails[[i+1] + "_universityCourseName"] = courseName;
		universityDetails[[i+1] + "_universityName"] = universityName;
		universityDetails[[i+1] + "_universityYearFrom"] = g_startYear_duration;
		universityDetails[[i+1] + "_universityYearTo"] = g_endYear_duration;
		
		student.universityMap = universityDetails;
		
		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_wizard_graduate.htm',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
	
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
		}); 

		 $("#content2").css("display", "none");
		$("#content3").css("display", "block");
		
		$("#tab2").removeClass("current");
		$("#tab3").addClass("current"); 

		localStorage.setItem("prev", "tab3"); 
		
		 	return true;
	}
	
	return false;
}

/* add entire education section(graduate and high school) */
function addEducationDetails()
{
	var student = new Object();
	
	// High School Details
	var schoolName = document.getElementById("schoolName").value;
	var schoolState = document.getElementById("schoolState").value;
	var h_from_gpa = document.getElementById("h_from_gpa").value;
	var h_to_gpa = document.getElementById("h_to_gpa").value;
	var h_endMonth_duration = document.getElementById("id_h_from_year").value;
	var h_endYear_duration = document.getElementById("id_h_to_year").value;

	var universityName = document.getElementById("universityName").value;
	var courseName = document.getElementById("courseName").value;
	var g_from_gpa = document.getElementById("g_from_gpa").value;
	var g_to_gpa = document.getElementById("g_to_gpa").value;
	var g_startYear_duration = document.getElementById("id_g_from_year").value;
	var g_endYear_duration = document.getElementById("id_g_to_year").value;


	if(schoolName == "" || $.trim(schoolName) == "")
	{
		$("#emptySchoolName").html('Enter School Name');
	}

	if(schoolState == "")
	{
		$("#emptySchoolSate").html('Please select a Course');
	}

	if(!(schoolState == ""))
	{
		$("#emptySchoolSate").empty();
	}
	
	if(+h_from_gpa > +h_to_gpa)
	{
		$("#emptyGpaSchool").html('From value cannot be greater than To value');
	}

	/* if(h_from_gpa % 1 != 0 || h_to_gpa % 1 != 0)
	{
		$("#emptyGpaSchool").html('Decimal Numbers not allowed');
	} */

	if(h_from_gpa =="" || h_to_gpa == "" || $.trim(h_from_gpa) == "" || $.trim(h_to_gpa) == "")
	{
		$("#emptyGpaSchool").html('Enter GPA Score');
	}

	if(isNaN(h_from_gpa) || isNaN(h_to_gpa))
	{
		$("#emptyGpaSchool").html('GPA Score should only be in Numbers');
	}
	
	/*if(+h_startYear_duration >= +h_endYear_duration)
	{
		$("#errorDurationSchool").html('From duration cannot be greater than To duration');
	}*/

	if(+h_endYear_duration > +g_startYear_duration)
	{
		$("#errorHighSchoolDuration").html('High School End duration cannot be greater Graduate Start duration');
	}

	var check = addGraduateDetails();
	
	if(check == true && !(schoolName == "" || $.trim(schoolName) == "" || schoolState == "" ||+h_endYear_duration > +g_startYear_duration || +h_from_gpa > +h_to_gpa || h_from_gpa =="" || h_to_gpa == "" || $.trim(h_from_gpa) == "" || $.trim(h_to_gpa) == "" || isNaN(h_from_gpa) || isNaN(h_to_gpa)))
	{
		$("#emptySchoolName").empty();
		$("#emptySchoolSate").empty();
		$("#emptyGpaSchool").empty();
		$("#errorDurationSchool").empty();
		
		var i = 0;
		var schoolDetails = {};
		var universityDetails = {};
		
		schoolDetails["schoolName"] = schoolName;
		schoolDetails["schoolPassingYear"] = h_endYear_duration;
		schoolDetails["schoolGpaFrom"] = h_from_gpa;
		schoolDetails["schoolGpaTo"] = h_to_gpa;
		schoolDetails["schoolState"] = schoolState;
		schoolDetails["schoolPassingMonth"] = h_endMonth_duration;
		
		student.schoolMap = schoolDetails;
		
		universityDetails[[i+1] + "_universityGpaFrom"] = g_from_gpa;
		universityDetails[[i+1] + "_universityGpaTo"] = g_to_gpa;
		universityDetails[[i+1] + "_universityCourseName"] = courseName;
		universityDetails[[i+1] + "_universityName"] = universityName;
		universityDetails[[i+1] + "_universityYearFrom"] = g_startYear_duration;
		universityDetails[[i+1] + "_universityYearTo"] = g_endYear_duration;
		
		student.universityMap = universityDetails;
		
		$.ajax({

		  	type : 'POST',
		 	url : 'candidate_wizard_total_education.htm',						
			dataType : 'json',
			cache : false,
			data : JSON.stringify(student),	
			contentType : 'application/json',
			
			success : function(data) {
	
			},
			
			error : function(xhr,error) {
				alert("Failed");
			}
		}); 

		$("#content2").css("display", "none");
		$("#content3").css("display", "block");
		
		$("#tab2").removeClass("current");
		$("#tab3").addClass("current"); 

		localStorage.setItem("prev", "tab3");
		
	}
	if(check == true && (schoolName == "" || $.trim(schoolName) == "" || schoolState == "" ||+h_endYear_duration > +g_startYear_duration || +h_from_gpa > +h_to_gpa || h_from_gpa =="" || h_to_gpa == "" || $.trim(h_from_gpa) == "" || $.trim(h_to_gpa) == "" || isNaN(h_from_gpa) || isNaN(h_to_gpa)))
	{
		$("#content2").css("display", "block");
		$("#content3").css("display", "none");
		
		$("#tab3").removeClass("current");
		$("#tab2").addClass("current"); 

		localStorage.setItem("prev", "tab2");
	}
}

/* upload resume via ajax call */
function uploadResume()
{	
 var isValidFile=false;
 var ext = $('#fileResume').val().split('.').pop().toLowerCase();
//If the extension of the  uploaded file is among the ones listed below then upload
 if($.inArray(ext, ['pdf','doc','docx','rtf','txt']) != -1) 
 {
	 isValidFile=true;
 }

 if(isValidFile!==false)
 {
	var resumeFile = new FormData();
    resumeFile.append("fileResume", fileResume.files[0]);

    var client = new XMLHttpRequest();
    client.open("post", "candidate_upload_resume.htm", true);
    client.send(resumeFile);

    $("#resumeName").empty().append(fileResume.files[0].name);
    
    $("#content1").css("display", "none");
 	$("#content3").css("display", "block");
 	
 	$("#tab1").removeClass("current");
 	$("#tab3").addClass("current"); 

 	localStorage.setItem("prev", "tab3");
    return true;

 }
 else
{
	 $("#invalidFile").empty().append('Invalid File.Please upload a CV');
}

  return false;
}

/* get city and state on entering zip code */
function getCityFunction()
{
	var zipCode=$("#zipcode").val();
	   
      $.ajax({
        
        url: 'get_city_name.htm',
        data : {
			'zipCode' : zipCode
		},
        cache: false,
   	    success: function(cityName) {
   	   	    if(cityName==" ()"){
   	   	  $("#city").val("");
   	   	  $("#state").val("");  
   	   	  $("#zipCodeError").html("Please Enter Valid Zip Code");
   	   	   	    }
   	   	    else
   	   	   	    {
   	   	  			$("#zipCodeError").html("");  
   	   	  			values=cityName.split('(');
  					finalCity=values[0];
  					two=values[1];
  					$("#city").val(finalCity);
  					splitState=two.split(')');
  					finalState=splitState[0];
  					$("#state").val(finalState);
   	   	   	    }
             
     
        }
    });
 

}
