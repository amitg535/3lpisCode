package caerusapp.dao.university;

import java.util.Date;
import java.util.List;
import java.util.Map;

import caerusapp.domain.university.UniversityJobDom;

public interface IUniversityJobsDao {

	List<UniversityJobDom> getInternalPostings(String universityName);

	void postInternship(UniversityJobDom universityJobDom);

	UniversityJobDom getInternalInternshipDetails(String internshipIdAndFirmId,String universityName);

	void deleteInternalInternship(String internshipIdAndFirmId,String universityName);

	boolean internalInternshipIdExists(String internshipIdAndFirmId,String universityName);

	List<UniversityJobDom> getInternalPostings(String universityName,List<String> statuses);

	Map<String, String> getAppliedCandidateEmailIds(String internshipIdAndFirmId,String universityName);

	Map<String, Date> getAppliedCandidateEmailIdsWithTimestamp(String internshipIdAndFirmId, String universityName);

	void updateCandidateStatus(String candidateEmailId,String internshipIdAndFirmId, String universityName, String status);
}
