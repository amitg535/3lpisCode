package caerusapp.service.employer;


import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;

public interface IEmployerManager {

	/**
	 * 
	 * @param corporateName
	 * @return
	 */
	EmployerDom getEmployerDetails(String corporateName);

	/**
	 * 
	 * @param corporateName
	 * @return
	 */
	int getUserLoginAttempts(String corporateName);

	/**
	 * 
	 * @param emailId
	 * @return
	 */
	int getEmployerByEmailId(String emailId);

	/**
	 * 
	 * @param employerDom
	 */
	void addEmployer(EmployerDom employerDom);

	/**
	 * 
	 * @param companyName
	 * @return
	 */
	int getEmployerByCompanyName(String companyName);
	
	/**
	 * 
	 * @param keyword
	 * @param emailID
	 */
	void updateEmployerSearchHistory(String keyword, String emailID);

	/**
	 * 
	 * @param jobDetailsDom
	 */
	void saveSearchParameter(JobDetailsDom jobDetailsDom);

	/**
	 * 
	 * @param loggedInUserEmail
	 * @return
	 */
	List<String> getFormulaNames(String loggedInUserEmail);

	/**
	 * 
	 * @param candidateEmailId
	 * @param candidateShortlistedStatus
	 * @param jobId
	 */
	void updateCandidateStatus(String candidateEmailId,String candidateShortlistedStatus, String jobId);

	/**
	 * 
	 * @param candidateDetails
	 */
	void employerSaveCandidate(StudentDom candidateDetails);

	/**
	 * 
	 * @param emailId
	 * @return
	 */
	List<JobDetailsDom> getSavedSearches(String emailId);

	/**
	 * 
	 * @param emailId
	 * @param searchParameterName
	 */
	void deleteSavedSearch(String emailId, String searchParameterName);

	/**
	 * 
	 * @param industry
	 * @param companyName
	 * @return
	 */
	public List<EmployerDom> getRegisteredCompaniesByIndustryAndCompanyName(String industry, String companyName);
	
	/**
	 * 
	 * @param companyName
	 * @return
	 */
	 public List<EmployerDom> getRegisteredCompaniesByCompanyName(String companyName);
	 
	 /**
	  * 
	  * @param emailId
	  * @return
	  */
	List<StudentDom> getSavedCandidates(String emailId);


	Map<Object, String> getEmployerSearchHistory(String corporateEmailId);

	void updateActionOnUniversityInvite(String corporateEmailId,String eventId, String action);

	void updateUserLoginAttempts(String corporateName);

	List<String> getRepositoryFileNames(String companyName);

	void updateEmployerDetails(EmployerDom employerDetailsDom);

	List<String> getFormulaDetails(String formulaName, String emailId);

	JobDetailsDom getParametersOfSavedSearch(String parameterName,String emailId);

	List<EmployerDom> getEmployerFiles(String companyName);

	void deleteFile(String fileId, String companyName);

	void uploadFile(EmployerDom employerCom);

	byte[] getEmployerLogo(String employerEmailId);

	void updateCandidateStatusForInternship(String candidateEmailId,String status, String internshipIdAndFirmId);

	byte[] getEmployerFileDetails(String companyName,String fileName);

	void updateCandidateStatusForCampusInternship(String candidateEmailId,String status, String internshipIdAndFirmId, String universityName);

	void updateCandidateStatusForCampusJob(String candidateEmailId,String status, String jobId, String universityName);

	void addToEmployerRecentSearches(String combinationWord, String emailId, String firmName);

	Map<Date, String> getEmployerRecentSearches(String emailId);
	
	void updateEmployerActivity(String firmName, String studentEmailId, String action);

	Long getEmployerActivityCount(String companyName, Date previousDate,String action);

	List<String> getRecentVisitedProfiles(String firmName,String action);

	String getCompanyIndustryType(String firmName);

	List<String> getCompaniesOfSameIndustry(String industry);

	Map<String,Map<String,Integer>> getRecentVisitedProfiles(List<String> companyNames,String employerActivityViewedProfile);

	Map<String, String> getCompanyPhotoName(List<String> companyNames);

	/**
	 * This method is used to fetch title of job/internship/.. by jobId/internshipId..
	 * @param jobId
	 * @param jobTypeFlag
	 * @return
	 */
	String getTitleById(String jobId, String jobTypeFlag);

}
