/* add work details and reset the form*/
function resetWorkForm() {
	var workYearFrom = document.getElementById('startYear').value;
	var workYearTo = document.getElementById('endYear').value;
	var workMonthTo = document.getElementById('endMonth').value;
	var workMonthFrom = document.getElementById('startMonth').value;
	var workCompanyName = document.getElementById('companyName').value;
	var workDescription = document.getElementById('workDesc').value;
	var workDesignation = document.getElementById('designation').value;
	var d = new Date();

	if (workYearTo == "") {
		workYearTo = d.getFullYear();
	}

	if (workMonthTo == "") {
		workMonthTo = d.getMonth() + 1;
	}

	$.ajax({

				type : 'POST',
				url : 'candidate_portfolio_Work.json',
				cache : false,
				data : {
					workCompanyName : workCompanyName,
					workDescription : workDescription,
					workDesignation : workDesignation,
					workMonthFrom : workMonthFrom,
					workYearFrom : workYearFrom,
					workMonthTo : workMonthTo,
					workYearTo : workYearTo
				},
				success : function(data) {

					if (data.length > 0) {
						$
								.each(
										data,
										function(i, item) {

											if (item == "workCompanyName") {
												$("#errorCompanyName").html(
														'Enter Company Name');
											}
											if (item == "workDescription") {
												$("#errorWorkDescription")
														.html(
																'Enter Work Description');
											}
											if (item == "workDesignation") {
												$("#errorWorkDesignation")
														.html(
																'Enter Work Designation');
											}

											if (item == "workYearFrom") {
												$("#errorDurationWork")
														.html(
																'Work from year cannot be greater than work to year');
											}
											if (item == "workYearTo") {
												$("#errorDurationWork")
														.html(
																'Work from year should be minimum 15 years from Date of Birth');
											}
											if (item == "workMonthTo") {
												$("#errorDurationWork")
														.html(
																"Cant be Working with two organizations at Once.Please check your previous Employments");
											}

										});
					}

					else {
						// An array starts with the index 0, so you could do
						// minus 1 to get the correct one
						var data = new Array("January", "February", "March",
								"April", "May", "June", "July", "August",
								"September", "October", "November", "December");
						workMonthFrom = (data[workMonthFrom - 1]);
						workMonthTo = (data[workMonthTo - 1]);

						$("#errorCompanyName").html('');
						$("#errorWorkDescription").html('');
						$("#errorWorkDesignation").html('');
						$("#errorDurationWork").html('');

						if (!(workYearTo == null)) {
							$(
									"#workDisplay .right_detailswrap .topborder_lists")
									.append(
											'<li class="hover" onclick="fillWorkDetails(this.id)">'
													+ '<div class="floatleft">'
													+ '<div class="orangetxt12"><span class="companyname">'
													+ workCompanyName
													+ '</span>'
													+ '(<span>'
													+ workDesignation
													+ '</span>)</div>'
													+ '<div class="greytxt_nomargin"><span>'
													+ workDescription
													+ '</span></div>'
													+ '<div class="floatright">'
													+ '<div class="orangetxt12 floatright"><span>'
													+ workMonthFrom
													+ ' '
													+ workYearFrom
													+ ' - '
													+ workMonthTo
													+ ' '
													+ workYearTo
													+ '</span></div></div></li>');

						} else {
							$(
									"#workDisplay .right_detailswrap .topborder_lists")
									.append(
											'<li class="hover" onclick="fillWorkDetails(this.id)">'
													+ '<div class="floatleft">'
													+ '<div class="orangetxt12"><span class="companyname">'
													+ workCompanyName
													+ '</span>'
													+ '(<span>'
													+ workDesignation
													+ '</span>)</div>'
													+ '<div class="greytxt_nomargin"><span>'
													+ workDescription
													+ '</span></div>'
													+ '<div class="floatright">'
													+ '<div class="orangetxt12 floatright"><span>'
													+ workMonthFrom
													+ ' '
													+ workYearFrom
													+ ' - '
													+ workMonthTo
													+ ' - Currently Working</span></div></div></li>');
						}

						$(".topborder_lists li ").attr('id', function(i) {
							$(this).attr('id', "list" + i);
						});

						$(".topborder_lists li div span").attr('id',
								function(i) {
									$(this).attr('id', "listDetails" + i);
								});

						document.getElementById('companyName').value = "";
						document.getElementById('workDesc').value = "";
						document.getElementById('designation').value = "";
						document.getElementById('startMonth').value = "1";
						document.getElementById('startYear').value = "2014";
						document.getElementById('endMonth').value = "1";
						document.getElementById('endYear').value = "2014";

						$("#endWorkDuration").show();
						$("#present").hide();
						document.getElementById("currentCheckbox").checked = false;

					}

				},

				error : function(xhr, error) {
					alert("Failed");
				}
			});

}

/* add certification details and reset the form */
function resetCertificationForm() {
	var certificateName = $(".topborder_lists li div span.certificateName");

	var i;
	var certificateNameArray = new Array();

	for (i = 0; i < certificateName.length; ++i) {
		certificateNameArray.push(certificateName[i].innerText);
	}

	$("#errorCertificateName").html('');
	$("#errorCertificateAuthority").html('');
	$("#errorCertificateNumber").html('');
	$("#errorCertificateDuration").html('');

	var certificateName = $('#certificateName').val();
	var certificateNumber = $('#certificateNumber').val();
	var certificateAuthority = $('#certificateAuthority').val();
	var certificationStartMonth = $("#certificationStartMoth").val();
	var certificationStartYear = $("#certificationStartYear").val();
	var certificationEndMonth = $("#certificationEndMonth").val();
	var certificationEndYear = $("#certificationEndYear").val();

	var exists = 0;
	var i;
	for (i = 0; i < certificateNameArray.length; ++i) {

		if (certificateNameArray[i] == certificateName)
			exists += 1;
	}

	if (exists) {
		$("#errorCertificateName").html('Certificate name already exists');
	}

	else {
		$
				.ajax({

					type : 'POST',
					url : 'candidate_certification_details.json',
					cache : false,
					data : {
						certificateName : certificateName,
						certificateNumber : certificateNumber,
						certificateAuthority : certificateAuthority,
						certificationStartMonth : certificationStartMonth,
						certificationStartYear : certificationStartYear,
						certificationEndMonth : certificationEndMonth,
						certificationEndYear : certificationEndYear
					},
					success : function(data) {
						if (data.length > 0) {
							$
									.each(
											data,
											function(i, item) {

												if (item == "certificateName") {
													$("#errorCertificateName")
															.html(
																	'Enter certificate Name');
												}
												if (item == "certificateAuthority") {
													$(
															"#errorCertificateAuthority")
															.html(
																	'Enter Certificate Authority Name');
												}
												if (item == "certificateNumber") {
													$("#errorCertificateNumber")
															.html(
																	'Enter Certificate Number');
												}

												if (item == "certificationStartYear") {
													$(
															"#errorCertificateDuration")
															.html(
																	'Certification from year cannot be greater than certification to year ');
												}

											});
						}

						else {
							// An array starts with the index 0, so you could do
							// minus 1 to get the correct one
							var data = new Array("January", "February",
									"March", "April", "May", "June", "July",
									"August", "September", "October",
									"November", "December");
							certificationStartMonth = (data[certificationStartMonth - 1]);
							certificationEndMonth = (data[certificationEndMonth - 1]);

							$("#errorCertificateName").html('');
							$("#errorCertificateAuthority").html('');
							$("#errorCertificateNumber").html('');
							$("#errorCertificateDuration").html('');

							if (!(certificationEndYear == null)) {
								$(
										"#certificateDisplay .right_detailswrap .topborder_lists")
										.append(
												'<li class="hover" onclick="fillCertificateDetails(this.id)">'
														+ '<div class="floatleft"><div class="greytxt_nomargin"><span class="certificateName">'
														+ certificateName
														+ '</span></div><div class="orangetxt12"><span>'
														+ certificateNumber
														+ '</span></div></div>'
														+ '<div class="floatright"><div class="dark_greytitle" style="text-align:right "><span>'
														+ certificateAuthority
														+ '</span></div>'
														+ '<div class="orangetxt12 floatright"><span>'
														+ certificationStartMonth
														+ ' '
														+ certificationStartYear
														+ ' - '
														+ certificationEndMonth
														+ ' '
														+ certificationEndYear
														+ '</span></div></div></li>');

							} else {
								$(
										"#certificateDisplay .right_detailswrap .topborder_lists")
										.append(
												'<li class="hover" onclick="fillCertificateDetails(this.id)">'
														+ '<div class="floatleft"><div class="greytxt_nomargin"><span class="certificateName">'
														+ certificateName
														+ '</span></div><div class="orangetxt12"><span>'
														+ certificateNumber
														+ '</span></div></div>'
														+ '<div class="floatright"><div class="dark_greytitle" style="text-align:right "><span>'
														+ certificateAuthority
														+ '</span></div>'
														+ '<div class="orangetxt12 floatright"><span>'
														+ certificationStartMonth
														+ ' '
														+ certificationStartYear
														+ ' - Certificate Does Not Expire </span></div></div></li>');
							}

							$(".topborder_lists li ").attr('id', function(i) {
								$(this).attr('id', "list" + i);
							});

							$(".topborder_lists li div span").attr('id',
									function(i) {
										$(this).attr('id', "listDetails" + i);
									});

							$('#certificateName').val('');
							$('#certificateNumber').val('');
							$('#certificateAuthority').val('');
							$("#certificationStartMoth").val("1");
							$("#certificationStartYear").val("2014");
							$("#certificationEndMonth").val("1");
							$("#certificationEndYear").val("2014");
						}

					},

					error : function(xhr, error) {
						alert("Failed");
					}
				});
	}
}

/* add publication details and reset the form */
function resetPublicationForm() {
	var publicationTitle = $(".topborder_lists li div span.publicationTitle");

	var i;
	var publicationTitleArray = new Array();

	for (i = 0; i < publicationTitle.length; ++i) {
		publicationTitleArray.push(publicationTitle[i].innerText);
	}

	$("#errorPublicationTitle").html('');
	$("#errorPublisherAuthorFirstName").html('');
	$("#errorPublicationUrl").html('');
	$("#errorPublisherName").html('');
	$("#errorPublicationSummary").html('');
	$("#errorPublicationDate").html('');
	$("#errorPublisherAuthorLastName").html('');

	var publicationTitle = $("#publicationTitle").val();
	var publisherAuthorFirstName = $("#publisherAuthorFirstName").val();
	var publicationUrl = $("#publicationUrl").val();
	var publisherName = $("#publisherName").val();
	var publicationSummary = $("#publicationSummary").val();
	var publicationDate = $("#publicationDate").val();
	var publisherAuthorLastName = $("#publisherAuthorLastName").val();

	var exists = 0;
	var i;
	for (i = 0; i < publicationTitleArray.length; ++i) {

		if (publicationTitleArray[i] == publicationTitle)
			;
		exists += 1;
	}

	if (exists) {
		$("#errorPublicationTitle").html('Publication title already exists');
	}

	else {
		$
				.ajax({

					type : 'POST',
					url : 'candidate_publication_details.json',
					cache : false,
					data : {
						publicationTitle : publicationTitle,
						publisherAuthorFirstName : publisherAuthorFirstName,
						publicationUrl : publicationUrl,
						publisherName : publisherName,
						publicationSummary : publicationSummary,
						publicationDate : publicationDate,
						publisherAuthorLastName : publisherAuthorLastName
					},
					success : function(data) {
						if (data.length > 0) {
							$
									.each(
											data,
											function(i, item) {

												if (item == "publicationTitle") {
													$("#errorPublicationTitle")
															.html(
																	'Enter Publication Title Name');
												}
												if (item == "publisherAuthorFirstName") {
													$(
															"#errorPublisherAuthorFirstName")
															.html(
																	'Enter Publication Author First Name');
												}
												if (item == "publicationUrl") {
													$("#errorPublicationUrl")
															.html(
																	'Enter Publication Url');
												}

												if (item == "publisherName") {
													$("#errorPublisherName")
															.html(
																	'Enter Publisher Name ');
												}

												if (item == "publicationSummary") {
													$(
															"#errorPublicationSummary")
															.html(
																	'Enter Publication Summary ');
												}
												if (item == "publicationDate") {
													$("#errorPublicationDate")
															.html(
																	'Enter Publication Date ');
												}
												if (item == "publisherAuthorLastName") {
													$(
															"#errorPublisherAuthorLastName")
															.html(
																	'Enter Publication Author Last Name ');
												}

											});
						}

						else {

							$("#errorPublicationTitle").html('');
							$("#errorPublisherAuthorFirstName").html('');
							$("#errorPublicationUrl").html('');
							$("#errorPublisherName").html('');
							$("#errorPublicationSummary").html('');
							$("#errorPublicationDate").html('');
							$("#errorPublisherAuthorLastName").html('');

							$(
									"#publicationDisplay .right_detailswrap .topborder_lists")
									.append(
											'<li class="hover" onclick="fillPublicationDetails(this.id)">'
													+ '<div class="floatleft"><div class="greytxt_nomargin"><span class="publicationTitle">'
													+ publicationTitle
													+ '</span>( <a href="http://'
													+ publicationUrl
													+ '"target="_blank"><span>'
													+ publicationUrl
													+ '</span></a> )</div>'
													+ '<div class="orangetxt12"><span>'
													+ publisherName
													+ '</span></div><div class="greytxt_nomargin"><span>'
													+ publicationSummary
													+ '</span></div></div>'
													+ '<div class="floatright"><div class="dark_greytitle"><span>'
													+ publisherAuthorFirstName
													+ '</span><span> '
													+ publisherAuthorLastName
													+ '</span></div>'
													+ '<div class="orangetxt12"><span>'
													+ publicationDate
													+ '</span></div></div></li>');

							$(".topborder_lists li ").attr('id', function(i) {
								$(this).attr('id', "list" + i);
							});

							$(".topborder_lists li div span").attr('id',
									function(i) {
										$(this).attr('id', "listDetails" + i);
									});

							$('#publicationTitle').val('');
							$('#publisherAuthorFirstName').val('');
							$('#publicationUrl').val('');
							$("#publisherName").val('');
							$("#publicationSummary").val('');
							$("#publicationDate").val('');
							$("#publisherAuthorLastName").val('');

						}

					},

					error : function(xhr, error) {
						alert("Failed");
					}
				});
	}
	;
}

/* add current month and year if presently working is selected */
function callPresentlyWorking() {
	document.getElementById('endYear').value = "";
	document.getElementById('endMonth').value = "";

	var checked = $("#currentCheckbox").is(":checked");
	if (checked == true) {

		var currentMonth = new Date().getMonth();
		var currentYear = new Date().getYear();

		// An array starts with the index 0, so you could do minus 1 to get the
		// correct one
		var data = new Array("January", "February", "March", "April", "May",
				"June", "July", "August", "September", "October", "November",
				"December");

		$("#endWorkDuration").hide();
		$("#present").empty().append(
				data[+currentMonth] + "    " + new Date().getFullYear());
		$("#present").show();

	}

	if (checked == false) {
		$("#endWorkDuration").show();
		$("#present").hide();
	}

}

/* set certificate duration to no expiry */
function callCertificateNoExpiry() {
	document.getElementById('certificationEndYear').value = "";
	document.getElementById('certificationEndMonth').value = "";

	var checked = $("#certificationCheckbox").is(":checked");
	if (checked == true) {
		$("#certificate").hide();
	}

	if (checked == false) {
		$("#certificate").show();
	}
}

/* add interest details */
function addInterests() {
	var inputVal1 = $("#tags").val();

	if (inputVal1 == "") {
		$("#spn2").remove();
		$("#tags_tagsinput")
				.after(
						'<span id="spn2"  style="color: #f00  font-size: 11px ">Enter atleast 1 Hobby</span>');
	}

	if (inputVal1 != "") {
		$("#spn2").remove();
		$("#tags_tagsinput").after('<span class="error">  </span>');

		var student = new Object();

		interestDetails = document.getElementById("tags").value;

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

			},

			error : function(xhr, error) {
				alert("Failed");
			}
		});
	}
}

function hideEmptyLanguage() {
	$("#emptyLanguage").empty();
}

/* delete language added by candidate */
function deleteLanguage(elementId) {
	var student = new Object();

	var aId = $('#' + elementId).parent().attr('id');

	var liText = $('#' + aId).text();

	var language = liText.replace(/[\s\n\r]+/g, '');

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

		error : function(xhr, error) {
			alert("Failed");
		}

	});

}

/* add language known by candidate */
function addLanguage() {
	var student = new Object();

	var language = document.getElementById("languagesList").value;

	if (language == "" || $.trim(language) == "") {
		$("#emptyLanguage").html('Enter a Language');
	}

	if (!(language == "" || $.trim(language) == "")) {
		$("#languagesKnown").show();
		$("#languagesDisplay .recent_activities_wrap")
				.append(
						'<li>'
								+ language
								+ '<a class="floatright " style="display:inline-block " onclick="deleteLanguage(this.id)"><img src="images/list_cross_icn.png" ></a></li>');

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

			error : function(xhr, error) {
				alert("Failed");
			}

		});
	}

}

/* fill the form with selected work details */
function fillWorkDetails(elementId) {

	$("#addMoreWorkBtn").hide();
	$("#updateWorkDetailsBtn").show();
	
	var children = $('#' + elementId).find('div span');

	var i;
	var array = new Array();

	for (i = 0; i < children.length; ++i) {
		array.push(children[i].innerText);
	}

	$("#companyName").val(array[0]);
	$("#designation").val(array[1]);
	$("#workDesc").val(array[2]);

	var splitArray = array[3].split(' ');

	$("#startMonth").val(new Date(splitArray[0] + " 1, 2000").getMonth() + 1);
	$("#startYear").val(splitArray[1]);

	if (splitArray[3] == "Currently") {
		$("#endWorkDuration").hide();
		$('#currentCheckbox').prop('checked', true);
	}

	else {
		$("#endWorkDuration").show();
		$("#endMonth").val(new Date(splitArray[3] + " 1, 2000").getMonth() + 1);
		$("#endYear").val(splitArray[4]);
	}

}

/* fill the form with selected certification details */
function fillCertificateDetails(elementId) {
	$("#errorCertificateName").html('');
	$("#errorCertificateAuthority").html('');
	$("#errorCertificateNumber").html('');
	$("#errorCertificateDuration").html('');

	var children = $('#' + elementId).find('div span');

	var i;
	var array = new Array();

	for (i = 0; i < children.length; ++i) {
		array.push(children[i].innerText);
	}

	$("#certificateName").val(array[0]);
	$("#certificateNumber").val(array[1]);
	$("#certificateAuthority").val(array[2]);

	var splitArray = array[3].split(' ');

	$("#certificationStartMoth").val(
			new Date(splitArray[0] + " 1, 2000").getMonth() + 1);
	$("#certificationStartYear").val(splitArray[1]);

	if (splitArray[3] == "Certificate") {
		$("#certificate").hide();
		$('#certificationCheckbox').prop('checked', true);
	}

	else {
		$("#certificate").show();
		$("#certificationEndMonth").val(
				new Date(splitArray[3] + " 1, 2000").getMonth() + 1);
		$("#certificationEndYear").val(splitArray[4]);
	}

}

/* fill the form with selected publication details */
function fillPublicationDetails(elementId) {

	$("#errorPublicationTitle").html('');
	$("#errorPublisherAuthorFirstName").html('');
	$("#errorPublicationUrl").html('');
	$("#errorPublisherName").html('');
	$("#errorPublicationSummary").html('');
	$("#errorPublicationDate").html('');
	$("#errorPublisherAuthorLastName").html('');

	var children = $('#' + elementId).find('div span');

	var i;
	var array = new Array();

	for (i = 0; i < children.length; ++i) {
		array.push(children[i].innerText);
	}

	$("#publicationTitle").val(array[0]);
	$("#publicationUrl").val(array[1]);
	$("#publisherName").val(array[2]);
	$("#publicationSummary").val(array[3]);
	$("#publisherAuthorFirstName").val(array[4]);
	$("#publisherAuthorLastName").val(array[5]);
	$("#publicationDate").val(array[6]);

}

/* validate the introductory section of the page */
function validateIntro() {
	var formValue = document.getElementById("intro");
	formValue.action = 'candidate_portfolio_introductory.htm';

	var firstName = $("#firstName").val();
	var lastName = $("#lastName").val();
	var zipcode = $("#zipCode").val();
	var n = zipcode.length;
	var dob = document.getElementById("datepicker").value;
	
	var regExp = /^(\([0-9]{3}\)\s?|[0-9]{3}-)[0-9]{3}-[0-9]{4}$/;
	var zipRegex = /^\\d{5}(-\\d{4})?$/;
	
	var returnVar = true;
	
	var testPhoneNumber = $("#mobileNumber").val(); 
	if(! regExp.test(testPhoneNumber) ){
		$("#phoneNumberErrorMessage").empty().append("Please Enter a Valid Phone Number. e.g:123-345-3456 or (078)789-8908");
		return false;
	}
	
	/*if( ! zipRegex.test(zipcode)){
		$("#errorZipCode").html('Enter Zip Code (5 digits)');
		return false;
	}*/
	
	if (isNaN(zipcode)) {
		$("#errorZipCode").html('Zip Code should only contain Numbers');
	}
	
	   $.ajax({
	        url: 'get_city_name.htm',
	        data : {
				'zipCode' : zipcode
			},
	        cache : false,
	        async : false,
	   	    success: function(cityName) {
	   	    	if(cityName == " ()"){
	   	   	    		$("#errorZipCode").html("Please Enter Valid Zip Code");
	   	   	    	returnVar = false;
	   	   	    }
	        }
	    });
	
	if(returnVar === false)
		return returnVar;
	
	
	var checked_option_radio = null;
	if ($(".r1").checked) {
		checked_option_radio = document.getElementById('r1').value;
	}
	if ($(".r2").checked) {
		checked_option_radio = document.getElementById('r2').value;
	}

	if (firstName == "" || $.trim(firstName) == "") {
		$("#emptyFirstName").html('Enter First Name');
	}

	if (lastName == "" || $.trim(lastName) == "") {
		$("#emptyLastName").html('Enter Last Name');
	}

	if (dob == "") {
		$("#emptyDOB").html('Enter Date Of Birth');
	}

	if (typeof checked_option_radio === "undefined") {
		$("#emptyGender").html('Please select your Gender');
	}

	if (!(typeof checked_option_radio === "undefined")) {
		$("#emptyGender").empty();
	}

	if (!(zipcode == "" || $.trim(zipcode) == "" || n != 5 || isNaN(zipcode)
			|| firstName == "" || $.trim(firstName) == "" || lastName == ""
			|| $.trim(lastName) == "" || dob == "" || typeof checked_option_radio === "undefined")) {
		$("#emptyFirstName").empty();
		$("#emptyLastName").empty();
		$("#emptyGender").empty();
		$("#emptyDOB").empty();
		$("#errorZipCode").empty();
		formValue.submit();
	}
}

/* validate the skills section of the page */
function validateSkills() {
	var formValue = document.getElementById("skillForm");
	formValue.action = 'candidate_portfolio_profile.htm';

	var inputVal = $("#primarySkills").val();

	if (inputVal == "") {

		$("#spn1").remove();
		$("#primarySkills_tagsinput")
				.after(
						'<span id="spn1" style="color: #f00  font-size: 11px ">Enter atleast 1 Primary skill</span>');

	}
	if (inputVal != "") {

		$("#spn1").remove();
		$("#primarySkills_tagsinput").after(
				'<span class="important">    </span>');

	}

	var inputVal1 = $("#tags1").val();

	if (inputVal1 == "") {

		$("#spn2").remove();
		$("#tags1_tagsinput")
				.after(
						'<span id="spn2"  style="color: #f00  font-size: 11px ">Enter atleast 1 Secondary skill</span>');

	}
	if (inputVal1 != "") {
		$("#spn2").remove();
		$("#tags1_tagsinput").after('<span class="error">  </span>');

	}

	if ($('#skillForm').valid()) {

		if (inputVal != "" && inputVal1 != "") {

			formValue.submit();
		}
	}

}

/* validate the education section of the page */

/* upload resume via ajax call */
function checkResumeFile() {
	var isValidFile = false;
	var ext = $('#fileResume').val().split('.').pop().toLowerCase();
	// If the extension of the uploaded file is among the ones listed below then
	// upload
	if ($.inArray(ext, [ 'pdf', 'doc', 'docx', 'rtf', 'txt' ]) != -1) {
		isValidFile = true;
	}

	if (isValidFile !== false) {
		var resumeFile = new FormData();
		resumeFile.append("fileResume", fileResume.files[0]);

		var client = new XMLHttpRequest();
		client.open("post", "candidate_upload_resume.htm", false);
		client.send(resumeFile);

		$("#successResumeUpload").empty().append("Resume Successfully Uploaded");
		$("#resumeUploaded").empty().append('Current uploaded Resume is ' + fileResume.files[0].name);
		$("#emptyResume").empty();
		return true;

	} else {
		$("#emptyResume").empty().append('Invalid File.Please upload a CV');
	}
}

/* upload video */
function checkUploadedVideo() {
	var formValue = document.getElementById("videoForm");
	formValue.action = 'candidate_upload_video.htm';

	var videoFile = document.getElementById("videoFile").value;

	if (videoFile == "") {
		$("#emptyVideo").html('Choose a File');
	} else {
		formValue.submit();
	}
}

// code to check if introductory and education section are empty
/*
 * function checkEmpty(studentEmailId) { var formValue =
 * document.getElementById("previewForm") ;
 * formValue.action='candidate_detail_view.htm?studentEmailId='+studentEmailId;
 * 
 * var firstName = $("#firstName").val() ; var lastName = $("#lastName").val() ;
 * var zipCode = $("#zipCode").val() ; var dob =
 * document.getElementById("datepicker").value ; var checked_option_radio = null ;
 * if ($(".r1").checked) { checked_option_radio =
 * document.getElementById('r1').value ; } if ($(".r2").checked) {
 * checked_option_radio = document.getElementById('r2').value ; } //var
 * checked_option_radio = $('input:radio[name=radiofield]:checked').val() ;
 * 
 * var schoolName = $("#schoolName").val() ; //var h_from_gpa =
 * $("#h_from_gpa").val() ; //var h_to_gpa = $("#h_to_gpa").val() ; //var
 * g_from_gpa = $("#g_from_gpa").val() ; //var g_to_gpa = $("#g_to_gpa").val() ;
 * //var coursedrop = $("#coursedrop").val(); //var Univdrop =
 * $("#Univdrop").val() ; //var courseNameDrop = $("#courseNameDrop").val() ;
 * 
 * 
 * if(typeof checked_option_radio === "undefined" || dob === "" || firstName === "" ||
 * lastName === "" || zipCode === "" || schoolName === "" || coursedrop === "" ||
 * Univdrop === "" || courseNameDrop === "") { alert("Please fill the
 * Introductory and Education Section") ; }
 * 
 * else { formValue.submit() ; } }
 */

/* add school education and reset form */
function resetSchoolForm() {

	var schoolName1 = document.getElementById("schoolName").value;
	var schoolState = document.getElementById("schoolState").value;
	var schoolGpaFrom = document.getElementById("schoolGpaFrom").value;
	var schoolGpaTo = document.getElementById("schoolGpaTo").value;
	var schoolPassingYear = document.getElementById("schoolPassingYear").value;
	var schoolPassingMonth = document.getElementById("schoolPassingMonth").value;

	$.ajax({

		type : 'POST',
		url : 'candidate_portfolio_School.json',
		cache : false,
		data : {
			schoolName : schoolName1,
			schoolState : schoolState,
			schoolGpaFrom : schoolGpaFrom,
			schoolGpaTo : schoolGpaTo,
			schoolPassingYear : schoolPassingYear,
			schoolPassingMonth : schoolPassingMonth

		},
		success : function(data) {

			if (data.length > 0) {
				$.each(data, function(i, item) {

					if (item.search("School Name") != -1) {
						$("#errorSchoolName").html(item);
					}
					if (item.search("School State") != -1) {
						$("#errorSchoolState").html(item);
					}
					if (item.search("GPA") != -1) {
						$("#errorSchoolGpa").html(item);
					}

					if ((item.search("School Passing Month") != -1)
							|| (item.search("School Passing Year") != -1)) {
						$("#errorSchoolDuration").html(item);
					}
				});
			}

			else {
				window.location.reload();
			}
		},

		error : function(xhr, error) {
			alert("Failed");
		}
	});

}

/* fill the form with selected school details */
function fillSchoolDetails(elementId) {
	var children = $('#' + elementId).find('div span');

	var i;
	var array = new Array();

	for (i = 0; i < children.length; ++i) {
		array.push(children[i].innerText);
	}

	$("#schoolName").val(array[0]);
	$("#schoolState").val(array[1]);

	var splitArrayGpa = array[2].split('/');

	$("#schoolGpaFrom").val(splitArrayGpa[0]);
	$("#schoolGpaTo").val(splitArrayGpa[1]);

	var splitArrayLoc = array[3].split(' ');

	$("#schoolPassingMonth").val(
			new Date(splitArrayLoc[0] + " 1, 2000").getMonth() + 1);
	$('#schoolPassingYear').val(splitArrayLoc[1]);

}

/* add university education and reset form */
function resetUniversityForm() {

	var universityName = document.getElementById("Univdrop").value;
	var universityGpaFrom = document.getElementById("universityGpaFrom").value;
	var universityGpaTo = document.getElementById("universityGpaTo").value;
	var universityYearFrom = document.getElementById("universityYearFrom").value;
	var universityYearTo = document.getElementById("universityYearTo").value;
	var universityMonthFrom = document.getElementById("universityMonthFrom").value;
	var universityMonthTo = document.getElementById("universityMonthTo").value;
	var universityCourseType = document.getElementById("coursedrop").value;

	var universityCourseName = document.getElementById("courseNameDrop").value;

			$.ajax({
				type : 'POST',
				url : 'candidate_portfolio_University.json',
				cache : false,
				data : {
					universityName : universityName,
					universityGpaFrom : universityGpaFrom,
					universityGpaTo : universityGpaTo,
					universityYearFrom : universityYearFrom,
					universityYearTo : universityYearTo,
					universityMonthFrom : universityMonthFrom,
					universityMonthTo : universityMonthTo,
					universityCourseType : universityCourseType,
					universityCourseName : universityCourseName

				},
				success : function(data) {

					if (data.length > 0) {
						$.each(data, function(i, item) {

							if (item.search("Course Type") != -1) {
								$("#errorUniversityCourseType").html(item);
							}

							if (item.search("Course Name") != -1) {
								$("#errorUniversityCourseName").html(item);
							}

							if (item.search("University Name") != -1) {
								$("#errorUniversityName").html(item);
							}

							if (item.search("GPA") != -1) {
								$("#errorGpaGraduation").html(item);
							}

							if (item.search("Year To") != -1) {
								$("#errorGraduationDuration").html(item);
							}
							if (item.search("Invalid") != -1) {
								$("#errorGraduationDuration").html(item);
							}
						});
					}

					else {

						var data = new Array("January", "February", "March",
								"April", "May", "June", "July", "August",
								"September", "October", "November", "December");
						universityMonthFrom = (data[universityMonthFrom - 1]);
						universityMonthTo = (data[universityMonthTo - 1]);
						$("#errorUniversityName").html('');
						$("#errorGpaGraduation").html('');
						$("#errorGraduationDuration").html('');
						$("#errorUniversityCourseType").html('');
						$("#errorUniversityCourseName").html('');
						// $("#errorSchoolDuration").html('') ;

						$(
								"#universityDisplay .right_detailswrap .topborder_lists")
								.append(
										'<li class="hover" onclick="fillUniversityDetails(this.id)">'
												+ '<div class="floatleft">'
												+ '<div class="orangetxt12"><span class="universityname">'
												+ universityName
												+ '</span>'
												+'</div>'
												+'<div class="greytxt_nomargin">'
												+ '(<span class="universitygpa">'
												+ universityCourseType
												+ " "
												+ universityCourseName
												+ '</span>)</div>'
												+ '<div class="greytxt_nomargin"><span class="universitygpa">'
												+ universityGpaFrom
												+ "/"
												+ universityGpaTo
												+ '</span></div></div>'
												+ '<div class="floatright">'
												+ '<div class="orangetxt12"><span>'
												+ universityMonthFrom
												+ ' '
												+ universityYearFrom
												+ ' to '
												+ universityMonthTo
												+ ' '
												+ universityYearTo
												+ '</span></div></div></li>');

						$("#universityGpaFrom").val('');
						$("#universityGpaTo").val('');
						$("#universityMonthFrom").val("1");
						$("#universityYearFrom").val("2014");
						$("#universityMonthTo").val("1");
						$("#universityYearTo").val("2014");
						// $("#coursedrop").options[0].selected = true ;
						// $("#courseNameDrop option:first").attr("selected",
						// true) ;
						// $("#Univdrop").options[0].selected = true ;
					}
				},

				error : function(xhr, error) {
					// alert("Failed") ;
				}
			});
}

/* fill the form with selected university details */
function fillUniversityDetails(elementId) {

	var children = $('#' + elementId).find('div span');

	var i;
	var array = new Array();

	for (i = 0; i < children.length; ++i) {
		array.push(children[i].innerText);
	}

	// $("#Univdrop").val(array[0]) ;
	// $("#Univdrop option:first").attr("selected", true);
	var univDropdown = document.getElementById("Univdrop");
	univDropdown.value = array[0].toString();
	//alert("Univ Name " + array[0]);

	//alert("Course " + array[1].toString());

	var arrayString = array[1].toString().trim();

	var courseType = arrayString.substring(0, arrayString.indexOf(' '));
	var courseName = arrayString.substring(arrayString.indexOf(' '),
			arrayString.length);

//	alert("Course Name + Course type " + arrayString);

	// var courseDetailsArray = array[1].split(' ');

	/* alert("Complete Array "+courseDetailsArray); */
	/*
	 * $("#courseNameDrop").val(courseDetailsArray[0]);
	 * $("#coursedrop").val(courseDetailsArray[1]) ;
	 */

/*	alert("course Name" + courseName.toString() + "course type"
			+ courseType.toString());*/

	$("#courseNameDrop").val(courseName.toString());
	$("#universityCourseType").val(courseType.toString());

	var splitArrayGpa = array[2].split('/');

	$("#universityGpaFrom").val(splitArrayGpa[0]);
	$("#universityGpaTo").val(splitArrayGpa[1]);

	var splitArrayDuration = array[3].split('to');
	var splitArrayStart = splitArrayDuration[0].split(' ');
	var splitArrayEnd = splitArrayDuration[1].split(' ');

	$("#universityMonthFrom").val(
			new Date(splitArrayStart[0] + " 1, 2000").getMonth() + 1);
	$('#universityYearFrom').val(splitArrayStart[1]);

	$("#universityMonthTo").val(
			new Date(splitArrayEnd[1] + " 1, 2000").getMonth() + 1);
	$('#universityYearTo').val(splitArrayEnd[2]);

}