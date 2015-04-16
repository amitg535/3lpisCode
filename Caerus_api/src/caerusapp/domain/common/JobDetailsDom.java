/**
 * 
 */
package caerusapp.domain.common;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author pallavid
 *
 */
public class JobDetailsDom {
	
	private String jobIdAndFirmId;
	private String jobTitle;
	private String jobDescription;
	private String postedOn;
	private String experienceFrom;
	private String experienceTo;
	private String functionalArea;
	private String industry;
	private String jobId;
	private String jobType;
	private String payPerWeek;
	private String location;
	private String status;
	private String zipCode;
	private String gpaCutOffFrom;
	private String gpaCutOffTo;
	private String exceptionMessage;
	private String emailId;
	private String companyName;
	private String internshipId;
	private String internshipIdAndFirmId;
	private String internshipTitle;
	private String internshipType;
	private String startDate;
	private String endDate;
	private String internshipDescription;
	private String approximateHours;
	private String payPerHour;
	private String keyword;
	private String searchCriteria;  
	private String savedFlag;
	private String differenceInDays;
	private String state;
	private String parameterName;
	private String numberOfVacancy;
	
	private Long responseCount;
	
	private Boolean exceptionOccured;
	private Boolean jobUpdateFlag;
	private Boolean appliedFlag;
	private Boolean saveSearchParameter;
	private Boolean deletedFlag;
	private Boolean jobFlag;
	
	private Date appliedOn;
	private Date savedOn;
	private Date savedSearchOn;
	
	private List<String> primarySkills;
	private List<String> secondarySkills;
	private List<String> eligibleStreams;
	private List<String> campusJobRecipients;
	private List<String> jobFilterValues;
	private String sortedParameter;
	private Long jobViewedCount;
	private Map<String,Date> campusJobAppliedStudents;
	private Map<String,Date> campusInternshipAppliedStudents;
	
	private String firmName;
	
	private String jobLocation;
	
	private String yearsOfExperienceFrom;
	private Boolean allJobsInternshipsFlag;
	
	public Boolean getAllJobsInternshipsFlag() {
		return allJobsInternshipsFlag;
	}
	public void setAllJobsInternshipsFlag(Boolean allJobsInternshipsFlag) {
		this.allJobsInternshipsFlag = allJobsInternshipsFlag;
	}
	public Boolean getJobFlag() {
		return jobFlag;
	}
	public void setJobFlag(Boolean jobFlag) {
		this.jobFlag = jobFlag;
	}
	public Long getJobViewedCount() {
		return jobViewedCount;
	}
	public void setJobViewedCount(Long jobViewedCount) {
		this.jobViewedCount = jobViewedCount;
	}
	public String getSortedParameter() {
		return sortedParameter;
	}
	public void setSortedParameter(String sortedParameter) {
		this.sortedParameter = sortedParameter;
	}
	public List<String> getJobFilterValues() {
		return jobFilterValues;
	}
	public void setJobFilterValues(List<String> jobFilterValues) {
		this.jobFilterValues = jobFilterValues;
	}
	
	private Map<String, String> jobAppliedStudents;

	public String getFirmName() {
		return firmName;
	}
	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}
	public String getJobLocation() {
		return jobLocation;
	}
	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}
	public String getYearsOfExperienceFrom() {
		return yearsOfExperienceFrom;
	}
	public void setYearsOfExperienceFrom(String yearsOfExperienceFrom) {
		this.yearsOfExperienceFrom = yearsOfExperienceFrom;
	}
	public String getYearsOfExperienceTo() {
		return yearsOfExperienceTo;
	}
	public void setYearsOfExperienceTo(String yearsOfExperienceTo) {
		this.yearsOfExperienceTo = yearsOfExperienceTo;
	}
	private String yearsOfExperienceTo;
	
	public Boolean getDeletedFlag() {
		return deletedFlag;
	}
	public void setDeletedFlag(Boolean deletedFlag) {
		this.deletedFlag = deletedFlag;
	}
	public Date getSavedSearchOn() {
		return savedSearchOn;
	}
	public void setSavedSearchOn(Date savedSearchOn) {
		this.savedSearchOn = savedSearchOn;
	}
	public String getParameterName() {
		return parameterName;
	}
	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}
	public Boolean getSaveSearchParameter() {
		return saveSearchParameter;
	}
	public void setSaveSearchParameter(Boolean saveSearchParameter) {
		this.saveSearchParameter = saveSearchParameter;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getUniversityName() {
		return universityName;
	}
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}
	private String universityName;
	
	public String getDifferenceInDays() {
		return differenceInDays;
	}
	public void setDifferenceInDays(String differenceInDays) {
		this.differenceInDays = differenceInDays;
	}
	public String getSavedFlag() {
		return savedFlag;
	}
	public void setSavedFlag(String savedFlag) {
		this.savedFlag = savedFlag;
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
	 * @return the experienceFrom
	 */
	public String getExperienceFrom() {
		return experienceFrom;
	}
	/**
	 * @param experienceFrom the experienceFrom to set
	 */
	public void setExperienceFrom(String experienceFrom) {
		this.experienceFrom = experienceFrom;
	}
	/**
	 * @return the experienceTo
	 */
	public String getExperienceTo() {
		return experienceTo;
	}
	/**
	 * @param experienceTo the experienceTo to set
	 */
	public void setExperienceTo(String experienceTo) {
		this.experienceTo = experienceTo;
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
	 * @return the appliedOn
	 */
	public Date getAppliedOn() {
		return appliedOn;
	}
	/**
	 * @param appliedOn the appliedOn to set
	 */
	public void setAppliedOn(Date appliedOn) {
		this.appliedOn = appliedOn;
	}
	/**
	 * @return the savedOn
	 */
	public Date getSavedOn() {
		return savedOn;
	}
	/**
	 * @param savedOn the savedOn to set
	 */
	public void setSavedOn(Date savedOn) {
		this.savedOn = savedOn;
	}
	public String getJobId() {
		return jobId;
	}
	public void setJobId(String jobId) {
		this.jobId = jobId;
	}
	public String getJobType() {
		return jobType;
	}
	public void setJobType(String jobType) {
		this.jobType = jobType;
	}
	public String getPayPerWeek() {
		return payPerWeek;
	}
	public void setPayPerWeek(String payPerWeek) {
		this.payPerWeek = payPerWeek;
	}
	public List<String> getPrimarySkills() {
		return primarySkills;
	}
	public void setPrimarySkills(List<String> primarySkills) {
		this.primarySkills = primarySkills;
	}
	public List<String> getSecondarySkills() {
		return secondarySkills;
	}
	public void setSecondarySkills(List<String> secondarySkills) {
		this.secondarySkills = secondarySkills;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getGpaCutOffFrom() {
		return gpaCutOffFrom;
	}
	public void setGpaCutOffFrom(String gpaCutOffFrom) {
		this.gpaCutOffFrom = gpaCutOffFrom;
	}
	public String getGpaCutOffTo() {
		return gpaCutOffTo;
	}
	public void setGpaCutOffTo(String gpaCutOffTo) {
		this.gpaCutOffTo = gpaCutOffTo;
	}
	public List<String> getEligibleStreams() {
		return eligibleStreams;
	}
	public void setEligibleStreams(List<String> eligibleStreams) {
		this.eligibleStreams = eligibleStreams;
	}
	public Boolean getExceptionOccured() {
		return exceptionOccured;
	}
	public void setExceptionOccured(Boolean exceptionOccured) {
		this.exceptionOccured = exceptionOccured;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getExceptionMessage() {
		return exceptionMessage;
	}
	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}
	public Long getResponseCount() {
		return responseCount;
	}
	public void setResponseCount(Long responseCount) {
		this.responseCount = responseCount;
	}
	public String getInternshipId() {
		return internshipId;
	}
	public void setInternshipId(String internshipId) {
		this.internshipId = internshipId;
	}
	public String getInternshipIdAndFirmId() {
		return internshipIdAndFirmId;
	}
	public void setInternshipIdAndFirmId(String internshipIdAndFirmId) {
		this.internshipIdAndFirmId = internshipIdAndFirmId;
	}
	public String getInternshipTitle() {
		return internshipTitle;
	}
	public void setInternshipTitle(String internshipTitle) {
		this.internshipTitle = internshipTitle;
	}
	public String getInternshipType() {
		return internshipType;
	}
	public void setInternshipType(String internshipType) {
		this.internshipType = internshipType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getInternshipDescription() {
		return internshipDescription;
	}
	public void setInternshipDescription(String internshipDescription) {
		this.internshipDescription = internshipDescription;
	}
	public String getApproximateHours() {
		return approximateHours;
	}
	public void setApproximateHours(String approximateHours) {
		this.approximateHours = approximateHours;
	}
	public String getPayPerHour() {
		return payPerHour;
	}
	public void setPayPerHour(String payPerHour) {
		this.payPerHour = payPerHour;
	}
	public Boolean getJobUpdateFlag() {
		return jobUpdateFlag;
	}
	public void setJobUpdateFlag(Boolean jobUpdateFlag) {
		this.jobUpdateFlag = jobUpdateFlag;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchCriteria() {
		return searchCriteria;
	}
	public void setSearchCriteria(String searchCriteria) {
		this.searchCriteria = searchCriteria;
	}
	public Boolean getAppliedFlag() {
		return appliedFlag;
	}
	public void setAppliedFlag(Boolean appliedFlag) {
		this.appliedFlag = appliedFlag;
	}
	public List<String> getCampusJobRecipients() {
		return campusJobRecipients;
	}
	public void setCampusJobRecipients(List<String> campusJobRecipients) {
		this.campusJobRecipients = campusJobRecipients;
	}
	public Map<String, Date> getCampusJobAppliedStudents() {
		return campusJobAppliedStudents;
	}
	public void setCampusJobAppliedStudents(
			Map<String, Date> campusJobAppliedStudents) {
		this.campusJobAppliedStudents = campusJobAppliedStudents;
	}
	public String getNumberOfVacancy() {
		return numberOfVacancy;
	}
	public void setNumberOfVacancy(String numberOfVacancy) {
		this.numberOfVacancy = numberOfVacancy;
	}
	public Map<String, Date> getCampusInternshipAppliedStudents() {
		return campusInternshipAppliedStudents;
	}
	public void setCampusInternshipAppliedStudents(
			Map<String, Date> campusInternshipAppliedStudents) {
		this.campusInternshipAppliedStudents = campusInternshipAppliedStudents;
	}
	/**
	 * @return the jobAppliedStudents
	 */
	public Map<String, String> getJobAppliedStudents() {
		return jobAppliedStudents;
	}
	/**
	 * @param jobAppliedStudents the jobAppliedStudents to set
	 */
	public void setJobAppliedStudents(Map<String, String> jobAppliedStudents) {
		this.jobAppliedStudents = jobAppliedStudents;
	}
}