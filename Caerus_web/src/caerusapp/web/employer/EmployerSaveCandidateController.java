package caerusapp.web.employer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to save a candidate by an employer 
 *
 */
@Controller
public class EmployerSaveCandidateController
{
	//Auto-wiring service Components
	@Autowired
	private IEmployerManager employerManager;
	@Autowired
	private IStudentManager studentManager;

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 
	 * This method is used to save a candidate and view the details of a candidate
	 * @param candidateEmailId
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_SAVE_CANDIDATE)
	public void saveCandidate(@RequestParam("candidateEmailId") String candidateEmailId ,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		
		logger.info(CaerusLoggerConstants.SAVE_CANDIDATE);
		
		//Spring security authentication containing the logged in user details
		Authentication authentication= SecurityContextHolder.getContext().getAuthentication();
		String employerEmailId=authentication.getName();
		
		StudentDom candidateDetails = studentManager.getDetailsByEmailId(candidateEmailId);
		
		if(null != candidateDetails)
		{
			candidateDetails.setCompanyId(employerEmailId);
			employerManager.employerSaveCandidate(candidateDetails);
		}
		
		String sessionId = "";
		String source = request.getParameter("source");
		String redirectionPage = "";
		
		if(source != null && source.equalsIgnoreCase("viewResponses"))
		{
			sessionId = (String) request.getSession().getAttribute("jobId");
			redirectionPage = "employer_viewresponses.htm?jobId="+sessionId;
			
		}
		if(source != null && source.equalsIgnoreCase("internshipResponses"))
		{
			sessionId = (String) request.getSession().getAttribute("internshipId");
			redirectionPage = "employer_viewresponses_internship.htm?internshipId="+sessionId;
		}
		
	}

}