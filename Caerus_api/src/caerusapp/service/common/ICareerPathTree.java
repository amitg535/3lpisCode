package caerusapp.service.common;

import java.util.List;
import java.util.Map;

import caerusapp.domain.common.CareerPathLevelDom;




public interface ICareerPathTree  {
    
	/**
	 * This method is used to insert the details of a careerPathLevel
	 * @param level
	 */
	public void insertLevelDetails(CareerPathLevelDom level);
	
	/**
	 * This Method is used to get all the levels stored for a functional area
	 * @param functionalArea
	 * @return List<functionalarea>
	 */
	public List<String> getAllLevelsForFunctionalArea(String functionalArea);
	
	
	/**
	 * This Method is used to get all the parents stored for a functional area
	 * @param functionalArea
	 * @return List<parents>
	 */
	public List<String> getAllParents(String functionalArea);
	
	/**
	 * This method is used to get the map of all the parent-child relationships for a functional area
	 * @param functionalArea
	 * @return Map<parent,child>
	 */
	public Map<String,String> getCareerMap(String functionalArea);
	
	/**
	 * This method is used to get all the career path levels 
	 * @return list<CareerPathLevels>
	 */
	public List<CareerPathLevelDom> getAllLevelsDetails();

	/**
	 * This method gets the details for a level
	 * @param levelName
	 * @param functionalArea
	 * @return
	 */
	public CareerPathLevelDom getDetailsForLevel(String levelName,
			String functionalArea);

    
    
    
	
}