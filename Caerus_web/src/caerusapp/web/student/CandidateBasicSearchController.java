package caerusapp.web.student;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.queryparser.classic.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CandidateCommonBrowseJobs;

/**
 * This class is used for candidate search page
 * @author RavishaG
 *
 */
@Controller
public class CandidateBasicSearchController {

	// Auto-wiring service components
	@Autowired
	IStudentJobsManager studentJobsManager;
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	IMasterManager masterManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * This method is used to load the candidate search page
	 * @param httpServletRequest
	 * @return ModelAndView	
	 * @throws IOException 
	 * @throws ParseException 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_BASIC_SEARCH)
	public ModelAndView candidateSearchPage(HttpServletRequest httpServletRequest) throws IOException, ParseException
	{
		 //Spring security authentication containing the logged in user details
		 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		 String emailId = authentication.getName(); 
				
		 // The modelAndView object contains the model(data) and the view(page)
		 ModelAndView modelAndView = new ModelAndView("candidate/candidate_basic_search");
		 
		 List<JobDetailsDom> recentJobsInternshipDetails = new ArrayList<JobDetailsDom>();
		 LinkedHashMap<String , String> nowRecruitingCompanies = new LinkedHashMap<String,String>();
		 
		 // Fetching recently posted jobs and internships
		 recentJobsInternshipDetails = getRecentJobsInternships(emailId);
		
		if(null != recentJobsInternshipDetails && recentJobsInternshipDetails.size() > 0)
		{
			// Send 5 recent jobs and internships to the jsp page
			if(recentJobsInternshipDetails.size() > 5)
				modelAndView.addObject("recentJobs",recentJobsInternshipDetails.subList(0, 5));
			
			modelAndView.addObject("recentJobsSize",recentJobsInternshipDetails.size());
			
		}	
		
		// Getting unique companies that are presently recruiting
		for (JobDetailsDom jobDetailsDom : recentJobsInternshipDetails) {
			if(null != jobDetailsDom.getCompanyName() && !jobDetailsDom.getCompanyName().equals(""))
				nowRecruitingCompanies.put(jobDetailsDom.getCompanyName(),jobDetailsDom.getEmailId());
		}
		
		if(null != nowRecruitingCompanies && nowRecruitingCompanies.size() > 0)
			modelAndView.addObject("nowRecruitingCompanies",nowRecruitingCompanies);
			
		// Fetching the popular keywords searched by candidates
		Map<String,Integer> popularTags = studentManager.getCandidateSearchedKeywords();
		if(popularTags != null && popularTags.size() > 0)
		{
			Map<String,Integer> popularTagsSorted = CaerusCommonUtil.sortMapOnValues(popularTags); 
			List<String> popularTagsList = new ArrayList<>(popularTagsSorted.keySet());
			
			if(null != popularTagsList && popularTagsList.size() > 0)
			{
				if(popularTagsList.size() > 5)
					modelAndView.addObject("popularTags", popularTagsList.subList(0, 5));
				else
					modelAndView.addObject("popularTags", popularTagsList);
			}
			
		}
		
		// Candidate Browse jobs section
		Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
		resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, emailId);
		modelAndView.addObject("resultCountMap", resultCountMap);
			
		//Fetching candidate's recent searches
		Map<String,Date> recentSearches = studentManager.getCandidateRecentSearches(emailId);
		
		recentSearches = CaerusCommonUtil.sortMapOnValues(recentSearches);
		List<String> recentSearchList = new ArrayList<String>(recentSearches.keySet());
		
		if(null != recentSearchList && recentSearchList.size() > 0)
		{
			if(recentSearchList.size() > 5)
				modelAndView.addObject("recentSearches", recentSearchList.subList(0, 5));
			else
				modelAndView.addObject("recentSearches", recentSearchList);
		}
		
		/** Retrieving Saved Search List*/
		List<JobDetailsDom> savedSearches = studentJobsManager.getSavedSearches(emailId);
		modelAndView.addObject("savedSearchSize", savedSearches.size());
		
		
		//Retrieving Industry List
	    List<String> industries =  masterManager.getIndustries();
	 	
		//Retrieving Functional Area List
	    List<String> functionalAreas = masterManager.getFunctionalAreas();
		
		Collections.sort(industries);
		Collections.sort(functionalAreas);

		modelAndView.addObject("industries", industries);
		modelAndView.addObject("functionalAreas",functionalAreas);
		modelAndView.addObject("searchJobs", new JobDetailsCom());
		
		
		return modelAndView;
	}
	
	/**
	 * This method is used to filter recent jobs
	 * @param jobDetailsDom
	 * @param httpServletRequest
	 * @return List<JobDetailsDom>
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_FILTER_ON_RECENT_JOBS)
	@ResponseBody
	public List<JobDetailsDom> getFilteredJobs(@RequestBody JobDetailsDom jobDetailsDom,HttpServletRequest httpServletRequest)
	{
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String emailId = authentication.getName(); 
		 
		List<JobDetailsDom> recentJobsInternshipDetails = new ArrayList<JobDetailsDom>();
		List<JobDetailsDom> recentFilteredJobs = new ArrayList<JobDetailsDom>();
		
		// Fetching recently posted jobs and internships
		recentJobsInternshipDetails = getRecentJobsInternships(emailId);
		
		if(recentJobsInternshipDetails != null && recentJobsInternshipDetails.size() > 0)
		{
			for (JobDetailsDom recentJobsInternships : recentJobsInternshipDetails) {
				
				if(jobDetailsDom.getJobFilterValues().size() > 0)
				{
					for (String jobType : jobDetailsDom.getJobFilterValues()) {
						
							// Find recent jobs as per the applied filter
							if(recentJobsInternships.getJobType() != null && recentJobsInternships.getJobType().trim().replace(" ","").equalsIgnoreCase(jobType))
								recentFilteredJobs.add(recentJobsInternships);
					}
				}
				
				else
					recentFilteredJobs = recentJobsInternshipDetails;
			}
		}
		
		if(null != jobDetailsDom.getAllJobsInternshipsFlag() && jobDetailsDom.getAllJobsInternshipsFlag())
		{
			return recentFilteredJobs;
		}
		
		else
		{
			// Send 5 recent filtered jobs and internships to the jsp page
			if(recentFilteredJobs != null && recentFilteredJobs.size() > 5)
				return recentFilteredJobs.subList(0, 5);
			
			else
				return recentFilteredJobs;
		}
	}
	
	/**
	 * This method is used to fetch recent jobs and internships from indexes
	 * @param emailId
	 * @return List<JobDetailsDom>
	 */
	@SuppressWarnings("unchecked")
	public List<JobDetailsDom> getRecentJobsInternships(String emailId)
	{
		 String SRC_FOLDER = CaerusPathConstants.jobIndexes;
		
		 File indexDir = new File(SRC_FOLDER);
		
		 SimpleDBSearcher simpleDBSearcher = new SimpleDBSearcher();
		 
		 Map<String, Date> appliedJobIdMap = new HashMap<String, Date>();
		 Map<String, Date> appliedInternshipIdMap = new HashMap<String, Date>();
		 Map<String,List<String>> jobAndInternshipIds = new HashMap<String,List<String>>();
		 List<String> jobIds = new ArrayList<String>();
		 List<String> internshipIds = new ArrayList<String>();
		 List<JobDetailsDom> searchedJobsDetails = new ArrayList<JobDetailsDom>();
		 List<JobDetailsDom> searchedInternshipDetails = new ArrayList<JobDetailsDom>();
		 List<JobDetailsDom> recentJobsInternshipDetails = new ArrayList<JobDetailsDom>();
		 
		 // Fetch recent jobs and internships from indexes
		 try
		 {
			 jobAndInternshipIds = simpleDBSearcher.searchIndexForRecentJobs(indexDir);
		 }
		 catch(Exception exception)
		 {
			logger.error("Indexes not found at "+indexDir);
		 }
		 
		 if(jobAndInternshipIds != null && jobAndInternshipIds.size() > 0)
		 {
			 for (Entry<String,List<String>> entry : jobAndInternshipIds.entrySet()) 
			 {
				 if(entry.getKey().equals("jobs"))
				 {
					 jobIds = entry.getValue();
					 
					 if(jobIds != null && jobIds.size() > 0)
					 {
						// Get the jobs applied by the candidate
						if(emailId!= null && !emailId.isEmpty())
						{
							jobIds.removeAll(studentJobsManager.getAppliedJobIds(emailId));
						
							/*if(appliedJobIdMap!=null && appliedJobIdMap.size() !=0)
							{
								for (String appliedJobId : appliedJobIdMap.keySet()) {
									
									jobIds.remove(appliedJobId);
								}
							}*/
						}
					 }
				 }
				 else
				 {
					 internshipIds = entry.getValue();
					 
					 if(internshipIds != null && internshipIds.size() > 0)
					 {
						 // Get the internships applied by the candidate
						 if(emailId!= null && !emailId.isEmpty())
							{
								/*appliedInternshipIdMap = studentJobsManager.getAppliedInternshipIds(emailId);*/
							
								internshipIds.removeAll(studentJobsManager.getAppliedInternshipIds(emailId));
								
								/*if(appliedInternshipIdMap!=null && appliedInternshipIdMap.size()!=0)
								{
									for (String appliedInternshipId : appliedInternshipIdMap.keySet()) {
										
										internshipIds.remove(appliedInternshipId);
									}
								}*/
							}
						 }
				 }
				 
			}
		 } 
		
		// Get job details 
		if(jobIds != null && jobIds.size() > 0)
		{
			searchedJobsDetails = studentJobsManager.getJobDetails(jobIds);
			if(searchedJobsDetails != null && searchedJobsDetails.size() > 0)
			{
				for (JobDetailsDom jobDetailsDom : searchedJobsDetails) {
					jobDetailsDom.setJobFlag(true);
				}
				recentJobsInternshipDetails.addAll(searchedJobsDetails);
			}
		} 
		
		// Get internship details
		if(internshipIds != null && internshipIds.size() > 0)
		{
			searchedInternshipDetails = studentJobsManager.getInternshipDetails(internshipIds);
			if(searchedInternshipDetails != null && searchedInternshipDetails.size() > 0)
			{
				for (JobDetailsDom jobDetailsDom : searchedInternshipDetails) {
					
					jobDetailsDom.setJobFlag(false);
					jobDetailsDom.setJobType("Internship");
				}
				
				recentJobsInternshipDetails.addAll(searchedInternshipDetails);
			}
		} 
		
		if(recentJobsInternshipDetails != null && recentJobsInternshipDetails.size() > 0)
		{
			// Sort jobs and internships on date
			recentJobsInternshipDetails = CaerusCommonUtility.sortListByDateReverse(recentJobsInternshipDetails, "JobDetailsDom");
			
			for(JobDetailsDom jobDetailsDom : recentJobsInternshipDetails) 
	        {
	            	jobDetailsDom.setDifferenceInDays((CaerusCommonUtility.getDifferenceInDays("E MMM dd HH:mm:ss Z yyyy",jobDetailsDom.getPostedOn())));
	        }
			
		}	
		
		return recentJobsInternshipDetails;
		 
	}
	
	/**
	 * This method is used to display all recent jobs and internships for a candidate
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 * @throws IOException 
	 * @throws ParseException 
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_ALL_RECENT_JOBS)
	public ModelAndView candidateAllRecentJobs(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException, ParseException
	{
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String emailId = authentication.getName(); 
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_all_recent_jobs");
		
		List<JobDetailsDom> recentJobsInternshipDetails = new ArrayList<JobDetailsDom>();
		 
		// Fetching recently posted jobs and internships
		recentJobsInternshipDetails = getRecentJobsInternships(emailId);
		
		if(null != recentJobsInternshipDetails && recentJobsInternshipDetails.size() > 0)
		{
			modelAndView.addObject("recentJobs",recentJobsInternshipDetails);
		}	
		
		// Candidate Browse jobs section
		Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
		resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, emailId);
		modelAndView.addObject("resultCountMap", resultCountMap);
		
		return modelAndView;
	}
}
