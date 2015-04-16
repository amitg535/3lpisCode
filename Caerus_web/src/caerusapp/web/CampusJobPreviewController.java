package caerusapp.web;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * 
 * @author RavishaG
 *
 */
@Controller
public class CampusJobPreviewController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	//Auto-wiring service component
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IStudentJobsManager studentJobsManager;
	
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired	
	ILoginManagement loginManagement;
	
	/**
	 * This method is used to preview campus job details
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CAMPUS_JOB_PREVIEW)
	public ModelAndView handleRequest(@ModelAttribute("success") String success,@RequestParam("jobId") String jobId, @RequestParam(value="universityName",required=false) String universityName,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();
		String authority = auth.getAuthorities().toString();
		authority = authority.replace("[", "").replace("]", "");
		
		logger.info(CaerusLoggerConstants.VIEW_JOB_DETAILS);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("common/campus_job_preview");
		String jobAction = request.getParameter("job_action");

		if(success != null && !success.isEmpty())
		{
			modelAndView.addObject("success", true);
		}
		
		
		/*
		 // Fetching parameter values from request
		String strJobId = request.getParameter("jobId");
		String univName = request.getParameter("universityName");
		
		String jobId=request.getParameter("job_id");
		
		*/
		
		if(universityName == null)
		{
			universityName = loginManagement.getEntityNameByEmailId(emailId);
		}
		// Updating the status of the campus job
		if(jobId!=null && jobAction!=null)
	    {
	    	universityManager.updateCampusJobStatus(jobId,universityName,jobAction);
	    }
		
		
		Map<String, Date> appliedStudentsMap = new HashMap<String, Date>();

		// Retrieving the job details posted for that university 
		JobDetailsDom campusJobDetails = employerJobPostManager.getCampusJobDetails(jobId, universityName);
		
		employerJobPostManager.updateSeenByUniversityFlag(jobId,universityName);

		// Retrieving the company details which has posted the internship
		EmployerDom companyDetails=employerManager.getEmployerDetails(campusJobDetails.getCompanyName());
		
		/* Added by RavishaG to show responses of candidates in thin client application */
		appliedStudentsMap = studentJobsManager.getStudentsAppliedForJob(campusJobDetails.getJobIdAndFirmId(),universityName);
		
		
		if(authority.equals("ROLE_STUDENT"))
		{
			studentJobsManager.updateViewedCampusJob(emailId,jobId);
			employerJobPostManager.updateCampusJobViewCount(jobId,universityName);
		}
				
		
		// Adding values to the modelAndView object
		modelAndView.addObject("companyDetails", companyDetails);
		modelAndView.addObject("campusJobDetails",campusJobDetails);
		
		
		if(appliedStudentsMap != null)
		{
			modelAndView.addObject("responses",appliedStudentsMap.size());
		}
		else
		{
			modelAndView.addObject("responses",0);
		}
		
		
		modelAndView.addObject("emailId", emailId);
		
		// returning the modelAndView object
		return modelAndView;
	}


	
}
