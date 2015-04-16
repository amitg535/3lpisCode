package caerusapp.web.student;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.university.UniversityJobDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.university.IUniversityJobsManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class CandidateInternalPostings {

	@Autowired
	ILoginManagement loginManagement;
	
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired
	IUniversityJobsManager universityJobsManager;
	
	@Autowired
	IStudentJobsManager studentJobsManager;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_INTERNAL_POSTINGS)
	String loadInternalPostings(Model model){
		String candidateEmailId = SecurityContextHolder.getContext().getAuthentication().getName();
		
		String universityName = universityManager.getUniversityForRegisteredStudent(candidateEmailId);
		int internalPostingCount = 0;
		
		if(null != universityName && universityName.trim().length() > 0)
		{
			List<UniversityJobDom> internalPostings = universityJobsManager.getInternalPostings(universityName, new ArrayList<String>(){{add(CaerusStringConstants.JOB_STATUS_PUBLISHED);}});

			if(null != internalPostings && internalPostings.size() > 0)
				internalPostingCount = internalPostings.size();
		
			model.addAttribute("appliedInternalPostingIds", studentJobsManager.getAppliedInternalPostingIds(candidateEmailId));
			model.addAttribute("dbDateFormat",CaerusAPIStringConstants.DB_DATE_FORMAT);
			model.addAttribute("displayDateFormat",CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
			model.addAttribute("draftStatus",CaerusStringConstants.JOB_STATUS_DRAFT);
			model.addAttribute("candidateEmailId",candidateEmailId);
			model.addAttribute("internalPostings",internalPostings);
		}
		model.addAttribute("internalPostingCount",internalPostingCount);
		return "candidate/candidate_internal_postings";
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_APPLY_INTERNAL_POSTING)
	String applyToInternalPosting(@RequestParam("internshipIdAndFirmId") String internshipIdAndFirmId, @RequestParam("universityName") String universityName){
		String candidateEmailId = SecurityContextHolder.getContext().getAuthentication().getName();
		studentJobsManager.applyToInternalPostings(internshipIdAndFirmId,universityName,candidateEmailId);
		
		return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_INTERNAL_POSTINGS;
	}
	
}
