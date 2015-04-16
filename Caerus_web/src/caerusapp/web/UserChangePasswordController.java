/**
 * 
 */
package caerusapp.web;

import javax.servlet.ServletException;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.common.LoginManagementCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.service.common.ILoginManagement;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to enable a user to change their password 
 * @author RavishaG
 * 
 */
@Controller
public class UserChangePasswordController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private ILoginManagement loginManagement;

	@ModelAttribute("loginCom")
	LoginManagementCom getLoginManagementComObject()
	{
		return new LoginManagementCom();
	}
	
	/**
	 * This method is used to load the change password page for a user
	 * @param success
	 * @param oldPassword
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.USER_CHANGE_PASSWORD, method = RequestMethod.GET)
	public String loadPage(@ModelAttribute("success") String success,@ModelAttribute("oldPassword") String oldPassword, Model model)
	{
		if(oldPassword != null && !oldPassword.isEmpty())
		{
			model.addAttribute("oldPassword", true);
		}
		
		if(success != null && !success.isEmpty())
		{
			model.addAttribute("success", true);
		}
		
		model.addAttribute("loginCom", getLoginManagementComObject());
		
		return "common/user_change_password";
	}
	
	/**
	 * This method is used to update a user's password in the database
	 * @param loginManagementCom
	 * @param bindingResult
	 * @param redirectAttributes
	 * @return ModelAndView
	 * @throws ServletException
	 * @throws CaerusCommonException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.USER_CHANGE_PASSWORD, method = RequestMethod.POST)
	public ModelAndView changePassword(@ModelAttribute("loginCom") LoginManagementCom loginManagementCom,BindingResult bindingResult, RedirectAttributes redirectAttributes) throws ServletException,CaerusCommonException
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();

		// Creating a domain object 
		LoginManagementDom loginManagementDom = new LoginManagementDom();
		
		loginManagementCom.setEmailId(userName);
		loginManagementCom.setOldPassword(DigestUtils.md5Hex(loginManagementCom.getOldPassword()));

			if(loginManagementCom != null)
			{
				BeanUtils.copyProperties(loginManagementCom, loginManagementDom);
			}
			
			// Retrieving the logged in user details from the database
			LoginManagementDom userLoginDetails = loginManagement.getUserDetailsByEmailID(userName);

			if (userLoginDetails.getPassword().equals(loginManagementCom.getOldPassword()))
			{
				// Update the user's password in the database
				loginManagement.updateUsersLoginPassword(loginManagementDom);
				
				// update the user's recent activities in the database
				loginManagement.updateRecentActivities(userName);
			
				redirectAttributes.addFlashAttribute("success", "success");
				
				logger.info(CaerusLoggerConstants.CHANGED_PASSWORD);
				
				return new ModelAndView(new RedirectView("user_change_password.htm"));
				
			} 
			else 
			{
				redirectAttributes.addFlashAttribute("oldPassword", "oldPassword");
				
				return new ModelAndView(new RedirectView("user_change_password.htm"));
				
			}
		
	}


}