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
public class CampusInternshipPreviewController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	// Auto-wiring service component
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
	 * This method is used to preview campus internship details 
	 * @param internshipId
	 * @param universityName
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CAMPUS_INTERNSHIP_PREVIEW)
	public ModelAndView handleRequest(@ModelAttribute("success") String success,@RequestParam("internshipId") String internshipId, @RequestParam(value="universityName",required=false) String universityName,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		 //Spring security authentication containing the logged in user details
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 String emailId = auth.getName();
		 String authority = auth.getAuthorities().toString();
		 authority = authority.replace("[", "").replace("]", "");
		
		logger.info(CaerusLoggerConstants.VIEW_INTERNSHIP_DETAILS);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("common/campus_internship_preview");
		String internshipAction = request.getParameter("internship_action");

		if(success != null && !success.isEmpty())
		{
			modelAndView.addObject("success", true);
		}
		
		/*String internshipId = request.getParameter("internship_id");
	    
		
		// Fetching parameter values from request
		String strInternshipId = request.getParameter("internshipId");
		String univName = request.getParameter("universityName");

		if(strInternshipId == null)
		{
			strInternshipId = internshipId;
		}*/
		
		if(universityName == null)
		{
			universityName = loginManagement.getEntityNameByEmailId(emailId);
		}
		
		// Updating the status of the campus internship 
	    if(internshipId!= null && internshipAction!=null)
	    {
	    	universityManager.updateCampusInternshipStatus(internshipId,universityName,internshipAction);
	    }
		// Retrieving the internship details posted for that university 
		JobDetailsDom campusInternshipDetails = employerJobPostManager.getCampusInternshipDetails(internshipId,universityName);

		Map<String, Date> appliedStudentsMap = new HashMap<String, Date>();
		
		EmployerDom companyDetails = employerManager.getEmployerDetails(campusInternshipDetails.getCompanyName());
		
		/* Added by RavishaG to show responses of candidates in thin client application */
		appliedStudentsMap = studentJobsManager.getStudentsAppliedForInternship(campusInternshipDetails.getInternshipIdAndFirmId(),universityName);
		
		if(authority.equals("ROLE_STUDENT"))
		{
			studentJobsManager.updateViewedCampusInternship(emailId,internshipId);
			employerJobPostManager.updateCampusInternshipViewCount(internshipId,universityName);
		}
		
		// Adding values to the modelAndView object
		modelAndView.addObject("companyDetails", companyDetails);
		modelAndView.addObject("campusInternshipDetails",campusInternshipDetails);
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
