package caerusapp.service.employer;

import java.util.Date;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.employer.EmployerEventCom;
import caerusapp.util.CaerusCommonUtility;


public class EmployerScheduleEventValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return EmployerEventCom.class.equals(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		
		EmployerEventCom employerEventCom = (EmployerEventCom) obj;
		
		if(employerEventCom.getEventName() == null || (employerEventCom.getEventName() != null && employerEventCom.getEventName().trim().length() == 0))
			errors.rejectValue("eventName","error.employer.employerEventCom.eventName.required","Please Enter Event Name");
		
		if(employerEventCom.getParticipatingUniversity() == null || (employerEventCom.getParticipatingUniversity() != null && employerEventCom.getParticipatingUniversity().trim().length() == 0))
			errors.rejectValue("participatingUniversity","error.employer.employerEventCom.participatingUniversity.required","Please Enter Participating University Name");
			
		if(employerEventCom.getEventDescription() == null || (employerEventCom.getEventDescription() != null && employerEventCom.getEventDescription().trim().length() == 0))
			errors.rejectValue("eventDescription","error.employer.employerEventCom.eventDescription.required","Please Enter Event Description");
			
		if(employerEventCom.getEventLocation() == null || (employerEventCom.getEventLocation() != null && employerEventCom.getEventLocation().trim().length() == 0))
			errors.rejectValue("eventLocation","error.employer.employerEventCom.eventLocation.required","Please Enter Event Location");
		
		if(employerEventCom.getStartDate() == null || (employerEventCom.getStartDate() != null && employerEventCom.getStartDate().trim().length() == 0 )){
			errors.rejectValue("startDate","error.employer.employerEventCom.startDate.required","Please Enter Event Start Date");
		}
				
		if(employerEventCom.getEndDate() == null || (employerEventCom.getEndDate() != null && employerEventCom.getEndDate().trim().length() == 0 )){
			errors.rejectValue("endDate","error.employer.employerEventCom.endDate.required","Please Enter Event End Date");
		}
		else {
			if(employerEventCom.getStartDate() != null && employerEventCom.getStartDate().trim().length() > 0 ){
				Date startDate = CaerusCommonUtility.stringToDate(employerEventCom.getStartDate(), "yyyy-MM-dd");
				Date endDate = CaerusCommonUtility.stringToDate(employerEventCom.getEndDate(),"yyyy-MM-dd");
				
				if(endDate.before(startDate))
					errors.rejectValue("endDate","error.employer.employerEventCom.endDate.invalidValue","End Date Cannot be Before Start Date");
				
				if(endDate.equals(startDate))
				{
					Date startTime = CaerusCommonUtility.stringToDate(employerEventCom.getStartTime(), "hh:mm a");
					Date endTime = CaerusCommonUtility.stringToDate(employerEventCom.getEndTime(), "hh:mm a");
					
					if(endTime.before(startTime))
						errors.rejectValue("endTime","error.employer.employerEventCom.endTime.invalidValue","End Time Cannot be Before Start Time on the Same Day");
					
					if(endTime.equals(startTime))
						errors.rejectValue("endTime","error.employer.employerEventCom.endTime.invalidValue","End Time Cannot Match Start Time on the Same Day");
					
				}
				
			}
		}
		
		if(employerEventCom.getFunctionalAreas() != null && employerEventCom.getFunctionalAreas().size() > 0){
			/*if(employerEventCom.getEligibleBatches() != null && employerEventCom.getEligibleBatches().size() == 0){
				errors.rejectValue("eligibleBatches","error.employer.employerEventCom.eligibleBatches.invalidValue","Please Select Eligible Batches");
			}*/
			
			if(employerEventCom.getNumberOfHirings() != null && employerEventCom.getNumberOfHirings().size() == 1 && employerEventCom.getNumberOfHirings().get(0).trim().length() == 0){
				errors.rejectValue("numberOfHirings","error.employer.employerEventCom.numberOfHirings.invalidValue","Please Mention Vacancy Count");
			}
			
			/*if(employerEventCom.getMinimumSalaryOffered() != null && employerEventCom.getMinimumSalaryOffered().size() == 0){
				errors.rejectValue("minimumSalaryOffered","error.employer.employerEventCom.minimumSalaryOffered.invalidValue","Please Mention Minimum Salary");
			}*/
		}
	}
}
