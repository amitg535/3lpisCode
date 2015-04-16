package caerusapp.dao.common;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.common.CareerPathLevelDom;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;

public class JdbcCareerPathDao implements CareerPathDao {
	 
	/**
	 * @param args
	 */
	
	@Autowired
	CassandraOperations cassandraOperations;
	
	@SuppressWarnings("unused")
	@Override
	public void insertLevelDetails(CareerPathLevelDom level) {
		
		 
		 DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			// Get the date today using Calendar object.
			Calendar today = Calendar.getInstance();        
			
			  try  
		   
			  {
			  String insertLevelDetails="insert into level_details(level_name,area_of_interest,avg_salary,level_description,years,parent,insertion_time) values("+"'"+level.getLevelName()+"'"+","+"'"+level.getFunctionalArea()+"'"+","+level.getSalary()+","+"'"+level.getDescription()+"'"+","+level.getYears()+","+"'"+level.getParent()+"'"+","+"'"+df.format(today.getTime())+"'"+")";
				 cassandraOperations.execute(insertLevelDetails);
			  
			   if(!level.getParent().equalsIgnoreCase(""))
			   {
				  
				   String parent=level.getParent();
				   String levelName=level.getLevelName();
				   String newKey=parent+"_child1";
				   
				   
				   String parent_child=parent+"_child";
				   
				   String queryForMapCount="Select count(*) from career_paths where area_of_interest='"+level.getFunctionalArea()+"'";
				   int mapcount = Integer.parseInt(cassandraOperations.queryForObject(queryForMapCount, Long.class).toString());
				   
				   if(mapcount>0)
				   {
					   String queryForGettingMap="Select career_paths from career_paths where area_of_interest='"+level.getFunctionalArea()+"'";
					  
					@SuppressWarnings("unchecked")
					Map<String,String>  careerPathMap = (Map<String, String>) cassandraOperations.queryForObject(queryForGettingMap, Map.class);
						   
						   for(int i=careerPathMap.size();i>0;i--){
							   String parent_child_i=parent_child+i;
							   
							    if(careerPathMap.containsKey(parent_child_i))
							    {
							    	newKey=parent_child+(i+1);
							    	break;
							    }
							    else{
							    	newKey=parent_child+1;
							    	}
						   }
						   
					   String queryForUpdateinMap="update career_paths set career_paths=career_paths + {'"+newKey+"':'"+levelName+"'} where area_of_interest='"+level.getFunctionalArea()+"'";
						   
						if(careerPathMap!=null || !careerPathMap.containsValue(levelName)){
							cassandraOperations.execute(queryForUpdateinMap);
					   }
				   }
				   else
				   {
					   String queryForInsertInMap="insert into career_paths(career_paths,area_of_interest) values({'"+newKey+"':'"+levelName+"'} ,'"+level.getFunctionalArea()+"')";
					   		cassandraOperations.execute(queryForInsertInMap);
				   }
				   
				   String queryForRetrievingTimestamp="select insertion_time from level_details where level_name='"+level.getParent()+"' and area_of_interest='"+level.getFunctionalArea()+"'";
				   		String time = cassandraOperations.queryForObject(queryForRetrievingTimestamp, String.class);
				   
				   
				   String queryForUpadteInParentDetail="update level_details set is_parent=true where level_name='"+level.getParent()+"' and area_of_interest ='"+level.getFunctionalArea()+"' and insertion_time='"+time+"'";
				   		cassandraOperations.execute(queryForUpadteInParentDetail);
			   }
		   }
			  
		   catch(Exception e)
		   {
			   e.printStackTrace();
		   }
		
		
	}
	
	@Override
	public List<String> getAllLevelsForFunctionalArea(String functionalArea) {
		String queryForGettingAllLevels="select area_of_interest,level_name from level_details ";
		@SuppressWarnings("unchecked")
		List<CareerPathLevelDom> levels = new ArrayList<CareerPathLevelDom>();
		try{
		 levels =  cassandraOperations.query(queryForGettingAllLevels, new CareerLevelNameandAreaMapper());
		}
		catch(Exception e){
			
		}
		List<String> levelNames = new ArrayList<String>();
		for(CareerPathLevelDom careerPathLevelDom :levels )
		{
			if(careerPathLevelDom.getFunctionalArea().equals(functionalArea))
			{
				levelNames.add(careerPathLevelDom.getLevelName());
			}
		}
		return levelNames;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<String> getAllParents(String functionalArea) {
		List<CareerPathLevelDom> parentList=new ArrayList<CareerPathLevelDom>();
		List<CareerPathLevelDom> sortedParentPojoList=new ArrayList<CareerPathLevelDom>();
		List<String> parentSortedList=new ArrayList<String>();
		//List<String> parentSortedList=new ArrayList<String>();
		
		String queryForGettingParents="select level_name,area_of_interest,insertion_time from level_details";
			parentList = cassandraOperations.query(queryForGettingParents,new CareerLevelNameandTimeMapper());
		
			for (CareerPathLevelDom careerPathLevelDom : parentList) {
				if(careerPathLevelDom.getFunctionalArea().equalsIgnoreCase(functionalArea))
					sortedParentPojoList.add(careerPathLevelDom);
			}
			
			sortedParentPojoList = CaerusCommonUtility.sortListByDateReverse(sortedParentPojoList, "CareerPathLevelDom");	
			for (CareerPathLevelDom careerPathLevelDom : sortedParentPojoList) {
				parentSortedList.add(careerPathLevelDom.getLevelName());
			}
			
		/*for(String parent:parentList){
			parentListString+="'"+parent+"'"+",";
		}*/
		
						/*parentListString = parentListString.substring(0, parentListString.length()-1);
						
						
						String queryForSortingList ="select level_name,insertion_time ,area_of_interest from level_details order by insertion_time";
						try
						{
							sortedParentPojoList = cassandraOperations.query(queryForSortingList,new CareerLevelNameandTimeMapper());
						}
						catch(Exception e){
							e.printStackTrace();
						}
						for(CareerPathLevelDom parent:sortedParentPojoList){
							parentSortedList.add(parent.getLevelName());
						}*/
		
		return parentSortedList;
	}
	@SuppressWarnings("unchecked")
	@Override
	public Map<String,String> getCareerMap(String functionalArea) {
		Map<String, String> careerMap=new HashMap<String,String>();
		
		String queryForcheckingMapExists="select count(*) from career_paths where area_of_interest='"+functionalArea+"'";
			int count = Integer.parseInt(cassandraOperations.queryForObject(queryForcheckingMapExists, Long.class).toString());

		if(count>0){
		String queryForGettingMap="select career_paths from career_paths where area_of_interest='"+functionalArea+"'";
		careerMap = cassandraOperations.queryForObject(queryForGettingMap, Map.class);
		}
		return careerMap;
	}
	
	private static class CareerLevelNameandAreaMapper implements
	RowMapper<CareerPathLevelDom> {
    	@Override
	public CareerPathLevelDom mapRow(Row rs, int arg1) throws DriverException {
		CareerPathLevelDom careerPathLevelDom = new CareerPathLevelDom();
		careerPathLevelDom.setLevelName(rs.getString("level_name"));
		careerPathLevelDom.setFunctionalArea(rs.getString("area_of_interest"));
		return careerPathLevelDom;
	}
}

	@Override
	public List<CareerPathLevelDom> getAllLevelsDetails() {
		String queryForGettingAllLevelsDetails="Select level_name,level_description,area_of_interest,avg_salary,years,parent from level_details";
		List<CareerPathLevelDom> careerPathLevels = cassandraOperations.query(queryForGettingAllLevelsDetails, new CareerLevelDetailsMapper());
		
		return careerPathLevels;
	}

	private static class CareerLevelDetailsMapper implements RowMapper<CareerPathLevelDom>{

		@Override
		public CareerPathLevelDom mapRow(Row rs, int arg1)
				throws DriverException {
			CareerPathLevelDom careerPathLevelDom = new CareerPathLevelDom();
			careerPathLevelDom.setLevelName(rs.getString("level_name"));
			careerPathLevelDom.setDescription(rs.getString("level_description"));
			careerPathLevelDom.setFunctionalArea(rs.getString("area_of_interest"));
			careerPathLevelDom.setSalary(rs.getDouble("avg_salary"));
			careerPathLevelDom.setYears(rs.getDouble("years"));
			careerPathLevelDom.setParent(rs.getString("parent"));
			return careerPathLevelDom;
		}
	}
	
	private static class CareerLevelNameandTimeMapper implements RowMapper<CareerPathLevelDom>{

		@Override
		public CareerPathLevelDom mapRow(Row rs, int arg1)
				throws DriverException {
			CareerPathLevelDom careerPathLevelDom = new CareerPathLevelDom();
			careerPathLevelDom.setLevelName(rs.getString("level_name"));
			careerPathLevelDom.setInsertionTime(rs.getString("insertion_time"));
			careerPathLevelDom.setFunctionalArea(rs.getString("area_of_interest"));
			return careerPathLevelDom;
		}
		
		
	}

	@Override
	public CareerPathLevelDom getDetailsForLevel(String levelName,
			String functionalArea) {
		CareerPathLevelDom levelDetails = null;
		String queryToCheckIfLevelExists="select count(*) from level_details where level_name='"+levelName+"' and area_of_interest='"+functionalArea+"'";
			int countIfExists = Integer.parseInt(cassandraOperations.queryForObject(queryToCheckIfLevelExists, Long.class).toString());

		if(countIfExists>0){
		String queryForDetails="select * from level_details where level_name='"+levelName+"' and area_of_interest='"+functionalArea+"'";
		levelDetails = cassandraOperations.queryForObject(queryForDetails, new CareerLevelDetailsMapper());
		}
		
		return levelDetails;
	}

}