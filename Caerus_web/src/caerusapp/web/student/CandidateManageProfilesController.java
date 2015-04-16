package caerusapp.web.student;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.student.StudentCom;
import caerusapp.domain.student.StudentDom;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;

@Controller
public class CandidateManageProfilesController {

	@Autowired
	IStudentManager studentManager;
	
	private String REDIRECT_MANAGE_PROFILES = "redirect:"+CaerusAnnotationURLConstants.CANDIDATE_MANAGE_PROFILES;
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_MANAGE_PROFILES)
	String loadProfiles(Model model){
		Integer profileCount = 0;
		List<StudentDom> profiles = studentManager.getProfiles(SecurityContextHolder.getContext().getAuthentication().getName());
		
		if(profiles != null && profiles.size() > 0)
			profileCount = profiles.size();
		
		model.addAttribute("profileCount",profileCount);
		model.addAttribute("profiles",profiles);
		return "candidate/candidate_manage_profile";
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_MARK_DEFAULT_PROFILE)
	String markDefault(@RequestParam("profileName") String profileName){
		studentManager.markDefault(SecurityContextHolder.getContext().getAuthentication().getName(),profileName);
		return REDIRECT_MANAGE_PROFILES;
	}
	String updateProfile(@ModelAttribute("profileDetails") StudentCom profileDetails){
		StudentDom profileDetailsDom = new StudentDom();
		
		BeanUtils.copyProperties(profileDetails, profileDetailsDom);
		studentManager.updateStudentProfile(profileDetailsDom);
		return REDIRECT_MANAGE_PROFILES;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_EDIT_PROFILE)
	String loadProfileDetails(@RequestParam("profileName") String profileName,Model model){
		StudentDom profileDetails = studentManager.getProfileDetails(SecurityContextHolder.getContext().getAuthentication().getName(),profileName);
		
		model.addAttribute("editMode",true);
		model.addAttribute("profileDetails",profileDetails);
		return "candidate/candidate_create_profile";
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_CREATE_PROFILE,method = RequestMethod.GET)
	String loadNewProfilePage(Model model) {
		model.addAttribute("profileDetails",new StudentCom());
		return "candidate/candidate_create_profile";
	}
	
	@RequestMapping(value = "candidate_create_profile.htm",method = RequestMethod.POST)
	String createNewProfile(@ModelAttribute("profileDetails") StudentCom profileDetails,BindingResult bindingResult,Model model) {
	
		profileDetails.setEmailID(SecurityContextHolder.getContext().getAuthentication().getName());
		
		if(profileDetails.getFile() != null && profileDetails.getFile().getOriginalFilename() != null && profileDetails.getFile().getOriginalFilename().length() > 0) {
			if(! (CaerusCommonUtil.getFileExtension(profileDetails.getFile().getOriginalFilename()).equalsIgnoreCase("pdf") ||
				 CaerusCommonUtil.getFileExtension(profileDetails.getFile().getOriginalFilename()).equalsIgnoreCase("doc") || 
				 CaerusCommonUtil.getFileExtension(profileDetails.getFile().getOriginalFilename()).equalsIgnoreCase("docx")  ))
			{
				bindingResult.rejectValue("file", "Invalid File","Please Enter a Valid Resume with pdf,doc or docx extensions");
			}
		}
		
		if( profileDetails.getEditMode()!= null && !profileDetails.getEditMode())
		{
			if(studentManager.checkIfProfileNameExists(profileDetails.getProfileName(),profileDetails.getEmailID())){
				bindingResult.rejectValue("profileName", "Invalid Profile Name","Duplicate Profile Name.Please Enter a New Name");
			}
		}
		else {
			model.addAttribute("editMode",true);
			
		}
		
		if(profileDetails.getPrimarySkills() == null || profileDetails.getPrimarySkills().size() == 0)
			bindingResult.rejectValue("primarySkills", "Empty Primary Skills","Please Enter Primary Skills");
		
		if(profileDetails.getSecondarySkills() == null || profileDetails.getSecondarySkills().size() == 0)
			bindingResult.rejectValue("secondarySkills", "Empty Secondary Skills","Please Enter Secondary Skills");
		
		if(profileDetails.getAboutYourSelf() == null || profileDetails.getAboutYourSelf().trim().length() == 0)
			bindingResult.rejectValue("aboutYourSelf", "Empty aboutYourSelf","Please Write Something About Yourself");
		
		if(profileDetails.getProfileName() == null || profileDetails.getProfileName().trim().length() == 0)
			bindingResult.rejectValue("profileName", "Empty profileName","Please Give an Identity to yourself with a Profile Name");
		
		
		if(bindingResult.hasErrors()){
			return CaerusJSPMapper.CANDIDATE_CREATE_PROFILE;
		}
		
		StudentDom profileDetailsDom = new StudentDom();
		BeanUtils.copyProperties(profileDetails, profileDetailsDom);
		
		studentManager.updateStudentProfile(profileDetailsDom);
		return REDIRECT_MANAGE_PROFILES;
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_DELETE_PROFILE,method = RequestMethod.GET)
	String deleteProfile(@RequestParam("profileName") String profileName) {
		studentManager.deleteProfile(SecurityContextHolder.getContext().getAuthentication().getName(),profileName);
		return REDIRECT_MANAGE_PROFILES;
	}
	
	
}
