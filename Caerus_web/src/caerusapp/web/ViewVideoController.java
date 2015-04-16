package caerusapp.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;

@Controller
public class ViewVideoController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	ILoginManagement loginManager;
	
	@Autowired
	StudentManager studentManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.VIEW_VIDEO)
	public void handleRequest(HttpServletRequest request, HttpServletResponse response,@RequestParam("emailId") String emailId) throws ServletException, IOException  {
	    String authority = loginManager.getAuthorityByEmailId(emailId);
	    String fileName = null;
	    byte[] video = null;
	    
	    StudentDom student = new StudentDom();
	    EmployerDom empVideo = new EmployerDom();
	    
	    if(authority.equals("ROLE_CORPORATE"))
	    {
	    	String companyName = loginManagement.getEntityNameByEmailId(emailId);
	    	empVideo = employerManager.getEmployerDetails(companyName);
	    	fileName = empVideo.getFileNameVideo();
			video = empVideo.getVideoFileData();
	    }
	    
	    if(authority.equals("ROLE_STUDENT"))
	    {
	    	student = studentManager.getDetailsByEmailId(emailId);
	    	fileName = student.getVideoName();	
			video = student.getUploadVideoclip();
	    }
		
		if(fileName != null)
		{
		    String extension = CaerusCommonUtil.getFileExtension(fileName);
		    
		    if(extension.equals("mp4"))
		    {
	    	
			  try
			  { 
				response.setContentType("video/mp4"); 
		        response.setContentLength(video.length);
		 
		        response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
		        response.getOutputStream().write(video);
		        response.getOutputStream().flush();
		        response.getOutputStream().close();
			  
			  }
			  catch (NullPointerException e) {
				
			  }
		   }
		}
	}
}