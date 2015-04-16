package caerusapp.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusStringConstants;

/**
 * This class is used to fetch the company logo 
 *  
 */
@Controller
public class ViewImageController {

	
protected final Log logger = LogFactory.getLog(getClass());

	//Auto-wiring service components
	@Autowired
	private IEmployerManager employerManager;

	@Autowired
	private ILoginManagement loginManagement;
	
	@Autowired
	private IStudentManager studentManager;
	
	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	IMasterManager masterManager;
	
	/**
	 * This method is used to fetch the company logo 
	 *  
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.VIEW_IMAGE)
	public void handleRequest(@RequestParam(value="emailId", required=false) String emailId, @RequestParam(value="isHomePage", required=false) boolean isHomePage,
			 @RequestParam(value="isMessagePage", required=false) boolean isMessagePage, @RequestParam(value="studentEmailId", required=false) String studentEmailId, 
			 @RequestParam(value="companyName", required=false) String companyName,	HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		String authorityOfLoggedInUser = "";
		 String photoName = "";
		 byte[] imageArray = null;
		
		if(authentication != null)
		{
			authorityOfLoggedInUser = authentication.getAuthorities().toString();
			authorityOfLoggedInUser = authorityOfLoggedInUser.replace("[","").replace("]", "");
		}
		
		if(authorityOfLoggedInUser.equals("ROLE_ADMIN")/* || authorityOfLoggedInUser.equals("ROLE_STUDENT")*/)
		{
			StudentDom studentDom = studentManager.getStudentImage(emailId);
			
			photoName = studentDom.getPhotoName();
			imageArray = studentDom.getPhotoData();
		}
		
		else
		{	
		    HttpSession httpSession = request.getSession();
		    String corporateName = (String) httpSession.getAttribute("compName");
		    String universityName = (String) httpSession.getAttribute("univName");
		   
		    if(null!= emailId){
		    	
		    	String authority = loginManagement.getAuthorityByEmailId(emailId.trim());
		    	if(null!= authority && authority.length() != 0){
		    		if(authority.equals("ROLE_CORPORATE"))
					{
							corporateName = loginManagement.getUserDetailsByEmailID(emailId.trim()).getEntityName();
							
							//Fetching company logo
						    EmployerDom employer = employerManager.getEmployerDetails(corporateName);
						
						    photoName = employer.getImageName();
							imageArray = employer.getImageData();
						
					
					}
					
					else if(/*authority.equals("ROLE_STUDENT")||*/ isHomePage)
					{
						
							StudentDom student = studentManager.getDetailsByEmailId(emailId);
							
							photoName = student.getPhotoName();
							imageArray = student.getPhotoData();
						
						
					}
		    		
					else if(authority.equals("ROLE_STUDENT"))
					{
						StudentDom studentDom = studentManager.getStudentImage(emailId);
						
						photoName = studentDom.getPhotoName();
						imageArray = studentDom.getPhotoData();
					}
					
					else
					{
						if(universityName == null || universityName.equals(""))
						{
							universityName = loginManagement.getUserDetailsByEmailID(emailId.trim()).getEntityName();
							
						}
						
						UniversityDetailsDom university = universityManager.getUniversityDetailsByName(universityName);
						
						photoName = university.getUniversityLogoName();
						imageArray = university.getPhotoData();
					}
		    	}
		    	
		    }
			
		
			
			if(isMessagePage){
				if(null!=studentEmailId){
					
					StudentDom student = studentManager.getDetailsByEmailId(studentEmailId);
					
					photoName = student.getPhotoName();
					imageArray = student.getPhotoData();
				}
				
				if(null!=companyName){
					EmployerDom employer = employerManager.getEmployerDetails(companyName);
					
				    photoName = employer.getImageName();
					imageArray = employer.getImageData();
				}
				
				
			}
		
	}
				
		if(photoName == null ||( null != photoName && photoName.trim().length() == 0)){
			imageArray = masterManager.getDefaultImage();
			if(null!= imageArray &&imageArray.length != 0){
			
				photoName = CaerusStringConstants.DEFAULT_PHOTO_NAME;
			
			}
		}
		
		String imageFormat=null;
		
		//Code Added By BalajiI on 5th November to Accommodate All Image Formats(namely PNG,JPEG,BMP)
		if(photoName != null && !photoName.equals(""))
		{ 
			String fileExtension = CaerusCommonUtil.getFileExtension(photoName);
			imageFormat="image/"+fileExtension;
			response.setContentType(imageFormat);
			response.setContentLength(imageArray.length);
			response.setHeader("Content-Disposition", "inline; filename=\"" + photoName + "\"");
			response.getOutputStream().write(imageArray);
			response.getOutputStream().flush();
		}
		
	}
}