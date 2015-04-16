package caerusapp.service.student;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import caerusapp.dao.student.IStudentDao;
import caerusapp.dao.student.StudentDao;
import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentRecommendationDom;
import caerusapp.exceptions.CaerusCommonException;

/**
 * @author KShailesh
 * 
 */
public class StudentManager implements IStudentManager {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7870319758393597361L;

	protected final Log logger = LogFactory.getLog(getClass());

	private IStudentDao studentDao;
	
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}

	/**
	 * This method is used when a candidate registers to the application 
	 * @param student
	 */
	@Override
	public void candidateRegistration(StudentDom student) {
		
		studentDao.candidateRegistration(student);

	}
	
	 /** This method is used to check whether a student with an emailId:student.getEmailID() already exists
	 * @author KarthikeyanK
	 * @param emailId
	 * @return int (userCount)
	 * @throws CaerusCommonException
	 */
	@Override
	public int getStudentByEmailId(String emailId)
			throws CaerusCommonException {
		
		return studentDao.getStudentByEmailId(emailId);
	}
	
	/** (non-Javadoc)
	 * @see caerusapp.service.student.StudentManager#addStudentIntroductory(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method using add detail of the Introductory for Portfolio.
	 **/
	@Override
	public void addStudentIntroductory(StudentDom student) {
		
		studentDao.addStudentIntroductory(student);

	}
	
	
	 /**(non-Javadoc)
	 * @see caerusapp.service.student.StudentManager#addStudentEducation(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method using add detail of the Education for Portfolio.
	 */
	@Override
	public void addStudentEducation(StudentDom student) {
		
		studentDao.addStudentEducation(student);

	}
	
	/** (non-Javadoc)
	 * @see caerusapp.service.student.StudentManager#addStudentEducation(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method using add detail of the Work for Portfolio.
	 **/
	@Override
	public void addStudentWork(StudentDom student) {
		
		studentDao.addStudentWork(student);

	}
	
	/** (non-Javadoc)
	 * @see caerusapp.service.student.StudentManager#addStudentResumeSkills(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method using add detail of the Resume, Skills and Other for Portfolio.
	 */
	@Override
	public void addStudentResumeSkills(StudentDom student) {
		
		studentDao.addStudentResumeSkills(student);

	}
	
	 /**
     * This method is used by a candidate to add his/her profile details
     * @param profile
     *//*
	@Override
	public void studentProfile(Student profile, String emailId) {
		
		studentDao.studentProfile(profile);

	}

	

	@Override
	public Student studentDefaultProfileByEmailId(String emailID) {
		String profileName = null;
		List<Student> stud = studentDao.getStudentProfileDetailsByEmailId(emailID);

		//logger.info("STUD:" + stud);

		int size = stud.size();
		for (int i = 0; i < size; i++) {
			System.out.println(stud.get(i).getProfileName() + " "
					+ stud.get(i).getDefaultProfile());
			if (stud.get(i).getDefaultProfile() != null
					&& stud.get(i).getDefaultProfile().equalsIgnoreCase("True")) {
				//System.out.println("inside if");
				profileName = stud.get(i).getProfileName();
				logger.info("profileName:" + profileName);
				logger.info("studentProfile:"
						+ studentDao.getProfileDetailsByProfileName(emailID,
								profileName));
				Student studentProfile = studentDao
						.getProfileDetailsByProfileName(emailID, profileName);
				return studentProfile;

			}
		}

		return null;

	}
	*/

	 /**
	 * @see caerusapp.service.student.StudentManager#getDetailsByEmailId(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method is used to fetch the candidate details
	 */
	@Override
	public StudentDom getDetailsByEmailId(String emailId) {
		return studentDao.getDetailsByEmailId(emailId);

	}
	
	 /*
	 * 
	 (non-Javadoc)
	 * @see caerusapp.service.student.StudentManager#getProfileDetailsByDefault(caerusapp.domain.student.Student)
	 * @author Kshailesh
	 * @desc this method is used to fetch the candidate's default profile's details
	 
	@Override
	public Student getProfileDetailsByDefault(String emailId){
		return studentDao.getProfileDetailsByDefault(emailId);
		
	}
	
	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of states from master table.
	 * @return List of states
	 *//*
	public List<String> getStateList(){
		return studentDao.getStateList();
		
	}
	
	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of courses from master table.
	 * @return List of courses
	 *//*
	public List<String> getCourseList(){
		return studentDao.getCourseList();
		
	}
	
	*//**
	 * @author Kshailesh
	 * @desc this method used to get the list of universities from master table.
	 * @return List of universities
	 *//*
	public List<String> getUniversityList(){
		return studentDao.getUniversityList();
		
	}
	

	*//**
	 * This method is used to get details of the selected profile
	 * @param emailId
	 * @param selectedProfile
	 * @return student(studentProfile)
	 *//*
	@Override
	public Student getProfileDetailsByProfileName(String emailId,
			String selectedProfile) {

		Student student = studentDao.getProfileDetailsByProfileName(emailId,
				selectedProfile);
		
		return student;
	}

	*/

	/**
	 * This method is used to check whether a student with an emailId:student.getEmailID() already exists
	 * @author KarthikeyanK
	 * @param student
	 * @return int (userCount)
	 * @throws CaerusCommonException
	 *//*
	@Override
	public int getStudentByEmailId(Student addStudent)
			throws CaerusCommonException {
		
		return studentDao.getStudentByEmailId(addStudent);
	}*/


	
	/* * (non-Javadoc)
	 * This method is used to activate(enable) a user's account for the application
	 * @author KarthikeyanK
	 * @see
	 * caerusapp.service.student.StudentManager#updateEnabledStatusByUsername
	 * (java.lang.String)
	 
	@Override
	public void updateEnabledStatusByUsername(String userName) {
		studentDao.updateEnabledStatusByUsername(userName);

	}

	
	 * (non-Javadoc)
	 * This method is used to check whether a user's account is active or not
	 * @author KarthikeyanK
	 * @see
	 * caerusapp.service.student.StudentManager#getEnabledStatusByUsername(java
	 * .lang.String)
	 
	@Override
	public String getEnabledStatusByUsername(String userName) {
		return studentDao.getEnabledStatusByUsername(userName);
	}

	/**
	 * This method is used to set a candidate's profile to default  
	 * @param profile
	 * @param emailID
	 *//*
	@Override
	public void updateStudentDefaultProfile(String emailID, Student profile)
	{
		List<Student> studentProfileList = studentDao.getStudentProfileDetailsByEmailId(emailID);
		Iterator iterator = studentProfileList.iterator();
		while (iterator.hasNext())
		{
			Student studentWithProfile = (Student) iterator.next();
			String existingDefaultProfile = studentWithProfile.getDefaultProfile();
			
			if (existingDefaultProfile != null && !existingDefaultProfile.equals("")) 
			{
				if (existingDefaultProfile.equalsIgnoreCase("true"))
				{
					studentDao.updateDefaultProfileFalse(studentWithProfile);
				}
			}

		}

		studentDao.updateDefaultProfile(profile);
	}


	
	/** (non-Javadoc)
	 *  This method is used to upload profile photo by student
	 * @see
	 * caerusapp.service.student.StudentManager#uploadPhoto(caerusapp.domain
	 * .student.Student)
	 */
	@Override
	public void uploadPhoto(StudentDom student) {
		studentDao.uploadPhoto(student);
	}
	
	 /**(non-Javadoc)
	 * This method is used to upload resume by student
	 * @see caerusapp.service.student.StudentManager#uploadPhoto(caerusapp.domain.student.Student)
	 */
	@Override
	public void uploadResume(StudentDom student) {
		studentDao.uploadResume(student);
	}
	
	/**
	 * This method is used to upload video resume by student
	 * @author Kshailesh
	 * @param student
	 */
	@Override
	public void uploadVideo(StudentDom student) {
		studentDao.uploadVideo(student);
	}

	/**
	 * This method is used by the candidate to add a new profile
	 * @author KarthikeyanK
	 * @param profile
	 * @param emailId
	 *//*
	@Override
	public void addStudentProfile(Student profile, String emailId) {

		studentDao.addStudentProfile(profile, emailId);

	}

	*//**
	 * This method is used to fetch the candidate's profile details
	 * @author KarthikeyanK
	 * @param emailId
	 */
	@Override
	public List<StudentDom> getStudentProfileDetailsByEmailId(String emailId) {

		return studentDao.getStudentProfileDetailsByEmailId(emailId);
	}

	/**
	 * This method is used to get the details of a list of candidates
	 * @param profileList
	 * @return List of Students
	 */
	@Override
	public List<StudentDom> findStudentList(String profileList) {
		
		return studentDao.findStudentList(profileList);
		
	}
	
	
	/**
	 * This method is used to get the query builder details for a given formula
	 * @param formulaName
	 * @return List<EmployerQueryBuilderDom> formulaList
	 */
	@Override
	public EmployerQueryBuilderDom findFormula(String formulaName,String emailId)
	{
		return studentDao.findFormula(formulaName,emailId);
	}
	
	/**
	 * This method is used to get the query builder details for a candidate
	 * @param formulaName
	 * @return List<EmployerQueryBuilderDom> formulaList
	 *//*
	@Override
	public List<EmployerQueryBuilderDom> findFormulaName(String formulaName){
		return studentDao.findFormulaName(formulaName);
		
	}

	*//**
	 * This method is used to fetch the list of industries from the master table 
	 * @return List of industries
	 *//*
	@Override
	public List<String> getIndustryList() {
		return studentDao.getIndustryList();
	}
	
	*//**
	 * This method is used to fetch the list of functional area from the master table 
	 * @return List of functional area 
	 *//*
	@Override
	public List<String> getfunctionalArea() {
		return studentDao.getfunctionalArea();
	}

	*//**
	 * This method is used to update the profile views of a candidate when a company views his/her profile 
	 * @author TrishnaR
	 * @param companyName,studentEmailId
	 */
	@Override
	public void updateViewedByCompany(String firm,String emailId) {
		 studentDao.updateViewedByCompany(firm,emailId);
		
	}


	/**
	 * @author BalajiI
	 * This method is used to update a candidate's profile 
	 * @param studentDom
	 * @param emailId
	 *//*
	@Override
	public void updateStudentProfileDetails(Student studentDom, String emailId) {
		studentDao.updateStudentProfileDetails(studentDom,emailId);
	}



	*//**
	 * This method is used by the candidate to view the list of employers who have viewed his/her profile
	 * @author TrishnaR,BalajiI
	 * @return HashMap<String, Object> (viewedByCompaniesMap)
	 */
	@Override
	public HashMap<String, Object> getViewedByCompaniesList(String emailId) {
		
		return studentDao.getViewedByCompaniesList(emailId) ;
	}
	
	/**
	 * This method is used to retrieve the details of the candidate's recent activities on the application
	 * @author RavishaG
	 * @param emailID
	 * @return Map<String, Object> (recentActivitiesMap)
	 *//*
	@Override
	public Map<String, Object> getRecentActivities(String emailID) {
		
		return studentDao.getRecentActivities(emailID);
	}

	*//**
	* This method is used to update candidate's skills and resume details
	* @param student
	* @return Student(student)
	*//*
	@Override
	public Student updateStudentDefaultSkills(Student student) {
		// TODO Auto-generated method stub
		return studentDao.updateStudentDefaultSkills(student);
		
	}

	*//**
	 * This method is used to get candidate's QR code image
	 * @author RavishaG
	 * @param emailID
	 * @return File(imageFile)
	 */
	@Override
	public File getQRcodeImage(String emailID) {
		return studentDao.getQRcodeImage(emailID);
	}

	/**
	 * This method is used to upload the candidate's QR code image
	 * @author RavishaG
	 * @param qrcodeImage
	 * @param emailId
	 *//*
	@Override
	public void uploadQRCodeImage(InputStream qrcodeImage, String emailId) {
		 studentDao.uploadQRCodeImage(qrcodeImage,emailId);
		
	}
	*/
	
	/**
	 * This method is used to check if the candidate has logged in for the first time
	 * @author PallaviD
	 * @param emailId
	 */
	@Override
	public void updateIsFirstLogin(String emailId) {
		studentDao.updateIsFirstLogin(emailId);
		
	}

	/**
	 * This method is used to add career objective to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	@Override
	public void addCareerObjectiveToResume(String emailID, String careerObjective) {
		studentDao.addCareerObjectiveToResume(emailID,careerObjective);
		
	}

	/**
	 * This method is used to add expertise to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	@Override
	public void addExpertiseToResume(String emailID, String expertise) {
		studentDao.addExpertiseToResume(emailID,expertise);
		
	}

	/**
	 * This method is used to check if a candidate is already saved by an employer
	 * @author RavishaG
	 * @param candidateEmailId
	 * @param companyEmailId
	 * @return boolean(flag) 
	 */
	@Override
	public boolean isSavedCandidate(String candidateEmailId,String companyEmailId) {
		
		return studentDao.isSavedCandidate(candidateEmailId,companyEmailId);
	}

	/**
	 * This method is used to add personal details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addPersonalDetailsFromWizard(String studentEmailId,StudentDom student) {
		
		studentDao.addPersonalDetailsFromWizard(studentEmailId,student);
		
	}
	
	/**
	 * This method is used to add skill details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addSkillsFromWizard(String studentEmailId, StudentDom student) {
		studentDao.addSkillsFromWizard(studentEmailId,student);
	}

	/**
	 * This method is used to add work details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	/*@Override
	public void addWorkFromWizard(String studentEmailId, StudentDom student) {
		studentDao.addWorkFromWizard(studentEmailId,student);
		
	}*/
	
	/**
	 * This method is used to add some additional extra details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addStudentInterests(String studentEmailId, StudentDom student) {
		studentDao.addStudentInterests(studentEmailId,student);
		
	}

	/**
	 * This method is used to add languages known by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addStudentLanguagesKnown(String studentEmailId,StudentDom student) {
		
		studentDao.addStudentLanguagesKnown(studentEmailId,student);
		
	}

	/** 
	 * This method is used to add entire education details of a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	/*@Override
	public void addEducationFromWizard(String studentEmailId,StudentDom student) {
		
		studentDao.addEducationFromWizard(studentEmailId,student);
		
	}*/

	/**
	 * This method is used to add only graduate details of education section of a candidate from the wizard page to the database
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	/*@Override
	public void addGraduateFromWizard(String studentEmailId, StudentDom student) {
		studentDao.addGraduateFromWizard(studentEmailId, student);
		
	}*/

	/**
	 * This method is used to add certification details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param certificationList
	 * @param i
	 * @return null
	 */
	@Override
	public void addCertificationDetails(String studentEmailId,List<PortfolioDetailsDom> certificationList, int i) {
		studentDao.addCertificationDetails(studentEmailId,certificationList,i);
	}

	/**
	 * This method is used to add publication details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param publicationList
	 * @param i
	 * @return null
	 */
	@Override
	public void addPublicationDetails(String studentEmailId,List<PortfolioDetailsDom> publicationList, int i) {
		studentDao.addPublicationDetails(studentEmailId,publicationList,i);
		
	}

	/**
	 * This method is used to retrieve list of course type from the database
	 * @author ravishag
	 * @return set<string>
	 *//*
	@Override
	public Set<String> getCourseTypeList() {
		
		return studentDao.getCourseTypeList();
	}

	*//**
	 * This method is used to increment the count of video profile views of a candidate 
	 * @author ravishag
	 * @param studentEmailId
	 * * @param i 
	 * @return null
	 */
	@Override
	public void incrementVideoProfileViews(String studentEmailId,int i) {
		
		studentDao.incrementVideoProfileViews(studentEmailId,i);
	}


	/**
	 * This method is used to remove languages by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return null
	 */
	@Override
	public void removeLanguages(String studentEmailId, StudentDom student) {
		 studentDao.removeLanguages(studentEmailId,student);
	}

	/**
	 * This method is used to Delete the Selected Profile of a Candidate
	 * @param candidateEmailId
	 * @param profileName
	 * @return boolean(isDeleted)
	 *//*
	@Override
	public boolean deleteSelectedProfile(String candidateEmailId , String profileName) {
		return studentDao.deleteSelectedProfile(candidateEmailId , profileName);
	}
	*/

	/**
	 * This method is used to update students's IScore
	 * @author TrishnaR
	 * @param score
	 * @param emailId 
	 */
	@Override
	public void updateStudentIScore(Double score,String emailId) {
		studentDao.updateStudentIScore(score,emailId);
	}

	/**
	 * @author balajii
	 * This method is used to Update Student Skills of a Candidate
	 * @param studentUpdatedSkills
	 * @return boolean (updateSuccess)
	 */
	/*@Override
	public boolean updateSkills(StudentDom studentUpdatedSkills) {
		return studentDao.updateSkills(studentUpdatedSkills);
	}*/

	@Override
	public void updateMailSettings(String emailId, Map<String, List<String>> mailSettingsMap) {
		 studentDao.updateMailSettings(emailId,mailSettingsMap);
	

	}


	@Override
	public Map<String, Boolean> getCandidateMailSettings(String emailId) {
		return studentDao.getCandidateMailSettings(emailId);
	}


	/** @author PallaviD
	* This method is used to insert searched keywords
	* @param searchKeyword
	* @return 
	*/
	@Override
	public void addSearchedKeywords(String searchKeyword,Boolean userInputFlag) {
		studentDao.addSearchedKeywords(searchKeyword,userInputFlag);
	}

	@Override
	public Map<String, Object> getRecentActivities(String emailID) {
		return studentDao.getRecentActivities(emailID);
	}

	/**
	 * This method is used to fetch an candidate's photo 
	 * @author RavishaG
	 * @param emailID
	 * @return byte[]
	 *//*
	@Override
	public byte[] getCandidatePhoto(String emailID) {
		
		return studentDao.getCandidatePhoto(emailID);
	}

	*//**
	 * This method is used to update a candidate's profile visibility to true or false
	 * @author RavishaG
	 * @param emailId
	 * @param visibility
	 */
	@Override
	public void updateProfileVisibility(String emailId, boolean visibility) {
		studentDao.updateProfileVisibility(emailId,visibility);
		
	}

	/**This method is used to add work details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param workList
	 * @param i
	 */
	public void addWorkDetails(String studentEmailId,
			List<PortfolioDetailsDom> workList, int i){
		studentDao.addWorkDetails(studentEmailId, workList, i);
	}

	/** This method is used to add school details of  a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param portfolioDetailsDom
	 */
	@Override
	public void addSchoolDetails(String studentEmailId,
			PortfolioDetailsDom portfolioDetailsDom) {
		studentDao.addSchoolDetails(studentEmailId, portfolioDetailsDom);
		
	}

	/**
	 * This method is used to add university details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param universityList
	 * @param i
	 */
	@Override
	public void addUniversityDetails(String studentEmailId,List<PortfolioDetailsDom> universityList, int i) {
		studentDao.addUniversityDetails(studentEmailId, universityList,  i);
		
	}

	/**
	 * @author BalajiI
	 * @param appliedStudentEmailIdsStr
	 * @return List<StudentDom>(appliedCandidates)
	 */
	@Override
	public List<StudentDom> getCandidateListByEmailId(String appliedStudentEmailIdsStr) {
		return studentDao.getCandidateListByEmailId(appliedStudentEmailIdsStr);
	}

	@Override
	public void updateSkills(StudentDom studentUpdatedSkills) {
		studentDao.updateSkills(studentUpdatedSkills);
	}

	@Override
	public List<StudentDom> getProfiles(String candidateEmailId) {
		return studentDao.getProfiles(candidateEmailId);
	}

	@Override
	public StudentDom getProfileDetails(String candidateEmailId,String profileName) {
		return studentDao.getProfileDetails(candidateEmailId,profileName);
	}

	@Override
	public void updateStudentProfile(StudentDom profileDetailsDom) {
		studentDao.updateStudentProfile(profileDetailsDom);
	}

	@Override
	public void markDefault(String candidateEmailId, String profileName) {
		studentDao.markDefault(candidateEmailId,profileName);
	}

	@Override
	public void deleteProfile(String candidateEmailId, String profileName) {
		studentDao.deleteProfile(candidateEmailId,profileName);
	}

	@Override
	public boolean checkIfProfileNameExists(String profileName,String candidateEmailId) {
		return studentDao.checkIfProfileNameExists(profileName,candidateEmailId);
	}

	@Override
	public void uploadQRCodeImage(InputStream qrcodeImage, String emailId) {
		studentDao.uploadQRCodeImage(qrcodeImage,emailId);
	}

	@Override
	public StudentDom getStudentImage(String studentEmailId) {
		
		return studentDao.getStudentImage(studentEmailId);
	}

	public void candidateBetaRegistration(StudentDom student) {
		 studentDao.candidateBetaRegistration(student);
		
	}

	@Override
	public Map<String,Integer> getCandidateSearchedKeywords() {
		
		return studentDao.getCandidateSearchedKeywords();
	}

	public void addToCandidateRecentSearches(String combinationWord,String emailId, String searchCriterion) {
		studentDao.addToCandidateRecentSearches(combinationWord,emailId,searchCriterion);
	}

	@Override
	public Map<String,Date> getCandidateRecentSearches(String emailId) {
		
		return studentDao.getCandidateRecentSearches(emailId);
	}

	@Override
	public List<StudentDom> getCandidateDetails(ArrayList<String> candidateEmailIds) {
		return studentDao.getCandidateDetails(candidateEmailIds);
	}

	@Override
	public void sendRecommendationRequest(StudentRecommendationDom studentRecommendationDom) {
		 studentDao.sendRecommendationRequest(studentRecommendationDom);
		
	}

	@Override
	public List<StudentRecommendationDom> getCandidateRecommendations(
			String emailId, String authority,  String recommenderStatus) {
		return studentDao.getCandidateRecommendations(emailId, authority, recommenderStatus);
	}

	@Override
	public void sendRecommendationReminder(String candidateEmailId,
			String recommenderEmailId) {
		studentDao.sendRecommendationReminder(candidateEmailId, recommenderEmailId);
		
	}

	@Override
	public void submitRecommendation(
			StudentRecommendationDom studentRecommendationDom) {
		studentDao.submitRecommendation(studentRecommendationDom);
		
	}
}