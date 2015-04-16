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
import org.springframework.beans.BeanUtils;
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
 * This class is used to edit Campus Recruitment by university
 * @author KShailesh
 *
 */
@Controller
public class UniversityEditRecruitmentController  {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;

	
	/**
	 * This method is used to update the campus recruitment details in the database
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_RECRUITMENT,method=RequestMethod.POST)
	public String onSubmit(@ModelAttribute("universityEventCmd")UniversityEventCom universityEventCmd,HttpServletRequest request,ModelMap model)
			throws ServletException {
		
		logger.info(CaerusLoggerConstants.EDIT_RECRUITMENT);
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String emailID = auth.getName();

		
		ArrayList<String> companyEmailList = new ArrayList<String>();
		ArrayList<String> companyNameList = new ArrayList<String>();
		
		String eventId = universityEventCmd.getEventId(); // getting the selected event Id value from form
		
		// Fetching parameter value from request
		String invitedCompaniesRecrutiment = request
				.getParameter("email_id_Recrutiment");
		String companyNameRecrutiment = request
				.getParameter("company_Name_Recrutiment");
		
		String[] invitedCompaniesListMail = null;

		// Adding the company emailId and name invited for the recruitment
		if (invitedCompaniesRecrutiment != null
				&& invitedCompaniesRecrutiment.length() > 0) {

			companyEmailList.add(invitedCompaniesRecrutiment);   

			companyNameList.add(companyNameRecrutiment);

			invitedCompaniesListMail = invitedCompaniesRecrutiment.split(",");

			int i = 0;
			
		}

		// Creating a domain object 
		UniversityEventDom universityEventDom = new UniversityEventDom();
		
		// Setting values  from business objects(command) to value object(domain)
		universityEventDom.setEventId(universityEventCmd.getEventId());
		universityEventDom.setEndDate(universityEventCmd.getEndDate());
		universityEventDom.setEventType(universityEventCmd.getEventType());
		universityEventDom.setStartDate(universityEventCmd.getStartDate());
		universityEventDom.setStatus(universityEventCmd.getStatus());
		universityEventDom.setStartTime(universityEventCmd.getStartTime());
		universityEventDom.setEndTime(universityEventCmd.getEndTime());
		universityEventDom.setVenue(universityEventCmd.getVenue());
		universityEventDom.setInvitedCompanies(companyEmailList);
		universityEventDom.setCompanyName(companyNameList);
		universityEventDom.setDescription(universityEventCmd.getDescription());

		// Updating the status of the recruitment in the database
		universityManager.updateSeminarEvent(universityEventDom);

		 
		 // Adding values to the modelAndView Object
		 model.addAttribute("universityEventCmd", universityEventCmd);
		 
		 HttpSession httpSession = request.getSession(true);
		 httpSession.setAttribute("eventId", universityEventDom.getEventId());
		 
		 // redirect to the defined view(page)
		 return "redirect:preview_university_event.htm"; 
	}
	
	/**
	 * This method is used to load the page with data
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_RECRUITMENT,method=RequestMethod.GET)
	public String getEditRecruitmentForm(@RequestParam("event_id")String eventId,@RequestParam("eventNamess")String eventType,HttpServletRequest request,ModelMap model){
	
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailID = auth.getName(); //get logged in Email ID
	    
	    // Fetching parameter value from request
	    String eventIds = request.getParameter("event_id"); // getting the selected event Id value from form

	    // Retrieving the recruitment details from the database based on the event Id
	    UniversityEventDom universityEventDom = universityManager.getScheduleEventByEventId(eventId);
	    
	    UniversityEventCom universityEventCmd = new UniversityEventCom();    	
	    
	    // Setting values from value object(domain) to business objects(command)
	   
	    BeanUtils.copyProperties(universityEventDom, universityEventCmd);
	   
	    // Formatting the date as per required format
	    DateFormat inputFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
		DateFormat  outputFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		String startDate = universityEventDom.getStartDate();
		String endDate = universityEventDom.getEndDate();
		
		Date date = null;
		Date edate = null;
		
		// Exception handling
		try {
			date = inputFormat.parse(startDate);
			edate = inputFormat.parse(endDate);
		
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		
		String startDateFormat = outputFormat.format(date);
		String  endDateFormat = outputFormat.format(edate);

	    universityEventCmd.setStartDate(startDateFormat);
	   	universityEventCmd.setEndDate(endDateFormat);
	   	
	   	List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
	    
	    // Iterating through the list of invited companies
	    Iterator<UniversityEventDom> itr = invitedCompanyListEvent.iterator();
	      while(itr.hasNext()) {
	    	  UniversityEventDom universityEventdom = itr.next();
	    }
	      
	    // Adding values to the referenceData Object
		model.addAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
		request.setAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
		model.addAttribute("universityEventCmd",universityEventCmd);
	   	
	   	// return the command(business) object
		return "university/university_edit_recruitment";	
	 
	}
	
}