package caerusapp.web.student;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.dao.common.CassandraExtensions;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to get candidate job activities ie applied jobs, applied internships, saved jobs and saved internships
 * @author RavishaG
 */
@Controller
public class CandidateJobActivitiesController {

	@Autowired
	IStudentJobsManager studentJobsManager;

	@Autowired
	private IStudentManager studentManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	CassandraExtensions cassandraExtensionTrial;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * This method is used to get a candidate's applied jobs, applied internships, saved jobs and saved internships
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_JOB_ACTIVITIES)
	public String getCandidateJobActivities(@RequestParam(value="selected",required=false) String selectedMenu, Model model,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		model.addAttribute("noRecommendedJobsMessage",CaerusStringConstants.NO_RECOMMENDED_JOBS);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();		
		List<JobDetailsDom> savedJobs = new ArrayList<JobDetailsDom>();
		List<JobDetailsDom> appliedJobs = new ArrayList<JobDetailsDom>();
		List<JobDetailsDom> recommendedJobs = new ArrayList<JobDetailsDom>();
		
		List<JobDetailsDom> savedInternships = new ArrayList<JobDetailsDom>();
		List<JobDetailsDom> appliedInternships = new ArrayList<JobDetailsDom>();
		
		int appliedJobsCount = 0;
		int savedJobsCount = 0;
		int recommendedJobsCount = 0;
		
		int appliedInternshipsCount = 0;
		int savedInternshipsCount = 0;
		
		Device device = DeviceUtils.getCurrentDevice(httpServletRequest);
		//For thin client
		if(! device.isNormal())
		{
			if(selectedMenu != null)
			{
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_APPLIED_JOBS_SECTION))
				{
					appliedJobs = CandidateCommonFeature.getAppliedJobs(employerJobPostManager, studentJobsManager , loggedInUserEmail, appliedJobs);
					model.addAttribute("appliedJobs",appliedJobs);

					if(appliedJobs != null && appliedJobs.size() > 0)
						appliedJobsCount = appliedJobs.size();
					model.addAttribute("appliedJobsCount",appliedJobsCount);
				}
				
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_APPLIED_INTERNSHIPS_SECTION))
				{
					appliedInternships = CandidateCommonFeature.getAppliedInternships(employerJobPostManager, studentJobsManager, loggedInUserEmail,appliedInternships);
					
					model.addAttribute("appliedInternships",appliedInternships);
		
					if(appliedInternships != null && appliedInternships.size() > 0)
						appliedInternshipsCount = appliedInternships.size();
					model.addAttribute("appliedInternshipsCount",appliedInternshipsCount);
				}
				
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_SAVED_JOBS_SECTION))
				{
					savedJobs = CandidateCommonFeature.getSavedJobs(employerJobPostManager, studentJobsManager , loggedInUserEmail, savedJobs);
					model.addAttribute("savedJobs",savedJobs);
		
					if(savedJobs != null && savedJobs.size() > 0)
						model.addAttribute("savedJobsCount",savedJobs.size());
					
					Map<String,Date> savedAndAppliedJobIdsMap = studentJobsManager.getSavedAndAppliedJobIdsMap(loggedInUserEmail);
					model.addAttribute("savedAndAppliedJobIdsMap",savedAndAppliedJobIdsMap);
				}
				
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_SAVED_INTERNSHIPS_SECTION))
				{
					savedInternships = CandidateCommonFeature.getSavedInternships(employerJobPostManager, studentJobsManager, loggedInUserEmail,savedInternships);	
					model.addAttribute("savedInternships",savedInternships);
					
					if(savedInternships != null && savedInternships.size() > 0)
						savedInternshipsCount = savedInternships.size();
					model.addAttribute("savedInternshipsCount",savedInternshipsCount);
				}
				
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_RECOMMENDED_JOBS_SECTION))
				{
					recommendedJobs = CandidateCommonFeature.getRecommendedJobs(studentJobsManager, employerJobPostManager, loggedInUserEmail,savedInternships);	
					List<JobDetailsDom> sortedRecommendeJobs = CaerusCommonUtility.sortListByDateReverse(recommendedJobs, "JobDetailsDom");
					model.addAttribute("recommendedJobs",sortedRecommendeJobs);
					
					if(sortedRecommendeJobs != null && sortedRecommendeJobs.size() > 0)
						recommendedJobsCount = sortedRecommendeJobs.size();
					model.addAttribute("recommendedJobsCount",recommendedJobsCount);
				}
			}
			
		}
		//For Web app
		else
		{
			if(selectedMenu != null)
			{
				if(selectedMenu.equals(CaerusStringConstants.CANDIDATE_APPLIED_JOBS_SECTION))
				{
					model.addAttribute("appliedJobsListing", true);
				}
			}
			appliedJobs = CandidateCommonFeature.getAppliedJobs(employerJobPostManager, studentJobsManager , loggedInUserEmail, appliedJobs);
			model.addAttribute("appliedJobs",appliedJobs); 
			
			savedJobs = CandidateCommonFeature.getSavedJobs(employerJobPostManager, studentJobsManager , loggedInUserEmail, savedJobs);
			model.addAttribute("savedJobs",savedJobs);
			
			savedInternships = CandidateCommonFeature.getSavedInternships(employerJobPostManager, studentJobsManager, loggedInUserEmail,savedInternships);	
			model.addAttribute("savedInternships",savedInternships);
			
			appliedInternships = CandidateCommonFeature.getAppliedInternships(employerJobPostManager, studentJobsManager, loggedInUserEmail,appliedInternships);
			model.addAttribute("appliedInternships",appliedInternships);
			
			if(appliedJobs != null && appliedJobs.size() > 0)
				appliedJobsCount = appliedJobs.size();
				
			if(savedJobs != null && savedJobs.size() > 0)
				savedJobsCount = savedJobs.size();
			
			if(appliedInternships != null && appliedInternships.size() > 0)
				appliedInternshipsCount = appliedInternships.size();
				
			if(savedInternships != null && savedInternships.size() > 0)
				savedInternshipsCount = savedInternships.size();
				
				
			model.addAttribute("savedJobsCount",savedJobsCount);
			model.addAttribute("appliedInternshipsCount",appliedInternshipsCount);	
			model.addAttribute("savedInternshipsCount",savedInternshipsCount);
			model.addAttribute("appliedJobsCount",appliedJobsCount);
			
			/** For Marking Saved Jobs with Applied Status(if applicable) */
			/*Map<String,Date> savedAndAppliedJobIdsMap = studentJobsManager.getSavedAndAppliedJobIdsMap(loggedInUserEmail);
			model.addAttribute("savedAndAppliedJobIdsMap",savedAndAppliedJobIdsMap);*/
			
			/** For Marking Saved Recommended Jobs with Saved Flag */
			/*Map<String,Date> savedJobIdsMap = studentJobsManager.getSavedJobIdsMap(loggedInUserEmail);
			model.addAttribute("savedJobIdsMap",savedJobIdsMap);*/
			
			/** For Marking Applied Jobs  */
			/*Map<String,Date> appliedJobIdsMap = studentJobsManager.getAppliedJobIdsMap(loggedInUserEmail);
			model.addAttribute("appliedJobIdsMap",appliedJobIdsMap);*/
			
			
			/** For Marking Saved Internships with Applied Status(if applicable) */
			/*Map<String,Date> savedAndAppliedInternshipIdsMap = studentJobsManager.getSavedAndAppliedInternshipIdsMap(loggedInUserEmail);
			model.addAttribute("savedAndAppliedInternshipIdsMap",savedAndAppliedInternshipIdsMap);*/
			
			/** For Marking Saved Internships */
			/*Map<String,Date> savedInternshipIdsMap = studentJobsManager.getSavedInternshipIdsMap(loggedInUserEmail);
			model.addAttribute("savedInternshipIdsMap",savedInternshipIdsMap);*/
			
			/** For Marking Applied Internships  */
			/*Map<String,Date> appliedInternshipIdsMap = studentJobsManager.getAppliedInternshipIdsMap(loggedInUserEmail);
			model.addAttribute("appliedInternshipIdsMap",appliedInternshipIdsMap);*/
			
			
			/*int savedAndAppliedJobIdsMapCount = 0;
			
			if(savedAndAppliedJobIdsMap != null && savedAndAppliedJobIdsMap.size() > 0)
				savedAndAppliedJobIdsMapCount = savedAndAppliedJobIdsMap.size();
			
			model.addAttribute("savedAndAppliedJobIdsMapCount",savedAndAppliedJobIdsMapCount);*/
				
			recommendedJobs = CandidateCommonFeature.getRecommendedJobs(studentJobsManager, employerJobPostManager,loggedInUserEmail,recommendedJobs);
			List<JobDetailsDom> sortedRecommendedJobs = CaerusCommonUtility.sortListByDateReverse(recommendedJobs, "JobDetailsDom");
			
			if(null != sortedRecommendedJobs && sortedRecommendedJobs.size() >0)
				recommendedJobsCount = sortedRecommendedJobs.size();
				
			model.addAttribute("savedJobIds",studentJobsManager.getSavedJobIds(loggedInUserEmail));
			model.addAttribute("recommendedJobs",sortedRecommendedJobs);
			model.addAttribute("recommendedJobsCount",recommendedJobsCount);
		}
		return "candidate/candidate_job_activities";
	}
		
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_APPLY_JOB)
	@ResponseBody
	boolean applyJob(@RequestParam("jobId") String jobId)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		boolean exceptionOccured = checkResumeFilled(loggedInUserEmail);
		
		if(exceptionOccured == false)
			studentJobsManager.applyJob(jobId, loggedInUserEmail);
		
		return exceptionOccured;

		
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_SAVE_JOB)
	@ResponseBody
	void saveJob(@RequestParam("jobId") String jobId)
	{	
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();		
		
		studentJobsManager.saveJob(jobId,loggedInUserEmail);
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_SAVED_JOB)
	@ResponseBody
	boolean applySavedJob(@RequestParam("jobId") String jobId){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		
		boolean exceptionOccured = checkResumeFilled(loggedInUserEmail);
		
		if(exceptionOccured == false)
			studentJobsManager.applySavedJob(jobId,loggedInUserEmail);
		return exceptionOccured;
	}

	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_INTERNSHIP)
	@ResponseBody
	boolean applyInternship(@RequestParam("internshipId") String internshipId)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();	
		boolean exceptionOccured = checkResumeFilled(loggedInUserEmail);
		
		if(exceptionOccured == false)
			studentJobsManager.applyInternship(internshipId,loggedInUserEmail);
		return exceptionOccured;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_SAVE_INTERNSHIP)
	@ResponseBody
	void saveInternship(@RequestParam("internshipId") String internshipId)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		studentJobsManager.saveInternship(internshipId,loggedInUserEmail);
		logger.info(CaerusLoggerConstants.CANDIDATE_SAVED_INTERNSHIP);
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_SAVED_INTERNSHIP)
	@ResponseBody
	boolean applySavedInternship(@RequestParam("internshipId") String internshipId){
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		
		boolean exceptionOccured = checkResumeFilled(loggedInUserEmail);
		
		if(exceptionOccured == false)
			studentJobsManager.applySavedInternship(internshipId,loggedInUserEmail);
		return exceptionOccured;
	}
	
	boolean checkResumeFilled(String loggedInUserEmail){
		
		boolean exceptionOccured = false;
		// Retrieving logged in student details from the database
		StudentDom student = studentManager.getDetailsByEmailId(loggedInUserEmail);
		String resume = student.getResumeName();
		String courseType = student.getCourseType();
		if (resume == null) 
		{
			exceptionOccured = true;
		}
		
		return exceptionOccured;
		
	}

	
}