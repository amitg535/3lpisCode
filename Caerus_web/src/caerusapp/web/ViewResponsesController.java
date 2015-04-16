package caerusapp.web;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.StudentJobsManager;
import caerusapp.service.student.StudentManager;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to display the list of responses of students received for a campus job broadcasted by a university
 * @author RavishaG
 */
@Controller
public class ViewResponsesController {
	
	// Auto-wiring service component
	@Autowired
	StudentJobsManager studentJobsManager;
	@Autowired
	IEmployerJobPostManager employerJobPostManager;
	@Autowired
	StudentManager studentManager;
	@Autowired
	IUniversityManager universityManager;
	
	@Autowired
	IEmployerManager employerManager;
	
	/**
	 * This method is used to fetch the responses of students received for a campus job broadcasted by a university
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.VIEW_CAMPUS_JOB_RESPONSES)
	public ModelAndView viewJobResponses(@RequestParam("jobId")String jobId,@RequestParam("universityName")String universityName,
			HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ParseException
	{
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("common/view_campus_job_responses");
		
		
		Map<String,Date> appliedStudentsMap = new HashMap<String,Date>();
		List<StudentDom> appliedStudentDetails = new ArrayList<StudentDom>();
		StudentDom studentDetails = null;
		
		// Retrieving the details of the campus job from the database
		JobDetailsDom jobDetails = employerJobPostManager.getCampusJobDetails(jobId,universityName);

		//Adding values to the modelAndView object
		modelAndView.addObject("jobTitle", jobDetails.getJobTitle());
		modelAndView.addObject("companyName",jobDetails.getCompanyName());
		modelAndView.addObject("location",jobDetails.getLocation());
		modelAndView.addObject("date",jobDetails.getPostedOn());
		
		// Retrieving the students who have applied for the campus job from the database
		appliedStudentsMap = studentJobsManager.getStudentsAppliedForJob(jobId,universityName);
		
		if(appliedStudentsMap != null)
		{
			for (Entry<String, Date> entry : appliedStudentsMap.entrySet()) {
				String emailId = entry.getKey();
				
				// Retrieving the details of the students who have applied for the campus job from the database
				studentDetails = studentManager.getDetailsByEmailId(emailId);
				
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		        Date date = entry.getValue();
		        String current = dateFormat.format(date);
				
				studentDetails.setAppliedDate(current);
				appliedStudentDetails.add(studentDetails);
			}
		}
		
		Map<String, String> appliedStudentEmailsWithStatus = new HashMap<String, String>();
		appliedStudentEmailsWithStatus = employerJobPostManager.getAppliedCandidateEmailIdsForCampusJob(jobId,universityName);
		
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
		modelAndView.addObject("appliedStudentEmailsWithStatus",appliedStudentEmailsWithStatus);

		modelAndView.addObject("shortlistedStudentCount",shortlistedStudentCount);
		modelAndView.addObject("onHoldStudentCount",onHoldStudentCount);
		modelAndView.addObject("rejectedStudentCount",rejectedStudentCount);
		modelAndView.addObject("totalStudentsCount",totalStudentsCount);
		
		List<StudentDom> studentList = new ArrayList<StudentDom>();
		
		for (StudentDom candidateDetails : appliedStudentDetails) 
		{
			List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(candidateDetails.getUniversityMap());
			
			if(universityDetailsList.size() != 0)
			{
				if(universityDetailsList != null && universityDetailsList.size() > 1)
				{
					candidateDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
				}
				else
				{
					candidateDetails.setUniversityDetails(universityDetailsList.get(0));
				}
			}
			studentList.add(candidateDetails);
		}
		
		/* Added by RavishaG to sort students on I-Score */
		if(appliedStudentDetails != null)
		{
			Collections.sort(appliedStudentDetails, new Comparator<StudentDom>() {
			     @Override
			      public int compare(StudentDom o1, StudentDom o2) {
			       return o2.getIScore().compareTo(o1.getIScore());
			      }
			    });
		}
		
		// Adding values to the modelAndView object
		modelAndView.addObject("appliedStudentDetails",studentList);
		modelAndView.addObject("count",appliedStudentDetails.size());		
		
		// returning the modelAndView object
		return modelAndView;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SHORTLIST_CANDIDATE_CAMPUS)
	String employerShortlistCandidate(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,@RequestParam("universityName") String universityName)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForCampusInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_SHORTLISTED_STATUS,internshipIdAndFirmId,universityName);
			return "redirect:view_campus_internship_responses.htm?internshipIdAndFirmId="+internshipIdAndFirmId+"&universityName="+universityName;
		}
		if(jobId != null && jobId.length() > 0)
		{
			employerManager.updateCandidateStatusForCampusJob(candidateEmailId, CaerusStringConstants.CANDIDATE_SHORTLISTED_STATUS,jobId,universityName);
		}
		return "redirect:view_campus_job_responses.htm?jobId="+jobId+"&universityName="+universityName;
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_REJECT_CANDIDATE_CAMPUS)
	String employerRejectCandidate(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,@RequestParam("universityName") String universityName)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForCampusInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_REJECTED_STATUS,internshipIdAndFirmId,universityName);
			return "redirect:view_campus_internship_responses.htm?internshipIdAndFirmId="+internshipIdAndFirmId+"&universityName="+universityName;
		}
	
		if(jobId != null && jobId.length() > 0)
			employerManager.updateCandidateStatusForCampusJob(candidateEmailId, CaerusStringConstants.CANDIDATE_REJECTED_STATUS,jobId,universityName);
		return "redirect:view_campus_job_responses.htm?jobId="+jobId+"&universityName="+universityName;
	}
		
	@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_PUT_CANDIDATE_ONHOLD_CAMPUS)
	String employerPutCandidateOnHold(
			@RequestParam(value="isInternship",required=false) Boolean isInternship,
			@RequestParam(value="internshipIdAndFirmId",required=false) String internshipIdAndFirmId,
			@RequestParam(value="jobId",required=false) String jobId,
			@RequestParam("candidateEmailId") String candidateEmailId,@RequestParam("universityName") String universityName)
	{
		if(isInternship != null && isInternship && internshipIdAndFirmId != null && internshipIdAndFirmId.length() > 0){
			employerManager.updateCandidateStatusForCampusInternship(candidateEmailId, CaerusStringConstants.CANDIDATE_ONHOLD_STATUS,internshipIdAndFirmId,universityName);
			return "redirect:view_campus_internship_responses.htm?internshipIdAndFirmId="+internshipIdAndFirmId+"&universityName="+universityName;
		}
		
		if(jobId != null && jobId.length() > 0)
			employerManager.updateCandidateStatusForCampusJob(candidateEmailId, CaerusStringConstants.CANDIDATE_ONHOLD_STATUS,jobId,universityName);
		return "redirect:view_campus_job_responses.htm?jobId="+jobId+"&universityName="+universityName;
	}
	
	
	/**
	 * This method is used to fetch the responses of students received for a campus internship broadcasted by a university
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.VIEW_CAMPUS_INTERNSHIP_RESPONSES)
	public ModelAndView viewInternshipResponses(@RequestParam("internshipIdAndFirmId")String internshipIdAndFirmId,@RequestParam("universityName")String universityName,
			HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ParseException
	{
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("common/view_campus_internship_responses");
		
		Map<String,Date> appliedStudentsMap = new HashMap<String,Date>();
		List<StudentDom> appliedStudentDetails = new ArrayList<StudentDom>();
		StudentDom studentdetails = null;
		
		// Retrieving the details of the campus internship from the database
		JobDetailsDom jobDetails = employerJobPostManager.getCampusInternshipDetails(internshipIdAndFirmId,universityName);

		// Adding values to the modelAndView object
		modelAndView.addObject("internshipTitle", jobDetails.getInternshipTitle());
		modelAndView.addObject("companyName",jobDetails.getCompanyName());
		modelAndView.addObject("location",jobDetails.getLocation());
		modelAndView.addObject("date",jobDetails.getPostedOn());
		
		// Retrieving the students who have applied for the campus internship from the database
		appliedStudentsMap = studentJobsManager.getStudentsAppliedForInternship(internshipIdAndFirmId,universityName);
		
		if(appliedStudentsMap != null)
		{
			for (Entry<String, Date> entry : appliedStudentsMap.entrySet()) {
				String emailId = entry.getKey();
				
				// Retrieving the details of the students who have applied for the campus internship from the database
				studentdetails = studentManager.getDetailsByEmailId(emailId);
				
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		        Date date = entry.getValue();
		        String current = dateFormat.format(date);
				
				studentdetails.setAppliedDate(current);
				appliedStudentDetails.add(studentdetails);
			}
		}
		
		Map<String, String> appliedStudentEmailsWithStatus = new HashMap<String, String>();
		appliedStudentEmailsWithStatus = employerJobPostManager.getAppliedCandidateEmailIdsForCampusInternship(internshipIdAndFirmId,universityName);
		
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
		modelAndView.addObject("appliedStudentEmailsWithStatus",appliedStudentEmailsWithStatus);

		modelAndView.addObject("shortlistedStudentCount",shortlistedStudentCount);
		modelAndView.addObject("onHoldStudentCount",onHoldStudentCount);
		modelAndView.addObject("rejectedStudentCount",rejectedStudentCount);
		modelAndView.addObject("totalStudentsCount",totalStudentsCount);
		
		List<StudentDom> studentList = new ArrayList<StudentDom>();
		
		for (StudentDom candidateDetails : appliedStudentDetails) 
		{
			List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(candidateDetails.getUniversityMap());
			
			if(universityDetailsList.size() != 0)
			{
				if(universityDetailsList != null && universityDetailsList.size() > 1)
				{
					candidateDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
				}
				else
				{
					candidateDetails.setUniversityDetails(universityDetailsList.get(0));
				}
			}
			studentList.add(candidateDetails);
		}
		
		/* Added by RavishaG to sort students on I-Score */
		if(appliedStudentDetails != null)
		{
			Collections.sort(appliedStudentDetails, new Comparator<StudentDom>() {
			     @Override
			      public int compare(StudentDom o1, StudentDom o2) {
			       return o2.getIScore().compareTo(o1.getIScore());
			      }
			    });
		}
		
		// Adding values to the modelAndView object
		modelAndView.addObject("appliedStudentDetails",studentList);
		modelAndView.addObject("count",appliedStudentDetails.size());
		
		// returning the modelAndView object
		return modelAndView;
	}
}