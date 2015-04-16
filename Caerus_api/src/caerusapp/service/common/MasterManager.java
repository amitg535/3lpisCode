package caerusapp.service.common;

import java.util.List;
import java.util.Set;

import caerusapp.dao.common.IMasterDao;

public class MasterManager implements IMasterManager {

	private IMasterDao masterDao;

	public IMasterDao getMasterDao() {
		return masterDao;
	}

	public void setMasterDao(IMasterDao masterDao) {
		this.masterDao = masterDao;
	}

	@Override
	public List<String> getFunctionalAreas() {
		return masterDao.getFunctionalAreas();
	}

	@Override
	public List<String> getIndustries() 
	{
		return masterDao.getIndustries();
	}
	
	@Override
	public List<String> getStates()
	{
		return masterDao.getStates();
	}

	@Override
	public List<String> getCourses() 
	{
		return masterDao.getCourses();
	}

	@Override
	public List<String> getUniversities() 
	{
		return masterDao.getUniversities();
	}

	@Override
	public Set<String> getCourseTypes() 
	{
		return masterDao.getCourseTypes();
	}

	@Override
	public List<String> getCompanyTypes() 
	{
		return masterDao.getCompanyTypes();
	}
	@Override
	public String getCity(String zipCode) 
	{
		return masterDao.getCity(zipCode);	
	}
	
	@Override
	public String getState(String zipCode)
	{
		return masterDao.getState(zipCode);	
	}

	@Override
	public List<String> getRegisteredUniversities() {
		return masterDao.getRegisteredUniversities();	
	}

	@Override
	public List<String> getRegisteredCompanies() {
		return masterDao.getRegisteredCompanies();
	}

	@Override
	public byte[] getDefaultImage() {
		return masterDao.getDefaultImage();
	}

	@Override
	public List<String> getEmployeeStrength() {
		return masterDao.getEmployeeStrength();
	}
}
