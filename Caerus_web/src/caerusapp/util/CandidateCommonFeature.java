package caerusapp.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.UpcomingEventsDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;

/**
 * This class consists of candidate features common to the welcome and dashboard page
 * @author BalajiI,TrishnaR
 *
 */
public class CandidateCommonFeature 
{
	
	Log logger = LogFactory.getLog(getClass());
	
    /**
     * This method is used to fetch list of virtual jobfairs 
     * @author BalajiI,TrishnaR
     * @param candidateEmailId
     * @param virtualFairManager
     * @return
     */
    /*public  List<VirtualFairDom> getVirtualFairList(String candidateEmailId,VirtualFairManager virtualFairManager)
    {
	 List<VirtualFairDom> virtualFairList=new ArrayList<VirtualFairDom>();
	 
	 // Retrieving list of virtual jobfairs for a student
	 virtualFairList=virtualFairManager.getVirtualFairDetail(candidateEmailId);
	 
	 return virtualFairList;
    }*/
    
    
    
    /**
     * This method is used to fetch recommended jobs for a student
     * @author BalajiI,TrishnaR
     * @param searchedJobsDetails
     * @param studentJobsManager
     * @param emailId
     * @return
     */
    /*public List<JobDetailsDom> getRecommendedJobs(List<JobDetailsDom> searchedJobsDetails,StudentJobsManager studentJobsManager,String emailId )
    {

    	// Retrieving list of recommended jobs
		List<JobDetailsDom> recommendedJobsList = new ArrayList<JobDetailsDom>(searchedJobsDetails);
		
		Map<String, JobDetailsDom> map = new LinkedHashMap<String, JobDetailsDom>();
		
		// Iterating through list of recommended jobs
		for (JobDetailsDom recommendedJobDetails : recommendedJobsList)
		{
			map.put(recommendedJobDetails.getJobIdAndFirmId(), recommendedJobDetails);
		}
		
		recommendedJobsList.clear();
		recommendedJobsList.addAll(map.values());
		List<String> recommendedJobIdList= new ArrayList<String>();
		
			// Iterating through list of recommended jobs
	    	for(JobDetailsDom recomendedJob : recommendedJobsList)
	    	{
	    		recommendedJobIdList.add(recomendedJob.getJobIdAndFirmId());
	    	}
	    	
	    // Retrieving list of applied jobs
		List<JobDetailsDom> AppliedJobsList = studentJobsManager.getAppliedJob(emailId);
		List<String> appliedJobIdList= new ArrayList<String>();
		
		 Removing Applide Jobs From Recommended Jobs 
		if(AppliedJobsList!=null)
		{
				// Iterating through list of applied jobs 
	        	for(JobDetailsDom appliedJobs : AppliedJobsList)
	        	{
	        		
	        		appliedJobIdList.add(appliedJobs.getJobIdAndFirmId());
	        	}
		}
		recommendedJobIdList.removeAll(appliedJobIdList);
		 Removing Applide Jobs From Recommended Jobs 
		
		String ids = "";
		String idList = "" ;
		
		if(recommendedJobIdList.size()!=0)
		{
			Iterator<String> recommendedJob = recommendedJobIdList.iterator();
			// Iterating through recommended Jobs
			while (recommendedJob.hasNext())
			{
				String individualId = recommendedJob.next();
				ids+="'" + individualId + "'" + ",";
			}
					
			idList = ids.substring(0, ids.length()-1);
			recommendedJobsList.clear();
			 Fetching The Recommended Jobs
			recommendedJobsList=studentJobsManager.getSearchdJobDetails(idList);
			 Fetching The Recommended Jobs
		}
		else
		{
			recommendedJobsList.clear();
		}				    
	
		List<String> savedJobIdList = studentJobsManager.getSavedJobIds(emailId);
		
		if(null!=savedJobIdList)
		{
			for (String savedJobId : savedJobIdList)
			{
				if(! recommendedJobIdList.isEmpty())
				{
					for (String recommendedJobId : recommendedJobIdList)
					{
						if(savedJobId.equalsIgnoreCase(recommendedJobId))
						{
							
							for (JobDetailsDom recommendedJobDetails : recommendedJobsList) 
							{
								 Setting the Saved Flag in Recommended Jobs
								if(recommendedJobDetails.getJobIdAndFirmId().equals(savedJobId))
								{
									recommendedJobDetails.setSavedFlag("true");
								}
								Setting the Saved Flag in Recommended Jobs
							}
						}
					}
				}
			}
		}
		
		
		return recommendedJobsList;

    }*/
    
        /**
         * This method is used to fetch the count of applied jobs
         * @author BalajiI,TrishnaR
         * @param studentJobsManager
         * @param emailID
         * @return
         */
    	/*public int getAppliedJobCount(StudentJobsManager studentJobsManager,String emailID)
		{	
		    int appliedJobCount=0;
		    int appliedFlag = 0;
		    
		    // Exception handling
		    try
			    {
		    	
		    		// Retrieving list of applied jobs
				    List<JobDetailsDom> appliedJobList = studentJobsManager.getAppliedJob(emailID); 
				    List<JobDetailsDom> recentAppliedJobList = new ArrayList<JobDetailsDom>();
				    JobDetailsDom appliedJobDtls = null;
				    
				    Added by RavishaG 
					// Finding applied jobs for candidate within 30 days of current date
					Calendar calendar = Calendar.getInstance();
			    	calendar.setTime(new Date());
			    	calendar.add(Calendar.DAY_OF_YEAR, - 30);
			    	Date thirtyDaysBack = calendar.getTime();
				    
				    if(appliedJobList!=null)
				    {
				    	for (JobDetailsDom studentSearchJobs : appliedJobList) {
				    		
				    		String jobId = studentSearchJobs.getJobIdAndFirmId();
				    		
				    		 appliedFlag = studentJobsManager.getAppliedJobFlag(emailID,jobId);
				    		 
				    		 if(appliedFlag!=0)
							  {
							   appliedJobDtls = studentJobsManager.getAppliedJobDtls(emailID,jobId);
							   studentSearchJobs.setApplied_on(appliedJobDtls.getApplied_on());
							   
							   Date appliedOnDate = studentSearchJobs.getApplied_on();
								 
								if(appliedOnDate.compareTo(thirtyDaysBack) > 0)
								{
									recentAppliedJobList.add(studentSearchJobs);
								}
							  
							  }
							
						}
				 
				    	
				    	appliedJobCount = recentAppliedJobList.size();
				 	
				    }
			    }
			    catch(NullPointerException exception)
			    {
			    	
			    }
		    return appliedJobCount;

		} */

    	/**
    	 * This method is used to fetch virtual job fair details 
    	 * @param virtualFairList
    	 * @param virtualFairManager
    	 * @return
    	 */
		/*public List<VirtualFairDom> getVirtualFairDetails(List<VirtualFairDom> virtualFairList,VirtualFairManager virtualFairManager) 
		{
		   List<VirtualFairDom> virtualFairDomList=new ArrayList<VirtualFairDom>();
		   
		   // Iterating through virtual Jobfair event list
		    for(VirtualFairDom virtualFairDom:virtualFairList)
			{
				
			  VirtualFairDom virtualFairDetails = virtualFairManager.getVirtualFairEventDetails(virtualFairDom.getVirtualJobId());
			  
			  if(null!=virtualFairDetails.getVirtualJobId())
			  {
				  // Count of companies which have accepted the Jobfair
			      int acceptedCount = virtualFairManager.getAcceptedCompanyCount(virtualFairDom.getVirtualJobId());
			      
			      // count of students going for the virtual Jobfair
			      int studentCount = virtualFairManager.getStudentsCount(virtualFairDom.getVirtualJobId());
			      
			      
			      virtualFairDetails.setAcceptedCompanyCount(acceptedCount);
			      virtualFairDetails.setInvitedStudentsCount(studentCount);
			      virtualFairDomList.add(virtualFairDetails);
			  }
	
			 
			}
		    
		   return virtualFairDomList; 
		}*/
		
		/**
		 * This method is used to fetch the recent activities performed by a student
		 * @author BalajiI,TrishnaR
		 * @param studentManager
		 * @param emailID
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public static Map<String,Object> getRecentActivitiesMap(IStudentManager studentManager,String emailID)
		{
		    
			Map<String,Object> recentActivitiesMap = new HashMap<String, Object>();
			Map<String,Object> recentActivitiesMapSorted = new HashMap<String, Object>();
			Map<String,Object> recentActivitiesSubMapSorted = new HashMap<String, Object>();
			
			// Retrieving recent activities of a student
			recentActivitiesMap = studentManager.getRecentActivities(emailID);
			if(recentActivitiesMap!=null)
			{
				// sorting the map in descending order of timestamp
				recentActivitiesMapSorted = CaerusCommonUtility.sortMapOnValues(recentActivitiesMap);
			
				int i=0;
				
				// Selecting the recent 10 values from recent activities
				for(Map.Entry<String,Object> entry : recentActivitiesMapSorted.entrySet()) 
				{
				    if(i >= 0 && i < 5) 
				    {
				    	recentActivitiesSubMapSorted.put(entry.getKey(), entry.getValue());	
				    }
				    i++;
		        
				}
		    
				recentActivitiesSubMapSorted = CaerusCommonUtility.sortMapOnValues(recentActivitiesSubMapSorted);
		    
			}
			return recentActivitiesSubMapSorted;
		}	
		
		
		/**
		 * @author RavishaG
		 * This method is used to find out upcoming events for candidates
		 * @param eventDetailsList
		 * @return List
		 * @throws ParseException
		 */
		public static List getUpcomingEventList(List eventDetailsList, String className) throws ParseException
		{	
			List upcomingEventsList = new ArrayList();
			
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	        Date date = new Date();
	        String current = dateFormat.format(date);
	        long diffDays = 0 ;
	        long diffDays1 = 0 ;
	         
	        Date currentDate = (Date)dateFormat.parse(current);
	        
	        if(className.equals("EmployerEventDom"))
	        {
	        	List<EmployerEventDom> eventList = new ArrayList<EmployerEventDom>(); 
	        	
	        	eventList = eventDetailsList;
	        	
	            for (EmployerEventDom employerEventDom : eventList) 
	 	        {	
	 				String endDate = employerEventDom.getEndDate();
	 				
	 				String endDateParsed = CaerusCommonUtility.parseTimestampToDate(endDate);
	 				
	 				Date end = dateFormat.parse(endDateParsed);
	 				
	 				long diff = end.getTime() - currentDate.getTime();
	 				 
	 				diffDays = diff / (24 * 60 * 60 * 1000);
	 	 
	 				String startDate = employerEventDom.getStartDate();
	 				
	 				String startDateParsed = CaerusCommonUtility.parseTimestampToDate(startDate);
	 				
	 				Date start = dateFormat.parse(startDateParsed);
	 				
	 				long diff1 = start.getTime() - currentDate.getTime();
	 				
	 				diffDays1 = diff1 / (24 * 60 * 60 * 1000);
	 				
	 				if(diffDays1 > 0)
	 				{
	 					employerEventDom.setDifferenceInDays(diffDays1);
	 				}
	 				if(diffDays > 0)
	 		        {
	 					upcomingEventsList.add(employerEventDom);
	 		        }
	 				
	 	        }
	        }
	      
	        if(className.equals("UniversityEventDom"))
	        {
	        	List<UniversityEventDom> eventList = new ArrayList<UniversityEventDom>(); 
	        	
	        	eventList = eventDetailsList;
	        	
	            for (UniversityEventDom employerEventDom : eventList) 
	 	        {	
	 				String endDate = employerEventDom.getEndDate();
	 				
	 				String endDateParsed = CaerusCommonUtility.parseTimestampToDate(endDate);
	 				
	 				Date end = dateFormat.parse(endDateParsed);
	 				
	 				long diff = end.getTime() - currentDate.getTime();
	 				 
	 				diffDays = diff / (24 * 60 * 60 * 1000);
	 	 
	 				String startDate = employerEventDom.getStartDate();
	 				
	 				String startDateParsed = CaerusCommonUtility.parseTimestampToDate(startDate);
	 				
	 				Date start = dateFormat.parse(startDateParsed);
	 				
	 				long diff1 = start.getTime() - currentDate.getTime();
	 				
	 				diffDays1 = diff1 / (24 * 60 * 60 * 1000);
	 				
	 				if(diffDays1 > 0)
	 				{
	 					employerEventDom.setDifferenceInDays(diffDays1);
	 				}
	 				if(diffDays > 0)
	 		        {
	 					upcomingEventsList.add(employerEventDom);
	 		        }
	 				
	 	        }
	        }
	      
			
			return upcomingEventsList;
			
		}

		/**
		 * This method is used to find list of upcoming university and corporate events for candidate
		 * @author RavishaG
		 * @param universityManager
		 * @param employerEventManager
		 * @param universityName
		 * @return List
		 */
		public static List<UpcomingEventsDom> getEventList(IUniversityManager universityManager,IEmployerEventManager employerEventManager,String universityName) {
			
			 List<EmployerEventDom> corporateEvents = new ArrayList<EmployerEventDom>();
			 List<UniversityEventDom> universityEvents = new ArrayList<UniversityEventDom>();		
			 List<UpcomingEventsDom> allEvents = new ArrayList<UpcomingEventsDom>();
		
			corporateEvents = employerEventManager.getEventDetailsByUniversityName(universityName);
		
			try 
			{
				corporateEvents = CandidateCommonFeature.getUpcomingEventList(corporateEvents, "EmployerEventDom");
				
				if(corporateEvents != null && corporateEvents.size() > 0)
				{
					for (EmployerEventDom upcomingCorporateEvent : corporateEvents) {
						
						UpcomingEventsDom upcomingEventsDom = new UpcomingEventsDom();
						
						upcomingEventsDom.setEventId(upcomingCorporateEvent.getEventId());
						upcomingEventsDom.setEventName(upcomingCorporateEvent.getEventName());
						upcomingEventsDom.setCompanyName(upcomingCorporateEvent.getCompanyName());
						upcomingEventsDom.setStartDate(upcomingCorporateEvent.getStartDate());
						upcomingEventsDom.setEndDate(upcomingCorporateEvent.getEndDate());
						
						if(upcomingCorporateEvent.getDifferenceInDays() != null)
							upcomingEventsDom.setDifferenceInDays(upcomingCorporateEvent.getDifferenceInDays());
						
						upcomingEventsDom.setAcceptedByStudentsList(upcomingCorporateEvent.getAcceptedByStudentsList());
						upcomingEventsDom.setDeniedByStudentsList(upcomingCorporateEvent.getDeniedByStudentsList());
						upcomingEventsDom.setFirmId(upcomingCorporateEvent.getEmailId());
						upcomingEventsDom.setStartTime(upcomingCorporateEvent.getStartTime());
						upcomingEventsDom.setEndTime(upcomingCorporateEvent.getEndTime());
						upcomingEventsDom.setUniversityFlag(false);
						
						allEvents.add(upcomingEventsDom);
						
					}
				}
			} 
			catch (ParseException e) 
			{
				e.printStackTrace();
			}
				
			
			universityEvents = universityManager.getEventDetailsByUniversityName(universityName);
			
			try 
			{
				universityEvents = CandidateCommonFeature.getUpcomingEventList(universityEvents, "UniversityEventDom");
				
				if(universityEvents != null && universityEvents.size() > 0)
				{
					for (UniversityEventDom upcomingUniversityEvent : universityEvents) {
						
						UpcomingEventsDom upcomingEventsDom = new UpcomingEventsDom();
						
						upcomingEventsDom.setEventId(upcomingUniversityEvent.getEventId());
						upcomingEventsDom.setEventName(upcomingUniversityEvent.getEventName());
						upcomingEventsDom.setEventType(upcomingUniversityEvent.getEventType());
						upcomingEventsDom.setStartDate(upcomingUniversityEvent.getStartDate());
						upcomingEventsDom.setEndDate(upcomingUniversityEvent.getEndDate());
						upcomingEventsDom.setDifferenceInDays(upcomingUniversityEvent.getDifferenceInDays());
						upcomingEventsDom.setAcceptedByStudentsList(upcomingUniversityEvent.getAcceptedByStudentsList());
						upcomingEventsDom.setDeniedByStudentsList(upcomingUniversityEvent.getDeniedByStudentsList());
						upcomingEventsDom.setUniversityId(upcomingUniversityEvent.getUniversityId());
						upcomingEventsDom.setStartTime(upcomingUniversityEvent.getStartTime());
						upcomingEventsDom.setEndTime(upcomingUniversityEvent.getEndTime());
						upcomingEventsDom.setUniversityFlag(true);
						
						allEvents.add(upcomingEventsDom);
					}
				}
			} 
			catch (ParseException e) 
			{
				e.printStackTrace();
			}	
			
			if(allEvents != null)
			allEvents = CaerusCommonUtility.sortListByDateReverse(allEvents, "UpcomingEventsDom");
				
			return null == allEvents ? new ArrayList<UpcomingEventsDom>() : allEvents;
		}

		
		/**
		 * This method is used to find recommended jobs for a candidate posted within 20 days of current date
		 * @author RavishaG
		 * @param recommendedJobsList
		 * @return list
		 */
		public List<JobDetailsDom> getRecentRecommendedJobs(List<JobDetailsDom> recommendedJobsList) {
			
			List<JobDetailsDom> recentRecommendedJobsList = new ArrayList<JobDetailsDom>();
			
			// Finding recommended jobs for candidate within 20 days of current date
			Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(new Date());
	    	calendar.add(Calendar.DAY_OF_YEAR, - 20);
	    	Date twentyDaysBack = calendar.getTime();
			
	    	if(recommendedJobsList != null)
	    	{
				for (JobDetailsDom employerJobPost : recommendedJobsList) {
					
					String postedOn = employerJobPost.getPostedOn();
					
					Date postedOnDate = CaerusCommonUtility.stringToDate(postedOn, "E MMM dd HH:mm:ss Z yyyy");
					
					if(postedOnDate.compareTo(twentyDaysBack) > 0)
					{
						recentRecommendedJobsList.add(employerJobPost);
					}
					
				}
	    	}
			
			return recentRecommendedJobsList;
		}
		
		/**
		 * Retrieving Recommended Jobs From Lucene Indexes(Excluding Applied Jobs)
		 * @author BalajiI
		 * @param studentJobsManager
		 * @param studentManager
		 * @param loggedInCandidateEmailId
		 * @return recommendedJobs(List<EmployerJobPost>)
		 */
		public List<JobDetailsDom> getRecommendedJobsLucene(IStudentJobsManager studentJobsManager,IStudentManager studentManager,String loggedInCandidateEmailId)
		{
			
			/**
			 * Retrieving Student Profile Details
			 */
			List<StudentDom> studentProfileList = studentManager.getStudentProfileDetailsByEmailId(loggedInCandidateEmailId);
			List<String> skills = null;
			
			if (studentProfileList != null && studentProfileList.size() > 0) 
			{
				for (StudentDom studentProfileDetails : studentProfileList)
				{
					if (studentProfileDetails.getDefaultProfile() != null && studentProfileDetails.getDefaultProfile().equalsIgnoreCase("true"))
					{
						/** Retrieving Student Primary Skills */
						skills = studentProfileDetails.getPrimarySkills();
						skills.addAll(studentProfileDetails.getSecondarySkills());
					}
				}
			}
			
			HashMap<String, String> searchParametersMap = new HashMap<String, String>();
			
			if(null != skills && !skills.isEmpty())
			{
				String primarySkillsString = skills.toString().replaceAll(","," ").replace("[", " ").replace("]", " ");
				searchParametersMap.put("keyword",primarySkillsString);
			}
			
			String SRC_FOLDER = CaerusPathConstants.jobIndexes;
			
			File indexDir = new File(SRC_FOLDER);
			
			SimpleDBSearcher simpleDBSearcher = new SimpleDBSearcher();
			List<String> recommendedJobIds = new ArrayList<String>();
			try
			{
				recommendedJobIds = simpleDBSearcher.searchIndex(indexDir, searchParametersMap, "recommendedJobs");
				
				// Retrieving Applied JobIds
				/* List<String> appliedJobIds = studentJobsManager.getAppliedJobIds(loggedInCandidateEmailId,"jobs");
				
				if(!appliedJobIds.isEmpty())
					recommendedJobIds.removeAll(appliedJobIds);*/
			}
			catch(FileNotFoundException fnfe)
			{
				logger.error("Indexes not found at "+indexDir);
			}
			catch(Exception exception)
			{
				logger.error("Something Went Wrong "+exception.toString());
			}
			
			StringBuilder recommendedJobIdsSB = new StringBuilder();
			String recommendedJobIdsStr = "";
			
			for (String recommendedJobId : recommendedJobIds) {
				recommendedJobIdsSB = recommendedJobIdsSB.append("'").append(recommendedJobId).append("',");
			}
			
			if(recommendedJobIdsSB.length() > 0)
				recommendedJobIdsStr = recommendedJobIdsSB.substring(0,recommendedJobIdsSB.lastIndexOf(","));
			
			List<JobDetailsDom> recommendedJobs = new ArrayList<JobDetailsDom>();
			
			/*if(recommendedJobIdsStr.length() > 0)
				recommendedJobs = studentJobsManager.getSearchdJobDetails(recommendedJobIdsStr);*/
			
			int savedJobFlag = 0;
			for(JobDetailsDom recommendedJobDetails : recommendedJobs)
			{
				String jobIdAndFirmId = recommendedJobDetails.getJobIdAndFirmId();
				
				/** Checking if the Job has already been saved */
				/*if(jobIdAndFirmId != null)
					savedJobFlag = studentJobsManager.isSavedJob(loggedInCandidateEmailId,jobIdAndFirmId);*/

			  if(savedJobFlag != 0)
			  {
				  recommendedJobDetails.setSavedFlag(String.valueOf(true));			  
			  }	
			}
			
			return recommendedJobs;
		}
		
		/** 
		 * This method is used to return Certifications List 
		 * @author RavishaG
		 * @param certificationsMap
		 * @return certificationList
		 */
		public static List<PortfolioDetailsDom> getCertificationList(
				Map<String, String> certificationsMap) {
			int i=0;
			List<PortfolioDetailsDom> certificationList = new ArrayList<PortfolioDetailsDom>();
			
			if(certificationsMap != null && certificationsMap.size() != 0)
			{
				certificationsMap = CaerusCommonUtil.sortMapObject(certificationsMap);
				
				Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(certificationsMap);
				
				String[] lastEntry = entry.getKey().split("_");
				String index = lastEntry[0];
				i = Integer.parseInt(index);	
				
				for(int j=1; j<=i; j++)
				{
					PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
					for(Entry<String, String> string : certificationsMap.entrySet())
					{
							int a = Character.getNumericValue(string.getKey().charAt(0));
							if(a == j)
							{		
								if(string.getKey().contains("authorityName"))
								{
									portfolioDetails.setCertificateAuthority(string.getValue());
								}
								
								if(string.getKey().contains("certificateName"))
								{
									portfolioDetails.setCertificateName(string.getValue());
								}
								
								if(string.getKey().contains("certificateNumber"))
								{
									portfolioDetails.setCertificateNumber(string.getValue());
								}
								
								if(string.getKey().contains("startMonth"))
								{
									portfolioDetails.setCertificationStartMonth(string.getValue());
								}
								
								if(string.getKey().contains("startYear"))
								{
									portfolioDetails.setCertificationStartYear(string.getValue());
								}
								
								if(string.getKey().contains("endMonth"))
								{
									if(string.getValue().equals("")  || string.getValue().equals("null"))
									{
										portfolioDetails.setCertificationEndMonth("");	
									}
									else
									{
										portfolioDetails.setCertificationEndMonth(string.getValue());
									}
								}
								
								if(string.getKey().contains("endYear"))
								{
									if(string.getValue().equals("")  || string.getValue().equals("null"))
									{
										portfolioDetails.setCertificationEndYear("no expiry");	
									}
									else
									{
										portfolioDetails.setCertificationEndYear(string.getValue());
									}
								}	
								
							}		
					}
					
					certificationList.add(portfolioDetails);
				}
				
			}
			return certificationList;
		}

		/** 
		 * This method is used to return Publications List 
		 * @author RavishaG
		 * @param publicationsMap
		 * @return publicationList
		 */
		public static List<PortfolioDetailsDom> getPublicationList(Map<String, String> publicationsMap){
			
			List<PortfolioDetailsDom> publicationList = new ArrayList<PortfolioDetailsDom>();
			
			int i = 0;
			if(publicationsMap != null && publicationsMap.size() != 0)
			{
				publicationsMap = CaerusCommonUtil.sortMapObject(publicationsMap);
				
				Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(publicationsMap);
				
				String[] lastEntry = entry.getKey().split("_");
				String index = lastEntry[0];
				i = Integer.parseInt(index);
				
				for(int j=1; j<=i; j++)
				{
					PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
					for(Entry<String, String> string : publicationsMap.entrySet())
					{
							int a = Character.getNumericValue(string.getKey().charAt(0));
							if(a == j)
							{		
								if(string.getKey().contains("publicationTitle"))
								{
									portfolioDetails.setPublicationTitle(string.getValue());
								}
								
								if(string.getKey().contains("publicationSummary"))
								{
									portfolioDetails.setPublicationSummary(string.getValue());
								}
								
								if(string.getKey().contains("publicationDate"))
								{
									portfolioDetails.setPublicationDate(string.getValue());
								}
								
								if(string.getKey().contains("publicationUrl"))
								{
									portfolioDetails.setPublicationUrl(string.getValue());
								}
								
								if(string.getKey().contains("publisherName"))
								{
									portfolioDetails.setPublisherName(string.getValue());
								}	
								
								if(string.getKey().contains("publisherAuthorFirstName"))
								{
									portfolioDetails.setPublisherAuthorFirstName(string.getValue());
								}	
								
								if(string.getKey().contains("publisherAuthorLastName"))
								{
									portfolioDetails.setPublisherAuthorLastName(string.getValue());
								}	
								
							}		
					}
					
					publicationList.add(portfolioDetails);
				}
				
			}
					return publicationList;
			
		}


		/**
		 * This method is used to return school Details
		 * @author RavishaG
		 * @param schoolMap
		 * @return PortfolioDetailsDom
		 */
		public static PortfolioDetailsDom getSchoolDetails(Map<String, String> schoolMap) {
			
			PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
			
			if(schoolMap != null && schoolMap.size() != 0)
			{
					for(Entry<String, String> schoolEntry : schoolMap.entrySet())
					{	
						if(schoolEntry.getKey().contains("schoolName"))
						{
							String schoolName = schoolEntry.getValue().replace("'","");
							portfolioDetails.setSchoolName(schoolName);
						}
						
						if(schoolEntry.getKey().contains("schoolState"))
						{
							portfolioDetails.setSchoolState(schoolEntry.getValue());
						}
						
						if(schoolEntry.getKey().contains("schoolGpaFrom"))
						{
							if(!(schoolEntry.getValue().equals("null")))
								portfolioDetails.setSchoolGpaFrom(Double.parseDouble(schoolEntry.getValue()));
							
							else
							portfolioDetails.setSchoolGpaFrom(0.0);
						}
						
						if(schoolEntry.getKey().contains("schoolGpaTo"))
						{
							if(! schoolEntry.getValue().equals("null"))
								portfolioDetails.setSchoolGpaTo(Double.parseDouble(schoolEntry.getValue()));
							else
								portfolioDetails.setSchoolGpaTo(0.0);
								
						}
						
						if(schoolEntry.getKey().contains("schoolPassingYear"))
						{
							portfolioDetails.setSchoolPassingYear(schoolEntry.getValue());
						}	
						
						if(schoolEntry.getKey().contains("schoolPassingMonth"))
						{
							portfolioDetails.setSchoolPassingMonth(schoolEntry.getValue());
						}	
						
					}
					
				}
				
					return portfolioDetails;
		}


		/**
		 * This method is used to return university Details
		 * @author RavishaG
		 * @param universityMap
		 * @return list
		 */
		public static List<PortfolioDetailsDom> getUniversityDetails(Map<String, String> universityMap) {
			
			List<PortfolioDetailsDom> universityDetailsList = new ArrayList<PortfolioDetailsDom>();
			
			int i = 0;
			if(universityMap != null && universityMap.size() != 0)
			{
				universityMap = CaerusCommonUtil.sortMapObject(universityMap);
				
				Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(universityMap);
				
				String[] lastEntry = entry.getKey().split("_");
				String index = lastEntry[0];
				
				if(!index.equals("null")){
					
				
				i = Integer.parseInt(index);
				
					for(int j=1; j<=i; j++)
					{
						PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
						for(Entry<String, String> universityEntry : universityMap.entrySet())
						{
								int a = Character.getNumericValue(universityEntry.getKey().charAt(0));
								if(a == j)
								{		
									if(universityEntry.getKey().contains("universityName"))
									{
										String universityName = universityEntry.getValue().replace("'", "");
										portfolioDetails.setUniversityName(universityName);
									}
									
									if(universityEntry.getKey().contains("universityGpaFrom"))
									{
										if(!(universityEntry.getValue().equals("null")))
											portfolioDetails.setUniversityGpaFrom(Double.parseDouble(universityEntry.getValue()));
										else
										portfolioDetails.setUniversityGpaFrom(0.0);
									}
									
									if(universityEntry.getKey().contains("universityGpaTo"))
									{
										if(!(universityEntry.getValue().equals("null")))
											portfolioDetails.setUniversityGpaTo(Double.parseDouble(universityEntry.getValue()));
										else
										portfolioDetails.setUniversityGpaTo(0.0);
									}
									
									if(universityEntry.getKey().contains("universityYearFrom"))
									{
										portfolioDetails.setUniversityYearFrom(universityEntry.getValue());
									}
									
									if(universityEntry.getKey().contains("universityYearTo"))
									{
										portfolioDetails.setUniversityYearTo(universityEntry.getValue());
									}	
									
									if(universityEntry.getKey().contains("universityMonthFrom"))
									{
										portfolioDetails.setUniversityMonthFrom(universityEntry.getValue());
									}	
									
									if(universityEntry.getKey().contains("universityMonthTo"))
									{
										portfolioDetails.setUniversityMonthTo(universityEntry.getValue());
									}	
									
									if(universityEntry.getKey().contains("universityCourseType"))
									{
										String universityCourseType = universityEntry.getValue().replace("'", "");
										portfolioDetails.setUniversityCourseType(universityCourseType);
									}	
									
									if(universityEntry.getKey().contains("universityCourseName"))
									{
										String universityCourseName = universityEntry.getValue().replace("'", "");
										portfolioDetails.setUniversityCourseName(universityCourseName);
									}	
									
								}		
						}
						
						universityDetailsList.add(portfolioDetails);
					}
				}
			}
					return universityDetailsList;
		}
		
		
		/**
		 * This method is used to return university Details
		 * @author RavishaG
		 * @param workMap
		 * @return list
		 */
		public static List<PortfolioDetailsDom> getWorkDetails(Map<String, String> workMap) {
			
			List<PortfolioDetailsDom> workDetailsList = new ArrayList<PortfolioDetailsDom>();
			
			int i = 0;
			if(workMap != null && workMap.size() != 0)
			{
				workMap = CaerusCommonUtil.sortMapObject(workMap);
				
				Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(workMap);
				
				String[] lastEntry = entry.getKey().split("_");
				String index = lastEntry[0];
				i = Integer.parseInt(index);
				
				for(int j=1; j<=i; j++)
				{
					PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
					for(Entry<String, String> workEntry : workMap.entrySet())
					{
							int a = Character.getNumericValue(workEntry.getKey().charAt(0));
							if(a == j)
							{		
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_COMPANY_NAME))
								{
									portfolioDetails.setWorkCompanyName(workEntry.getValue());
								}
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_DESCRIPTION))
								{
									portfolioDetails.setWorkDescription(workEntry.getValue());
								}
								
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_YEAR_FROM))
								{
									portfolioDetails.setWorkYearFrom(workEntry.getValue());
								}
								
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_YEAR_TO))
								{
									portfolioDetails.setWorkYearTo(workEntry.getValue());
								}
								
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_MONTH_FROM))
								{
									portfolioDetails.setWorkMonthFrom(workEntry.getValue());
								}	
								
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_MONTH_TO))
								{
									portfolioDetails.setWorkMonthTo(workEntry.getValue());
								}	
								
								if(workEntry.getKey().contains(CaerusStringConstants.CANDIDATE_WORK_MAP_WORK_DESIGNATION))
								{
									portfolioDetails.setWorkDesignation(workEntry.getValue());
								}	
								
							}		
					}
					
					workDetailsList.add(portfolioDetails);
				}
				
			}
					return workDetailsList;
		}
		
		public static List<JobDetailsDom> getAppliedJobs(IEmployerJobPostManager employerJobPostManager,
				IStudentJobsManager studentJobsManager, String loggedInUserEmail, List<JobDetailsDom> appliedJobs) {
			/*String appliedJobsCassandraInQuery = "";
			Map<String,Date> appliedJobsWithTimestamp = studentJobsManager.getAppliedJobIdsMap(loggedInUserEmail);
			
			if(appliedJobsWithTimestamp != null && !appliedJobsWithTimestamp.isEmpty()){
				appliedJobsCassandraInQuery = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(appliedJobsWithTimestamp.keySet()));
			}
			if(appliedJobsCassandraInQuery.length() > 0)
				appliedJobs = employerJobPostManager.getJobsForJobIds(appliedJobsCassandraInQuery);*/
			
			appliedJobs = studentJobsManager.getAppliedJobs(loggedInUserEmail);
			
			return null == appliedJobs ? new ArrayList<JobDetailsDom>() : appliedJobs ;
		}


		public static List<JobDetailsDom> getSavedJobs(IEmployerJobPostManager employerJobPostManager,IStudentJobsManager studentJobsManager,String emailId,
				List<JobDetailsDom> savedJobs) {
			
			savedJobs = studentJobsManager.getSavedJobs(emailId);
			
			/*
			Map<String,Date> savedJobsWithTimestamp = studentJobsManager.getSavedJobIdsMap(emailId);
			String savedJobsCassandraInQuery = "";
			
			if(savedJobsWithTimestamp != null && !savedJobsWithTimestamp.isEmpty()){
				savedJobsCassandraInQuery = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(savedJobsWithTimestamp.keySet()));
			}
			if(savedJobsCassandraInQuery.length() > 0)
				savedJobs = employerJobPostManager.getJobsForJobIds(savedJobsCassandraInQuery);*/
		
			return null == savedJobs ? new ArrayList<JobDetailsDom>() : savedJobs ;
		}
	
		public static List<JobDetailsDom> getSavedInternships(IEmployerJobPostManager employerJobPostManager,
				IStudentJobsManager studentJobsManager, String loggedInUserEmail,List<JobDetailsDom> savedInternships) {
			/*String savedInternshipsCassandraInQuery = "";
			Map<String,Date> savedInternshipsWithTimestamp = studentJobsManager.getSavedInternshipIdsMap(loggedInUserEmail);
			
			if(savedInternshipsWithTimestamp != null && !savedInternshipsWithTimestamp.isEmpty()){
				savedInternshipsCassandraInQuery = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(savedInternshipsWithTimestamp.keySet()));
			}
			if(savedInternshipsCassandraInQuery.length() > 0)
				savedInternships = employerJobPostManager.getInternshipsForInternshipIds(savedInternshipsCassandraInQuery);*/
			
			savedInternships = studentJobsManager.getSavedInternships(loggedInUserEmail);
			
			return null == savedInternships ? new ArrayList<JobDetailsDom>() : savedInternships ;
		}


		public static List<JobDetailsDom> getAppliedInternships(IEmployerJobPostManager employerJobPostManager,
				IStudentJobsManager studentJobsManager, String loggedInUserEmail,List<JobDetailsDom> appliedInternships) {
			/*String appliedInternshipsCassandraInQuery = "";
			
			Map<String,Date> appliedInternshipsWithTimestamp = studentJobsManager.getAppliedInternshipIdsMap(loggedInUserEmail);
			if(appliedInternshipsWithTimestamp != null && !appliedInternshipsWithTimestamp.isEmpty()){
				appliedInternshipsCassandraInQuery = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(appliedInternshipsWithTimestamp.keySet()));
			}
			if(appliedInternshipsCassandraInQuery.length() > 0)
				appliedInternships = employerJobPostManager.getInternshipsForInternshipIds(appliedInternshipsCassandraInQuery);*/
			
			appliedInternships = studentJobsManager.getAppliedInternships(loggedInUserEmail);
			
			return null == appliedInternships ? new ArrayList<JobDetailsDom>() : appliedInternships ;
		}

		
		/**
		 * This method is used to get recommended jobs for a candidate
		 * @author balajii
		 * @param studentJobsManager
		 * @param employerJobPostManager
		 * @param loggedInUserEmail
		 * @param recommendedJobs
		 * @return List
		 */
		public static List<JobDetailsDom> getRecommendedJobs(IStudentJobsManager studentJobsManager,IEmployerJobPostManager employerJobPostManager,String loggedInUserEmail,
				List<JobDetailsDom> recommendedJobs) 
		{
			StudentDom defaultProfileDetails = studentJobsManager.getDefaultProfileDetails(loggedInUserEmail);
			
			StringBuilder skillsSB = new StringBuilder();
			String skills = "";
			
			if(defaultProfileDetails != null)
			{
				if(defaultProfileDetails.getPrimarySkills() != null){
					for(int i = defaultProfileDetails.getPrimarySkills().size() - 1 ; i >= 0; i--)
					{
						skillsSB.append(defaultProfileDetails.getPrimarySkills().get(i)).append(" ");
					}	
				}
				if(defaultProfileDetails.getPrimarySkills() != null){
					for(int i = defaultProfileDetails.getSecondarySkills().size() - 1 ; i >= 0; i--)
					{
						skillsSB.append(defaultProfileDetails.getSecondarySkills().get(i)).append(" ");
					}
				}
				
				if(skillsSB.length() > 0)
				{
					skills = skillsSB.toString();
				}
			}
			
			if(skills.length() > 0)
			{
				Map<String, String> searchParametersMap = new HashMap<String, String>();
				
				searchParametersMap.put("keyword", skills);
				
				try {
					
					List<String> recommendedJobIds = SimpleDBSearcher.searchIndex(new File(CaerusPathConstants.jobIndexes), searchParametersMap, CaerusStringConstants.RECOMMENDED_JOBS);
					if(recommendedJobIds != null && recommendedJobIds.size() > 0)
					{
						/*Map<String,Date> appliedJobsWithTimestamp = studentJobsManager.getAppliedJobIdsMap(loggedInUserEmail);
						recommendedJobIds.removeAll(appliedJobsWithTimestamp.keySet());*/
						
						recommendedJobIds.removeAll(studentJobsManager.getAppliedJobIds(loggedInUserEmail));
						
						String recommendedJobsCassandraQueryStr = CaerusCommonUtility.getCassandraInQueryString(recommendedJobIds);
						recommendedJobs = employerJobPostManager.getJobsForJobIds(recommendedJobsCassandraQueryStr);
					}
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return recommendedJobs;
		}
		
		/**
		 * This method is used to fetch the count of recommended jobs for a candidate
		 * @author ravishag
		 * @param studentJobsManager
		 * @param employerJobPostManager
		 * @param loggedInUserEmail
		 * @return int
		 */
		public static int getRecommendedJobCount(IStudentJobsManager studentJobsManager,IEmployerJobPostManager employerJobPostManager,String loggedInUserEmail)
		{
			int count = 0;
			
			StudentDom defaultProfileDetails = studentJobsManager.getDefaultProfileDetails(loggedInUserEmail);
			
			StringBuilder skillsSB = new StringBuilder();
			String skills = "";
			
			if(defaultProfileDetails != null)
			{
				if(defaultProfileDetails.getPrimarySkills() != null){
					for(int i = defaultProfileDetails.getPrimarySkills().size() - 1 ; i >= 0; i--)
					{
						skillsSB.append(defaultProfileDetails.getPrimarySkills().get(i)).append(" ");
					}	
				}
				if(defaultProfileDetails.getPrimarySkills() != null){
					for(int i = defaultProfileDetails.getSecondarySkills().size() - 1 ; i >= 0; i--)
					{
						skillsSB.append(defaultProfileDetails.getSecondarySkills().get(i)).append(" ");
					}
				}
				
				if(skillsSB.length() > 0)
				{
					skills = skillsSB.toString();
				}
			}
			
			if(skills.length() > 0)
			{
				Map<String, String> searchParametersMap = new HashMap<String, String>();
				searchParametersMap.put("keyword", skills);
				try {
					
					List<String> recommendedJobIds = SimpleDBSearcher.searchIndex(new File(CaerusPathConstants.jobIndexes), searchParametersMap, CaerusStringConstants.RECOMMENDED_JOBS);
					if(recommendedJobIds != null && recommendedJobIds.size() > 0)
					{
						/*Map<String,Date> appliedJobsWithTimestamp = studentJobsManager.getAppliedJobIdsMap(loggedInUserEmail);
						
						recommendedJobIds.removeAll(appliedJobsWithTimestamp.keySet());*/
						
						recommendedJobIds.removeAll(studentJobsManager.getAppliedJobIds(loggedInUserEmail));
						
						count = recommendedJobIds.size();
					}
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return count;
		}
		
		/**
		 * This method is used to fetch the count of applied jobs for a candidate
		 * @author ravishag
		 * @param employerJobPostManager
		 * @param studentJobsManager
		 * @param loggedInUserEmail
		 * @param appliedJobs
		 * @return int 
		 */
		public static int getAppliedJobsCount(IEmployerJobPostManager employerJobPostManager,IStudentJobsManager studentJobsManager, String loggedInUserEmail) 
		{
			int count = 0;
			
			count = studentJobsManager.getAppliedJobsCount(loggedInUserEmail);
			
			/*Map<String,Date> appliedJobsWithTimestamp = studentJobsManager.getAppliedJobIdsMap(loggedInUserEmail);
			
			if(appliedJobsWithTimestamp != null)
				count = appliedJobsWithTimestamp.size();
			*/
			return count;
		}
}