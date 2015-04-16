/**
 * 
 */
package caerusapp.web.university;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.service.university.IUniversityManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * 
 * @author TrishnaR
 *
 */
@Controller
public class UniversityEventTemplateController {
	
	@Autowired
	private IUniversityManager universityManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping(value=CaerusAnnotationURLConstants.UNIVERSITY_SAVE_EVENT_TEMPLATE, method=RequestMethod.POST)
	public String updateEventTemplate(@RequestParam("template") String template, @RequestParam("eventId") String eventId,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)
	{
		logger.info(CaerusLoggerConstants.UPLOAD_EVENT_TEMPLATE);
		universityManager.updateEventTemplate(template,eventId);
		
		return "redirect:preview_university_event.htm";
	}
	

}