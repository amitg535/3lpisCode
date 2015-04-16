package caerusapp.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.site.SitePreference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.common.BetaUserCmd;
import caerusapp.command.common.JobDetailsCom;
import caerusapp.command.common.LoginManagementCom;
import caerusapp.domain.common.BetaUserDom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.lucene.indexing.LuceneHomePageSearcher;
import caerusapp.lucene.indexing.LuceneIScore;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.service.student.StudentManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CaerusStringConstants;
import caerusapp.util.MailUtil;


@Controller
public class HomeController {
	
	@Autowired
	StudentManager studentManager;
	
	@Autowired
	IMasterManager masterManager;
	
	@Autowired
	IStudentJobsManager studentJobsManager;
	
	@Autowired
	ILoginManagement loginManagement;

	@Autowired
	MailUtil mailUtil;
	
	@RequestMapping(value=CaerusAnnotationURLConstants.HOME_PAGE,method = RequestMethod.GET)
	 public String sayHello(@ModelAttribute("registered") String registered,@ModelAttribute("exists") String exists,@ModelAttribute("unregistered") String unregistered,@RequestParam(value="error",required=false) String error,SitePreference sitePreference,HttpServletRequest request,Model model,@RequestParam(required=false)String userName,Device device) throws Exception 
	 {
		if(registered != null && !registered.isEmpty())
			model.addAttribute("registered", true);

		if(null != unregistered && !unregistered.isEmpty())
			model.addAttribute("unregistered", true);
		
		if(exists != null && !exists.isEmpty())
			model.addAttribute("exists", true);
		
		if(null != userName)
		 {
				String enabledStatus = loginManagement.getEnabledStatusByUsername(userName);

				if (enabledStatus == null || enabledStatus.equals("null")|| enabledStatus.equalsIgnoreCase("false")) 
				{
					// Updating the status of a student in the database
					loginManagement.updateEnabledStatusByUsername(userName);

					model.addAttribute("verificationSuccessMessage", "Congratulations! \n Your have successfully activated your account.");
					
				} 
				else if (enabledStatus.equals(" ")|| enabledStatus.equals("true"))
				{
					model.addAttribute("verificationSuccessMessage", "Your account is already activated.");
				}
					
			}
		
		 //Fetching student list in descending order of their i-scores
		 List<StudentDom> studentList = new ArrayList<StudentDom>();
		 studentList = LuceneIScore.getCandidateIScore();
		
		List<String> industryList =  masterManager.getIndustries();
		List<String> functionalAreaList = masterManager.getFunctionalAreas();
		List<String> universityNames= masterManager.getRegisteredUniversities();
		

		Collections.sort(industryList);
		Collections.sort(functionalAreaList);
		
		ObjectMapper mapper = new ObjectMapper();
		String universityNamesjson = "";
		
		universityNamesjson = mapper.writeValueAsString(universityNames);
		
		if(error != null && !error.isEmpty())
		{
			if(!device.isNormal())
			{
				model.addAttribute("error", true);
				return "common/login";
			}
			
			else
			model.addAttribute("error", true);
		}
		
		
			
		model.addAttribute("studentSearchJobs", getSearchJobsObject());
		model.addAttribute("industryList", industryList);
		model.addAttribute("functionalAreaList", functionalAreaList);
		model.addAttribute("universityNames", universityNamesjson);
		model.addAttribute("studentList", studentList);
		model.addAttribute("betaUserCmd", new BetaUserCmd());
		model.addAttribute("loginManagementCom", new LoginManagementCom());
		return "common/home";
	 }
	
	/*@RequestMapping("home.htm")
	String loadHomePage()
	{
		model.addAttribute("studentSearchJobs",getSearchJobsObject());
		return "common/home";
	}*/
	
	
	/**
	  * This method to search jobs or internships from the home page.
	  * @author TrishnaR
	  * @param searchJobs
	  * @param httpServletRequest
	  * @param httpServletResponse
	  * @param result
	  * @return modelAndView
	  * @throws Exception
	  */
	 
	 @RequestMapping(value=CaerusAnnotationURLConstants.HOME_PAGE,method=RequestMethod.POST)
		public ModelAndView getJobs(@ModelAttribute("studentSearchJobs") JobDetailsCom searchJobs,
				HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,BindingResult result) throws Exception{
			
		 	// The modelAndView object contains the model(data) and the view(page)
		 	ModelAndView modelAndView = new ModelAndView("candidate/candidate_job_listing");
		
			//List<EmployerJobPost> searchedJobsDetails = new ArrayList<EmployerJobPost>();
			
		 	List<JobDetailsDom> searchedJobsDetails = new ArrayList<JobDetailsDom>();
		 	
			String searchKeyword = searchJobs.getKeyword();
			//String location = searchJobs.getLocation();
			String searchCriterion = searchJobs.getSearchCriteria();

		    //String SRC_FOLDER="/home/lucene/Indexes";
			  String SRC_FOLDER = CaerusPathConstants.jobIndexes;
			
			File indexDir = new File(SRC_FOLDER);
			
			LuceneHomePageSearcher luceneHomePageSearcher = new LuceneHomePageSearcher();
			List<String> idList = new ArrayList<String>();
			
			Pattern stopWords = Pattern.compile("\\b(?:i|a|an|and|are|as|at|be|but|by|for|if|in|into|into|no|not|of|on|or|such|that|the|their|then|there|to|was|will|with)\\b\\s*", Pattern.CASE_INSENSITIVE);
			try {
				//Code to avoid stop word insert
				if (!searchKeyword.contains(" "))
					
				{
					Matcher matcher = stopWords.matcher(searchKeyword);
					searchKeyword= matcher.replaceAll("");
			    	if(searchKeyword.length()!=0)
					studentManager.addSearchedKeywords(searchKeyword,true);
				}
				
				else{
					studentManager.addSearchedKeywords(searchKeyword,true);
					Matcher matcher = stopWords.matcher(searchKeyword);
					searchKeyword= matcher.replaceAll("");
					//First keyword group after stop word remove
					//if(searchKeyword.length()!=0)
					//studentManager.addSearchedKeywords(searchKeyword);
					
					//To insert individual words
					String[] searchKeywords = searchKeyword.split(" ");
										
					for(String word: searchKeywords)
					studentManager.addSearchedKeywords(word,false);
				
				}
				
			}
			catch(Exception exception){
				exception.printStackTrace();				
			}
			
			try{
			 idList= luceneHomePageSearcher.searchIndex(indexDir, searchKeyword, searchCriterion);
			}catch(FileNotFoundException fnfe){
				fnfe.printStackTrace();
				//print("Indexes not found at "+indexDir);
			}
			catch(Exception exception){
				exception.printStackTrace();
			}
			

			if (idList.size()!= 0) {

				// Retrieving the searched job details from the database
				if(searchCriterion.equalsIgnoreCase("jobs")){
					searchCriterion = "Jobs";
				
				searchedJobsDetails = studentJobsManager.getJobDetails(idList);
				}
				
				// Retrieving the searched internship details from the database
				 if(searchCriterion.equalsIgnoreCase("internships")){
					 searchCriterion = "Internships";
					
					 searchedJobsDetails = studentJobsManager.getInternshipDetails(idList);
				 }
				
			}
			
			int count = 0;
			
			if (!(searchedJobsDetails == null)) {
				count = searchedJobsDetails.size();
			}
			List<String> industryList =  masterManager.getIndustries();
			List<String> functionalAreaList = masterManager.getFunctionalAreas();
			
			// Adding values to the modelAndView object
			modelAndView.addObject("count", count);
			modelAndView.addObject("searchJobs",searchedJobsDetails);
			modelAndView.addObject("criteria", searchCriterion);
			modelAndView.addObject("functionalAreaList", functionalAreaList);
			modelAndView.addObject("industryList", industryList);
			

			// returning the modelAndView object
			return modelAndView;
	 
	 }
	 
	 	@ModelAttribute("studentSearchJobs")
	 	public JobDetailsCom getSearchJobsObject() {
	 		return new JobDetailsCom();
	 	}
	
	 	@ModelAttribute("searchJobsCommand")
	 	private JobDetailsCom getsearchJobsCommandObject() {
		 return new JobDetailsCom();	
	 	}
	
	 	@ModelAttribute("searchJobs")
	 	public JobDetailsCom getSearchJobs() {
	 		return new JobDetailsCom();
	 
	 	}
	 	
	 	
	 	/**
		  * This method is used to display the functional Area List
		  * @param sitePreference
		  * @param device
		  * @param model
		  * @return String
		  * @throws Exception
		  */
		 @RequestMapping(value=CaerusAnnotationURLConstants.LOGIN_PAGE)
		 public String loginMobile(HttpServletRequest httpServletRequest) throws Exception 
		 {
			 return "common/login";   
		 }
	 	
		 
		 @RequestMapping(value=CaerusAnnotationURLConstants.REGISTER_BETA_USER,method=RequestMethod.POST)
		 public ModelAndView registerBetaUser(@ModelAttribute("betaUserCmd") BetaUserCmd betaUserCmd ,HttpServletRequest servletRequest, ModelMap model,BindingResult result,RedirectAttributes redirectAttributes){
			 
			 BetaUserDom betaUser=new BetaUserDom();
			 betaUser.setEmailId(betaUserCmd.getEmailId());
			 betaUser.setRole(betaUserCmd.getRole());
			 
				
				String remoteAddress = servletRequest.getRemoteAddr();
				
				ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
		        reCaptcha.setPrivateKey("6Lc7Nf0SAAAAANmN2GnycCmSWBj2oKbwaKzC0cVX");
		        reCaptcha.setPublicKey("6Lc7Nf0SAAAAADWkURapK18AI1YdErSaZb6MuLEF");

		        String challenge = servletRequest.getParameter("recaptcha_challenge_field");
		        String uresponse = servletRequest.getParameter("recaptcha_response_field");
				
				ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddress, challenge, uresponse);
				if(reCaptchaResponse.isValid())
				{
				if(loginManagement.checkBetaUserExists(betaUser.getEmailId()))
				  {
					 redirectAttributes.addFlashAttribute("exists", "true");
					 return new ModelAndView(new RedirectView("home.htm"));
				  }
				  else
				  { 
					  Document document = CaerusCommonUtil.registrationMailTemplate("BetaUser");
					  
						 try {
							 loginManagement.insertBetaUser(betaUser);
							 mailUtil.sendMailToUsers(betaUser.getEmailId(), document.toString(), "Welcome to Imploy Me");
								
								String content="<html><head></head><body>Hello ,<br>"+"A new Beta User has been registered waiting for confirmation.The details are :" +
										"<br>"+ "Username: " + betaUser.getEmailId() + "<br>" + "Intended Role: " + betaUser.getRole() + "<br>" + 
										  "<br><br>" +
										"Regards,<br> Imploy.me team</body></html>";
								
								Document doc = Jsoup.parse(content);
								
								String mailSubject="New Beta User Registered";

								
								mailUtil.sendMailToUsers(CaerusStringConstants.FORWARD_TO_SAJU, doc.toString(), mailSubject);
								mailUtil.sendMailToUsers(CaerusStringConstants.FORWARD_TO_NEIL, doc.toString(), mailSubject);
								
							} catch (IOException e1) {
								e1.printStackTrace();
							}
						 
						 redirectAttributes.addFlashAttribute("registered", "true");
						 return new ModelAndView(new RedirectView("home.htm"));
				  }
					  
			}
				 else {
				
					 model.addAttribute("Invalidcaptcha", "Invalid captcha");
				 }
			 return new ModelAndView("common/home");
		 }
}