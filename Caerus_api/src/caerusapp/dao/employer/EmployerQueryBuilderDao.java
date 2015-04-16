package caerusapp.dao.employer;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;
import org.springframework.util.StringUtils;

import caerusapp.domain.employer.EmployerQueryBuilderDom;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Update;

public class EmployerQueryBuilderDao implements IEmployerQueryBuilderDao {
	
	Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	CassandraOperations cassandraOperations;

	@Override
	public List<EmployerQueryBuilderDom> getEmployerFormulae(String emailId) {
		String getEmployerFormulae = "select * from employer_querybuilder_dtls where email_id='"+emailId+"' and is_deleted=false";
		List<EmployerQueryBuilderDom> employerFormulae = new ArrayList<EmployerQueryBuilderDom>();
		
		try {
			employerFormulae = cassandraOperations.query(getEmployerFormulae, new EmployerQueryBuilderMapper());
		}
		catch(IllegalArgumentException argEx){
			logger.error("IllegalArgumentException in getEmployerFormulae");
		}
		catch(NoHostAvailableException noHostEx){
			logger.error("NoHostAvailableException to Serve the request in getEmployerFormulae");
		}
		catch (NullPointerException npe) {
			logger.error("NullPointerException in getEmployerFormulae");
		}
		return employerFormulae == null ? new ArrayList<EmployerQueryBuilderDom>():employerFormulae;
	}
	
	
	private class EmployerQueryBuilderMapper implements RowMapper<EmployerQueryBuilderDom> {

		@Override
		public EmployerQueryBuilderDom mapRow(Row rs, int arg1) throws DriverException {

			EmployerQueryBuilderDom employerFormulaDetails = new EmployerQueryBuilderDom();
			employerFormulaDetails.setFirmId(rs.getString("firm_id"));
			employerFormulaDetails.setEmailId(rs.getString("email_id"));
			employerFormulaDetails.setFormulaName(rs.getString("formula_name"));
			employerFormulaDetails.setFormulaList(rs.getList("formula_list",String.class));
			
			if(rs.getList("formula_list",String.class) != null && rs.getList("formula_list",String.class).size() > 0)
				employerFormulaDetails.setFormula(StringUtils.collectionToDelimitedString(rs.getList("formula_list",String.class), ""));
			
			return employerFormulaDetails;
		}
	}


	@Override
	public void addFormula(EmployerQueryBuilderDom employerQueryBuilderDom) {
		
		Insert addFormula = QueryBuilder.insertInto("employer_querybuilder_dtls").values(
				new String[]{"formula_name","email_id","firm_id","formula_list","is_deleted"},
				new Object[]{
				employerQueryBuilderDom.getFormulaName(),
				employerQueryBuilderDom.getEmailId(),
				employerQueryBuilderDom.getFirmId(),
				employerQueryBuilderDom.getFormulaList(),
				false});
		
		cassandraOperations.execute(addFormula);
	}


	@Override
	public void deleteFormula(EmployerQueryBuilderDom employerQueryBuilderDom) {
		Update deleteFormula = QueryBuilder.update("employer_querybuilder_dtls");
		
		deleteFormula.where(QueryBuilder.eq("email_id", employerQueryBuilderDom.getEmailId()));
		deleteFormula.where(QueryBuilder.eq("formula_name", employerQueryBuilderDom.getFormulaName()));
		
		deleteFormula.with(QueryBuilder.set("is_deleted", true));
		
		cassandraOperations.execute(deleteFormula);
	}


	@Override
	public EmployerQueryBuilderDom getFormulaDetails(String loggedInUserEmail,String formulaName) {
		String getFormulaDetails = "select * from employer_querybuilder_dtls where email_id='"+
		loggedInUserEmail+"' and formula_name='"+formulaName+"'";
		
		EmployerQueryBuilderDom formulaDetails = new EmployerQueryBuilderDom();
		try {
			formulaDetails = cassandraOperations.queryForObject(getFormulaDetails, new EmployerQueryBuilderMapper());
		}
		catch(IllegalArgumentException argEx) {
			
		}
		catch(NoHostAvailableException noHostEx) {
			
		}
		return formulaDetails == null ? new EmployerQueryBuilderDom():formulaDetails;
	}
}
