/**
 * 
 */
package caerusapp.domain.university;

import java.util.List;
import java.util.Map;

import caerusapp.domain.student.StudentDom;

/**
 * @author TrishnaR
 * 
 */
public class UniversityEventDom {
	
	private String eventId;
	private String description;
	private String endDate;
	private String eventName;
	private String eventType;
	private String firmId;
	private String startDate;
	private String status;
	private String time;
	private String venue;
	private String industry;
	private String keywords;
	private String seminarCategory;
	private String speakerName;
	private String topic;
	private String invitationStatus;
	private String message;
	private String companyEmailId;
	private String inviteCompanyName;
	private String universityName;
	private String universityId;
	private String controllerEventId;
	private String startTime;
	private String endTime;
	private String templateName;
	private String divId;
	private String invitedCompanyRecruitment;
	private String invitedCompanySeminar;
	private StringBuilder daysRemaining ;
	
	private long differenceInDays;
	
	private boolean readFlag;
	private boolean showPublish; 
	private boolean recruitmentFlag;
	private boolean seminarFlag;
	private boolean jobFairFlag;
	
	private List<String> invitedCompanies;
	private List<String> companyName;
	private List<String> functionalAreaList;
	private List<String> industryList;
	private List<String> stateList;
	private List<String> acceptedByStudentsList;
	private List<String> deniedByStudentsList;
	private List<StudentDom> candidateList;
	
	private Map<String,String> companyNameEmailIdMap;
	private Map<String,String> companyNameStatusMap;
	
	
	
	
	public Map<String, String> getCompanyNameStatusMap() {
		return companyNameStatusMap;
	}
	public void setCompanyNameStatusMap(Map<String, String> companyNameStatusMap) {
		this.companyNameStatusMap = companyNameStatusMap;
	}
	public List<String> getFunctionalAreaList() {
		return functionalAreaList;
	}
	public void setFunctionalAreaList(List<String> functionalAreaList) {
		this.functionalAreaList = functionalAreaList;
	}
	public List<String> getIndustryList() {
		return industryList;
	}
	public void setIndustryList(List<String> industryList) {
		this.industryList = industryList;
	}
	public List<String> getStateList() {
		return stateList;
	}
	public void setStateList(List<String> stateList) {
		this.stateList = stateList;
	}
	/**
	 * @return the controllerEventId
	 */
	public String getControllerEventId() {
		return controllerEventId;
	}
	/**
	 * @param controllerEventId
	 *            the controllerEventId to set
	 */
	public void setControllerEventId(String controllerEventId) {
		this.controllerEventId = controllerEventId;
	}
	public String getUniversityId() {
		return universityId;
	}
	public void setUniversityId(String universityId) {
		this.universityId = universityId;
	}
	public String getUniversityName() {
		return universityName;
	}
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}

	/**
	 * @return the seminarCategory
	 */
	public String getSeminarCategory() {
		return seminarCategory;
	}
	/**
	 * @param seminarCategory
	 *            the seminarCategory to set
	 */
	public void setSeminarCategory(String seminarCategory) {
		this.seminarCategory = seminarCategory;
	}
	/**
	 * @return the speakerName
	 */
	public String getSpeakerName() {
		return speakerName;
	}
	/**
	 * @param speakerName
	 *            the speakerName to set
	 */
	public void setSpeakerName(String speakerName) {
		this.speakerName = speakerName;
	}
	/**
	 * @return the topic
	 */
	public String getTopic() {
		return topic;
	}
	/**
	 * @param topic
	 *            the topic to set
	 */
	public void setTopic(String topic) {
		this.topic = topic;
	}
	/**
	 * @return the eventId
	 */
	public String getEventId() {
		return eventId;
	}
	/**
	 * @param eventId
	 *            the eventId to set
	 */
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param descripton
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
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
	 * @return the eventName
	 */
	public String getEventName() {
		return eventName;
	}
	/**
	 * @param eventName
	 *            the eventName to set
	 */
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	/**
	 * @return the eventType
	 */
	public String getEventType() {
		return eventType;
	}
	/**
	 * @param eventType
	 *            the eventType to set
	 */
	public void setEventType(String eventType) {
		this.eventType = eventType;
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
	 * @return the invitedCompanies
	 */
	public List<String> getInvitedCompanies() {
		return invitedCompanies;
	}
	/**
	 * @param invitedCompanies
	 *            the invitedCompanies to set
	 */
	public void setInvitedCompanies(List<String> invitedCompanies) {
		this.invitedCompanies = invitedCompanies;
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
	 * @return the time
	 */
	public String getTime() {
		return time;
	}
	/**
	 * @param time
	 *            the time to set
	 */
	public void setTime(String time) {
		this.time = time;
	}
	/**
	 * @return the venue
	 */
	public String getVenue() {
		return venue;
	}
	/**
	 * @param venue
	 *            the venue to set
	 */
	public void setVenue(String venue) {
		this.venue = venue;
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
	 * @return the keywords
	 */
	public String getKeywords() {
		return keywords;
	}
	/**
	 * @param keywords
	 *            the keywords to set
	 */
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	/**
	 * @return the invitationStatus
	 */
	public String getInvitationStatus() {
		return invitationStatus;
	}
	/**
	 * @param invitationStatus
	 *            the invitationStatus to set
	 */
	public void setInvitationStatus(String invitationStatus) {
		this.invitationStatus = invitationStatus;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message
	 *            the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the companyEmailId
	 */
	public String getCompanyEmailId() {
		return companyEmailId;
	}
	/**
	 * @param companyEmailId
	 *            the companyEmailId to set
	 */
	public void setCompanyEmailId(String companyEmailId) {
		this.companyEmailId = companyEmailId;
	}
	/**
	 * @return the companyName
	 */
	public List<String> getCompanyName() {
		return companyName;
	}
	/**
	 * @param companyName
	 *            the companyName to set
	 */
	public void setCompanyName(List<String> companyName) {
		this.companyName = companyName;
	}
	/**
	 * @return the inviteCompanyName
	 */
	public String getInviteCompanyName() {
		return inviteCompanyName;
	}
	/**
	 * @param inviteCompanyName
	 *            the inviteCompanyName to set
	 */
	public void setInviteCompanyName(String inviteCompanyName) {
		this.inviteCompanyName = inviteCompanyName;
	}
	/**
	 * @return the startTime
	 */
	public String getStartTime() {
		return startTime;
	}
	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}
	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public long getDifferenceInDays() {
		return differenceInDays;
	}
	public void setDifferenceInDays(long differenceInDays) {
		this.differenceInDays = differenceInDays;
	}
	public List<String> getAcceptedByStudentsList() {
		return acceptedByStudentsList;
	}
	public void setAcceptedByStudentsList(List<String> acceptedByStudentsList) {
		this.acceptedByStudentsList = acceptedByStudentsList;
	}
	public List<String> getDeniedByStudentsList() {
		return deniedByStudentsList;
	}
	public void setDeniedByStudentsList(List<String> deniedByStudentsList) {
		this.deniedByStudentsList = deniedByStudentsList;
	}
	public Map<String, String> getCompanyNameEmailIdMap() {
		return companyNameEmailIdMap;
	}
	public void setCompanyNameEmailIdMap(Map<String, String> companyNameEmailIdMap) {
		this.companyNameEmailIdMap = companyNameEmailIdMap;
	}
	/**
	 * @return the readFlag
	 */
	public boolean isReadFlag() {
		return readFlag;
	}
	/**
	 * @param readFlag the readFlag to set
	 */
	public void setReadFlag(boolean readFlag) {
		this.readFlag = readFlag;
	}
	
	/**
	 *  @return the daysRemaining
	 */
	public StringBuilder getDaysRemaining() {
		return daysRemaining;
	}
	/**
	 * @param daysRemaining the daysRemaining to set
	 */
	public void setDaysRemaining(StringBuilder daysRemaining) {
		this.daysRemaining = daysRemaining;
	}
	/**
	 * @return the showPublish
	 */
	public boolean isShowPublish() {
		return showPublish;
	}
	/**
	 * @param showPublish the showPublish to set
	 */
	public void setShowPublish(boolean showPublish) {
		this.showPublish = showPublish;
	}
	/**
	 * @return the templateName
	 */
	public String getTemplateName() {
		return templateName;
	}
	/**
	 * @param templateName the templateName to set
	 */
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	/**
	 * @return the candidateList
	 */
	public List<StudentDom> getCandidateList() {
		return candidateList;
	}
	/**
	 * @param candidateList the candidateList to set
	 */
	public void setCandidateList(List<StudentDom> candidateList) {
		this.candidateList = candidateList;
	}
	/**
	 * @return the divId
	 */
	public String getDivId() {
		return divId;
	}
	/**
	 * @param divId the divId to set
	 */
	public void setDivId(String divId) {
		this.divId = divId;
	}
	public String getInvitedCompanyRecruitment() {
		return invitedCompanyRecruitment;
	}
	public void setInvitedCompanyRecruitment(String invitedCompanyRecruitment) {
		this.invitedCompanyRecruitment = invitedCompanyRecruitment;
	}
	public String getInvitedCompanySeminar() {
		return invitedCompanySeminar;
	}
	public void setInvitedCompanySeminar(String invitedCompanySeminar) {
		this.invitedCompanySeminar = invitedCompanySeminar;
	}
	public boolean isRecruitmentFlag() {
		return recruitmentFlag;
	}
	public void setRecruitmentFlag(boolean recruitmentFlag) {
		this.recruitmentFlag = recruitmentFlag;
	}
	public boolean isSeminarFlag() {
		return seminarFlag;
	}
	public void setSeminarFlag(boolean seminarFlag) {
		this.seminarFlag = seminarFlag;
	}
	public boolean isJobFairFlag() {
		return jobFairFlag;
	}
	public void setJobFairFlag(boolean jobFairFlag) {
		this.jobFairFlag = jobFairFlag;
	}

	

}