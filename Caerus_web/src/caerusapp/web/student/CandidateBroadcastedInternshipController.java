package caerusapp.web.student;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;

/**@author PallaviD
 * Servlet implementation class CandidateBroadcastedJobController
 * This class is used to show broadcasted internships to candidate
 */
@Controller
public class CandidateBroadcastedInternshipController {
	
	//Auto-wiring service component
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IStudentJobsManager studentJobsManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	//Logger for this class and subclasses
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to show broadcasted internships to candidate
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_BROADCASTED_INTERNSHIPS)
	public ModelAndView candidateBroadcastedJobs(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse) 
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String candidateEmailId = auth.getName();
		
		//The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_broadcasted_internships");
		
        //Creating list of domain object
		List<EmployerCampusJobPostDom> campusInternships = null;
		int campusInternshipCount = 0;
		
		List<EmployerDom> employerDetails = new ArrayList<EmployerDom>();
		
		String universityName = universityManager.getUniversityForRegisteredStudent(candidateEmailId);
        logger.info(CaerusLoggerConstants.UNIVERSITY_NAME_FOR_REGISTERED_STUDENT);
        
        if(null != universityName)
        {
        	//Using current session
        	 HttpSession currentSession=httpServletRequest.getSession();
      		currentSession.setAttribute("universityName", universityName);
      		logger.info(CaerusLoggerConstants.CAMPUS_INTERNSHIPS);
      		campusInternships = universityManager.getCampusInternships(universityName);
      		
      		/* Added by RavishaG*/
      		if(null != campusInternships && campusInternships.size() > 0)
      		{		
      			Collections.sort(campusInternships, new Comparator<EmployerCampusJobPostDom>(){
					public int compare(EmployerCampusJobPostDom o1, EmployerCampusJobPostDom o2) {
						  String dateFormat = "dd MMM yyyy";
						
						  
						  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
						  Date d2 = CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
						  
						  int compareValue = 0;
						  
						  if(null != d1 && null != d2)
					       compareValue = d2.compareTo(d1);
						  
						  return compareValue;
					  }
					});
      			campusInternshipCount = campusInternships.size();
      		}
        }
        
        // get employer details
       /* if(null != campusInternships && campusInternships.size() > 0)
		{		
		  for (EmployerCampusJobPostDom employerCampusJobPostDom : campusInternships) {
				
			  if(employerCampusJobPostDom.getStatus().equalsIgnoreCase("Broadcasted"))
			  {
				  if(employerCampusJobPostDom.getFirmId() != null)
				  employerDetails.add(employerManager.getEmployerDetails(employerCampusJobPostDom.getFirmName()));		  
			  }
		  }
		}*/
		
		if(employerDetails != null)
		{
			for (EmployerDom employer : employerDetails) {
				
				for (EmployerCampusJobPostDom employerCampusJobPostDom : campusInternships) {
					
					if(employer.getCompanyName().equals(employerCampusJobPostDom.getFirmName()))
					{
						employerCampusJobPostDom.setPhotoName(employer.getImageName());
					}
				}
			}
		}
       
        //Adding objects to model to retrieve details on jsp
		
		modelAndView.addObject("campusAppliedInternshipIds", studentJobsManager.getAppliedCampusInternshipIds(candidateEmailId));
	    modelAndView.addObject("employerInternshipListSizeForUniversity",campusInternshipCount);
	    modelAndView.addObject("employerDetails",employerDetails);
		modelAndView.addObject("employerInternshipListForUniversity",campusInternships);
		modelAndView.addObject("count", campusInternshipCount);
		modelAndView.addObject("emailID",candidateEmailId);
		
		return modelAndView;
	}

	/**
	 * This method is used to apply a broadcasted campus internship
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_APPLY_BROADCASTED_INTERNSHIPS)
	 public ModelAndView candidateApplyBroadcated(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, RedirectAttributes redirectAttributes) 
	 {
		//Spring security authentication containing the logged in user detail
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 String emailId = auth.getName();
		
		 String internshipId = httpServletRequest.getParameter("internshipId");
		 
		 String universityName=(String) httpServletRequest.getSession().getAttribute("universityName");
		 
		 Device device = DeviceUtils.getCurrentDevice(httpServletRequest);
		
		 ModelAndView modelAndView = new ModelAndView("common/campus_internship_preview");
		 
		 StudentDom student = studentManager.getDetailsByEmailId(emailId);
		 
		 logger.info(CaerusLoggerConstants.STUDENT_DETAILS );
		
		 if (student.getResumeName() == null) 
		 {
			redirectAttributes.addFlashAttribute("emptyProfile", "true");
			
			return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
			
		 }
		
		 else
		 {
			studentJobsManager.applyBroadcastedInternship(internshipId, emailId,universityName);
			
			if(!device.isNormal())
			{
				// Retrieving the job details posted for that university 
				JobDetailsDom campusInternshipDetails = employerJobPostManager.getCampusInternshipDetails(internshipId, universityName);
				modelAndView.addObject("campusInternshipDetails",campusInternshipDetails);
				modelAndView.addObject("applied", true);
				return modelAndView;
			}
			
			else
			{
				// Getting the current page url
				String url = httpServletRequest.getHeader("referer");
				
				String requiredUrl = null;
			       
			   // Splitting the string at the last occurence of '/'
			    if (url.lastIndexOf("/") != -1)  
			    {
			    	requiredUrl = url.substring(url.lastIndexOf("/") + 1, url.length()); // check if(endIndex != -1)
			    }
			    
			    //Redirect to the page from where the job is applied
			    if(requiredUrl.equals("candidate_broadcasted_internships.htm"))
			    	return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.CANDIDATE_BROADCASTED_INTERNSHIPS));
			    
			    else
			    {
			    	redirectAttributes.addFlashAttribute("success","true");
			    	return new ModelAndView(new RedirectView(requiredUrl));
			    }
			    	
			}
			
		 }
	 }
	
}