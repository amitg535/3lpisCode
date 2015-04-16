package caerusapp.web.university;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;

@Controller
public class UniversityManageInvitationsController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;

	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IEmployerEventManager employerEventManager;
	
	@Autowired
	MailUtil mailUtil;
	/**
	 * This method is used to fetch the list of corporate invites received by a university from the database
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_MANAGE_CORPORATE_INVITATIONS)
	public String getCorporateInvitations(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		    String universityName = "";
		    
		    if(request.getSession().getAttribute("univName") != null && !request.getSession().getAttribute("univName").equals(""))
		    	universityName = request.getSession().getAttribute("univName").toString();

		    List receivedEvents =  universityManager.getEventListByUniversityName(universityName);
		    logger.info(CaerusLoggerConstants.CAMPUS_INVITES);
		    
		    model.addAttribute("dbDateFormat",CaerusAPIStringConstants.DB_DATE_FORMAT);
		    model.addAttribute("displayDateFormat",CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
		    model.addAttribute("eventList", receivedEvents); 
		    return CaerusJSPMapper.UNIVERSITY_MANAGE_RECEIVED_INVITATIONS;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_UPDATE_CORPORATE_INVITATION_STATUS)
	ModelAndView updateCorporateInvitationStatus(@RequestParam("eventId") String eventId,@RequestParam("action") String status,
			@RequestParam(value="eventName",required=false) String eventName, HttpServletRequest request)
	{
		 String universityName = "";
		    
		 if(request.getSession().getAttribute("univName") != null && !request.getSession().getAttribute("univName").equals(""))
		    	universityName = request.getSession().getAttribute("univName").toString();
		    
		universityManager.updateCorporateInvitationStatus(eventId,status);
		
		String corporateEmailId = employerEventManager.getEmployerEmailIdbyEventId(eventId);
		
		if(!(status.equalsIgnoreCase("Broadcasted") || status.equalsIgnoreCase("Broadcast")))
		{
			Document document = CaerusCommonUtil.eventUpdateMailTemplate();
			
			if(status.equalsIgnoreCase("undo") || status.equalsIgnoreCase("UndoBroadcast"))
	    		document.getElementById("username").append(universityName+ " has reverted the status for the event " + eventName);
			
	    	else
	    		document.getElementById("username").append(universityName+ " has " + status + " the invitation for the event " + eventName);
			
			try 
			{
				/*MailUtil.sendMailToUsers(corporateEmailId, document.toString(), "Event Status Update");*/
				mailUtil.sendMailToUsers(corporateEmailId, document.toString(), "Event Status Update");
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		}
		return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.UNIVERSITY_MANAGE_CORPORATE_INVITATIONS));
		//return "redirect:"+CaerusAnnotationURLConstants.UNIVERSITY_MANAGE_CORPORATE_INVITATIONS;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_PREVIEW_CORPORATE_INVITATION)
	String previewCorporateInvitation(@RequestParam("eventId") String eventId, Model model){
		EmployerEventDom eventDetails = employerEventManager.getEmployerEventDetails(eventId);
		
		EmployerDom employerDetails = employerManager.getEmployerDetails(eventDetails.getCompanyName());
		model.addAttribute("eventDetails",eventDetails);
		model.addAttribute("employerDetails",employerDetails);
		
		return CaerusJSPMapper.UNIVERSITY_PREVIEW_CORPORATE_INVITATION ;
	}

}
