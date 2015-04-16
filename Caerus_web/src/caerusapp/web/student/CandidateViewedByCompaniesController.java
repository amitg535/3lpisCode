/**
 * 
 */
package caerusapp.web.student;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;

/**
 * This class is used to Display the Companies that viewed a candidate's resume
 * @author TrishnaR,BalajiI
 *
 */

@Controller
public class CandidateViewedByCompaniesController {
	
	//Auto-wiring Service Components
	@Autowired
	StudentManager studentManager;
	
	/**
	 * This method is used to display the companies that viewed a candidate's resume
	 * @author TrishnaR,BalajiI
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.CANDIDATE_VIEWED_BY_COMPANIES,produces="application/json")
	@ResponseBody
	public StudentDom getCompanyNames(HttpServletRequest request,HttpServletResponse response)
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	    
	    StudentDom student = new StudentDom();
	    
	    HashMap<String, Object> viewedByCompaniesMap=new HashMap<String, Object>();
	    HashMap<String, Object> recentViewedByCompaniesMap=new HashMap<String, Object>();
	    
		if(emailId!=null && emailId!="")
		{
			//Retrieving List of Companies that viewed a candidate's resume
			viewedByCompaniesMap= studentManager.getViewedByCompaniesList(emailId);
		
			/* Added by RavishaG  */
			// Finding profile views for 10 days before current date
			Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(new Date());
	    	calendar.add(Calendar.DAY_OF_YEAR, - 10);
	    	Date tenDaysBack = calendar.getTime();
	    	
	    	String viewAll = request.getParameter("viewAll");
	    	
	    	if(viewedByCompaniesMap != null && viewedByCompaniesMap.size() != 0)
    		{
		    	if(viewAll == null)
		    	{		    		
			    	for (Entry<String,Object> companyMap : viewedByCompaniesMap.entrySet()) {
					
			    		Date profileViewDate = (Date) companyMap.getValue();
			    		
			    		if(profileViewDate.compareTo(tenDaysBack) > 0)
			    		{
			    			recentViewedByCompaniesMap.put(companyMap.getKey(), companyMap.getValue());
			    		}
			    		
					}
			    	
			    	if(recentViewedByCompaniesMap.size() == 0)
			    	{
			    		// No Recent Views
			    		student.setException("No recent views");
			    	}
			    	
		    	}
		    	
		    	else
		    	{
		    		student.setException(null);
		    		recentViewedByCompaniesMap = viewedByCompaniesMap;
		    	}
		    	
		    	//Sorting the map by date
		    	if(recentViewedByCompaniesMap != null && recentViewedByCompaniesMap.size() != 0)
				{
		    		recentViewedByCompaniesMap = (HashMap<String, Object>) CaerusCommonUtil.sortMapOnValues(recentViewedByCompaniesMap);	
		    		student.setViewedByCompaniesMap(recentViewedByCompaniesMap);
				}
		    	
	    	}
	    	
	    	else
	    	{
	    		// No Views
	    		student.setExceptionOccured(true);
	    	}
	    	
			
		}
			return student;
	}
	
	/**
	 * This method is used to display the companies that viewed a candidate's resume for mobile devices 
	 * @author RavishaG
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return ModelAndView
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_VIEWED_BY_COMPANIES_THIN_CLIENT)
	public ModelAndView getProfileViews(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String emailId = auth.getName();
	    
	    ModelAndView modelAndView = new ModelAndView("candidate/candidate_viewed_by_companies");
	    
	    HashMap<String, Object> viewedByCompaniesMap = new HashMap<String, Object>();
	    HashMap<String, Object> recentViewedByCompaniesMap=new HashMap<String, Object>();
	    HashMap<String, Object> viewedByCompaniesMapFinal = new HashMap<String, Object>();
	    
	    if(emailId!=null && emailId!="")
		{
			//Retrieving List of Companies that viewed a candidate's resume
			viewedByCompaniesMap= studentManager.getViewedByCompaniesList(emailId);
		
			// Finding profile views for 10 days before current date
			Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(new Date());
	    	calendar.add(Calendar.DAY_OF_YEAR, - 10);
	    	Date tenDaysBack = calendar.getTime();
	    	
	    	String viewAll = httpServletRequest.getParameter("viewAll");
	    	
	    	if(viewedByCompaniesMap != null && viewedByCompaniesMap.size() != 0)
    		{
		    	if(viewAll == null)
		    	{		    		
			    	for (Entry<String,Object> companyMap : viewedByCompaniesMap.entrySet()) {
					
			    		Date profileViewDate = (Date) companyMap.getValue();
			    		
			    		if(profileViewDate.compareTo(tenDaysBack) > 0)
			    		{
			    			recentViewedByCompaniesMap.put(companyMap.getKey(), companyMap.getValue());
			    		}
			    		
					}
			    	
			    	if(recentViewedByCompaniesMap.size() == 0)
			    	{
			    		// No Recent Views
			    		modelAndView.addObject("recentViews","No recent views");
			    	}
			    	
		    	}
		    	
		    	else
		    	{
		    		recentViewedByCompaniesMap = viewedByCompaniesMap;
		    		modelAndView.addObject("viewAll",true);
		    	}
		    	
		    	//Sorting the map by date
		    	if(recentViewedByCompaniesMap != null && recentViewedByCompaniesMap.size() != 0)
				{
		    		recentViewedByCompaniesMap = (HashMap<String, Object>) CaerusCommonUtil.sortMapOnValues(recentViewedByCompaniesMap);	
		    		
		    		viewedByCompaniesMap = (HashMap<String, Object>) CaerusCommonUtil.sortMapOnValues(viewedByCompaniesMap);
					
					for (Entry<String, Object> entry : viewedByCompaniesMap.entrySet()) {
						
						Date timestamp = (Date) entry.getValue();
						
						// display minutes in 2 digits
						Integer minutes = 0;
						String time = "";
					
						//add 1900 to year to as the getYear method returns the year minus 1900
						if(timestamp.getMinutes() < 9)
						{
							time = timestamp.getDate() + "-" + (timestamp.getMonth() +1) + "-" + (timestamp.getYear()+1900) + " at " + timestamp.getHours() +
									":" + String.format("%02d", timestamp.getMinutes());
						}
						
						else
						{
							time = timestamp.getDate() + "-" + (timestamp.getMonth() +1) + "-" + (timestamp.getYear()+1900) + " at " + timestamp.getHours() +
									":" + timestamp.getMinutes();
						}
						
						viewedByCompaniesMapFinal.put(entry.getKey(), time);
					}
		    		
				}
		    	
	    	}
	    	
	    	else
	    	{
	    		// No Views
	    		modelAndView.addObject("noViews","No Views");
	    	}
			
		}
	    
	    modelAndView.addObject("viewedByCompaniesMap",viewedByCompaniesMapFinal);
	    modelAndView.addObject("viewedByCompaniesMapCount",viewedByCompaniesMapFinal.size());
	    
		return modelAndView;
	}

}