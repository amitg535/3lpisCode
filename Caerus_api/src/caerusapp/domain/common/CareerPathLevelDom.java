package caerusapp.domain.common;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author TulsiC
 *
 *This class is used as a domain class for careerPathLevel to create and access its properties
 */

public class CareerPathLevelDom {
	
	private String levelName;
	private Double salary;
	private Double years;
	private String functionalArea;
	private String description;
	private String parent;
	private String insertionTime;
	private List<CareerPathLevelDom> children;
	
	public CareerPathLevelDom(String levelName,Double salary,Double years,String functionalArea,String description,String parent){
		this.levelName=levelName;
		this.salary=salary;
		this.years=years;
		this.functionalArea=functionalArea;
		this.description=description;
		this.parent=parent;
		children=new ArrayList<CareerPathLevelDom>();
		
	}
	
	public CareerPathLevelDom() {
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


	public List<CareerPathLevelDom> getChildren() {
		return children;
	}

	public void setChildren(List<CareerPathLevelDom> children) {
		this.children = children;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public Double getYears() {
		return years;
	}

	public void setYears(Double years) {
		this.years = years;
	}

	
}