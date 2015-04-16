/**
 * 
 */
package caerusapp.web.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import caerusapp.command.common.CareerPathLevelCmd;
import caerusapp.dao.common.CareerPathDao;
import caerusapp.domain.common.CareerPathLevelDom;
import caerusapp.service.common.CareerPathLevelTree;
import caerusapp.service.common.ICareerPathTree;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;


/**
 * 
 * @author TulciC
 *
 */
@Controller
public class AdminViewCareerPathController  {
	
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	ICareerPathTree careerPathTree;
	
	@Autowired
	private CareerPathDao careerPathDao;
	
	@Autowired
	StudentManager studentManager;
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_VIEW_CAREER_PATH,method={RequestMethod.GET,RequestMethod.POST})
	public String viewCareerPathsPage(Model model){
	
		List<CareerPathLevelDom> careerPathLevelsDetails=new ArrayList<CareerPathLevelDom>();
		CareerPathLevelCmd careerPathlevel = new CareerPathLevelCmd();
		
		
		List<String> functionalArea = masterManager.getFunctionalAreas();
		
		careerPathLevelsDetails = careerPathTree.getAllLevelsDetails();
		
		model.addAttribute("careerPathlevel", careerPathlevel);
		model.addAttribute("functionalArea", functionalArea);
		model.addAttribute("careerPathLevelsDetails", careerPathLevelsDetails);
		
		return "admin/admin_careerpath";
		
	}

	
	/*@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_ADD_CAREER_LEVEL_FORM,method=RequestMethod.GET)
	public String addcareerpathlevelForm(ModelMap model){
		
		CareerPathLevelCmd level = new CareerPathLevelCmd();
		
		List<String> areaOfInterest= new ArrayList<String>();
		areaOfInterest.add("Mining");
		areaOfInterest.add("Finance");
		areaOfInterest.add("Environment");
		areaOfInterest.add("IT");
		model.put("CareerPathLevelCmd", level);
		model.addAttribute("areaOfInterest",areaOfInterest );
		
		//model.addAttribute("CareerPathLevelCmd", attributeValue)
		return "admin/NewFile";
		
	}*/

	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_ADD_CAREER_LEVEL ,method = RequestMethod.POST)
	public String addLevel(@ModelAttribute("CareerPathLevelCmd") CareerPathLevelCmd careerPathLevelCmd,
		BindingResult result, SessionStatus status) {
 
		CareerPathLevelDom careerPathLevel =new CareerPathLevelDom();
		
		careerPathLevel.setLevelName(careerPathLevelCmd.getLevelName());
		careerPathLevel.setDescription(careerPathLevelCmd.getDescription());
		careerPathLevel.setFunctionalArea(careerPathLevelCmd.getFunctionalArea());
		careerPathLevel.setSalary(careerPathLevelCmd.getSalary());
		careerPathLevel.setParent(careerPathLevelCmd.getParent());
		careerPathLevel.setYears(careerPathLevelCmd.getYears());
		
		
		careerPathTree.insertLevelDetails(careerPathLevel);
		
		//clear the command object from the session
		status.setComplete(); 
 
		//return form success view
		return "redirect:admin_view_careerpaths.htm";
 
	}
	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_GETPARENTS_FOR_FUNCTIONAL_AREA , method=RequestMethod.GET)
	@ResponseBody
	public List<String> getParent(@RequestParam("functionalArea") String functionalArea ){
		List<String> functionalAreaLevels=careerPathTree.getAllLevelsForFunctionalArea(functionalArea);
		
		return functionalAreaLevels;
	}
	
	
	@RequestMapping(value=CaerusAnnotationURLConstants.ADMIN_GET_JSON_FOR_TREE , method=RequestMethod.GET)
	@ResponseBody
	public String getJson(@RequestParam("functionalArea") String functionalArea ) {
		//System.out.println("functionalArea="+functionalArea);
		
		Map<String,CareerPathLevelTree> treeMap= new HashMap<String, CareerPathLevelTree>();
		Map<String,String> careerMap= careerPathTree.getCareerMap(functionalArea);
		
		List<String> parentlist=careerPathTree.getAllParents(functionalArea);

		for(String parent:parentlist){
			String currentParent=parent;
			
			if(treeMap.size() == 0){
				CareerPathLevelTree tree1= new CareerPathLevelTree();
				treeMap.put("tree1", tree1);
				CareerPathLevelDom levelDetails=careerPathTree.getDetailsForLevel(currentParent,functionalArea);
				tree1.insertRoot(currentParent,levelDetails.getSalary(),levelDetails.getYears(),levelDetails.getFunctionalArea(),levelDetails.getDescription(),levelDetails.getParent());
				for (int i=0;i<=careerMap.size();i++)
				{
					//System.out.print(currentParent.concat("_child"));
					String key=currentParent.concat("_child")+i;
					//System.out.print(key);
					if(careerMap.containsKey(key))
					{
						//System.out.print(true);
						//System.out.println(careerMap.get(key));
						 levelDetails=careerPathTree.getDetailsForLevel(careerMap.get(key),functionalArea);
						tree1.insertChild(careerMap.get(key),levelDetails.getSalary(),levelDetails.getYears(),levelDetails.getFunctionalArea(),levelDetails.getDescription(),currentParent);
						//levelName,salary,years,functionalArea,description,parent
						tree1.printPath();
					}
					
				}
				
			}
			
			else{
				
				CareerPathLevelDom foundFlag = null; 
				CareerPathLevelTree treeFound = null;
				
					for(Entry<String, CareerPathLevelTree> tree : treeMap.entrySet())
					{
						foundFlag = null; 
						//System.out.println("");
						 treeFound = null;
						 CareerPathLevelDom rootNode= tree.getValue().getRoot();
						 foundFlag =  tree.getValue().find(rootNode, currentParent);
						 //System.out.println("\n treefound" + tree.getValue().toString() + "==========="+tree.getValue().getRoot());
						 if(foundFlag!=null){
						 treeFound = tree.getValue();
						 break;
						 }
					}
				if(null==foundFlag)
				{
					CareerPathLevelTree newAddedTree;
					 int treeMapSize= treeMap.size();
					 int finaltreeMapSize = treeMapSize+1;
					 String newTreeSize =Integer.toString(finaltreeMapSize);
					 //System.out.println(newTreeSize);
					 String newKeyForTree = "tree"+newTreeSize;
					 //System.out.println(newKeyForTree);
					
					 CareerPathLevelTree tree2 = new CareerPathLevelTree();
					 treeMap.put(newKeyForTree, tree2);
					if(treeMap.containsKey(newKeyForTree))
					{
						newAddedTree=treeMap.get(newKeyForTree);
						CareerPathLevelDom levelDetails=careerPathTree.getDetailsForLevel(currentParent,functionalArea);
						newAddedTree.insertRoot(currentParent,levelDetails.getSalary(),levelDetails.getYears(),levelDetails.getFunctionalArea(),levelDetails.getDescription(),levelDetails.getParent());
						for (int i=0;i<=careerMap.size();i++)
						{
							//System.out.print(currentParent.concat("_child"));
							String key=currentParent.concat("_child")+i;
							//System.out.print(key);
							if(careerMap.containsKey(key))
							{
								//System.out.print(true);
								 levelDetails=careerPathTree.getDetailsForLevel(careerMap.get(key),functionalArea);
								newAddedTree.insertChild(careerMap.get(key),levelDetails.getSalary(),levelDetails.getYears(),levelDetails.getFunctionalArea(),levelDetails.getDescription(),currentParent);
								newAddedTree.printPath();
							}
							
						}
					}
					 
					 
					// tree2.insertRoot(data, salary); store in map and retreive from map again
				}
				else{
					for (int i=0;i<=careerMap.size();i++)
					{
						//System.out.print(currentParent.concat("_child"));
						String key=currentParent.concat("_child")+i;
						//System.out.print(key);
						if(careerMap.containsKey(key))
						{
						//System.out.print(true);
						CareerPathLevelDom levelDetails=careerPathTree.getDetailsForLevel(careerMap.get(key),functionalArea);
							treeFound.insertChild(careerMap.get(key),levelDetails.getSalary(),levelDetails.getYears(),levelDetails.getFunctionalArea(),levelDetails.getDescription(),currentParent);
							treeFound.printPath();
						}
						
					}
					
				}
			}
			
			
			
			
		}
		
		for(Entry<String, CareerPathLevelTree> tree : treeMap.entrySet())
		{
			//System.out.println("Tree");
			tree.getValue().printPath();
		}
		
		
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(treeMap);
			//System.out.println(json);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return json;
	}

	 

}