package caerusapp.dao.employer;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;

public interface IEmployerDao {

	EmployerDom getEmployerDetails(String corporateName);

	int getEmployerByEmailId(String emailId);

	void addEmployer(EmployerDom employerDom);

	int getEmployerByCompanyName(String companyName);

	int getUserLoginAttempts(String corporateName);

	void updateEmployerSearchHistory(String keyword, String emailID);

	void saveSearchParameter(JobDetailsDom jobDetailsDom);

	List<String> getFormulaNames(String loggedInUserEmail);

	void updateCandidateStatus(String candidateEmailId,String candidateShortlistedStatus, String jobId);

	void employerSaveCandidate(StudentDom candidateDetails);

	List<JobDetailsDom> getSavedSearches(String emailId);

	void deleteSavedSearch(String emailId, String searchParameterName);

	List<EmployerDom> getRegisteredCompaniesByIndustryAndCompanyName(String industry, String companyName);

	List<EmployerDom> getRegisteredCompaniesByCompanyName(String companyName);

	List<EmployerDom> getRegisteredCompaniesByIndustry(String industry);
	List<StudentDom> getSavedCandidates(String emailId);

	Map<Object, String> getEmployerSearchHistory(String corporateEmailId);

	void updateActionOnUniversityInvite(String corporateName,String eventId, String action);

	void updateUserLoginAttempts(String corporateName);

	List<String> getRepositoryFileNames(String companyName);

	void updateEmployerDetails(EmployerDom employerDetailsDom);

	List<String> getFormulaDetails(String formulaName, String emailId);

	JobDetailsDom getParametersOfSavedSearch(String parameterName,String emailId);

	List<EmployerDom> getEmployerFiles(String companyName);

	void deleteFile(String fileId, String companyName);

	void uploadFile(EmployerDom employerDom);

	byte[] getEmployerLogo(String employerEmailId);

	void updateCandidateStatusForInternship(String candidateEmailId,String status, String internshipIdAndFirmId);

	byte[] getEmployerFileDetails(String companyName,String fileName);

	void updateCandidateStatusForCampusInternship(String candidateEmailId,String candidateShortlistedStatus, String internshipIdAndFirmId, String universityName);

	void updateCandidateStatusForCampusJob(String candidateEmailId,String candidateShortlistedStatus, String jobId, String universityName);


	void addToEmployerRecentSearches(String combinationWord, String emailId, String firmName);

	Map<Date, String> getEmployerRecentSearches(String emailId);

	void updateEmployerActivity(String firmName, String studentEmailId, String action);

	Long getEmployerActivityCount(String companyName, Date previousDate,String action);

	List<String> getRecentVisitedProfiles(String firmName, String action);

	String getCompanyIndustryType(String firmName);

	List<String> getCompaniesOfSameIndustry(String industry);

	Map<String,Map<String,Integer>> getRecentVisitedProfiles(List<String> companyNames,String action);

	Map<String, String> getCompanyPhotoName(List<String> companyNames);

	/**
	 * This method is used to fetch title of job/internship/.. by jobId/internshipId..
	 * @param jobId
	 * @param jobTypeFlag
	 * @return
	 */
	String getTitleById(String jobId, String jobTypeFlag);
}

