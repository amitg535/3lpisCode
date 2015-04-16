package caerusapp.service.employer;

import java.util.List;

import caerusapp.dao.employer.IEmployerEventDao;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityEventDom;

public class EmployerEventManager implements IEmployerEventManager
{
	IEmployerEventDao employerEventDao;

	public IEmployerEventDao getEmployerEventDao() {
		return employerEventDao;
	}

	public void setEmployerEventDao(IEmployerEventDao employerEventDao) {
		this.employerEventDao = employerEventDao;
	}

	@Override
	public EmployerEventDom getEmployerEventDetails(String eventId) {
		return employerEventDao.getEmployerEventDetails(eventId);
	}

	@Override
	public void updateInvitationStatus(String eventId, String action) {
		employerEventDao.updateInvitationStatus(eventId,action);
	}

	@Override
	public List getEventsByCompanyName(String corporateName) {
		return employerEventDao.getEventsByCompanyName(corporateName);
	}
	public String  scheduleEvent(EmployerEventDom eventDetailsDom) {
		return employerEventDao.scheduleEvent(eventDetailsDom);

	}

	@Override
	public List<EmployerEventDom> getEmployerEvents(String companyName) {
		return employerEventDao.getEmployerEvents(companyName);
	}

	@Override
	public void updateEventStatus(String companyName, String eventId,String status) {
		employerEventDao.updateEventStatus(companyName,eventId,status);
	}

	@Override
	public void updateEvent(EmployerEventDom eventDetailsDom) {
		employerEventDao.updateEvent(eventDetailsDom);
	}

	@Override
	public List<EmployerEventDom> getEventDetailsByUniversityName(
			String universityName) {
		return employerEventDao.getEventDetailsByUniversityName(universityName);
	}

	@Override
	public void updateCandidateActionOnCorporateEvent(
			EmployerEventDom employerEventDom, String studentEmailId) {
		employerEventDao.updateCandidateActionOnCorporateEvent(employerEventDom, studentEmailId);
		
	}

	@Override
	public void revertCandidateActionOnCorporateEvent(String studentEmailId,
			EmployerEventDom employerEventDom) {
		employerEventDao.revertCandidateActionOnCorporateEvent(studentEmailId, employerEventDom);
		
		
	}

	@Override
	public String getEmployerEmailIdbyEventId(String eventId) {
		return employerEventDao.getEmployerEmailIdbyEventId(eventId);
	}

	@Override
	public List<UniversityEventDom> getCampusEvents(String corporateName,String status) {
		return employerEventDao.getCampusEvents(corporateName,status);
	}
}