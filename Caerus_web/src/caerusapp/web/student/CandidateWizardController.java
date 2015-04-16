package caerusapp.web.student;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import caerusapp.command.student.StudentCom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to load the candidate wizard page and enable candidate to update his/her details
 * @author RavishaG
 *
 */
@Controller
public class CandidateWizardController {

	
	// Auto-wiring service component 
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	IMasterManager masterManager;
	
	
	 @ModelAttribute("addStudent")
	 public StudentCom getStudentObject() 
	 {
		return new StudentCom();
	 }
	
	
	/**
	 * This method is used to fetch load the candidate wizard page 
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_WIZARD,method = RequestMethod.GET)
	public String setupForm(Model model,@ModelAttribute("verificationMessage") String verificationMessage) 
	{
		if(verificationMessage != null && !verificationMessage.isEmpty())
		{
			model.addAttribute("verificationMessage",true);
		}
		
		// Adding values to the Model object
		model.addAttribute("addStudent",getStudentObject());
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		StudentCom addStudent = new StudentCom();
		
		// Retrieving student details from the database
		StudentDom student= studentManager.getDetailsByEmailId(studentEmailId);
		
		StudentDom studentDom = studentManager.getStudentImage(studentEmailId);
		
		addStudent.setPhotoName(studentDom.getPhotoName());
		
		addStudent.setAboutYourSelf(student.getAboutYourSelf());
		addStudent.setZipCode(student.getZipCode());
		addStudent.setDateOfBirth(student.getDateOfBirth());
		addStudent.setG_from_gpa(student.getG_from_gpa());
		addStudent.setG_to_gpa(student.getG_to_gpa());
		addStudent.setG_startYear_duration(student.getG_startYear_duration());
		addStudent.setG_endYear_duration(student.getG_endYear_duration());
		addStudent.setSchoolName(student.getSchoolName());
		addStudent.setH_from_gpa(student.getH_from_gpa());
		addStudent.setH_to_gpa(student.getH_to_gpa());
		addStudent.setH_startYear_duration(student.getH_startYear_duration());
		addStudent.setH_endYear_duration(student.getH_endYear_duration());

		//Retrieving Default Profile's About Yourself,Skills and Resume Heading
		
		
		if(!(student.getPrimarySkills() == null))
		{
		 StringBuilder sb = new StringBuilder();
	        for(String str : student.getPrimarySkills())
	        {
	            sb.append(str).append(","); //separating contents using semi colon
	        }
	      
	     String strfromArrayList = sb.toString();
		
		addStudent.setPrimarySkills1(strfromArrayList);
		}
		
		if(!(student.getSecondarySkills() == null)){
		 StringBuilder sb1 = new StringBuilder();
	        for(String str1 : student.getSecondarySkills()){
	            sb1.append(str1).append(","); //separating contents using semi colon
	        }
	      
	    String strfromArrayList1 = sb1.toString();
	    
		addStudent.setSecondarySkills1(strfromArrayList1);
		
		}
		
		addStudent.setCompanyName(student.getCompanyName());
		addStudent.setDesignation(student.getDesignation());
		addStudent.setWorkDesc(student.getWorkDesc());
		addStudent.setW_startMonth_duration(student.getW_startMonth_duration());
		addStudent.setW_startYear_duration(student.getW_startYear_duration());
		addStudent.setW_endMonth_duration(student.getW_endMonth_duration());
		addStudent.setW_endYear_duration(student.getW_endYear_duration());
		addStudent.setInterestList(student.getInterestList());
		
		model.addAttribute("gender",student.getGender());
		model.addAttribute("universityName", student.getUniversityName());
		model.addAttribute("courseName",student.getCourseName());
		model.addAttribute("schoolStateName",student.getSchoolState());
		
		List<Integer> yearList = new ArrayList<Integer>();
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		int previousYear = currentYear - 40;
		
		for(int i = (currentYear); i >= previousYear; i--)
		{
			yearList.add(currentYear);
			currentYear--;
		}
		
		// Retrieving list of courses from the database and sorting it alphabetically
		List<String> courseList = masterManager.getCourses();
		Collections.sort(courseList);

		// Retrieving list of universities from the database and sorting it alphabetically
		List<String> universityList = masterManager.getUniversities();
		Collections.sort(universityList);
		
		// Retrieving list of states from the database and sorting it alphabetically
		List<String> stateList = masterManager.getStates();
		Collections.sort(stateList);
		
		// Adding values to the Model object
		model.addAttribute("year", yearList);
		model.addAttribute("resumeName", student.getResumeName());
		model.addAttribute("languageList", student.getLanguagesList());
		model.addAttribute("courseList", courseList);
		model.addAttribute("universityList", universityList);
		model.addAttribute("stateList", stateList);
		
		model.addAttribute("addStudent", addStudent);
		model.addAttribute("emailId", student.getEmailID());
		model.addAttribute("photoName",studentDom.getPhotoName());
		
		// Redirecting to the specified view
	    return CaerusJSPMapper.CANDIDATE_WIZARD;
	    
	}
	
	/**
	 *  This method is used add personal details from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_WIZARD_INTRODUCTORY,method = RequestMethod.POST)
	   public void addIntroductory(@RequestBody StudentDom student,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
	
		Date date = CaerusCommonUtility.stringToDate(student.getDateOfBirth(), "yyyy-MM-dd");
		student.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").format(date));	
		
		// Updating the database with the details filled in by the candidate
		studentManager.addPersonalDetailsFromWizard(studentEmailId,student);	
		
	}
	
	/**
	 * This method is used add skill details from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_WIZARD_SKILLS,method = RequestMethod.POST)
	   public void addSkills(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		// Updating the database with the details filled in by the candidate
		studentManager.addSkillsFromWizard(studentEmailId,student);
			
	}
	
	/**
	 * This method is used add work details from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_WIZARD_WORK,method = RequestMethod.POST)
	   public void addWork(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		Map<String,String> workMap = student.getWorkMap();
		List<PortfolioDetailsDom> workList = CandidateCommonFeature.getWorkDetails(workMap);
		int i = 0;
		
		// Updating the database with the details filled in by the candidate
		studentManager.addWorkDetails(studentEmailId, workList, i);
		
	}
	
	/**
	 * This method is used add some additional extra details from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_WIZARD_INTERESTS,method = RequestMethod.POST)
	   public void addInterests(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		// Updating the database with the details filled in by the candidate
		studentManager.addStudentInterests(studentEmailId,student);
			
	}

	/**
	 * This method is used add some languages known by a candidate from the wizard page to the database
	 * @param student
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return null
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_WIZARD_ADD_LANGUAGES, method = RequestMethod.POST)
	 public void addLanguages(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		// Updating the database with the details filled in by the candidate
		studentManager.addStudentLanguagesKnown(studentEmailId,student);
		
	}
	
	/**
	 * This method is used remove languages by a candidate from the wizard page to the database
	 * @param student
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return null
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_WIZARD_REMOVE_LANGUAGES, method = RequestMethod.POST)
	 public void removeLanguages(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		// Updating the database with the details filled in by the candidate
		studentManager.removeLanguages(studentEmailId,student);
		
	}
	
	/**
	 * This method is used add entire education details of a candidate from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_WIZARD_EDUCATION, method = RequestMethod.POST)
	public void addEducationDetails(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
	
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		Map<String,String> schoolMap = student.getSchoolMap();
		PortfolioDetailsDom schoolDetails = CandidateCommonFeature.getSchoolDetails(schoolMap);
		
		// Updating the database with the details filled in by the candidate
		studentManager.addSchoolDetails(studentEmailId, schoolDetails);
		
	}
	
	/**
	 * This method is used add only graduate details of education section of a candidate from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_WIZARD_GRADUATE, method = RequestMethod.POST)
	public void addGarduateDetails(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
	
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		Map<String,String> universityMap = student.getUniversityMap();
		List<PortfolioDetailsDom> universityList = CandidateCommonFeature.getUniversityDetails(universityMap);
		int i = 0;
		
		// Updating the database with the details filled in by the candidate
		studentManager.addUniversityDetails(studentEmailId, universityList, i);
		
	}
}