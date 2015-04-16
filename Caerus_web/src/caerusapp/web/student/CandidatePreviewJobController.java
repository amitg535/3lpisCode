package caerusapp.web.student;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.lucene.queryparser.classic.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.lucene.indexing.SimpleDBSearcher;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.employer.IEmployerJobPostManager;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.service.student.IStudentJobsManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtility;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusPathConstants;
import caerusapp.util.CandidateCommonBrowseJobs;
import caerusapp.util.MailUtil;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Iterables;

/**
 * This class is used to display Job preview to a candidate
 */
@Controller
public class CandidatePreviewJobController {

	/** Auto-wiring Service Components */
	@Autowired
	private IEmployerJobPostManager employerJobPostManager;
	
	@Autowired
	private IEmployerManager employerManager;
    
	@Autowired
    private ILoginManagement loginManagement;
    
	@Autowired
    private IStudentJobsManager studentJobsManager;

	@Autowired
	MailUtil mailUtil;

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * This method is used to display Job preview to a candidate
	 * @throws ParseException 
	 */
	@RequestMapping (value = CaerusAnnotationURLConstants.CANDIDATE_PREVIEW_JOB)
	public ModelAndView previewJobDetails(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException, ParseException {
		
		/**Spring security authentication containing the logged in user details*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String emailId = auth.getName(); //Logged in User's Email Id
		
	//	int countFlag = 0;
		//Boolean isSavedJob = false;


		logger.info(CaerusLoggerConstants.VIEW_JOB_DETAILS);
		
		/** The modelAndView object contains the model(savedSearchList) and the view(candidate_preview_listed_job)*/
		ModelAndView modelAndView = new ModelAndView("candidate/candidate_preview_listed_job");
		
		/** Retrieving the Current Session */
		HttpSession session = request.getSession(true);
		
		Map<String,String> sessionMap = (Map<String,String>) session.getAttribute("sessionMap");
		
		if(null != sessionMap)
		{
			if(sessionMap.containsKey("keyword"))
				modelAndView.addObject("keyword", sessionMap.get("keyword"));
			if(sessionMap.containsKey("location"))
				modelAndView.addObject("location",  sessionMap.get("location"));
			if(sessionMap.containsKey("industry"))
				modelAndView.addObject("industry",  sessionMap.get("industry"));
			if(sessionMap.containsKey("functionalArea"))
				modelAndView.addObject("functionalArea",  sessionMap.get("functionalArea"));
			if(sessionMap.containsKey("jobType"))
				modelAndView.addObject("jobType",  sessionMap.get("jobType"));
		}
		
		String jobId = request.getParameter("jobId");
		JobDetailsDom job = null;
		EmployerDom companyDetails = new EmployerDom();
		Map<String,Date> appliedJobIdsMap = new HashMap<String,Date>();
		Integer candidatePosition = 0, responseCount = 0;
		
		if (jobId != null) {
			
			Map<String, String> appliedCandidates = employerJobPostManager.getAppliedCandidateEmailIds(jobId); 
			
			if(appliedCandidates != null && appliedCandidates.size() > 0) {
					responseCount = appliedCandidates.size();
					candidatePosition = studentJobsManager.getCandidateAppliedPosition(appliedCandidates.keySet(),emailId);
			}
			
			if(candidatePosition != -1 ) {
				modelAndView.addObject("candidatePosition",++candidatePosition);
			}
			
			modelAndView.addObject("responseCount",responseCount);
			
			studentJobsManager.updateViewedJobs(emailId,jobId);
			employerJobPostManager.updateJobViewCount(jobId);
			
			/** Retrieving Job Details based on Job Id */
			job = employerJobPostManager.getJobDetailsByJobIdAndFirmId(jobId);

			String companyId = employerJobPostManager.getFirmIdByJobIdAndFirmId(jobId);
			
			if(companyId!=null && !companyId.isEmpty())
			{
				//Fetching the company name using the logged in user's email id
				String corporateName = loginManagement.getEntityNameByEmailId(companyId);
				
				// Retrieving the company details from the database 
				companyDetails = employerManager.getEmployerDetails(corporateName);
			}
			
			// Candidate Browse jobs section
			Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
			resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, emailId);
			modelAndView.addObject("resultCountMap", resultCountMap);
						
			/** For Marking Saved Recommended Jobs with Saved Flag */
			/*Map<String,Date> savedJobIdsMap = studentJobsManager.getSavedJobIdsMap(emailId);
			modelAndView.addObject("savedJobIdsMap",savedJobIdsMap);*/
			
			/** For Marking Applied Jobs  */
			/*appliedJobIdsMap = studentJobsManager.getAppliedJobIdsMap(emailId);
			modelAndView.addObject("appliedJobIdsMap",appliedJobIdsMap);*/

		
			modelAndView.addObject("job", job);
			modelAndView.addObject("companyID", companyId);
		
			modelAndView.addObject("companyDetails", companyDetails);
		

			}

		/** Related Jobs to the One the User Clicked to view the details of */
		
		String jobSkills = "";
		StringBuilder jobSkillsSB = new StringBuilder();
		
		if(! job.getPrimarySkills().isEmpty())
		{
			for (String primarySkill : job.getPrimarySkills()) {
				jobSkillsSB = jobSkillsSB.append(" ").append(primarySkill);
			}
		}

		if(! job.getSecondarySkills().isEmpty())
		{
			for (String secondarySkill : job.getSecondarySkills()) {
				jobSkillsSB = jobSkillsSB.append(" ").append(secondarySkill);
			}
		}
		
		if(jobSkillsSB.length() > 0)
			jobSkills = jobSkillsSB.toString();
		
		File INDEX_LOCATION = new File(CaerusPathConstants.jobIndexes);
		
		Set<String> relatedJobIds = new HashSet<String>();
		
		try {
			/** Fecthing Job Ids of Related Jobs in terms of primary and secondary skills of the current job. */
			relatedJobIds = SimpleDBSearcher.fetchRelatedJobs(jobSkills, INDEX_LOCATION);
			
			if(relatedJobIds != null && relatedJobIds.size() > 0)
				relatedJobIds.remove(jobId);
		} catch (ParseException e) {
			logger.error(e.getLocalizedMessage());
		}
		catch (IOException e) {
			logger.error(e.getLocalizedMessage());
		}
		catch(Exception e)
		{
			logger.error(e.getLocalizedMessage());
		}
		
		/** Removing Applied Jobs from Related Jobs */
		if(null != relatedJobIds && !relatedJobIds.isEmpty())
		{
			relatedJobIds.removeAll(new ArrayList<String>(appliedJobIdsMap.keySet()));
			relatedJobIds = ImmutableSet.copyOf(Iterables.limit(relatedJobIds, 6));
		}
		
		String relatedJobIdsString = CaerusCommonUtility.getCassandraInQueryString(new ArrayList<String>(relatedJobIds));
		List<JobDetailsDom> relatedJobs = new ArrayList<JobDetailsDom>();
		
		/** Fecthing Job Details of all the Related Job Ids */
		if(!relatedJobIds.isEmpty())
			relatedJobs = employerJobPostManager.getJobsForJobIds(relatedJobIdsString);
		
		List<String> companyNames = new ArrayList<String>();
		
		for (JobDetailsDom jobDetailsDom : relatedJobs) {
			companyNames.add(jobDetailsDom.getCompanyName());
		}
		
		if(companyNames.contains(""))
			companyNames.removeAll(Collections.singleton(""));
		
		Map<String,String> photoNameMap = employerManager.getCompanyPhotoName(companyNames);
		if(null != photoNameMap)
			modelAndView.addObject("photoNameMap", photoNameMap);
		
			int relatedJobCount = 0;
			if(! relatedJobs.isEmpty())
				relatedJobCount = relatedJobs.size();
				
			modelAndView.addObject("relatedJobCount",relatedJobCount);
			modelAndView.addObject("relatedJobs",relatedJobs);
			
		/** Related Jobs to the One the User has wished to view the details of */
		
		/**
		 * Sharing the job with a friend based on his/her Email Id
		 */
		String friendEmailId = request.getParameter("friendEmailId");

		if (friendEmailId != null && jobId != null) {
			String ID = job.getJobId();
			/**
			 * Creating the Email Template
			 * @author PallaviD
			 * 
			 * 
			 */

			
			logger.info(emailId +CaerusLoggerConstants.SHARED_JOB+" with Job ID "+jobId + " With "+ friendEmailId);
			StringBuffer html = new StringBuffer();

			html.append("<!DOCTYPE html>");
			html.append("<html lang='en'>");
			html.append("<head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><title>Candidate View Particular Job</title>"
					+ "<meta name='description' content=''><meta name='author' content=''></head>");
			html.append("<body>");
		
			html.append("<table width='980px' border='0' cellspacing='0' cellpadding='0' style='margin:0 auto; font-family:Tahoma, Geneva, sans-serif; font-size:12px;' align='center'>");
			
			html.append("<tr>");
			html.append("<td style='padding:15px; background:#f55b5b; color:#fff;text-transform:uppercase; text-align:center; font-size:26px;'>Imploy.Me </td>");
			html.append("</tr>");
			
			html.append("<tr>");
			html.append("<td>");
			html.append("<span id= 'JobTitle' style='color: #F55B5B;font-size: 26px;margin-bottom: 0.5em;padding: 0;font-weight: normal;'></span>");
			html.append("<span id='jobID' style='color: #999898;font-size: 11px;font-weight: bold;padding: 0.50em 1em;margin: 0;'></span>");
			html.append("</td>");
			html.append("</tr>");
			html.append("<tr><td style='height:20px;'>&nbsp;</td></tr>");
			html.append("<tr>");
			html.append("<td style='color: #828282;font-size: 12px;display: inline;float: left;padding: 0 5px;margin-top: 4px;'><span id='companyName' style='font-size: 18px;color: #5E5F5E;padding-right: 0.6em;margin: 0;'></span>");
			html.append("<span id='location'></span>");
			html.append("<span> | </span>");
			html.append("<span id='experience'></span>");
			html.append("<span> yrs | </span>");
			html.append("<span id='jobType'></span>");
			html.append("</tr>");
			html.append("<tr>");
			html.append("<td style='color: #828282;font-size: 12px;display: inline;float: left;padding: 0 5px;margin-top: 8px;'>");
			html.append("<strong>Industry:</strong> ");
			html.append("<span id='indstry'></span>");
			html.append("<span> | </span>");
			html.append("<strong>Functional Area:</strong> ");
			html.append("<span id='func'></span>");
			html.append("<span> | </span>");
			html.append("<strong>Posted on:</strong> ");
			html.append("<span id='postedon'></span>");
			html.append("</td>");
			html.append("</tr>");
			html.append("<tr><td style='height:20px;'>&nbsp;</td></tr>");
			html.append("<tr><td style='border-top: #DFDEDE dashed 1px;border-bottom: #DFDEDE dashed 1px;padding: 0.70em 0 0.70em 0;'>");
			html.append("<table width='100%' border='0' cellspacing='0' cellpadding='0'>");
			//html.append("</table>");
			html.append("<tr><td style='height:20px;'>&nbsp;</td></tr>");
			html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>Job Description</td></tr>");
			html.append("<tr><td id='jobDescription' style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");
			html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>Primary Skills</td></tr>");
			html.append("<tr><td id='primarySkills' style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");
			html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>Secondary Skills</td></tr>");
			html.append("<tr><td id='secondarySkills' style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");
			html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>Salary Per Week ($)</td></tr>");
			html.append("<tr><td id='salary'style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");
			//html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>Eligible Streams</td></tr>");
			html.append("<tr><td id='streams' style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");
			/*html.append("<tr><td style='font-size: 12px;font-weight: bold;color: #0B99B3; padding-top:1em;'>GPA Cut Off</td></tr>");
			html.append("<tr><td id='gpaCuttOff'style='color: #828282;line-height: 20px;text-align: justify;padding: 0;'></td></tr>");*/
			html.append("<tr><td style='padding-top:1em; text-align:center;'>");
			html.append("<a href='http://www.google.com' target='_blank'><input type='button' value='Apply' style='height: 34px;padding: 0.25em 2.3em !important; margin-right: 0.5em;cursor: pointer;color: #000;overflow: visible;font-size: 14px;text-align: center;background: #8AECFD;-moz-border-radius: 2px;-webkit-border-radius: 2px;border-radius: 2px; border:none; border-bottom: 1px solid #242424;'/></a>");
			html.append("</td></tr>");
			html.append("</td></tr>");
			html.append("</table>");
			html.append("</table>");
			html.append("</body>");
			html.append("</html>");


			Document doc = null;
			try {
				doc = Jsoup.parse(html.toString());
			} catch (Exception e) {

				e.printStackTrace();
			}

			doc.getElementById("JobTitle").text(job.getJobTitle());
			doc.getElementById("companyName").text(job.getCompanyName());
			doc.getElementById("location").text(job.getLocation());
			doc.getElementById("experience").text(
					job.getExperienceFrom() + " to " + job.getExperienceTo());
			doc.getElementById("jobType").text(job.getJobType());
			doc.getElementById("indstry").text(job.getIndustry());
			doc.getElementById("func").text(job.getFunctionalArea());
			doc.getElementById("postedon").text(job.getPostedOn());
			doc.getElementById("jobDescription").text(job.getJobDescription());
			doc.getElementById("primarySkills").text(
					setStringListForHTML(job.getPrimarySkills()));
			doc.getElementById("secondarySkills").text(
					setStringListForHTML(job.getSecondarySkills()));
			doc.getElementById("salary").text(job.getPayPerWeek());
			/*doc.getElementById("streams").text(setStringListForHTML(job.getEligibleStreams()));
			doc.getElementById("gpaCuttOff").text(job.getGpaCutOffFrom() + " to " + job.getGpaCutOffTo());*/
			doc.getElementById("jobID").text(ID);

			String subject = session.getAttribute("username")
					+ " Has Recommended a Job For You!!";
			
			/**
			 * Sending mail to the mentioned email Id
			 */
			/*MailUtil.sendMailToUsers(friendEmailId, doc.toString(), subject); */
			mailUtil.sendMailToUsers(friendEmailId, doc.toString(), subject);
			
			logger.info(CaerusLoggerConstants.MAIL_SENT);
		}
		return modelAndView;
	}

	
	/**
	 * @return to set list data fields in html mail
	 */
	public static String setStringListForHTML(List<String> receivedStringList)
			throws IOException {
		String stringToBeSet = "";
		int i = 0;
		List<String> stringList = receivedStringList;

		if (null!= stringList && stringList.size() != 0) {

			Iterator<String> psi = stringList.iterator();
			while (psi.hasNext()) {
				i++;
				if (i != stringList.size())
					stringToBeSet = stringToBeSet.concat(psi.next() + ",  ");
				else
					stringToBeSet = stringToBeSet.concat(psi.next());
			}
		}
		return stringToBeSet;

	}

	/**
	 * This method is used to Retrieve Internships
	 * @throws ParseException 
	 */
	@RequestMapping (value= CaerusAnnotationURLConstants.CANDIDATE_PREVIEW_INTERNSHIP)
	public ModelAndView prviewInternshipDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
		
		logger.info(CaerusLoggerConstants.VIEW_INTERNSHIP_DETAILS);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String emailId = auth.getName();
		EmployerDom companyDetails = new EmployerDom();

		//The modelAndView object contains the model(companyDetails,Job) and the view(candidate_view_internship)
		ModelAndView modelAndView = new ModelAndView(
				"candidate/candidate_preview_listed_internship");
		String internshipId = request.getParameter("internshipId");
		
		//Retrieving Internship Details
		JobDetailsDom internship = employerJobPostManager.getInternshipDetailsByInternshipIdAndFirmId(internshipId);
		String companyId = internship.getEmailId();
		
		/** Retrieving the Current Session */
		HttpSession session = request.getSession(true);
		
		Map<String,String> sessionMap = (Map<String,String>) session.getAttribute("sessionMap");
		
		if(null != sessionMap)
		{
			if(sessionMap.containsKey("keyword"))
				modelAndView.addObject("keyword", sessionMap.get("keyword"));
			if(sessionMap.containsKey("location"))
				modelAndView.addObject("location",  sessionMap.get("location"));
			if(sessionMap.containsKey("industry"))
				modelAndView.addObject("industry",  sessionMap.get("industry"));
			if(sessionMap.containsKey("functionalArea"))
				modelAndView.addObject("functionalArea",  sessionMap.get("functionalArea"));
			if(sessionMap.containsKey("jobType"))
				modelAndView.addObject("jobType",  sessionMap.get("jobType"));
		}
		
		if(companyId!=null && !companyId.isEmpty())
		{
			//Fetching the company name using the logged in user's email id
			String corporateName = loginManagement.getEntityNameByEmailId(companyId);
			
			// Retrieving the company details from the database 
			companyDetails = employerManager.getEmployerDetails(corporateName);
		}
		
		studentJobsManager.updateViewedInternships(emailId,internshipId);
		employerJobPostManager.updateInternshipViewCount(internshipId);
		
		/** For Marking Saved Recommended Jobs with Saved Flag */
		/*Map<String,Date> savedInternshipIdsMap = studentJobsManager.getSavedInternshipIdsMap(emailId);
		modelAndView.addObject("savedInternshipIdsMap",savedInternshipIdsMap);*/
		
		/** For Marking Applied Jobs  */
		/*Map<String,Date> appliedInternshipIdsMap = studentJobsManager.getAppliedInternshipIdsMap(emailId);
		modelAndView.addObject("appliedInternshipIdsMap",appliedInternshipIdsMap);*/
		
		// Candidate Browse jobs section
		Map<String,Map<String,Integer>> resultCountMap = new HashMap<String,Map<String,Integer>>();
		resultCountMap = CandidateCommonBrowseJobs.getBrowseJobsSection(studentJobsManager, emailId);
		modelAndView.addObject("resultCountMap", resultCountMap);
		
		session.setAttribute("companyID",companyId);
		
		modelAndView.addObject("internship", internship);
		modelAndView.addObject("companyDetails", companyDetails);
		
		
		if(request.getParameter("source")!= null)
			modelAndView.addObject("source",String.valueOf(request.getParameter("source")));
		
		return modelAndView;
	}

}