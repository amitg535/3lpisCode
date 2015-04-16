/**
 * 
 */
package caerusapp.domain.university;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @author pallavid
 *
 */
public class UniversityDetailsDom {
	
	private String universityName;
	private String phoneNumber;
	private String zipCode;
	private String city;
	private String contactPerson;
	private String universityRegistrationNumber;
	private String universityAddress;
	private String state;
	private String contactPersonEmailId;
	private boolean termsAndConditions;;
	private boolean mailMe;
	private String authority;
	private String countryName;
	private String countryCode;

	private String placementExecutiveName;
	private String placementExecutiveRole;
	private String placementExecutiveEmailId;
	private String placementExecutiveStatus;

	private String caerusCommonExceptionMessage;
	private String duplicateExceptionMessage;
	private String doesNotExistExceptionMessage;
	private boolean exceptionOccured = false;
	private String successMessage;
	
	private String universityWebsite;
	private String aboutUs;
	private CommonsMultipartFile universityLogo;
	private String universityLogoName;
	private InputStream inputStream;
	private byte[] photoData;
	
	private String firstName;
	private String lastName;
	private String emailID;
	
	private Boolean adminFlag;
	
	private String password;
	
	private String confirmPassword;
	
	private String ugFullTimeStudents;
	
	private String ugPartTimeStudents;
	
	private String pgFullTimeStudents;
	
	private String pgPartTimeStudents;
	
	private String noOfTeachingStaff;
	
	private String noOfResearchStaff;
	
	private String noOfSupportStaff;
	
	private String autumnStartDate;
	
	private String springStartDate;
	
	private String summerStartDate;
	
	private String autumnEndDate;
	
	private String springEndDate;
	
	private String summerEndDate;
	
	private List<String> awardsAndRecognitionList;
	
	private List<String> courseType;
	
	private List<String> courseName;
	
	private String selectJob;
	private String jobIdAndFirmId;
	private String univId;
	private String aboutTheCompany;
	private String address;
	private String candidateProfileDescription;
	private String jobDescription;
	private String uploadFileName;
	private String companyName;
	private String functionalArea;
	private String industry;
	private String jobId;
	private String firmId;
	private String jobTitle;
	private String natureOfJob;
	private String keywords;
	private String jobLocation;
	private String numberOfVacancies;
	private String postGraduateQualification;
	private String postedOn;
	private String questionnaire;
	private String responseCount;
	private String salaryDetails;
	private String telephone;
	private String flag;
	private String status;
	private boolean showInternationalLocations;
	private String underGraduateQualification;
	private boolean setResponsePreferences;
	private String emailAddress;
	private byte[] fileData;
	public InputStream fileInputStream;
	private CommonsMultipartFile uploadFile;

	private String[] university;

	
	 private Map<String,String> registeredStudents;
	 private Map<String,String> unregisteredStudents;
	 private String batch;
	 
	 private HashMap campusJobAppliedStudents;
	 private HashMap campusIntenshipappliedStudents;
	/**
	 * @return the universityName
	 */
	public String getUniversityName() {
		return universityName;
	}
	/**
	 * @param universityName the universityName to set
	 */
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}
	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
		return phoneNumber;
	}
	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	/**
	 * @return the zipCode
	 */
	public String getZipCode() {
		return zipCode;
	}
	/**
	 * @param zipCode the zipCode to set
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
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the contactPerson
	 */
	public String getContactPerson() {
		return contactPerson;
	}
	/**
	 * @param contactPerson the contactPerson to set
	 */
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	/**
	 * @return the universityRegistrationNumber
	 */
	public String getUniversityRegistrationNumber() {
		return universityRegistrationNumber;
	}
	/**
	 * @param universityRegistrationNumber the universityRegistrationNumber to set
	 */
	public void setUniversityRegistrationNumber(String universityRegistrationNumber) {
		this.universityRegistrationNumber = universityRegistrationNumber;
	}
	/**
	 * @return the universityAddress
	 */
	public String getUniversityAddress() {
		return universityAddress;
	}
	/**
	 * @param universityAddress the universityAddress to set
	 */
	public void setUniversityAddress(String universityAddress) {
		this.universityAddress = universityAddress;
	}
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * @return the contactPersonEmailId
	 */
	public String getContactPersonEmailId() {
		return contactPersonEmailId;
	}
	/**
	 * @param contactPersonEmailId the contactPersonEmailId to set
	 */
	public void setContactPersonEmailId(String contactPersonEmailId) {
		this.contactPersonEmailId = contactPersonEmailId;
	}
	/**
	 * @return the termsAndConditions
	 */
	public boolean isTermsAndConditions() {
		return termsAndConditions;
	}
	/**
	 * @param termsAndConditions the termsAndConditions to set
	 */
	public void setTermsAndConditions(boolean termsAndConditions) {
		this.termsAndConditions = termsAndConditions;
	}
	/**
	 * @return the mailMe
	 */
	public boolean isMailMe() {
		return mailMe;
	}
	/**
	 * @param mailMe the mailMe to set
	 */
	public void setMailMe(boolean mailMe) {
		this.mailMe = mailMe;
	}
	/**
	 * @return the authority
	 */
	public String getAuthority() {
		return authority;
	}
	/**
	 * @param authority the authority to set
	 */
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	/**
	 * @return the countryName
	 */
	public String getCountryName() {
		return countryName;
	}
	/**
	 * @param countryName the countryName to set
	 */
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	/**
	 * @return the countryCode
	 */
	public String getCountryCode() {
		return countryCode;
	}
	/**
	 * @param countryCode the countryCode to set
	 */
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	/**
	 * @return the placementExecutiveName
	 */
	public String getPlacementExecutiveName() {
		return placementExecutiveName;
	}
	/**
	 * @param placementExecutiveName the placementExecutiveName to set
	 */
	public void setPlacementExecutiveName(String placementExecutiveName) {
		this.placementExecutiveName = placementExecutiveName;
	}
	/**
	 * @return the placementExecutiveRole
	 */
	public String getPlacementExecutiveRole() {
		return placementExecutiveRole;
	}
	/**
	 * @param placementExecutiveRole the placementExecutiveRole to set
	 */
	public void setPlacementExecutiveRole(String placementExecutiveRole) {
		this.placementExecutiveRole = placementExecutiveRole;
	}
	/**
	 * @return the placementExecutiveEmailId
	 */
	public String getPlacementExecutiveEmailId() {
		return placementExecutiveEmailId;
	}
	/**
	 * @param placementExecutiveEmailId the placementExecutiveEmailId to set
	 */
	public void setPlacementExecutiveEmailId(String placementExecutiveEmailId) {
		this.placementExecutiveEmailId = placementExecutiveEmailId;
	}
	/**
	 * @return the placementExecutiveStatus
	 */
	public String getPlacementExecutiveStatus() {
		return placementExecutiveStatus;
	}
	/**
	 * @param placementExecutiveStatus the placementExecutiveStatus to set
	 */
	public void setPlacementExecutiveStatus(String placementExecutiveStatus) {
		this.placementExecutiveStatus = placementExecutiveStatus;
	}
	/**
	 * @return the caerusCommonExceptionMessage
	 */
	public String getCaerusCommonExceptionMessage() {
		return caerusCommonExceptionMessage;
	}
	/**
	 * @param caerusCommonExceptionMessage the caerusCommonExceptionMessage to set
	 */
	public void setCaerusCommonExceptionMessage(String caerusCommonExceptionMessage) {
		this.caerusCommonExceptionMessage = caerusCommonExceptionMessage;
	}
	/**
	 * @return the duplicateExceptionMessage
	 */
	public String getDuplicateExceptionMessage() {
		return duplicateExceptionMessage;
	}
	/**
	 * @param duplicateExceptionMessage the duplicateExceptionMessage to set
	 */
	public void setDuplicateExceptionMessage(String duplicateExceptionMessage) {
		this.duplicateExceptionMessage = duplicateExceptionMessage;
	}
	/**
	 * @return the doesNotExistExceptionMessage
	 */
	public String getDoesNotExistExceptionMessage() {
		return doesNotExistExceptionMessage;
	}
	/**
	 * @param doesNotExistExceptionMessage the doesNotExistExceptionMessage to set
	 */
	public void setDoesNotExistExceptionMessage(String doesNotExistExceptionMessage) {
		this.doesNotExistExceptionMessage = doesNotExistExceptionMessage;
	}
	/**
	 * @return the exceptionOccured
	 */
	public boolean isExceptionOccured() {
		return exceptionOccured;
	}
	/**
	 * @param exceptionOccured the exceptionOccured to set
	 */
	public void setExceptionOccured(boolean exceptionOccured) {
		this.exceptionOccured = exceptionOccured;
	}
	/**
	 * @return the successMessage
	 */
	public String getSuccessMessage() {
		return successMessage;
	}
	/**
	 * @param successMessage the successMessage to set
	 */
	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}
	/**
	 * @return the universityWebsite
	 */
	public String getUniversityWebsite() {
		return universityWebsite;
	}
	/**
	 * @param universityWebsite the universityWebsite to set
	 */
	public void setUniversityWebsite(String universityWebsite) {
		this.universityWebsite = universityWebsite;
	}
	/**
	 * @return the aboutUs
	 */
	public String getAboutUs() {
		return aboutUs;
	}
	/**
	 * @param aboutUs the aboutUs to set
	 */
	public void setAboutUs(String aboutUs) {
		this.aboutUs = aboutUs;
	}
	/**
	 * @return the universityLogo
	 */
	public CommonsMultipartFile getUniversityLogo() {
		return universityLogo;
	}
	/**
	 * @param universityLogo the universityLogo to set
	 */
	public void setUniversityLogo(CommonsMultipartFile universityLogo) {
		this.universityLogo = universityLogo;
	}
	/**
	 * @return the universityLogoName
	 */
	public String getUniversityLogoName() {
		return universityLogoName;
	}
	/**
	 * @param universityLogoName the universityLogoName to set
	 */
	public void setUniversityLogoName(String universityLogoName) {
		this.universityLogoName = universityLogoName;
	}
	/**
	 * @return the inputStream
	 */
	public InputStream getInputStream() {
		return inputStream;
	}
	/**
	 * @param inputStream the inputStream to set
	 */
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	/**
	 * @return the photoData
	 */
	public byte[] getPhotoData() {
		return photoData;
	}
	/**
	 * @param photoData the photoData to set
	 */
	public void setPhotoData(byte[] photoData) {
		this.photoData = photoData;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/**
	 * @return the emailID
	 */
	public String getEmailID() {
		return emailID;
	}
	/**
	 * @param emailID the emailID to set
	 */
	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}
	/**
	 * @return the adminFlag
	 */
	public Boolean getAdminFlag() {
		return adminFlag;
	}
	/**
	 * @param adminFlag the adminFlag to set
	 */
	public void setAdminFlag(Boolean adminFlag) {
		this.adminFlag = adminFlag;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the confirmPassword
	 */
	public String getConfirmPassword() {
		return confirmPassword;
	}
	/**
	 * @param confirmPassword the confirmPassword to set
	 */
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	/**
	 * @return the ugFullTimeStudents
	 */
	public String getUgFullTimeStudents() {
		return ugFullTimeStudents;
	}
	/**
	 * @param ugFullTimeStudents the ugFullTimeStudents to set
	 */
	public void setUgFullTimeStudents(String ugFullTimeStudents) {
		this.ugFullTimeStudents = ugFullTimeStudents;
	}
	/**
	 * @return the ugPartTimeStudents
	 */
	public String getUgPartTimeStudents() {
		return ugPartTimeStudents;
	}
	/**
	 * @param ugPartTimeStudents the ugPartTimeStudents to set
	 */
	public void setUgPartTimeStudents(String ugPartTimeStudents) {
		this.ugPartTimeStudents = ugPartTimeStudents;
	}
	/**
	 * @return the pgFullTimeStudents
	 */
	public String getPgFullTimeStudents() {
		return pgFullTimeStudents;
	}
	/**
	 * @param pgFullTimeStudents the pgFullTimeStudents to set
	 */
	public void setPgFullTimeStudents(String pgFullTimeStudents) {
		this.pgFullTimeStudents = pgFullTimeStudents;
	}
	/**
	 * @return the pgPartTimeStudents
	 */
	public String getPgPartTimeStudents() {
		return pgPartTimeStudents;
	}
	/**
	 * @param pgPartTimeStudents the pgPartTimeStudents to set
	 */
	public void setPgPartTimeStudents(String pgPartTimeStudents) {
		this.pgPartTimeStudents = pgPartTimeStudents;
	}
	/**
	 * @return the noOfTeachingStaff
	 */
	public String getNoOfTeachingStaff() {
		return noOfTeachingStaff;
	}
	/**
	 * @param noOfTeachingStaff the noOfTeachingStaff to set
	 */
	public void setNoOfTeachingStaff(String noOfTeachingStaff) {
		this.noOfTeachingStaff = noOfTeachingStaff;
	}
	/**
	 * @return the noOfResearchStaff
	 */
	public String getNoOfResearchStaff() {
		return noOfResearchStaff;
	}
	/**
	 * @param noOfResearchStaff the noOfResearchStaff to set
	 */
	public void setNoOfResearchStaff(String noOfResearchStaff) {
		this.noOfResearchStaff = noOfResearchStaff;
	}
	/**
	 * @return the noOfSupportStaff
	 */
	public String getNoOfSupportStaff() {
		return noOfSupportStaff;
	}
	/**
	 * @param noOfSupportStaff the noOfSupportStaff to set
	 */
	public void setNoOfSupportStaff(String noOfSupportStaff) {
		this.noOfSupportStaff = noOfSupportStaff;
	}
	/**
	 * @return the autumnStartDate
	 */
	public String getAutumnStartDate() {
		return autumnStartDate;
	}
	/**
	 * @param autumnStartDate the autumnStartDate to set
	 */
	public void setAutumnStartDate(String autumnStartDate) {
		this.autumnStartDate = autumnStartDate;
	}
	/**
	 * @return the springStartDate
	 */
	public String getSpringStartDate() {
		return springStartDate;
	}
	/**
	 * @param springStartDate the springStartDate to set
	 */
	public void setSpringStartDate(String springStartDate) {
		this.springStartDate = springStartDate;
	}
	/**
	 * @return the summerStartDate
	 */
	public String getSummerStartDate() {
		return summerStartDate;
	}
	/**
	 * @param summerStartDate the summerStartDate to set
	 */
	public void setSummerStartDate(String summerStartDate) {
		this.summerStartDate = summerStartDate;
	}
	/**
	 * @return the autumnEndDate
	 */
	public String getAutumnEndDate() {
		return autumnEndDate;
	}
	/**
	 * @param autumnEndDate the autumnEndDate to set
	 */
	public void setAutumnEndDate(String autumnEndDate) {
		this.autumnEndDate = autumnEndDate;
	}
	/**
	 * @return the springEndDate
	 */
	public String getSpringEndDate() {
		return springEndDate;
	}
	/**
	 * @param springEndDate the springEndDate to set
	 */
	public void setSpringEndDate(String springEndDate) {
		this.springEndDate = springEndDate;
	}
	/**
	 * @return the summerEndDate
	 */
	public String getSummerEndDate() {
		return summerEndDate;
	}
	/**
	 * @param summerEndDate the summerEndDate to set
	 */
	public void setSummerEndDate(String summerEndDate) {
		this.summerEndDate = summerEndDate;
	}
	/**
	 * @return the awardsAndRecognitionList
	 */
	public List<String> getAwardsAndRecognitionList() {
		return awardsAndRecognitionList;
	}
	/**
	 * @param awardsAndRecognitionList the awardsAndRecognitionList to set
	 */
	public void setAwardsAndRecognitionList(List<String> awardsAndRecognitionList) {
		this.awardsAndRecognitionList = awardsAndRecognitionList;
	}
	/**
	 * @return the courseType
	 */
	public List<String> getCourseType() {
		return courseType;
	}
	/**
	 * @param courseType the courseType to set
	 */
	public void setCourseType(List<String> courseType) {
		this.courseType = courseType;
	}
	/**
	 * @return the courseName
	 */
	public List<String> getCourseName() {
		return courseName;
	}
	/**
	 * @param courseName the courseName to set
	 */
	public void setCourseName(List<String> courseName) {
		this.courseName = courseName;
	}
	/**
	 * @return the selectJob
	 */
	public String getSelectJob() {
		return selectJob;
	}
	/**
	 * @param selectJob the selectJob to set
	 */
	public void setSelectJob(String selectJob) {
		this.selectJob = selectJob;
	}
	/**
	 * @return the jobIdAndFirmId
	 */
	public String getJobIdAndFirmId() {
		return jobIdAndFirmId;
	}
	/**
	 * @param jobIdAndFirmId the jobIdAndFirmId to set
	 */
	public void setJobIdAndFirmId(String jobIdAndFirmId) {
		this.jobIdAndFirmId = jobIdAndFirmId;
	}
	/**
	 * @return the univId
	 */
	public String getUnivId() {
		return univId;
	}
	/**
	 * @param univId the univId to set
	 */
	public void setUnivId(String univId) {
		this.univId = univId;
	}
	/**
	 * @return the aboutTheCompany
	 */
	public String getAboutTheCompany() {
		return aboutTheCompany;
	}
	/**
	 * @param aboutTheCompany the aboutTheCompany to set
	 */
	public void setAboutTheCompany(String aboutTheCompany) {
		this.aboutTheCompany = aboutTheCompany;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the candidateProfileDescription
	 */
	public String getCandidateProfileDescription() {
		return candidateProfileDescription;
	}
	/**
	 * @param candidateProfileDescription the candidateProfileDescription to set
	 */
	public void setCandidateProfileDescription(String candidateProfileDescription) {
		this.candidateProfileDescription = candidateProfileDescription;
	}
	/**
	 * @return the jobDescription
	 */
	public String getJobDescription() {
		return jobDescription;
	}
	/**
	 * @param jobDescription the jobDescription to set
	 */
	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}
	/**
	 * @return the uploadFileName
	 */
	public String getUploadFileName() {
		return uploadFileName;
	}
	/**
	 * @param uploadFileName the uploadFileName to set
	 */
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	/**
	 * @return the companyName
	 */
	public String getCompanyName() {
		return companyName;
	}
	/**
	 * @param companyName the companyName to set
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	/**
	 * @return the functionalArea
	 */
	public String getFunctionalArea() {
		return functionalArea;
	}
	/**
	 * @param functionalArea the functionalArea to set
	 */
	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}
	/**
	 * @return the industry
	 */
	public String getIndustry() {
		return industry;
	}
	/**
	 * @param industry the industry to set
	 */
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	/**
	 * @return the jobId
	 */
	public String getJobId() {
		return jobId;
	}
	/**
	 * @param jobId the jobId to set
	 */
	public void setJobId(String jobId) {
		this.jobId = jobId;
	}
	/**
	 * @return the firmId
	 */
	public String getFirmId() {
		return firmId;
	}
	/**
	 * @param firmId the firmId to set
	 */
	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}
	/**
	 * @return the jobTitle
	 */
	public String getJobTitle() {
		return jobTitle;
	}
	/**
	 * @param jobTitle the jobTitle to set
	 */
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	/**
	 * @return the natureOfJob
	 */
	public String getNatureOfJob() {
		return natureOfJob;
	}
	/**
	 * @param natureOfJob the natureOfJob to set
	 */
	public void setNatureOfJob(String natureOfJob) {
		this.natureOfJob = natureOfJob;
	}
	/**
	 * @return the keywords
	 */
	public String getKeywords() {
		return keywords;
	}
	/**
	 * @param keywords the keywords to set
	 */
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	/**
	 * @return the jobLocation
	 */
	public String getJobLocation() {
		return jobLocation;
	}
	/**
	 * @param jobLocation the jobLocation to set
	 */
	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}
	/**
	 * @return the numberOfVacancies
	 */
	public String getNumberOfVacancies() {
		return numberOfVacancies;
	}
	/**
	 * @param numberOfVacancies the numberOfVacancies to set
	 */
	public void setNumberOfVacancies(String numberOfVacancies) {
		this.numberOfVacancies = numberOfVacancies;
	}
	/**
	 * @return the postGraduateQualification
	 */
	public String getPostGraduateQualification() {
		return postGraduateQualification;
	}
	/**
	 * @param postGraduateQualification the postGraduateQualification to set
	 */
	public void setPostGraduateQualification(String postGraduateQualification) {
		this.postGraduateQualification = postGraduateQualification;
	}
	/**
	 * @return the postedOn
	 */
	public String getPostedOn() {
		return postedOn;
	}
	/**
	 * @param postedOn the postedOn to set
	 */
	public void setPostedOn(String postedOn) {
		this.postedOn = postedOn;
	}
	/**
	 * @return the questionnaire
	 */
	public String getQuestionnaire() {
		return questionnaire;
	}
	/**
	 * @param questionnaire the questionnaire to set
	 */
	public void setQuestionnaire(String questionnaire) {
		this.questionnaire = questionnaire;
	}
	/**
	 * @return the responseCount
	 */
	public String getResponseCount() {
		return responseCount;
	}
	/**
	 * @param responseCount the responseCount to set
	 */
	public void setResponseCount(String responseCount) {
		this.responseCount = responseCount;
	}
	/**
	 * @return the salaryDetails
	 */
	public String getSalaryDetails() {
		return salaryDetails;
	}
	/**
	 * @param salaryDetails the salaryDetails to set
	 */
	public void setSalaryDetails(String salaryDetails) {
		this.salaryDetails = salaryDetails;
	}
	/**
	 * @return the telephone
	 */
	public String getTelephone() {
		return telephone;
	}
	/**
	 * @param telephone the telephone to set
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the showInternationalLocations
	 */
	public boolean isShowInternationalLocations() {
		return showInternationalLocations;
	}
	/**
	 * @param showInternationalLocations the showInternationalLocations to set
	 */
	public void setShowInternationalLocations(boolean showInternationalLocations) {
		this.showInternationalLocations = showInternationalLocations;
	}
	/**
	 * @return the underGraduateQualification
	 */
	public String getUnderGraduateQualification() {
		return underGraduateQualification;
	}
	/**
	 * @param underGraduateQualification the underGraduateQualification to set
	 */
	public void setUnderGraduateQualification(String underGraduateQualification) {
		this.underGraduateQualification = underGraduateQualification;
	}
	/**
	 * @return the setResponsePreferences
	 */
	public boolean isSetResponsePreferences() {
		return setResponsePreferences;
	}
	/**
	 * @param setResponsePreferences the setResponsePreferences to set
	 */
	public void setSetResponsePreferences(boolean setResponsePreferences) {
		this.setResponsePreferences = setResponsePreferences;
	}
	/**
	 * @return the emailAddress
	 */
	public String getEmailAddress() {
		return emailAddress;
	}
	/**
	 * @param emailAddress the emailAddress to set
	 */
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	/**
	 * @return the fileData
	 */
	public byte[] getFileData() {
		return fileData;
	}
	/**
	 * @param fileData the fileData to set
	 */
	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
	}
	/**
	 * @return the fileInputStream
	 */
	public InputStream getFileInputStream() {
		return fileInputStream;
	}
	/**
	 * @param fileInputStream the fileInputStream to set
	 */
	public void setFileInputStream(InputStream fileInputStream) {
		this.fileInputStream = fileInputStream;
	}
	/**
	 * @return the uploadFile
	 */
	public CommonsMultipartFile getUploadFile() {
		return uploadFile;
	}
	/**
	 * @param uploadFile the uploadFile to set
	 */
	public void setUploadFile(CommonsMultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	/**
	 * @return the university
	 */
	public String[] getUniversity() {
		return university;
	}
	/**
	 * @param university the university to set
	 */
	public void setUniversity(String[] university) {
		this.university = university;
	}
	/**
	 * @return the registeredStudents
	 */
	public Map<String,String> getRegisteredStudents() {
		return registeredStudents;
	}
	/**
	 * @param registeredStudents the registeredStudents to set
	 */
	public void setRegisteredStudents(Map<String,String> registeredStudents) {
		this.registeredStudents = registeredStudents;
	}
	/**
	 * @return the unregisteredStudents
	 */
	public Map<String,String> getUnregisteredStudents() {
		return unregisteredStudents;
	}
	/**
	 * @param unregisteredStudents the unregisteredStudents to set
	 */
	public void setUnregisteredStudents(Map<String,String> unregisteredStudents) {
		this.unregisteredStudents = unregisteredStudents;
	}
	/**
	 * @return the batch
	 */
	public String getBatch() {
		return batch;
	}
	/**
	 * @param batch the batch to set
	 */
	public void setBatch(String batch) {
		this.batch = batch;
	}
	/**
	 * @return the campusJobAppliedStudents
	 */
	public HashMap getCampusJobAppliedStudents() {
		return campusJobAppliedStudents;
	}
	/**
	 * @param campusJobAppliedStudents the campusJobAppliedStudents to set
	 */
	public void setCampusJobAppliedStudents(HashMap campusJobAppliedStudents) {
		this.campusJobAppliedStudents = campusJobAppliedStudents;
	}
	/**
	 * @return the campusIntenshipappliedStudents
	 */
	public HashMap getCampusIntenshipappliedStudents() {
		return campusIntenshipappliedStudents;
	}
	/**
	 * @param campusIntenshipappliedStudents the campusIntenshipappliedStudents to set
	 */
	public void setCampusIntenshipappliedStudents(
			HashMap campusIntenshipappliedStudents) {
		this.campusIntenshipappliedStudents = campusIntenshipappliedStudents;
	}

}
