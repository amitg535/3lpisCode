package caerusapp.command.employer;

import java.util.List;

public class EmployerQueryBuilderCom {

	private String firmId;
	private String emailId;
	private String formulaName;
	private String formula;
	private String successMessage;
	private String deleteAndEditButtonStatus;
	private String action;

	private List<String> formulaList;

	
	
	public String getFirmId() {
		return firmId;
	}

	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getFormulaName() {
		return formulaName;
	}

	public void setFormulaName(String formulaName) {
		this.formulaName = formulaName;
	}

	public String getFormula() {
		return formula;
	}

	public void setFormula(String formula) {
		this.formula = formula;
	}

	public String getSuccessMessage() {
		return successMessage;
	}

	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}

	public String getDeleteAndEditButtonStatus() {
		return deleteAndEditButtonStatus;
	}

	public void setDeleteAndEditButtonStatus(String deleteAndEditButtonStatus) {
		this.deleteAndEditButtonStatus = deleteAndEditButtonStatus;
	}

	public List<String> getFormulaList() {
		return formulaList;
	}

	public void setFormulaList(List<String> formulaList) {
		this.formulaList = formulaList;
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
