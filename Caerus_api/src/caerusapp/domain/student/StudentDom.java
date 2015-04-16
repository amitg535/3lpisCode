package caerusapp.domain.student;

import java.io.InputStream;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import caerusapp.domain.common.JobDetailsDom;

public class StudentDom implements Serializable {

	private static final long serialVersionUID = 8030244679264428945L;
	
	private Integer toExperience;
	private String email;
	private String universityname;
	private String sortlist;
	private String onhold;
	private String reject;

	
	private String  companyId;

	// For searching candidate.........................

	private String name;
	private String studentId;
	
	//@NotEmpty(message = ValidatorMessageConstants.CANDIDATE_FIRST_NAME_EMPTY)
	private String firstName;
	
	private String middleName;
	
	//@NotEmpty(message = ValidatorMessageConstants.CANDIDATE_LAST_NAME_EMPTY)
	private String lastName;
	
	private String userName;
	
	//@NotEmpty(message = ValidatorMessageConstants.CANDIDATE_PASSWORD_EMPTY)
	private String password;
	
	//@Pattern(regexp ="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(?:[a-zA-Z]{2,6})$", message = ValidatorMessageConstants.EMAIL_ID_SYNTAX) @NotEmpty(message = ValidatorMessageConstants.CANDIDATE_EMAIL_ID_EMPTY)
	private String emailID;
	
	//@NotEmpty(message = ValidatorMessageConstants.CANDIDATE_DATE_OF_BIRTH_EMPTY)
	private String dateOfBirth;
	
	//@NotEmpty(message = ValidatorMessageConstants.CANDIDATE_CONFIRM_PASSWORD_EMPTY)
	private String confirmPassword;
	
	private String state;
	private String func_area;
	private String userId;
	private String authority;
	private String nameThisProfile;
	private String currentLocation;
	private String mobileNumber;
	private String previousExp;
	private String industry;
	private String functionalArea;
	private String profileSummary;
	private String keySkills;
	private String resumeText;
	private String profileName;
	private String yourName;
	private String resumeHeadline;
	private String ugQualification;
	private String pgQualification;
	private String otherQualification;
	private String exception;
	private String defaultProfile;
	private String filename;
	private String photoName;
	private String videoTitle;
	private String videoName;
	private String SearchDate;
	private String address;
	private String zipCode;
	private String city;
	private String gender;
	private String aboutYourSelf;
	private String resumeName;
	private String courseType;
	private String courseName;
	private String universityName;
	private String g_startMonth_duration;
	private String g_startYear_duration;
	private String g_endMonth_duration;
	private String g_endYear_duration;
	private String h_startMonth_duration;
	private String h_startYear_duration;
	private String h_endMonth_duration;
	private String h_endYear_duration;
	private String w_startMonth_duration;
	private String w_startYear_duration;
	private String w_endMonth_duration;
	private String w_endYear_duration;
	private String g_from_gpa;
	private String g_to_gpa;
	private String g_from_gpa1;
	private String g_to_gpa1;
	private String schoolName;
	private String schoolState;
	private String h_gpa;
	private String h_from_gpa;
	private String h_to_gpa;
	private String companyName;
	private String workDesc;
	private String designation;
	private String w_start_duration;
	private String w_end_duration;
	private String primarySkills1;
	private String secondarySkills1;
	private String batch;
	private String appliedDate;
	private String careerObjective;
	private String expertize;
	private String hiddenValue;
	private String jobRequestShorlisted;
	private String jobRequestOnHold;
	private String jobRequestRejected;
	private String successMessage;
	private String jobRequestStatus;
	private String language;
	
	private int fileCount = 5;
	
	private Integer age;
	private Integer viewVideoProfileCount;
	
	private Double IScore;
	private Double iScore;
		
	private boolean exceptionOccured = false;
	private boolean sendMeJobAlerts;
	private boolean recruitersCallMe;
	private boolean notificationFromCaerus;
	private boolean communicationFromCaerus;
	private boolean termsAndConditions;
	private boolean isDefault;
	private boolean isFirstLogin;
	private boolean profileVisibility;
	private boolean savedCandidate;
	private Boolean editMode;
	
	private byte[] fileData;
	private byte[] uploadVideoclip;
	private byte[] photoData;

	Date date;
	private Date posted_on;
	private Date applied_on;
	
	private CommonsMultipartFile fileResume;
	private CommonsMultipartFile filePhoto;
	private CommonsMultipartFile fileVideo;
	
	public InputStream inputStream;
	public InputStream inputStreamResume;
	public InputStream inputStreamPhoto;
	public InputStream inputStreamVideo;

	private List<String> primarySkills;
	private List<String> secondarySkills;
	private List<String> industryList;
	private List<String> functionalAreaList;
	private List<String> expertizeList;
	private List<String> stateList;
	private List<String> courseList;
	private List<String> universityList;
	private List<String> saved_jobs_list;
	private List<JobDetailsDom> jobList;
	private List certificationsList;
	private List publicationsList;

	private Set<String> viewedByEmployerSet;
	private Set<String> languagesList;
		
	private Map<String, Object> viewedByCompaniesMap;
	private Map <String, String> workMap;
	private Map <String, String> schoolMap;
	private Map <String, String> universityMap;
	private Map<String, String> certificationsMap;
	private Map<String, String> publicationsMap;
	private Map<String,Boolean> mailSettingsMap;
	private Map<String, String> JobStatus;
	private Map<String, String> internshipStatus;
	private Map<String, String> campusJobStatus;
	private Map<String, String> campusInternshipStatus;
	
	private CommonsMultipartFile file;
	
	
	
	private String keywords;
	private String educationalQualification;
	private boolean spring;
	private boolean fall;
	private boolean winter;
	private boolean summer;
	private boolean saveSearchParameter;
	private Integer fromExperience;
	private Integer ToExperience;
	private Integer fromGpa;
	private Integer toGpa;
	private String location;
	private String yearOfPassing;
	private String lastUpdate;
	private String parameterName;


	private String[] candidateEmailId;
	private List<String> educationalQualifications;
	private String searchParameterName;
	private String jobIdAndFirmId;
	
	private PortfolioDetailsDom universityDetails;
	
	
	
	
	public String getSearchParameterName() {
		return searchParameterName;
	}

	public void setSearchParameterName(String searchParameterName) {
		this.searchParameterName = searchParameterName;
	}

	public String getJobIdAndFirmId() {
		return jobIdAndFirmId;
	}

	public void setJobIdAndFirmId(String jobIdAndFirmId) {
		this.jobIdAndFirmId = jobIdAndFirmId;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public List<String> getExpertizeList() {
		return expertizeList;
	}

	public void setExpertizeList(List<String> expertizeList) {
		this.expertizeList = expertizeList;
	}

	public String getCareerObjective() {
		return careerObjective;
	}

	public void setCareerObjective(String careerObjective) {
		this.careerObjective = careerObjective;
	}

	public boolean isSavedCandidate() {
		return savedCandidate;
	}

	public void setSavedCandidate(boolean savedCandidate) {
		this.savedCandidate = savedCandidate;
	}

	public String getExpertize() {
		return expertize;
	}

	public void setExpertize(String expertize) {
		this.expertize = expertize;
	}

	public String getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(String appliedDate) {
		this.appliedDate = appliedDate;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	/**
	 * @return the primarySkills1
	 */
	public String getPrimarySkills1() {
		return primarySkills1;
	}

	/**
	 * @param primarySkills1 the primarySkills1 to set
	 */
	public void setPrimarySkills1(String primarySkills1) {
		this.primarySkills1 = primarySkills1;
	}

	/**
	 * @return the secondarySkills1
	 */
	public String getSecondarySkills1() {
		return secondarySkills1;
	}

	/**
	 * @param secondarySkills1 the secondarySkills1 to set
	 */
	public void setSecondarySkills1(String secondarySkills1) {
		this.secondarySkills1 = secondarySkills1;
	}

;

	public Integer getViewVideoProfileCount() {
		return viewVideoProfileCount;
	}

	public void setViewVideoProfileCount(Integer viewVideoProfileCount) {
		this.viewVideoProfileCount = viewVideoProfileCount;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	private List<String> interestList;

	public List<String> getInterestList() {
		return interestList;
	}

	public void setInterestList(List<String> interestList) {
		this.interestList = interestList;
	}

	public Map<String, String> getCertificationsMap() {
		return certificationsMap;
	}

	public void setCertificationsMap(Map<String, String> certificationsMap) {
		this.certificationsMap = certificationsMap;
	}

	public Map<String, String> getPublicationsMap() {
		return publicationsMap;
	}

	public void setPublicationsMap(Map<String, String> publicationsMap) {
		this.publicationsMap = publicationsMap;
	}

	public Set<String> getLanguagesList() {
		return languagesList;
	}

	public void setLanguagesList(Set<String> languagesList) {
		this.languagesList = languagesList;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the studentId
	 */
	public String getStudentId() {
		return studentId;
	}

	/**
	 * @param studentId
	 *            the studentId to set
	 */
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName
	 *            the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return the middleName
	 */
	public String getMiddleName() {
		return middleName;
	}

	/**
	 * @param middleName
	 *            the middleName to set
	 */
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * @param lastName
	 *            the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName
	 *            the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the emailID
	 */
	public String getEmailID() {
		return emailID;
	}

	/**
	 * @param emailID
	 *            the emailID to set
	 */
	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the func_area
	 */
	public String getFunc_area() {
		return func_area;
	}

	/**
	 * @param func_area
	 *            the func_area to set
	 */
	public void setFunc_area(String func_area) {
		this.func_area = func_area;
	}

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * @param userId
	 *            the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * @return the authority
	 */
	public String getAuthority() {
		return authority;
	}

	/**
	 * @param authority
	 *            the authority to set
	 */
	public void setAuthority(String authority) {
		this.authority = authority;
	}

	/**
	 * @return the confirmPassword
	 */
	public String getConfirmPassword() {
		return confirmPassword;
	}

	/**
	 * @param confirmPassword
	 *            the confirmPassword to set
	 */
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	/**
	 * @return the nameThisProfile
	 */
	public String getNameThisProfile() {
		return nameThisProfile;
	}

	/**
	 * @param nameThisProfile
	 *            the nameThisProfile to set
	 */
	public void setNameThisProfile(String nameThisProfile) {
		this.nameThisProfile = nameThisProfile;
	}

	/**
	 * @return the currentLocation
	 */
	public String getCurrentLocation() {
		return currentLocation;
	}

	/**
	 * @param currentLocation
	 *            the currentLocation to set
	 */
	public void setCurrentLocation(String currentLocation) {
		this.currentLocation = currentLocation;
	}

	/**
	 * @return the mobileNumber
	 */
	public String getMobileNumber() {
		return mobileNumber;
	}

	/**
	 * @param mobileNumber
	 *            the mobileNumber to set
	 */
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	/**
	 * @return the previousExp
	 */
	public String getPreviousExp() {
		return previousExp;
	}

	/**
	 * @param previousExp
	 *            the previousExp to set
	 */
	public void setPreviousExp(String previousExp) {
		this.previousExp = previousExp;
	}

	/**
	 * @return the industry
	 */
	public String getIndustry() {
		return industry;
	}

	/**
	 * @param industry
	 *            the industry to set
	 */
	public void setIndustry(String industry) {
		this.industry = industry;
	}

	/**
	 * @return the functionalArea
	 */
	public String getFunctionalArea() {
		return functionalArea;
	}

	/**
	 * @param functionalArea
	 *            the functionalArea to set
	 */
	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}

	/**
	 * @return the profileSummary
	 */
	public String getProfileSummary() {
		return profileSummary;
	}

	/**
	 * @param profileSummary
	 *            the profileSummary to set
	 */
	public void setProfileSummary(String profileSummary) {
		this.profileSummary = profileSummary;
	}

	/**
	 * @return the keySkills
	 */
	public String getKeySkills() {
		return keySkills;
	}

	/**
	 * @param keySkills
	 *            the keySkills to set
	 */
	public void setKeySkills(String keySkills) {
		this.keySkills = keySkills;
	}

	/**
	 * @return the resumeText
	 */
	public String getResumeText() {
		return resumeText;
	}

	/**
	 * @param resumeText
	 *            the resumeText to set
	 */
	public void setResumeText(String resumeText) {
		this.resumeText = resumeText;
	}

	/**
	 * @return the profileName
	 */
	public String getProfileName() {
		return profileName;
	}

	/**
	 * @param profileName
	 *            the profileName to set
	 */
	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	/**
	 * @return the yourName
	 */
	public String getYourName() {
		return yourName;
	}

	/**
	 * @param yourName
	 *            the yourName to set
	 */
	public void setYourName(String yourName) {
		this.yourName = yourName;
	}

	/**
	 * @return the resumeHeadline
	 */
	public String getResumeHeadline() {
		return resumeHeadline;
	}

	/**
	 * @param resumeHeadline
	 *            the resumeHeadline to set
	 */
	public void setResumeHeadline(String resumeHeadline) {
		this.resumeHeadline = resumeHeadline;
	}

	/**
	 * @return the ugQualification
	 */
	public String getUgQualification() {
		return ugQualification;
	}

	/**
	 * @param ugQualification
	 *            the ugQualification to set
	 */
	public void setUgQualification(String ugQualification) {
		this.ugQualification = ugQualification;
	}

	/**
	 * @return the pgQualification
	 */
	public String getPgQualification() {
		return pgQualification;
	}

	/**
	 * @param pgQualification
	 *            the pgQualification to set
	 */
	public void setPgQualification(String pgQualification) {
		this.pgQualification = pgQualification;
	}

	/**
	 * @return the otherQualification
	 */
	public String getOtherQualification() {
		return otherQualification;
	}

	/**
	 * @param otherQualification
	 *            the otherQualification to set
	 */
	public void setOtherQualification(String otherQualification) {
		this.otherQualification = otherQualification;
	}

	/**
	 * @return the exception
	 */
	public String getException() {
		return exception;
	}

	/**
	 * @param exception
	 *            the exception to set
	 */
	public void setException(String exception) {
		this.exception = exception;
	}

	/**
	 * @return the exceptionOccured
	 */
	public boolean isExceptionOccured() {
		return exceptionOccured;
	}

	/**
	 * @param exceptionOccured
	 *            the exceptionOccured to set
	 */
	public void setExceptionOccured(boolean exceptionOccured) {
		this.exceptionOccured = exceptionOccured;
	}

	/**
	 * @return the defaultProfile
	 */
	public String getDefaultProfile() {
		return defaultProfile;
	}

	/**
	 * @param defaultProfile
	 *            the defaultProfile to set
	 */
	public void setDefaultProfile(String defaultProfile) {
		this.defaultProfile = defaultProfile;
	}

	/**
	 * @return the sendMeJobAlerts
	 */
	public boolean isSendMeJobAlerts() {
		return sendMeJobAlerts;
	}

	/**
	 * @param sendMeJobAlerts
	 *            the sendMeJobAlerts to set
	 */
	public void setSendMeJobAlerts(boolean sendMeJobAlerts) {
		this.sendMeJobAlerts = sendMeJobAlerts;
	}

	/**
	 * @return the recruitersCallMe
	 */
	public boolean isRecruitersCallMe() {
		return recruitersCallMe;
	}

	/**
	 * @param recruitersCallMe
	 *            the recruitersCallMe to set
	 */
	public void setRecruitersCallMe(boolean recruitersCallMe) {
		this.recruitersCallMe = recruitersCallMe;
	}

	/**
	 * @return the notificationFromCaerus
	 */
	public boolean isNotificationFromCaerus() {
		return notificationFromCaerus;
	}

	/**
	 * @param notificationFromCaerus
	 *            the notificationFromCaerus to set
	 */
	public void setNotificationFromCaerus(boolean notificationFromCaerus) {
		this.notificationFromCaerus = notificationFromCaerus;
	}

	/**
	 * @return the communicationFromCaerus
	 */
	public boolean isCommunicationFromCaerus() {
		return communicationFromCaerus;
	}

	/**
	 * @param communicationFromCaerus
	 *            the communicationFromCaerus to set
	 */
	public void setCommunicationFromCaerus(boolean communicationFromCaerus) {
		this.communicationFromCaerus = communicationFromCaerus;
	}

	/**
	 * @return the termsAndConditions
	 */
	public boolean isTermsAndConditions() {
		return termsAndConditions;
	}

	/**
	 * @param termsAndConditions
	 *            the termsAndConditions to set
	 */
	public void setTermsAndConditions(boolean termsAndConditions) {
		this.termsAndConditions = termsAndConditions;
	}

	/**
	 * @return the filename
	 */
	public String getFilename() {
		return filename;
	}

	/**
	 * @param filename
	 *            the filename to set
	 */
	public void setFilename(String filename) {
		this.filename = filename;
	}

	/**
	 * @return the fileData
	 */
	public byte[] getFileData() {
		return fileData;
	}

	/**
	 * @param fileData
	 *            the fileData to set
	 */
	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
	}

	/**
	 * @return the inputStream
	 */
	public InputStream getInputStream() {
		return inputStream;
	}

	/**
	 * @param inputStream
	 *            the inputStream to set
	 */
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	/**
	 * @return the uploadVideoclip
	 */
	public byte[] getUploadVideoclip() {
		return uploadVideoclip;
	}

	/**
	 * @param uploadVideoclip
	 *            the uploadVideoclip to set
	 */
	public void setUploadVideoclip(byte[] uploadVideoclip) {
		this.uploadVideoclip = uploadVideoclip;
	}

	/**
	 * @return the photoName
	 */
	public String getPhotoName() {
		return photoName;
	}

	/**
	 * @param photoName
	 *            the photoName to set
	 */
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}

	/**
	 * @return the photoData
	 */
	public byte[] getPhotoData() {
		return photoData;
	}

	/**
	 * @param photoData
	 *            the photoData to set
	 */
	public void setPhotoData(byte[] photoData) {
		this.photoData = photoData;
	}

	/**
	 * @return the fileCount
	 */
	public int getFileCount() {
		return fileCount;
	}

	/**
	 * @param fileCount
	 *            the fileCount to set
	 */
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	/**
	 * @return the isDefault
	 */
	public boolean getIsDefault() {
		return isDefault;
	}

	/**
	 * @param isDefault
	 *            the isDefault to set
	 */
	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

	/**
	 * @return the date
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * @param date
	 *            the date to set
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * @return the videoTitle
	 */
	public String getVideoTitle() {
		return videoTitle;
	}

	/**
	 * @param videoTitle
	 *            the videoTitle to set
	 */
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}

	/**
	 * @return the videoName
	 */
	public String getVideoName() {
		return videoName;
	}

	/**
	 * @param videoName
	 *            the videoName to set
	 */
	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}

	/**
	 * @return the searchDate
	 */
	public String getSearchDate() {
		return SearchDate;
	}

	/**
	 * @param searchDate
	 *            the searchDate to set
	 */
	public void setSearchDate(String searchDate) {
		SearchDate = searchDate;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the zipCode
	 */
	public String getZipCode() {
		return zipCode;
	}

	/**
	 * @param zipCode
	 *            the zipCode to set
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * @return the dateOfBirth
	 */
	public String getDateOfBirth() {
		return dateOfBirth;
	}

	/**
	 * @param dateOfBirth
	 *            the dateOfBirth to set
	 */
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * @param gender
	 *            the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @return the aboutYourSelf
	 */
	public String getAboutYourSelf() {
		return aboutYourSelf;
	}

	/**
	 * @param aboutYourSelf
	 *            the aboutYourSelf to set
	 */
	public void setAboutYourSelf(String aboutYourSelf) {
		this.aboutYourSelf = aboutYourSelf;
	}

	/**
	 * @return the resumeName
	 */
	public String getResumeName() {
		return resumeName;
	}

	/**
	 * @param resumeName
	 *            the resumeName to set
	 */
	public void setResumeName(String resumeName) {
		this.resumeName = resumeName;
	}

	/**
	 * @return the courseType
	 */
	public String getCourseType() {
		return courseType;
	}

	/**
	 * @param courseType
	 *            the courseType to set
	 */
	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	/**
	 * @return the courseName
	 */
	public String getCourseName() {
		return courseName;
	}

	/**
	 * @param courseName
	 *            the courseName to set
	 */
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	/**
	 * @return the universityName
	 */
	public String getUniversityName() {
		return universityName;
	}

	/**
	 * @param universityName
	 *            the universityName to set
	 */
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}

	/**
	 * @return the g_from_gpa
	 */
	public String getG_from_gpa() {
		return g_from_gpa;
	}

	/**
	 * @param g_from_gpa
	 *            the g_from_gpa to set
	 */
	public void setG_from_gpa(String g_from_gpa) {
		this.g_from_gpa = g_from_gpa;
	}

	/**
	 * @return the g_to_gpa
	 */
	public String getG_to_gpa() {
		return g_to_gpa;
	}

	/**
	 * @param g_to_gpa
	 *            the g_to_gpa to set
	 */
	public void setG_to_gpa(String g_to_gpa) {
		this.g_to_gpa = g_to_gpa;
	}

	/**
	 * @return the g_from_gpa1
	 */
	public String getG_from_gpa1() {
		return g_from_gpa1;
	}

	/**
	 * @param g_from_gpa1
	 *            the g_from_gpa1 to set
	 */
	public void setG_from_gpa1(String g_from_gpa1) {
		this.g_from_gpa1 = g_from_gpa1;
	}

	/**
	 * @return the g_to_gpa1
	 */
	public String getG_to_gpa1() {
		return g_to_gpa1;
	}

	/**
	 * @param g_to_gpa1
	 *            the g_to_gpa1 to set
	 */
	public void setG_to_gpa1(String g_to_gpa1) {
		this.g_to_gpa1 = g_to_gpa1;
	}

	/**
	 * @return the schoolName
	 */
	public String getSchoolName() {
		return schoolName;
	}

	/**
	 * @param schoolName
	 *            the schoolName to set
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	/**
	 * @return the schoolState
	 */
	public String getSchoolState() {
		return schoolState;
	}

	/**
	 * @param schoolState
	 *            the schoolState to set
	 */
	public void setSchoolState(String schoolState) {
		this.schoolState = schoolState;
	}

	/**
	 * @return the h_gpa
	 */
	public String getH_gpa() {
		return h_gpa;
	}

	/**
	 * @param h_gpa
	 *            the h_gpa to set
	 */
	public void setH_gpa(String h_gpa) {
		this.h_gpa = h_gpa;
	}

	/**
	 * @return the h_from_gpa
	 */
	public String getH_from_gpa() {
		return h_from_gpa;
	}

	/**
	 * @param h_from_gpa
	 *            the h_from_gpa to set
	 */
	public void setH_from_gpa(String h_from_gpa) {
		this.h_from_gpa = h_from_gpa;
	}

	/**
	 * @return the h_to_gpa
	 */
	public String getH_to_gpa() {
		return h_to_gpa;
	}

	/**
	 * @param h_to_gpa
	 *            the h_to_gpa to set
	 */
	public void setH_to_gpa(String h_to_gpa) {
		this.h_to_gpa = h_to_gpa;
	}

	/**
	 * @return the companyName
	 */
	public String getCompanyName() {
		return companyName;
	}

	/**
	 * @param companyName
	 *            the companyName to set
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/**
	 * @return the workDesc
	 */
	public String getWorkDesc() {
		return workDesc;
	}

	/**
	 * @param workDesc
	 *            the workDesc to set
	 */
	public void setWorkDesc(String workDesc) {
		this.workDesc = workDesc;
	}

	/**
	 * @return the w_start_duration
	 */
	public String getW_start_duration() {
		return w_start_duration;
	}

	/**
	 * @param w_start_duration
	 *            the w_start_duration to set
	 */
	public void setW_start_duration(String w_start_duration) {
		this.w_start_duration = w_start_duration;
	}

	/**
	 * @return the w_end_duration
	 */
	public String getW_end_duration() {
		return w_end_duration;
	}

	/**
	 * @param w_end_duration
	 *            the w_end_duration to set
	 */
	public void setW_end_duration(String w_end_duration) {
		this.w_end_duration = w_end_duration;
	}

	/**
	 * @return the fileResume
	 */
	public CommonsMultipartFile getFileResume() {
		return fileResume;
	}

	/**
	 * @param fileResume
	 *            the fileResume to set
	 */
	public void setFileResume(CommonsMultipartFile fileResume) {
		this.fileResume = fileResume;
	}

	/**
	 * @return the filePhoto
	 */
	public CommonsMultipartFile getFilePhoto() {
		return filePhoto;
	}

	/**
	 * @param filePhoto
	 *            the filePhoto to set
	 */
	public void setFilePhoto(CommonsMultipartFile filePhoto) {
		this.filePhoto = filePhoto;
	}

	/**
	 * @return the fileVideo
	 */
	public CommonsMultipartFile getFileVideo() {
		return fileVideo;
	}

	/**
	 * @param fileVideo
	 *            the fileVideo to set
	 */
	public void setFileVideo(CommonsMultipartFile fileVideo) {
		this.fileVideo = fileVideo;
	}

	/**
	 * @return the inputStreamResume
	 */
	public InputStream getInputStreamResume() {
		return inputStreamResume;
	}

	/**
	 * @param inputStreamResume
	 *            the inputStreamResume to set
	 */
	public void setInputStreamResume(InputStream inputStreamResume) {
		this.inputStreamResume = inputStreamResume;
	}

	/**
	 * @return the inputStreamPhoto
	 */
	public InputStream getInputStreamPhoto() {
		return inputStreamPhoto;
	}

	/**
	 * @param inputStreamPhoto
	 *            the inputStreamPhoto to set
	 */
	public void setInputStreamPhoto(InputStream inputStreamPhoto) {
		this.inputStreamPhoto = inputStreamPhoto;
	}

	/**
	 * @return the inputStreamVideo
	 */
	public InputStream getInputStreamVideo() {
		return inputStreamVideo;
	}

	/**
	 * @param inputStreamVideo
	 *            the inputStreamVideo to set
	 */
	public void setInputStreamVideo(InputStream inputStreamVideo) {
		this.inputStreamVideo = inputStreamVideo;
	}

	/**
	 * @return the primarySkills
	 */
	public List<String> getPrimarySkills() {
		return primarySkills;
	}

	/**
	 * @param primarySkills
	 *            the primarySkills to set
	 */
	public void setPrimarySkills(List<String> primarySkills) {
		this.primarySkills = primarySkills;
	}

	/**
	 * @return the secondarySkills
	 */
	public List<String> getSecondarySkills() {
		return secondarySkills;
	}

	/**
	 * @param secondarySkills
	 *            the secondarySkills to set
	 */
	public void setSecondarySkills(List<String> secondarySkills) {
		this.secondarySkills = secondarySkills;
	}

	/**
	 * @return the file
	 */
	public CommonsMultipartFile getFile() {
		return file;
	}

	/**
	 * @param file
	 *            the file to set
	 */
	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}

	/**
	 * @return the jobRequestShorlisted
	 */
	public String getJobRequestShorlisted() {
		return jobRequestShorlisted;
	}

	/**
	 * @param jobRequestShorlisted
	 *            the jobRequestShorlisted to set
	 */
	public void setJobRequestShorlisted(String jobRequestShorlisted) {
		this.jobRequestShorlisted = jobRequestShorlisted;
	}

	/**
	 * @return the jobRequestOnHold
	 */
	public String getJobRequestOnHold() {
		return jobRequestOnHold;
	}

	/**
	 * @param jobRequestOnHold
	 *            the jobRequestOnHold to set
	 */
	public void setJobRequestOnHold(String jobRequestOnHold) {
		this.jobRequestOnHold = jobRequestOnHold;
	}

	/**
	 * @return the jobRequestRejected
	 */
	public String getJobRequestRejected() {
		return jobRequestRejected;
	}

	/**
	 * @param jobRequestRejected
	 *            the jobRequestRejected to set
	 */
	public void setJobRequestRejected(String jobRequestRejected) {
		this.jobRequestRejected = jobRequestRejected;
	}

	/**
	 * @return the jobRequestStatus
	 */
	public String getJobRequestStatus() {
		return jobRequestStatus;
	}

	/**
	 * @param jobRequestStatus
	 *            the jobRequestStatus to set
	 */
	public void setJobRequestStatus(String jobRequestStatus) {
		this.jobRequestStatus = jobRequestStatus;
	}

	/**
	 * @return the g_startMonth_duration
	 */
	public String getG_startMonth_duration() {
		return g_startMonth_duration;
	}

	/**
	 * @param g_startMonth_duration the g_startMonth_duration to set
	 */
	public void setG_startMonth_duration(String g_startMonth_duration) {
		this.g_startMonth_duration = g_startMonth_duration;
	}

	/**
	 * @return the g_startYear_duration
	 */
	public String getG_startYear_duration() {
		return g_startYear_duration;
	}

	/**
	 * @param g_startYear_duration the g_startYear_duration to set
	 */
	public void setG_startYear_duration(String g_startYear_duration) {
		this.g_startYear_duration = g_startYear_duration;
	}

	/**
	 * @return the g_endMonth_duration
	 */
	public String getG_endMonth_duration() {
		return g_endMonth_duration;
	}

	/**
	 * @param g_endMonth_duration the g_endMonth_duration to set
	 */
	public void setG_endMonth_duration(String g_endMonth_duration) {
		this.g_endMonth_duration = g_endMonth_duration;
	}

	/**
	 * @return the g_endYear_duration
	 */
	public String getG_endYear_duration() {
		return g_endYear_duration;
	}

	/**
	 * @param g_endYear_duration the g_endYear_duration to set
	 */
	public void setG_endYear_duration(String g_endYear_duration) {
		this.g_endYear_duration = g_endYear_duration;
	}

	/**
	 * @return the h_startMonth_duration
	 */
	public String getH_startMonth_duration() {
		return h_startMonth_duration;
	}

	/**
	 * @param h_startMonth_duration the h_startMonth_duration to set
	 */
	public void setH_startMonth_duration(String h_startMonth_duration) {
		this.h_startMonth_duration = h_startMonth_duration;
	}

	/**
	 * @return the h_startYear_duration
	 */
	public String getH_startYear_duration() {
		return h_startYear_duration;
	}

	/**
	 * @param h_startYear_duration the h_startYear_duration to set
	 */
	public void setH_startYear_duration(String h_startYear_duration) {
		this.h_startYear_duration = h_startYear_duration;
	}

	/**
	 * @return the h_endMonth_duration
	 */
	public String getH_endMonth_duration() {
		return h_endMonth_duration;
	}

	/**
	 * @param h_endMonth_duration the h_endMonth_duration to set
	 */
	public void setH_endMonth_duration(String h_endMonth_duration) {
		this.h_endMonth_duration = h_endMonth_duration;
	}

	/**
	 * @return the h_endYear_duration
	 */
	public String getH_endYear_duration() {
		return h_endYear_duration;
	}

	/**
	 * @param h_endYear_duration the h_endYear_duration to set
	 */
	public void setH_endYear_duration(String h_endYear_duration) {
		this.h_endYear_duration = h_endYear_duration;
	}

	/**
	 * @return the w_startMonth_duration
	 */
	public String getW_startMonth_duration() {
		return w_startMonth_duration;
	}

	/**
	 * @param w_startMonth_duration the w_startMonth_duration to set
	 */
	public void setW_startMonth_duration(String w_startMonth_duration) {
		this.w_startMonth_duration = w_startMonth_duration;
	}

	/**
	 * @return the w_startYear_duration
	 */
	public String getW_startYear_duration() {
		return w_startYear_duration;
	}

	/**
	 * @param w_startYear_duration the w_startYear_duration to set
	 */
	public void setW_startYear_duration(String w_startYear_duration) {
		this.w_startYear_duration = w_startYear_duration;
	}

	/**
	 * @return the w_endMonth_duration
	 */
	public String getW_endMonth_duration() {
		return w_endMonth_duration;
	}

	/**
	 * @param w_endMonth_duration the w_endMonth_duration to set
	 */
	public void setW_endMonth_duration(String w_endMonth_duration) {
		this.w_endMonth_duration = w_endMonth_duration;
	}

	/**
	 * @return the w_endYear_duration
	 */
	public String getW_endYear_duration() {
		return w_endYear_duration;
	}

	/**
	 * @param w_endYear_duration the w_endYear_duration to set
	 */
	public void setW_endYear_duration(String w_endYear_duration) {
		this.w_endYear_duration = w_endYear_duration;
	}

	/**
	 * @return the designation
	 */
	public String getDesignation() {
		return designation;
	}

	/**
	 * @param designation the designation to set
	 */
	public void setDesignation(String designation) {
		this.designation = designation;
	}

	/**
	 * @return the successMessage
	 */
	public String getSuccessMessage() {
		return successMessage;
	}

	/**
	 * @param successMessage
	 *            the successMessage to set
	 */
	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}

	/**
	 * @return the stateList
	 */
	public List<String> getStateList() {
		return stateList;
	}

	/**
	 * @param stateList the stateList to set
	 */
	public void setStateList(List<String> stateList) {
		this.stateList = stateList;
	}

	/**
	 * @return the courseList
	 */
	public List<String> getCourseList() {
		return courseList;
	}

	/**
	 * @param courseList the courseList to set
	 */
	public void setCourseList(List<String> courseList) {
		this.courseList = courseList;
	}

	/**
	 * @return the universityList
	 */
	public List<String> getUniversityList() {
		return universityList;
	}

	/**
	 * @param universityList the universityList to set
	 */
	public void setUniversityList(List<String> universityList) {
		this.universityList = universityList;
	}

	public Date getPosted_on() {
		return posted_on;
	}

	public void setPosted_on(Date posted_on) {
		this.posted_on = posted_on;
	}

	public Date getApplied_on() {
		return applied_on;
	}

	public void setApplied_on(Date applied_on) {
		this.applied_on = applied_on;
	}

	public List<String> getSaved_jobs_list() {
		return saved_jobs_list;
	}

	public void setSaved_jobs_list(List<String> saved_jobs_list) {
		this.saved_jobs_list = saved_jobs_list;
	}

	/**
	 * @return the industryList
	 */
	public List<String> getIndustryList() {
		return industryList;
	}

	/**
	 * @param industryList the industryList to set
	 */
	public void setIndustryList(List<String> industryList) {
		this.industryList = industryList;
	}

	/**
	 * @return the functionalAreaList
	 */
	public List<String> getFunctionalAreaList() {
		return functionalAreaList;
	}

	/**
	 * @param functionalAreaList the functionalAreaList to set
	 */
	public void setFunctionalAreaList(List<String> functionalAreaList) {
		this.functionalAreaList = functionalAreaList;
	}

	/**
	 * @return the viewedByEmployerSet
	 */
	public Set<String> getViewedByEmployerSet() {
		return viewedByEmployerSet;
	}

	/**
	 * @param viewedByEmployerSet the viewedByEmployerSet to set
	 */
	public void setViewedByEmployerSet(Set<String> viewedByEmployerSet) {
		this.viewedByEmployerSet = viewedByEmployerSet;
	}

	public boolean isFirstLogin() {
		return isFirstLogin;
	}

	public void setFirstLogin(boolean isFirstLogin) {
		this.isFirstLogin = isFirstLogin;
	}

	public String getHiddenValue() {
		return hiddenValue;
	}

	public void setHiddenValue(String hiddenValue) {
		this.hiddenValue = hiddenValue;
	}

	public Double getIScore() {
		return IScore;
	}

	public void setIScore(Double iScore) {
		IScore = iScore;
	}

	/**
	 * @return the iScore
	 */
	public Double getiScore() {
		return iScore;
	}

	/**
	 * @param iScore the iScore to set
	 */
	public void setiScore(Double iScore) {
		this.iScore = iScore;
	}

	public List getCertificationsList() {
		return certificationsList;
	}

	public void setCertificationsList(List certificationsList) {
		this.certificationsList = certificationsList;
	}

	public List getPublicationsList() {
		return publicationsList;
	}

	public void setPublicationsList(List publicationsList) {
		this.publicationsList = publicationsList;
	}

	public boolean isProfileVisibility() {
		return profileVisibility;
	}

	public void setProfileVisibility(boolean profileVisibility) {
		this.profileVisibility = profileVisibility;
	}

	public Map<String, Boolean> getMailSettingsMap() {
		return mailSettingsMap;
	}

	public void setMailSettingsMap(Map<String, Boolean> mailSettingsMap) {
		this.mailSettingsMap = mailSettingsMap;
	}

	public Map<String, Object> getViewedByCompaniesMap() {
		return viewedByCompaniesMap;
	}

	public void setViewedByCompaniesMap(Map<String, Object> viewedByCompaniesMap) {
		this.viewedByCompaniesMap = viewedByCompaniesMap;
	}

	/**
	 * @return the workMap
	 */
	public Map<String, String> getWorkMap() {
		return workMap;
	}

	/**
	 * @param workMap the workMap to set
	 */
	public void setWorkMap(Map<String, String> workMap) {
		this.workMap = workMap;
	}

	/**
	 * @return the schoolMap
	 */
	public Map<String, String> getSchoolMap() {
		return schoolMap;
	}

	/**
	 * @param schoolMap the schoolMap to set
	 */
	public void setSchoolMap(Map<String, String> schoolMap) {
		this.schoolMap = schoolMap;
	}

	/**
	 * @return the universityMap
	 */
	public Map<String, String> getUniversityMap() {
		return universityMap;
	}

	/**
	 * @param universityMap the universityMap to set
	 */
	public void setUniversityMap(Map<String, String> universityMap) {
		this.universityMap = universityMap;
	}

	/**
	 * @return the jobList
	 */
	public List<JobDetailsDom> getJobList() {
		return jobList;
	}

	/**
	 * @param jobList the jobList to set
	 */
	public void setJobList(List<JobDetailsDom> jobList) {
		this.jobList = jobList;
	}

	/**
	 * @return the jobStatus
	 */
	public Map<String, String> getJobStatus() {
		return JobStatus;
	}

	/**
	 * @param jobStatus the jobStatus to set
	 */
	public void setJobStatus(Map<String, String> jobStatus) {
		JobStatus = jobStatus;
	}

	/**
	 * @return the internshipStatus
	 */
	public Map<String, String> getInternshipStatus() {
		return internshipStatus;
	}

	/**
	 * @param internshipStatus the internshipStatus to set
	 */
	public void setInternshipStatus(Map<String, String> internshipStatus) {
		this.internshipStatus = internshipStatus;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getEducationalQualification() {
		return educationalQualification;
	}

	public void setEducationalQualification(String educationalQualification) {
		this.educationalQualification = educationalQualification;
	}

	public boolean isSpring() {
		return spring;
	}

	public void setSpring(boolean spring) {
		this.spring = spring;
	}

	public boolean isFall() {
		return fall;
	}

	public void setFall(boolean fall) {
		this.fall = fall;
	}

	public boolean isWinter() {
		return winter;
	}

	public void setWinter(boolean winter) {
		this.winter = winter;
	}

	public boolean isSummer() {
		return summer;
	}

	public void setSummer(boolean summer) {
		this.summer = summer;
	}

	public boolean isSaveSearchParameter() {
		return saveSearchParameter;
	}

	public void setSaveSearchParameter(boolean saveSearchParameter) {
		this.saveSearchParameter = saveSearchParameter;
	}

	public Integer getFromExperience() {
		return fromExperience;
	}

	public void setFromExperience(Integer fromExperience) {
		this.fromExperience = fromExperience;
	}

	public Integer getToExperience() {
		return toExperience;
	}

	public void setToExperience(Integer toExperience) {
		this.toExperience = toExperience;
	}

	public Integer getFromGpa() {
		return fromGpa;
	}

	public void setFromGpa(Integer fromGpa) {
		this.fromGpa = fromGpa;
	}

	public Integer getToGpa() {
		return toGpa;
	}

	public void setToGpa(Integer toGpa) {
		this.toGpa = toGpa;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getYearOfPassing() {
		return yearOfPassing;
	}

	public void setYearOfPassing(String yearOfPassing) {
		this.yearOfPassing = yearOfPassing;
	}

	public String getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(String lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUniversityname() {
		return universityname;
	}

	public void setUniversityname(String universityname) {
		this.universityname = universityname;
	}

	public String getSortlist() {
		return sortlist;
	}

	public void setSortlist(String sortlist) {
		this.sortlist = sortlist;
	}

	public String getOnhold() {
		return onhold;
	}

	public void setOnhold(String onhold) {
		this.onhold = onhold;
	}

	public String getReject() {
		return reject;
	}

	public void setReject(String reject) {
		this.reject = reject;
	}

	public String[] getCandidateEmailId() {
		return candidateEmailId;
	}

	public void setCandidateEmailId(String[] candidateEmailId) {
		this.candidateEmailId = candidateEmailId;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public List<String> getEducationalQualifications() {
		return educationalQualifications;
	}

	public void setEducationalQualifications(List<String> educationalQualifications) {
		this.educationalQualifications = educationalQualifications;
	}

	public PortfolioDetailsDom getUniversityDetails() {
		return universityDetails;
	}

	public void setUniversityDetails(PortfolioDetailsDom universityDetails) {
		this.universityDetails = universityDetails;
		
	}

	public Boolean getEditMode() {
		return editMode;
	}

	public void setEditMode(Boolean editMode) {
		this.editMode = editMode;
	}

	/**
	 * @return the campusJobStatus
	 */
	public Map<String, String> getCampusJobStatus() {
		return campusJobStatus;
	}

	/**
	 * @param campusJobStatus the campusJobStatus to set
	 */
	public void setCampusJobStatus(Map<String, String> campusJobStatus) {
		this.campusJobStatus = campusJobStatus;
	}

	/**
	 * @return the campusInternshipStatus
	 */
	public Map<String, String> getCampusInternshipStatus() {
		return campusInternshipStatus;
	}

	/**
	 * @param campusInternshipStatus the campusInternshipStatus to set
	 */
	public void setCampusInternshipStatus(Map<String, String> campusInternshipStatus) {
		this.campusInternshipStatus = campusInternshipStatus;
	}
	
}