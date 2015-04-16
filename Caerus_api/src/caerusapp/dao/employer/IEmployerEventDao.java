package caerusapp.dao.employer;

import java.util.List;

import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityEventDom;

public interface IEmployerEventDao {

	EmployerEventDom getEmployerEventDetails(String eventId);

	void updateInvitationStatus(String eventId, String action);

	List getEventsByCompanyName(String corporateName);

	String scheduleEvent(EmployerEventDom eventDetailsDom);

	List<EmployerEventDom> getEmployerEvents(String companyName);

	void updateEventStatus(String loggedInEmployerEmail, String eventId,String status);

	void updateEvent(EmployerEventDom eventDetailsDom);

	List<EmployerEventDom> getEventDetailsByUniversityName(String universityName);

	void updateCandidateActionOnCorporateEvent(
			EmployerEventDom employerEventDom, String studentEmailId);

	void revertCandidateActionOnCorporateEvent(String studentEmailId,
			EmployerEventDom employerEventDom);

	String getEmployerEmailIdbyEventId(String eventId);

	List<UniversityEventDom> getCampusEvents(String corporateName, String status);


}
