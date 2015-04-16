package caerusapp.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler  {
	
	@Override
    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toString();

        String successfulLogin = "";
        if(role.contains("ROLE_CORPORATE")) {
            successfulLogin = "employer_dashboard.htm";
        }
        if(role.contains("ROLE_STUDENT")) {
            successfulLogin = "candidate_dashboard.htm";
        }
        if(role.contains("ROLE_UNIVERSITY")) {
            successfulLogin = "university_dashboard.htm";
        }
        if(role.contains("ROLE_ADMIN")) {
            successfulLogin = "admin_manage_users.htm";
        }
        
        if(role.contains("ROLE_RECOMMENDER")) {
            successfulLogin = "recommender_view_requests.htm";
        }
        
        return successfulLogin;
    }
}
