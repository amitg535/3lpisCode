package caerusapp.domain.common;

import java.util.List;

/**
 * 
 * @author RavishaG
 *
 */
public class UpcomingEventsDom {
	
	private String eventId;
	
	private String eventName;
	
	private long differenceInDays;
	
	private String startDate;
	
	private String endDate;
	
	private String companyName;
	
	private boolean universityFlag;
	
	private List<String> acceptedByStudentsList;
	
	private List<String> deniedByStudentsList;
	
	private String universityId;
	
	private String firmId;
	
	private String eventType;
	
	private String startTime;
	
	private String endTime;

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

	public long getDifferenceInDays() {
		return differenceInDays;
	}

	public void setDifferenceInDays(long differenceInDays) {
		this.differenceInDays = differenceInDays;
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

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public boolean getUniversityFlag() {
		return universityFlag;
	}

	public void setUniversityFlag(boolean universityFlag) {
		this.universityFlag = universityFlag;
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

	public String getUniversityId() {
		return universityId;
	}

	public void setUniversityId(String universityId) {
		this.universityId = universityId;
	}

	public String getFirmId() {
		return firmId;
	}

	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}