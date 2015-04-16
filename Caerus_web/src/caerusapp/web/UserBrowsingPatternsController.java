/**
 * 
 */
package caerusapp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.util.CaerusAnnotationURLConstants;

/**
 *This class is used to track a user's browsing patterns
 * @author RavishaG
 */

@Controller
public class UserBrowsingPatternsController {
	
	@Autowired
	private ILoginManagement loginManagement;
	
	/**
	 * This method is used to store a user's browsing patterns to the database 
	 * @param userBrowsingPatternsDom
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return userBrowsingPatternsDom
	 */
	@RequestMapping(value=CaerusAnnotationURLConstants.USER_BROWSING_PATTERNS)
	public void addPattern(@RequestBody UserBrowsingPatternsDom userBrowsingPatternsDom, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userEmailId = auth.getName();
		
		// update details in the database
		loginManagement.updateUserBrowsingPatterns(userBrowsingPatternsDom,userEmailId);
	
	}

}