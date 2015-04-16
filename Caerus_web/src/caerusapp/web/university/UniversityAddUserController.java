/**
 * 
 */
package caerusapp.web.university;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import caerusapp.command.university.UniversityDetailsCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.MailUtil;

/**
 * This class is used to add university users
 * @author RavishaG
 *
 */
@Controller
public class UniversityAddUserController {
	
	//Autowiring service components
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired
	ILoginManagement loginManagement;

	@Autowired
	MailUtil mailUtil;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	 @ModelAttribute("addUser")
	 public UniversityDetailsCom getUnivesityRegisterationCmdObject() 
	 {
		return new UniversityDetailsCom();
	 }

	/**
	 * This method is used to load university add user page
	 * @author RavishaG
	 * @param model
	 * @param httpServletRequest
	 * @return String
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_ADD_USER , method = RequestMethod.GET)
	public String loadUniversityAddUserPage(Model model, HttpServletRequest httpServletRequest)
	{
		List<LoginManagementDom> userDetailsList = loginManagement.getUsers(httpServletRequest.getSession().getAttribute("univName").toString());
		
		model.addAttribute("addUser", getUnivesityRegisterationCmdObject());
		model.addAttribute("userDetailsList",userDetailsList);
		
		return "university/university_add_user";
	}
	
	/**
	 * This method is used to add university users 
	 * @author RavishaG
	 * @param univesityRegisterationCmd
	 * @param result
	 * @param request
	 * @return String
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_ADD_USER, method = RequestMethod.POST)
	public String universityAddUser(Model model, @ModelAttribute("addUser") UniversityDetailsCom univesityRegisterationCmd, BindingResult result, HttpServletRequest request)
	{
		LoginManagementDom loginManagementDom = new LoginManagementDom();
		
		UniversityDetailsDom univesityRegisterationDom = new UniversityDetailsDom();
		
		univesityRegisterationDom.setEmailID(univesityRegisterationCmd.getEmailID());
		
		if(! univesityRegisterationCmd.getPassword().equalsIgnoreCase(univesityRegisterationCmd.getConfirmPassword()))
		{
			result.rejectValue("confirmPassword", "UnivesityRegisterationCmd", "Passwords Don't Match");
		}
		
		/** Checking if the Email Id is already Registered */
		if(universityManager.checkUniversityEmailIdExist(univesityRegisterationDom.getEmailID()) > 0)
		{
			result.rejectValue("emailID", "UnivesityRegisterationCmd", "Email Id Already Exists");
		}
		
		if(result.hasErrors())
		{
			List<LoginManagementDom> userDetailsList = loginManagement.getUsers(request.getSession().getAttribute("univName").toString());
			
			model.addAttribute("userDetailsList",userDetailsList);
			
			return "university/university_add_user";
		}
		
		loginManagementDom.setEntityName(request.getSession().getAttribute("univName").toString());
		loginManagementDom.setAuthority(CaerusStringConstants.DEFAULT_UNIVERSITY_AUTHORITY);
		loginManagementDom.setPassword(univesityRegisterationCmd.getPassword());
		loginManagementDom.setFirstName(univesityRegisterationCmd.getFirstName());
		loginManagementDom.setLastName(univesityRegisterationCmd.getLastName());
		loginManagementDom.setAdminFlag(univesityRegisterationCmd.getAdminFlag());
		loginManagementDom.setEmailId(univesityRegisterationCmd.getEmailID());
		
		/** Adding a New User */
		loginManagement.addUser(loginManagementDom);
		
		String universityName = CaerusCommonUtility.getCapitalizedString(request.getSession().getAttribute("univName").toString());
		String mailSubject = "";
		
		if(univesityRegisterationCmd.getAdminFlag())
			mailSubject = " "+universityName +" Has Added you as an Admin User";
		else
			mailSubject = ""+universityName +" Has Added you as a User";
		
		String document = "<html><head></head><body>Hi " +univesityRegisterationCmd.getFirstName()+" "+univesityRegisterationCmd.getLastName()+",<br> Welcome to Imploy.Me<br>You've Been Added as a User by "+universityName+"<br>Your Login Credentials Are : <br> Username : "+univesityRegisterationCmd.getEmailID()+"<br> Password : "+univesityRegisterationCmd.getPassword()+"</body></html>";
		Document mailBodyDoc = Jsoup.parse(document);
		
		try {
			/*MailUtil.sendMailToUsers(univesityRegisterationCmd.getEmailID(), mailBodyDoc.toString(),mailSubject);*/
			mailUtil.sendMailToUsers(univesityRegisterationCmd.getEmailID(), mailBodyDoc.toString(),mailSubject);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		logger.info(CaerusLoggerConstants.UNIVERSITY_ADD_USER);
		
		return "redirect:university_add_user.htm";
	}
	
	/**
	 * This method is used to update university user details
	 * @author RavishaG
	 * @param univesityRegisterationCmd
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return String
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_UPDATE_USER)
	public String updateUniversityUser(@ModelAttribute("addUser") UniversityDetailsCom univesityRegisterationCmd, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		LoginManagementDom userDetails = new LoginManagementDom();
		
		userDetails.setEmailId(univesityRegisterationCmd.getEmailID());
		userDetails.setAdminFlag(univesityRegisterationCmd.getAdminFlag());
		userDetails.setFirstName(univesityRegisterationCmd.getFirstName());
		userDetails.setLastName(univesityRegisterationCmd.getLastName());
		
		/** Updating the Existing User's Details */
		loginManagement.updateUserDetails(userDetails);
		
		logger.info(CaerusLoggerConstants.UNIVERSITY_UPDATE_USER_DETAILS);
				
		return "redirect:university_add_user.htm";
	}
	
}