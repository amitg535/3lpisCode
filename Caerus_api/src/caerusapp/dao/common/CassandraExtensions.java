package caerusapp.dao.common;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.cassandra.core.CassandraOperations;
import org.springframework.stereotype.Component;

import caerusapp.domain.common.JobDetailsDom;

import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;


@Component
public class CassandraExtensions {

	@Autowired
	CassandraOperations cassandraOperations;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	public Set<String> retreiveDistinctValues(String tableName, String parameter) {
		Select select = QueryBuilder.select(parameter).from(tableName);
		LinkedHashSet<String> distinctValues = new LinkedHashSet<String>();
		ResultSet resultSet = null;
		
		try
		{
			resultSet = cassandraOperations.query(select);
			if(null != resultSet && !resultSet.isExhausted())
			{
				for (Row row : resultSet) {
					if(null != row.getString(parameter))
						distinctValues.add(row.getString(parameter));
				}
			}
		}
		catch(IllegalArgumentException | NullPointerException npe)
		{
			distinctValues = new LinkedHashSet<String>();
			logger.error("Error in method retreiveDistinctValues()");
		}
		
		return distinctValues == null ? new HashSet<String>() : distinctValues;
	}

	public Object retreiveDistinctValues(String tableName,List<String> parameters,String className) {
		
		String[] stringArray = Arrays.copyOf(parameters.toArray(), parameters.toArray().length, String[].class);
		Select select = QueryBuilder.select(stringArray).from(tableName);
		
		LinkedHashMap<String,String> distinctValues = new LinkedHashMap<String,String>();
		ResultSet resultSet = null;
		
		if(className.equals("JobDetailsDom"))
		{
			JobDetailsDom jobDetailsDom = new JobDetailsDom();
			
			try
			{
				resultSet = cassandraOperations.query(select);
				//Iterator itr = resultSet.iterator();
				//int i = 0;
				
				/*while (resultSet.next()) {

					jobDetailsDom.setUniversityName(resultSet.get);
				}
				*/
				/*while(itr.hasNext())
				{
					jobDetailsDom.setUniversityName("");
				}
				
				if(null != resultSet && !resultSet.isExhausted())
				{
					for (Row row: resultSet) {
						for
						
						if(null != row.getString(""))
							jobDetailsDom.setUniversityName(universityName);
					}
				}*/
			}
			catch(IllegalArgumentException | NullPointerException npe)
			{
				logger.error("Error in method retreiveDistinctValues()");
			}
			
		}
		
		
		return distinctValues == null ? new HashMap<String,String>() : distinctValues;
	}

	public Map<String, List<String>> checkListContains(String tablename,
			String primaryKey, String listColumn, String checkEntity) {
		
		Map<String,List<String>> contaningValues = new HashMap<String,List<String>>();
		Select select= QueryBuilder.select(primaryKey,listColumn).from(tablename);
		ResultSet resultSet =cassandraOperations.query(select);
		for(Row row: resultSet){
			if(row.getList(listColumn,String.class).toString().contains(checkEntity)){
				contaningValues.put(row.getString(primaryKey), row.getList(listColumn,String.class));
				}
				
		}
		return contaningValues;
	}

	public Map<String, Map<String, Date>> checkMapContains(
			String tablename, String primayKey, String mapColumn,
			String checkEntity) {
		Map<String, Map<String, Date>> contaningValuesMap = new HashMap<String, Map<String, Date>>();
		Select select = QueryBuilder.select(primayKey,mapColumn).from(tablename);
		ResultSet rs=cassandraOperations.query(select);
		for (Row row : rs) {
			if(row.getMap(mapColumn, String.class, Date.class).containsKey(checkEntity))
				contaningValuesMap.put(row.getString(primayKey), row.getMap(mapColumn, String.class, Date.class));
		}
		return contaningValuesMap;
	}
	
	
	
	
	
	
}
