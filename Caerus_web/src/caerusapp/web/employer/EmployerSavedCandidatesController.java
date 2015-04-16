/**
 * 
 */
package caerusapp.web.employer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to get the list of saved candidates by an employer and display it
 *
 */

@Controller
public class EmployerSavedCandidatesController 
{
	//Auto-wiring service Components
	@Autowired
	private IEmployerManager employerManager;
	@Autowired
	private IStudentManager studentManager;

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * This method is used to get the list of saved candidates by an employer and display it
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SAVED_CANDIDATES)
	public ModelAndView getSavedCandidates(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		//The modelAndView object contains the model(data) and the view(employer_saved_listing)
		ModelAndView modelAndView = new ModelAndView("employer/employer_saved_listing");
		
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String loggedInCorporateEmail = auth.getName();
		String studentEmailId = "";

		List<StudentDom> savedCandidates = employerManager.getSavedCandidates(loggedInCorporateEmail);
		List<StudentDom> savedCandidatesSorted = new ArrayList<StudentDom>();
		
		for (StudentDom searchCandidatedetails : savedCandidates) 
		{
			studentEmailId = searchCandidatedetails.getEmail();
			
			//Getting candidate details
			StudentDom studentDetails = studentManager.getDetailsByEmailId(studentEmailId);
			
			List<PortfolioDetailsDom> universityDetailsList = CandidateCommonFeature.getUniversityDetails(studentDetails.getUniversityMap());
			if(universityDetailsList.size() != 0)
			{
				if(universityDetailsList != null && universityDetailsList.size() > 1)
				{
					studentDetails.setUniversityDetails(universityDetailsList.get(universityDetailsList.size() -1));
				}
				else
				{
					studentDetails.setUniversityDetails(universityDetailsList.get(0));
				}
			}
			savedCandidatesSorted.add(studentDetails);
		}
		
		
		int savedCandidateCount = 0;
		if((savedCandidates != null))
		{
			savedCandidateCount = savedCandidates.size();
			Collections.sort(savedCandidatesSorted,new Comparator<StudentDom>()
			{
				@Override
				public int compare(StudentDom o1, StudentDom o2) 
				{
					int returnValue = 0;
					
					if(o2.getiScore() != null && o1.getiScore() != null)
					returnValue = o2.getiScore().compareTo(o1.getiScore());
					
					return returnValue;
				}
				
			});
		}
		modelAndView.addObject("studentList",savedCandidatesSorted);
		modelAndView.addObject("count",savedCandidateCount);
		
		
		logger.info(CaerusLoggerConstants.SAVED_CANDIDATES);
		return modelAndView;
	
	}
	
	 

}