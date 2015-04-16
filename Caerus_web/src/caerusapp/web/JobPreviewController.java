package caerusapp.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.queryparser.classic.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CandidateCommonBrowseJobs;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Iterables;

/**
 * This class is used to preview job
 * @author PallaviD
 *
 */

@Controller
public class JobPreviewController {
	
	/** Auto-wiring Service Components */
	@Autowired
	private IEmployerJobPostManager employerJobPostManager;
	@Autowired
	private IEmployerManager employerManager;
    @Autowired
	private ILoginManagement loginManagement;
    @Autowired
    private IStudentJobsManager studentJobsManager;
    
    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to display Job preview 
	 * @throws ParseException 
	 */
	
	@RequestMapping (value = CaerusAnnotationURLConstants.PREVIEW_JOB)
	public ModelAndView previewJobDetails(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException, ParseException {
	
logger.info(CaerusLoggerConstants.VIEW_JOB_DETAILS);
		
		/** The modelAndView object contains the model(savedSearchList) and the view(candidate_preview_listed_job)*/
		ModelAndView modelAndView = new ModelAndView("common/preview_listed_job");
		String jobId = request.getParameter("jobId");
		JobDetailsDom job = null;
		EmployerDom companyDetails = new EmployerDom();
		
		/** Retrieving Job Details based on Job Id */
		job = employerJobPostManager.getJobDetailsByJobIdAndFirmId(jobId);

		String companyId = employerJobPostManager.getFirmIdByJobIdAndFirmId(jobId);
		
		if(companyId!=null && !companyId.isEmpty())
		{
			//Fetching the company name using the logged in user's email id
			String corporateName = loginManagement.getEntityNameByEmailId(companyId);
			
			// Retrieving the company details from the database 
			companyDetails = employerManager.getEmployerDetails(corporateName);
		}
		
		modelAndView.addObject("job", job);
		modelAndView.addObject("companyID", companyId);
	
		modelAndView.addObject("companyDetails", companyDetails);
		
		
/** Related Jobs to the One the User Clicked to view the details of */
		
		String jobSkills = "";
		StringBuilder jobSkillsSB = new StringBuilder();
		
		if(! job.getPrimarySkills().isEmpty())
		{
			for (String primarySkill : job.getPrimarySkills()) {
				jobSkillsSB = jobSkillsSB.append(" ").append(primarySkill);
			}
		}

		if(! job.getSecondarySkills().isEmpty())
		{
			for (String secondarySkill : job.getSecondarySkills()) {
				jobSkillsSB = jobSkillsSB.append(" ").append(secondarySkill);
			}
		}
		
		if(jobSkillsSB.length() > 0)
			jobSkills = jobSkillsSB.toString();
		
		File INDEX_LOCATION = new File(CaerusPathConstants.jobIndexes);
		
		Set<String> relatedJobIds = new HashSet<String>();
		
		try {
			/** Fecthing Job Ids of Related Jobs in terms of primary and secondary skills of the current job. */
			relatedJobIds = SimpleDBSearcher.fetchRelatedJobs(jobSkills, INDEX_LOCATION);
			
			if(relatedJobIds != null && relatedJobIds.size() > 0)
				relatedJobIds.remove(jobId);
		} catch (ParseException e) {
			logger.error(e.getLocalizedMessage());
		}
		catch (IOException e) {
			logger.error(e.getLocalizedMessage());
		}
		catch(Exception e)
		{
			logger.error(e.getLocalizedMessage());
		}
		
		/** Removing Applied Jobs from Related Jobs */
		if(null != relatedJobIds && !relatedJobIds.isEmpty())
		{
			//relatedJobIds.removeAll(new ArrayList<String>(appliedJobIdsMap.keySet()));
			relatedJobIds = ImmutableSet.copyOf(Iterables.limit(relatedJobIds, 6));
		}
		
		String relatedJobIdsString = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(relatedJobIds));
		List<JobDetailsDom> relatedJobs = new ArrayList<JobDetailsDom>();
		
		/** Fecthing Job Details of all the Related Job Ids */
		if(!relatedJobIds.isEmpty())
			relatedJobs = employerJobPostManager.getJobsForJobIds(relatedJobIdsString);
			
			int relatedJobCount = 0;
			if(! relatedJobs.isEmpty())
				relatedJobCount = relatedJobs.size();
				
			modelAndView.addObject("relatedJobCount",relatedJobCount);
			modelAndView.addObject("relatedJobs",relatedJobs);
			
			// Candidate Browse jobs section
			Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
			resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, null);
			modelAndView.addObject("resultCountMap", resultCountMap);
		
		
		return modelAndView;
	
	
	
	
	}
	
	

}
