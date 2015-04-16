package caerusapp.command.common;

import java.util.ArrayList;
import java.util.List;


/**
 * 
 * @author TulsiC
 *
 *This class is used as a command class for careerPathLevel to create and access its properties
 */
public class CareerPathLevelCmd {
	
	private String levelName;
	private Double salary;
	private Double years;
	private String functionalArea;
	private String description;
	private String parent;
	private String insertionTime;
	private List<CareerPathLevelCmd> children;

	public CareerPathLevelCmd(String levelName,double salary){
		this.levelName=levelName;
		this.salary=salary;
		children=new ArrayList<CareerPathLevelCmd>();
	}
	
	public CareerPathLevelCmd(String levelName,List<String> children){
		this.levelName=levelName;
	}
	
	public CareerPathLevelCmd() {
	}
	
	
	
	
	public String getInsertionTime() {
		return insertionTime;
	}

	public void setInsertionTime(String insertionTime) {
		this.insertionTime = insertionTime;
	}
	
	
	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public String getFunctionalArea() {
		return functionalArea;
	}

	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

		

	public List<CareerPathLevelCmd> getChildren() {
		return children;
	}

	public void setChildren(List<CareerPathLevelCmd> children) {
		this.children = children;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getYears() {
		return years;
	}

	public void setYears(Double years) {
		this.years = years;
	}
	
	
}