/**
 * 
 */
package caerusapp.web.university;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.exceptions.DoesNotExistException;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to display the list of campus jobs and internships posted for a university
 * @author KarthikeyanK
 * 
 */
@Controller
public class UniversityCampusJobsInternshipsController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private IUniversityManager universityManager;
	
	@Autowired
	private IEmployerJobPostManager employerJobPostManager;
	
	//String univeName;

	/**
	 * This method is used to fetch the list of campus jobs and internships posted for a university from the database
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_CAMPUS_JOBS_INTERNSHIPS)
	public ModelAndView loadCampusJobsInternships(
			@RequestParam(value="jobId",required=false)String jobId,
			@RequestParam(value="jobAction",required=false) String jobAction,
			@RequestParam(value="internshipAction",required=false) String internshipAction,
			@RequestParam(value="internshipId",required=false) String internshipId,
			HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		List<EmployerCampusJobPostDom> campusJobs = new ArrayList<EmployerCampusJobPostDom>();
		List<EmployerCampusJobPostDom> campusInternships = new ArrayList<EmployerCampusJobPostDom>();
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.UNIVERSITY_CAMPUS_JOBS_INTERNSHIPS);

			
	    //Getting a session from request
	    HttpSession session = request.getSession();
	  		
	    // Retrieving university name from the database
	    String universityName = "";
	    
	    if(request.getSession().getAttribute("univName") != null)
	    	universityName = request.getSession().getAttribute("univName").toString();
	    	
	    Device currentDevice = DeviceUtils.getCurrentDevice(request);
	    
	    /* Added by RavishaG to show job/internship listing in thin client application */
	    if(!currentDevice.isNormal())
		{
			if(request.getParameter("selected") != null && request.getParameter("selected").equals("jobs"))
			{
				campusJobs = universityManager.getCampusJobs(universityName);
				modelAndView.addObject("jobs",true);
			}
			
			if(request.getParameter("selected") != null && request.getParameter("selected").equals("internships"))
			{
				campusInternships = universityManager.getCampusJobs(universityName);	
				modelAndView.addObject("internships",true);
			}
		}
	   
	    logger.info(CaerusLoggerConstants.NEW_JOB_ALERTS);
		   // Exception handling
		   try
		   {
		    
			// Updating the status of the campus job 
		    if(jobId != null && jobAction != null)
		    {
		    	universityManager.updateCampusJobStatus(jobId,universityName,jobAction);
		    	employerJobPostManager.updateSeenByUniversityFlag(jobId,universityName);
		    }
	    
		    // Updating the status of the campus internship 
		    if(internshipId != null && internshipAction != null)
		    {
		    	universityManager.updateCampusInternshipStatus(internshipId,universityName,internshipAction);
		    }
	
			if (universityName != null && !universityName.equals(""))
			{
				// Retrieving the list of jobs posted for the university from the database
				campusJobs = universityManager.getCampusJobs(universityName);
				
				// Retrieving the list of internships posted for the university from the database
				campusInternships = universityManager.getCampusInternships(universityName);
						
				// Adding values to the modelAndView object
				if (campusJobs != null && campusInternships != null) 
				{
					/* Added by RavishaG to sort jobs and internships on time */
					
					// sort the jobs on time
					campusJobs = CaerusCommonUtility.sortListByDateReverse(campusJobs, "EmployerCampusJobPostDom");
					
					modelAndView.addObject("campusJobs",campusJobs);
					modelAndView.addObject("employerJobListSizeForUniversity",campusJobs.size());
					
					// sort the internships on time
					campusInternships = CaerusCommonUtility.sortListByDateReverse(campusInternships, "EmployerCampusJobPostDom");
					
					modelAndView.addObject("campusInternships",campusInternships);
					modelAndView.addObject("employerInternshipListSizeForUniversity",campusInternships.size());
	
				}
			}
		   }
		   catch(NullPointerException npe)
		   {
			   npe.printStackTrace();
		   }
		   catch(DoesNotExistException dne)
	
		   {
			   dne.printStackTrace();
		   }
		return modelAndView;
	}
}