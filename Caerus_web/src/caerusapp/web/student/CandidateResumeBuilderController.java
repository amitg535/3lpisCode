/**
 * 
 */
package caerusapp.web.student;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to add  fields in resume using resume builder
 * @author TrishnaR
 * 
 */
@Controller
public class CandidateResumeBuilderController
{
	/** Auto-wiring Service Components */
	@Autowired
	StudentManager studentManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/*
	 * This method is used to add fields in resume using resume builder
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_RESUME_BUILDER)
	public String loadResumeBuilder(@RequestParam(value="content",required=false) String careerObjective, @RequestParam(value="expertise",required=false) String expertise,HttpServletRequest request,HttpServletResponse response,Model model) throws Exception
	{
		/**Spring security authentication containing the logged in user details*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName(); // Logged in username

		logger.info(CaerusLoggerConstants.RESUME_BUILDER);

		if (careerObjective != null) 
		{
			//Adding Career Objective to Resume
			studentManager.addCareerObjectiveToResume(studentEmailId, careerObjective);
		}

		if (expertise != null) 
		{
			//Adding Expertise to Resume
			studentManager.addExpertiseToResume(studentEmailId, expertise);
		}

		StudentDom studentDetails = studentManager.getDetailsByEmailId(studentEmailId);
		model.addAttribute("studentDetails", studentDetails);
		
		PortfolioDetailsDom schoolDetails = CandidateCommonFeature.getSchoolDetails(studentDetails.getSchoolMap());
		model.addAttribute("schoolDetails", schoolDetails);
		
		List<PortfolioDetailsDom> universityList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
		model.addAttribute("universityList", universityList);
		
		List<PortfolioDetailsDom> workDetails = CandidateCommonFeature.getWorkDetails(studentDetails.getWorkMap());
		model.addAttribute("workDetails", workDetails);
		
		List<PortfolioDetailsDom> certificationList = CandidateCommonFeature.getCertificationList(studentDetails.getCertificationsMap());
		model.addAttribute("certificationList", certificationList);			 

		List<PortfolioDetailsDom> publicationList = CandidateCommonFeature.getPublicationList(studentDetails.getPublicationsMap());
		model.addAttribute("publicationList", publicationList);

		return "candidate/candidate_resume_builder";

	}
}