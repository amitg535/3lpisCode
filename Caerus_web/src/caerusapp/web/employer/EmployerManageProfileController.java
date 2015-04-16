package caerusapp.web.employer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.employer.EmployerCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.EmployerProfileValidator;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusLoggerConstants;

@Controller
public class EmployerManageProfileController {

	
	@Autowired
	public EmployerManageProfileController(EmployerProfileValidator employerProfileValidator){
		this.employerProfileValidator = employerProfileValidator;
	}
	
	public EmployerManageProfileController(){
		
	}
	
	private EmployerProfileValidator employerProfileValidator;
	
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_MANAGE_PROFILE)
	String handleRequest(HttpServletRequest request,HttpServletResponse response,Model model) throws ServletException, IOException {
		logger.info(CaerusLoggerConstants.PROFILE_VIEW);
		
		//Using the existing session
		HttpSession session = request.getSession();
		String corporateName = (String) session.getAttribute("compName");
		
		// Fetching the login Attempts of the corporate user to display the next page(either the Dashboard or the Manage Profile Page)
		int loginAttempts = employerManager.getUserLoginAttempts(corporateName);
		model.addAttribute("loginAttempts", loginAttempts);

		if(loginAttempts == 0)
			employerManager.updateUserLoginAttempts(corporateName);
		
		EmployerDom employerDetails = employerManager.getEmployerDetails(corporateName);
		model.addAttribute("selectedEmployeeStrength", employerDetails.getNoOfEmployees());
		
		LoginManagementDom adminDetails = new LoginManagementDom();
		
		adminDetails = loginManagement.getAdminByEntityName(corporateName);
		
		if (null!= adminDetails.getFirstName() && null!= adminDetails.getLastName()){
			
			employerDetails.setContactPersonName(adminDetails.getFirstName().concat(" ").concat(adminDetails.getLastName()));
		}
		
		else {
			employerDetails.setContactPersonName("Beta Company");
		}
		employerDetails.setEmailID(adminDetails.getUserName());
		
		model.addAttribute("employerDetails", employerDetails);
		model.addAttribute("industryList", masterManager.getIndustries());
		model.addAttribute("functionalAreaList",masterManager.getFunctionalAreas());
		model.addAttribute("noOfEmployees",masterManager.getEmployeeStrength());
		
		return "employer/employer_manage_profile";
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_MANAGE_PROFILE,method=RequestMethod.POST)	
	ModelAndView updateEmployerDetails(@ModelAttribute("employerDetails") EmployerCom employerDetails,BindingResult bindingResult)
	{
		
		if(employerDetails != null){
			employerProfileValidator.validate(employerDetails, bindingResult);
		}
			
		if(bindingResult.hasErrors()){
			ModelAndView modelAndView = new ModelAndView("employer/employer_manage_profile");
			
			modelAndView.addObject("employerDetails", employerDetails);
			modelAndView.addObject("industryList", masterManager.getIndustries());
			modelAndView.addObject("functionalAreaList",masterManager.getFunctionalAreas());
			
			return modelAndView;
		}
		
		EmployerDom employerDetailsDom = new EmployerDom();
		BeanUtils.copyProperties(employerDetails, employerDetailsDom);
		
		employerManager.updateEmployerDetails(employerDetailsDom);
		
		return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.EMPLOYER_PROFILE_PREVIEW));
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_VIEW_BROCHURE)
	void viewEmployerBrochure(@RequestParam(value="companyName",required=false) String companyName,HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		if(request.getSession().getAttribute("compName") != null)
			companyName = request.getSession().getAttribute("compName").toString();
		
			EmployerDom employerDetails = new EmployerDom();
			
			//Fetching the employer details
			employerDetails = employerManager.getEmployerDetails(companyName);
			
			if(employerDetails != null)
			{
				String brochureName = employerDetails.getBrochureName();
				byte[] brochure = employerDetails.getBrochureData();
				
					String fileExtension = CaerusCommonUtil.getFileExtension(brochureName);
					
					response.setContentType("application/"+fileExtension);
					if(fileExtension.equals("doc") || fileExtension.equals("docx"))
					{
						response.setContentType("application/msword");
					}
					if(fileExtension.equals("pdf"))
					{
						response.setContentType("application/pdf");
					}
					response.getOutputStream().write(brochure);
					response.getOutputStream().flush();
					
					response.getOutputStream().close();
			}
			
	}
}