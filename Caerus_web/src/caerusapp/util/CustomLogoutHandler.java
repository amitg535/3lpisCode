package caerusapp.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import caerusapp.service.common.ILoginManagement;

public class CustomLogoutHandler extends SimpleUrlLogoutSuccessHandler {

	// Autowiring service component
	private ILoginManagement loginManagement;
		
	/**
	 * This method is used to get the logout time of a user and redirect it to the home page on logout
	 */
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, 
			Authentication authentication) throws IOException, ServletException {

		// Spring security authentication containing the logged in user details
		String userEmailId = authentication.getName();
		
		// update details in the database
		loginManagement.setUserLogoutTime(userEmailId);
		
        // Redirect user to the home page
		response.sendRedirect("home.htm");
		
	}

	public ILoginManagement getLoginManagement() {
		return loginManagement;
	}

	public void setLoginManagement(ILoginManagement loginManagement) {
		this.loginManagement = loginManagement;
	}
}
