package caerusapp.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * @author RavishaG
 */
@Controller
public class CandidateDetailViewController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	/**
	 * This method is used to display candidate's details
	 * @param studentEmailId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW)
	public String showCandidateDetails(Model model, @RequestParam("studentEmailId") String studentEmailId, @RequestParam(value="jobId", required=false) String jobId , 
			@RequestParam(value="internshipIdAndFirmId", required=false) String internshipIdAndFirmId, @RequestParam(value="campus", required=false) boolean campus,
			@RequestParam(value="universityName", required=false) String universityName,
			HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse, RedirectAttributes redirectAttributes)
	{	
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		
		// Fetching student details
    	StudentDom studentDetails = studentManager.getDetailsByEmailId(studentEmailId);
    	
    	String authority = loginManagement.getAuthorityByEmailId(loggedInUserEmail);
    	
    	boolean checkFlag = checkEmptyCandidateProfile(studentDetails);
    	
    	String firmName = ""; String jobTitleForMessage = "";
    	
    	if(authority != null && authority.equals("ROLE_ADMIN") || authority.equals("ROLE_STUDENT"))
    	{
    		StudentDom studentDom = studentManager.getStudentImage(studentEmailId);
    		
    		studentDetails.setPhotoName(studentDom.getPhotoName());
    	
    	}
    	if(authority != null && authority.equals("ROLE_CORPORATE"))
    	{
    		firmName = loginManagement.getEntityNameByEmailId(loggedInUserEmail);
    		model.addAttribute("companyName", firmName);
    		employerManager.updateEmployerActivity(firmName,studentEmailId,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_VIEWED_PROFILE);
    		
    		//Updating the viewed_by_companies map
			studentManager.updateViewedByCompany(firmName,studentEmailId);
			
			//Add jobId or internshipId for preview of candidate profile
			if(null != jobId && jobId.trim().length() > 0){
				model.addAttribute("jobId", jobId);
				
				//campus job
				if(campus){
					//Get Candidate status for current campus job
					Map<String, String> campusJobStatusMap = studentDetails.getCampusJobStatus();
					if(null != campusJobStatusMap  &&  campusJobStatusMap.size()>0 && campusJobStatusMap.keySet().contains(jobId)){
						model.addAttribute("candidateStatus",campusJobStatusMap.get(jobId));
						model.addAttribute("campus", campus);
						model.addAttribute("universityName",universityName);
					}
					
					jobTitleForMessage = employerManager.getTitleById(jobId, CaerusAPIStringConstants.CAMPUS_JOB_FLAG);
					
				}
				
				else{
					//Get Candidate status for current job
					Map<String, String> jobStatusMap = studentDetails.getJobStatus();
					if(null != jobStatusMap  &&  jobStatusMap.size()>0 && jobStatusMap.keySet().contains(jobId)){
						model.addAttribute("candidateStatus",jobStatusMap.get(jobId));
					}
					if(null != jobId && jobId.trim().length() > 0)
						jobTitleForMessage = employerManager.getTitleById(jobId, CaerusAPIStringConstants.JOB_FLAG);
				}
			
				model.addAttribute("jobTitle", jobTitleForMessage);
			
			}
			
			if(null != internshipIdAndFirmId){
				model.addAttribute("internshipIdAndFirmId", internshipIdAndFirmId);
				
				//campus iternship
				if(campus){
					//Get Candidate status for current campus internship
					Map<String, String> campusInternshipStatusMap = studentDetails.getCampusInternshipStatus();
					if(null != campusInternshipStatusMap  &&  campusInternshipStatusMap.size()>0 && campusInternshipStatusMap.keySet().contains(internshipIdAndFirmId)){
						model.addAttribute("candidateStatus",campusInternshipStatusMap.get(internshipIdAndFirmId));
						model.addAttribute("campus", campus);
						model.addAttribute("universityName",universityName);
					}
					
					jobTitleForMessage = employerManager.getTitleById(internshipIdAndFirmId, CaerusAPIStringConstants.CAMPUS_INTERNSHIP_FLAG);
					
				}
				
				else{
				
					//Get Candidate status for current internship
					Map<String, String> internshipStatusMap = studentDetails.getInternshipStatus();
					if(null != internshipStatusMap  &&  internshipStatusMap.size()>0 && internshipStatusMap.keySet().contains(internshipIdAndFirmId)){
						model.addAttribute("candidateStatus",internshipStatusMap.get(internshipIdAndFirmId));
					}
					
					jobTitleForMessage = employerManager.getTitleById(internshipIdAndFirmId, CaerusAPIStringConstants.INTERNSHIP_FLAG);
					
				}
				
				model.addAttribute("jobTitle", jobTitleForMessage);
				
				
				
			}
    	}
    	
    	if(authority != null && authority.equals("ROLE_STUDENT") && checkFlag)
    	{
    		redirectAttributes.addFlashAttribute("emptyProfile","true");
    		return "redirect:candidate_portfolio.htm";
    	}
    	
    	else
    	{
    		logger.info(CaerusLoggerConstants.PROFILE_PREVIEW);
    		
    		model.addAttribute("authority", authority);
    		
	    	model.addAttribute("studentDetails",studentDetails);
	    	
	    	// Finding candidate's school details
	    	PortfolioDetailsDom schoolDetails = CandidateCommonFeature.getSchoolDetails(studentDetails.getSchoolMap());
	    	
	    	model.addAttribute("schoolDetails", schoolDetails);
	    	
	    	// Finding candidate's university details
	    	List<PortfolioDetailsDom> universityList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
	    	
	    	model.addAttribute("universityList", universityList);
	    	
	    	// Finding candidate's work details
	    	List<PortfolioDetailsDom> workList = CandidateCommonFeature.getWorkDetails(studentDetails.getWorkMap());
	    	
	    	model.addAttribute("workList", workList);
		
	    	// Finding candidate's certification details
			List<PortfolioDetailsDom> certificationList = CandidateCommonFeature.getCertificationList(studentDetails.getCertificationsMap());
				
			model.addAttribute("certificationList", certificationList);
			
			// Finding candidate's publication details
			List<PortfolioDetailsDom> publicationList = CandidateCommonFeature.getPublicationList(studentDetails.getPublicationsMap());
					
			model.addAttribute("publicationList", publicationList);
			
    	}
    	
    	//Sharing the profile via mail
		String friendEmailId = httpServletRequest.getParameter("friendEmailId");
		
		if(friendEmailId != null)
		{
		      Properties mailProperty = new Properties();
		      ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			  InputStream str = classLoader.getResourceAsStream(CaerusStringConstants.CONFIG_FILE);
			  try 
			  {
				mailProperty.load(str);
			  } 
			  catch (IOException e1) 
			  {
				e1.printStackTrace();
			  }
				
		      String host = mailProperty.getProperty("caerus.mail.host");	
		      final String username = mailProperty.getProperty("caerus.mail.username");
			  final String password = mailProperty.getProperty("caerus.mail.password");
			  String from = mailProperty.getProperty("caerus.mail.from.address");
			  String smtpPort = mailProperty.getProperty("caerus.mail.port");

		      Properties props = new Properties();
		      props.put("mail.smtp.auth", "true");
		      props.put("mail.smtp.starttls.enable", "true");
		      props.put("mail.smtp.host", host);
		      props.put("mail.smtp.port", smtpPort);

		      Session session = Session.getInstance(props,
		         new javax.mail.Authenticator() {
		            protected PasswordAuthentication getPasswordAuthentication() {
		               return new PasswordAuthentication(username, password);
		            }
		         });

		      try
		      {
		    	  StudentDom candidateDetails = studentManager.getDetailsByEmailId(studentEmailId);
		    	  
		    	 String name = candidateDetails.getFirstName().concat(" "+candidateDetails.getLastName());
			        
		    	 Message message = new MimeMessage(session);
  
		         message.setFrom(new InternetAddress(from));

		         message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(friendEmailId));

		         message.setSubject("QR Code Image - " + name);

		         MimeMultipart multipart = new MimeMultipart("related");
  
		         BodyPart messageBodyPart = new MimeBodyPart();
		         
			     String htmlText = "<img src=\"cid:image\">";
			     
		         messageBodyPart.setContent(htmlText, "text/html");
			        
		         multipart.addBodyPart(messageBodyPart);
 
		         File imageFile =  studentManager.getQRcodeImage(studentEmailId);
			         
		         messageBodyPart = new MimeBodyPart();
			         
		         DataSource fds = new FileDataSource(imageFile);
			     
		         messageBodyPart.setDataHandler(new DataHandler(fds));
			         
		         messageBodyPart.setHeader("Content-ID", "<image>");

		         multipart.addBodyPart(messageBodyPart);
		         
		         message.setContent(multipart);
		         
		         Transport.send(message);

		         logger.info(CaerusLoggerConstants.MAIL_SENT);

		      }
		      catch (MessagingException e) 
		      {
		         throw new RuntimeException(e);
		      }
		}
		
		/*HttpSession httpSession = httpServletRequest.getSession();
		httpSession.setAttribute("jobId", jobId);
		httpSession.setAttribute("jobtitle", jobDetails.getJobTitle());
		httpSession.setAttribute("companyName", companyName);*/
			
			return "common/candidate_detail_view";
		
		}
	
		private Boolean checkEmptyCandidateProfile(StudentDom studentDetails)
		{
			boolean flag = false;
			
			if(studentDetails.getSchoolMap().size() == 0 || studentDetails.getUniversityMap().size() == 0 || studentDetails.getFirstName().equals("") || studentDetails.getLastName().equals("") ||
		    		studentDetails.getZipCode() == null  || studentDetails.getDateOfBirth().equals(""))
			{
				flag = true;
			}
		
			return flag;
			
		}
	
	}
