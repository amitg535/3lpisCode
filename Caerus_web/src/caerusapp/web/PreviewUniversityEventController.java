







/**
 * 
 */
package caerusapp.web;

import java.io.File;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to preview the university event for all the three roles(University,Employer,Candidate)
 * @author TrishnaR
 *
 */
@Controller
public class PreviewUniversityEventController {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired 
	IUniversityManager universityManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	/**
	 * This method is used to preview the university event for all the three roles(University,Employer,Candidate)
	 * @param eventId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @param model
	 * @return
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.PREVIEW_UNIVERSITY_EVENT,method=RequestMethod.GET)
	public String previewUniversityEvent(@RequestParam(value = "eventId", required=false) String eventId,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse,Model model)
	{
		logger.info(CaerusLoggerConstants.EVENT_DETAILS);
		
		// Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		HttpSession httpSession = httpServletRequest.getSession();
		String emailId = authentication.getName();
		
		String authority = authentication.getAuthorities().toString();
		int mid = authority.lastIndexOf("_");
		String role = authority.substring(mid+1, authority.length()-1);
		
		String fileName = "2"; //Setting the default fileName to 2 as the default div id would be 2.
		boolean showPublishButton = false;
		String acceptedTimeString = null;
		
		//Fetching parameter value from request
		if(eventId==null || eventId.length()==0)
		{
			eventId = (String) httpSession.getAttribute("eventId");
			showPublishButton = true;
		}
		
		
		// Retrieving jobfair event details from the database based on the eventId
		UniversityEventDom eventDetails = universityManager.getScheduleEventByEventId(eventId);
		
		
		//Fetching the Theme Template File name to render the div id
		String templateName = eventDetails.getTemplateName();
		if(templateName!=null)
		{
			File file = new File(templateName);
			fileName = file.getName();
			int position = fileName.lastIndexOf(".");
			if (position > 0)
			{
			    fileName = fileName.substring(0, position);
			}
		}
			
		eventDetails.setDivId(fileName);
		
		if(showPublishButton == true)
		{
			eventDetails.setShowPublish(true);
		}
		
		//Code to be executed if the logged in user is a Corporate
		if(role.equals("CORPORATE"))
		{
			List<UniversityEventDom> invitedCompanyDetails = universityManager.getInvitedListByEventId(eventId);
			for (int i = invitedCompanyDetails.size()-1; i >= 0; i--)
		    {
		    	if((invitedCompanyDetails.get(i).getInviteCompanyName()).equalsIgnoreCase(httpServletRequest.getSession().getAttribute("compName").toString()))
		    	{
		    		//Retreiving the invitation status for the logged in Corporate User
		    		model.addAttribute("inivitationStatus", invitedCompanyDetails.get(i).getInvitationStatus());
		    		 if(invitedCompanyDetails.get(i).getTime() != null)
		    		 {
		    		    String date = "";
						try 
						{
							date = CaerusCommonUtility.parseTimestampToDate(invitedCompanyDetails.get(i).getTime());
						} catch (ParseException e) 
						{
							e.printStackTrace();
						}
		    		    model.addAttribute("date",date);
		    		 }
		    	}
		    }
		}
		
		//Code to be executed if the logged in user is a Candidate
		if(role.equals("STUDENT"))
		{
			model.addAttribute("studentEmailId", emailId);
			// Retrieving accepted time for event
			if(eventDetails.getAcceptedByStudentsList() != null && eventDetails.getAcceptedByStudentsList().contains(emailId))
			{
				//Timestamp acceptedTime = universityManager.getEventAcceptedTime(emailId,eventDetails.getEventName(),eventDetails.getUniversityId());
				
				Date  acceptedTime = universityManager.getEventAcceptedTime(emailId,eventDetails.getEventName(),eventDetails.getUniversityId());
				
				if(acceptedTime!=null)
				acceptedTimeString = acceptedTime.toString().substring(0, acceptedTime.toString().lastIndexOf(':'));
				model.addAttribute("acceptedTime",acceptedTimeString);
				
			}
		}

		// Retrieving university details from the database based on the university Id 
		//UnivesityRegisterationDom universityDetails= universityManager.getUniversityDetailsByEmailId(eventDetails.getUniversityId()); 
		
		UniversityDetailsDom universityDetails = universityManager.getUniversityDetailsByName(eventDetails.getUniversityName());
		
		// Set university email id from user table
		LoginManagementDom adminDetails = loginManagement.getAdminByEntityName(eventDetails.getUniversityName());
		universityDetails.setContactPersonEmailId(adminDetails.getUserName());
		
		//Retrieving the List of corporates that have accepted the event invitation
		List<UniversityEventDom> attendingCorporates = universityManager.getAttendingCorporateList(eventId);
		
		for (UniversityEventDom universityEventDom : attendingCorporates) {
			LoginManagementDom loginManagementDom = loginManagement.getAdminByEntityName(universityEventDom.getInviteCompanyName());
			universityEventDom.setFirmId(loginManagementDom.getUserName());
		}
		
		String locAddress = universityDetails.getUniversityAddress() + " " + universityDetails.getCity();
		
		model.addAttribute("locAddress", locAddress);
		model.addAttribute("cityLoc", universityDetails.getCity());
		model.addAttribute("eventDetails",eventDetails);
		model.addAttribute("universityDetails",universityDetails);
		model.addAttribute("attendingCorporates",attendingCorporates);
	
		return CaerusJSPMapper.COMMON_PREVIEW_UNIVERSITY_EVENT;
	}

}
