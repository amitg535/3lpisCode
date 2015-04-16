package caerusapp.command.common;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

import caerusapp.util.ValidatorMessageConstants;

public class LoginManagementCom {


	@Pattern(regexp ="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(?:[a-zA-Z]{2,6})$", message = ValidatorMessageConstants.EMAIL_ID_SYNTAX) @NotEmpty(message = ValidatorMessageConstants.EMAIL_ID_EMPTY)
	private String emailId;
	
	private String userName;
	private String password;
	private String oldPassword;
	private String newPassword;
	private String confirmPassword;
	private String authority;
	private Boolean enabled;
	private String successMessage;
	private String exception;
	private boolean exceptionOccured = false;
	private String firstName;
	private String lastName;
	private String entityName;
	private boolean adminFlag;
	private String newEntityName;
	
	
	/**
	 * @return the emailId
	 */
	public String getEmailId() {
		return emailId;
	}
	/**
	 * @param emailId
	 *            the emailId to set
	 */
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName
	 *            the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the oldPassword
	 */
	public String getOldPassword() {
		return oldPassword;
	}
	/**
	 * @param oldPassword
	 *            the oldPassword to set
	 */
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	/**
	 * @return the newPassword
	 */
	public String getNewPassword() {
		return newPassword;
	}
	/**
	 * @param newPassword
	 *            the newPassword to set
	 */
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	/**
	 * @return the confirmPassword
	 */
	public String getConfirmPassword() {
		return confirmPassword;
	}
	/**
	 * @param confirmPassword
	 *            the confirmPassword to set
	 */
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	/**
	 * @return the authority
	 */
	public String getAuthority() {
		return authority;
	}
	/**
	 * @param authority
	 *            the authority to set
	 */
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	/**
	 * @return the enabledStatus
	 */
	public Boolean getEnabled() {
		return enabled;
	}
	/**
	 * @param enabledStatus
	 *            the enabledStatus to set
	 */
	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	/**
	 * @return the successMessage
	 */
	public String getSuccessMessage() {
		return successMessage;
	}
	/**
	 * @param successMessage
	 *            the successMessage to set
	 */
	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}
	/**
	 * @return the exception
	 */
	public String getException() {
		return exception;
	}
	/**
	 * @param exception
	 *            the exception to set
	 */
	public void setException(String exception) {
		this.exception = exception;
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
	/**
	 * @return the entityName
	 */
	public String getEntityName() {
		return entityName;
	}
	/**
	 * @param entityName the entityName to set
	 */
	public void setEntityName(String entityName) {
		this.entityName = entityName;
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
	 * @return the isAdminFlag
	 */
	public boolean isAdminFlag() {
		return adminFlag;
	}
	/**
	 * @param isAdminFlag the isAdminFlag to set
	 */
	public void setAdminFlag(boolean adminFlag) {
		this.adminFlag = adminFlag;
	}
	public String getNewEntityName() {
		return newEntityName;
	}
	public void setNewEntityName(String newEntityName) {
		this.newEntityName = newEntityName;
	}
	


}
