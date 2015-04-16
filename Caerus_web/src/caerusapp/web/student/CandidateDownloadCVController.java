package caerusapp.web.student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import caerusapp.domain.student.StudentDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;

/**
 *This class is used to download curriculum vitae
 */
@Controller
public class CandidateDownloadCVController 
{
	//Auto-wiring service component
	@Autowired
	private StudentManager studentManager;

	/**
	 * This method is used to download curriculum vitae
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_DOWNLOAD_CV)
	public void downloadCV(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException,CaerusCommonException
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();
		
			StudentDom file = studentManager.getDetailsByEmailId(emailId);
			
			 String fileName = file.getResumeName();
			 if(fileName != null && !fileName.equals(null))
			 {
		    	 response.setHeader("Content-Disposition","inline; filename=\"" + file.getResumeName() +"\"");
		    	 FileCopyUtils.copy(file.getFileData(), response.getOutputStream());
		     } 
			 else
			 {
		    	 throw new CaerusCommonException("Resume is not available in database, Please upload your resume");
			 }
	}
}
