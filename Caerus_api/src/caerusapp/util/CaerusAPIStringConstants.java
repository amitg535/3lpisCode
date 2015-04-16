package caerusapp.util;

public class CaerusAPIStringConstants {

	public static final String DEFAULT_FORMULA_NAME = "Default Formula";
	public static final String DEFAULT_CANDIDATE_PROFILE_NAME = "Default";
	public static final String DEFAULT_EMPLOYER_AUTHORITY = "ROLE_CORPORATE";
	public static final String DEFAULT_UNIVERSITY_AUTHORITY = "ROLE_UNIVERSITY";
	public static final String DEFAULT_STUDENT_AUTHORITY = "ROLE_STUDENT";
	
	public static final String ADMIN_EMAIL_ID = "admin@caerus.com";
	
	public static final String JOB_STATUS_PUBLISHED = "Published";
	public static final String JOB_STATUS_DRAFT = "Draft";
	public static final String JOB_STATUS_CLOSED = "Closed";
	public static final String JOB_STATUS_APPLIED = "Applied";
	
	public static final String CANDIDATE_SHORTLISTED_STATUS = "Shortlisted";
	public static final String CANDIDATE_ONHOLD_STATUS = "OnHold";
	public static final String CANDIDATE_REJECTED_STATUS = "Rejected";
	public static final String CANDIDATE_APPLY_STATUS = "Applied";
	public static final String CANDIDATE_WORK_MAP_COMPANY_NAME = "workCompanyName";
	public static final String CANDIDATE_WORK_MAP_WORK_DESCRIPTION = "workDescription";
	public static final String CANDIDATE_WORK_MAP_WORK_YEAR_FROM = "workYearFrom";
	public static final String CANDIDATE_WORK_MAP_WORK_YEAR_TO = "workYearTo";
	public static final String CANDIDATE_WORK_MAP_WORK_MONTH_FROM = "workMonthFrom" ;
	public static final String CANDIDATE_WORK_MAP_WORK_MONTH_TO = "workMonthTo";
	public static final String CANDIDATE_WORK_MAP_WORK_DESIGNATION = "workDesignation" ;
	
	public static final String DB_DATE_FORMAT = "E MMM dd HH:mm:ss Z yyyy";
	public static final String DISPLAY_DATE_FORMAT = "dd MMM yyyy";
	public static final String EVENT_DATE_FORMAT = "E MMM dd HH:mm:ss Z yyyy";
	
	public static final String COMPARATOR_JOB_DETAILS_DOM = "JobDetailsDom";

	public static final String JOB_FLAG = "jobs";
	public static final String INTERNSHIP_FLAG = "internships";
	public static final String CAMPUS_JOB_FLAG = "campus jobs";
	public static final String CAMPUS_INTERNSHIP_FLAG = "campus internships";
	public static final String INTERNAL_POSTINGS_FLAG = "internal postings";

	public static final String EMPLOYER_EVENT_STATUS_PENDING = "Pending";
	public static final String EMPLOYER_EVENT_STATUS_ACCEPTED = "Accepted";
	public static final String EMPLOYER_EVENT_STATUS_PUBLISHED = "Published";
	public static final String EMPLOYER_ACTIVITY_VIEWED_PROFILE = "viewed profile";
	public static final String EMPLOYER_ACTIVITY_DOWNLOADED_RESUME = "downloaded resume";
	
	public static final String INVITATION_STATUS_ACCEPTED = "Accepted";
	public static final String INVITATION_STATUS_SCHEDULED = "Scheduled";
	public static final String INVITATION_STATUS_PENDING = "Pending";
	
	public static final String ERROR_MESSAGE = "Something Went Wrong in ";
	
	
	/** Candidate Activities Table and Fields */
	public static final String TABLE_CANDIDATE_ACTIVITIES = "candidate_activities";
	public static final String IS_SAVED_FLAG = "is_saved";
	public static final String CANDIDATE_EMAIL_ID = "email_id";
	public static final String IS_APPLIED_FLAG = "is_applied";
	public static final String IS_VIEWED_FLAG = "is_viewed";
	public static final String JOB_TYPE_IDENTIFIER = "job_type_identifier";
	public static final String JOB_ID_AND_FIRM_ID = "job_id_and_firm_id";
	public static final String SAVED_ON = "saved_on";
	public static final String COMPANY_NAME = "company_name";
	public static final String JOB_DESCRIPTION = "job_description";
	public static final String JOB_LOCATION = "location";
	public static final String JOB_TITLE = "job_title";
	public static final String JOB_TYPE = "job_type";
	public static final String PRIMARY_SKILLS = "primary_skills";
	public static final String SECONDARY_SKILLS = "secondary_skills";
	public static final String JOB_POSTED_ON = "job_posted_on";
	public static final String APPLIED_ON = "applied_on";

	public static final String TABLE_JOB_DTLS = "job_dtls";
	public static final String FIRM_NAME = "firm_name";
	public static final String STATUS = "status";

	public static final String CANDIDATE_SAVED_JOB_LOGGER = "Saved Job ";
	public static final String CANDIDATE_APPLIED_JOB_LOGGER = "Applied To Job";
	public static final String JOB_STATUS = "job_status";
	public static final String ASYNC_UPDATE_CANDIDATE_ACTIVITIES = "Updating Candidate Activities in ASYNC Manner";
	public static final String TABLE_UNIVERSITY_INTERNSHIP_DTLS = "university_internship_dtls";
	public static final String APPLIED_STUDENTS = "applied_students";
	public static final String CANDIDATE_INTERNSHIP_STATUS = "candidate_internship_status";
	public static final String INTERNSHIP_ID_AND_FIRM_ID = "internship_id_and_firm_id";
	public static final String UNIVERSITY_NAME = "univ_name";
	public static final String APPLIED_CANDIDATES_STATUS = "candidate_internship_status";
	public static final String APPLIED_CANDIDATES = "applied_students";
	
	public static final String TABLE_INVITED_COMPANY_DETAILS = "invited_company_details";
	public static final String INVITATION_STATUS = "invitation_status";
	
	
	/** Candidate Activities Table and Fields */
	
	public static final String DEFAULT_RECOMMENDER_AUTHORITY = "ROLE_RECOMMENDER";
}
