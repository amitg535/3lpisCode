package caerusapp.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;

@Controller
public class SetUsernameController {

	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	ILoginManagement loginManagement;
	
	@RequestMapping( value=CaerusAnnotationURLConstants.GET_USERNAME)
	@ResponseBody
	String getUserName(HttpServletRequest request)
	{
		String username= "";
		if(request.getSession().getAttribute("username") == null)
		{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			
			String authority = authentication.getAuthorities().toString();
			authority = authority.replace("[", "").replace("]", "");
			
			if(authority.equals("ROLE_STUDENT"))
			{
				StudentDom student = studentManager.getDetailsByEmailId(SecurityContextHolder.getContext().getAuthentication().getName());
				username = student.getFirstName().concat(" ").concat(student.getLastName());
				request.getSession().setAttribute("username", username);
			}
			
			else if(authority.equals("ROLE_CORPORATE"))
			{
				// Fetching the logged in user's details
				LoginManagementDom loggedInUserDetails = loginManagement.getUserDetailsByEmailID(SecurityContextHolder.getContext().getAuthentication().getName());
				
				String corporateName = loggedInUserDetails.getEntityName();
				String adminName = loggedInUserDetails.getFirstName().concat(" ").concat(loggedInUserDetails.getLastName());
				
				request.getSession().setAttribute("username", adminName);
				request.getSession().setAttribute("compName", corporateName);
				
			}
			
			else if(authority.equals("ROLE_UNIVERSITY"))
			{
				// Fetching the logged in user's details
				LoginManagementDom loggedInUserDetails = loginManagement.getUserDetailsByEmailID(SecurityContextHolder.getContext().getAuthentication().getName());
				
				String universityName = loggedInUserDetails.getEntityName();
				String adminName = loggedInUserDetails.getFirstName().concat(" ").concat(loggedInUserDetails.getLastName());
				
				request.getSession().setAttribute("username", adminName);
				request.getSession().setAttribute("univName", universityName);
			}
			
		}
		return username;
		
	}
}
