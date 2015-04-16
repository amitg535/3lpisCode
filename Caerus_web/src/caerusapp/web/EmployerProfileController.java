package caerusapp.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerProfileController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	//Auto-wiring service components
	@Autowired
	private IEmployerManager employerManager;

	@Autowired
	ILoginManagement loginManagement;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IStudentJobsManager studentJobsManager;
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_PROFILE_PREVIEW,method=RequestMethod.GET)	
	String loadProfilePreviewPage(@RequestParam(value="companyName",required=false) String companyName,Model model,HttpServletRequest request)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(companyName == null || companyName.equals(""))
			companyName = request.getSession().getAttribute("compName").toString();
		
		EmployerDom employerDetails = employerManager.getEmployerDetails(companyName);
		
		LoginManagementDom adminDetails = new LoginManagementDom();
		
		if(authentication.getAuthorities().toString().equals("[ROLE_CORPORATE]"))
			adminDetails = loginManagement.getUserDetailsByEmailID(authentication.getName());
		else
			adminDetails = loginManagement.getAdminByEntityName(companyName);
		
		if(null!= adminDetails.getFirstName() && null != adminDetails.getLastName())
			employerDetails.setContactPersonName(adminDetails.getFirstName().concat(" ").concat(adminDetails.getLastName()));
		else {
			employerDetails.setContactPersonName("Beta Company");
		}
		
		employerDetails.setEmailID(adminDetails.getUserName());
		
		model.addAttribute("employerDetails",employerDetails);
		model.addAttribute("companyLocationsSize", employerDetails.getCompanyLocations().size());
		
		
		
		
		int allJobCount = 0;
		List<JobDetailsDom> employerJobs = new ArrayList<JobDetailsDom>();
		List<String> savedJobIds = new ArrayList<String>();
		List<String> appliedJobIds = new ArrayList<String>();
		
		/** Fetching all the Jobs posted by Employer */
		if(null != companyName && companyName.trim().length() > 0){
			employerJobs = employerJobPostManager.getJobsByCompanyName(companyName,CaerusAPIStringConstants.JOB_STATUS_PUBLISHED);
		}
	
		if(null != employerJobs && employerJobs.size() > 0)
		{
			allJobCount = employerJobs.size();
			
			/** Sorting the Results based on Job Posted On Date (Descending Order)*/
			Collections.sort(employerJobs, new Comparator<JobDetailsDom>(){
				@Override
				public int compare(JobDetailsDom o1, JobDetailsDom o2) {
					int compare = 0;
					
					Date oldDate = CaerusCommonUtil.getPastDate(30,CaerusAPIStringConstants.DB_DATE_FORMAT);

				    Date d1 = (Date) oldDate.clone();
				    Date d2 = (Date) oldDate.clone();

						if(null != o1.getPostedOn())
							d1 = CaerusCommonUtility.stringToDate(o1.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT);
						
						if(null != o2.getPostedOn())
							d2 = CaerusCommonUtility.stringToDate(o2.getPostedOn(), CaerusAPIStringConstants.DB_DATE_FORMAT);
						
					compare = d2.compareTo(d1);
					return compare;
				}
			});
		}	
		
		/** Marking Saved and Applied Jobs with Appropriate Flags */
		if(null != SecurityContextHolder.getContext().getAuthentication().getAuthorities() && SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString().contains("ROLE_STUDENT"))
		{
			String loggedInUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
			savedJobIds = studentJobsManager.getSavedJobIds(loggedInUserEmail);
			appliedJobIds = studentJobsManager.getAppliedJobIds(loggedInUserEmail);
			logger.info(loggedInUserEmail + " "+ CaerusLoggerConstants.ALL_EMPLOYER_JOBS +" of "+companyName);
		}
		
		model.addAttribute("savedJobIds",savedJobIds);
		model.addAttribute("appliedJobIds",appliedJobIds);
		model.addAttribute("allJobCount",allJobCount);	
		model.addAttribute("allEmployerJobs",employerJobs);
		model.addAttribute("noJobsMessage",CaerusStringConstants.NO_JOBS);
		model.addAttribute("displayDateFormat",CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
		model.addAttribute("dbDateFormat",CaerusAPIStringConstants.DB_DATE_FORMAT);
		
		
		return CaerusJSPMapper.EMPLOYER_PROFILE_PREVIEW ;
	}
	
}
