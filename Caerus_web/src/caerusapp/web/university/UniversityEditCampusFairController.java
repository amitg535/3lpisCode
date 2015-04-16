package caerusapp.web.university;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.university.UniversityEventCom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.common.MasterManager;
import caerusapp.service.student.StudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to edit Campus Jobfairs by university
 * @author kshailesh
 *
 */
@Controller
public class UniversityEditCampusFairController  {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	private StudentManager studentManager;
	
	@Autowired
	private MasterManager masterManager;

	
	/**
	 * This method is used to update the campus fair details in the database
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_CAMPUSFAIR,method=RequestMethod.POST)
	public String onSubmit(@ModelAttribute ("universityEventCmd") UniversityEventCom universityEventCmd, HttpServletRequest request,
			HttpServletResponse response,ModelMap model)
			throws ServletException {
		
		logger.info(CaerusLoggerConstants.EDIT_JOB_FAIR);
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailID = auth.getName();
		HttpSession httpSession = request.getSession(true);

		// All the form values are received in this object
		//UniversityEventCom universityEventCmd = (UniversityEventCom) command;
		
		ArrayList<String> companyEmailList = new ArrayList<String>();
		ArrayList<String> companyNameList = new ArrayList<String>();
		
		String eventId = universityEventCmd.getEventId(); // getting the selected event Id value from the form
		
		// Fetching parameter value from request
		String invitedCompaniesJobFair = (String) request
				.getParameter("email_id_JobFair");
		String companyNameJobFair = request
				.getParameter("company_Name_JobFair");
		String invitedCompaniesRecrutiment = request
				.getParameter("email_id_Recrutiment");
		String companyNameRecrutiment = request
				.getParameter("company_Name_Recrutiment");
		
		// Retrieving list of invited companies and their details for the campus jobfair
		List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
		
		// Iterating through the list of invited companies
	    Iterator<UniversityEventDom> itr = invitedCompanyListEvent.iterator();
	      while(itr.hasNext()) {
	    	  UniversityEventDom universityEventDom = itr.next();
	    	
	    	  companyEmailList.add(universityEventDom.getCompanyEmailId());   	

			  companyNameList.add(universityEventDom.getInviteCompanyName());
    	  
	    }

		String[] invitedCompaniesListMail = null;

		// Adding the company emailId and name invited for the jobfairs
		if (invitedCompaniesJobFair != null
				&& invitedCompaniesJobFair.length() > 0) {

			companyEmailList.add(invitedCompaniesJobFair);   	

			companyNameList.add(companyNameJobFair);

			invitedCompaniesListMail = invitedCompaniesJobFair.split(",");

			int i = 0;

		}
		
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
		universityEventDom.setDescription(universityEventCmd.getDescription());
		universityEventDom.setEndDate(universityEventCmd.getEndDate());
		universityEventDom.setEventName(universityEventCmd.getEventName());
		universityEventDom.setEventType(universityEventCmd.getEventType());
		universityEventDom.setFirmId(universityEventCmd.getFirmId());
		universityEventDom.setStartDate(universityEventCmd.getStartDate());
		universityEventDom.setStatus(universityEventCmd.getStatus());
		universityEventDom.setStartTime(universityEventCmd.getStartTime());
		universityEventDom.setEndTime(universityEventCmd.getEndTime());
		universityEventDom.setVenue(universityEventCmd.getVenue());
		universityEventDom.setInvitedCompanies(companyNameList);
		universityEventDom.setCompanyName(companyNameList);
		universityEventDom.setMessage("");
		universityEventDom.setUniversityId(emailID);
		universityEventDom.setUniversityName(request.getSession().getAttribute("univName").toString()); 
		
		// Updating the status of the campus jobfair in the database
		universityManager.updateCampusFairEvent(universityEventDom);
		
		//Added a flag showPublish to show/hide the publish button
		universityEventDom.setShowPublish(true);
		httpSession.setAttribute("eventId", universityEventDom.getEventId());
		
		 
		 // Adding values to the modelAndView Object
		model.addAttribute("universityEventCmd", universityEventCmd);
		 
		 // redirect to the defined view(page)
		 return "redirect:preview_university_event.htm"; 
	}
	
	/**
	 * This method is used to load the page with data
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_EDIT_CAMPUSFAIR,method=RequestMethod.GET)
	public String getEditJobFairForm(HttpServletRequest request,ModelMap model,@RequestParam("event_id") String eventId,@RequestParam("eventNamess") String eventName ){
	
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailID = auth.getName(); //get logged in Email ID
	    
	  
	    // Retrieving the job fair details from the database based on the event Id
	    UniversityEventDom universityEventDom = universityManager.getScheduleEventByEventId(eventId);
	    
	    UniversityEventCom universityEventCmd = new UniversityEventCom();	
	    
	    BeanUtils.copyProperties(universityEventDom, universityEventCmd);
	    
	    StringBuilder attendingCandidatesStringBuilder = new StringBuilder(); 

	    List<String> participatingCandidates = universityEventDom.getAcceptedByStudentsList();
	    if(participatingCandidates!=null && participatingCandidates.size()>0)
	    {
		    for (String candidate : participatingCandidates)
		    {
		    	attendingCandidatesStringBuilder = attendingCandidatesStringBuilder.append("'").append(candidate).append("',");
			}
		    String attendingCandidates = attendingCandidatesStringBuilder.substring(0, attendingCandidatesStringBuilder.lastIndexOf(","));
		    
		    // Fetching the candidates who have accepted the event invitation and setting the same to the command object.
		    universityEventCmd.setCandidateList(studentManager.findStudentList(attendingCandidates));
	    }
	    
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
	   	
	   	model.addAttribute("universityEventCmd",universityEventCmd);
	   	
	    String emailList = request.getParameter("emailList"); 
	    List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
	   	
	    model.addAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
	    request.setAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
	    
	    List<String> industryList =masterManager.getIndustries();
	    
	    Collections.sort(industryList);
	    model.addAttribute("industryList", industryList);
	    
	   	// return the command(business) object
		return "university/university_edit_campusfair";	
	 
	}
	
	/**
	 * This method is used to load data
	 *//*
	@SuppressWarnings("unchecked")
	protected Map referenceData(HttpServletRequest request) throws Exception {
 
		Map referenceData = new HashMap();
	   
		// Fetching parameter value from request
		String eventId = request.getParameter("event_id"); // getting the selected event Id value from form
	    String emailList = request.getParameter("emailList"); // getting the selected event Id value from form
		
	    // Retrieving the list of invited companies and their details from the database
	    List<UniversityEventDom> invitedCompanyListEvent  = universityManager.getInvitedListByEventId(eventId);
	    
	    // Iterating through the list of invited companies
	    Iterator<UniversityEventDom> itr = invitedCompanyListEvent.iterator();
	      while(itr.hasNext()) {
	    	  UniversityEventDom universityEventDom = itr.next();
	    }
	      
	    // Adding values to the referenceData Object
		referenceData.put("invitedCompanyListEvent", invitedCompanyListEvent);
		request.setAttribute("invitedCompanyListEvent", invitedCompanyListEvent);
		
		// Retrieving the industry list from the master table 
		List<String> industryList = universityManager.getIndustryList();
				
		// Sorting the list alphabetically
		Collections.sort(industryList);
				
		// Adding values to the referenceData object
		referenceData.put("industryList", industryList);
		
		 UniversityEventDom universityEventDom = universityManager.getScheduleEventByEventId(eventId);
		 referenceData.put("eventStatus", universityEventDom.getStatus());
	
		// return the reference data object
		return referenceData;
	}*/
}

