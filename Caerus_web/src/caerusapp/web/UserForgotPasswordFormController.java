/**
 * 
 */
package caerusapp.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import caerusapp.command.common.LoginManagementCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;
import caerusapp.util.PasswordGeneratorUtil;

/**
 * This class is used for forgot password functionality
 * @author RavishaG
 * 
 */
@RestController
public class UserForgotPasswordFormController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
	@Autowired
	private ILoginManagement loginManagement;
	
	@Autowired
	MailUtil mailUtil;
	
	@ModelAttribute("loginManagementCom")
	LoginManagementCom getloginManagementComObject()
	{
		return new LoginManagementCom();
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.USER_FORGOT_PASSWORD, method = RequestMethod.GET)
	public String loadPage(Model model)
	{
		model.addAttribute("loginManagementCom", getloginManagementComObject());
		return "common/user_forgot_password";
	}

	/**
	 * This method is used to generate a new password for a user 
	 * @throws IOException 
	 */
	
	/*@RequestMapping(value = CaerusAnnotationURLConstants.USER_FORGOT_PASSWORD, method = RequestMethod.POST)
	public ModelAndView updateUserPassword(@ModelAttribute("success") String success, @ModelAttribute("error") String error,@ModelAttribute("unregistered") String unregistered,
			@ModelAttribute("loginManagementCom") @Valid LoginManagementCom loginManagementCom, BindingResult bindingResult, RedirectAttributes redirectAttributes, HttpServletRequest httpServletRequest) throws ServletException,CaerusCommonException, IOException 
	{
		ModelAndView modelAndView = new ModelAndView("common/user_forgot_password");
		
		if(success != null && !success.isEmpty())
		{
			modelAndView.addObject("success", true);
		}
		
		if(error != null && !error.isEmpty())
		{
			modelAndView.addObject("error", true);
		}
		
		if(unregistered != null && !unregistered.isEmpty())
		{
			modelAndView.addObject("unregistered", true);
		}
		
		if(!bindingResult.hasErrors())
		{
			// Creating a domain object 
			LoginManagementDom loginManagementDom = new LoginManagementDom();
	
			loginManagementDom.setEmailId(loginManagementCom.getEmailId());
	
				// check if the user is a valid user
				Boolean validUserFlag = loginManagement.checkValidUser(loginManagementDom.getEmailId());
	
				if (validUserFlag != null)
				{
					if (validUserFlag == true) 
					{
						loginManagementDom.setNewPassword(PasswordGeneratorUtil.randomStringGenerator());
						LoginManagementDom validUser = loginManagement.getUserDetailsByEmailID(loginManagementDom.getEmailId());
						
						//loginManagementForgotPasswordDom.setNewPassword(loginManagementForgotPasswordCom.getNewPassword());
		
						if (loginManagementDom != null) 
						{
							loginManagement.updateUsersLoginPassword(loginManagementDom);
							StringBuffer html = new StringBuffer();
							html.append("<!DOCTYPE html>");
							html.append("<html lang='en'>");
							html.append("<head>");
							html.append("<meta charset='utf-8'>");
							html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
							html.append("<title>Candidate View Particular Job</title>");
							html.append("<meta name='description' content=''>");
							html.append("<meta name='author' content=''>");
							html.append("</head>");
							html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
							html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
							html.append("<tr>");
							html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Imploy.Me </td>");
							html.append("</tr>");

							html.append("</table>");

							html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
							html.append("<tr>");
							html.append("<td>");
							
							html.append("<table>");
							html.append("<tbody><tr>");
							
							html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='firstName'></span>,</td>");
							html.append("</tr>");
							html.append("<tr>");
							html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>We have recieved a request for "+"\"Forgot Password\""+" from you for <span id='userName'></span>.</td>");
							html.append("</tr>");
							html.append("<tr>");
							html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Please find your new password below.</td>");
							html.append("</tr>");
							html.append("<tr>");
							html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'> New Password: <span id = 'userPassword'></td>");
							html.append("</tr>");
							html.append("<tr>");
							html.append("<td style='padding-top : 15px;'>");
							html.append("<span style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Click </span> <a href='#' target='_blank' style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Imploy.me</a> <span style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>to login with your new credentials.</span>");
							html.append("</tr>");
							html.append("<tr>");
							html.append("<td style='padding-top : 15px;'>");
							html.append("</td>");
							html.append("</tr>");
							
							
							html.append("<tr>");
							html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
							html.append("</tr>");
							html.append("</tbody>");
							html.append("</table>");
							html.append("</td>");
							html.append("</tr>");
							html.append("</table>");
							html.append("</body>");
							html.append("</html>");
							
							String path = httpServletRequest.getContextPath();
						    String basePath = httpServletRequest.getScheme()+"://"+httpServletRequest.getServerName()+":"+httpServletRequest.getServerPort()+path+"/";
							String imployLink = basePath+"home.htm";
							
							Document doc = Jsoup.parse(html.toString());
							if(null!= validUser.getFirstName()){
								
								doc.getElementById("firstName").text(validUser.getFirstName());
							}
							else {
								doc.getElementById("firstName").text("User");
							}
							doc.getElementById("userName").text(validUser.getUserName());
							Elements links = doc.select("a[href]");
							for (Element link : links)  
							{
						        link.attr("href",imployLink);
						    }
							
							doc.getElementById("userPassword").text(loginManagementDom.getNewPassword());
							String mailSubject="Imploy.me Password";

							String userMailId = loginManagementDom.getEmailId(); 
							try
							{
								//Mailing a new password to user
								mailUtil.sendMailToUsers(userMailId, doc.toString(), mailSubject);
							}
							catch (IOException ie) 
							{
								ie.printStackTrace();
							}
							catch (Exception e) 
							{
								e.printStackTrace();
							}
							logger.info(CaerusLoggerConstants.MAIL_SENT);
						}
		
						redirectAttributes.addFlashAttribute("success", true);
						return new ModelAndView(new RedirectView("user_forgot_password.htm"));
						
					} 
					
					else 
					{
						redirectAttributes.addFlashAttribute("error", true);
						return new ModelAndView(new RedirectView("user_forgot_password.htm"));
		
					}
				}
				else
				{
					redirectAttributes.addFlashAttribute("unregistered", "true");
					//return new ModelAndView(new RedirectView("user_forgot_password.htm"));
					return new ModelAndView(new RedirectView("home.htm"));
				}
		}
		else
		{
			return modelAndView;
		}
	}*/
	
	@RequestMapping(value = CaerusAnnotationURLConstants.USER_FORGOT_PASSWORD, method = RequestMethod.POST)
	@ResponseBody
	boolean resetUserPassword(@RequestParam("emailId") String emailId,HttpServletRequest httpServletRequest)
	{
		boolean validUserFlag = false;
		if(null != emailId && emailId.trim().length() > 0)
		{
			String returnMessage = "";
			validUserFlag = loginManagement.checkValidUser(emailId);
			
			if (validUserFlag) 
			{
				
				returnMessage = "Successfully Reset your Password. Please check your Mail.";
				LoginManagementDom validUser = loginManagement.getUserDetailsByEmailID(emailId);
				validUser.setEmailId(emailId);
				validUser.setNewPassword(PasswordGeneratorUtil.randomStringGenerator());
				
				if (null != validUser) 
				{
					loginManagement.updateUsersLoginPassword(validUser);
				}
				
				StringBuffer html = new StringBuffer();
				html.append("<!DOCTYPE html>");
				html.append("<html lang='en'>");
				html.append("<head>");
				html.append("<meta charset='utf-8'>");
				html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
				html.append("<title>Forgot Password</title>");
				html.append("<meta name='description' content=''>");
				html.append("<meta name='author' content=''>");
				html.append("</head>");
				html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
				html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
				html.append("<tr>");
				html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Imploy.Me </td>");
				html.append("</tr>");
	
				html.append("</table>");
	
				html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
				html.append("<tr>");
				html.append("<td>");
				
				html.append("<table>");
				html.append("<tbody><tr>");
				
				html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='firstName'></span>,</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>We have recieved a request for "+"\"Forgot Password\""+" from you for <span id='userName'></span>.</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Please find your new password below.</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'> New Password: <span id = 'userPassword'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='padding-top : 15px;'>");
				html.append("<span style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Click </span> <a href='#' target='_blank' style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Imploy.me</a> <span style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>to login with your new credentials.</span>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='padding-top : 15px;'>");
				html.append("</td>");
				html.append("</tr>");
				
				
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
				html.append("</tr>");
				html.append("</tbody>");
				html.append("</table>");
				html.append("</td>");
				html.append("</tr>");
				html.append("</table>");
				html.append("</body>");
				html.append("</html>");
				
				String path = httpServletRequest.getContextPath();
			    String basePath = httpServletRequest.getScheme()+"://"+httpServletRequest.getServerName()+":"+httpServletRequest.getServerPort()+path+"/";
				String imployLink = basePath+"home.htm";
				
				Document doc = Jsoup.parse(html.toString());
				if(null!= validUser.getFirstName())
					doc.getElementById("firstName").text(validUser.getFirstName());
				else 
					doc.getElementById("firstName").text("User");
				
				doc.getElementById("userName").text(validUser.getUserName());
				Elements links = doc.select("a[href]");
				for (Element link : links)  
				{
			        link.attr("href",imployLink);
			    }
				
				doc.getElementById("userPassword").text(validUser.getNewPassword());
				String mailSubject="Imploy.me Password";
	
				String userMailId = validUser.getEmailId(); 
				try
				{
					//Mailing a new password to user
					mailUtil.sendMailToUsers(userMailId, doc.toString(), mailSubject);
				}
				catch (IOException ie) 
				{
					ie.printStackTrace();
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
				logger.info(CaerusLoggerConstants.MAIL_SENT);
				
		}
		else
			returnMessage = "Sorry. We couldnt Recognize your EmailId";
		}
		return validUserFlag;
	}
}