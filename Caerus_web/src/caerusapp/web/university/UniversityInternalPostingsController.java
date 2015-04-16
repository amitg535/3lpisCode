package caerusapp.web.university;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.university.UniversityJobCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.domain.university.UniversityJobDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.student.IStudentManager;
import caerusapp.service.university.IUniversityJobsManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.service.university.UniversityInternalPostingValidator;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusStringConstants;

@Controller
public class UniversityInternalPostingsController {

	@Autowired
	IUniversityJobsManager universityJobsManager;
	
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	@Autowired
	UniversityInternalPostingValidator universityInternalPostingValidator;
	
	@Autowired
	IStudentManager studentManager;
	
	private Log logger = LogFactory.getLog(getClass());
	
	private final static String SUCCESS_REDIRECTION = "redirect:"+CaerusAnnotationURLConstants.UNIVERSITY_INTERNAL_POSTINGS;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_INTERNAL_POSTINGS, method = RequestMethod.GET)
	String loadInternalPostings(Model model,HttpServletRequest request){
		String universityName = "";
		if(null != request.getSession().getAttribute("univName"))
			universityName = request.getSession().getAttribute("univName").toString();
			
		List<UniversityJobDom> internalPostings =  universityJobsManager.getInternalPostings(universityName);
		
		model.addAttribute("jobStatusClosed",CaerusStringConstants.JOB_STATUS_CLOSED);
		model.addAttribute("jobStatusPublished",CaerusStringConstants.JOB_STATUS_PUBLISHED);
		model.addAttribute("jobStatusDraft",CaerusStringConstants.JOB_STATUS_DRAFT);
		model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		model.addAttribute("internalPostings",internalPostings);
		return CaerusJSPMapper.UNIVERSITY_INTERNAL_POSTINGS;
	}
	
	@RequestMapping( value = CaerusAnnotationURLConstants.UNIVERSITY_POST_INTERNSHIP, method = RequestMethod.GET)
	String loadUniversityPostInternshipPage(Model model){
		
		model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
		model.addAttribute("universityJobCom", new UniversityJobCom());
		return CaerusJSPMapper.UNIVERSITY_POST_INTERNSHIP;
	}
	
	@RequestMapping( value = CaerusAnnotationURLConstants.UNIVERSITY_POST_INTERNSHIP, method = RequestMethod.POST)
	String universityPostInternship(@ModelAttribute("universityJobCom") UniversityJobCom universityJobCom,BindingResult bindingResult, @RequestParam(value="editMode",required = false) String editMode,@RequestParam(value = "action",required = false) String action, @RequestParam(value="post",required=false) String post, HttpServletRequest request,Model model){
		
		model.addAttribute("role", SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString().replace("[", "").replace("]", ""));
		String redirectView = "";
		UniversityJobDom universityJobDom = new UniversityJobDom();
		universityJobCom.setPostedOn(new Date().toString());
		
		LoginManagementDom adminDetails = new LoginManagementDom();
		UniversityDetailsDom universityDetails = new UniversityDetailsDom();
		
		if(null != request.getSession().getAttribute("univName"))
			universityJobCom.setUniversityName(request.getSession().getAttribute("univName").toString());

		
		if(null != editMode && editMode.equals("true"))
			redirectView = CaerusJSPMapper.UNIVERSITY_POST_INTERNSHIP;
		
		if(null != action && action.trim().length() > 0)
		{
			if(null != universityJobCom)
				BeanUtils.copyProperties(universityJobCom, universityJobDom);
			
			if(action.equals("save"))
			{
				universityJobDom.setStatus(CaerusStringConstants.JOB_STATUS_DRAFT);
				logger.info(request.getSession().getAttribute("univName") +" Drafted Internal Posting ");
			}
			
			if(action.equals("publish"))
			{
				universityJobDom.setStatus(CaerusStringConstants.JOB_STATUS_PUBLISHED);
				logger.info(request.getSession().getAttribute("univName") +" Published Internal Posting ");
			}
			
			if(null != universityJobDom.getPrimarySkills() && universityJobDom.getPrimarySkills().size() > 0)
				universityJobDom.setPrimarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(universityJobDom.getPrimarySkills()));
			
			if(null != universityJobDom.getSecondarySkills() && universityJobDom.getSecondarySkills().size() > 0)
				universityJobDom.setSecondarySkills(CaerusCommonUtil.removeExtraneousBracketsFromList(universityJobDom.getSecondarySkills()));
			
			universityJobsManager.postInternship(universityJobDom);
			
			redirectView = SUCCESS_REDIRECTION;
		}
		
		if(null != post && post.equals("true"))
		{
			universityInternalPostingValidator.validate(universityJobCom, bindingResult);
			
			if(bindingResult.hasErrors()){
				redirectView = "university/university_post_internship";
				model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
				model.addAttribute("universityJobCom", universityJobCom);
				return redirectView;
			}
			
			if(! universityJobCom.isUpdateFlag())
			{
				if(universityJobsManager.internalInternshipIdExists(universityJobCom.getInternshipId().concat("_").concat(universityJobCom.getUniversityName()),universityJobCom.getUniversityName()))
					bindingResult.rejectValue("internshipId","Duplicate Internship Id","Internship Already Exists with the Same ID.Please Enter a new value");
			
				if(bindingResult.hasErrors()){
					redirectView = CaerusJSPMapper.UNIVERSITY_POST_INTERNSHIP;
					model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
					model.addAttribute("universityJobCom", universityJobCom);
					return redirectView;
				}
			}
			redirectView = CaerusJSPMapper.UNIVERSITY_PREVIEW_INTERNAL_INTERNSHIP;
			adminDetails = loginManagement.getAdminByEntityName(request.getSession().getAttribute("univName").toString());
			universityDetails = universityManager.getUniversityDetailsByName(request.getSession().getAttribute("univName").toString());
		}
		
		model.addAttribute("adminDetails",adminDetails);
		model.addAttribute("universityDetails",universityDetails);
		model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
		model.addAttribute("universityJobCom",universityJobCom);
		model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		return redirectView;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_PREVIEW_INTERNAL_INTERNSHIP)
	String getInternalInternshipDetails(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,@RequestParam(value="universityName",required=false) String universityName, Model model,HttpServletRequest request){
		UniversityJobDom universityJobDom = new UniversityJobDom();
		
		if(null == universityName)
			universityName = request.getSession().getAttribute("univName").toString();
		
		
		if(null != internshipIdAndFirmId){
			universityJobDom = universityJobsManager.getInternalInternshipDetails(internshipIdAndFirmId,universityName);
		}
		universityJobDom.setUpdateFlag(true);
		model.addAttribute("adminDetails",loginManagement.getAdminByEntityName(universityName));
		model.addAttribute("universityDetails",universityManager.getUniversityDetailsByName(universityName));
		model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
		model.addAttribute("universityJobCom",universityJobDom);
		model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		model.addAttribute("role",SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString().replace("[", "").replace("]", ""));
		
		
		return CaerusJSPMapper.UNIVERSITY_PREVIEW_INTERNAL_INTERNSHIP;
	}
	
	@RequestMapping( value = CaerusAnnotationURLConstants.UNIVERSITY_DELETE_INTERNAL_INTERNSHIP)
	String deleteInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, HttpServletRequest request){
		
		universityJobsManager.deleteInternalInternship(internshipIdAndFirmId,request.getSession().getAttribute("univName").toString());
		return SUCCESS_REDIRECTION;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_COPY_INTERNAL_INTERNSHIP)
	String copyInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, HttpServletRequest request,Model model){
		UniversityJobDom universityJobDom = new UniversityJobDom();
		universityJobDom = universityJobsManager.getInternalInternshipDetails(internshipIdAndFirmId,request.getSession().getAttribute("univName").toString());
		
		universityJobDom.setInternshipId("");
		universityJobDom.setInternshipTitle("");
		
		model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
		model.addAttribute("universityJobCom", universityJobDom);
		return CaerusJSPMapper.UNIVERSITY_POST_INTERNSHIP;
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_EDIT_INTERNAL_INTERNSHIP)
	String editInternship(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, HttpServletRequest request,Model model){
		UniversityJobDom universityJobDom = new UniversityJobDom();
		universityJobDom = universityJobsManager.getInternalInternshipDetails(internshipIdAndFirmId,request.getSession().getAttribute("univName").toString());
		
		universityJobDom.setUpdateFlag(true);
		model.addAttribute("internshipTypes", CaerusStringConstants.INTERNSHIP_TYPES);
		model.addAttribute("universityJobCom", universityJobDom);
		return CaerusJSPMapper.UNIVERSITY_POST_INTERNSHIP;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_VIEW_INTERNAL_POSTING_RESPONSES)
	String viewInternalPostingResponses(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, HttpServletRequest request,Model model){
		String universityName = request.getSession().getAttribute("univName").toString();
		List<StudentDom> appliedCandidates = new ArrayList<StudentDom>();
		
		Map<String,String> appliedCandidateEmailIds = universityJobsManager.getAppliedCandidateEmailIds(internshipIdAndFirmId,universityName);
		Map<String,Date> appliedCandidateEmailIdsWithTime = universityJobsManager.getAppliedCandidateEmailIdsWithTimestamp(internshipIdAndFirmId,universityName);
		
		if(null != appliedCandidateEmailIds && !appliedCandidateEmailIds.isEmpty())
		{
			String appliedCandidateEmails = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(appliedCandidateEmailIds.keySet()));
			appliedCandidates = studentManager.getCandidateListByEmailId(appliedCandidateEmails);
		}
		int appliedCandidateCount = 0;
		int rejectedCandidates = 0;
		int shortlistedCandidates = 0;
		int onholdCandidates = 0;
		if(null != appliedCandidateEmailIds && ! appliedCandidateEmailIds.isEmpty())
		{
			Map<String,Integer> cardinalityMap = CollectionUtils.getCardinalityMap(appliedCandidateEmailIds.values());
			
			if(null != cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS))
				appliedCandidateCount = cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_APPLY_STATUS);
			
			if(null != cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_SHORTLISTED_STATUS))
				shortlistedCandidates = cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_SHORTLISTED_STATUS);
			
			if(null != cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_ONHOLD_STATUS))
				onholdCandidates = cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_ONHOLD_STATUS);
			
			if(null != cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_REJECTED_STATUS))
				rejectedCandidates = cardinalityMap.get(CaerusAPIStringConstants.CANDIDATE_REJECTED_STATUS);
		}
		
		model.addAttribute("displayDateFormat",CaerusStringConstants.DISPLAY_DATE_FORMAT);
		model.addAttribute("dbDateFormat",CaerusStringConstants.DB_DATE_FORMAT);
		model.addAttribute("appliedCandidateCount",appliedCandidateCount);
		model.addAttribute("shortlistedCandidates",shortlistedCandidates);
		model.addAttribute("onholdCandidates",onholdCandidates);
		model.addAttribute("rejectedCandidates",rejectedCandidates);
		model.addAttribute("universityName",universityName);
		model.addAttribute("internshipDetails",universityJobsManager.getInternalInternshipDetails(internshipIdAndFirmId, universityName));
		model.addAttribute("appliedCandidates",appliedCandidates);
		model.addAttribute("appliedCandidateEmailIds",appliedCandidateEmailIds);
		model.addAttribute("appliedCandidateEmailIdsWithTime",appliedCandidateEmailIdsWithTime);
		
		return CaerusJSPMapper.UNIVERSITY_VIEW_INTERNAL_POSTING_RESPONSES;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.UNIVERSITY_UPDATE_CANDIDATE_STATUS)
	String updateCandidateStatus(
			@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId,
			@RequestParam("status") String status,
			@RequestParam("candidateEmailId") String candidateEmailId,
			HttpServletRequest request){
		
		String universityName = request.getSession().getAttribute("univName").toString();
		universityJobsManager.updateCandidateStatus(candidateEmailId,internshipIdAndFirmId,universityName,status);
		
		return "redirect:"+CaerusAnnotationURLConstants.UNIVERSITY_VIEW_INTERNAL_POSTING_RESPONSES+"?internshipIdAndFirmId="+internshipIdAndFirmId;
	}
	
}
