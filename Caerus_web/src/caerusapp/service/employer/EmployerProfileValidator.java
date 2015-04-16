package caerusapp.service.employer;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.employer.EmployerCom;

public class EmployerProfileValidator implements Validator {

	@Override
	public boolean supports(Class<?> class1) {
		return EmployerCom.class.equals(class1);
	}

	@Override
	public void validate(Object command, Errors errors) {
		EmployerCom employerDetails = (EmployerCom) command;
		
		if(employerDetails.getCompanyName() == null || employerDetails.getCompanyName().length() == 0)
			errors.rejectValue("companyName", "Empty Value", "Please Enter Company Name");
		
		if(employerDetails.getAddressLine1() == null || employerDetails.getAddressLine1().length() == 0)
			errors.rejectValue("addressLine1", "Empty Value", "Please Enter Address");
		
		if(employerDetails.getPostalCode() == null || employerDetails.getPostalCode().length() == 0)
			errors.rejectValue("postalCode", "Empty Value", "Please Enter Zip Code");
		
		if(employerDetails.getCompanyRegNumber() == null || employerDetails.getCompanyRegNumber().length() == 0)
			errors.rejectValue("companyRegNumber", "Empty Value", "Please Enter Company Registration Number");
		
		if(employerDetails.getState() == null || employerDetails.getState().length() == 0)
			errors.rejectValue("state", "Empty Value", "Please Enter State");
		
		if(employerDetails.getIndustry() == null || employerDetails.getIndustry().length() == 0)
			errors.rejectValue("industry", "Empty Value", "Please Select Industry");
		
		if(employerDetails.getCompanyType() == null || employerDetails.getCompanyType().length() == 0)
			errors.rejectValue("companyType", "Empty Value", "Please Enter Company Type");
		
		if(employerDetails.getCompanyDesc() == null || employerDetails.getCompanyDesc().length() == 0)
			errors.rejectValue("companyDesc", "Empty Value", "Please Enter Company Overview");
		
		
		if(employerDetails.getContactPersonName() == null || employerDetails.getContactPersonName().length() == 0)
			errors.rejectValue("contactPersonName", "Empty Value", "Please Enter Contact Person Name");
		
		if(employerDetails.getPhoneNumber() == null || employerDetails.getPhoneNumber().length() == 0)
			errors.rejectValue("phoneNumber", "Empty Value", "Please Enter Phone Number");
		
		
	}

}
