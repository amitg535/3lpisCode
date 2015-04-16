package caerusapp.service.common;

import java.util.ArrayList;
import java.util.List;

import caerusapp.domain.common.CareerPathLevelDom;

public class CareerPathLevelTree{


	private CareerPathLevelDom root;

	/**
	 * This function is used to insert a child in the tree
	 * @param parent
	 * @param child
	 * @return
	 */
	public boolean insertChild(String levelName,Double salary,Double years,String functionalArea,String description,String parent) {
		List<CareerPathLevelDom> childlist= new ArrayList<CareerPathLevelDom>();
		CareerPathLevelDom parentNode = find(root,parent);
		CareerPathLevelDom childlevel = new CareerPathLevelDom(levelName,salary,years,functionalArea,description,parent);
		childlist=parentNode.getChildren();
		childlist.add(childlevel);
		return true;
	}

	public boolean remove(String node, boolean cascade) {
		return false;
	}

	/**
	 * This function is used to find a node in a tree
	 * @param rootnode
	 * @param levelName
	 * @return
	 */
	public CareerPathLevelDom find(CareerPathLevelDom rootnode , String levelName) {
	        
		if (rootnode == null)
	        return null;
	     if (rootnode.getLevelName().equals(levelName))
	            return rootnode;
	        List<CareerPathLevelDom> children = rootnode.getChildren(); 
	        CareerPathLevelDom res = null;
	        for(CareerPathLevelDom careerPathLevel:children){
	        	if(res==null)
	           res = find(careerPathLevel,levelName);
	        }
	        return res;
	}

	/**
	 * This function is used to print the path of tree
	 * @param currentNode
	 */
	public void printTree(CareerPathLevelDom currentNode) {
	        
	        if( currentNode == null)
		        return;
		   System.out.println(currentNode.getLevelName() + " ");
		   System.out.println(currentNode.getSalary() + " ");
		    List<CareerPathLevelDom> children = currentNode.getChildren(); 
		    for(CareerPathLevelDom careerPathLevel:children)
	        {
	           printTree(careerPathLevel);
	        }
		
	}
	public void printPath() {
		printTree(root);
	}
	

	public CareerPathLevelDom getRoot() {
		return root;
	}

	public void setRoot(CareerPathLevelDom root) {
		this.root = root;
	}
	
	public void insertRoot(String levelName,Double salary,Double years,String functionalArea,String description,String parent)
	{
	    root = new CareerPathLevelDom(levelName, salary, years, functionalArea, description, parent);
	}

	

	}