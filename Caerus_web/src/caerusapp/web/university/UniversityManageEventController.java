/**
 * 
 */
package caerusapp.web.university;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to display the list of upcoming events for a university
 * @author TrishnaR
 *
 */

@Controller
public class UniversityManageEventController
{
	//
	@Autowired
	private IUniversityManager universityManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to fetch the list of upcoming events for a university from the database
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_MANAGE_SCHEDULED_EVENTS)
	public ModelAndView handleRequest(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		logger.info(CaerusLoggerConstants.UPCOMING_EVENTS);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.UNIVERSITY_MANAGE_SCHEDULED_EVENTS);
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
		Date todaysDate = new Date(); 
		List<UniversityEventDom> upcomingEvents = new ArrayList<UniversityEventDom>();
		List<UniversityEventDom> closedEvents = new ArrayList<UniversityEventDom>();
		List<UniversityEventDom> ongoingEvents = new ArrayList<UniversityEventDom>();
		String defaultDateTimeFormat = CaerusAPIStringConstants.DB_DATE_FORMAT;
		String timePickerFormat = "hh:mm a";
	    
	    // Retrieving the upcoming event details for a university from the database
		List<UniversityEventDom> allEvents = universityManager.getEventList(emailId);
		
		if(null != allEvents)
		{
			for (UniversityEventDom eventDetails : allEvents) 
			{
				Date eventStartDate = CaerusCommonUtility.stringToDate(eventDetails.getStartDate(), defaultDateTimeFormat);
				Date eventStartTime = CaerusCommonUtility.stringToDate(eventDetails.getStartTime(), timePickerFormat);
				
				Long startDateTime = eventStartDate.getTime()+eventStartTime.getTime();
				
				Date eventEndDate = CaerusCommonUtility.stringToDate(eventDetails.getEndDate(),defaultDateTimeFormat);
				Date eventEndTime = CaerusCommonUtility.stringToDate(eventDetails.getEndTime(), timePickerFormat);
				
				Long endDateTime = eventEndDate.getTime()+eventEndTime.getTime();
				
				List<UniversityEventDom> invitedCompanyListEvent = universityManager.getInvitedListByEventId(eventDetails.getEventId());
				Map<String,String> invitedCompanyWithStatus = new HashMap<String,String>();

				for (UniversityEventDom invitedCompany : invitedCompanyListEvent) {
						invitedCompanyWithStatus.put(invitedCompany.getInviteCompanyName(),invitedCompany.getInvitationStatus());
					}
				eventDetails.setCompanyNameStatusMap(invitedCompanyWithStatus);
				
				if(eventStartDate.compareTo(todaysDate) > 0)
				{
					StringBuilder differenceInDays = CaerusCommonUtility.calculateDateDifference(defaultDateTimeFormat, startDateTime);
					eventDetails.setDaysRemaining(differenceInDays);
					upcomingEvents.add(eventDetails);
				}
				
				
				if(todaysDate.compareTo(eventEndDate) > 0)
				{
					closedEvents.add(eventDetails);
				}
				
				if((todaysDate.equals(eventStartDate)||todaysDate.after(eventStartDate)) && todaysDate.before(eventEndDate)) 
				{
					StringBuilder differenceInDays = CaerusCommonUtility.calculateDateDifference(defaultDateTimeFormat, endDateTime);
					eventDetails.setDaysRemaining(differenceInDays);
					ongoingEvents.add(eventDetails);		
				}
			}
		}
		
		// Adding values to the modelAndView object
		modelAndView.addObject("upcomingEvents", upcomingEvents);
		modelAndView.addObject("ongoingEvents", ongoingEvents);
		modelAndView.addObject("closedEvents", closedEvents);
		
		// Returning the modelAndView object
		return modelAndView;	
	}
}