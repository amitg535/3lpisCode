package caerusapp.dao.common;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.cassandra.core.CassandraOperations;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.university.UniversityJobDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.util.CaerusAPIStringConstants;

import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Update;

@Component
public class AsyncActivities {

	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	CassandraOperations cassandraOperations;
	
	private Log logger = LogFactory.getLog(getClass());
	
	@Async
	public void updateCandidateActivitiesJob(String jobIdAndFirmId, JobDetailsDom updatedJobDetails, boolean campusFlag){
		boolean updateFlag = false;
		List<String> candidateEmailIds = new ArrayList<String>();
		JobDetailsDom oldJobDetails = new JobDetailsDom();
		String universityName = "";
		
		if(campusFlag)
		{
			try {
				List<String> universityNames = cassandraOperations.queryForList("select univ_name from university_job_dtls where job_id_and_firm_id='"+jobIdAndFirmId+"'", String.class);
				
				if(null != universityNames && ! universityNames.isEmpty())
					universityName = universityNames.get(0).trim();
			}
			catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
				logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			}
		}
		
		if(! campusFlag)
		{
			try {
				oldJobDetails = employerJobPostManager.getJobDetailsByJobIdAndFirmId(jobIdAndFirmId);
			}
			catch (IllegalArgumentException | NullPointerException e) {
				oldJobDetails = new JobDetailsDom();
			}
		}
		
		if(campusFlag && null != universityName && universityName.trim().length() > 0)
		{
			try {
				oldJobDetails = employerJobPostManager.getCampusJobDetails(jobIdAndFirmId, universityName);
			}
			catch (IllegalArgumentException | NullPointerException e) {
				oldJobDetails = new JobDetailsDom();
			}
		}

		
		if(null != oldJobDetails.getJobTitle() && oldJobDetails.getJobTitle().trim().length() > 0)
		{
			Update updateCandidateActivities = QueryBuilder.update(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
			if(! updatedJobDetails.getJobTitle().equals(oldJobDetails.getJobTitle()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TITLE, updatedJobDetails.getJobTitle()));
				updateFlag = true;
			}
			
			if(! updatedJobDetails.getJobType().equals(oldJobDetails.getJobType()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TYPE, updatedJobDetails.getJobType()));
				updateFlag = true;
			}
			
			if(! updatedJobDetails.getLocation().equals(oldJobDetails.getLocation()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_LOCATION, updatedJobDetails.getLocation()));
				updateFlag = true;
			}
			
			if(! updatedJobDetails.getPrimarySkills().toString().contentEquals(oldJobDetails.getPrimarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.PRIMARY_SKILLS, updatedJobDetails.getPrimarySkills()));
				updateFlag = true;
			}
			
			if(! updatedJobDetails.getSecondarySkills().toString().contentEquals(oldJobDetails.getSecondarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.SECONDARY_SKILLS, updatedJobDetails.getSecondarySkills()));
				updateFlag = true;
			}
			
			if(! updatedJobDetails.getStatus().equals(oldJobDetails.getStatus()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_STATUS, updatedJobDetails.getStatus()));
				updateFlag = true;
			}
			
			if(updateFlag){
				try {
					candidateEmailIds = cassandraOperations.queryForList("select email_id from candidate_activities where job_id_and_firm_id='"+jobIdAndFirmId+"'", String.class);
				}
				catch(IllegalArgumentException | NoHostAvailableException | NullPointerException ex){
					candidateEmailIds = new ArrayList<String>();
				}
			}
			updateCandidateActivities.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, jobIdAndFirmId));
			
			String updateCandidateActivitiesQuery = updateCandidateActivities.toString();
			
			for (String candidateEmailId : candidateEmailIds) {
				String localQuery = updateCandidateActivitiesQuery.substring(0, updateCandidateActivitiesQuery.lastIndexOf(";")).concat(" and email_id='"+candidateEmailId+"'");
				cassandraOperations.execute(localQuery);
				logger.info(CaerusAPIStringConstants.ASYNC_UPDATE_CANDIDATE_ACTIVITIES);
			}
		}
	}
	
	
	@Async
	public void updateCandidateActivitiesInternship(String internshipIdAndFirmId,JobDetailsDom updatedInternshipDetails,boolean campusFlag){
		boolean updateFlag = false;
		List<String> candidateEmailIds = new ArrayList<String>();
		String universityName = "";
		JobDetailsDom oldInternshipDetails = new JobDetailsDom();
		
		if(campusFlag)
		{
			try {
			List<String> universityNames = cassandraOperations.queryForList("select univ_name from university_internship_dtls where internship_id_and_firm_id='"+internshipIdAndFirmId+"'", String.class);
			if(null != universityNames && !universityNames.isEmpty())
				universityName = universityNames.get(0).trim();
			}
			catch(NullPointerException | IllegalArgumentException | NoHostAvailableException ex){
				logger.error(CaerusAPIStringConstants.ERROR_MESSAGE);
			}
		}
		if(! campusFlag)
			oldInternshipDetails = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
		
		if(campusFlag && null != universityName && universityName.trim().length() > 0)
			oldInternshipDetails = employerJobPostManager.getCampusInternshipDetails(internshipIdAndFirmId, universityName);
		
		
		if(null != oldInternshipDetails.getInternshipTitle() && oldInternshipDetails.getInternshipTitle().trim().length() > 0)
		{
			Update updateCandidateActivities = QueryBuilder.update(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
			
			if(! updatedInternshipDetails.getInternshipTitle().equals(oldInternshipDetails.getInternshipTitle()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TITLE, updatedInternshipDetails.getInternshipTitle()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getInternshipType().equals(oldInternshipDetails.getInternshipType()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TYPE, updatedInternshipDetails.getInternshipType()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getLocation().equals(oldInternshipDetails.getLocation()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_LOCATION, updatedInternshipDetails.getLocation()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getPrimarySkills().toString().contentEquals(oldInternshipDetails.getPrimarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.PRIMARY_SKILLS, updatedInternshipDetails.getPrimarySkills()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getSecondarySkills().toString().contentEquals(oldInternshipDetails.getSecondarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.SECONDARY_SKILLS, updatedInternshipDetails.getSecondarySkills()));
				updateFlag = true;
			}
			
			if(! campusFlag)
			{
				if(! updatedInternshipDetails.getStatus().equals(oldInternshipDetails.getStatus()))
				{
					updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_STATUS, updatedInternshipDetails.getStatus()));
					updateFlag = true;
				}
			}
			
			
			if(updateFlag){
				try {
					candidateEmailIds = cassandraOperations.queryForList("select email_id from candidate_activities where job_id_and_firm_id='"+internshipIdAndFirmId+"'", String.class);
				}
				catch(IllegalArgumentException | NoHostAvailableException | NullPointerException ex){
					candidateEmailIds = new ArrayList<String>();
				}
			}
			updateCandidateActivities.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, internshipIdAndFirmId));
			
			String updateCandidateActivitiesQuery = updateCandidateActivities.toString();
			
			for (String candidateEmailId : candidateEmailIds) {
				String localQuery = updateCandidateActivitiesQuery.substring(0, updateCandidateActivitiesQuery.lastIndexOf(";")).concat(" and email_id='"+candidateEmailId+"'");
				cassandraOperations.execute(localQuery);
				logger.info(CaerusAPIStringConstants.ASYNC_UPDATE_CANDIDATE_ACTIVITIES);
			}
		}
	}


	public void updateCandidateActivitiesInternalPosting(UniversityJobDom oldInternshipDetails,UniversityJobDom updatedInternshipDetails) {
		boolean updateFlag = false;
		List<String> candidateEmailIds = new ArrayList<String>();
		
		if(null != oldInternshipDetails.getInternshipTitle() && oldInternshipDetails.getInternshipTitle().trim().length() > 0)
		{
			Update updateCandidateActivities = QueryBuilder.update(CaerusAPIStringConstants.TABLE_CANDIDATE_ACTIVITIES);
			
			if(! updatedInternshipDetails.getInternshipTitle().equals(oldInternshipDetails.getInternshipTitle()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TITLE, updatedInternshipDetails.getInternshipTitle()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getInternshipType().equals(oldInternshipDetails.getInternshipType()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_TYPE, updatedInternshipDetails.getInternshipType()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getLocation().equals(oldInternshipDetails.getLocation()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_LOCATION, updatedInternshipDetails.getLocation()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getPrimarySkills().toString().contentEquals(oldInternshipDetails.getPrimarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.PRIMARY_SKILLS, updatedInternshipDetails.getPrimarySkills()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getSecondarySkills().toString().contentEquals(oldInternshipDetails.getSecondarySkills().toString()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.SECONDARY_SKILLS, updatedInternshipDetails.getSecondarySkills()));
				updateFlag = true;
			}
			
			if(! updatedInternshipDetails.getStatus().equals(oldInternshipDetails.getStatus()))
			{
				updateCandidateActivities.with(QueryBuilder.set(CaerusAPIStringConstants.JOB_STATUS, updatedInternshipDetails.getStatus()));
				updateFlag = true;
			}
			
			if(updateFlag){
				try {
					candidateEmailIds = cassandraOperations.queryForList("select email_id from candidate_activities where job_id_and_firm_id='"+oldInternshipDetails.getInternshipIdAndFirmId()+"'", String.class);
				}
				catch(IllegalArgumentException | NoHostAvailableException | NullPointerException ex){
					candidateEmailIds = new ArrayList<String>();
				}
			}
			updateCandidateActivities.where(QueryBuilder.eq(CaerusAPIStringConstants.JOB_ID_AND_FIRM_ID, oldInternshipDetails.getInternshipIdAndFirmId()));
			
			String updateCandidateActivitiesQuery = updateCandidateActivities.toString();
			
			for (String candidateEmailId : candidateEmailIds) {
				String localQuery = updateCandidateActivitiesQuery.substring(0, updateCandidateActivitiesQuery.lastIndexOf(";")).concat(" and email_id='"+candidateEmailId+"'");
				cassandraOperations.execute(localQuery);
				logger.info(CaerusAPIStringConstants.ASYNC_UPDATE_CANDIDATE_ACTIVITIES);
			}
		
		}
	}
}
