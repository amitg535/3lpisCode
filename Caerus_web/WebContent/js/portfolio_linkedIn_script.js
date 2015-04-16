
function onLinkedInLoad() {
IN.Event.on(IN, "auth", onLinkedInAuth);
}

function onLinkedInAuth() 
{
IN.API.Profile("me")
.fields("firstName", "lastName", "industry", "location:(name)", "picture-url", "headline", "summary", "interests", "num-recommenders", "phone-numbers", "main-address", "num-connections", "public-profile-url", "distance", "positions:(title,company:(id,name,type,size,industry,ticker),id,summary,start-date,end-date,is-current)", "email-address", "educations:(id,school-name,field-of-study,start-date,end-date,degree,activities,notes)", "date-of-birth", "publications:(id,title,publisher:(name),authors:(id,name,person),date,url,summary)" , "skills:(id,skill:(name))" ,"certifications:(id,name,authority:(name),number,start-date,end-date)", "courses:(id,name,number)", "volunteer:(volunteer-experiences:(id,role,organization:(name),cause:(name)))","patents:(id,title,summary,number,status:(id,name),office:(name),inventors:(id,name,person),date,url)", "recommendations-received:(id,recommendation-type,recommendation-text,recommender)","picture-urls::(original)", "languages:(id,language:(name),proficiency:(level,name))")
.result(displayProfiles)
.error(displayProfilesErrors);

// added to clear linkedIn cache
IN.User.logout();

}

function displayProfiles(profiles) {
	var student = new Object();
	
/* Basic Info */
member = profiles.values[0];

phone = member.phoneNumbers;
var phoneCount = phone._total;
if(phoneCount > 0)
{
	phoneDetails = member.phoneNumbers.values[0];
	student.mobileNumber = phoneDetails.phoneNumber;	
}


if(!(member.dateOfBirth == null) )
{
	var date = member.dateOfBirth.year + "-" + member.dateOfBirth.month + "-" + member.dateOfBirth.day ;
	student.dateOfBirth = date;
}

if(!(member.mainAddress == null) )
{
	var address = member.mainAddress;
	address = address.replace(/\n/g, "");
	student.address = address;
}

if(!(member.summary == null) )
{
	student.aboutYourSelf = member.summary;
}

if(!(member.headline == null) )
{
	student.profileName = member.headline;
}

if(!(member.interests == null) )
{
	interestDetails = member.interests;
	var array = [];
	array = interestDetails.split(",");
	student.interestList = array;
}

/* urlDetails = member.pictureUrls;
var urlCount = urlDetails._total;
for(var i = 0; i < urlCount; i++) {
student.pictureUrl = urlDetails.values[i];
}*/

if(!(member.languages == null) )
{
	languageDetails = member.languages;
	var languageCount = languageDetails._total;
	var languages = [];
	for(var i = 0; i < languageCount; i++)
	{
		languages[i] = languageDetails.values[i].language.name;
	}
	student.languagesList = languages;
}

/* Educational Info */
if(!(member.educations == null) )
{
	educationDetails = member.educations;
	var educationCount = educationDetails._total;
	var schoolDetails = {};
	var universityDetails = {};
	
	for(var i = 0; i < educationCount; i++) 
	{
		if(educationDetails.values[i].degree == "High School")
		{
			schoolDetails["schoolName"] = educationDetails.values[i].schoolName;
			schoolDetails["schoolPassingYear"] = educationDetails.values[i].endDate.year;
		}
		
		else
		{
			universityDetails[[i+1] + "_universityCourseType"] = educationDetails.values[i].degree;
			universityDetails[[i+1] + "_universityCourseName"] = educationDetails.values[i].fieldOfStudy;
			universityDetails[[i+1] + "_universityName"] = educationDetails.values[i].schoolName;
			universityDetails[[i+1] + "_universityYearFrom"] = educationDetails.values[i].startDate.year;
			universityDetails[[i+1] + "_universityYearTo"] = educationDetails.values[i].endDate.year;
		}
		
		student.schoolMap = schoolDetails;
		student.universityMap = universityDetails;
	}
	
}

/* Skills Info */
if(!(member.skills == null) )
{
	 skillsDetails = member.skills;
	 var skillCount = skillsDetails._total; 
	 var arr = [];
	 for(var i = 0; i < skillCount; i++) {
		  arr[i] = skillsDetails.values[i].skill.name;  	
	   } 
	student.primarySkills = arr;
}

/* Work Info*/
if(!(member.positions == null) )
{
	position = member.positions;
	var positionCount = position._total;
	var workDetails = {};
	
	for(var i = 0; i < positionCount; i++)
	{
		workDetails[[i+ 1] + "_workCompanyName"] = position.values[i].company.name;
		workDetails[[i+ 1] + "_workDesignation"] = position.values[i].title;
		workDetails[[i+ 1] + "_workMonthFrom"] = position.values[i].startDate.month;
		workDetails[[i+ 1] + "_workYearFrom"] = position.values[i].startDate.year;
		
		if(typeof position.values[i].endDate === "undefined")
		{
			workDetails[[i+ 1] + "_workMonthTo"] = null;
			workDetails[[i+ 1] + "_workYearTo"] = null;
		}
		else
		{
			workDetails[[i+ 1] + "_workMonthTo"] = position.values[i].endDate.month;
			workDetails[[i+ 1] + "_workYearTo"] = position.values[i].endDate.year;
		}
		
		student.workMap = workDetails;
	}
	
}

/* Certifications Info */
if(!(member.certifications == null) )
{
    certificationDetails = member.certifications;
    var certificationCount = certificationDetails._total; 
    var certifications = {};
    for(var i = 0; i < certificationCount; i++) {

        
          
    	   if(typeof certificationDetails.values[i].endDate === "undefined")
        	   {
    		   	    certifications[[i+1] + "_endMonth"] = "";
    		   	    certifications[[i+1] + "_endYear"] = "";   
        	   }
    	   else
        	   {
    		  		certifications[[i+1] + "_endMonth"] = certificationDetails.values[i].endDate.month ;
    		  	    certifications[[i+1] + "_endYear"] = certificationDetails.values[i].endDate.year; 
        	   }

    	   if(!(certificationDetails.values[i].startDate == null))
           {
    	   		certifications[[i+1] + "_startMonth"] = certificationDetails.values[i].startDate.month ;
    	   	    certifications[[i+1] + "_startYear"] = certificationDetails.values[i].startDate.year ;
           }

	  	  
   	   
    	   certifications[[i+ 1] + "_certificateName"] = certificationDetails.values[i].name;
    	   if(!(certificationDetails.values[i].authority == null))
           {
    	   		certifications[[i+ 1] + "_authorityName"] = certificationDetails.values[i].authority.name;
           }
    	   
    	   certifications[[i+ 1] + "_certificateNumber"] = certificationDetails.values[i].number;
    	   
			
			student.certificationsMap = certifications;
    	}  
}


/* Publications Info */
if(!(member.publications == null) )
{ 
      publicationDetails = member.publications;
      var publicationCount = publicationDetails._total;
      var publications = {};
      for(var i = 0; i < publicationCount; i++) {

    	  if(!(publicationDetails.values[i].date ==null))
       	 {
    	 	 var date =  publicationDetails.values[i].date.year + "-" + publicationDetails.values[i].date.month + "-" + publicationDetails.values[i].date.day ; 
         }
    	  publications[[i+ 1] + "_publicationTitle"] = publicationDetails.values[i].title;
    	  publications[[i+ 1] + "_publicationSummary"] = publicationDetails.values[i].summary;
    	  publications[[i+ 1] + "_publicationDate"] = date;
    	  publications[[i+ 1] + "_publicationUrl"] = publicationDetails.values[i].url;
    	  publications[[i+ 1] + "_publisherName"] = publicationDetails.values[i].publisher.name;
          
    	  if(!(publicationDetails.values[i].authors == null))
    		{
		      	var publicationAuthorsCount = publicationDetails.values[i].authors._total;
		      	for(var j = 0; j < publicationAuthorsCount; j++) {

		      		if(!(publicationDetails.values[i].authors.values[j].name == null))
					{
						var name = publicationDetails.values[i].authors.values[j].name;
						var splitName = name.split(' ');
		      			publications[[i+ 1] + "_publisherAuthorFirstName"] = splitName[0];
		      			publications[[i+ 1] + "_publisherAuthorLastName"] = splitName[1];
					}
		      		else
			      	{
						if(!(publicationDetails.values[i].authors.values[j].person.firstName == null))
						{
			      			publications[[i+ 1] + "_publisherAuthorFirstName"] = publicationDetails.values[i].authors.values[j].person.firstName;
						}
	
						if(!(publicationDetails.values[i].authors.values[j].person.lastName == null))
						{
			      			publications[[i+ 1] + "_publisherAuthorLastName"] = publicationDetails.values[i].authors.values[j].person.lastName;
						}
		      		}
		      	}
    		}
      	student.publicationsMap = publications;
      } 
}     

  $.ajax({

	  	type : 'POST',
	 	url : 'candidate_import_data.json',						
		//dataType : 'json',
		cache : false,
		data : JSON.stringify(student),	
		contentType : 'application/json',
		
		success : function(data) {
			location.reload();
		},
		
		error : function(xhr,error) {
			alert("Failed");
		}
	}); 
  
}

function displayProfilesErrors(error) {
console.log(error);
}
