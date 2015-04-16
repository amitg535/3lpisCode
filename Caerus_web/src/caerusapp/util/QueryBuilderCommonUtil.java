/**
 * 
 */
package caerusapp.util;


import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * This class is used to 
 * @author KARTHIKEYANK
 * 
 */
public class QueryBuilderCommonUtil {

	// Defining string variables that can be used in different classes
	static final String UNIVERSITY_RANK = "University Rank";
	static final String COURSE_RANK = "Course Rank";
	static final String GRADUATION_YEAR = "Graduation Year";
	static final String YEARS_OF_EXPERIENCE = "Years of Experience";
	static final String HIGH_SCHOOL_GPA = "High School GPA";
	static final String AGE = "Age";
	static final String UNIVERSITY_GPA = "University GPA";

	static final int UNIVERSITY_RANK_LENGTH = UNIVERSITY_RANK.length();
	static final int COURSE_RANK_LENGTH = COURSE_RANK.length();
	static final int GRADUATION_YEAR_LENGTH = GRADUATION_YEAR.length();
	static final int YEARS_OF_EXPERIENCE_LENGTH = YEARS_OF_EXPERIENCE.length();
	static final int HIGH_SCHOOL_GPA_LENGTH = HIGH_SCHOOL_GPA.length();
	static final int AGE_LENGTH = AGE.length();
	static final int UNIVERSITY_GPA_LENGTH = UNIVERSITY_GPA.length();

	static final String DOT = ".";
	static final String MINUS = "-";
	static final String PLUS = "+";
	static final String ASTERISK = "*";
	static final String BACK_SLASH = "/";
	static final String OPEN_PARENTHESES = "(";
	static final String CLOSE_PARENTHESES = ")";

	static final String ZERO = "0";
	static final String ONE = "1";
	static final String TWO = "2";
	static final String THREE = "3";
	static final String FOUR = "4";
	static final String FIVE = "5";
	static final String SIX = "6";
	static final String SEVEN = "7";
	static final String EIGHT = "8";
	static final String NINE = "9";

	static final char DOT_SYMBOL = '.';
	static final char MINUS_SYMBOL = '-';
	static final char PLUSE_SYMBOL = '+';
	static final char ASTERISK_SYMBOL = '*';
	static final char BACK_SLASH_SYMBOL = '/';
	static final char OPEN_PARENTHESES_SYMBOL = '(';
	static final char CLOSE_PARENTHESES_SYMBOL = ')';

	static final String DOUBLE_QUOTE = " \" ";
	static final String NUMBER_ERROR_MESSAGE = "Use \" * \" for multiplication ";
	static final String NUMBER_INVALID_ERROR_MESSAGE = " Invalid Open Paranthesis ";
	static final String DIVIDE_BY_ZERO = " Divide By Zero is not allowed ";
	static final String MATHEMATICAL_EXPRESSION_ERROR = " Syntax Error in Mathematical Expression ";
	// static final String NO_DATA_FOUND_AFTER_DOT_OPERATOR =
	// "No Data Found after Dot";
	static final String NO_DATA_FOUND_AFTER_DOT_OPERATOR = "Invalid Dot Oprator";
	static final String MORE_THAN_ONE_DOT_OPERATOR_EXIST = "More than one dot operator exists";
	static final String SHOULD_NOT_ALLOWED_AFTER_THE_VARIABLE = " is not allowed after the Expression ";
	static final String SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE = " is not allowed before the Expression ";
	static final String SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE = " is not allowed at the end of the Expression ";
	static final String INVALID_VARIABLE_EXPRESSION = "Invalid Variable Expression  ";
	static final String OPEN_PARENTHESIS_NOT_CLOSED_PROPERLY = "Open Parenthesis is not closed properly";
	static final String CLOSED_PARENTHESIS_MORE_THAN_OPEN_PARENTHESIS = "Closed parenthesis is more than open parenthesis";
	static final String INVALID_PARENTHESIS = "Invalid brackets";
	static final String EMPTY_PARAENTHESIS_NOT_ALLOWED = "Empty Paranthesis not allowed.";

	/**
	 * This method is used to find alphabets, digits and operators in an input string and group them together
	 * @param strExpression
	 * @return st
	 */
	public static String[] getSplittedExpression(String strExpression) {

		String[] st = new String[strExpression.length()];

		Pattern p = Pattern.compile("[A-Za-z ]+|[0-9.]+|[(]+|[)]+|[+/*-]+");

		Matcher m = p.matcher(strExpression);

		int i = 0;

		// Iterating through the string 
		while (i < strExpression.length()) {

			// check if matcher can find the defined pattern, then group them together
			if (m.find()) {

				st[i] = m.group();

			}

			i++;
		}

		return st;

	}

	/**
	 * This method is used to find the size of an array
	 * @param queryArray
	 * @return numericCount
	 */
	public static int getArrayCount(String[] queryArray) {

		int numericCount = 0;

		// Iterating through the array
		for (int j = 0; j < queryArray.length; j++) {

			if (queryArray[j] != null) {

				numericCount++;

			}

		}

		numericCount = numericCount - 1;

		return numericCount;

	}

	/**
	 * This method is used to check the format of a mathematical expression
	 * @param queryBuilderExpression
	 * @return mathematicalExpressionErrorMessage
	 */

	public static String mathematicalExpressionValidator(
			String[] queryBuilderExpression) {

		String mathematicalExpressionErrorMessage = null;

		int mathematicalExpressionCount = 0;

		// Iterating through the input string array to find its size
		for (int j = 0; j < queryBuilderExpression.length; j++) {

			if (queryBuilderExpression[j] != null) {

				mathematicalExpressionCount++;

			}

		}

		mathematicalExpressionCount = mathematicalExpressionCount - 1;

		// Iterating through the input string array
		for (int j = 0; j < queryBuilderExpression.length; j++) {

			if (queryBuilderExpression[j] != null) {

				if (j == 0) {

					// check if the expressions contains a '+' operator, then display an error message
					if (queryBuilderExpression[j].contains(PLUS)) {

						mathematicalExpressionErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;

					}
					
					// check if the expressions contains a '-' operator, then display an error message
					if (queryBuilderExpression[j].contains(MINUS)) {

						mathematicalExpressionErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;

					}
					
					// check if the expressions contains a '*' operator, then display an error message
					if (queryBuilderExpression[j].contains(ASTERISK)) {

						mathematicalExpressionErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;

					}
					
					// check if the expressions contains a '/' operator, then display an error message
					if (queryBuilderExpression[j].contains(BACK_SLASH)) {

						mathematicalExpressionErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;

					}

				}

				// check if the expressions contains any of the '+,-,*,/,(,)' operators, then display an error message
				if (queryBuilderExpression[j].contains(PLUS)) {

					int count = 0;

					for (int i = 0; i < queryBuilderExpression[j].length(); i++) {

						if (queryBuilderExpression[j].charAt(i) == PLUSE_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == MINUS_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == BACK_SLASH_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == ASTERISK_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == OPEN_PARENTHESES_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == CLOSE_PARENTHESES_SYMBOL) {

							count++;

							if (count > 1) {

								mathematicalExpressionErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MATHEMATICAL_EXPRESSION_ERROR;

							}
						}

					}

				} else if (queryBuilderExpression[j].contains(MINUS)) {

					int count = 0;

					for (int i = 0; i < queryBuilderExpression[j].length(); i++) {

						if (queryBuilderExpression[j].charAt(i) == PLUSE_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == MINUS_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == BACK_SLASH_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == ASTERISK_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == OPEN_PARENTHESES_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == CLOSE_PARENTHESES_SYMBOL) {

							count++;

							if (count > 1) {

								mathematicalExpressionErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MATHEMATICAL_EXPRESSION_ERROR;

							}
						}

					}

				} else if (queryBuilderExpression[j].contains(ASTERISK)) {

					int count = 0;

					for (int i = 0; i < queryBuilderExpression[j].length(); i++) {

						if (queryBuilderExpression[j].charAt(i) == PLUSE_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == MINUS_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == BACK_SLASH_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == ASTERISK_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == OPEN_PARENTHESES_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == CLOSE_PARENTHESES_SYMBOL) {

							count++;

							if (count > 1) {

								mathematicalExpressionErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MATHEMATICAL_EXPRESSION_ERROR;

							}
						}

					}

				} else if (queryBuilderExpression[j].contains(BACK_SLASH)) {

					int count = 0;

					for (int i = 0; i < queryBuilderExpression[j].length(); i++) {

						if (queryBuilderExpression[j].charAt(i) == PLUSE_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == MINUS_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == BACK_SLASH_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == ASTERISK_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == OPEN_PARENTHESES_SYMBOL
								|| queryBuilderExpression[j].charAt(i) == CLOSE_PARENTHESES_SYMBOL) {

							count++;

							if (count > 1) {

								mathematicalExpressionErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MATHEMATICAL_EXPRESSION_ERROR;

							}
						}

					}

				}

			}

		}

		return mathematicalExpressionErrorMessage;

	}

	/**
	 * This method is used to check the format of numeric expressions 
	 * @param queryBuilderExpression
	 * @return numberErrorMessage
	 */
	public static String numberValidator(String[] queryBuilderExpression) {

		String numberErrorMessage = null;

		// Find the size of input array
		int numericCount = getArrayCount(queryBuilderExpression);

		for (int j = 0; j <= numericCount; j++) {

			if (queryBuilderExpression[j] != null) {

				if (j == 0) {

					/* check if the expression contains '1' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(ONE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					/* check if the expression contains '2' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(TWO)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					/* check if the expression contains '3' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(THREE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					/* check if the expression contains '4' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(FOUR)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '5' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(FIVE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = "Use \" * \" for multiplication "
									+ queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1];
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '6' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(SIX)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = "Use \" * \" for multiplication "
									+ queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1];
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '7' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(SEVEN)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '8' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(EIGHT)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '9' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(NINE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					/* check if the expression contains '0' and if it does, check if the next variable in the expression contains 
					 '(,), university rank, course rank, graduation year, years of experience, high school gpa, age, university gpa, 
					  then display an error message */
					if (queryBuilderExpression[j].contains(ZERO)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					/*	if (queryBuilderExpression[j + 1]
								.contentEquals(BACK_SLASH)) {

							numberErrorMessage = DIVIDE_BY_ZERO + DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}*/

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					// check if the expression contains the '+' operator, and next variable in the expression contains '(' or ')', then display an error message
			/*		if (queryBuilderExpression[j].equals(PLUS)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}
*/
					// check if the expression contains the '-' operator, and next variable in the expression contains '(' or ')', then display an error message
			/*		if (queryBuilderExpression[j].equals(MINUS)) {
						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}*/

					// check if the expression contains the '/.' operator, and next variable in the expression contains '(' or ')', then display an error message
			/*		if (queryBuilderExpression[j].equals(BACK_SLASH)) {
						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}
*/
					// check if the expression contains the '+* operator, and next variable in the expression contains '(' or ')', then display an error message
				/*	if (queryBuilderExpression[j].equals(ASTERISK)) {
						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}
					*/
					// check if the expression contains the '.' operator, and next variable in the expression contains '(' or ')', then display an error message
					if (queryBuilderExpression[j].equals(DOT)) {
						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

				}

				// Checking for the same conditions for the rest of the input string length
				if (j > 0 && j < numericCount) {

					if (queryBuilderExpression[j].contentEquals(ONE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(TWO)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(THREE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(FOUR)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(FIVE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(SIX)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(SEVEN)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(EIGHT)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(NINE)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contentEquals(ZERO)) {

						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(BACK_SLASH)) {

							numberErrorMessage = DIVIDE_BY_ZERO + DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(BACK_SLASH)) {

							numberErrorMessage = DIVIDE_BY_ZERO + DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ queryBuilderExpression[j - 1]
									+ DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j + 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].equals(PLUS)) {

					/*	if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else*/ if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].equals(MINUS)) {
					/*	if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else */if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].equals(BACK_SLASH)) {
					/*	if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else*/ if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].equals(ASTERISK)) {
					/*	if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else*/ if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].equals(DOT)) {
						if (queryBuilderExpression[j + 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						} else if (queryBuilderExpression[j + 1]
								.contentEquals(CLOSE_PARENTHESES)) {

							numberErrorMessage = INVALID_VARIABLE_EXPRESSION
									+ DOUBLE_QUOTE + queryBuilderExpression[j]
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE;
						}
					}

				}

				// Checking for the same conditions for the last index of the input string 
				if (j == numericCount) {

					if (queryBuilderExpression[j].contains(ONE)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(TWO)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(THREE)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(FOUR)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(FIVE)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contains(SIX)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(SEVEN)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}
					}

					if (queryBuilderExpression[j].contains(EIGHT)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(NINE)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

					if (queryBuilderExpression[j].contains(ZERO)) {

						if (queryBuilderExpression[j - 1]
								.contentEquals(OPEN_PARENTHESES)) {

							numberErrorMessage = NUMBER_INVALID_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(COURSE_RANK)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(GRADUATION_YEAR)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(YEARS_OF_EXPERIENCE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(HIGH_SCHOOL_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1].contentEquals(AGE)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(BACK_SLASH)) {

							numberErrorMessage = DIVIDE_BY_ZERO + DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

						if (queryBuilderExpression[j - 1]
								.contentEquals(UNIVERSITY_GPA)) {

							numberErrorMessage = NUMBER_ERROR_MESSAGE
									+ DOUBLE_QUOTE
									+ queryBuilderExpression[j - 1]
									+ queryBuilderExpression[j] + DOUBLE_QUOTE;
						}

					}

				}

			}
		}

		return numberErrorMessage;

	}

	/**
	 * This method is used to check the format of floating point variables
	 * @param queryBuilderExpression
	 * @return floatingPointErrorMessage
	 */
	public static String floatingPointNumberValidator(
			String[] queryBuilderExpression) {

		String floatingPointErrorMessage = null;

		int count1 = 0;

		for (int j = 0; j < queryBuilderExpression.length; j++) {

			
			if (queryBuilderExpression[j] != null) {

				// Check if a floating point variable is input correctly
				if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
						.length() - 1) {

					floatingPointErrorMessage = DOUBLE_QUOTE
							+ queryBuilderExpression[j] + DOUBLE_QUOTE
							+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

				}

				for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

					// Check for more than 1 '.' operator
					if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
						count1++;
						if (count1 > 1) {

							floatingPointErrorMessage = DOUBLE_QUOTE
									+ queryBuilderExpression[j] + DOUBLE_QUOTE
									+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

						}
					}

				}

				// check if the expression contains '1' and if it does, check for correct input and number of '.' operators
				if (queryBuilderExpression[j].contains(ONE)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '2' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(TWO)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '3' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(THREE)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '4' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(FOUR)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '5' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(FIVE)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {

							if (count > 0) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;
							}

							count++;
						}

					}

				} 
				// check if the expression contains '6' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(SIX)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '7' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(SEVEN)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;
					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '8' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(EIGHT)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '9' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(NINE)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

					int count = 0;

					for (int m1 = 0; m1 < queryBuilderExpression[j].length(); m1++) {

						if (queryBuilderExpression[j].charAt(m1) == DOT_SYMBOL) {
							count++;
							if (count > 1) {

								floatingPointErrorMessage = DOUBLE_QUOTE
										+ queryBuilderExpression[j]
										+ DOUBLE_QUOTE
										+ MORE_THAN_ONE_DOT_OPERATOR_EXIST;

							}
						}

					}

				} 
				// check if the expression contains '0' and if it does, check for correct input and number of '.' operators
				else if (queryBuilderExpression[j].contains(ZERO)) {

					if (queryBuilderExpression[j].lastIndexOf(DOT) == queryBuilderExpression[j]
							.length() - 1) {

						floatingPointErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j] + DOUBLE_QUOTE
								+ NO_DATA_FOUND_AFTER_DOT_OPERATOR;

					}

				}

			}

		}

		return floatingPointErrorMessage;

	}

	/**
	 * This method is used to check the format of a variable expression
	 * @param queryBuilderExpression
	 * @return variableExpressionErrorMessage
	 */
	public static String variableExpressionValidator(
			String[] queryBuilderExpression) {
		
		String variableExpressionErrorMessage = null;

		int count = 0;

		// Iterating through the input array to find its size
		for (int j = 0; j < queryBuilderExpression.length; j++) {

			if (queryBuilderExpression[j] != null) {

				count++;

			}

		}

		count = count - 1;

		for (int j = 0; j <= count; j++) {

			if (queryBuilderExpression[j] != null) {

				// check for null input
				if (count == 0) {

					variableExpressionErrorMessage = INVALID_VARIABLE_EXPRESSION
							+ DOUBLE_QUOTE
							+ queryBuilderExpression[j]
							+ DOUBLE_QUOTE;

				} else if (count > 0) {

					if (j == 0) {

						Pattern p = Pattern
								.compile("(University Rank|Course Rank|Graduation Year|Years of Experience|High School GPA|Age|University GPA|[+]|[-]|[*]|[/]+|[(]+|[)]+|[0-9.]+)");
						Matcher m = p.matcher(queryBuilderExpression[j]);

						int i = 0;

						while (i < queryBuilderExpression[j].length()) {

							if (queryBuilderExpression[j] != null) {
								// check if input matches defined pattern
								if (!m.matches()) {

									variableExpressionErrorMessage = INVALID_VARIABLE_EXPRESSION
											+ DOUBLE_QUOTE
											+ queryBuilderExpression[j]
											+ DOUBLE_QUOTE;
								}

							}

							i++;
						}

						// check if the expressions contains any of the '.,+,-,*,/' operators, then display an error message
						if (queryBuilderExpression[j].equals(DOT)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE + DOT
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE;

						} else if (queryBuilderExpression[j].equals(PLUS)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ PLUS + queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE;

						} else if (queryBuilderExpression[j].equals(MINUS)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ MINUS + queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE;

						} else if (queryBuilderExpression[j].equals(ASTERISK)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ ASTERISK + queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE;

						} else if (queryBuilderExpression[j].equals(BACK_SLASH)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ BACK_SLASH
									+ queryBuilderExpression[j + 1]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_BEFORE_THE_VARIABLE;

						}

					}

					if (j > 0 && count > j) {

						Pattern p = Pattern
								.compile("(University Rank|Course Rank|Graduation Year|Years of Experience|High School GPA|Age|University GPA|[+]|[-]|[*]|[/]+|[(]+|[)]+|[0-9.]+)");
						Matcher m = p.matcher(queryBuilderExpression[j]);

						int i = 0;

						while (i < queryBuilderExpression[j].length()) {

							if (queryBuilderExpression[j] != null) {

								// check if input matches defined pattern
								if (!m.matches()) {

									variableExpressionErrorMessage = INVALID_VARIABLE_EXPRESSION
											+ DOUBLE_QUOTE
											+ queryBuilderExpression[j]
											+ DOUBLE_QUOTE;

								}

							}

							i++;
						}

					}

					if (count == j) {

						Pattern p = Pattern
								.compile("(University Rank|Course Rank|Graduation Year|Years of Experience|High School GPA|Age|University GPA|[+]|[-]|[*]|[/]+|[(]+|[)]+|[0-9.]+)");
						Matcher m = p.matcher(queryBuilderExpression[j]);

						int i = 0;

						while (i < queryBuilderExpression[j].length()) {

							if (queryBuilderExpression[j] != null) {

								// check if input matches defined pattern
								if (!m.matches()) {

									variableExpressionErrorMessage = INVALID_VARIABLE_EXPRESSION
											+ DOUBLE_QUOTE
											+ queryBuilderExpression[j]
											+ DOUBLE_QUOTE;
								}

							}

							i++;
						}

						// check if the expressions contains '+' operator, then display an error message
						if (queryBuilderExpression[j].contentEquals(PLUS)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;

						}

						// check if the expressions contains '-' operator, then display an error message
						if (queryBuilderExpression[j].contentEquals(MINUS)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;
						}

						// check if the expressions contains '/' operator, then display an error message
						if (queryBuilderExpression[j].contentEquals(BACK_SLASH)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;
						}

						// check if the expressions contains '*' operator, then display an error message
						if (queryBuilderExpression[j].contentEquals(ASTERISK)) {

							variableExpressionErrorMessage = DOUBLE_QUOTE
									+ queryBuilderExpression[j]
									+ DOUBLE_QUOTE
									+ SHOULD_NOT_ALLOWED_AT_THE_END_OF_THE_VARIABLE;
						}

					}

				}

			}

		}

		return variableExpressionErrorMessage;
	}

	/**
	 * This method is used to check for correct parenthesis in an expression
	 * @param queryBuilderExpression
	 * @return parenthesisExpressionErrorMessage
	 */
	public static String parenthesisExpressionValidator(
			String[] queryBuilderExpression) {

		String parenthesisExpressionErrorMessage = null;

		int openParenthesisCount = 0;

		int closedParenthesisCount = 0;

		int openParenthesisIndex = 0;
		int closedParenthesisIndex = 0;

		char[] closeParenthesisIndex = new char[queryBuilderExpression.length];

		// Iterating through the input array
		for (int j = 0; j < queryBuilderExpression.length; j++) {
			
			// Check if query contains + or - or * or / after ( 
			if (queryBuilderExpression[j] != null) {
				
				if (queryBuilderExpression[j]
						.contentEquals(OPEN_PARENTHESES)) {
					
					if(queryBuilderExpression[j + 1].contentEquals(PLUS) || queryBuilderExpression[j + 1]

									.contentEquals(MINUS) || queryBuilderExpression[j + 1]
											.contentEquals(ASTERISK) || queryBuilderExpression[j + 1]
													.contentEquals(BACK_SLASH)) {
			
						parenthesisExpressionErrorMessage = DOUBLE_QUOTE
								+ queryBuilderExpression[j]
								+ queryBuilderExpression[j+1]
								+ DOUBLE_QUOTE
								+ INVALID_PARENTHESIS;
					}
					
				}
				
				// Finding count of opening parenthesis '('
				for (int k = 0; k < queryBuilderExpression[j].length(); k++) {
					
					if (queryBuilderExpression[j].charAt(k) == OPEN_PARENTHESES_SYMBOL) {
				
						closeParenthesisIndex[j] = queryBuilderExpression[j]
								.charAt(k);
						openParenthesisIndex = j;
						openParenthesisCount++;

					}

				}

				// Finding count of closing parenthesis ')'
				for (int l = 0; l < queryBuilderExpression[j].length(); l++) {

					if (queryBuilderExpression[j].charAt(l) == CLOSE_PARENTHESES_SYMBOL) {

						closeParenthesisIndex[j] = queryBuilderExpression[j]
								.charAt(l);
						closedParenthesisIndex = j;
						closedParenthesisCount++;

					}

				}

			}

		}

		// check if open Parenthesis Count is not equal to closed Parenthesis Count, then display an error message
		if (openParenthesisCount != closedParenthesisCount) {

			if (openParenthesisCount > closedParenthesisCount) {

				parenthesisExpressionErrorMessage = OPEN_PARENTHESIS_NOT_CLOSED_PROPERLY;

			} else if (openParenthesisCount < closedParenthesisCount) {

				parenthesisExpressionErrorMessage = CLOSED_PARENTHESIS_MORE_THAN_OPEN_PARENTHESIS;

			}

		} else if (openParenthesisCount == closedParenthesisCount) {

			// check if index of open Parenthesis Count is more than index of closed Parenthesis Count, then display an error message
			if (closedParenthesisIndex < openParenthesisIndex) {

				parenthesisExpressionErrorMessage = INVALID_PARENTHESIS;

			}

			// check if index of closed Parenthesis Count is one more than index of open Parenthesis Count, then display an error message
			if (closedParenthesisIndex == openParenthesisIndex + 1) {

				parenthesisExpressionErrorMessage = EMPTY_PARAENTHESIS_NOT_ALLOWED;

			}

		}

		return parenthesisExpressionErrorMessage;

	}

}
