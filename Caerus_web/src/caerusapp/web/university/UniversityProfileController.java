package caerusapp.web.university;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
/*import org.springframework.web.servlet.mvc.SimpleFormController;*/
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.university.UniversityDetailsCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.student.StudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to display the university profile edit page
 *
 */
@Controller
public class UniversityProfileController  {
	
	/** Logger for this class and subclasses */
	Log logger=LogFactory.getLog(getClass());
	
	// Auto-wiring service component
	@Autowired
	IUniversityManager universityManager;
	@Autowired
	StudentManager studentManager;
	@Autowired
	ILoginManagement loginManagement;

	/**
	 * This method is used to load the page with data
	 */
    @RequestMapping (value= CaerusAnnotationURLConstants.UNIVERSITY_EDIT_PROFILE, method = RequestMethod.GET)
    
    public String universityEditProfileForm(HttpServletRequest httpServletRequest, Model model){
    	
    	logger.info(CaerusLoggerConstants.PROFILE_VIEW);
    	
    	// Spring security authentication containing the logged in user details
    			Authentication auth=SecurityContextHolder.getContext().getAuthentication();
    			String emailId=auth.getName();
    			
    			HttpSession session = httpServletRequest.getSession();
    			// Setting values in the session
    			String universityName = (String) session.getAttribute("univName");
    			UniversityDetailsDom universityDetails=universityManager.getUniversityDetailsByName(universityName);
    			
    			// Creating a command object 
    			UniversityDetailsCom universityDetailsCom=new UniversityDetailsCom();
    			
    			// Setting values from value object(domain) to business objects(command)
    			universityDetailsCom.setUniversityName(universityDetails.getUniversityName());
    			universityDetailsCom.setUniversityRegistrationNumber(universityDetails.getUniversityRegistrationNumber());
    			universityDetailsCom.setPhoneNumber(universityDetails.getPhoneNumber());
    			universityDetailsCom.setUniversityAddress(universityDetails.getUniversityAddress());
    			universityDetailsCom.setZipCode(universityDetails.getZipCode());
    			universityDetailsCom.setState(universityDetails.getState());
    			universityDetailsCom.setCity(universityDetails.getCity());
    			universityDetailsCom.setUniversityWebsite(universityDetails.getUniversityWebsite());
    			universityDetailsCom.setAboutUs(universityDetails.getAboutUs());
    			universityDetailsCom.setUniversityLogoName(universityDetails.getUniversityLogoName());
    			universityDetailsCom.setAutumnStartDate(universityDetails.getAutumnStartDate());
    			universityDetailsCom.setAutumnEndDate(universityDetails.getAutumnEndDate());
    			universityDetailsCom.setSpringStartDate(universityDetails.getSpringStartDate());
    			universityDetailsCom.setSpringEndDate(universityDetails.getSpringEndDate());
    			universityDetailsCom.setSummerStartDate(universityDetails.getSummerStartDate());
    			universityDetailsCom.setSummerEndDate(universityDetails.getSummerEndDate());
    			universityDetailsCom.setNoOfResearchStaff(universityDetails.getNoOfResearchStaff());
    			universityDetailsCom.setNoOfSupportStaff(universityDetails.getNoOfSupportStaff());
    			universityDetailsCom.setNoOfTeachingStaff(universityDetails.getNoOfTeachingStaff());
    			universityDetailsCom.setUgFullTimeStudents(universityDetails.getUgFullTimeStudents());
    			universityDetailsCom.setUgPartTimeStudents(universityDetails.getUgPartTimeStudents());
    			universityDetailsCom.setPgFullTimeStudents(universityDetails.getPgFullTimeStudents());
    			universityDetailsCom.setPgPartTimeStudents(universityDetails.getPgPartTimeStudents());
    			universityDetailsCom.setAwardsAndRecognitionList(universityDetails.getAwardsAndRecognitionList());
    			universityDetailsCom.setCourseName(universityDetails.getCourseName());
    			universityDetailsCom.setCourseType(universityDetails.getCourseType());
    			
    			LoginManagementDom adminDetails = loginManagement.getUserDetailsByEmailID(emailId);
    			universityDetailsCom.setContactPersonEmailId(adminDetails.getUserName());
    			if(null!= adminDetails.getFirstName() && null!= adminDetails.getLastName()){
    				
    				universityDetailsCom.setContactPerson(adminDetails.getFirstName().concat(" ").concat(adminDetails.getLastName()));
    			}
    			
    			else {
    				universityDetailsCom.setContactPerson("Beta University");
    			}
    			
    			model.addAttribute("universityDetailsCom", universityDetailsCom);
    			
    			model.addAttribute("logoName", universityDetails.getUniversityLogoName());
    			model.addAttribute("stateName", universityDetails.getState());
    			
    			
    			// Exception handling
    			try
    			{
    				//referenceDataMap.put("stateList",employeeManager.getStateList());
    			
    				if(universityDetails.getAwardsAndRecognitionList() != null && universityDetails.getAwardsAndRecognitionList().size() != 0)
    				{
    					model.addAttribute("recognitionListSize", universityDetails.getAwardsAndRecognitionList().size());
    				}
    				else
    				{
    					model.addAttribute("recognitionListSize",1);
    				}
    				
    				if(universityDetails.getCourseType() != null && universityDetails.getCourseType().size() != 0)
    				{
    					model.addAttribute("courseListSize", universityDetails.getCourseType().size());
    				}
    				else
    				{
    					model.addAttribute("courseListSize",1);
    				}
    				
    				
    				
    			}
    			catch(DataAccessException dae)
    			{
    				dae.printStackTrace();
    			}
    			
    			catch (Exception e) 
    			{
    			e.printStackTrace();	
    			}
		        
    			Device deviceType = DeviceUtils.getCurrentDevice(httpServletRequest);
    			if(deviceType.isNormal() || deviceType.isTablet() || deviceType.isMobile())
		       
    				return ("university/university_profile");
				return universityName;
    	
    }
    
	
	/**
	 * This method is used to create/update university profile in the database 
	 */
    @RequestMapping (value= CaerusAnnotationURLConstants.UNIVERSITY_EDIT_PROFILE, method = RequestMethod.POST)
	public ModelAndView onSubmit(@ModelAttribute("universityDetailsCom")  UniversityDetailsCom universityDetailsCom,
			BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response)
			throws Exception{
		
		// Fetching the device type(mobile,tablet,web)
		Device deviceType=(Device)DeviceUtils.getCurrentDevice(request);
		 
		logger.info(CaerusLoggerConstants.UPDATE_PROFILE);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView=new ModelAndView();// Only for web-app
		
		HttpSession session = request.getSession();
		// Setting values in the session
		String universityName = (String) session.getAttribute("univName");
	
		// Creating a domain object 
		UniversityDetailsDom universityDetailsDom = new UniversityDetailsDom();

		// Setting values from business objects(command) to value object(domain)
		universityDetailsCom.setUniversityName(universityName);
	
		BeanUtils.copyProperties(universityDetailsCom, universityDetailsDom);
		
		List<String> awardsAndRecognitionList = new ArrayList<String>();
		
		if(universityDetailsCom.getAwardsAndRecognitionList() != null && universityDetailsCom.getAwardsAndRecognitionList().size() > 0 && !universityDetailsCom.getAwardsAndRecognitionList().get(0).equals(""))
		{
			for (String awards : universityDetailsCom.getAwardsAndRecognitionList()) {
				
				if(!(awards.equals("") || awards.trim().equals("")))
				{
					awardsAndRecognitionList.add(awards);
				}
			}
		}
		
		if(awardsAndRecognitionList.size() != 0)
		{
			universityDetailsDom.setAwardsAndRecognitionList(awardsAndRecognitionList);
		}
		
		// Handling empty awardsAndRecognition list
		else
		{
			List<String> emptyList = new ArrayList<String>();
			emptyList.add("");
			universityDetailsDom.setAwardsAndRecognitionList(emptyList);
		}
	
		List<Integer> indexList = new ArrayList<Integer>();
		
		if(null!=universityDetailsCom.getCourseName()){
			
			for(int i=0; i<universityDetailsCom.getCourseName().size(); i++)
			{
				if((universityDetailsCom.getCourseName().get(i).equals("")) || (universityDetailsCom.getCourseName().get(i).trim().equals("")))
				{
					indexList.add(i);
				}
			}
			
		}
		
	
		for (Integer integer : indexList) {
			universityDetailsCom.getCourseName().remove(integer.intValue());
			universityDetailsCom.getCourseType().remove(integer.intValue());
		}	
		
		universityDetailsDom.setCourseName(universityDetailsCom.getCourseName());
		universityDetailsDom.setCourseType(universityDetailsCom.getCourseType());
		
		// File upload changes
		CommonsMultipartFile multipartFile = universityDetailsCom.getUniversityLogo();

		if(multipartFile != null)
		{
			String fileName = "";
		
			fileName = multipartFile.getOriginalFilename();
			
				InputStream inputStream = null;
		
				// Exception handling
				try {
							
					if(multipartFile.getSize() > 0) {
					
					inputStream = multipartFile.getInputStream();
				
					universityDetailsDom.setUniversityLogoName(fileName); 
					universityDetailsDom.setInputStream(inputStream);	
					universityDetailsDom.setPhotoData(multipartFile.getBytes());
					
					}
				}
				
	
				catch (CaerusCommonException e) {
					e.printStackTrace();
				} 
			
		}
		
				// update university profile in the database
				universityManager.editUniversity(universityDetailsDom);
				
				// Checking the type of device
				if(deviceType.isNormal())
				{
					modelAndView = new ModelAndView(new RedirectView("view_university_profile.htm")); // web app
				}
				else
				{
					modelAndView = new ModelAndView(new RedirectView("university_dashboard.htm"));    //thin client
				}
			
		 // returning the modelAndView object
		 return modelAndView;
	
	}

	@ModelAttribute("universityDetailsCom")
	UniversityDetailsCom getUniversityDetailsCom()
	{
		return new UniversityDetailsCom();
	}

}

