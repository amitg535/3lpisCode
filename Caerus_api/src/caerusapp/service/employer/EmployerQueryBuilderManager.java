package caerusapp.service.employer;

import java.util.List;

import caerusapp.dao.employer.IEmployerQueryBuilderDao;
import caerusapp.domain.employer.EmployerQueryBuilderDom;

public class EmployerQueryBuilderManager implements IEmployerQueryBuilderManager {

	IEmployerQueryBuilderDao employerQueryBuilderDao;

	
	@Override
	public List<EmployerQueryBuilderDom> getEmployerFormulae(String emailId) {
		return employerQueryBuilderDao.getEmployerFormulae(emailId);
	}

	@Override
	public void addFormula(EmployerQueryBuilderDom employerQueryBuilderDom) {
		employerQueryBuilderDao.addFormula(employerQueryBuilderDom);
	}

	@Override
	public void deleteFormula(EmployerQueryBuilderDom employerQueryBuilderDom) {
		employerQueryBuilderDao.deleteFormula(employerQueryBuilderDom);
	}
	
	
	public IEmployerQueryBuilderDao getEmployerQueryBuilderDao() {
		return employerQueryBuilderDao;
	}

	public void setEmployerQueryBuilderDao(
			IEmployerQueryBuilderDao employerQueryBuilderDao) {
		this.employerQueryBuilderDao = employerQueryBuilderDao;
	}

	@Override
	public EmployerQueryBuilderDom getFormulaDetails(String loggedInUserEmail,String formulaName) {
		return employerQueryBuilderDao.getFormulaDetails(loggedInUserEmail,formulaName);
	}
}
