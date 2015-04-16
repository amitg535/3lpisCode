/**
 * 
 */
package caerusapp.domain.employer;

import java.util.List;

/**
 * @author KarthikeyanK
 * 
 */
public class EmployerQueryBuilderDom {

	private String firmId;
	private String emailId;
	private String formulaName;
	private String formula;
	private String successMessage;
	private String deleteAndEditButtonStatus;
	private String action;

	private List<String> formulaList;


	
	
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
	 * @return the formulaName
	 */
	public String getFormulaName() {
		return formulaName;
	}

	/**
	 * @param formulaName
	 *            the formulaName to set
	 */
	public void setFormulaName(String formulaName) {
		this.formulaName = formulaName;
	}

	/**
	 * @return the formula
	 */
	public String getFormula() {
		return formula;
	}

	/**
	 * @param formula
	 *            the formula to set
	 */
	public void setFormula(String formula) {
		this.formula = formula;
	}

	/**
	 * @return the formulaList
	 */
	public List<String> getFormulaList() {
		return formulaList;
	}

	/**
	 * @param formulaList
	 *            the formulaList to set
	 */
	public void setFormulaList(List<String> formulaList) {
		this.formulaList = formulaList;
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
	 * @return the deleteAndEditButtonStatus
	 */
	public String getDeleteAndEditButtonStatus() {
		return deleteAndEditButtonStatus;
	}

	/**
	 * @param deleteAndEditButtonStatus
	 *            the deleteAndEditButtonStatus to set
	 */
	public void setDeleteAndEditButtonStatus(String deleteAndEditButtonStatus) {
		this.deleteAndEditButtonStatus = deleteAndEditButtonStatus;
	}

	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}

	/**
	 * @param action the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}

}