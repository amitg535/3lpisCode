/**
 * 
 */
package caerusapp.domain.student;

import java.util.Date;

/**
 * @author PallaviD
 *
 */
public class StudentRecommendationDom {
	
	private String studentEmailId;
	private String type;
	private Date requestTime;
	
	private String recommenderEmailId;
	private String organization;
	private String designation;
	private String recommenderFirstName;
	private String recommenderLastName;
	
	private Date recommenderResponseTime;
	private String studentRecoStatus;
	private String recommenderStatus;
	
	private String creativityRating;
	private String workEthicRating;
	private String leadershipRating;
	
	private Integer reminderCount;
	
	
	private String requestMessage; 
	private String detailedReco;
	
	private String studentFirstName;
	private String studentLastName;
	
	private String yearsStudentKnown;

	/**
	 * @return the studentEmailId
	 */
	public String getStudentEmailId() {
		return studentEmailId;
	}

	/**
	 * @param studentEmailId the studentEmailId to set
	 */
	public void setStudentEmailId(String studentEmailId) {
		this.studentEmailId = studentEmailId;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the requestTime
	 */
	public Date getRequestTime() {
		return requestTime;
	}

	/**
	 * @param requestTime the requestTime to set
	 */
	public void setRequestTime(Date requestTime) {
		this.requestTime = requestTime;
	}

	/**
	 * @return the recommenderEmailId
	 */
	public String getRecommenderEmailId() {
		return recommenderEmailId;
	}

	/**
	 * @param recommenderEmailId the recommenderEmailId to set
	 */
	public void setRecommenderEmailId(String recommenderEmailId) {
		this.recommenderEmailId = recommenderEmailId;
	}

	/**
	 * @return the organization
	 */
	public String getOrganization() {
		return organization;
	}

	/**
	 * @param organization the organization to set
	 */
	public void setOrganization(String organization) {
		this.organization = organization;
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
	 * @return the recommenderResponseTime
	 */
	public Date getRecommenderResponseTime() {
		return recommenderResponseTime;
	}

	/**
	 * @param recommenderResponseTime the recommenderResponseTime to set
	 */
	public void setRecommenderResponseTime(Date recommenderResponseTime) {
		this.recommenderResponseTime = recommenderResponseTime;
	}

	/**
	 * @return the studentRecoStatus
	 */
	public String getStudentRecoStatus() {
		return studentRecoStatus;
	}

	/**
	 * @param studentRecoStatus the studentRecoStatus to set
	 */
	public void setStudentRecoStatus(String studentRecoStatus) {
		this.studentRecoStatus = studentRecoStatus;
	}

	/**
	 * @return the recommenderStatus
	 */
	public String getRecommenderStatus() {
		return recommenderStatus;
	}

	/**
	 * @param recommenderStatus the recommenderStatus to set
	 */
	public void setRecommenderStatus(String recommenderStatus) {
		this.recommenderStatus = recommenderStatus;
	}

	/**
	 * @return the creativityRating
	 */
	public String getCreativityRating() {
		return creativityRating;
	}

	/**
	 * @param creativityRating the creativityRating to set
	 */
	public void setCreativityRating(String creativityRating) {
		this.creativityRating = creativityRating;
	}

	/**
	 * @return the workEthicRating
	 */
	public String getWorkEthicRating() {
		return workEthicRating;
	}

	/**
	 * @param workEthicRating the workEthicRating to set
	 */
	public void setWorkEthicRating(String workEthicRating) {
		this.workEthicRating = workEthicRating;
	}

	/**
	 * @return the leadershipRating
	 */
	public String getLeadershipRating() {
		return leadershipRating;
	}

	/**
	 * @param leadershipRating the leadershipRating to set
	 */
	public void setLeadershipRating(String leadershipRating) {
		this.leadershipRating = leadershipRating;
	}

	/**
	 * @return the reminderCount
	 */
	public Integer getReminderCount() {
		return reminderCount;
	}

	/**
	 * @param reminderCount the reminderCount to set
	 */
	public void setReminderCount(Integer reminderCount) {
		this.reminderCount = reminderCount;
	}

	/**
	 * @return the requestMessage
	 */
	public String getRequestMessage() {
		return requestMessage;
	}

	/**
	 * @param requestMessage the requestMessage to set
	 */
	public void setRequestMessage(String requestMessage) {
		this.requestMessage = requestMessage;
	}

	/**
	 * @return the detailedReco
	 */
	public String getDetailedReco() {
		return detailedReco;
	}

	/**
	 * @param detailedReco the detailedReco to set
	 */
	public void setDetailedReco(String detailedReco) {
		this.detailedReco = detailedReco;
	}

	/**
	 * @return the recommenderFirstName
	 */
	public String getRecommenderFirstName() {
		return recommenderFirstName;
	}

	/**
	 * @param recommenderFirstName the recommenderFirstName to set
	 */
	public void setRecommenderFirstName(String recommenderFirstName) {
		this.recommenderFirstName = recommenderFirstName;
	}

	/**
	 * @return the recommenderLastName
	 */
	public String getRecommenderLastName() {
		return recommenderLastName;
	}

	/**
	 * @param recommenderLastName the recommenderLastName to set
	 */
	public void setRecommenderLastName(String recommenderLastName) {
		this.recommenderLastName = recommenderLastName;
	}

	/**
	 * @return the studentFirstName
	 */
	public String getStudentFirstName() {
		return studentFirstName;
	}

	/**
	 * @param studentFirstName the studentFirstName to set
	 */
	public void setStudentFirstName(String studentFirstName) {
		this.studentFirstName = studentFirstName;
	}

	/**
	 * @return the studentLastName
	 */
	public String getStudentLastName() {
		return studentLastName;
	}

	/**
	 * @param studentLastName the studentLastName to set
	 */
	public void setStudentLastName(String studentLastName) {
		this.studentLastName = studentLastName;
	}

	/**
	 * @return the yearsStudentKnown
	 */
	public String getYearsStudentKnown() {
		return yearsStudentKnown;
	}

	/**
	 * @param yearsStudentKnown the yearsStudentKnown to set
	 */
	public void setYearsStudentKnown(String yearsStudentKnown) {
		this.yearsStudentKnown = yearsStudentKnown;
	}

	
	
	
	

}
