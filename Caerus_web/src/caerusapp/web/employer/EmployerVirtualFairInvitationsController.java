/**
 * 
 */
package caerusapp.web.employer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusLoggerConstants;

/**
 * This class is used to view all the virtual fair invitations received by an employer
 * @author TrishnaR
 *
 */
@Controller
public class EmployerVirtualFairInvitationsController {

	//Auto-wiring service components
	//VirtualFairManager virtualFairManager;
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 *  This method is used to view all the virtual fair invitations received by an employer
	 */
	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_VIRTUAL_FAIR_INVITATIONS)
	public ModelAndView handleRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		logger.info(CaerusLoggerConstants.VIRTUAL_FAIR_LIST);
		
		//The modelAndView object contains the model(employerJobListForUniversity) and the view(employer_virtualfair_invitations)
		ModelAndView modelAndView = new ModelAndView("employer/employer_virtualfair_invitations");
		
		//Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String loggedInCorporateEmail = auth.getName();
	    
	    // Creating a domain object 
	    /*VirtualFairDom virtualFairDom = new VirtualFairDom();
	    
	    List<VirtualFairDom> fairIds = virtualFairManager.getVirtualFairInvitation(email_id);
	    
	    String jobFairIdList = ""; 
	    String status = "";
	    List<VirtualFairDom> fairDetails = null;
	    HashMap<String, String> jobStatus = new HashMap<String, String>();
	    
	    Iterator<VirtualFairDom> itr = fairIds.iterator();
		
	    while(itr.hasNext()){
	    	
	    	VirtualFairDom Id = itr.next();
	    	
	    	String jobFairId = Id.getVirtualJobId();
	    	
	    	status = Id.getInvitedCompanyStatus();
	    	
	    	if(!(status.equals("Mail_Pending"))){
	    		    	     		    		    	
	    	jobFairIdList+="'" + jobFairId + "'" + ",";
	    	
	    	jobStatus.put(jobFairId, status);

	    	}
	    }
	    
	    
	    if(jobFairIdList.length() > 0 ) {
		    jobFairIdList = jobFairIdList.substring(0, jobFairIdList.length()-1);
		    fairDetails = virtualFairManager.getVirtualFairList(jobFairIdList);
	    }
	    
    	mav.addObject("fairDetails",fairDetails);
    	mav.addObject("jobStatus",jobStatus);
    	*/
    	return modelAndView;
	}
}