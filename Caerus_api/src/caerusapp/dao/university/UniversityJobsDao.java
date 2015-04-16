package caerusapp.dao.university;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.dao.common.AsyncActivities;
import caerusapp.dao.employer.IEmployerJobPostDao;
import caerusapp.domain.university.UniversityJobDom;
import caerusapp.util.CaerusAPIStringConstants;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;

public class UniversityJobsDao implements IUniversityJobsDao {

	@Autowired
	CassandraOperations cassandraOperations;
	
	@Autowired
	AsyncActivities asyncActivities;
	
	@Autowired
	IEmployerJobPostDao employerJobPostDao;
	
	Log logger = LogFactory.getLog(getClass());
	
	@Override
	public List<UniversityJobDom> getInternalPostings(String universityName) {
		List<UniversityJobDom> internalPostings = new ArrayList<UniversityJobDom>();
		
		Select selectInternalPostings = QueryBuilder.select().from("university_internship_dtls");
		selectInternalPostings.where(QueryBuilder.eq("univ_name", universityName));
		selectInternalPostings.where(QueryBuilder.eq("self_posted", true));
		selectInternalPostings.where(QueryBuilder.eq("is_deleted", false));
		selectInternalPostings.allowFiltering();
		
		try {
			internalPostings = cassandraOperations.query(selectInternalPostings, new InternshipDetailsMapper());
		} catch (NullPointerException | IllegalArgumentException | NoHostAvailableException e) {
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" getInternalPostings "+e.getStackTrace().toString() );
			internalPostings = new ArrayList<UniversityJobDom>();
		}
		
		return null == internalPostings ? new ArrayList<UniversityJobDom>() : internalPostings;
	}

	private class InternshipDetailsMapper implements RowMapper<UniversityJobDom>{
		
		@Override
		public UniversityJobDom mapRow(Row rs, int arg1) throws DriverException {
			UniversityJobDom internshipDetails = new UniversityJobDom();
			
			internshipDetails.setInternshipIdAndFirmId(rs.getString("internship_id_and_firm_id"));
			internshipDetails.setUniversityName(rs.getString("univ_name"));
			internshipDetails.setInternshipId(rs.getString("internship_id"));
			internshipDetails.setInternshipTitle(rs.getString("internship_title"));
			internshipDetails.setInternshipType(rs.getString("internship_type"));
			internshipDetails.setApproximateHours(rs.getString("approximate_hours"));
			internshipDetails.setStartDate(rs.getString("start_date"));
			internshipDetails.setEndDate(rs.getString("end_date"));
			internshipDetails.setPayPerHour(rs.getString("payper_hours"));
			internshipDetails.setVacancyCount(rs.getString("numberofvacancy"));
			internshipDetails.setPrimarySkills((List<String>) rs.getList("primary_skills",String.class));
			internshipDetails.setSecondarySkills((List<String>) rs.getList("secondary_skills",String.class));
			internshipDetails.setLocation(rs.getString("internship_location"));
			internshipDetails.setInternshipDescription(rs.getString("internship_description"));
			internshipDetails.setStatus(rs.getString("status"));
			internshipDetails.setPostedOn(rs.getString("posted_on"));
			internshipDetails.setZipCode(rs.getString("zip_code"));
			internshipDetails.setAppliedStudents(rs.getMap("candidate_internship_status", String.class, String.class));

			return internshipDetails;
		}
		
	}

	@Override
	public void postInternship(UniversityJobDom updatedInternshipDetails) {
		String internshipIdAndFirmId = updatedInternshipDetails.getInternshipId().concat("_").concat(updatedInternshipDetails.getUniversityName());
		
		UniversityJobDom oldInternshipDetails = getInternalInternshipDetails(internshipIdAndFirmId, updatedInternshipDetails.getUniversityName());
		
		if(! updatedInternshipDetails.getStatus().equals(CaerusAPIStringConstants.JOB_STATUS_DRAFT))
			asyncActivities.updateCandidateActivitiesInternalPosting(oldInternshipDetails, updatedInternshipDetails);
		
		
		Insert postInternship = QueryBuilder.insertInto("university_internship_dtls").values(
				new String[]{"internship_id_and_firm_id","internship_id","univ_name","internship_title",
						"internship_type","approximate_hours","start_date","end_date","payper_hours",
						"numberofvacancy","primary_skills","secondary_skills","internship_location",
						"internship_description","status","posted_on","zip_code","is_deleted","self_posted"
						}, 
				new Object[]{
						internshipIdAndFirmId,
						updatedInternshipDetails.getInternshipId(),
						updatedInternshipDetails.getUniversityName(),
						updatedInternshipDetails.getInternshipTitle(),
						updatedInternshipDetails.getInternshipType(),
						updatedInternshipDetails.getApproximateHours(),
						updatedInternshipDetails.getStartDate(),
						updatedInternshipDetails.getEndDate(),
						updatedInternshipDetails.getPayPerHour(),
						updatedInternshipDetails.getVacancyCount(),
						updatedInternshipDetails.getPrimarySkills(),
						updatedInternshipDetails.getSecondarySkills(),
						updatedInternshipDetails.getLocation(),
						updatedInternshipDetails.getInternshipDescription(),
						updatedInternshipDetails.getStatus(),
						new Date().toString(),
						updatedInternshipDetails.getZipCode(),
						false,
						true
				});
		
		
		try {
			cassandraOperations.execute(postInternship);
		}
		catch(NoHostAvailableException | IllegalArgumentException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" postInternship "+ex.getStackTrace().toString() );
		}
	}

	@Override
	public UniversityJobDom getInternalInternshipDetails(String internshipIdAndFirmId, String universityName) {
		UniversityJobDom internshipDetails = new UniversityJobDom();
		
		Select selectInternshipDetails = QueryBuilder.select().from("university_internship_dtls");
		selectInternshipDetails.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
		selectInternshipDetails.where(QueryBuilder.eq("univ_name", universityName));
		
		try {
			internshipDetails = cassandraOperations.queryForObject(selectInternshipDetails, new InternshipDetailsMapper());
		} catch (NullPointerException | IllegalArgumentException | NoHostAvailableException e) {
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" getInternalInternshipDetails "+e.getStackTrace().toString() );
			internshipDetails = new UniversityJobDom();
		}
		
		return null == internshipDetails ?  new UniversityJobDom(): internshipDetails;
	}

	@Override
	public void deleteInternalInternship(String internshipIdAndFirmId,String universityName) {
		Update deleteInternship = QueryBuilder.update("university_internship_dtls");
		deleteInternship.with(QueryBuilder.set("is_deleted", true));
		deleteInternship.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
		deleteInternship.where(QueryBuilder.eq("univ_name", universityName));
		
		try {
			cassandraOperations.execute(deleteInternship);
		}
		catch(NoHostAvailableException | IllegalArgumentException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" deleteInternalInternship "+ex.getStackTrace().toString() );
		}
		
	}

	@Override
	public boolean internalInternshipIdExists(String internshipIdAndFirmId,String universityName) {
		boolean internshipIdExists = false;
		
		Select countInternship = QueryBuilder.select().countAll().from("university_internship_dtls");
		countInternship.where(QueryBuilder.eq("internship_id_and_firm_id", internshipIdAndFirmId));
		countInternship.where(QueryBuilder.eq("univ_name", universityName));
		
		try {
			long internshipCount = cassandraOperations.queryForObject(countInternship,Long.class);
			if(internshipCount != 0)
				internshipIdExists = true;
		}
		catch(NoHostAvailableException | IllegalArgumentException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" internalInternshipIdExists "+ex.getStackTrace().toString() );
		}
		return internshipIdExists;
	}

	@Override
	public List<UniversityJobDom> getInternalPostings(String universityName,List<String> statuses) {
		List<UniversityJobDom> internalPostings = new ArrayList<UniversityJobDom>();
		
		for (String status : statuses) {
			Select selectInternalPostings = QueryBuilder.select().from("university_internship_dtls");
			selectInternalPostings.where(QueryBuilder.eq("univ_name", universityName));
			selectInternalPostings.where(QueryBuilder.eq("self_posted", true));
			selectInternalPostings.where(QueryBuilder.eq("is_deleted", false));
			selectInternalPostings.where(QueryBuilder.eq("status", status));
			
			selectInternalPostings.allowFiltering();
			
			try {
				internalPostings.addAll( cassandraOperations.query(selectInternalPostings, new InternshipDetailsMapper()) );
			} catch (NullPointerException | IllegalArgumentException | NoHostAvailableException e) {
				logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+" getInternalPostings "+e.getStackTrace().toString() );
				internalPostings = new ArrayList<UniversityJobDom>();
			}
		}
		return null == internalPostings ? new ArrayList<UniversityJobDom>() : internalPostings;
	}

	@Override
	public Map<String, String> getAppliedCandidateEmailIds(String internshipIdAndFirmId, String universityName) {
		Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
		
		Select selectAppliedCandidates = QueryBuilder.select(CaerusAPIStringConstants.APPLIED_CANDIDATES_STATUS).from(CaerusAPIStringConstants.TABLE_UNIVERSITY_INTERNSHIP_DTLS);
		selectAppliedCandidates.where(QueryBuilder.eq(CaerusAPIStringConstants.INTERNSHIP_ID_AND_FIRM_ID,internshipIdAndFirmId));
		selectAppliedCandidates.where(QueryBuilder.eq(CaerusAPIStringConstants.UNIVERSITY_NAME,universityName));
		
		try {
			appliedCandidateEmailIds = cassandraOperations.queryForObject(selectAppliedCandidates, Map.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(ex.getStackTrace().toString());
			appliedCandidateEmailIds = new HashMap<String, String>();
		}
		return null == appliedCandidateEmailIds ? new HashMap<String, String>() : appliedCandidateEmailIds;
	}

	@Override
	public Map<String, Date> getAppliedCandidateEmailIdsWithTimestamp(String internshipIdAndFirmId, String universityName) {
		Map<String, Date> appliedCandidateEmailIdsWithTime = new HashMap<String, Date>();
		
		Select selectAppliedCandidates = QueryBuilder.select(CaerusAPIStringConstants.APPLIED_CANDIDATES).from(CaerusAPIStringConstants.TABLE_UNIVERSITY_INTERNSHIP_DTLS);
		selectAppliedCandidates.where(QueryBuilder.eq(CaerusAPIStringConstants.INTERNSHIP_ID_AND_FIRM_ID,internshipIdAndFirmId));
		selectAppliedCandidates.where(QueryBuilder.eq(CaerusAPIStringConstants.UNIVERSITY_NAME,universityName));
		
		try {
			appliedCandidateEmailIdsWithTime = cassandraOperations.queryForObject(selectAppliedCandidates, Map.class);
		}
		catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
			logger.error(ex.getStackTrace().toString());
			appliedCandidateEmailIdsWithTime = new HashMap<String, Date>();
		}
		return null == appliedCandidateEmailIdsWithTime ? new HashMap<String, Date>() : appliedCandidateEmailIdsWithTime;
	}

	@Override
	public void updateCandidateStatus(String candidateEmailId,String internshipIdAndFirmId,String universityName, String status) {
		Update updateCandidateStatus = QueryBuilder.update(CaerusAPIStringConstants.TABLE_UNIVERSITY_INTERNSHIP_DTLS);
		updateCandidateStatus.with(QueryBuilder.put(CaerusAPIStringConstants.APPLIED_CANDIDATES_STATUS,candidateEmailId, status));
		updateCandidateStatus.where(QueryBuilder.eq(CaerusAPIStringConstants.INTERNSHIP_ID_AND_FIRM_ID, internshipIdAndFirmId));
		updateCandidateStatus.where(QueryBuilder.eq(CaerusAPIStringConstants.UNIVERSITY_NAME, universityName));
		
		
		try {
			cassandraOperations.execute(updateCandidateStatus);
		}
		catch(NoHostAvailableException | IllegalArgumentException ex){
			logger.error(CaerusAPIStringConstants.ERROR_MESSAGE+ " "+ ex.getStackTrace().toString());
		}
	}
}
