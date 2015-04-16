package caerusapp.service.university;

import java.sql.Timestamp;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import caerusapp.dao.university.IUniversityManagerDao;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityEventDom;

public class UniversityManager implements IUniversityManager {

	
	private IUniversityManagerDao universityManagerDao;

	/**
	 * @param universityManagerDao
	 *            the universityManagerDao to set
	 */
	public void setUniversityManagerDao(
			IUniversityManagerDao universityManagerDao) {
		this.universityManagerDao = universityManagerDao;
	}

	
	/**
	 * This method is used to to check for duplicate entries of students not registered with application
	 * @author RavishaG
	 * @param emailId
	 * @return Map<String,Map<String,String>>
	 */
	@Override
	public Map<String,Map<String,String>> checkStudent(String emailId) {
		
		return universityManagerDao.checkStudent(emailId);
	}
	
	/**
	 * This method is used to update unregistered students to registered students for an university
	 * @author RavishaG
	 * @param studentMap
	 * @param universityName
	 */
	@Override
	public void updateRegisteredStudents(Map<String,String> studentMap,String universityName) {
		universityManagerDao.updateRegisteredStudents(studentMap,universityName);
	}
	
	/**
	 * This method is used to register a university
	 *@param univesityDetailsDom
	 */
	
	@Override
	public void addUniversity(UniversityDetailsDom univesityDetailsDom) {
		universityManagerDao.addUniversity(univesityDetailsDom);
	}

	/**
	 * This method is used to check whether a university with the given name exists
	 * @param emailId
	 * @return integer (No of universities)
	 */
	@Override
	public int checkUniversityEmailIdExist(String emailId) {

		return universityManagerDao.checkUniversityEmailIdExist(emailId);
	}
	
	/**
	  * This method is used to check whether a university with the given name exists
	  * @param universityName
	  * @return integer (No of universities)
	  */
	@Override
	public int getUniversityByUniversityName(String universityName) {
		
		return universityManagerDao.getUniversityByUniversityName(universityName);
	}
	
	
	/**
	 * This Method is used for editing the University Profile
	 *  @param univesityRegisterationDom
	 */
	/*
	@Override
	public void editUniversity(
			UnivesityRegisterationDom univesityRegisterationDom) {

		universityManagerDao.editUniversity(univesityRegisterationDom);

	}

	*/
	/**
	 * This method is used for getting all the registered university names
	 * @return  Map<String, String>(UniversityName,UniversityName)
	 *//*
	@Override
	public Map<String, String> getUniversityNameList() {

		return universityManagerDao.getUniversityNameList();
	}

	*/

	/**
	 *  This method is used for scheduling an event by university
	 *  @param UniversityEventDom
	 *  @author TrishnaR
	 *  @return String (eventId)
	 */
	@Override
	public String scheduleEventByUniversity(UniversityEventDom universityEventDom) {
		return universityManagerDao.scheduleEventByUniversity(universityEventDom);

	}

	/**
	 * This method is used to update an event created by university
	 * @param universityEventDom
	 * @author TrishnaR
	 */
	@Override
	public void updateCampusFairEvent(UniversityEventDom universityEventDom) {
		universityManagerDao.updateCampusFairEvent(universityEventDom);

	}

	
	
	/**
	 * This method is used to get all the details of an event created by university.
	 * @return UniversityEventDom
	 * @param eventID
	 * @author ShaileshK
	 */
	@Override
	public UniversityEventDom getScheduleEventByEventId(String eventId) {
		return universityManagerDao.getScheduleEventByEventId(eventId);
	}

		
	/**
	 * This method is used for getting a list of all the companies invited for a particulat event created by university
	 * @param eventId
	 * @return List<UniversityEventDom> (invited companies)
	 * @author ShaileshK
	 */	
	@Override
	public List<UniversityEventDom> getInvitedListByEventId(String eventId) {
		return universityManagerDao.getInvitedListByEventId(eventId);
	}

	/**
	 * This method is used for getting all the university created events and its details for a university
	 * @param emailId
	 * @return List (eventList)
	 */
	@Override
	public List<UniversityEventDom> getEventList(String emailID) {
		return universityManagerDao.getEventList(emailID);
	}

	/**
	 * This method is used to delete a university created event
	 * @param event_id
	 *//*
	@Override
	public void deleteEvent(String event_id) {
		universityManagerDao.deleteEvent(event_id);
	}

	*//**
	 * This method is used to update a seminar event created by employer
	 * @param  UniversityEventDom
	 */
	@Override
	public void updateSeminarEvent(UniversityEventDom universityEventDom) {
		universityManagerDao.updateSeminarEvent(universityEventDom);

	}

	
	/**
	 * This method is used to get the list of all employer created events received by a university
	 * @param  universityName
	 * @return List (eventList)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getEventListByUniversityName(String universityName) {
		return universityManagerDao.getEventListByUniversityName(universityName);
	}

	/**
	 * This method is used to apply the given action to an event by an university
	 * @param event_id , action
	 *//*
	@Override
	public void applyAction(String event_id, String action) {
		universityManagerDao.applyAction(event_id, action);
	}

	*//**
	 * This method is used to get all the details of an event created by employer
	 * @param event_id
	 * @return EmployerEventDom
	 *//*
	@Override
	public EmployerEventDom getEmployerEventDetails(String event_id) {
		return universityManagerDao.getEmployerEventDetails(event_id);
	}

	*//**
	 * This method is used to set the status of an event created by university
	 * @param  status, eventId
	 *//* 
	public void updateStatus(String status, String eventId) {
		universityManagerDao.updateStatus(status, eventId);

	}


	*//**
	 * This method is used to get the count of events received by an employer and whose invitation status is pending
	 *  @param companyName
	 *  @return Integer (inviteCount)
 	 */
	@Override
	public int getTotalCampusInvites(String companyName) {
		return universityManagerDao.getTotalCampusInvites(companyName);
	}

	/**
	 * This method is used for getting all the events which are published by university
	 * @param emailID
	 * @return Integer (upcomingEventsNo)
	 */
	@Override
	public int getNoOfUpcomingEvents(String emailID) {
		return universityManagerDao.getNoOfUpcomingEvents(emailID);
	}

	/**
	 * This method is used for getting the count of all the events created by an employer and are at pending status for a university
	 * @param  universityName
	 * @return Integer (noOfPendingRecevivedInvitations)
	 */
	@Override
	public int getNoOfPendingInvitations(String universityName) {
		return universityManagerDao.getNoOfPendingInvitations(universityName);
	}

	
	/**
	 * This method is used to get all the details of university given its emailId
	 * @param emaiId
	 * @return UnivesityRegisterationDom
	 *//*
	@Override
	public UnivesityRegisterationDom getUniversityDetailsByEmailId(
			String emailid) {
		return universityManagerDao.getUniversityDetailsByEmailId(emailid);
	}

	*//**
	 * This method is used to separate the registered and unregistered students from a given map of students
	 * @param  universityName
	 * @param validEntries
	 * @return  HashMap<String,HashMap<String,String>> (students)
	 * @author RavishaG
	 */
	@Override
	public Map<String,Map<String,String>> checkRegisteredStudent(String universityName, Map<String,String> validEntries ) {
		 return universityManagerDao.checkRegisteredStudent(universityName,validEntries);
	}

	/**
	 * This method is used to upload a file by university (Excel sheet of students)
	 * @author RavishaG
	 * @param inputStreamResume
	 */
	@Override
	public void uploadFile(InputStream inputStreamResume) {
		universityManagerDao.uploadFile(inputStreamResume);
		
	}
	
	/**
	 * This method is used to get all the students(registered and unregistered) for a university
	 * @param universityName
	 * @return UniversityLoginDo> (details)
 	 * @author RavishaG
	 */
	@Override
	public UniversityDetailsDom getStudentsOfUniversity(String universityName) {
		
		return universityManagerDao.getStudentsOfUniversity(universityName);
	}

	
	/**
	 *This method is used to delete registered students from university 
	 * @param registeredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	@Override
	public void deleteRegisteredStudent(String universityName,HashMap<String,String> registeredStudents) {
		universityManagerDao.deleteRegisteredStudent(universityName,registeredStudents);
		
	}
	
	
	/**
	 *This method is used to delete unregistered students from university 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	@Override
	public void deleteUnRegisteredStudent(String universityName,HashMap<String,String> unRegisteredStudents) {
		universityManagerDao.deleteUnRegisteredStudent(universityName,unRegisteredStudents);
		
	}

	/**
	 *This method is used to add registered students to university 
	 * @author RavishaG
	 * @param registeredStudents
	 * @param universityName
	 */
	@Override
	public void addRegisteredStudentToMap(String universityName,Map<String,String> registeredStudents) {
		 universityManagerDao.addRegisteredStudentToMap(universityName,registeredStudents);
		
	}

	/**
	 *This method is used to add unregistered students to university 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	@Override
	public void addUnRegisteredStudentToMap(String universityName,Map<String,String> unRegisteredStudents) {
		 universityManagerDao.addUnRegisteredStudentToMap(universityName,unRegisteredStudents);
		
	}

	
	/**
	 * This method is used to get a map of students registered for a university and their batch
	 * @author RavishaG
	 * @param universityName
	 * @return  Map<String, String> (registeredStudentDetails)
	 */
	@Override
	public  Map<String, String> registeredStudentDetails(String universityName) {
		
		return universityManagerDao.registeredStudentDetails(universityName);
	}


	/**
	 * This method is used to segregate existing (registered) and unregistered students from a given map of students 
	 * @author RavishaG
	 * @param validEntries
	 * @return Map<String,HashMap<String,String>>  (totalStudentsMap)
	 */
	@Override
	public Map<String,Map<String,String>> checkExistingStudents(Map<String,String> validEntries) {
		
		return universityManagerDao.checkExistingStudents(validEntries);
	}


	/**
	 * This method is used to get the number of events broadcasted by university
	 * @param universityName
	 * @return Integer (count)
	 * @author RavishaG
	 */
	@Override
	public int getBroadcastedEventCount(String universityName) {
		
		return universityManagerDao.getBroadcastedEventCount(universityName);
	}
	

	/**
	 * This method is used by university to update the status of campus job 
	 * @author PallaviD
	 * @param jobIdAndFirmId 
	 * @param universityName
	 */
	@Override
	public void updateCampusJobStatus(String jobIdAndFirmId, String universityName, String jobAction) {
		 universityManagerDao.updateCampusJobStatus(jobIdAndFirmId, universityName, jobAction);
	}

	
	/**
	 * This method is used by university to update the status of campus internship 
	 * @author PallaviD
	 * @param jobIdAndFirmId 
	 * @param universityName
	 */
	@Override
	public void updateCampusInternshipStatus(String internshipIdAndFirmId, String universityName, String internshipAction) {
		universityManagerDao.updateCampusInternshipStatus(internshipIdAndFirmId, universityName, internshipAction);
	}

	/**
	 * This method is used the get the university for a registered student
	 * @author PallaviD
	 * @param studentEmailId
	 * @return universityName
	 */
	@Override
	public String getUniversityForRegisteredStudent(String emailId) {
		return universityManagerDao.getUniversityForRegisteredStudent(emailId);
		
	}

	/**
	 * This method is used to get all the details of a campus job for a university 
	 * @author PallaviD
	 * @param jobId
	 * @param universityName 
	 * @return EmployerCampusJobPostDom
	 *//*
	@Override
	public EmployerCampusJobPostDom getBroadcastedCampusJobDetails(String jobId, String universityName) {
		return universityManagerDao.getBroadcastedCampusJobDetails(jobId, universityName);
	}

	*//**
	 * This method is used to get all the details of a campus internship for a university 
	 * @author PallaviD
	 * @param internshipId
	 * @param universityName 
	 * @return EmployerCampusJobPostDom
	 *//*
	@Override
	public EmployerCampusJobPostDom getBroadcastedCampusInternshipDetails(
			String internshipId, String universityName) {
		return universityManagerDao.getBroadcastedCampusInternshipDetails(internshipId, universityName);
	}

	
	*//**
	 * This method is used by employer to apply  campus job status for a candidate
	 * @author PallaviD
	 * @param candidateEmail
	 * @param action
	 * @param jobId
	 * @param universityName
	 * @return boolean
	 *//*
	@Override
	public boolean updateCandidateJobStatus(String candidateEmail,
			String action, String jobId, String universityName) {
	
		return universityManagerDao.updateCandidateJobStatus(candidateEmail, action, jobId, universityName);
	}

	
	*//**
	 * This method is used by employer to apply  campus internship status for a candidate
	 * @author PallaviD
	 * @param candidateEmail
	 * @param action
	 * @param internshipId
	 * @param universityName
	 * @return boolean
	 */
	
	/*@Override
	public boolean updateCandidateInternshipStatus(String candidateEmail,
			String action, String internshipId, String universityName) {
		return universityManagerDao.updateCandidateInternshipStatus(candidateEmail, action, internshipId, universityName);
	}
	*/
	
	/**
	 * This method is used to get the number of campus jobs broadcasted by university
	 * @param universityName
	 * @return Integer (count)
	 * @author RavishaG
	 */
	@Override
	public int getbroadcastedJobCount(String universityName) {
		
		return universityManagerDao.getbroadcastedJobCount(universityName);
	}

	/**
	 * This method is used to get the list of all industries stored in master_demo
	 * @return List<String> industryList
	 * @author RavishaG
	 *//*
	@Override
	public List<String> getIndustryList() {
		
		return universityManagerDao.getIndustryList();
	}

*/
	@Override
	public UniversityDetailsDom getUniversityDetailsByName(String universityName) {
		return universityManagerDao.getUniversityDetailsByName(universityName);
	}


	
	
	/** This method is used to get status of the event created by a university
	 * @author ravishag
	 * @param eventId
	 * @return
	 */
	
	@Override
	public String getEventStatus(String eventId) {
		
		return universityManagerDao.getEventStatus(eventId);
	}


	/**
	 * This method is used to find university event details by university name
	 * @author RavishaG
	 * @param universityName
	 * @return list
	 */

	/*@Override
	public List<UniversityEventDom> getEventDetailsByUniversityName(String universityName) {
	
		return universityManagerDao.getEventDetailsByUniversityName(universityName);
	}*/


	/**
	 * This method is used to update candidate's action on university event
	 * @author RavishaG
	 * @param universityEventDom
	 * @param studentEmailId
	 */
	@Override
	public void updateCandidateActionOnUniversityEvent(UniversityEventDom universityEventDom, String studentEmailId) {
		
		universityManagerDao.updateCandidateActionOnUniversityEvent(universityEventDom,studentEmailId);
	}


	/**
	 * This method is used to revert action on university event 
	 * @author RavishaG
	 * @param studentEmailId
	 * @param universityEventDom
	 */
	@Override
	public void revertCandidateActionOnUniversityEvent(String studentEmailId,UniversityEventDom universityEventDom) {
		
		universityManagerDao.revertCandidateActionOnUniversityEvent(studentEmailId,universityEventDom);
	}


	/**
	 * This method is used to find the time an event was accepted by candidate
	 * @author RavishaG
	 * @param studentEmailId
	 * @param eventName
	 * @param firmId
	 * @return Date
	 */
	@Override
	public Date getEventAcceptedTime(String studentEmailId,String eventName, String firmId) {
		
		return universityManagerDao.getEventAcceptedTime(studentEmailId,eventName,firmId);
	}

	/**
	 * This method is used to set read_flag of invited company true
	 * @author pallavid
	 * @param eventId
	 * @param companyName
	 *//*
	@Override
	public void setInvitedCompanyReadFlag(String eventId, String companyName) {
		universityManagerDao.setInvitedCompanyReadFlag(eventId, companyName);
		
	}
*/
	 /** This method is used to update an event Template
	 * @author TrishnaR
	 * @param template
	 */
	@Override
	public void updateEventTemplate(String template,String eventId)
	{
		universityManagerDao.updateEventTemplate(template,eventId);
	}

	/**
	 * This method is used to retrieve the List of corporates that have accepted the event invitation
	 * @author TrishnaR
	 * @param eventId
	 * @return List<UniversityEventDom> (list of attending corporates)
	 */
	@Override
	public List<UniversityEventDom> getAttendingCorporateList(String eventId){
		return universityManagerDao.getAttendingCorporateList(eventId); 
	}


	

/**
	 * @param universityLoginDao
	 *            the universityLoginDao to set
	 */
	/*public void setUniversityLoginDao(IUniversityLoginDao universityLoginDao) {
		this.universityLoginDao = universityLoginDao;
	}*/


	/**
	 * This method is used to get university name given its emailId
	 * @param emailId
	 * @return String universityName
	 * @author KarthikeyanK
	 */
	/*@Override
	public String getUniversityNameByEmailId(String emailId) {

		return universityLoginDao.getUniversityNameByEmailId(emailId);
	}*/

	/** 
	 * This method is used to get jobs(Published & Broadcasted) posted by employers for university 
	 * @param UniversityName
	 * @return List<EmployerCampusJobPostDom> CampusJobsList
	 * @author KarthikeyanK
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusJobs(String universityName) {
		return universityManagerDao.getCampusJobs(universityName);
	}

	/**
	 * This method  is used to retrieve the file uploaded by a n employer during a job posting
	 * @param jobId
	 * @param emailId
	 * @return UniversityLoginDom
	 * @author KarthikeyanK
	 */
	/*@Override
	public UniversityLoginDom getEmployerUploadedFile(String jobId,
			String emailId) {

		return universityLoginDao.getEmployerUploadedFile(jobId, emailId);
	}*/

	
	/**
	 * This method is used to get all the campus jobs posted by an employer
	 * @param emailId
	 * @return List<UniversityLoginDom> employerJobPostedListForUniversity
	 * @author KarthikeyanK
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusJobsByEmployer(String emailId) {
		return universityManagerDao.getCampusJobsByEmployer(emailId);
	}
	

	
	
	
	/**
	 * This method is used to get all the campus internships posted by an employer
	 * @param emailId
	 * @return List<EmployerCampusJobPostDom> employerJobPostedListForUniversity
	 * @author KarthikeyanK
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusInternshipsByEmployer(
			String emailId) {

		return universityManagerDao.getCampusInternshipsByEmployer(emailId);
	}

	
	
	
	/** 
	 * This method is used to get internships(Published & Broadcasted) posted by employers for university 
	 * @param UniversityName
	 * @return List<EmployerCampusJobPostDom> jobsList
	 */
	@Override
	public List<EmployerCampusJobPostDom> getCampusInternships(
			String emailId) {
		return universityManagerDao
			.getCampusInternships(emailId);
	}

	/**
	 * This Method is used for editing the University Profile
	 *  @param univesityDetailsDom
	 */

	@Override
	public void editUniversity(UniversityDetailsDom univesityDetailsDom) {
		universityManagerDao.editUniversity(univesityDetailsDom);
		
	}


	@Override
	public void updateCorporateInvitationStatus(String eventId, String status) {
		universityManagerDao.updateCorporateInvitationStatus(eventId,status);
		
	}

	@Override
	public List<UniversityEventDom> getEventDetailsByUniversityName(
			String universityName) {
		return universityManagerDao.getEventDetailsByUniversityName(universityName);
	}
}
