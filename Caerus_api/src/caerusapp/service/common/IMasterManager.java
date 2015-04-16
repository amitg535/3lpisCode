package caerusapp.service.common;

import java.util.List;
import java.util.Set;

public interface IMasterManager {

	List<String> getFunctionalAreas();

	List<String> getIndustries();

	List<String> getStates();

	List<String> getCourses();
	
	Set<String> getCourseTypes();

	List<String> getUniversities();
	
	String getCity(String zipCode);

	String getState(String zipCode);

	List<String> getCompanyTypes();

	List<String> getRegisteredUniversities();

	List<String> getRegisteredCompanies();

	byte[] getDefaultImage();

	List<String> getEmployeeStrength();

}
