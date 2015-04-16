package caerusapp.service.employer;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.common.JobDetailsCom;

public class EmployerCampusJobValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return JobDetailsCom.class.equals(clazz);
	}

	@Override
	public void validate(Object command, Errors errors) {
		JobDetailsCom jobDetailsCom = (JobDetailsCom) command;
		
		if(jobDetailsCom.getJobId() == null || (jobDetailsCom.getJobId() != null && jobDetailsCom.getJobId().trim().length() == 0))
			errors.rejectValue("jobId","error.employer.jobDetailsCom.jobId.required","Please Enter Job Id");
	
		if(jobDetailsCom.getJobTitle() == null || (jobDetailsCom.getJobTitle() != null && jobDetailsCom.getJobTitle().trim().length() == 0))
			errors.rejectValue("jobTitle","error.employer.jobDetailsCom.jobTitle.required","Please Enter Job Title");
		
		if(jobDetailsCom.getPrimarySkills() == null || (jobDetailsCom.getPrimarySkills() != null && jobDetailsCom.getPrimarySkills().size() == 0 ))
			errors.rejectValue("primarySkills","error.employer.jobDetailsCom.primarySkills.required","Please Enter Primary Skills");
		
		if(jobDetailsCom.getSecondarySkills() == null || (jobDetailsCom.getSecondarySkills() != null && jobDetailsCom.getSecondarySkills().size() == 0 ))
			errors.rejectValue("secondarySkills","error.employer.jobDetailsCom.secondarySkills.required","Please Enter Secondary Skills");

		if(jobDetailsCom.getZipCode() == null || (jobDetailsCom.getZipCode() != null && jobDetailsCom.getZipCode().trim().length() == 0))
			errors.rejectValue("zipCode","error.employer.jobDetailsCom.zipCode.required","Please Enter ZipCode");
		
		if(jobDetailsCom.getLocation() == null || (jobDetailsCom.getLocation() != null && jobDetailsCom.getLocation().trim().length() == 0))
			errors.rejectValue("location","error.employer.jobDetailsCom.location.required","Please Enter Job Location");
		
		if(jobDetailsCom.getJobDescription() == null || (jobDetailsCom.getJobDescription() != null && jobDetailsCom.getJobDescription().trim().length() == 0))
			errors.rejectValue("jobDescription","error.employer.jobDetailsCom.jobDescription.required","Please Enter Job Description");
		
		if(jobDetailsCom.getCampusJobRecipients() == null || (jobDetailsCom.getCampusJobRecipients() != null && jobDetailsCom.getCampusJobRecipients().get(0).trim().length() == 0))
			errors.rejectValue("campusJobRecipients","error.employer.jobDetailsCom.campusJobRecipients.required","Please Select Recipients");
		
	}

}
