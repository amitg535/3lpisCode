package caerusapp.dao.university;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityEventDom;
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

public class UniversityManagerDao implements IUniversityManagerDao {


	
	Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	CassandraOperations cassandraOperations;

	
	

	
	
	
	/**
	  * This class is used to Map the ResultSet values to Domain/Value Objects for student_university_connections.
	  */
	
	private static class StudentUniversityConnectionsMapper implements RowMapper<UniversityDetailsDom> 
	{
		@Override
		public UniversityDetailsDom mapRow(Row rs, int arg1)throws DriverException 
		{
			UniversityDetailsDom universityDetailsDom = new UniversityDetailsDom();
			
			universityDetailsDom.setUniversityName(rs.getString("university_name"));
			universityDetailsDom.setUnregisteredStudents(rs.getMap("unregistered_students_map", String.class,String.class));

			return universityDetailsDom;
		}
	}

	
	
	/**
	 * This method is used to to check for duplicate entries of students not
	 * registered with application
	 * 
	 * @author RavishaG
	 * @param emailId
	 * @return Map<String,Map<String,String>>
	 */
	@Override
	public Map<String, Map<String, String>> checkStudent(String emailId) {
 		Map<String, String> studentEmailWithBatchMap = new HashMap<String, String>();
		Map<String, Map<String, String>> univNameWithStudentDetailsMap = new HashMap<String, Map<String,String>>();

		Select selectUnregisteredStudents = QueryBuilder.select("university_name", "unregistered_students_map").from("student_university_connections");
		List<UniversityDetailsDom> unregisteredStudents = new ArrayList<UniversityDetailsDom>();
		try {
			
			unregisteredStudents = cassandraOperations.query(selectUnregisteredStudents,new StudentUniversityConnectionsMapper());
		}
		catch(IllegalArgumentException | NullPointerException | NoHostAvailableException ex){
			unregisteredStudents = new ArrayList<UniversityDetailsDom>();
		}
		
		if(unregisteredStudents != null && unregisteredStudents.size() > 0)
		{
			for (UniversityDetailsDom universityDetails : unregisteredStudents) {
				String universityName = universityDetails.getUniversityName();
				if(universityDetails.getUnregisteredStudents().containsKey(emailId)){
					studentEmailWithBatchMap.put(emailId, universityDetails.getUnregisteredStudents().get(emailId));
				}
				if(studentEmailWithBatchMap != null && studentEmailWithBatchMap.size() >0)
				{
					univNameWithStudentDetailsMap.put(universityName, studentEmailWithBatchMap);
					break;
				}
			}
		}
		return univNameWithStudentDetailsMap == null ? new HashMap<String, Map<String,String>>():univNameWithStudentDetailsMap; 
	}

	/**
	 * This method is used to update unregistered students to registered
	 * students for an university
	 * 
	 * @author RavishaG
	 * @param newMap
	 * @param universityName
	 */
	@Override
	public void updateRegisteredStudents(Map<String, String> studentMap,
			String universityName) {

		for (String string : studentMap.keySet()) {
			String batch = studentMap.get(string);

			String updateUnRegisteredMapQuery = "delete unregistered_students_map['"
					+ string
					+ "'] from student_university_connections where university_name ='"
					+ universityName + "'";
			cassandraOperations.execute(updateUnRegisteredMapQuery);

			String updateRegisteredMapQuery = "update student_university_connections set registered_students_map = registered_students_map + {'"
					+ string
					+ "':'"
					+ batch
					+ "'} where university_name ='"
					+ universityName + "'";
			cassandraOperations.execute(updateRegisteredMapQuery);
		}
	}


	/**
	 * This method is used to register a university
	 * 
	 * @param UnivesityRegisterationDom
	 */
	@Override
	public void addUniversity(UniversityDetailsDom univesityRegisterationDom) {

		Insert insertIntoUniversityReg = QueryBuilder.insertInto(
				"university_reg").values(
				new String[] { "universityname",
						"universityregistrationnumber", "phonenumber",
						"address", "zipcode", "city", "state",
						"university_website" },
				new Object[] {
						univesityRegisterationDom.getUniversityName()
								.toLowerCase(),
						univesityRegisterationDom
								.getUniversityRegistrationNumber(),
						univesityRegisterationDom.getPhoneNumber(),
						univesityRegisterationDom.getUniversityAddress(),
						univesityRegisterationDom.getZipCode(),
						univesityRegisterationDom.getCity(),
						univesityRegisterationDom.getState(),
						univesityRegisterationDom.getUniversityWebsite() });

		cassandraOperations.execute(insertIntoUniversityReg);

		
		Insert insertIntoUser = QueryBuilder.insertInto("user").values(
				new String[]{"username", "password", "authority", "first_name", "last_name", "entity_name", "is_admin","enabled"}, 
				new Object[]{
						univesityRegisterationDom.getEmailID(),
						DigestUtils.md5Hex(univesityRegisterationDom.getPassword()),
						univesityRegisterationDom.getAuthority(),
						univesityRegisterationDom.getFirstName(),
						univesityRegisterationDom.getLastName(),
						univesityRegisterationDom.getUniversityName()
								.toLowerCase(), true, true });

							
		
		cassandraOperations.execute(insertIntoUser);
	}

	/**
	 * This class is used to Map the ResultSet values to Domain/Value Objects
	 * for university details.
	 *
	 **/
	private static class UniversityDetailMapper implements
			RowMapper<UniversityDetailsDom> {

		@Override
		public UniversityDetailsDom mapRow(Row rs, int arg1)
				throws DriverException {
			UniversityDetailsDom universityDetails = new UniversityDetailsDom();
			universityDetails.setUniversityName(rs.getString("universityname"));
			universityDetails.setUniversityRegistrationNumber(rs
					.getString("universityregistrationnumber"));
			universityDetails.setPhoneNumber(rs.getString("phonenumber"));
			universityDetails.setUniversityAddress(rs.getString("address"));
			universityDetails.setState(rs.getString("state"));
			universityDetails.setZipCode(rs.getString("zipcode"));
			universityDetails.setCity(rs.getString("city"));
			// universityDetails.setContactPerson(rs.getString("contactpersonname"));
			universityDetails.setUniversityWebsite(rs
					.getString("university_website"));
			// universityDetails.setContactPersonEmailId(rs.getString("contactpersonemailid"));
			universityDetails.setAboutUs(rs.getString("about_us"));
			universityDetails.setUniversityLogoName(rs
					.getString("university_logo_filename"));

			if (rs.getBytes("university_logo") != null) {
				byte[] imageData = new byte[rs.getBytes("university_logo")
						.remaining()];
				rs.getBytes("university_logo").get(imageData);
				universityDetails.setPhotoData(imageData);

			}

			universityDetails.setAutumnStartDate(rs
					.getString("autumn_start_date"));
			universityDetails.setAutumnEndDate(rs.getString("autumn_end_date"));
			universityDetails.setSpringStartDate(rs
					.getString("spring_start_date"));
			universityDetails.setSpringEndDate(rs.getString("spring_end_date"));
			universityDetails.setSummerStartDate(rs
					.getString("summer_start_date"));
			universityDetails.setSummerEndDate(rs.getString("summer_end_date"));
			universityDetails.setNoOfTeachingStaff(rs
					.getString("teaching_staff_count"));
			universityDetails.setNoOfResearchStaff(rs
					.getString("research_staff_count"));
			universityDetails.setNoOfSupportStaff(rs
					.getString("support_staff_count"));
			universityDetails.setUgFullTimeStudents(rs
					.getString("ug_fulltime_students_count"));
			universityDetails.setUgPartTimeStudents(rs
					.getString("ug_parttime_students_count"));
			universityDetails.setPgFullTimeStudents(rs
					.getString("pg_fulltime_students_count"));
			universityDetails.setPgPartTimeStudents(rs
					.getString("pg_parttime_students_count"));
			universityDetails.setAwardsAndRecognitionList(rs.getList(
					"recognition_list", String.class));
			universityDetails.setCourseType(rs.getList(
					"available_course_type_list", String.class));
			universityDetails.setCourseName(rs.getList(
					"available_course_name_list", String.class));

			return universityDetails;
		}
	}

	/**
	 * This method is used to check whether a university with the given name
	 * exists
	 * 
	 * @param emailId
	 * @return integer (No of universities)
	 */
	@Override
	public int checkUniversityEmailIdExist(String emailId) {

		Select select = QueryBuilder.select().countAll().from("user");

		select.where(QueryBuilder.eq("username", emailId));

		Integer count = Integer.valueOf(cassandraOperations.queryForObject(
				select, Long.class).toString());
		
		
		return count;	
	}
	
	
	/**
	  * This method is used to check whether a university with the given name exists
	  * @param universityName
	  * @return integer (No of universities)
	  */
	 @Override
	 public int getUniversityByUniversityName(String universityName) {
		 
		 Select select = QueryBuilder.select().countAll().from("university_reg");
		 
		 select.where(QueryBuilder.eq("universityname", universityName));
		 
		 Integer count = Integer.valueOf(cassandraOperations.queryForObject(select, Long.class).toString());
		 
		 return count;
		 
	 }
	
	
	/*
	  * This class is used to Map the ResultSet values to Domain/Value Objects for university event details.
	  */
	private static class UniversityEventMapper
			implements
				RowMapper<UniversityEventDom> {
		public UniversityEventDom mapRow(Row rs, int rowNum)
				throws DriverException {

			UniversityEventDom universityEventDom = new UniversityEventDom();
			universityEventDom.setEventId(rs.getString("event_id"));
			universityEventDom.setFirmId(rs.getString("firm_id"));
			universityEventDom.setEventName(rs.getString("event_name"));
			universityEventDom.setEventType(rs.getString("event_type"));
		
			if(null!= rs.getDate("start_date"))
				universityEventDom.setStartDate(rs.getDate("start_date").toString());
			
			if(null!= rs.getDate("end_date"))
				universityEventDom.setEndDate(rs.getDate("end_date").toString());
			
			universityEventDom.setStartTime(rs.getString("start_time"));
			universityEventDom.setEndTime(rs.getString("end_time"));
			universityEventDom.setStatus(rs.getString("status"));
			universityEventDom.setVenue(rs.getString("venue"));
			universityEventDom.setDescription(rs.getString("description"));
			universityEventDom.setInvitedCompanies(rs.getList("invite_companies_name", String.class));
			universityEventDom.setSpeakerName(rs.getString("speaker_name"));
			universityEventDom.setSeminarCategory(rs.getString("seminar_category"));
			universityEventDom.setTopic(rs.getString("topic"));
			universityEventDom.setUniversityId(rs.getString("email_id"));
			universityEventDom.setUniversityName(rs.getString("university_name"));
			universityEventDom.setAcceptedByStudentsList(rs.getList("accepted_by_students", String.class));
			universityEventDom.setDeniedByStudentsList( rs.getList("denied_by_students", String.class));
			universityEventDom.setTemplateName(rs.getString("template_name"));
			
			return universityEventDom;
		}
	}

	/**
	  * This class is used to Map the ResultSet values to Domain/Value Objects for university registered students details.
	  */
	private static class StudentUniversityForRegisteredStudentsMapper implements RowMapper<UniversityDetailsDom> 
	{
		@Override
		public UniversityDetailsDom mapRow(Row rs, int arg1) throws DriverException 
		{
			UniversityDetailsDom universityLoginDom = new UniversityDetailsDom();
			
		   universityLoginDom.setRegisteredStudents(rs.getMap("registered_students_map", String.class,String.class));
		   universityLoginDom.setUniversityName(rs.getString("university_name"));
		   
		   return universityLoginDom;
		}

	
	 }

/**
	  * This class is used to Map the ResultSet values to Domain/Value Objects for university registered and unregistered students.
	  */
	private static class UniversityConnectionsMapper implements RowMapper<UniversityDetailsDom> 
	{
		@Override
		public UniversityDetailsDom mapRow(Row rs, int arg1) throws DriverException
		{
			UniversityDetailsDom universityDetailsDom = new UniversityDetailsDom();
			
			universityDetailsDom.setRegisteredStudents(rs.getMap("registered_students_map",String.class,String.class));
			universityDetailsDom.setUnregisteredStudents(rs.getMap("unregistered_students_map",String.class,String.class));
			
		    return universityDetailsDom;
		    
		}
	  
	  }

	

	/**
	 * This method is used to find the last inserted event id and also to update
	 * the count
	 * 
	 * @return String (last inserted event id)
	 */

	@SuppressWarnings("unused")
	public String getLastInsertedEventID() {

		String sql = "select value from auto_increment where job_id ='last_inserted_event_id'";
		Integer lastInsertedEventId = Integer.valueOf(cassandraOperations
				.queryForObject(sql, BigInteger.class).toString());
		Integer incrByOne = lastInsertedEventId + 1;
		String update_lastId = "update auto_increment set value = " + incrByOne
				+ " where job_id='last_inserted_event_id'";
		ResultSet count = cassandraOperations.query(update_lastId);
		return Integer.toString(lastInsertedEventId);
	}

	/**
	 * This method is used for scheduling an event by university
	 * 
	 * @param UniversityEventDom
	 * @return String (eventId)
	 */

	@SuppressWarnings("unused")
	public String scheduleEventByUniversity(
			UniversityEventDom universityEventDom) {
		String eventId = getLastInsertedEventID();

		Date eventStartDate = CaerusCommonUtility.stringToDate(
				universityEventDom.getStartDate(), "yyyy-MM-dd");

		Date eventEndDate = CaerusCommonUtility.stringToDate(
				universityEventDom.getEndDate(), "yyyy-MM-dd");

		// Timestamp t = new Timestamp(universityEventDom.getStartDate());

		Insert insert = QueryBuilder.insertInto("university_event_details")
				.values(new String[] { "event_id", "email_id", "event_name",
						"event_type", "start_date", "end_date", "start_time",
						"end_time", "status", "venue", "description",
						"invite_companies_name", "speaker_name",
						"seminar_category", "topic", "university_name" },
						new Object[] { eventId,
								universityEventDom.getUniversityId(),

								universityEventDom.getEventName(),
								universityEventDom.getEventType(),
								eventStartDate, eventEndDate,
								universityEventDom.getStartTime(),
								universityEventDom.getEndTime(),
								universityEventDom.getStatus(),
								universityEventDom.getVenue(),
								universityEventDom.getDescription(),
								universityEventDom.getInvitedCompanies(),
								universityEventDom.getSpeakerName(),
								universityEventDom.getSeminarCategory(),
								universityEventDom.getTopic(),
								universityEventDom.getUniversityName() });

		cassandraOperations.execute(insert);

		String companyList = "", emailId = "";

		if (universityEventDom.getCompanyName() != null
				&& universityEventDom.getCompanyName().size() > 0) {
			companyList = universityEventDom.getCompanyName().get(0);
			emailId = universityEventDom.getInvitedCompanies().get(0);
		}

		if (companyList.length() > 1) {
			String[] companyListDetails = companyList.split(",");

			for (int i = 0; i < companyListDetails.length; i++) {
				Insert insertInvitedCompanies = QueryBuilder.insertInto(
						"invited_company_details").values(
						new String[] { "event_id", "company_name",
								"invitation_status", "messages", "event_name",
								"university_name", "start_date", "end_date",
								"start_time", "end_time", "university_id",
								"event_type", "read_flag" },
						new Object[] { eventId, companyListDetails[i].trim(),
								universityEventDom.getInvitationStatus(),
								universityEventDom.getMessage(),
								universityEventDom.getEventName(),
								universityEventDom.getUniversityName(),
								eventStartDate, eventEndDate,
								universityEventDom.getStartTime(),
								universityEventDom.getEndTime(),
								universityEventDom.getUniversityId(),
								universityEventDom.getEventType(),
								universityEventDom.isReadFlag() });

				cassandraOperations.execute(insertInvitedCompanies);
			}
		}

		else {
			String companyLists = "";
			if (companyList.length() > 0)
				companyLists = companyList.substring(0,
						companyList.length() - 1);

			Insert insertInvitedCompanies = QueryBuilder.insertInto(
					"invited_company_details").values(
					new String[] { "event_id", "company_name",
							"invitation_status", "messages", "event_name",
							"university_name", "start_date", "end_date",
							"start_time", "end_time", "university_id",
							"event_type" },
					new Object[] { eventId, companyLists.trim(),
							universityEventDom.getInvitationStatus(),
							universityEventDom.getMessage(),
							universityEventDom.getEventName(),
							universityEventDom.getUniversityName(),
							universityEventDom.getStartDate(),
							universityEventDom.getEndDate(),
							universityEventDom.getStartTime(),
							universityEventDom.getEndTime(),
							universityEventDom.getUniversityId(),
							universityEventDom.getEventType() });
		}

		return eventId;
	}

	/**
	 * This method is used to update an event created by university
	 * 
	 * @param UniversityEventDom
	 */
	@Override
	public void updateCampusFairEvent(UniversityEventDom universityEventDom) {

		String eventId = universityEventDom.getEventId();
		String universityName = universityEventDom.getUniversityName();
		String eventStatus = null;

		if (universityEventDom.getStatus().equalsIgnoreCase("re-proposed")) {
			universityEventDom.setStatus("Proposed");
		}

		Update universityEventDetails = QueryBuilder
				.update("university_event_details");

		Date eventStartdate = CaerusCommonUtility.stringToDate(
				universityEventDom.getStartDate(), "yyyy-MM-dd");

		Date eventEndDate = CaerusCommonUtility.stringToDate(
				universityEventDom.getEndDate(), "yyyy-MM-dd");

		universityEventDetails.with(QueryBuilder.set("firm_id",
				universityEventDom.getFirmId()));
		universityEventDetails.with(QueryBuilder.set("event_name",
				universityEventDom.getEventName()));
		universityEventDetails.with(QueryBuilder.set("event_type",
				universityEventDom.getEventType()));
		universityEventDetails.with(QueryBuilder.set("start_date",
				eventStartdate));
		universityEventDetails.with(QueryBuilder.set("end_date", eventEndDate));
		universityEventDetails.with(QueryBuilder.set("start_time",
				universityEventDom.getStartTime()));
		universityEventDetails.with(QueryBuilder.set("end_time",
				universityEventDom.getEndTime()));
		universityEventDetails.with(QueryBuilder.set("status",
				universityEventDom.getStatus()));
		universityEventDetails.with(QueryBuilder.set("venue",
				universityEventDom.getVenue()));
		universityEventDetails.with(QueryBuilder.set("description",
				universityEventDom.getDescription()));
		universityEventDetails.with(QueryBuilder.set("invite_companies_name",
				universityEventDom.getInvitedCompanies()));
		universityEventDetails.with(QueryBuilder.set("university_name",
				universityName));

		universityEventDetails.where(QueryBuilder.eq("event_id", eventId));

		cassandraOperations.execute(universityEventDetails);

		StringBuilder invitedCompanies = new StringBuilder();
		for (String str : universityEventDom.getInvitedCompanies()) {
			invitedCompanies.append(str).append(","); // separating contents
														// using semi colon
		}

		String invitedCompaniesStr = invitedCompanies.toString();
		StringBuilder companies = new StringBuilder();
		for (String str1 : universityEventDom.getCompanyName()) {
			companies.append(str1).append(","); // separating contents using
												// semi colon
		}
		String companyList = companies.toString();

		if (companyList.length() > 1) {
			String[] companyListDetails = companyList.split(",");
			String[] invitedCompanyArray = invitedCompaniesStr.split(",");

			for (int i = 0; i < companyListDetails.length; i++) {

				if (universityEventDom.getStatus().equalsIgnoreCase("proposed")) {
					universityEventDom.setInvitationStatus("Pending");
				}

				else if (universityEventDom.getStatus().equalsIgnoreCase(
						"cancelled")) {
					universityEventDom.setInvitationStatus("Cancelled");
				} else {
					String companyName = invitedCompanyArray[i];
					String queryForStatus = "select invitation_status from invited_company_details where company_name='"
							+ companyName
							+ "' and event_id = '"
							+ eventId
							+ "'";
					eventStatus = cassandraOperations.queryForObject(
							queryForStatus, String.class);

					if (eventStatus.equalsIgnoreCase("accepted")
							|| eventStatus.equalsIgnoreCase("published")
							|| eventStatus.equalsIgnoreCase("scheduled")) {
						universityEventDom
								.setInvitationStatus(universityEventDom
										.getStatus());
					}

					else {
						universityEventDom.setInvitationStatus(eventStatus);
					}
				}

				Insert insertCompanyForUniversityEvent = QueryBuilder
						.insertInto("invited_company_details").values(
								new String[] { "event_id", "company_name",
										"invitation_status", "messages",
										"event_name", "university_name",
										"start_date", "end_date", "start_time",
										"end_time", "university_id",
										"event_type" },

								new Object[] {
										eventId,
										companyListDetails[i].trim(),
										universityEventDom
												.getInvitationStatus(),
										universityEventDom.getMessage(),
										universityEventDom.getEventName(),
										universityName, eventStartdate,
										eventEndDate,
										universityEventDom.getStartTime(),
										universityEventDom.getEndTime(),
										universityEventDom.getUniversityId(),
										universityEventDom.getEventType() });
				cassandraOperations.execute(insertCompanyForUniversityEvent);
			}
		} else {
			String emailIds = invitedCompaniesStr.substring(0,
					invitedCompaniesStr.length() - 1);

			String companyLists = companyList.substring(0,
					companyList.length() - 1);

			if (universityEventDom.getStatus().equalsIgnoreCase("proposed")) {
				universityEventDom.setInvitationStatus("Pending");
			}

			else if (universityEventDom.getStatus().equalsIgnoreCase(
					"cancelled")) {
				universityEventDom.setInvitationStatus("Cancelled");
			}

			else {
				String queryForStatus = "select invitation_status from "
						+ "company_details where company_name='"
						+ emailIds + "' and event_id= '" + eventId + "'";
				eventStatus = cassandraOperations.queryForObject(
						queryForStatus, String.class);

				if (eventStatus.equalsIgnoreCase("accepted")) {
					universityEventDom.setInvitationStatus("Published");
				}

				else if (eventStatus.equalsIgnoreCase("published")) {
					universityEventDom.setInvitationStatus("Scheduled");
				}

				else {
					universityEventDom.setInvitationStatus(eventStatus);
				}
			}

			Insert insertCompanyForUniveristyEvent = QueryBuilder.insertInto(
					"invited_company_details").values(
					new String[] { "event_id", "company_name",
							"invitation_status", "messages", "event_name",
							"university_name", "start_date", "end_date",
							"start_time", "end_time", "university_id",
							"event_type" },
					new Object[] { eventId, companyLists.trim(),
							universityEventDom.getInvitationStatus(),
							universityEventDom.getMessage(),
							universityEventDom.getEventName(), universityName,
							eventStartdate, eventEndDate,
							universityEventDom.getStartTime(),
							universityEventDom.getEndTime(),
							universityEventDom.getUniversityId(),
							universityEventDom.getEventType() });

			cassandraOperations.execute(insertCompanyForUniveristyEvent);

			
		}

	}

	/**
	 * This method is used to get all the details of an event created by
	 * university.
	 * 
	 * @param String
	 *            eventID
	 * @return UniversityEventDom
	 */
	@SuppressWarnings("unused")
	@Override
	public UniversityEventDom getScheduleEventByEventId(String eventID) {
		UniversityEventDom universityEventDom = new UniversityEventDom();
		String sqlQuery1 = "select * from university_event_details where event_id='"
				+ eventID + "'";
		UniversityEventDom universityEvent = cassandraOperations
				.queryForObject(sqlQuery1, new UniversityEventListMapper());
		return universityEvent;
	}

	/**
	 * This method is used for getting a list of all the companies invited for a
	 * particular event created by university
	 * 
	 * @param eventId
	 * @return List<UniversityEventDom> (invited companies)
	 */
	@Override
	public List<UniversityEventDom> getInvitedListByEventId(String eventID) {
		List<UniversityEventDom> universityEvent = new ArrayList<UniversityEventDom>();
		final String GET_INVITATIONS_BY_EVENT_ID = "select * from invited_company_details where event_id='"
				+ eventID + "' ALLOW FILTERING";
		universityEvent = cassandraOperations.query(
				GET_INVITATIONS_BY_EVENT_ID, new InvitedCompaniesMapper());
		return universityEvent;
	}

	private static class InvitedCompaniesMapper implements RowMapper<UniversityEventDom> {
		@Override
		public UniversityEventDom mapRow(Row rs, int arg1) throws DriverException {
			UniversityEventDom universityEventDom = new UniversityEventDom();
			
			universityEventDom.setEventId(rs.getString("event_id"));
			universityEventDom.setInviteCompanyName(rs.getString("company_name"));
			universityEventDom.setInvitationStatus(rs.getString("invitation_status"));
			universityEventDom.setTime(rs.getString("time"));
			universityEventDom.setUniversityName(rs.getString("university_name"));
			universityEventDom.setInviteCompanyName(rs.getString("company_name"));
			return universityEventDom;
		}

	}

	/**
	 * This method is used to get the count of events received by an employer
	 * and whose invitation status is pending
	 * 
	 * @param emailId
	 * @return Integer (inviteCount)
	 */
	public int getTotalCampusInvites(String companyName) {
		String GET_INVITATION_COUNT = "select count(*) from invited_company_details where company_name='"
				+ companyName
				+ "' and invitation_status='Pending' and read_flag=false ALLOW FILTERING";

		int inviteCount = Integer.valueOf(cassandraOperations.queryForObject(
				GET_INVITATION_COUNT, Long.class).toString());

		return inviteCount;
	}

	/**
	 * This method is used for getting all the events which are published by
	 * university
	 * 
	 * @param emailID
	 * @return Integer (upcomingEventsNo)
	 */

	public int getNoOfUpcomingEvents(String emailID) {

		String sql = "select count(*) from university_event_details where email_id='"
				+ emailID + "' and  status='Publish' ALLOW FILTERING ";

		int upcomingEventsNo = Integer.valueOf(cassandraOperations
				.queryForObject(sql, Long.class).toString());

		return upcomingEventsNo;

	}

	/**
	 * This method is used for getting the count of all the events created by an
	 * employer and are at pending status for a university
	 * 
	 * @param universityName
	 * @return Integer (noOfPendingRecevivedInvitations)
	 */
	public int getNoOfPendingInvitations(String universityName) {
		String sqlQuery1 = "select count(*) from employer_event_details where university_name='"
				+ universityName
				+ "' and invitation_status='Pending' ALLOW FILTERING";

		// int noOfPendingRecevivedInvitations =
		// getJdbcTemplate().queryForInt(sqlQuery1, universityName);
		int noOfPendingRecevivedInvitations = Integer
				.valueOf(cassandraOperations.queryForObject(sqlQuery1,
						Long.class).toString());

		return noOfPendingRecevivedInvitations;

	}

	/**
	 * This method is used for getting all the university created events and
	 * its details for a university
	 * 
	 * @param emailId
	 * @return List (eventList)
	 */
	@Override
	public List<UniversityEventDom> getEventList(String emailID) {
		List<UniversityEventDom> eventList = new ArrayList<UniversityEventDom>();
		
		Select selectEvents = QueryBuilder.select().from("university_event_details");
		selectEvents.where(QueryBuilder.eq("email_id", emailID));
		
		try
		{
			eventList = cassandraOperations.query(selectEvents,new UniversityEventListMapper());
		}
		catch(NullPointerException npe)
		{
			 eventList = new ArrayList<UniversityEventDom>();
		}
		return eventList == null ? new ArrayList<UniversityEventDom>() : eventList;
	}

	private static class UniversityEventListMapper implements
			RowMapper<UniversityEventDom> {

		@Override
		public UniversityEventDom mapRow(Row rs, int arg1)
				throws DriverException {
			UniversityEventDom universityEventDom = new UniversityEventDom();
			universityEventDom.setEventId(rs.getString("event_id"));
			universityEventDom.setEventName(rs.getString("event_name"));
			universityEventDom.setEventType(rs.getString("event_type"));
			if(null != rs.getDate("start_date"))
			universityEventDom.setStartDate(rs.getDate("start_date").toString());
			if(null != rs.getDate("end_date"))
			universityEventDom.setEndDate(rs.getDate("end_date").toString());
			universityEventDom.setStartTime(rs.getString("start_time"));
			universityEventDom.setEndTime(rs.getString("end_time"));
			universityEventDom.setStatus(rs.getString("status"));
			universityEventDom.setInvitedCompanies((List<String>) rs.getList("invite_companies_name", String.class));
			universityEventDom.setUniversityId(rs.getString("email_id"));
			universityEventDom.setAcceptedByStudentsList((List<String>) rs
					.getList("accepted_by_students", String.class));
			universityEventDom.setDeniedByStudentsList((List<String>) rs
					.getList("denied_by_students", String.class));
			universityEventDom.setVenue(rs.getString("venue"));
			universityEventDom.setUniversityName(rs
					.getString("university_name"));
			universityEventDom.setDescription(rs.getString("description"));
			universityEventDom.setTemplateName(rs.getString("template_name"));
			universityEventDom.setSpeakerName(rs.getString("speaker_name"));
			universityEventDom.setTopic(rs.getString("topic"));
			return universityEventDom;
		}

	}

	
	/**
	 * This method is used to update a seminar event created by employer
	 * 
	 * @param UniversityEventDom
	 */
	@Override
	public void updateSeminarEvent(UniversityEventDom universityEventDom) {
		String eventId = universityEventDom.getEventId();
		String GET_INVITED_COMPANIES = null;
		String invitedCompanyNamesForEvent = null;
		String sqlUniName = null;
		String eventStatus = null;

		Date eventStartDate = CaerusCommonUtility.stringToDate(
				universityEventDom.getStartDate(), "yyyy-MM-dd");

		Date eventEndDate = CaerusCommonUtility.stringToDate(
				universityEventDom.getEndDate(), "yyyy-MM-dd");

		if (universityEventDom.getStatus().equalsIgnoreCase("re-proposed")) {
			universityEventDom.setStatus("Proposed");
		}
		Update updateUniversityEventDetails = QueryBuilder
				.update("university_event_details");

		if(universityEventDom.getTopic()!=null)
			updateUniversityEventDetails.with(QueryBuilder.set("topic",
					universityEventDom.getTopic()));
		if(universityEventDom.getSpeakerName()!=null)
			updateUniversityEventDetails.with(QueryBuilder.set("speaker_name",
					universityEventDom.getSpeakerName()));
			
			
		
		updateUniversityEventDetails.with(QueryBuilder.set("start_date",
				eventStartDate));
		updateUniversityEventDetails.with(QueryBuilder.set("end_date",
				eventEndDate));
		updateUniversityEventDetails.with(QueryBuilder.set("start_time",
				universityEventDom.getStartTime()));
		updateUniversityEventDetails.with(QueryBuilder.set("end_time",
				universityEventDom.getEndTime()));
		updateUniversityEventDetails.with(QueryBuilder.set("status",
				universityEventDom.getStatus()));
		updateUniversityEventDetails.with(QueryBuilder.set("venue",
				universityEventDom.getVenue()));
		updateUniversityEventDetails.with(QueryBuilder.set("description",
				universityEventDom.getDescription()));
		
		updateUniversityEventDetails
				.where(QueryBuilder.eq("event_id", eventId));

		cassandraOperations.execute(updateUniversityEventDetails);

		StringBuilder invitedCompanyNames = new StringBuilder();
		for (String invitedCompanyName : universityEventDom
				.getInvitedCompanies()) {
			invitedCompanyNames.append(invitedCompanyName).append(","); // separating
																		// contents
																		// using
																		// semi
																		// colon
		}

		String invitedCompanyNamesStr = invitedCompanyNames.toString();

		StringBuilder sb1 = new StringBuilder();
		for (String str1 : universityEventDom.getCompanyName()) {
			sb1.append(str1).append(","); // separating contents using semi
											// colon
		}
		String companyList = sb1.toString();
		GET_INVITED_COMPANIES = "select invite_companies_name from university_event_details where event_id='"
				+ eventId + "'";
		cassandraOperations.queryForObject(GET_INVITED_COMPANIES, String.class);

		if (companyList.length() > 1) {
			String[] companyListDetails = companyList.split(",");
			String[] companyNames = invitedCompanyNamesStr.split(",");

			for (int i = 0; i < companyListDetails.length; i++) {

				if (universityEventDom.getStatus().equalsIgnoreCase("proposed")) {
					universityEventDom.setInvitationStatus("Pending");
				} else if (universityEventDom.getStatus().equalsIgnoreCase(
						"cancelled")) {
					universityEventDom.setInvitationStatus("Cancelled");
				} else {
					String queryForStatus = "select invitation_status from invited_company_details where company_name ='"
							+ companyNames[i]
							+ "' and event_id = '"
							+ eventId
							+ "'";
					eventStatus = cassandraOperations.queryForObject(queryForStatus,
							String.class);

					if (eventStatus.equalsIgnoreCase("accepted")
							|| eventStatus.equalsIgnoreCase("published")
							|| eventStatus.equalsIgnoreCase("scheduled")) {
						universityEventDom
								.setInvitationStatus(universityEventDom
										.getStatus());
					}

					else {
						universityEventDom.setInvitationStatus(eventStatus);
					}
				}
				String updateInvitedCompanyStatusQuery = "update invited_company_details set invitation_status=? where event_id=? and company_name=?";

				Update updateInvitedCompanyStatus = QueryBuilder
						.update("invited_company_details");

				updateInvitedCompanyStatus.with(QueryBuilder.set(
						"invitation_status", universityEventDom.getStatus()));
				updateInvitedCompanyStatus.where(QueryBuilder.eq("event_id",
						eventId));
				updateInvitedCompanyStatus.where(QueryBuilder.eq(
						"company_name", companyNames[i]));

				cassandraOperations.execute(updateInvitedCompanyStatus);

			}
		}
	}

	

	/**
	 * This method is used to get the list of all employer created events
	 * received by a university
	 * 
	 * @param universityName
	 * @return List (eventList)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getEventListByUniversityName(String universityName) {
		List<EmployerEventDom> events = new ArrayList<EmployerEventDom>();
		
		Select selectEvents = QueryBuilder.select().from("employer_event_details");
		selectEvents.where(QueryBuilder.eq("university_name", universityName));
		
		try {
			events = cassandraOperations.query(selectEvents,new EmployerEventMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex)
		{
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " getEventListByUniversityName" +ex.getStackTrace().toString());
		}

		return null == events ? new ArrayList<EmployerEventDom>() : events;
	}

	private static class EmployerEventMapper implements RowMapper<EmployerEventDom>{

		@Override
		public EmployerEventDom mapRow(Row rs, int arg1) throws DriverException {
			EmployerEventDom employerEventDom = new EmployerEventDom();
			employerEventDom.setEventId(rs.getString("event_id"));
			employerEventDom.setEventName(rs.getString("event_name"));
			
			if(null != rs.getDate("start_date"))
				employerEventDom.setStartDate(rs.getDate("start_date").toString());
			if(null != rs.getDate("end_date"))
				employerEventDom.setEndDate(rs.getDate("end_date").toString());
		
			employerEventDom.setStartTime(rs.getString("start_time"));
			employerEventDom.setEndTime(rs.getString("end_time"));
			employerEventDom.setParticipatingUniversity(rs
					.getString("university_name"));
			employerEventDom.setEventDescription(rs.getString("expectations"));
			employerEventDom.setInvitationStatus(rs.getString("status"));
			employerEventDom.setInvitationStatus(rs
					.getString("invitation_status"));
			employerEventDom.setEventStatus(rs.getString("status"));
			employerEventDom.setInvitationStatus(rs.getString("invitation_status"));
			employerEventDom.setCompanyName(rs.getString("company_name"));
			employerEventDom.setEmailId(rs.getString("email_id"));
			return employerEventDom;
		}

	}

	
	

	
	/**
	 * This method is used to upload a file by university (Excel sheet of students)
	 * @param inputStreamResume
	 * @author RavishaG
	 */
	@SuppressWarnings("unused")
	@Override
	public void uploadFile(InputStream inputStreamResume) {
		
		int readBytes = 0;
		
		byte[] buffer = null;
		try {

			if (inputStreamResume != null) {

				int size = inputStreamResume.available();

				if (size > 15000000) {
					buffer = new byte[15000000];
				} else {
					buffer = new byte[size];
				}

				readBytes = inputStreamResume.read(buffer);
			}

		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}
	
	

	/**
	 * This method is used to get all the students(registered and unregistered) for a university
	 * @param universityName
	 * @return List<UniversityLoginDom> (details)
 	 * @author RavishaG
	 */
	@Override
	public UniversityDetailsDom getStudentsOfUniversity(String universityName) {
		
		UniversityDetailsDom students = new UniversityDetailsDom();
		try
		{
			String query = "select registered_students_map,unregistered_students_map from student_university_connections where university_name = '"+universityName+"'";
			students = cassandraOperations.queryForObject(query,new UniversityConnectionsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex)
		{
			students = new UniversityDetailsDom();
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " getStudentsOfUniversity" +ex.getStackTrace().toString());
		}
		return students == null ? new UniversityDetailsDom(): students;
	}
	
	/**
	 * This method is used to get a map of students registered for a university and their batch
	 * @author RavishaG
	 */
	

	@Override
	public Map<String, String> registeredStudentDetails(String universityName) {
		Map<String, String> registeredStudentDetails = new HashMap<String, String>();
		try {
			String query = "select registered_students_map from student_university_connections where university_name = '"+ universityName + "'";
			cassandraOperations.queryForMap(query);
		} catch (NullPointerException | IllegalArgumentException | NoHostAvailableException ex) {
			registeredStudentDetails = new HashMap<String, String>();
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " registeredStudentDetails" +ex.getStackTrace().toString());
		}
		return registeredStudentDetails == null ? new HashMap<String, String>(): registeredStudentDetails;
	}

	
	 /**This method is used to add unregistered students to university 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	@Override
	public void addUnRegisteredStudentToMap(String universityName,Map<String,String> unRegisteredStudents)
	{
		Update updateUnregisteredStudents = QueryBuilder.update("student_university_connections");
		updateUnregisteredStudents.with(QueryBuilder.putAll("unregistered_students_map", unRegisteredStudents));
		updateUnregisteredStudents.where(QueryBuilder.eq("university_name", universityName));
		try {
			cassandraOperations.execute(updateUnregisteredStudents);
		}
		catch(IllegalArgumentException | NoHostAvailableException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " addUnRegisteredStudentToMap" +ex.getStackTrace().toString());
		}
	}

	/**
	 * This method is used to delete unregistered students from university
	 * 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	
	@Override
	public void deleteUnRegisteredStudent(String universityName,HashMap<String,String> unRegisteredStudents)
	{
			String studentEmailId = null;
		
			for(Entry<String, String> entry : unRegisteredStudents.entrySet())
			{
				 studentEmailId = entry.getKey();	
				 String updateUnRegisteredMapQuery = "delete unregistered_students_map['"+studentEmailId+"'] from student_university_connections where university_name = '"+universityName+"'" ;
				 cassandraOperations.execute(updateUnRegisteredMapQuery);
			}
	}
	
	/**
	 * This method is used to delete registered students from university 
	 * @param registeredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	
	@Override
	public void deleteRegisteredStudent(String universityName,HashMap<String,String> registeredStudents)
	{
		String studentEmailId = "";
		int count = 0;
		
		 String queryForCount = "select registered_students_count from student_university_connections where university_name = '"+universityName+"'";
		 count = cassandraOperations.queryForObject(queryForCount,Integer.class);
		 
			for(Entry<String, String> entry : registeredStudents.entrySet())
			{
				 studentEmailId = entry.getKey();
				 String updateUnRegisteredMapQuery = "delete registered_students_map['"+studentEmailId+"'] from student_university_connections where university_name = '"+universityName+"'" ;
				 cassandraOperations.execute(updateUnRegisteredMapQuery);
			}
		
		String query = "update student_university_connections set registered_students_count = "+(count - 1)+" where university_name = '"+universityName+"'";
		cassandraOperations.execute(query);	
		
	}
	
	
	/**
	 * This method is used to segregate existing (registered) and unregistered students from a given map of students 
	 * @author RavishaG
	 * @param validEntries
	 * @return HashMap<String,HashMap<String,String>>  (totalStudentsMap)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Map<String,Map<String,String>> checkExistingStudents(Map<String,String> validEntries)
	{
		List<UniversityDetailsDom> existingStudents = new ArrayList<UniversityDetailsDom>();
		String queryForExistingStudents = "select university_name,registered_students_map from student_university_connections";
		
		HashMap<String,String> finalizedStudentsMap = new HashMap<String, String>();
		HashMap<String,String> existingStudentsMap = new HashMap<String, String>();
		Map<String,Map<String,String>> totalStudentsMap = new HashMap<String, Map<String,String>>();
		
		try
		{
			existingStudents =  cassandraOperations.query(queryForExistingStudents,new StudentUniversityForRegisteredStudentsMapper());
			Map<String,String> superMap = new HashMap<String, String>();

		       if(existingStudents != null && !existingStudents.isEmpty())
		       {
					 for (UniversityDetailsDom universityDetailsDom : existingStudents)
					 {
						 if(universityDetailsDom!=null)
						 {
							 superMap.putAll(universityDetailsDom.getRegisteredStudents());
						 }
					}
					
					 
					 for (Entry<String, String> candidateEntry : validEntries.entrySet()) {
						if(superMap.containsKey(candidateEntry.getKey())){
							existingStudentsMap.put(candidateEntry.getKey(), candidateEntry.getValue());
						}
						else {
							finalizedStudentsMap.put(candidateEntry.getKey(), candidateEntry.getValue());
						}
					}
					 
					 	totalStudentsMap.put("existingStudents",existingStudentsMap);
						totalStudentsMap.put("notExistingStudents",finalizedStudentsMap);
		       }
		}	
		
		catch(NullPointerException | IllegalArgumentException ex)
		{
			totalStudentsMap = new HashMap<String, Map<String,String>>();
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " checkExistingStudents" +ex.getStackTrace().toString());
		}
		
		 return totalStudentsMap == null ? new HashMap<String, Map<String,String>>() :totalStudentsMap;
	
	}
	
	/** This method is used to get the number of events broadcasted by
	 * university
	 * 
	 * @param universityName
	 * 
	 * @return Integer (count)
	 * 
	 * @author RavishaG
	 */
	@Override
	public int getBroadcastedEventCount(String universityName) {

		String queryCount = "select count(1) from employer_event_details where invitation_status = 'Broadcasted' and university_name = '"
				+ universityName + "' ALLOW FILTERING ";


		int count = Integer.valueOf(cassandraOperations.queryForObject(
				queryCount, Long.class).toString());

		return count;

	}

	/**
	 * This method is used by university to update the status of campus job
	 * 
	 * @author PallaviD
	 * @param jobIdAndFirmId
	 * @param universityName
	 */
	@Override
	public void updateCampusJobStatus(String jobIdAndFirmId,
			String universityName, String jobAction) {
		String sqlQuery = "update university_job_dtls set status='" + jobAction
				+ "' where job_id_and_firm_id ='" + jobIdAndFirmId
				+ "' and univ_name='" + universityName + "'";

		cassandraOperations.execute(sqlQuery);
	}

	/**
	 * This method is used by university to update the status of campus
	 * internship
	 * 
	 * @author PallaviD
	 * @param jobIdAndFirmId
	 * @param universityName
	 */
	@Override
	public void updateCampusInternshipStatus(String internshipIdAndFirmId,
			String universityName, String internshipAction) {
		String sql = "update university_internship_dtls set status='"
				+ internshipAction + "' where internship_id_and_firm_id ='"
				+ internshipIdAndFirmId + "' and univ_name='" + universityName
				+ "'";

		cassandraOperations.execute(sql);

	}

	/**
	 * This method is used the get the university for a registered student
	 * 
	 * @author PallaviD
	 * @param studentEmailId
	 * @return universityName
	 */
	
	@Override
	public String getUniversityForRegisteredStudent(String emailId) {
		
		String dbUniversityName=null;
		
		String sqlQuery = "select registered_students_map, university_name from student_university_connections";
		
		List<UniversityDetailsDom> registered_students=null;
		
		registered_students = cassandraOperations.query(sqlQuery, new StudentUniversityForRegisteredStudentsMapper());
		
		if(null!=registered_students)
			{
				for (UniversityDetailsDom universityLoginDom : registered_students) 
				{
					if(null!=universityLoginDom.getRegisteredStudents())
					{
						if(universityLoginDom.getRegisteredStudents().containsKey(emailId))
						
					{
						dbUniversityName=universityLoginDom.getUniversityName();
					
						if(null!=dbUniversityName)
						{
							break;
						}
						
					}
				}
				}
			}	
		return dbUniversityName;
	}
	
	
	@Override
	public int getbroadcastedJobCount(String universityName) {

		String queryCount = "select count(1) from university_job_dtls where status = 'Broadcasted' and univ_name = '"
				+ universityName + "' ALLOW FILTERING ";

		// int count = getJdbcTemplate().queryForInt(queryCount,
		// universityName);

		int count = Integer.valueOf(cassandraOperations.queryForObject(
				queryCount, Long.class).toString());

		return count;

	}

	

	@Override
	public UniversityDetailsDom getUniversityDetailsByName(String universityName) {

		UniversityDetailsDom universityDetails = null;
		try {

			Select select = QueryBuilder.select().from("university_reg");

			select.where(QueryBuilder.eq("universityname", universityName));

			universityDetails = cassandraOperations.queryForObject(select,
					new UniversityDetailMapper());

		} catch (EmptyResultDataAccessException exception) {
			throw new DoesNotExistException("Empty Result Set");
		} catch (Exception ex) {
			
		}
		return universityDetails;
	}

	/**
	 * This method is used to get status of the event created by a university
	 * 
	 * @author ravishag
	 * @param eventId
	 * @return
	 */
	
	  @Override public String getEventStatus(String eventId) {
	  
	  String query ="select status from university_event_details where event_id ='"+eventId+"'";
	  
	  String status = cassandraOperations.queryForObject(query,String.class);
	  
	  return status;
	  
	 }
	 
	
	
	/**
	 * This method is used to find university event details by university
	 * name
	 * 
	 * @author RavishaG
	 * @param universityName
	 * @return list
	 */
	
	@Override
	public List<UniversityEventDom> getEventDetailsByUniversityName(String universityName) {
		String query = "select * from university_event_details where university_name ='"+universityName+"' and status = 'Scheduled' ALLOW FILTERING";
		List<UniversityEventDom> universityEventDetails = cassandraOperations.query(query, new UniversityEventMapper());
		return universityEventDetails;
		
	}

	
		
	
	/**
	 * This method is used to find the time an event was accepted by
	 * candidate
	 * 
	 * @author RavishaG
	 * @param studentEmailId
	 * @param eventName
	 * @param firmId
	 * @return Date
	 */
	@Override
	public Date getEventAcceptedTime(String studentEmailId,
			String eventName, String firmId) {
		

		Select select = QueryBuilder.select("accepted_time").from(
				"confirmed_candidate_events");
		select.where(QueryBuilder.eq("student_email_id", studentEmailId));
		select.where(QueryBuilder.eq("event_name", eventName));
		select.where(QueryBuilder.eq("corp_univ_email_id", firmId));

		Date acceptedDateTime=cassandraOperations.queryForObject(select,Timestamp.class);
		 

		return acceptedDateTime;                                                                                                                           
	}

	
	/**
	 * This method is used to update an event Template
	 * 
	 * @author TrishnaR
	 * @param template
	 */
	@Override
	public void updateEventTemplate(String template, String eventId) {
		String updateQuery = "update university_event_details set template_name='"
				+ template + "' where event_id='" + eventId + "'";
		cassandraOperations.execute(updateQuery);
	}

	
	/**
	 * This method is used to retrieve the List of corporates that have accepted
	 * the event invitation
	 * 
	 * @author TrishnaR
	 * @param eventId
	 * @return List<UniversityEventDom> (list of attending corporates)
	 */
	@Override
	public List<UniversityEventDom> getAttendingCorporateList(String eventId) {
		List<UniversityEventDom> attendingCorporates = new ArrayList<UniversityEventDom>();
		List<String> statuses = new ArrayList<String>(){{
			add(CaerusAPIStringConstants.INVITATION_STATUS_ACCEPTED);
			add(CaerusAPIStringConstants.INVITATION_STATUS_SCHEDULED);
			}};
		
		for (String status : statuses) {
			Select selectAttendingCorporates = QueryBuilder.select().from("invited_company_details");
			selectAttendingCorporates.where(QueryBuilder.eq("invitation_status",status));
			selectAttendingCorporates.where(QueryBuilder.eq("event_id", eventId));
			
			try {
				attendingCorporates.addAll(cassandraOperations.query(selectAttendingCorporates, new InvitedCompaniesMapper()));
			}
			catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
				attendingCorporates = new ArrayList<UniversityEventDom>();
			}
		}	
		return null == attendingCorporates? new ArrayList<UniversityEventDom>() : attendingCorporates;
	}

	
	@Override
	public List<EmployerCampusJobPostDom> getCampusJobs(String dbUniversityName) {
		List<String> statusList = new ArrayList<String>();
		List<EmployerCampusJobPostDom> jobsList = new ArrayList<EmployerCampusJobPostDom>();

		statusList.add("Published");
		statusList.add("Broadcasted");

		if (null != statusList) {
			for (String status : statusList) {

				String sqlQuery = "select * from university_job_dtls where univ_name='"
						+ dbUniversityName
						+ "' and status='"
						+ status
						+ "' ALLOW FILTERING;";

				// List<EmployerCampusJobPostDom> jobPostedListForUniversity =
				// getJdbcTemplate().query(sqlQuery, new
				// UniversityJobsBroadcastMapper(),dbUniversityName,status);

				List<EmployerCampusJobPostDom> jobPostedListForUniversity = cassandraOperations
						.query(sqlQuery, new UniversityJobsBroadcastMapper());
				jobsList.addAll(jobPostedListForUniversity);
			}

		}
		return jobsList;

	
	}

	private static class UniversityJobsBroadcastMapper implements
			RowMapper<EmployerCampusJobPostDom> {

		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int arg1)
				throws DriverException {
			EmployerCampusJobPostDom employerCampusJobPostDom = new EmployerCampusJobPostDom();

			employerCampusJobPostDom.setJobIdAndFirmId(rs
					.getString("job_id_and_firm_id"));

			employerCampusJobPostDom.setJobId(rs.getString("job_id"));
			employerCampusJobPostDom.setFirmId(rs.getString("firm_id"));
			employerCampusJobPostDom.setJobTitle(rs.getString("job_title"));
			employerCampusJobPostDom.setJobType(rs.getString("job_type"));
			employerCampusJobPostDom.setYearsOfExperienceFrom(rs
					.getInt("yearofexperiencefrom"));
			employerCampusJobPostDom.setYearsOfExperienceTo(rs
					.getInt("yearofexperienceto"));
			employerCampusJobPostDom.setJobDescription(rs
					.getString("description"));
			employerCampusJobPostDom.setPrimarySkills(rs.getList(
					"primary_skills", String.class));
			employerCampusJobPostDom.setSecondarySkills(rs.getList(
					"secondary_skills", String.class));
			employerCampusJobPostDom.setPayPerWeek(rs.getString("payperweek"));
			employerCampusJobPostDom.setFirmName(rs.getString("firm_name"));
			// employerCampusJobPostDom.setEligibleStreams(rs.getList("eligible_streams",String.class));
			employerCampusJobPostDom.setJobLocation(rs.getString("location"));
			employerCampusJobPostDom.setIndustry(rs.getString("industry"));
			employerCampusJobPostDom.setFunctionalArea(rs
					.getString("functional_area"));
			employerCampusJobPostDom.setGpaCutOffFrom(rs
					.getInt("gpacutofffrom"));
			employerCampusJobPostDom.setGpaCutOffTo(rs.getInt("gpacutoffto"));
			employerCampusJobPostDom.setStatus(rs.getString("status"));
			employerCampusJobPostDom
					.setCandidateJobStatus((Map<String, String>) (rs.getMap(
							"candidate_job_status", String.class, String.class)));

			// rs.getMap("applied_students",String.class,Date.class);
			employerCampusJobPostDom
					.setCampusJobAppliedStudents((Map<String, Date>) (rs
							.getMap("applied_students", String.class,
									Date.class)));
			employerCampusJobPostDom.setUniversityName(rs.getString("univ_name"));
			
			employerCampusJobPostDom.setPostedOn(CaerusCommonUtility.changeDateFormat(rs.getString("posted_on"),"E MMM dd HH:mm:ss Z yyyy","dd MMM yyyy"));
			
			employerCampusJobPostDom.setSeenByUniversityFlag(rs
					.getBool("campus_job_seen_by_university_flag"));

			return employerCampusJobPostDom;
		}

	}

	/**
	 * This method is used to get all the campus jobs posted by an employer
	 * 
	 * @param emailId
	 * @return List<UniversityLoginDom> employerJobPostedListForUniversity
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusJobsByEmployer(String emailId) {
		String getCampusJobs = "select * from university_job_dtls where firm_id='"
				+ emailId + "' and is_deleted=false allow filtering;";
		List<EmployerCampusJobPostDom> campusJobs = cassandraOperations.query(
				getCampusJobs, new CampusJobsMapper());
		return campusJobs == null ? new ArrayList<EmployerCampusJobPostDom>()
				: campusJobs;
	}

	/**
	 * This class is used to Map the ResultSet values to Domain/Value Objects
	 * for details of a campus job
	 * 
	 * @author KarthikeyanK
	 */
	private static class CampusJobsMapper implements
			RowMapper<EmployerCampusJobPostDom> {

		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int arg1) {

			EmployerCampusJobPostDom campusJobDetails = new EmployerCampusJobPostDom();

			campusJobDetails.setJobIdAndFirmId(rs
					.getString("job_id_and_firm_id"));
			campusJobDetails.setJobId(rs.getString("job_id"));
			campusJobDetails.setFirmId(rs.getString("firm_id"));
			campusJobDetails.setJobTitle(rs.getString("job_title"));
			campusJobDetails.setJobType(rs.getString("job_type"));
			campusJobDetails.setJobDescription(rs.getString("description"));
			campusJobDetails.setFirmName(rs.getString("firm_name"));
			campusJobDetails.setJobLocation(rs.getString("location"));
			campusJobDetails.setIndustry(rs.getString("industry"));
			campusJobDetails.setFunctionalArea(rs.getString("functional_area"));
			campusJobDetails.setUniversityName(rs.getString("univ_name"));
			campusJobDetails.setPostedOn(rs.getString("posted_on"));
			campusJobDetails.setPostedBy(rs.getString("firm_name"));
			campusJobDetails.setFlag(rs.getString("flag"));
			campusJobDetails.setStatus(rs.getString("status"));

			Integer responseCount = 0;
			if (rs.getMap("applied_students", String.class, Date.class) != null && !rs.getMap("applied_students", String.class, Date.class).isEmpty())
			{
				campusJobDetails.setCampusJobAppliedStudents(rs.getMap("applied_students", String.class, Date.class));
				responseCount = rs.getMap("applied_students", String.class, Date.class).size();
			}
			campusJobDetails.setResponseCount(responseCount.toString());
			
			campusJobDetails.setAppliedCampusJobStatusMap(rs.getMap("candidate_job_status", String.class, String.class));
			
			return campusJobDetails;
		}
	}

	/**
	 * This method is used to get all the campus internships posted by an
	 * employer
	 * 
	 * @param emailId
	 * @return List<EmployerCampusJobPostDom> employerJobPostedListForUniversity
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusInternshipsByEmployer (String emailId) {
		Select selectCampusInternships = QueryBuilder.select().from("university_internship_dtls");
		selectCampusInternships.where(QueryBuilder.eq("firm_id",emailId));
		selectCampusInternships.where(QueryBuilder.eq("is_deleted",false));
		selectCampusInternships.where(QueryBuilder.eq("self_posted",false));
		selectCampusInternships.allowFiltering();
		
		List<EmployerCampusJobPostDom> campusInternships = new ArrayList<EmployerCampusJobPostDom>();
		
		try {
			campusInternships = cassandraOperations.query(selectCampusInternships, new CampusInternshipMapper());
		}
		catch(IllegalArgumentException | NullPointerException | NoHostAvailableException ex) {
			campusInternships = new ArrayList<EmployerCampusJobPostDom>();
			logger.error("Something Went Wrong in getCampusInternshipsByEmployer"+ex.getStackTrace().toString());
		}
		return campusInternships == null ? new ArrayList<EmployerCampusJobPostDom>() : campusInternships;
	}

	/**
	 * This method is used to get internships(Published & Broadcasted) posted by
	 * employers for university
	 * 
	 * @param UniversityName
	 * @return List<EmployerCampusJobPostDom> jobsList
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusInternships(String dbUniversityName) {
		List<String> statuses = new ArrayList<String>(){{
			add("Published");
			add("Broadcasted");
		}};
		
		List<EmployerCampusJobPostDom> campusInternships = new ArrayList<EmployerCampusJobPostDom>();

		if (null != statuses) {
			for (String status : statuses) {
				Select selectCampusInternships = QueryBuilder.select().from("university_internship_dtls");
				selectCampusInternships.where(QueryBuilder.eq("univ_name",dbUniversityName));
				selectCampusInternships.where(QueryBuilder.eq("status",status));
				selectCampusInternships.where(QueryBuilder.eq("is_deleted",false));
				selectCampusInternships.where(QueryBuilder.eq("self_posted",false));
				selectCampusInternships.allowFiltering();

				List<EmployerCampusJobPostDom> campusInternshipsForOneStatus = cassandraOperations.query(selectCampusInternships, new CampusInternshipMapper());
				campusInternships.addAll(campusInternshipsForOneStatus);
			}
		}
		return campusInternships == null ? new ArrayList<EmployerCampusJobPostDom>() : campusInternships;
	}

	private static class CampusInternshipMapper implements
			RowMapper<EmployerCampusJobPostDom> {

		@Override
		public EmployerCampusJobPostDom mapRow(Row rs, int arg1)
				throws DriverException {
			EmployerCampusJobPostDom campusInternshipDetails = new EmployerCampusJobPostDom();

			campusInternshipDetails.setInternshipIdAndFirmId(rs
					.getString("internship_id_and_firm_id"));
			campusInternshipDetails.setInternshipId(rs
					.getString("internship_id"));
			campusInternshipDetails.setFirmId(rs.getString("firm_id"));
			campusInternshipDetails.setFirmName(rs.getString("firm_name"));
			campusInternshipDetails.setPostedBy(rs.getString("firm_name"));
			campusInternshipDetails.setInternshipTitle(rs
					.getString("internship_title"));
			campusInternshipDetails.setInternshipType(rs
					.getString("internship_type"));
			campusInternshipDetails.setApproximateHours(rs
					.getString("approximate_hours"));
			campusInternshipDetails.setStartDate(rs.getString("start_date"));
			campusInternshipDetails.setEndDate(rs.getString("end_date"));
			campusInternshipDetails
					.setPayPerHours(rs.getString("payper_hours"));
			campusInternshipDetails.setNumberOfVacancy(rs
					.getString("numberofvacancy"));
			campusInternshipDetails
					.setUniversityName(rs.getString("univ_name"));
			campusInternshipDetails.setPrimarySkills(rs.getList(
					"primary_skills", String.class));
			campusInternshipDetails.setSecondarySkills(rs.getList(
					"secondary_skills", String.class));
			campusInternshipDetails.setInternshipLocation(rs
					.getString("internship_location"));
			campusInternshipDetails.setInternshipDescription(rs
					.getString("internship_description"));
			campusInternshipDetails.setStatus(rs.getString("status"));

			campusInternshipDetails.setPostedOn(CaerusCommonUtility.changeDateFormat(rs.getString("posted_on"),"E MMM dd HH:mm:ss Z yyyy","dd MMM yyyy"));
			
			Integer responseCount = 0;
			if( rs.getMap("applied_students", String.class,Date.class) != null &&  ! rs.getMap("applied_students", String.class,Date.class).isEmpty())
			{
				campusInternshipDetails.setCampusInternshipAppliedStudents((Map<String, Date>) rs.getMap("applied_students", String.class,Date.class));
				responseCount = rs.getMap("applied_students", String.class,Date.class).size();
			}
			campusInternshipDetails.setResponseCount(responseCount.toString());
			
			return campusInternshipDetails;
		}
	}

	/**
	 * This method is used for editing the University Profile
	 * 
	 * @param UnivesityRegisterationDom
	 */
	@SuppressWarnings("unused")
	@Override
	public void editUniversity(UniversityDetailsDom universityDetailsDom) {
		try {

			
			String universityName = universityDetailsDom.getUniversityName();

			Insert insert = QueryBuilder.insertInto("university_reg").values(new String[] {
					
					"phonenumber","address","zipcode","state","city",
					"university_website","about_us","ug_fulltime_students_count",
					"ug_parttime_students_count","pg_fulltime_students_count","pg_parttime_students_count",
					"teaching_staff_count","research_staff_count","support_staff_count","autumn_start_date",
					"autumn_end_date","spring_start_date","spring_end_date","summer_start_date",
					"summer_end_date","recognition_list","available_course_type_list","available_course_name_list", "universityname"
		
					
			}, 
					
					
					new Object[]{universityDetailsDom.getPhoneNumber(),
					universityDetailsDom.getUniversityAddress(),
					universityDetailsDom.getZipCode(),
					universityDetailsDom.getState(),
					universityDetailsDom.getCity(),
					universityDetailsDom.getUniversityWebsite(),
					universityDetailsDom.getAboutUs(),
					universityDetailsDom.getUgFullTimeStudents(),
					universityDetailsDom.getUgPartTimeStudents(),
					universityDetailsDom.getPgFullTimeStudents(),
					universityDetailsDom.getPgPartTimeStudents(),
					universityDetailsDom.getNoOfTeachingStaff(),
					universityDetailsDom.getNoOfResearchStaff(),
					universityDetailsDom.getNoOfSupportStaff(),
					universityDetailsDom.getAutumnStartDate(),
					universityDetailsDom.getAutumnEndDate(),
					universityDetailsDom.getSpringStartDate(),
					universityDetailsDom.getSpringEndDate(),
					universityDetailsDom.getSummerStartDate(),
					universityDetailsDom.getSummerEndDate(),
					universityDetailsDom.getAwardsAndRecognitionList(),
					universityDetailsDom.getCourseType(),
					universityDetailsDom.getCourseName(),
					/*universityDetailsDom.getUniversityLogoName(),
					ByteBuffer.wrap(universityDetailsDom.getPhotoData()),*/
					universityDetailsDom.getUniversityName()});
			
			
			cassandraOperations.execute(insert);		

			// Update logo only if added
			if(universityDetailsDom.getUniversityLogoName() != null && !universityDetailsDom.getUniversityLogoName().isEmpty())
			{
				Update update = QueryBuilder.update("university_reg");
				
				update.with(QueryBuilder.set("university_logo_filename", universityDetailsDom.getUniversityLogoName()));
				
				update.with(QueryBuilder.set("university_logo", ByteBuffer.wrap(universityDetailsDom.getPhotoData())));
				
				update.where(QueryBuilder.eq("universityname", universityDetailsDom.getUniversityName()));
				
				cassandraOperations.execute(update);
			}
			


		} catch (Exception e) {
			e.printStackTrace();
		}
	
}


	@Override
	public void updateCorporateInvitationStatus(String eventId, String status) {
		if (status.equalsIgnoreCase("undo")) {
			status = CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_PENDING;
		}
		if (status.equalsIgnoreCase("UndoBroadcast")) {
			status = CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_ACCEPTED;
		}
		Update updateCorporateInviteStatus = QueryBuilder.update("employer_event_details");
		
		updateCorporateInviteStatus.with(QueryBuilder.set("invitation_status",status));
		updateCorporateInviteStatus.where(QueryBuilder.eq("event_id",eventId));
		
		cassandraOperations.execute(updateCorporateInviteStatus);
	}

	@Override
	public Map<String,Map<String,String>> checkRegisteredStudent(String universityName,Map<String,String> validEntries) {
		
		
		String query = "select username from user where authority = 'ROLE_STUDENT'"; 
		
		List<String> studentEmailIdList = cassandraOperations.queryForList(query,String.class);
		HashMap<String,String> registeredStudents = new HashMap<String,String>();
		HashMap<String,String> unRegisteredStudents = new HashMap<String,String>();
		Map<String,Map<String,String>> students= new HashMap<String,Map<String,String>>();
		if(studentEmailIdList!=null)
		{
			for(Entry<String, String> entry : validEntries.entrySet())
			{
				if(studentEmailIdList.contains(entry.getKey()))
				{
					registeredStudents.put(entry.getKey(),entry.getValue());
				}
				else
				{
					unRegisteredStudents.put(entry.getKey(),entry.getValue());
				}
			}
			
			students.put("registeredStudents",registeredStudents);
			students.put("unRegisteredStudents",unRegisteredStudents);
			
			
		}
			return students;
	}

	@Override
	public void addRegisteredStudentToMap(String universityName,Map<String,String> registeredStudents)
	{
		
		String studentEmailId = null;
		String batch = null;
		int count = 0;
		
		try
		 {

			 String queryForCount = "select registered_students_count from student_university_connections where university_name = '"+universityName+"'";
			 count = cassandraOperations.queryForObject(queryForCount,Integer.class);
			 
			 if(registeredStudents.size() != 0)
			 {
				 count += registeredStudents.size();
			 }
			 
			    String query = "update student_university_connections set registered_students_count=" + count+ "where university_name = '"+universityName+"'";
				cassandraOperations.execute(query);
				
				for(Entry<String, String> entry : registeredStudents.entrySet())
				{
					 studentEmailId = entry.getKey();
					 batch = entry.getValue();	 		
					 
					 String updateRegisteredMapQuery = "update student_university_connections set registered_students_map = registered_students_map + {'"+studentEmailId+"':'"+batch+"'}  where university_name = '"+universityName+"'" ;			 
					 cassandraOperations.execute(updateRegisteredMapQuery);	
		
				}	
		 }
		
		catch(NullPointerException npe)
		{
			for(Entry<String, String> entry : registeredStudents.entrySet())
			{
				 studentEmailId = entry.getKey();
				 batch = entry.getValue();	
				 String updateRegisteredMapQuery = "update student_university_connections set registered_students_map = registered_students_map + {'"+studentEmailId+"':'"+batch+"'}  where university_name = '"+universityName+"'" ;			 
				 cassandraOperations.execute(updateRegisteredMapQuery);	
	
			}	
			
			String query = "update student_university_connections set registered_students_count=" + registeredStudents.size()+ "where university_name = '"+universityName+"'";
			cassandraOperations.execute(query);
		}
		
		catch(EmptyResultDataAccessException e)
		{
			for(Entry<String, String> entry : registeredStudents.entrySet())
			{
				 studentEmailId = entry.getKey();
				 batch = entry.getValue();	
				 String updateRegisteredMapQuery = "update student_university_connections set registered_students_map = registered_students_map + {'"+studentEmailId+"':'"+batch+"'}  where university_name = '"+universityName+"'" ;			 
				 cassandraOperations.execute(updateRegisteredMapQuery);	
	
			}	
			
			String query = "update student_university_connections set registered_students_count=" + registeredStudents.size()+ "where university_name = '"+universityName+"'";
			cassandraOperations.execute(query);
		}
		
			
				
		
	}

	/**
	 * This method is used to update candidate's action on university event
	 * @author RavishaG
	 * @param universityEventDom
	 * @param studentEmailId
	 */
	@Override
	public void updateCandidateActionOnUniversityEvent(UniversityEventDom universityEventDom, String studentEmailId) {
		
		String query = null;
		
		if(universityEventDom.getStatus().equalsIgnoreCase("accept"))
		{
			
			query = "update university_event_details set accepted_by_students = accepted_by_students + ['"+studentEmailId+"'] where event_id = '"+ universityEventDom.getEventId().trim()+"'";
			
			String query1 = "insert into confirmed_candidate_events(student_email_id,event_name,corp_univ_email_id,accepted_time,university_name) values(?,?,?,?,?)";
			
			Insert insertConfirmedCandidates= QueryBuilder.insertInto("confirmed_candidate_events").values(new String[]{"student_email_id","event_name","corp_univ_email_id","accepted_time","university_name"}, new Object[]{studentEmailId, universityEventDom.getEventName(), universityEventDom.getUniversityId(), new Date(), universityEventDom.getUniversityName()});
			
			cassandraOperations.execute(insertConfirmedCandidates);
		}
		
		if(universityEventDom.getStatus().equalsIgnoreCase("deny"))
		{
			query = "update university_event_details set denied_by_students = denied_by_students + ['"+studentEmailId+"'] where event_id ='"+ universityEventDom.getEventId().trim()+"'";
		}
		
		cassandraOperations.execute(query);
	}

	@Override
	public void revertCandidateActionOnUniversityEvent(String studentEmailId,
			UniversityEventDom universityEventDom) {
		
			String checkAcceptedStudentsExist="select accepted_by_students from university_event_details where event_id='"+universityEventDom.getEventId()+"'";
			try
			{
				List<String> accepted_students = cassandraOperations.queryForObject(checkAcceptedStudentsExist, List.class);
			
				String queryForAcceptedStudentsList = "update university_event_details set accepted_by_students = accepted_by_students - ['"+studentEmailId+"'] where event_id = '"+universityEventDom.getEventId()+"'";
			
				cassandraOperations.execute(queryForAcceptedStudentsList);
			}
			catch(NullPointerException e)
			{
				String queryForAcceptedStudentsList = "delete accepted_by_students from university_event_details where  event_id='"+universityEventDom.getEventId()+"'";
				
				cassandraOperations.execute(queryForAcceptedStudentsList);
			}
			
			String checkDeniedStudentsExist="select denied_by_students from university_event_details where event_id='"+universityEventDom.getEventId()+"'";
			
			try
			{
				List<String> deniedStudents = cassandraOperations.queryForList(checkDeniedStudentsExist, String.class);
			
				String queryForDeniedstudentsList = "update university_event_details set denied_by_students = denied_by_students - ['"+studentEmailId+"'] where event_id = '"+universityEventDom.getEventId()+"'";
			
				cassandraOperations.execute(queryForDeniedstudentsList);
			}
			catch(NullPointerException e)
			{
				String queryForDeniedStudentsList = "delete denied_by_students from university_event_details where  event_id='"+universityEventDom.getEventId()+"'";
				
				cassandraOperations.execute(queryForDeniedStudentsList);
			}
			
			String queryForConfirmedCandidatesTable = "delete from confirmed_candidate_events where student_email_id = '"+studentEmailId+"' and event_name = '"+universityEventDom.getEventName()+"' and corp_univ_email_id = '"+ universityEventDom.getUniversityId()+"'";
			
			cassandraOperations.execute(queryForConfirmedCandidatesTable);
		}

}





