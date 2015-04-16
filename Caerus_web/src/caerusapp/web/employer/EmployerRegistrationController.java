package caerusapp.web.employer;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
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

import caerusapp.command.employer.EmployerCom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.MailUtil;
import caerusapp.util.PasswordGeneratorUtil;

/**
 * This class is used to register the employer
 * @author TulsiC
 *
 */

@Controller
public class EmployerRegistrationController {

	//Auto-wiring service components
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	MailUtil mailUtil;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to save the details for employer registration
	 */
	
	@ModelAttribute("employerCom")
	EmployerCom getEmployerComObject()
	{
		return new EmployerCom();
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_REGISTRATION, method = RequestMethod.GET)
	public String loadPage(@ModelAttribute("success") String success,@ModelAttribute("error") String error,Model model,HttpServletRequest httpServletRequest)
	{

		if(success != null && !success.isEmpty())
		{
			model.addAttribute("success",true);
		}
		
		if(error != null && !error.isEmpty())
		{
			model.addAttribute("registered",true);
		}
		
		List<String> industryList = masterManager.getIndustries();
		model.addAttribute("industryList", industryList);
		
		List<String> companyTypeList = masterManager.getCompanyTypes();
		model.addAttribute("companyTypeList", companyTypeList);
		
		model.addAttribute("employerCom", getEmployerComObject());
		return CaerusJSPMapper.EMPLOYER_REGISTRATION;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_REGISTRATION, method = RequestMethod.POST)
	public ModelAndView onSubmit(@ModelAttribute("employerCom") @Valid EmployerCom employerCom, BindingResult bindingResult,RedirectAttributes redirectAttributes, HttpServletRequest httpServletRequest) throws ServletException, IOException
	{
		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.EMPLOYER_REGISTRATION);
		
		
		// Creating a domain object 
		EmployerDom employerDom = new EmployerDom();
		
		if(!bindingResult.hasErrors())
		{
			BeanUtils.copyProperties(employerCom, employerDom);
			
			int registeredEmployerCount = employerManager.getEmployerByEmailId(employerDom.getEmailID());
			
			int companyNameCount = employerManager.getEmployerByCompanyName(employerDom.getCompanyName());

			if (registeredEmployerCount == 0 && companyNameCount == 0) 
			{
				employerDom.setPassword(PasswordGeneratorUtil.randomStringGenerator());

				Document document = CaerusCommonUtil.registrationMailTemplate(employerDom.getAuthority());
				
				/*ServletContext servletContext = httpServletRequest.getSession().getServletContext();
				String contextPath = servletContext.getRealPath(File.separator);
				
				//Add default not available image
				contextPath+= CaerusPathConstants.defaultImagePath;
				
		        byte[] imageData = FileUtils.readFileToByteArray(new File(contextPath));
				
				employerDom.setImageName("Default Image");
				employerDom.setImageData(imageData);
				*/
				employerManager.addEmployer(employerDom);
				
				String path = httpServletRequest.getContextPath();
			    String basePath = httpServletRequest.getScheme()+"://"+httpServletRequest.getServerName()+":"+httpServletRequest.getServerPort()+path+"/";

			    
			    String accountVerifierLink = basePath+"home.htm";
				
				document.getElementById("username").append("Your Username is "+employerDom.getEmailID());
				document.getElementById("password").text("Your Password is "+ employerDom.getPassword());
				
				Elements links = document.select("a[href]");
				for (Element link : links)  
				{
			        link.attr("href",accountVerifierLink);
			    }
				
				try 
				{
					mailUtil.sendMailToUsers(employerDom.getEmailID(), document.toString(), "Welcome to Imploy Me");
				} 
				catch (IOException e)
				{
					e.printStackTrace();
				}
				
				logger.info(CaerusLoggerConstants.EMPLOYER_REGISTRATION);

				redirectAttributes.addFlashAttribute("success", "true");
				
				return new ModelAndView(new RedirectView("employer_registration.htm"));
				
			}
			else 
			{
				redirectAttributes.addFlashAttribute("error", "true");
				
				return new ModelAndView(new RedirectView("employer_registration.htm"));
			}
		}
		
		else
		{
			List<String> industryList = masterManager.getIndustries();
			modelAndView.addObject("industryList", industryList);
			
			if(employerCom.getIndustry() != null)
				modelAndView.addObject("selectedIndustry", employerCom.getIndustry());
			
			List<String> companyTypeList = masterManager.getCompanyTypes();
			modelAndView.addObject("companyTypeList", companyTypeList);
			
			if(employerCom.getCompanyType() != null)
				modelAndView.addObject("selectedCompanyType", employerCom.getCompanyType());
			
			return modelAndView;
		}
		
	}


}