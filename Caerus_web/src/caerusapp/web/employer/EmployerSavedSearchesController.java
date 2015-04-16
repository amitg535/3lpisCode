package caerusapp.web.employer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;
/**
 * This class is used to display the searches saved by an employer
 * @author BalajiI
 *
 */
@Controller
public class EmployerSavedSearchesController
{
		/** Logger for this class and subclasses */
		protected final Log logger = LogFactory.getLog(getClass());
		
		//Auto-wiring service Components
		@Autowired
		private IEmployerManager employerManager;
		
		/**
		 * This method is used to display the searches saved by an employer
		 *
		 */
		@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_SAVED_SEARCHES)
		public ModelAndView getSavedSearchesListing(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
		{
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailId = auth.getName(); 
			int searchListCount=0;
			
			//The modelAndView object contains the model(data) and the view(employer_saved_searches)
			ModelAndView modelAndView = new ModelAndView("employer/employer_saved_searches");
			
			List<JobDetailsDom> searchList=new ArrayList<JobDetailsDom>();
			
			//Retrieving the list of saved searches
			searchList = employerManager.getSavedSearches(emailId);
			
			
			if(searchList != null)
			{
				/** Sorting Records Based on Date to display Recent Records on Top */
				Collections.sort(searchList, new Comparator<JobDetailsDom>() {

					@Override
					public int compare(JobDetailsDom o1, JobDetailsDom o2) {
						return o2.getSavedSearchOn().compareTo(o1.getSavedSearchOn());
					}

				});
				
				searchListCount = searchList.size();
			}
			
			modelAndView.addObject("searchjobs",searchList);
			modelAndView.addObject("count",searchListCount);
			
			logger.info(CaerusLoggerConstants.SAVED_SEARCHES);
			
			return modelAndView;
		}
		
		
		@RequestMapping(value=CaerusAnnotationURLConstants.EMPLOYER_DELETE_SAVED_SEARCH)
		public ModelAndView deleteSavedSearch(@RequestParam(value="searchParameterName")String searchParameterName,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
		{
			//Spring security authentication containing the logged in user details
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String emailId = auth.getName();
	
			//Deleting saved search
			employerManager.deleteSavedSearch(emailId, searchParameterName);
			
			logger.info(CaerusLoggerConstants.EMPLOYER_DELETE_SAVED_SEARCH);
			return new ModelAndView(new RedirectView("employer_saved_searches.htm"));
		}
		
}