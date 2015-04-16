package caerusapp.web.employer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import caerusapp.command.common.JobDetailsCom;
import caerusapp.domain.common.JobDetailsDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.employer.EmployerDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.service.common.ILoginManagement;
import caerusapp.service.common.IMasterManager;
import caerusapp.service.employer.EmployerJobPostManager;
import caerusapp.service.employer.EmployerJobValidator;
import caerusapp.service.employer.IEmployerManager;
import caerusapp.util.CaerusAnnotationURLConstants;
import caerusapp.util.CaerusCommonUtil;
import caerusapp.util.CaerusJSPMapper;
import caerusapp.util.CaerusLoggerConstants;
import caerusapp.util.CaerusStringConstants;

@Controller
public class EmployerJobActivitiesController {

	@Autowired
	public EmployerJobActivitiesController(
			EmployerJobValidator employerJobValidator) {
		this.employerJobValidator = employerJobValidator;
	}

	private EmployerJobValidator employerJobValidator;

	@Autowired
	IMasterManager masterManager;

	@Autowired
	IEmployerManager employerManager;

	@Autowired
	EmployerJobPostManager employerJobPostManager;

	@Autowired
	ILoginManagement loginManagement;

	protected final Log logger = LogFactory.getLog(getClass());

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_POST_JOB, method = RequestMethod.GET)
	public String postJob(HttpServletRequest request, Model model) {

		// Using an existing session
		HttpSession session = request.getSession();

		// Getting the job details from the existing session
		JobDetailsCom jobDetailsCom = new JobDetailsCom();
		jobDetailsCom.setCompanyName(request.getSession()
				.getAttribute("compName").toString());

		if (jobDetailsCom.getCompanyName() != null) {
			LoginManagementDom userDetails = loginManagement
					.getAdminByEntityName(jobDetailsCom.getCompanyName().trim());
			jobDetailsCom.setEmailId(userDetails.getUserName().trim());
		}

		String editMode = request.getParameter("editMode");

		if (editMode != null) {
			jobDetailsCom = (JobDetailsCom) session.getAttribute("postSession");
		}

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}

		List<String> functionalAreaList = masterManager.getFunctionalAreas();
		Collections.sort(functionalAreaList);

		// Fetching the industry list from the master table
		List<String> industryList = masterManager.getIndustries();
		Collections.sort(industryList);

		List<String> jobTypes = new ArrayList<String>();
		jobTypes.add("Full Time");
		jobTypes.add("Part Time");

		model.addAttribute("primarySkills", jobTypes);
		model.addAttribute("secondarySkills", jobTypes);

		model.addAttribute("jobTypes", jobTypes);
		model.addAttribute("functionalAreaList", functionalAreaList);
		model.addAttribute("industryList", industryList);

		model.addAttribute("postJob", jobDetailsCom);

		logger.info(CaerusLoggerConstants.EMPLOYER_POST_JOB);
		return CaerusJSPMapper.EMPLOYER_POST_JOB;
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_JOB)
	protected ModelAndView previewJob(
			@ModelAttribute("postJob") JobDetailsCom jobDetailsCom,
			BindingResult bindingResult, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		HttpSession httpSession = request.getSession();

		// The modelandview object contains the model(data) and the
		// view(employer_preview_of_job.jsp)
		ModelAndView modelAndView = new ModelAndView(
				CaerusJSPMapper.EMPLOYER_JOB_PREVIEW);

		String jobId = jobDetailsCom.getJobId();

		employerJobValidator.validate(jobDetailsCom, bindingResult);

		if (bindingResult.hasErrors()) {
			List<String> functionalAreaList = masterManager
					.getFunctionalAreas();
			Collections.sort(functionalAreaList);

			// Fetching the industry list from the master table
			List<String> industryList = masterManager.getIndustries();
			Collections.sort(industryList);

			List<String> jobTypes = new ArrayList<String>();
			jobTypes.add("Full Time");
			jobTypes.add("Part Time");

			model.addAttribute("jobTypes", jobTypes);
			model.addAttribute("functionalAreaList", functionalAreaList);
			model.addAttribute("industryList", industryList);

			model.addAttribute("postJob", jobDetailsCom);

			return new ModelAndView(CaerusJSPMapper.EMPLOYER_POST_JOB);
		}

		try {
			// Checking if the job with id:jobId exists
			int count = employerJobPostManager.getJobIdCount(jobId);

			if (count == 0) {
				// Using an existing session
				httpSession.setAttribute("postSession", jobDetailsCom);

				logger.info(CaerusLoggerConstants.PREVIEW_JOB);

				String jobDescription = Jsoup.parse(
						jobDetailsCom.getJobDescription()).text();

				jobDetailsCom.setPostedOn(new Date().toString());

				if (jobDetailsCom.getPrimarySkills() != null
						&& jobDetailsCom.getPrimarySkills().size() > 0) {
					jobDetailsCom.setPrimarySkills(CaerusCommonUtil
							.removeExtraneousBracketsFromList(jobDetailsCom
									.getPrimarySkills()));
				}
				if (jobDetailsCom.getSecondarySkills() != null
						&& jobDetailsCom.getSecondarySkills().size() > 0) {
					jobDetailsCom.setSecondarySkills(CaerusCommonUtil
							.removeExtraneousBracketsFromList(jobDetailsCom
									.getSecondarySkills()));
				}

				// Fetching the employer details
				LoginManagementDom adminDetails = loginManagement
						.getUserDetailsByEmailID(SecurityContextHolder
								.getContext().getAuthentication().getName());
				jobDetailsCom.setEmailId(adminDetails.getUserName());
				jobDetailsCom.setCompanyName(request.getSession()
						.getAttribute("compName").toString());

				modelAndView.addObject("jobDetails", jobDetailsCom);
				modelAndView.addObject("jobDescription", jobDescription);
				model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
				
				return modelAndView;
			} else {
				throw new CaerusCommonException("Job Id is already registered");
			}
		} catch (CaerusCommonException e) {
			jobDetailsCom.setExceptionMessage(e.getLocalizedMessage());
			jobDetailsCom.setExceptionOccured(true);
			logger.info("Exception String:"
					+ jobDetailsCom.getExceptionMessage().toString());

			List<String> functionalAreaList = masterManager
					.getFunctionalAreas();
			Collections.sort(functionalAreaList);

			// Fetching the industry list from the master table
			List<String> industryList = masterManager.getIndustries();
			Collections.sort(industryList);

			List<String> jobTypes = new ArrayList<String>();
			jobTypes.add("Full Time");
			jobTypes.add("Part Time");

			model.addAttribute("jobTypes", jobTypes);
			model.addAttribute("functionalAreaList", functionalAreaList);
			model.addAttribute("industryList", industryList);
			model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
			
			// Redirecting to the error page with the model(data)
			return new ModelAndView(CaerusJSPMapper.EMPLOYER_POST_JOB,
					"postJob", jobDetailsCom);
		}
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_SAVE_JOB)
	public ModelAndView saveJob(@RequestParam("action") String action,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info(CaerusLoggerConstants.EMPLOYER_SAVE_JOB);

		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String emailID = auth.getName();

		// Using an existing session
		HttpSession session = request.getSession();
		String corporateName = (String) session.getAttribute("compName");
		JobDetailsDom jobDetailsDom = new JobDetailsDom();

		// Initialising fields related to pop up message
		Boolean jobPostCheckFlag = false;
		String successMessage = "";

		// Job details are fetched from the session
		JobDetailsCom jobDetailsCom = (JobDetailsCom) session
				.getAttribute("postSession");

		String jobId = jobDetailsCom.getJobId();

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}

		BeanUtils.copyProperties(jobDetailsCom, jobDetailsDom);

		jobDetailsDom.setEmailId(emailID);

		// Added to show Save Job only on Preview
		if (null != action) {
			// Exception Handling
			try {
				// Checking the status of the job and updating the job

				if (action.equalsIgnoreCase("publish")) {
					employerJobPostManager.publishJob(jobDetailsDom);
					successMessage = "You have succesfully posted a Job at Imploy.Me";
					jobPostCheckFlag = true;

				}

				if (action.equalsIgnoreCase("save")) {
					int count = employerJobPostManager.getJobIdCount(jobId);

					try {
						if (count == 0) {
							employerJobPostManager.saveJob(jobDetailsDom);
							successMessage = "You have succesfully saved a Job at Imploy.Me";
							jobPostCheckFlag = true;
						} else {
							// If the job id already exists in the database
							throw new CaerusCommonException(
									"Job Id is already registered");
						}
					} catch (CaerusCommonException e) {
						jobDetailsCom.setExceptionMessage(e
								.getLocalizedMessage());
						jobDetailsCom.setExceptionOccured(true);
						logger.info("Exception String:"
								+ jobDetailsCom.getExceptionMessage()
										.toString());
						// Redirecting to the success page with the model data
						return new ModelAndView(
								CaerusJSPMapper.EMPLOYER_POST_JOB, "postJob",
								jobDetailsCom);
					}
				}
			}

			catch (CaerusCommonException e) {

				logger.info("Exception Occured " + e.getStackTrace());
			}

		}

		return new ModelAndView(new RedirectView(
				CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS));
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_LISTED_JOB)
	ModelAndView getJobPreview(@RequestParam("jobId") String jobId,
			HttpServletRequest request) {
		logger.info(CaerusLoggerConstants.VIEW_JOB_DETAILS);

		// Spring security authentication containing the logged in user details
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String emailId = auth.getName();

		// The modelandview object contains the model(data) and the
		// view(employer_preview_listed_job.jsp)
		ModelAndView modelAndView = new ModelAndView(
				"employer/employer_preview_listed_job");

		// Fetching the job details
		JobDetailsDom jobDetailsDom = employerJobPostManager
				.getJobDetailsByJobIdAndFirmId(jobId);
		jobDetailsDom.setEmailId(emailId);
		jobDetailsDom.setJobIdAndFirmId(jobId);
		JobDetailsCom jobDetailsCom = new JobDetailsCom();
		String jobDescription = Jsoup.parse(jobDetailsDom.getJobDescription())
				.text();

		BeanUtils.copyProperties(jobDetailsDom, jobDetailsCom);

		EmployerDom companyDetails = employerManager.getEmployerDetails(request
				.getSession().getAttribute("compName").toString());
		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}


		Long jobViewedCount = loginManagement.getJobViewedCount(jobDetailsCom.getJobIdAndFirmId());
		jobDetailsCom.setJobViewedCount(jobViewedCount);
		
		modelAndView.addObject("companyDetails", companyDetails);
		modelAndView.addObject("postJob", jobDetailsCom);
		modelAndView.addObject("jobDetails", jobDetailsCom);
		modelAndView.addObject("jobDescription", jobDescription);
		modelAndView.addObject("jobStatus", jobDetailsCom.getStatus());
		modelAndView.addObject("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);

		return modelAndView;

	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_EDIT_POSTED_JOB)
	String editPostedJob(
			@RequestParam(value = "jobIdAndFirmId", required = false) String jobIdAndFirmId,
			@RequestParam(value = "action", required = false) String action,
			@ModelAttribute("postJob") JobDetailsCom jobDetailsCom, Model model) {
		if (jobIdAndFirmId != null && jobIdAndFirmId.length() > 0
				&& null != action && action.length() > 0
				&& action.equalsIgnoreCase("edit")) {
			JobDetailsDom jobDetailsDom = employerJobPostManager
					.getJobDetailsByJobIdAndFirmId(jobIdAndFirmId);
			BeanUtils.copyProperties(jobDetailsDom, jobDetailsCom);
		}
		String statusDisp = jobDetailsCom.getStatus();

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}
		
		List<String> functionalAreaList = masterManager.getFunctionalAreas();
		Collections.sort(functionalAreaList);

		// Fetching the industry list from the master table
		List<String> industryList = masterManager.getIndustries();
		Collections.sort(industryList);

		List<String> jobTypes = new ArrayList<String>();
		jobTypes.add("Full Time");
		jobTypes.add("Part Time");

		model.addAttribute("postJob", jobDetailsCom);
		model.addAttribute("statusDisp", statusDisp);
		model.addAttribute("jobTypes", jobTypes);
		model.addAttribute("functionalAreaList", functionalAreaList);
		model.addAttribute("industryList", industryList);

		return "employer/employer_edit_posted_job";
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_PREVIEW_EDIT_POSTED_JOB)
	String getPostedJobPreview(
			@ModelAttribute("postJob") JobDetailsCom jobDetailsCom,
			Model model, HttpServletRequest request) {
		jobDetailsCom.setEmailId(SecurityContextHolder.getContext()
				.getAuthentication().getName());
		jobDetailsCom.setCompanyName(request.getSession().getAttribute("compName").toString());
		
		
		String jobDescription = "";
		if (null != jobDetailsCom.getJobDescription()
				&& jobDetailsCom.getJobDescription().length() > 0)
			jobDescription = Jsoup.parse(jobDetailsCom.getJobDescription())
					.text();

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}
		
		Long jobViewedCount = loginManagement.getJobViewedCount(jobDetailsCom.getJobIdAndFirmId());
		jobDetailsCom.setJobViewedCount(jobViewedCount);
		
		EmployerDom companyDetails = employerManager.getEmployerDetails(request
				.getSession().getAttribute("compName").toString());
		model.addAttribute("companyDetails", companyDetails);
		model.addAttribute("jobDetails", jobDetailsCom);
		model.addAttribute("jobDescription", jobDescription);
		model.addAttribute("postJob", jobDetailsCom);
		model.addAttribute("jobDateFormat",CaerusStringConstants.STANDARD_JOB_DATE_FORMAT);
		
		return "employer/employer_preview_listed_job";
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_UPDATE_POSTED_JOB)
	ModelAndView updatePostedJobStatus(
			@RequestParam(value = "action", required = false) String action,
			@ModelAttribute("postJob") JobDetailsCom jobDetailsCom,HttpServletRequest request) {
		JobDetailsDom jobDetailsDom = new JobDetailsDom();
		jobDetailsCom.setEmailId(SecurityContextHolder.getContext()
				.getAuthentication().getName());

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}

		jobDetailsCom.setCompanyName(request.getSession().getAttribute("compName").toString());
		BeanUtils.copyProperties(jobDetailsCom, jobDetailsDom);

		jobDetailsDom.setJobUpdateFlag(true);

		if (action != null && action.equals("save")) {
			employerJobPostManager.saveJob(jobDetailsDom);
		}
		if (action != null && action.equals("publish")) {
			employerJobPostManager.publishJob(jobDetailsDom);
		}
		return new ModelAndView(new RedirectView(
				CaerusAnnotationURLConstants.EMPLOYER_JOBS_INTERNSHIPS));
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_COPY_JOB)
	String employerCopyJob(@RequestParam("jobId") String jobId, Model model) {
		JobDetailsDom jobDetailsDom = employerJobPostManager.getJobDetailsByJobIdAndFirmId(jobId);

		if (jobDetailsDom != null) {
			jobDetailsDom.setJobTitle("");
			jobDetailsDom.setJobId("");
		}

		jobDetailsDom.setPostedOn(new Date().toString());
		JobDetailsCom jobDetailsCom = new JobDetailsCom();

		BeanUtils.copyProperties(jobDetailsDom, jobDetailsCom);

		if (jobDetailsCom.getPrimarySkills() != null
				&& jobDetailsCom.getPrimarySkills().size() > 0) {
			jobDetailsCom.setPrimarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getPrimarySkills()));
		}
		if (jobDetailsCom.getSecondarySkills() != null
				&& jobDetailsCom.getSecondarySkills().size() > 0) {
			jobDetailsCom.setSecondarySkills(CaerusCommonUtil
					.removeExtraneousBracketsFromList(jobDetailsCom
							.getSecondarySkills()));
		}

		model.addAttribute("postJob", jobDetailsCom);
		model.addAttribute("jobDetails", jobDetailsCom);

		List<String> functionalAreaList = masterManager.getFunctionalAreas();
		Collections.sort(functionalAreaList);

		// Fetching the industry list from the master table
		List<String> industryList = masterManager.getIndustries();
		Collections.sort(industryList);

		List<String> jobTypes = new ArrayList<String>();
		jobTypes.add("Full Time");
		jobTypes.add("Part Time");

		model.addAttribute("jobTypes", jobTypes);
		model.addAttribute("functionalAreaList", functionalAreaList);
		model.addAttribute("industryList", industryList);
		model.addAttribute("copyJob", true);
		model.addAttribute("statusDisp", jobDetailsCom.getStatus());

		logger.info(CaerusLoggerConstants.EMPLOYER_COPY_JOB);
		return CaerusJSPMapper.EMPLOYER_POST_JOB;
	}

	@RequestMapping(value = CaerusAnnotationURLConstants.EMPLOYER_DELETE_JOB)
	public String deleteJob(@RequestParam("jobId") String jobId,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// Deleting existing job
		employerJobPostManager.deletePostedJob(jobId);

		return CaerusJSPMapper.REDIRECT_SUCCESS_JOBS_INTERNSHIPS;

	}
}
