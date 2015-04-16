package caerusapp.web.employer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.command.employer.EmployerCom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;

/**
 * 
 * This class is used to fetch files from repository
 *
 */
@Controller
public class EmployerFilesRepositoryController {
	
	//Auto-wiring service component
	@Autowired
	IEmployerManager employerManager;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 
	 * This method is used to fetch files from repository
	 *
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_FILE_REPOSITORY)
	public ModelAndView loadEmployerRepoPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException  {
		
		//The mav object contains the model(data) and the view(employer_files_repository.jsp)
		ModelAndView modelAndView= new ModelAndView("employer/employer_files_repository");

		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null )
			companyName = request.getSession().getAttribute("compName").toString();
		
      //Fetching files from repository
        List<EmployerDom> employerRepoFiles = employerManager.getEmployerFiles(companyName);
        modelAndView.addObject("employerRepoFiles", employerRepoFiles);  
        modelAndView.addObject("employerCom", new EmployerCom());
        
        return modelAndView;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DELETE_FILE_FROM_REPO)
	String deleteFileFromRepo(@RequestParam("fileId")String fileId,HttpServletRequest request){
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null)
			companyName = request.getSession().getAttribute("compName").toString();
			
		employerManager.deleteFile(fileId,companyName);
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_FILE_REPOSITORY;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPLOAD_FILE)
	String employerUploadFile(@ModelAttribute("employerCom") EmployerCom employerCom,HttpServletRequest request) throws IOException
	{
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null)
			companyName = request.getSession().getAttribute("compName").toString();
		
		employerCom.setCompanyName(companyName);
		EmployerDom employerDom = new EmployerDom();
		BeanUtils.copyProperties(employerCom, employerDom);
		
		if(employerCom.getFile() == null || employerCom.getFile().getOriginalFilename() == null)
			return "employer/employer_files_repository";
		
		employerDom.setFileMimeType(employerCom.getFile().getContentType());
		employerDom.setFileSize(String.valueOf(employerCom.getFile().getSize() / 1024));
		employerDom.setFileData(employerCom.getFile().getBytes());
		employerDom.setFileName(employerCom.getFile().getOriginalFilename());
		employerManager.uploadFile(employerDom);
		
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_FILE_REPOSITORY;
	}
	
}