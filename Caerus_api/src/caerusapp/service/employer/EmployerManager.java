package caerusapp.service.employer;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.dao.employer.IEmployerDao;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;

public class EmployerManager implements IEmployerManager {

	IEmployerDao employerDao;

	public IEmployerDao getEmployerDao() {
		return employerDao;
	}

	public void setEmployerDao(IEmployerDao employerDao) {
		this.employerDao = employerDao;
	}

	@Override
	public EmployerDom getEmployerDetails(String corporateName) {
		return employerDao.getEmployerDetails(corporateName);
	}

	@Override
	public int getUserLoginAttempts(String corporateName) {
		return employerDao.getUserLoginAttempts(corporateName);
	}
	public int getEmployerByEmailId(String emailId) {
		return employerDao.getEmployerByEmailId(emailId);
	}

	@Override
	public void addEmployer(EmployerDom employerDom) {
		employerDao.addEmployer(employerDom);
	}

	@Override
	public int getEmployerByCompanyName(String companyName) {
		
		return employerDao.getEmployerByCompanyName(companyName);
	}

	@Override

	public void updateEmployerSearchHistory(String keyword, String emailID) {
		employerDao.updateEmployerSearchHistory(keyword,emailID);
	}

	@Override
	public void saveSearchParameter(JobDetailsDom jobDetailsDom) {
		employerDao.saveSearchParameter(jobDetailsDom);

	}
	
	public List<String> getFormulaNames(String loggedInUserEmail) {
		return employerDao.getFormulaNames(loggedInUserEmail);
	}

	@Override
	public void updateCandidateStatus(String candidateEmailId,String candidateShortlistedStatus, String jobId) {
		employerDao.updateCandidateStatus(candidateEmailId,candidateShortlistedStatus,jobId);

	}

	@Override
	public void employerSaveCandidate(StudentDom candidateDetails) {
		employerDao.employerSaveCandidate(candidateDetails);
	}

	@Override
	public List<JobDetailsDom> getSavedSearches(String emailId) {
		return employerDao.getSavedSearches(emailId);
	}

	@Override
	public void deleteSavedSearch(String emailId, String searchParameterName) {
		employerDao.deleteSavedSearch(emailId,searchParameterName);
	}

	public List<EmployerDom> getRegisteredCompaniesByIndustryAndCompanyName(String industry, String companyName) {
		return employerDao.getRegisteredCompaniesByIndustryAndCompanyName(industry, companyName);
	}

	public List<EmployerDom> getRegisteredCompaniesByCompanyName(
			String companyName) {
		return employerDao.getRegisteredCompaniesByCompanyName(companyName);
		}

	public List<EmployerDom> getRegisteredCompaniesByIndustry(String industry) {
		return employerDao.getRegisteredCompaniesByIndustry(industry);
	}
	public List<StudentDom> getSavedCandidates(String emailId) {
		return employerDao.getSavedCandidates(emailId);
	}

	@Override
	public Map<Object, String> getEmployerSearchHistory(String corporateEmailId) {
		
		return employerDao.getEmployerSearchHistory(corporateEmailId);
	}

	@Override
	public void updateActionOnUniversityInvite(String corporateName,String eventId, String action) {
		employerDao.updateActionOnUniversityInvite(corporateName,eventId,action);
	}

	@Override
	public void updateUserLoginAttempts(String corporateName) {
		employerDao.updateUserLoginAttempts(corporateName);
	}
	public List<String> getRepositoryFileNames(String companyName) {
		return employerDao.getRepositoryFileNames(companyName);

	}

	@Override
	public void updateEmployerDetails(EmployerDom employerDetailsDom) {
		employerDao.updateEmployerDetails(employerDetailsDom);
	}

	@Override
	public List<String> getFormulaDetails(String formulaName, String emailId) {
		return employerDao.getFormulaDetails(formulaName,emailId);
	}

	@Override
	public JobDetailsDom getParametersOfSavedSearch(String parameterName,String emailId) {
		return employerDao.getParametersOfSavedSearch(parameterName,emailId);
	}

	@Override
	public List<EmployerDom> getEmployerFiles(String companyName) {
		return employerDao.getEmployerFiles(companyName);
	}

	@Override
	public void deleteFile(String fileId, String companyName) {
		employerDao.deleteFile(fileId,companyName);
	}

	@Override
	public void uploadFile(EmployerDom employerDom) {
		employerDao.uploadFile(employerDom);
	}

	@Override
	public byte[] getEmployerLogo(String companyName) {
		
		return employerDao.getEmployerLogo(companyName);
	}
	
	@Override
	public void updateCandidateStatusForInternship(String candidateEmailId,String status, String internshipIdAndFirmId) {
		employerDao.updateCandidateStatusForInternship(candidateEmailId,status,internshipIdAndFirmId);
	}

	@Override
	public byte[] getEmployerFileDetails(String companyName,String fileName) {
		return employerDao.getEmployerFileDetails(companyName,fileName);
	}

	@Override
	public void updateCandidateStatusForCampusInternship(String candidateEmailId, String status,
			String internshipIdAndFirmId,String universityName) {
		employerDao.updateCandidateStatusForCampusInternship(candidateEmailId,status,internshipIdAndFirmId,universityName);
	}

	@Override
	public void updateCandidateStatusForCampusJob(String candidateEmailId,String status, String jobId,
			String universityName) {
		employerDao.updateCandidateStatusForCampusJob(candidateEmailId,status,jobId,universityName);
	}

	@Override

	public void addToEmployerRecentSearches(String combinationWord,String emailId,String firmName) {
		employerDao.addToEmployerRecentSearches(combinationWord,emailId,firmName);
	}

	@Override
	public Map<Date, String> getEmployerRecentSearches(String emailId) {
		return employerDao.getEmployerRecentSearches(emailId);
	}


	public void updateEmployerActivity(String firmName, String studentEmailId, String action) {
		employerDao.updateEmployerActivity(firmName,studentEmailId,action);
	}

	@Override
	public Long getEmployerActivityCount(String companyName, Date previousDate,String action) {
		return employerDao.getEmployerActivityCount(companyName,previousDate,action);
	}
	
	@Override
	public List<String> getRecentVisitedProfiles(String firmName,String action) {
		return employerDao.getRecentVisitedProfiles(firmName,action);
	}

	@Override
	public String getCompanyIndustryType(String firmName) {
		return employerDao.getCompanyIndustryType(firmName);
	}

	@Override
	public List<String> getCompaniesOfSameIndustry(String industry) {
		return employerDao.getCompaniesOfSameIndustry(industry);
	}

	@Override
	public  Map<String,Map<String,Integer>> getRecentVisitedProfiles(List<String> companyNames,String action) {
		return employerDao.getRecentVisitedProfiles(companyNames,action);
	}

	@Override
	public Map<String, String> getCompanyPhotoName(List<String> companyNames) {
		return employerDao.getCompanyPhotoName(companyNames);
	}

	@Override
	public String getTitleById(String jobId, String jobTypeFlag) {
		return employerDao.getTitleById(jobId, jobTypeFlag );
	}
}
