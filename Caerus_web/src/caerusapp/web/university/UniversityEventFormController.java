/**
 * 
 */
package caerusapp.web.university;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.command.university.UniversityEventCom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.university.UniversityEventDom;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.EmployerManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to schedule an event by the university
 * @author TrishnaR
 * 
 */
@Controller
public class UniversityEventFormController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	private EmployerManager employeeManager;

	@Autowired
	private IMasterManager masterManager;
	

	/**
	 * This method is used to schedule an event(job fair, recruitment, seminar) by the university
	 * @param request
	 * @param response
	 * @param command
	 * @param errors
	 * @return
	 * @throws ServletException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_SCHEDULE_EVENT,method=RequestMethod.POST)
	public String onSubmit(@ModelAttribute("universityEventCmd") UniversityEventCom universityEventCmd,HttpServletRequest request,HttpServletResponse response)
			throws ServletException {
		
		logger.info(CaerusLoggerConstants.SCHEDULE_EVENT);
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String emailID = auth.getName();
		HttpSession httpSession = request.getSession(true);

		// All the form values are received in this object
		//UniversityEventCom universityEventCmd = (UniversityEventCom) command;

		// Fetching parameter value from request
		String invitedCompaniesJobFair = (String) request
				.getParameter("email_id_JobFair");	
		String companyNameJobFair = request
				.getParameter("company_Name_JobFair");
		/*String companyNameRecrutiment = request
				.getParameter("company_Name_Recrutiment");
		String invitedCompaniesSeminar = (String) request
				.getParameter("email_id_Seminar");
		String companyNameSeminar = request
				.getParameter("company_Name_Seminar");
		String invitedCompaniesRecrutiment = request
				.getParameter("email_id_Recrutiment");*/

		String[] invitedCompaniesListMail = null;
		
		List<String> invitedCompaniesEmailId = new ArrayList<String>();

		ArrayList<String> companyNames = new ArrayList<String>();

		ArrayList<String> companyNameList = new ArrayList<String>();

		// adding the company emailId and name, if there are companies invited for the jobfair
		if(universityEventCmd.isJobFairFlag() == true)
		{
			
	
				companyNames.addAll(universityEventCmd.getInvitedCompanies());   
	
				companyNameList.add(companyNameJobFair);
	
				//invitedCompaniesListMail = invitedCompaniesJobFair.split(",");
	
				//int i = 0;
	
			
		}
		// adding the company emailId and name, if there are companies invited for the recruitment
		/*if (invitedCompaniesRecrutiment != null
				&& invitedCompaniesRecrutiment.length() > 0) {*/

			//companyEmailList.add(invitedCompaniesRecrutiment);

			//companyNameList.add(companyNameRecrutiment);
			
		if(universityEventCmd.isRecruitmentFlag() == true)
		{
			companyNameList.add(universityEventCmd.getInvitedCompanyRecruitment());
			
			//String companyEmailId = employeeManager.getEmployerEmailIdByName(universityEventCmd.getInvitedCompanyRecruitment());
			
			companyNames.add(universityEventCmd.getInvitedCompanyRecruitment());

			//invitedCompaniesListMail = invitedCompaniesRecrutiment.split(",");
			
			//invitedCompaniesEmailId.add(companyEmailId);
			
			String[] invitedCompaniesArray = new String[invitedCompaniesEmailId.size()];
			
			invitedCompaniesListMail = invitedCompaniesEmailId.toArray(invitedCompaniesArray);
		}	
		
		
		if(universityEventCmd.isSeminarFlag() == true)
		{
			companyNameList.add(universityEventCmd.getInvitedCompanySeminar());
			
			//String companyEmailId = employeeManager.getEmployerEmailIdByName(universityEventCmd.getInvitedCompanySeminar());
			
			companyNames.add(universityEventCmd.getInvitedCompanySeminar());

			//invitedCompaniesListMail = invitedCompaniesRecrutiment.split(",");
			
			//invitedCompaniesEmailId.add(companyEmailId);
			
			String[] invitedCompaniesArray = new String[invitedCompaniesEmailId.size()];
			
			invitedCompaniesListMail = invitedCompaniesEmailId.toArray(invitedCompaniesArray);
		}	
		
		
			

			//int i = 0;
			
	//	}
		
		// adding the company emailId and name, if there are companies invited for the seminar
		/*if (invitedCompaniesSeminar != null
				&& invitedCompaniesSeminar.length() > 0) {

			companyEmailList.add(invitedCompaniesSeminar);

			companyNameList.add(companyNameSeminar);

			//invitedCompaniesListMail = invitedCompaniesSeminar.split(",");

			int i = 0;

		}
*/
		// Creating a domain object  
		UniversityEventDom universityEventDom = new UniversityEventDom();

		// Setting values from business objects(command) to value object(domain)
		universityEventDom.setEventId(universityEventCmd.getEventId());
		universityEventDom.setDescription(universityEventCmd.getDescription());
		universityEventDom.setEndDate(universityEventCmd.getEndDate());
		universityEventDom.setEventName(universityEventCmd.getEventName());
		universityEventDom.setEventType(universityEventCmd.getEventType());
		universityEventDom.setFirmId(universityEventCmd.getFirmId());
		universityEventDom.setInvitedCompanies(companyNames);
		universityEventDom.setStartDate(universityEventCmd.getStartDate());
		//universityEventDom.setStatus(universityEventCmd.getStatus());
		universityEventDom.setStatus("Proposed");
		universityEventDom.setStartTime(universityEventCmd.getStartTime());
		universityEventDom.setEndTime(universityEventCmd.getEndTime());
		universityEventDom.setVenue(universityEventCmd.getVenue());
		universityEventDom.setSpeakerName(universityEventCmd.getSpeakerName());
		universityEventDom.setSeminarCategory(universityEventCmd.getSeminarCategory());
		universityEventDom.setTopic(universityEventCmd.getTopic());
		universityEventDom.setCompanyName(companyNameList);
		universityEventDom.setInvitationStatus("Pending");
		universityEventDom.setMessage("");
		universityEventDom.setUniversityId(emailID);
		universityEventDom.setReadFlag(false);
		universityEventDom.setUniversityName(request.getSession().getAttribute("univName").toString());
		

		String eventId = universityManager.scheduleEventByUniversity(universityEventDom);
		httpSession.setAttribute("eventId", eventId);

		// Update Email send to Employers regarding the event scheduling
		/*MailUtil.sendInviteMailToEmployers(
				universityEventDom.getEventType(),
				invitedCompaniesListMail,
				universityEventDom.getEventName(),
				universityEventDom.getStartDate(),
				universityEventDom.getEndDate(),
				universityEventDom.getStartTime(),
				universityEventDom.getVenue(),
				universityEventDom.getDescription());*/
					
		logger.info(CaerusLoggerConstants.MAIL_SENT);

		// Redirecting to success view 
		return "redirect:preview_university_event.htm";

	}	
	
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_SCHEDULE_EVENT,method=RequestMethod.GET)
	public String getUniversityScheduleEventForm(@ModelAttribute("universityEventCmd") UniversityEventCom universityEventCmd, ModelMap model ){
		// Retrieving the industry list from the master table 
			List<String> industryList = masterManager.getIndustries();
			List<String> registeredCompanies = masterManager.getRegisteredCompanies();
			
			// Sorting the list alphabetically
			if(industryList != null && industryList.size() > 0)
				Collections.sort(industryList);
		
			if(registeredCompanies != null && registeredCompanies.size() > 0)
				Collections.sort(registeredCompanies);
			
		model.addAttribute("industryList", industryList);
		model.addAttribute("companyList", registeredCompanies);
		return CaerusJSPMapper.UNIVERSITY_SCHEDULE_EVENT;
		
	}
	@RequestMapping(value=CaerusAnnotationURLConstants.SEARCH_COMPANIES_FOR_UNIVERSITY_EVENT,method=RequestMethod.GET)
	@ResponseBody
	public String handleRequest(@RequestParam("industry")String  industry,@RequestParam("companyName") String companyName,HttpServletRequest request,
			HttpServletResponse response) {

		List<EmployerDom> registeredEmployer = null;

		//ModelAndView mav = new ModelAndView("university/recruitment_sample");

		
		String keyword = "";
		// industry = (String) request.getParameter("industry");
		//String companyName = (String) request.getParameter("companyName");


		if (keyword.length() == 0 && industry.length() > 0
				&& companyName.length() > 0) {

			registeredEmployer = employeeManager.getRegisteredCompaniesByIndustryAndCompanyName(industry,
							companyName);

		}

		if (keyword.length() == 0 && industry.length() == 0
				&& companyName.length() > 0) {

			registeredEmployer = employeeManager.getRegisteredCompaniesByCompanyName(companyName);

		}

		if (keyword.length() == 0 && industry.length() > 0
				&& companyName.length() == 0) {

			registeredEmployer = employeeManager.getRegisteredCompaniesByIndustry(industry);

		}

		ObjectMapper mapper = new ObjectMapper();
		Map<String,EmployerDom> employerMap = new HashMap<String,EmployerDom>();
		
		for (EmployerDom employerDom : registeredEmployer) {
			employerMap.put(employerDom.getCompanyName(),employerDom);
		}
		
		JsonNode json = mapper.valueToTree(employerMap);
		
		// Setting attribute values in request
		request.setAttribute("registeredEmployer", registeredEmployer);
		//mav.addObject("registeredEmployer", registeredEmployer);    
		
		// redirect to the defined view(page)
		// registeredEmployer;

		return json.toString();
		
	
	
	
}
}