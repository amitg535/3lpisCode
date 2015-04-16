package caerusapp.web.employer;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.suggest.Lookup.LookupResult;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.lucene.indexing.AutoSuggest;
import caerusapp.lucene.indexing.EmployerSearchCandidateLucene;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CandidateCommonFeature;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Iterables;

/**
 * 
 * @author RavishaG
 *
 */

@Controller
public class EmployerSearchCandidateController {

		//Auto-wiring service component
		@Autowired
		private IEmployerManager employerManager;
		@Autowired
		private IStudentManager studentManager;
		@Autowired
		private IMasterManager masterManager;
		
		//Logger for this class and subclasses
		protected final Log logger = LogFactory.getLog(getClass());

		File indexDirectory = new File(CaerusPathConstants.studentIndexes);
		File jobIndexes = new File(CaerusPathConstants.jobIndexes);
		
		@ModelAttribute("jobDetailsCom")
		JobDetailsCom getJobDetailsComObject()
		{
			return new JobDetailsCom();
		}
		
		/**
		 * This method is used to load the employer search page
		 * @param model
		 * @return String
		 * @throws IOException 
		 * @throws ParseException 
		 */
		@SuppressWarnings("unchecked")
		@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SEARCH_CANDIDATE, method = RequestMethod.GET)
		public String loadPage(Model model, HttpServletRequest httpServletRequest) throws ParseException, IOException
		{
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailId = auth.getName();
			
			//Fetching the logged in company name from session
			HttpSession session = httpServletRequest.getSession();
			String firmName = (String) session.getAttribute("compName");
			
			//Fetching candidate's recent searches
			Map<Date, String> recentSearches = employerManager.getEmployerRecentSearches(emailId);
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			Map<String,Integer> recentSearchesMap = new HashMap<String,Integer>();
			
			recentSearches = CaerusCommonUtil.sortMapOnKeyInDescendingOder(recentSearches);
			int i = 0;
			
			for (Entry<Date, String> recentSearchEntry : recentSearches.entrySet()) 
			{
				if(i < 5)
				{
					JobDetailsCom jobDetailsCom = new JobDetailsCom();
					jobDetailsCom.setKeyword(recentSearchEntry.getValue());
					
					try 
					{
						// Get new candidates from the time the search was made to current date
						candidateList = getCandidatesLucene(jobDetailsCom,"",httpServletRequest,recentSearchEntry.getKey());
						
						if(null != recentSearchesMap && recentSearchesMap.containsKey(recentSearchEntry.getValue()))
							i--;
						
						recentSearchesMap.put(recentSearchEntry.getValue(), candidateList.size());
						i++;
						
					} 
					catch (ServletException | IOException e) 
					{
						e.printStackTrace();
					} 
					
				}
				
				else
					break;
			}
				
			if(null != recentSearchesMap)
				model.addAttribute("recentSearches",recentSearchesMap);
			
			
			// Fetch profiles of candidates recently visited by employer
			List<String> visitedProfiles = employerManager.getRecentVisitedProfiles(firmName,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_VIEWED_PROFILE);
			if(null != visitedProfiles && visitedProfiles.size() > 0)
			{
				LinkedHashSet<String> uniqueVisitedProfiles = new LinkedHashSet<String>(visitedProfiles);
				List<String> uniqueVisitedProfileList = new ArrayList<String>();
				
				// Getting 5 recent candidates
				if(uniqueVisitedProfiles.size() > 5)
					uniqueVisitedProfileList = new ArrayList<String>(ImmutableSet.copyOf(Iterables.limit(uniqueVisitedProfiles, 5)));
				else
					uniqueVisitedProfileList = new ArrayList<String>(uniqueVisitedProfiles);
					
				if(null != uniqueVisitedProfileList && uniqueVisitedProfileList.size() > 0)
				{
					// Fetch candidate details
					List<StudentDom> visitedProfilesMap = studentManager.getCandidateDetails(new ArrayList<>(uniqueVisitedProfileList));
					
					if(null != visitedProfilesMap && visitedProfilesMap.size() > 0)
						model.addAttribute("visitedProfilesMap", visitedProfilesMap);
				}
			}
			
			String industry = "";
			
			// Getting the industry type for company
			if(null != firmName && !firmName.equals(""))
				industry = employerManager.getCompanyIndustryType(firmName);
			
			if(null != industry && !industry.equals(""))
			{
				// Fetch jobs posted by companies having same industry type
				Map<String,Map<String,String>> popularJobs = SimpleDBSearcher.fetchPopularJobsOfSameIndustry(industry, jobIndexes);
				
				if(null != popularJobs && popularJobs.size() > 0)
				{
					ConcurrentHashMap<String,Map<String,String>> popularJobsConcurrent = new ConcurrentHashMap<String,Map<String,String>>();
					popularJobsConcurrent.putAll(popularJobs);
					
					Iterator<String> itr = popularJobsConcurrent.keySet().iterator();
					
					// Remove jobs posted by the same company
					while(itr.hasNext()){
						String popularJobKey = itr.next();
						Map<String,String> popularJob = popularJobsConcurrent.get(popularJobKey);
						
						if(popularJob.containsKey(firmName))
							popularJobs.remove(popularJobKey);
					}
					
					Map<String,String> popularJobMap = new HashMap<String,String>();
					
					for (Entry<String,Map<String,String>> popularJob : popularJobs.entrySet()) {
						popularJobMap.put(popularJob.getKey(), popularJob.getValue().values().toString().replace("[", "").replace("]", ""));
					}
					
					// Sort map on the count on job Titles
					Map<String,Integer> sortedMap = CollectionUtils.getCardinalityMap(popularJobMap.values());
					sortedMap = CaerusCommonUtil.sortMapOnValues(sortedMap);
					
					List<String> popularJobsList = new ArrayList<String>(sortedMap.keySet());
					if(null != popularJobsList && popularJobsList.size() > 0)
					{
						// Send 20 most popular posted jobs to the jsp page
						if(popularJobsList.size() > 20)
							model.addAttribute("popularJobs", popularJobsList.subList(0, 20));
						else
							model.addAttribute("popularJobs", popularJobsList);
					}
				}
			}
			
			// Fetch all companies belonging to same industry
			List<String> companyNames = employerManager.getCompaniesOfSameIndustry(industry);
			companyNames.remove(firmName);
			
			// Fetch recently visited profiles along with the count
			Map<String,Map<String,Integer>> trendingProfiles = employerManager.getRecentVisitedProfiles(companyNames,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_VIEWED_PROFILE);
			Map<String,Integer> trendingProfilesMap = new HashMap<String,Integer>();
			
			for (Entry<String,Map<String,Integer>> entrySet : trendingProfiles.entrySet()) {
				int viewedProfileCount = 0;
				if(null != entrySet.getValue().get("viewed profile"))
					viewedProfileCount = entrySet.getValue().get("viewed profile");
				
				trendingProfilesMap.put(entrySet.getKey(),viewedProfileCount);
			}

			// sort map on count of views
			trendingProfilesMap = CaerusCommonUtil.sortMapOnValues(trendingProfilesMap);
			
			if(null != trendingProfilesMap.keySet() && trendingProfilesMap.keySet().size() > 0)
			{
				// Fetch candidate details
				List<StudentDom> candidateDetails = studentManager.getCandidateDetails(new ArrayList<>(trendingProfilesMap.keySet()));
				
				if(null != candidateDetails && candidateDetails.size() > 0)
					model.addAttribute("candidateDetails", candidateDetails);
			}
			
			//Retrieving the list of saved searches
			List<JobDetailsDom> searchList = employerManager.getSavedSearches(emailId);
				model.addAttribute("savedSearchSize", searchList.size());
				
			List<String> stateList = masterManager.getStates();
			model.addAttribute("stateList", stateList);
			
			List<String> universityList = masterManager.getUniversities();
			model.addAttribute("universityList", universityList);
			
			model.addAttribute("jobDetailsCom", getJobDetailsComObject());
			return CaerusJSPMapper.EMPLOYER_ADVANCE_SEARCH;
		}
		
		/**
		 * This method is used to get candidates listing
		 * @param jobDetailsCom
		 * @param bindingResult
		 * @param httpServletRequest
		 * @return ModelAndView
		 */
		@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SEARCH_CANDIDATE, method = RequestMethod.POST)
		public ModelAndView searchCandidates(@ModelAttribute("jobDetailsCom") JobDetailsCom jobDetailsCom, BindingResult bindingResult, HttpServletRequest httpServletRequest)
		{
			//Logger for this class and subclasses
			logger.info(CaerusLoggerConstants.GET_CANDIDATES);
			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailId = auth.getName();
			
			//Fetching the logged in company name from session
			HttpSession session = httpServletRequest.getSession();
			String firmName = (String) session.getAttribute("compName");
			
			String keyword = jobDetailsCom.getKeyword();
			
			if(!keyword.equals(""))
			{
				employerManager.updateEmployerSearchHistory(keyword,emailId);
			}
			
			//The modelAndView object contains the model(data) and the view(page)
			ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.EMPLOYER_CANDIDATE_LISTING);
			
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			
			if(httpServletRequest.getParameter("source") != null && httpServletRequest.getParameter("source").equals("savedSearches"))
			{
				modelAndView.addObject("source","savedSearches");
			}
			
			try 
			{
				candidateList = getCandidatesLucene(jobDetailsCom,"",httpServletRequest,null);
			} 
			catch (ServletException e) 
			{
				e.printStackTrace();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			 
			List<String> sortParameters = new ArrayList<String>();
			sortParameters.add("Recent");
			sortParameters.add("Relevance");
			sortParameters.add("Popular");
			sortParameters.add("Age");
			
			//Adding objects to model to retrieve details on jsp
			modelAndView.addObject("sortParameters",sortParameters);
			
			List<StudentDom> studentList = new ArrayList<StudentDom>();
			String combinationWord = "";
			
			if(null!= candidateList && candidateList.size() > 0)
			{
				if(null !=jobDetailsCom.getKeyword() && !jobDetailsCom.getKeyword().equals("") && null != jobDetailsCom.getLocation() && !jobDetailsCom.getLocation().equals("")){
					combinationWord = jobDetailsCom.getKeyword() +" in "+jobDetailsCom.getLocation();
					employerManager.addToEmployerRecentSearches(combinationWord,emailId,firmName);
				}
				else if(null != jobDetailsCom.getKeyword() && !jobDetailsCom.getKeyword().equals(""))
					employerManager.addToEmployerRecentSearches(jobDetailsCom.getKeyword(),emailId,firmName);
				else if(null != jobDetailsCom.getLocation() && !jobDetailsCom.getLocation().equals(""))
					employerManager.addToEmployerRecentSearches(jobDetailsCom.getLocation(),emailId,firmName);
				
				modelAndView.addObject("count",candidateList.size());
				
				for (StudentDom studentDetails : candidateList) 
				{
					if( null != studentDetails.getUniversityMap() && studentDetails.getUniversityMap().size() > 0)
					{	
						List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
						if(universityDetailsList.size() != 0)
						{
							if(universityDetailsList != null && universityDetailsList.size() > 1)
							{
								studentDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
							}
							else
							{
								studentDetails.setUniversityDetails(universityDetailsList.get(0));
							}
						}
						else{
							studentDetails.setUniversityDetails(new PortfolioDetailsDom());
						}
						studentList.add(studentDetails);
					}
				}
			}
			
			modelAndView.addObject("studentList", studentList);
			modelAndView.addObject("keyword", jobDetailsCom.getKeyword());
			modelAndView.addObject("city", jobDetailsCom.getLocation());
			modelAndView.addObject("universityName", jobDetailsCom.getUniversityName());
			modelAndView.addObject("state", jobDetailsCom.getState());
			
			List<String> stateList = masterManager.getStates();
			modelAndView.addObject("stateList", stateList);
			
			List<String> universityList = masterManager.getUniversities();
			modelAndView.addObject("universityList", universityList);
			
			return modelAndView;
		
		}

		/**
		 * This method is used to find candidates using lucene indexes
		 * @param jobDetailsCom
		 * @param sortedParameter
		 * @param request
		 * @return list
		 * @throws ServletException
		 * @throws IOException
		 */
		public List<StudentDom> getCandidatesLucene(JobDetailsCom jobDetailsCom,String sortedParameter,HttpServletRequest request, Date lastDate) throws ServletException, IOException
		{
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailID = auth.getName();
			
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			Map<String,String> luceneParametersMap = new HashMap<String,String>();
			List<StudentDom> candidateLuceneResults= new ArrayList<StudentDom>();
			
			String keyword = jobDetailsCom.getKeyword();
			
			String city = jobDetailsCom.getLocation();
			
			String universityName = jobDetailsCom.getUniversityName();
			
			String state = jobDetailsCom.getState();
	
			String studentEmailId = request.getParameter("emailId");
			
			if( keyword !=null && !keyword.isEmpty())
				luceneParametersMap.put("keySkills", keyword);
			
			if(city!= null && !city.isEmpty())
				luceneParametersMap.put("city", city);
			
			if(universityName!= null && !universityName.isEmpty())
				luceneParametersMap.put("universityName", universityName);
			
			if(state!= null && !state.isEmpty())
				luceneParametersMap.put("state", state);
			
			if(null!=sortedParameter && !sortedParameter.isEmpty())
				luceneParametersMap.put("sortedParameter",sortedParameter);
			
			try 
			{
				candidateLuceneResults = EmployerSearchCandidateLucene.searchIndex(indexDirectory, luceneParametersMap,lastDate);
			} 
			
			
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			
			
			for (StudentDom candidateDetails : candidateLuceneResults) {
		
					boolean flag = studentManager.isSavedCandidate(candidateDetails.getEmailID(),emailID);
					
					if(flag == true)
					{
						candidateDetails.setSavedCandidate(true);
					}
					
					if(studentEmailId != null)
					{
						if(candidateDetails.getEmailID().equals(studentEmailId))
						{
							studentManager.incrementVideoProfileViews(studentEmailId,candidateDetails.getViewVideoProfileCount());
						}
					}
					
					candidateList.add(candidateDetails);		
				
			}
			
			return candidateList;

		}
	
		/**
		 * This method is used to save a search parameter
		 * @param jobDetailsCom
		 * @param bindingResult
		 * @param httpServletRequest
		 * @return ModelAndView
		 */
		@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_SAVE_SEARCH)
		public ModelAndView saveSearchParameter(@ModelAttribute("jobDetailsCom") JobDetailsCom jobDetailsCom, BindingResult bindingResult, HttpServletRequest httpServletRequest)
		{
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailId = auth.getName();
			
			//The modelAndView object contains the model(data) and the view(page)
			ModelAndView modelAndView = new ModelAndView("employer/employer_candidate_listing");
			
			JobDetailsDom jobDetailsDom = new JobDetailsDom();
			
			if(jobDetailsCom != null)
			{
				BeanUtils.copyProperties(jobDetailsCom, jobDetailsDom);
			}
			
			jobDetailsDom.setEmailId(emailId);
			
			employerManager.saveSearchParameter(jobDetailsDom);
			
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			
			try 
			{
				candidateList= getCandidatesLucene(jobDetailsCom,"",httpServletRequest,null);
			} 
			catch (ServletException e) 
			{
				e.printStackTrace();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			
			List<StudentDom> studentList = new ArrayList<StudentDom>();
			
			if(null!= candidateList && !candidateList.isEmpty() )
			{
				modelAndView.addObject("count",candidateList.size());
				
				for (StudentDom studentDetails : candidateList) 
				{
					List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
					if(universityDetailsList.size() != 0)
					{
						if(universityDetailsList != null && universityDetailsList.size() > 1)
						{
							studentDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
						}
						else
						{
							studentDetails.setUniversityDetails(universityDetailsList.get(0));
						}
					}
					studentList.add(studentDetails);
				}
			}
			
			modelAndView.addObject("studentList", candidateList);
			
			List<String> sortParameters = new ArrayList<String>();
			sortParameters.add("Recent");
			sortParameters.add("Relevance");
			sortParameters.add("Popular");
			sortParameters.add("Age");
			
			//Adding objects to model to retrieve details on jsp
			modelAndView.addObject("sortParameters",sortParameters);
			
			return modelAndView;
		}
		
		/**
		 * This method is used to sort candidates by sort parameters
		 * @param jobDetailsCom
		 * @param sortedParameter
		 * @param request
		 * @return list
		 * @throws ServletException
		 * @throws IOException
		 */
		@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_SORTED_SEARCH_LISTING)
		@ResponseBody
		public List<StudentDom> getSortedCandidatesLucene(@RequestBody JobDetailsCom jobDetailsCom,HttpServletRequest request) throws ServletException, IOException
		{
			List<StudentDom> candidateResults =	getCandidatesLucene(jobDetailsCom,jobDetailsCom.getSortedParameter(),request,null);
			return candidateResults;
		}
		
		/**
		 * This method is used to find candidates for an employer's saved search
		 * @param parameterName
		 * @param httpServletRequest
		 * @param httpServletResponse
		 * @return ModelAndView
		 */
		@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SAVED_SEARCH_CANDIDATES)
		public ModelAndView viewSavedSearchCandidates(@RequestParam("searchParameterName") String parameterName, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
		{
			//Logger for this class and subclasses
			logger.info(CaerusLoggerConstants.SAVED_CANDIDATES);
			
			//Spring security authentication containing the logged in user details
			Authentication authentication=SecurityContextHolder.getContext().getAuthentication();
			
			//The modelAndView object contains the model(data) and the view(page)
			ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.EMPLOYER_CANDIDATE_LISTING);
			
			String emailId=authentication.getName();//Logged in User Email ID
			
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			
			JobDetailsDom jobDetailsDom = employerManager.getParametersOfSavedSearch(parameterName,emailId);
			
			JobDetailsCom jobDetailsCom = new JobDetailsCom();
			
			BeanUtils.copyProperties(jobDetailsDom, jobDetailsCom);
			
			try 
			{
				candidateList = getCandidatesLucene(jobDetailsCom, "", httpServletRequest,null);
			} 
			catch (ServletException e)
			{
				e.printStackTrace();
			} 
			catch (IOException e)
			{
				e.printStackTrace();
			}
			
			List<StudentDom> studentList = new ArrayList<StudentDom>();
			
			if(null!= candidateList && !candidateList.isEmpty() )
			{
				modelAndView.addObject("count",candidateList.size());
				
				for (StudentDom studentDetails : candidateList) 
				{
					List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
					if(universityDetailsList.size() != 0)
					{
						if(universityDetailsList != null && universityDetailsList.size() > 1)
						{
							studentDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
						}
						else
						{
							studentDetails.setUniversityDetails(universityDetailsList.get(0));
						}
					}
					studentList.add(studentDetails);
				}
			}
			modelAndView.addObject("studentList", studentList);
			
			List<String> sortParameters = new ArrayList<String>();
			sortParameters.add("Recent");
			sortParameters.add("Relevance");
			sortParameters.add("Popular");
			sortParameters.add("Age");
			
			modelAndView.addObject("keyword", jobDetailsCom.getKeyword());
			modelAndView.addObject("city", jobDetailsCom.getLocation());
			modelAndView.addObject("universityName", jobDetailsCom.getUniversityName());
			modelAndView.addObject("state", jobDetailsCom.getState());
			
			//Adding objects to model to retrieve details on jsp
			modelAndView.addObject("sortParameters",sortParameters);
			
			return modelAndView;
	        	
		}
		
		/**
		 * This method is used 
		 * @param enteredText
		 * @return List<String>
		 */
		 @RequestMapping(value=CaerusAnnotationURLConstants.GET_EMPLOYER_KEYWORD_SUGGESTIONS)
		 @ResponseBody
		 public List<String> returnSuggestedWords(@RequestParam("enteredText") String enteredText )
		 {
			 List<String> returnedWords=new ArrayList<String>();
			 
			 try{
				 
				 //Fetching keyword suggestions for the entered text by User
				 List<LookupResult>suggestedWords=AutoSuggest.suggestSkills(enteredText, true);
				 
				 String word="";
				 //List of LookUpResult to List of String Conversion
				 if(null != suggestedWords && suggestedWords.size()!=0)
				 {
					 for(int i=0; i<suggestedWords.size();i++)
					 {
						 word=suggestedWords.get(i).key.toString();
						 //Removing Unwanted Character Sequence Returned by Lucene (Highlighted Text)
						 word=word.replaceAll("<b>", "");
						 word=word.replaceAll("</b>", "");
						 returnedWords.add(word);
					 }
				 }
				
			 }
			 catch(Exception e)
			 {
				 e.printStackTrace();
			 }
			
			 return returnedWords;	 
		 }
		
}
