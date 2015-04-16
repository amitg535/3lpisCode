/**
 * 
 */
package caerusapp.domain.employer;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author KarthikeyanK
 * 
 */
public class EmployerCampusJobPostDom {

	private String jobId;
	private String jobIdAndFirmId;
	private String jobTitle;
	private String jobType;
	private String functionalArea;
	private String payPerWeek;
	private String industry;
	private String jobLocation;
	private String jobDescription;
	private String firmId;
	// private String[] universityNameArray;

	private String flag;
	private String firmName;
	private String postedBy;
	private String postedOn;
	private String responseCount;
	private String universityName;
	private String status;

	private Integer yearsOfExperienceFrom;
	private Integer yearsOfExperienceTo;
	private Integer gpaCutOffFrom;
	private Integer gpaCutOffTo;

	private List<String> universityNameList;
	private List<String> primarySkills;
	private List<String> secondarySkills;
	private List<String> eligibleStreams;

	private String internshipId;
	private String internshipTitle;
	private String internshipType;
	private String approximateHours;
	private String startDate;
	private String endDate;
	private String payPerHours;
	private String numberOfVacancy;
	private String internshipLocation;
	private String internshipDescription;

	private String internshipIdAndFirmId;
	private String caerusCommonExceptionMessage;
	private boolean exceptionOccured = false;
	private Map<String, Date> campusJobAppliedStudents;
	private Map<String, Date> campusInternshipAppliedStudents;
	
	private Map<String, String> candidateJobStatus;
	private Map<String, String> candidateInternshipStatus;
	
	private String exception;
	
	private String zipCode;
	
	private String primarySkills1;
	
	private String secondarySkills1;
	private byte[] photoData;
	private String photoName;
	
	private boolean seenByUniversityFlag;
	
	private Map<String, String> appliedCampusJobStatusMap;

		
	/**
	 * @return the jobId
	 */
	public String getJobId() {
		return jobId;
	}
	/**
	 * @param jobId
	 *            the jobId to set
	 */
	public void setJobId(String jobId) {
		this.jobId = jobId;
	}
	/**
	 * @return the jobTitle
	 */
	public String getJobTitle() {
		return jobTitle;
	}
	/**
	 * @param jobTitle
	 *            the jobTitle to set
	 */
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	/**
	 * @return the jobType
	 */
	public String getJobType() {
		return jobType;
	}
	/**
	 * @param jobType
	 *            the jobType to set
	 */
	public void setJobType(String jobType) {
		this.jobType = jobType;
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
	 * @return the payPerWeek
	 */
	public String getPayPerWeek() {
		return payPerWeek;
	}
	/**
	 * @param payPerWeek
	 *            the payPerWeek to set
	 */
	public void setPayPerWeek(String payPerWeek) {
		this.payPerWeek = payPerWeek;
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
	 * @return the jobLocation
	 */
	public String getJobLocation() {
		return jobLocation;
	}
	/**
	 * @param jobLocation
	 *            the jobLocation to set
	 */
	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}
	/**
	 * @return the jobDescription
	 */
	public String getJobDescription() {
		return jobDescription;
	}
	/**
	 * @param jobDescription
	 *            the jobDescription to set
	 */
	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}
	/**
	 * @return the firmId
	 */
	public String getFirmId() {
		return firmId;
	}
	/**
	 * @param firmId
	 *            the firmId to set
	 */
	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag
	 *            the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/**
	 * @return the firmName
	 */
	public String getFirmName() {
		return firmName;
	}
	/**
	 * @param firmName
	 *            the firmName to set
	 */
	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}
	/**
	 * @return the postedBy
	 */
	public String getPostedBy() {
		return postedBy;
	}
	/**
	 * @param postedBy
	 *            the postedBy to set
	 */
	public void setPostedBy(String postedBy) {
		this.postedBy = postedBy;
	}
	/**
	 * @return the postedOn
	 */
	public String getPostedOn() {
		return postedOn;
	}
	/**
	 * @param postedOn
	 *            the postedOn to set
	 */
	public void setPostedOn(String postedOn) {
		this.postedOn = postedOn;
	}
	/**
	 * @return the responseCount
	 */
	public String getResponseCount() {
		return responseCount;
	}
	/**
	 * @param responseCount
	 *            the responseCount to set
	 */
	public void setResponseCount(String responseCount) {
		this.responseCount = responseCount;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the yearsOfExperienceFrom
	 */
	public Integer getYearsOfExperienceFrom() {
		return yearsOfExperienceFrom;
	}
	/**
	 * @param yearsOfExperienceFrom
	 *            the yearsOfExperienceFrom to set
	 */
	public void setYearsOfExperienceFrom(Integer yearsOfExperienceFrom) {
		this.yearsOfExperienceFrom = yearsOfExperienceFrom;
	}
	/**
	 * @return the yearsOfExperienceTo
	 */
	public Integer getYearsOfExperienceTo() {
		return yearsOfExperienceTo;
	}
	/**
	 * @param yearsOfExperienceTo
	 *            the yearsOfExperienceTo to set
	 */
	public void setYearsOfExperienceTo(Integer yearsOfExperienceTo) {
		this.yearsOfExperienceTo = yearsOfExperienceTo;
	}
	/**
	 * @return the gpaCutOffFrom
	 */
	public Integer getGpaCutOffFrom() {
		return gpaCutOffFrom;
	}
	/**
	 * @param gpaCutOffFrom
	 *            the gpaCutOffFrom to set
	 */
	public void setGpaCutOffFrom(Integer gpaCutOffFrom) {
		this.gpaCutOffFrom = gpaCutOffFrom;
	}
	/**
	 * @return the gpaCutOffTo
	 */
	public Integer getGpaCutOffTo() {
		return gpaCutOffTo;
	}
	/**
	 * @param gpaCutOffTo
	 *            the gpaCutOffTo to set
	 */
	public void setGpaCutOffTo(Integer gpaCutOffTo) {
		this.gpaCutOffTo = gpaCutOffTo;
	}
	/**
	 * @return the universityNameList
	 */
	public List<String> getUniversityNameList() {
		return universityNameList;
	}
	/**
	 * @param universityNameList
	 *            the universityNameList to set
	 */
	public void setUniversityNameList(List<String> universityNameList) {
		this.universityNameList = universityNameList;
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
	 * @return the eligibleStreams
	 */
	public List<String> getEligibleStreams() {
		return eligibleStreams;
	}
	/**
	 * @param eligibleStreams
	 *            the eligibleStreams to set
	 */
	public void setEligibleStreams(List<String> eligibleStreams) {
		this.eligibleStreams = eligibleStreams;
	}
	/**
	 * @return the internshipId
	 */
	public String getInternshipId() {
		return internshipId;
	}
	/**
	 * @param internshipId
	 *            the internshipId to set
	 */
	public void setInternshipId(String internshipId) {
		this.internshipId = internshipId;
	}
	/**
	 * @return the internshipTitle
	 */
	public String getInternshipTitle() {
		return internshipTitle;
	}
	/**
	 * @param internshipTitle
	 *            the internshipTitle to set
	 */
	public void setInternshipTitle(String internshipTitle) {
		this.internshipTitle = internshipTitle;
	}
	/**
	 * @return the internshipType
	 */
	public String getInternshipType() {
		return internshipType;
	}
	/**
	 * @param internshipType
	 *            the internshipType to set
	 */
	public void setInternshipType(String internshipType) {
		this.internshipType = internshipType;
	}
	/**
	 * @return the approximateHours
	 */
	public String getApproximateHours() {
		return approximateHours;
	}
	/**
	 * @param approximateHours
	 *            the approximateHours to set
	 */
	public void setApproximateHours(String approximateHours) {
		this.approximateHours = approximateHours;
	}
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate
	 *            the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate
	 *            the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the payPerHours
	 */
	public String getPayPerHours() {
		return payPerHours;
	}
	/**
	 * @param payPerHours
	 *            the payPerHours to set
	 */
	public void setPayPerHours(String payPerHours) {
		this.payPerHours = payPerHours;
	}
	/**
	 * @return the numberOfVacancy
	 */
	public String getNumberOfVacancy() {
		return numberOfVacancy;
	}
	/**
	 * @param numberOfVacancy
	 *            the numberOfVacancy to set
	 */
	public void setNumberOfVacancy(String numberOfVacancy) {
		this.numberOfVacancy = numberOfVacancy;
	}
	/**
	 * @return the internshipLocation
	 */
	public String getInternshipLocation() {
		return internshipLocation;
	}
	/**
	 * @param internshipLocation
	 *            the internshipLocation to set
	 */
	public void setInternshipLocation(String internshipLocation) {
		this.internshipLocation = internshipLocation;
	}
	/**
	 * @return the internshipDescription
	 */
	public String getInternshipDescription() {
		return internshipDescription;
	}
	/**
	 * @param internshipDescription
	 *            the internshipDescription to set
	 */
	public void setInternshipDescription(String internshipDescription) {
		this.internshipDescription = internshipDescription;
	}
	/**
	 * @return the caerusCommonExceptionMessage
	 */
	public String getCaerusCommonExceptionMessage() {
		return caerusCommonExceptionMessage;
	}
	/**
	 * @param caerusCommonExceptionMessage
	 *            the caerusCommonExceptionMessage to set
	 */
	public void setCaerusCommonExceptionMessage(
			String caerusCommonExceptionMessage) {
		this.caerusCommonExceptionMessage = caerusCommonExceptionMessage;
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
	public String getInternshipIdAndFirmId() {
		return internshipIdAndFirmId;
	}
	public void setInternshipIdAndFirmId(String internshipIdAndFirmId) {
		this.internshipIdAndFirmId = internshipIdAndFirmId;
	}
	public String getJobIdAndFirmId() {
		return jobIdAndFirmId;
	}
	public void setJobIdAndFirmId(String jobIdAndFirmId) {
		this.jobIdAndFirmId = jobIdAndFirmId;
	}
	
	public Map<String, Date> getCampusJobAppliedStudents() {
		return campusJobAppliedStudents;
	}
	public void setCampusJobAppliedStudents(
			Map<String, Date> campusJobAppliedStudents) {
		this.campusJobAppliedStudents = campusJobAppliedStudents;
	}
	public Map<String, Date> getCampusInternshipAppliedStudents() {
		return campusInternshipAppliedStudents;
	}
	public void setCampusInternshipAppliedStudents(
			Map<String, Date> campusInternshipAppliedStudents) {
		this.campusInternshipAppliedStudents = campusInternshipAppliedStudents;
	}
	public Map<String, String> getCandidateJobStatus() {
		return candidateJobStatus;
	}
	public void setCandidateJobStatus(Map<String, String> candidateJobStatus) {
		this.candidateJobStatus = candidateJobStatus;
	}
	public Map<String, String> getCandidateInternshipStatus() {
		return candidateInternshipStatus;
	}
	public void setCandidateInternshipStatus(
			Map<String, String> candidateInternshipStatus) {
		this.candidateInternshipStatus = candidateInternshipStatus;
	}
	public String getException() {
		return exception;
	}
	public void setException(String exception) {
		this.exception = exception;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getPrimarySkills1() {
		return primarySkills1;
	}
	public void setPrimarySkills1(String primarySkills1) {
		this.primarySkills1 = primarySkills1;
	}
	public String getSecondarySkills1() {
		return secondarySkills1;
	}
	public void setSecondarySkills1(String secondarySkills1) {
		this.secondarySkills1 = secondarySkills1;
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
	 * @return the photoName
	 */
	public String getPhotoName() {
		return photoName;
	}
	/**
	 * @param photoName the photoName to set
	 */

	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public boolean isSeenByUniversityFlag() {
		return seenByUniversityFlag;
	}
	public void setSeenByUniversityFlag(boolean seenByUniversityFlag) {
		this.seenByUniversityFlag = seenByUniversityFlag;
	}
	/**
	 * @return the appliedCampusJobStatusMap
	 */
	public Map<String, String> getAppliedCampusJobStatusMap() {
		return appliedCampusJobStatusMap;
	}
	/**
	 * @param appliedCampusJobStatusMap the appliedCampusJobStatusMap to set
	 */
	public void setAppliedCampusJobStatusMap(
			Map<String, String> appliedCampusJobStatusMap) {
		this.appliedCampusJobStatusMap = appliedCampusJobStatusMap;
	}
	
	
}