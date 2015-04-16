package caerusapp.dao.student;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.dao.common.AsyncActivities;
import caerusapp.dao.employer.IEmployerJobPostDao;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;


public class StudentJobsDao implements IStudentJobsDao {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	CassandraOperations cassandraOperations;
	
	@Autowired
	AsyncActivities asyncActivities;
	
	@Autowired
	IEmployerJobPostDao employerJobPostDao;
	/**
	 * 
	 * This class is used to Map the ResultSet values(job_dtls) to Domain/Value Objects(JobDetailsDao)
	 *
	 */
	public static class JobMapper implements RowMapper<JobDetailsDom> {

		@Override
		public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
			JobDetailsDom job = new JobDetailsDom();

			job.setJobTitle(rs.getString("job_title"));
			job.setJobDescription(rs.getString("description"));
			job.setJobType(rs.getString("job_type"));
			job.setPayPerWeek(rs.getString("salary"));
			job.setLocation(rs.getString("location"));
			job.setIndustry(rs.getString("industry"));
			job.setFunctionalArea(rs.getString("functional_area"));
			job.setPostedOn(rs.getDate("posted_on").toString());
			job.setCompanyName(rs.getString("firm_name"));
			job.setEmailId(rs.getString("firm_id"));
			job.setJobId(rs.getString("job_id"));
			job.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			job.setPrimarySkills(rs.getList("primary_skills",String.class));
			job.setSecondarySkills( rs.getList("secondary_skills",String.class));
			job.setExperienceFrom(rs.getString("experience_from"));
			job.setExperienceTo(rs.getString("experience_to"));
			//jobDetails.setGpaCutOffFrom(rs.getString("gpa_cut_off_from"));
			//jobDetails.setGpaCutOffTo(rs.getString("gpa_cut_off_to"));
			//jobDetails.setEligibleStreams( rs.getList("eligible_streams",String.class));
			job.setStatus(rs.getString("status"));
			job.setZipCode(rs.getString("zip_code"));
			job.setResponseCount((long) rs.getInt("response_count"));
			

			return job;

		}
	}
	/**
	 * 
	 * This class is used to Map the ResultSet values(internship_dtls) to Domain/Value Objects(JobDetailsDao)
	 *
	 */

	public static class InternshipMapper implements RowMapper<JobDetailsDom> {
		
		@Override
		public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
			JobDetailsDom internshipDetails = new JobDetailsDom();

			internshipDetails.setInternshipIdAndFirmId(rs.getString("internship_id_and_firm_id"));
			internshipDetails.setInternshipId(rs.getString("internship_id"));
			internshipDetails.setInternshipTitle(rs.getString("internship_title"));
			internshipDetails.setInternshipType(rs.getString("internship_type"));
			internshipDetails.setInternshipDescription(rs.getString("description"));
			internshipDetails.setStartDate(rs.getString("start_date"));
			internshipDetails.setEndDate(rs.getString("end_date"));
			internshipDetails.setApproximateHours(rs.getString("approximate_hours"));
			internshipDetails.setPayPerHour(rs.getString("pay_per_hour"));
			internshipDetails.setPostedOn(rs.getDate("posted_on").toString());
			internshipDetails.setPrimarySkills( rs.getList("primary_skills",String.class));
			internshipDetails.setSecondarySkills( rs.getList("secondary_skills",String.class));
			internshipDetails.setStatus(rs.getString("status"));
			internshipDetails.setLocation(rs.getString("location"));
			internshipDetails.setEmailId(rs.getString("firm_id"));
			internshipDetails.setCompanyName(rs.getString("firm_name"));
			internshipDetails.setZipCode(rs.getString("zip_code"));

			return internshipDetails;
		}
	}
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(internship_dtls) to Domain/Value Objects(JobDetailsDao)
	 *
	 */
	public static class ApplyInternshipMapper  implements RowMapper<JobDetailsDom> {

		@Override
		public JobDetailsDom mapRow(Row row, int arg1) throws DriverException {

			JobDetailsDom appliedInternship = new JobDetailsDom();
			appliedInternship.setResponseCount((long)row.getInt("response_count"));
			appliedInternship.setInternshipTitle(row.getString("internship_title"));
			return appliedInternship;
		}
		
	}
	
	public static class ApplyJobMapper  implements RowMapper<JobDetailsDom> {

		@Override
		public JobDetailsDom mapRow(Row row, int arg1) throws DriverException {

			JobDetailsDom appliedJob = new JobDetailsDom();
			appliedJob.setResponseCount((long)row.getInt("response_count"));
			appliedJob.setJobTitle(row.getString("job_title"));
			return appliedJob;
		}
		
	}
	/**
	 * 
	 * This class is used to Map the ResultSet values(job_dtls) to Domain/Value Objects(EmployerJobPost)
	 *
	 */
	/*public static class jobMapperSearch implements RowMapper {
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			JobDetailsDom job = new JobDetailsDom();
		
			job.setJobTitle(rs.getString("job_title"));
			job.setJobDescription(rs.getString("description"));
			job.setNatureOfJob(rs.getString("job_type"));
			job.setSalaryDetails(rs.getString("salary"));
			job.setJobLocation(rs.getString("location"));
			job.setIndustry(rs.getString("industry"));
			job.setFunctionalArea(rs.getString("functional_area"));
			job.setPostedOn(rs.getString("posted_on"));
			job.setCompanyName(rs.getString("firm_name"));
			job.setEmailAddress(rs.getString("firm_id"));
			job.setJobId(rs.getString("job_id"));
			job.setJobid_and_firmid(rs.getString("job_id_and_firm_id"));
			job.setResponseCount(rs.getInt("response_count"));
			job.setPrimarySkills((List<String>) rs.getObject("primary_skills"));
			job.setSecondarySkills((List<String>) rs.getObject("secondary_skills"));
			job.setExperienceFrom(rs.getString("experience_from"));
			job.setExperienceTo(rs.getString("experience_to"));
			job.setGpaCutOffFrom(rs.getString("gpa_cut_off_from"));
			job.setGpaCutOffTo(rs.getString("gpa_cut_off_to"));
			job.setEligibleStreams((List<String>) rs.getObject("eligible_streams"));
			job.setStatus(rs.getString("status"));
									
			return job;
		}

	}*/
	
	/**
	  * 
	  * This class is used to Map the ResultSet values(job_dtls) to Domain/Value Objects(StudentSearchJobs)
	  *
	  */
	 /*private static class SearchJobsMapper implements RowMapper<StudentDom> {

	  public StudentDom mapRow(ResultSet rs, int rowNum)
	    throws SQLException {

		  StudentDom searchJobs = new StudentDom();
	   searchJobs.setJobTitle(rs.getString("job_title"));
	   searchJobs.setJobDescription(rs.getString("description"));
	   searchJobs.setSalaryDetails(rs.getString("salary"));
	   searchJobs.setLocation(rs.getString("location"));
	   searchJobs.setIndustry(rs.getString("industry"));
	   searchJobs.setFunctionalArea(rs.getString("functional_area"));
	   searchJobs.setPrimarySkills((List<String>)rs.getObject("primary_skills"));
	   searchJobs.setSecondarySkills((List<String>)rs.getObject("secondary_skills"));
	   searchJobs.setCompanyName(rs.getString("firm_name"));
	   searchJobs.setEmailAddress(rs.getString("firm_id"));
	   searchJobs.setNatureOfJob(rs.getString("job_type"));
	   searchJobs.setPostedOn(rs.getString("posted_on"));
	   searchJobs.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));

	   return searchJobs;
	  }
	 }*/
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(internship_dtls) to Domain/Value Objects(EmployerJobPost)
	 *
	 */
	/*public static class internshipMapperSearch implements RowMapper {
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			JobDetailsDom job = new JobDetailsDom();
		
			job.setInternship_id_and_firm_id(rs.getString("internship_id_and_firm_id"));
			job.setInternshipId(rs.getString("internship_id"));
			job.setInternshipTitle(rs.getString("internship_title"));
			job.setInternshipType(rs.getString("internship_type"));
			job.setInternshipDescription(rs.getString("description"));
			job.setStartDate(rs.getString("start_date"));
			job.setEndDate(rs.getString("end_date"));
			job.setApproximateHours(rs.getString("approximate_hours"));
			job.setPayPerHour(rs.getString("pay_per_hour"));
			job.setPostedOn(rs.getString("posted_on"));
			job.setPrimarySkills((List<String>) rs.getObject("primary_skills"));
			job.setSecondarySkills((List<String>) rs.getObject("secondary_skills"));
			job.setStatus(rs.getString("status"));
			job.setLocation(rs.getString("location"));
			job.setCompanyName(rs.getString("firm_name"));
			job.setEmailAddress(rs.getString("firm_id"));								
			return job;
		}

	}*/


	/**
	 * 
	 * This class is used to Map the ResultSet values(saved_searches) to Domain/Value Objects(StudentSearchJobs)
	 *
	 */
	/*private static class SaveSearchJobsMapper implements RowMapper<StudentDom> {
		public StudentDom mapRow(ResultSet rs, int rowNum)
				throws SQLException {

			StudentDom searchJobs = new StudentDom();
			searchJobs.setEmailId(rs.getString("emailid"));
			searchJobs.setKeywords(rs.getString("keyword"));
			searchJobs.setLocation(rs.getString("location"));
			searchJobs.setIndustry(rs.getString("industry"));
			searchJobs.setFunctionalArea(rs.getString("functional_area"));
			searchJobs.setSearchParameterName(rs.getString("search_parameter_name"));
			searchJobs.setIs_deleted(rs.getBoolean("is_deleted"));
			searchJobs.setSaved_search_on(rs.getDate("saved_search_on"));
			searchJobs.setSearchCriteria(rs.getString("search_criterion"));
			

			return searchJobs;
		}
	}*/

	
	private static class SavedSearchMapper implements RowMapper<JobDetailsDom> {
	
		@Override
		public JobDetailsDom mapRow(Row rs, int rowNum) throws DriverException {
		JobDetailsDom savedSearch = new JobDetailsDom();
		
		savedSearch.setEmailId(rs.getString("emailid"));
		savedSearch.setKeyword(rs.getString("keyword"));
		savedSearch.setLocation(rs.getString("location"));
		savedSearch.setIndustry(rs.getString("industry"));
		savedSearch.setFunctionalArea(rs.getString("functional_area"));
		savedSearch.setParameterName(rs.getString("search_parameter_name"));
		savedSearch.setDeletedFlag(rs.getBool("is_deleted"));
		
		savedSearch.setSavedSearchOn(rs.getDate("saved_search_on"));

		savedSearch.setSearchCriteria(rs.getString("search_criterion"));

		return savedSearch;
	}
}
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
	Date date = new Date();
 
	/**
	 * This method is used to save the search parameters during job search
	 * @param saveSearchJobs
	 */
	@Override
	public void saveSearchJobs(JobDetailsDom saveSearchJobs, String emailID) {
	
		Date date = new Date();
		
		Insert insertIntoSavedSearches = QueryBuilder.insertInto("saved_searches").values(
				new String[]{		
				"emailid", "search_parameter_name", "keyword", "location", "industry", 
						 "job_type", "functional_area", "is_deleted", "saved_search_on" , "search_criterion"	
					
				}, 
				new Object[]{
						emailID,
						saveSearchJobs.getParameterName(),
						saveSearchJobs.getKeyword(),
						saveSearchJobs.getLocation(),
						saveSearchJobs.getIndustry(),
						saveSearchJobs.getJobType(),
						saveSearchJobs.getFunctionalArea(),
						false,
						date,
						saveSearchJobs.getSearchCriteria()
						
						});
		
		cassandraOperations.execute(insertIntoSavedSearches);
	}

	/**
	 * This method is used to view saved searches
	 * @param emailID
	 * @return List<JobDetailsDom> (savedSearches)
	 */
	@Override
	public List<JobDetailsDom> getSavedSearches(String emailid) {
		String getSavedSearches = "select * from saved_searches where emailid ='"+ emailid +"' and is_deleted=false ALLOW FILTERING";
		List<JobDetailsDom> savedSearches = new ArrayList<JobDetailsDom>();
		
		try {
			savedSearches = cassandraOperations.query(getSavedSearches, new SavedSearchMapper());
		}
		catch(NullPointerException | IllegalArgumentException ex){
			savedSearches = new ArrayList<JobDetailsDom>();
		}
		return savedSearches == null ? new ArrayList<JobDetailsDom>() : savedSearches;
	}

	
	/**
	 * This method is used to apply for a job by the candidate
	 * @param jobIdAndFirmId
	 * @param emailID
	 */
	@Override
	public void applySearchedJob(String jobIdAndFirmId, String emailID) {
		String pName = null;
		
		Date date = new Date();
		
		String sql = "select profile_name, is_default from student_profiles where email_id=? ALLOW FILTERING";
		/*List<StudentDom> profile_name = getSimpleJdbcTemplate().query(sql, new studentProfileMapper(), emailID);
		for (StudentDom item : profile_name) {
			if (item.getDefaultProfile()!= null && item.getDefaultProfile().equalsIgnoreCase("true")) {
				pName = item.getProfileName();
			}
		}

		String response_sql = "SELECT response_count FROM job_dtls WHERE job_id_and_firm_id=? ALLOW FILTERING";
		int responseCount = getSimpleJdbcTemplate().queryForInt(response_sql,
				jobIdAndFirmId);
		
		int query = getSimpleJdbcTemplate()
				.update("insert into applied_job (student_emailid,job_id,flag,profile_name,posted_on) values(:Email,:JobID,:fL,:pN,:postedOn)",
						new MapSqlParameterSource().addValue("Email", emailID)
						.addValue("JobID", jobIdAndFirmId)
								.addValue("fL", "1").addValue("pN", pName).addValue("postedOn", date));

		String jobApplied = "Applied";
		// adding a map to student_details
		String queryTest = "update student_details set job_status = {'"+jobIdAndFirmId+"':'"+jobApplied+"'} where email_id = ?";		
		
		
		int count1 = getSimpleJdbcTemplate().update(queryTest,emailID);
		String sqlQuery = "update job_dtls set response_count="
				+ (responseCount + 1) + " where job_id_and_firm_id=?";
		int count = getSimpleJdbcTemplate().update(sqlQuery, jobIdAndFirmId);
		
		
		
		String queryForJobTitle = "Select job_title from job_dtls where job_id_and_firm_id = ?";
		String jobTitle = getSimpleJdbcTemplate().queryForObject(queryForJobTitle,String.class,jobIdAndFirmId);
		String tracker = "Applied for Job: "+jobTitle;
		
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id = ?";
		
		int result = getSimpleJdbcTemplate().update(queryForTracker,emailID);*/
			

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * caerusapp.dao.student.StudentSearchJobsDao#deletesavedSearchJobs(java
	 * .lang.String[], java.lang.String[])
	 */
	/**
	 * This method is used to delete a saved search
	 * @param emailIds
	 * @param savedSearchParameterNames
	 */
	@Override
	public void deletesavedSearchJobs(String[] emailIds,
			String[] savedSearchParameterNames) {

		for (int i = 0; i < savedSearchParameterNames.length; i++) {

			String sqlQuery = "delete from save_searchjobs where emailid=? and searchparametername=?";
			//getSimpleJdbcTemplate().update(sqlQuery, emailIds[i],savedSearchParameterNames[i]);

		}

	}
	
	/**
	 * This method is used to soft delete a saved job
	 * @param emailId
	 * @param searchParameterNames
	 */
	@Override
	public void deleteSavedSearchJob(String emailId,
			String searchParameterNames) {

			String sqlQuery = "update saved_searches set is_deleted=true  where emailid='"+emailId+"' and search_parameter_name='"+searchParameterNames+"'";
			cassandraOperations.execute(sqlQuery);
			//getSimpleJdbcTemplate().update(sqlQuery, emailId,searchParameterNames);

	}
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(applied_job) to Domain/Value Objects(Student)
	 *
	 */
		/*private static class studentEmailMapper implements RowMapper<StudentDom> {
			public StudentDom mapRow(ResultSet rs, int rowNum)
			throws SQLException {
				StudentDom searchJobs = new StudentDom();
				searchJobs.setEmailID(rs.getString("student_emailid"));
				return searchJobs;
				}
		}*/
	
	/**
	* This method is used to get the list of students who have applied for the job with id:jobId
	* @param jobId
	* @return Map<String,String>studentEmailsWithStatus
	*/	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String,String> getAppliedStudents(String jobId) {
		String appliedCandidates = "select applied_candidates_map from job_dtls where job_id_and_firm_id='"+jobId+"'";
		Map<String,String> appliedCandidatesWithStatus = new HashMap<String, String>();
		
		try {
			appliedCandidatesWithStatus = cassandraOperations.queryForObject(appliedCandidates, Map.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			 appliedCandidatesWithStatus = new HashMap<String, String>();
		}
		return appliedCandidatesWithStatus == null ? new HashMap<String, String>() : appliedCandidatesWithStatus;
	}
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(applied_job) to Domain/Value Objects(StudentSearchJobs)
	 *
	 */
	/*private static class savedJobsMapper implements RowMapper<StudentDom> {
		public StudentDom mapRow(ResultSet rs, int rowNum)
		throws SQLException {
			StudentDom searchJobs = new StudentDom();
	searchJobs.setJobid_and_firmid(rs.getString("job_id"));
	searchJobs.setSaved_on(rs.getDate("saved_on_date"));
	searchJobs.setFlag(rs.getString("flag"));
	return searchJobs;
		}
	}*/
	
	

	
	/**
	 * This method is used to get the list of students who have applied for the internship with id:internshipId
	 * @param internshipId
	 * @return List<Student> studentEmails
	 */
	public List<StudentDom> getInternshipAppliedStudent(String internshipId) {

		String sql = "select student_emailid from applied_internship where internship_id = ? and flag = '1' ALLOW FILTERING";
		
		List<StudentDom> studentEmails = new ArrayList<StudentDom>();
		
		//List<StudentDom> studentEmails = getJdbcTemplate().query(sql, new studentEmailMapper(), internshipId);
	
		return studentEmails;
	}


	/**
	 * This method is used to save an internship
	 * @param internshipId
	 * @param candidateEmailId	
	 */
	@Override
	public void saveInternship(String internshipId,final String candidateEmailId) {
		
		//Fetch Internship Details
		String internshipQuery  = "SELECT * FROM internship_dtls WHERE internship_id_and_firm_id='"+internshipId+"' ALLOW FILTERING";
		JobDetailsDom internshipDetails = cassandraOperations.queryForObject(internshipQuery, new InternshipMapper());

		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, internshipDetails.getInternshipIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_SAVED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SAVED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, internshipDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, internshipDetails.getInternshipDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, internshipDetails.getInternshipTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, internshipDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, internshipDetails.getInternshipType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, internshipDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, internshipDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(internshipDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, internshipDetails.getStatus());
		
		String tracker = "Saved the Internship : "+internshipDetails.getInternshipTitle();
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";
		
		cassandraOperations.execute(queryForTracker);
		cassandraOperations.execute(insertIntoCandidateActivities);
	}
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(applied_job) to Domain/Value Objects(StudentSearchJobs)
	 *
	 */
	/*private static class AppliedJobsDtlsMapper implements RowMapper<StudentDom> {
		public StudentDom mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			StudentDom searchJobs = new StudentDom();
			searchJobs.setJobIdAndFirmId(rs.getString("job_id"));
			searchJobs.setApplied_on(rs.getDate("posted_on"));
			searchJobs.setFlag(rs.getString("flag"));
			searchJobs.setSaved_on(rs.getDate("saved_on_date"));

			return searchJobs;
		}
	}*/
	



	/**
	 * This class is used to Map the ResultSet values(applied_internship) to Domain/Value Objects(EmployerJobPost)
	 * @author BalajiI
	 *
	 */
	/*private static class AppliedInternshipDetailMapper implements RowMapper<JobDetailsDom> {
		public JobDetailsDom mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			JobDetailsDom savedInternshipDetails = new JobDetailsDom();
			savedInternshipDetails.setInternship_id_and_firm_id(rs.getString("internship_id"));
			savedInternshipDetails.setAppliedOn(rs.getDate("posted_on"));
			savedInternshipDetails.setFlag(rs.getString("flag"));
			savedInternshipDetails.setSaved_On(rs.getDate("saved_on_date"));

			return savedInternshipDetails;
		}
	}*/

	private class CampusJobMapper implements RowMapper<EmployerCampusJobPostDom>{
		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int arg1) throws DriverException {
			EmployerCampusJobPostDom campusJobDetails = new EmployerCampusJobPostDom();
			
			campusJobDetails.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			campusJobDetails.setFirmId(rs.getString("firm_id"));
			campusJobDetails.setJobId(rs.getString("job_id"));
			campusJobDetails.setJobTitle(rs.getString("job_title"));
			campusJobDetails.setJobType(rs.getString("job_type"));
			campusJobDetails.setJobLocation(rs.getString("location"));
			campusJobDetails.setJobDescription(rs.getString("description"));
			campusJobDetails.setPayPerWeek(rs.getString("payperweek"));
			campusJobDetails.setFunctionalArea(rs.getString("functional_area"));
			campusJobDetails.setIndustry(rs.getString("industry"));
			
			campusJobDetails.setStatus(rs.getString("status"));
			campusJobDetails.setPostedOn(rs.getString("posted_on"));
			campusJobDetails.setZipCode(rs.getString("zip_code"));
			
			campusJobDetails.setPrimarySkills(rs.getList("primary_skills",String.class));
			campusJobDetails.setSecondarySkills(rs.getList("secondary_skills",String.class));
			campusJobDetails.setFirmName(rs.getString("firm_name"));
			campusJobDetails.setCampusJobAppliedStudents(rs.getMap("applied_students",String.class,Date.class));
			
			campusJobDetails.setUniversityName(rs.getString("univ_name"));
			
			return campusJobDetails;
		}
		
	}
	
	
	/**
	 * This method is used when the candidate applies for a campus job
	 * @author PallaviD
	 * @return boolean isApplied
	 * @throws EmptyResultSetException
	 * 
	 */
	@Override
	public void applyBroadcastedJob(String jobId, String candidateEmailId,String universityName) 
	{
		// applied_students, job_title
		//Fetch Job Details
		String jobQuery  = "SELECT * FROM university_job_dtls WHERE job_id_and_firm_id='"+jobId+"' and univ_name = '"+universityName+"' ALLOW FILTERING";
		EmployerCampusJobPostDom appliedJobDetails = cassandraOperations.queryForObject(jobQuery, new CampusJobMapper());
				
		//Increment Response count
		String updateAppliedStudents = "update university_job_dtls set applied_students = applied_students +{'"+candidateEmailId+"':'"+new Date().getTime()+"'} where job_id_and_firm_id='"+jobId+"' and univ_name = '"+universityName+"'" ;
		String updateCandidateJobStatus = "update university_job_dtls set candidate_job_status = candidate_job_status + {'"+candidateEmailId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where job_id_and_firm_id='"+jobId+"' and univ_name = '"+universityName+"'" ;
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, appliedJobDetails.getJobIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, appliedJobDetails.getFirmName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, appliedJobDetails.getJobDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, appliedJobDetails.getJobTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, appliedJobDetails.getJobLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, appliedJobDetails.getJobType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, appliedJobDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, appliedJobDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(appliedJobDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.CAMPUS_JOB_FLAG);	
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, appliedJobDetails.getStatus());
		
		
		/*String countJobMaps = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_JOB_FLAG+"'";
		int jobMapCount = Integer.valueOf(cassandraOperations.queryForObject(countJobMaps, Long.class).toString());
		
		Map<String,Date> appliedJobMap = new HashMap<String, Date>();
		appliedJobMap.put(jobId, new Date());
		
		if(jobMapCount == 0)
		{
			Insert insertIntoJobActivities = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","applied_map"},
					new Object[]{emailId,CaerusAPIStringConstants.CAMPUS_JOB_FLAG,appliedJobMap });
			
			cassandraOperations.execute(insertIntoJobActivities);
		}
		else
		{
			String updateJobActivity = "update candidate_job_activities set applied_map = applied_map + {'"+jobId+"':'"+new Date().getTime()+"'} where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_JOB_FLAG+"'";
			cassandraOperations.execute(updateJobActivity);
		}*/
		
		String updateJobStatusMapQuery = "update student_details set campus_job_status = campus_job_status + {'"+jobId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		//Update Recent activities for student
		String jobTitle = appliedJobDetails.getJobTitle();
		String tracker = "Applied for Campus Job: "+jobTitle;
				
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";
				
		try {
			cassandraOperations.execute(insertIntoCandidateActivities);
			cassandraOperations.execute(updateJobStatusMapQuery);
			cassandraOperations.execute(updateCandidateJobStatus);
			cassandraOperations.execute(updateAppliedStudents);
			cassandraOperations.execute(queryForTracker);
		}
		catch(IllegalArgumentException | NoHostAvailableException ex)
		{
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
		}
	}
	
	
	public static class ApplyCampusJobMapper  implements RowMapper<EmployerCampusJobPostDom> {

		@Override
		public EmployerCampusJobPostDom mapRow(Row row, int arg1) throws DriverException {

			EmployerCampusJobPostDom appliedCampusJob = new EmployerCampusJobPostDom();
			
			appliedCampusJob.setCampusJobAppliedStudents(row.getMap("applied_students", String.class, Date.class));
			appliedCampusJob.setJobTitle(row.getString("job_title"));
			
			return appliedCampusJob;
		}
		
	}
	
	
	
	
	/**
	 * This method is used when the candidate applies for a campus internship
	 * @author PallaviD
	 * @param internshipId
	 * @return boolean isApplied
	 * 
	 */
	@Override
	public void applyBroadcastedInternship(String internshipId, String candidateEmailId,String universityName) 
	{
		
		//Fetch Job Details
		String jobQuery  = "SELECT * FROM university_internship_dtls WHERE internship_id_and_firm_id='"+internshipId+"' and univ_name = '"+universityName+"' ALLOW FILTERING";
		EmployerCampusJobPostDom internshipDetails = cassandraOperations.queryForObject(jobQuery, new CampusInternshipMapper());
				
		//Increment Response count
		String updateAppliedStudents = "update university_internship_dtls set applied_students = applied_students +{'"+candidateEmailId+"':'"+new Date().getTime()+"'} where internship_id_and_firm_id='"+internshipId+"' and univ_name = '"+universityName+"'" ;
		String updateCandidateIntenshipStatus = "update university_internship_dtls set candidate_internship_status = candidate_internship_status + {'"+candidateEmailId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where internship_id_and_firm_id='"+internshipId+"' and univ_name = '"+universityName+"'" ;
		String updateInternshipStatusMapQuery = "update student_details set campus_internship_status = campus_internship_status + {'"+internshipId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, internshipDetails.getInternshipIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, internshipDetails.getFirmName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, internshipDetails.getInternshipDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, internshipDetails.getInternshipTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, internshipDetails.getInternshipLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, internshipDetails.getInternshipType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, internshipDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, internshipDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(internshipDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG);	
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, internshipDetails.getStatus());
		
		
		/*String countJobMaps = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG+"'";
		int jobMapCount = Integer.valueOf(cassandraOperations.queryForObject(countJobMaps, Long.class).toString());
		
		Map<String,Date> appliedInternshipMap = new HashMap<String, Date>();
		appliedInternshipMap.put(internshipId, new Date());
		
		if(jobMapCount == 0)
		{
			Insert insertIntoJobActivities = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","applied_map"},
					new Object[]{emailId,CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG,appliedInternshipMap });
			
			cassandraOperations.execute(insertIntoJobActivities);
		}
		else
		{
			String updateJobActivity = "update candidate_job_activities set applied_map = applied_map + {'"+internshipId+"':'"+new Date().getTime()+"'} where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG+"'";
			cassandraOperations.execute(updateJobActivity);
		}*/
		
		
		
		//Update Recent activities for student
		String internshipTitle = internshipDetails.getInternshipTitle();
		String tracker = "Applied for Campus Internship: "+internshipTitle;
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";
				
		cassandraOperations.execute(insertIntoCandidateActivities);
		cassandraOperations.execute(updateAppliedStudents);
		cassandraOperations.execute(updateCandidateIntenshipStatus);
		cassandraOperations.execute(updateInternshipStatusMapQuery);
		cassandraOperations.execute(queryForTracker);
		
	}

	
	public static class ApplyCampusInternshipMapper  implements RowMapper<EmployerCampusJobPostDom> {

		@Override
		public EmployerCampusJobPostDom mapRow(Row row, int arg1) throws DriverException {

			EmployerCampusJobPostDom appliedCampusJob = new EmployerCampusJobPostDom();
			
			appliedCampusJob.setCampusJobAppliedStudents(row.getMap("applied_students", String.class, Date.class));
			appliedCampusJob.setJobTitle(row.getString("internship_title"));
			
			return appliedCampusJob;
		}
		
	}
	
	private class CampusInternshipMapper implements RowMapper<EmployerCampusJobPostDom>{
		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int arg1) throws DriverException {
			EmployerCampusJobPostDom campusInternshipDetails = new EmployerCampusJobPostDom();
			
			campusInternshipDetails.setInternshipIdAndFirmId(rs.getString("internship_id_and_firm_id"));
			campusInternshipDetails.setInternshipId(rs.getString("internship_id"));
			campusInternshipDetails.setFirmId(rs.getString("firm_id"));
			campusInternshipDetails.setInternshipTitle(rs.getString("internship_title"));
			campusInternshipDetails.setInternshipType(rs.getString("internship_type"));
			campusInternshipDetails.setApproximateHours(rs.getString("approximate_hours"));
			campusInternshipDetails.setStartDate(rs.getString("start_date"));
			campusInternshipDetails.setEndDate(rs.getString("end_date"));
			campusInternshipDetails.setPayPerHours(rs.getString("payper_hours"));
			campusInternshipDetails.setNumberOfVacancy(rs.getString("numberofvacancy"));
			campusInternshipDetails.setUniversityName(rs.getString("univ_name"));
			campusInternshipDetails.setPrimarySkills((List<String>) rs.getList("primary_skills",String.class));
			campusInternshipDetails.setSecondarySkills((List<String>) rs.getList("secondary_skills",String.class));
			campusInternshipDetails.setInternshipLocation(rs.getString("internship_location"));
			campusInternshipDetails.setInternshipDescription(rs.getString("internship_description"));
			campusInternshipDetails.setStatus(rs.getString("status"));
			campusInternshipDetails.setPostedOn(rs.getString("posted_on"));
			campusInternshipDetails.setFirmName(rs.getString("firm_name"));
			campusInternshipDetails.setZipCode(rs.getString("zip_code"));
			campusInternshipDetails.setUniversityName(rs.getString("univ_name"));
			campusInternshipDetails.setCampusInternshipAppliedStudents((Map<String, Date>)rs.getMap("applied_students",String.class,Date.class));
			
			return campusInternshipDetails;
		}
		
	}
	
	
	/**
	 * This method is used to get the candidates who have applied for the campus job with id:jobId
	 * @author RavishaG
	 * @param jobId
	 * @param universityName
	 * @return Map<String, Date> appliedStudentsMap
	 */
	@Override
	public Map<String, Date> getStudentsAppliedForJob(String jobId,String universityName) {
			String appliedStudentsMapQuery = "select applied_students from university_job_dtls where job_id_and_firm_id ='"+jobId+"' and univ_name ='"+universityName+"' ALLOW FILTERING";
			Map<String,Date> appliedStudentsMap = new HashMap<String, Date>();
			try {
				appliedStudentsMap = cassandraOperations.queryForObject(appliedStudentsMapQuery, Map.class);
			}
			catch(NullPointerException npe){
				logger.error("NullPointerException in getStudentsAppliedForJob");
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in getStudentsAppliedForJob");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in getStudentsAppliedForJob");
			}
			return appliedStudentsMap == null ? new HashMap<String, Date>():appliedStudentsMap;
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
		String appliedStudentsQuery = "select applied_students from university_internship_dtls where internship_id_and_firm_id ='"+internshipId+"' and univ_name ='"+universityName+"' ALLOW FILTERING";
		Map<String,Date> appliedStudentsMap = new HashMap<String, Date>();
		
		try { 
			appliedStudentsMap = cassandraOperations.queryForObject(appliedStudentsQuery, Map.class);
		}
		catch(NullPointerException npe){
			logger.error("NullPointerException in getStudentsAppliedForInternship");
		}
		catch(IllegalArgumentException argEx){
			logger.error("IllegalArgumentException in getStudentsAppliedForInternship");
		}
		catch(NoHostAvailableException noHostEx){
			logger.error("NoHostAvailableException in getStudentsAppliedForInternship");
		}	
		return appliedStudentsMap == null ? new HashMap<String, Date>() : appliedStudentsMap;
	}

	/*@SuppressWarnings("unchecked")
	@Override
	public Map<String, Date> getAppliedJobIdsMap(String candidateEmailId) {

		String getAppliedJobIdsWithTimestampQuery = "select applied_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.JOB_FLAG+"';";
		
		Map<String, Date> appliedJobIdsWithTimestamp = new HashMap<String, Date>();
		try {
			appliedJobIdsWithTimestamp = (Map<String, Date>) cassandraOperations.queryForObject(getAppliedJobIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			appliedJobIdsWithTimestamp = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getAppliedJobIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(appliedJobIdsWithTimestamp != null && appliedJobIdsWithTimestamp.size() > 0)
		{
			appliedJobIdsWithTimestamp = CaerusCommonUtility.sortMapOnTimestampValue(appliedJobIdsWithTimestamp);
		}
		return appliedJobIdsWithTimestamp == null ? new HashMap<String, Date>() : appliedJobIdsWithTimestamp;
	}*/

	/*@SuppressWarnings("unchecked")
	@Override
	public Map<String, Date> getAppliedInternshipIdsMap(String candidateEmailId) {
		
		String getAppliedInternshipIdsWithTimestampQuery = "select applied_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.INTERNSHIP_FLAG+"';";
		Map<String, Date> appliedInternshipIdsWithTimestamp = new HashMap<String, Date>();
		
		try{
			appliedInternshipIdsWithTimestamp = (Map<String, Date>) cassandraOperations.queryForObject(getAppliedInternshipIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			appliedInternshipIdsWithTimestamp = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getAppliedInternshipIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(appliedInternshipIdsWithTimestamp != null && appliedInternshipIdsWithTimestamp.size() > 0)
		{
			appliedInternshipIdsWithTimestamp = CaerusCommonUtility.sortMapOnTimestampValue(appliedInternshipIdsWithTimestamp);
		}
		return appliedInternshipIdsWithTimestamp == null ? new HashMap<String, Date>() : appliedInternshipIdsWithTimestamp;
	}

	@Override
	public Map<String, Date> getSavedJobIdsMap(String candidateEmailId) {

		String getSavedJobIdsWithTimestampQuery = "select saved_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.JOB_FLAG+"';";
		Map<String, Date> savedJobIdsWithTimestamp = new HashMap<String, Date>();
		
		try {
			savedJobIdsWithTimestamp =  cassandraOperations.queryForObject(getSavedJobIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			savedJobIdsWithTimestamp = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getSavedJobIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(savedJobIdsWithTimestamp != null && savedJobIdsWithTimestamp.size() > 0)
		{
			savedJobIdsWithTimestamp = CaerusCommonUtility.sortMapOnTimestampValue(savedJobIdsWithTimestamp);
		}
		return savedJobIdsWithTimestamp == null ? new HashMap<String, Date>() : savedJobIdsWithTimestamp;
	}
	

	@Override
	public Map<String, Date> getSavedInternshipIdsMap(String candidateEmailId) {
		
		String getSavedInternshipIdsWithTimestampQuery = "select saved_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.INTERNSHIP_FLAG+"';";
		Map<String, Date> savedInternshipIdsWithTimestamp = new HashMap<String, Date>();
		
		try {
			savedInternshipIdsWithTimestamp = (Map<String, Date>) cassandraOperations.queryForObject(getSavedInternshipIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			savedInternshipIdsWithTimestamp = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getSavedInternshipIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(savedInternshipIdsWithTimestamp != null && savedInternshipIdsWithTimestamp.size() > 0)
		{
			savedInternshipIdsWithTimestamp = CaerusCommonUtility.sortMapOnTimestampValue(savedInternshipIdsWithTimestamp);
		}
		return savedInternshipIdsWithTimestamp == null ? new HashMap<String, Date>() : savedInternshipIdsWithTimestamp;
	}*/

	@Override
	public StudentDom getDefaultProfileDetails(String candidateEmailId) {
		StudentDom defaultProfileDetails = new StudentDom();
		String getDefaultProfileDetails = "select * from student_profiles where is_default=true and email_id='"+candidateEmailId+"';";
		
		try {
			defaultProfileDetails = cassandraOperations.queryForObject(getDefaultProfileDetails, new StudentProfileMapper());
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getDefaultProfileDetails");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		return defaultProfileDetails == null ? new StudentDom() : defaultProfileDetails;
	}
	
	private class StudentProfileMapper implements RowMapper<StudentDom>{
		@Override
		public StudentDom mapRow(Row rs, int arg1) throws DriverException {
			StudentDom profileDetails = new StudentDom();
			profileDetails.setSecondarySkills(rs.getList("secondary_skills", String.class));
			profileDetails.setPrimarySkills(rs.getList("primary_skills", String.class));
			
			return profileDetails;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Date> getSavedAndAppliedJobIdsMap(String candidateEmailId) {
		String getSavedAndAppliedJobIdsWithTimestampQuery = "select saved_applied_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.JOB_FLAG+"';";
		Map<String, Date> savedAndAppliedJobIds = new HashMap<String, Date>();
		
		try {
			savedAndAppliedJobIds = (Map<String, Date>) cassandraOperations.queryForObject(getSavedAndAppliedJobIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			savedAndAppliedJobIds = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getSavedInternshipIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(savedAndAppliedJobIds != null && savedAndAppliedJobIds.size() > 0)
		{
			savedAndAppliedJobIds = CaerusCommonUtility.sortMapOnTimestampValue(savedAndAppliedJobIds);
		}
		return savedAndAppliedJobIds == null ? new HashMap<String, Date>() : savedAndAppliedJobIds;
	}

	@Override
	public void applyJob(String jobId,final String candidateEmailId) {
		//Fetch Job Details
		String jobQuery  = "SELECT * FROM job_dtls WHERE job_id_and_firm_id='"+jobId+"' ALLOW FILTERING";
		JobDetailsDom appliedJobDetails = cassandraOperations.queryForObject(jobQuery, new JobMapper());
				
		int responseCountForJob = Integer.valueOf(appliedJobDetails.getResponseCount().toString());
				
		//Increment Response count
		String updateResponseCount = "update job_dtls set response_count="+ (responseCountForJob + 1) + " where job_id_and_firm_id='"+jobId+"'";
		
		//Insert applied students map
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(jobId,true);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{ put(candidateEmailId,CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS); }}, jobId, incrementedAppliedCandidateCount, true);
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, appliedJobDetails.getJobIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, appliedJobDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, appliedJobDetails.getJobDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, appliedJobDetails.getJobTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, appliedJobDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, appliedJobDetails.getJobType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, appliedJobDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, appliedJobDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(appliedJobDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG);	
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, appliedJobDetails.getStatus());
		
		String updateJobStatusMapQuery = "update student_details set job_status = job_status + {'"+jobId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		//Update Recent activities for student
		String jobTitle = appliedJobDetails.getJobTitle();
		String tracker = "Applied for Job: "+jobTitle;
				
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";

		try {
			cassandraOperations.execute(updateResponseCount);
			cassandraOperations.execute(updateJobStatusMapQuery);
			cassandraOperations.execute(queryForTracker);
			cassandraOperations.execute(insertIntoCandidateActivities);
			logger.info(candidateEmailId +" "+ CaerusAPIStringConstants.CANDIDATE_APPLIED_JOB_LOGGER+" With Job Id "+appliedJobDetails.getJobIdAndFirmId());
		}
		catch(NoHostAvailableException | IllegalArgumentException ex){
			
		}
	}

	/**
	 * 
	 * @param Id (JobId or InternshipId)
	 * @param identifier (true for Jobs and flag for Internships)
	 * @return appliedCandidateCount
	 */
	private long getIncrementedAppliedCandidateCount(String id,boolean identifier){
		long appliedCandidateCount = 0;
		Select selectAppliedCandidateCount = null;
		if(identifier)
		{
			selectAppliedCandidateCount = QueryBuilder.select("applied_candidates_count").from("job_dtls");
			selectAppliedCandidateCount.where(QueryBuilder.eq("job_id_and_firm_id", id));
		}
		else
		{
			selectAppliedCandidateCount = QueryBuilder.select("applied_candidates_count").from("internship_dtls");
			selectAppliedCandidateCount.where(QueryBuilder.eq("internship_id_and_firm_id", id));
		}
			
		try {
			appliedCandidateCount = cassandraOperations.queryForObject(selectAppliedCandidateCount, Long.class);
		}
		catch(NullPointerException | IllegalArgumentException ex){
			appliedCandidateCount = 0;
		}
		return ++appliedCandidateCount;
	}
	
	
	
	private boolean updateAppliedCandidatesMap(Map<String,String> appliedCandidate,String id,long incrementedAppliedCandidateCount,boolean identifier){
		boolean flag = false;
		
		Update updateAppliedCandidate = null;
		
		if(identifier){
			updateAppliedCandidate = QueryBuilder.update("job_dtls");
			updateAppliedCandidate.with(QueryBuilder.putAll("applied_candidates_map",appliedCandidate));
			updateAppliedCandidate.with(QueryBuilder.set("applied_candidates_count", incrementedAppliedCandidateCount));
			
			updateAppliedCandidate.where(QueryBuilder.eq("job_id_and_firm_id", id));
		}
		else {
			updateAppliedCandidate = QueryBuilder.update("internship_dtls");
			updateAppliedCandidate.with(QueryBuilder.putAll("applied_candidates_map",appliedCandidate));
			updateAppliedCandidate.with(QueryBuilder.set("applied_candidates_count", incrementedAppliedCandidateCount));
			
			updateAppliedCandidate.where(QueryBuilder.eq("internship_id_and_firm_id", id));
		}
		
		try {
			cassandraOperations.execute(updateAppliedCandidate);
			flag = true;
		}
		catch(Exception ex){
			logger.error("Something Went Wrong in updateAppliedCandidatesMap "+ex.getStackTrace().toString());
		}
		return flag;
	}
	
	@Override
	public void saveJob(final String jobId, final String candidateEmailId) {
		//Fetch Job Details
		String jobQuery  = "SELECT * FROM job_dtls WHERE job_id_and_firm_id='"+jobId+"' ALLOW FILTERING";
		JobDetailsDom savedJobDetails = cassandraOperations.queryForObject(jobQuery, new JobMapper());
		
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(jobId,true);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{ put(candidateEmailId,CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS); }}, jobId, incrementedAppliedCandidateCount, true);
		
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, savedJobDetails.getJobIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_SAVED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SAVED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, savedJobDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, savedJobDetails.getJobDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, savedJobDetails.getJobTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, savedJobDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, savedJobDetails.getJobType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, savedJobDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, savedJobDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate( savedJobDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, savedJobDetails.getStatus());
		
		String jobTitle = savedJobDetails.getJobTitle();
		String tracker = "Saved the Job: "+jobTitle;
				
		String updateRecentActivities = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";

		try {  
			cassandraOperations.execute(updateRecentActivities);
			cassandraOperations.execute(insertIntoCandidateActivities);
			logger.info(candidateEmailId +" "+ CaerusAPIStringConstants.CANDIDATE_SAVED_JOB_LOGGER+" With Job Id "+savedJobDetails.getJobIdAndFirmId());
		}
		catch(NoHostAvailableException | IllegalArgumentException ex)
		{
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
		}
	}

	@SuppressWarnings("serial")
	@Override
	public void applySavedJob(String jobId,final String candidateEmailId) {
		
		//Fetch Job Details
		String jobQuery  = "SELECT * FROM job_dtls WHERE job_id_and_firm_id='"+jobId+"' ALLOW FILTERING";
		JobDetailsDom jobDetails = cassandraOperations.queryForObject(jobQuery, new JobMapper());
		
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(jobId,true);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{ put(candidateEmailId,CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS); }}, jobId, incrementedAppliedCandidateCount, true);
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, jobDetails.getJobIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, jobDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, jobDetails.getJobDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, jobDetails.getJobTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, jobDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, jobDetails.getJobType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, jobDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, jobDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(jobDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, jobDetails.getStatus());
		
		String updateJobStatusMapQuery = "update student_details set job_status = job_status + {'"+jobId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		//Update Recent activities for student
		String jobTitle = jobDetails.getJobTitle();
		String tracker = "Applied for Job: "+jobTitle;
				
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";

		try {
			cassandraOperations.execute(insertIntoCandidateActivities);
			cassandraOperations.execute(updateJobStatusMapQuery);
			cassandraOperations.execute(queryForTracker);
			logger.info(candidateEmailId +" "+ CaerusAPIStringConstants.CANDIDATE_APPLIED_JOB_LOGGER +" With Job Id "+jobDetails.getJobIdAndFirmId());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
		}
	}

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param jobIdList
	 * @return jobs
	 */
	@Override
	public List<JobDetailsDom> getJobDetails(List<String> jobIdList) {
		
		//Call to common function to convert string list to single string for IN Query
		String idListToString = CaerusCommonUtility.getCassandraInQueryString(jobIdList);
		String sqlQuery = "select * from job_dtls where job_id_and_firm_id IN ("+idListToString+")";
		List<JobDetailsDom> jobs = cassandraOperations.query(sqlQuery, new JobMapper());
		return jobs;
	}

	/**
	 * This Method is used to fetch internship details 
	 * @author PallaviD
	 * @param internshipIdList
	 * @return internships
	 */
	@Override
	public List<JobDetailsDom> getInternshipDetails(List<String> internshipIdList) {
		
		//Call to common function to convert string list to single string for IN Query
		String idListToString = CaerusCommonUtility.getCassandraInQueryString(internshipIdList);
		String sqlQuery = "select * from internship_dtls where internship_id_and_firm_id IN ("+idListToString+")";
		List<JobDetailsDom> internships = cassandraOperations.query(sqlQuery, new InternshipMapper());
		return internships;
	}

	/**
	 * This method is used to apply Internship
	 */
	@Override
	public void applyInternship(String internshipId,final String candidateEmailId) {
		
		//Fetch Internship Details
		String internshipQuery  = "SELECT * FROM internship_dtls WHERE internship_id_and_firm_id='"+internshipId+"' ALLOW FILTERING";
		JobDetailsDom appliedInternship = cassandraOperations.queryForObject(internshipQuery, new InternshipMapper());
		
		int responseCountForInternship = 0;
		
		if(null != appliedInternship.getResponseCount())
			responseCountForInternship = Integer.valueOf(appliedInternship.getResponseCount().toString());
		
		//Increment Response count
		String updateResponseCount = "update internship_dtls set response_count="+ (responseCountForInternship + 1) + " where internship_id_and_firm_id='"+internshipId+"'";
		
		/*//Insert applied students map
		String updateAppliedCandidatesQuery = "update internship_dtls set applied_candidates_map = applied_candidates_map + {'"+candidateEmailId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where internship_id_and_firm_id='"+internshipId+"'";
		cassandraOperations.execute(updateAppliedCandidatesQuery);
		*/
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(internshipId,false);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{ put(candidateEmailId,CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS); }}, internshipId, incrementedAppliedCandidateCount, false);
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, appliedInternship.getInternshipIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, appliedInternship.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, appliedInternship.getInternshipDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, appliedInternship.getInternshipTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, appliedInternship.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, appliedInternship.getInternshipType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, appliedInternship.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, appliedInternship.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(appliedInternship.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, appliedInternship.getStatus());
		
		String updateInternshipStatusMapQuery = "update student_details set internship_status = internship_status + {'"+internshipId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		//Update Recent activities for student
		String internshipTitle = appliedInternship.getInternshipTitle();
		String tracker = "Applied for Internship: "+internshipTitle;
		
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";
		
		cassandraOperations.execute(updateInternshipStatusMapQuery);
		cassandraOperations.execute(updateResponseCount);
		cassandraOperations.execute(queryForTracker);
		cassandraOperations.execute(insertIntoCandidateActivities);
		
	}

	@Override
	public Map<String, Date> getSavedAndAppliedInternshipIdsMap(
			String candidateEmailId) {
		String getSavedAndAppliedInternshipIdsWithTimestampQuery = "select saved_applied_map from candidate_job_activities where email_id='"+candidateEmailId+"' and flag='"+CaerusAPIStringConstants.INTERNSHIP_FLAG+"';";
		Map<String, Date> savedAndAppliedInternshipIds = new HashMap<String, Date>();
		
		try {
			savedAndAppliedInternshipIds = (Map<String, Date>) cassandraOperations.queryForObject(getSavedAndAppliedInternshipIdsWithTimestampQuery, Map.class);
		}
		catch(NullPointerException npe)
		{
			savedAndAppliedInternshipIds = new HashMap<String, Date>();
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getSavedInternshipIdsMap");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Hosts Available To Serve the Request");
		}
		
		if(savedAndAppliedInternshipIds != null && savedAndAppliedInternshipIds.size() > 0)
		{
			savedAndAppliedInternshipIds = CaerusCommonUtility.sortMapOnTimestampValue(savedAndAppliedInternshipIds);
		}
		return savedAndAppliedInternshipIds == null ? new HashMap<String, Date>() : savedAndAppliedInternshipIds;
	}

	@SuppressWarnings("serial")
	@Override
	public void applySavedInternship(String internshipId,final String candidateEmailId) 
	{
		//Fetch Internship Details
		String internshipQuery  = "SELECT * FROM internship_dtls WHERE internship_id_and_firm_id='"+internshipId+"' ALLOW FILTERING";
		JobDetailsDom internshipDetails = cassandraOperations.queryForObject(internshipQuery, new InternshipMapper());
		
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(internshipId,false);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{ put(candidateEmailId,CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS); }}, internshipId, incrementedAppliedCandidateCount, false);
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, internshipDetails.getInternshipIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, internshipDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, internshipDetails.getInternshipDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, internshipDetails.getInternshipTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, internshipDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, internshipDetails.getInternshipType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, internshipDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, internshipDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(internshipDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, internshipDetails.getStatus());
		
		String updateInternshipStatusMapQuery = "update student_details set internship_status = internship_status + {'"+internshipId+"':'"+CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS+"'} where email_id='"+candidateEmailId+"'";
		
		//Update Recent activities for student
		String internshipTitle = internshipDetails.getInternshipTitle();
		String tracker = "Applied for Internship: "+internshipTitle;
		
		String updateRecentActivities = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id ='"+candidateEmailId+"'";
		
		cassandraOperations.execute(insertIntoCandidateActivities);
		cassandraOperations.execute(updateInternshipStatusMapQuery);
		cassandraOperations.execute(updateRecentActivities);
	}

	@Override
	public Integer getCandidateAppliedPosition(Set<String> appliedCandidateEmailIds, String emailId) {
		List<Double> candidateScores = new ArrayList<Double>();
		Double specificCandidateScore = 0.0;
		Integer candidatePosition = 0;
		
		Select selectSpecificCandidateScore = QueryBuilder.select("i_score").from("student_details");
		selectSpecificCandidateScore.where(QueryBuilder.eq("email_id", emailId));
		
		Select selectCandidateScores = QueryBuilder.select("i_score").from("student_details");
		selectCandidateScores.where(QueryBuilder.in("email_id", appliedCandidateEmailIds.toArray()));
		
		try {
			candidateScores = cassandraOperations.queryForList(selectCandidateScores, Double.class);
			specificCandidateScore = cassandraOperations.queryForObject(selectSpecificCandidateScore, Double.class);
		}
		catch(NullPointerException | IllegalArgumentException ex){
			candidateScores = new ArrayList<Double>();
		}
		if(null != candidateScores && candidateScores.size() > 0){
			candidateScores.removeAll(Collections.singleton(null));
			Collections.sort(candidateScores,Collections.reverseOrder());
		}
		
		if(candidateScores.contains(specificCandidateScore)){
			candidatePosition = candidateScores.indexOf(specificCandidateScore);
		}
		/** Returning only if the Candidate's score is in Top 100 */
		return candidatePosition > 100 ? -1: candidatePosition ;
	}
	
	@Override
	public void updateViewedJobs(String emailId, String jobId) {
		
		Map<String,Date> viewedJob = new HashMap<String, Date>();
		viewedJob.put(jobId, new Date());
		
		Long count = 0L;
		String getCount = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.JOB_FLAG+"'";
		try {
			count = cassandraOperations.queryForObject(getCount,Long.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in Updating Job Views " +ex.getCause());
		}
		if(count > 0 ){
			Update updateViewedJobs = QueryBuilder.update("candidate_job_activities");
			updateViewedJobs.with(QueryBuilder.putAll("viewed_map", viewedJob));
			
			updateViewedJobs.where(QueryBuilder.eq("flag", CaerusAPIStringConstants.JOB_FLAG));
			updateViewedJobs.where(QueryBuilder.eq("email_id", emailId));
			try {
				cassandraOperations.execute(updateViewedJobs);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}
		}
		else {
			Insert insertViewJobMap = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","viewed_map"},
					new Object[]{emailId,
							CaerusAPIStringConstants.JOB_FLAG,
							viewedJob
						});
			
			try {
				cassandraOperations.execute(insertViewJobMap);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}		
		}
		
	}

	@Override
	public void updateViewedInternships(String emailId, String internshipId) {
		Map<String,Date> viewedInternship = new HashMap<String, Date>();
		viewedInternship.put(internshipId, new Date());
		
		Long count = 0L;
		String getCount = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.INTERNSHIP_FLAG+"'";
		try {
			count = cassandraOperations.queryForObject(getCount,Long.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in Updating Internship Views " +ex.getCause());
		}
		if(count > 0 ){
			Update updateViewedJobs = QueryBuilder.update("candidate_job_activities");
			updateViewedJobs.with(QueryBuilder.putAll("viewed_map", viewedInternship));
			
			updateViewedJobs.where(QueryBuilder.eq("flag", CaerusAPIStringConstants.INTERNSHIP_FLAG));
			updateViewedJobs.where(QueryBuilder.eq("email_id", emailId));
			try {
				cassandraOperations.execute(updateViewedJobs);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}
		}
		else {
			Insert insertViewJobMap = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","viewed_map"},
					new Object[]{emailId,
							CaerusAPIStringConstants.INTERNSHIP_FLAG,
							viewedInternship
						});
			
			try {
				cassandraOperations.execute(insertViewJobMap);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}		
		}
		
	}

	@Override
	public void updateViewedCampusInternship(String emailId, String internshipId) {
		Map<String,Date> viewedCampusInternship = new HashMap<String, Date>();
		viewedCampusInternship.put(internshipId, new Date());
		
		Long count = 0L;
		String getCount = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG+"'";
		try {
			count = cassandraOperations.queryForObject(getCount,Long.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in Updating Internship Views " +ex.getCause());
		}
		if(count > 0 ){
			Update updateViewedJobs = QueryBuilder.update("candidate_job_activities");
			updateViewedJobs.with(QueryBuilder.putAll("viewed_map", viewedCampusInternship));
			
			updateViewedJobs.where(QueryBuilder.eq("flag", CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG));
			updateViewedJobs.where(QueryBuilder.eq("email_id", emailId));
			try {
				cassandraOperations.execute(updateViewedJobs);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}
		}
		else {
			Insert insertViewJobMap = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","viewed_map"},
					new Object[]{emailId,
							CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG,
							viewedCampusInternship
						});
			
			try {
				cassandraOperations.execute(insertViewJobMap);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}		
		}
		
	}

	@Override
	public void updateViewedCampusJob(String emailId, String jobId) {
		Map<String,Date> viewedCampusJob = new HashMap<String, Date>();
		viewedCampusJob.put(jobId, new Date());
		
		Long count = 0L;
		String getCount = "select count(*) from candidate_job_activities where email_id='"+emailId+"' and flag='"+CaerusAPIStringConstants.CAMPUS_JOB_FLAG+"'";
		try {
			count = cassandraOperations.queryForObject(getCount,Long.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in Updating Internship Views " +ex.getCause());
		}
		if(count > 0 ){
			Update updateViewedJobs = QueryBuilder.update("candidate_job_activities");
			updateViewedJobs.with(QueryBuilder.putAll("viewed_map", viewedCampusJob));
			
			updateViewedJobs.where(QueryBuilder.eq("flag", CaerusAPIStringConstants.CAMPUS_JOB_FLAG));
			updateViewedJobs.where(QueryBuilder.eq("email_id", emailId));
			try {
				cassandraOperations.execute(updateViewedJobs);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}
		}
		else {
			Insert insertViewJobMap = QueryBuilder.insertInto("candidate_job_activities").values(
					new String[]{"email_id","flag","viewed_map"},
					new Object[]{emailId,
							CaerusAPIStringConstants.CAMPUS_JOB_FLAG,
							viewedCampusJob
						});
			
			try {
				cassandraOperations.execute(insertViewJobMap);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job Views " +ex.getCause());
			}		
		}
		
	}

	
	private static class JobDetailsMapper implements RowMapper<JobDetailsDom> {

		@Override
		public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
			JobDetailsDom jobDetails = new JobDetailsDom();

			jobDetails.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			jobDetails.setJobTitle(rs.getString("job_title"));
			jobDetails.setJobDescription(rs.getString("job_description"));
			jobDetails.setJobType(rs.getString("job_type"));
			jobDetails.setLocation(rs.getString("location"));
			jobDetails.setPostedOn(rs.getDate("job_posted_on").toString());
			jobDetails.setCompanyName(rs.getString("company_name"));
			jobDetails.setPrimarySkills(rs.getList("primary_skills",String.class));
			jobDetails.setSecondarySkills( rs.getList("secondary_skills",String.class));
			
			if(rs.getBool(CaerusAPIStringConstants.IS_APPLIED_FLAG)){
				jobDetails.setAppliedFlag(true);
				jobDetails.setAppliedOn(rs.getDate("applied_on"));
			}
			
			if(rs.getBool(CaerusAPIStringConstants.IS_SAVED_FLAG)){
				jobDetails.setSavedFlag("true");
				jobDetails.setSavedOn(rs.getDate("saved_on"));
			}
			
			/*job.setIndustry(rs.getString("industry"));*/
			/*job.setFunctionalArea(rs.getString("functional_area"));*/
			/*job.setStatus(rs.getString("status"));
			job.setZipCode(rs.getString("zip_code"));
			job.setResponseCount((long)rs.getInt("response_count"));*/
			
			return jobDetails;
		}
	}
	
	@Override
	public List<JobDetailsDom> getSavedJobs(String emailId) {
		List<JobDetailsDom> savedJobs = new ArrayList<JobDetailsDom>();
		
		Select getSavedJobs = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getSavedJobs.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG));
		getSavedJobs.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_SAVED_FLAG, true));
		getSavedJobs.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, emailId));
		getSavedJobs.allowFiltering();
		
		try {
			savedJobs = cassandraOperations.query(getSavedJobs , new JobDetailsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			 savedJobs = new ArrayList<JobDetailsDom>();
		}
		return null == savedJobs ? new ArrayList<JobDetailsDom>() : savedJobs;
	}

	@Override
	public List<JobDetailsDom> getSavedInternships(String loggedInUserEmail) {
		List<JobDetailsDom> savedInternships = new ArrayList<JobDetailsDom>();
		
		Select getSavedInternships = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getSavedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG));
		getSavedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_SAVED_FLAG, true));
		getSavedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getSavedInternships.allowFiltering();
		
		try {
			savedInternships = cassandraOperations.query(getSavedInternships , new JobDetailsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			 savedInternships = new ArrayList<JobDetailsDom>();
		}
		return null == savedInternships ? new ArrayList<JobDetailsDom>() : savedInternships;
	}

	@Override
	public List<JobDetailsDom> getAppliedInternships(String loggedInUserEmail) {
		List<JobDetailsDom> appliedInternships = new ArrayList<JobDetailsDom>();
		
		Select getAppliedInternships = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG));
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getAppliedInternships.allowFiltering();
		
		try {
			appliedInternships = cassandraOperations.query(getAppliedInternships , new JobDetailsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			 appliedInternships = new ArrayList<JobDetailsDom>();
		}
		return null == appliedInternships ? new ArrayList<JobDetailsDom>() : appliedInternships;	
	}

	@Override
	public int getAppliedJobsCount(String loggedInUserEmail) {
		int appliedJobCount = 0;
		
		Select getAppliedJobCount = QueryBuilder.select().countAll().from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedJobCount.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG));
		getAppliedJobCount.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedJobCount.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getAppliedJobCount.allowFiltering();
		
		try {
			long appliedJobCountL = cassandraOperations.queryForObject(getAppliedJobCount ,Long.class);
			if(0 != appliedJobCountL)
				appliedJobCount = (int) appliedJobCountL;
			
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
		}
		return appliedJobCount;
	}

	@Override
	public List<JobDetailsDom> getAppliedJobs(String loggedInUserEmail) {
		List<JobDetailsDom> appliedInternships = new ArrayList<JobDetailsDom>();
		
		Select getAppliedInternships = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG));
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedInternships.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getAppliedInternships.allowFiltering();
		
		try {
			appliedInternships = cassandraOperations.query(getAppliedInternships , new JobDetailsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			 appliedInternships = new ArrayList<JobDetailsDom>();
		}
		return null == appliedInternships ? new ArrayList<JobDetailsDom>() : appliedInternships;
	}

	@Override
	public List<String> getAppliedJobIds(String loggedInUserEmail) {
		List<String> appliedJobIds = new ArrayList<String>();
		
		Select getAppliedJobIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG));
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getAppliedJobIds.allowFiltering();
		
		try {
			appliedJobIds = cassandraOperations.queryForList(getAppliedJobIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			appliedJobIds = new ArrayList<String>();
		}
		return null == appliedJobIds ? new ArrayList<String>() : appliedJobIds;
	}

	@Override
	public List<String> getAppliedInternshipIds(String emailId) {
		List<String> appliedInternshipIds = new ArrayList<String>();
		
		Select getAppliedJobIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNSHIP_FLAG));
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, emailId));
		getAppliedJobIds.allowFiltering();
		
		try {
			appliedInternshipIds = cassandraOperations.queryForList(getAppliedJobIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			appliedInternshipIds = new ArrayList<String>();
		}
		return null == appliedInternshipIds ? new ArrayList<String>() : appliedInternshipIds;
	}

	@Override
	public List<String> getSavedJobIds(String loggedInUserEmail) {
		List<String> savedJobIds = new ArrayList<String>();
		
		Select getSavedJobIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getSavedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.JOB_FLAG));
		getSavedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_SAVED_FLAG, true));
		getSavedJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, loggedInUserEmail));
		getSavedJobIds.allowFiltering();
		
		try {
			savedJobIds = cassandraOperations.queryForList(getSavedJobIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			savedJobIds = new ArrayList<String>();
		}
		return null == savedJobIds ? new ArrayList<String>() : savedJobIds;
	}

	@Override
	public List<String> getAppliedCampusJobIds(String candidateEmailId) {
		List<String> appliedCampusJobIds = new ArrayList<String>();
		
		Select getAppliedCampusJobIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedCampusJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.CAMPUS_JOB_FLAG));
		getAppliedCampusJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedCampusJobIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId));
		getAppliedCampusJobIds.allowFiltering();
		
		try {
			appliedCampusJobIds = cassandraOperations.queryForList(getAppliedCampusJobIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			appliedCampusJobIds = new ArrayList<String>();
		}
		return null == appliedCampusJobIds ? new ArrayList<String>() : appliedCampusJobIds;
	}

	@Override
	public List<String> getAppliedCampusInternshipIds(String candidateEmailId) {
		List<String> appliedInternshipIds = new ArrayList<String>();
		
		Select getAppliedInternshipIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedInternshipIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG));
		getAppliedInternshipIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedInternshipIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId));
		getAppliedInternshipIds.allowFiltering();
		
		try {
			appliedInternshipIds = cassandraOperations.queryForList(getAppliedInternshipIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			appliedInternshipIds = new ArrayList<String>();
		}
		return null == appliedInternshipIds ? new ArrayList<String>() : appliedInternshipIds;
	}

	@Override
	public void applyToInternalPostings(String internshipIdAndFirmId,String universityName, final String candidateEmailId) {
		Update updateUniversityInternship = QueryBuilder.update(CaerusAPIStringConstants.TABLE_UNIVERSITY_INTERNSHIP_DTLS);
		updateUniversityInternship.with(QueryBuilder.putAll(CaerusAPIStringConstants.APPLIED_STUDENTS, new HashMap<String,Date>(){{
				put(candidateEmailId, new Date());
		}}));
		updateUniversityInternship.with(QueryBuilder.putAll(CaerusAPIStringConstants.CANDIDATE_INTERNSHIP_STATUS, new HashMap<String,String>(){{
			put(candidateEmailId, CaerusAPIStringConstants.JOB_STATUS_APPLIED);
		}}));
		
		updateUniversityInternship.where(QueryBuilder.eq(CaerusAPIStringConstants.INTERNSHIP_ID_AND_FIRM_ID, internshipIdAndFirmId));
		updateUniversityInternship.where(QueryBuilder.eq(CaerusAPIStringConstants.UNIVERSITY_NAME, universityName));

		JobDetailsDom internshipDetails = employerJobPostDao.getCampusInternshipDetails(internshipIdAndFirmId, universityName);
		
		Insert insertIntoCandidateActivities = QueryBuilder.insertInto(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, internshipDetails.getInternshipIdAndFirmId());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.IS_APPLIED_FLAG, true);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.APPLIED_ON, new Date());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.COMPANY_NAME, internshipDetails.getCompanyName());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_DESCRIPTION, internshipDetails.getInternshipDescription());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TITLE, internshipDetails.getInternshipTitle());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_LOCATION, internshipDetails.getLocation());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE, internshipDetails.getInternshipType());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.PRIMARY_SKILLS, internshipDetails.getPrimarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.SECONDARY_SKILLS, internshipDetails.getSecondarySkills());
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_POSTED_ON, CaerusCommonUtility.stringToDate(internshipDetails.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT));
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNAL_POSTINGS_FLAG);
		insertIntoCandidateActivities.value(CaerusAPIStringConstants.JOB_STATUS, internshipDetails.getStatus());

		try {
			cassandraOperations.execute(updateUniversityInternship);
			cassandraOperations.execute(insertIntoCandidateActivities);
		}
		catch(IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
		}
	}

	@Override
	public List<String> getAppliedInternalPostingIds(String candidateEmailId) {
		List<String> appliedInternalPostingIds = new ArrayList<String>();
		
		Select getAppliedInternalPostingIds = QueryBuilder.select(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID).from(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
		getAppliedInternalPostingIds.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_TYPE_IDENTIFIER, CaerusAPIStringConstants.INTERNAL_POSTINGS_FLAG));
		getAppliedInternalPostingIds.where(QueryBuilder.eq(CaerusAPIStringConstants.IS_APPLIED_FLAG, true));
		getAppliedInternalPostingIds.where(QueryBuilder.eq(CaerusAPIStringConstants.CANDIDATE_EMAIL_ID, candidateEmailId));
		getAppliedInternalPostingIds.allowFiltering();
		
		try {
			appliedInternalPostingIds = cassandraOperations.queryForList(getAppliedInternalPostingIds , String.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			appliedInternalPostingIds = new ArrayList<String>();
		}
		return null == appliedInternalPostingIds ? new ArrayList<String>() : appliedInternalPostingIds;
	}
}