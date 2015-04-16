package caerusapp.dao.employer;

import java.util.List;

import caerusapp.domain.employer.EmployerQueryBuilderDom;

public interface IEmployerQueryBuilderDao {

	List<EmployerQueryBuilderDom> getEmployerFormulae(String emailId);

	void addFormula(EmployerQueryBuilderDom employerQueryBuilderDom);

	void deleteFormula(EmployerQueryBuilderDom employerQueryBuilderDom);

	EmployerQueryBuilderDom getFormulaDetails(String loggedInUserEmail,String formulaName);

}
