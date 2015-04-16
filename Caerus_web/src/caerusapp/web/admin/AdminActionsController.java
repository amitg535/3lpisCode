/**
 * 
 */
package caerusapp.web.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.domain.common.BetaUserDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.MessageDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityDetailsDom;
/*import caerusapp.domain.employer.Employee;
import caerusapp.domain.student.Student;
import caerusapp.domain.university.UniversityLoginDom;*/
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMessageManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.StudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.MailUtil;
import caerusapp.util.PasswordGeneratorUtil;

/**This class is used to implement various Admin Actions
 * @author PallaviD
 *
 */
@Controller
public class AdminActionsController {
	
	
	//Logger for this class and subclasses 
	protected final Log logger = LogFactory.getLog(getClass());
		
	//Auto-wiring service component
	@Autowired 
	private ILoginManagement loginManagement;
	
	@Autowired
	private IMessageManager messageManager;
	
	@Autowired
	StudentManager studentManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	MailUtil mailUtil;
	/**
	 * This method is used by Admin to enable users
	 * @param enableUsersMap
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws Exception
	 */
	@RequestMapping(value= CaerusAnnotationURLConstants.ADMIN_ENABLE_USERS, method = RequestMethod.POST)
	public void enableUsers(@RequestBody Map<String,String> enableUsersMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{
		logger.info(CaerusLoggerConstants.ADMIN_ENABLE_USERS);
		
		try{
			
			loginManagement.enableUsers(enableUsersMap);
		}
		
		catch(Exception e){
			
			e.printStackTrace();
		}
	}
	
	/**
	 * This method is used by Admin to disable users
	 * @param disableUsersMap
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws Exception
	 */
	@RequestMapping(value= CaerusAnnotationURLConstants.ADMIN_DISABLE_USERS, method = RequestMethod.POST)
	public void disableUsers(@RequestBody Map<String,String> disableUsersMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{
		logger.info(CaerusLoggerConstants.ADMIN_DISABLE_USERS);
		
		try{
			
			loginManagement.disableUsers(disableUsersMap);
		}
		
		catch(Exception e){
			
			e.printStackTrace();
		}
	}
	
	/**
	 * This method is used to display Admin Dashboard
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws Exception
	 */
	@RequestMapping(value= CaerusAnnotationURLConstants.ADMIN_MANAGE_USERS, method = RequestMethod.GET)
	public ModelAndView handleRequest(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{
		logger.info(CaerusLoggerConstants.ADMIN_LOGIN); 
		
		//The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("admin/admin_login");
		
		// Exception handling
		try
		{

			// Retrieving the details of the admin from the database
			List<LoginManagementDom> userDataList = loginManagement.getUserDetails();
			
			// Creating a new session
			HttpSession session = httpServletRequest.getSession();
				
			// Setting values in the session
			session.setAttribute("adminName", "Caerus");
			session.setAttribute("username", "Admin");

		 					
		 List<LoginManagementDom> corporateList = new ArrayList<LoginManagementDom>();
		 List<LoginManagementDom> studentList = new ArrayList<LoginManagementDom>();
		 List<LoginManagementDom> universityList = new ArrayList<LoginManagementDom>();
		
		// Iterating through the list of users
		 Iterator<LoginManagementDom> itr1 = userDataList.iterator();
	      while(itr1.hasNext()) {
	    	  LoginManagementDom currentUser = (LoginManagementDom) itr1.next();
	    	  
	    	  if(currentUser.getUserName()!=null && currentUser.getAuthority()!=null){
	    		  if(currentUser.getAuthority().equalsIgnoreCase("ROLE_STUDENT"))
	    			  studentList.add(currentUser);
	    		  else if(currentUser.getAuthority().equalsIgnoreCase("ROLE_CORPORATE"))
	    			  corporateList.add(currentUser);
	    		  else if(currentUser.getAuthority().equalsIgnoreCase("ROLE_UNIVERSITY"))
	    			  universityList.add(currentUser);
	    	    }
	   }
		
	      modelAndView.addObject("studentList", studentList);
	      modelAndView.addObject("corporateList", corporateList);
	      modelAndView.addObject("universityList", universityList);
			  
		}
	
		catch(Exception ex)
		{ 
			ex.printStackTrace();
			logger.info(ex.getStackTrace());
		}
		
		return modelAndView;
	}
	
	/**
	 * This method is used to load the verify user photos and videos page
	 * @author RavishaG
	 * @param htpHttpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_VERIFICATIONS)
	public String verificationsPage(@ModelAttribute("videoTab") String videoTab, Model model, HttpServletRequest htpHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(videoTab != null && !videoTab.isEmpty())
			model.addAttribute("videoTab", true);
		
		List<StudentDom> studentList = loginManagement.getUnverifiedPhotoStudents();
		model.addAttribute("studentList",studentList);
		
		List<StudentDom> candidateList = loginManagement.getUnverifiedVideoStudents();
		model.addAttribute("candidateList",candidateList);
		
		return "admin/admin_verifications";
	}

	/**
	 * This method is used to verify or reject user photos
	 * @author RavishaG
	 * @param veriyFlag
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_VERIFY_USER_PHOTO)
	public ModelAndView verifyUserPhoto(@RequestParam("userName") String userName, @RequestParam("verifyFlag") String verifyFlag, HttpServletRequest httpServletRequest)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String emailId = authentication.getName();
		
		MessageDom messageDom = new MessageDom();
		
		if(verifyFlag.equals("verify"))
		{
			loginManagement.verifyUserPhoto(userName);
			
			messageDom.setMessageSubject("Photo Verification Successful");
			messageDom.setReceiverEmailId(userName);
			messageDom.setSenderEmailId(emailId);
			messageDom.setMessage("Dear User ,Congratulations your photo has been succesfully verified. Now corporates and Universities would be able to see your profile Photo.Regards, Imploy.me Team");
			messageDom.setFirstMessage(true);
			
			messageManager.addMessage(messageDom);
		}
		else
		{
			loginManagement.rejectUserPhoto(userName);
			
			messageDom.setMessageSubject("Photo Verification Failed");
			messageDom.setReceiverEmailId(userName);
			messageDom.setSenderEmailId(emailId);
			messageDom.setMessage("Dear User ,The photo that you have uploaded violates our photo policy guidelines . Please upload a new photo which clearly depicts your face and is not offensive or promotes nudity in any manner .Regards, Imploy.me Team");
			messageDom.setFirstMessage(true);
			
			messageManager.addMessage(messageDom);
			
		}
		
		return new ModelAndView(new RedirectView("admin_verification.htm"));
	}
	
	/**
	 * This method is used to verify or reject user profile videos
	 * @author RavishaG
	 * @param veriyFlag
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_VERIFY_USER_VIDEO)
	public ModelAndView verifyUserVideo(@RequestParam("userName") String userName, @RequestParam("verifyFlag") String verifyFlag, HttpServletRequest httpServletRequest,
			RedirectAttributes redirectAttributes)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String emailId = authentication.getName();
		
		MessageDom messageDom = new MessageDom();
		
		if(verifyFlag.equals("verify"))
		{
			loginManagement.verifyUserVideo(userName);
			
			messageDom.setMessageSubject("Video Verification Successful");
			messageDom.setReceiverEmailId(userName);
			messageDom.setSenderEmailId(emailId);
			messageDom.setMessage("Dear User ,Congratulations your video has been succesfully verified. Now corporates and Universities would be able to see your profile video.Regards, Imploy.me Team");
			messageDom.setFirstMessage(true);
			
			messageManager.addMessage(messageDom);
		}
		else
		{
			loginManagement.rejectUserVideo(userName);
			
			messageDom.setMessageSubject("Video Verification Failed");
			messageDom.setReceiverEmailId(userName);
			messageDom.setSenderEmailId(emailId);
			messageDom.setMessage("Dear User ,The video that you have uploaded violates our photo policy guidelines . Please upload a new video which clearly depicts your face and is not offensive or promotes nudity in any manner .Regards, Imploy.me Team");
			messageDom.setFirstMessage(true);
			
			messageManager.addMessage(messageDom);
			
		}
		
		redirectAttributes.addFlashAttribute("videoTab", "true");
		return new ModelAndView(new RedirectView("admin_verification.htm"));
	}
	
	/**
	 * This method is used to manage beta users by admin
	 * @author ravishag
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 */
	@RequestMapping(value= CaerusAnnotationURLConstants.ADMIN_MANAGE_BETA_USERS)
	public ModelAndView manageBetaUsers(@ModelAttribute("error") String error, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		logger.info(CaerusLoggerConstants.BETA_USERS_PAGE);
		
		//The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("admin/admin_manage_beta_users");
		
		// Get List of Beta Users
		List<BetaUserDom> betaUsers = loginManagement.getBetaUsers();
		
		if(error != null && !error.isEmpty())
		{
			modelAndView.addObject("error", true);
		}
		
		modelAndView.addObject("betaUserList", betaUsers);
		
		// Redirecting to the defined page
		return modelAndView;
	}

	/**
	 * This method is used by admin to confirm a beta user
	 * @author RavishaG
	 * @param emailId
	 * @param role
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_CONFIRM_BETA_USERS)
	public ModelAndView confirmUser(@RequestParam("emailId") String emailId, @RequestParam("role") String role, HttpServletRequest httpServletRequest, 
			HttpServletResponse httpServletResponse, RedirectAttributes redirectAttributes)
	{
		// check role of user
		if(role.equals("Student"))
		{
			StudentDom student = new StudentDom();	
			
			student.setEmailID(emailId);
			
			int registeredCandidateCount = studentManager.getStudentByEmailId(emailId);
			
			// check if student is already registered
			if (registeredCandidateCount == 0) {
				
				student.setFirstLogin(true);
				
				// Set student's profile visibility to true by default
				student.setProfileVisibility(true);

				Map<String,Boolean> mailSettingsMap = new HashMap<String,Boolean>();
				
				// Set student's mail setting map to default settings
				mailSettingsMap.put("subscribe",true);
				mailSettingsMap.put("jobupdates", true);
				mailSettingsMap.put("eventupdates", true);
				mailSettingsMap.put("contactme", true);
				
				student.setMailSettingsMap(mailSettingsMap);
				student.setAuthority("ROLE_STUDENT");
				
				String password = PasswordGeneratorUtil.randomStringGenerator();
				student.setPassword(password);
				student.setFirstName("Beta");
				student.setLastName("Student");
				
				// adding student
				studentManager.candidateBetaRegistration(student);
				
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
				html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
				html.append("</tr>");

				html.append("</table>");

				html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
				html.append("<tr>");
				html.append("<td>");
				
				html.append("<table>");
				html.append("<tbody><tr>");
				
				html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thank you for registering with us for the beta services. Please find your beta credentials included in this mail.</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Username: <span id = 'userMailId'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Password: <span id = 'userPassword'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
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
				
				Document doc = Jsoup.parse(html.toString());
				doc.getElementById("userName").text("Beta User");
				doc.getElementById("userMailId").text(student.getEmailID());
				doc.getElementById("userPassword").text(password);
				String mailSubject="Beta User credentials for Imploy.me";

				 try 
				 {
					 mailUtil.sendMailToUsers(student.getEmailID(), doc.toString(), mailSubject);
				 } 
				 catch (IOException e) 
				 {
					e.printStackTrace();
				 }
				
				//updating status in beta_user_details table
				loginManagement.updateBetaUserStatus(emailId,"Confirmed");

			}
			
			else
			{	
				// sending error message to admin manage users page
				redirectAttributes.addFlashAttribute("error","true");
				
				return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
				
			}
			
		}
		
		// check role of user
		if(role.equals("Employer"))
		{
			EmployerDom employee = new EmployerDom();
			
			employee.setEmailID(emailId);
			
			int registeredEmployerCount = employerManager.getEmployerByEmailId(emailId);		
			
			String companyNumber = loginManagement.getLastInsertedBetaCompanyNumber();
			
			String companyName = "BetaCompany".concat(companyNumber);
			
			employee.setCompanyName(companyName);
			
			employee.setCompanyType("Company");
			
			employee.setCompanyRegNumber("123-456-789");
			
			employee.setFirstName("Beta");
			
			employee.setLastName("Corporate");
			
					
			// check if employer is already registered
			if (registeredEmployerCount == 0) {
				
				employee.setAuthority("ROLE_CORPORATE");
				
				String password = PasswordGeneratorUtil.randomStringGenerator();
				
				employee.setPassword(password);
				/*ServletContext servletContext = httpServletRequest.getSession().getServletContext();
				String contextPath = servletContext.getRealPath(File.separator);
				//Add default not available image
				contextPath+= CaerusPathConstants.defaultImagePath;*/
				
		        /*byte[] imageData;
				try {
					imageData = FileUtils.readFileToByteArray(new File(contextPath));
					 employee.setImageName("Default Image");
				        employee.setImageData(imageData);
						
				} catch (IOException e1) {
					e1.printStackTrace();
				}*/
				// add employee
				employerManager.addEmployer(employee);
				
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
				html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
				html.append("</tr>");

				html.append("</table>");

				html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
				html.append("<tr>");
				html.append("<td>");
				
				html.append("<table>");
				html.append("<tbody><tr>");
				
				html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thank you for registering with us for the beta services. Please find your beta credentials included in this mail.</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Username: <span id = 'userMailId'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Password: <span id = 'userPassword'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
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
				
				Document doc = Jsoup.parse(html.toString());
				doc.getElementById("userName").text("Beta User");
				doc.getElementById("userMailId").text(employee.getEmailID());
				doc.getElementById("userPassword").text(password);
				String mailSubject="Beta User credentials for Imploy.me";

				 try 
				 {
					 mailUtil.sendMailToUsers(employee.getEmailID(), doc.toString(), mailSubject);
				 } 
				 catch (IOException e) 
				 {
					e.printStackTrace();
				 }
				 
				// enable user
				 loginManagement.enableUser(emailId);
				 
				 LoginManagementDom loginManagementDom = new LoginManagementDom();
				 
				 loginManagementDom.setEmailId(emailId);
				 loginManagementDom.setNewPassword(password);
				 
				 loginManagement.updateUsersLoginPassword(loginManagementDom);
				 
				 //updating status in beta_user_details table
				 loginManagement.updateBetaUserStatus(emailId,"Confirmed");
			}
			
			else
			{
				// sending error message to admin manage users page
				redirectAttributes.addFlashAttribute("error","true");
				
				return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
			}
		}	
		
		// check role of user
		if(role.equals("University"))
		{	
			UniversityDetailsDom universityRegisterationDom = new UniversityDetailsDom();
			
			universityRegisterationDom.setEmailID(emailId);
			
			String universityNumber = loginManagement.getLastInsertedBetaUniversityNumber();
			
			String universityName = "BetaUniversity".concat(universityNumber);
			
			universityRegisterationDom.setUniversityRegistrationNumber("123-456-789");
					
			// set university name
			universityRegisterationDom.setUniversityName(universityName);
			
			universityRegisterationDom.setFirstName("Beta");
			
			universityRegisterationDom.setLastName("University");
					
			int usercount = universityManager.checkUniversityEmailIdExist(universityName);
						
			int usercount1=universityManager.getUniversityByUniversityName(universityName);

			// check if the university is not already registered with Imploy , then register it
			if (usercount == 0 && usercount1 == 0) {
			
				universityRegisterationDom.setAuthority("ROLE_UNIVERSITY");
				
				String password = PasswordGeneratorUtil.randomStringGenerator();
				
				universityRegisterationDom.setPassword(password);
				
				universityManager.addUniversity(universityRegisterationDom);
				
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
				html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
				html.append("</tr>");

				html.append("</table>");

				html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
				html.append("<tr>");
				html.append("<td>");
				
				html.append("<table>");
				html.append("<tbody><tr>");
				
				html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thank you for registering with us for the beta services. Please find your beta credentials included in this mail.</td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Username: <span id = 'userMailId'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td> Password: <span id = 'userPassword'></td>");
				html.append("</tr>");
				html.append("<tr>");
				html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
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
				
				Document doc = Jsoup.parse(html.toString());
				doc.getElementById("userName").text("Beta User");
				doc.getElementById("userMailId").text(universityRegisterationDom.getEmailID());
				doc.getElementById("userPassword").text(password);
				String mailSubject="Beta User credentials for Imploy.me";
				
				// Update Email send to University regarding the registration
				try 
				{
					mailUtil.sendMailToUsers(universityRegisterationDom.getEmailID(), doc.toString(), mailSubject);
				} 
				catch (IOException e) 
				{
					e.printStackTrace();
				}
				
				// enable user
				loginManagement.enableUser(emailId);
				
				LoginManagementDom loginManagementDom = new LoginManagementDom();
				 
				 loginManagementDom.setEmailId(emailId);
				 loginManagementDom.setNewPassword(password);
				 
				 loginManagement.updateUsersLoginPassword(loginManagementDom);

				//updating status in beta_user_details table
				loginManagement.updateBetaUserStatus(emailId,"Confirmed");
				
			} 
			
			else
			{
				// sending error message to admin manage users page
				redirectAttributes.addFlashAttribute("error","true");
				
				return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
			}
		}
		
		return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
	}
	
	/**
	 * This method is used to delete a beta user
	 * @author RavishaG
	 * @param emailId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 */
/*	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_DELETE_BETA_USERS)
	public ModelAndView deleteBetaUser(@RequestParam("emailId") String emailId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		//updating status in beta_user_details table
		loginManagement.updateBetaUserStatus(emailId,"Deleted");
		
		int userCount = loginManagement.checkValidUser(emailId);
		
		// If user does not exist
		if(userCount != 0)
		{
			// disable user
			loginManagement.disableUser(emailId);
		}
		
		return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
	}*/
	
	/**
	 * This method is used to undo delete action on a beta user
	 * @author RavishaG
	 * @param emailId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 */
	/*@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_UNDO_DELETE_ACTION)
	public ModelAndView undoDeleteAction(@RequestParam("emailId") String emailId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		int userCount = loginManagement.checkValidUser(emailId);
		
		// If user does not exist
		if(userCount == 0)
		{
			//updating status in beta_user_details table
			loginManagement.updateBetaUserStatus(emailId,"Pending");
		}
		
		else
		{
			//updating status in beta_user_details table
			loginManagement.updateBetaUserStatus(emailId,"Confirmed");
			
			// enable user
			loginManagement.enableUser(emailId);

		}
		
		return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
	}*/
	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_MANAGE_DATABASE,method=RequestMethod.GET)
	public String adminManageDatabase(){
		return CaerusJSPMapper.ADMIN_MANAGE_DATABASE;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_MANAGE_DATABASE,method=RequestMethod.POST)
	public String adminChangeDatabase(@ModelAttribute("loginManagentCom") LoginManagementDom loginManagentCom){
		if(loginManagement.checkEntityExist(loginManagentCom.getEntityName())){
			if(loginManagentCom.getAuthority().equals("ROLE_CORPORATE")){
				loginManagement.changeCompanyNameforNonPrimarykeys(loginManagentCom);
			}
		}
		return "redirect:"+CaerusAnnotationURLConstants.ADMIN_MANAGE_DATABASE;
		
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.ADMIN_RESENDMAIL_BETA_USERS)
	public ModelAndView resendMail(@RequestParam("emailId") String emailId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String newPassword = PasswordGeneratorUtil.randomStringGenerator();
		
		LoginManagementDom loginManagementDom = new LoginManagementDom();
		loginManagementDom.setNewPassword(newPassword);
		loginManagementDom.setEmailId(emailId);
		
		
		
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
		html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
		html.append("</tr>");

		html.append("</table>");

		html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
		html.append("<tr>");
		html.append("<td>");
		
		html.append("<table>");
		html.append("<tbody><tr>");
		
		html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'>Thank you for registering with us for the beta services. Please find your beta credentials included in this mail.</td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("<td> Username: <span id = 'userMailId'></td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("<td> New Password Password: <span id = 'userPassword'></td>");
		html.append("</tr>");
		html.append("<tr>");
		html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
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
		
		Document doc = Jsoup.parse(html.toString());
		doc.getElementById("userName").text("Beta User");
		doc.getElementById("userMailId").text(loginManagementDom.getEmailId());
		doc.getElementById("userPassword").text(loginManagementDom.getNewPassword());
		String mailSubject="Beta User credentials for Imploy.me";
		
		// Update Email send to University regarding the registration
		try 
		{
			loginManagement.updateUsersLoginPassword(loginManagementDom);
			mailUtil.sendMailToUsers(loginManagementDom.getEmailId(), doc.toString(), mailSubject);
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		
		return new ModelAndView(new RedirectView("admin_manage_beta_users.htm"));
	}
}