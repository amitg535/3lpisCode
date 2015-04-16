package caerusapp.web.student;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.student.StudentDom;
import caerusapp.exceptions.DoesNotExistException;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to apply candidate's mail settings and profile visibility
 * @author TulsiC
 */
@Controller
public class CandidateSettingsController
{
	
	// Autowiring service component
	@Autowired
	StudentManager studentManager;
	
	 final Log logger = LogFactory.getLog(getClass());
	
	 /**
	  * This method is used to apply candidate's mail settings
	  * @author TulsiC
	  * @param mailSettingsMap
	  * @return boolean
	  */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_MAIL_SETTINGS,method=RequestMethod.POST)
	@ResponseBody
	public boolean candidateApplyMailSettings(@RequestBody Map<String,List<String>> mailSettingsMap){
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	    
	    boolean successFlag=false;
	    
		try
		{
			//Updating the database with mail settings
			studentManager.updateMailSettings(emailId,mailSettingsMap);
			successFlag=true;
			logger.info(CaerusLoggerConstants.CANDIDATE_APPLY_MAIL_SETTINGS);
		}
		
		catch(DoesNotExistException dne)
		{
			dne.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return successFlag;
		
	}
	
	
	/**
	 * This method is used to load candidate's setting page along with the default mail settings
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_SETTINGS)
	public ModelAndView candidateSettings(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	    
	    //The modelAndView object contains the model(data) and the view(page)
	    ModelAndView modelAndView = new ModelAndView("candidate/candidate_settings");
	    
	    // Retrieving candidate's mail settings
	    Map<String, Boolean> mailSettingMap = studentManager.getCandidateMailSettings(emailId);
	    
	    // Retrieving candidate's details to find profile visibility flag
		StudentDom student = studentManager.getDetailsByEmailId(emailId);
		
		 //Adding objects to model to retrieve details on jsp 
		modelAndView.addObject("profileVisibility",student.isProfileVisibility());
	    modelAndView.addObject("mailSettingmap",mailSettingMap);
	    
	    logger.info(CaerusLoggerConstants.CANDIDATE_MAIL_SETTINGS);
	    
	    return modelAndView;
	    
	}
	
	/**
	 * This method is used to update candidate's profile visibility flag in the database
	 * @author RavishaG
	 * @param visibility
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_PROFILE_VISIBILITY)
	public void setProfileVisibility(@RequestParam("visibility") boolean visibility, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	   
	    // Updating the database with profile visibility 
	    studentManager.updateProfileVisibility(emailId,visibility);
	    
	    logger.info(CaerusLoggerConstants.CANDIDATE_PROFILE_VISBILITY_APPLIED);
	   
	}
	
}