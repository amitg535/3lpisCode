/**
 * 
 */
package caerusapp.service.university;


import java.sql.Timestamp;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityEventDom;

public interface IUniversityManager {
	
	
	/**
	 * This method is used to to check for duplicate entries of students not registered with application
	 * @author RavishaG
	 * @param emailId
	 * @return Map<String,Map<String,String>>
	 */
	public Map<String,Map<String,String>> checkStudent(String emailId);
	
	/**
	 * This method is used to update unregistered students to registered students for an university
	 * @author RavishaG
	 * @param studentMap
	 * @param universityName
	 */
	public void updateRegisteredStudents(Map<String,String> studentMap, String universityName);
	
	/**
	 * This method is used to register a university
	 * @param univesityDetailsDom
	 * @author KarthikeyanK
	 */
	public void addUniversity(UniversityDetailsDom univesityDetailsDom);
	
	/**
	 * This method is used to check whether a university with the given name exists
	 * @param emailId
	 * @return integer (No of universities)
	 */
	public int checkUniversityEmailIdExist(String emailId);
	
	/**
	  * This method is used to check whether a university with the given name exists
	  * @param universityName
	  * @return integer (No of universities)
	  */
	public int getUniversityByUniversityName(String universityName);

	/**
	 * This Method is used for editing the University Profile
	 * @param univesityRegisterationDom
	 * @author KarthikeyanK
	 *//*
	public void editUniversity(
			UnivesityRegisterationDom univesityRegisterationDom);
	
	
	*//**
	 * This method is used for getting all the registered university names
	 * @return  Map<String, String>(UniversityName,UniversityName)
	 * @author KarthikeyanK
	 *//*
	public Map<String, String> getUniversityNameList();
	
	

	*/
	/**
	 *  This method is used for scheduling an event by university
	 *  @param UniversityEventDom
	 *  @author TrishnaR
	 * 	@return String (eventId)
	 */
	public String scheduleEventByUniversity(UniversityEventDom universityEventDom);

	/** This method is used to update an event created by university
	 * @param universityEventDom
	 * @author TrishnaR
	 */
	public void updateCampusFairEvent(UniversityEventDom universityEventDom);

	
	/**
	 * This method is used to get all the details of an event created by university.
	 * @return UniversityEventDom
	 * @param eventID
	 * @author ShaileshK
	 */
	public UniversityEventDom getScheduleEventByEventId(String eventId);

	/**
	 * This method is used for getting a list of all the companies invited for a particulat event created by university
	 * @param eventId
	 * @return List<UniversityEventDom> (invited companies)
	 * @author ShaileshK
	 */
	public List<UniversityEventDom> getInvitedListByEventId(String eventId);


	

	/**
	 * This method is used for getting all the university created events and its details for a university
	 * @param emailId
	 * @return List (eventList)
	 */
	public List<UniversityEventDom> getEventList(String emailID);
	
	/**
	 * This method is used to delete a university created event
	 * @param event_id
	 *//*
	public void deleteEvent(String event_id);

	*//**
	 * This method is used to update a seminar event created by employer
	 * @param  UniversityEventDom
	 * @author TrishnaR
	 */
	
	
	
	public void updateSeminarEvent(UniversityEventDom universityEventDom);
	
	/**
	 * This method is used to get the list of all employer created events received by a university
	 * @param  universityName
	 * @return List (eventList)
	 */
	public List getEventListByUniversityName(String universityName);
	
	/**
	 * This method is used to apply the given action to an event by an university
	 * @param event_id , action
	 *//*
	public void applyAction(String event_id, String action);


	*//**
	 * This method is used to get all the details of an event created by employer
	 * @param event_id
	 * @return EmployerEventDom
	 *//*
	public EmployerEventDom getEmployerEventDetails(String event_id);
	
	
	*//**
	 * This method is used to set the status of an event created by university
	 * @param  status, eventId
	 *//* 
	public void updateStatus(String status, String eventId);
	
	*//**
	 * This method is used to get the count of events received by an employer and whose invitation status is pending
	 *  @param companyName
	 *  @return Integer (inviteCount)
 	 */
	public int getTotalCampusInvites(String companyName);

	/**
	 * This method is used for getting all the events which are published by university
	 * @param emailID
	 * @return Integer (upcomingEventsNo)
	 */
	public int getNoOfUpcomingEvents(String emailID);

	/**
	 * This method is used for getting the count of all the events created by an employer and are at pending status for a university
	 * @param  universityName
	 * @return Integer (noOfPendingRecevivedInvitations)
	 */
	
	public int getNoOfPendingInvitations(String universityName);
	
	
	/**
	 * This method is used to get all the details of university given its emailId
	 * @param emaiId
	 * @return UnivesityRegisterationDom
	 *//*
	public UnivesityRegisterationDom getUniversityDetailsByEmailId(
			String emailid);

	*//**
	 * This method is used to separate the registered and unregistered students from a given map of students
	 * @param  universityName
	 * @param validEntries
	 * @return  Map<String,Map<String,String>> (students)
	 * @author RavishaG
	 */
	public Map<String,Map<String,String>> checkRegisteredStudent(String universityName,Map<String, String> validEntries);

	/**
	 * This method is used to upload a file by university (Excel sheet of students)
	 * @author RavishaG
	 * @param inputStreamResume
	 */
	public void uploadFile(InputStream inputStreamResume);
	
	
	/**
	 * This method is used to get all the students(registered and unregistered) for a university
	 * @param universityName
	 * @return UniversityLoginDom (details)
 	 * @author RavishaG
	 */
	public UniversityDetailsDom getStudentsOfUniversity(String universityName);

	
	/**
	 *This method is used to delete registered students from university 
	 * @param registeredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	public void deleteRegisteredStudent(String universityName,HashMap<String,String> registeredStudents);
	
	/**
	 *This method is used to delete unregistered students from university 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	public void deleteUnRegisteredStudent(String universityName,HashMap<String,String> unregisteredStudents);


	/**
	 *This method is used to add registered students to university 
	 * @author RavishaG
	 * @param registeredStudents
	 * @param universityName
	 */
	public void addRegisteredStudentToMap(String universityName,Map<String, String> registeredStudents);
	
	/**
	 *This method is used to add unregistered students to university 
	 * @param unRegisteredStudents
	 * @param universityName
	 * @author RavishaG
	 */
	public void addUnRegisteredStudentToMap(String universityName,Map<String,String> unRegisteredStudents);

	
	/**
	 * This method is used to get a map of students registered for a university and their batch
	 * @author RavishaG
	 * @param universityName
	 * @return  Map<String, String> (registeredStudentDetails)
	 */
	public Map<String, String> registeredStudentDetails(String universityName);


	/**
	 * This method is used to segregate existing (registered) and unregistered students from a given map of students 
	 * @author RavishaG
	 * @param validEntries
	 * @return Map<String,Map<String,String>>  (totalStudentsMap)
	 */
	public Map<String,Map<String,String>> checkExistingStudents(Map<String, String> validEntries);

	
	/**
	 * This method is used to get the number of events broadcasted by university
	 * @param universityName
	 * @return Integer (count)
	 * @author RavishaG
	 */
	public int getBroadcastedEventCount(String universityName);
	


	/**
	 * This method is used by university to update the status of campus job 
	 * @author PallaviD
	 * @param jobIdAndFirmId 
	 * @param universityName
	 */
	public void updateCampusJobStatus(String jobIdAndFirmId, String universityName, String jobAction);

	/**
	 * This method is used by university to update the status of campus internship 
	 * @author PallaviD
	 * @param jobIdAndFirmId 
	 * @param universityName
	 */
	public void updateCampusInternshipStatus(String internshipIdAndFirmId, String universityName, String internshipAction);
    
	/**
	 * This method is used the get the university for a registered student
	 * @author PallaviD
	 * @param studentEmailId
	 * @return universityName
	 */
	public String getUniversityForRegisteredStudent(String emailId);
	 

	/**
	 * This method is used to get all the details of a campus job for a university 
	 * @author PallaviD
	 * @param jobId
	 * @param universityName 
	 * @return EmployerCampusJobPostDom
	 *//*
	public EmployerCampusJobPostDom getBroadcastedCampusJobDetails(String jobId, String universityName);

	*//**
	 * This method is used to get all the details of a campus internship for a university 
	 * @author PallaviD
	 * @param internshipIdAndFirmId
	 * @param universityName 
	 * @return EmployerCampusJobPostDom
	 *//*
	public EmployerCampusJobPostDom getBroadcastedCampusInternshipDetails(
			String internshipId, String universityName);

	
	*//**
	 * This method is used by employer to apply  campus job status for a candidate
	 * @author PallaviD
	 * @param candidateEmail
	 * @param action
	 * @param jobId
	 * @param universityName
	 * @return boolean
	 *//*
	public boolean updateCandidateJobStatus(String candidateEmail,
			String action, String jobId, String universityName);

	
	*//**
	 * This method is used by employer to apply  campus internship status for a candidate
	 * @author PallaviD
	 * @param candidateEmail
	 * @param action
	 * @param internshipId
	 * @param universityName
	 * @return boolean
	 */
	/*
	public boolean updateCandidateInternshipStatus(String candidateEmail,
			String action, String internshipID, String universityName);
*/
	/**
	 * This method is used to get the number of campus jobs broadcasted by university
	 *  @param universityName
	 * @return Integer (count)
	 * @author RavishaG
	 */
	public int getbroadcastedJobCount(String universityName);

	/**
	 * This method is used to get the list of all industries stored in master_demo
	 * @return List<String> industryList
	 * @author RavishaG
	 *//*
	public List<String> getIndustryList();


	/**
	 * This method is used to get university details by university name
	 * @param universityName
	 * @return UniversityDetailsDom
	 */
	public UniversityDetailsDom getUniversityDetailsByName(String universityName);
	
	

	/**
	 * This method is used to get status of the event created by a university
	 * @author ravishag
	 * @param eventId
	 * @return
	 */

	public String getEventStatus(String eventId);


	/**
	 * This method is used to find university event details by university name
	 * @author RavishaG
	 * @param universityName
	 * @return list
	 */
	public List<UniversityEventDom> getEventDetailsByUniversityName(String universityName);


	/**
	 * This method is used to update candidate's action on university event
	 * @author RavishaG
	 * @param universityEventDom
	 * @param studentEmailId
	 */
	public void updateCandidateActionOnUniversityEvent(UniversityEventDom universityEventDom, String studentEmailId);


	/**
	 * This method is used to revert action on university event 
	 * @author RavishaG
	 * @param studentEmailId
	 * @param universityEventDom
	 */
	public void revertCandidateActionOnUniversityEvent(String studentEmailId,UniversityEventDom universityEventDom);

	
	/**
	 * This method is used to find the time an event was accepted by candidate
	 * @author RavishaG
	 * @param studentEmailId
	 * @param eventName
	 * @param firmId
	 * @return Date
	 */
	public Date getEventAcceptedTime(String studentEmailId,String eventName, String firmId);

	/**
	 * This method is used to set read_flag of invited company true
	 * @author pallavid
	 * @param eventId
	 * @param companyName
	 *//*
	public void setInvitedCompanyReadFlag(String eventId, String companyName);

	*//** This method is used to update an event Template
	 * @author TrishnaR
	 * @param template
	 * @param eventId 
	 */
	public void updateEventTemplate(String template, String eventId);


	
	/**
	 * This method is used to retrieve the List of corporates that have accepted the event invitation
	 * @author TrishnaR
	 * @param eventId
	 * @return List<UniversityEventDom> (list of attending corporates)
	 */
	public List<UniversityEventDom> getAttendingCorporateList(String eventId);
	
	/** 
	 * This method is used to get jobs(Published & Broadcasted) posted by employers for university 
	 * @param UniversityName
	 * @return List<EmployerCampusJobPostDom> CampusJobsList
	 * @author KarthikeyanK
	 */
	
	public List<EmployerCampusJobPostDom> getCampusJobs(
			String universityName);
	
	/**
	 * This method is used to get university name given its emailId
	 * @param emailId
	 * @return String universityName
	 * @author KarthikeyanK
	 *//*
	public String getUniversityNameByEmailId(String emailId);

	*//**
	 * This method  is used to retrieve the file uploaded by a n employer during a job posting
	 * @param jobId
	 * @param emailId
	 * @return UniversityLoginDom
	 * @author KarthikeyanK
	 *//*    
	public UniversityLoginDom getEmployerUploadedFile(String jobId,
			String emailId);

	*/
	
	
	/**
	 * This method is used to get all the campus internships posted by an employer
	 * @param emailId
	 * @return List<EmployerCampusJobPostDom> employerJobPostedListForUniversity
	 * @author KarthikeyanK
	 */
	
	public List<EmployerCampusJobPostDom> getCampusInternshipsByEmployer(String emailId);



	/**
	 * This method is used to get all the campus jobs posted by an employer
	 * @param emailId
	 * @return List<UniversityLoginDom> employerJobPostedListForUniversity
	 * @author KarthikeyanK
	 */
	
	public List<EmployerCampusJobPostDom> getCampusJobsByEmployer(String emailId);
	
	
	/** 
	 * This method is used to get internships(Published & Broadcasted) posted by employers for university 
	 * @param UniversityName
	 * @return List<EmployerCampusJobPostDom> jobsList
	 */
	public List<EmployerCampusJobPostDom> getCampusInternships(
			String emailId);



	/**
	 * This Method is used for editing the University Profile
	 * @param UniversityDetailsDom
	 * @author KarthikeyanK
	 */
	public void editUniversity(UniversityDetailsDom univesityRegisterationDom);

	public void updateCorporateInvitationStatus(String eventId, String status);

}
