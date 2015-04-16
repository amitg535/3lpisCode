package caerusapp.dao.employer;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;


public class EmployerEventDao implements IEmployerEventDao{

	Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	CassandraOperations cassandraOperations;

	private static class EmployerEventMapper implements RowMapper<EmployerEventDom> {
		@Override
		public EmployerEventDom mapRow(Row rs, int arg1)throws DriverException {
			
			EmployerEventDom employerEventDom = new EmployerEventDom();
			employerEventDom.setEventId(rs.getString("event_id"));
			employerEventDom.setEventName(rs.getString("event_name"));
			
			if(rs.getDate("start_date") != null)
				employerEventDom.setStartDate(rs.getDate("start_date").toString());
			
			if(rs.getDate("end_date") != null)
				employerEventDom.setEndDate(rs.getDate("end_date").toString());
			
			employerEventDom.setStartTime(rs.getString("start_time"));
			employerEventDom.setEndTime(rs.getString("end_time"));
			employerEventDom.setParticipatingUniversity(rs.getString("university_name"));
			employerEventDom.setEventDescription(rs.getString("expectations"));
			employerEventDom.setEventStatus(rs.getString("status"));
			employerEventDom.setInvitationStatus(rs.getString("invitation_status"));
			employerEventDom.setCompanyName(rs.getString("company_name"));
			employerEventDom.setEmailId(rs.getString("email_id"));
			employerEventDom.setEventLocation(rs.getString("event_location"));
			
			employerEventDom.setEligibleBatches(rs.getList("eligible_batches", String.class));
			employerEventDom.setNumberOfHirings(rs.getList("no_of_hirings", String.class));
			employerEventDom.setFunctionalAreas(rs.getList("functional_areas", String.class));
			employerEventDom.setMinimumSalaryOffered(rs.getList("min_sal_offered", String.class));
			employerEventDom.setEmployerRepositoryFileNames(rs.getList("repo_file_names", String.class));
			
			employerEventDom.setAttachCompanyProfile(rs.getBool("is_company_profile_attached"));
			employerEventDom.setAttachPreplacementFiles(rs.getBool("is_pre_placement_attached"));
			
			employerEventDom.setAcceptedByStudentsList(rs.getList("accepted_by_students", String.class));
			employerEventDom.setDeniedByStudentsList(rs.getList("denied_by_students", String.class));
			
			return employerEventDom;
		}
	
	}

		
	
	
	@Override
	public EmployerEventDom getEmployerEventDetails(String eventId) {
		String selectEventDetailsQuery = "select * from employer_event_details where event_id = '"+eventId+"'";
		EmployerEventDom eventDetailsDom = new EmployerEventDom();
		
		try{
			eventDetailsDom = cassandraOperations.queryForObject(selectEventDetailsQuery,new EmployerEventMapper());
		}
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getFormulaNames");
		}
		catch(NoHostAvailableException noHostEx)
		{
			logger.error("No Host Available to Serve Requests");
		}
		return eventDetailsDom == null ? new EmployerEventDom(): eventDetailsDom;
	}


	@Override
	public void updateInvitationStatus(String eventId, String action) {
		
		if (action.equalsIgnoreCase("undo")) 
		{
			action = "Pending";
		}
		if (action.equalsIgnoreCase("UndoBroadcast")) 
		{
			action = "Accepted";
		}
		
		String queryToUpdateStatus = "update employer_event_details set invitation_status='"+action+"' where event_id='"+eventId+"'";
		
		cassandraOperations.execute(queryToUpdateStatus);
		
	}



	@Override
	public List getEventsByCompanyName(String corporateName) {
		
		List<UniversityEventDom> events = new ArrayList<UniversityEventDom>();
		String GET_EVENTS = "select * from invited_company_details where company_name = '"+corporateName+"'";
		try
		{
			events = cassandraOperations.query(GET_EVENTS, new InvitedCompanyDetailsMapper());
		}
		catch(EmptyResultDataAccessException emptyRS)
		{
			logger.error("Error in getEventsByCompanyName()"+emptyRS.getStackTrace());
		}
		
		return events;
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
			//universityEventDom.setExpectations(rs.getString("expectations"));
			//universityEventDom.setStatus(rs.getString("status"));
			universityEventDom.setInvitationStatus(rs.getString("invitation_status"));
			//universityEventDom.setCompanyName(rs.getString("company_name"));
			//universityEventDom.setEmaild(rs.getString("email_id"));
			
			return universityEventDom;
		}
	}

	/**
	 * This method is used to retrieve the last inserted eventId
	 * @return last_inserted_event_id_emp
	 */
	public String getLastInsertedEventId() {
		
		String getLastInsertedEventId = "select value from auto_increment where job_id ='last_inserted_event_id_emp'";
		BigInteger lastInsertedEventId = cassandraOperations.queryForObject(getLastInsertedEventId,BigInteger.class);
		
		Integer lastInsertedEventIdInt =  Integer.valueOf(lastInsertedEventId.toString());
		Integer incrByOne = lastInsertedEventIdInt + 1;
		String update_lastId = "update auto_increment set value = " + incrByOne+ " where job_id='last_inserted_event_id_emp'";
		
		cassandraOperations.execute(update_lastId);
		return Integer.toString(incrByOne);
	}

	@Override
	public String scheduleEvent(EmployerEventDom eventDetailsDom) {
	
		String eventId = getLastInsertedEventId();
		String invitationStatus = CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_PENDING;
		
		Date startDate = CaerusCommonUtility.stringToDate(eventDetailsDom.getStartDate(),"yyyy-MM-dd");
		Date endDate = CaerusCommonUtility.stringToDate(eventDetailsDom.getEndDate(),"yyyy-MM-dd");
		
		Insert scheduleEvent = QueryBuilder.insertInto("employer_event_details").values(
			new String[]{ 
				"event_id","event_name","start_date","end_date","start_time",
				"end_time","university_name","expectations","no_of_hirings",
				"min_sal_offered","status","email_id","company_name",
				"repo_file_names","functional_areas","is_pre_placement_attached",
				"is_company_profile_attached","event_location","invitation_status","eligible_batches"}	,
				new Object[]{
			    eventId,
				eventDetailsDom.getEventName(),
				startDate,
				endDate,
				eventDetailsDom.getStartTime(),
				eventDetailsDom.getEndTime(),
				eventDetailsDom.getParticipatingUniversity(),
				eventDetailsDom.getEventDescription(),
				eventDetailsDom.getNumberOfHirings(),
				eventDetailsDom.getMinimumSalaryOffered(),
				CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_PUBLISHED,
				eventDetailsDom.getEmailId(),
				eventDetailsDom.getCompanyName(),
				eventDetailsDom.getEmployerRepositoryFileNames(), 
				eventDetailsDom.getFunctionalAreas(),
				eventDetailsDom.getAttachPreplacementFiles(),
				eventDetailsDom.getAttachCompanyProfile(),
				eventDetailsDom.getEventLocation(),
				invitationStatus,
				eventDetailsDom.getEligibleBatches()
				}
			);
	
	cassandraOperations.execute(scheduleEvent);
	return eventId;
	}


	@Override
	public List<EmployerEventDom> getEmployerEvents(String companyName) {
		String getEmployerEvents = "select * from employer_event_details where company_name='"+companyName+"'";
		
		List<EmployerEventDom> employerEvents = new ArrayList<EmployerEventDom>();
		try {
			employerEvents = cassandraOperations.query(getEmployerEvents,new EmployerEventMapper());
		}
		catch(NullPointerException npe){
			employerEvents = new ArrayList<EmployerEventDom>();
		}
		catch(IllegalArgumentException argEx){
			
		}
		return employerEvents == null ? new ArrayList<EmployerEventDom>() : employerEvents;
	}


	@Override
	public void updateEventStatus(String companyName, String eventId,String status) {

		Update updateEmployerInvitationStatus=QueryBuilder.update("invited_company_details");
		
		updateEmployerInvitationStatus.with(QueryBuilder.set("invitation_status", status));
		updateEmployerInvitationStatus.where(QueryBuilder.eq("event_id", eventId));
		updateEmployerInvitationStatus.where(QueryBuilder.eq("company_name", companyName));
		
		cassandraOperations.execute(updateEmployerInvitationStatus);
		
	}


	@Override
	public void updateEvent(EmployerEventDom eventDetailsDom) {
		String eventId = eventDetailsDom.getEventId();
		String invitationStatus = CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_PENDING;
		
		Date startDate = CaerusCommonUtility.stringToDate(eventDetailsDom.getStartDate(),"yyyy-MM-dd");
		Date endDate = CaerusCommonUtility.stringToDate(eventDetailsDom.getEndDate(),"yyyy-MM-dd");
		
		Insert scheduleEvent = QueryBuilder.insertInto("employer_event_details").values(
			new String[]{ "event_id","event_name","start_date","end_date","start_time",
				"end_time","university_name","expectations","no_of_hirings",
				"min_sal_offered","status","email_id","company_name",
				"repo_file_names","functional_areas","is_pre_placement_attached",
				"is_company_profile_attached","event_location","invitation_status","eligible_batches"}	,
				new Object[]{
			    eventId,
				eventDetailsDom.getEventName(),
				startDate,
				endDate,
				eventDetailsDom.getStartTime(),
				eventDetailsDom.getEndTime(),
				eventDetailsDom.getParticipatingUniversity(),
				eventDetailsDom.getEventDescription(),
				eventDetailsDom.getNumberOfHirings(),
				eventDetailsDom.getMinimumSalaryOffered(),
				CaerusAPIStringConstants.EMPLOYER_EVENT_STATUS_PUBLISHED,
				eventDetailsDom.getEmailId(),
				eventDetailsDom.getCompanyName(),
				eventDetailsDom.getEmployerRepositoryFileNames(), 
				eventDetailsDom.getFunctionalAreas(),
				eventDetailsDom.getAttachPreplacementFiles(),
				eventDetailsDom.getAttachCompanyProfile(),
				eventDetailsDom.getEventLocation(),
				invitationStatus,
				eventDetailsDom.getEligibleBatches()
				}
			);
	
	cassandraOperations.execute(scheduleEvent);
	}


	@Override
	public List<EmployerEventDom> getEventDetailsByUniversityName(String universityName) {
		String sqlQuery = "select * from employer_event_details where university_name ='"+universityName+"' and invitation_status = 'Broadcasted' ALLOW FILTERING";
		List<EmployerEventDom> eventList = cassandraOperations.query(sqlQuery, new EmployerEventMapper());
		return eventList;
	}


	@Override
	public void updateCandidateActionOnCorporateEvent(
			EmployerEventDom employerEventDom, String studentEmailId) {
		
		String query = null;
		
		if(employerEventDom.getStudentAcceptStatus().equalsIgnoreCase("accept"))
		{
			query = "update employer_event_details set accepted_by_students = accepted_by_students + ['"+studentEmailId+"'] where event_id ='"+employerEventDom.getEventId()+"'";
			
			Insert queryForInsertion = QueryBuilder.insertInto("confirmed_candidate_events").values(
					new String[]{ "student_email_id","event_name", "corp_univ_email_id", "accepted_time", "university_name",
						}	,
					new Object[]{studentEmailId, employerEventDom.getEventName(), employerEventDom.getFirmId(), new Date(), employerEventDom.getParticipatingUniversity()});
		
			cassandraOperations.execute(queryForInsertion);
		}
		
		if(employerEventDom.getStudentAcceptStatus().equalsIgnoreCase("deny"))
		{
			query = "update employer_event_details set denied_by_students = denied_by_students + ['"+studentEmailId+"'] where event_id ='"+employerEventDom.getEventId()+"'";
		}
		
		cassandraOperations.execute(query);
		
	}

	private static class EventStudentMapper implements RowMapper<EmployerEventDom> {
		@Override
		public EmployerEventDom mapRow(Row rs, int arg1)throws DriverException {
			
			EmployerEventDom employerEventDom = new EmployerEventDom();
					
			employerEventDom.setAcceptedByStudentsList(rs.getList("accepted_by_students", String.class));
			employerEventDom.setDeniedByStudentsList(rs.getList("denied_by_students", String.class));
			
			return employerEventDom;
		}
	
	}

	@SuppressWarnings("unchecked")
	@Override
	public void revertCandidateActionOnCorporateEvent(String studentEmailId,
			EmployerEventDom employerEventDom) {
		
		//List<String> acceptedByStudents = new ArrayList<String>();
		String queryForConfirmedCandidatesTable = "delete from confirmed_candidate_events where student_email_id ='"+studentEmailId+"' and event_name='"+employerEventDom.getEventName()+"' and corp_univ_email_id='"+employerEventDom.getFirmId()+"'";
		
		String acceptedByStudentsListQuery = "select accepted_by_students, denied_by_students from employer_event_details where event_id ='"+employerEventDom.getEventId()+"'";
		
		EmployerEventDom eventDetails = cassandraOperations.queryForObject(acceptedByStudentsListQuery, new EventStudentMapper());
		
		//List<String> acceptedByStudents = cassandraOperations.queryForObject(acceptedByStudentsListQuery, List.class);
		
		if(null != eventDetails.getAcceptedByStudentsList() && eventDetails.getAcceptedByStudentsList().size() != 0){
			
			String queryForAcceptedStudentsList = "update employer_event_details set accepted_by_students = accepted_by_students - ['"+studentEmailId+"'] where event_id ='"+employerEventDom.getEventId()+"'";
			
			cassandraOperations.execute(queryForAcceptedStudentsList);
			cassandraOperations.execute(queryForConfirmedCandidatesTable);
		}
			
		
		
		if(null != eventDetails.getDeniedByStudentsList() && eventDetails.getDeniedByStudentsList().size() != 0 ){
			
			String queryForDeniedstudentsList = "update employer_event_details set denied_by_students = denied_by_students - ['"+studentEmailId+"'] where event_id = '"+employerEventDom.getEventId()+"'";
			
			cassandraOperations.execute(queryForDeniedstudentsList);
			cassandraOperations.execute(queryForConfirmedCandidatesTable);
		}
		
		
		
	}


	@Override
	public String getEmployerEmailIdbyEventId(String eventId) {
		
		Select select = QueryBuilder.select("email_id").from("employer_event_details");
		
		select.where(QueryBuilder.eq("event_id", eventId));
		
		String corporateEmailId = cassandraOperations.queryForObject(select,String.class);
		
		return corporateEmailId;
	}


	@Override
	public List<UniversityEventDom> getCampusEvents(String corporateName,String status) {
		List<UniversityEventDom> campusEvents = new ArrayList<UniversityEventDom>();
		
		Select selectCampusEvents = QueryBuilder.select().from(CaerusAPIStringConstants.TABLE_INVITED_COMPANY_DETAILS);
		selectCampusEvents.where(QueryBuilder.eq(CaerusAPIStringConstants.COMPANY_NAME, corporateName));
		selectCampusEvents.where(QueryBuilder.eq(CaerusAPIStringConstants.INVITATION_STATUS, status));
		selectCampusEvents.limit(6);
		
		try
		{
			campusEvents = cassandraOperations.query(selectCampusEvents, new InvitedCompanyDetailsMapper());
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException emptyRS)
		{
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE +emptyRS.getStackTrace());
			campusEvents = new ArrayList<UniversityEventDom>();
		}
		return null == campusEvents ? new ArrayList<UniversityEventDom>() : campusEvents;
	}
	
}

