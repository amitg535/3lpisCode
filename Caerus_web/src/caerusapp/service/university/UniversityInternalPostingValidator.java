package caerusapp.service.university;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.university.UniversityJobCom;

public class UniversityInternalPostingValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return UniversityJobCom.class.equals(clazz);
	}

	@Override
	public void validate(Object command, Errors errors) {
		UniversityJobCom internshipDetailsCom = (UniversityJobCom) command;
		
		if(internshipDetailsCom.getInternshipId() == null || (internshipDetailsCom.getInternshipId() != null && internshipDetailsCom.getInternshipId().trim().length() == 0))
			errors.rejectValue("internshipId","error.university.UniversityJobCom.internshipId.required","Please Enter Internship Id");
	
		if(internshipDetailsCom.getInternshipType() == null || (internshipDetailsCom.getInternshipType() != null && internshipDetailsCom.getInternshipType().trim().length() == 0))
			errors.rejectValue("internshipType","error.university.UniversityJobCom.internshipType.required","Please Select Internship Type");
		
		if(internshipDetailsCom.getInternshipTitle() == null || (internshipDetailsCom.getInternshipTitle() != null && internshipDetailsCom.getInternshipTitle().trim().length() == 0))
			errors.rejectValue("internshipTitle","error.university.UniversityJobCom.internshipTitle.required","Please Enter Internship Title");
		
		if(internshipDetailsCom.getPrimarySkills() == null || (internshipDetailsCom.getPrimarySkills() != null && internshipDetailsCom.getPrimarySkills().size() == 0))
			errors.rejectValue("primarySkills","error.university.UniversityJobCom.primarySkills.required","Please Enter Primary Skills");
		
		if(internshipDetailsCom.getSecondarySkills() == null || (internshipDetailsCom.getSecondarySkills() != null && internshipDetailsCom.getSecondarySkills().size() == 0))
			errors.rejectValue("secondarySkills","error.university.UniversityJobCom.secondarySkills.required","Please Enter Secondary Skills");
		
		if(internshipDetailsCom.getZipCode() == null || (internshipDetailsCom.getZipCode() != null && internshipDetailsCom.getZipCode().trim().length() == 0))
			errors.rejectValue("zipCode","error.university.UniversityJobCom.zipCode.required","Please Enter ZipCode");
		
		if(internshipDetailsCom.getLocation() == null || (internshipDetailsCom.getLocation() != null && internshipDetailsCom.getLocation().trim().length() == 0))
			errors.rejectValue("location","error.university.UniversityJobCom.location.required","Please Enter Job Location");
		
		if(internshipDetailsCom.getInternshipDescription() == null || (internshipDetailsCom.getInternshipDescription() != null && internshipDetailsCom.getInternshipDescription().trim().length() == 0))
			errors.rejectValue("internshipDescription","error.university.UniversityJobCom.internshipDescription.required","Please Enter Internship Description");
	}

}
