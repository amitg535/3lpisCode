package caerusapp.web;

import java.security.Principal;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.stereotype.Controller;

/**
 * 
 * @author tulsiC
 */
@Controller
public class CaerusContactUsController {
	protected final Log logger = LogFactory.getLog(getClass());
	@RequestMapping(value = "/contact_us.htm", method = RequestMethod.GET)
	public ModelAndView print(ModelMap model, Principal principal,
			Authentication cc, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		
		ModelAndView modelAndView= new ModelAndView("common/contact_us");
		
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();

		List name1 = (List)auth.getAuthorities();
		
		String role = null;

		Iterator itr = name1.iterator();

		while (itr.hasNext()) {

			role = itr.next().toString();

		}
		
		modelAndView.addObject("ROLE", role);
		return modelAndView;
		
	}	
	
}