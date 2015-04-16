package caerusapp.web.employer;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import caerusapp.service.employer.EmployerCampusInternshipValidator;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerCampusInternshipActivitiesController {

	@Autowired
	public EmployerCampusInternshipActivitiesController(EmployerCampusInternshipValidator employerCampusInternshipValidator){
		this.employerCampusInternshipValidator = employerCampusInternshipValidator;
	}
	
	private EmployerCampusInternshipValidator employerCampusInternshipValidator;
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	Log logger = LogFactory.getLog(getClass());
	
	final static String EMPLOYER_JOBS_INTERNSHIPS_REDIRECT = "redirect:employer_jobs_internships.htm?selected=campusInternships";
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_CAMPUS_INTERNSHIP,method=RequestMethod.GET)
	String loadCampusInternshipPage(@ModelAttribute("campusInternshipCommand") JobDetailsCom campusInternshipCommand,Model model)
	{
		JobDetailsCom campusInternshipCom = new JobDetailsCom();
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("campusInternshipCommand",campusInternshipCom);
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_INTERNSHIP;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_CAMPUS_INTERNSHIP,method=RequestMethod.POST)
	String postCampusInternship(@RequestParam(value="editMode",required=false) String editMode,
			@ModelAttribute("campusInternshipCommand") JobDetailsCom campusInternshipCommand,BindingResult bindingResult,Model model,HttpServletRequest request)
	{
		String returnView = CaerusJSPMapper.EMPLOYER_PREVIEW_CAMPUS_INTERNSHIP;
		
		employerCampusInternshipValidator.validate(campusInternshipCommand,bindingResult);
		
		if(bindingResult.hasErrors()){
			
			model.addAttribute("universityList", masterManager.getRegisteredUniversities());
			model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
			model.addAttribute("industryList", masterManager.getIndustries());
			
			model.addAttribute("campusInternshipCommand",campusInternshipCommand);
			return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_INTERNSHIP;
		}
		
		if(editMode != null && editMode.length() > 0)
		{
			
			returnView = CaerusJSPMapper.EMPLOYER_POST_CAMPUS_INTERNSHIP;
			campusInternshipCommand.setJobUpdateFlag(true);
			
			campusInternshipCommand.setInternshipIdAndFirmId(campusInternshipCommand.getInternshipId().concat("_").concat(SecurityContextHolder.getContext().getAuthentication().getName()));
			if(campusInternshipCommand.getCampusJobRecipients() != null && campusInternshipCommand.getCampusJobRecipients().size() > 0)
			{
				campusInternshipCommand.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getCampusJobRecipients()));
				campusInternshipCommand.setUniversityName(campusInternshipCommand.getCampusJobRecipients().get(0));
			}
			if(campusInternshipCommand.getPrimarySkills() != null && campusInternshipCommand.getPrimarySkills().size() > 0)
			{
				campusInternshipCommand.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getPrimarySkills()));
			}
			if(campusInternshipCommand.getSecondarySkills() != null && campusInternshipCommand.getSecondarySkills().size() > 0)
			{
				campusInternshipCommand.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getSecondarySkills()));
			}
		}
		campusInternshipCommand.setPostedOn(new Date().toString());
		
		LoginManagementDom userDetails = loginManagement.getAdminByEntityName(request.getSession().getAttribute("compName").toString().trim());
		campusInternshipCommand.setEmailId(userDetails.getUserName().trim());
		
		Long campusInternshipCount = loginManagement.getCampusInternshipViewedCount(campusInternshipCommand.getInternshipIdAndFirmId(),campusInternshipCommand.getUniversityName());
		campusInternshipCommand.setJobViewedCount(campusInternshipCount);
		campusInternshipCommand.setResponseCount(campusInternshipCommand.getResponseCount());
		
		model.addAttribute("jobDateFormat", CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("campusInternshipCommand",campusInternshipCommand);
		model.addAttribute("companyDetails", employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString()));
		
		return returnView;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPDATE_CAMPUS_INTERNSHIP_STATUS)
	ModelAndView updateCampusInternshipStatus(@RequestParam("action") String action,@ModelAttribute("campusInternshipCommand") JobDetailsCom campusInternshipCommand,Model model,HttpServletRequest request)
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		campusInternshipCommand.setEmailId(authentication.getName());
		
		String companyName = "";
		
		if(request.getSession().getAttribute("compName") != null && !request.getSession().getAttribute("compName").equals(""))
			companyName = request.getSession().getAttribute("compName").toString();
		
		campusInternshipCommand.setCompanyName(companyName);
		
		JobDetailsDom campusInternshipDom = new JobDetailsDom();
		
		if(campusInternshipCommand.getCampusJobRecipients() != null && campusInternshipCommand.getCampusJobRecipients().size() > 0)
		{
			campusInternshipCommand.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getCampusJobRecipients()));
		}
		if(campusInternshipCommand.getPrimarySkills() != null && campusInternshipCommand.getPrimarySkills().size() > 0)
		{
			campusInternshipCommand.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getPrimarySkills()));
		}
		if(campusInternshipCommand.getSecondarySkills() != null && campusInternshipCommand.getSecondarySkills().size() > 0)
		{
			campusInternshipCommand.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipCommand.getSecondarySkills()));
		}
		
		BeanUtils.copyProperties(campusInternshipCommand, campusInternshipDom);
		
		if(action != null && action.length() > 0)
		{
			if(action.equals("save")){
				employerJobPostManager.saveCampusInternship(campusInternshipDom);
			}
			if(action.equals("publish")){
				employerJobPostManager.publishCampusInternship(campusInternshipDom);
			}
		}
		model.addAttribute("campusInternshipCommand",campusInternshipCommand);
		
		return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS+"?selected=campusInternships"));
	}
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_POSTED_CAMPUS_INTERNSHIP)
	String previewPostedCampusInternship(@RequestParam("internshipId") String internshipId,@RequestParam("universityName")String universityName,Model model,HttpServletRequest request)
	{
		JobDetailsDom campusInternshipDetails = employerJobPostManager.getCampusInternshipDetails(internshipId,universityName);
		
		if(campusInternshipDetails.getCampusJobRecipients() != null && campusInternshipDetails.getCampusJobRecipients().size() > 0)
		{
			campusInternshipDetails.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getCampusJobRecipients()));
		}
		if(campusInternshipDetails.getPrimarySkills() != null && campusInternshipDetails.getPrimarySkills().size() > 0)
		{
			campusInternshipDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getPrimarySkills()));
		}
		if(campusInternshipDetails.getSecondarySkills() != null && campusInternshipDetails.getSecondarySkills().size() > 0)
		{
			campusInternshipDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getSecondarySkills()));
		}
		
		
		EmployerDom companyDetails = employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString());
		model.addAttribute("companyDetails", companyDetails);
		
		LoginManagementDom userDetails = loginManagement.getAdminByEntityName(request.getSession().getAttribute("compName").toString().trim());
		campusInternshipDetails.setEmailId(userDetails.getUserName().trim());
		
		JobDetailsCom campusInternshipDetailsCom = new JobDetailsCom();
		BeanUtils.copyProperties(campusInternshipDetails, campusInternshipDetailsCom);
		
		Long campusInternshipCount = loginManagement.getCampusInternshipViewedCount(internshipId,universityName);
		campusInternshipDetailsCom.setJobViewedCount(campusInternshipCount);
		campusInternshipDetailsCom.setResponseCount((long) campusInternshipDetailsCom.getCampusInternshipAppliedStudents().size());

		model.addAttribute("jobDateFormat", CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		model.addAttribute("campusInternshipCommand",campusInternshipDetailsCom);
		
		return CaerusJSPMapper.EMPLOYER_PREVIEW_CAMPUS_INTERNSHIP;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_COPY_CAMPUS_INTERNSHIP)
	String copyCampusJob(@RequestParam("internshipId") String internshipId,@RequestParam("universityName")String universityName,Model model)
	{
		JobDetailsDom campusInternshipDetailsDom = employerJobPostManager.getCampusInternshipDetails(internshipId,universityName);
		
		campusInternshipDetailsDom.setInternshipId("");
		campusInternshipDetailsDom.setInternshipTitle("");
		
		if(campusInternshipDetailsDom.getCampusJobRecipients() != null && campusInternshipDetailsDom.getCampusJobRecipients().size() > 0)
		{
			campusInternshipDetailsDom.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetailsDom.getCampusJobRecipients()));
		}
		if(campusInternshipDetailsDom.getPrimarySkills() != null && campusInternshipDetailsDom.getPrimarySkills().size() > 0)
		{
			campusInternshipDetailsDom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetailsDom.getPrimarySkills()));
		}
		if(campusInternshipDetailsDom.getSecondarySkills() != null && campusInternshipDetailsDom.getSecondarySkills().size() > 0)
		{
			campusInternshipDetailsDom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetailsDom.getSecondarySkills()));
		}
		
		JobDetailsCom campusJobDetailsCom = new JobDetailsCom();
		BeanUtils.copyProperties(campusInternshipDetailsDom, campusJobDetailsCom);
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		model.addAttribute("campusInternshipCommand",campusJobDetailsCom);
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_INTERNSHIP;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_EDIT_POSTED_CAMPUS_INTERNSHIP)
	String editPostedCampusJob(@RequestParam("internshipId") String internshipId,@RequestParam("universityName")String universityName,Model model)
	{
		JobDetailsDom campusInternshipDetails = employerJobPostManager.getCampusInternshipDetails(internshipId,universityName);
		
		campusInternshipDetails.setJobUpdateFlag(true);
		JobDetailsCom campusInternshipDetailsCom = new JobDetailsCom();
		
		if(campusInternshipDetails.getCampusJobRecipients() != null && campusInternshipDetails.getCampusJobRecipients().size() > 0)
		{
			campusInternshipDetails.setCampusJobRecipients(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getCampusJobRecipients()));
		}
		if(campusInternshipDetails.getPrimarySkills() != null && campusInternshipDetails.getPrimarySkills().size() > 0)
		{
			campusInternshipDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getPrimarySkills()));
		}
		if(campusInternshipDetails.getSecondarySkills() != null && campusInternshipDetails.getSecondarySkills().size() > 0)
		{
			campusInternshipDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(campusInternshipDetails.getSecondarySkills()));
		}
		
		BeanUtils.copyProperties(campusInternshipDetails, campusInternshipDetailsCom);
		model.addAttribute("campusInternshipCommand",campusInternshipDetailsCom);
		
		model.addAttribute("universityList", masterManager.getRegisteredUniversities());
		model.addAttribute("functionalAreaList", masterManager.getFunctionalAreas());
		model.addAttribute("industryList", masterManager.getIndustries());
		
		return CaerusJSPMapper.EMPLOYER_POST_CAMPUS_INTERNSHIP;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DELETE_CAMPUS_INTERNSHIP)
	String deleteCampusInternship(@RequestParam("internshipId") String internshipId,@RequestParam("universityName")String universityName)
	{
		employerJobPostManager.deleteCampusInternship(internshipId,universityName);
		logger.info(CaerusLoggerConstants.EMPLOYER_DELETE_CAMPUS_INTERNSHIP);
		
		return EMPLOYER_JOBS_INTERNSHIPS_REDIRECT;
	}
	
	/**
	 * This method is used to close a campus internship
	 * @author RavishaG
	 * @param internshipIdAndFirmId
	 * @param universityName
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_CLOSE_CAMPUS_INTERNSHIP,method = RequestMethod.POST)
	public void closeCampusInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, @RequestParam("universityName") String universityName, 
			HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		// Close campus internship
		employerJobPostManager.closeCampusInternship(internshipIdAndFirmId,universityName);
		logger.info(CaerusLoggerConstants.EMPLOYER_CLOSE_CAMPUS_INTERNSHIP);
	}
	
	/**
	 * This method is used to extend campus internship's end date
	 * @author RavishaG
	 * @param internshipIdAndFirmId
	 * @param universityName
	 * @param endDate
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_EXTEND_CAMPUS_INTERNSHIP_ENDDATE,method = RequestMethod.POST)
	public void extendCampusInternshipEndDate(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, @RequestParam("universityName") String universityName, 
			@RequestParam("endDate") String endDate, HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		// Extend campus internship end date
		employerJobPostManager.extendCampusInternshipEndDate(internshipIdAndFirmId,universityName,endDate);
		logger.info(CaerusLoggerConstants.EMPLOYER_CAMPUS_INTERNSHIP_DATE_EXTENDED);
	}
}
