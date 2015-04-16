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
 * This class is used to show broadcasted jobs to candidate
 */
@Controller
public class CandidateBroadcastedJobController {
	
	 //Auto-wiring service component
	 @Autowired
	 IUniversityManager universityManager;
	
	 @Autowired
	 IEmployerManager employerManager;
	 
	 @Autowired
	 IStudentManager studentManager;
	 
	 @Autowired
	 IStudentJobsManager studentJobsManager;
	 
	 @Autowired
	 IEmployerJobPostManager employerJobPostManager;
	 
	 //Logger for this class and subclasses
	 protected final Log logger = LogFactory.getLog(getClass());
	 
	 /**
	  * This method is used to show broadcasted jobs to candidate
	  * @param httpServletRequest
	  * @param httpServletResponse
	  * @return ModelAndView
	  */
	 
	 @RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_BROADCASTED_JOBS)
	 public ModelAndView candidateBroadcastedJobs(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) 
	 {
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String candidateEmailId = auth.getName(); 
		
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_broadcasted_jobs");
	 
		List<EmployerCampusJobPostDom> campusJobs = new ArrayList<EmployerCampusJobPostDom>();
		int campusJobCount = 0;
	
		logger.info(CaerusLoggerConstants.UNIVERSITY_NAME_FOR_REGISTERED_STUDENT);
		
		String universityName = universityManager.getUniversityForRegisteredStudent(candidateEmailId);
		List<EmployerDom> employerDetails = new ArrayList<EmployerDom>();
		
		if(null != universityName){
		  HttpSession currentSession = httpServletRequest.getSession();
		  currentSession.setAttribute("universityName", universityName);	 
		  logger.info(CaerusLoggerConstants.CAMPUS_JOBS);
		  campusJobs = universityManager.getCampusJobs(universityName);
		  
		  /* Added by RavishaG */
		  if(null != campusJobs && campusJobs.size() > 0)
		  {
			  Collections.sort(campusJobs, new Comparator<EmployerCampusJobPostDom>(){
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
			  campusJobCount = campusJobs.size();
		  }
	}
		 
		
		/*// get employer details
		if(campusJobs != null)
		{		
		  for (EmployerCampusJobPostDom employerCampusJobPostDom : campusJobs) {

			  if(employerCampusJobPostDom.getStatus().equalsIgnoreCase("Broadcasted"))
			  {
				  employerDetails.add(employerManager.getEmployerDetails(employerCampusJobPostDom.getFirmName()));		  
			  }
		  }
		}*/
		
		if(employerDetails != null)
		{
			for (EmployerDom employer : employerDetails) {
				
				for (EmployerCampusJobPostDom employerCampusJobPostDom : campusJobs) {
					
					if(null != employer.getCompanyName() && employer.getCompanyName().trim().equals(employerCampusJobPostDom.getFirmName().trim()))
					{
						employerCampusJobPostDom.setPhotoName(employer.getImageName());
					}
				}
			}
		}
		
		//Adding objects to model to retrieve details on jsp
		modelAndView.addObject("appliedCampusJobIds", studentJobsManager.getAppliedCampusJobIds(candidateEmailId));
		modelAndView.addObject("employerJobListForUniversity",campusJobs);
		modelAndView.addObject("employerDetails",employerDetails);
		modelAndView.addObject("employerJobListSizeForUniversity",campusJobCount);
		modelAndView.addObject("count",campusJobCount);
		modelAndView.addObject("emailID",candidateEmailId);
		
		return modelAndView;
	}
	
	/**
	 * This method is used to apply a broadcasted campus job
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @param redirectAttributes
	 * @return ModelAndView
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_APPLY_BROADCASTED_JOBS)
	 public ModelAndView candidateApplyBroadcated(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, RedirectAttributes redirectAttributes) 
	 {
		 //Spring security authentication containing the logged in user details
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 String emailId = auth.getName();
		 
		 String jobId = httpServletRequest.getParameter("jobId");
		 String universityName = (String) httpServletRequest.getSession().getAttribute("universityName");
		 
		 Device device = DeviceUtils.getCurrentDevice(httpServletRequest);
		 
		 ModelAndView modelAndView = new ModelAndView("common/campus_job_preview");
				 
		 StudentDom student = studentManager.getDetailsByEmailId(emailId);
		 logger.info(CaerusLoggerConstants.STUDENT_DETAILS );
			
		 if (student.getResumeName() == null) 
		 {
			redirectAttributes.addFlashAttribute("emptyProfile", "true");
			return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
		 }
		 else
		 {
			studentJobsManager.applyBroadcastedJob(jobId, emailId,universityName);
			
			if(!device.isNormal())
			{
				// Retrieving the job details posted for that university 
				JobDetailsDom campusJobDetails = employerJobPostManager.getCampusJobDetails(jobId, universityName);
				modelAndView.addObject("campusJobDetails",campusJobDetails);
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
			    if(requiredUrl.equals(CaerusAnnotationURLConstants.CANDIDATE_BROADCASTED_JOBS))
			    	return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.CANDIDATE_BROADCASTED_JOBS));
			    else
			    {
			    	redirectAttributes.addFlashAttribute("success","true");
			    	return new ModelAndView(new RedirectView(requiredUrl));
			    }
			    	
			}
			
		 }
				
	 }
}