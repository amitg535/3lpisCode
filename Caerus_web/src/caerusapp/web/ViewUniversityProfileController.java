package caerusapp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.university.UniversityDetailsDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusJSPMapper;

/**
 * This class is used to display the university profile page
 * @author RavishaG
 */
@Controller
public class ViewUniversityProfileController {

	// Auto-wiring service component
	@Autowired
	IUniversityManager universityManager;
	@Autowired
	ILoginManagement loginManagement;
	
	/**
	 * This method is used to fetch the university profile details from the database
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.VIEW_UNIVERSITY_PROFILE)
	public ModelAndView universityProfilePreview(@RequestParam(value="universityName", required=false) String universityName,HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// The modelAndView object contains the model(data) and the view(page)
		ModelAndView modelAndView = new ModelAndView(CaerusJSPMapper.COMMON_UNIVERSITY_PROFILE);
				
		String emailId = "";
		if(universityName == null || universityName.isEmpty())
		{
			// Spring security authentication containing the logged in user details
			Authentication auth=SecurityContextHolder.getContext().getAuthentication();
			emailId=auth.getName();
			
			HttpSession session = httpServletRequest.getSession();
			// Setting values in the session
			universityName = (String) session.getAttribute("univName");
		}
		
		UniversityDetailsDom universityDetails = universityManager.getUniversityDetailsByName(universityName);
		
		if(!universityName.isEmpty() && universityDetails != null)
		{
			LoginManagementDom adminDetails = loginManagement.getAdminByEntityName(universityName);
			emailId = adminDetails.getUserName();
			
			universityDetails.setContactPersonEmailId(emailId);
			
			//Handling empty awardsandRecognition list
			if(null != universityDetails.getAwardsAndRecognitionList() && universityDetails.getAwardsAndRecognitionList().size() !=0){
				for (String awards : universityDetails.getAwardsAndRecognitionList()) {
					if(awards.equals(""))
					{
						universityDetails.setAwardsAndRecognitionList(null);
					}
				}
			}
			
		}
	
		// Adding values to the modelAndView object
		modelAndView.addObject("universityDetails",universityDetails);
		
		// returning the modelAndView object
		return modelAndView;
	}
	
	
}
