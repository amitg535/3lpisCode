package caerusapp.web.employer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import caerusapp.domain.employer.EmployerDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;

/**
 * @author RavishaG
 */
@Controller
public class EmployerImportProfileFromLinkedInController {

	// Auto-wiring service component
	@Autowired
	IEmployerManager employerManager;
	
	/**
	 * This method is used to import logged in candidate's details from his/her LinkedIn profile
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 */
	@RequestMapping(method = RequestMethod.POST, value = CaerusAnnotationURLConstants.EMPLOYER_IMPORT_PROFILE_FROM_LINKEDIN)
	public void importData(@RequestBody EmployerDom employerDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		//Using the existing session
		HttpSession session = httpServletRequest.getSession();
		String corporateName = (String) session.getAttribute("compName");
		
		employerDom.setCompanyName(corporateName);
		
		if(null != employerDom.getCompanyType())
			employerDom.setCompanyType(employerDom.getCompanyType().trim());
		else
			employerDom.setCompanyType("");
		
		// Set the employee strength as per Imploy.me strength intervals
		String strength = "";
		if(null != employerDom.getNoOfEmployees())
		{
			if(employerDom.getNoOfEmployees().contains("-"))
			{
				String[] employeeStrengthArray = employerDom.getNoOfEmployees().split("-");
				strength = employeeStrengthArray[1];
			}
		
			else
				strength = employerDom.getNoOfEmployees().substring(0,employerDom.getNoOfEmployees().lastIndexOf("+"));
		
		if(Integer.parseInt(strength) <= 50)
			employerDom.setNoOfEmployees("0-50");
		if(Integer.parseInt(strength) > 50 && Integer.parseInt(strength) <= 200)
			employerDom.setNoOfEmployees("51-200");
		if(Integer.parseInt(strength) > 200 && Integer.parseInt(strength) <= 500)
			employerDom.setNoOfEmployees("201-500");
		if(Integer.parseInt(strength) > 500 && Integer.parseInt(strength) <= 1000)
			employerDom.setNoOfEmployees("501-1000");
		if(Integer.parseInt(strength) > 1000)
			employerDom.setNoOfEmployees("1000 & more");
		}
		
		//Update profile in the database
		employerManager.updateEmployerDetails(employerDom);
	}

}
