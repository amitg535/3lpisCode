package caerusapp.service.employer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import caerusapp.command.employer.EmployerQueryBuilderCom;
import caerusapp.util.QueryBuilderCommonUtil;

/**
 * This class is used to validate Query Builder 
 * @author KarthikeyanK
 * 
 */
public class EmployerQueryBuilderValidator implements Validator {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Override
	public boolean supports(Class<?> clazz) {
		return EmployerQueryBuilderCom.class.equals(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {

		/*All the form values are received in this object*/
		EmployerQueryBuilderCom employerQueryBuilderValidator = (EmployerQueryBuilderCom) obj;

		/*Checking for Empty Fields*/
		if (employerQueryBuilderValidator.getFormulaName().trim() == null
				|| employerQueryBuilderValidator.getFormulaName().length() == 0
				|| employerQueryBuilderValidator.getFormulaName().trim()
						.isEmpty() == true) {

			errors.rejectValue("formulaName",
					"error.employer.querybuilder.formulaname.required","Please Enter a Formula Name");

		}

		if (employerQueryBuilderValidator.getFormula().trim() == null
				|| employerQueryBuilderValidator.getFormula().length() == 0
				|| employerQueryBuilderValidator.getFormula().trim().isEmpty() == true) {

			errors.rejectValue("formula",
					"error.employer.querybuilder.formula.required","Please Enter a Formula");

		} else if (employerQueryBuilderValidator.getFormula() != null
				|| employerQueryBuilderValidator.getFormula().length() > 0) {

			String[] expressionArray = QueryBuilderCommonUtil
					.getSplittedExpression(employerQueryBuilderValidator
							.getFormula());

			String mathematicalExpressionErrorMessage = QueryBuilderCommonUtil
					.mathematicalExpressionValidator(expressionArray);

			String floatingPointNumberErrorMessage = QueryBuilderCommonUtil
					.floatingPointNumberValidator(expressionArray);

			String variableExpressionErrorMessage = QueryBuilderCommonUtil
					.variableExpressionValidator(expressionArray);

			String numericExpressionErrorMessage = QueryBuilderCommonUtil
					.numberValidator(expressionArray);

			String parenthesisExpressionErrorMessage = QueryBuilderCommonUtil
					.parenthesisExpressionValidator(expressionArray);

			if (mathematicalExpressionErrorMessage != null) {

				errors.rejectValue("formula", " ",
						new Object[]{mathematicalExpressionErrorMessage},
						mathematicalExpressionErrorMessage);

			} else if (floatingPointNumberErrorMessage != null
					&& floatingPointNumberErrorMessage.length() > 0) {

				errors.rejectValue("formula", " ",
						new Object[]{floatingPointNumberErrorMessage},
						floatingPointNumberErrorMessage);

			} else if (variableExpressionErrorMessage != null
					&& variableExpressionErrorMessage.length() > 0) {

				errors.rejectValue("formula", " ",
						new Object[]{variableExpressionErrorMessage},
						variableExpressionErrorMessage);

			} else if (numericExpressionErrorMessage != null
					&& numericExpressionErrorMessage.length() > 0) {

				errors.rejectValue("formula", " ",
						new Object[]{numericExpressionErrorMessage},
						numericExpressionErrorMessage);

			} else if (parenthesisExpressionErrorMessage != null
					&& parenthesisExpressionErrorMessage.length() > 0) {

				errors.rejectValue("formula", " ",
						new Object[]{parenthesisExpressionErrorMessage},
						parenthesisExpressionErrorMessage);
			}

		}
	}
}
