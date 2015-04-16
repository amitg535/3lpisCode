package caerusapp.service.employer;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.common.JobDetailsCom;

public class EmployerInternshipValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return JobDetailsCom.class.equals(clazz);
	}

	@Override
	public void validate(Object command, Errors errors) {
		JobDetailsCom internshipDetailsCom = (JobDetailsCom) command;
		
		if(internshipDetailsCom.getInternshipId() == null || (internshipDetailsCom.getInternshipId() != null && internshipDetailsCom.getInternshipId().trim().length() == 0))
			errors.rejectValue("internshipId","error.employer.jobDetailsCom.internshipId.required","Please Enter Internship Id");
		
		if(internshipDetailsCom.getInternshipType() == null || (internshipDetailsCom.getInternshipType() != null && internshipDetailsCom.getInternshipType().trim().length() == 0))
			errors.rejectValue("internshipType","error.employer.jobDetailsCom.internshipType.required","Please Select Internship Type");
	
		if(internshipDetailsCom.getInternshipTitle() == null || (internshipDetailsCom.getInternshipTitle() != null && internshipDetailsCom.getInternshipTitle().trim().length() == 0))
			errors.rejectValue("internshipTitle","error.employer.jobDetailsCom.internshipTitle.required","Please Enter Internship Title");
		
		if(internshipDetailsCom.getPrimarySkills() == null || (internshipDetailsCom.getPrimarySkills() != null && internshipDetailsCom.getPrimarySkills().size() == 0))
			errors.rejectValue("primarySkills","error.employer.jobDetailsCom.primarySkills.required","Please Enter Primary Skills");
		
		if(internshipDetailsCom.getSecondarySkills() == null || (internshipDetailsCom.getSecondarySkills() != null && internshipDetailsCom.getSecondarySkills().size() ==  0))
			errors.rejectValue("secondarySkills","error.employer.jobDetailsCom.secondarySkills.required","Please Enter Secondary Skills");
		
		if(internshipDetailsCom.getZipCode() == null || (internshipDetailsCom.getZipCode() != null && internshipDetailsCom.getZipCode().trim().length() == 0))
			errors.rejectValue("zipCode","error.employer.jobDetailsCom.zipCode.required","Please Enter ZipCode");
		
		if(internshipDetailsCom.getLocation() == null || (internshipDetailsCom.getLocation() != null && internshipDetailsCom.getLocation().trim().length() == 0))
			errors.rejectValue("location","error.employer.jobDetailsCom.location.required","Please Enter Job Location");
		
		if(internshipDetailsCom.getInternshipDescription() == null || (internshipDetailsCom.getInternshipDescription() != null && internshipDetailsCom.getInternshipDescription().trim().length() == 0))
			errors.rejectValue("internshipDescription","error.employer.jobDetailsCom.internshipDescription.required","Please Enter Internship Description");
	}

}
