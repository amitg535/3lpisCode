/**
 * 
 */
package caerusapp.util;


/**
 * Contains all the Annotation Mapping URLs with their respective Controller Name.
 * @author TrishnaR
 *
 */
public class CaerusAnnotationURLConstants 
{
	/** JSON Mapping Starts */
	
	public static final String CANDIDATE_VIEWED_BY_COMPANIES = "/candidate_viewed_by_companies.json"; //CandidateViewedByCompaniesController
	public static final String CANDIDATE_WIZARD_INTERESTS = "/candidate_wizard_interests.json"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_ADD_LANGUAGES = "/candidate_wizard_add_languages.json"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_REMOVE_LANGUAGES = "/candidate_wizard_remove_languages.json"; //CandidateWizardController
	public static final String CANDIDATE_PORTFOLIO_WORK = "/candidate_portfolio_Work.json"; //CandidatePortfolioController
	public static final String CANDIDATE_PUBLICATION_DETAILS = "/candidate_publication_details.json"; //CandidatePortfolioController
	public static final String CANDIDATE_CERTIFICATION_DETAILS = "/candidate_certification_details.json"; //CandidatePortfolioController
	public static final String CANDIDATE_APPLY_JOB = "/candidate_apply_job.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_APPLY_SAVED_JOB = "/candidate_apply_saved_job.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_SAVE_JOB = "/candidate_save_job.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_PORTFOLIO_SCHOOL = "/candidate_portfolio_School.json"; //CandidatePortfolioController
	public static final String CANDIDATE_PORTFOLIO_UNIVERSITY = "/candidate_portfolio_University.json"; //CandidatePortfolioController
	public static final String CANDIDATE_IMPORT_DATA = "/candidate_import_data.json"; //CandidateImportDataController
	public static final String CANDIDATE_APPLY_MAIL_SETTINGS = "/candidate_apply_mail_settings.json"; //CandidateMailSettingsController
	public static final String CANDIDATE_APPLY_FILTER_ON_RECENT_JOBS = "/candidate_apply_filter_on_jobs.json"; //CandidateBasicSearchController
	public static final String CANDIDATE_SUGGEST_SKILLS_JSON = "suggest_skills.json"; //CandidatePortfolioController
	
	public static final String EMPLOYER_EMAIL_CANDIDATE_PROFILE = "/employer_email_candidate_profile.json";//EmployerDownloadAndMailCandidateProfileController
	public static final String EMPLOYER_ANALYTICS_JSON = "employer_analytics.json"; //EmployerAnalyticsController
	public static final String EMPLOYER_REPORTS_JSON = "employer_reports.json"; //EmployerAnalyticsController
	public static final String EMPLOYER_GENERATE_SCORE = "/employer_generate_score.json"; //EmployerViewJobResponsesController
	
	public static final String UNIVERSITY_BROADCAST_JOB = "/university_broadcast_job.json"; //UniversityDashboardController
	public static final String UNIVERSITY_BROADCAST_INTERNSHIP = "/university_broadcast_internship.json"; //UniversityDashboardController
	
	public static final String GET_USERNAME = "/get_username.json"; //SetUsernameController
	public static final String GET_EMPLOYER_KEYWORD_SUGGESTIONS = "/get_employer_keywords_suggestions.json"; //EmployerSearchCandidateController
	public static final String EMPLOYER_CLOSE_CAMPUS_INTERNSHIP = "/employer_close_campus_internship.json"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_EXTEND_CAMPUS_INTERNSHIP_ENDDATE = "/employer_extend_campus_internship_endDate.json"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_CLOSE_INTERNSHIP = "employer_close_internship.json"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_EXTEND_INTERNSHIP_ENDDATE = "employer_extend_internship_endDate.json"; //EmployerInternshipActivitiesController
	public static final String USER_FORGOT_PASSWORD = "user_forgot_password.json"; //UserForgotPasswordFormController
	public static final String EMPLOYER_IMPORT_PROFILE_FROM_LINKEDIN = "/employer_import_profile.json"; //EmployerImportProfileFromLinkedInController
	
	/** JSON Mapping Ends */
	
	
	/** HTM Mapping Starts */
	

	public static final String HOME_PAGE = "/home.htm"; //HomeController
	public static final String LOGIN_PAGE = "/login.htm"; //HomeController
	public static final String WELCOME_PAGE = "/welcome.htm"; //LoginController
	public static final String CANDIDATE_VIEWED_BY_COMPANIES_THIN_CLIENT = "/candidate_viewed_by_companies_thin_client.htm"; //CandidateViewedByCompaniesController
	public static final String CANDIDATE_DASHBOARD_SKILLS_UPDATE = "/candidate_dashboard_skills_update.htm";//CandidateDashboardController
	
	public static final String EMPLOYER_DOWNLOAD_CANDIDATE_PROFILE = "/employer_download_candidate_profile.htm";//EmployerDownloadAndMailCandidateProfileController
	public static final String EMPLOYER_SEARCH_LISTING = "/employer_candidate_listing.htm"; //EmployerCandidateSearchListing
	public static final String EMPLOYER_SORTED_SEARCH_LISTING = "/employer_sorted_candidate_listing.json"; //EmployerCandidateSearchListing
	public static final String EMPLOYER_SAVE_CANDIDATE = "/employer_save_candidate.htm"; //EmployerSaveCandidate
	public static final String EMPLOYER_POST_CAMPUS_JOB = "employer_post_campus_job.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_UPDATE_CAMPUS_JOB_STATUS = "employer_update_campus_job_status.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_PREVIEW_POSTED_CAMPUS_JOB = "employer_preview_posted_campus_job.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_EDIT_POSTED_CAMPUS_JOB = "employer_edit_posted_campus_job.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_DELETE_CAMPUS_JOB = "employer_delete_campus_job.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_COPY_CAMPUS_JOB = "employer_copy_campus_job.htm"; //EmployerCampusJobActivitiesController
	public static final String EMPLOYER_POST_CAMPUS_INTERNSHIP = "employer_post_campus_internship.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_UPDATE_CAMPUS_INTERNSHIP_STATUS = "employer_update_campus_internship_status.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_PREVIEW_POSTED_CAMPUS_INTERNSHIP = "employer_preview_posted_campus_internship.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_DELETE_CAMPUS_INTERNSHIP = "employer_delete_campus_internship.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_COPY_CAMPUS_INTERNSHIP = "employer_copy_campus_internship.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_EDIT_POSTED_CAMPUS_INTERNSHIP = "employer_edit_posted_campus_internship.htm"; //EmployerCampusInternshipActivitiesController
	public static final String EMPLOYER_MANAGE_PROFILE = "employer_manage_profile.htm"; //EmployerManageProfileController
	public static final String EMPLOYER_SCHEDULE_EVENT = "employer_schedule_event.htm"; //EmployerEventActivitiesController
	public static final String EMPLOYER_PROFILE_PREVIEW = "profile_preview.htm"; //EmployerProfileController
	public static final String EMPLOYER_EVENT_PREVIEW = "employer_event_preview.htm"; //EmployerEventActivitiesController
	public static final String EMPLOYER_UPDATE_EVENT = "employer_update_event.htm"; //EmployerEventActivitiesController
	public static final String EMPLOYER_UPDATE_INVITATION_STATUS = "employer_update_invitation_status.htm"; //EmployerCampusConnectController
	public static final String EMPLOYER_DASHBOARD = "/employer_dashboard.htm"; //EmployerDashboardController
	public static final String EMPLOYER_VIEW_INTERNSHIP_RESPONSES = "/employer_view_internship_responses.htm"; //EmployerViewInternshipResponsesController
	public static final String EMPLOYER_MANAGE_CAMPUS_JOB_RESPONSES =  "/employer_manage_campus_job_responses.htm"; //EmployerViewCampusJobResponsesController
	public static final String EMPLOYER_VIEW_INTERNSHIP_JOB_RESPONSES ="/employer_view_campus_internship_responses.htm"; //EmployerViewCampusInternshipResponsesController
	public static final String EMPLOYER_MANAGE_CAMPUS_INTERNSHIP_RESPONSES= "/employer_manage_campus_internship_responses.htm"; //EmployerViewCampusInternshipResponsesController
	//public static final String EMPLOYER_FILE_FROM_REPOSITORY= "/download_file_from_repo.htm"; //EmployerDownloadFileFromRepoController
	public static final String EMPLOYER_SAVED_SEARCH_CANDIDATES="/employer_saved_search_candidates.htm";//EmployerSearchCandidateController
	public static final String EMPLOYER_SAVED_CANDIDATES="/employer_saved_candidates.htm"; //EmployerSavedCandidatesController
	public static final String EMPLOYER_VIEW_EVENT = "/employer_view_event.htm";//EmployerViewEventController
	public static final String EMPLOYER_GET_CANDIDATE_LIST_FOR_EVENT = "/employer_get_candidate_list_for_event.htm";//EmployerViewEventController
	public static final String EMPLOYER_MANAGE_RECEIVED_INVITATIONS = "/employer_manage_receivedinvitations.htm"; //EmployerManageInvitationsController
	public static final String EMPLOYER_GET_CITY = "/get_city_name.htm"; //EmployerCommonUtilController
	public static final String EMPLOYER_VIEW_JOB_RESPONSES = "/employer_view_job_responses.htm"; //EmployerViewJobResponsesController
	public static final String EMPLOYER_ADD_USER = "employer_add_user.htm"; //EmployerAddUserController
	public static final String EMPLOYER_USER_DETAILS = "employer_user_details.htm"; //EmployerAddUserController
	public static final String EMPLOYER_DELETE_USER = "employer_delete_user.htm"; //EmployerAddUserController
	public static final String EMPLOYER_SAVE_JOB = "employer_save_job.htm";  //EmployerJobActivitiesController
	public static final String EMPLOYER_PREVIEW_LISTED_JOB = "employer_preview_listed_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_EDIT_POSTED_JOB = "employer_edit_posted_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_PREVIEW_EDIT_POSTED_JOB = "employer_preview_edit_posted_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_PREVIEW_EDIT_JOB = "/employer_Preview_edit.htm"; //EmployerPreviewEditController
	public static final String EMPLOYER_PREVIEW_JOB = "/employer_preview_of_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_POST_JOB = "employer_post_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_UPDATE_POSTED_JOB = "employer_update_posted_job_status.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_COPY_JOB = "employer_copy_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_DELETE_JOB = "employer_delete_existing_job.htm"; //EmployerJobActivitiesController
	public static final String EMPLOYER_POST_INTERNSHIP = "employer_post_internship.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_UPDATE_INTERNSHIP_STATUS = "employer_update_internship_status.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_COPY_INTERNSHIP = "employer_copy_internship.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_EDIT_POSTED_INTERNSHIP = "employer_edit_internship.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_PREVIEW_LISTED_INTERNSHIP = "employer_preview_listed_internship.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_DELETE_INTERNSHIP = "employer_delete_internship.htm"; //EmployerInternshipActivitiesController
	public static final String EMPLOYER_SHORTLIST_CANDIDATE = "employer_shortlist_candidate.htm"; //EmployerViewJobResponsesController
	public static final String EMPLOYER_PUT_CANDIDATE_ONHOLD = "employer_put_candidate_onhold.htm"; //EmployerViewJobResponsesController
	public static final String EMPLOYER_REJECT_CANDIDATE = "employer_reject_candidate.htm"; //EmployerViewJobResponsesController
	public static final String EMPLOYER_PREVIEW_EDITED_INTERSHIP = "/employer_preview_edit_save_data.htm"; //EmployerPreviewEditSaveController
	public static final String EMPLOYER_PREVIEW_INTERNSHIP = "/employer_InternshipPreviewSave_data.htm"; //EmployerInternshipPreviewSaveDataController
	public static final String EMPLOYER_JOBS_AND_INTERNSHIPS_LISTING = "/employer_jobsinternships_listing.htm"; //EmployerJobsinternshipsListing
	public static final String EMPLOYER_MANAGE_EVENTS = "/employer_manage_scheduledevents.htm"; // EmployerManageEventController
	public static final String EMPLOYER_VIEW_CANDIDATE_DETAILS = "/employer_view_candidate_details.htm"; //EmployerViewCandidateDetailsController
	public static final String EMPLOYER_SEARCH_CANDIDATE = "employer_search_candidate.htm"; //EmployerSearchCandidateController
	public static final String EMPLOYER_MANAGE_PROFILE_IMAGE = "employer_manage_profile_image.htm"; //EmployerManageProfileImageController
	public static final String EMPLOYER_VIEW_BROCHURE = "view_brochure.htm"; //EmployerManageProfilePreviewController
	public static final String EMPLOYER_JOBS_INTERNSHIPS = "employer_jobs_internships.htm"; //EmployerJobsInternshipsController
	public static final String EMPLOYER_CAMPUS_CONNECT = "employer_campus_connect.htm"; //EmployerCampusConnectController
	public static final String EMPLOYER_CALCULATE_SCORE = "/employer_calculate_score_listing.htm"; //EmployerCalculateScoreController
	public static final String EMPLOYER_GET_SUGGESTED_WORDS = "/get_suggested_keywords.json"; //EmployerCommonUtilController
	public static final String EMPLOYER_GENERATE_SCORE_FROM_SEARCH_LISTING = "/generate_score_from_search_listing.htm"; //EmployerCalculateScoreController
	public static final String EMPLOYER_SAVED_SEARCHES = "/employer_saved_searches.htm"; //EmployerSavedSearchesController
	public static final String EMPLOYER_DELETE_SAVED_SEARCH = "/employer_delete_saved_search.htm"; //EmployerSavedSearchesController
	public static final String EMPLOYER_SAVE_SEARCH = "/employer_save_search_parameter.htm"; // EmployerSearchCandidateController
	public static final String EMPLOYER_QUERYBUILDER = "employer_querybuilder_add_formula.htm"; //EmployerQueryBuilderController
	public static final String EMPLOYER_QUERYBUILDER_DELETE_FORMULA = "employer_querybuilder_delete_formula.htm"; //EmployerQueryBuilderController
	public static final String EMPLOYER_QUERYBUILDER_EDIT_FORMULA = "employer_querybuilder_edit_formula.htm"; //EmployerQueryBuilderController
	public static final String EMPLOYER_FILE_REPOSITORY = "employer_files_repository.htm"; //EmployerFilesRepositoryController
	public static final String EMPLOYER_DELETE_FILE_FROM_REPO = "employer_delete_file.htm"; //EmployerFilesRepositoryController
	public static final String EMPLOYER_DOWNLOAD_REPORT = "/employer_download_report.htm"; //EmployerGenerateReportController
	public static final String EMPLOYER_GENERATE_REPORT = "/employer_generate_report.htm"; //EmployerGenerateReportController
	public static final String EMPLOYER_REGISTRATION = "/employer_registration.htm"; //EmployerRegistrationController
	public static final String EMPLOYER_ENABLE_USER = "employer_enable_user.htm"; //EmployerAddUserController
	public static final String EMPLOYER_VIRTUAL_FAIR_INVITATIONS = "employer_virtualfair_invitations.htm"; //EmployerVirtualFairInvitationsController
	public static final String EMPLOYER_DOWNLOAD_REPOSITORY_FILE = "download_file_from_repo.htm"; //EmployerDownloadRepositoryFileController
	public static final String EMPLOYER_ANALYTICS = "employer_analytics.htm"; //EmployerAnalyticsController
	public static final String EMPLOYER_UPLOAD_FILE = "employer_upload_file.htm";
	
	public static final String CANDIDATE_SAVED_JOBS = "/candidate_saved_jobs.htm"; //CandidateSavedJobsController
	public static final String CANDIDATE_PREVIEW_BROADCASTED_CORPORATE_INVITES = "/candidate_broadcasted_corporate_invites.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String CANDIDATE_PREVIEW_BROADCASTED_CORPORATE_INVITE_DETAILS = "/candidate_preview_received_corporate_invite.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String CANDIDATE_VIEW_EMPLOYER_IMAGE = "/view_employer_image.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String CANDIDATE_PORTFOLIO = "/candidate_portfolio.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_PORTFOLIO_INTRODUCTORY = "candidate_portfolio_introductory.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_PORTFOLIO_EDUCATION = "/candidate_portfolio_Education.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_PORTFOLIO_PROFILE = "/candidate_portfolio_profile.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_UPLOAD_RESUME = "/candidate_upload_resume.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_UPLOAD_VIDEO = "/candidate_upload_video.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_UPLOAD_PHOTO = "/candidate_upload_photo.htm"; //CandidatePortfolioController
	public static final String CAPTURE_IMAGE = "/capture_image.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_PHOTO = "/candidate_view_profile_photo.htm"; //CandidatePortfolioController
	public static final String CANDIDATE_WIZARD = "/candidate_wizard.htm"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_INTRODUCTORY = "/candidate_wizard_introductory.htm"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_SKILLS = "/candidate_wizard_skills.htm"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_WORK = "/candidate_wizard_work.htm"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_EDUCATION = "/candidate_wizard_total_education.htm"; //CandidateWizardController
	public static final String CANDIDATE_WIZARD_GRADUATE = "/candidate_wizard_graduate.htm"; //CandidateWizardController
	public static final String CANDIDATE_JOB_ACTIVITIES = "/candidate_job_activities.htm"; //CandidateJobActivitiesController
	public static final String CANDIDATE_SETTINGS = "/candidate_settings.htm"; //CandidateMailSettingsController
	public static final String CANDIDATE_APPLY_PROFILE_VISIBILITY = "/candidate_apply_profile_visibility.json"; //CandidateMailSettingsController
	public static final String CANDIDATE_REGISTRATION = "/candidate_registration.htm"; // CandidateRegistrationController
	public static final String CANDIDATE_DETAIL_VIEW = "/detail_view_candidate.htm"; //CandidateDetailViewController
	public static final String CANDIDATE_APPLY_SAVED_INTERNSHIP = "/candidate_apply_saved_internship.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_SAVE_INTERNSHIP = "/candidate_save_internship.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_APPLY_INTERNSHIP = "/candidate_apply_internship.json"; //CandidateJobActivitiesController
	public static final String CANDIDATE_PREVIEW_JOB_FAIR="/candidate_setup_preview.htm"; //SetupPreviewController
	public static final String CANDIDATE_MANAGE_VIRTUAL_FAIR= "/candidate_manage_virtualfair_invitation.htm"; //CandidateManageVirtualFairInvitationsController
	public static final String CANDIDATE_RESPONSE_TO_CORPORATE_INVITE = "/candidate_response_to_corporate_invite.htm";//CandidateBroadcastedCorporateInvitesController
	public static final String CANDIDATE_VIEW_VIRTUAL_FAIRS= "/candidate_view_virtualfairs.htm"; //CandidateViewVirtualJobFairsController
	public static final String CANDIDATE_MANAGE_PROFILES = "/candidate_manage_profile.htm"; //CandidateManageProfilesController
	public static final String CANDIDATE_SET_DEFAULT_PROFILE = "/candidate_set_default_profile.htm"; //CandidateManageProfilesController
	public static final String CANDIDATE_SEARCH_JOBS_LISTING = "/candidate_job_listing.htm"; //CandidateSearchJobsListingController
	public static final String CANDIDATE_ADVANCED_SEARCH_CONTROLLER = "/candidate_advancesearch.htm"; //CandidateSearchJobsFormController
	public static final String CANDIDATE_BROADCASTED_JOBS="candidate_broadcasted_jobs.htm"; //CandidateBroadcastedJobController
	public static final String  CANDIDATE_APPLY_BROADCASTED_JOBS="candidate_apply_broadcasted_job.htm"; //CandidateBroadcastedJobController
	public static final String CANDIDATE_BROADCASTED_INTERNSHIPS="candidate_broadcasted_internships.htm"; //CandidateBroadcastedInternshipController
	public static final String CANDIDATE_APPLY_BROADCASTED_INTERNSHIPS="candidate_apply_broadcasted_internship.htm"; //CandidateBroadcastedInternshipController
	public static final String CANDIDATE_DASHBOARD = "/candidate_dashboard.htm"; //CandidateDashboardController
	public static final String CANDIDATE_MAIL_SETTINGS = "/candidate_mail_settings.htm"; //CandidateMailSettingsController
	public static final String CANDIDATE_DETAIL_VIEW_QRCODE = "/candidate_detail_view_qrCode.htm"; //CandidateDetailViewQRController
	public static final String CANDIDATE_IMAGE = "/candidate_view_profile_photoQR.htm";  //CandidateDetailViewQRController
	public static final String CANDIDATE_DOWNLOAD_RESUME = "/candidate_resume_download.htm"; //CandidateResumeDownloadController
	public static final String CANDIDATE_RESUME_BUILDER = "/candidate_resume_builder.htm"; //CandidateResumeBuilderController
	public static final String CANDIDATE_GET_MAIL_SETTINGS = "/candidate_get_mail_settings.htm"; //CandidateMailSettingsController
	public static final String CANDIDATE_SAVED_SEARCHES = "/candidate_saved_search.htm"; // CandidateSearchJobActivitiesController
	public static final String CANDIDATE_APPLIED_JOBS = "/candidate_applied_jobs.htm"; //CandidateAppliedJobsController
	public static final String CANDIDATE_DOWNLOAD_CV = "/download_cv.htm"; // CandidateDownloadCVController
	public static final String CANDIDATE_RECOMMENDED_JOBS = "candidate_recommended_jobs.htm"; //CandidateRecommendedJobsController
	public static final String CANDIDATE_SEARCH_JOBS_INTERNSHIPS = "candidate_search_jobs_internships.htm"; //CandidateSearchJobActivitiesController
	public static final String CANDIDATE_DELETE_SAVED_SEARCHES= "candidate_delete_saved_searches.htm"; // CandidateSearchJobActivitiesController
	public static final String CANDIDATE_PREVIEW_JOB = "candidate_preview_listed_job.htm"; //CandidatePreviewJobController
	public static final String CANDIDATE_PREVIEW_INTERNSHIP = "candidate_preview_listed_internship.htm"; //CandidatePreviewJobController
	public static final String CANDIDATE_QRCODE = "student_qrcode.htm"; //CandidateQRController
	public static final String CANDIDATE_MARK_DEFAULT_PROFILE = "candidate_set_default_profile.htm"; //CandidateManageProfilesController
	public static final String CANDIDATE_EDIT_PROFILE = "candidate_edit_profile.htm"; //CandidateManageProfilesController
	public static final String CANDIDATE_CREATE_PROFILE = "candidate_create_profile.htm"; //CandidateManageProfilesController
	public static final String CANDIDATE_DELETE_PROFILE = "candidate_delete_profile.htm"; //CandidateManageProfilesController 
	public static final String CANDIDATE_INTERNAL_POSTINGS = "candidate_internal_postings.htm"; //CandidateInternalPostings
	public static final String CANDIDATE_APPLY_INTERNAL_POSTING = "candidate_apply_internal_posting.htm"; //CandidateInternalPostings
	public static final String CANDIDATE_VIEW_CAREER_PATH = "candidate_careerpath.htm"; //CandidateCareerPathController
	
	public static final String UNIVERSITY_ADD_USER = "/university_add_user.htm"; // UniversityAddUserController
	public static final String UNIVERSITY_UPDATE_USER = "/university_update_user.htm"; // UniversityAddUserController
	public static final String UNIVERSITYS_REGISTRATION = "/university_registration.htm"; // UniversityRegistrationController
	public static final String UNIVERSITY_MANAGE_SCHEDULED_EVENTS = "/university_manage_scheduledevents.htm"; //UniversityManageEventController
	public static final String  UNIVERSITY_EVENT_DELETE = "/university_event_delete.htm"; //UniversityEventDeleteController
	public static final String UNIVERSITY_MANAGE_CONNECTIONS = "/university_manage_connections.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_UPLOAD_FILE = "/university_upload_file.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_DOWNLOAD_TEMPLATE = "/download_template.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_DELETE_STUDENTS = "/university_delete_students.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_ADD_CONNECTIONS = "/university_add_connections.htm"; //UniversityManageConnectionsController
	//public static final String UNIVERSITY_VIEW_CANDIDATE_IMAGE = "/view_image.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_VIEW_CANDIDATE_DETAILS = "/university_view_candidate_details.htm"; //UniversityManageConnectionsController
	public static final String UNIVERSITY_BROADCAST_CORPORATE_INVITES = "/university_broadcast_corporate_invites.htm"; //UniversityBroadcastCorporateInvitesController
	public static final String VIEW_CAMPUS_JOB_RESPONSES = "/view_campus_job_responses.htm"; //ViewResponsesController
	public static final String VIEW_CAMPUS_INTERNSHIP_RESPONSES = "/view_campus_internship_responses.htm"; //ViewResponsesController
	//public static final String UNIVERSITY_PROFILE_VIEW = "/university_profile_view.htm"; //UniversityProfilePreviewController
	public static final String UNIVERSITY_EDIT_PROFILE = "university_profile.htm"; //UniversityProfileController
	public static final String UNIVERSITY_SCHEDULE_EVENT = "university_schedule_anevent.htm" ; //UniversityEventFormController
	public static final String UNIVERSITY_MANAGE_CORPORATE_INVITATIONS = "university_manage_received_invitations.htm"; //UniversityManageInvitationsController
	public static final String UNIVERSITY_UPDATE_CORPORATE_INVITATION_STATUS = "university_update_corporate_invitation_status.htm"; //UniversityManageInvitationsController
	public static final String UNIVERSITY_PREVIEW_CORPORATE_INVITATION = "university_preview_corporate_invitation.htm"; //UniversityManageInvitationsController
	public static final String UNIVERSITY_REGISTRATION = "/university_registration.htm"; // UniversityRegistrationFormController
	public static final String UNIVERSITY_DASHBOARD = "/university_dashboard.htm"; //UniversityDashboardController
	public static final String UNIVERSITY_SAVE_EVENT_TEMPLATE = "/university_save_event_template.htm"; //UniversityEventTemplateController
	public static final String UNIVERSITY_CAMPUS_JOBS_INTERNSHIPS = "university_campus_jobs_internships.htm"; //UniversityCampusJobsInternshipsController
	public static final String UNIVERSITY_INTERNAL_POSTINGS = "university_internal_postings.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_POST_INTERNSHIP = "university_post_internship.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_PREVIEW_INTERNAL_INTERNSHIP = "internal_internship_preview.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_DELETE_INTERNAL_INTERNSHIP = "university_delete_internal_internship.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_COPY_INTERNAL_INTERNSHIP = "university_copy_internal_internship.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_EDIT_INTERNAL_INTERNSHIP = "university_edit_internal_internship.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_VIEW_INTERNAL_POSTING_RESPONSES = "view_internal_posting_responses.htm"; //UniversityInternalPostingsController
	public static final String UNIVERSITY_UPDATE_CANDIDATE_STATUS = "university_update_candidate_status.htm"; //UniversityInternalPostingsController

	public static final String VIEW_VIDEO = "/view_video.htm"; //ViewVideoController
	public static final String VIEW_RECOMMENDED_CANDIDATES_PROFILES = "/employer_view_recommended_candidate_profiles.htm"; //EmployerViewRecommendedCandidateProfilesController
	public static final String USER_BROWSING_PATTERNS = "/user_browsing_patterns.htm"; //UserBrowsingPatternsController
	public static final String UPDATE_CANDIDATE_ACTION_ON_CORPORATE_EVENT = "/update_candidate_action_on_corporate_event.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String UPDATE_CANDIDATE_ACTION_ON_UNIVERSITY_EVENT = "/update_candidate_action_on_university_event.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String UNDO_ACTION_ON_CORPORATE_EVENT = "/undo_candidate_action_on_corporate_event.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String UNDO_ACTION_ON_UNIVERSITY_EVENT = "/undo_candidate_action_on_university_event.htm"; //CandidateBroadcastedCorporateInvitesController
	public static final String CAMPUS_JOB_PREVIEW = "/campus_job_preview.htm"; //CampusJobPreviewController
	public static final String CAMPUS_INTERNSHIP_PREVIEW = "/campus_internship_preview.htm"; //CampusInternshipPreviewController
	public static final String VIEW_IMAGE = "/view_image.htm"; //ViewImageController
	public static final String USER_CHANGE_PASSWORD = "/user_change_password.htm"; //UserChangePasswordController
	public static final String PREVIEW_BROADCASTED_INTERNSHIP = "/candidate_preview_university_broadcasted_internship.htm"; //CandidatePreviewBroadcastedInternshipController
	public static final String PREVIEW_BROADCASTED_JOB = "/candidate_preview_university_broadcasted_job.htm"; //CandidatePreviewBroadcastedJobController	
	public static final String SEARCH_JOBS_BY_PARAMETERS="/searchJobsByParameters.htm";//CandidateHomeSearchJobsByParametersController
	public static final String GET_JOB_LISTING="/getJobListing.htm";//CandidateHomeSearchJobsByParametersController
	public static final String VIEW_COMPANY_PROFILE="/view_company_profile.htm";//ViewCompanyProfileController
	public static final String VIEW_COMPANY_LOGO="/view_company_logo.htm";//ViewCompanyLogoController
	public static final String VIEW_CANDIDATE_PHOTO = "/view_candidate_photo.htm"; //ViewCandidatePhotoController
	//public static final String VIEW_UNIVERSITY_LOGO = "/view_university_logo.htm"; //UniversityProfilePreviewController
	public static final String SEND_MESSAGE = "/send_message.htm"; // CommonUtilController
	public static final String MESSAGE_INBOX = "/message_inbox.htm"; // CommonUtilController
	public static final String DELETE_MESSAGE = "/delete_message.htm"; // CommonUtilController
	public static final String READ_MESSAGE = "/read_message.htm"; // CommonUtilController
	public static final String VIEW_UNIVERSITY_PROFILE="/view_university_profile.htm" ;//ViewUniversityProfileController
	public static final String VIEW_REG_UNIVERSITY_LOGO="/view_reg_university_logo.htm" ;//ViewUniversityProfileController
	public static final String VIEW_EMPLOYER_VIDEO = "/view_employer_video.htm"; //ViewEmployerVideo
	public static final String PREVIEW_UNIVERSITY_EVENT = "/preview_university_event.htm"; //PreviewUniversityEventController
	public static final String SEARCH_COMPANIES_FOR_UNIVERSITY_EVENT = "search_companies_for_universityJobFair.htm";
	public static final String CANDIDATE_BASIC_SEARCH = "candidate_basic_search.htm"; //CandidateBasicSearchController
	public static final String CANDIDATE_ALL_RECENT_JOBS = "candidate_all_recent_jobs.htm"; //CandidateBasicSearchController
	
	
	
	public static final String ADMIN_VIEW_CAREER_PATH ="/admin_view_careerpaths.htm"; //AdminViewCareerPathController
	public static final String ADMIN_ADD_CAREER_LEVEL_FORM ="/admin_add_careerpathlevel_form.htm"; //AdminViewCareerPathController
	public static final String ADMIN_ADD_CAREER_LEVEL ="/admin_add_careerpathlevel.htm"; //AdminViewCareerPathController
	public static final String ADMIN_GETPARENTS_FOR_FUNCTIONAL_AREA ="/admin_getParents_for_functional_area.json"; //AdminViewCareerPathController
	public static final String ADMIN_ENABLE_USERS = "/admin_enable_users.htm"; //AdminActionsController
	public static final String ADMIN_DISABLE_USERS = "/admin_disable_users.htm"; //AdminActionsController
	public static final String ADMIN_MANAGE_USERS = "/admin_manage_users.htm"; //AdminActionsController
	public static final String ADMIN_GET_JSON_FOR_TREE ="/admin_get_json_for_tree.htm"; //AdminViewCareerPathController
	public static final String ADMIN_VERIFICATIONS ="/admin_verification.htm"; //AdminActionsController
	public static final String ADMIN_VERIFY_USER_PHOTO ="/admin_verify_user_photo.htm"; //AdminActionsController
	public static final String ADMIN_VERIFY_USER_VIDEO ="/admin_verify_user_video.htm"; //AdminActionsController
	public static final String ADMIN_MANAGE_DATABASE = "admin_manage_database.htm"; //AdminActionsController
	
	public static final String UNIVERSITY_EDIT_CAMPUSFAIR="university_edit_campusfair.htm"; //UniversityEditCampusFairController
	public static final String UNIVERSITY_EDIT_RECRUITMENT="university_edit_recruitment.htm"; //UniversityEditRecruitmentController
	public static final String UNIVERSITY_EDIT_SEMINAR= "university_edit_seminar.htm"; //UniversityEditSeminarController
	

	public static final String EMPLOYER_SHORTLIST_CANDIDATE_CAMPUS = "employer_shortlist_candidate_campus.htm"; //ViewResponsesController
	public static final String EMPLOYER_PUT_CANDIDATE_ONHOLD_CAMPUS = "employer_put_candidate_onhold_campus.htm"; //ViewResponsesController
	public static final String EMPLOYER_REJECT_CANDIDATE_CAMPUS = "employer_reject_candidate_campus.htm"; //ViewResponsesController
	public static final String REGISTER_BETA_USER = "/beta_registration.htm"; //HomeController
	
	//Beta Users Urls
	public static final String ADMIN_MANAGE_BETA_USERS = "/admin_manage_beta_users.htm"; //AdminActionsController
 	public static final String ADMIN_CONFIRM_BETA_USERS = "/admin_confirm_beta_user.htm"; //AdminActionsController
 	public static final String ADMIN_DELETE_BETA_USERS = "/admin_delete_beta_user.htm"; //AdminActionsController
 	public static final String ADMIN_UNDO_DELETE_ACTION = "/admin_undo_delete_action.htm"; //AdminActionsController
 	public static final String ADMIN_MASTERS = "admin_manage_masters.htm"; //AdminManageMastersController
	public static final String ADMIN_GET_SELECTED_MASTER = "admin_get_selected_master.htm"; //AdminManageMastersController
	public static final String ADMIN_ADD_MASTER = "admin_add_master.htm"; //AdminManageMastersController
	public static final String ADMIN_DELETE_MASTER = "admin_delete_result.htm"; //AdminManageMastersController
	public static final String ADMIN_EDIT_MASTER = "admin_edit_result.htm"; //AdminManageMastersController
	public static final String ADMIN_UPLOAD_MASTERS_FILE = "admin_upload_masters_file.htm"; //AdminManageMastersController
	public static final String ADMIN_RESENDMAIL_BETA_USERS = "/admin_resendmail_beta_user.htm"; //AdminActionsController

	public static final String PREVIEW_JOB = "preview_job.htm"; //JobPreviewContoller
	public static final String ALL_JOBS_BY_EMPLOYER = "all_jobs_by_employer.htm"; //EmployerJobsController
	
	public static final String CANDIDATE_RECOMMENDATION = "candidate_recommendation.htm"; //CandidateRecommendationController
	public static final String RECOMMNDER_VIEW_REQUESTS = "recommender_view_requests.htm"; //RecommenderActionsController
	public static final String RECOMMENDER_SUBMIT_RECOMMENDATION = "recommender_submit_recomendation.htm"; //RecommenderActionsController
	
}
