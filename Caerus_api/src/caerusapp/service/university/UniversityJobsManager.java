package caerusapp.service.university;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.dao.university.IUniversityJobsDao;
import caerusapp.domain.university.UniversityJobDom;

public class UniversityJobsManager implements IUniversityJobsManager {

	private IUniversityJobsDao universityJobsDao;

	public IUniversityJobsDao getUniversityJobsDao() {
		return universityJobsDao;
	}

	public void setUniversityJobsDao(IUniversityJobsDao universityJobsDao) {
		this.universityJobsDao = universityJobsDao;
	}

	
	@Override
	public List<UniversityJobDom> getInternalPostings(String universityName) {
		return universityJobsDao.getInternalPostings(universityName);
	}

	@Override
	public void postInternship(UniversityJobDom universityJobDom) {
		universityJobsDao.postInternship(universityJobDom);
	}

	@Override
	public UniversityJobDom getInternalInternshipDetails(String internshipIdAndFirmId, String universityName) {
		return universityJobsDao.getInternalInternshipDetails(internshipIdAndFirmId,universityName);
	}

	@Override
	public void deleteInternalInternship(String internshipIdAndFirmId,String universityName) {
		universityJobsDao.deleteInternalInternship(internshipIdAndFirmId,universityName);
	}

	@Override
	public boolean internalInternshipIdExists(String internshipIdAndFirmId,String universityName) {
		return universityJobsDao.internalInternshipIdExists(internshipIdAndFirmId,universityName);
	}

	@Override
	public List<UniversityJobDom> getInternalPostings(String universityName,List<String> statuses) {
		return universityJobsDao.getInternalPostings(universityName,statuses);
	}

	@Override
	public Map<String, String> getAppliedCandidateEmailIds(String internshipIdAndFirmId, String universityName) {
		return universityJobsDao.getAppliedCandidateEmailIds(internshipIdAndFirmId,universityName);
	}

	@Override
	public Map<String, Date> getAppliedCandidateEmailIdsWithTimestamp(String internshipIdAndFirmId, String universityName) {
		return universityJobsDao.getAppliedCandidateEmailIdsWithTimestamp(internshipIdAndFirmId,universityName);
	}

	@Override
	public void updateCandidateStatus(String candidateEmailId,String internshipIdAndFirmId,String universityName, String status) {
		universityJobsDao.updateCandidateStatus(candidateEmailId,internshipIdAndFirmId,universityName,status);
	}
	
}
