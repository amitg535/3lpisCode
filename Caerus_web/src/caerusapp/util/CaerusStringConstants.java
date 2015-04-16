/**
 * 
 */
package caerusapp.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Contains all the String Constants.
 * @author balajii
 *
 */
public class CaerusStringConstants
{
	public static final String DEFAULT_FORMULA_NAME = "Default Formula";
	
	public static final String ADMIN_EMAIL_ID = "admin@caerus.com";
	
	public static final String DEFAULT_CANDIDATE_PROFILE_NAME = "Default";
	
	public static final String DEFAULT_EMPLOYER_AUTHORITY = "ROLE_CORPORATE";
	
	public static final String DEFAULT_UNIVERSITY_AUTHORITY = "ROLE_UNIVERSITY";
	
	public static final String DEFAULT_STUDENT_AUTHORITY = "ROLE_STUDENT";
	
	public static final String JOB_STATUS_PUBLISHED = "Published";
	public static final String JOB_STATUS_DRAFT = "Draft";
	public static final String JOB_STATUS_CLOSED = "Closed";
	
	public static final String CANDIDATE_SHORTLISTED_STATUS = "Shortlisted";
	public static final String CANDIDATE_ONHOLD_STATUS = "OnHold";
	public static final String CANDIDATE_REJECTED_STATUS = "Rejected";
	
	
	public static final String COMPARATOR_JOB_DETAILS_DOM = "JobDetailsDom";

	public static final String CANDIDATE_APPLIED_JOBS_SECTION = "applied_jobs";
	public static final String CANDIDATE_APPLIED_INTERNSHIPS_SECTION = "applied_internships";
	public static final String CANDIDATE_SAVED_JOBS_SECTION = "saved_jobs";
	public static final String CANDIDATE_SAVED_INTERNSHIPS_SECTION = "saved_internships";
	public static final String CANDIDATE_RECOMMENDED_JOBS_SECTION = "recommended_jobs";

	public static final String RECOMMENDED_JOBS = "recommendedJobs"; //SimpleDBSearcher
	public static final String JOBS = "jobs"; //SimpleDBSearcher
	public static final String INTERNSHIPS = "internships"; //SimpleDBSearcher

	public static final String PHONE_NUMBER_REGEX = "^(([(]?(\\d{2,4})[)]?)|(\\d{2,4})|([+1-9]+\\d{1,2}))?[-\\s]?(\\d{2,3})?[-\\s]?((\\d{7,8})|(\\d{3,4}[-\\s]\\d{3,4}))$";
	
	public static final String dbDateFormat = "E MMM dd HH:mm:ss Z yyyy";
	public static final String DISPLAY_DATE_FORMAT = "dd MMM YYYY";

	public static final String CANDIDATE_WORK_MAP_COMPANY_NAME = "workCompanyName";
	public static final String CANDIDATE_WORK_MAP_WORK_DESCRIPTION = "workDescription";
	public static final String CANDIDATE_WORK_MAP_WORK_YEAR_FROM = "workYearFrom";
	public static final String CANDIDATE_WORK_MAP_WORK_YEAR_TO = "workYearTo";
	public static final String CANDIDATE_WORK_MAP_WORK_MONTH_FROM = "workMonthFrom" ;
	public static final String CANDIDATE_WORK_MAP_WORK_MONTH_TO = "workMonthTo";
	public static final String CANDIDATE_WORK_MAP_WORK_DESIGNATION = "workDesignation" ;
	
	
	public static final String FUNCTIONAL_AREA = "functionalArea" ;
	public static final String JOB_TYPE = "jobType" ;
	public static final String LOCATION = "location" ;
	public static final String INDUSTRY = "industry" ;
	
	
	public static final String STANDARD_DATE_FORMAT = "E dd MMM yyyy HH:mm" ;
	public static final String STANDARD_JOB_DATE_FORMAT = "dd MMM yyyy" ;
	public static final String DB_DATE_FORMAT = "E MMM dd HH:mm:ss Z yyyy";

	public static final String NO_JOBS_POSTED_YET = "You've Not Posted Jobs Yet.Analytics Would be Available only after Posting Jobs.";

	public static final String FORWARD_TO_SAJU = "sajuv@quinnox.com";
	public static final String FORWARD_TO_NEIL = "neilkumar@outlook.com";

	public static final String CONFIG_FILE = "config.properties";

	public static final List<String> INTERNSHIP_TYPES = new ArrayList<String>(){{
			add("Paid"); 
			add("Un-Paid");
			add("Co-Op");
			add("Summer");
			add("Externship");
		}};

	public static final String CLASS_EMPLOYER_CAMPUS_JOB_POST_DOM = "EmployerCampusJobPostDom";

	public static final String CLASS_JOB_DETAILS_DOM = "JobDetailsDom";

	public static final String NO_RECOMMENDED_JOBS = "";

	public static final String DATE_FORMAT_EXCEPTION = "Date Parse Exception";

	public static final String NO_JOBS = "No Jobs have been posted yet";
	
	public static final String DEFAULT_CANDIDATE_RECOMMENDATION_STATUS = "Sent";
	
	public static final String CANDIDATE_RECOMMENDATION_STATUS = "Received";
	
	public static final String DEFAULT_RECOMMENDER_STATUS = "Pending";
	
	public static final String RECOMMENDER_STATUS = "Completed";
	
	public static Map<String,Integer> getEmployerAnalyticsDropdown() {
		return new HashMap<String,Integer>(){{
				put("This Week",7);
				put("Last 2 Weeks",14);
				put("Last Month",30);
				put("Last 2 Months",60);
			}};
			
	}
	
	public static final String DEFAULT_RECOMMENDER_AUTHORITY = "ROLE_RECOMMENDER";
	
	@SuppressWarnings("serial")
	public static List<String> getYearsStudentKnownDropdown() {
		return new ArrayList<String>(){{
			add("0 to 1 Years");
		    add("1 to 2 Years");
			add("2 to 3 Years");
			add("More than 3 Years");
		}};
		
	}
	
	public static final String DEFAULT_PHOTO_NAME = "Default Photo";
	
}
