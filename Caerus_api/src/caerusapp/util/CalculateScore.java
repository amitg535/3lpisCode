/**
 * 
 */
package caerusapp.util;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import caerusapp.domain.student.StudentScoreDom;
import de.congrace.exp4j.Calculable;
import de.congrace.exp4j.ExpressionBuilder;
import de.congrace.exp4j.UnknownFunctionException;
import de.congrace.exp4j.UnparsableExpressionException;

/**
 * @author TrishnaR
 * This class is used to calculate student's scores
 */
public class CalculateScore 
{
	/**
	 * This method is used to calculate students's University GPA
	 * @param gpaScore
	 * @param gpaFrom
	 * @return Double (universityGPA)
	 */
	public static Double calculateUniversityGPA(String gpaScore,String gpaFrom)
	{
		Double gpaScoreDouble = Double.parseDouble(gpaScore);
		Double gpaFromDouble = Double.parseDouble(gpaFrom);
		
		Double universityGPA = (gpaScoreDouble/gpaFromDouble) * 10;
		
		return universityGPA;
	}
	
	/**
	 * This method is used to calculate students's High School GPA
	 * @param gpaScore
	 * @param gpaFrom
	 * @return Double (highSchoolGPA)
	 */
	public static Double calculateHighSchoolGPA(String gpaScore,String gpaFrom)
	{
		Double gpaScoreDouble = Double.parseDouble(gpaScore);
		Double gpaFromDouble = Double.parseDouble(gpaFrom);
		
		Double highSchoolGPA = (gpaScoreDouble/gpaFromDouble) * 10;
		
		return highSchoolGPA;
	}
	
	/**
	 * This method is used to calculate students's years of work experience
	 * @param workFromYear
	 * @param workToYear
	 * @param workFromMonth
	 * @param workToMonth
	 * @return Double (yearsOfExperience)
	 */
	public static Double calculateYearsOfExperience(String workFromYear,String workToYear,String workFromMonth, String workToMonth)
	{
		Integer workFromYearInteger = Integer.parseInt(workFromYear);
		Integer workToYearInteger = Integer.parseInt(workToYear);
		Integer workFromMonthInteger = Integer.parseInt(workFromMonth);
		Integer workToMonthInteger = Integer.parseInt(workToMonth);
	
		Double differenceInYears = (double) (workToYearInteger - workFromYearInteger);
		Double differenceInMonths = (double) (workToMonthInteger - workFromMonthInteger);
		
		Double yearsOfExperience = differenceInYears + differenceInMonths/12;
		
		return yearsOfExperience;
	}
	
	/**
	 * This method is used to calculate students's age
	 * @param dateOfBirth
	 * @return Integer (age)
	 */
	public static Integer calculateAge(String dateOfBirth)
	{
		Date currentDate  = new Date();
		Integer currentYear = currentDate.getYear();
		Date birthDate = null;
		try 
		{
			birthDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(dateOfBirth);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}
		Integer birthYear = birthDate.getYear();

		Integer age = currentYear- birthYear;
		return age;
	}
	
	/**
	 * This method is used to calculate students's IScore
	 * @param studentScoreDom
	 * @param formulaElementList
	 * @return Double (score)
	 */
	public static Double calculateIScore(StudentScoreDom studentScoreDom,List<String> formulaElementList)
	{
		String formula = "";
		Calculable calculable = null;
		Double score  = null;
		
		//Creating the formula expression to calculate student's score
		for (String formulaElements : formulaElementList)
		{
			formula = formula + formulaElements; 
		}
		
		try 
		{
			calculable = new ExpressionBuilder(formula).withVariableNames("UniversityGPA", "HighSchoolGPA", "Age",
					"UniversityRank", "CourseRank", "YearsofExperience", "GraduationYear").build();
			
			if(studentScoreDom.getUniversityGPA()!=null)
				calculable.setVariable("UniversityGPA", studentScoreDom.getUniversityGPA());
			else
				calculable.setVariable("UniversityGPA", 0);
			
			if(studentScoreDom.getHighSchoolGPA()!=null)
				calculable.setVariable("HighSchoolGPA", studentScoreDom.getHighSchoolGPA());
			else
				calculable.setVariable("HighSchoolGPA", 0);
			
			if(studentScoreDom.getGraduationYear()!=null)
				calculable.setVariable("GraduationYear", studentScoreDom.getGraduationYear());
			else
				calculable.setVariable("GraduationYear", 0);
			
			if(studentScoreDom.getAge()!=null && studentScoreDom.getAge()!=0)
			{
				calculable.setVariable("Age", studentScoreDom.getAge());
			}
			else
			{
				calculable.setVariable("Age", 1);
				calculable.setVariable("GraduationYear", 0);	
			}
			
			if(studentScoreDom.getUniversityRank()!=null)
				calculable.setVariable("UniversityRank", studentScoreDom.getUniversityRank());
			else
				calculable.setVariable("UniversityRank", 0);
			
			if(studentScoreDom.getCourseRank()!=null)
				calculable.setVariable("CourseRank", studentScoreDom.getCourseRank());
			else
				calculable.setVariable("CourseRank", 0);
			
			if(studentScoreDom.getYearsOfExperience()!=null)
				calculable.setVariable("YearsofExperience", studentScoreDom.getYearsOfExperience());
			else
				calculable.setVariable("YearsofExperience", 0);
			score = calculable.calculate();
			
			final DecimalFormat decimalFormatOfScore = new DecimalFormat("#0.00");
			//Rounding towards the nearest neighbour
			decimalFormatOfScore.setRoundingMode(RoundingMode.HALF_UP);
			String formattedScore = decimalFormatOfScore.format(score);
			score = Double.parseDouble(formattedScore);
		
		} catch (UnknownFunctionException e) {
			e.printStackTrace();
		} catch (UnparsableExpressionException e) {
			e.printStackTrace();
		} 
		
		return score;
	}

}