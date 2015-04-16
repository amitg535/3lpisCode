package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.MessageDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMessageManager;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.EmployerCommonFeature;
import caerusapp.util.MailUtil;

	@Controller
	public class EmployerDashboardController
	{
		//Logger for this class and subclasses
		protected final Log logger = LogFactory.getLog(getClass());
	
		//Auto-wiring service component
		@Autowired
		IEmployerJobPostManager employerJobPostManager;
		
		@Autowired	
		IEmployerManager employerManager;
		
		@Autowired
		IUniversityManager universityManager;
	
		@Autowired
		IStudentManager studentManager;
		
		@Autowired
		ILoginManagement loginManagement;
		
		@Autowired
		IEmployerEventManager employerEventManager;
		
		@Autowired
		IMessageManager messageManager;
		
		@Autowired
		MailUtil mailUtil;
		
		//Creating domain object
		List<EmployerCampusJobPostDom> campusJobs = null;

		/**
		 * This method is used to display employer dashboard page
		 * @param request
		 * @param response
		 * @return ModelAndView
		 * @throws Exception
		 */
		@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DASHBOARD)
		public ModelAndView loadEmployerDashboard(HttpServletRequest request,HttpServletResponse response) throws Exception
		{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String corporateEmailId = authentication.getName();
			
			logger.info(corporateEmailId +" Logged In");
			
			String authority = authentication.getAuthorities().toString();
			authority = authority.replace("[", "").replace("]", "");
			
			// Fetching the logged in user's details
			LoginManagementDom loggedInUserDetails = loginManagement.getUserDetailsByEmailID(corporateEmailId);
			
			if(null != loggedInUserDetails && loggedInUserDetails.isAdminFlag())
			{
				request.getSession().setAttribute("isAdmin", true);
			}
			
			UserBrowsingPatternsDom userBrowsingPatternsDom = new UserBrowsingPatternsDom();
			String userFullName = "";
			String corporateName = loggedInUserDetails.getEntityName();
			if(null!= loggedInUserDetails.getFirstName() && null!= loggedInUserDetails.getLastName()){
				
				 userFullName = loggedInUserDetails.getFirstName().concat(" ").concat(loggedInUserDetails.getLastName());
			}
			
			else  userFullName = "User";
			// Creating a new session
			HttpSession session = request.getSession();
			session.setAttribute("compName",corporateName);
			session.setAttribute("username",userFullName);
			
			
			// Fetching the login Attempts of the corporate user to display the next page(either the Dashboard or the Manage Profile Page)
			int loginAttempts = employerManager.getUserLoginAttempts(corporateName);
			
			if (loginAttempts == 0) 
			{
				return new ModelAndView(new RedirectView("employer_manage_profile.htm"));
			} 
			
			else
			{
				//The modelAndView object contains the model(data) and the view(page)
				ModelAndView modelAndView = new ModelAndView("employer/employer_dashboard");
				
				// Retrieving the company details from the database
				EmployerDom corporateDetails = employerManager.getEmployerDetails(corporateName);
				corporateDetails.setEmailID(corporateEmailId);
				
				modelAndView.addObject("corporateDetails", corporateDetails);
					
				session.setAttribute("compWebsite",corporateDetails.getCompanyWebsite());
				
				userBrowsingPatternsDom.setEmailId(corporateEmailId);
				
				loginManagement.addLoginDetails(userBrowsingPatternsDom,authority);
				
				//Logger for this class and subclasses
				logger.info(CaerusLoggerConstants.DASHBOARD_LOGGER);
				
				String eventId = null;
				String action = null;
				String universityEmailId = null;
				String eventName = null;
				List<JobDetailsDom> sortedEmployerJobs = null;
				List <EmployerCampusJobPostDom> sortedCampusJobs = null;
				//Default max count of candidates to be shown on page
				int maxShowCandidateCount = 4;
				
				if(request!=null)
				{
					eventId = request.getParameter("event_id");
					action = request.getParameter("action");
					universityEmailId = request.getParameter("uni_email");
					eventName = request.getParameter("eventName");
				}		
				
			    if((eventId!=null) && (action!=null))
			    { 
			    	employerManager.updateActionOnUniversityInvite(corporateName, eventId, action);
			    	
			    	//MailUtil.sendMailAboutEventStatus(universityEmailId, corporateEmailId, eventId, action, eventName);	  
			    	
			    	Document document = CaerusCommonUtil.eventUpdateMailTemplate();
			    	
			    	if(action.equalsIgnoreCase("undo"))
			    		document.getElementById("username").append(corporateName+ " has reverted the status for the event " + eventName);
					
			    	else
			    		document.getElementById("username").append(corporateName+ " has " + action + " the invitation for the event " + eventName);
					
			    	mailUtil.sendMailToUsers(universityEmailId, document.toString(), "Event Status Update");
			    }
				
			    //Getting request parameter 
				String jobId = request.getParameter("jobid");
				if(jobId!= null)
				{
					employerJobPostManager.deletePostedJob(jobId);		
				}
				
				//creating list of domain object
				List<JobDetailsDom> employerJobs = employerJobPostManager.getAllJobsPostedByEmployer(corporateEmailId);
				
				int jobCount=0,campusJobCount=0;
				
				if(employerJobs != null && employerJobs.size() > 0)
				{
					String className = "JobDetailsDom";
					sortedEmployerJobs = CaerusCommonUtility.sortListByDateReverse(employerJobs,className);
					jobCount = sortedEmployerJobs.size();
				}
				
				if(null != sortedEmployerJobs && sortedEmployerJobs.size() > 0){
				for (JobDetailsDom job : sortedEmployerJobs) {
					
					//get applied students map
					if(null!= job.getJobAppliedStudents() &&  job.getJobAppliedStudents().size()!=0){
   
						Map<String, String> studentResponsesMap =  new HashMap<String, String>();
						studentResponsesMap.putAll(job.getJobAppliedStudents());
						
						//check frequency of each status viz Applied/Shortlisted etc. 
						@SuppressWarnings("unchecked")
						Map<String,Integer> cardinalityMap = CollectionUtils.getCardinalityMap(studentResponsesMap.values());
						List<String> removableKeys = new ArrayList<String>(cardinalityMap.keySet());
						
						//Remove all candidates except those having status as "Applied" 
						if(cardinalityMap.containsKey(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS)  && cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS) >= maxShowCandidateCount){
							removableKeys.remove(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
						}
						
						else {
							
							//Include all candidates having status "Accepted" plus candidates till maxShowCandidateCount reached
							List<String> selectedKeys =  new ArrayList<String>();
							selectedKeys.add(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
								
							int appliedCount = 0;
							if(null != cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS))
								appliedCount = cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
							
							for (Entry<String, Integer> entry : cardinalityMap.entrySet()) {
								if(! entry.getKey().equals(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS)){
									if(( appliedCount + entry.getValue()) <= maxShowCandidateCount){
										selectedKeys.add(entry.getKey());
									}
									
								}
							}
								removableKeys.removeAll(selectedKeys);
						
						}
						
						if(removableKeys.size()!=0){
							boolean flag = studentResponsesMap.values().removeAll(removableKeys);
						}
						
						//Set final candidates map
						job.setJobAppliedStudents(studentResponsesMap);
						
						}
					}
				}
				campusJobs = universityManager.getCampusJobsByEmployer(corporateEmailId);
	
				//Retrieving the Events based on the Employer's Name
				
				if(campusJobs != null && campusJobs.size() > 0)
				{
					Collections.sort(campusJobs, new Comparator<EmployerCampusJobPostDom>(){
						public int compare(EmployerCampusJobPostDom o1, EmployerCampusJobPostDom o2) {
							  
							  String dateFormat = CaerusAPIStringConstants.DB_DATE_FORMAT;
							  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
							  Date d2 =  CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
							   
							  int compareTo = 0;
							  if(d1 != null && d2 != null)
								  compareTo = d2.compareTo(d1);
							  
						      return compareTo;
						  }
					});
					sortedCampusJobs = new ArrayList<EmployerCampusJobPostDom>();
					sortedCampusJobs.addAll(campusJobs);
					
					campusJobCount = sortedCampusJobs.size();
				}
				
				
				if(null != sortedCampusJobs && sortedCampusJobs.size() > 0) {
				
					for (EmployerCampusJobPostDom campusJob : sortedCampusJobs) {
					
					//get applied students map
					if(null != campusJob.getAppliedCampusJobStatusMap() &&  campusJob.getAppliedCampusJobStatusMap().size() != 0){
   
						Map<String, String> campusStudentResponsesMap =  new HashMap<String, String>();
						campusStudentResponsesMap.putAll(campusJob.getAppliedCampusJobStatusMap());
						
						//check frequency of each status viz Applied/Shortlisted etc. 
						@SuppressWarnings("unchecked")
						Map<String,Integer> campusCardinalityMap = CollectionUtils.getCardinalityMap(campusStudentResponsesMap.values());
						List<String> removableKeys = new ArrayList<String>(campusCardinalityMap.keySet());
						
						//Remove all candidates except those having status as "Applied" 
						if(campusCardinalityMap.containsKey(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS)  && campusCardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS) >= maxShowCandidateCount){
							removableKeys.remove(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
						}
						
						else {
							
							//Include all candidates having status "Accepted" plus candidates till maxShowCandidateCount reached
							List<String> selectedKeys =  new ArrayList<String>();
							selectedKeys.add(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
								
							int appliedCount = 0;
							if(null != campusCardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS))
								appliedCount = campusCardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
							
							for (Entry<String, Integer> entry : campusCardinalityMap.entrySet()) {
								if(! entry.getKey().equals(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS)){
									if(( appliedCount + entry.getValue()) <= maxShowCandidateCount){
										selectedKeys.add(entry.getKey());
									}
									
								}
							}
								removableKeys.removeAll(selectedKeys);
						}
						
						if(removableKeys.size() != 0){
							campusStudentResponsesMap.values().removeAll(removableKeys);
						}
						//Set final candidates map
						campusJob.setAppliedCampusJobStatusMap(campusStudentResponsesMap);
						
						}
					}
				}
				
				List<UniversityEventDom> campusEvents = employerEventManager.getCampusEvents(corporateName,CaerusAPIStringConstants.INVITATION_STATUS_PENDING);
				//Adding objects to model to retrieve details on jsp
				modelAndView.addObject("sortedEmployerJobs", sortedEmployerJobs);
				modelAndView.addObject("jobCount", jobCount);
				modelAndView.addObject("sortedCampusJobs", sortedCampusJobs);
				modelAndView.addObject("campusJobCount",campusJobCount);
				
				
				List<UniversityEventDom> campusEventsFirstDiv = new ArrayList<UniversityEventDom>();
				List<UniversityEventDom> campusEventsSecondDiv = new ArrayList<UniversityEventDom>();
				
				int eventCount = 0;
				if(campusEvents != null && campusEvents.size() > 0)
				{
					eventCount = campusEvents.size();
					
					if(eventCount < 3)
						campusEventsFirstDiv = campusEvents.subList(0, eventCount);
					else
						campusEventsFirstDiv = campusEvents.subList(0, 3);
					
					if(campusEvents.size() > 3)
						campusEventsSecondDiv = campusEvents.subList(3, campusEvents.size());
					
				}
				
				modelAndView.addObject("campusEventsFirstDiv", campusEventsFirstDiv);
				modelAndView.addObject("campusEventsSecondDiv", campusEventsSecondDiv);
				modelAndView.addObject("campusEvents", campusEvents);
				modelAndView.addObject("eventListsize", eventCount);	
				
				int inviteCount = universityManager.getTotalCampusInvites(corporateName);
				modelAndView.addObject("inviteCount", inviteCount);
				
				String searchParameterName = request.getParameter("searchParameterName");
				if(searchParameterName != null && !searchParameterName.isEmpty())
				{
					employerManager.deleteSavedSearch(corporateEmailId,searchParameterName);
				}
				
				int count=0;
				
				List<JobDetailsDom> savedSearches = employerManager.getSavedSearches(corporateEmailId);
				
				if(savedSearches != null && savedSearches.size() > 0)
				{
					count = savedSearches.size();
				}
				if(count > 3)
				{
					savedSearches = savedSearches.subList(0,3);
				}
				modelAndView.addObject("savedSearches",savedSearches);
				
				
				//Retrieve unread Message Count for dash board
				 int newMessageCount=0;
				 
				 List<List<MessageDom>> messageInboxList = messageManager.getMessage(corporateEmailId,authority);
				  
				 for (List<MessageDom> messageRelayList : messageInboxList) 
				 {
					 // For each individual Message Chain
					 for (MessageDom message : messageRelayList) 
					 {
						   if(corporateEmailId.equalsIgnoreCase(message.getReceiverEmailId()) && message.isRead()==false)
						   {
							 newMessageCount+=1;
						   }
					}
					 				
				}
					 
				session.setAttribute("newMessageCount", newMessageCount);
				
				int virtualFairCount = 0;
				modelAndView.addObject("virtualFairCount",virtualFairCount);
				
				/*int virtualFairCount = virtualFairManager.getInvitationCount(corporateEmailId);
				
				modelAndView.addObject("savedSearchJobsCount",count);
				*/
				
				/* Added by RavishaG to get recommended video profiles of students for employers */
				List<StudentDom> studentDetailList = EmployerCommonFeature.getRecommendedVideoProfiles(employerManager, studentManager, corporateEmailId);
			
				if(studentDetailList != null)
				{
					if(studentDetailList.size() != 0)
					{
						modelAndView.addObject("studentListSize",studentDetailList.size());
						if(studentDetailList.size() > 2)
						{
							modelAndView.addObject("studentList",studentDetailList.subList(0, 2));	
						}
						else
						{
							modelAndView.addObject("studentList",studentDetailList.subList(0, studentDetailList.size()));
						}
					}
				}
				modelAndView.addObject("searchCandidate", new JobDetailsCom());
				modelAndView.addObject("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
				modelAndView.addObject("dbDateFormat",CaerusStringConstants.DB_DATE_FORMAT);
				
				modelAndView.addObject("EMPLOYER_POST_JOB",CaerusAnnotationURLConstants.EMPLOYER_POST_JOB);
				modelAndView.addObject("EMPLOYER_POST_CAMPUS_JOB",CaerusAnnotationURLConstants.EMPLOYER_POST_CAMPUS_JOB);
				
				return modelAndView;
			}
		}

}
