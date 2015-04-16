package caerusapp.web.student;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import caerusapp.command.student.StudentRecommendationCom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentRecommendationDom;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.student.IStudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.MailUtil;

@Controller 
public class CandidateRecommendationController {
	
	@Autowired
	IStudentManager studentManager;
	
	@Autowired
	MailUtil mailUtil;
	
	@Autowired
	ILoginManagement loginManagement;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@RequestMapping (value =  CaerusAnnotationURLConstants.CANDIDATE_RECOMMENDATION)
	public String requestRecommendation(HttpServletRequest request, Model model, Authentication authentication){
		
		int recommendationCount = 0;
		StudentRecommendationCom studentRecommendationCom = new StudentRecommendationCom();
		
		String emailId = authentication.getName();
		
		StudentDom student = studentManager.getDetailsByEmailId(emailId);
		
		Map<String, String> universityMap = student.getUniversityMap();
		Set<String> studentUniversitySet = new HashSet<String>();
		
		
		for (Map.Entry<String, String> entry : universityMap.entrySet())
		{
			if(entry.getKey().contains("universityName")){
				
				studentUniversitySet.add(entry.getValue());
			}
		}
		
		
		Map<String, String> workMap = student.getWorkMap();
		Set<String> studentCompnaySet = new HashSet<String>();
		
		for (Map.Entry<String, String> entry : workMap.entrySet()) {
			
			if(entry.getKey().contains("workCompanyName")){
							
				studentCompnaySet.add(entry.getValue());

			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String universityString = ""; String compnayString = "";
		try {
			universityString = mapper.writeValueAsString(studentUniversitySet);
			compnayString = mapper.writeValueAsString(studentCompnaySet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String candidateEmailId = authentication.getName();
		List <StudentRecommendationDom> recommendationList = studentManager.getCandidateRecommendations(candidateEmailId, CaerusStringConstants.DEFAULT_STUDENT_AUTHORITY, "");
		
		if(recommendationList.size() !=0){
			recommendationCount = recommendationList.size();
		}
		
		model.addAttribute("studentRecommendationCom", studentRecommendationCom);
		model.addAttribute("studentUniversitySet",universityString);
		model.addAttribute("studentCompanySet", compnayString);
		model.addAttribute("recommendationList", recommendationList);
		model.addAttribute("recommendationCount", recommendationCount);
		
		
		
		return CaerusJSPMapper.CANDIDATE_RECOMMENDATION;
		
	}
	
	@RequestMapping(value = CaerusAnnotationURLConstants.CANDIDATE_RECOMMENDATION, method={RequestMethod.POST})
	protected String postRecommendationRequest(@ModelAttribute("studentRecommendationCom") StudentRecommendationCom studentRecommendationCom, BindingResult bindingResult, HttpServletRequest request,
			HttpServletResponse response, Model model, @RequestParam(value="sendReminder",required = false) boolean sendReminder, Authentication authentication) throws Exception {


		String candidateEmailId = authentication.getName();
		
		LoginManagementDom studentDetails = loginManagement.getUserDetailsByEmailID(candidateEmailId);
		studentRecommendationCom.setStudentFirstName(studentDetails.getFirstName());
		studentRecommendationCom.setStudentLastName(studentDetails.getLastName());
		
		if(sendReminder && !studentRecommendationCom.getRecommenderEmailId().equals("")){
			
			studentManager.sendRecommendationReminder(candidateEmailId, studentRecommendationCom.getRecommenderEmailId());
			
			StringBuffer html = new StringBuffer();
			html.append("<!DOCTYPE html>");
			html.append("<html lang='en'>");
			html.append("<head>");
			html.append("<meta charset='utf-8'>");
			html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
			html.append("<title>Candidate Recommendation Reminder</title>");
			html.append("<meta name='description' content=''>");
			html.append("<meta name='author' content=''>");
			html.append("</head>");
			html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
			html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
			html.append("<tr>");
			html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
			html.append("</tr>");

			html.append("</table>");

			html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
			html.append("<tr>");
			html.append("<td>");
			
			html.append("<table>");
			html.append("<tbody><tr>");
			
			html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'> <span id = 'student'>had requested for a Recommendation for their profile at Imploy.me on <span id='sentOn'> </span><br> "
					+ "  <br> This mail is to remind you to filling in the reccomendation form will add a great value to the candidates profile.  <br> Please find your login into Imploy.me using following credentials to complete the recommendation.</td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td> Username: <span id = 'userMailId'></td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td> Password: <span id = 'userPassword'></td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='padding-top : 15px;'>");
			html.append("</td>");
			html.append("</tr>");
			
			
			html.append("<tr>");
			html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
			html.append("</tr>");
			html.append("</tbody>");
			html.append("</table>");
			html.append("</td>");
			html.append("</tr>");
			html.append("</table>");
			html.append("</body>");
			html.append("</html>");
			
			Document doc = Jsoup.parse(html.toString());
			doc.getElementById("userName").text("Dear"+studentRecommendationCom.getRecommenderFirstName());
			
            LoginManagementDom studentUser = loginManagement.getUserDetailsByEmailID(candidateEmailId);
			
			doc.getElementById("student").text(studentUser.getFirstName());
			
			doc.getElementById("student").text(candidateEmailId);
			doc.getElementById("sentOn").text(studentRecommendationCom.getRequestTime().toString());
			doc.getElementById("userMailId").text(studentRecommendationCom.getRecommenderEmailId());
			doc.getElementById("userPassword").text("12345678");
			String mailSubject= studentUser.getFirstName()+ "" + studentUser.getLastName()+"has requested for recommendation at Imploy.me";
			mailUtil.sendMailToUsers(studentRecommendationCom.getRecommenderEmailId(), doc.toString(), mailSubject);
			
		}
		
		else {
			
			StudentRecommendationDom studentRecommendationDom = new StudentRecommendationDom();
			
			BeanUtils.copyProperties(studentRecommendationCom, studentRecommendationDom);
			
			studentRecommendationDom.setStudentEmailId(authentication.getName());
			studentRecommendationDom.setRequestTime(new Date());
			studentRecommendationDom.setStudentRecoStatus(CaerusStringConstants.DEFAULT_CANDIDATE_RECOMMENDATION_STATUS);
			studentRecommendationDom.setRecommenderStatus(CaerusStringConstants.DEFAULT_RECOMMENDER_STATUS);
			
			studentManager.sendRecommendationRequest(studentRecommendationDom);
			
			
			StringBuffer html = new StringBuffer();
			html.append("<!DOCTYPE html>");
			html.append("<html lang='en'>");
			html.append("<head>");
			html.append("<meta charset='utf-8'>");
			html.append("<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>");
			html.append("<title>Candidate Recommendation Request</title>");
			html.append("<meta name='description' content=''>");
			html.append("<meta name='author' content=''>");
			html.append("</head>");
			html.append("<body style='font-family:Tahoma; margin:0; padding:0; font-size:14px; line-height:1.8em;'>");
			html.append("<table width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc;border-bottom:0px solid #ccc; padding:5px;' align='center'>");
			html.append("<tr>");
			html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'><span style='font-style:italic;color:#fff94D; font-size:30px;'>Welcome </span> &nbsp To Imploy.Me </td>");
			html.append("</tr>");

			html.append("</table>");

			html.append("<table id='abc' width='968px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-size:14px;border:1px solid #ccc; padding:5px;border-top:0px solid #ccc;' align='center'>");
			html.append("<tr>");
			html.append("<td>");
			
			html.append("<table>");
			html.append("<tbody><tr>");
			
			html.append("<td style='color: #0B99B3;font-size: 18px;padding-top: 20px;'>Dear <span id='userName'>,</td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top: 20px;'> <span id = 'student'> has requested for a Recommendation for their profile at Imploy.me <br> "
					+"Please find your login into Imploy.me using following credentials to complete the recommendation.</td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td> Username: <span id = 'userMailId'></td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td> Password: <span id = 'userPassword'></td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td>We are sure that you would love the amazing new services extended by us. Regards,<br> Imploy.me team </td>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='padding-top : 15px;'>");
			html.append("</td>");
			html.append("</tr>");
			
			
			html.append("<tr>");
			html.append("<td style='color: #2e2e2e;font-size: 16px;font-weight: normal;padding-top : 20px;'>Regards,<br>Imploy.me Team</td>");
			html.append("</tr>");
			html.append("</tbody>");
			html.append("</table>");
			html.append("</td>");
			html.append("</tr>");
			html.append("</table>");
			html.append("</body>");
			html.append("</html>");
			
			Document doc = Jsoup.parse(html.toString());
			doc.getElementById("userName").text(studentRecommendationDom.getRecommenderFirstName());
			
			LoginManagementDom studentUser = loginManagement.getUserDetailsByEmailID(studentRecommendationDom.getStudentEmailId());
			
			doc.getElementById("student").text(studentUser.getFirstName());
			
			doc.getElementById("userMailId").text(studentRecommendationDom.getRecommenderEmailId());
			doc.getElementById("userPassword").text("12345678");
			String mailSubject= studentUser.getFirstName()+""+studentUser.getLastName()+"has requested for recommendation at Imploy.me";
			mailUtil.sendMailToUsers(studentRecommendationDom.getRecommenderEmailId(), doc.toString(), mailSubject);
			
		}

		return CaerusJSPMapper.CANDIDATE_RECOMMENDATION_REDIRECT;
		
	}

	@RequestMapping (value = CaerusAnnotationURLConstants.RECOMMNDER_VIEW_REQUESTS)
	public String viewReceivedRecommnedations(Model model, Authentication authentication, HttpServletRequest httpServletRequest){
		
		int pendingRequestCount = 0;
		int completedRecommendationCount = 0;
		
		String recommenderEmailId = authentication.getName();
		
		// Creating a new session
		HttpSession session = httpServletRequest.getSession();
		
		LoginManagementDom recommederUser = loginManagement.getUserDetailsByEmailID(recommenderEmailId);
		
		String concatenatedName = recommederUser.getFirstName()+""+ recommederUser.getLastName();

		// Setting values in the session
		session.setAttribute("username", concatenatedName);
		session.setAttribute("recommenderOrg", recommederUser.getEntityName());
		
		List <StudentRecommendationDom> pendingRequestList = studentManager.getCandidateRecommendations(recommenderEmailId, CaerusStringConstants.DEFAULT_RECOMMENDER_AUTHORITY, CaerusStringConstants.DEFAULT_RECOMMENDER_STATUS);
		List <StudentRecommendationDom> completedRecommendationList = studentManager.getCandidateRecommendations(recommenderEmailId, CaerusStringConstants.DEFAULT_RECOMMENDER_AUTHORITY, CaerusStringConstants.RECOMMENDER_STATUS);
		
		
		if(pendingRequestList != null && pendingRequestList.size() > 0){
			pendingRequestCount = pendingRequestList.size();
		}
		
		if(completedRecommendationList != null && completedRecommendationList.size() > 0){
			completedRecommendationCount = completedRecommendationList.size();
			model.addAttribute("completedRecommendationCount", completedRecommendationCount);
		}
		
		List<String> yearsStudentKnownList = CaerusStringConstants.getYearsStudentKnownDropdown();
		
			
		model.addAttribute("pendingRequestCount", pendingRequestCount);
		model.addAttribute("completedRecommendationCount",completedRecommendationCount);
		
		model.addAttribute("pendingRequestList", pendingRequestList);
		model.addAttribute("completedRecommendationList", completedRecommendationList);
		model.addAttribute("yearsStudentKnownList", yearsStudentKnownList);
		model.addAttribute("submitRecommendation", new StudentRecommendationCom());
		
		return CaerusJSPMapper.RECOMMENDER_VIEW_RECOMMENDATIONS;
		
	}

		
	@RequestMapping(value = CaerusAnnotationURLConstants.RECOMMENDER_SUBMIT_RECOMMENDATION, method={RequestMethod.POST})
	public void sendRecommendation(@ModelAttribute("submitRecommendation") StudentRecommendationCom studentRecommendationCom, BindingResult bindingResult, HttpServletRequest request,
			HttpServletResponse response, Authentication authentication){
		
		
		StudentRecommendationDom studentRecommendationDom = new StudentRecommendationDom();
		
		BeanUtils.copyProperties(studentRecommendationCom, studentRecommendationDom);
		studentRecommendationDom.setRecommenderEmailId(authentication.getName());
		studentRecommendationDom.setRecommenderStatus(CaerusStringConstants.RECOMMENDER_STATUS);
		studentRecommendationDom.setStudentRecoStatus(CaerusStringConstants.CANDIDATE_RECOMMENDATION_STATUS);
		
	    studentManager.submitRecommendation(studentRecommendationDom);
		
		
	}


}
