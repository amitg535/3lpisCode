package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.CandidateCommonFeature;

@Controller
public class EmployerViewInternshipResponsesController {

	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_VIEW_INTERNSHIP_RESPONSES)
	String loadInternshipResponses(@RequestParam("internshipIdAndFirmId")String internshipIdAndFirmId,Model model,HttpServletRequest request){
		
		if(internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0)
		{
			//Spring security authentication containing the logged in user details
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String loggedInUserEmail = authentication.getName();
			
			
			String companyName = "";

			if(request.getSession().getAttribute("compName") != null)
				companyName = request.getSession().getAttribute("compName").toString();
			
			JobDetailsDom internshipDetails = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipIdAndFirmId);
			
			Map<String, String> appliedStudentEmailsWithStatus = new HashMap<String, String>();
			appliedStudentEmailsWithStatus = employerJobPostManager.getAppliedCandidateEmailIdsForInternship(internshipIdAndFirmId);
			
			List<String> appliedStudentEmailIds = new ArrayList<String>();
			
			if(appliedStudentEmailsWithStatus != null && ! appliedStudentEmailsWithStatus.isEmpty())
				appliedStudentEmailIds = new ArrayList<String>(appliedStudentEmailsWithStatus.keySet());
			
			int rejectedStudentCount = 0;
			int shortlistedStudentCount = 0;
			int onHoldStudentCount = 0;
			int totalStudentsCount = 0;
			
			if(appliedStudentEmailsWithStatus != null)
			{	
				shortlistedStudentCount = Collections.frequency(new ArrayList<String>(appliedStudentEmailsWithStatus.values()), 
						CaerusStringConstants.CANDIDATE_SHORTLISTED_STATUS);
				
				onHoldStudentCount = Collections.frequency(new ArrayList<String>(appliedStudentEmailsWithStatus.values()), 
						CaerusStringConstants.CANDIDATE_ONHOLD_STATUS);
				
				rejectedStudentCount = Collections.frequency(new ArrayList<String>(appliedStudentEmailsWithStatus.values()),
						CaerusStringConstants.CANDIDATE_REJECTED_STATUS);
				
				totalStudentsCount = appliedStudentEmailsWithStatus.size();
			}
			
			String appliedStudentEmailIdsStr = CaerusCommonUtility.getCassandraInQueryString(appliedStudentEmailIds);
			
			List<StudentDom> appliedCandidates = studentManager.getCandidateListByEmailId(appliedStudentEmailIdsStr);
			
			List<StudentDom> studentList = new ArrayList<StudentDom>();
			
			for (StudentDom studentDetails : appliedCandidates) 
			{
				List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
				
				if(universityDetailsList.size() != 0)
				{
					if(universityDetailsList != null && universityDetailsList.size() > 1)
					{
						studentDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
					}
					else
					{
						studentDetails.setUniversityDetails(universityDetailsList.get(0));
					}
				}
				studentList.add(studentDetails);
			}
			
			// Sort candidates by I-Score
			if(studentList != null)
			{
				
				Collections.sort(studentList, new Comparator<StudentDom>() {
				       
				     @Override
				      public int compare(StudentDom o1, StudentDom o2) {
				       return o2.getiScore().compareTo(o1.getiScore());
				      }
				    });
			}
			
			model.addAttribute("appliedCandidates",studentList);
			model.addAttribute("appliedStudentEmailsWithStatus",appliedStudentEmailsWithStatus);
			
			List<String> employerFormulaeNames = employerManager.getFormulaNames(loggedInUserEmail);
			
			model.addAttribute("shortlistedStudentCount",shortlistedStudentCount);
			model.addAttribute("onHoldStudentCount",onHoldStudentCount);
			model.addAttribute("rejectedStudentCount",rejectedStudentCount);
			model.addAttribute("totalStudentsCount",totalStudentsCount);
			
			model.addAttribute("internshipIdAndFirmId",internshipDetails.getInternshipIdAndFirmId());
			
			model.addAttribute("jobDetails",internshipDetails);
			model.addAttribute("companyName", companyName);
			
			
			model.addAttribute("employerFormulaeNames",employerFormulaeNames);
		}
		model.addAttribute("internshipResponses",true);
		return "employer/employer_job_responses";
	}
	
}
