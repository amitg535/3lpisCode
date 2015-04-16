package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
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
import caerusapp.domain.employer.EmployerDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.EmployerInternshipValidator;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerInternshipActivitiesController {

	@Autowired
	public EmployerInternshipActivitiesController(EmployerInternshipValidator employerInternshipValidator){
		this.employerInternshipValidator = employerInternshipValidator;
	}
	
	private EmployerInternshipValidator employerInternshipValidator;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_INTERNSHIP,method=RequestMethod.GET)
	String loadInternshipPage(Model model)
	{
		JobDetailsCom jobDetailsCom = new JobDetailsCom();
		model.addAttribute("postInternship",jobDetailsCom);
		
		List<String> internshipTypes = new ArrayList<String>();
		internshipTypes.add("Full Time");
		internshipTypes.add("Part Time");
		
		model.addAttribute("internshipTypes",internshipTypes);
		return CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_INTERNSHIP,method=RequestMethod.POST)
	String postInternship(@RequestParam(value="editMode",required=false)String editMode,@ModelAttribute("postInternship") JobDetailsCom internshipDetails,BindingResult bindingResult,Model model,HttpServletRequest request)
	{
		String returnView = CaerusJSPMapper.EMPLOYER_PREVIEW_INTERNSHIP;
		
		employerInternshipValidator.validate(internshipDetails, bindingResult);
		
		if(bindingResult.hasErrors()){
			
			model.addAttribute("postInternship",internshipDetails);
			List<String> internshipTypes = new ArrayList<String>();
			internshipTypes.add("Full Time");
			internshipTypes.add("Part Time");
			
			model.addAttribute("internshipTypes",internshipTypes);
			return CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
		}
		
		internshipDetails.setEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
		
		String internshipDescription = "";
		if (internshipDetails.getInternshipDescription()!=null && internshipDetails.getInternshipDescription().length()>0)
			internshipDescription = Jsoup.parse(internshipDetails.getInternshipDescription()).text();
		
		/*if( null != internshipDetails.getJobUpdateFlag() && internshipDetails.getJobUpdateFlag()){
		}*/
		model.addAttribute("statusDisp",internshipDetails.getStatus());
		
		if(!(internshipDetails != null && internshipDetails.getJobUpdateFlag() != null && internshipDetails.getJobUpdateFlag()))
		{
			if(editMode != null && editMode.equals("true"))
			{
				model.addAttribute("editMode",true);
				List<String> internshipTypes = new ArrayList<String>();
				internshipTypes.add("Full Time");
				internshipTypes.add("Part Time");
				
				model.addAttribute("internshipTypes",internshipTypes);
				returnView = CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
			}	
			else
			{	
				//Checking if the internship with id:internshipId exists
				int count = employerJobPostManager.getInternshipIdCount(internshipDetails.getInternshipId());
				
				//Exception Handling
				try 
				{
					if(count == 0)
					{
						
						internshipDetails.setEmailId(loginManagement.getUserDetailsByEmailID(SecurityContextHolder.getContext().getAuthentication().getName()).getUserName());
					}
					else
					{
						throw new CaerusCommonException("Internship Id is already registered");
					}
					internshipDetails.setPostedOn(new Date().toString());
					
					
				}
				catch(CaerusCommonException e)
				{
					internshipDetails.setExceptionOccured(true);
					internshipDetails.setExceptionMessage(e.getLocalizedMessage());
					returnView = CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
				}
			}
		}
		
		if(internshipDetails.getPrimarySkills() != null && internshipDetails.getPrimarySkills().size() > 0)
		{
			internshipDetails.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getPrimarySkills()));
		}
		if(internshipDetails.getSecondarySkills() != null && internshipDetails.getSecondarySkills().size() > 0)
		{
			internshipDetails.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getSecondarySkills()));
		}
		model.addAttribute("internshipDescription",internshipDescription);
		model.addAttribute("postInternship",internshipDetails);
		model.addAttribute("internshipDetails",internshipDetails);
		model.addAttribute("jobDateFormat", CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		model.addAttribute("companyDetails",employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString()));
		
		return returnView;
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_UPDATE_INTERNSHIP_STATUS)
	ModelAndView updateInternshipStatus(@RequestParam(value="action",required=false)String action,@ModelAttribute("postInternship") JobDetailsCom internshipDetails,HttpServletRequest request){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		
		if(action != null){
			internshipDetails.setEmailId(loggedInUserEmail);
			internshipDetails.setCompanyName(request.getSession().getAttribute("compName").toString());
			
			JobDetailsDom internshipDetailsDom = new JobDetailsDom();
			BeanUtils.copyProperties(internshipDetails, internshipDetailsDom);
			
			internshipDetailsDom.setCompanyName(request.getSession().getAttribute("compName").toString());
			
			if(internshipDetails.getPrimarySkills() != null && internshipDetails.getPrimarySkills().size() > 0)
			{
				internshipDetailsDom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getPrimarySkills()));
			}
			if(internshipDetails.getSecondarySkills() != null && internshipDetails.getSecondarySkills().size() > 0)
			{
				internshipDetailsDom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getSecondarySkills()));
			}
			
			if(action.equals("save"))
			{
				employerJobPostManager.saveInternship(internshipDetailsDom);
			}
			if(action.equals("publish"))
			{
				employerJobPostManager.publishInternship(internshipDetailsDom);
			}
		}
		return new ModelAndView(new RedirectView(CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS+"?selected=internships"));
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_COPY_INTERNSHIP)
	String copyInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,Model model)
	{
		JobDetailsDom internshipDetails = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
		
		JobDetailsCom internshipDetailsCom = new JobDetailsCom();
		BeanUtils.copyProperties(internshipDetails, internshipDetailsCom);
		
		internshipDetailsCom.setInternshipId("");
		internshipDetailsCom.setInternshipTitle("");
		
		if(internshipDetails.getPrimarySkills() != null && internshipDetails.getPrimarySkills().size() > 0)
		{
			internshipDetailsCom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getPrimarySkills()));
		}
		if(internshipDetails.getSecondarySkills() != null && internshipDetails.getSecondarySkills().size() > 0)
		{
			internshipDetailsCom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetails.getSecondarySkills()));
		}
		
		model.addAttribute("postInternship",internshipDetailsCom);
		model.addAttribute("internshipDetails",internshipDetailsCom);
		return CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_EDIT_POSTED_INTERNSHIP)
	String editInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,Model model)
	{
		JobDetailsDom internshipDetails = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
		JobDetailsCom internshipDetailsCom = new JobDetailsCom();
		
		BeanUtils.copyProperties(internshipDetails, internshipDetailsCom);		
	
		internshipDetailsCom.setEmailId(loginManagement.getUserDetailsByEmailID(SecurityContextHolder.getContext().getAuthentication().getName()).getUserName());
		
	
		if(internshipDetailsCom.getPrimarySkills() != null && internshipDetailsCom.getPrimarySkills().size() > 0)
		{
			internshipDetailsCom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetailsCom.getPrimarySkills()));
		}
		if(internshipDetailsCom.getSecondarySkills() != null && internshipDetailsCom.getSecondarySkills().size() > 0)
		{
			internshipDetailsCom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetailsCom.getSecondarySkills()));
		}
		
		String internshipDescription = "";
		if (internshipDetails.getInternshipDescription()!=null && internshipDetails.getInternshipDescription().length()>0)
			internshipDescription = Jsoup.parse(internshipDetails.getInternshipDescription()).text();				
		
		model.addAttribute("statusDisp",internshipDetailsCom.getStatus());
		model.addAttribute("internshipDescription",internshipDescription);
		model.addAttribute("postInternship",internshipDetailsCom);
		model.addAttribute("internshipDetails",internshipDetailsCom);
		//return CaerusJSPMapper.EMPLOYER_PREVIEW_INTERNSHIP;
		model.addAttribute("editMode",true);
		
		return CaerusJSPMapper.EMPLOYER_POST_INTERNSHIP;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_LISTED_INTERNSHIP)
	String getInternshipPreview(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,Model model, HttpServletRequest request)
	{
		EmployerDom companyDetails = employerManager.getEmployerDetails(request.getSession().getAttribute("compName").toString());
		JobDetailsDom internshipDetails = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
		JobDetailsCom internshipDetailsCom = new JobDetailsCom();
		String internshipDescription = "";
		
		if (internshipDetails.getInternshipDescription()!=null && internshipDetails.getInternshipDescription().length()>0)
			internshipDescription = Jsoup.parse(internshipDetails.getInternshipDescription()).text();				
	
		BeanUtils.copyProperties(internshipDetails, internshipDetailsCom);	
		
		if(internshipDetailsCom.getPrimarySkills() != null && internshipDetailsCom.getPrimarySkills().size() > 0)
		{
			internshipDetailsCom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetailsCom.getPrimarySkills()));
		}
		if(internshipDetailsCom.getSecondarySkills() != null && internshipDetailsCom.getSecondarySkills().size() > 0)
		{
			internshipDetailsCom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(internshipDetailsCom.getSecondarySkills()));
		}
		
		internshipDetailsCom.setEmailId(loginManagement.getUserDetailsByEmailID(SecurityContextHolder.getContext().getAuthentication().getName()).getUserName());
		
		Long internshipViewedCount = loginManagement.getInternshipViewedCount(internshipDetailsCom.getInternshipIdAndFirmId());
		internshipDetailsCom.setJobViewedCount(internshipViewedCount);
		
		model.addAttribute("internshipDescription",internshipDescription);		
		model.addAttribute("postInternship",internshipDetailsCom);
		model.addAttribute("internshipDetails",internshipDetailsCom);
		model.addAttribute("companyDetails", companyDetails);
		model.addAttribute("jobDateFormat", CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		
		return CaerusJSPMapper.EMPLOYER_PREVIEW_INTERNSHIP;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_DELETE_INTERNSHIP)
	String deleteInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId)
	{
		employerJobPostManager.deleteInternship(internshipIdAndFirmId);
		return CaerusJSPMapper.REDIRECT_SUCCESS_JOBS_INTERNSHIPS+"?selected=internships";
	}
	
	/**
	 * This method is used to close an internship
	 * @author RavishaG
	 * @param internshipIdAndFirmId
	 * @param universityName
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_CLOSE_INTERNSHIP,method = RequestMethod.POST)
	public void closeCampusInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,HttpServletRequest httpServletRequest,
			HttpServletResponse httpServletResponse)
	{
		// Close internship
		employerJobPostManager.closeInternship(internshipIdAndFirmId);
		logger.info(CaerusLoggerConstants.EMPLOYER_CLOSE_INTERNSHIP);
	}
	
	/**
	 * This method is used to extend an internship's end date
	 * @author RavishaG
	 * @param internshipIdAndFirmId
	 * @param universityName
	 * @param endDate
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_EXTEND_INTERNSHIP_ENDDATE,method = RequestMethod.POST)
	public void extendCampusInternshipEndDate(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,@RequestParam("endDate") String endDate,
			HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		// Extend internship end date
		employerJobPostManager.extendInternshipEndDate(internshipIdAndFirmId,endDate);
		logger.info(CaerusLoggerConstants.EMPLOYER_INTERNSHIP_DATE_EXTENDED);
	}
	
}
