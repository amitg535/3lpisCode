package caerusapp.web.student;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.student.StudentCom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;

/**
 * This class is used to facilitate Candidate Registration 
 */
@Controller
public class CandidateRegistrationController{

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());


	/** Auto-wiring Service Components */
	@Autowired
	private IStudentManager studentManager;
	
	@Autowired
	private IUniversityManager universityManager;

	@Autowired
	MailUtil mailUtil;
	
	/**
	 * This method is used to facilitate Candidate Registration with checks if the candidate is already registered
	 */
	
	@ModelAttribute("studentCom")
	StudentCom getStudentComObject()
	{
		return new StudentCom();
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_REGISTRATION, method = RequestMethod.GET)
	public String loadPage(@ModelAttribute("error") String error,@ModelAttribute("success") String success,Model model)
	{
		if(success != null && !success.isEmpty())
		{
			model.addAttribute("success", true);
		}
		
		if(error != null && !error.isEmpty())
		{
			model.addAttribute("registered", true);
		}
		
		model.addAttribute("studentCom", getStudentComObject());
		return CaerusJSPMapper.CANDIDATE_REGISTRATION;
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_REGISTRATION, method = RequestMethod.POST)
	public ModelAndView registerCandidate(@ModelAttribute("studentCom") @Valid StudentCom studentCom,BindingResult bindingResult, RedirectAttributes redirectAttributes, HttpServletRequest httpServletRequest) throws ServletException {

		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.CANDIDATE_REGISTRATION);
		
		StudentDom studentDom = new StudentDom();
		
	    // check if there are any errors
	    if (!bindingResult.hasErrors()) 
	    {
			BeanUtils.copyProperties(studentCom, studentDom);
			
			studentDom.setFirstName(Character.toUpperCase(studentCom.getFirstName().charAt(0)) + studentCom.getFirstName().substring(1));
			studentDom.setLastName(Character.toUpperCase(studentCom.getLastName().charAt(0)) + studentCom.getLastName().substring(1));
			
			Date date = CaerusCommonUtility.stringToDate(studentCom.getDateOfBirth(), "yyyy-MM-dd");
			studentDom.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").format(date));	
			
			studentDom.setDefault(true);
			
			// isFirstLogin flag is set true on registration and candidate is redirected to candidate_portfolio.htm
			studentDom.setFirstLogin(true);
			
			// Set student's profile visibility to true by default
			studentDom.setProfileVisibility(true);
	
			Map<String,Boolean> mailSettingsMap = new HashMap<String,Boolean>();
			
			// Set student's mail setting map to default settings
			mailSettingsMap.put("subscribe",true);
			mailSettingsMap.put("jobupdates", true);
			mailSettingsMap.put("eventupdates", true);
			mailSettingsMap.put("contactme", true);
			
			studentDom.setMailSettingsMap(mailSettingsMap);
			
			int registeredCandidateCount = studentManager.getStudentByEmailId(studentDom.getEmailID());
	
			if (registeredCandidateCount == 0) 
			{
				
				Map<String, Map<String, String>> map = universityManager.checkStudent(studentDom.getEmailID());
	
				for (Entry<String, Map<String, String>> entry : map.entrySet()) 
				{
					String universityName = entry.getKey();
					
					Map<String, String> unregisteredStudent = entry.getValue();
					
					universityManager.updateRegisteredStudents(unregisteredStudent, universityName);
				}
				
				logger.info(CaerusLoggerConstants.CANDIDATE_REGISTRATION);
				
				studentManager.candidateRegistration(studentDom);
				
				Document document = CaerusCommonUtil.registrationMailTemplate(studentDom.getAuthority());
				
				String path = httpServletRequest.getContextPath();
			    String basePath = httpServletRequest.getScheme()+"://"+httpServletRequest.getServerName()+":"+httpServletRequest.getServerPort()+path+"/";

			    String accountVerifierLink = basePath+"home.htm?userName="+studentDom.getEmailID();
				
				document.getElementById("username").text("Your Username is "+studentDom.getEmailID());
				Elements links = document.select("a[href]");
				for (Element link : links)  
				{
			        link.attr("href",accountVerifierLink);
			    }
				
				try 
				{
					mailUtil.sendMailToUsers(studentDom.getEmailID(), document.toString(), "Welcome to Imploy Me");
				} 
				catch (IOException e)
				{
					e.printStackTrace();
				}
				
				redirectAttributes.addFlashAttribute("success","true");
				
				return new ModelAndView(new RedirectView("candidate_registration.htm"));
				
			}
			
			else 
			{		
				redirectAttributes.addFlashAttribute("error","true");
				
				return new ModelAndView(new RedirectView("candidate_registration.htm"));
				
			}
	    }
	    else
	    {
	    	return modelAndView;
	    }
	   
	}

}