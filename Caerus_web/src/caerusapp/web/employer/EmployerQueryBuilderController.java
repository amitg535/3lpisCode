/**
 * 
 */
package caerusapp.web.employer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.employer.EmployerQueryBuilderCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.service.employer.EmployerQueryBuilderValidator;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.employer.IEmployerQueryBuilderManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.QueryBuilderCommonUtil;

/**
 * This class is used to add or delete a formula for query builder
 * @author KarthikeyanK
 * 
 */
@Controller
public class EmployerQueryBuilderController {

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	IEmployerManager employerManager;
	
	@Autowired
	IEmployerQueryBuilderManager employerQueryBuilderManager;
	
	@Autowired
	IEmployerJobPostManager employerJobPostManager;

	@Autowired
	public EmployerQueryBuilderController(EmployerQueryBuilderValidator queryBuilderValidator){
		this.queryBuilderValidator = queryBuilderValidator;
	}
	
	// Creating Validator class object
	EmployerQueryBuilderValidator queryBuilderValidator;
	
	/**
	 * This class is used to submit the values for adding or to delete a formula for query builder
	 * 
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_QUERYBUILDER,method=RequestMethod.POST)
	public String addFormula(@RequestParam(required=false, value="action") String action,@ModelAttribute("queryBuilderCom") EmployerQueryBuilderCom employerQueryBuilderCom,
			BindingResult bindingResult,HttpServletRequest request,HttpServletResponse response,Model model) throws ServletException {
		String loggedInUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();

		queryBuilderValidator.validate(employerQueryBuilderCom, bindingResult);
		
		if(bindingResult.hasErrors()) {
			List<EmployerQueryBuilderDom> formulaeList = employerQueryBuilderManager.getEmployerFormulae(loggedInUserEmail);
			model.addAttribute("formulaeList", formulaeList);
			
			return CaerusJSPMapper.EMPLOYER_QUERY_BUILDER;
		}
		logger.info(CaerusLoggerConstants.QUERY_BUILDER);
		
		// Creating a domain object 
		EmployerQueryBuilderDom employerQueryBuilderDom = new EmployerQueryBuilderDom();

		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();

		employerQueryBuilderCom.setEmailId(emailId);

		String companyName = "";
		if(null != request.getSession().getAttribute("compName"))
			 companyName = request.getSession().getAttribute("compName").toString();

		employerQueryBuilderCom.setFirmId(companyName);

		BeanUtils.copyProperties(employerQueryBuilderCom, employerQueryBuilderDom);
		
		if (employerQueryBuilderCom != null && action != null) {
			if (action.equals("save")) {
					employerQueryBuilderDom.setFormulaList(new ArrayList<String>(Arrays.asList(QueryBuilderCommonUtil.getSplittedExpression(employerQueryBuilderDom.getFormula()))));
					employerQueryBuilderDom.getFormulaList().removeAll(Collections.singleton(null));
					
					employerQueryBuilderManager.addFormula(employerQueryBuilderDom);
					employerQueryBuilderCom.setSuccessMessage("Added Formula Successfully.");
			} 
			if (action.equals("delete")) {
					employerQueryBuilderManager.deleteFormula(employerQueryBuilderDom);
					employerQueryBuilderCom.setSuccessMessage("Deleted Formula Successfully.");
			}
		}
		//Getting the list of all formulae
		List<EmployerQueryBuilderDom> formulaeList = employerQueryBuilderManager.getEmployerFormulae(emailId);

		//Getting List of Jobs
				List<JobDetailsDom> employerJobsList = employerJobPostManager.getAllJobsPostedByEmployer(emailId);
		model.addAttribute("formulaeList", formulaeList);
		employerQueryBuilderCom.setFormula("");
		employerQueryBuilderCom.setFormulaName("");
		model.addAttribute("employerJobsList",employerJobsList);
		model.addAttribute("buildQuery", employerQueryBuilderCom);
		model.addAttribute("successMessage",employerQueryBuilderCom.getSuccessMessage());
		
		return CaerusJSPMapper.EMPLOYER_QUERY_BUILDER;
	}

	/**
	 * This method is used to load QueryBuilderPage
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_QUERYBUILDER)
	String loadQueryBuilderPage(HttpServletRequest request,Model model) throws Exception {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName();
		//Getting the list of all formulae
		List<EmployerQueryBuilderDom> formulaeList = employerQueryBuilderManager.getEmployerFormulae(emailId);

		//Getting List of Jobs
		List<JobDetailsDom> employerJobsList = employerJobPostManager.getAllJobsPostedByEmployer(emailId);
		model.addAttribute("queryBuilderCom",new EmployerQueryBuilderCom());
		model.addAttribute("employerJobsList",employerJobsList);
		model.addAttribute("formulaeList", formulaeList);
		return  CaerusJSPMapper.EMPLOYER_QUERY_BUILDER;
	}
	
	/**
	 * This method is used to delete formula
	 * @param employerQueryBuilderCom
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_QUERYBUILDER_DELETE_FORMULA)
	String deleteFormula(@ModelAttribute("queryBuilderCom")EmployerQueryBuilderCom employerQueryBuilderCom){
		EmployerQueryBuilderDom employerQueryBuilderDom = new EmployerQueryBuilderDom();
		BeanUtils.copyProperties(employerQueryBuilderCom, employerQueryBuilderDom);
		
		employerQueryBuilderDom.setEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
		employerQueryBuilderManager.deleteFormula(employerQueryBuilderDom);
		
		logger.info("Deleted Formula Successfully");
		return "redirect:"+CaerusAnnotationURLConstants.EMPLOYER_QUERYBUILDER;
	}
	
	/**
	 * This method is used to edit existing formula
	 * @param formulaName
	 * @param model
	 * @return
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_QUERYBUILDER_EDIT_FORMULA)
	String editFormula(@RequestParam("formulaName") String formulaName,Model model){
		
		String loggedInUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
		List<EmployerQueryBuilderDom> formulaeList = employerQueryBuilderManager.getEmployerFormulae(loggedInUserEmail);

		EmployerQueryBuilderDom queryBuilderDom = employerQueryBuilderManager.getFormulaDetails(loggedInUserEmail,formulaName);
		queryBuilderDom.setDeleteAndEditButtonStatus("enabled");
		
		EmployerQueryBuilderCom queryBuilderCom = new EmployerQueryBuilderCom();
		BeanUtils.copyProperties(queryBuilderDom, queryBuilderCom);
		
		model.addAttribute("queryBuilderCom",queryBuilderCom);
		model.addAttribute("formulaeList", formulaeList);
		return "employer/employer_query_builder";
	}
}