/**
 * 
 */
package caerusapp.web.university;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.university.UniversityDetailsCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;

/**
 * This class is used to display the university dashboard
 * @author KarthikeyanK
 * Annotated by BalajiI on 25/9/2014
 */
@Controller
public class UniversityDashboardController
{
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	List<EmployerCampusJobPostDom> campusJobs = null;

	List<EmployerCampusJobPostDom> campusInternships = null;
	
	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	private IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	private IEmployerEventManager employerEventManager;
	
	@Autowired 
	private ILoginManagement loginManagement;
	
	@Autowired
	MailUtil mailUtil;
	
	/** Contains the Broadcasted Job/Internship Status */
	private final String BROADCAST_JOB = "Broadcasted";
	
	/**
	 * This method is used to broadcast a campus job.
	 * @author balajii
	 * @param jobId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return Boolean(successFlag)
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_BROADCAST_JOB,method=RequestMethod.POST)
	@ResponseBody
	public Boolean broadcastJob(@RequestParam("jobId") String jobId,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		boolean successFlag = false;
		
		HttpSession session = httpServletRequest.getSession();
		// Setting values in the session
		String universityName = (String) session.getAttribute("univName");
		
		try
		{
			/** Updating the status of Job */
			universityManager.updateCampusJobStatus(jobId,universityName,BROADCAST_JOB);
			
			employerJobPostManager.updateSeenByUniversityFlag(jobId,universityName);
			
			successFlag = true;
			logger.info(universityName +" " +CaerusLoggerConstants.UNIVERSITY_BROADCAST_JOB +" With Id "+jobId);
		}
		catch(Exception ex)
		{
			logger.error(ex.getLocalizedMessage());
		}
		return successFlag;
	}
	
	/**
	 * This method is used to broadcast a campus internship.
	 * @author balajii
	 * @param internshipId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return Boolean(successFlag)
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_BROADCAST_INTERNSHIP,method=RequestMethod.POST)
	@ResponseBody
	public Boolean broadcastInternship(@RequestParam("internshipId") String internshipId,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		boolean successFlag = false;
	
		//getting new session		
		HttpSession session = httpServletRequest.getSession();
		// Setting values in the session
		String universityName = (String) session.getAttribute("univName");
		
		try
		{
			/** Updating the status of Internship */
			universityManager.updateCampusInternshipStatus(internshipId,universityName,BROADCAST_JOB);
			successFlag = true;
			logger.info(CaerusLoggerConstants.UNIVERSITY_BROADCAST_INTERNSHIP);
		}
		catch(Exception ex)
		{
			logger.error(ex.getLocalizedMessage());
		}
		return successFlag;
	}
	
	
	
	/**
	 * This method is used to fetch all the data from the database that is to be displayed on the university dashboard
	 */
	
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_DASHBOARD)
	public ModelAndView handleRequest(HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		// Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String universityEmailId = authentication.getName();
		
		logger.info(universityEmailId +" Logged In");
		
		List<GrantedAuthority> authorityList = (List<GrantedAuthority>) authentication.getAuthorities();
		String authority = null;
		Iterator<GrantedAuthority> itr = authorityList.iterator();

		while (itr.hasNext()) 
		{
			authority = itr.next().toString();
		}

		UserBrowsingPatternsDom userBrowsingPatternsDom = new UserBrowsingPatternsDom();
		
		//Fetch user details by emailID
		LoginManagementDom loginManagementDom =loginManagement.getUserDetailsByEmailID(universityEmailId);
		
		if(null != loginManagementDom && loginManagementDom.isAdminFlag())
		{
			request.getSession().setAttribute("isAdmin", true);
		}
	    
		String universityName = loginManagementDom.getEntityName();
		String universityUserName = "";
		if(null!= loginManagementDom.getFirstName() && null!= loginManagementDom.getLastName()){
			
			universityUserName = loginManagementDom.getFirstName()+ " "+loginManagementDom.getLastName();
		}
		else {
			universityUserName= "User";
		}
		
		
		// Creating a new session
		HttpSession session = request.getSession();
		
		// Setting values in the session
		session.setAttribute("univName", universityName);
		session.setAttribute("username", universityUserName);
		
		userBrowsingPatternsDom.setEmailId(universityEmailId);
		
		loginManagement.addLoginDetails(userBrowsingPatternsDom,authority);
		
		// Fetching parameter value from request
		String eventId = request.getParameter("event_id");
		String jobId = request.getParameter("job_id");
		String jobAction = request.getParameter("job_action");
	    String internshipId = request.getParameter("internship_id");
	    String internshipAction = request.getParameter("internship_action");
		String action = request.getParameter("action");

		logger.info(CaerusLoggerConstants.DASHBOARD_LOGGER);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("university/university_dashboard");

		
		
		
		// Fetching the device type(mobile,tablet,web)
			Device deviceType=(Device)DeviceUtils.getCurrentDevice(request);
			
			if(deviceType.isNormal()){
				
				// check if the job id and action are not null, then update the status of the job based on the job id and university name
			    if(jobId!= null && jobAction!=null)
			    {
			    	universityManager.updateCampusJobStatus(jobId,universityName,jobAction);
			    }
			    
			    // check if the internship id and action are not null, then update the status of the internship based on the internship id and university name
			    if( internshipId != null && internshipAction != null)
			    {
			    	universityManager.updateCampusInternshipStatus(internshipId,universityName,internshipAction);
			    }
			    
				if (universityEmailId != null) {

					// Retrieving list of jobs and its details posted for the university
					campusJobs = universityManager.getCampusJobs(universityName);
					
					campusJobs = CaerusCommonUtility.sortListByDateReverse(campusJobs, "EmployerCampusJobPostDom");

					// Retrieving list of internships and its details posted for the university
					campusInternships = universityManager.getCampusInternships(universityName);
					campusInternships = CaerusCommonUtility.sortListByDateReverse(campusInternships, "EmployerCampusJobPostDom");
					
						List<EmployerCampusJobPostDom> seenCampusJobsList = new ArrayList<EmployerCampusJobPostDom>();
						
						if (campusJobs != null && campusInternships != null) 
						{
							// Adding values to the modelAndView Object
							
							for (EmployerCampusJobPostDom campusJob : campusJobs) {
								
								if(campusJob.isSeenByUniversityFlag() == false)
								{
									seenCampusJobsList.add(campusJob);
								}
							}
							
							int campusJobCount = 0;
							if(null != campusJobs && campusJobs.size() > 0)
								campusJobCount = campusJobs.size();
							
							modelAndView.addObject("campusJobs",campusJobs);
							modelAndView.addObject("campusInternships",campusInternships);
							modelAndView.addObject("newJobAlerts",seenCampusJobsList.size());
							
							int campusInternshipCount = 0;
							if(null != campusInternships && campusInternships.size() > 0)
								campusInternshipCount = campusInternships.size();
							
							modelAndView.addObject("campusJobCount",campusJobCount);
							modelAndView.addObject("campusInternshipCount",campusInternshipCount);

						}
					
					if (null != eventId && eventId.trim().length() > 0) {

						// Creating a domain object 
						EmployerEventDom employerEventDom = new EmployerEventDom();
						
						// Fetching event details from the database
						employerEventDom = employerEventManager.getEmployerEventDetails(eventId);

						// Change the status of the event depending on the action
						universityManager.updateCorporateInvitationStatus(eventId, action);

						// Update Email send to Employers regarding the event status
						/*MailUtil.sendResponseToEmployers(employerEventDom.getEmailId(),
								employerEventDom.getCompanyName(),
								employerEventDom.getInvitationStatus(),
								employerEventDom.getEventId(),
								employerEventDom.getEventName(),
								employerEventDom.getParticipatingUniversity());*/
						
						if(!(action.equalsIgnoreCase("Broadcasted") || action.equalsIgnoreCase("Broadcast")))
						{
							Document document = CaerusCommonUtil.eventUpdateMailTemplate();
							
							if(action.equalsIgnoreCase("undo") || action.equalsIgnoreCase("UndoBroadcast"))
					    		document.getElementById("username").append(universityName+ " has reverted the status for the event " + employerEventDom.getEventName());
							
					    	else
					    		document.getElementById("username").append(universityName+ " has " + action + " the invitation for the event " + employerEventDom.getEventName());
							
							/*MailUtil.sendMailToUsers(employerEventDom.getEmailId(), document.toString(), "Event Status Update");*/
							mailUtil.sendMailToUsers(employerEventDom.getEmailId(), document.toString(), "Event Status Update");
						}
					}
					
				
					// Retrieving list of events and its details from the database
					List<EmployerEventDom> eventList = universityManager.getEventListByUniversityName(universityName);

					if(eventList != null && eventList.size() > 0)
					eventList = CaerusCommonUtility.sortListByDateReverse(eventList, "EmployerEventDom");

					// Retrieving the number of upcoming events for the university
					int noOfUpcomingEvents = universityManager.getNoOfUpcomingEvents(universityEmailId);

					// Retrieving the number of pending invitations for the university
					int pendingInvitations = universityManager.getNoOfPendingInvitations(universityName);

					// Adding values to the modelAndView Object
					modelAndView.addObject("eventList", eventList);
					
					modelAndView.addObject("noOfUpcomingEvents", noOfUpcomingEvents);
					
					modelAndView.addObject("pendingInvitations", pendingInvitations);
				}
				
			}
			
			//For thin client fetch university profile on dashboard
			else {
				
				UniversityDetailsDom universityDetails=universityManager.getUniversityDetailsByName(universityName);
    			
    			// Creating a command object 
    			UniversityDetailsCom universityDetailsCom = new UniversityDetailsCom();
    			
    			// Setting values from value object(domain) to business objects(command)
    			universityDetailsCom.setUniversityName(universityDetails.getUniversityName());
    			universityDetailsCom.setUniversityRegistrationNumber(universityDetails.getUniversityRegistrationNumber());
    			universityDetailsCom.setPhoneNumber(universityDetails.getPhoneNumber());
    			universityDetailsCom.setUniversityAddress(universityDetails.getUniversityAddress());
    			universityDetailsCom.setZipCode(universityDetails.getZipCode());
    			universityDetailsCom.setState(universityDetails.getState());
    			universityDetailsCom.setCity(universityDetails.getCity());
    			universityDetailsCom.setUniversityWebsite(universityDetails.getUniversityWebsite());
    			universityDetailsCom.setAboutUs(universityDetails.getAboutUs());
    			universityDetailsCom.setUniversityLogoName(universityDetails.getUniversityLogoName());
    			universityDetailsCom.setAutumnStartDate(universityDetails.getAutumnStartDate());
    			universityDetailsCom.setAutumnEndDate(universityDetails.getAutumnEndDate());
    			universityDetailsCom.setSpringStartDate(universityDetails.getSpringStartDate());
    			universityDetailsCom.setSpringEndDate(universityDetails.getSpringEndDate());
    			universityDetailsCom.setSummerStartDate(universityDetails.getSummerStartDate());
    			universityDetailsCom.setSummerEndDate(universityDetails.getSummerEndDate());
    			universityDetailsCom.setNoOfResearchStaff(universityDetails.getNoOfResearchStaff());
    			universityDetailsCom.setNoOfSupportStaff(universityDetails.getNoOfSupportStaff());
    			universityDetailsCom.setNoOfTeachingStaff(universityDetails.getNoOfTeachingStaff());
    			universityDetailsCom.setUgFullTimeStudents(universityDetails.getUgFullTimeStudents());
    			universityDetailsCom.setUgPartTimeStudents(universityDetails.getUgPartTimeStudents());
    			universityDetailsCom.setPgFullTimeStudents(universityDetails.getPgFullTimeStudents());
    			universityDetailsCom.setPgPartTimeStudents(universityDetails.getPgPartTimeStudents());
    			universityDetailsCom.setAwardsAndRecognitionList(universityDetails.getAwardsAndRecognitionList());
    			universityDetailsCom.setCourseName(universityDetails.getCourseName());
    			universityDetailsCom.setCourseType(universityDetails.getCourseType());
    			
    			LoginManagementDom adminDetails = loginManagement.getUserDetailsByEmailID(universityEmailId);
    			universityDetailsCom.setContactPersonEmailId(adminDetails.getUserName());
    			universityDetailsCom.setContactPerson(adminDetails.getFirstName().concat(" ").concat(adminDetails.getLastName()));
    			
    			modelAndView.addObject("university", universityDetailsCom);
    			
    			modelAndView.addObject("logoName", universityDetails.getUniversityLogoName());
    			modelAndView.addObject("stateName", universityDetails.getState());
    			
    			
    			// Exception handling
    			try
    			{
    				//referenceDataMap.put("stateList",employeeManager.getStateList());
    			
    				if(universityDetails.getAwardsAndRecognitionList() != null && universityDetails.getAwardsAndRecognitionList().size() != 0)
    				{
    					modelAndView.addObject("recognitionListSize", universityDetails.getAwardsAndRecognitionList().size());
    				}
    				else
    				{
    					modelAndView.addObject("recognitionListSize",1);
    				}
    				
    				if(universityDetails.getCourseType() != null && universityDetails.getCourseType().size() != 0)
    				{
    					modelAndView.addObject("courseListSize", universityDetails.getCourseType().size());
    				}
    				else
    				{
    					modelAndView.addObject("courseListSize",1);
    				}
    				
    				
    				
    			}
    			catch(DataAccessException dae)
    			{
    				dae.printStackTrace();
    			}
    			
    			catch (Exception e) 
    			{
    			e.printStackTrace();	
    			}
				
			}
			
			modelAndView.addObject("dbDateFormat",CaerusAPIStringConstants.DB_DATE_FORMAT);
			modelAndView.addObject("displayDateFormat",CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
		// redirect to the defined view(page)
		   return modelAndView;
	}

	
}