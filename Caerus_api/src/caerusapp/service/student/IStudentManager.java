package caerusapp.service.student;

import java.io.File;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentRecommendationDom;
import caerusapp.exceptions.CaerusCommonException;

public interface IStudentManager extends Serializable {

	/**
	 * This method is used when a candidate registers to the application 
	 * @param student
	 */
	public void candidateRegistration(StudentDom student); 
	
	
	/**
	 * This method is used to check whether a student with an emailId:student.getEmailID() already exists
	 * @author KarthikeyanK
	 * @param emailId
	 * @return int (userCount)
	 * @throws CaerusCommonException
	 */
	public int getStudentByEmailId(String emailId)
			throws CaerusCommonException;

	 /**
     * This method is used by a candidate to add his/her profile details
     * @param profile
     * @param emailId
     *//*
	public void studentProfile(StudentDom profile, String emailId);


	*/
	
	/**
	 * @author Kshailesh
	 * @param emailId
	 * @desc this method is used to fetch the candidate details
	 */
	public StudentDom getDetailsByEmailId(String emailId);
	
	
	/**
	 * @author Kshailesh
	 * @param emailId
	 * @desc this method is used to fetch the candidate's default profile's details
	 * @return student (studentProfile)
	 *//*
	public StudentDom getProfileDetailsByDefault(String emailId);

	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of states from master table.
	 * @return List of states
	 *//*
	public List<String> getStateList();
	
	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of courses from master table.
	 * @return List of courses
	 *//*
	public List<String> getCourseList();
	
	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of universities from master table.
	 * @return List of universities
	 *//*
	public List<String> getUniversityList();
	
	public StudentDom studentDefaultProfileByEmailId(String eId);

	*//**
	 * This method is used to get details of the selected profile
	 * @param emailId
	 * @param selectedProfile
	 * @return student(studentProfile)
	 *//*
	public StudentDom getProfileDetailsByProfileName(String emailId,
			String selectedProfile);

	*/
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Introductory for Portfolio.
	 */
	
	public void addStudentIntroductory(StudentDom student);
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Education for Portfolio.
	 */
	
	public void addStudentEducation(StudentDom student);
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Works for Portfolio.
	 */
	
	public void addStudentWork(StudentDom student);
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Resume Skills and Other for Portfolio.
	 */
	
	public void addStudentResumeSkills(StudentDom student);
	
	/**
	 * This method is used to upload profile photo by student
	 * @author Kshailesh
	 * @param student
	 */
	public void uploadPhoto(StudentDom student);

	/**
	 * This method is used to upload resume by student
	 * @author Kshailesh
	 * @param student
	 */
	public void uploadResume(StudentDom student);
	
	/**
	 * This method is used to upload video resume by student
	 * @author Kshailesh
	 * @param student
	 */
	public void uploadVideo(StudentDom student);


	/**
	 * This method is used to activate(enable) a user's account for the application
	 * @author KarthikeyanK
	 * @param userName
	 *//*
	public void updateEnabledStatusByUsername(String userName);

	*//**
	 * This method is used to check whether a user's account is active or not
	 * @author KarthikeyanK
	 * @param userName
	 * @return String(enabledStatus)
	 *//*
	public String getEnabledStatusByUsername(String userName);

	*//**
	 * This method is used to set a candidate's profile to default  
	 * @param addStudent
	 * @param emailID
	 *//*
	void updateStudentDefaultProfile(String emailID, StudentDom addStudent);

	*//**
	 * This method is used by the candidate to add a new profile
	 * @author KarthikeyanK
	 * @param profile
	 * @param emailId
	 *//*
	public void addStudentProfile(StudentDom profile, String emailId);

	*//**
	 * This method is used to fetch the candidate's profile details
	 * @author KarthikeyanK
	 * @param emailId
	 */
	public List<StudentDom> getStudentProfileDetailsByEmailId(String emailId);

	/**
	 * This method is used to get the details of a list of candidates
	 * @param profileList
	 * @return List of Students
	 */
	public List<StudentDom> findStudentList(String profileList);

	/**
	 * This method is used to fetch the list of industries from the master table 
	 * @return List of industries
	 *//*
	public List<String> getIndustryList();

	*//**
	 * This method is used to fetch the list of functional area from the master table 
	 * @return List of functional area 
	 *//*
	public List<String> getfunctionalArea();
	
	*/
	/**
	 * This method is used to get the query builder details for a given formula
	 * @param formulaName
	 * @param emailId 
	 * @return List<EmployerQueryBuilderDom> formulaList
	 */
	public EmployerQueryBuilderDom findFormula(String formulaName, String emailId);

	/**
	 * This method is used to get the query builder details for a candidate
	 * @param formulaName
	 * @return List<EmployerQueryBuilderDom> formulaList
	 *//*
	public List<EmployerQueryBuilderDom> findFormulaName(String string);


	*//**
	 * @author BalajiI
	 * This method is used to update a candidate's profile 
	 * @param studentDom
	 * @param emailId
	 *//*
	public void updateStudentProfileDetails(StudentDom studentDom, String emailId);
	

	*//**
	 * This method is used to update the profile views of a candidate when a company views his/her profile 
	 * @author TrishnaR
	 * @param companyName,studentEmailId
	 */
	public void updateViewedByCompany(String firm, String emailId);

	
	/**
	 * This method is used by the candidate to view the list of employers who have viewed his/her profile
	 * @author TrishnaR,BalajiI
	 * @return HashMap<String, Object> (viewedByCompaniesMap)
	 */
	public HashMap<String, Object> getViewedByCompaniesList(String emailId);

	/**
	 * This method is used to retrieve the details of the candidate's recent activities on the application
	 * @author RavishaG
	 * @param emailID
	 * @return Map<String, Object> (recentActivitiesMap)
	 */
	public Map<String, Object> getRecentActivities(String emailID);

	/**
	* This method is used to update candidate's skills and resume details
	* @param student
	* @return Student(student)
	*//*
	public StudentDom updateStudentDefaultSkills(StudentDom student);

	*//**
	 * This method is used to get candidate's QR code image
	 * @author RavishaG
	 * @param emailID
	 * @return File(imageFile)
	 */
	public File getQRcodeImage(String emailID);

	/**
	 * This method is used to upload the candidate's QR code image
	 * @author RavishaG
	 * @param qrcodeImage
	 * @param emailId
	 *//*
	public void uploadQRCodeImage(InputStream qrcodeImage, String emailId);
	
	*/
	
	/**
	 * This method is used to check if the candidate has logged in for the first time
	 * @author PallaviD
	 * @param emailId
	 */
	public void updateIsFirstLogin(String emailId);

	
	/**
	 * This method is used to add career objective to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	public void addCareerObjectiveToResume(String emailID,String careerObjective);

	/**
	 * This method is used to add expertise to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	public void addExpertiseToResume(String emailID, String expertise);


	/**
	 * This method is used to check if a candidate is already saved by an employer
	 * @author RavishaG
	 * @param candidateEmailId
	 * @param companyEmailId 
	 * @return boolean(flag)
	 */
	public boolean isSavedCandidate(String candidateEmailId, String companyEmailId);

	/**
	 * This method is used to add personal details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	public void addPersonalDetailsFromWizard(String studentEmailId,StudentDom student);

	/**
	 * This method is used to add skill details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	public void addSkillsFromWizard(String studentEmailId, StudentDom student);

	/**
	 * This method is used to add work details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	//public void addWorkFromWizard(String studentEmailId, StudentDom student);

	/**
	 * This method is used to add some additional extra details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	public void addStudentInterests(String studentEmailId, StudentDom student);

	/**
	 * This method is used to add languages known by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	public void addStudentLanguagesKnown(String studentEmailId,StudentDom student);

	/** 
	 * This method is used to add entire education details of a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	//public void addEducationFromWizard(String studentEmailId,StudentDom student);

	/**
	 * This method is used to add only graduate details of education section of a candidate from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	//public void addGraduateFromWizard(String studentEmailId, StudentDom student);

	
	/**
	 * This method is used to add certification details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param certificationList
	 * @param i
	 * @return null
	 */
	public void addCertificationDetails(String studentEmailId,List<PortfolioDetailsDom> certificationList, int i);

	/**
	 * This method is used to add publication details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param publicationList
	 * @param i
	 * @return null
	 */
	public void addPublicationDetails(String studentEmailId,List<PortfolioDetailsDom> publicationList, int i);

	/**
	 * This method is used to retrieve list of course type from the database
	 * @author ravishag
	 * @return set<string>
	 *//*
	public Set<String> getCourseTypeList();

	*//**
	 * This method is used to increment the count of video profile views of a candidate 
	 * @author ravishag
	 * @param studentEmailId
	 * @param i 
	 * @return null
	 */
	public void incrementVideoProfileViews(String studentEmailId, int i);


	/**
	 * This method is used to remove languages by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return null
	 */
	public void removeLanguages(String studentEmailId, StudentDom student);

	/**
	 * This method is used to Delete the Selected Profile of a Candidate
	 * @param candidateEmailId
	 * @param profileName
	 * @return boolean(isDeleted)
	 *//*
	public boolean deleteSelectedProfile(String candidateEmailId,String profileName);

	*/
	/**
	 * This method is used to update students's IScore
	 * @author TrishnaR
	 * @param score
	 * @param emailId 
	 */
	public void updateStudentIScore(Double score, String emailId);
	
	 /** @author balajii
	 * This method is used to Update Student Skills of a Candidate
	 * @param studentUpdatedSkills
	 * @return boolean (updateSuccess)
	 *//*
	public boolean updateSkills(StudentDom studentUpdatedSkills);

	
	*//**
	 * This Method is used to set the mail settings for a student
	 * @param mailSettingsMap 
	 * @param emailId 
	 */
	public void updateMailSettings(String emailId, Map<String, List<String>> mailSettingsMap);

	
	/**
	 * This Method is used to get the mail settings for a student
	 * @param emailId 
	 */
	public Map<String,Boolean> getCandidateMailSettings(String emailId);
	 
	 /** @author PallaviD
	 * This method is used to insert searched keywords
	 * @param searchKeyword
	 * @return 
	 */
	public void addSearchedKeywords(String searchKeyword,Boolean userInputFlag);

	/**
	 * This method is used to fetch an candidate's photo 
	 * @author RavishaG
	 * @param emailID
	 * @return byte[]
	 *//*
	public byte[] getCandidatePhoto(String emailID);

	*//**
	 * This method is used to update a candidate's profile visibility to true or false
	 * @author RavishaG
	 * @param emailId
	 * @param visibility
	 */
	public void updateProfileVisibility(String emailId, boolean visibility);
	
	
	/**This method is used to add work details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param workList
	 * @param i
	 */
	public void addWorkDetails(String studentEmailId,
			List<PortfolioDetailsDom> workList, int i);

	
	/** This method is used to add school details of  a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param portfolioDetailsDom
	 */
	public void addSchoolDetails(String studentEmailId,
			PortfolioDetailsDom portfolioDetailsDom);

	/**
	 * This method is used to add university details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param universityList
	 * @param i 
	 */
	public void addUniversityDetails(String studentEmailId,
			List<PortfolioDetailsDom> universityList, int i);


	/**
	 * @author BalajiI
	 * @param appliedStudentEmailIdsStr
	 * @return List<StudentDom>(appliedCandidates)
	 */
	public List<StudentDom> getCandidateListByEmailId(String appliedStudentEmailIdsStr);


	public void updateSkills(StudentDom studentUpdatedSkills);


	public List<StudentDom> getProfiles(String candidateEmailId);


	public StudentDom getProfileDetails(String candidateEmailId, String profileName);


	public void updateStudentProfile(StudentDom profileDetailsDom);


	public void markDefault(String candidateEmailId, String profileName);


	public void deleteProfile(String name, String profileName);


	public boolean checkIfProfileNameExists(String profileName, String candidateEmailId);


	public void uploadQRCodeImage(InputStream qrcodeImage, String emailId);


	public StudentDom getStudentImage(String studentEmailId);


	public Map<String,Integer> getCandidateSearchedKeywords();


	public Map<String,Date> getCandidateRecentSearches(String emailId);


	public List<StudentDom> getCandidateDetails(ArrayList<String> candidateEmailIds);


	public void sendRecommendationRequest(StudentRecommendationDom studentRecommendationDom);


	public List<StudentRecommendationDom> getCandidateRecommendations(String emailId, String authority, String recommenderStatus);


	public void sendRecommendationReminder(String candidateEmailId,	String recommenderEmailId);


	public void submitRecommendation(StudentRecommendationDom studentRecommendationDom);
		
	
}