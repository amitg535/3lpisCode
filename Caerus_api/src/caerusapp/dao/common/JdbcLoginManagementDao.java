package caerusapp.dao.common;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.common.BetaUserDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.BatchStatement;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.InvalidQueryException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Delete;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;

public class JdbcLoginManagementDao implements ILoginManagementDao {

	@Autowired
	CassandraOperations cassandraOperations;
	
	@Autowired
	CassandraExtensions cassandraExtensions;
	
	Log logger = LogFactory.getLog(getClass());
	
	@Override
	public LoginManagementDom getUserDetailsByEmailID(String emailID) {
		LoginManagementDom userDetails = new LoginManagementDom();
		try {
			 
			String sqlQuery = "select * from user where username='"+emailID+"';";
			userDetails = cassandraOperations.queryForObject(sqlQuery, new LoginManagementMapper()); 
			  }
			  catch(NullPointerException | IllegalArgumentException ex)
			  {
				  userDetails = new LoginManagementDom();
			  }  
		
		return userDetails;
		
	}

	@Override
	public void addLoginDetails(
			UserBrowsingPatternsDom userBrowsingPatternsDom, String authority) {
		
		
		 String insertLoginDetailsQuery= "insert into audience_details(email_id,authority,login_time) values('"+userBrowsingPatternsDom.getEmailId()+"','"+authority+"',now())";
	//	getJdbcTemplate().update("insert into audience_details(email_id,authority,login_time) values(?,?,now())", new Object[]{userBrowsingPatternsDom.getEmailId(), authority});
		
		 
		 
		/* Insert insert = QueryBuilder.insertInto("audience_details").values(
				 new String[]{"email_id","authority","login_time"},
				 new Object[]{userBrowsingPatternsDom.getEmailId(), authority,now()}
				 );*/
		 
		cassandraOperations.execute(insertLoginDetailsQuery);
		
	}
	
	private class LoginManagementMapper implements RowMapper<LoginManagementDom>{

		@Override
		public LoginManagementDom mapRow(Row rs, int arg1) throws DriverException {
			LoginManagementDom loginManagementDom = new LoginManagementDom();
			loginManagementDom.setUserName(rs.getString("username"));
			loginManagementDom.setAuthority(rs.getString("authority"));
			loginManagementDom.setEnabled(rs.getBool("enabled"));
			loginManagementDom.setFirstName(rs.getString("first_name"));
			loginManagementDom.setLastName(rs.getString("last_name"));
			loginManagementDom.setEntityName(rs.getString("entity_name"));
			loginManagementDom.setAdminFlag(rs.getBool("is_admin"));
			loginManagementDom.setPassword(rs.getString("password"));
			return loginManagementDom;
		}
		
	}

	private class UserDetailsForAdminMapper implements RowMapper<LoginManagementDom>{

		@Override
		public LoginManagementDom mapRow(Row rs, int arg1)
				throws DriverException {
			LoginManagementDom loginManagementDom = new LoginManagementDom();
			loginManagementDom.setUserName(rs.getString("username"));
			loginManagementDom.setAuthority(rs.getString("authority"));
			loginManagementDom.setEnabled(rs.getBool("enabled"));
			loginManagementDom.setFirstName(rs.getString("first_name"));
			loginManagementDom.setLastName(rs.getString("last_name"));
			loginManagementDom.setEntityName(rs.getString("entity_name"));
			loginManagementDom.setAdminFlag(rs.getBool("is_admin"));
			return loginManagementDom;
		}
		
	}
	/**
	 * This method is used to check the enabled flag of a user
	 * @author RavishaG
	 * @param emailId
	 * @return Boolean
	 */
	@Override
	public Boolean checkValidUser(String emailId) {
		Select select = QueryBuilder.select("enabled").from("user");
		select.where(QueryBuilder.eq("username", emailId));
		Boolean enabledFlag = cassandraOperations.queryForObject(select, Boolean.class);
		return null == enabledFlag? false : enabledFlag;
	}

	/**
	 * This method is used to update a user's password
	 * @author RavishaG
	 * @param loginManagementDom
	 */
	@Override
	public void updateUsersLoginPassword(LoginManagementDom loginManagementDom) {

		Update updateUserPassword = QueryBuilder.update("user");
		
		updateUserPassword.with(QueryBuilder.set("password", DigestUtils.md5Hex(loginManagementDom.getNewPassword())));	
		
		updateUserPassword.where(QueryBuilder.eq("username",loginManagementDom.getEmailId()));
		
		cassandraOperations.execute(updateUserPassword);
		
	}
	
	/**
	 * This method is used to retrieve admin details of University/Corporate
	 * @author PallaviD
	 * @param entityName
	 * @return adminDetails(LoginManagementDom)
	 */
	public LoginManagementDom getAdminByEntityName(String entityName){
		LoginManagementDom adminUserForEntity= null;
		
		Select select = QueryBuilder.select("username", "first_name", "last_name").from("user");
		select.where(QueryBuilder.eq("entity_name", entityName));
		select.where(QueryBuilder.eq("is_admin", true));
		select.allowFiltering();
		List<LoginManagementDom> adminUsersList =  new ArrayList<LoginManagementDom>();
				
			try {
			   adminUsersList = cassandraOperations.query(select, new AdminForEntityMapper()) ; 
			  }
			  catch(NullPointerException | IllegalArgumentException ex)
			  {
			   adminUsersList = new ArrayList<LoginManagementDom>();
			  }  
			  //Returning details of first Candidate
			  if(null != adminUsersList && adminUsersList.size() > 0){
			   adminUserForEntity = adminUsersList.get(0); 
			  }
			  
			  return adminUserForEntity == null ? new LoginManagementDom() : adminUserForEntity ;
			  
			 }
	

	/**
	* This class is used to Map the ResultSet values to Domain/Value Objects.
	*/
	private static class AdminForEntityMapper implements RowMapper<LoginManagementDom>
			 {

		@Override
		public LoginManagementDom mapRow (Row rs, int rowNum) throws DriverException {
			LoginManagementDom loginManagementDom = new LoginManagementDom();
			loginManagementDom.setUserName(rs.getString("username"));
			loginManagementDom.setFirstName(rs.getString("first_name"));
			loginManagementDom.setLastName(rs.getString("last_name"));
			
			return loginManagementDom;
		}
		
	}
	
	/**
	 * This method is used to find the authority of a user on the basis of email Id
	 * @author RavishaG
	 * @param emailId
	 * @return String(Authority)
	 */
	@Override
	public String getAuthorityByEmailId(String emailId) {
		String query = "select authority from user where username ='"+emailId+"'";
		String authority = cassandraOperations.queryForObject(query,String.class);
		return authority;
	}

	@Override
	public void setUserLogoutTime(String userEmailId) {
		String updateAudienceDetails = "update audience_details set logout_time = now() where email_id='"+userEmailId+"'";
		cassandraOperations.execute(updateAudienceDetails);	
	}

	@Override
	public void updateRecentActivities(String userName) 
	{
		String tracker = "Changed Your password ";
		
		Date date = new Date();
		
		String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+tracker+"':'"+date.getTime()+"'} where email_id = '"+userName+"'";
		
		cassandraOperations.execute(queryForTracker);
	}

	@Override
	public void updateUserBrowsingPatterns(UserBrowsingPatternsDom userBrowsingPatternsDom, String userEmailId) {
		
		Insert insert = QueryBuilder.insertInto("audience_details").values(
				new String[]{"email_id","latitude","longitude","city","state","country","organization","browser_name","browser_version","os","device","device_type","device_os","ip_address"}, 
				new Object[]{userEmailId,
						userBrowsingPatternsDom.getLatitude(),
						userBrowsingPatternsDom.getLongitude(),
						userBrowsingPatternsDom.getCity(), 
						userBrowsingPatternsDom.getState(),
						userBrowsingPatternsDom.getCountry(),
						userBrowsingPatternsDom.getOrganization(),
						userBrowsingPatternsDom.getBrowserName(),
						userBrowsingPatternsDom.getBrowserVersion(),
						userBrowsingPatternsDom.getOs(),
						userBrowsingPatternsDom.getDevice(),
						userBrowsingPatternsDom.getDeviceType(),
						userBrowsingPatternsDom.getDeviceOsVersion(),
						userBrowsingPatternsDom.getIpAddress()});
		
		cassandraOperations.execute(insert);
	}

	@Override
	public String getEntityNameByEmailId(String userId) {
		String entityNameQuery = "select entity_name from user where username='"+userId+"'";
		String entityName = cassandraOperations.queryForObject(entityNameQuery, String.class);
		return entityName;
	}

	@Override
	public String getEnabledStatusByUsername(String userName) {
		
		String sqlQuery = "select enabled from user where username = '"+userName+"'";

		Boolean enabledStatus = cassandraOperations.queryForObject(sqlQuery,Boolean.class);

		return enabledStatus.toString();
	}

	@Override
	public void updateEnabledStatusByUsername(String userName) {
		
		String sqlQuery = "update user set enabled = true where username = '"+userName+"'";
		
		cassandraOperations.execute(sqlQuery);
		
	}

	public List<LoginManagementDom> getUsers(String companyName) {
		List<LoginManagementDom> employees = new ArrayList<LoginManagementDom>();
		
		final String GET_ALL_EMPLOYEES = "select * from user where entity_name='"+companyName+"'";
		
		try
		{
			employees = cassandraOperations.query(GET_ALL_EMPLOYEES,new LoginManagementMapper());
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("IllegalArgumentException in  getUsersOfEmployer "+ argEx.getMessage().toString());
		}
		catch(NoHostAvailableException noHostEx){
			logger.error("NoHostAvailableException in  getUsersOfEmployer "+ noHostEx.getMessage().toString());
		}
		return employees == null ? new ArrayList<LoginManagementDom>():employees;
	}

	/**
	 * This method is used to update User Details
	 * @author balajii
	 * @param userDetails
	 */
	@Override
	public void updateUserDetails(LoginManagementDom userDetails) {
		Insert updateUserDetails = QueryBuilder.insertInto("user").values(new String[]{"first_name","last_name","is_admin","username"},
				new Object[]{userDetails.getFirstName(),userDetails.getLastName(),userDetails.isAdminFlag(),userDetails.getEmailId()});
		cassandraOperations.execute(updateUserDetails);
	}

	@Override
	public void addUser(LoginManagementDom userDetails) {
		String MD5HashedPassword = "";
		if(userDetails.getPassword() != null && userDetails.getPassword().length() > 0)
			MD5HashedPassword = DigestUtils.md5Hex(userDetails.getPassword());
		 
		Insert addUser = QueryBuilder.insertInto("user").values(
				new String[]{"username","password","authority","entity_name","first_name","last_name","is_admin","enabled"}, 	
				new Object[] {
						userDetails.getEmailId(), 
						MD5HashedPassword,
						userDetails.getAuthority(),
						userDetails.getEntityName(), 
						userDetails.getFirstName(),
						userDetails.getLastName(),
						userDetails.isAdminFlag(),true});
		
		cassandraOperations.execute(addUser);
		
	}

	@Override
	public void disableUsers(Map<String, String> disableUsersMap) {
		for(Entry<String, String> entry : disableUsersMap.entrySet())
		{
			 String disableUser = "update user set enabled=false where username='"+entry.getKey().trim()+"'";
			 cassandraOperations.execute(disableUser);
		}
	}

	@Override
	public void enableUsers(Map<String, String> enableUser) {
		for(Entry<String, String> entry : enableUser.entrySet())
		{
			 String disableUser = "update user set enabled=true where username='"+entry.getKey().trim()+"'";
			 cassandraOperations.execute(disableUser);
		}
	}

	@Override
	public List<LoginManagementDom> getUserDetails() {
		Select select = QueryBuilder.select("username", "authority", "enabled", "first_name", "last_name", "entity_name", "is_admin").from("user");
		List<LoginManagementDom> userList =  cassandraOperations.query(select, new UserDetailsForAdminMapper()) ; 
		return userList;
	}

	@Override
	public List<StudentDom> getUnverifiedPhotoStudents() {
		
		Select select = QueryBuilder.select("first_name","last_name","photoname","email_id","videoname").from("student_details");
		
		select.where(QueryBuilder.eq("photo_verified_flag", false));
		
		select.where(QueryBuilder.eq("photo_rejected_flag ", false));
		
		select.allowFiltering();
		
		List<StudentDom> studentList = new ArrayList<StudentDom>();
		
		try
		{
			studentList = cassandraOperations.query(select, new StudentDetailsMapper());
		}
		
		catch(IllegalArgumentException ex)
		{
			
		}
		
		return studentList == null ? new ArrayList<StudentDom>() : studentList;
	}
	
	private class StudentDetailsMapper implements RowMapper<StudentDom>{

		@Override
		public StudentDom mapRow(Row rs, int arg1) throws DriverException 
		{
			StudentDom studentDetails = new StudentDom();
			
			studentDetails.setFirstName(rs.getString("first_name"));
			studentDetails.setLastName(rs.getString("last_name"));
			studentDetails.setPhotoName(rs.getString("photoname"));
			studentDetails.setEmailID(rs.getString("email_id"));
			studentDetails.setVideoName(rs.getString("videoname"));
			
			return studentDetails;
		}
		
	}
	
	
	@Override
	public void verifyUserPhoto(String userName) {
	
		Update update = QueryBuilder.update("student_details");
		
		update.with(QueryBuilder.set("photo_verified_flag", true));
		
		update.where(QueryBuilder.eq("email_id", userName));
		
		cassandraOperations.execute(update);
		
	}

	@Override
	public void rejectUserPhoto(String userName) {
		
		Update update = QueryBuilder.update("student_details");
		
		update.with(QueryBuilder.set("photo_rejected_flag", true));
		
		update.where(QueryBuilder.eq("email_id", userName));
		
		cassandraOperations.execute(update);
		
	}

	@Override
	public List<StudentDom> getUnverifiedVideoStudents() {
		
		Select select = QueryBuilder.select("first_name","last_name","videoname","email_id","photoname").from("student_details");
		
		select.where(QueryBuilder.eq("video_verified_flag", false));
		
		select.where(QueryBuilder.eq("video_rejected_flag ", false));
		
		select.allowFiltering();
		
		List<StudentDom> studentList = new ArrayList<StudentDom>();
		
		try
		{
			studentList = cassandraOperations.query(select, new StudentDetailsMapper());
		}
		
		catch(IllegalArgumentException ex)
		{
			
		}
		
		return studentList == null ? new ArrayList<StudentDom>() : studentList;
	}

	/** This Method is used to add a beta user
	 * @param betaUser
	 * @return 
	 */
	public int insertBetaUser(BetaUserDom betaUser) {
		Insert insertBetUser =  QueryBuilder.insertInto("beta_user_details").values(new String[]{"email_id","intended_role","status","registered_time"},new Object[]{betaUser.getEmailId().toLowerCase(),betaUser.getRole(),"Pending",new Date()});
		try {
			cassandraOperations.execute(insertBetUser);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Exception in insertBetaUser "+ex.getMessage() );
		}
		return 1;
	}


	/**
	 * This method is used to check whether a beta user exists already with same emailId
	 * @param emailId
	 * @return boolean value
	 */
	@Override
	public boolean checkBetaUserExists(String emailId) {
		String queryCheckExistingBetaUser="select count(*) from beta_user_details  where email_id='"+emailId+"'";
		int count=Integer.valueOf(cassandraOperations.queryForObject(queryCheckExistingBetaUser,Long.class).toString());
		if (count > 0)
			return true;
		else
			return false;
	}
	@Override
	public List<BetaUserDom> getBetaUsers() {
		List<BetaUserDom> betaUserList = new ArrayList<BetaUserDom>();
		List<BetaUserDom> emptyBetaUserList = new ArrayList<BetaUserDom>();
		
		Select select = QueryBuilder.select().from("beta_user_details");
	    betaUserList =  cassandraOperations.query(select, new BetaUserMapper()) ; 
				
		for (BetaUserDom betaUserDom : betaUserList) {
			if(betaUserDom.getRole() == null)
			{
				emptyBetaUserList.add(betaUserDom);
			}
		}
		betaUserList.removeAll(emptyBetaUserList);

		return betaUserList;
	}
	
	private static class BetaUserMapper implements
	RowMapper<BetaUserDom> {

		public BetaUserDom mapRow(Row rs, int rowNum)
		throws DriverException {
			BetaUserDom betaUser = new BetaUserDom();
			
			betaUser.setEmailId(rs.getString("email_id"));
			betaUser.setRole(rs.getString("intended_role"));
			betaUser.setStatus(rs.getString("status"));
			betaUser.setRegisteredTime(rs.getDate("registered_time"));
			
			return betaUser;
		}
	}
	
	/**
	 * This method is used to update a beta user's status
	 * @author RavishaG
	 * @param emailId
	 * @param status
	 */
	@Override
	public void updateBetaUserStatus(String emailId, String status) {
		String query = "update beta_user_details set status ='"+status+"' where email_id = '"+emailId+"'";
		cassandraOperations.execute(query);
	} 
	
	/**
	 * This method is used to enable a beta user in user table
	 * @author RavishaG
	 * @param emailId
	 */
	@Override
	public void enableUser(String emailId) {
		String query = "update user set enabled =true where username = '"+emailId+"'";
		cassandraOperations.execute(query);
	} 
	
	/**
	 * This method is used to retrieve the last inserted job id
	 * @return String(lastInsertedJobId)
	 */
	public String getLastInsertedBetaCompanyNumber() {
		String sql = "select value from auto_increment where job_id ='last_inserted_betacompany_name'";
		Integer lastInsertedBetaCompanyNumber = Integer.valueOf(cassandraOperations.queryForObject(sql,BigInteger.class).toString());
		Integer incrByOne = lastInsertedBetaCompanyNumber + 1;
		String updateLastId = "update auto_increment set value = " + incrByOne + " where job_id='last_inserted_betacompany_name'";
	   
		cassandraOperations.execute(updateLastId);

		return Integer.toString(lastInsertedBetaCompanyNumber);
	}
	
	/**
	 * This method is used to retrieve the last inserted job id
	 * @return String(lastInsertedJobId)
	 */
	public String getLastInsertedBetaUniversityNumber() {
		String sql = "select value from auto_increment where job_id ='last_inserted_betauniversity_name'";
		Integer lastInsertedBetaUniversityNumber = Integer.valueOf(cassandraOperations.queryForObject(sql,BigInteger.class).toString());
		Integer incrByOne = lastInsertedBetaUniversityNumber + 1;
		String updateLastId = "update auto_increment set value = " + incrByOne
				+ " where job_id='last_inserted_betauniversity_name'";
		
		cassandraOperations.execute(updateLastId);
		
		return Integer.toString(lastInsertedBetaUniversityNumber);
	}

	@Override
	public void verifyUserVideo(String userName) {
		Update update = QueryBuilder.update("student_details");
		update.with(QueryBuilder.set("video_verified_flag", true));
		update.where(QueryBuilder.eq("email_id", userName));
		
		cassandraOperations.execute(update);
	}

	@Override
	public void rejectUserVideo(String userName) {
		Update update = QueryBuilder.update("student_details");
		update.with(QueryBuilder.set("video_rejected_flag", true));
		update.where(QueryBuilder.eq("email_id", userName));
		
		cassandraOperations.execute(update);
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> getMasterResults(String masterType) {
		List<String> masterResults = new ArrayList<String>();
		Select select = null;
		
		String masterTypeDB = getMasterTypeDB(masterType);
		
		if(masterTypeDB.equals("course_type")){
			Set<String> results = new HashSet<String>();
			select = QueryBuilder.select(masterTypeDB).from("master_demo");
			select.where(QueryBuilder.eq("master_values", "1"));
			
			try {
				results = cassandraOperations.queryForObject(select, Set.class);
			}
			catch(NullPointerException | IllegalArgumentException ex){
				results = new HashSet<String>();
			}
			return new ArrayList<String>(results == null ? new HashSet<String>() : results);
		}
		else {
			select = QueryBuilder.select(masterTypeDB).from("master_demo");
		}
		select.where(QueryBuilder.eq("master_values", "1"));
		try {
			masterResults = cassandraOperations.queryForObject(select, List.class);
		}
		catch(NullPointerException | IllegalArgumentException ex){
			masterResults = new ArrayList<String>();
		}
		return masterResults== null ? new ArrayList<String>() : masterResults;
	}

	@Override
	public void deleteMasterValue(String masterType, String masterValue) {
		String masterTypeDB = "";
		
		if(masterType != null && masterType.trim().length() > 0){
			masterTypeDB = getMasterTypeDB(masterType);
			
			Update deleteMasterValue = QueryBuilder.update("master_demo");
			deleteMasterValue.with(QueryBuilder.remove(masterTypeDB, masterValue));
			deleteMasterValue.where(QueryBuilder.eq("master_values", "1"));
			
			try {
				cassandraOperations.execute(deleteMasterValue);
			}
			catch(IllegalArgumentException | NoHostAvailableException ex){
				logger.error("Error in deleteMasterValue "+ex.getMessage());
			}
		}
	}

	@Override
	public void addMasterValue(String masterType, String masterValue) {
		String masterTypeDB = getMasterTypeDB(masterType);
		
		Update addMasterValue = QueryBuilder.update("master_demo");
		addMasterValue.with(QueryBuilder.add(masterTypeDB, masterValue));
		addMasterValue.where(QueryBuilder.eq("master_values", "1"));
		
		try {
			cassandraOperations.execute(addMasterValue);
		}
		catch(IllegalArgumentException | NoHostAvailableException ex){
			logger.error("Error in deleteMasterValue "+ex.getMessage());
		}
	}

	@Override
	public Boolean checkMasterValueExists(String masterType, String masterValue) {
		Boolean masterValueExists = false;
		List<String> results = getMasterResults(masterType);
		
		if(null != results && results.size() > 0){
			if(results.contains(masterValue))
				masterValueExists = true;
		}
		return masterValueExists;
	}
	/**
	 * This method maps the values on the page with the respective DB values. For Instance : Industries on the page is industry_name in DB.
	 * @param masterType
	 * @return masterTypeDB
	 */
	private String getMasterTypeDB(String masterType){
		String masterTypeDB = "";
		
		switch (masterType) {
		case "Company Types":
			masterTypeDB = "company_type";
			break;
		case "Course Names":
			masterTypeDB = "course_name";
			break;
		case "School States":
			masterTypeDB = "school_state";
			break;
		case "Industries":
			masterTypeDB = "industry_name";
			break;
		case "Functional Areas":
			masterTypeDB = "functionarea";
			break;
		case "University Names":
			masterTypeDB = "university_name";
			break;
		case "Course Types":
			masterTypeDB = "course_type";
			break;
		default:
			break;
		}
		return masterTypeDB == null ? "" :masterTypeDB;
	}

	@Override
	public void updateMasterValue(String masterType, String oldValue,String newMasterValue) {
		
		String masterTypeDb = getMasterTypeDB(masterType);
		
		Update deletePreviousValue = QueryBuilder.update("master_demo");
		deletePreviousValue.with(QueryBuilder.remove(masterTypeDb, oldValue));
		deletePreviousValue.where(QueryBuilder.eq("master_values", "1"));
		
		Update updateNewValue = QueryBuilder.update("master_demo");
		updateNewValue.with(QueryBuilder.add(masterTypeDb, newMasterValue));
		updateNewValue.where(QueryBuilder.eq("master_values", "1"));
		
		try {
			cassandraOperations.execute(deletePreviousValue);
			cassandraOperations.execute(updateNewValue);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in updateMasterValue "+ex.getMessage() );
		}
	}

	@Override
	public void addMasterValues(Set<String> elements,String masterType) {
		String masterTypeDB = getMasterTypeDB(masterType);
		
		Update updateMasterValues = QueryBuilder.update("master_demo");
		updateMasterValues.with(QueryBuilder.set(masterTypeDB, elements));
		updateMasterValues.where(QueryBuilder.eq("master_values", "1"));
		
		try {
			cassandraOperations.execute(updateMasterValues);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			logger.error("Error in addMasterValues "+ex.getMessage() );
		}
		
	}
	
	@Override
	public boolean checkEntityExist(String entityName) {
		String checkEntityExist="select count(*) from user where entity_name='"+entityName+"'";
		int count=Integer.valueOf(cassandraOperations.queryForObject(checkEntityExist, Long.class).toString());
		if(count>0)
			return true;
		return false;
	}

	@Override
	public void changeCompanyNameforNonPrimarykeys(LoginManagementDom loginManagentDom) {
			
			final BatchStatement batch = new BatchStatement(BatchStatement.Type.UNLOGGED);
			
			Select selectJobidandFirmIds = QueryBuilder.select("job_id_and_firm_id").from("job_dtls");
			selectJobidandFirmIds.where(QueryBuilder.eq("firm_name", loginManagentDom.getEntityName()));
			List<String> jobids=cassandraOperations.queryForList(selectJobidandFirmIds, String.class);
			if(jobids.size()>0){
				String strUpdateCompnaynameJOB_DTLS = "UPDATE job_dtls set firm_name=? where job_id_and_firm_id in ?";
				PreparedStatement updateCompnaynameJOB_DTLS = cassandraOperations.getSession().prepare(strUpdateCompnaynameJOB_DTLS);
				batch.add(updateCompnaynameJOB_DTLS.bind(loginManagentDom.getNewEntityName(),jobids));
			}	
			
			
			Select selectMessageIds = QueryBuilder.select("message_id").from("message_details");
			selectMessageIds.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			List<String> messageIds=cassandraOperations.queryForList(selectMessageIds, String.class);
			if(messageIds.size()>0){
				String strUpdateCompnaynameMESSAGE_DETAILS = "UPDATE message_details set company_name=? where message_id in ?";
				PreparedStatement updateCompanyNameMESSAGE_DETAILS = cassandraOperations.getSession().prepare(strUpdateCompnaynameMESSAGE_DETAILS);
				batch.add(updateCompanyNameMESSAGE_DETAILS.bind( loginManagentDom.getNewEntityName(),messageIds));
			}
			
			
			
			Select selectInternshipidandFirmIds = QueryBuilder.select("internship_id_and_firm_id").from("internship_dtls");
			selectInternshipidandFirmIds.where(QueryBuilder.eq("firm_name", loginManagentDom.getEntityName()));
			List<String> internshipIds=cassandraOperations.queryForList(selectInternshipidandFirmIds, String.class);
			if(internshipIds.size()>0){
				String strUpdateCompnaynameINTERNSHIP_DTLS = "UPDATE internship_dtls set firm_name=? where internship_id_and_firm_id in ?";
				PreparedStatement updateCompnaynameINTERNSHIP_DTLS = cassandraOperations.getSession().prepare(strUpdateCompnaynameINTERNSHIP_DTLS);
				batch.add(updateCompnaynameINTERNSHIP_DTLS.bind( loginManagentDom.getNewEntityName(),internshipIds));
			}
			
			
			Select selectEventIds = QueryBuilder.select("event_id").from("employer_event_details");
			selectEventIds.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			List<String> eventIds=cassandraOperations.queryForList(selectEventIds, String.class);
			if(eventIds.size()>0){
				String strUpdateCompnaynameEMPLOYER_EVENT_DETAILS = "UPDATE employer_event_details set company_name=? where event_id in ?";
				PreparedStatement updateCompnaynameEMPLOYER_EVENT_DETAILS = cassandraOperations.getSession().prepare(strUpdateCompnaynameEMPLOYER_EVENT_DETAILS);
				batch.add(updateCompnaynameEMPLOYER_EVENT_DETAILS.bind( loginManagentDom.getNewEntityName(),eventIds));
			}
			

			Select selectInternshipidAndUnivName = QueryBuilder.select("internship_id_and_firm_id","univ_name").from("university_internship_dtls");
			selectInternshipidAndUnivName.where(QueryBuilder.eq("firm_name", loginManagentDom.getEntityName()));
			List<EmployerCampusJobPostDom> internshipids =cassandraOperations.query(selectInternshipidAndUnivName, new InternshipidAndUnivNameMapper());
			if(internshipids.size()>0){
				String strUpdateCompanyNameUNIVERSITY_INTERNSHIP_DETAILS = "UPDATE university_internship_dtls set firm_name=? where internship_id_and_firm_id=? and univ_name=?";
				PreparedStatement updateCompanyNameUNIVERSITY_INTERNSHIP_DETAILS = cassandraOperations.getSession().prepare(strUpdateCompanyNameUNIVERSITY_INTERNSHIP_DETAILS);
				for (EmployerCampusJobPostDom employerCampusJobPostDom : internshipids) {
					batch.add(updateCompanyNameUNIVERSITY_INTERNSHIP_DETAILS.bind(loginManagentDom.getNewEntityName(),employerCampusJobPostDom.getInternshipIdAndFirmId(), employerCampusJobPostDom.getUniversityName()));
			}
			}
			
			
			Select selectEmailIdAndFormula = QueryBuilder.select("email_id","formula_name").from("employer_querybuilder_dtls");
			selectEmailIdAndFormula.where(QueryBuilder.eq("firm_id", loginManagentDom.getEntityName()));
			List<EmployerQueryBuilderDom> emailIdAndFormulaList =cassandraOperations.query(selectEmailIdAndFormula, new EmployerQueryBuilderDomMapper());
			if(emailIdAndFormulaList.size()>0){
				String strUpdateCompanyNameEMPLOYER_QUERYBUILDER_DTLS = "UPDATE employer_querybuilder_dtls set firm_id=? where email_id=? and formula_name=?";
				PreparedStatement updateCompanyNameEMPLOYER_QUERYBUILDER_DTLS = cassandraOperations.getSession().prepare(strUpdateCompanyNameEMPLOYER_QUERYBUILDER_DTLS);
				for (EmployerQueryBuilderDom employerQueryBuilderDom : emailIdAndFormulaList) {
					batch.add(updateCompanyNameEMPLOYER_QUERYBUILDER_DTLS.bind(loginManagentDom.getNewEntityName(),employerQueryBuilderDom.getEmailId(),employerQueryBuilderDom.getFormulaName()));
			}
			}
			
			
			Select selectJobidAndUnivName = QueryBuilder.select("job_id_and_firm_id","univ_name").from("university_job_dtls");
			selectJobidAndUnivName.where(QueryBuilder.eq("firm_name", loginManagentDom.getEntityName()));
			List<EmployerCampusJobPostDom> jobIdsAndUnivNameList =cassandraOperations.query(selectJobidAndUnivName, new JobIdAndUnivNameMapper());
			if(jobIdsAndUnivNameList.size()>0){
				String strUpdateCompanyNameUNIVERSITY_JOB_DETAILS = "UPDATE university_job_dtls set firm_name=? where job_id_and_firm_id=? and univ_name=?";
				PreparedStatement updateCompanyNameUNIVERSITY_JOB_DETAILS = cassandraOperations.getSession().prepare(strUpdateCompanyNameUNIVERSITY_JOB_DETAILS);
				
				for (EmployerCampusJobPostDom employerCampusJobPostDom : jobIdsAndUnivNameList) {
				 batch.add(updateCompanyNameUNIVERSITY_JOB_DETAILS.bind( loginManagentDom.getNewEntityName(),employerCampusJobPostDom.getJobIdAndFirmId(), employerCampusJobPostDom.getUniversityName()));
			}
			}
			
			
			
			final String updateInviteCompanies = "update university_event_details set invite_companies_name=? where event_id=?";
			final PreparedStatement prepared = cassandraOperations.getSession().prepare(updateInviteCompanies);
			Map<String,List<String>> mapOfListContainingValues=cassandraExtensions.checkListContains("university_event_details", "event_id", "invite_companies_name", loginManagentDom.getEntityName());
			for (Map.Entry<String, List<String>> entry : mapOfListContainingValues.entrySet()) {
				List<String> listOfCompanies=new ArrayList<>();
				listOfCompanies.addAll(entry.getValue());
				Collections.replaceAll(listOfCompanies,loginManagentDom.getEntityName()+" ",loginManagentDom.getNewEntityName()+" ");
				mapOfListContainingValues.put(entry.getKey(),listOfCompanies);
				batch.add(prepared.bind(listOfCompanies, entry.getKey()));
			}


			final String updateViewedCompanies = "update student_details set viewed_by_companies_map=? where email_id=?";
			final PreparedStatement preparedViewedCompanies = cassandraOperations.getSession().prepare(updateViewedCompanies);
			Map<String,Map<String,Date>> mapOfmapContainingValues=cassandraExtensions.checkMapContains("student_details", "email_id", "viewed_by_companies_map", loginManagentDom.getEntityName());
			
			for (Map.Entry<String,Map<String,Date>> entry : mapOfmapContainingValues.entrySet()) {
				Map<String,Date> map=new HashMap<String, Date>();
				map.putAll(entry.getValue());
				map.put(loginManagentDom.getNewEntityName(), entry.getValue().get(loginManagentDom.getEntityName()));
				map.remove(loginManagentDom.getEntityName());
				entry.setValue(map);
				batch.add(preparedViewedCompanies.bind(entry.getValue(),entry.getKey()));
			}
			
			

			Select selectEmployerDetails = QueryBuilder.select("company_name", "addressline1", "city","industry","phone_number","state",
					"zip_code","company_reg_number","contact_person","company_type","company_website","login_attempts").from("employer_details");
			selectEmployerDetails.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			EmployerDom employer = cassandraOperations.queryForObject(selectEmployerDetails, new EmployerDetailsMapper());
			employer.setCompanyName(loginManagentDom.getNewEntityName());
			Insert insertEmployer = QueryBuilder.insertInto("employer_details").values(new String[]{"company_name", "addressline1", "city","industry","phone_number","state",
					"zip_code","company_reg_number","contact_person","company_type","company_website","login_attempts"},
					new Object[]{
					employer.getCompanyName(),employer.getAddressLine1(),employer.getCity(),employer.getIndustry(),	employer.getPhoneNumber(),
					employer.getState(),employer.getPostalCode(),employer.getCompanyRegNumber(),employer.getContactPersonName(),employer.getCompanyType(),
					employer.getCompanyWebsite(),employer.getLoginAttempts()});
			batch.add(insertEmployer);
			Delete deleteEmployer = QueryBuilder.delete().from("employer_details");
			deleteEmployer.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			batch.add(deleteEmployer);
			
			

			Select selectInvitedCompanyDetails = QueryBuilder.select("event_id", "company_name",	"invitation_status", "messages", "event_name",
					"university_name", "start_date", "end_date",
					"start_time", "end_time", "university_id",
					"event_type", "read_flag").from("invited_company_details");
			selectInvitedCompanyDetails.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			List<UniversityEventDom> invitedCompanyDetails  = cassandraOperations.query(selectInvitedCompanyDetails, new InvitedCompanyDetailsMapper());
			for (UniversityEventDom universityEventDom : invitedCompanyDetails) {
				universityEventDom.setInviteCompanyName(loginManagentDom.getNewEntityName());
				Date eventStartdate = CaerusCommonUtility.stringToDate(universityEventDom.getStartDate(),"E MMM dd HH:mm:ss Z yyyy");
				Date eventEndDate = CaerusCommonUtility.stringToDate(universityEventDom.getEndDate(), "E MMM dd HH:mm:ss Z yyyy");
				Insert insertInvitedCompany = QueryBuilder.insertInto("invited_company_details").values(new String[]{"event_id", "company_name",	"invitation_status", "messages", "event_name",
						"university_name", "start_date", "end_date",
						"start_time", "end_time", "university_id",
						"event_type", "read_flag"},
						new Object[]{
						universityEventDom.getEventId(), universityEventDom.getInviteCompanyName(),
						universityEventDom.getInvitationStatus(),
						universityEventDom.getMessage(),
						universityEventDom.getEventName(),
						universityEventDom.getUniversityName(),
						eventStartdate,
						eventEndDate,
						universityEventDom.getStartTime(),
						universityEventDom.getEndTime(),
						universityEventDom.getUniversityId(),
						universityEventDom.getEventType(),
						universityEventDom.isReadFlag() });
				batch.add(insertInvitedCompany);
			}
			Delete deleteInvitedCompanyDetails = QueryBuilder.delete().from("invited_company_details");
			deleteInvitedCompanyDetails.where(QueryBuilder.eq("company_name", loginManagentDom.getEntityName()));
			batch.add(deleteInvitedCompanyDetails);
			
			
			
			Select selectUsername = QueryBuilder.select("username").from("user");
			selectUsername.where(QueryBuilder.eq("entity_name", loginManagentDom.getEntityName()));
			String userName=cassandraOperations.queryForObject(selectUsername, String.class);
			if(null!=userName){
				String strUpdateCompanyNameUSER = "UPDATE user set entity_name=? where username=?";
				PreparedStatement updateCompanyNameUSER = cassandraOperations.getSession().prepare(strUpdateCompanyNameUSER);
				batch.add(updateCompanyNameUSER.bind(loginManagentDom.getNewEntityName(),userName));
			}
			
			
			
			cassandraOperations.execute(batch);
			
			
	}
	
	private static class InvitedCompanyDetailsMapper implements RowMapper<UniversityEventDom> {
		@Override
		public UniversityEventDom mapRow(Row rs, int arg1)throws DriverException {
			
			UniversityEventDom universityEventDom = new UniversityEventDom();
			universityEventDom.setEventId(rs.getString("event_id"));
			universityEventDom.setEventName(rs.getString("event_name"));

			if(null!=rs.getDate("start_date"))
			universityEventDom.setStartDate(rs.getDate("start_date").toString());
			if(null!=rs.getDate("end_date"))
			universityEventDom.setEndDate(rs.getDate("end_date").toString());

			
			if(null!=rs.getDate("start_date"))
				universityEventDom.setStartDate(rs.getDate("start_date").toString());
			
			if(null!=rs.getDate("end_date"))
				universityEventDom.setEndDate(rs.getDate("end_date").toString());

			universityEventDom.setStartTime(rs.getString("start_time"));
			universityEventDom.setEndTime(rs.getString("end_time"));
			universityEventDom.setEventType(rs.getString("event_type"));
			universityEventDom.setUniversityName(rs.getString("university_name"));
			universityEventDom.setUniversityId(rs.getString("university_id"));
			universityEventDom.setInvitationStatus(rs.getString("invitation_status"));
			universityEventDom.setInviteCompanyName(rs.getString("company_name"));
			universityEventDom.setMessage(rs.getString("messages"));
			universityEventDom.setReadFlag(rs.getBool("read_flag"));
			
			return universityEventDom;
		}
	}
	
	
	
	private static class InternshipidAndUnivNameMapper implements RowMapper<EmployerCampusJobPostDom>{

		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int i)
				throws DriverException {
			EmployerCampusJobPostDom employerCampusJobPostDom = new EmployerCampusJobPostDom();
			employerCampusJobPostDom.setInternshipIdAndFirmId(rs.getString("internship_id_and_firm_id"));
			employerCampusJobPostDom.setUniversityName(rs.getString("univ_name"));
			return employerCampusJobPostDom;
		}
		
	}
	
	
	private static class EmployerQueryBuilderDomMapper implements RowMapper<EmployerQueryBuilderDom>{

		@Override
		public EmployerQueryBuilderDom mapRow(Row rs, int i)
				throws DriverException {
			EmployerQueryBuilderDom employerQueryBuilderDom = new EmployerQueryBuilderDom();
			employerQueryBuilderDom.setEmailId(rs.getString("email_id"));
			employerQueryBuilderDom.setFormulaName(rs.getString("formula_name"));
			return employerQueryBuilderDom;
		}
		
	}
	
	private static class JobIdAndUnivNameMapper implements RowMapper<EmployerCampusJobPostDom>{

		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int i)
				throws DriverException {
			EmployerCampusJobPostDom employerCampusJobPostDom = new EmployerCampusJobPostDom();
			employerCampusJobPostDom.setJobIdAndFirmId(rs.getString("job_id_and_firm_id"));
			employerCampusJobPostDom.setUniversityName(rs.getString("univ_name"));
			return employerCampusJobPostDom;
		}
		
	}
	
	private static class  EmployerDetailsMapper implements RowMapper<EmployerDom>{

		@Override
		public EmployerDom mapRow(Row rs, int i) throws DriverException {
			EmployerDom employerDetails = new EmployerDom();
			employerDetails.setCompanyName(rs.getString("company_name"));
			employerDetails.setAddressLine1(rs.getString("addressline1"));
			employerDetails.setCity(rs.getString("city"));
			employerDetails.setIndustry(rs.getString("industry"));
			employerDetails.setPhoneNumber(rs.getString("phone_number"));
			employerDetails.setState(rs.getString("state"));
			employerDetails.setPostalCode(rs.getString("zip_code"));
			employerDetails.setCompanyRegNumber(rs.getString("company_reg_number"));
			employerDetails.setContactPersonName(rs.getString("contact_person"));
			employerDetails.setCompanyType(rs.getString("company_type"));
			employerDetails.setCompanyWebsite(rs.getString("company_website"));
			//System.out.print((rs.getString("login_attempts")));
			System.out.println("login_attempts"+Integer.valueOf((rs.getVarint("login_attempts").toString())));
			employerDetails.setLoginAttempts(Integer.valueOf((rs.getVarint("login_attempts").toString())));
			
			
			return employerDetails;
		}
		
	}

	private static class EventIdAndCompaniesMapper implements RowMapper<UniversityEventDom>{

		@Override
		public UniversityEventDom mapRow(Row rs, int arg1)
				throws DriverException {
			UniversityEventDom universityEventDom = new UniversityEventDom();
			universityEventDom.setEventId(rs.getString("event_id"));
			universityEventDom.setInvitedCompanies(rs.getList("invite_companies_name", String.class));
			return universityEventDom;
		}
		
	}

	public Long getJobViewedCount(String jobIdAndFirmId) {
		
		Select select = QueryBuilder.select("viewed_count").from("job_dtls");
		select.where(QueryBuilder.eq("job_id_and_firm_id", jobIdAndFirmId));
		Long jobViewedCount = 0l;
		try
		{
			jobViewedCount = cassandraOperations.queryForObject(select,Long.class);
		}
		catch(NullPointerException npe)
		{
			
		}
		
		return jobViewedCount == null ? 0 : jobViewedCount;
	}

	@Override
	public Long getInternshipViewedCount(String internshipIdAndFirmId) {
		Select select = QueryBuilder.select("viewed_count").from("internship_dtls");
		select.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
		Long internshipViewedCount = 0l;
		try
		{
			internshipViewedCount = cassandraOperations.queryForObject(select,Long.class);
		}
		catch(NullPointerException npe)
		{
			
		}
		
		return internshipViewedCount == null ? 0 : internshipViewedCount;
	}

	@Override
	public Long getCampusJobViewedCount(String jobId, String universityName) {
		Select select = QueryBuilder.select("viewed_count").from("university_job_dtls");
		select.where(QueryBuilder.eq("job_id_and_firm_id", jobId));
		select.where(QueryBuilder.eq("univ_name", universityName));
		Long campusJobViewedCount = 0l;
		try
		{
			campusJobViewedCount = cassandraOperations.queryForObject(select,Long.class);
		}
		catch(NullPointerException | IllegalArgumentException | InvalidQueryException npe)
		{
			campusJobViewedCount = 0l;
		}
		return campusJobViewedCount == null ? 0 : campusJobViewedCount;
	}

	@Override
	public Long getCampusInternshipViewedCount(String internshipId,String universityName) {
		Select select = QueryBuilder.select("viewed_count").from("university_internship_dtls");
		select.where(QueryBuilder.eq("internship_id_and_firm_id", internshipId));
		select.where(QueryBuilder.eq("univ_name", universityName));
		Long campusInternshipViewedCount = 0l;
		try
		{
			campusInternshipViewedCount = cassandraOperations.queryForObject(select,Long.class);
		}
		catch(NullPointerException | InvalidQueryException pe)
		{
			campusInternshipViewedCount = 0l;
		}
		return campusInternshipViewedCount == null ? 0 : campusInternshipViewedCount;
	}
}
