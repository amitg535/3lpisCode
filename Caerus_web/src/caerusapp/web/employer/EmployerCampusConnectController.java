package caerusapp.web.employer;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.university.UniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.MailUtil;

@Controller
public class EmployerCampusConnectController {

	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	UniversityManager universityManager;
	
	@Autowired
	IEmployerEventManager employerEventManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	@Autowired
	MailUtil mailUtil;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_CAMPUS_CONNECT,method = RequestMethod.GET)
	String loadCampusConnectPage(@RequestParam(value = "selected",required = false) String selected,Model model,HttpServletRequest request){
		
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null)
			companyName = request.getSession().getAttribute("compName").toString();
		
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);
		
		if(selected != null && selected.equals("receivedInvitations"))
		{
			@SuppressWarnings("unchecked")
			List<UniversityEventDom> universityEvents = employerEventManager.getEventsByCompanyName(companyName);
			
			 for (int i = universityEvents.size()-1 ; i >= 0; i--) {
			    	
			    	String universityEventStatus = universityManager.getEventStatus(universityEvents.get(i).getEventId());
			    	universityEvents.get(i).setStatus(universityEventStatus);
			    	
				}
			model.addAttribute("universityInvitations", true);
			model.addAttribute("universityEvents",universityEvents);
		}
		else
		{
			List<EmployerEventDom> employerEvents = employerEventManager.getEmployerEvents(companyName);
			model.addAttribute("employerEvents",employerEvents);
		}
		model.addAttribute("employerDetails",employerDetails);
		model.addAttribute("displayDateFormat",CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
		model.addAttribute("dbDateFormat",CaerusAPIStringConstants.DB_DATE_FORMAT);
				
		return CaerusJSPMapper.EMPLOYER_CAMPUS_CONNECT;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPDATE_INVITATION_STATUS)
	public String updateInvitationStatus(@RequestParam("eventId") String eventId,@RequestParam("status") String status,
		@RequestParam("univEmail")String universityEmailId,@RequestParam("eventName")String eventName) throws IOException{
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInEmployerEmail = authentication.getName();
		
		String companyName= loginManagement.getEntityNameByEmailId(loggedInEmployerEmail);
		
		//Accept or Reject the event
		if(status.equalsIgnoreCase("Undo"))
				status="Pending";
		if(status.equalsIgnoreCase("Accept") || status.equalsIgnoreCase("Accepted") )
			status="Accepted";
		if(status.equalsIgnoreCase("Reject") || status.equalsIgnoreCase("Rejected") )
			status="Rejected";
		employerEventManager.updateEventStatus(companyName, eventId, status);

    	//MailUtil.sendMailAboutEventStatus(universityEmailId, loggedInEmployerEmail, eventId, status, eventName);
		
		//Sending e-mail to the university with the status (accepted or rejected the event)
		Document document = CaerusCommonUtil.eventUpdateMailTemplate();
		
		if(status.equalsIgnoreCase("undo"))
    		document.getElementById("username").append(companyName+ " has reverted the status for the event " + eventName);
		
    	else
    		document.getElementById("username").append(companyName+ " has " + status + " the invitation for the event " + eventName);
		
		mailUtil.sendMailToUsers(universityEmailId, document.toString(), "Event Status Update");
		
    	return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_CAMPUS_CONNECT+"?selected=receivedInvitations";
	}
}