package caerusapp.service.student;

import java.text.ParseException;
import java.util.Date;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;

import caerusapp.command.student.PortfolioDetailsCmd;
import caerusapp.domain.student.StudentDom;
import caerusapp.util.CaerusCommonUtil;

/**
 * This class is used to Validate the certification and portfolio section of the Candidate Portfolio page
 * @author ravishag
 *
 */
@Component
public class CandidatePortfolioValidator {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	IStudentManager studentManager;
	
	/**
	 * This method is used to validate the certification section of the candidate portfolio page
	 * @param portfolioDetailsCmd
	 * @param bindingResult
	 * @return null
	 */
	public void validateCertification(PortfolioDetailsCmd portfolioDetailsCmd,BindingResult bindingResult) {
		
		if (portfolioDetailsCmd.getCertificateName() == null || portfolioDetailsCmd.getCertificateName().isEmpty() || portfolioDetailsCmd.getCertificateName().trim().length() == 0) {

			bindingResult.rejectValue("certificateName","certificateName_empty");
			
		}
		
		if (portfolioDetailsCmd.getCertificateAuthority() == null || portfolioDetailsCmd.getCertificateAuthority().isEmpty() || portfolioDetailsCmd.getCertificateAuthority().trim().length() == 0) {

			bindingResult.rejectValue("certificateAuthority","certificateAuthority_empty");
			
		}
		
		if (portfolioDetailsCmd.getCertificateNumber() == null || portfolioDetailsCmd.getCertificateNumber().isEmpty() || portfolioDetailsCmd.getCertificateNumber().trim().length() == 0) {

			bindingResult.rejectValue("certificateNumber","certificateNumber_empty");
			
		}	
		if (!(portfolioDetailsCmd.getCertificationEndYear().equals("null")))
		{
			if (Integer.parseInt(portfolioDetailsCmd.getCertificationStartYear()) > Integer.parseInt(portfolioDetailsCmd.getCertificationEndYear())) {
	
				bindingResult.rejectValue("certificationStartYear","error_duration");
				
			}
			
			if (Integer.parseInt(portfolioDetailsCmd.getCertificationStartYear()) == Integer.parseInt(portfolioDetailsCmd.getCertificationEndYear())) {
				
				if(Integer.parseInt(portfolioDetailsCmd.getCertificationStartMonth()) > Integer.parseInt(portfolioDetailsCmd.getCertificationEndMonth())) {
				
				bindingResult.rejectValue("certificationStartYear","error_duration");
				}
			}
		}
		
	}
	
	/**
	 * This method is used to validate the publication section of the candidate portfolio page
	 * @param portfolioDetailsCmd
	 * @param bindingResult
	 * @return null
	 */
		public void validatePublication(PortfolioDetailsCmd portfolioDetailsCmd,BindingResult bindingResult) {
		
		if (portfolioDetailsCmd.getPublicationTitle() == null || portfolioDetailsCmd.getPublicationTitle().isEmpty() || portfolioDetailsCmd.getPublicationTitle().trim().length() == 0) {

			bindingResult.rejectValue("publicationTitle","publicationTitle_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublisherName() == null || portfolioDetailsCmd.getPublisherName().isEmpty() || portfolioDetailsCmd.getPublisherName().trim().length() == 0) {

			bindingResult.rejectValue("publisherName","publisherName_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublisherAuthorFirstName() == null || portfolioDetailsCmd.getPublisherAuthorFirstName().isEmpty() || portfolioDetailsCmd.getPublisherAuthorFirstName().trim().length() == 0) {

			bindingResult.rejectValue("publisherAuthorFirstName","publisherAuthorFirstName_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublisherAuthorLastName() == null || portfolioDetailsCmd.getPublisherAuthorLastName().isEmpty() || portfolioDetailsCmd.getPublisherAuthorLastName().trim().length() == 0) {

			bindingResult.rejectValue("publisherAuthorLastName","publisherAuthorLastName_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublicationUrl() == null || portfolioDetailsCmd.getPublicationUrl().isEmpty() || portfolioDetailsCmd.getPublicationUrl().trim().length() == 0) {

			bindingResult.rejectValue("publicationUrl","publicationUrl_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublicationSummary() == null || portfolioDetailsCmd.getPublicationSummary().isEmpty() || portfolioDetailsCmd.getPublicationSummary().trim().length() == 0) {

			bindingResult.rejectValue("publicationSummary","publicationSummary_empty");
			
		}
		
		if (portfolioDetailsCmd.getPublicationDate() == null || portfolioDetailsCmd.getPublicationDate().isEmpty() || portfolioDetailsCmd.getPublicationDate().trim().length() == 0) {

			bindingResult.rejectValue("publicationDate","publicationDate_empty");
			
		}
		
	}
		
		/**
		 * This method is used to validate the work section of the candidate portfolio page
		 * @param portfolioDetailsCmd
		 * @param bindingResult
		 * @return null
		 */
			public void validateWork(PortfolioDetailsCmd portfolioDetailsCmd,BindingResult bindingResult) {
			
			if (portfolioDetailsCmd.getWorkCompanyName() == null || portfolioDetailsCmd.getWorkCompanyName().isEmpty() || portfolioDetailsCmd.getWorkCompanyName().length() == 0) {
				bindingResult.rejectValue("workCompanyName","workCompanyName_empty");
			}
			
			if (portfolioDetailsCmd.getWorkDescription() == null || portfolioDetailsCmd.getWorkDescription().isEmpty() || portfolioDetailsCmd.getWorkDescription().trim().length() == 0) {
				bindingResult.rejectValue("workDescription","workDescription_empty");
			}
			
			if (portfolioDetailsCmd.getWorkDesignation() == null || portfolioDetailsCmd.getWorkDesignation().isEmpty() || portfolioDetailsCmd.getWorkDesignation().trim().length() == 0) {
				bindingResult.rejectValue("workDesignation","workDesignation_empty");
			}
			
			if(portfolioDetailsCmd.getWorkYearTo() != null && portfolioDetailsCmd.getWorkYearFrom() != null ){
				if(Integer.parseInt(portfolioDetailsCmd.getWorkYearFrom()) >  Integer.parseInt(portfolioDetailsCmd.getWorkYearTo())){
					bindingResult.rejectValue("workYearFrom","workDuration_error");
				}
				
				if(Integer.parseInt(portfolioDetailsCmd.getWorkYearFrom()) ==  Integer.parseInt(portfolioDetailsCmd.getWorkYearTo())){
					if(Integer.parseInt(portfolioDetailsCmd.getWorkMonthFrom()) >=  Integer.parseInt(portfolioDetailsCmd.getWorkMonthTo())){
						bindingResult.rejectValue( "workYearFrom","workDuration_error");
					}
				}
				
			}
			StudentDom studentDetails = new StudentDom();
			if(null != portfolioDetailsCmd.getWorkYearFrom()){
				studentDetails = studentManager.getDetailsByEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
				
				if(studentDetails.getDateOfBirth() != null){
					if( Integer.parseInt(portfolioDetailsCmd.getWorkYearFrom()) - CaerusCommonUtil.getYearFromDate(CaerusCommonUtil.getDateFromString(studentDetails.getDateOfBirth(), "yyyy-MM-dd")) < 15){
						bindingResult.rejectValue( "workYearTo","workDuration_error","Work Year should have a minimum gap of 15 years from Birth Date");
					}
				}
			}
			
			if(null != portfolioDetailsCmd.getWorkYearTo()){
				if(studentDetails.getWorkMap() != null && !studentDetails.getWorkMap().isEmpty()){
					
					Integer index = 1;
					for (Entry<String,String> mapEntry : studentDetails.getWorkMap().entrySet()) {
						String endYearStr = index.toString() + "_endYear";
						if(mapEntry.getKey().contains(endYearStr)){
							if(mapEntry.getValue().contains( CaerusCommonUtil.getYearFromDate(new Date()).toString())){
								bindingResult.rejectValue( "workMonthTo","workDuration_error");
							}
							index++;
						}
					}
					
				}
			}
				
		}

		/**
		 * This method is used to validate the school section of the candidate portfolio page
		 * @param portfolioDetailsCmd
		 * @param bindingResult
		 * @return null
		 * @throws ParseException 
		 */
		public void validateSchool(PortfolioDetailsCmd portfolioDetailsCmd,BindingResult bindingResult) throws ParseException {
			
			if(portfolioDetailsCmd.getSchoolName() == null || portfolioDetailsCmd.getSchoolName().isEmpty() || portfolioDetailsCmd.getSchoolName().length() == 0 ){
				bindingResult.rejectValue("schoolName", "schoolName_empty", "School Name Required");
			}
			
			if(portfolioDetailsCmd.getSchoolState() == null || portfolioDetailsCmd.getSchoolState().isEmpty() || portfolioDetailsCmd.getSchoolState().length() == 0 ){
				bindingResult.rejectValue("schoolState", "schoolState_error", "School State Required");
			}
			
			if(portfolioDetailsCmd.getSchoolGpaFrom() == null || portfolioDetailsCmd.getSchoolGpaFrom().toString().isEmpty() || portfolioDetailsCmd.getSchoolGpaFrom().toString().length() == 0
					|| portfolioDetailsCmd.getSchoolGpaTo() == null || portfolioDetailsCmd.getSchoolGpaTo().toString().isEmpty() || portfolioDetailsCmd.getSchoolGpaTo().toString().length() == 0){
				bindingResult.rejectValue("schoolGpaFrom", "schoolGpa_error","GPA Score cannot be Empty");
			}
			
			if(portfolioDetailsCmd.getSchoolGpaFrom() != null && portfolioDetailsCmd.getSchoolGpaTo() != null) {
				if(portfolioDetailsCmd.getSchoolGpaFrom().isNaN() || portfolioDetailsCmd.getSchoolGpaTo().isNaN()){
					bindingResult.rejectValue("schoolGpaFrom", "schoolGpa_error","GPA Score should only be in Numbers Eg. 3 or 2.3");
				}
				
				if(portfolioDetailsCmd.getSchoolGpaFrom() > portfolioDetailsCmd.getSchoolGpaTo()){
					bindingResult.rejectValue("schoolGpaFrom", "schoolGpa_error","GPA From cannot be greater than GPA To");
				}
			}
			
			if(portfolioDetailsCmd.getSchoolPassingMonth() == null || portfolioDetailsCmd.getSchoolPassingMonth().isEmpty() || portfolioDetailsCmd.getSchoolPassingMonth().length() == 0){
				bindingResult.rejectValue("schoolPassingMonth", "schoolPassingMonth_error","School Passing Month Required");
			}
			
			if(portfolioDetailsCmd.getSchoolPassingYear() == null || portfolioDetailsCmd.getSchoolPassingYear().isEmpty() || portfolioDetailsCmd.getSchoolPassingYear().isEmpty()){
				bindingResult.rejectValue("schoolPassingYear", "schoolPassingYear_error","School Passing Year Required");
			}
			
			if(portfolioDetailsCmd.getSchoolPassingYear() != null && portfolioDetailsCmd.getSchoolPassingYear().trim().length() > 0){
				StudentDom studentDetails = studentManager.getDetailsByEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
				
				if(studentDetails.getDateOfBirth() != null && studentDetails.getDateOfBirth().trim().length() > 0)
				{
						Date selectedDate = CaerusCommonUtil.getDateFromString(studentDetails.getDateOfBirth().trim(), "yyyy-MM-dd");
					    Integer birthYear = CaerusCommonUtil.getYearFromDate(selectedDate);
					    
					if( Integer.parseInt(portfolioDetailsCmd.getSchoolPassingYear()) - birthYear < 13)
						bindingResult.rejectValue("schoolPassingYear", "schoolPassingYear_error","School Passing Year Should be At least 13 years from your Date of Birth");
				}
			}
		}

		/**
		 * This method is used to validate the university section of the candidate portfolio page
		 * @param portfolioDetailsCmd
		 * @param bindingResult
		 * @return null
		 */
		public void validateUniversity(PortfolioDetailsCmd portfolioDetailsCmd,
				BindingResult bindingResult) {
			
			if(portfolioDetailsCmd.getUniversityName() == null || portfolioDetailsCmd.getUniversityName().isEmpty() || portfolioDetailsCmd.getUniversityName().length() == 0 ){
				bindingResult.rejectValue("universityName", "universityName_empty", "University Name Required");
			}
			
			if(portfolioDetailsCmd.getUniversityGpaFrom() == null || portfolioDetailsCmd.getUniversityGpaFrom().toString().isEmpty() || portfolioDetailsCmd.getUniversityGpaFrom().toString().length() == 0
					|| portfolioDetailsCmd.getUniversityGpaTo() == null || portfolioDetailsCmd.getUniversityGpaTo().toString().isEmpty() || portfolioDetailsCmd.getUniversityGpaTo().toString().length() == 0){
				bindingResult.rejectValue("universityGpaFrom", "universityGpa_error","GPA Score cannot be Empty");
			}
			
			if(portfolioDetailsCmd.getUniversityGpaFrom() != null && portfolioDetailsCmd.getUniversityGpaFrom() != null) {
				if(portfolioDetailsCmd.getUniversityGpaTo().isNaN() || portfolioDetailsCmd.getUniversityGpaTo().isNaN()){
					bindingResult.rejectValue("universityGpaFrom", "universityGpa_error","GPA Score should only be in Numbers Eg. 3 or 2.3");
				}
				
				if(portfolioDetailsCmd.getUniversityGpaFrom() > portfolioDetailsCmd.getUniversityGpaTo()){
					bindingResult.rejectValue("universityGpaFrom", "universityGpa_error","GPA From cannot be greater than GPA To");
				}
			}
			
			/*if(portfolioDetailsCmd.getUniversityMonthFrom() == null || portfolioDetailsCmd.getUniversityMonthFrom().isEmpty() || portfolioDetailsCmd.getUniversityMonthFrom().length() == 0){
				
				bindingResult.rejectValue("universityMonthFrom", "universityMonthFrom_error","University Start Month Required");
			}
			
			if(portfolioDetailsCmd.getUniversityMonthTo() == null || portfolioDetailsCmd.getUniversityMonthTo().isEmpty() || portfolioDetailsCmd.getUniversityMonthTo().isEmpty()){
				
				bindingResult.rejectValue("universityMonthTo", "universityMonthTo_error","University End Month Required");
			}
			
			if(portfolioDetailsCmd.getUniversityYearFrom() == null || portfolioDetailsCmd.getUniversityYearFrom().isEmpty() || portfolioDetailsCmd.getUniversityYearFrom().length() == 0){
				
				bindingResult.rejectValue("universityYearFrom", "universityYearFrom_error","University Start Year Required");
			}
			
			if(portfolioDetailsCmd.getUniversityYearTo() == null || portfolioDetailsCmd.getUniversityYearTo().isEmpty() || portfolioDetailsCmd.getUniversityYearTo().isEmpty()){
				
				bindingResult.rejectValue("universityYearTo", "universityYearTo_error","University End Year Required");
				
			}*/
			
			if(portfolioDetailsCmd.getUniversityCourseType() == null || portfolioDetailsCmd.getUniversityCourseType().isEmpty() || portfolioDetailsCmd.getUniversityCourseType().isEmpty()){
				bindingResult.rejectValue("universityCourseType", "universityCourseType_error","University Course Type Required");
			}
			
			if(portfolioDetailsCmd.getUniversityCourseName() == null || portfolioDetailsCmd.getUniversityCourseName().isEmpty() || portfolioDetailsCmd.getUniversityCourseName().isEmpty()){
				bindingResult.rejectValue("universityCourseName", "universityCourseName_error","University Course Name Required");
			}
			if(Integer.parseInt(portfolioDetailsCmd.getUniversityYearTo()) < Integer.parseInt(portfolioDetailsCmd.getUniversityYearFrom()) ){
				bindingResult.rejectValue("universityYearTo", "universityYearTo_error","Year To Cannot be Less than Year From");
			}
			
			if(Integer.parseInt(portfolioDetailsCmd.getUniversityYearTo()) == Integer.parseInt(portfolioDetailsCmd.getUniversityYearFrom()) ){
				if(Integer.parseInt(portfolioDetailsCmd.getUniversityMonthTo()) <= Integer.parseInt(portfolioDetailsCmd.getUniversityMonthFrom()))
					bindingResult.rejectValue("universityYearTo", "universityYearTo_error","Invalid Entry");
			}
			
			
			if(portfolioDetailsCmd.getSchoolPassingYear() != null && portfolioDetailsCmd.getSchoolPassingYear().trim().length() > 0){
				StudentDom studentDetails = studentManager.getDetailsByEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
				
				if(studentDetails.getDateOfBirth() != null && studentDetails.getDateOfBirth().trim().length() > 0)
				{
						Date selectedDate = CaerusCommonUtil.getDateFromString(studentDetails.getDateOfBirth().trim(), "yyyy-MM-dd");
					    Integer birthYear = CaerusCommonUtil.getYearFromDate(selectedDate);
					    
					if( Integer.parseInt(portfolioDetailsCmd.getSchoolPassingYear()) - birthYear < 13)
						bindingResult.rejectValue("schoolPassingYear", "schoolPassingYear_error","School Passing Year Should be At least 13 years from your Date of Birth");
				}
			
			}
			
		}
	
}