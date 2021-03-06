package caerusapp.service.employer;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.domain.common.JobDetailsDom;

public interface IEmployerJobPostManager {

	void publishJob(JobDetailsDom jobDetailsDom);
	void saveJob(JobDetailsDom jobDetailsDom);

	int getJobIdCount(String jobId);

	List<JobDetailsDom> getAllInternshipsPostedByEmployer(String emailID);
	List<JobDetailsDom> getAllJobsPostedByEmployer(String emailID);

	Integer getResponseCountForJob(String jobIdAndFirmId);
	Integer getResponseCountForInternship(String internshipIdAndFirmId);

	JobDetailsDom getJobDetailsByJobIdAndFirmId(String jobId);

	void updatePostedJob(JobDetailsDom jobDetailsDom);

	int getInternshipIdCount(String internshipId);

	void saveInternship(JobDetailsDom internshipDetails);

	void publishInternship(JobDetailsDom internshipDetailsDom);

	JobDetailsDom getInternshipDetailsByInternshipIdAndFirmId(String internshipIdAndFirmId);
	
	void deleteInternship(String internshipIdAndFirmId);
	
	Map<String, String> getAppliedCandidateEmailIds(String jobId);
	
	List<JobDetailsDom> getJobsForJobIds(String cassandraInQuery);
	
	void saveCampusJob(JobDetailsDom campusJobDetailsDom);
	
	void publishCampusJob(JobDetailsDom campusJobDetailsDom);
	
	JobDetailsDom getCampusJobDetails(String jobId, String universityName);
	
	void deleteCampusJob(String jobId, String universityName);
	

	void updateSeenByUniversityFlag(String jobId, String universityName);

	void saveCampusInternship(JobDetailsDom campusInternshipCommand);
	void publishCampusInternship(JobDetailsDom campusInternshipDom);
	JobDetailsDom getCampusInternshipDetails(String internshipId,String universityName);
	void deleteCampusInternship(String internshipId, String universityName);
	
	String getCity(String zipCode);
	String getState(String zipCode);
	void deletePostedJob(String jobId);
	List<JobDetailsDom> getInternshipsForInternshipIds(String savedInternshipsCassandraInQuery);
	String getFirmIdByJobIdAndFirmId(String jobId);
	
	List<JobDetailsDom> getJobsDetails(JobDetailsDom jobDetailsDom,String emailId);
	
	JobDetailsDom findJobDetails(String jobIdAndFirmId);

	Map<String, String> getAppliedCandidateEmailIdsForInternship(String internshipIdAndFirmId);
	
	Map<String, String> getAppliedCandidateEmailIdsForCampusJob(String jobId, String universityName);
	
	Map<String, String> getAppliedCandidateEmailIdsForCampusInternship(String internshipId, String universityName);
	
	/**
	 * This method updates the Viewed count of a job
	 * @author balajii
	 * @param jobId 
	 */
	void updateJobViewCount(String jobId);
	
	void updateInternshipViewCount(String internshipId);
	
	void updateCampusInternshipViewCount(String internshipId, String universityName);
	
	void updateCampusJobViewCount(String jobId, String universityName);
	
	Long getJobsAndInternshipCountPostedInTimeframe(String companyName, Date previousDate, boolean allTimeDataFlag);
	
	Long getAppliedCandidateCountInTimeframe(String companyName,Date previousDate);
	
	float getAverageJobClosureTime(String companyName, Date previousDate);
	
	Long getAverageResponsesPerJob(String companyName, Date previousDate);
	
	void closeCampusInternship(String internshipIdAndFirmId,String universityName);
	
	void extendCampusInternshipEndDate(String internshipIdAndFirmId,String universityName,String endDate);
	
	void closeInternship(String internshipIdAndFirmId);
	
	void extendInternshipEndDate(String internshipIdAndFirmId, String endDate);
	
	
	/**
	 * This method fetches all the jobs posted by a Company with a specific status (i.e : Published Jobs, Closed Jobs et cetera)
	 * @author balajii
	 * @param companyName
	 * @param status
	 * @return List<JobDetailsDom>
	 */
	List<JobDetailsDom> getJobsByCompanyName(String companyName, String status);

}
