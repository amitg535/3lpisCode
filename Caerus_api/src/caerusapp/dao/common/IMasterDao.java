package caerusapp.dao.common;

import java.util.List;
import java.util.Set;

public interface IMasterDao {

	List<String> getFunctionalAreas();

	List<String> getIndustries();

	List<String> getStates();

	List<String> getCourses();

	List<String> getUniversities();

	Set<String> getCourseTypes();

	List<String> getCompanyTypes();

	String getCity(String zipCode);
	
	String getState(String zipCode);

	List<String> getRegisteredUniversities();

	List<String> getRegisteredCompanies();

	byte[] getDefaultImage();

	List<String> getEmployeeStrength();

}
