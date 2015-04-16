package caerusapp.service.student;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import caerusapp.dao.student.IStudentJobsDao;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.StudentDom;

public class StudentJobsManager implements IStudentJobsManager {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6782940037865934576L;
	
	private IStudentJobsDao studentJobsDao;
	
	public IStudentJobsDao getStudentJobsDao() {
		return studentJobsDao;
	}

	public void setStudentJobsDao(IStudentJobsDao studentJobsDao) {
		this.studentJobsDao = studentJobsDao;
	}

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to save the search parameters during job search
	 * @param saveSearchJobs
	 * @param emailID
	 */
	@Override
	public void saveSearchJobs(JobDetailsDom searchJobs, String emailID) {
		studentJobsDao.saveSearchJobs(searchJobs, emailID);

	}

	/**
	 * This method is used to view saved searches
	 * @param emailID
	 * @return List<JobDetailsDom> (saveSearchJobsList)
	 */
	@Override
	public List<JobDetailsDom> getSavedSearches(String emailID) {
		return studentJobsDao.getSavedSearches(emailID);
	}

	/**
	 * This method is used to delete a saved search
	 * @param emailIds
	 * @param savedSearchParameterNames
	 */
	@Override
	public void deletesavedSearchJobs(String[] emailIds,
			String[] savedSearchParameterNames) {

		studentJobsDao.deletesavedSearchJobs(emailIds,
				savedSearchParameterNames);
	}
	
	/**
	 * This method is used to soft delete a saved job
	 * @param emailId
	 * @param searchParameterNames
	 */
	@Override
	public void deleteSavedSearchJob(String emailId,
			String SearchParameterNames) {

		studentJobsDao.deleteSavedSearchJob(emailId,
				SearchParameterNames);
	}

	/**
	 * This method is used to get the list of students who have applied for the job with id:jobId
	 * @param jobId
	 * @return Map<String, String> studentEmailsWithStatus
	 */
	@Override
	public Map<String, String> getAppliedStudents(String jobId) {
		return studentJobsDao.getAppliedStudents(jobId);
		
	}
	/**
	 * This method is used to apply an internship by the candidate
	 * @param internshipId
	 * @param candidateEmailId
	 */
	@Override
	public void applyInternship(String internshipId, String candidateEmailId) {
		studentJobsDao.applyInternship(internshipId, candidateEmailId);
		
	}

	/**
	 * This method is used to get the list of students who have applied for the internship with id:internshipId
	 * @param internshipId
	 * @return List<Student> studentEmails
	 */
	@Override
	public List<StudentDom> getInternshipAppliedStudent(String internshipId) {
		return studentJobsDao.getInternshipAppliedStudent(internshipId);
	}
	
	/**
	 * This method is used to save an internship
	 * @param internshipId
	 * @param candidateEmailId	
	 */
	@Override
	public void saveInternship(String internshipId, String candidateEmailId) {
		 studentJobsDao.saveInternship(internshipId,candidateEmailId);
	}
		
	/**
	 * This method is used when the candidate applies for a campus job
	 * @author PallaviD
	 * @param jobId
	 * @return void 
	 * 
	 */
	@Override
	public void applyBroadcastedJob(String jobId, String emailId,String universityName) {
		 studentJobsDao.applyBroadcastedJob(jobId,emailId,universityName);
	}
	
	/**
	 * This method is used when the candidate applies for a campus internship
	 * @author PallaviD
	 * @param internshipId
	 * @return void 
	 * 
	 */
	@Override
	public void applyBroadcastedInternship(String internshipId, String emailId,String universityName) {
		 studentJobsDao.applyBroadcastedInternship(internshipId,emailId,universityName);
	}

	/**
	 * This method is used to get the candidates who have applied for the campus job with id:jobId
	 * @author RavishaG
	 * @param jobId
	 * @param universityName
	 * @return Map<String, Timestamp> appliedStudentsMap
	 */
	@Override
	public Map<String, Date> getStudentsAppliedForJob(String jobId,String universityName) {
		
		return studentJobsDao.getStudentsAppliedForJob(jobId,universityName);
	}

	/**
	 * This method is used to get the candidates who have applied for the campus internship with id:internshipId
	 * @author RavishaG
	 * @param internshipId
	 * @param universityName
	 * @return Map<String, Timestamp> appliedStudentsMap
	 */
	@Override
	public Map<String, Date> getStudentsAppliedForInternship(String internshipId, String universityName) {
		
		return studentJobsDao.getStudentsAppliedForInternship(internshipId,universityName);
	}

	/*@Override
	public Map<String, Date> getAppliedJobIdsMap(String candidateEmailId) {
		return studentJobsDao.getAppliedJobIdsMap(candidateEmailId);
	}*/

	/*@Override
	public Map<String, Date> getAppliedInternshipIdsMap(String candidateEmailId) {
		return studentJobsDao.getAppliedInternshipIdsMap(candidateEmailId);
	}

	@Override
	public Map<String, Date> getSavedJobIdsMap(String candidateEmailId) {
		return studentJobsDao.getSavedJobIdsMap(candidateEmailId);
	}

	@Override
	public Map<String, Date> getSavedInternshipIdsMap(String candidateEmailId) {
		return studentJobsDao.getSavedInternshipIdsMap(candidateEmailId);
	}*/

	@Override
	public StudentDom getDefaultProfileDetails(String candidateEmailId) {
		return studentJobsDao.getDefaultProfileDetails(candidateEmailId);
	}

	@Override
	public Map<String, Date> getSavedAndAppliedJobIdsMap(String candidateEmailId) {
		return studentJobsDao.getSavedAndAppliedJobIdsMap(candidateEmailId);
	}

	@Override
	public void applyJob(String jobId,String candidateEmailId) {
		studentJobsDao.applyJob(jobId,candidateEmailId);
		
	}

	@Override
	public void saveJob(String jobId,String candidateEmailId) {
		studentJobsDao.saveJob(jobId,candidateEmailId);
	}

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param jobIdList
	 * @return jobs
	 */
	@Override
	public void applySavedJob(String jobId,String candidateEmailId) {
		studentJobsDao.applySavedJob(jobId,candidateEmailId);
	}

	@Override
	public List<JobDetailsDom> getJobDetails(List<String> jobIdList) {
		return studentJobsDao.getJobDetails(jobIdList);
	}

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param internshipIdList
	 * @return internships
	 */
	@Override
	public List<JobDetailsDom> getInternshipDetails(List<String> internshipIdList) {
		return studentJobsDao.getInternshipDetails(internshipIdList);
	}

	@Override
	public Map<String, Date> getSavedAndAppliedInternshipIdsMap(
			String candidateEmailId) {
		return studentJobsDao.getSavedAndAppliedInternshipIdsMap(candidateEmailId);
	}

	@Override
	public void applySavedInternship(String internshipId,
			String candidateEmailId) {
		studentJobsDao.applySavedInternship(internshipId, candidateEmailId);
		
	}


	@Override
	public Integer getCandidateAppliedPosition(Set<String> appliedCandidateEmailIds,String emailId) {
		return studentJobsDao.getCandidateAppliedPosition(appliedCandidateEmailIds,emailId);
	}

	@Override
	public void updateViewedJobs(String jobId, String emailId) {
		studentJobsDao.updateViewedJobs(jobId,emailId);
	}
	
	@Override
	public void updateViewedInternships(String emailId, String internshipId) {
		studentJobsDao.updateViewedInternships(emailId,internshipId);
	}

	@Override
	public void updateViewedCampusInternship(String emailId, String internshipId) {
		studentJobsDao.updateViewedCampusInternship(emailId,internshipId);
	}

	@Override
	public void updateViewedCampusJob(String emailId, String jobId) {
		studentJobsDao.updateViewedCampusJob(emailId,jobId);
	}

	@Override
	public List<JobDetailsDom> getSavedJobs(String emailId) {
		return studentJobsDao.getSavedJobs(emailId);
	}

	@Override
	public List<JobDetailsDom> getSavedInternships(String loggedInUserEmail) {
		return studentJobsDao.getSavedInternships(loggedInUserEmail);
	}

	@Override
	public List<JobDetailsDom> getAppliedInternships(String loggedInUserEmail) {
		return studentJobsDao.getAppliedInternships(loggedInUserEmail);
	}

	@Override
	public int getAppliedJobsCount(String loggedInUserEmail) {
		return studentJobsDao.getAppliedJobsCount(loggedInUserEmail);
	}

	@Override
	public List<JobDetailsDom> getAppliedJobs(String loggedInUserEmail) {
		return studentJobsDao.getAppliedJobs(loggedInUserEmail);
	}

	@Override
	public List<String> getAppliedJobIds(String loggedInUserEmail) {
		return studentJobsDao.getAppliedJobIds(loggedInUserEmail);
	}

	@Override
	public List<String> getAppliedInternshipIds(String emailId) {
		return studentJobsDao.getAppliedInternshipIds(emailId);
	}

	@Override
	public List<String> getSavedJobIds(String loggedInUserEmail) {
		return studentJobsDao.getSavedJobIds(loggedInUserEmail);
	}

	@Override
	public List<String> getAppliedCampusJobIds(String candidateEmailId) {
		return studentJobsDao.getAppliedCampusJobIds(candidateEmailId);
	}

	@Override
	public List<String> getAppliedCampusInternshipIds(String candidateEmailId) {
		return studentJobsDao.getAppliedCampusInternshipIds(candidateEmailId);
	}

	@Override
	public void applyToInternalPostings(String internshipIdAndFirmId,String universityName, String candidateEmailId) {
		studentJobsDao.applyToInternalPostings(internshipIdAndFirmId,universityName,candidateEmailId);
	}

	@Override
	public List<String> getAppliedInternalPostingIds(String candidateEmailId) {
		return studentJobsDao.getAppliedInternalPostingIds(candidateEmailId);
	}
	
}