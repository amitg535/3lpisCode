package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.EmployerCampusJobValidator;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerCampusJobActivitiesController {

	private EmployerCampusJobValidator employerCampusJobValidator;
	
	@Autowired
	public EmployerCampusJobActivitiesController(EmployerCampusJobValidator employerCampusJobValidator){
		this.employerCampusJobValidator = employerCampusJobValidator;
	}
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	final static String EMPLOYER_CAMPUS_JOBS_LISTING = "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS+"?selected=campusJobs";
	
	Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_CAMPUS_JOB,method=RequestMethod.GET)
	String loadPostCampusJobPage(Model model)
	{
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("campusJob",new JobDetailsCom());
		List<String> jobTypes = new ArrayList<String>();
		jobTypes.add("Full Time");
		jobTypes.add("Part Time");
		
		 model.addAttribute("jobTypes", jobTypes);
		 
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_JOB;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_POST_CAMPUS_JOB,method=RequestMethod.POST)
	String postCampusJob(@RequestParam(value="editMode",required=false) String editMode, @ModelAttribute("campusJob") JobDetailsCom campusJobDetails,BindingResult bindingResult,Model model,HttpServletRequest request)
	{
		String returnView = CaerusJSPMapper.EMPLOYER_CAMPUS_JOB_PREVIEW;
		
		employerCampusJobValidator.validate(campusJobDetails, bindingResult);
		
		if(bindingResult.hasErrors()){
			
			model.addAttribute("universityList", masterManager.getRegisteredUniversities());
			model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
			model.addAttribute("industryList", masterManager.getIndustries());
			
			model.addAttribute("campusJob",campusJobDetails);
			
			List<String> jobTypes = new ArrayList<String>();
			jobTypes.add("Full Time");
			jobTypes.add("Part Time");
			
			 model.addAttribute("jobTypes", jobTypes);
			return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_JOB;
		}
		if(campusJobDetails.getCampusJobRecipients() != null && campusJobDetails.getCampusJobRecipients().size() > 0)
		{
			campusJobDetails.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getCampusJobRecipients()));
		}
		
		if(editMode != null && editMode.equals("true"))
		{	
			campusJobDetails.setJobIdAndFirmId(campusJobDetails.getJobId().concat("_").concat(SecurityContextHolder.getContext().getAuthentication().getName()));
			campusJobDetails.setUniversityName(campusJobDetails.getCampusJobRecipients().get(0));
			returnView = CaerusJSPMapper.EMPLOYER_POST_CAMPUS_JOB;
			campusJobDetails.setJobUpdateFlag(true);
			
			String status = campusJobDetails.getStatus();
			if(null != status && status.trim().length() > 0){
				if(status.contains(","))
				{
					int lastIndex = status.lastIndexOf(',');
					status = status.substring(lastIndex + 1,status.length());
				}
				campusJobDetails.setStatus(status);
			}
		}
		
		
		long campusJobCount = loginManagement.getCampusJobViewedCount(campusJobDetails.getJobIdAndFirmId(),campusJobDetails.getUniversityName());
		campusJobDetails.setJobViewedCount(campusJobCount);
		
		if(campusJobDetails.getPrimarySkills() != null && campusJobDetails.getPrimarySkills().size() > 0)
		{
			campusJobDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getPrimarySkills()));
		}
		if(campusJobDetails.getSecondarySkills() != null && campusJobDetails.getSecondarySkills().size() > 0)
		{
			campusJobDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getSecondarySkills()));
		}
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		campusJobDetails.setEmailId(authentication.getName());
		
		campusJobDetails.setPostedOn(new Date().toString());
		
		if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
			campusJobDetails.setCompanyName(request.getSession().getAttribute("compName").toString());
		
		LoginManagementDom userDetails = loginManagement.getAdminByEntityName(request.getSession().getAttribute("compName").toString().trim());
		campusJobDetails.setEmailId(userDetails.getUserName().trim());
		
		if(campusJobDetails.getZipCode() != null && campusJobDetails.getZipCode().trim().length() == 0){
			campusJobDetails.setZipCode("0");
		}
		
		model.addAttribute("companyDetails",employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString()));
		model.addAttribute("campusJob",campusJobDetails);
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		
		return returnView;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPDATE_CAMPUS_JOB_STATUS)
	ModelAndView updateCampusJobStatus(@RequestParam("action") String action,@ModelAttribute("campusJob") JobDetailsCom campusJobDetails,HttpServletRequest request)
	{
		JobDetailsDom campusJobDetailsDom = new JobDetailsDom();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		campusJobDetails.setEmailId(authentication.getName());
		
		BeanUtils.copyProperties(campusJobDetails, campusJobDetailsDom);
		
		if(action != null)
		{
			if(campusJobDetailsDom.getCampusJobRecipients() != null && campusJobDetailsDom.getCampusJobRecipients().size() > 0)
			{
				campusJobDetailsDom.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getCampusJobRecipients()));
			}
			if(campusJobDetailsDom.getPrimarySkills() != null && campusJobDetailsDom.getPrimarySkills().size() > 0)
			{
				campusJobDetailsDom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getPrimarySkills()));
			}
			if(campusJobDetailsDom.getSecondarySkills() != null && campusJobDetailsDom.getSecondarySkills().size() > 0)
			{
				campusJobDetailsDom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getSecondarySkills()));
			}
			
			String companyName = "";
			if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
				companyName = request.getSession().getAttribute("compName").toString();
			
			campusJobDetailsDom.setCompanyName(companyName);
			
			if(action.equals("save"))
			{
				employerJobPostManager.saveCampusJob(campusJobDetailsDom);
				logger.info(CaerusLoggerConstants.EMPLOYER_SAVED_CAMPUS_JOB);
			}
			if(action.equals("publish"))
			{
				employerJobPostManager.publishCampusJob(campusJobDetailsDom);
				logger.info(CaerusLoggerConstants.EMPLOYER_PUBLISHED_CAMPUS_JOB);
			}
		}
		return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS+"?selected=campusJobs"));
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_POSTED_CAMPUS_JOB)
	String previewPostedCampusJob(@RequestParam("jobId") String jobId,@RequestParam("universityName")String universityName,Model model,HttpServletRequest request)
	{
		EmployerDom companyDetails = employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString());
		JobDetailsDom campusJobDetails = employerJobPostManager.getCampusJobDetails(jobId,universityName);
		
		if(campusJobDetails.getCampusJobRecipients() != null && campusJobDetails.getCampusJobRecipients().size() > 0)
		{
			campusJobDetails.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getCampusJobRecipients()));
		}
		if(campusJobDetails.getPrimarySkills() != null && campusJobDetails.getPrimarySkills().size() > 0)
		{
			campusJobDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getPrimarySkills()));
		}
		if(campusJobDetails.getSecondarySkills() != null && campusJobDetails.getSecondarySkills().size() > 0)
		{
			campusJobDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getSecondarySkills()));
		}
		LoginManagementDom userDetails = loginManagement.getAdminByEntityName(request.getSession().getAttribute("compName").toString().trim());
		campusJobDetails.setEmailId(userDetails.getUserName().trim());
		
		JobDetailsCom campusJobDetailsCom = new JobDetailsCom();
		BeanUtils.copyProperties(campusJobDetails, campusJobDetailsCom);
		
		Long campusJobCount = loginManagement.getCampusJobViewedCount(jobId,universityName);
		campusJobDetailsCom.setJobViewedCount(campusJobCount);
		campusJobDetailsCom.setResponseCount((long) campusJobDetailsCom.getCampusJobAppliedStudents().size());
		
		model.addAttribute("campusJob",campusJobDetailsCom);
		model.addAttribute("companyDetails", companyDetails);
		model.addAttribute("jobDateFormat", CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		
		return CaerusJSPMapper.EMPLOYER_CAMPUS_JOB_PREVIEW;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_EDIT_POSTED_CAMPUS_JOB)
	String editPostedCampusJob(@RequestParam("jobId") String jobId,@RequestParam("universityName")String universityName,Model model,HttpServletRequest request)
	{
		JobDetailsDom campusJobDetails = employerJobPostManager.getCampusJobDetails(jobId,universityName);
		
		campusJobDetails.setJobUpdateFlag(true);
		JobDetailsCom campusJobDetailsCom = new JobDetailsCom();
		
		if(campusJobDetails.getCampusJobRecipients() != null && campusJobDetails.getCampusJobRecipients().size() > 0)
		{
			campusJobDetails.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getCampusJobRecipients()));
		}
		if(campusJobDetails.getPrimarySkills() != null && campusJobDetails.getPrimarySkills().size() > 0)
		{
			campusJobDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getPrimarySkills()));
		}
		if(campusJobDetails.getSecondarySkills() != null && campusJobDetails.getSecondarySkills().size() > 0)
		{
			campusJobDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetails.getSecondarySkills()));
		}
		
		BeanUtils.copyProperties(campusJobDetails, campusJobDetailsCom);
		
		if(campusJobDetailsCom.getZipCode() != null && campusJobDetailsCom.getZipCode().trim().length() == 0){
			campusJobDetailsCom.setZipCode("0");
		}
		
		model.addAttribute("campusJob",campusJobDetailsCom);
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_JOB;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DELETE_CAMPUS_JOB)
	String deleteCampusJob(@RequestParam("jobId") String jobId,@RequestParam("universityName")String universityName)
	{
		employerJobPostManager.deleteCampusJob(jobId,universityName);
		logger.info(CaerusLoggerConstants.EMPLOYER_DELETE_CAMPUS_JOB);
		return EMPLOYER_CAMPUS_JOBS_LISTING;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_COPY_CAMPUS_JOB)
	String copyCampusJob(@RequestParam("jobId") String jobId,@RequestParam("universityName")String universityName,Model model)
	{
		JobDetailsDom campusJobDetailsDom = employerJobPostManager.getCampusJobDetails(jobId,universityName);
		
		campusJobDetailsDom.setJobId("");
		campusJobDetailsDom.setJobTitle("");
		
		if(campusJobDetailsDom.getCampusJobRecipients() != null && campusJobDetailsDom.getCampusJobRecipients().size() > 0)
		{
			campusJobDetailsDom.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getCampusJobRecipients()));
		}
		if(campusJobDetailsDom.getPrimarySkills() != null && campusJobDetailsDom.getPrimarySkills().size() > 0)
		{
			campusJobDetailsDom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getPrimarySkills()));
		}
		if(campusJobDetailsDom.getSecondarySkills() != null && campusJobDetailsDom.getSecondarySkills().size() > 0)
		{
			campusJobDetailsDom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusJobDetailsDom.getSecondarySkills()));
		}
		
		JobDetailsCom campusJobDetailsCom = new JobDetailsCom();
		BeanUtils.copyProperties(campusJobDetailsDom, campusJobDetailsCom);
		
		if(campusJobDetailsCom.getZipCode() != null && campusJobDetailsCom.getZipCode().trim().length() == 0){
			campusJobDetailsCom.setZipCode("0");
		}
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("campusJob",campusJobDetailsCom);
		
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_JOB;
	}
}