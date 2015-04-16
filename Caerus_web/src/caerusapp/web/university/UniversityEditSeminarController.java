/**
 * 
 */
package caerusapp.web.university;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.university.UniversityEventCom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to edit Campus Seminars by university 
 */
@Controller
public class UniversityEditSeminarController 
{
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private IUniversityManager universityManager;

	/**
	 * This method is used to update the campus seminar details in the database
	 */
	
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_SEMINAR,method=RequestMethod.POST)
	public String onSubmit(@ModelAttribute("universityEventCmd")UniversityEventCom universityEventCmd,HttpServletRequest request,ModelMap model) throws ServletException 
	{
		
		logger.info(CaerusLoggerConstants.EDIT_SEMINAR);
		
		//Get session object from request
		HttpSession httpSession = request.getSession();
		//Fetching University Name from Session
		String universityName = (String) httpSession.getAttribute("univName");
		
		
		
		ArrayList<String> companyEmailList = new ArrayList<String>();
		ArrayList<String> companyNameList = new ArrayList<String>();
		
		String eventId = universityEventCmd.getEventId(); // getting the selected event Id value from form
		// Retrieving list of invited companies and their details for the campus jobfair
		List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
				
				// Iterating through the list of invited companies
			    Iterator<UniversityEventDom> itr = invitedCompanyListEvent.iterator();
			      while(itr.hasNext()) {
			    	  UniversityEventDom universityEventDom = itr.next();
			    	
			    	  companyEmailList.add(universityEventDom.getCompanyEmailId());   	

					  companyNameList.add(universityEventDom.getInviteCompanyName());
		    	  
			    }
		
		
		// Creating a domain object 
		UniversityEventDom universityEventDom = new UniversityEventDom();	
		
		// Setting values  from business objects(command) to value object(domain)
		universityEventDom.setEventId(universityEventCmd.getEventId());
		universityEventDom.setEndDate(universityEventCmd.getEndDate());
		universityEventDom.setStartDate(universityEventCmd.getStartDate());
		universityEventDom.setStatus(universityEventCmd.getStatus());
		universityEventDom.setStartTime(universityEventCmd.getStartTime());
		universityEventDom.setEndTime(universityEventCmd.getEndTime());
		universityEventDom.setVenue(universityEventCmd.getVenue());
		universityEventDom.setSpeakerName(universityEventCmd.getSpeakerName());
		universityEventDom.setTopic(universityEventCmd.getTopic());
		universityEventDom.setInvitedCompanies(companyNameList);
		universityEventDom.setCompanyName(companyNameList);
		universityEventDom.setUniversityName(universityName);

		// Updating the status of the campus jobfair in the database
		universityManager.updateSeminarEvent(universityEventDom);
		
		//Added a flag showPublish to show/hide the publish button
		universityEventDom.setShowPublish(true);
		httpSession.setAttribute("eventId", universityEventDom.getEventId());

		// Redirecting to success view 
		 ModelAndView modelAndView = new ModelAndView(new RedirectView(""));
		 
		 // Adding values to the modelAndView Object
		 modelAndView.addObject("universityEventCmd", universityEventCmd);
		 
		 // redirect to the defined view(page)
		 return "redirect:preview_university_event.htm"; 
	}
	
	/**
	 * This method is used to load the page with data
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_SEMINAR,method=RequestMethod.GET)
	public String getEditSeminarForm(@RequestParam("event_id")String eventId,@RequestParam("eventNamess") String eventName, HttpServletRequest request,ModelMap model)
	{
		// Spring security authentication containing the logged in user details
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailID = auth.getName(); //get logged in Email ID
	    

	    // Retrieving the seminar details from the database based on the event Id
	    UniversityEventDom universityEventDom = universityManager.getScheduleEventByEventId(eventId);
	    
	    UniversityEventCom universityEventCmd = new UniversityEventCom();    
	    
	    // Setting values from value object(domain) to business objects(command)
	    universityEventCmd.setEventId(universityEventDom.getEventId());
	    universityEventCmd.setEndDate(universityEventDom.getEndDate());
	    universityEventCmd.setEventName(universityEventDom.getEventName());
	    universityEventCmd.setEventType(universityEventDom.getEventType());
	    
	    if(!(universityEventDom.getInvitedCompanies() == null))
		{
		 StringBuilder sb = new StringBuilder();
	        for(String str : universityEventDom.getInvitedCompanies())
	        {
	            sb.append(str).append(","); //separating contents using semi colon
	        }
	      
	     String strfromArrayList = sb.toString();
		
	     universityEventCmd.setInviteCompanyName(strfromArrayList.substring(0,(strfromArrayList.lastIndexOf(","))));
		}
	    
	   // universityEventCmd.setInvitedCompanies(universityEventDom.getInvitedCompanies());
	    universityEventCmd.setStartDate(universityEventDom.getStartDate());
	    universityEventCmd.setStatus(universityEventDom.getStatus());
		universityEventCmd.setStartTime(universityEventDom.getStartTime());
		universityEventCmd.setEndTime(universityEventDom.getEndTime());
	    universityEventCmd.setVenue(universityEventDom.getVenue());
	    universityEventCmd.setSpeakerName(universityEventDom.getSpeakerName());
	    universityEventCmd.setSeminarCategory(universityEventDom.getSeminarCategory());
	    universityEventCmd.setTopic(universityEventDom.getTopic());
	    universityEventCmd.setInvitedCompanies(universityEventDom.getInvitedCompanies());
	   
	    // Formatting the date as per required format
	    DateFormat inputFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
		DateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		String startDate = universityEventDom.getStartDate();
		String endDate = universityEventDom.getEndDate();
		
		Date date = null;
		Date edate = null;
		
		// Exception handling
		try 
		{
			date = inputFormat.parse(startDate);
			edate = inputFormat.parse(endDate);
			
		} 
		catch (ParseException e)
		{
			e.printStackTrace();
		}
		String startDateFormat = outputFormat.format(date);
		String  endDateFormat = outputFormat.format(edate);

	    universityEventCmd.setStartDate(startDateFormat);
	   	universityEventCmd.setEndDate(endDateFormat);
	   	
	   	List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
	    
	    // Iterating through the list of invited companies
	    Iterator<UniversityEventDom> itr = invitedCompanyListEvent.iterator();
	      while(itr.hasNext())
	      {
	    	  UniversityEventDom universityEventdom = itr.next();
	      }
	      
	    // Adding values to the referenceData Object
		model.addAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
		model.addAttribute("universityEventCmd",universityEventCmd);
		request.setAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
		model.addAttribute("eventStatus", universityEventDom.getStatus());
	   	
	   	// return the command(business) object
		return "university/university_edit_seminar";	
	 
	}
	
	
	
}