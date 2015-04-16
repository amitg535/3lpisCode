package caerusapp.web.student;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.command.student.StudentCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.MessageDom;
import caerusapp.domain.common.UpcomingEventsDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMessageManager;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CandidateCommonFeature;

@Controller
public class CandidateDashboardController {
	
	@Autowired 
	private ILoginManagement loginManagement;
	@Autowired
	IStudentManager studentManager;
	@Autowired
	IMessageManager messageManager;
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	@Autowired
	IStudentJobsManager studentJobsManager;
	@Autowired
	IUniversityManager universityManager;
	@Autowired
	IEmployerEventManager employerEventManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 *  This method is used to show Candidate Dashboard
	 */
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_DASHBOARD)
	public String getCandidateDashboard(@ModelAttribute("noJobsMessage") String noJobsMessage,HttpServletRequest request, HttpServletResponse response, Authentication authentication, ModelMap model) throws ParseException 
	{
		if(noJobsMessage != null && noJobsMessage.length() > 0)
			model.addAttribute("noJobsMessage",noJobsMessage);
			
		// Spring security authentication containing the logged in user details
		String candidateEmailId = authentication.getName();
		String authority = authentication.getAuthorities().toString();
		authority = authority.replace("[", "").replace("]", "");

		logger.info(candidateEmailId +" Logged In");
		
		String returnView = null;
		
		Device currentDevice = DeviceUtils.getCurrentDevice(request);
		
		UserBrowsingPatternsDom userBrowsingPatternsDom = new UserBrowsingPatternsDom();
		
		String firstName="",lastName="";
		
		// Retrieving logged in student details from the database
		StudentDom student = studentManager.getDetailsByEmailId(candidateEmailId);
		
		StudentDom studentDom = studentManager.getStudentImage(candidateEmailId);
		
		student.setPhotoName(studentDom.getPhotoName());
		
		firstName = student.getFirstName();
		lastName = student.getLastName();
		boolean isFirstLogin = student.isFirstLogin();
		List<JobDetailsDom> recommendedJobs = new ArrayList<JobDetailsDom>();

		//String concatenatedName = firstName.concat(" ").concat(lastName);
		String concatenatedName = "";
		if(null!= firstName && null!= lastName ){
			concatenatedName = firstName.concat(" ").concat(lastName);
		}
		else {
			concatenatedName= "User";
		}
		
		// Added by RavishaG to store candidate's login details 
		HttpSession httpSession = request.getSession(true);	
		
		userBrowsingPatternsDom.setEmailId(candidateEmailId);
		
		if(null!= authority)
		loginManagement.addLoginDetails(userBrowsingPatternsDom,authority);
        
		httpSession.setAttribute("username", concatenatedName);
		httpSession.setAttribute("emailId", candidateEmailId);
		
		// Adding values to the model object
		model.addAttribute("username", concatenatedName);
		model.addAttribute("message", "Caerus Login Form example");
					
		int appliedJobCount = CandidateCommonFeature.getAppliedJobsCount(employerJobPostManager, studentJobsManager, candidateEmailId);
		model.addAttribute("countappliedjobs",appliedJobCount);
		
		int countRecommendedJobs = CandidateCommonFeature.getRecommendedJobCount(studentJobsManager,employerJobPostManager,candidateEmailId);
		model.addAttribute("countRecommendedJobs",countRecommendedJobs);
		
		/*Map<String,Date> savedJobIdsMap = studentJobsManager.getSavedJobIdsMap(emailId);
		model.addAttribute("savedJobIdsMap",savedJobIdsMap);*/
		
		List<String> savedJobIds = studentJobsManager.getSavedJobIds(candidateEmailId);
		model.addAttribute("savedJobIds",savedJobIds);
		
		//Creating list of domain object
		List<EmployerCampusJobPostDom> employerJobListForUniversity = null;
		List<EmployerCampusJobPostDom> campusInternshipList = null;
		List<UpcomingEventsDom> allEventsList = null;
    	
		//** To Display the Age on Dashboard Page*//*
		if(student.getDateOfBirth()!=null)
		{
			int age = 0;
			age = CaerusCommonUtility.getAge(student.getDateOfBirth());
		    student.setAge(age);
		}
		
		model.addAttribute("studentProfile", student);
		
		 //Retrieve unread Message Count for dash board
		 int newMessageCount=0;
		 
		 List<List<MessageDom>> messageInboxList = messageManager.getMessage(candidateEmailId,authority);
		  
		 for (List<MessageDom> messageRelayList : messageInboxList) 
		 {
			 // For each individual Message Chain
			 for (MessageDom message : messageRelayList) 
			 {
				   if(candidateEmailId.equalsIgnoreCase(message.getReceiverEmailId()) && message.isRead()==false)
				   {
					 newMessageCount+=1;
				   }
			}
			 				
		}
			 
		httpSession.setAttribute("newMessageCount", newMessageCount);

		
		if(currentDevice.isNormal())
		{
			//Added by PallaviD to redirect student to candidate_portfolio.htm on first login 
			if(isFirstLogin == true)
				returnView = "redirect:candidate_portfolio.htm";
			
			else 
			{
				recommendedJobs = CandidateCommonFeature.getRecommendedJobs(studentJobsManager, employerJobPostManager, candidateEmailId, recommendedJobs);
				List<JobDetailsDom> sortedRecommendedJobs = CaerusCommonUtility.sortListByDateReverse(recommendedJobs, "JobDetailsDom");
				
				if (sortedRecommendedJobs != null && !sortedRecommendedJobs.isEmpty()) 
				{
					//** To Display The Difference of Days and Hours elapsed since the posting time(Recent Ones on Top i.e A job posted one day ago would appear above job posted before 2 days) *//*
	 	            for(JobDetailsDom employerJobPost : sortedRecommendedJobs) 
	 	            {
	 	            	employerJobPost.setDifferenceInDays((CaerusCommonUtility.getDifferenceInDays("E MMM dd HH:mm:ss Z yyyy",employerJobPost.getPostedOn())));
	 	            }
					
	    			if(sortedRecommendedJobs != null && sortedRecommendedJobs.size()>6)
					{
						model.addAttribute("recommendedjobs", sortedRecommendedJobs.subList(0,6));
					}
					else
					{
						model.addAttribute("recommendedjobs", sortedRecommendedJobs);	
					}
				}
				
				if(student.getGender()!=null)
				{
					if(student.getGender().equals("Male"))
						student.setGender("M");
					else
						student.setGender("F");
				}
				
				
			
		    	/*List<VirtualFairDom> virtualFairList=new ArrayList<VirtualFairDom>();
		    	virtualFairList=candidateCommonFeature.getVirtualFairList(loggedInUserEmailId,virtualFairManager);
		    		 
				int virtualEventCount = 0;
			
				// Retrieving the details of virtual jobfairs for the candidate
				if(virtualFairList!=null)
				{
					virtualFairList=candidateCommonFeature.getVirtualFairDetails(virtualFairList, virtualFairManager);
				}
			
				model.addAttribute("virtualFairDetails",virtualFairList);
				
				if(!virtualFairList.isEmpty())
				{
					virtualEventCount = virtualFairList.size();
				}
				
				model.addAttribute("virtualEvents",virtualEventCount);*/
				
				
				Map<String,Object> recentActivitiesSubMapSorted = new HashMap<String, Object>();
				
				// Retrieving the recent activites performed by a student
				recentActivitiesSubMapSorted = CandidateCommonFeature.getRecentActivitiesMap(studentManager, candidateEmailId);
				model.addAttribute("recentActivitiesMapSorted",recentActivitiesSubMapSorted);
				
		    	/*List<UpcomingEventsDom> allEventsList = candidateCommonFeature.getEventList(universityManager,employerEventManager,universityName);
		    			
		    	int count = allEventsList.size();
		    	//Adding objects in model to retrieve details on jsp
				model.addAttribute("eventsCount",count);
				
				if(count > 3)
				{
					model.addAttribute("upcomingEventsList",allEventsList.subList(0, 3));
				}
				else
				{
					model.addAttribute("upcomingEventsList",allEventsList);
				}*/
		    	
				
			HashMap<String, Object> viewedByCompaniesMap = studentManager.getViewedByCompaniesList(candidateEmailId);
			if(null!= viewedByCompaniesMap)
				model.addAttribute("viewedByCompaniesCount", viewedByCompaniesMap.size());
			StudentCom studentCom = new StudentCom();
			BeanUtils.copyProperties(student, studentCom);
			model.addAttribute("addStudent", studentCom);
			
			//To exclude virtual job events
			model.addAttribute("eventsCount", 0);
			returnView = "candidate/candidate_dashboard";
			}
		}
		
		//Added by RavishaG to redirect student to candidate_detail_view.htm on first login for mobile devices
		else
		{
			if(isFirstLogin)
				 returnView = "";
			else 
			{
				String universityName=universityManager.getUniversityForRegisteredStudent(candidateEmailId);
		    	
		    	if(universityName != null)
		    	{
		    		employerJobListForUniversity = universityManager.getCampusJobs(universityName);
		    		campusInternshipList = universityManager.getCampusInternships(universityName);
		    		allEventsList = CandidateCommonFeature.getEventList(universityManager,employerEventManager,universityName);
		    	}
		    	
		    	model.addAttribute("employerJobListForUniversity",employerJobListForUniversity);
		    	model.addAttribute("campusInternshipList",campusInternshipList);
		    	model.addAttribute("upcomingEventsCount",allEventsList.size());
		    	
		    	returnView = "candidate/candidate_dashboard";
			}
			
		}
		
		logger.info(CaerusLoggerConstants.STUDENT_LOGIN);
		
		model.addAttribute("searchJobs", new JobDetailsCom());

		return returnView;
	}

	/**
	 * @author balajii
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return String(redirect:candidate_dashboard.htm)
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_DASHBOARD_SKILLS_UPDATE)
	public String updateSkills(@ModelAttribute("addStudent") StudentCom addStudent,BindingResult bindingResult, 
			Model model , HttpServletRequest httpServletRequest,RedirectAttributes redirectAttributes)
	{
		/** Getting Logged In Username Using Spring Security */
		Authentication springAuthentication = SecurityContextHolder.getContext().getAuthentication();
		String candidateEmailId = springAuthentication.getName();
		addStudent.setEmailID(candidateEmailId);
		
		StudentDom studentUpdatedSkills = new StudentDom();
		BeanUtils.copyProperties(addStudent, studentUpdatedSkills);
		
		/** Updating Student Profile Details */
		studentManager.updateSkills(studentUpdatedSkills);
		
		logger.error(CaerusLoggerConstants.CANDIDATE_DASHBOARD_SKILLS_UPDATE);
		redirectAttributes.addFlashAttribute("noJobsMessage","We Don't have Jobs Matching your Skills. Please Update your Skills or Visit us Later.");
		return "redirect:candidate_dashboard.htm";
	}
}
