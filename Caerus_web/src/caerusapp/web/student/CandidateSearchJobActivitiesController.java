package caerusapp.web.student;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.StudentJobsManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CandidateCommonBrowseJobs;

@Controller
public class CandidateSearchJobActivitiesController {
	
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	//Auto-wiring Service Components
	@Autowired
	StudentJobsManager studentJobsManager;
	
	@Autowired
	StudentManager studentManager;
	
	@Autowired
	IMasterManager masterManager;
	

	@ModelAttribute ("searchJobs")
	public JobDetailsCom getSearchJobs()
	{
		return new JobDetailsCom();
	}
	
	/**
	 * This Method is used to retrieve searched jobs/internships listing or save searches
	 * @param request
	 * @param searchJobs
	 * @param model
	 * @param bindingResult
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_SEARCH_JOBS_INTERNSHIPS, method=RequestMethod.POST)
	protected String onSubmit(HttpServletRequest request , @ModelAttribute("searchJobs") JobDetailsCom searchJobs , Model model, BindingResult bindingResult)throws Exception 
	{
		//Retrieving Current session
		HttpSession inputSession = request.getSession(true);
		String emailId ="";
		
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication!=null)
			emailId = authentication.getName(); 
		else
			emailId = (String) inputSession.getAttribute("emailId");
		
		
		List<JobDetailsDom> searchedJobsDetails = new ArrayList<JobDetailsDom>();
		List<JobDetailsDom> sortedSearchedJobsDetails = new ArrayList<JobDetailsDom>();
		
		List<String> jobIdList = new ArrayList<String>();
		Map<String, Date> appliedJobIdMap = new HashMap<String, Date>();
		Map<String, Date> appliedInternshipIdMap = new HashMap<String, Date>();
		
		String keyword = searchJobs.getKeyword();
		String functionalArea = searchJobs.getFunctionalArea();
		String location = searchJobs.getLocation();
		String searchCriterion = searchJobs.getSearchCriteria();
		String jobType =  searchJobs.getJobType();
		String industry = "";
		
		if(searchCriterion.equalsIgnoreCase("jobs"))
		{
			industry = searchJobs.getIndustry();
		}

		int count = 0;
		
		HashMap<String, String> searchParametersMap = new HashMap<String, String>();
		Map<String,String> sessionMap = new HashMap<String,String>();
		if(null!= keyword && !keyword.isEmpty())
		{
			searchParametersMap.put("keyword",keyword);
			sessionMap.put("keyword", keyword);
		}
		if(null!= location && !location.isEmpty())
		{
			searchParametersMap.put("location",location);
			sessionMap.put("location", location);
		}
		if(null!= industry && !industry.isEmpty())
		{
			searchParametersMap.put("industry",industry);
			sessionMap.put("industry", industry);
		}
		if(null!=functionalArea && !functionalArea.isEmpty())
		{
			searchParametersMap.put("functionalArea", functionalArea);
			sessionMap.put("functionalArea", functionalArea);
		}
		if(null!=jobType && !jobType.isEmpty())
		{
			searchParametersMap.put("jobType", jobType);
			sessionMap.put("jobType", jobType);
		}
	
		inputSession.setAttribute("sessionMap", sessionMap);
		//Add all searched parameters into Keyword Master
		String combinationWord = "";
		
		if(searchParametersMap.size() == 1)
		{
			for (Map.Entry<String, String> entry : searchParametersMap.entrySet())
			{
				String searchedKeyword = entry.getValue();
				if( null!= searchedKeyword && searchedKeyword!= ""){
					try {
						
						//Code to avoid stop word insert
						addKeyword(searchedKeyword);
					}
					catch(Exception exception){
						exception.printStackTrace();				
					}
				}
			}
		}
		
		if(searchParametersMap.keySet().contains("keyword") && searchParametersMap.keySet().contains("industry")){
			
			combinationWord = searchParametersMap.get("keyword") +" "+ searchParametersMap.get("industry");
			addKeyword(combinationWord);
		}
		
		if(searchParametersMap.keySet().contains("keyword") && searchParametersMap.keySet().contains("location")){
			
			combinationWord = searchParametersMap.get("keyword") +" "+ searchParametersMap.get("location");
			addKeyword(combinationWord);
		}
		
		if(searchParametersMap.keySet().contains("keyword") && searchParametersMap.keySet().contains("functionalArea")){
	
			combinationWord = searchParametersMap.get("keyword") +" "+ searchParametersMap.get("functionalArea");
			addKeyword(combinationWord);
		}
		
		
	 String SRC_FOLDER = CaerusPathConstants.jobIndexes;
	
	 File indexDir = new File(SRC_FOLDER);
	
	 SimpleDBSearcher simpleDBSearcher = new SimpleDBSearcher();
	 
	 Map<String, Date> savedJobIdsMap = new HashMap<String,Date>();
	 Map<String, Date> savedInternshipIdsMap = new HashMap<String,Date>();
	 
	 try
		{
			jobIdList = simpleDBSearcher.searchIndex(indexDir, searchParametersMap, searchCriterion);
		}catch(FileNotFoundException fnfe){
			logger.error("Indexes not found at "+indexDir);
		}
		catch(Exception exception){
			logger.error("Indexes not found at "+indexDir);
		}

	if(null != jobIdList && jobIdList.size() > 0)
	{
		if(searchParametersMap.keySet().contains("keyword") && searchParametersMap.keySet().contains("location")){
			combinationWord = searchParametersMap.get("keyword") +" in "+ searchParametersMap.get("location");
			studentManager.addToCandidateRecentSearches(combinationWord,emailId,searchCriterion);
		}
		else if(searchParametersMap.keySet().contains("keyword"))
				studentManager.addToCandidateRecentSearches(searchParametersMap.get("keyword"),emailId,searchCriterion);
		else if(searchParametersMap.keySet().contains("location"))
				studentManager.addToCandidateRecentSearches(searchParametersMap.get("location"),emailId,searchCriterion);
	}
	 
	if(searchCriterion.equalsIgnoreCase("jobs")){
			    //Get the jobs applied by the candidate
				if(emailId!= null && !emailId.isEmpty())
				{
					/*appliedJobIdMap = studentJobsManager.getAppliedJobIdsMap(emailId);*/
				
					/*if(appliedJobIdMap!=null && appliedJobIdMap.size() !=0)
					{
						for (String appliedJobId : appliedJobIdMap.keySet()) {
							
							jobIdList.remove(appliedJobId);
						}
					}*/
					
					jobIdList.removeAll(studentJobsManager.getAppliedJobIds(emailId));
					
					/*savedJobIdsMap = studentJobsManager.getSavedJobIdsMap(emailId);
					savedInternshipIdsMap = studentJobsManager.getSavedInternshipIdsMap(emailId);*/
					
				}
	// Retrieving the searched job details from the database
	searchCriterion = "Jobs";
	searchedJobsDetails = studentJobsManager.getJobDetails(jobIdList);
	}
	

	// Candidate Browse jobs section
	Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
	resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, emailId);
	model.addAttribute("resultCountMap", resultCountMap);
	

	 if(searchCriterion.equalsIgnoreCase("internships")){
		//Get the internships applied by the candidate
			if(emailId!= null && !emailId.isEmpty())
			{
				jobIdList.removeAll(studentJobsManager.getAppliedInternshipIds(emailId));
				
				/*appliedInternshipIdMap = studentJobsManager.getAppliedInternshipIdsMap(emailId);
			
				if(appliedInternshipIdMap!=null && appliedInternshipIdMap.size()!=0)
				{
					for (String appliedInternshipId : appliedInternshipIdMap.keySet()) {
						
						jobIdList.remove(appliedInternshipId);
					}
				}*/
			}
		 // Retrieving the searched internship details from the database
		 searchCriterion = "Internships";
		 searchedJobsDetails = studentJobsManager.getInternshipDetails(jobIdList);
		 
	
	 }
	
	 if (!(searchedJobsDetails == null)) {
			
			count = searchedJobsDetails.size();
			
			sortedSearchedJobsDetails = CaerusCommonUtility.sortListByDateReverse(searchedJobsDetails, "JobDetailsDom");
		}

		//Retrieving Industry List
	    List<String> industryList =  masterManager.getIndustries();
	 	
		//Retrieving Functional Area List
	    List<String> functionalAreaList = masterManager.getFunctionalAreas();
		
		Collections.sort(industryList);
		Collections.sort(functionalAreaList);
		
		// Adding values to the modelAndView object
		model.addAttribute("count", count);
		model.addAttribute("searchJobs",sortedSearchedJobsDetails);
		model.addAttribute("criteria", searchCriterion);
		model.addAttribute("industryList", industryList);
		model.addAttribute("functionalAreaList", functionalAreaList);
		model.addAttribute("searchJobsCommand",  getSearchJobs());
		model.addAttribute("searchParametersMap",searchParametersMap);
		
		model.addAttribute("savedJobIdsMap", savedJobIdsMap);
		model.addAttribute("savedInternshipIdsMap", savedInternshipIdsMap);
		
		
		String action = request.getParameter("action");
		JobDetailsDom saveSearchJobs = new JobDetailsDom();
		BeanUtils.copyProperties(searchJobs, saveSearchJobs);
			
		if (action != null && action.equalsIgnoreCase("saveSearch")) 
		{
			 keyword = searchJobs.getKeyword();
			
			//Saving a search
			studentJobsManager.saveSearchJobs(saveSearchJobs, emailId);
			
			String criterion = searchJobs.getSearchCriteria();
			
			model.addAttribute("criteria", criterion);
			
			logger.info(CaerusLoggerConstants.SAVE_SEARCH);
		}
	
		return "candidate/candidate_job_listing";
	}

	/**
	 * This method is used to get Advanced Search Page
	 * @param request
	 * @param searchJobs
	 * @param model
	 * @param bindingResult
	 * @return candidate_advance_search
	 * @throws Exception
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_SEARCH_JOBS_INTERNSHIPS, method=RequestMethod.GET)
	protected String getSearchParameters(HttpServletRequest request , @ModelAttribute("searchJobs") JobDetailsCom searchJobs , Model model, BindingResult bindingResult)throws Exception 
	{
		//Retrieving Industry List
	    List<String> industries =  masterManager.getIndustries();
	 	
		//Retrieving Functional Area List
	    List<String> functionalAreas = masterManager.getFunctionalAreas();
		
	    if(null != functionalAreas && functionalAreas.size() > 0)
	    	Collections.sort(functionalAreas);
	    
	    if(null != industries && industries.size() > 0)
	    	Collections.sort(industries);

		model.addAttribute("industryList", industries);
		model.addAttribute("functionalAreaList",functionalAreas);
		model.addAttribute("searchJobs", getSearchJobs());
		
		return "candidate/candidate_advance_search";
		
		
	}
	
	/**
	 * This method is used to retrieve saved searches
	 * @param request
	 * @param response
	 * @param searchJobs
	 * @return ModelAndView (candidate_saved_searches)
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_SAVED_SEARCHES)
	public ModelAndView returnSavedSearches(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchJobsCommand") JobDetailsCom searchJobs)
	{
		/**Spring security authentication containing the logged in user details*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailID = auth.getName();

		logger.info(CaerusLoggerConstants.SAVED_SEARCHES);

		/** The modelAndView object contains the model(savedSearchList) and the view(candidate_saved_search_new)*/
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_saved_searches");

		/** Retrieving Saved Search List*/
		List<JobDetailsDom> savedSearches = studentJobsManager.getSavedSearches(emailID);

		int savedSearchCount = 0;

		if (savedSearches != null && savedSearches.size() > 0)
		{
			savedSearchCount = savedSearches.size();
			//savedSearches = CaerusCommonUtility.sortListByDateReverse(savedSearches, "JobDetailsDom");
			
			Collections.sort(savedSearches, new Comparator<JobDetailsDom>(){
				public int compare(JobDetailsDom o1, JobDetailsDom o2) {

					Date d1 = o1.getSavedSearchOn();
					  Date d2 = o2.getSavedSearchOn();
					  
					  int compareValue = 0;
					  
					  if(null != d1 && null != d2)
						 compareValue = d2.compareTo(d1);
					  
					  return compareValue;
				  }
			});
		
		
		}
		
		modelAndView.addObject("savedSearches", savedSearches);
		modelAndView.addObject("count", savedSearchCount);

		return modelAndView;
	}
	
	
	/**
	 * This method is used to Delete a Saved Search
	 * @param request
	 * @param response
	 * @return ModelAndView (candidate_saved_searches)
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_DELETE_SAVED_SEARCHES)
	public ModelAndView deleteSavedSearch(HttpServletRequest request,
			HttpServletResponse response)  {

		
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_saved_searches");
		
		/** Retrieving Request Parameter */
		String searchParameterName = request.getParameter("searchParameterName");
		
		/**Spring security authentication containing the logged in user details*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailID = auth.getName();
		int savedSearchListCount = 0;

		/** Deleting the selected Saved Search */
		studentJobsManager.deleteSavedSearchJob(emailID, searchParameterName);
		logger.info(CaerusLoggerConstants.DELETE_SAVED_SEARCH);

		
		/** Retrieving the List of saved searches */
		List<JobDetailsDom> savedSearchList = studentJobsManager.getSavedSearches(emailID);

		if (!savedSearchList.isEmpty() || savedSearchList != null) {
			savedSearchListCount = savedSearchList.size();

		}

		modelAndView.addObject("count", savedSearchListCount);
		modelAndView.addObject("searchjobs", savedSearchList);
		
		return modelAndView;
	}
	
	/**
	 * This method is used to add a keyword in database
	 * @param searchedKeyword
	 */
	public void addKeyword (String searchedKeyword){
		Pattern stopWords = Pattern.compile("\\b(?:i|a|an|and|are|as|at|be|but|by|for|if|in|into|into|no|not|of|on|or|such|that|the|their|then|there|to|was|will|with)\\b\\s*", Pattern.CASE_INSENSITIVE);
		if (!searchedKeyword.contains(" "))
			
		{
			Matcher matcher = stopWords.matcher(searchedKeyword);
			searchedKeyword= matcher.replaceAll(" ");
	    	if(searchedKeyword.length()!=0)
			studentManager.addSearchedKeywords(searchedKeyword,true);
		}
		
		else{
			studentManager.addSearchedKeywords(searchedKeyword,true);
			Matcher matcher = stopWords.matcher(searchedKeyword);
			searchedKeyword= matcher.replaceAll("");
			//First keyword group after stop word remove
			//if(searchKeyword.length()!=0)
			//studentManager.addSearchedKeywords(searchKeyword);
			
			//To insert individual words
			String[] searchKeywords = searchedKeyword.split(" ");
								
			for(String word: searchKeywords)
			studentManager.addSearchedKeywords(word,false);
		
		}
		
	}
	
}
