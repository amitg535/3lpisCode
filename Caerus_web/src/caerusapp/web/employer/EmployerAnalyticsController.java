package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerAnalyticsController {

	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_ANALYTICS)
	private String loadEmployerAnalyticsPage(HttpServletRequest request,Model model) {
		String companyName = request.getSession().getAttribute("compName").toString();
		List<String> durationDropDown = new ArrayList<String>(){{add("This Week"); add("Last 2 Weeks"); add("Last Month"); add("Last 2 Months"); }};
		Date previousDate = CaerusCommonUtil.getDateByDifference(CaerusStringConstants.getEmployerAnalyticsDropdown().get("This Week"));
		Long allJobCount = employerJobPostManager.getJobsAndInternshipCountPostedInTimeframe(companyName,previousDate,true);
		
		if( null == allJobCount || allJobCount == 0){
			model.addAttribute("noJobsYet",CaerusStringConstants.NO_JOBS_POSTED_YET);
			return "employer/employer_analytics";
		}
		Long jobsInTimeFrame = employerJobPostManager.getJobsAndInternshipCountPostedInTimeframe(companyName,previousDate,false);
		
		Long appliedCandidateCount = employerJobPostManager.getAppliedCandidateCountInTimeframe(companyName,previousDate);
		Long candidateProfilesVisitedCount = employerManager.getEmployerActivityCount(companyName,previousDate,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_VIEWED_PROFILE);
		Long resumeDownloadedCount = employerManager.getEmployerActivityCount(companyName,previousDate,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_DOWNLOADED_RESUME);
		float averageJobClosureTime = employerJobPostManager.getAverageJobClosureTime(companyName,previousDate);
		Long averageResponsesPerJob = employerJobPostManager.getAverageResponsesPerJob(companyName,previousDate);
		
		model.addAttribute("jobsInTimeFrame",jobsInTimeFrame);
		model.addAttribute("appliedCandidateCount",appliedCandidateCount);
		model.addAttribute("candidateProfilesVisitedCount",candidateProfilesVisitedCount);
		model.addAttribute("resumeDownloadedCount",resumeDownloadedCount);
		model.addAttribute("averageJobClosureTime",averageJobClosureTime);
		model.addAttribute("averageResponsesPerJob",averageResponsesPerJob);
		model.addAttribute("durationDropDown",durationDropDown);
		
		return "employer/employer_analytics";
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_ANALYTICS_JSON)
	@ResponseBody
	private Map<String,Long> getEmployerAnalytics(@RequestParam("durationAnalytics") String durationAnalytics,HttpServletRequest request)
	{
		String companyName = request.getSession().getAttribute("compName").toString();
		Map<String,Long> employerAnalytics = new HashMap<String, Long>();
		
		if(null != durationAnalytics && durationAnalytics.trim().length() > 0){
			Date previousDate = CaerusCommonUtil.getDateByDifference(CaerusStringConstants.getEmployerAnalyticsDropdown().get(durationAnalytics));
			Long jobsInTimeFrame = 0L;
			boolean allTimeDataFlag = false;
			
			if(durationAnalytics.equals("All Data"))
				allTimeDataFlag = true;
				
			jobsInTimeFrame = employerJobPostManager.getJobsAndInternshipCountPostedInTimeframe(companyName,previousDate,allTimeDataFlag);
			
			
			Long appliedCandidateCount = employerJobPostManager.getAppliedCandidateCountInTimeframe(companyName,previousDate);
			Long candidateProfilesVisitedCount = employerManager.getEmployerActivityCount(companyName,previousDate,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_VIEWED_PROFILE);
			Long resumeDownloadedCount = employerManager.getEmployerActivityCount(companyName,previousDate,CaerusAPIStringConstants.EMPLOYER_ACTIVITY_DOWNLOADED_RESUME);
			
			
			employerAnalytics.put("jobsInTimeFrame",jobsInTimeFrame);
			employerAnalytics.put("appliedCandidateCount",appliedCandidateCount);
			employerAnalytics.put("candidateProfilesVisitedCount",candidateProfilesVisitedCount);
			employerAnalytics.put("resumeDownloadedCount",resumeDownloadedCount);
			
		}
		return null == employerAnalytics ? new HashMap<String, Long>() : employerAnalytics;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_REPORTS_JSON)
	@ResponseBody
	private Map<String,String> getEmployerReports(@RequestParam("durationReports") String durationReports,HttpServletRequest request)
	{
		String companyName = request.getSession().getAttribute("compName").toString();
		Map<String,String> employerReports = new HashMap<String, String>();
		if(null != durationReports && durationReports.trim().length() > 0){
			if(CaerusStringConstants.getEmployerAnalyticsDropdown().containsKey(durationReports)){
				Date previousDate = CaerusCommonUtil.getDateByDifference(CaerusStringConstants.getEmployerAnalyticsDropdown().get(durationReports));
				Float averageJobClosureTime = employerJobPostManager.getAverageJobClosureTime(companyName,previousDate);
				Long averageResponsesPerJob = employerJobPostManager.getAverageResponsesPerJob(companyName,previousDate);
				employerReports.put("averageJobClosureTime",averageJobClosureTime.toString());
				employerReports.put("averageResponsesPerJob",averageResponsesPerJob.toString());
			}
			
		}
		return null == employerReports ? new HashMap<String, String>() : employerReports;
	}
}