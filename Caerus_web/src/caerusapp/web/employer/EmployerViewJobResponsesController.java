package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentScoreDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.CalculateScore;
import caerusapp.util.CandidateCommonFeature;

@Controller
public class EmployerViewJobResponsesController {

	@Autowired
	private IStudentJobsManager studentJobsManager;
	@Autowired
	private IStudentManager studentManager;
	@Autowired
	private IEmployerManager employerManager;
	@Autowired
	private IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_VIEW_JOB_RESPONSES)
	String loadJobResponses(@RequestParam("jobId")String jobId,Model model, HttpServletRequest request, HttpServletResponse response)
	{
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loggedInUserEmail = authentication.getName();
		
		String companyName = loginManagement.getEntityNameByEmailId(loggedInUserEmail);
/*		HttpSession httpSession = request.getSession(true);	
*/		JobDetailsDom jobDetails = employerJobPostManager.getJobDetailsByJobIdAndFirmId(jobId);
		
		Map<String, String> appliedStudentEmailsWithStatus = new HashMap<String, String>();
		appliedStudentEmailsWithStatus = employerJobPostManager.getAppliedCandidateEmailIds(jobId);
		
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
		
		
		model.addAttribute("jobDetails",jobDetails);
		model.addAttribute("jobIdAndFirmId", jobDetails.getJobIdAndFirmId());
		model.addAttribute("companyName", companyName);
		
		/*httpSession.setAttribute("jobId", jobId);
		httpSession.setAttribute("jobtitle", jobDetails.getJobTitle());
		httpSession.setAttribute("companyName", companyName);*/
		model.addAttribute("dbDateFormat", CaerusAPIStringConstants.DB_DATE_FORMAT);
		model.addAttribute("displayDateFormat", CaerusAPIStringConstants.DISPLAY_DATE_FORMAT);
		model.addAttribute("employerFormulaeNames",employerFormulaeNames);
		return CaerusJSPMapper.EMPLOYER_JOB_RESPONSES;
		
	}
	
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SHORTLIST_CANDIDATE)
	String employerShortlistCandidate(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,
			HttpServletRequest request)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_SHORTLISTED_STATUS,internshipIdAndFirmId);
			//Short listed from Candidate Preview Page
			if(request.getHeader("referer").contains("detail_view_candidate.htm")){
				return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&internshipIdAndFirmId="+internshipIdAndFirmId;
			}
			else
			return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_INTERNSHIP_RESPONSES+"?internshipIdAndFirmId="+internshipIdAndFirmId;
		}
		if(jobId != null && jobId.length() > 0)
		{
			employerManager.updateCandidateStatus(candidateEmailId, CaerusStringConstants.CANDIDATE_SHORTLISTED_STATUS,jobId);
			//Short listed from Candidate Preview Page
			if(request.getHeader("referer").contains("detail_view_candidate.htm")){
				return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&jobId="+jobId;
			}
		}
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_JOB_RESPONSES+"?jobId="+jobId;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_REJECT_CANDIDATE)
	String employerRejectCandidate(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,
			HttpServletRequest request)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_REJECTED_STATUS,internshipIdAndFirmId);
			//Short listed from Candidate Preview Page
			if(request.getHeader("referer").contains("detail_view_candidate.htm")){
				return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&internshipIdAndFirmId="+internshipIdAndFirmId;
			}
			else
			return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_INTERNSHIP_RESPONSES+"?internshipIdAndFirmId="+internshipIdAndFirmId;
		}
	
		if(jobId != null && jobId.length() > 0)
			employerManager.updateCandidateStatus(candidateEmailId, CaerusStringConstants.CANDIDATE_REJECTED_STATUS,jobId);
		//Short listed from Candidate Preview Page
		if(request.getHeader("referer").contains("detail_view_candidate.htm")){
			return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&jobId="+jobId;
		}
		else
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_JOB_RESPONSES+"?jobId="+jobId;
	}
		
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_PUT_CANDIDATE_ONHOLD)
	String employerPutCandidateOnHold(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,
			HttpServletRequest request)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_ONHOLD_STATUS,internshipIdAndFirmId);
			//Short listed from Candidate Preview Page
			if(request.getHeader("referer").contains("detail_view_candidate.htm")){
				return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&internshipIdAndFirmId="+internshipIdAndFirmId;
			}
			else
			return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_INTERNSHIP_RESPONSES+"?internshipIdAndFirmId="+internshipIdAndFirmId;
		}
		
		if(jobId != null && jobId.length() > 0)
			employerManager.updateCandidateStatus(candidateEmailId, CaerusStringConstants.CANDIDATE_ONHOLD_STATUS,jobId);
		//Short listed from Candidate Preview Page
		if(request.getHeader("referer").contains("detail_view_candidate.htm")){
			return "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_DETAIL_VIEW+"?studentEmailId="+candidateEmailId+"&jobId="+jobId;
		}
		else
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_VIEW_JOB_RESPONSES+"?jobId="+jobId;
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_GENERATE_SCORE)
	@ResponseBody
	public Map<String,Double> generateScoreAccordingToFormula(@RequestParam(value="jobId",required=false) String jobId,
	@RequestParam(value="formulaName",required=false) String formulaName,@RequestParam(value="internshipId",required=false) String internshipId,
	@RequestParam(value="internshipFlag",required=false) Boolean internshipFlag,
			HttpServletRequest request)
	{
		//Spring security authentication containing the logged in user details
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String emailId = authentication.getName();
		
		Map<String,Double> candidateScores = new HashMap<String, Double>();
		
		if(!(formulaName.equals(CaerusStringConstants.DEFAULT_FORMULA_NAME)))
		{	
			String candidateEmailIds="";
			Map<String, String> appliedCandidateEmailIds = new HashMap<String, String>();
			List<String> appliedCandidateEmailIdList = new ArrayList<String>();
			List<StudentDom> candidateList = new ArrayList<StudentDom>();
			List<StudentDom> appliedStudents = new ArrayList<StudentDom>();
			
			//Getting applied students for the job
			if(internshipFlag != null && internshipFlag)
				appliedStudents = studentJobsManager.getInternshipAppliedStudent(internshipId);
			else
				appliedCandidateEmailIds = employerJobPostManager.getAppliedCandidateEmailIds(jobId);
	
			if(appliedCandidateEmailIds != null)
			{
				for (Entry<String,String> appliedStudentEntry: appliedCandidateEmailIds.entrySet()) {
						
					candidateEmailIds = appliedStudentEntry.getKey();
					appliedCandidateEmailIdList.add(candidateEmailIds);
				}
			}
			
			candidateEmailIds = CaerusCommonUtility.getCassandraInQueryString(appliedCandidateEmailIdList);
			
			List<String> finalFormulaList = new ArrayList<String>();
			
			List<String> formulaDetails= employerManager.getFormulaDetails(formulaName,emailId);
			
			/** Manipulating Formula Displayed to match Calculation Parameters */
			for (String formula : formulaDetails)
			{
				if (formula.endsWith("University Rank"))
					formula = "UniversityRank";
	
				if (formula.endsWith("Course Rank"))
					formula = "CourseRank";
				
				if (formula.endsWith("Graduation Year"))
					formula = "GraduationYear";
				
				if (formula.endsWith("Years of Experience"))
					formula = "YearsofExperience";
				
				if (formula.endsWith("High School GPA"))
					formula = "HighSchoolGPA";
				
				if (formula.endsWith("Age"))
					formula = "Age";
				
				if (formula.endsWith("University GPA"))
					formula = "UniversityGPA";
	
				finalFormulaList.add(formula);
			}
			
			//Modified existing code
			if (candidateEmailIds.length() > 0) 
			{
				candidateList = studentManager.getCandidateListByEmailId(candidateEmailIds);
	
				Integer age = 0 ;
				Double highSchoolGPA = 0.0;
				Double universityGPA = 0.0;
				Double yearsOfExperience = 0.0;
				Double iScore = 0.0; 
				
				/**
				 * Calculating iScore for All Candidates Individually
				 */
				for (StudentDom studentDetails : candidateList)
				{
					if(studentDetails.getDateOfBirth() != null)
					{
						age = CalculateScore.calculateAge(studentDetails.getDateOfBirth());
					}
					
					if(studentDetails.getH_from_gpa() != null && studentDetails.getH_to_gpa() != null)
					{
						highSchoolGPA = CalculateScore.calculateHighSchoolGPA(studentDetails.getH_from_gpa(),studentDetails.getH_to_gpa());
					}
					
					if(studentDetails.getG_from_gpa() != null && studentDetails.getG_to_gpa() != null)
					{
						universityGPA = CalculateScore.calculateUniversityGPA(studentDetails.getG_from_gpa(),studentDetails.getG_to_gpa());
					}
					
					if(studentDetails.getW_startYear_duration()!=null && studentDetails.getW_endYear_duration() != null
							&& studentDetails.getW_startMonth_duration() != null && studentDetails.getW_endMonth_duration() != null)
					{
						yearsOfExperience =	CalculateScore.calculateYearsOfExperience(
													studentDetails.getW_startYear_duration(),studentDetails.getW_endYear_duration(),
													studentDetails.getW_startMonth_duration(),studentDetails.getW_endMonth_duration());
					}
					
					StudentScoreDom studentScoreDom = new StudentScoreDom();
					
					studentScoreDom.setAge(age);
					studentScoreDom.setYearsOfExperience(yearsOfExperience);
					studentScoreDom.setHighSchoolGPA(highSchoolGPA);
					studentScoreDom.setUniversityGPA(universityGPA);
					
					/** Setting Static Values for Course and University Rank */
					studentScoreDom.setCourseRank(5);
					studentScoreDom.setUniversityRank(5);
					/** Setting Static Values for Course and University Rank */
					
					if(studentDetails.getG_endYear_duration() != null)
						studentScoreDom.setGraduationYear(Integer.parseInt(studentDetails.getG_endYear_duration()));
					
					iScore = CalculateScore.calculateIScore(studentScoreDom, finalFormulaList);
						
					studentDetails.setiScore(iScore);
					
					candidateScores.put(studentDetails.getEmailID(), iScore);
				}
			}
			
			if(!candidateScores.isEmpty())
			{
				/** Sorting Map on Scores in Descending Order */
				candidateScores = CaerusCommonUtility.sortMapOnValues(candidateScores);
			}
			logger.info(CaerusLoggerConstants.EMPLOYER_GENERATE_SCORE);
		}
		
		return candidateScores;
	}
}
