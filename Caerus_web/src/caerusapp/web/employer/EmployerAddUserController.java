/**
 * 
 */
package caerusapp.web.employer;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.common.LoginManagementCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.MailUtil;

/**
 * This class is used to Add Users by Employer
 * @author balajii
 */
@Controller
public class EmployerAddUserController {

	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	@Autowired
	MailUtil mailUtil;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private static final String EMPLOYER_ADD_USER_PAGE = "employer/employer_add_user";
	private static final String EMPLOYER_ADD_USER = "redirect:employer_add_user.htm";
	
	/** This method is used to Load Add User Page
	 * @author balajii
	 * @param model
	 * @param request
	 * @return "employer_add_user.jsp"
	 */
	@RequestMapping(CaerusAnnotationURLConstants.EMPLOYER_ADD_USER)
	String loadAddUserPage(Model model,HttpServletRequest request)
	{
		List<LoginManagementDom> employees = loginManagement.getUsers(request.getSession().getAttribute("compName").toString());
		
		model.addAttribute("addUser",new LoginManagementCom());
		model.addAttribute("employees",employees);
		
		return EMPLOYER_ADD_USER_PAGE;
	}
	
	/**
	 * This method is used to Add User by Employer
	 * @author balajii
	 * @param employer
	 * @param result
	 * @param request
	 * @param editModeFlag
	 * @return "redirect:employer_add_user.htm"
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_ADD_USER,method = RequestMethod.POST)
	String addUser(@ModelAttribute("addUser") LoginManagementCom employer,BindingResult result,HttpServletRequest request,@RequestParam(value = "editMode",required = false) String editModeFlag,Model model)
	{
		if(editModeFlag != null && editModeFlag.length() > 0 && editModeFlag.equalsIgnoreCase("true"))
		{
			LoginManagementDom userDetails = new LoginManagementDom();
			
			userDetails.setEmailId(employer.getEmailId());
			userDetails.setAdminFlag(employer.isAdminFlag());
			userDetails.setFirstName(employer.getFirstName());
			userDetails.setLastName(employer.getLastName());
			
			/** Updating the Existing User's Details */
			loginManagement.updateUserDetails(userDetails);
			logger.info(CaerusLoggerConstants.EMPLOYER_UPDATE_USER_DETAILS);
		}
		else
		{
			if(! employer.getPassword().equalsIgnoreCase(employer.getConfirmPassword()))
			{
				result.rejectValue("confirmPassword", "AddEmployer", "Passwords Don't Match");
			}
			
			/** Checking if the Email Id is already Registered */
			if(employerManager.getEmployerByEmailId(employer.getEmailId()) > 0)
			{
				result.rejectValue("emailId", "AddEmployer", "Email Id Already Exists");
			}
			
			if(result.hasErrors())
			{
				List<LoginManagementDom> employees = loginManagement.getUsers(request.getSession().getAttribute("compName").toString());
				model.addAttribute("employees",employees);
				return EMPLOYER_ADD_USER_PAGE;
			}
			
			LoginManagementDom userDetails = new LoginManagementDom();
			
			userDetails.setEntityName(request.getSession().getAttribute("compName").toString());
			userDetails.setAuthority(CaerusStringConstants.DEFAULT_EMPLOYER_AUTHORITY);
			userDetails.setPassword(employer.getPassword());
			userDetails.setFirstName(employer.getFirstName());
			userDetails.setLastName(employer.getLastName());
			userDetails.setAdminFlag(employer.isAdminFlag());
			userDetails.setEmailId(employer.getEmailId());
			
			/** Adding a New User */
			loginManagement.addUser(userDetails);
			
			String companyName = CaerusCommonUtility.getCapitalizedString(request.getSession().getAttribute("compName").toString());
			String mailSubject = "";
			
			if(employer.isAdminFlag())
				mailSubject = " "+companyName +" Has Added you as an Admin User";
			else
				mailSubject = ""+companyName +" Has Added you as a User";
			
			String document = "<html><head></head><body>Hi " +employer.getFirstName()+" "+employer.getLastName()+",<br> Welcome to Imploy.Me<br>You've Been Added as a User by "+companyName+"<br>Your Login Credentials Are : <br> Username : "+employer.getEmailId()+"<br> Password : "+employer.getPassword()+"</body></html>";
			Document mailBodyDoc = Jsoup.parse(document);
			
			//sendMail(employee.getEmailID(), mailSubject, mailBodyDoc.toString());
			
			try {
				mailUtil.sendMailToUsers(userDetails.getEmailId(), mailBodyDoc.toString(),mailSubject);
			} catch (IOException e) {
				logger.error("Error in Sending Mail");
			}
			logger.info(CaerusLoggerConstants.EMPLOYER_ADD_USER);
		}
		return EMPLOYER_ADD_USER;
	}
	
	/**
	 * This method is used to retrieve Employee details of an Employer
	 * @author balajii
	 * @param userEmailId
	 * @param model
	 * @param request
	 * @return "employer_add_user.jsp"
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_USER_DETAILS)
	String getEmployeeDetails(@RequestParam("emailId") String userEmailId,Model model,HttpServletRequest request)
	{
		LoginManagementDom userDetails = loginManagement.getUserDetailsByEmailID(userEmailId);
		
		LoginManagementCom employeeDetails = new LoginManagementCom();
		employeeDetails.setFirstName(userDetails.getFirstName());
		employeeDetails.setLastName(userDetails.getLastName());
		employeeDetails.setAdminFlag(userDetails.isAdminFlag());
		employeeDetails.setEmailId(userEmailId);
		
		List<LoginManagementDom> employees = loginManagement.getUsers(request.getSession().getAttribute("compName").toString());
		
		model.addAttribute("editMode",true);
		model.addAttribute("addUser",employeeDetails);
		model.addAttribute("employees",employees);
		
		return EMPLOYER_ADD_USER_PAGE;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DELETE_USER)
	String deleteUser(@RequestParam("emailId") String userEmailId)
	{
		Map<String,String> disableUser = new HashMap<String,String>();
		disableUser.put(userEmailId, userEmailId);
		
		loginManagement.disableUsers(disableUser);
		
		return EMPLOYER_ADD_USER;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_ENABLE_USER)
	String enableUser(@RequestParam("emailId") String userEmailId){
		Map<String,String> enableUser = new HashMap<String,String>();
		enableUser.put(userEmailId, userEmailId);
		
		loginManagement.enableUsers(enableUser);
		
		return EMPLOYER_ADD_USER;
	}
	
}