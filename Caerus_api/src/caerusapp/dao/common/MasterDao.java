package caerusapp.dao.common;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.cassandra.core.CassandraOperations;

import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;

public class MasterDao implements IMasterDao {

	@Autowired
	CassandraOperations cassandraOperations;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getFunctionalAreas()
	{
		List<String> functionalAreas = new ArrayList<String>();
		try{
			functionalAreas = (List<String>) cassandraOperations.queryForObject("select functionarea from master_demo where master_values='1'", List.class);
		}
		catch(Exception ex)
		{
			
		}
		
		return functionalAreas == null ? new ArrayList<String>() : functionalAreas;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getIndustries() {
		List<String> industries = new ArrayList<String>();
		try{
			industries =  (List<String>) cassandraOperations.queryForObject("select industry_name from master_demo where master_values='1'", List.class);
		}
		catch(Exception ex)
		{
			
		}
		return industries == null ? new ArrayList<String>() : industries;
	}

	public List<String> getStates() 
	{
		List<String> states = new ArrayList<String>();
		try
		{
			states = cassandraOperations.queryForObject("select school_state from master_demo", List.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return states == null ? new ArrayList<String>() : states;
	}

	@Override
	public List<String> getCourses() 
	{
		List<String> courses = new ArrayList<String>();
		try
		{
			courses = cassandraOperations.queryForObject("select course_name from master_demo", List.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return courses == null ? new ArrayList<String>() : courses;
	}

	@Override
	public List<String> getUniversities() 
	{
		List<String> universities = new ArrayList<String>();
		try
		{
			universities = cassandraOperations.queryForObject("select university_name from master_demo", List.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return universities == null ? new ArrayList<String>() : universities;
	}
	
	@Override
	public Set<String> getCourseTypes() 
	{
		Set<String> courseTypes = new HashSet<String>();
		try
		{
			courseTypes = cassandraOperations.queryForObject("select course_type from master_demo", Set.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return courseTypes == null ? new HashSet<String>() : courseTypes;
	}

	@Override
	public List<String> getCompanyTypes() 
	{
		List<String> companyTypes = new ArrayList<String>();
		try
		{
			companyTypes = cassandraOperations.queryForObject("select company_type from master_demo", List.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return companyTypes == null ? new ArrayList<String>() : companyTypes;
	}

	public String getCity(String zipCode) {
		String city = "";
		try 
		{
			String query = "select city from zipcode_master where zip = '"+zipCode+"' ALLOW FILTERING";
			city = cassandraOperations.queryForObject(query, String.class);
		}
		catch (EmptyResultDataAccessException e) 
		{
			logger.error(e.getStackTrace());
		}
		return city;	
	}
	
	@Override
	public String getState(String zipCode) {
		
		String state = "";
		try 
		{
			String query = "select state from zipcode_master where zip = '"+zipCode+"' ALLOW FILTERING";
			state = cassandraOperations.queryForObject(query, String.class);
		}

		catch (EmptyResultDataAccessException e) {
			logger.error(e.getStackTrace());
		}
		return state;
	}

	@Override
	public List<String> getRegisteredUniversities() {
		List<String> registeredUnivNames = new ArrayList<String>();
		Select selectRegisteredUnivNames = QueryBuilder.select("universityname").from("university_reg");
		try {
			registeredUnivNames = cassandraOperations.queryForList(selectRegisteredUnivNames, String.class);
		}
		catch(NullPointerException npe){
			registeredUnivNames = new ArrayList<String>();
			logger.error("NullPointer Exception in getRegisteredUniversities");
		}
		catch(IllegalArgumentException argEx){
			logger.error("IllegalArgumentException in getRegisteredUniversities");
		}
		catch(NoHostAvailableException noHostEx){
			logger.error("NoHostAvailableException in getRegisteredUniversities");
		}
		return registeredUnivNames == null ? new ArrayList<String>(): registeredUnivNames;
	}

	@Override
	public List<String> getRegisteredCompanies() {
		List<String> registeredCompanyNames = new ArrayList<String>();
		
		Select selectRegisteredCompanyNames = QueryBuilder.select("company_name").from("employer_details");
		
		try { 
			registeredCompanyNames = cassandraOperations.queryForList(selectRegisteredCompanyNames, String.class);
		}
		catch(IllegalArgumentException | NullPointerException ex){
			registeredCompanyNames = new ArrayList<String>();
		}
		return registeredCompanyNames == null ? new ArrayList<String>() : registeredCompanyNames;
	}

	@Override
	public byte[] getDefaultImage() {
		Select selectDefaultImage = QueryBuilder.select("default_photo").from("master_demo");
		byte[] defaultImage = null;
		try {
			ByteBuffer defaultImageBB = cassandraOperations.queryForObject(selectDefaultImage, ByteBuffer.class);
			
			if(defaultImageBB != null && defaultImageBB.hasRemaining()){
				defaultImage = new byte[defaultImageBB.remaining()];
				defaultImageBB.get(defaultImage);
			}
		}
		catch(NullPointerException | IllegalArgumentException ex){
			logger.error("Null Pointer Exception in getDefaultImage "+ ex.getStackTrace().toString());
		}
		return defaultImage;
	}

	@Override
	public List<String> getEmployeeStrength() {
		List<String> employeeStrength = new ArrayList<String>();
		try
		{
			employeeStrength = cassandraOperations.queryForObject("select emp_strength from master_demo", List.class);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return employeeStrength == null ? new ArrayList<String>() : employeeStrength;
	}
}
