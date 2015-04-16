package caerusapp.service.employer;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.dao.employer.IEmployerJobPostDao;
import caerusapp.domain.common.JobDetailsDom;

public class EmployerJobPostManager implements IEmployerJobPostManager {
	
	IEmployerJobPostDao employerJobPostDao;

	public IEmployerJobPostDao getEmployerJobPostDao() {
		return employerJobPostDao;
	}

	public void setEmployerJobPostDao(IEmployerJobPostDao employerJobPostDao) {
		this.employerJobPostDao = employerJobPostDao;
	}

	public int getJobIdCount(String jobId) {
		return employerJobPostDao.getJobIdCount(jobId);
	}

	@Override
	public void publishJob(JobDetailsDom jobDetailsDom) {
		employerJobPostDao.publishJob(jobDetailsDom);
	}

	@Override
	public void saveJob(JobDetailsDom jobDetailsDom) {
		employerJobPostDao.saveJob(jobDetailsDom);
	}

	@Override
	public List<JobDetailsDom> getAllInternshipsPostedByEmployer(String emailID) {
		return employerJobPostDao.getAllInternshipsPostedByEmployer(emailID);
	}

	@Override
	public List<JobDetailsDom> getAllJobsPostedByEmployer(String emailID) {
		return employerJobPostDao.getAllJobsPostedByEmployer(emailID);
	}

	@Override
	public Integer getResponseCountForJob(String jobIdAndFirmId) {
		return employerJobPostDao.getResponseCountForJob(jobIdAndFirmId);
	}

	@Override
	public Integer getResponseCountForInternship(String internshipIdAndFirmId) {
		return employerJobPostDao.getResponseCountForInternship(internshipIdAndFirmId);
	}

	@Override
	public JobDetailsDom getJobDetailsByJobIdAndFirmId(String jobId) {
		return employerJobPostDao.getJobDetailsByJobIdAndFirmId(jobId);
	}

	@Override
	public void updatePostedJob(JobDetailsDom jobDetailsDom) {
		employerJobPostDao.updatePostedJob(jobDetailsDom);
		
	}
	@Override
	public void deletePostedJob(String jobId) {
		employerJobPostDao.deletePostedJob(jobId);
	}

	@Override
	public int getInternshipIdCount(String internshipId) {
		return employerJobPostDao.getInternshipIdCount(internshipId);
	}

	@Override
	public void saveInternship(JobDetailsDom internshipDetails) {
		employerJobPostDao.saveInternship(internshipDetails);
	}

	@Override
	public void publishInternship(JobDetailsDom internshipDetailsDom) {
		employerJobPostDao.publishInternship(internshipDetailsDom);
	}

	@Override
	public JobDetailsDom getInternshipDetailsByInternshipIdAndFirmId(String internshipIdAndFirmId) {
		return employerJobPostDao.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
	}

	@Override
	public void deleteInternship(String internshipIdAndFirmId) {
		employerJobPostDao.deleteInternship(internshipIdAndFirmId);
	}

	@Override
	public Map<String, String> getAppliedCandidateEmailIds(String jobId) {
		return employerJobPostDao.getAppliedCandidateEmailIds(jobId);
	}

	@Override
	public List<JobDetailsDom> getJobsForJobIds(String cassandraInQuery) {
		return employerJobPostDao.getJobsForJobIds(cassandraInQuery);
	}

	@Override
	public void saveCampusJob(JobDetailsDom campusJobDetailsDom) {
		employerJobPostDao.saveCampusJob(campusJobDetailsDom);
	}

	@Override
	public void publishCampusJob(JobDetailsDom campusJobDetailsDom) {
		employerJobPostDao.publishCampusJob(campusJobDetailsDom);
	}

	@Override
	public JobDetailsDom getCampusJobDetails(String jobId, String universityName) {
		return employerJobPostDao.getCampusJobDetails(jobId,universityName);
	}

	@Override
	public void deleteCampusJob(String jobId, String universityName) {
		employerJobPostDao.deleteCampusJob(jobId,universityName);
	}

	@Override

	public void updateSeenByUniversityFlag(String jobId, String universityName) {
		employerJobPostDao.updateSeenByUniversityFlag(jobId,universityName);
	}
	public void saveCampusInternship(JobDetailsDom campusInternshipCommand) {
		employerJobPostDao.saveCampusInternship(campusInternshipCommand);
	}

	@Override
	public void publishCampusInternship(JobDetailsDom campusInternshipDom) {
		employerJobPostDao.publishCampusInternship(campusInternshipDom);
	}

	@Override
	public JobDetailsDom getCampusInternshipDetails(String internshipId,String universityName) {
		return employerJobPostDao.getCampusInternshipDetails(internshipId,universityName);
	}

	@Override
	public void deleteCampusInternship(String internshipId,String universityName) {
		employerJobPostDao.deleteCampusInternship(internshipId,universityName);
	}
	
	public String getCity(String zipCode) {
		return employerJobPostDao.getCity(zipCode);
	}

	@Override
	public String getState(String zipCode) {
		return employerJobPostDao.getState(zipCode);

	}

	@Override
	public List<JobDetailsDom> getInternshipsForInternshipIds(
			String savedInternshipsCassandraInQuery) {
		return employerJobPostDao.getInternshipsForInternshipIds(savedInternshipsCassandraInQuery);
	}

	@Override
	public String getFirmIdByJobIdAndFirmId(String jobId) {
		return employerJobPostDao.getFirmIdByJobIdAndFirmId(jobId);
	}

	@Override
	public List<JobDetailsDom> getJobsDetails(JobDetailsDom jobDetailsDom,String emailId) {
		
		return employerJobPostDao.getJobsDetails(jobDetailsDom,emailId);
	}

	@Override
	public JobDetailsDom findJobDetails(String jobIdAndFirmId) {
		
		return employerJobPostDao.findJobDetails(jobIdAndFirmId);
	}
	
	@Override
	public Map<String, String> getAppliedCandidateEmailIdsForInternship(String internshipIdAndFirmId) {
		return employerJobPostDao.getAppliedCandidateEmailIdsForInternship(internshipIdAndFirmId);
	}

	@Override
	public Map<String, String> getAppliedCandidateEmailIdsForCampusJob(String jobId, String universityName) {
		
		return employerJobPostDao.getAppliedCandidateEmailIdsForCampusJob(jobId,universityName);
	}

	@Override
	public Map<String, String> getAppliedCandidateEmailIdsForCampusInternship(String internshipId, String universityName) {
		
		return employerJobPostDao.getAppliedCandidateEmailIdsForCampusInternship(internshipId,universityName);
	}
	
	/**
	 * This method updates the Viewed count of a job
	 * @author balajii
	 * @param jobId 
	 */
	@Override
	public void updateJobViewCount(String jobId) {
		employerJobPostDao.updateJobViewCount(jobId);
	}

	@Override
	public void updateInternshipViewCount(String internshipId) {
		employerJobPostDao.updateInternshipViewCount(internshipId);
	}

	@Override
	public void updateCampusInternshipViewCount(String internshipId,String universityName) {
		employerJobPostDao.updateCampusInternshipViewCount(internshipId,universityName);
	}

	@Override
	public void updateCampusJobViewCount(String jobId, String universityName) {
		employerJobPostDao.updateCampusJobViewCount(jobId,universityName);
	}

	@Override
	public Long getAppliedCandidateCountInTimeframe(String companyName,Date previousDate) {
		return employerJobPostDao.getAppliedCandidateCountInTimeframe(companyName,previousDate);
	}

	@Override
	public float getAverageJobClosureTime(String companyName, Date previousDate) {
		return employerJobPostDao.getAverageJobClosureTime(companyName,previousDate);
	}

	@Override
	public Long getAverageResponsesPerJob(String companyName, Date previousDate) {
		return employerJobPostDao.getAverageResponsesPerJob(companyName,previousDate);
	}

	@Override
	public Long getJobsAndInternshipCountPostedInTimeframe(String companyName,Date previousDate, boolean allTimeDataFlag) {
		return employerJobPostDao.getJobsAndInternshipCountPostedInTimeframe(companyName,previousDate,allTimeDataFlag);
	}

	@Override
	public void closeCampusInternship(String internshipIdAndFirmId,String universityName) {
		employerJobPostDao.closeCampusInternship(internshipIdAndFirmId,universityName);
	}

	@Override
	public void extendCampusInternshipEndDate(String internshipIdAndFirmId,String universityName,String endDate) {
		employerJobPostDao.extendCampusInternshipEndDate(internshipIdAndFirmId,universityName,endDate);	
	}

	@Override
	public void closeInternship(String internshipIdAndFirmId) {
		employerJobPostDao.closeInternship(internshipIdAndFirmId);
	}

	@Override
	public void extendInternshipEndDate(String internshipIdAndFirmId,String endDate) {
		employerJobPostDao.extendInternshipEndDate(internshipIdAndFirmId,endDate);
	}

	/**
	 * This method fetches all the jobs posted by a Company with a specific status (i.e : Published Jobs, Closed Jobs et cetera)
	 * @author balajii
	 * @param companyName
	 * @param status
	 * @return List<JobDetailsDom>
	 */
	@Override
	public List<JobDetailsDom> getJobsByCompanyName(String companyName,String status) {
		return employerJobPostDao.getJobsByCompanyName(companyName,status);
	}

}
