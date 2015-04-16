package caerusapp.dao.employer;

import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.dao.common.AsyncActivities;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;

public class EmployerJobPostDao implements IEmployerJobPostDao {

	Log logger = LogFactory.getLog(getClass());
	
	
	@Autowired
	CassandraOperations cassandraOperations;

	@Autowired
	AsyncActivities asyncActivities;
	
	/**
	 * Static Variables are used for retaining certain Values
	 * Elsewhere(addJobParametersToJobMapper())
	 */
	private static Date postedOn = null;
	private static String jobIdAndFirmId = null;
	
/** Mapper Section */
	
	
	/**
	 * This class is used to Map the ResultSet values to Domain/Value Objects.
	 */
	public static class InternshipDetailsMapper implements RowMapper<JobDetailsDom> {
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
			internshipDetails.setResponseCount( (long) rs.getInt("response_count"));

			return internshipDetails;

		}
	}
	
	
	private class JobDetailsMapper implements RowMapper<JobDetailsDom>{

		@Override
		public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
			JobDetailsDom jobDetails = new JobDetailsDom();

			jobDetails.setJobTitle(rs.getString("job_title"));
			jobDetails.setJobDescription(rs.getString("description"));
			jobDetails.setJobType(rs.getString("job_type"));
			jobDetails.setPayPerWeek(rs.getString("salary"));
			jobDetails.setLocation(rs.getString("location"));
			jobDetails.setIndustry(rs.getString("industry"));
			jobDetails.setFunctionalArea(rs.getString("functional_area"));
			
			if(null != rs.getDate("posted_on"))
				jobDetails.setPostedOn(rs.getDate("posted_on").toString());
			
			jobDetails.setCompanyName(rs.getString("firm_name"));
			jobDetails.setEmailId(rs.getString("firm_id"));
			jobDetails.setJobId(rs.getString("job_id"));
			jobDetails.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			jobDetails.setPrimarySkills(rs.getList("primary_skills",String.class));
			jobDetails.setSecondarySkills( rs.getList("secondary_skills",String.class));
			jobDetails.setExperienceFrom(rs.getString("experience_from"));
			jobDetails.setExperienceTo(rs.getString("experience_to"));
			jobDetails.setJobAppliedStudents(rs.getMap("applied_candidates_map", String.class, String.class));
			
			//jobDetails.setGpaCutOffFrom(rs.getString("gpa_cut_off_from"));
			//jobDetails.setGpaCutOffTo(rs.getString("gpa_cut_off_to"));
			//jobDetails.setEligibleStreams( rs.getList("eligible_streams",String.class));
			jobDetails.setStatus(rs.getString("status"));
			jobDetails.setZipCode(rs.getString("zip_code"));
			jobDetails.setResponseCount((long)rs.getInt("response_count"));

			return jobDetails;
		}
		
	}
	
	
	/** Mapper Section */
	
	@Override
	public void publishJob(JobDetailsDom jobDetailsDom) {
		
		lastInsertedJobId = getLastInsertedJobID();
		Date date = new Date();

		postedOn = date;
		String jobIdAndFirmId = "";

		if(jobDetailsDom.getJobUpdateFlag() != null && jobDetailsDom.getJobUpdateFlag())
			jobIdAndFirmId = jobDetailsDom.getJobIdAndFirmId();
		else
		{
			lastInsertedJobId = getLastInsertedJobID();
			jobIdAndFirmId = lastInsertedJobId + "_"+jobDetailsDom.getEmailId();
		}
		
		asyncActivities.updateCandidateActivitiesJob(jobIdAndFirmId, jobDetailsDom, false);
		
		Insert insertJobDetails = null;
		
			if(null != jobDetailsDom.getStatus() && jobDetailsDom.getStatus().equalsIgnoreCase(CaerusAPIStringConstants.JOB_STATUS_CLOSED)){
				cassandraOperations.execute(QueryBuilder.update("job_dtls").with(QueryBuilder.set("closed_on", new Date())).where(QueryBuilder.eq("job_id_and_firm_id", jobIdAndFirmId)));
			}
			else {
				jobDetailsDom.setStatus(CaerusAPIStringConstants.JOB_STATUS_PUBLISHED);
			}
				insertJobDetails = QueryBuilder.insertInto("job_dtls").values(new String[]{
						"job_id_and_firm_id",
						"firm_id",
						"job_id",
						"job_title",
						"job_type",
						"salary",
						"functional_area",
						"location",
						"industry",
						"primary_skills",
						"secondary_skills",
						"experience_from",
						"experience_to",
						"description",
						"status",
						"firm_name",
						"zip_code",
						"is_deleted",
						"posted_on"
				},
					new Object[] {
							jobIdAndFirmId,
							jobDetailsDom.getEmailId(), 
							jobDetailsDom.getJobId(),
							jobDetailsDom.getJobTitle(),
							jobDetailsDom.getJobType(),
							jobDetailsDom.getPayPerWeek(),
							jobDetailsDom.getFunctionalArea(),
							jobDetailsDom.getLocation(),
							jobDetailsDom.getIndustry(),
							jobDetailsDom.getPrimarySkills(),
							jobDetailsDom.getSecondarySkills(),
							jobDetailsDom.getExperienceFrom(),
							jobDetailsDom.getExperienceTo(),
							jobDetailsDom.getJobDescription(), 
							jobDetailsDom.getStatus(),
							jobDetailsDom.getCompanyName(),
							jobDetailsDom.getZipCode(),
							false ,
							new Date()
				});
				
			
			try {
				cassandraOperations.execute(insertJobDetails);
			}
			catch(IllegalArgumentException | NoHostAvailableException ex){
				logger.error("Something Went Wrong in publishJob DAO "+ex.getLocalizedMessage());
			}
	}

	/**
	 * This method is used to retrieve the last inserted job id
	 * @return String(lastInsertedJobId)
	 */
	public String getLastInsertedJobID() {
		String getLastJobId = "select value from auto_increment where job_id ='last_inserted_job_id'";
		Integer lastInsertedJobId = Integer.parseInt(cassandraOperations.queryForObject(getLastJobId,BigInteger.class).toString());
		
		Integer newJobId = lastInsertedJobId + 1;
		
		String updateLastId = "update auto_increment set value = " + newJobId+" where job_id='last_inserted_job_id'";
		cassandraOperations.execute(updateLastId);

		return Integer.toString(lastInsertedJobId);

	}
	String lastInsertedJobId = null;
	
	@Override
	public void saveJob(JobDetailsDom jobDetails) {
			lastInsertedJobId = getLastInsertedJobID();
			Date date = new Date();
			
			String jobIdAndFirmId = "";
			
			if(jobDetails.getJobUpdateFlag() != null && jobDetails.getJobUpdateFlag())
				jobIdAndFirmId = jobDetails.getJobIdAndFirmId();
			else
			{
				lastInsertedJobId = getLastInsertedJobID();
				jobIdAndFirmId = lastInsertedJobId + "_"+jobDetails.getEmailId();
				jobDetails.setStatus("Draft");
			}
			
			Insert insertJobDetails = QueryBuilder.insertInto("job_dtls").
					values(
							new String[]{"job_id_and_firm_id","firm_id","job_id","job_title","job_type","salary",
						"functional_area","location","industry","primary_skills","secondary_skills","experience_from",
						"experience_to","description","status",
						"posted_on","firm_name","zip_code","is_deleted"}, 
		
						new Object[] {
				jobIdAndFirmId,
				jobDetails.getEmailId(), 
				jobDetails.getJobId(),
				jobDetails.getJobTitle(),
				jobDetails.getJobType(),
				jobDetails.getPayPerWeek(),
				jobDetails.getFunctionalArea(),
				jobDetails.getLocation(),
				jobDetails.getIndustry(), 
				jobDetails.getPrimarySkills(),
				jobDetails.getSecondarySkills(),
				jobDetails.getExperienceFrom(),
				jobDetails.getExperienceTo(),
				jobDetails.getJobDescription(),
				jobDetails.getStatus(), 
				date,
				jobDetails.getCompanyName(),
				jobDetails.getZipCode(),false });
			
			cassandraOperations.execute(insertJobDetails);
			
			if(jobDetails.getStatus().equals(CaerusAPIStringConstants.JOB_STATUS_CLOSED)){
				cassandraOperations.execute(QueryBuilder.update("job_dtls").with(QueryBuilder.set("closed_on", new Date())).where(QueryBuilder.eq("job_id_and_firm_id", jobIdAndFirmId)));
			}
			
		}
		
		
	@Override
	public int getJobIdCount(String jobId) {
		String query = "select count(*) from job_dtls where job_id='"+jobId+"'";
		int count = Integer.valueOf(cassandraOperations.queryForObject(query,Long.class).toString());
		return count;
	}

	@Override
	public List<JobDetailsDom> getAllInternshipsPostedByEmployer(String firmId) {
		String fetchInternships = "select * from internship_dtls where firm_id ='"+firmId+"' and is_deleted=false allow filtering;";
		List<JobDetailsDom> internships = (List<JobDetailsDom>) cassandraOperations.query(fetchInternships, new InternshipDetailsMapper());
		return internships == null ? new ArrayList<JobDetailsDom>() : internships;
	}
	

	/**
	 * This method is used to retrieve All Jobs Posted by the Employer
	 * @param String employerId
	 * @return List(employerJobs)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getAllJobsPostedByEmployer(String employerId) {
		String fetchAllEmployerJobs = "select * from job_dtls where firm_id ='"+employerId+"' and is_deleted=false allow filtering;";
		List employerJobs = cassandraOperations.query(fetchAllEmployerJobs, new JobDetailsMapper());
		return employerJobs == null ? new ArrayList<JobDetailsDom>(): employerJobs;
	}
	
	/**
	 * This method is used to get the response count of Job
	 * @param jobId
	 * @return Integer(responseCountForJob)
	 */
	@Override
	public Integer getResponseCountForJob(String jobId) {
		String jobResponseCount = "select count(1) from applied_job where job_id ='"+jobId+"' and flag = '1' allow filtering";
		int responseCountForJob =  Integer.valueOf(cassandraOperations.queryForObject(jobResponseCount,Long.class).toString());
		return responseCountForJob;
	}

	/**
	 * This method is used to get the response count of internship
	 * @param internshipId
	 * @return Integer(responseCountForInternship)
	 */
	@Override
	public Integer getResponseCountForInternship(String internshipId) {
		String internshipResponseCount = "select count(1) from applied_internship where internship_id ='"+internshipId+"' and flag = '1' allow filtering";
		int responseCountForInternship = Integer.valueOf(cassandraOperations.queryForObject(internshipResponseCount,Long.class).toString());
		return responseCountForInternship;
	}

	/**
	 * This method is used to retrieve job details by jobid
	 * @param String jobId
	 * @return EmployerJobPost(postJobdet)
	 */
	@Override
	public JobDetailsDom getJobDetailsByJobIdAndFirmId(String jobId) {
		String fetchJobDetails = "select * from job_dtls where job_id_and_firm_id ='"+jobId+"';";
		JobDetailsDom jobDetails = (JobDetailsDom) cassandraOperations.queryForObject(fetchJobDetails,new JobDetailsMapper());
		return jobDetails == null ? new JobDetailsDom() : jobDetails;
	}

	/**
	 * This method is used to Update job details by jobId_firmId and JobDetails
	 * @param String jobId
	 * @param EmployerJobPost jobDetails
	 */
	@Override
	public void updatePostedJob(JobDetailsDom jobDetails) {
		Date currentDate = new Date();
		postedOn = currentDate;
		
		Insert insertJobDetails = QueryBuilder.insertInto("job_dtls").values(new String[]{
				"job_type","salary","functional_area","industry","location",
				"primary_skills","secondary_skills","experience_from","experience_to",
				"description","status","posted_on","zip_code","job_id_and_firm_id"
				},
				new Object[] { 
				jobDetails.getJobType(), 
				jobDetails.getPayPerWeek(),
				jobDetails.getFunctionalArea(), 
				jobDetails.getIndustry(),
				jobDetails.getLocation(),
				jobDetails.getPrimarySkills(),
				jobDetails.getSecondarySkills(),
				jobDetails.getExperienceFrom(),
				jobDetails.getExperienceTo(),
				jobDetails.getGpaCutOffFrom(),
				jobDetails.getGpaCutOffTo(), 
				jobDetails.getJobDescription(),
				jobDetails.getStatus(),
				currentDate,
				jobDetails.getZipCode(), 
				jobDetails.getJobId()});

		
		cassandraOperations.execute(insertJobDetails);
		if(jobDetails.getStatus().equals(CaerusAPIStringConstants.JOB_STATUS_CLOSED)){
			cassandraOperations.execute(QueryBuilder.update("job_dtls").with(QueryBuilder.set("closed_on", new Date())).where(QueryBuilder.eq("job_id_and_firm_id", jobDetails.getJobId())));
		}
		
	}

	@Override
	public void deletePostedJob(String jobId) {
		String deleteJob = "update job_dtls set is_deleted=true where job_id_and_firm_id='"+jobId+"';";
		cassandraOperations.execute(deleteJob);
	}

	@Override
	public int getInternshipIdCount(String internshipId) {
		String query = "select count(*) from internship_dtls where internship_id='"+internshipId+"'";
		int internshipIdCount = Integer.valueOf(cassandraOperations.queryForObject(query,Long.class).toString());
		return internshipIdCount;
	}

	@Override
	public void saveInternship(JobDetailsDom internshipDetails) {
		Date postedOn = new Date();
		String internshipIdAndFirmId = internshipDetails.getInternshipId() + "_" + internshipDetails.getEmailId();
		internshipDetails.setStatus(CaerusAPIStringConstants.JOB_STATUS_DRAFT);
		
		Insert saveInternship = QueryBuilder.insertInto("internship_dtls").values(new String[]{
				"internship_id_and_firm_id","firm_id","internship_id","internship_title",
				"internship_type","description","posted_on","start_date","end_date","approximate_hours",
				"pay_per_hour","primary_skills","secondary_skills","location","status","firm_name","zip_code","is_deleted"}
		,new Object[] {
				internshipIdAndFirmId,
		internshipDetails.getEmailId(),
		internshipDetails.getInternshipId(),
		internshipDetails.getInternshipTitle(),
		internshipDetails.getInternshipType(),
		internshipDetails.getInternshipDescription(), 
		postedOn,
		internshipDetails.getStartDate(), 
		internshipDetails.getEndDate(),
		internshipDetails.getApproximateHours(),
		internshipDetails.getPayPerHour(),
		internshipDetails.getPrimarySkills(), 
		internshipDetails.getSecondarySkills(),
		internshipDetails.getLocation(),
		internshipDetails.getStatus(),
		internshipDetails.getCompanyName(),
		internshipDetails.getZipCode(),false});
		
		cassandraOperations.execute(saveInternship);
		
		}
	
	@Override
	public void publishInternship(JobDetailsDom internshipDetails) {
		Date postedOn = new Date();
		
		internshipDetails.setStatus(CaerusAPIStringConstants.JOB_STATUS_PUBLISHED);
		String internshipIdAndFirmId = internshipDetails.getInternshipId() + "_" + internshipDetails.getEmailId();

		asyncActivities.updateCandidateActivitiesInternship(internshipIdAndFirmId, internshipDetails,false);

		Insert saveInternship = QueryBuilder.insertInto("internship_dtls").values(new String[]{
				"internship_id_and_firm_id","firm_id","internship_id","internship_title",
				"internship_type","description","posted_on","start_date","end_date","approximate_hours",
				"pay_per_hour","primary_skills","secondary_skills","location","status","firm_name","zip_code","is_deleted"}
		,new Object[] {
				internshipIdAndFirmId,
		internshipDetails.getEmailId(),
		internshipDetails.getInternshipId(),
		internshipDetails.getInternshipTitle(),
		internshipDetails.getInternshipType(),
		internshipDetails.getInternshipDescription(), 
		postedOn,
		internshipDetails.getStartDate(), 
		internshipDetails.getEndDate(),
		internshipDetails.getApproximateHours(),
		internshipDetails.getPayPerHour(),
		internshipDetails.getPrimarySkills(), 
		internshipDetails.getSecondarySkills(),
		internshipDetails.getLocation(),
		internshipDetails.getStatus(),
		internshipDetails.getCompanyName(),
		internshipDetails.getZipCode(),false});
		
		cassandraOperations.execute(saveInternship);
		
		}

		@Override
		public JobDetailsDom getInternshipDetailsByInternshipIdAndFirmId(String internshipIdAndFirmId) {
			String sql = "select * from internship_dtls where internship_id_and_firm_id = '"+internshipIdAndFirmId+"';";
			
			JobDetailsDom internshipDetails = new JobDetailsDom();
			try {
				internshipDetails = cassandraOperations.queryForObject(sql, new InternshipDetailsMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getInternshipDetailsByInternshipIdAndFirmId");
			}
			return internshipDetails == null ? new JobDetailsDom():internshipDetails;
		}

		@Override
		public void deleteInternship(String internshipIdAndFirmId) {
			String deleteInternship = "update internship_dtls set is_deleted=true where internship_id_and_firm_id='"+internshipIdAndFirmId+"';";
			cassandraOperations.execute(deleteInternship);
		}

		@SuppressWarnings("unchecked")
		@Override
		public Map<String, String> getAppliedCandidateEmailIds(String jobId) {
			Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
			try{
				appliedCandidateEmailIds = (Map<String, String>) cassandraOperations.queryForObject("select applied_candidates_map from job_dtls where job_id_and_firm_id='"+jobId+"';",Map.class);
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getAppliedCandidateEmailIds");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			catch(NullPointerException npe)
			{
				appliedCandidateEmailIds = new HashMap<String, String>();
			}
			return appliedCandidateEmailIds == null ? new HashMap<String, String>(): appliedCandidateEmailIds;
		}

		@Override
		public List<JobDetailsDom> getJobsForJobIds(String cassandraInQuery) {
			
			List<JobDetailsDom> jobsForJobIds = new ArrayList<JobDetailsDom>();
			String getJobsUsingInClause = "select * from job_dtls where job_id_and_firm_id in ("+cassandraInQuery+")";
			
			try {
				jobsForJobIds = cassandraOperations.query(getJobsUsingInClause, new JobDetailsMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getJobsForJobIds");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			return jobsForJobIds == null ? new ArrayList<JobDetailsDom>() : jobsForJobIds;
		}

		@Override
		public void saveCampusJob(JobDetailsDom campusJobDetailsDom) {
			if(campusJobDetailsDom.getCampusJobRecipients() != null && campusJobDetailsDom.getCampusJobRecipients().size() > 0)
			{
				for (int i = campusJobDetailsDom.getCampusJobRecipients().size() - 1 ; i >= 0; i--) {
					jobIdAndFirmId = (campusJobDetailsDom.getJobId().concat("_")).concat(campusJobDetailsDom.getEmailId());
					
					campusJobDetailsDom.setStatus(CaerusAPIStringConstants.JOB_STATUS_DRAFT);
					
					Integer experienceFrom = 0;
					Integer experienceTo = 0;
					
					if(campusJobDetailsDom.getExperienceFrom() != null && campusJobDetailsDom.getExperienceFrom().length() > 0)
					{
						experienceFrom = Integer.valueOf(campusJobDetailsDom.getExperienceFrom());
					}
					
					if(campusJobDetailsDom.getExperienceTo() != null && campusJobDetailsDom.getExperienceTo().length() > 0)
					{
						experienceTo = Integer.valueOf(campusJobDetailsDom.getExperienceTo());
					}
					
					Insert insertCampusJobDetails = QueryBuilder.insertInto("university_job_dtls").values(new String[]{
							"job_id_and_firm_id","univ_name","description","location",
							"functional_area","industry","job_id","job_title","job_type","firm_id",
							"primary_skills","secondary_skills","payperweek",
							"yearofexperiencefrom","yearofexperienceto",
							"posted_on","firm_name","status","zip_code","is_deleted"},
							new Object[] {
							jobIdAndFirmId,
							campusJobDetailsDom.getCampusJobRecipients().get(i),
							campusJobDetailsDom.getJobDescription(),
							campusJobDetailsDom.getLocation(),
							campusJobDetailsDom.getFunctionalArea(),
							campusJobDetailsDom.getIndustry(),
							campusJobDetailsDom.getJobId(),
							campusJobDetailsDom.getJobTitle(),
							campusJobDetailsDom.getJobType(),
							campusJobDetailsDom.getEmailId(),
							campusJobDetailsDom.getPrimarySkills(),
							campusJobDetailsDom.getSecondarySkills(),
							campusJobDetailsDom.getPayPerWeek(),
							experienceFrom,
							experienceTo,
							campusJobDetailsDom.getPostedOn(),
							campusJobDetailsDom.getCompanyName(),
							campusJobDetailsDom.getStatus(),
							campusJobDetailsDom.getZipCode(),false});
					
					cassandraOperations.execute(insertCampusJobDetails);
					
				}
			}
		}

		@Override
		public void publishCampusJob(JobDetailsDom campusJobDetailsDom) {
			jobIdAndFirmId = (campusJobDetailsDom.getJobId().concat("_")).concat(campusJobDetailsDom.getEmailId());

			asyncActivities.updateCandidateActivitiesJob(jobIdAndFirmId, campusJobDetailsDom ,true);
			
			if(campusJobDetailsDom.getCampusJobRecipients() != null && campusJobDetailsDom.getCampusJobRecipients().size() > 0)
			{
				for (int i = campusJobDetailsDom.getCampusJobRecipients().size() - 1 ; i >= 0; i--) {
					
					campusJobDetailsDom.setStatus(CaerusAPIStringConstants.JOB_STATUS_PUBLISHED);
					
					Integer experienceFrom = 0;
					Integer experienceTo = 0;
					
					if(campusJobDetailsDom.getExperienceFrom() != null && campusJobDetailsDom.getExperienceFrom().length() > 0)
					{
						experienceFrom = Integer.valueOf(campusJobDetailsDom.getExperienceFrom());
					}
					
					if(campusJobDetailsDom.getExperienceTo() != null && campusJobDetailsDom.getExperienceTo().length() > 0)
					{
						experienceTo = Integer.valueOf(campusJobDetailsDom.getExperienceTo());
					}
					
					Insert insertCampusJobDetails = QueryBuilder.insertInto("university_job_dtls").values(new String[]{
							"job_id_and_firm_id","univ_name","description","location",
							"functional_area","industry","job_id","job_title","job_type","firm_id",
							"primary_skills","secondary_skills","payperweek",
							"yearofexperiencefrom","yearofexperienceto",
							"posted_on","firm_name","status","zip_code","is_deleted"},
							new Object[] {
							jobIdAndFirmId,
							campusJobDetailsDom.getCampusJobRecipients().get(i).trim(),
							campusJobDetailsDom.getJobDescription(),
							campusJobDetailsDom.getLocation(),
							campusJobDetailsDom.getFunctionalArea(),
							campusJobDetailsDom.getIndustry(),
							campusJobDetailsDom.getJobId(),
							campusJobDetailsDom.getJobTitle(),
							campusJobDetailsDom.getJobType(),
							campusJobDetailsDom.getEmailId(),
							campusJobDetailsDom.getPrimarySkills(),
							campusJobDetailsDom.getSecondarySkills(),
							campusJobDetailsDom.getPayPerWeek(),
							experienceFrom,
							experienceTo,
							campusJobDetailsDom.getPostedOn(),
							campusJobDetailsDom.getCompanyName(),
							campusJobDetailsDom.getStatus(),
							campusJobDetailsDom.getZipCode(),
							false});
					
					cassandraOperations.execute(insertCampusJobDetails);
			
				}
		
			}
		}

		@Override
		public JobDetailsDom getCampusJobDetails(String jobId,String universityName) {
			JobDetailsDom campusJobDetailsDom = new JobDetailsDom();
			try {
				Select select = QueryBuilder.select().from("university_job_dtls");
				select.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
				select.where(QueryBuilder.eq("univ_name",universityName));
				
				campusJobDetailsDom = cassandraOperations.queryForObject(select, new CampusJobDetailsMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getCampusJobDetails");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			return campusJobDetailsDom == null ? new JobDetailsDom() : campusJobDetailsDom;
		}
		
		private class CampusJobDetailsMapper implements RowMapper<JobDetailsDom>{

			@Override
			public JobDetailsDom mapRow(Row rs, int arg1)	throws DriverException {
				
				JobDetailsDom campusJobDetails = new JobDetailsDom();
				
				campusJobDetails.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
				campusJobDetails.setEmailId(rs.getString("firm_id"));
				campusJobDetails.setJobId(rs.getString("job_id"));
				campusJobDetails.setJobTitle(rs.getString("job_title"));
				campusJobDetails.setJobType(rs.getString("job_type"));
				campusJobDetails.setLocation(rs.getString("location"));
				campusJobDetails.setJobDescription(rs.getString("description"));
				campusJobDetails.setPayPerWeek(rs.getString("payperweek"));
				campusJobDetails.setFunctionalArea(rs.getString("functional_area"));
				campusJobDetails.setIndustry(rs.getString("industry"));
				campusJobDetails.setCampusJobRecipients(Arrays.asList(new String[]{rs.getString("univ_name")}));

				//if(rs.getInt("yearofexperiencefrom") != 0 )
					campusJobDetails.setExperienceFrom(String.valueOf(rs.getInt("yearofexperiencefrom")));
				
				//if(rs.getInt("yearofexperienceto") != 0 )
					campusJobDetails.setExperienceTo(String.valueOf(rs.getInt("yearofexperienceto")));
				
				campusJobDetails.setStatus(rs.getString("status"));
				campusJobDetails.setPostedOn(rs.getString("posted_on"));
				campusJobDetails.setZipCode(rs.getString("zip_code"));
				
				campusJobDetails.setPrimarySkills(rs.getList("primary_skills",String.class));
				campusJobDetails.setSecondarySkills(rs.getList("secondary_skills",String.class));
				campusJobDetails.setCompanyName(rs.getString("firm_name"));
				campusJobDetails.setCampusJobAppliedStudents(rs.getMap("applied_students",String.class,Date.class));
				
				if(rs.getInt("gpacutofffrom") != 0)
					campusJobDetails.setGpaCutOffFrom(String.valueOf(rs.getInt("gpacutofffrom")));
				
				if(rs.getInt("gpacutoffto") != 0)
					campusJobDetails.setGpaCutOffTo(String.valueOf(rs.getInt("gpacutoffto")));
				
				campusJobDetails.setUniversityName(rs.getString("univ_name"));
				
				return campusJobDetails;
			}
			
		}

		@Override
		public void deleteCampusJob(String jobId, String universityName) {
			Update update = QueryBuilder.update("university_job_dtls");
			
			update.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
			update.where(QueryBuilder.eq("univ_name",universityName));
			
			update.with(QueryBuilder.set("is_deleted", true));
			
			cassandraOperations.execute(update);
		
		}


		
		@Override
		public void updateSeenByUniversityFlag(String jobId,String universityName) {
			
			Update update = QueryBuilder.update("university_job_dtls");
			
			update.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
			update.where(QueryBuilder.eq("univ_name",universityName));
			
			update.with(QueryBuilder.set("campus_job_seen_by_university_flag", true));
			
			cassandraOperations.execute(update);
			
		}

		@Override
		public void saveCampusInternship(JobDetailsDom campusInternshipDom) {
			
			 String internshipIdAndFirmId = (campusInternshipDom.getInternshipId().concat("_")).concat(campusInternshipDom.getEmailId());
			
			 campusInternshipDom.setStatus(CaerusAPIStringConstants.JOB_STATUS_DRAFT);
			 for(int i = 0;i<campusInternshipDom.getCampusJobRecipients().size(); i++)
			 {
				Insert saveCampusInternship =  QueryBuilder.insertInto("university_internship_dtls").values(new String[]{
						"internship_id_and_firm_id","internship_id","firm_id",
						"univ_name","internship_title","internship_type",
						"approximate_hours","start_date","end_date","payper_hours",
						"numberofvacancy","primary_skills","secondary_skills","internship_location",
						"internship_description","status","posted_on","firm_name","zip_code","is_deleted","self_posted"
						}, new Object[] {
	
		       internshipIdAndFirmId, 
		       campusInternshipDom.getInternshipId(),
		       campusInternshipDom.getEmailId(),
		       campusInternshipDom.getCampusJobRecipients().get(i).trim(),
		       campusInternshipDom.getInternshipTitle(),
		       campusInternshipDom.getInternshipType(),
		       campusInternshipDom.getApproximateHours(),
		       campusInternshipDom.getStartDate(),
		       campusInternshipDom.getEndDate(),
		       campusInternshipDom.getPayPerHour(),
		       campusInternshipDom.getNumberOfVacancy(),
		       campusInternshipDom.getPrimarySkills(),
		       campusInternshipDom.getSecondarySkills(),
		       campusInternshipDom.getLocation(),
		       campusInternshipDom.getInternshipDescription(),
		       campusInternshipDom.getStatus(),
		       campusInternshipDom.getPostedOn(),
		       campusInternshipDom.getCompanyName(),
		       campusInternshipDom.getZipCode(),
		       false,
		       false
				});
				
				cassandraOperations.execute(saveCampusInternship);
			 }	
		}

		@Override
		public void publishCampusInternship(JobDetailsDom campusInternshipDetails) {
			 String internshipIdAndFirmId = (campusInternshipDetails.getInternshipId().concat("_")).concat(campusInternshipDetails.getEmailId());
				
			 asyncActivities.updateCandidateActivitiesInternship(internshipIdAndFirmId, campusInternshipDetails ,true);
			 
			 campusInternshipDetails.setStatus(CaerusAPIStringConstants.JOB_STATUS_PUBLISHED);
			 
			 for(int i = 0;i < campusInternshipDetails.getCampusJobRecipients().size(); i++)
			 {
				Insert publishCampusInternship =  QueryBuilder.insertInto("university_internship_dtls").values(new String[]{
						"internship_id_and_firm_id","internship_id","firm_id",
						"univ_name","internship_title","internship_type",
						"approximate_hours","start_date","end_date","payper_hours",
						"numberofvacancy","primary_skills","secondary_skills","internship_location",
						"internship_description","status","posted_on","firm_name","zip_code","is_deleted","self_posted"
						}, new Object[] {
	
		       internshipIdAndFirmId, 
		       campusInternshipDetails.getInternshipId(),
		       campusInternshipDetails.getEmailId(),
		       campusInternshipDetails.getCampusJobRecipients().get(i).trim(),
		       campusInternshipDetails.getInternshipTitle(),
		       campusInternshipDetails.getInternshipType(),
		       campusInternshipDetails.getApproximateHours(),
		       campusInternshipDetails.getStartDate(),
		       campusInternshipDetails.getEndDate(),
		       campusInternshipDetails.getPayPerHour(),
		       campusInternshipDetails.getNumberOfVacancy(),
		       campusInternshipDetails.getPrimarySkills(),
		       campusInternshipDetails.getSecondarySkills(),
		       campusInternshipDetails.getLocation(),
		       campusInternshipDetails.getInternshipDescription(),
		       campusInternshipDetails.getStatus(),
		       campusInternshipDetails.getPostedOn(),
		       campusInternshipDetails.getCompanyName(),
		       campusInternshipDetails.getZipCode(),
		       false,
		       false
				});
				
				cassandraOperations.execute(publishCampusInternship);
			 }	
		}

		@Override
		public JobDetailsDom getCampusInternshipDetails(String internshipId,String universityName) {
			
			JobDetailsDom campusInternshipDetails = new JobDetailsDom();
			
			Select selectCampusInternshipDetails = QueryBuilder.select().from("university_internship_dtls");
			selectCampusInternshipDetails.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));
			selectCampusInternshipDetails.where(QueryBuilder.eq("univ_name",universityName));
			
			try {
				campusInternshipDetails = cassandraOperations.queryForObject(selectCampusInternshipDetails, new CampusInternshipDetailMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getCampusInternshipDetails");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			return campusInternshipDetails == null ? new JobDetailsDom() : campusInternshipDetails;
		}
		
		@Override
		public String getState(String zipCode) {
			String state = "";
			Select select = QueryBuilder.select("state").from("zipcode_master");
			select.where(QueryBuilder.eq("zip",zipCode));
			state = cassandraOperations.queryForObject(select, String.class) ;
			
			return state == null ? "" : state;
		}
		
		@Override
		public String getCity(String zipCode) {
			   String city = "";
			   Select select = QueryBuilder.select("city").from("zipcode_master");
			   select.where(QueryBuilder.eq("zip",zipCode));
			   city = cassandraOperations.queryForObject(select, String.class) ;
			   return city == null ? "" : city;

		
		}
		
		private class CampusInternshipDetailMapper implements RowMapper<JobDetailsDom>{
			
			@Override
			public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
				JobDetailsDom campusInternshipDetails = new JobDetailsDom();
				
				campusInternshipDetails.setInternshipIdAndFirmId(rs.getString("internship_id_and_firm_id"));
				campusInternshipDetails.setCampusJobRecipients(Arrays.asList(new String[]{rs.getString("univ_name")}));
				campusInternshipDetails.setInternshipId(rs.getString("internship_id"));
				campusInternshipDetails.setEmailId(rs.getString("firm_id"));
				campusInternshipDetails.setInternshipTitle(rs.getString("internship_title"));
				campusInternshipDetails.setInternshipType(rs.getString("internship_type"));
				campusInternshipDetails.setApproximateHours(rs.getString("approximate_hours"));
				campusInternshipDetails.setStartDate(rs.getString("start_date"));
				campusInternshipDetails.setEndDate(rs.getString("end_date"));
				campusInternshipDetails.setPayPerHour(rs.getString("payper_hours"));
				campusInternshipDetails.setNumberOfVacancy(rs.getString("numberofvacancy"));
				campusInternshipDetails.setUniversityName(rs.getString("univ_name"));
				campusInternshipDetails.setPrimarySkills((List<String>) rs.getList("primary_skills",String.class));
				campusInternshipDetails.setSecondarySkills((List<String>) rs.getList("secondary_skills",String.class));

				campusInternshipDetails.setLocation(rs.getString("internship_location"));
				campusInternshipDetails.setInternshipDescription(rs.getString("internship_description"));
				campusInternshipDetails.setStatus(rs.getString("status"));
				campusInternshipDetails.setPostedOn(rs.getString("posted_on"));
				campusInternshipDetails.setCompanyName(rs.getString("firm_name"));
				campusInternshipDetails.setZipCode(rs.getString("zip_code"));
				
				campusInternshipDetails.setCampusInternshipAppliedStudents((Map<String, Date>)rs.getMap("applied_students",String.class,Date.class));

				return campusInternshipDetails;
			}
			
		}


		@Override
		public void deleteCampusInternship(String internshipId,String universityName) {
			Update update = QueryBuilder.update("university_internship_dtls");
			
			update.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));
			update.where(QueryBuilder.eq("univ_name",universityName));
			
			update.with(QueryBuilder.set("is_deleted", true));
			
			cassandraOperations.execute(update);
		}

		@Override
		public List<JobDetailsDom> getInternshipsForInternshipIds(
				String savedInternshipsCassandraInQuery) {
			List<JobDetailsDom> internshipsForInternshipIds = new ArrayList<JobDetailsDom>();
			String getInternshipsUsingInClause = "select * from internship_dtls where internship_id_and_firm_id in ("+savedInternshipsCassandraInQuery+")";
			
			try {
				internshipsForInternshipIds = cassandraOperations.query(getInternshipsUsingInClause, new InternshipDetailsMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getInternshipsForInternshipIds");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			return internshipsForInternshipIds == null ? new ArrayList<JobDetailsDom>() : internshipsForInternshipIds;
		}

		@Override
		public String getFirmIdByJobIdAndFirmId(String jobId) {
			String firmIdQuery = "select firm_id from job_dtls where job_id_and_firm_id='"+jobId+"'";
			String firmId = cassandraOperations.queryForObject(firmIdQuery, String.class);
			return firmId;
		}


		@Override
		public List<JobDetailsDom> getJobsDetails(JobDetailsDom jobDetailsDom,String emailId) {
			
			String baseQuery = "select job_id_and_firm_id,job_title,job_id,posted_on,firm_name,response_count from job_dtls where firm_id='"+emailId+"' and status='Published'";
			
			if(jobDetailsDom.getJobId() != null && !jobDetailsDom.getJobId().equals(""))
			{
				baseQuery.substring(0,baseQuery.lastIndexOf("'"));
				
				baseQuery = baseQuery.concat(" and job_id='"+ jobDetailsDom.getJobId()+"'");
			}
			
			if(jobDetailsDom.getJobTitle() != null && !jobDetailsDom.getJobTitle().equals(""))
			{
				baseQuery.substring(0,baseQuery.lastIndexOf("'"));
				
				baseQuery = baseQuery.concat(" and job_title='"+ jobDetailsDom.getJobTitle()+"'");
			}
			
			
			if(jobDetailsDom.getPostedOn() != null && !jobDetailsDom.getPostedOn().equals(""))
			{
				String nextDate = "";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c = Calendar.getInstance();
				
				try 
				{
					c.setTime(sdf.parse(jobDetailsDom.getPostedOn()));
					c.add(Calendar.DATE, 1); 
					nextDate = sdf.format(c.getTime()); 
				} 
				catch (ParseException e) {
					
					e.printStackTrace();
				}
					
				baseQuery.substring(0,baseQuery.lastIndexOf("'"));
				
				baseQuery = baseQuery.concat(" and posted_on >= '"+ jobDetailsDom.getPostedOn()+"' and posted_on < '"+ nextDate +"'");
			}
			
			baseQuery = baseQuery.concat(" ALLOW FILTERING ;");
			
			List<JobDetailsDom> jobList = cassandraOperations.query(baseQuery,new JobDetailsMapperForReports());
			
			return jobList;
		}
		
		public static class JobDetailsMapperForReports implements RowMapper<JobDetailsDom>
		{
			@Override
			public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
				
				JobDetailsDom job = new JobDetailsDom();
				
				job.setJobId(rs.getString("job_id"));
				job.setJobTitle(rs.getString("job_title"));
				
				if(rs.getDate("posted_on") != null)
				{
					job.setPostedOn(rs.getDate("posted_on").toString());
				}
				job.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
				job.setCompanyName(rs.getString("firm_name"));
				job.setResponseCount((long)rs.getInt("response_count"));
				
				return job;

			}
			
		}


		@Override
		public JobDetailsDom findJobDetails(String jobIdAndFirmId) {
			
			String query = "select job_id_and_firm_id,job_id,job_title,posted_on,firm_name,response_count from job_dtls where job_id_and_firm_id='"+jobIdAndFirmId+"'";
			
			JobDetailsDom jobDetails = cassandraOperations.queryForObject(query, new JobDetailsMapperForReports());
			
			return jobDetails;
		}


		@SuppressWarnings("unchecked")
		@Override
		public Map<String, String> getAppliedCandidateEmailIdsForInternship(String internshipIdAndFirmId) {
			Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
			
			try {
				appliedCandidateEmailIds = (Map<String, String>) cassandraOperations.queryForObject("select applied_candidates_map from internship_dtls where internship_id_and_firm_id='"+internshipIdAndFirmId+"';",Map.class);
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getAppliedCandidateEmailIdsForInternship");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			catch(NullPointerException npe)
			{
				appliedCandidateEmailIds = new HashMap<String, String>();
			}
			return appliedCandidateEmailIds == null ? new HashMap<String, String>(): appliedCandidateEmailIds;
		}

		
		@Override
		public Map<String, String> getAppliedCandidateEmailIdsForCampusJob(String jobId, String universityName) {
			
			Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
			
			try {
				appliedCandidateEmailIds = (Map<String, String>) cassandraOperations.queryForObject("select candidate_job_status from university_job_dtls where job_id_and_firm_id='"+jobId+"' and univ_name = '"+universityName+"';",Map.class);
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getAppliedCandidateEmailIdsForInternship");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			catch(NullPointerException npe)
			{
				appliedCandidateEmailIds = new HashMap<String, String>();
			}
			return appliedCandidateEmailIds == null ? new HashMap<String, String>(): appliedCandidateEmailIds;
		}

		@Override
		public Map<String, String> getAppliedCandidateEmailIdsForCampusInternship(String internshipId, String universityName) {
			
			Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
			
			try {
				appliedCandidateEmailIds = (Map<String, String>) cassandraOperations.queryForObject("select candidate_internship_status from university_internship_dtls where internship_id_and_firm_id='"+internshipId+"' and univ_name = '"+universityName+"';",Map.class);
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getAppliedCandidateEmailIdsForInternship");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Hosts Available to Serve the Request");
			}
			catch(NullPointerException npe)
			{
				appliedCandidateEmailIds = new HashMap<String, String>();
			}
			return appliedCandidateEmailIds == null ? new HashMap<String, String>(): appliedCandidateEmailIds;
		}

		@Override
		public void updateJobViewCount(String jobId) {
			Select selectJobViewCount = QueryBuilder.select("viewed_count").from("job_dtls");
			selectJobViewCount.where(QueryBuilder.eq("job_id_and_firm_id",jobId));

			Long jobViewCount = 0L;
			
			try {
				jobViewCount = cassandraOperations.queryForObject(selectJobViewCount, Long.class);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				jobViewCount = 0L;
			}
			jobViewCount = ++jobViewCount ;
			
			Update updateJobViewCount = QueryBuilder.update("job_dtls");
			updateJobViewCount.with(QueryBuilder.set("viewed_count", jobViewCount));
			
			updateJobViewCount.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
			
			try {
				cassandraOperations.execute(updateJobViewCount);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job View Count " +ex.getCause());
			}
			
		}

		@Override
		public void updateInternshipViewCount(String internshipId) {
			
			Select selectInternshipViewCount = QueryBuilder.select("viewed_count").from("internship_dtls");
			selectInternshipViewCount.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));

			Long internshipViewCount = 0L;
			
			try {
				internshipViewCount = cassandraOperations.queryForObject(selectInternshipViewCount, Long.class);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				internshipViewCount = 0L;
			}
			internshipViewCount = ++internshipViewCount ;
			
			Update updateInternshipViewCount = QueryBuilder.update("internship_dtls");
			updateInternshipViewCount.with(QueryBuilder.set("viewed_count", internshipViewCount));
			
			updateInternshipViewCount.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));
			
			try {
				cassandraOperations.execute(updateInternshipViewCount);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job View Count " +ex.getCause());
			}
		}

		@Override
		public void updateCampusInternshipViewCount(String internshipId,String universityName) {
			Select selectCampusInternshipViewCount = QueryBuilder.select("viewed_count").from("university_internship_dtls");
			selectCampusInternshipViewCount.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));
			selectCampusInternshipViewCount.where(QueryBuilder.eq("univ_name",universityName));

			Long internshipViewCount = 0L;
			
			try {
				internshipViewCount = cassandraOperations.queryForObject(selectCampusInternshipViewCount, Long.class);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				internshipViewCount = 0L;
			}
			internshipViewCount = ++internshipViewCount ;
			
			Update updateInternshipViewCount = QueryBuilder.update("university_internship_dtls");
			updateInternshipViewCount.with(QueryBuilder.set("viewed_count", internshipViewCount));
			
			updateInternshipViewCount.where(QueryBuilder.eq("internship_id_and_firm_id",internshipId));
			updateInternshipViewCount.where(QueryBuilder.eq("univ_name",universityName));
			
			try {
				cassandraOperations.execute(updateInternshipViewCount);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job View Count " +ex.getCause());
			}
		}

		@Override
		public void updateCampusJobViewCount(String jobId, String universityName) {
			Select selectCampusJobViewCount = QueryBuilder.select("viewed_count").from("university_job_dtls");
			selectCampusJobViewCount.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
			selectCampusJobViewCount.where(QueryBuilder.eq("univ_name",universityName));

			Long campusJobViewCount = 0L;
			
			try {
				campusJobViewCount = cassandraOperations.queryForObject(selectCampusJobViewCount, Long.class);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				campusJobViewCount = 0L;
			}
			++campusJobViewCount ;
			
			Update updateInternshipViewCount = QueryBuilder.update("university_job_dtls");
			updateInternshipViewCount.with(QueryBuilder.set("viewed_count", campusJobViewCount));
			
			updateInternshipViewCount.where(QueryBuilder.eq("job_id_and_firm_id",jobId));
			updateInternshipViewCount.where(QueryBuilder.eq("univ_name",universityName));
			
			try {
				cassandraOperations.execute(updateInternshipViewCount);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				logger.error("Error in Updating Job View Count " +ex.getCause());
			}
		}

		@Override
		public Long getJobsAndInternshipCountPostedInTimeframe(String companyName,Date pastDate, boolean allTimeDataFlag) {
			Long jobsInTimeframe = 0L;
			
			Select selectJobs = QueryBuilder.select().countAll().from("job_dtls");
			selectJobs.allowFiltering();
			selectJobs.where(QueryBuilder.eq("firm_name", companyName));
			
			Select selectInternships = QueryBuilder.select().countAll().from("internship_dtls");
			selectInternships.allowFiltering();
			selectInternships.where(QueryBuilder.eq("firm_name", companyName));
			
			if(! allTimeDataFlag)
			{
				selectInternships.where(QueryBuilder.gte("posted_on", pastDate));
				selectJobs.where(QueryBuilder.gte("posted_on", pastDate));
			}
			
			
			try {
				jobsInTimeframe = cassandraOperations.queryForObject(selectJobs, Long.class);
				jobsInTimeframe += cassandraOperations.queryForObject(selectInternships, Long.class);
			}
			catch(NullPointerException | IllegalArgumentException ex){
				logger.error("Something Went Wrong in getJobsAndInternshipsPostedInTimeframe "+ ex.getMessage());
				jobsInTimeframe = 0L;
			}
			return null == jobsInTimeframe ? 0L : jobsInTimeframe;
		}
		
		
		private Map<String,List<String>> jobAndInternshipIdsInTimeframe(String companyName, Date pastDate){
			Map<String,List<String>> jobAndInternshipIds = new HashMap<String,List<String>>();
			
			Select selectJobIds = QueryBuilder.select("job_id_and_firm_id").from("job_dtls");
			selectJobIds.allowFiltering();
			
			selectJobIds.where(QueryBuilder.eq("firm_name", companyName));
			selectJobIds.where(QueryBuilder.gte("posted_on", pastDate));
			
			Select selectInternshipIds = QueryBuilder.select("internship_id_and_firm_id").from("internship_dtls");
			selectInternshipIds.allowFiltering();
			
			selectInternshipIds.where(QueryBuilder.eq("firm_name", companyName));
			selectInternshipIds.where(QueryBuilder.gte("posted_on", pastDate));
			
			try {
				jobAndInternshipIds.put(CaerusAPIStringConstants.JOB_FLAG,cassandraOperations.queryForList(selectJobIds, String.class));
				jobAndInternshipIds.put(CaerusAPIStringConstants.INTERNSHIP_FLAG,cassandraOperations.queryForList(selectInternshipIds, String.class));
			}
			catch(NullPointerException | IllegalArgumentException ex){
				logger.error("Something Went Wrong in jobAndInternshipIdsInTimeframe "+ ex.getMessage());
				jobAndInternshipIds = new HashMap<String,List<String>>();
			}
			return null == jobAndInternshipIds ? new HashMap<String,List<String>>() : jobAndInternshipIds;
		}

		@Override
		public Long getAppliedCandidateCountInTimeframe(String companyName,Date previousDate) {
			Long totalAppliedCandidates = 0L;
			Map<String, List<String>> jobAndInternshipIdsInTimeframe = jobAndInternshipIdsInTimeframe(companyName, previousDate);
			Select selectAppliedCandidateCount = null;
			Select selectAppliedCandidateCountInternships = null;
			List<Long> appliedCandidatesCount = new ArrayList<Long>();
			
			if(null != jobAndInternshipIdsInTimeframe && jobAndInternshipIdsInTimeframe.size() > 0){
				if(jobAndInternshipIdsInTimeframe.containsKey(CaerusAPIStringConstants.JOB_FLAG)){
					selectAppliedCandidateCount = QueryBuilder.select("applied_candidates_count").from("job_dtls");
					selectAppliedCandidateCount.where(QueryBuilder.in("job_id_and_firm_id", jobAndInternshipIdsInTimeframe.get(CaerusAPIStringConstants.JOB_FLAG).toArray()));
				}
				if(jobAndInternshipIdsInTimeframe.containsKey(CaerusAPIStringConstants.INTERNSHIP_FLAG)){
					selectAppliedCandidateCountInternships = QueryBuilder.select("applied_candidates_count").from("internship_dtls");
					selectAppliedCandidateCountInternships.where(QueryBuilder.in("internship_id_and_firm_id", jobAndInternshipIdsInTimeframe.get(CaerusAPIStringConstants.INTERNSHIP_FLAG).toArray()));
				}
				
				try {
					
					ResultSet resultSet = cassandraOperations.query(selectAppliedCandidateCount);
					
					
					if(null != resultSet && !resultSet.isExhausted()){
						for (Row row : resultSet) {
							if(row.getLong("applied_candidates_count") != 0)
								appliedCandidatesCount.add(row.getLong("applied_candidates_count"));
						}
					}
					resultSet = cassandraOperations.query(selectAppliedCandidateCountInternships);
					if(null != resultSet && !resultSet.isExhausted()){
						for (Row row : resultSet) {
							if(row.getLong("applied_candidates_count") != 0)
								appliedCandidatesCount.add(row.getLong("applied_candidates_count"));
						}
					}
					
					
					//appliedCandidatesCount = cassandraOperations.queryForList(selectAppliedCandidateCount, Long.class);
					//appliedCandidatesCount.addAll(cassandraOperations.queryForList(selectAppliedCandidateCountInternships, Long.class));
					
					if(null != appliedCandidatesCount && appliedCandidatesCount.size() > 0){
					    for (Long variable : appliedCandidatesCount) {
					    	totalAppliedCandidates += variable;
						}
					}
				}
				catch(NullPointerException | IllegalArgumentException ex){
					logger.error("Something Went Wrong in getAppliedCandidateCountInTimeframe "+ ex.getMessage());
					totalAppliedCandidates = 0L;
				}
			}
			return null == totalAppliedCandidates ? 0L : totalAppliedCandidates;
		}

		@Override
		public float getAverageJobClosureTime(String companyName,Date previousDate) {
			float averageJobClosureTime = 0.0f;
			
			Select selectClosedJobs = QueryBuilder.select("job_id_and_firm_id","posted_on","closed_on").from("job_dtls");
			selectClosedJobs.allowFiltering();
			selectClosedJobs.where(QueryBuilder.eq("status", CaerusAPIStringConstants.JOB_STATUS_CLOSED));
			selectClosedJobs.where(QueryBuilder.gte("closed_on",previousDate));
			selectClosedJobs.where(QueryBuilder.eq("firm_name",companyName));
			
			try {
				ResultSet resultSet = cassandraOperations.query(selectClosedJobs);
				int jobCount = 0;
				
				if(null != resultSet && ! resultSet.isExhausted()){
				Long minuteDifference = 0L;	
				
					for (Row row : resultSet) {
						jobCount ++;
						if(null != row.getDate("closed_on"))
							minuteDifference += CaerusCommonUtility.getDateDifferenceInMinutes(row.getDate("posted_on"), row.getDate("closed_on"));
					}
					
					if(minuteDifference != 0){
							averageJobClosureTime = (minuteDifference / (24 * 60 * jobCount) );
					}
				}
			}
			catch(NullPointerException | IllegalArgumentException ex){
				logger.error("Something Went Wrong in getAverageJobClosureTime "+ ex.getMessage());
				averageJobClosureTime = 0.0f;
			}
			return averageJobClosureTime;
		}
		

		@Override
		public Long getAverageResponsesPerJob(String companyName,Date previousDate) {
			Long averageResponses = 0L;
			List<Long> responses = new ArrayList<Long>();
			
			Select selectAppliedCandidates = QueryBuilder.select("applied_candidates_count").from("job_dtls");
			selectAppliedCandidates.allowFiltering();
			selectAppliedCandidates.where(QueryBuilder.gte("posted_on",previousDate));
			selectAppliedCandidates.where(QueryBuilder.eq("firm_name",companyName));
			
			try {
				ResultSet resultSet = cassandraOperations.query(selectAppliedCandidates);
				for (Row row : resultSet) {
					responses.add(row.getLong("applied_candidates_count"));
				}
			}
			catch(IllegalArgumentException | NullPointerException ex) {
				responses = new ArrayList<Long>();
			}
			long responseSum = 0L;
			if(null != responses && responses.size() > 0){
				for (Long response : responses) {
					responseSum += response;
				}
				if(responseSum != 0){
					averageResponses = responseSum / responses.size();
				}
			}
			
			return null == averageResponses ? 0L : averageResponses;
		}

		@Override
		public void closeCampusInternship(String internshipIdAndFirmId,String universityName) {

			Update update = QueryBuilder.update("university_internship_dtls");
			update.with(QueryBuilder.set("status", CaerusAPIStringConstants.JOB_STATUS_CLOSED));
			update.with(QueryBuilder.set("closed_on", new Date()));
			update.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
			update.where(QueryBuilder.eq("univ_name", universityName));
			
			cassandraOperations.execute(update);
		}

		@Override
		public void extendCampusInternshipEndDate(String internshipIdAndFirmId,String universityName,String endDate) {
			
			Update update = QueryBuilder.update("university_internship_dtls");
			update.with(QueryBuilder.set("end_date", endDate));
			update.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
			update.where(QueryBuilder.eq("univ_name", universityName));
			
			cassandraOperations.execute(update);
		}

		@Override
		public void closeInternship(String internshipIdAndFirmId) {
			
			Update update = QueryBuilder.update("internship_dtls");
			update.with(QueryBuilder.set("status", CaerusAPIStringConstants.JOB_STATUS_CLOSED));
			update.with(QueryBuilder.set("closed_on", new Date()));
			update.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
			
			cassandraOperations.execute(update);
		}

		@Override
		public void extendInternshipEndDate(String internshipIdAndFirmId,String endDate) {
			
			Update update = QueryBuilder.update("internship_dtls");
			update.with(QueryBuilder.set("end_date", endDate));
			update.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
			
			cassandraOperations.execute(update);
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
			List<JobDetailsDom> employerJobs = new ArrayList<JobDetailsDom>();
			
			Select selectJobs = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_JOB_DTLS);
			selectJobs.where(QueryBuilder.eq(CaerusAPIStringConstants.FIRM_NAME, companyName));
			selectJobs.where(QueryBuilder.eq(CaerusAPIStringConstants.STATUS, status));
			selectJobs.allowFiltering();
			
			try {
				employerJobs = cassandraOperations.query(selectJobs , new JobDetailsMapper());
			}
			catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
				logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
				employerJobs = new ArrayList<JobDetailsDom>();
			}
			return null == employerJobs ? new ArrayList<JobDetailsDom>() : employerJobs;
		}
}
