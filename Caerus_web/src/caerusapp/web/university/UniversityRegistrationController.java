package caerusapp.web.university;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import caerusapp.command.university.UniversityDetailsCom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;
import caerusapp.util.PasswordGeneratorUtil;

/**
 * This class is used to register a university with Imploy
 * @author KarthikeyanK
 * 
 */
@Controller
public class UniversityRegistrationController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	MailUtil mailUtil;
	
	@ModelAttribute("universityDetailsCom")
	UniversityDetailsCom getUniversityDetailsCom()
	{
		return new UniversityDetailsCom();
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_REGISTRATION,method = RequestMethod.GET)
	public String loadPage(@ModelAttribute("success") String success,@ModelAttribute("error") String error,Model model)
	{
		if(success != null && !success.isEmpty())
		{
			model.addAttribute("success", true);
		}
		
		if(error != null && !error.isEmpty())
		{
			model.addAttribute("registered", true);
		}
		
		model.addAttribute("universityDetailsCom", getUniversityDetailsCom());
		return CaerusJSPMapper.UNIVERSITY_REGISTRATION;
	}
	

	/**
	 * This method is used to add a university to the database which wants to register with Imploy
	 */
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_REGISTRATION,method = RequestMethod.POST)
	protected ModelAndView registerUniversity(@ModelAttribute("universityDetailsCom") @Valid UniversityDetailsCom universityDetailsCom,
			BindingResult bindingResult, HttpServletRequest httpServletRequest,HttpServletResponse response, RedirectAttributes redirectAttributes)throws Exception 
	{

		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.UNIVERSITY_REGISTRATION);
		
		// Creating a domain object 
		UniversityDetailsDom univesityDetailsDom = new UniversityDetailsDom();
		 
		if(!bindingResult.hasErrors())
		{
			BeanUtils.copyProperties(universityDetailsCom, univesityDetailsDom);
			
			int usercount = universityManager.checkUniversityEmailIdExist(univesityDetailsDom.getEmailID());
			int usercount1=universityManager.getUniversityByUniversityName(univesityDetailsDom.getUniversityName());

			// check if the university is not already registered with Imploy , then register it
			if (usercount == 0 && usercount1==0)
			{
				univesityDetailsDom.setPassword(PasswordGeneratorUtil.randomStringGenerator());
				universityManager.addUniversity(univesityDetailsDom);
				
				logger.info(CaerusLoggerConstants.UNIVERSITY_REGISTRATION);

				Document document = CaerusCommonUtil.registrationMailTemplate(univesityDetailsDom.getAuthority());
				
				String path = httpServletRequest.getContextPath();
			    String basePath = httpServletRequest.getScheme()+"://"+httpServletRequest.getServerName()+":"+httpServletRequest.getServerPort()+path+"/";

			    String accountVerifierLink = basePath+"home.htm";
				
				document.getElementById("username").append("Your Username is "+univesityDetailsDom.getEmailID());
				document.getElementById("password").text(" Your Password is "+univesityDetailsDom.getPassword());
				
				Elements links = document.select("a[href]");
				for (Element link : links)  
				{
			        link.attr("href",accountVerifierLink);
			    }
				
				try 
				{
					/*MailUtil.sendMailToUsers(univesityDetailsDom.getEmailID(), document.toString(), "Welcome to Imploy Me");*/
					mailUtil.sendMailToUsers(univesityDetailsDom.getEmailID(), document.toString(), "Welcome to Imploy Me");
				} 
				catch (IOException e)
				{
					e.printStackTrace();
				}
				
				 
				redirectAttributes.addFlashAttribute("success", "true");
				return new ModelAndView(new RedirectView("university_registration.htm"));

			} 	
			
			else 
			{
				redirectAttributes.addFlashAttribute("error", "true");
				return new ModelAndView(new RedirectView("university_registration.htm"));
			}

		}
		else
		{
			return modelAndView;
		}

	}

}