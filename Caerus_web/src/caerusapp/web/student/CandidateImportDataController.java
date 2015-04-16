package caerusapp.web.student;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CandidateCommonFeature;

/**
 * This class is used to import logged in candidate's details from his/her LinkedIn profile
 * @author RavishaG
 *
 */

@Controller
public class CandidateImportDataController {

	// Auto-wiring service component
	@Autowired
	IStudentManager studentManager;
	
	/**
	 * This method is used to import logged in candidate's details from his/her LinkedIn profile
	 * @param student
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @return null
	 */
	@RequestMapping(method = RequestMethod.POST, value = CaerusAnnotationURLConstants.CANDIDATE_IMPORT_DATA)
	public void importData(@RequestBody StudentDom student, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String studentEmailId = auth.getName();
		
		// Retrieving student details from the database
		StudentDom studentDetails= studentManager.getDetailsByEmailId(studentEmailId);
		
		// Setting values from value object(domain) to business objects(command)
		student.setFirstName(studentDetails.getFirstName());
		student.setLastName(studentDetails.getLastName());
		student.setEmailID(studentEmailId);
		
		Date date = CaerusCommonUtility.stringToDate(student.getDateOfBirth(), "yyyy-MM-dd");
		student.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").format(date));	
		
		String abc = null;
		int i = 0;
		
		List<String> skillList = student.getPrimarySkills();
		if (!skillList.isEmpty()) {		
			abc = skillList.get(skillList.size()-1);
			skillList.remove(skillList.size()-1);
		}
		
		if(!(skillList == null)){
			 StringBuilder sb = new StringBuilder();
		        for(String str : skillList){
		            sb.append(str).append(","); 				//separating contents using semi colon
		        }
		      
		    String strfromArrayList = sb.toString();
			student.setPrimarySkills1(strfromArrayList);
		}
		
		if(!(skillList.get(skillList.size()-1) == null))
		{		
			student.setSecondarySkills1(abc);
		}
		
		// Updating the database with the details imported
		studentManager.addStudentResumeSkills(student);
		studentManager.addStudentIntroductory(student);
		studentManager.addStudentInterests(studentEmailId, student);
		studentManager.addStudentLanguagesKnown(studentEmailId, student);
		
		/* Work Details */
		Map<String,String> workMap = student.getWorkMap();
		List<PortfolioDetailsDom> workList = CandidateCommonFeature.getWorkDetails(workMap);
		
		studentManager.addWorkDetails(studentEmailId, workList, i);
		
		/* School Details */
		Map<String,String> schoolMap = student.getSchoolMap();
		PortfolioDetailsDom schoolDetails = CandidateCommonFeature.getSchoolDetails(schoolMap);
		
		studentManager.addSchoolDetails(studentEmailId, schoolDetails);
		
		/* University Details */
		Map<String,String> universityMap = student.getUniversityMap();
		List<PortfolioDetailsDom> universityList = CandidateCommonFeature.getUniversityDetails(universityMap);
		
		studentManager.addUniversityDetails(studentEmailId, universityList, i);
		
		/*  Certification Details  */
		Map<String,String> certificationsMap = student.getCertificationsMap();
		List<PortfolioDetailsDom> certificationList = CandidateCommonFeature.getCertificationList(certificationsMap);
		
		studentManager.addCertificationDetails(studentEmailId, certificationList, i);
		
		/*  Publications Details  */
		Map<String,String> publicationsMap = student.getPublicationsMap();
		List<PortfolioDetailsDom> publicationList = CandidateCommonFeature.getPublicationList(publicationsMap);
		
		studentManager.addPublicationDetails(studentEmailId, publicationList, i);
		
	}
}	