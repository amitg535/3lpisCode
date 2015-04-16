package caerusapp.web.employer;

import java.text.ParseException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.employer.EmployerEventCom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.employer.EmployerEventDom;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.EmployerScheduleEventValidator;
import caerusapp.service.employer.IEmployerEventManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;

@Controller
public class EmployerEventActivitiesController {

	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IEmployerEventManager employerEventManager;
	
	@Autowired
	public EmployerEventActivitiesController(EmployerScheduleEventValidator employerScheduleEventValidator){
		this.employerScheduleEventValidator = employerScheduleEventValidator;
	}
	
	private EmployerScheduleEventValidator employerScheduleEventValidator;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SCHEDULE_EVENT)
	String loadScheduleEventPage(@RequestParam(value="eventId",required=false)String eventId,Model model,HttpServletRequest request) throws ParseException{
		 EmployerEventCom eventDetailsCom = new EmployerEventCom();
		
		 String companyName = "";
			
			if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
				companyName = request.getSession().getAttribute("compName").toString();
			
		if(eventId != null && !eventId.equals(""))
		{
			EmployerEventDom eventDetails = employerEventManager.getEmployerEventDetails(eventId);
			
			eventDetails.setStartDate(CaerusCommonUtil.changeDateFormat("E MMM dd HH:mm:ss Z yyyy", "dd-MM-YYYY",  eventDetails.getStartDate()));
			eventDetails.setEndDate(CaerusCommonUtil.changeDateFormat("E MMM dd HH:mm:ss Z yyyy", "dd-MM-YYYY",  eventDetails.getEndDate()));
			
			BeanUtils.copyProperties(eventDetails, eventDetailsCom);
			model.addAttribute("editMode",true);
		}
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("employerEventCom",eventDetailsCom);
		model.addAttribute("eligibleBatches", Arrays.asList(new String[]{"Spring-2013","Winter-2013","Spring-2014","Winter-2014","Spring-2015","Winter-2015"}));
		model.addAttribute("repositoryFiles",employerManager.getRepositoryFileNames(companyName));
		
		//Set location for default map
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);		
		String localAddress = employerDetails.getAddressLine1()+ " "+employerDetails.getCity()+ " "+employerDetails.getState()+ " "+employerDetails.getPostalCode();
		request.setAttribute("localAddress", localAddress);
		
		
		return CaerusJSPMapper.EMPLOYER_SCHEDULE_EVENT;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SCHEDULE_EVENT,method=RequestMethod.POST)
	String postEventPage(@ModelAttribute("employerEventCom") EmployerEventCom eventDetailsCom,BindingResult bindingResult,Model model,HttpServletRequest request){
		EmployerEventDom eventDetailsDom = new EmployerEventDom();
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
			companyName = request.getSession().getAttribute("compName").toString();
		
		employerScheduleEventValidator.validate(eventDetailsCom, bindingResult);
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("universityList", masterManager.getRegisteredUniversities());
			model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
			model.addAttribute("industryList", masterManager.getIndustries());
			
			model.addAttribute("employerEventCom",eventDetailsCom);
			model.addAttribute("eligibleBatches", Arrays.asList(new String[]{"Spring-2013","Winter-2013","Spring-2014","Winter-2014","Spring-2015","Winter-2015"}));
			model.addAttribute("repositoryFiles",employerManager.getRepositoryFileNames(companyName));
			
			return CaerusJSPMapper.EMPLOYER_SCHEDULE_EVENT;
		}
		
		eventDetailsCom.setEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
		
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);
		
		BeanUtils.copyProperties(eventDetailsCom, eventDetailsDom);
		
		eventDetailsDom.setCompanyName(companyName);
		
		String eventId = employerEventManager.scheduleEvent(eventDetailsDom);
		eventDetailsCom.setEventId(eventId);
		eventDetailsCom.setCompanyName(companyName);
		
		//Set location for default map
		String localAddress = employerDetails.getAddressLine1()+ " "+employerDetails.getCity()+ " "+employerDetails.getState()+ " "+employerDetails.getPostalCode();
		request.setAttribute("localAddress", localAddress);
		
		model.addAttribute("eventDetails",eventDetailsCom);
		model.addAttribute("employerDetails",employerDetails);
		
		return CaerusJSPMapper.EMPLOYER_PREVIEW_EVENT;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_EVENT_PREVIEW)
	String getEventPreview(@RequestParam("eventId") String eventId,Model model,HttpServletRequest request){
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
			companyName = request.getSession().getAttribute("compName").toString();
			
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);
		EmployerEventDom eventDetails = employerEventManager.getEmployerEventDetails(eventId);
		
		if(null != eventDetails){
			 if(null != eventDetails.getStartDate())
				 eventDetails.setStartDate(CaerusCommonUtility.changeDateFormat(eventDetails.getStartDate(),CaerusAPIStringConstants.EVENT_DATE_FORMAT,CaerusAPIStringConstants.DISPLAY_DATE_FORMAT));
		
			 if(null != eventDetails.getEndDate())
				 eventDetails.setEndDate(CaerusCommonUtility.changeDateFormat(eventDetails.getEndDate(),CaerusAPIStringConstants.EVENT_DATE_FORMAT,CaerusAPIStringConstants.DISPLAY_DATE_FORMAT));

		}
			
		
		String localAddress = employerDetails.getAddressLine1()+ " "+employerDetails.getCity()+ " "+employerDetails.getState()+ " "+employerDetails.getPostalCode();
		request.setAttribute("localAddress", localAddress);
				
		employerDetails.setCompanyName(companyName);
		model.addAttribute("eventDetails",eventDetails);
		model.addAttribute("employerDetails",employerDetails);
		
		return CaerusJSPMapper.EMPLOYER_PREVIEW_EVENT;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPDATE_EVENT)
	String updatePostedEvent(@ModelAttribute("employerEventCom") EmployerEventCom eventDetailsCom,HttpServletRequest request,Model model)
	{
		EmployerEventDom eventDetailsDom = new EmployerEventDom();
		
		eventDetailsCom.setEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
			companyName = request.getSession().getAttribute("compName").toString();
			
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);
		eventDetailsCom.setCompanyName(companyName);
		
		BeanUtils.copyProperties(eventDetailsCom, eventDetailsDom);
		eventDetailsDom.setCompanyName(companyName);
		employerEventManager.updateEvent(eventDetailsDom);
		
		model.addAttribute("eventDetails",eventDetailsCom);
		model.addAttribute("employerDetails",employerDetails);
		
		return CaerusJSPMapper.EMPLOYER_PREVIEW_EVENT;
	}
	 
}