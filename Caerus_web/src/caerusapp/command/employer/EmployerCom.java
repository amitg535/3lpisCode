package caerusapp.command.employer;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import caerusapp.util.CaerusStringConstants;
import caerusapp.util.ValidatorMessageConstants;

public class EmployerCom implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3696482518093656125L;

	@NotEmpty(message = ValidatorMessageConstants.ADDRESS_EMPTY)
	private String addressLine1;
	
	@NotEmpty(message = ValidatorMessageConstants.ADMIN_FIRST_NAME_EMPTY)
	private String firstName;
	
	@NotEmpty(message = ValidatorMessageConstants.ADMIN_LAST_NAME_EMPTY)
	private String lastName;

	@NotEmpty(message = ValidatorMessageConstants.REGISTRATION_NUMBER_EMPTY)
	private String companyRegNumber;
	
	@Size(min = 6,max = 16,message = ValidatorMessageConstants.PHONE_NUMBER_SIZE) 
	@Pattern(regexp = CaerusStringConstants.PHONE_NUMBER_REGEX,message=ValidatorMessageConstants.PHONE_NUMBER_PATTERN)
	private String phoneNumber;
	
	@NotEmpty(message = ValidatorMessageConstants.STATE_EMPTY)
	private String state;
	
	@NotEmpty(message = ValidatorMessageConstants.CITY_EMPTY)
	private String city;
	
	@NotEmpty(message = ValidatorMessageConstants.ZIPCODE_EMPTY)
	private String postalCode;
	
	@AssertTrue(message = ValidatorMessageConstants.ACCEPT_TERMS_AND_CONDITIONS)
	private boolean termsAndConditions;
	
	@Pattern(regexp ="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(?:[a-zA-Z]{2,6})$", message = ValidatorMessageConstants.EMAIL_ID_SYNTAX) @NotEmpty(message = ValidatorMessageConstants.ADMIN_EMAIL_ID_EMPTY)
	private String emailID;
	
	@NotEmpty(message = ValidatorMessageConstants.INDUSTRY_EMPTY)
	private String industry;
	
	@NotEmpty(message = ValidatorMessageConstants.COMPANY_TYPE_EMPTY)
	private String companyType;
	
	@NotEmpty(message = ValidatorMessageConstants.COMPANY_NAME_EMPTY)
	private String companyName;
	
	private String userName;
	private String password;
	private String confirmPassword;
	private String confirmEmailID;
	private String nameThisProfile;
	private String currentLocation;
	private String country;
	private String title;
	private String postCode;
	private String addressLine2;
	private String companyDesc;
	private String authority;
	private String plan;
	private String contactPersonName;
	private String aboutCompany;
	private String companyWebsite;
	private String linkedInAddress;
	private String noOfEmployees;
	private String imageName;
	private String fileNameVideo;
	private String fileSize;
	private String fileMimeType;
	private String postedOn;	
	private String workingWithUs;
	private String hiringProcess;
	private String brochureName;
	private String keywords;
	private String planName;
	private String role;
	private String status;	
	private String mCorporateUserAction;
	private String emailexception;
	private String regexception;
	private String fileName;
	private Integer loginAttempts;
	
	
	
	private Long fileId;
	
	private Boolean isAdminFlag;

	private MultipartFile image;
	private MultipartFile brochure;
	private MultipartFile video;
	private CommonsMultipartFile file;

	private String[] corporateUserEmailID;
	private String[] corporateUserName;
	private String[] corporateUserRole;
	private String[] corporateUserStatus;
	
	private byte[] imageData;
	private byte[] videoFileData;
	private byte[] brochureData;
	
	private byte[] fileData;
	private CommonsMultipartFile fileVideo;
	
	private List<String> companyList;
	private List<String> industryList;
	private List<String> faxNumbers;
	
	private Map<String,String> companyLocations;
	
	private boolean mailMe;
	private boolean exceptionOccured = false;
	private boolean emailexceptionOccured = false;
	private boolean regexceptionOccured = false;
	
	private String photoName;
	
	public List<String> getFaxNumbers() {
		return faxNumbers;
	}
	public void setFaxNumbers(List<String> faxNumbers) {
		this.faxNumbers = faxNumbers;
	}	
	public CommonsMultipartFile getFileVideo() {
		return fileVideo;
	}
	public void setFileVideo(CommonsMultipartFile fileVideo) {
		this.fileVideo = fileVideo;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmailID() {
		return emailID;
	}
	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	public String getConfirmEmailID() {
		return confirmEmailID;
	}
	public void setConfirmEmailID(String confirmEmailID) {
		this.confirmEmailID = confirmEmailID;
	}
	public String getNameThisProfile() {
		return nameThisProfile;
	}
	public void setNameThisProfile(String nameThisProfile) {
		this.nameThisProfile = nameThisProfile;
	}
	public String getCurrentLocation() {
		return currentLocation;
	}
	public void setCurrentLocation(String currentLocation) {
		this.currentLocation = currentLocation;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getCompanyDesc() {
		return companyDesc;
	}
	public void setCompanyDesc(String companyDesc) {
		this.companyDesc = companyDesc;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getCompanyRegNumber() {
		return companyRegNumber;
	}
	public void setCompanyRegNumber(String companyRegNumber) {
		this.companyRegNumber = companyRegNumber;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public String getContactPersonName() {
		return contactPersonName;
	}
	public void setContactPersonName(String contactPersonName) {
		this.contactPersonName = contactPersonName;
	}
	public String getCompanyType() {
		return companyType;
	}
	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}
	public String getAboutCompany() {
		return aboutCompany;
	}
	public void setAboutCompany(String aboutCompany) {
		this.aboutCompany = aboutCompany;
	}
	public String getCompanyWebsite() {
		return companyWebsite;
	}
	public void setCompanyWebsite(String companyWebsite) {
		this.companyWebsite = companyWebsite;
	}
	public String getLinkedInAddress() {
		return linkedInAddress;
	}
	public void setLinkedInAddress(String linkedInAddress) {
		this.linkedInAddress = linkedInAddress;
	}
	public String getNoOfEmployees() {
		return noOfEmployees;
	}
	public void setNoOfEmployees(String noOfEmployees) {
		this.noOfEmployees = noOfEmployees;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public String getFileNameVideo() {
		return fileNameVideo;
	}
	public void setFileNameVideo(String fileNameVideo) {
		this.fileNameVideo = fileNameVideo;
	}
	public byte[] getImageData() {
		return imageData;
	}
	public void setImageData(byte[] imageData) {
		this.imageData = imageData;
	}
	public byte[] getVideoFileData() {
		return videoFileData;
	}
	public void setVideoFileData(byte[] videoFileData) {
		this.videoFileData = videoFileData;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileMimeType() {
		return fileMimeType;
	}
	public void setFileMimeType(String fileMimeType) {
		this.fileMimeType = fileMimeType;
	}
	public String getPostedOn() {
		return postedOn;
	}
	public void setPostedOn(String postedOn) {
		this.postedOn = postedOn;
	}
	public List<String> getCompanyList() {
		return companyList;
	}
	public void setCompanyList(List<String> companyList) {
		this.companyList = companyList;
	}
	public List<String> getIndustryList() {
		return industryList;
	}
	public void setIndustryList(List<String> industryList) {
		this.industryList = industryList;
	}
	public Map<String, String> getCompanyLocations() {
		return companyLocations;
	}
	public void setCompanyLocations(Map<String, String> companyLocations) {
		this.companyLocations = companyLocations;
	}
	public String getWorkingWithUs() {
		return workingWithUs;
	}
	public void setWorkingWithUs(String workingWithUs) {
		this.workingWithUs = workingWithUs;
	}
	public String getHiringProcess() {
		return hiringProcess;
	}
	public void setHiringProcess(String hiringProcess) {
		this.hiringProcess = hiringProcess;
	}
	public MultipartFile getBrochure() {
		return brochure;
	}
	public void setBrochure(MultipartFile brochure) {
		this.brochure = brochure;
	}
	public String getBrochureName() {
		return brochureName;
	}
	public void setBrochureName(String brochureName) {
		this.brochureName = brochureName;
	}
	public byte[] getBrochureData() {
		return brochureData;
	}
	public void setBrochureData(byte[] brochureData) {
		this.brochureData = brochureData;
	}
	public Boolean getIsAdminFlag() {
		return isAdminFlag;
	}
	public void setIsAdminFlag(Boolean isAdminFlag) {
		this.isAdminFlag = isAdminFlag;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getmCorporateUserAction() {
		return mCorporateUserAction;
	}
	public void setmCorporateUserAction(String mCorporateUserAction) {
		this.mCorporateUserAction = mCorporateUserAction;
	}
	public boolean isTermsAndConditions() {
		return termsAndConditions;
	}
	public void setTermsAndConditions(boolean termsAndConditions) {
		this.termsAndConditions = termsAndConditions;
	}
	public boolean isMailMe() {
		return mailMe;
	}
	public void setMailMe(boolean mailMe) {
		this.mailMe = mailMe;
	}
	public boolean isExceptionOccured() {
		return exceptionOccured;
	}
	public void setExceptionOccured(boolean exceptionOccured) {
		this.exceptionOccured = exceptionOccured;
	}
	public String getEmailexception() {
		return emailexception;
	}
	public void setEmailexception(String emailexception) {
		this.emailexception = emailexception;
	}
	public boolean isEmailexceptionOccured() {
		return emailexceptionOccured;
	}
	public void setEmailexceptionOccured(boolean emailexceptionOccured) {
		this.emailexceptionOccured = emailexceptionOccured;
	}
	public String getRegexception() {
		return regexception;
	}
	public void setRegexception(String regexception) {
		this.regexception = regexception;
	}
	public boolean isRegexceptionOccured() {
		return regexceptionOccured;
	}
	public void setRegexceptionOccured(boolean regexceptionOccured) {
		this.regexceptionOccured = regexceptionOccured;
	}
	public MultipartFile getVideo() {
		return video;
	}
	public void setVideo(MultipartFile video) {
		this.video = video;
	}
	public String[] getCorporateUserEmailID() {
		return corporateUserEmailID;
	}
	public void setCorporateUserEmailID(String[] corporateUserEmailID) {
		this.corporateUserEmailID = corporateUserEmailID;
	}
	public String[] getCorporateUserName() {
		return corporateUserName;
	}
	public void setCorporateUserName(String[] corporateUserName) {
		this.corporateUserName = corporateUserName;
	}
	public String[] getCorporateUserRole() {
		return corporateUserRole;
	}
	public void setCorporateUserRole(String[] corporateUserRole) {
		this.corporateUserRole = corporateUserRole;
	}
	public String[] getCorporateUserStatus() {
		return corporateUserStatus;
	}
	public void setCorporateUserStatus(String[] corporateUserStatus) {
		this.corporateUserStatus = corporateUserStatus;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public byte[] getFileData() {
		return fileData;
	}
	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}
	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}
	public Integer getLoginAttempts() {
		return loginAttempts;
	}
	public void setLoginAttempts(Integer loginAttempts) {
		this.loginAttempts = loginAttempts;
	}
	
	
}
