package caerusapp.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import caerusapp.dao.common.CareerPathDao;
import caerusapp.domain.common.CareerPathLevelDom;




/**
 * @author TulsiC
 *
 */
public class CareerPathTree implements ICareerPathTree{

	@Autowired
	private CareerPathDao careerPathDao;
	
	
	@Override
	public void insertLevelDetails(CareerPathLevelDom level) {
		
		careerPathDao.insertLevelDetails(level);
		
	}
	

	@Override
	public List<String> getAllParents(String functionalArea) {
		return careerPathDao.getAllParents(functionalArea);
	}

	@Override
	public List<String> getAllLevelsForFunctionalArea(String functionalArea) {
		return careerPathDao.getAllLevelsForFunctionalArea(functionalArea);
	}

	@Override
	public List<CareerPathLevelDom> getAllLevelsDetails() {
		return careerPathDao.getAllLevelsDetails();
		
	}

	@Override
	public Map<String, String> getCareerMap(String functionalArea) {
		
		return careerPathDao.getCareerMap(functionalArea);
	}

	

	public CareerPathDao getCareerPathDao() {
		return careerPathDao;
	}
	
	public void setCareerPathDao(CareerPathDao careerPathDao) {
		this.careerPathDao = careerPathDao;
	}


	@Override
	public CareerPathLevelDom getDetailsForLevel(String levelName,
			String functionalArea) {
		return careerPathDao.getDetailsForLevel(levelName,functionalArea);
	}


	
}