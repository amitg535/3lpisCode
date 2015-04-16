package caerusapp.web.employer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;

@Controller
public class EmployerDownloadRepositoryFileController {

	Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	IEmployerManager employerManager;

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DOWNLOAD_REPOSITORY_FILE)
	void downloadFileFromRepo(@RequestParam("fileName") String fileName,@RequestParam("companyName") String companyName,HttpServletRequest request,HttpServletResponse response){
		byte[] fileData = null;
		try
		{
			//For University Login or Student Login
			if(fileName != null && companyName != null && fileName.length() > 0 && companyName.length() > 0)
			{
				//Fetching files from repository
				fileData = employerManager.getEmployerFileDetails(companyName, fileName);
			}	
			    
			if(fileData != null && fileData.length > 10)
			{
			   response.setHeader("Content-Disposition","attachment; filename=\"" +fileName  +"\"");
			   FileCopyUtils.copy(fileData, response.getOutputStream()); 
			} 
		}
		catch(Exception ex){
			logger.error("Error In Reading Image in downloadFileFromRepo");
		}
	}
}

