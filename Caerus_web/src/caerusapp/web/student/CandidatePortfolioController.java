package caerusapp.web.student;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.search.suggest.Lookup.LookupResult;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import sun.misc.BASE64Decoder;
import caerusapp.command.student.PortfolioDetailsCmd;
import caerusapp.command.student.StudentCom;
import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentScoreDom;
import caerusapp.lucene.indexing.AutoSuggest;
import caerusapp.service.common.MasterManager;
import caerusapp.service.student.CandidatePortfolioValidator;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;
/**
 * This class is used to load the candidate portfolio page
 * @author KShailesh
 */
import caerusapp.util.CalculateScore;
import caerusapp.util.CandidateCommonFeature;

/**
 * Refactored to annotation based controller by RavishaG 
 */

@Controller
public class CandidatePortfolioController {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Auto-wiring service component
	@Autowired
	private StudentManager studentManager;
	@Autowired
	private MasterManager masterManager;
	
	//Creating object of class StudentScoreDom to calculate student scores
	StudentScoreDom studentScoreDom = null;
	

	@Autowired
	public CandidatePortfolioController(CandidatePortfolioValidator candidatePortfolioDetailsValidator){
		this.candidatePortfolioDetailsValidator = candidatePortfolioDetailsValidator;
	}
	
	// Creating Validator class object
	CandidatePortfolioValidator candidatePortfolioDetailsValidator;
		
	/**
	 * This method is used to load the page with a candidate's portfolio data
	 * @param model
	 * @param request
	 * @return String
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO , method = RequestMethod.GET)
	public String candidatePortfolio(@ModelAttribute("emptyProfile") String emptyProfile,@ModelAttribute("videoVerification") String videoVerification, 
			@ModelAttribute("fileUploadError") String fileUploadError, Model model, HttpServletRequest request )
	{		
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_portfolio");
		
		if(fileUploadError != null && !fileUploadError.isEmpty())
		{
			modelAndView.addObject("fileUploadError",fileUploadError);
		}
		
		if(emptyProfile != null && !emptyProfile.isEmpty())
		{
			modelAndView.addObject("emptyProfile",true);
		}
		
		if(videoVerification != null && !videoVerification.isEmpty())
		{
			modelAndView.addObject("videoVerification",true);
		}
		
		logger.info(CaerusLoggerConstants.VIEW_PROFILE);
		
		HttpSession httpSession = request.getSession();
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName(); //get logged in Email ID
		
	    httpSession.setAttribute("emailId", emailId);
	    
	    // Retrieving candidate details from the database
	    StudentDom studentDom = studentManager.getDetailsByEmailId(emailId);
	    
	    StudentDom student = studentManager.getStudentImage(emailId);
		
	    studentDom.setPhotoName(student.getPhotoName());
	    
	    // Creating a command object
	    StudentCom studentCom = new StudentCom();
	    
	    //Creating Student Score Domain object
	    studentScoreDom = new StudentScoreDom();

		List<String> formulaElementList = getScoreCalculationFormula();
		Double score = null;
		  
						
			//Retrieving Default Profile's About Yourself,Skills and Resume Heading
			if(!(studentDom.getPrimarySkills() == null))
			{
			 StringBuilder sb = new StringBuilder();
		        for(String str : studentDom.getPrimarySkills())
		        {
		            sb.append(str).append(","); //separating contents using semi colon
		        }
		      
		     String strfromArrayList = sb.toString();
			
			studentDom.setPrimarySkills1(strfromArrayList);
			}
			if(!(studentDom.getSecondarySkills() == null)){
			 StringBuilder sb1 = new StringBuilder();
		        for(String str1 : studentDom.getSecondarySkills()){
		            sb1.append(str1).append(","); //separating contents using semi colon
		        }
		      
		    String strfromArrayList1 = sb1.toString();
		    
			studentDom.setSecondarySkills1(strfromArrayList1);
			
			}

			List<Integer> yearList = new ArrayList<Integer>();
			List<Integer> futureYears = new ArrayList<Integer>();
			
			int currentYear = Calendar.getInstance().get(Calendar.YEAR);
			int previousYear = currentYear - 40;
			int nextYear = currentYear;
			
			for(int i = (currentYear); i >= previousYear; i--)
			{
				yearList.add(currentYear);
				futureYears.add(nextYear);
				++ nextYear;
				currentYear--;
			}
			
			/**
			 * Code To calculate Students's IScore when the candidate portfolio is loaded
			 * Added by TrishnaR(28/05/2014)
			 */
			//Setting values to StudentScoreDom object to calculate student's score
			if((studentDom.getG_from_gpa()!=null) && (studentDom.getG_to_gpa()!=null))
			{
				Double universityGPA = CalculateScore.calculateUniversityGPA(studentDom.getG_from_gpa(), studentDom.getG_to_gpa());
				studentScoreDom.setUniversityGPA(universityGPA);
			}
			
			if((studentDom.getH_from_gpa()!=null) && (studentDom.getH_to_gpa()!=null))
			{
				Double highSchoolGPA = CalculateScore.calculateHighSchoolGPA(studentDom.getH_from_gpa(), studentDom.getH_to_gpa());
				studentScoreDom.setHighSchoolGPA(highSchoolGPA);
			}
			
			if((studentDom.getW_startYear_duration()!=null) && (studentDom.getW_endYear_duration()!=null) && 
					(studentDom.getW_startMonth_duration()!=null) && (studentDom.getW_endMonth_duration()!=null)  )
			{
				Double yearsOfExperience = CalculateScore.calculateYearsOfExperience(studentDom.getW_startYear_duration(), studentDom.getW_endYear_duration(), 
																						studentDom.getW_startMonth_duration(), studentDom.getW_endMonth_duration());
			
				studentScoreDom.setYearsOfExperience(yearsOfExperience);
			}
			
			if(studentDom.getDateOfBirth()!=null)
			{
				Integer age = CalculateScore.calculateAge(studentDom.getDateOfBirth());
				studentScoreDom.setAge(age);
			}
			
			//University Rank and Course Rank are hard coded at present which would be replaced by the actual data once the data is gathered
			studentScoreDom.setUniversityRank(5);
			studentScoreDom.setCourseRank(5);
			
			if(studentDom.getG_endYear_duration()!=null)
			{
				studentScoreDom.setGraduationYear(Integer.parseInt(studentDom.getG_endYear_duration()));
			}
			
			formulaElementList = getScoreCalculationFormula();
		
			//Updating student's age in studentScoreDom object
			if(studentScoreDom!=null && formulaElementList!=null)
				score = CalculateScore.calculateIScore(studentScoreDom, formulaElementList);
			
			//Updating student's IScore in database
			if(score != null)
				studentManager.updateStudentIScore(score,emailId);
			/**
			 * Code To calculate Students's IScore Ends
			 */
			
			// Adding values to the Model object
			model.addAttribute("year", yearList);
			model.addAttribute("futureYears", futureYears);
			
			// Retrieving list of states from the database and sorting it alphabetically
			List<String> stateList = masterManager.getStates();
			Collections.sort(stateList);
			
			// Adding values to the Model object
			model.addAttribute("stateList", stateList);
			
			// Retrieving list of course names from the database and sorting it alphabetically
			List<String> courseList = masterManager.getCourses();
			Collections.sort(courseList);
			
			// Adding values to the Model object
			model.addAttribute("courseList", courseList);
			
			// Retrieving list of universities from the database and sorting it alphabetically
			List<String> universityList = masterManager.getUniversities();
			Collections.sort(universityList);
			
			// Retrieving list of course types from the database and sorting it alphabetically
			Set<String> coureTypeList = new TreeSet<String>();
			coureTypeList = masterManager.getCourseTypes();
			// isFirstLogin is set false after fist Login of candidate
			 studentManager.updateIsFirstLogin(emailId);	 
			
			 	Map<String,String> certificationsMap = studentDom.getCertificationsMap();
				List<PortfolioDetailsDom> certificationList = new ArrayList<PortfolioDetailsDom>();
				certificationList = CandidateCommonFeature.getCertificationList(certificationsMap);

				// Sending publications list to the portfolio page
				Map<String,String> publicationsMap = studentDom.getPublicationsMap();
				List<PortfolioDetailsDom> publicationList = new ArrayList<PortfolioDetailsDom>();
				publicationList = CandidateCommonFeature.getPublicationList(publicationsMap);	
				
				Map<String,String> workMap = studentDom.getWorkMap();
				List<PortfolioDetailsDom> workList = new ArrayList<PortfolioDetailsDom>();
				workList = CandidateCommonFeature.getWorkDetails(workMap);	
				 
				 //Sending School Map to portfolio page
				 Map<String,String> schoolMap = studentDom.getSchoolMap();
				 PortfolioDetailsDom portfolioDetails = new PortfolioDetailsDom();
				 portfolioDetails = CandidateCommonFeature.getSchoolDetails(schoolMap);
				 
				 Map<String,String> universityMap = studentDom.getUniversityMap();
				 List<PortfolioDetailsDom> universityList1 = new ArrayList<PortfolioDetailsDom>();
				 universityList1 = CandidateCommonFeature.getUniversityDetails(universityMap);
				 
				 studentDom.setSchoolName(studentDom.getSchoolMap().get("schoolName"));
				 
				 BeanUtils.copyProperties(studentDom, studentCom);
				 
				 PortfolioDetailsCmd portfolioDetailsCmd = new PortfolioDetailsCmd();
				 portfolioDetailsCmd.setSchoolState(studentDom.getSchoolMap().get("schoolState"));
				 portfolioDetailsCmd.setSchoolName(studentDom.getSchoolMap().get("schoolName"));
				 
				 if(studentDom.getSchoolMap().get("schoolGpaTo") != null && !studentDom.getSchoolMap().get("schoolGpaTo").equals("null"))
					 portfolioDetailsCmd.setSchoolGpaTo(Double.parseDouble(studentDom.getSchoolMap().get("schoolGpaTo")));
				 
				 if(studentDom.getSchoolMap().get("schoolGpaFrom") != null && !studentDom.getSchoolMap().get("schoolGpaFrom").equals("null"))
					 portfolioDetailsCmd.setSchoolGpaFrom(Double.parseDouble(studentDom.getSchoolMap().get("schoolGpaFrom")));
				 
				 portfolioDetailsCmd.setSchoolPassingMonth(studentDom.getSchoolMap().get("schoolPassingMonth"));
				 portfolioDetailsCmd.setSchoolPassingYear(studentDom.getSchoolMap().get("schoolPassingYear"));
				 
					// Adding values to the Model object
					 model.addAttribute("universityList", universityList);
					 model.addAttribute("coureTypeList", coureTypeList);
					 model.addAttribute("coureType", studentDom.getCourseType());		
					 model.addAttribute("universityName", studentDom.getUniversityName());
					 model.addAttribute("courseName", studentDom.getCourseName());
					 model.addAttribute("schoolStateName", studentDom.getSchoolMap().get("schoolState"));
					 model.addAttribute("stateName", studentDom.getState());
					 model.addAttribute("photoName", studentDom.getPhotoName());
					 model.addAttribute("resumeName",studentDom.getResumeName());
					 model.addAttribute("videoName",studentDom.getVideoName());
					 model.addAttribute("firstLogin", studentDom.isFirstLogin());
					 model.addAttribute("languageList", studentDom.getLanguagesList());
					 model.addAttribute("addStudent", studentCom);
					 model.addAttribute("certificationList", certificationList);
					 model.addAttribute("publicationList", publicationList);
					 model.addAttribute("workList", workList);
					 model.addAttribute("schoolDetails", portfolioDetails);
					 model.addAttribute("universityList1", universityList1);
					 model.addAttribute("portfolioDetailsCmd",portfolioDetailsCmd);
					
			 // Redirecting to the defined page
			return "candidate/candidate_portfolio";	
	 
	}
	

	/**
	 * This method is used to Upload Profile Photo in Candidate Portfolio
	 * @param studentCom
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_UPLOAD_PHOTO, method = RequestMethod.POST)
	public ModelAndView uploadStudentProfilePhoto(@ModelAttribute("addStudent") StudentCom studentCom, BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest)
	{
		// Creating a domain object 
		StudentDom studentDom = new StudentDom();
		 
		// Getting the current page url
		String url = httpServletRequest.getHeader("referer");
		
		String newstr = null;
	       
		   // Splitting the string at the last occurence of '/'
		    if (url.lastIndexOf("/") != -1)  
		    {
		        newstr = url.substring(url.lastIndexOf("/") + 1, url.length()); // check if(endIndex != -1)
		    }
		 
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName(); //get logged in Email ID
	    
	    // Photo Upload Changes
	    CommonsMultipartFile multipartFilePhoto = studentCom.getFilePhoto();
	    String filePhoto = "";

		if (multipartFilePhoto != null) {

			filePhoto = multipartFilePhoto.getOriginalFilename(); // getting the filename
			String extension =  CaerusCommonUtil.getFileExtension(filePhoto);
			
			if((extension != null) && (extension.equals("jpg") || extension.equals("bmp") || extension.equals("png") || extension.equals("jpeg")))
			{
				if (multipartFilePhoto.getSize() > 0) {
					BeanUtils.copyProperties(studentCom, studentDom);
					studentDom.setEmailID(emailId);
					
					// Update the database 
					studentManager.uploadPhoto(studentDom);
					logger.info(CaerusLoggerConstants.UPLOAD_PHOTO);
				}
			}
		}
		
		// Fetching the device type(mobile,tablet,web)
		Device currentDevice = DeviceUtils.getCurrentDevice(httpServletRequest);
		
		// check If the device is not a mobile or tablet device
		if(currentDevice.isNormal() && newstr.equals("candidate_portfolio.htm"))
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
		}
		
		// check If the device is not a mobile or tablet device
		if(currentDevice.isNormal() && newstr.equals("candidate_wizard.htm"))
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_wizard.htm"));
		}
		
		// check If the device is a mobile or tablet device
		else
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_detail_view.htm"));
		}
	}
	
	
	/**
	 * This method is used to Edit Introductory section in Candidate Portfolio
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_INTRODUCTORY, method = RequestMethod.POST)
	public ModelAndView getPortfolioIntroductoryDetails(@ModelAttribute("addStudent") StudentCom addStudent, BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest)
	{
		
		logger.info(CaerusLoggerConstants.UPDATE_PROFILE_INTRODUCTORY);
		
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_dashboard");
	 
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName(); // get logged in Email ID
		
		// Fetching the device type(mobile,tablet,web)
		Device device=DeviceUtils.getCurrentDevice(httpServletRequest);
		
		// Creating a domain object 
		StudentDom studentDom = new StudentDom();
		
		Integer age = null;
		Double score = null;
		
		List<String> formulaElementList = null;

		// check If the device is not a mobile or tablet device 
		if(device.isNormal())
		{	
			// Setting values  from business objects(command) to value object(domain)
			studentDom.setFirstName(addStudent.getFirstName());
			studentDom.setLastName(addStudent.getLastName());
			studentDom.setEmailID(addStudent.getEmailID());
			studentDom.setMobileNumber(addStudent.getMobileNumber());
			studentDom.setAddress(addStudent.getAddress());
			studentDom.setZipCode(addStudent.getZipCode());
			//studentDom.setDateOfBirth(addStudent.getDateOfBirth());
			
			Date date = CaerusCommonUtility.stringToDate(addStudent.getDateOfBirth(), "yyyy-MM-dd");
			studentDom.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").format(date));
			
			studentDom.setGender(addStudent.getGender());
			studentDom.setLanguage(addStudent.getLanguage());
			studentDom.setLanguagesList(addStudent.getLanguagesList());
			studentDom.setInterestList(addStudent.getInterestList());
			
			String cityName = masterManager.getCity(addStudent.getZipCode());
			String stateName = masterManager.getState(addStudent.getZipCode());
			
			if(cityName!=null && cityName.length()>0 && stateName!=null && stateName.length()>0)
			{
				studentDom.setCity(cityName);
				studentDom.setState(stateName);
			}
		
			/*else
			{
				
				 String zipCodeErrorMessage="Please Enter Valid Zip Code";
				 modelAndView= new ModelAndView("candidate/candidate_portfolio");
				 modelAndView.addObject("zipCodeErrorMessage",zipCodeErrorMessage);
				 return modelAndView;
			}*/
			
			// Update the database with edited fields 
			studentManager.addStudentIntroductory(studentDom);
			
			
			// Redirecting to defined view 
			
			modelAndView = new ModelAndView(new RedirectView("candidate_portfolio.htm"));
			//return new ModelAndView(new RedirectView("candidate_portfolio.htm"));

		}
		
		// check If the device is a mobile or tablet device 
		else
		{
			// Setting values  from business objects(command) to value object(domain)
			studentDom.setEmailID(emailId);
			studentDom.setFirstName(addStudent.getFirstName());
			studentDom.setLastName(addStudent.getLastName());
			studentDom.setAddress(addStudent.getAddress());
			studentDom.setZipCode(addStudent.getZipCode());
			studentDom.setMobileNumber(addStudent.getMobileNumber());
			studentDom.setGender(addStudent.getGender());
			studentDom.setDateOfBirth(addStudent.getDateOfBirth());
			
			String cityName=masterManager.getCity(addStudent.getZipCode());
			String stateName=masterManager.getState(addStudent.getZipCode());
			
			if(cityName.length()>0&&stateName.length()>0)
			{
				studentDom.setCity(cityName);
				studentDom.setState(stateName);
			}
		
			else{
				 String zipCodeErrorMessage="Please Enter Valid Zip Code";
				 modelAndView= new ModelAndView("candidate/candidate_detail_view");
				 modelAndView.addObject("zipCodeErrorMessage",zipCodeErrorMessage);
				 return modelAndView;
				 
			}
			
			// Update the database with edited fields 
			studentManager.addStudentIntroductory(studentDom);
			modelAndView = new ModelAndView(new RedirectView("candidate_detail_view.htm"));
		}
		
		if(studentDom.getDateOfBirth()!=null)
		{
			formulaElementList = getScoreCalculationFormula();
			age = CalculateScore.calculateAge(studentDom.getDateOfBirth());
			studentScoreDom.setAge(age);
			
			//Updating student's age in studentScoreDom object
			if(studentScoreDom!=null && formulaElementList!=null)
				score = CalculateScore.calculateIScore(studentScoreDom, formulaElementList);
			
			//Updating student's IScore in database
			if(score!=null)
				studentManager.updateStudentIScore(score,emailId);
		}
		
		return modelAndView;	
	}

	/**
	 * This method is used to Edit Education section in Candidate Portfolio
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_EDUCATION, method = RequestMethod.POST)
	public ModelAndView getPortfolioEducationDetails(@ModelAttribute("addStudent") StudentCom addStudent, BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest)
	{
		logger.info(CaerusLoggerConstants.UPDATE_PROFILE_EDUCATION);
		
		ModelAndView modelAndView = new ModelAndView();
		
		//Spring security authentication containing the logged in user details
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	     String emailId = auth.getName(); //get logged in Email ID

	     	//Fetching the device type(mobile,tablet,web)
	     	Device device=DeviceUtils.getCurrentDevice(httpServletRequest);
	     
	     	// Creating a domain object
	        StudentDom dstudent = new StudentDom();
	        Double universityGPA = 0.0;
	        Double highSchoolGPA = 0.0;
	        Double score = null;
			
	        // check If the device is not a mobile or tablet device 
			if(device.isNormal()){
				
			// Setting values  from business objects(command) to value object(domain)	
			dstudent.setCourseType(addStudent.getCourseType());
			dstudent.setCourseName(addStudent.getCourseName());
			dstudent.setUniversityName(addStudent.getUniversityName());
			dstudent.setG_from_gpa(addStudent.getG_from_gpa());
			dstudent.setG_to_gpa(addStudent.getG_to_gpa());
			dstudent.setG_startMonth_duration(addStudent.getG_startMonth_duration());
			dstudent.setG_startYear_duration(addStudent.getG_startYear_duration());
			dstudent.setG_endMonth_duration(addStudent.getG_endMonth_duration());
			dstudent.setG_endYear_duration(addStudent.getG_endYear_duration());
			
			dstudent.setSchoolName(addStudent.getSchoolName());
			dstudent.setSchoolState(addStudent.getSchoolState());
			dstudent.setH_from_gpa(addStudent.getH_from_gpa());
			dstudent.setH_to_gpa(addStudent.getH_to_gpa());
			dstudent.setH_startMonth_duration(addStudent.getH_startMonth_duration());
			dstudent.setH_startYear_duration(addStudent.getH_startYear_duration());
			dstudent.setH_endMonth_duration(addStudent.getH_endMonth_duration());
			dstudent.setH_endYear_duration(addStudent.getH_endYear_duration());
			dstudent.setEmailID(emailId);
		

			// Update the database with edited fields 
		  	studentManager.addStudentEducation(dstudent);
		
		  		// Redirecting to defined view
			  	//return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
				modelAndView = new ModelAndView(new RedirectView("candidate_portfolio.htm")); 
			}
			
			// check If the device is a mobile or tablet device
			else
			{
				// Setting values  from business objects(command) to value object(domain)
				dstudent.setCourseType(addStudent.getCourseType());
				dstudent.setCourseName(addStudent.getCourseName());
				dstudent.setUniversityName(addStudent.getUniversityName());
				dstudent.setG_startMonth_duration(addStudent.getG_startMonth_duration());
				dstudent.setG_startYear_duration(addStudent.getG_startYear_duration());
				dstudent.setG_endMonth_duration(addStudent.getG_endMonth_duration());
				dstudent.setG_endYear_duration(addStudent.getG_endYear_duration());
				dstudent.setG_from_gpa(addStudent.getG_from_gpa());
				dstudent.setG_to_gpa(addStudent.getG_to_gpa());
				dstudent.setEmailID(emailId);
				
				dstudent.setSchoolName(addStudent.getSchoolName());
				dstudent.setSchoolState(addStudent.getSchoolState());
				dstudent.setH_from_gpa(addStudent.getH_from_gpa());
				dstudent.setH_to_gpa(addStudent.getH_to_gpa());
				dstudent.setH_startMonth_duration(addStudent.getH_startMonth_duration());
				dstudent.setH_startYear_duration(addStudent.getH_startYear_duration());
				dstudent.setH_endMonth_duration(addStudent.getH_endMonth_duration());
				dstudent.setH_endYear_duration(addStudent.getH_endYear_duration());
		
				// Update the database with edited fields 
				studentManager.addStudentEducation(dstudent);
				
				// Redirecting to defined view
				modelAndView = new ModelAndView(new RedirectView("candidate_detail_view.htm"));
				
			}
			
			List<String> formulaElementList = getScoreCalculationFormula();
			
			if((dstudent.getG_from_gpa()!=null) && (dstudent.getG_to_gpa()!=null))
			{
				universityGPA = CalculateScore.calculateUniversityGPA(dstudent.getG_from_gpa(), dstudent.getG_to_gpa());
				studentScoreDom.setUniversityGPA(universityGPA);
			}
			
			if((dstudent.getH_from_gpa()!=null) && (dstudent.getH_to_gpa()!=null))
			{
				highSchoolGPA = CalculateScore.calculateHighSchoolGPA(dstudent.getH_from_gpa(), dstudent.getH_to_gpa());
				studentScoreDom.setHighSchoolGPA(highSchoolGPA);
			}
			
			//Updating student's education details in studentScoreDom object
			
			if(dstudent.getG_endYear_duration()!=null)
				studentScoreDom.setGraduationYear(Integer.parseInt(dstudent.getG_endYear_duration()));
			
			if(studentScoreDom!=null && formulaElementList!=null)
				score = CalculateScore.calculateIScore(studentScoreDom, formulaElementList);
			
			//Updating student's IScore in database
			if(score!=null)
				studentManager.updateStudentIScore(score,emailId);
			
			return modelAndView;
		
	}
	
	/**
	 * This method is used to Edit Resume section in Candidate Portfolio
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_PROFILE, method = RequestMethod.POST)
	public ModelAndView getPortfolioSkillDetails(@ModelAttribute("addStudent") StudentCom addStudent, BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest)
	{
		logger.info(CaerusLoggerConstants.UPDATE_PROFILE_RESUME);
		 
		 // Fetching the device type(mobile,tablet,web)
		 Device device=DeviceUtils.getCurrentDevice(httpServletRequest);
		
		 // Spring security authentication containing the logged in user details
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 String emailId = auth.getName(); //get logged in Email ID

		 // Creating a domain object 
		 StudentDom newProfile = new StudentDom();	
			
			// Setting values to Student object
			newProfile.setEmailID(emailId);
			newProfile.setProfileName(addStudent.getProfileName());
			newProfile.setResumeText(addStudent.getResumeText());
			newProfile.setDefault(true);
			newProfile.setPrimarySkills1(addStudent.getPrimarySkills1());
			newProfile.setSecondarySkills1(addStudent.getSecondarySkills1());
			newProfile.setAboutYourSelf(addStudent.getAboutYourSelf());
		
		    /** Candidate Dashboard Data */
			if(addStudent.getHiddenValue()!=null)
			{
				newProfile.setDefault(false);
				// Update the database with edited fields
	       		studentManager.addStudentResumeSkills(newProfile);
				return new ModelAndView(new RedirectView("candidate_dashboard.htm"));
				
			}
			
			else
			{
				// check If the device is not a mobile or tablet device 
				if(device.isNormal())
				{
					newProfile.setAboutYourSelf(addStudent.getAboutYourSelf());
					// Update the database with edited fields
		       		studentManager.addStudentResumeSkills(newProfile);
		       		
		       		// Redirecting to defined view
		       		return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
				}
				
				// check If the device is not a mobile or tablet device
				else
				{
					// Update the database with edited fields 
					studentManager.addStudentResumeSkills(newProfile);
					
					return null;
	
				}
			}
	}
	
	/**
	 * This method is used to Upload Resume in Candidate Portfolio
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_UPLOAD_RESUME, method = RequestMethod.POST)
	public ModelAndView uploadStudentResume(@ModelAttribute("addStudent") StudentCom addStudent,  BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest)
	{		
		// Creating a domain object 
		StudentDom dStudent = new StudentDom();
		
		// Getting the current page url
		String url = httpServletRequest.getHeader("referer");
		
		String newstr = null;
	       
	    // Splitting the string at the last occurence of '/'
	    if (url.lastIndexOf("/") != -1)  
	    {
	        newstr = url.substring(url.lastIndexOf("/") + 1, url.length()); // not forgot to put check if(endIndex != -1)
	    }

		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();
	    
	    // Fetching the device type(mobile,tablet,web)
	    Device device=DeviceUtils.getCurrentDevice(httpServletRequest);
	    
	    String profileName = addStudent.getProfileName();
	    
	    // File Upload changes
	    CommonsMultipartFile multipartFileResume = addStudent.getFileResume();
	    String fileResume = "";

		if (multipartFileResume != null)
		{
			fileResume = multipartFileResume.getOriginalFilename();
			InputStream inputStreamResume = null;
			
			if(!(fileResume == null || fileResume.isEmpty()))
			{
				String extension =  CaerusCommonUtil.getFileExtension(fileResume);
				
				if(extension.equals("pdf") || extension.equals("txt") || extension.equals("doc") || extension.equals("docx"))
				{	
				// Exception handling
					try 
					{
							if (multipartFileResume.getSize() > 0) 
							{
								inputStreamResume = multipartFileResume.getInputStream();
		
								dStudent.setEmailID(emailId); 
								dStudent.setResumeName(fileResume); 
								//dStudent.setInputStreamResume(multipartFileResume.getInputStream()); 
								dStudent.setFileData(multipartFileResume.getBytes());
								dStudent.setProfileName(profileName);
								
								// Update the database
								studentManager.uploadResume(dStudent);
		
								inputStreamResume.close();
		
							}
		
					} 
					catch (IOException e) 
					{
						e.printStackTrace();
		
					}
				}
		}
		}

		logger.info(CaerusLoggerConstants.UPLOAD_RESUME);
		// check If the device is not a mobile or tablet device
		if(device.isNormal() && newstr.equals("candidate_portfolio.htm"))
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
		}
		
		// check If the device is not a mobile or tablet device
		if(device.isNormal() && newstr.equals("candidate_wizard.htm"))
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_wizard.htm"));
		}
		
		// check If the device is a mobile or tablet device
		else
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_detail_view.htm"));
		}
	}
	
	/**
	 * This method is used to Upload Video in Candidate Portfolio
	 * @param addStudent
	 * @param bindingResult
	 * @param model
	 * @param httpServletRequest
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_UPLOAD_VIDEO, method = RequestMethod.POST)
	public ModelAndView uploadStudentVideoResume(@ModelAttribute("addStudent") StudentCom addStudent, BindingResult bindingResult, Model model , HttpServletRequest httpServletRequest, RedirectAttributes redirectAttributes) 
	throws MaxUploadSizeExceededException
	{
		// Creating a domain object 
		StudentDom dStudent = new StudentDom();
		
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName(); //get logged in Email ID
	    
	    ModelAndView modelAndView = new ModelAndView();
	  
	    // Video Upload changes
	    CommonsMultipartFile multipartFileVideo = addStudent.getFileVideo();
	
	    String fileVideo = "";

		if (multipartFileVideo != null)
		{
			fileVideo = multipartFileVideo.getOriginalFilename(); // getting the filename
			InputStream inputStreamVideo = null;
			
			if(fileVideo.length() > 0)
			{
				String extension = CaerusCommonUtil.getFileExtension(fileVideo);
			
				if(extension.equals("mp4"))
				{
				
				// Exception handling
					try
					{
		
							if (multipartFileVideo.getSize() > 0)
							{
								if(multipartFileVideo.getSize() > 26214400)
								{
									bindingResult.rejectValue("fileVideo", "", "Please upload a file less than 25MB in size");
								}
								
								if(bindingResult.hasErrors())
								{
									redirectAttributes.addFlashAttribute("fileUploadError", "Please upload a file less than 25MB in size");
									return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
								}
								
								inputStreamVideo = multipartFileVideo.getInputStream();
		
								dStudent.setEmailID(emailId); // setting the emailId value to Student Domain
								dStudent.setVideoName(fileVideo); // setting the filename value to Student Domain
								//dStudent.setInputStreamVideo(inputStreamVideo); // setting the inputStream value to Student Domain
								dStudent.setFileData(multipartFileVideo.getBytes());// Setting the video data
								
								// Update the database
								studentManager.uploadVideo(dStudent);
		
								inputStreamVideo.close();
		
								logger.info(CaerusLoggerConstants.UPLOAD_VIDEO);
							}
		
					}
					catch (IOException e)
					{
						e.printStackTrace();
		
					}
				
				}
				else
				{
					redirectAttributes.addFlashAttribute("fileUploadError", "Please upload mp4 file");
					return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
				}
			}
			else
			{
				modelAndView.addObject("errorVideo","Please select a File");
			}
		}
		// Fetching the device type(mobile,tablet,web)
		Device device=DeviceUtils.getCurrentDevice(httpServletRequest);
		
		// check If the device is not a mobile or tablet device
		if(device.isNormal())
		{
			// Redirecting to defined view
			redirectAttributes.addFlashAttribute("videoVerification", "true");
			return new ModelAndView(new RedirectView("candidate_portfolio.htm"));
		}
		// check If the device is a mobile or tablet device
		else
		{
			// Redirecting to defined view
			return new ModelAndView(new RedirectView("candidate_detail_view.htm"));
		}
		
		
	}
	
	
	/**
	 * This method is used to edit candidate's certifications' details
	 * @param portfolioDetailsCmd
	 * @param bindingResult
	 * @param model
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_CERTIFICATION_DETAILS, method = RequestMethod.POST)
	@ResponseBody
	public List<String> getCertificationDetails(@ModelAttribute("portfolioDetailsCmd") PortfolioDetailsCmd portfolioDetailsCmd, BindingResult bindingResult, SessionStatus status, Model model)
	{
			// Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String studentEmailId = auth.getName(); //get logged in Email ID
			 
		    // Retrieving candidate details from the database
		    StudentDom student= studentManager.getDetailsByEmailId(studentEmailId);
		    
		    List<String> erroneousFields = new ArrayList<String>();
		    
		    // call the validation function
		    candidatePortfolioDetailsValidator.validateCertification(portfolioDetailsCmd, bindingResult);
		    
		    // check if there are any errors
		    if (bindingResult.hasErrors()) {
		    
		    	for (FieldError errorValue : bindingResult.getFieldErrors()) {
					erroneousFields.add(errorValue.getField());
				}
		    	
		    	return erroneousFields;
			} 
		    
		    else
		    {
			    // Creating a domain object 
			    PortfolioDetailsDom portfolioDetailsDom = new PortfolioDetailsDom();
			    
			    // Creating a list of type PortfolioDetailsDom
			    List<PortfolioDetailsDom> certificationList = new ArrayList<PortfolioDetailsDom>();
				 
			    // Setting values  from business objects(command) to value object(domain)
			    portfolioDetailsDom.setCertificateName(portfolioDetailsCmd.getCertificateName());
			    portfolioDetailsDom.setCertificateNumber(portfolioDetailsCmd.getCertificateNumber());
			    portfolioDetailsDom.setCertificateAuthority(portfolioDetailsCmd.getCertificateAuthority());
			    portfolioDetailsDom.setCertificationStartMonth(portfolioDetailsCmd.getCertificationStartMonth());
			    portfolioDetailsDom.setCertificationEndMonth(portfolioDetailsCmd.getCertificationEndMonth());
			    portfolioDetailsDom.setCertificationStartYear(portfolioDetailsCmd.getCertificationStartYear());
			    portfolioDetailsDom.setCertificationEndYear(portfolioDetailsCmd.getCertificationEndYear());
			    
			   certificationList.add(portfolioDetailsDom);
			    
			    Map<String,String> certificationsMap = student.getCertificationsMap();
	
				int i = 0;
			    if(certificationsMap != null && !certificationsMap.isEmpty())
				{
					certificationsMap = CaerusCommonUtil.sortMapObject(certificationsMap);
					
					Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(certificationsMap);
					
					String[] lastEntry = entry.getKey().split("_");
					String index = lastEntry[0];
					i = Integer.parseInt(index);	
				
				}
		
	
			    // Updating the database with the details filled in by the candidate
				studentManager.addCertificationDetails(studentEmailId,certificationList,i);
			
				return erroneousFields;
				
		    }
	}
	
	/**
	 * This method is used to edit candidate's publications' details
	 * @param portfolioDetailsCmd
	 * @param bindingResult
	 * @param model
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PUBLICATION_DETAILS, method = RequestMethod.POST)
	@ResponseBody
	public List<String> getPublicationDetails(@ModelAttribute("portfolioDetailsCmd") PortfolioDetailsCmd portfolioDetailsCmd, BindingResult bindingResult, SessionStatus status, Model model)
	{
			// Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String studentEmailId = auth.getName(); //get logged in Email ID
		    
		    // Retrieving student details from the database
		    StudentDom student= studentManager.getDetailsByEmailId(studentEmailId);
		    
		    List<String> erroneousFields = new ArrayList<String>();
		    
		    
		    // call the validation function
		    candidatePortfolioDetailsValidator.validatePublication(portfolioDetailsCmd, bindingResult);
		    
		    // check if there are any errors
		    if (bindingResult.hasErrors()) {
		    
		    	for (FieldError errorValue : bindingResult.getFieldErrors()) {
					erroneousFields.add(errorValue.getField());
				}
		    	
		    	return erroneousFields;
		    	 
			}
		    
		    else
		    {
			    // Creating a domain object 
			    PortfolioDetailsDom portfolioDetailsDom = new PortfolioDetailsDom();
				 
			    // Creating a list of type PortfolioDetailsDom
			    List<PortfolioDetailsDom> publicationList = new ArrayList<PortfolioDetailsDom>();
			    
			    // Setting values  from business objects(command) to value object(domain)
				portfolioDetailsDom.setPublicationTitle(portfolioDetailsCmd.getPublicationTitle());
			    portfolioDetailsDom.setPublicationSummary(portfolioDetailsCmd.getPublicationSummary());
			    portfolioDetailsDom.setPublicationUrl(portfolioDetailsCmd.getPublicationUrl());
			    portfolioDetailsDom.setPublisherName(portfolioDetailsCmd.getPublisherName());
			    portfolioDetailsDom.setPublisherAuthorFirstName(portfolioDetailsCmd.getPublisherAuthorFirstName());
			    portfolioDetailsDom.setPublisherAuthorLastName(portfolioDetailsCmd.getPublisherAuthorLastName());
			    portfolioDetailsDom.setPublicationDate(portfolioDetailsCmd.getPublicationDate());
			    
			    publicationList.add(portfolioDetailsDom);
			    
			    Map<String,String> publicationsMap = student.getPublicationsMap();
			    
			    int i = 0;
				if(publicationsMap != null && !publicationsMap.isEmpty())
				{
					publicationsMap = CaerusCommonUtil.sortMapObject(publicationsMap);
					
					Entry<String, String> entry1 = CaerusCommonUtility.getLastMapEntry(publicationsMap);
					
					String[] lastEntry1 = entry1.getKey().split("_");
					String index1 = lastEntry1[0];
					i = Integer.parseInt(index1);
				}
			    
				// Updating the database with the details filled in by the candidate
				studentManager.addPublicationDetails(studentEmailId,publicationList,i);
			
		    	return erroneousFields;
		    }
	}
	
	/**
	 * This method is used to fetch the candidate scoring formula list
	 * @author TrishnaR
	 * @return List<String>(formulaElementList)
	 */
	private List<String> getScoreCalculationFormula() 
	{
		String formulaName = CaerusStringConstants.DEFAULT_FORMULA_NAME;
		String adminId = CaerusStringConstants.ADMIN_EMAIL_ID;
		EmployerQueryBuilderDom employerQueryBuilderDom = studentManager.findFormula(formulaName,adminId);
		List<String> formulaElementList = employerQueryBuilderDom.getFormulaList();
		return formulaElementList;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CAPTURE_IMAGE,method = RequestMethod.POST)
	public void captureImage(@RequestParam ("data") String data,RedirectAttributes redirectAttributes,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException 
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();

		StudentDom student = new StudentDom();
		student.setEmailID(studentEmailId);
		
		String extention = data.substring(data.indexOf("/")+1,data.indexOf(";"));
		
		String photoName = "ProfilePhoto."+extention;
		
		//Extracting the encoded image
		String imageDataBytes = data.substring(data.indexOf(",")+1);
		
        BASE64Decoder decoder = new BASE64Decoder();
        byte[] decodedBytes = decoder.decodeBuffer(imageDataBytes);
           
        student.setPhotoData(decodedBytes);
        student.setPhotoName(photoName);
		
		// Update the database 
		studentManager.uploadPhoto(student);
	}
	

	/**
	 *This method is used to Edit Work section in Candidate Portfolio
	 * @param portfolioDetailsCmd
	 * @param bindingResult
	 * @param status
	 * @param model
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_WORK, method = RequestMethod.POST)
	@ResponseBody
	public List<String> getPortfolioWorkDetails(@ModelAttribute("portfolioDetailsCmd") PortfolioDetailsCmd portfolioDetailsCmd, BindingResult bindingResult, SessionStatus status, Model model)
	{
			// Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		    String studentEmailId = auth.getName(); //get logged in Email ID
			 
		    // Retrieving candidate details from the database
		    StudentDom student= studentManager.getDetailsByEmailId(studentEmailId);
		    
		    List<String> erroneousFields = new ArrayList<String>();
		    
		    // call the validation function
		     candidatePortfolioDetailsValidator.validateWork(portfolioDetailsCmd, bindingResult);
		    
		    // check if there are any errors
		    if (bindingResult.hasErrors()) {
		    
		    	for (FieldError errorValue : bindingResult.getFieldErrors()) {
					erroneousFields.add(errorValue.getField());
				}
		    	
		    	return erroneousFields;
			} 
		    
		    else
		    {
			    // Creating a domain object 
			    PortfolioDetailsDom portfolioDetailsDom = new PortfolioDetailsDom();
			    
			    // Creating a list of type PortfolioDetailsDom
			    List<PortfolioDetailsDom> workList = new ArrayList<PortfolioDetailsDom>();
				 
			    // Setting values  from business objects(command) to value object(domain)
			    BeanUtils.copyProperties(portfolioDetailsCmd, portfolioDetailsDom);
			    workList.add(portfolioDetailsDom);
			    
			    Map<String,String> workMap = student.getWorkMap();
	
				int i = 0;
			    if(workMap != null && !workMap.isEmpty())
				{
			    	workMap = CaerusCommonUtil.sortMapObject(workMap);
					
					Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(workMap);
					
					String[] lastEntry = entry.getKey().split("_");
					String index = lastEntry[0];
					i = Integer.parseInt(index);	
				
				}
		
	
			    // Updating the database with the details filled in by the candidate
				studentManager.addWorkDetails(studentEmailId,workList,i);
			
				return erroneousFields;
				
		    }
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_SCHOOL, method = RequestMethod.POST)
	@ResponseBody
	public List<String> getPortfolioSchoolDetails(@ModelAttribute("portfolioDetailsCmd") PortfolioDetailsCmd portfolioDetailsCmd, BindingResult bindingResult, SessionStatus status, Model model) throws IllegalAccessException, InvocationTargetException
	{
			// Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		    String studentEmailId = auth.getName(); //get logged in Email ID
			 
		    // Retrieving candidate details from the database
		    
		    //Map<String, String> erroneousFields = new HashMap<String, String>();
		   List<String> erroneousFields = new ArrayList<String>();
		    // call the validation function
		   try {
			candidatePortfolioDetailsValidator.validateSchool(portfolioDetailsCmd, bindingResult);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		    
			    
		  if (bindingResult.hasErrors()) {
			    	for (FieldError errorValue : bindingResult.getFieldErrors()) {
						erroneousFields.add(errorValue.getDefaultMessage());
					}
			    	return erroneousFields;
				}
		    else
		    {
			    // Creating a domain object 
			    PortfolioDetailsDom portfolioDetailsDom = new PortfolioDetailsDom();
			    
			   // Setting values  from business objects(command) to value object(domain)
			   BeanUtils.copyProperties(portfolioDetailsCmd, portfolioDetailsDom);
			   
	
			   	// Updating the database with the details filled in by the candidate
				studentManager.addSchoolDetails(studentEmailId,portfolioDetailsDom);
			
				return erroneousFields;
				
		    }
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_PORTFOLIO_UNIVERSITY, method = RequestMethod.POST)
	@ResponseBody
	public List<String> getPortfolioUniversityDetails(@ModelAttribute("portfolioDetailsCmd") PortfolioDetailsCmd portfolioDetailsCmd, BindingResult bindingResult, SessionStatus status, Model model)
	{
			// Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		    String studentEmailId = auth.getName(); //get logged in Email ID
			 
		    // Retrieving candidate details from the database
		    StudentDom student= studentManager.getDetailsByEmailId(studentEmailId);
		    
		    //Map<String, String> erroneousFields = new HashMap<String, String>();
		   List<String> erroneousFields = new ArrayList<String>();
		    
		   // call the validation function
		   candidatePortfolioDetailsValidator.validateUniversity(portfolioDetailsCmd, bindingResult);
		    
			    
		  if (bindingResult.hasErrors()) {
				    
			    	for (FieldError errorValue : bindingResult.getFieldErrors()) {
						erroneousFields.add(errorValue.getDefaultMessage());
					}
			    	
			    	return erroneousFields;
				}
		    else
		    {
			    // Creating a domain object 
			    PortfolioDetailsDom portfolioDetailsDom = new PortfolioDetailsDom();
			   
			    // Creating a list of type PortfolioDetailsDom
			    List<PortfolioDetailsDom> universityList = new ArrayList<PortfolioDetailsDom>();
			    
			   // Setting values  from business objects(command) to value object(domain)
			  portfolioDetailsDom.setUniversityCourseName(portfolioDetailsCmd.getUniversityCourseName());
			  portfolioDetailsDom.setUniversityCourseType(portfolioDetailsCmd.getUniversityCourseType());
			  portfolioDetailsDom.setUniversityGpaFrom(portfolioDetailsCmd.getUniversityGpaFrom());
			  portfolioDetailsDom.setUniversityGpaTo(portfolioDetailsCmd.getUniversityGpaTo());
			  portfolioDetailsDom.setUniversityMonthFrom(portfolioDetailsCmd.getUniversityMonthFrom());
			  portfolioDetailsDom.setUniversityMonthTo(portfolioDetailsCmd.getUniversityMonthTo());
			  portfolioDetailsDom.setUniversityName(portfolioDetailsCmd.getUniversityName());
			  portfolioDetailsDom.setUniversityYearFrom(portfolioDetailsCmd.getUniversityYearFrom());
			  portfolioDetailsDom.setUniversityYearTo(portfolioDetailsCmd.getUniversityYearTo());
			  
			  
			  universityList.add(portfolioDetailsDom);
			    
			    Map<String,String> universityMap = student.getUniversityMap();
	
				int i = 0;
			    if(universityMap != null && !universityMap.isEmpty())
				{
			    	universityMap = CaerusCommonUtil.sortMapObject(universityMap);
					
					Entry<String, String> entry = CaerusCommonUtility.getLastMapEntry(universityMap);
					
					String[] lastEntry = entry.getKey().split("_");
					String index = lastEntry[0];
					i = Integer.parseInt(index);	
				
				}
			    // Updating the database with the details filled in by the candidate
			  studentManager.addUniversityDetails(studentEmailId,universityList, i);
			
				return erroneousFields;
				
		    }
	}

	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_SUGGEST_SKILLS_JSON)
	@ResponseBody
	private List<String> getSuggestedSkills(@RequestParam("skill") String skill){
		 List<String> suggestions = new ArrayList<String>();
		 
		 try {
			 //Fetching keyword suggestions for the entered text by User
			 List<LookupResult>suggestedWords = AutoSuggest.suggestSkills(skill,false);
			 
			 String word = "";
			 //List of LookUpResult to List of String Conversion
			 if(null != suggestedWords && suggestedWords.size()!=0)
			 {
				 for(int i = 0; i<suggestedWords.size();i++)
				 {
					 word = suggestedWords.get(i).key.toString();
					 //Removing Unwanted Character Sequence Returned by Lucene (Highlighted Text)
					 word = word.replaceAll("<b>", "");
					 word = word.replaceAll("</b>", "");
					 suggestions.add(word);
				 }
			 }
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
	  return null == suggestions ? new ArrayList<String>() : suggestions;
	}
	
	
}