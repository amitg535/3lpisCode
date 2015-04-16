package caerusapp.dao.student;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.StudentDom;

public interface IStudentJobsDao {

	/**
	 * This method is used to save the search parameters during job search
	 * @param saveSearchJobs
	 * @param emailID 
	 */
	public void saveSearchJobs(JobDetailsDom saveSearchJobs, String emailID);

	/**
	 * This method is used to view saved searches
	 * @param emailID
	 * @return List<JobDetailsDom> (saveSearchJobsList)
	 */
	public List<JobDetailsDom> getSavedSearches(String emailID);

	/**
	 * This method is used to apply for a job by the candidate
	 * @param jobIdAndFirmId
	 * @param emailID
	 */
	public void applySearchedJob(String jobIdAndFirmId, String emailID);

	/**
	 * This method is used to delete a saved search
	 * @param emailIds
	 * @param savedSearchParameterNames
	 */
	public void deletesavedSearchJobs(String[] emailIds,
			String[] savedSearchParameterNames);

	/**
	 * This method is used to get the list of students who have applied for the job with id:jobId
	 * @param jobId
	 * @return Map<String, String> studentEmailsWithStatus
	 * 
	 */
	public Map<String, String> getAppliedStudents(String jobId);

	/**
	 * This method is used to apply an internship by the candidate
	 * @param internshipId
	 * @param emailID
	 */
	public void applyInternship(String internshipId, String emailID);

	/**
	 * This method is used to get the list of students who have applied for the internship with id:internshipId
	 * @param internshipId
	 * @return List<Student> studentEmails
	 */
	public List<StudentDom> getInternshipAppliedStudent(String internshipId);

	/**
	 * This method is used to soft delete a saved job
	 * @param emailId
	 * @param searchParameterNames
	 */
	public void deleteSavedSearchJob(String emailId, String searchParameterNames);

	/**
	 * This method is used to save an internship
	 * @param internshipId
	 * @param candidateEmailId	
	 */
	public void saveInternship(String internshipId, String candidateEmailId);

	/**
	 * This method is used when the candidate applies for a campus job
	 * @author PallaviD
	 * @param jobId
	 * @param emailId
	 * @param universityName 
	 * @return void 
	 */
	public void applyBroadcastedJob(String jobId, String emailId, String universityName);
	
	/**
	 * This method is used when the candidate applies for a campus internship
	 * @author PallaviD
	 * @param internshipId
	 * @param emailId
	 * @param universityName 
	 * @return void 
	 */
	public void applyBroadcastedInternship(String internshipId, String emailId, String universityName);

	/**
	 * This method is used to get the candidates who have applied for the campus job with id:jobId
	 * @author RavishaG
	 * @param jobId
	 * @param universityName 
	 * @return Map<String, Timestamp> appliedStudentsMap
	 */
	public Map<String, Date> getStudentsAppliedForJob(String jobId, String universityName);

	/**
	 * This method is used to get the candidates who have applied for the campus internship with id:internshipId
	 * @author RavishaG
	 * @param internshipId
	 * @param universityName
	 * @return Map<String, Timestamp> appliedStudentsMap
	 */
	public Map<String, Date> getStudentsAppliedForInternship(String internshipId, String universityName);

	/*public Map<String, Date> getAppliedInternshipIdsMap(String candidateEmailId);

	public Map<String, Date> getSavedJobIdsMap(String candidateEmailId);

	public Map<String, Date> getSavedInternshipIdsMap(String candidateEmailId);*/

	/*public Map<String, Date> getAppliedJobIdsMap(String candidateEmailId);*/

	public StudentDom getDefaultProfileDetails(String candidateEmailId);

	public Map<String, Date> getSavedAndAppliedJobIdsMap(String candidateEmailId);

	public void applyJob(String jobId, String candidateEmailId);

	public void saveJob(String jobId, String candidateEmailId);

	public void applySavedJob(String jobId, String candidateEmailId);

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param jobIdList
	 * @return jobs
	 */
	public List<JobDetailsDom> getJobDetails(List<String> jobIdList);

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param internshipIdList
	 * @return internships
	 */
	public List<JobDetailsDom> getInternshipDetails(List<String> internshipIdList);

	public Map<String, Date> getSavedAndAppliedInternshipIdsMap(
			String candidateEmailId);

	public void applySavedInternship(String internshipId,
			String candidateEmailId);

	public Integer getCandidateAppliedPosition(Set<String> appliedCandidateEmailIds, String emailId);
	
	public void updateViewedJobs(String jobId, String emailId);

	public void updateViewedInternships(String emailId, String internshipId);

	public void updateViewedCampusInternship(String emailId, String internshipId);

	public void updateViewedCampusJob(String emailId, String jobId);

	public List<JobDetailsDom> getSavedJobs(String emailId);

	public List<JobDetailsDom> getSavedInternships(String loggedInUserEmail);

	public List<JobDetailsDom> getAppliedInternships(String loggedInUserEmail);

	public int getAppliedJobsCount(String loggedInUserEmail);

	public List<JobDetailsDom> getAppliedJobs(String loggedInUserEmail);

	public List<String> getAppliedJobIds(String loggedInUserEmail);

	public List<String> getAppliedInternshipIds(String emailId);

	public List<String> getSavedJobIds(String loggedInUserEmail);

	public List<String> getAppliedCampusJobIds(String candidateEmailId);

	public List<String> getAppliedCampusInternshipIds(String candidateEmailId);

	public void applyToInternalPostings(String internshipIdAndFirmId,String universityName, String candidateEmailId);

	public List<String> getAppliedInternalPostingIds(String candidateEmailId);
	
}