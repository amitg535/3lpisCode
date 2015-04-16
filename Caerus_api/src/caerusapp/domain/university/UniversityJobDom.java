package caerusapp.domain.university;

import java.util.List;
import java.util.Map;

public class UniversityJobDom {

	private String internshipId;
	private String internshipIdAndFirmId;
	private String internshipType;
	private String internshipTitle;
	private String zipCode;
	private String city;
	private String internshipDescription;
	private String startDate;
	private String endDate;
	private String payPerHour;
	private String vacancyCount;
	private String location;
	private String status;
	private String postedOn;
	private String approximateHours;
	private String universityName;

	private boolean updateFlag;
	
	private List<String> primarySkills;
	private List<String> secondarySkills;
	
	private Map<String,String> appliedStudents;
	
	public String getInternshipId() {
		return internshipId;
	}
	public void setInternshipId(String internshipId) {
		this.internshipId = internshipId;
	}
	public String getInternshipType() {
		return internshipType;
	}
	public void setInternshipType(String internshipType) {
		this.internshipType = internshipType;
	}
	public String getInternshipTitle() {
		return internshipTitle;
	}
	public void setInternshipTitle(String internshipTitle) {
		this.internshipTitle = internshipTitle;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getInternshipDescription() {
		return internshipDescription;
	}
	public void setInternshipDescription(String internshipDescription) {
		this.internshipDescription = internshipDescription;
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
	public String getPayPerHour() {
		return payPerHour;
	}
	public void setPayPerHour(String payPerHour) {
		this.payPerHour = payPerHour;
	}
	public String getVacancyCount() {
		return vacancyCount;
	}
	public void setVacancyCount(String vacancyCount) {
		this.vacancyCount = vacancyCount;
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
	public String getPostedOn() {
		return postedOn;
	}
	public void setPostedOn(String postedOn) {
		this.postedOn = postedOn;
	}
	public String getApproximateHours() {
		return approximateHours;
	}
	public void setApproximateHours(String approximateHours) {
		this.approximateHours = approximateHours;
	}
	public String getInternshipIdAndFirmId() {
		return internshipIdAndFirmId;
	}
	public void setInternshipIdAndFirmId(String internshipIdAndFirmId) {
		this.internshipIdAndFirmId = internshipIdAndFirmId;
	}
	public boolean isUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getUniversityName() {
		return universityName;
	}
	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}
	public Map<String, String> getAppliedStudents() {
		return appliedStudents;
	}
	public void setAppliedStudents(Map<String, String> appliedStudents) {
		this.appliedStudents = appliedStudents;
	}
}
