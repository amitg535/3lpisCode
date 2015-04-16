/**
 * 
 */
package caerusapp.web.employer;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.ContentIdGenerator;
import caerusapp.util.MailUtil;


/**
 * @author TrishnaR
 * This class is used to download or mail a candidate's profile.
 *
 */
@Controller
public class EmployerDownloadAndMailCandidateProfileController 
{

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	MailUtil mailUtil;
	
	@Autowired
	IEmployerManager employerManager;
	
	//Auto-wiring service component
	@Autowired 
	StudentManager studentManager;
	
	/**
	 * This method is used to download a candidate's profile by the employer 
	 * @author TrishnaR
	 * @param candidateEmailId
	 * @param jobId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DOWNLOAD_CANDIDATE_PROFILE)
	ModelAndView downloadCandidateProfile(@RequestParam("emailId") String candidateEmailId,@RequestParam(value="jobId",required=false) String jobId,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException
	{
		//Fetching the candidate's details
		StudentDom studentDetails = studentManager.getDetailsByEmailId(candidateEmailId);
		
		String exceptionMessage = null;
		
		boolean exceptionOccured=false;
       
		//Spring security authentication containing the logged in user details
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	    
	  //Exception handling
		try
		{
			
			employerManager.updateEmployerActivity(httpServletRequest.getSession().getAttribute("compName").toString(), candidateEmailId, CaerusAPIStringConstants.EMPLOYER_ACTIVITY_DOWNLOADED_RESUME);
			String resumeName=studentDetails.getResumeName();
			    
			 	if(resumeName!=null && !resumeName.equals(null))
			     {
			    	 httpServletResponse.setHeader("Content-Disposition","attachment; filename=\"" + resumeName +"\"");
			    	 FileCopyUtils.copy(studentDetails.getFileData(), httpServletResponse.getOutputStream()); 
			     } 
			     else
			     {
			    	//throw new CaerusCommonException("Resume is not available in database, Please upload you resume");
			    	 exceptionMessage = "Oops,Resume is not available in Database" ;
			    	 exceptionOccured=true;
				 }
				 
		}
		catch(NullPointerException npe)
		{
			npe.printStackTrace();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		Map<String, Object> stuProfileModel = new HashMap<String, Object>();
		stuProfileModel.put("exceptionMessage", exceptionMessage);
		stuProfileModel.put("viewDetails",studentManager.getDetailsByEmailId(candidateEmailId));
		
		if (exceptionOccured==true)
		{
			//returning the modelAndView object containing the model(stuProfileModel) and the view(jsp)
			 return new ModelAndView("employer/employer_view_candidate_details",  "model", stuProfileModel);
		} 
		else
		{
			 return null;
		}
		
	}
	
	/**
	 * This method is used by the employer to email the candidate details.
	 * @author TrishnaR
	 * @param corporateEmailId
	 * @param candidateEmailId
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws IOException
	 * @throws MessagingException 
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_EMAIL_CANDIDATE_PROFILE)
	void emailCandidateProfile(@RequestParam("corporateEmailId") String corporateEmailId,@RequestParam("candidateEmailId") String candidateEmailId,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException, MessagingException
	{
		
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String employerEmailId = authentication.getName();
		
		//Loading the servlet context
		ServletContext servletContext = httpServletRequest.getSession().getServletContext();
		String contextPath = servletContext.getRealPath(File.separator);
		
		//Creating a jsoup document containing the candidate's details
		Document document = candidateProfileDocument(httpServletRequest, candidateEmailId);
		Elements elements = document.select("div.innercontainer img");
		
		byte[] imageContent = Jsoup.connect(elements.attr("abs:src")).ignoreContentType(true).execute().bodyAsBytes();
	
		String cid = ContentIdGenerator.getContentId();
		
		//Retrieving the html content  
		String headOpen = "<!DOCTYPE html><html lang=\"en\"><head>";
		String headClose = "</head><body style=\"background:#fff;\">";
		String appendImage="<div><img src=\"cid:"+ cid+ "\" width=\"152\" height=\"152\" /></div>\n";
		if(null != document.getElementById("profilePicture"))
			document.getElementById("profilePicture").remove();
		
		Element content = document.getElementById("innersection");
		String divOpen = content.outerHtml();
		String htmlClose = "</div></body></html>";
		String textContent = headOpen +  headClose + appendImage+ divOpen + htmlClose;
		
		//Creating a map containing the candidate's profile contents
		Map<String, Object> profileContent = new HashMap<String, Object>();
		
		profileContent.put("textContent",textContent);
		profileContent.put("imageContent",imageContent);
		profileContent.put("contextPath", contextPath);
		profileContent.put("cid",cid);
	
		String subject=employerEmailId+" Has forwarded Candidate details!!"+candidateEmailId;
			
		//Exception handling
			try
			{
				//Mailing a candidate's profile(Recommending a candidate) to an employer.
				mailUtil.sendCandidateProfile(corporateEmailId, profileContent, subject);
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
	

	/**
	 *	This method is used to retrieve a jsoup document containing the candidate's profile details.
	 * @author TrishnaR
	 * @param httpServletRequest
	 * @param candidateEmailId
	 * @return
	 * @throws IOException
	 */
	private Document candidateProfileDocument(HttpServletRequest httpServletRequest,String candidateEmailId) throws IOException{
		
		String serverName = httpServletRequest.getServerName();
		 int serverPort = httpServletRequest.getServerPort();
		//String applicationPath = "/detail_view_candidate.htm";
		 
		String dataUrl = CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW ;
		HttpSession session = httpServletRequest.getSession();
		
		//Connecting to the existing session and retrieving the DOM structure 
	    String fullPath = "http://" + serverName + ":" + serverPort + dataUrl+";jsessionid="+session.getId().toString();
	    
	    logger.info(fullPath);

	    Map<String , String> test = new HashMap<String, String>();
	    test.put("studentEmailId", candidateEmailId);
	    //test.put("jobId", "");
	   	Document document = Jsoup.connect(fullPath).data(test).timeout(0).get();
		
	   	if(null != document){
	   		if(null != document.getElementById("toolbarCandidate"))
	   			document.getElementById("toolbarCandidate").remove();
	   		
	   		if(null != document.getElementById("btnBack"))
	   			document.getElementById("btnBack").remove();
	   		//document.getElementById("sticky1").remove();
	   		
	   		if(null != document.getElementById("myModal1"))
	   			document.getElementById("myModal1").remove();
	   		
	   		if(document.getElementById("videoProfileButtton") != null)
	   			document.getElementById("videoProfileButtton").remove();
	   	}
		return document;
		
	}
	
	}