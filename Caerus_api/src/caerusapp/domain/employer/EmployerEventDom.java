package caerusapp.domain.employer;

import java.util.List;

/**
 * @author TrishnaR
 */

public class EmployerEventDom {

	private String eventId;
	private String eventName;
	private String eventDescription;
	private String participatingUniversity;
	private String startDate;
	private String startTime;
	private String endDate;
	private String endTime;
	private String eventLocation;
	private List<String> functionalAreas;
	private List<String> numberOfHirings;
	private List<String> minimumSalaryOffered;
	private String emailId;
	private String invitationStatus;
	private String eventStatus;
	private String companyName;
	
	private Long differenceInDays;
	
	private List<String> eligibleBatches;
	private List<String> employerRepositoryFileNames;

	private Boolean attachCompanyProfile;
	private Boolean attachPreplacementFiles;
	
	private List<String> acceptedByStudentsList;
	private List<String> deniedByStudentsList;
	
	private String studentAcceptStatus;
	
	private String firmId;

	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getEventDescription() {
		return eventDescription;
	}
	public void setEventDescription(String eventDescription) {
		this.eventDescription = eventDescription;
	}
	public String getParticipatingUniversity() {
		return participatingUniversity;
	}
	public void setParticipatingUniversity(String participatingUniversity) {
		this.participatingUniversity = participatingUniversity;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getEventLocation() {
		return eventLocation;
	}
	public void setEventLocation(String eventLocation) {
		this.eventLocation = eventLocation;
	}
	public List<String> getFunctionalAreas() {
		return functionalAreas;
	}
	public void setFunctionalAreas(List<String> functionalAreas) {
		this.functionalAreas = functionalAreas;
	}
	public List<String> getNumberOfHirings() {
		return numberOfHirings;
	}
	public void setNumberOfHirings(List<String> numberOfHirings) {
		this.numberOfHirings = numberOfHirings;
	}
	public List<String> getMinimumSalaryOffered() {
		return minimumSalaryOffered;
	}
	public void setMinimumSalaryOffered(List<String> minimumSalaryOffered) {
		this.minimumSalaryOffered = minimumSalaryOffered;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getInvitationStatus() {
		return invitationStatus;
	}
	public void setInvitationStatus(String invitationStatus) {
		this.invitationStatus = invitationStatus;
	}
	public String getEventStatus() {
		return eventStatus;
	}
	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}
	public Long getDifferenceInDays() {
		return differenceInDays;
	}
	public void setDifferenceInDays(Long differenceInDays) {
		this.differenceInDays = differenceInDays;
	}
	public List<String> getEligibleBatches() {
		return eligibleBatches;
	}
	public void setEligibleBatches(List<String> eligibleBatches) {
		this.eligibleBatches = eligibleBatches;
	}
	public List<String> getEmployerRepositoryFileNames() {
		return employerRepositoryFileNames;
	}
	public void setEmployerRepositoryFileNames(
			List<String> employerRepositoryFileNames) {
		this.employerRepositoryFileNames = employerRepositoryFileNames;
	}
	public Boolean getAttachCompanyProfile() {
		return attachCompanyProfile;
	}
	public void setAttachCompanyProfile(Boolean attachCompanyProfile) {
		this.attachCompanyProfile = attachCompanyProfile;
	}
	public Boolean getAttachPreplacementFiles() {
		return attachPreplacementFiles;
	}
	public void setAttachPreplacementFiles(Boolean attachPreplacementFiles) {
		this.attachPreplacementFiles = attachPreplacementFiles;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	/**
	 * @return the acceptedByStudentsList
	 */
	public List<String> getAcceptedByStudentsList() {
		return acceptedByStudentsList;
	}
	/**
	 * @param acceptedByStudentsList the acceptedByStudentsList to set
	 */
	public void setAcceptedByStudentsList(List<String> acceptedByStudentsList) {
		this.acceptedByStudentsList = acceptedByStudentsList;
	}
	/**
	 * @return the deniedByStudentsList
	 */
	public List<String> getDeniedByStudentsList() {
		return deniedByStudentsList;
	}
	/**
	 * @param deniedByStudentsList the deniedByStudentsList to set
	 */
	public void setDeniedByStudentsList(List<String> deniedByStudentsList) {
		this.deniedByStudentsList = deniedByStudentsList;
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
	 * @return the studentAcceptStatus
	 */
	public String getStudentAcceptStatus() {
		return studentAcceptStatus;
	}
	/**
	 * @param studentAcceptStatus the studentAcceptStatus to set
	 */
	public void setStudentAcceptStatus(String studentAcceptStatus) {
		this.studentAcceptStatus = studentAcceptStatus;
	}
	
	
}