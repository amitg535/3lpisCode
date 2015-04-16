package caerusapp.dao.employer;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.dao.DataAccessException;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.exceptions.DoesNotExistException;
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

public class EmployerDao implements IEmployerDao {

	Log logger = LogFactory.getLog(getClass());
	
	@Autowired 
	CassandraOperations cassandraOperations;
	
	@Override
	public EmployerDom getEmployerDetails(String corporateName) {
		
		EmployerDom employerDetails =  new EmployerDom();
		try {
			employerDetails = cassandraOperations.queryForObject("select * from employer_details where company_name='"+corporateName.trim()+"';", new EmployerMapper());
		}
		catch(IllegalArgumentException argEx)
		{
			argEx.printStackTrace();
			logger.error("Empty Result Set in getEmployerDetails()");
		}
		return employerDetails == null ? new EmployerDom() : employerDetails;
	}
	
	
	private class EmployerMapper implements RowMapper<EmployerDom>
	{

		@Override
		public EmployerDom mapRow(Row rs, int arg1) throws DriverException {
			EmployerDom employerDetails = new EmployerDom();
			String companyName = "";
			if(rs.getString("company_name") != null && rs.getString("company_name").length() > 0)
				companyName = rs.getString("company_name").trim();
			employerDetails.setCompanyName(companyName);
			//employerDetails.setEmailID(rs.getString("email_id"));
			employerDetails.setFirstName(rs.getString("first_name"));
			employerDetails.setLastName(rs.getString("last_name"));
			employerDetails.setUserName(rs.getString("username"));
			employerDetails.setAddressLine1(rs.getString("addressline1"));
			employerDetails.setAddressLine2(rs.getString("addressline2"));
			employerDetails.setCity(rs.getString("city"));
			employerDetails.setState(rs.getString("state"));
			employerDetails.setCountry(rs.getString("country"));
			employerDetails.setPhoneNumber(rs.getString("phone_number"));
			employerDetails.setPostalCode(rs.getString("zip_code"));
			employerDetails.setIndustry(rs.getString("industry"));
			employerDetails.setCompanyDesc(rs.getString("description"));
			employerDetails.setContactPersonName(rs.getString("contact_person"));
			employerDetails.setTitle(rs.getString("title"));
			employerDetails.setCompanyRegNumber(rs.getString("company_reg_number"));
			employerDetails.setCompanyWebsite(rs.getString("company_website"));
			employerDetails.setNoOfEmployees(rs.getString("number_of_emp"));
			employerDetails.setLinkedInAddress(rs.getString("linkedin_address"));
			employerDetails.setImageName(rs.getString("logo_name"));
			
			if(null != rs.getList("fax_numbers", String.class))
				employerDetails.setFaxNumbers(rs.getList("fax_numbers", String.class));
			if(null != rs.getBytes("logo_file"))
			{
				byte[] imageData = new byte[rs.getBytes("logo_file").remaining()];
				rs.getBytes("logo_file").get(imageData);
				employerDetails.setImageData(imageData);
				
			}
			
			if(null != rs.getBytes("video_file"))
			{
				byte[] video = new byte[rs.getBytes("video_file").remaining()];
				rs.getBytes("video_file").get(video);
				employerDetails.setVideoFileData(video);
			}
			
			employerDetails.setFileNameVideo(rs.getString("video_file_name"));
			employerDetails.setCompanyType(rs.getString("company_type"));
			
			/*if(rs.getMap("office_locations",String.class,String.class) == null || rs.getMap("office_locations",String.class,String.class).size() == 0){
				Map<String,String> companyOffices = new HashMap<String, String>();
				companyOffices.put(rs.getString("city"), rs.getString("city"));
				employerDetails.setCompanyLocations(companyOffices);
			}*/
			
			Map<String,String> companyOffices = new HashMap<String, String>();
			companyOffices.put(rs.getString("city"), rs.getString("city"));
			employerDetails.setCompanyLocations(companyOffices);
			
			employerDetails.setWorkingWithUs(rs.getString("working_with_us"));
			employerDetails.setHiringProcess(rs.getString("hiring_process"));
			employerDetails.setBrochureName(rs.getString("brochure_filename"));
			
			if(null != rs.getBytes("brochure"))
			{
				byte[] brochure = new byte[rs.getBytes("brochure").remaining()];
				rs.getBytes("brochure").get(brochure);
				employerDetails.setBrochureData(brochure);
			}
			
			return employerDetails;
		}
		
	}


	@Override
	public int getEmployerByEmailId(String emailId) {
		Select select = QueryBuilder.select().countAll().from("user");
		select.where(QueryBuilder.eq("username", emailId));
		Integer userCount = Integer.valueOf(cassandraOperations.queryForObject(select,Long.class).toString());
		return userCount;
	}


	@Override
	public void addEmployer(EmployerDom employerDom) {
		String companyName = CaerusCommonUtility.getCapitalizedString(employerDom.getCompanyName().trim());
		companyName = companyName.trim();
		
		 Insert insertIntoUser = QueryBuilder.insertInto("user").values(
				 new String[]{"username","password","authority","entity_name","first_name","last_name","is_admin","enabled"}, 
				 new Object[]{
						employerDom.getEmailID(),
						DigestUtils.md5Hex(employerDom.getPassword()), 
						employerDom.getAuthority(),
						companyName, 
						employerDom.getFirstName(), 
						employerDom.getLastName(), 
						true,
						true
				 });
		
		Insert insertIntoEmployerDetails = QueryBuilder.insertInto("employer_details").values(
				new String[]{"company_name", "addressline1", "city","industry","phone_number","state",
						"zip_code","company_reg_number","contact_person","company_type","company_website","login_attempts"}, 
				new Object[] {  
					companyName, 
					employerDom.getAddressLine1(),
					employerDom.getCity(),
					employerDom.getIndustry(), 
					employerDom.getPhoneNumber(),
					employerDom.getState(), 
					employerDom.getPostalCode(),
					employerDom.getCompanyRegNumber(),
					employerDom.getContactPersonName(),
					employerDom.getCompanyType(),
					employerDom.getCompanyWebsite(),0});
		//"logo_name", "logo_file"
		//, employerDom.getImageName(), ByteBuffer.wrap(employerDom.getImageData())
		
		cassandraOperations.execute(insertIntoUser);
		cassandraOperations.execute(insertIntoEmployerDetails);
		
	}


	@Override
	public int getEmployerByCompanyName(String companyName) {
		Select select = QueryBuilder.select().countAll().from("employer_details");
		select.where(QueryBuilder.eq("company_name", companyName.trim()));
		Integer countCompanyName = Integer.valueOf(cassandraOperations.queryForObject(select, Long.class).toString());
		return countCompanyName;
	}


	@Override

	public int getUserLoginAttempts(String corporateName) {
		
		Select selectLoginAttempts = QueryBuilder.select("login_attempts").from("employer_details");
		selectLoginAttempts.where(QueryBuilder.eq("company_name", corporateName));
		Integer loginAttemptsCount = 0;
		
		try
		{
			loginAttemptsCount = Integer.valueOf(cassandraOperations.queryForObject(selectLoginAttempts, java.math.BigInteger.class).toString());
		}
		
		catch(NullPointerException npe)
		{
			loginAttemptsCount = 0;
		}
		return loginAttemptsCount;
	}

 
	@Override
	public void updateEmployerSearchHistory(String keyword, String emailID) {
		
		 Date currentDate=new Date();
	     
	     keyword = keyword.toLowerCase();
	     
		 String updateKeywordHistoryMap = "update corporate_search_history set keyword_history_map = keyword_history_map + {'"+currentDate.getTime()+"':'"+keyword+"'} where email_id = '"+emailID+"'" ;
		 
		 cassandraOperations.execute(updateKeywordHistoryMap);
		 
	}
	
	
	public List<String> getFormulaNames(String loggedInUserEmail) {
		
		List<String> employerFormulaNames = new ArrayList<String>();
		
		List<String> emailIds = new ArrayList<String>();
		emailIds.add(loggedInUserEmail);
		emailIds.add(CaerusAPIStringConstants.ADMIN_EMAIL_ID);
		
		for (String emailId : emailIds) 
		{
			try {
				String getFormulaNames = "select formula_name from employer_querybuilder_dtls where email_id='"+emailId+"' and is_deleted=false";
				employerFormulaNames.addAll(cassandraOperations.queryForList(getFormulaNames, String.class));
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getFormulaNames");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Host Available to Serve Requests");
			}
		}
		return employerFormulaNames == null ? new ArrayList<String>() : employerFormulaNames;
	}


	@Override

	public void saveSearchParameter(JobDetailsDom jobDetailsDom) {
		
		Date date = new Date();

		Insert insertIntoSavedSearches = QueryBuilder.insertInto("saved_searches").values(
				new String[]{"emailid","search_parameter_name","keyword","state","location","university","is_deleted","saved_search_on"},
				new Object[]{jobDetailsDom.getEmailId(),
						jobDetailsDom.getParameterName(),
						jobDetailsDom.getKeyword(),
						jobDetailsDom.getState(),
						jobDetailsDom.getLocation(),
						jobDetailsDom.getUniversityName(),
						false,
						date}
				);
		
		cassandraOperations.execute(insertIntoSavedSearches);
	
	}
		

	public void updateCandidateStatus(final String candidateEmailId,final String candidateShortlistedStatus, String jobId) {
		String updateStudentDetails = "update student_details set job_status['"+jobId+"']='"+candidateShortlistedStatus+"' where email_id='"+candidateEmailId+"'";
		cassandraOperations.execute(updateStudentDetails);
		
		String updateJobDetails = "update job_dtls set applied_candidates_map = applied_candidates_map +"+ " {'"+candidateEmailId+"':'"+candidateShortlistedStatus+"'} where job_id_and_firm_id='"+jobId+"'";
		//cassandraOperations.execute(updateJobDetails);
		
		long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(jobId,true);
		updateAppliedCandidatesMap(new HashMap<String, String>(){{put(candidateEmailId,candidateShortlistedStatus);}}, jobId, incrementedAppliedCandidateCount,true);
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
	public void employerSaveCandidate(StudentDom candidateDetails) {
		
		Insert insertIntoStudentDetails = QueryBuilder.insertInto("saved_candidate").values(
				new String[]{"emailid","company_id","about_your_self","course_name","first_name","from_gpa","last_name","location","primary_skills","state","to_gpa"}, 
				new Object[]{candidateDetails.getEmailID(),
						candidateDetails.getCompanyId(),
						candidateDetails.getAboutYourSelf(),
						candidateDetails.getCourseName(),
						candidateDetails.getFirstName(),
						candidateDetails.getFromGpa(),
						candidateDetails.getLastName(),
						candidateDetails.getLocation(),
						candidateDetails.getPrimarySkills(),
						candidateDetails.getState(),
						candidateDetails.getToGpa()});
		
		cassandraOperations.execute(insertIntoStudentDetails);
		
	}


	@Override
	public List<JobDetailsDom> getSavedSearches(String emailId) {
		
		String query = "select * from saved_searches where emailid = '"+emailId+"' and is_deleted=false ALLOW FILTERING";
		
		List<JobDetailsDom> savedSearchList = (List<JobDetailsDom>) cassandraOperations.query(query,new SavedSearchesMapper());
		
		return savedSearchList == null ? new ArrayList<JobDetailsDom>() : savedSearchList;
	}

	
	private static class SavedSearchesMapper implements RowMapper<JobDetailsDom> 
	{
		@Override
		public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException 
		{
			JobDetailsDom searchJobs = new JobDetailsDom();
			
			searchJobs.setEmailId(rs.getString("emailid"));
			searchJobs.setKeyword(rs.getString("keyword"));
			searchJobs.setLocation(rs.getString("location"));
			searchJobs.setIndustry(rs.getString("industry"));
			searchJobs.setParameterName(rs.getString("search_parameter_name"));
			searchJobs.setDeletedFlag(rs.getBool("is_deleted"));
			searchJobs.setSavedSearchOn(rs.getDate("saved_search_on"));

			return searchJobs;
		}
		
	}


	@Override
	public void deleteSavedSearch(String emailId, String searchParameterName) {
		String sqlQuery = "update saved_searches set is_deleted=true where emailid='"+emailId+"' and search_parameter_name='"+searchParameterName+"'";
		cassandraOperations.execute(sqlQuery);
	}

	@Override
	public List<EmployerDom> getRegisteredCompaniesByIndustryAndCompanyName(
			String industry, String companyName) {
		List<EmployerDom> employerNameList = new ArrayList<EmployerDom>();

		String sqlQuery = "select * from employer_details";

		List<EmployerDom> employerList = cassandraOperations.query(sqlQuery,
				new SearchEmployerMapper());

		for (EmployerDom applicantList : employerList) {

			if (industry.equalsIgnoreCase(applicantList.getIndustry())
					&& applicantList.getCompanyName() != null
					&& applicantList.getCompanyName().toLowerCase()
							.startsWith(companyName.toLowerCase())) {
				employerNameList.add(applicantList);
			}
		}

		return employerNameList;
	}


	@Override
	public List<EmployerDom> getRegisteredCompaniesByCompanyName(
			String companyName) {
		List<EmployerDom> employerNameList = new ArrayList<EmployerDom>();

		String sqlQuery = "select * from employer_details";

		List<EmployerDom> employerList = cassandraOperations.query(sqlQuery,
				new SearchEmployerMapper());

		for (EmployerDom applicantList : employerList) {
			if (applicantList.getCompanyName() != null
					&& applicantList.getCompanyName().toLowerCase()
							.startsWith(companyName.toLowerCase())) {
				
				employerNameList.add(applicantList);
			}
		}

		return employerNameList;
	}


	@Override
	public List<EmployerDom> getRegisteredCompaniesByIndustry(String industry) {
		List<EmployerDom> employerNameList = new ArrayList<EmployerDom>();

		String sqlQuery = "select company_name,industry,city from employer_details";

		List<EmployerDom> employerList = cassandraOperations.query(sqlQuery,
				new SearchEmployerMapper());

		for (EmployerDom applicantList : employerList) {
			if (industry.equalsIgnoreCase(applicantList.getIndustry())) {
				employerNameList.add(applicantList);
			}
		}

		return employerNameList;
	}
	
	private static class SearchEmployerMapper implements RowMapper<EmployerDom>{

		@Override
		public EmployerDom mapRow(Row rs, int arg1) throws DriverException {
			EmployerDom employerDetails = new EmployerDom();
			String companyName = "";

			if(rs.getString("company_name") != null && rs.getString("company_name").length() > 0)
				companyName = CaerusCommonUtility.getCapitalizedString(rs.getString("company_name").trim());
				employerDetails.setCompanyName(companyName);
				employerDetails.setCity(rs.getString("city"));
				employerDetails.setIndustry(rs.getString("industry"));
			return employerDetails;
		}
		
	}

	@Override
	public List<StudentDom> getSavedCandidates(String emailId) {
		String query = "select * from  saved_candidate where company_id='"+emailId+"'";
		List<StudentDom> savedCandidates = cassandraOperations.query(query,new SavedCandidatesMapper());
		return savedCandidates;
	}

	
		private static class SavedCandidatesMapper implements RowMapper<StudentDom> {
			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				
				StudentDom studentDom = new StudentDom();
				studentDom.setEmail(rs.getString("emailid"));
				studentDom.setAboutYourSelf(rs.getString("about_your_self"));
				studentDom.setFirstName(rs.getString("first_name"));
				studentDom.setLastName(rs.getString("last_name"));
				studentDom.setLocation(rs.getString("location"));
				studentDom.setPrimarySkills((List<String>) rs.getList("primary_skills",String.class));
				studentDom.setCourseName(rs.getString("course_name"));
			
				return studentDom;
			}
		}


		@Override
		public Map<Object, String> getEmployerSearchHistory(String corporateEmailId) {
			Map<Object, String> employerSearchHistoryMap = new HashMap<Object,String>();
			try
			{
				String query ="select keyword_history_map from corporate_search_history where email_id = '"+corporateEmailId+"'";
				employerSearchHistoryMap = cassandraOperations.queryForObject(query, Map.class);
			}
			catch(NullPointerException e)
			{
				employerSearchHistoryMap = new HashMap<Object, String>();
			}
			return employerSearchHistoryMap == null ? new HashMap<Object, String>():employerSearchHistoryMap;
		}


		@Override
		public void updateActionOnUniversityInvite(String corporateName,String eventId, String action) {
			
			if (action.equalsIgnoreCase("undo")) 
			{
				action = "Pending";
			}
			
			if(action.equalsIgnoreCase("accepted"))
			{
				String query = "select status from university_event_details where event_id = '"+eventId+"'";
				String status = cassandraOperations.queryForObject(query, String.class);
				
				if(status.equalsIgnoreCase("re-proposed"))
				{
					action = "Pending";
				}
				
				else if(status.equalsIgnoreCase("cancelled"))
				{
					action = "Cancelled";
				}
				
				else if(status.equalsIgnoreCase("published") || status.equalsIgnoreCase("publish") || status.equalsIgnoreCase("scheduled"))
				{
					action = status;
				}
			}
			
			DateFormat dateFormat = new SimpleDateFormat("E MMM dd HH:mm:ss Z yyyy");

			Date date = Calendar.getInstance().getTime();        

			String time = dateFormat.format(date);
			
			Update update = QueryBuilder.update("invited_company_details");
			
			update.with(QueryBuilder.set("invitation_status", action));
			
			update.with(QueryBuilder.set("time", time));
			
			update.where(QueryBuilder.eq("company_name", corporateName));
			
			update.where(QueryBuilder.eq("event_id", eventId));
			
			cassandraOperations.execute(update);
			
		}


		@Override
		public void updateUserLoginAttempts(String corporateName) {
			Update update = QueryBuilder.update("employer_details ");
			
			update.with(QueryBuilder.set("login_attempts",1));
			update.where(QueryBuilder.eq("company_name", corporateName));
			cassandraOperations.execute(update);
		}

		@Override
		public List<String> getRepositoryFileNames(String companyName) {
			List<String> corporateRepoFileNames = new ArrayList<String>();
			String selectFileNames = "select file_name from corporate_repository where company_name='"+companyName+"'";
		
			try {
				corporateRepoFileNames = cassandraOperations.queryForList(selectFileNames, String.class);
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getRepositoryFileNames");
			}
			catch(NullPointerException npe)
			{
				logger.error("NullPointerException in getRepositoryFileNames");
			}
			catch(NoHostAvailableException noHostEx)
			{
				logger.error("No Host Available to Serve Requests");
			}
			return corporateRepoFileNames == null ? new ArrayList<String>() : corporateRepoFileNames;
		}
		

		@Override
		public void updateEmployerDetails(EmployerDom employerDetailsDom) {
			
			String industry = "";
			
			if(null != employerDetailsDom.getIndustry())
			{	
				industry = employerDetailsDom.getIndustry().replace("'","");
				String queryForIndustryName = "select industry_name from master_demo";
				List<String> industryNameList = cassandraOperations.queryForObject(queryForIndustryName,List.class);
				
				if(!(industryNameList.contains(industry)))
				{
					String queryToUpdateIndustry = "update master_demo set industry_name = industry_name + ['"+industry+"'] where master_values = '1'";
					cassandraOperations.execute(queryToUpdateIndustry);			
				}
			}
			
			
			Insert updateEmployerDetails = QueryBuilder.insertInto("employer_details").values(
					 new String[]{
								"company_name",
								"company_type",
								"first_name",
								"last_name",
								"phone_number",
								"addressline1",
								"addressline2",
								"city",
								"state",
								"country",
								"zip_code",
								"industry",
								"description",
								"title",
								"company_reg_number",
								"company_website",
								"number_of_emp",
								"contact_person",
								"hiring_process",
								"working_with_us",
								"linkedin_address",
								"fax_numbers"},

								new Object[]{
							 	employerDetailsDom.getCompanyName().trim(),
							 	employerDetailsDom.getCompanyType().trim(),
								employerDetailsDom.getFirstName(),
								employerDetailsDom.getLastName(), 
								employerDetailsDom.getPhoneNumber(),
								employerDetailsDom.getAddressLine1(),
								employerDetailsDom.getAddressLine2(),
								employerDetailsDom.getCity(),
								employerDetailsDom.getState(),
								employerDetailsDom.getCountry(),
								employerDetailsDom.getPostalCode(),
								employerDetailsDom.getIndustry(),
								employerDetailsDom.getCompanyDesc(),
								employerDetailsDom.getTitle(),
								employerDetailsDom.getCompanyRegNumber(),
								employerDetailsDom.getCompanyWebsite(),
								employerDetailsDom.getNoOfEmployees(),
								employerDetailsDom.getContactPersonName(),
								employerDetailsDom.getHiringProcess(),
								employerDetailsDom.getWorkingWithUs(),
								employerDetailsDom.getLinkedInAddress(),
								employerDetailsDom.getFaxNumbers()
								//corporateName
								});
			cassandraOperations.execute(updateEmployerDetails);
			
			if(employerDetailsDom.getImage() != null && employerDetailsDom.getImage().getOriginalFilename().length() > 0)
			{
				Update updateEmployerImage = QueryBuilder.update("employer_details");
				updateEmployerImage.with(QueryBuilder.set("logo_name", employerDetailsDom.getImage().getOriginalFilename()));
				try {
					updateEmployerImage.with(QueryBuilder.set("logo_file", ByteBuffer.wrap(employerDetailsDom.getImage().getBytes())));
				} catch (IOException e) {
					logger.error("Image Write Exception in Employer Update Image");
				}
				
				updateEmployerImage.where(QueryBuilder.eq("company_name",employerDetailsDom.getCompanyName().trim()));
				cassandraOperations.execute(updateEmployerImage);
			}
			
			if(employerDetailsDom.getVideo() != null && employerDetailsDom.getVideo().getOriginalFilename().length() > 0)
			{
				Update updateEmployerVideo = QueryBuilder.update("employer_details");
				updateEmployerVideo.with(QueryBuilder.set("video_file_name", employerDetailsDom.getVideo().getOriginalFilename()));
				try {
					updateEmployerVideo.with(QueryBuilder.set("video_file", ByteBuffer.wrap(employerDetailsDom.getVideo().getBytes())));
				} catch (IOException e) {
					logger.error("Image Write Exception in Employer Update Video");
				}
				
				updateEmployerVideo.where(QueryBuilder.eq("company_name",employerDetailsDom.getCompanyName().trim()));
				cassandraOperations.execute(updateEmployerVideo);
			}
			
			
			if(employerDetailsDom.getBrochure() != null && employerDetailsDom.getBrochure().getOriginalFilename().length() > 0)
			{
				Update updateEmployerBrochure = QueryBuilder.update("employer_details");
				updateEmployerBrochure.with(QueryBuilder.set("brochure_filename", employerDetailsDom.getBrochure().getOriginalFilename()));
				try {
					updateEmployerBrochure.with(QueryBuilder.set("brochure", ByteBuffer.wrap(employerDetailsDom.getBrochure().getBytes())));
				} catch (IOException e) {
					logger.error("Image Write Exception in Employer Update Brochure");
				}
				
				updateEmployerBrochure.where(QueryBuilder.eq("company_name",employerDetailsDom.getCompanyName().trim()));
				cassandraOperations.execute(updateEmployerBrochure);
			}
			
		}


		@Override
		public List<String> getFormulaDetails(String formulaName, String emailId) 
		{
			List<String> formulaDetails = new ArrayList<String>();
			Select select = QueryBuilder.select("formula_list").from("employer_querybuilder_dtls");
			select.where(QueryBuilder.eq("email_id", emailId));
			select.where(QueryBuilder.eq("formula_name", formulaName));
			formulaDetails = cassandraOperations.queryForObject(select, List.class);
			return formulaDetails == null ? new ArrayList<String>(): formulaDetails;
		}


		@Override
		public JobDetailsDom getParametersOfSavedSearch(String parameterName,String emailId) {
			
			String getParametersOfSavedSearch = "select keyword,location,state,university from saved_searches where emailid='"+emailId+"' and search_parameter_name='"+parameterName+"'";
			
			JobDetailsDom savedSearchparameters = new JobDetailsDom();
			
			try 
			{
				savedSearchparameters = cassandraOperations.queryForObject(getParametersOfSavedSearch, new SearchParameterMapper());
			} 
			catch (DataAccessException dae) 
			{
				throw new DoesNotExistException("Empty Result Set");
			}

			return savedSearchparameters;
			
		}
	
		
		private static class SearchParameterMapper implements RowMapper<JobDetailsDom> 
		{
			@Override
			public JobDetailsDom mapRow(Row rs, int arg1) throws DriverException {
				
				JobDetailsDom jobDetailsDom = new JobDetailsDom();
				
				jobDetailsDom.setKeyword(rs.getString("keyword"));
				jobDetailsDom.setLocation(rs.getString("location"));
				jobDetailsDom.setState(rs.getString("state"));
				jobDetailsDom.setUniversityName(rs.getString("university"));

				return jobDetailsDom;
			}
			
		}


		@Override
		public List<EmployerDom> getEmployerFiles(String companyName) {
			String getEmployerFiles = "select * from corporate_repository where company_name='"+companyName+"'";
			List<EmployerDom> employerRepoFiles = new ArrayList<EmployerDom>();
			
			try {
				employerRepoFiles = cassandraOperations.query(getEmployerFiles,new EmployerFileRepoMapper());
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in getEmployerFiles");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in getEmployerFiles");
			}
			return employerRepoFiles == null ? new ArrayList<EmployerDom>(): employerRepoFiles;
		}
		
		private class EmployerFileRepoMapper implements RowMapper<EmployerDom>{

			@Override
			public EmployerDom mapRow(Row rs, int arg1) throws DriverException {
				
				EmployerDom fileRepoDetails = new EmployerDom();
				
				fileRepoDetails.setCompanyName(rs.getString("company_name"));
				fileRepoDetails.setFileSize(rs.getString("file_size"));
				fileRepoDetails.setFileMimeType(rs.getString("mime_type"));
				fileRepoDetails.setPostedOn(rs.getDate("posted_on").toString());
				fileRepoDetails.setFileName(rs.getString("file_name"));
				fileRepoDetails.setFileId(rs.getLong("file_id"));
				
				if(rs.getBytes("file") != null )
				{
				    byte[] fileData = new byte[rs.getBytes("file").remaining()];
				    ByteBuffer fileDataBB = rs.getBytes("file").get(fileData);
				    fileRepoDetails.setFileData(fileDataBB.array());
				}
				return fileRepoDetails;
			}
			
		}


		@Override
		public void deleteFile(String fileId, String companyName) {
			String deleteFileFromRepo = "delete from corporate_repository where company_name='"
					+companyName+"' and file_id="+fileId+"";
			cassandraOperations.execute(deleteFileFromRepo);
		}


		@Override
		public void uploadFile(EmployerDom employerDom) {
			Long lastFileId = getLastFileId();
			
			Insert uploadFile = QueryBuilder.insertInto("corporate_repository").values(
					new String[]{"company_name","file_name","file_size","mime_type","file_id","file","posted_on"},
					new Object[]{
					employerDom.getCompanyName(),
					employerDom.getFileName(),
					employerDom.getFileSize(),
					employerDom.getFileMimeType(),
					lastFileId,
					ByteBuffer.wrap(employerDom.getFileData()),
					new Date()
					});
			
			try {
				cassandraOperations.execute(uploadFile);
				incrementFileId();
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in uploadFile");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in uploadFile");
			}
		}
		
		
		Long getLastFileId(){
			long lastFileId = 0;
			try {
				Select selectLastFileId = QueryBuilder.select("file_id").from("counter_references");
				selectLastFileId.where(QueryBuilder.eq("master_value",1));
				
				lastFileId = cassandraOperations.queryForObject(selectLastFileId,Long.class);
			}
			catch(NullPointerException npe){
				logger.error("NullPointerException in getLastFileId");
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in getLastFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in getLastFileId");
			}
			return lastFileId;
		}
		
		Boolean incrementFileId(){
			Boolean flag = false;
			Update updateFileId = QueryBuilder.update("counter_references");
			updateFileId.with(QueryBuilder.incr("file_id",1));
			updateFileId.where(QueryBuilder.eq("master_value",1));
			
			try {
				cassandraOperations.execute(updateFileId);
				flag = true;
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in incrementFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in incrementFileId");
			}
			return flag;	
		}


		@Override
		public byte[] getEmployerLogo(String companyName) {
			
			String query = "select logo_file from employer_details where company_name = '"+companyName+"'";
			byte[] imageData = new byte[0];
			
			try
			{
				ByteBuffer employerLogoMap = cassandraOperations.queryForObject(query,ByteBuffer.class);
				
				imageData = new byte[employerLogoMap.remaining()];
				employerLogoMap.get(imageData);
			}
			catch(NullPointerException npe)
			{
				
			}
			return imageData == null ? new byte[0]: imageData;
		}

		@Override
		public void updateCandidateStatusForInternship(final String candidateEmailId, final String status, String internshipIdAndFirmId) {
			String updateStudentDetails = "update student_details set internship_status['"+internshipIdAndFirmId+"']='"+status+"' where email_id='"+candidateEmailId+"'";
			
			/*String updateJobDetails = "update internship_dtls set applied_candidates_map = applied_candidates_map +"
					+ " {'"+candidateEmailId+"':'"+status+"'} where internship_id_and_firm_id='"+internshipIdAndFirmId+"'";*/

			long incrementedAppliedCandidateCount = getIncrementedAppliedCandidateCount(internshipIdAndFirmId,false);
			updateAppliedCandidatesMap(new HashMap<String, String>(){{put(candidateEmailId,status);}}, internshipIdAndFirmId, incrementedAppliedCandidateCount,false);
		
			
			cassandraOperations.execute(updateStudentDetails);
			//cassandraOperations.execute(updateJobDetails);
		}


		@Override
		public byte[] getEmployerFileDetails(String companyName,String fileName) {
			Select selectFileDetails = QueryBuilder.select("file").from("corporate_repository");
			selectFileDetails.where(QueryBuilder.eq("company_name", companyName));
			selectFileDetails.where(QueryBuilder.eq("file_name", fileName));
			
			Map<String, byte[]> fileNameWithData = new HashMap<String, byte[]>();
			byte[] fileData = null;
			try {
				ByteBuffer fileDataBB = cassandraOperations.queryForObject(selectFileDetails, ByteBuffer.class);
				
				if(fileDataBB != null){
					fileData = new byte[fileDataBB.remaining()];
					fileDataBB = fileDataBB.get(fileData);
				}
				fileNameWithData.put(fileName, fileData);
			}
			catch(IllegalArgumentException argEx){
				
			}
			catch(NullPointerException npe){
				
			}
			catch(NoHostAvailableException noHostEx){
				
			}
			return fileData == null ? new byte[1] : fileData;
		}


		@Override
		public void updateCandidateStatusForCampusInternship(String candidateEmailId, String status,
				String internshipIdAndFirmId, String universityName) {
			
			String updateStudentDetails = "update student_details set campus_internship_status['"+internshipIdAndFirmId+"']='"+status+"' where email_id='"+candidateEmailId+"'";
			cassandraOperations.execute(updateStudentDetails);
			
			String updateJobDetails = "update university_internship_dtls set candidate_internship_status = candidate_internship_status +"
					+ " {'"+candidateEmailId+"':'"+status+"'} where internship_id_and_firm_id='"+internshipIdAndFirmId+"' and univ_name='"+universityName+"'";
			cassandraOperations.execute(updateJobDetails);
			
		}


		@Override
		public void updateCandidateStatusForCampusJob(String candidateEmailId,String status, String jobId, String universityName) {
			
			String updateStudentDetails = "update student_details set campus_job_status['"+jobId+"']='"+status+"' where email_id='"+candidateEmailId+"'";
			cassandraOperations.execute(updateStudentDetails);
			
			String updateJobDetails = "update university_job_dtls set candidate_job_status = candidate_job_status +"
					+ " {'"+candidateEmailId+"':'"+status+"'} where job_id_and_firm_id='"+jobId+"' and univ_name='"+universityName+"'";
			cassandraOperations.execute(updateJobDetails);
			
		}


		@Override
		public void addToEmployerRecentSearches(String combinationWord,String emailId,String firmName) {
			
			Long lastRecentSearchId = getLastRecentSearchId();
			
			String searchParameterName = "recSearch" + lastRecentSearchId;
			
			Insert insert = QueryBuilder.insertInto("saved_searches").values(
					new String[]{"emailid","search_parameter_name","saved_search_on","keyword","is_saved_search","firm_name"}, 
					new Object[]{emailId,searchParameterName,new Date(),combinationWord,false,firmName});
			
			cassandraOperations.execute(insert);
			incrementRecentSearchId();
			
		}
		
		Long getLastRecentSearchId(){
			long lastFileId = 0;
			try {
				Select selectLastFileId = QueryBuilder.select("recent_search_id").from("counter_references");
				selectLastFileId.where(QueryBuilder.eq("master_value",1));
				
				lastFileId = cassandraOperations.queryForObject(selectLastFileId,Long.class);
			}
			catch(NullPointerException npe){
				logger.error("NullPointerException in getLastFileId");
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in getLastFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in getLastFileId");
			}
			return lastFileId;
		}
		
		Boolean incrementRecentSearchId(){
			Boolean flag = false;
			Update updateFileId = QueryBuilder.update("counter_references");
			updateFileId.with(QueryBuilder.incr("recent_search_id",1));
			updateFileId.where(QueryBuilder.eq("master_value",1));
			
			try {
				cassandraOperations.execute(updateFileId);
				flag = true;
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in incrementFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in incrementFileId");
			}
			return flag;	
		}


		@Override
		public Map<Date, String> getEmployerRecentSearches(String emailId) {
			Select select = QueryBuilder.select("keyword","saved_search_on").from("saved_searches");
			
			select.where(QueryBuilder.eq("emailid", emailId));
			
			select.where(QueryBuilder.eq("is_saved_search", false));
			
			select.allowFiltering();
			
			Map<Date, String> recentSearches = new HashMap<Date, String>();
			
			ResultSet resultSet = cassandraOperations.query(select);
			if(resultSet != null && !resultSet.isExhausted())
			{
				for (Row row : resultSet) {
					if(row != null)
						recentSearches.put(row.getDate("saved_search_on"),row.getString("keyword"));
				}
				
			}
			
			return recentSearches == null ? new HashMap<Date, String>()  : recentSearches;
		}
		
	
		@Override
		public void updateEmployerActivity(String firmName,String studentEmailId, String action) {
            Update updateEmployerActivity = QueryBuilder.update("employer_activities");
			updateEmployerActivity.with(QueryBuilder.set("action", action));
			updateEmployerActivity.with(QueryBuilder.set("email_id", studentEmailId));

			updateEmployerActivity.where(QueryBuilder.eq("company_name", firmName));
			updateEmployerActivity.where(QueryBuilder.eq("time", new Date()));
			try {
				cassandraOperations.execute(updateEmployerActivity);
			}
			catch(IllegalArgumentException | NoHostAvailableException ex){
				logger.error("Something Went Wrong in updateEmployerActivity "+ex.getMessage());
			}
		}


		@Override
		public Long getEmployerActivityCount(String companyName,Date previousDate, String action) {
			Long activityCount = 0L;
			
			Select selectActivityCount = QueryBuilder.select().countAll().from("employer_activities");
			selectActivityCount.where(QueryBuilder.eq("company_name", companyName));
			selectActivityCount.where(QueryBuilder.eq("action", action));
			selectActivityCount.where(QueryBuilder.gte("time", previousDate));
			
			try {
				activityCount = cassandraOperations.queryForObject(selectActivityCount, Long.class);
			}
			catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
				logger.error("Something Went Wrong in getEmployerActivityCount "+ex.getMessage());
				activityCount = 0L;
			}
			return null == activityCount ? 0L : activityCount;
		}
		
		@Override	
		public List<String> getRecentVisitedProfiles(String firmName,String action) {
		
		List<String> recentVisitedProfiles = new ArrayList<String>();
		
		Select select = QueryBuilder.select("email_id").from("employer_activities");
		select.where(QueryBuilder.eq("company_name", firmName));
		select.where(QueryBuilder.eq("action", action));
		select.limit(20);
		
		try
		{
			recentVisitedProfiles = cassandraOperations.queryForList(select, String.class);
		}
		catch(IllegalArgumentException | NoHostAvailableException ex)
		{
			logger.error("Something Went Wrong in getRecentVisitedProfiles "+ex.getMessage());
		}
		
		return recentVisitedProfiles == null ? new ArrayList<String>() : recentVisitedProfiles;
		}


		@Override
		public String getCompanyIndustryType(String firmName) {
			Select select = QueryBuilder.select("industry").from("employer_details");
			select.where(QueryBuilder.eq("company_name", firmName));
			String industry = "";
			try
			{
				industry = cassandraOperations.queryForObject(select,String.class);
			}
			catch(NullPointerException | NoHostAvailableException e)
			{
				logger.info("error in getCompanyIndustryType()");
			}
			
			return industry == null ? "" : industry;
		}


		@Override
		public List<String> getCompaniesOfSameIndustry(String industry) {
			Select select = QueryBuilder.select("company_name").from("employer_details");
			select.where(QueryBuilder.eq("industry", industry));
			List<String> companyNames = new ArrayList<String>();
			try
			{
				companyNames = cassandraOperations.queryForList(select, String.class);
			}
			catch(IllegalArgumentException | NoHostAvailableException ex)
			{
				logger.error("Something Went Wrong in getRecentVisitedProfiles "+ex.getMessage());
			}
			
			return companyNames == null ? new ArrayList<String>() : companyNames;
		}


		@Override
		public Map<String,Map<String,Integer>> getRecentVisitedProfiles(List<String> companyNames,String action) {

			Map<String,Map<String,Integer>> recentVisitedProfiles = new HashMap<String,Map<String,Integer>>();
			
			Select select = QueryBuilder.select("email_id","action").from("employer_activities");
			select.where(QueryBuilder.in("company_name", companyNames.toArray()));
			try
			{
				Map<String, Integer> actionCountMap = new HashMap<String,Integer>();
				
				ResultSet resultSet = cassandraOperations.query(select);
				if(resultSet != null && !resultSet.isExhausted())
				{
					int count = 0;
					for (final Row row : resultSet) {
						
						if(null != row.getString("email_id") && null != row.getString("action")){
							actionCountMap = new HashMap<String,Integer>();
							
							
							if(null != recentVisitedProfiles.get(row.getString("email_id")) && recentVisitedProfiles.get(row.getString("email_id")).size() > 0)
							{
								// Check if the map already contains entry for an emailId
								if(recentVisitedProfiles.containsKey(row.getString("email_id")))
								{
									// Retain the previous action and its count
									actionCountMap = recentVisitedProfiles.get(row.getString("email_id"));
									
									// Fetch the count of the existing action for a candidate (emailId)
									if(null != recentVisitedProfiles.get(row.getString("email_id")).get(row.getString("action")))
									{
										count = recentVisitedProfiles.get(row.getString("email_id")).get(row.getString("action"));
									}
								}
							}
							
							//Insert the action and its count
							actionCountMap.put(row.getString("action"), ++count);
							recentVisitedProfiles.put(row.getString("email_id"), actionCountMap);
							
							count = 0;
						}
					}	
				}
			}
			catch(IllegalArgumentException | NoHostAvailableException ex)
			{
				logger.error("Something Went Wrong in getRecentVisitedProfiles "+ex.getMessage());
			}
			
			return recentVisitedProfiles == null ? new HashMap<String,Map<String,Integer>>() : recentVisitedProfiles;
		}


		@Override
		public Map<String, String> getCompanyPhotoName(List<String> companyNames) {
			
			Select select = QueryBuilder.select("logo_name","company_name").from("employer_details");
			select.where(QueryBuilder.in("company_name", companyNames.toArray()));
			
			ResultSet resultSet = cassandraOperations.query(select);
			
			Map<String,String> photoNameMap = new HashMap<String,String>();
			
			while(null != resultSet && !resultSet.isExhausted())
			{
				for (Row row : resultSet) {
					photoNameMap.put(row.getString("company_name"),row.getString("logo_name"));
				}
			}
			
			return photoNameMap == null ? new HashMap<String,String>() : photoNameMap;
		}


		@Override
		public String getTitleById(String jobId, String jobTypeFlag) {
			
			String jobTitle = "";
			
			if(jobTypeFlag.equalsIgnoreCase(CaerusAPIStringConstants.JOB_FLAG)){
				
				Select select = QueryBuilder.select("job_title").from("job_dtls");
				select.where(QueryBuilder.eq("job_id_and_firm_id", jobId));
				jobTitle = cassandraOperations.queryForObject(select, String.class);
				
			}
			
			if(jobTypeFlag.equalsIgnoreCase(CaerusAPIStringConstants.INTERNSHIP_FLAG)){
				
				Select select = QueryBuilder.select("internship_title").from("internship_dtls");
				select.where(QueryBuilder.eq("internship_id_and_firm_id", jobId));
				jobTitle = cassandraOperations.queryForObject(select, String.class);
				
			}
			
			if(jobTypeFlag.equalsIgnoreCase(CaerusAPIStringConstants.CAMPUS_JOB_FLAG)){
	
				Select select = QueryBuilder.select("job_title").from("university_job_dtls");
				select.where(QueryBuilder.eq("job_id_and_firm_id", jobId));
				jobTitle = cassandraOperations.queryForObject(select, String.class);
			}

			if(jobTypeFlag.equalsIgnoreCase(CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG)){
				
				Select select = QueryBuilder.select("internship_title").from("university_internship_dtls");
				select.where(QueryBuilder.eq("internship_id_and_firm_id", jobId));
				jobTitle = cassandraOperations.queryForObject(select, String.class);
	
			}	
			
			return jobTitle;
		}
	}

