/**
 * 
 */
package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerCampusJobPostDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

/**
 * This class is used to display jobs, internships, campus jobs and internships to Employer
 * @author pallavid
 *
 */
@Controller
public class EmployerJobsInternshipsController {
	
		//Auto-wiring service components
		@Autowired
		IEmployerJobPostManager employerJobPostManager;
		
		@Autowired
		IEmployerManager employerManager; 
		
		//Auto-wiring service components for campus jobs and internships
		@Autowired
		IUniversityManager universityManager;
		
		/** Logger for this class and subclasses */
		protected final Log logger = LogFactory.getLog(getClass());
		
		/**
		 * This method is used to fetch jobs and internships posted by the employer
		 */		
	    @RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS)
		public ModelAndView getJobsInternships(HttpServletRequest request, HttpServletResponse response)
		{
	    	logger.info(CaerusLoggerConstants.NEW_JOB_ALERTS);
			
			//The modelAndView object contains the model(data) and the view(employer_jobsinternships_listing.jsp)
			ModelAndView modelAndView = new ModelAndView("employer/employer_jobs_internships");
			
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailID = auth.getName();
	
			List<EmployerCampusJobPostDom> employerCampusInternships = new ArrayList<EmployerCampusJobPostDom>();
			List<EmployerCampusJobPostDom> employerCampusJobs = new ArrayList<EmployerCampusJobPostDom>();
			List<EmployerCampusJobPostDom> sortedCampusJobs = new ArrayList<EmployerCampusJobPostDom>();
			List<EmployerCampusJobPostDom> sortedCampusInternships = new ArrayList<EmployerCampusJobPostDom>();
			
			List<JobDetailsDom> jobs = new ArrayList<JobDetailsDom>();
			List<JobDetailsDom> internships = new ArrayList<JobDetailsDom>();
			List<JobDetailsDom> sortedJobs = new ArrayList<JobDetailsDom>();
			List<JobDetailsDom> sortedInternships = new ArrayList<JobDetailsDom>();
			
				if(request.getParameter("selected") != null && request.getParameter("selected").equals("internships"))
				{
					internships = employerJobPostManager.getAllInternshipsPostedByEmployer(emailID);
					modelAndView.addObject("internships",true);
					if(! internships.isEmpty())
					{
						String className = CaerusStringConstants.CLASS_JOB_DETAILS_DOM;
						sortedInternships = CaerusCommonUtility.sortListByDateReverse(internships,className);
						modelAndView.addObject("listInternship",sortedInternships);
						
					}
				}
				
				else if(request.getParameter("selected") != null && request.getParameter("selected").equals("campusJobs"))
				{
					employerCampusJobs = universityManager.getCampusJobsByEmployer(emailID);
					modelAndView.addObject("campusJobs",true);
					if(employerCampusJobs != null)
					{
						Collections.sort(employerCampusJobs, new Comparator<EmployerCampusJobPostDom>(){
							public int compare(EmployerCampusJobPostDom o1, EmployerCampusJobPostDom o2) {
								  String dateFormat = CaerusAPIStringConstants.DB_DATE_FORMAT;
								
								  
								  Date d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(),dateFormat);
								  Date d2 = CaerusCommonUtility.stringToDate(o2.getPostedOn(),dateFormat);
								  
								  int compareValue = 0;
								  
								  if(null != d1 && null != d2)
							       compareValue = d2.compareTo(d1);
								  
								  return compareValue;
							  }
						});
						
						modelAndView.addObject("employerJobPostListForUniversity",employerCampusJobs);
					}
				}
				else if(request.getParameter("selected") != null && request.getParameter("selected").equals("campusInternships"))
				{
					employerCampusInternships = universityManager.getCampusInternshipsByEmployer(emailID);
					modelAndView.addObject("campusInternships",true);
					
					if(employerCampusInternships != null)
					{
						String className = CaerusStringConstants.CLASS_EMPLOYER_CAMPUS_JOB_POST_DOM;
						sortedCampusInternships = CaerusCommonUtility.sortListByDateReverse(employerCampusInternships,className);
						modelAndView.addObject("employerInternshipListForUniversity",sortedCampusInternships);
					}
				}
			
				else
				{
					jobs = employerJobPostManager.getAllJobsPostedByEmployer(emailID);
					modelAndView.addObject("jobs",true);
					if(! jobs.isEmpty())
					{
						String className =  CaerusStringConstants.CLASS_JOB_DETAILS_DOM;
						sortedJobs = CaerusCommonUtility.sortListByDateReverse(jobs,className);
						modelAndView.addObject("jobDetail", sortedJobs);
					}
				}
		
			
			logger.info(CaerusLoggerConstants.CAMPUS_JOBS_AND_INTERNSHIPS);
			
			if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
				modelAndView.addObject("companyName",request.getSession().getAttribute("compName").toString());
			
			modelAndView.addObject("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
			modelAndView.addObject("twoDaysAfter",CaerusCommonUtil.getFutureDate(2));
			
			return modelAndView;
			
		}
}