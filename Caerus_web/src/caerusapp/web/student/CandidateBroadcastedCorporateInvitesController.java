package caerusapp.web.student;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.UpcomingEventsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to show candidate broadcasted event details
 * @author RavishaG
 *
 */
@Controller
public class CandidateBroadcastedCorporateInvitesController {

	//Auto-wiring service component
	@Autowired
	IEmployerEventManager employerEventManager;
	@Autowired
	IStudentManager studentManager;
	@Autowired
	IUniversityManager universityManager;
	@Autowired
	IEmployerManager employerManager;
	
	
	//Logger for this class and subclasses
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * This method is used show candidate list of events by corporates and universities
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 * @throws ParseException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_PREVIEW_BROADCASTED_CORPORATE_INVITES)
	public ModelAndView candidateBroadcastedCorporateInvitesController(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ParseException
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
	   
	    //The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_preview_broadcasted_invites");		
		
    	String universityName = universityManager.getUniversityForRegisteredStudent(studentEmailId);	
		
		List<UpcomingEventsDom> allEventsList = CandidateCommonFeature.getEventList(universityManager,employerEventManager,universityName);
		
		int count = allEventsList.size();
    	
    	//Adding objects in model to retrieve details on jsp
		modelAndView.addObject("count",count);
    	modelAndView.addObject("allEventsList", allEventsList);
    	modelAndView.addObject("studentEmailId",studentEmailId);
	        
        logger.info(CaerusLoggerConstants.UPCOMING_EVENTS);
        
        return modelAndView;
	}
	
	/**
	 * This method is used to show corporate event details to candidate
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_PREVIEW_BROADCASTED_CORPORATE_INVITE_DETAILS)
	public ModelAndView candidatePreviewBroadcastedCorporateInviteDetails(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
		
		 //The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelandview = new ModelAndView("candidate/candidate_preview_received_corporate_invite");
		String event_id = "";
		
		
		if(httpServletRequest.getParameter("event_id") != null){
			event_id= (String) httpServletRequest.getParameter("event_id");
		}else {
			HttpSession session= httpServletRequest.getSession(true);
			event_id= (String) session.getAttribute("event_id");
		}		
		
		if (event_id != null)
		{
			EmployerEventDom eventDetails=employerEventManager.getEmployerEventDetails(event_id);
			
		
			EmployerDom employerDetails = employerManager.getEmployerDetails(eventDetails.getCompanyName());
			
			
			String acceptedTimeString = null;
			
			// Retrieving accepted time for event
			if(eventDetails.getAcceptedByStudentsList() != null && eventDetails.getAcceptedByStudentsList().contains(studentEmailId))
			{
				Date acceptedTime = universityManager.getEventAcceptedTime(studentEmailId,eventDetails.getEventName(), eventDetails.getEmailId());
				if(acceptedTime!=null)
				acceptedTimeString = acceptedTime.toString().substring(0, acceptedTime.toString().lastIndexOf(':'));
				
				modelandview.addObject("acceptedTime", acceptedTimeString);
			}
			
			modelandview.addObject("eventDetails", eventDetails);
			modelandview.addObject("employerDetails", employerDetails);
			
			modelandview.addObject("studentEmailId",studentEmailId);

		}
		
		logger.info(CaerusLoggerConstants.EVENT_DETAILS);
		return modelandview;
	}
	
	
	
	/**
	 * This method is used to update action as accepted or denied on corporate event
	 * @author RavishaG
	 * @param eventId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UPDATE_CANDIDATE_ACTION_ON_CORPORATE_EVENT)
	public void updateCorporateEvent(@ModelAttribute("employerEventDom") EmployerEventDom employerEventDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
	    
	    String universityName = universityManager.getUniversityForRegisteredStudent(studentEmailId);
	    
	    employerEventDom.setParticipatingUniversity(universityName);
	    
	    // Update action as accept or reject in the database
	    employerEventManager.updateCandidateActionOnCorporateEvent(employerEventDom,studentEmailId);
	    
	}
	
	/**
	 * This method is used to update action as accepted or denied on university event 
	 * @author RavishaG
	 * @param eventId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UPDATE_CANDIDATE_ACTION_ON_UNIVERSITY_EVENT)
	public void updateUniversityEvent(@ModelAttribute("universityEventDom") UniversityEventDom universityEventDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
	    
	    String universityName = universityManager.getUniversityForRegisteredStudent(studentEmailId);
	    
	    universityEventDom.setUniversityName(universityName);
	    
	    // Update action as accept or reject in the database
	    universityManager.updateCandidateActionOnUniversityEvent(universityEventDom,studentEmailId);
	    
	}

	
	/**
	 * This method is used to revert action on corporate event 
	 * @author RavishaG
	 * @param eventId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNDO_ACTION_ON_CORPORATE_EVENT)
	public void undoCorporateEvent(@ModelAttribute("employerEventDom") EmployerEventDom employerEventDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
	    
	    // Undo previous action in the database
	    employerEventManager.revertCandidateActionOnCorporateEvent(studentEmailId,employerEventDom);
	    
	}
	
	/**
	 * This method is used to revert action on university event 
	 * @author RavishaG
	 * @param eventId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNDO_ACTION_ON_UNIVERSITY_EVENT)
	public void undoUniversityEvent(@ModelAttribute("universityEventDom") UniversityEventDom universityEventDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String studentEmailId = auth.getName();
	    
	    // Undo previous action in the database
	    universityManager.revertCandidateActionOnUniversityEvent(studentEmailId,universityEventDom);
	    
	}
	
}