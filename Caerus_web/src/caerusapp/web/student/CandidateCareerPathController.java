package caerusapp.web.student;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import caerusapp.command.common.CareerPathLevelCmd;
import caerusapp.dao.common.CareerPathDao;
import caerusapp.domain.common.CareerPathLevelDom;
import caerusapp.service.common.ICareerPathTree;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;

@Controller
public class CandidateCareerPathController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	ICareerPathTree careerPathTree;
	
	@Autowired
	private CareerPathDao careerPathDao;
	
	@Autowired
	StudentManager studentManager;
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_VIEW_CAREER_PATH,method={RequestMethod.GET})
	public String viewCareerPathsPage(Model model){
	
		List<CareerPathLevelDom> careerPathLevelsDetails=new ArrayList<CareerPathLevelDom>();
		CareerPathLevelCmd careerPathlevel = new CareerPathLevelCmd();
		
		
		List<String> functionalArea = masterManager.getFunctionalAreas();
		
		careerPathLevelsDetails = careerPathTree.getAllLevelsDetails();
		
		model.addAttribute("careerPathlevel", careerPathlevel);
		model.addAttribute("functionalArea", functionalArea);
		model.addAttribute("careerPathLevelsDetails", careerPathLevelsDetails);
		
		return "candidate/candidate_careerpath";
		
	}

}
