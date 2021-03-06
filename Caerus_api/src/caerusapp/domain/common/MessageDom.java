/**
 * 
 */
package caerusapp.domain.common;

/**
 * @author pallavid
 * This class is used as a domain class for message to create and access its properties
 */
public class MessageDom {
	
	private String messageId;
	private String senderEmailId;
	private String receiverEmailId;
	private String jobIdAndFirmId;
	private String message;
	private String postedOn;
	private boolean read;
	private boolean isFirstMessage;
	private String prevMessageId;
	private String firstMessageId;
	private String jobTitle;
	private String candidateName;
	private String companyName;
	private String photoName;
	private String messageSubject;

	public String getMessageSubject() {
		return messageSubject;
	}
	public void setMessageSubject(String messageSubject) {
		this.messageSubject = messageSubject;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	/**
	 * @return the messageId
	 */
	public String getMessageId() {
		return messageId;
	}
	/**
	 * @param messageId the messageId to set
	 */
	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}
	
	/**
	 * @return the senderEmailId
	 */
	public String getSenderEmailId() {
		return senderEmailId;
	}
	/**
	 * @param senderEmailId the senderEmailId to set
	 */
	public void setSenderEmailId(String senderEmailId) {
		this.senderEmailId = senderEmailId;
	}
	/**
	 * @return the receiverEmailId
	 */
	public String getReceiverEmailId() {
		return receiverEmailId;
	}
	/**
	 * @param receiverEmailId the receiverEmailId to set
	 */
	public void setReceiverEmailId(String receiverEmailId) {
		this.receiverEmailId = receiverEmailId;
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
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
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
	 * @return the isRead
	 */
	public boolean isRead() {
		return read;
	}
	/**
	 * @param isRead the isRead to set
	 */
	public void setRead(boolean read) {
		this.read = read;
	}
	/**
	 * @return the isFirstMessage
	 */
	public boolean isFirstMessage() {
		return isFirstMessage;
	}
	/**
	 * @param isFirstMessage the isFirstMessage to set
	 */
	public void setFirstMessage(boolean isFirstMessage) {
		this.isFirstMessage = isFirstMessage;
	}
	/**
	 * @return the prevMessageId
	 */
	public String getPrevMessageId() {
		return prevMessageId;
	}
	/**
	 * @param prevMessageId the prevMessageId to set
	 */
	public void setPrevMessageId(String prevMessageId) {
		this.prevMessageId = prevMessageId;
	}
	/**
	 * @return the firstMessageId
	 */
	public String getFirstMessageId() {
		return firstMessageId;
	}
	/**
	 * @param firstMessageId the firstMessageId to set
	 */
	public void setFirstMessageId(String firstMessageId) {
		this.firstMessageId = firstMessageId;
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
	 * @return the candidateName
	 */
	public String getCandidateName() {
		return candidateName;
	}
	/**
	 * @param candidateName the candidateName to set
	 */
	public void setCandidateName(String candidateName) {
		this.candidateName = candidateName;
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

	

}