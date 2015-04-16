package caerusapp.dao.student;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cassandra.core.RowMapper;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.employer.EmployerQueryBuilderDom;
import caerusapp.domain.student.PortfolioDetailsDom;
import caerusapp.domain.student.StudentDom;
import caerusapp.domain.student.StudentRecommendationDom;
import caerusapp.exceptions.CaerusCommonException;
import caerusapp.exceptions.DoesNotExistException;
import caerusapp.util.CaerusAPIStringConstants;
import caerusapp.util.CaerusCommonUtility;

import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.exceptions.DriverException;
import com.datastax.driver.core.exceptions.NoHostAvailableException;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Update;

/**
 * @author KShailesh
 * 
 */
public class StudentDao implements IStudentDao {

	
	/** Logger for this class and subclasses */
	protected final static Log logger = LogFactory.getLog(StudentDao.class);


	@Autowired
	CassandraOperations cassandraOperations;
	
	/**
	 * This class is used to Map the ResultSet values(student_profiles) to Domain/Value Objects(Student)
	 *
	 */
	private static class StudentMapperProfile implements RowMapper<StudentDom> {

			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				StudentDom student = new StudentDom();
				student.setProfileName(rs.getString("profile_name"));
				student.setEmailID(rs.getString("email_id"));
				
				if(rs.getBytes("uploaded_resume") != null)
				{
					byte[] resumeData = new byte[rs.getBytes("uploaded_resume").remaining()];
					rs.getBytes("uploaded_resume").get(resumeData);
				    student.setFileData(resumeData);
				}
				
				student.setDate(rs.getDate("last_updated"));
				student.setPrimarySkills((List<String>) rs.getList("primary_skills",String.class));
				student.setSecondarySkills((List<String>) rs.getList("secondary_skills",String.class));
				student.setAboutYourSelf(rs.getString("about_yourself"));
				student.setResumeName(rs.getString("resume_name"));
				student.setDefault(rs.getBool("is_default"));

				return student;
			}
		
		}

		/**
	 * This class is used to Map the ResultSet values(student_details) to Domain/Value Objects(Student)
	 *
	 *//*
	
	/**
	 * This method is used when a candidate registers to the application 
	 * @param student
	 */
	@Override
	public void candidateRegistration(StudentDom student) {
		
		Insert insertIntoStudentDetails = QueryBuilder.insertInto("student_details").values(
				new String[]{"email_id", "first_name", "last_name", "is_first_login","date_of_birth","profile_visibility","mail_settings","last_updated"},
				new Object[]{student.getEmailID(),
						student.getFirstName(),
						student.getLastName(),
						student.isFirstLogin(),
						student.getDateOfBirth(),
						student.isProfileVisibility(),
						student.getMailSettingsMap(),
						new Date()
				});
		
		cassandraOperations.execute(insertIntoStudentDetails);
		
		//Code Added By RavishaG to map Candidate Recent Activities	
		String registeredMessage = "You have registered with us";
		
		try
		{
		    Date currentDate = new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+registeredMessage+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
		    cassandraOperations.execute(queryForTracker);
			
		}
		catch(Exception e)
		{
		    throw new DoesNotExistException();
		}
		
		String password = DigestUtils.md5Hex(student.getPassword());
		
		Insert insertIntoUser = QueryBuilder.insertInto("user").values(
			new String[]{"username", "password", "authority", "first_name", "last_name", "enabled"}, 
			new Object[]{student.getEmailID(), 
					password,
					student.getAuthority(), 
					student.getFirstName(),
					student.getLastName(),
					false});
				

		cassandraOperations.execute(insertIntoUser);
		
		
		Insert insertIntoStudentProfile = QueryBuilder.insertInto("student_profiles").values(
				new String[]{"email_id","profile_name","is_default","is_deleted","last_updated"}, 
				new Object[]{student.getEmailID(),CaerusAPIStringConstants.DEFAULT_CANDIDATE_PROFILE_NAME,true,false,new Date()});
		
		cassandraOperations.execute(insertIntoStudentProfile);
		
		
	}
	
	
	
	public static class StudentDetailMapper implements RowMapper<StudentDom> 
	{
		@Override
		public StudentDom mapRow(Row rs, int arg1) throws DriverException
		{
			StudentDom student = new StudentDom();
			student.setEmailID(rs.getString("email_id"));
			student.setProfileName(rs.getString("profile_name"));
			student.setFirstName(rs.getString("first_name"));
			student.setLastName(rs.getString("last_name"));
			student.setMobileNumber(rs.getString("mobile_number"));
			student.setState(rs.getString("state"));
			student.setZipCode(rs.getString("zip_code"));
			student.setCity(rs.getString("city"));
			student.setGender(rs.getString("gender"));
			student.setAddress(rs.getString("address"));
			student.setDateOfBirth(rs.getString("date_of_birth"));		
			student.setPrimarySkills(rs.getList("primary_skills", String.class));
			student.setSecondarySkills(rs.getList("secondary_skills",String.class));
			student.setJobStatus(rs.getMap("job_status",String.class,String.class));
			student.setInternshipStatus(rs.getMap("internship_status",String.class,String.class));
			student.setCampusJobStatus(rs.getMap("campus_job_status", String.class, String.class));
			student.setCampusInternshipStatus(rs.getMap("campus_internship_status", String.class, String.class));
			student.setAboutYourSelf(rs.getString("about_your_self"));
			
			if(null != rs.getDate("last_updated"))
			{
				//student.setLastUpdate(new SimpleDateFormat("MM-dd-yyyy HH:mm").format(rs.getDate("last_updated")));
				student.setLastUpdate(new SimpleDateFormat("dd MMM yyyy HH:mm").format(rs.getDate("last_updated")));
			}
			
			if(rs.getBytes("uploaded_resume") != null)
			{
			    byte[] resumeData = new byte[rs.getBytes("uploaded_resume").remaining()];
			    rs.getBytes("uploaded_resume").get(resumeData);
			    student.setFileData(resumeData);
			}
			if(rs.getBytes("uploaded_photo") != null)
			{
			    byte[] imageData = new byte[rs.getBytes("uploaded_photo").remaining()];
			    rs.getBytes("uploaded_photo").get(imageData);
			    student.setPhotoData(imageData);
			}
			if(rs.getBytes("uploaded_video_clip") != null)
			{
			    byte[] videoData = new byte[rs.getBytes("uploaded_video_clip").remaining()];
			    rs.getBytes("uploaded_video_clip").get(videoData);
			    student.setUploadVideoclip(videoData);
			}
			
			if(rs.getBool("photo_verified_flag") != false)
				student.setPhotoName(rs.getString("photoname"));
			else
				student.setPhotoName(null);
			
			student.setVideoName(rs.getString("videoname"));
			student.setResumeName(rs.getString("resumename"));			
			student.setFirstLogin(rs.getBool("is_first_login"));
			student.setCareerObjective(rs.getString("career_objective"));
			student.setExpertizeList(rs.getList("expertise_list",String.class));
			student.setLanguagesList(rs.getSet("language_list",String.class));
			student.setInterestList(rs.getList("interest_list",String.class));
			student.setCertificationsMap(rs.getMap("certifications_map",String.class,String.class));
			student.setPublicationsMap(rs.getMap("publications_map",String.class,String.class));
			student.setViewVideoProfileCount(rs.getInt("video_profile_view_count"));
			student.setIScore(rs.getDouble("i_score"));
			student.setiScore(rs.getDouble("i_score"));
			student.setProfileVisibility(rs.getBool("profile_visibility"));
			student.setWorkMap(rs.getMap("work_map",String.class,String.class));
			student.setSchoolMap(rs.getMap("school_map",String.class,String.class));
			student.setUniversityMap(rs.getMap("university_map",String.class,String.class));
				
			return student;
		}
	}

	
	
	
	/**
	 * This method is used to check whether a student with an emailId:student.getEmailID() already exists
	 * @author KarthikeyanK
	 * @param emailId
	 * @return int (userCount)
	 * @throws CaerusCommonException
	 */
	@Override
	public int getStudentByEmailId(String emailId)throws CaerusCommonException {
		
		Select select = QueryBuilder.select().countAll().from("user");
		
		select.where(QueryBuilder.eq("username", emailId));
		
		 Integer count = Integer.valueOf(cassandraOperations.queryForObject(select, Long.class).toString());
		
		return count;
		
	}
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Introductory for Portfolio.
	 */
	@Override
	public void addStudentIntroductory(StudentDom student) 
	{
		String firstName = "";
		String lastName = "";
		
		if(student.getFirstName() != null && student.getFirstName() != "")
		{
			firstName = CaerusCommonUtility.getCapitalizedString(student.getFirstName().toLowerCase());
		}
		
		if(student.getLastName() != null && student.getLastName() != "")
		{
			lastName = CaerusCommonUtility.getCapitalizedString(student.getLastName().toLowerCase());
		}
		
		if(student!=null)
		{   
			cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]{"email_id","first_name","last_name","mobile_number","address",
		        	 "zip_code","state","city","date_of_birth","gender","last_updated"},
		        	 new Object[]{
					student.getEmailID(),
					firstName,
					lastName,
					student.getMobileNumber(),
					student.getAddress(),
					student.getZipCode(),
					student.getState(),
					student.getCity(),
					student.getDateOfBirth(),
					student.getGender(),
					new Date()}));
		}
		
		
		//Code Added By RavishaG to map Candidate Recent Activities	
		String updatedIntroductorySection = "You have updated the Basic Information Section Of Portfolio ";
		
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedIntroductorySection+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
		    cassandraOperations.execute(queryForTracker);
			
		}
		catch(Exception e)
		{
		    throw new DoesNotExistException();
		}
	
	}
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Education for Portfolio.
	 */
	@Override
	public void addStudentEducation(StudentDom student) {
		
		String courseName= null;
		String universityName = null;
		String courseType = null;
		
		if(null != student.getCourseName())
		{	
			courseName = student.getCourseName().replace("'","");
			String queryForCourseName = "select course_name from master_demo";
			List<String> courseNameList = cassandraOperations.queryForObject(queryForCourseName,List.class);
			
			if(!(courseNameList.contains(courseName)))
			{
				String queryToUpdateCourseName = "update master_demo set course_name = course_name + ['"+courseName+"'] where master_values = '1'";
				cassandraOperations.update(queryToUpdateCourseName);			
			}
		}
		
		if(null != student.getUniversityName())
		{
			universityName = student.getUniversityName().replace("'","");
			String queryForUniversityName = "select university_name from master_demo";
			List<String> universityNameList = cassandraOperations.queryForObject(queryForUniversityName,List.class);
			
			if(!(universityNameList.contains(universityName)))
			{	
				String queryToUpdateUniversityName = "update master_demo set university_name = university_name + ['"+universityName+"'] where master_values = '1'";
				cassandraOperations.update(queryToUpdateUniversityName);			
			}
		}
		
		if(null != student.getCourseType())
		{ 
			courseType = student.getCourseType().replace("'","");
		
			if(!(courseType.equals("Associates Degree") || courseType.equals("Bachelors Degree")))
			{
				student.setCourseType("Masters Degree");
			}
		}
		// if(student.getCourseName()!=null && student.getSchoolName()!=null && student.getSchoolState()!=null && student.getG_startMonth_duration()!=null &&student.getG_endMonth_duration()!=null)
		if(student != null)
		{
			
			/*Added on 26-09-2014 to make GPA a non mandatory field */
			 
			if(student.getG_from_gpa()=="") student.setG_from_gpa(null);
			if(student.getG_to_gpa()=="") student.setG_to_gpa(null);
			if(student.getH_from_gpa()=="") student.setH_from_gpa(null);
			if(student.getH_to_gpa()=="") student.setH_to_gpa(null);
				 
			
				cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]{"email_id","course_name","course_type","university_name","school_name","school_state","university_gpa_from","university_gpa_to","university_monthduration_from","university_monthduration_to","university_yearduration_from","university_yearduration_to","school_gpa_from",
						"school_gpa_to","school_monthduration_from","school_monthduration_to","school_yearduration_from","school_yearduration_to","last_updated"}, 
						new Object[]{
								student.getEmailID(),
								courseName,
        						student.getCourseType(),
								universityName,
								student.getSchoolName(),
								student.getSchoolState(),
								student.getG_from_gpa(),
								student.getG_to_gpa(),
								student.getG_startMonth_duration(),
								student.getG_endMonth_duration(),
								student.getG_startYear_duration(),
								student.getG_endYear_duration(),
								student.getH_from_gpa(),
								student.getH_to_gpa(),
								student.getH_startMonth_duration(),
								student.getH_endMonth_duration(),
								student.getH_startYear_duration(),
								student.getH_endYear_duration(),
								new Date()
								}));
		
			}
		
				//Code Added By RavishaG to map Candidate Recent Activities
				String updatedEducationSection = "You have updated the Education Section Of Portfolio ";
				try
				{
				    Date currentDate=new Date();
				    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedEducationSection+"':'"+currentDate.getTime()+"'} where email_id ='"+student.getEmailID()+"'";
				    cassandraOperations.update(queryForTracker);
					
				}
				catch(Exception e)
				{
				    throw new DoesNotExistException();
				}
		
		
	}
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Work for Portfolio.
	 */
	@Override
	public void addStudentWork(StudentDom student) {

		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		String yearInString = String.valueOf(year);
		
		if (student.getW_endYear_duration() == null || student.getW_endYear_duration().isEmpty())
		{
			student.setW_endYear_duration(yearInString);
		}
		
		if(student.getW_endMonth_duration() == null || student.getW_endMonth_duration().isEmpty())
		{
			student.setW_endMonth_duration(String.valueOf(Calendar.getInstance().get(Calendar.MONTH) + 1));
		}
		
		cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]{"email_id","company_name","work_description","designation","work_monthduration_from","work_monthduration_to",
				"work_yearduration_from","work_yearduration_to","last_updated"},
				new Object[]{
				student.getEmailID(),
				student.getCompanyName(),
				student.getWorkDesc(),
				student.getDesignation(),
				student.getW_startMonth_duration(),
				student.getW_endMonth_duration(),
				student.getW_startYear_duration(),
				student.getW_endYear_duration(),
				new Date()
				}));
		
		
				//Code Added By RavishaG for Mapping Candidate Recent Activities
				String updatedWorkSection = "You have updated the Work Section Of Portfolio ";
				
				try
				{
				    Date currentDate=new Date();
				    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedWorkSection+"':'"+currentDate.getTime()+"'} where email_id ='"+student.getEmailID()+"'";
				    cassandraOperations.update(queryForTracker);
					
				}
				catch(Exception e)
				{
				    throw new DoesNotExistException();
				}

	}
	
	/**
	 * @author Kshailesh
	 * @param student
	 * @desc this method using add detail of the Resume, Skills and Resume for Portfolio.
	 */
	@Override
	public void addStudentResumeSkills(StudentDom student)
	{
		String primarySkillsString = student.getPrimarySkills1();
		String secondarySkillsString = student.getSecondarySkills1();
		ArrayList<String> primarySkillList=new ArrayList<String>();
		ArrayList<String> secondarySkillsList=new ArrayList<String>();
		
		if(primarySkillsString!=null)
		{
			primarySkillsString = primarySkillsString.trim();
		    primarySkillList= new ArrayList<String>(Arrays.asList(primarySkillsString.split(",")));
		}
	
		if(secondarySkillsString!=null)
		{
			secondarySkillsString = secondarySkillsString.trim();
			secondarySkillsList = new ArrayList<String>(Arrays.asList(secondarySkillsString.split(",")));
		}
		
		/**  Candidate Dashboard Skills Update */
		if(student.getAboutYourSelf() == null)
		{
			cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]{"email_id","primary_skills","secondary_skills","last_updated"}, 
					new Object[]{student.getEmailID(),primarySkillList,secondarySkillsList,new Date()}));
			
			cassandraOperations.execute(QueryBuilder.insertInto("student_profiles").values(new String[]{"email_id","profile_name","primary_skills","secondary_skills","is_default"}, 
					new Object[]{student.getEmailID(),"Default",primarySkillList,secondarySkillsList,true}));
		
		}
		else
		{
		//Check For Mobile Devices(Thin Client)
			if(student.getAboutYourSelf()==null && student.getProfileName()==null)
			{
				String profileAlreadyExistsQuery="select count(1) from student_profiles where email_id='"+student.getEmailID()+"'";
				int profileCount=cassandraOperations.queryForObject(profileAlreadyExistsQuery,Integer.class);
			
				cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]{"email_id","primary_skills","secondary_skills","last_updated"},
						new Object[]{student.getEmailID(),primarySkillList,secondarySkillsList,new Date()}));
				
				if(profileCount==0)
				{
					cassandraOperations.execute(QueryBuilder.insertInto("student_profiles").values(new String[]{"email_id","profile_name","primary_skills","secondary_skills","is_default"}, 
							new Object[]{student.getEmailID(),"Default",primarySkillList,secondarySkillsList,true}));
				}
				else
				{
					cassandraOperations.execute(QueryBuilder.insertInto("student_profiles").values(new String[]{"email_id","profile_name","primary_skills","secondary_skills"},
							new  Object[]{student.getEmailID(),"Default",primarySkillList,secondarySkillsList}));
				}
				
			}
			else
			{
				String profileAlreadyExistsQuery="select count(1) from student_profiles where email_id='"+student.getEmailID()+"' and is_default=true";
				Long profileCount=cassandraOperations.queryForObject(profileAlreadyExistsQuery,Long.class);
				
				if (profileCount==0) 
				{
					cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]
						{"email_id","about_your_self","primary_skills","secondary_skills","profile_name","last_updated"},
						new Object[]{student.getEmailID(),student.getAboutYourSelf(),primarySkillList,secondarySkillsList,
							student.getProfileName(),new Date()}));
				
					cassandraOperations.execute(QueryBuilder.insertInto("student_profiles").values(new String[]{"email_id","profile_name","about_yourself","is_default","primary_skills","secondary_skills"},
							new Object[]{student.getEmailID(),"Default",student.getAboutYourSelf(),true,
							primarySkillList,secondarySkillsList}));
				}
				else
				{
					
					cassandraOperations.execute(QueryBuilder.insertInto("student_details").values(new String[]
							{"email_id","about_your_self","primary_skills","secondary_skills","profile_name","last_updated"},
							new Object[]{student.getEmailID(),student.getAboutYourSelf(),primarySkillList,
							secondarySkillsList,student.getProfileName(),new Date()}));
					
					String profileNameQuery="select profile_name from student_profiles where email_id='"+student.getEmailID()+"' and is_default=true";
					String profileName=cassandraOperations.queryForObject(profileNameQuery,String.class);
					
					cassandraOperations.execute(QueryBuilder.insertInto("student_profiles").values(new String[]{"about_yourself","primary_skills","secondary_skills","profile_name",
							"email_id"},new Object[]{student.getAboutYourSelf(),primarySkillList,secondarySkillsList,profileName,student.getEmailID()}));
				}
				
				//Code Added By RavishaG for Mapping Candidate Recent Activities
				String updatedSkillsSection = "You have updated the Skills Section Of Portfolio ";
			
			try
			{
			    Date currentDate=new Date();
			    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedSkillsSection+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
			    cassandraOperations.execute(queryForTracker);
    			
    		}
			catch(Exception e)
			{
			    throw new DoesNotExistException();
			}
		}
	}
}

	

	
	/**
	 * @author Kshailesh
	 * @desc this method is used to fetch the candidate details
	 * @see caerusapp.dao.student.StudentDao#getDetailsByEmailId(caerusapp.domain.student.Student)
	 */
	@Override
	public StudentDom getDetailsByEmailId(String emailID) 
	{
		StudentDom studentDetails = new StudentDom();
		String getStudentDetails = "select * from student_details where email_id='"+emailID+"';";
		try{
		studentDetails = cassandraOperations.queryForObject(getStudentDetails,new StudentDetailMapper());
	  }
	  catch(NullPointerException | IllegalArgumentException ex)
	  {
		  studentDetails = new StudentDom();
	  }
		return studentDetails;
	}

	/**
	 * This method is used to upload profile photo by student
	 * @author Kshailesh
	 * @param student
	 */
	@Override
	public void uploadPhoto(StudentDom student) {
		
		byte[] compressedImage = null;
		String photoName = "";
		
		if(null != student.getFilePhoto())
		{
			compressedImage = student.getFilePhoto().getBytes();
			photoName = student.getFilePhoto().getOriginalFilename();
		}
		else
		{
			compressedImage = student.getPhotoData();
			photoName = student.getPhotoName();
		}
		
		String extension =  CaerusCommonUtility.getFileExtension(photoName);
		
		if(extension != null && (extension.equals("jpg") || extension.equals("jpeg")) && compressedImage.length > 512000)
		{
			compressedImage = CaerusCommonUtility.compressImage(compressedImage);
		}
			
		Insert insert = QueryBuilder.insertInto("student_details").values(new String[]{"photoname","uploaded_photo","email_id","photo_verified_flag","photo_rejected_flag","last_updated"},
				new Object[]{
				photoName, 
				ByteBuffer.wrap(compressedImage),
			     student.getEmailID(),
			     false,
			     false,
			     new Date()});
		cassandraOperations.execute(insert);
		
		//Code Added By RavishaG for Mapping Candidate Recent Activities
		String updatedPortfolioPhoto = "You have updated your Profile Photo ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedPortfolioPhoto+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
		    cassandraOperations.execute(queryForTracker);
			
		}
		catch(Exception e)
		{
		    throw new DoesNotExistException();
		}
	}
	
	
	/** (non-Javadoc)
	 * This method is used to upload resume by student
	 * @author Kshailesh
	 * @see caerusapp.dao.student.StudentDao#uploadResume(java.lang.String, java.lang.String)
	 */
	@Override
	public void uploadResume(StudentDom student) {
		String profileNameQuery = "select profile_name from student_profiles where email_id='"+student.getEmailID()+"' and is_default=true";
		String defaultProfileName = cassandraOperations.queryForObject(profileNameQuery,String.class);
		
		Insert insert = QueryBuilder.insertInto("student_details").values(new String[]{"resumename","uploaded_resume","profile_name","last_updated","email_id"},
				new Object[]{student.getResumeName(),ByteBuffer.wrap(student.getFileData()),defaultProfileName,
				new Date(),student.getEmailID()});
		cassandraOperations.execute(insert);
		
		String profileAlreadyExistsQuery = "select count(1) from student_profiles where email_id='"+student.getEmailID()+"' and is_default=true";
		Long profileCount = cassandraOperations.queryForObject(profileAlreadyExistsQuery,Long.class);
		
		if(profileCount == 0)
		{
			
			Insert insertProfileDetails = QueryBuilder.insertInto("student_profiles").values(new String[]{"resume_name","uploaded_resume","is_default","profile_name","about_yourself","email_id","is_deleted"},
					new Object[]{student.getResumeName(),ByteBuffer.wrap(student.getFileData()),true,defaultProfileName,student.getAboutYourSelf(),
					student.getEmailID(),false});
			cassandraOperations.execute(insertProfileDetails);
		}
		

		else {
			Insert insertProfileDetails = QueryBuilder.insertInto("student_profiles").values(new String[]{"resume_name","uploaded_resume","profile_name","email_id","is_deleted"},
					new Object[]{student.getResumeName(),ByteBuffer.wrap(student.getFileData()),defaultProfileName,
					student.getEmailID(),false});
			cassandraOperations.execute(insertProfileDetails);
		
		}
		
		//Code Added By RavishaG to map Candidate Recent Activities
		String updatedResume = "You have updated your Resume ";
		
		try
		{
		    Date currentDate = new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedResume+"':'"+currentDate.getTime()+"'}"
		    		+ " where email_id = '"+student.getEmailID()+"'";
		    cassandraOperations.execute(queryForTracker);
			
		}
		catch(Exception e)
		{
		    throw new DoesNotExistException();
		}
	}

	/**
	 * This method is used to upload video resume by student
	 * @author Kshailesh
	 * @param student
	 */
	@Override
	public void uploadVideo(StudentDom student) {

		Insert insert = QueryBuilder.insertInto("student_details").values(new String[]{"videoname","uploaded_video_clip","email_id","video_rejected_flag","video_verified_flag","last_updated"},
				new Object[]{student.getVideoName(),ByteBuffer.wrap(student.getFileData()),student.getEmailID(),false,false,new Date()});
		cassandraOperations.execute(insert);
		

				//Code Added By RavishaG for Mapping Candidate Recent Activities
				String updatedPortfolioVideo = "You have updated your Profile Video";

				try
				{
				    Date currentDate=new Date();
				    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedPortfolioVideo+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
				    cassandraOperations.execute(queryForTracker);
					
				}
				catch(Exception e)
				{
				    throw new DoesNotExistException();
				}
		
		
	}

	/**
	 * This method is used to fetch the candidate's profile details
	 * @author KarthikeyanK
	 * @param emailId
	 */
	@Override
	public List<StudentDom> getStudentProfileDetailsByEmailId(String emailId) {

		Select selectProfileDetails = QueryBuilder.select().from("student_profiles");
		
		selectProfileDetails.where(QueryBuilder.eq("email_id", emailId));
		
		List<StudentDom> studentProfiles = new ArrayList<StudentDom>();
		try
		{
			studentProfiles = cassandraOperations.query(selectProfileDetails, new StudentMapperProfile());
		}
		
		catch(IllegalArgumentException argEx)
		{
			logger.error("Empty Result Set in getStudentProfileDetailsByEmailId");
		}
		
		return studentProfiles == null ? new ArrayList<StudentDom>() : studentProfiles;
		
		
	}

	/**
	 * This method is used to get the details of a list of candidates
	 * @param profileList
	 * @return List of Students
	 */
	@Override
	public List<StudentDom> findStudentList(String profileList) {
		

		String sqlQuery = "select * from student_details where email_id IN ("+profileList+")";

		List<StudentDom> studentProfile = cassandraOperations.query(sqlQuery,new CandidateDetailsMapper());
		
		return studentProfile;
		
	}
	
	
	/**
	 * This method is used to get the query builder details for a given formula
	 * @param formulaName
	 * @return EmployerQueryBuilderDom formula
	 */
	@Override
	public EmployerQueryBuilderDom findFormula(String formulaName,String emailId){
		
		String getDefaultFormula = "select * from employer_querybuilder_dtls where formula_name='"+formulaName+"' and email_id='"+emailId+"' ALLOW FILTERING";

		EmployerQueryBuilderDom defaultFormula = cassandraOperations.queryForObject(getDefaultFormula,new QueryBuilderMapper());

		return defaultFormula;
		
	}
	
	
	/**
	 * 
	 * This class is used to Map the ResultSet values(employer_querybuilder_dtls) to Domain/Value Objects(EmployerQueryBuilderDom)
	 *
	 */
	private static class QueryBuilderMapper implements RowMapper<EmployerQueryBuilderDom>
	{
		@Override
		public EmployerQueryBuilderDom mapRow(Row rs, int rowNum) throws DriverException
		{
			EmployerQueryBuilderDom employerQueryBuilderDom = new EmployerQueryBuilderDom();
			employerQueryBuilderDom.setFormulaList(rs.getList("formula_list",String.class));
			employerQueryBuilderDom.setFormulaName(rs.getString("formula_name"));
			employerQueryBuilderDom.setEmailId(rs.getString("email_id"));
			employerQueryBuilderDom.setFirmId(rs.getString("firm_id"));
			return employerQueryBuilderDom;
		}
	}

	/**
	 * This method is used to update the profile views of a candidate when a company views his/her profile 
	 * @author TrishnaR
	 * @param companyName,studentEmailId
	 */
	@Override
	public void updateViewedByCompany(String companyName,String emailId) 
	{
		Map<String, Object> viewedByCompaniesMap = new HashMap<String, Object>();
		
		String selectViewedCompaniesMapQuery = "select viewed_by_companies_map from student_details where email_id = '"+emailId+"'"; 
		try { 
			viewedByCompaniesMap = cassandraOperations.queryForObject(selectViewedCompaniesMapQuery,Map.class);
		}
		catch(NullPointerException npe){
			viewedByCompaniesMap = new HashMap<String, Object>();
		}
		
		String updateViewedCompaniesMapQuery = "";
		Date date = new Date();
			
		if(viewedByCompaniesMap != null)
		{
			if(viewedByCompaniesMap.containsKey(companyName))
			{
				updateViewedCompaniesMapQuery = "update student_details set viewed_by_companies_map['"+companyName+"'] = '"+date.getTime()+"' where email_id = '"+emailId+"'";
				cassandraOperations.execute(updateViewedCompaniesMapQuery);
			}
			else
			{
				 updateViewedCompaniesMapQuery = "update student_details set viewed_by_companies_map = viewed_by_companies_map + {'"+companyName+"':'"+date.getTime()+"'} where email_id = '"+emailId+"'";
				 cassandraOperations.execute(updateViewedCompaniesMapQuery);	
			}
		}
		else
		{
			 updateViewedCompaniesMapQuery = "update student_details set viewed_by_companies_map = {'"+companyName+"':'"+date.getTime()+"'} where email_id = '"+emailId+"'";
			 cassandraOperations.execute(updateViewedCompaniesMapQuery);	
		}
	}
	
/**
	 * This method is used by the candidate to view the list of employers who have viewed his/her profile
	 * @author TrishnaR,BalajiI
	 * @return HashMap<String, Object> (viewedByCompaniesMap)
	 */
	@Override
	public HashMap<String,Object> getViewedByCompaniesList(String emailId) {
		
		String cqlQuery = "select viewed_by_companies_map from student_details where email_id='"+emailId+"'";
		
		HashMap<String,Object> viewedByCompaniesMap = new HashMap<String,Object>();
		
		try
		{
			viewedByCompaniesMap = cassandraOperations.queryForObject(cqlQuery,HashMap.class);
		}
		catch(NullPointerException npe)
		{
			logger.error("Null Pointer Exception in getViewedByCompaniesList");
		}
		return viewedByCompaniesMap ==  null ? new HashMap<String,Object>() : viewedByCompaniesMap;
	}

	/**
	 * This method is used to retrieve the details of the candidate's recent activities on the application
	 * @author RavishaG
	 * @param emailID
	 * @return Map<String, Object> (recentActivitiesMap)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getRecentActivities(String emailID) {
		Select selectRecentActivitiesMap = QueryBuilder.select("recent_activities_map").from("student_details");
		selectRecentActivitiesMap.where(QueryBuilder.eq("email_id", emailID));
		Map<String, Object> recentActivitesMap = new HashMap<String, Object>();
		try {
			recentActivitesMap	= cassandraOperations.queryForObject(selectRecentActivitiesMap,Map.class);
		}
		catch(IllegalArgumentException argEx){
			logger.error("Illegal Argument Exception in getRecentActivities");
		}
		catch(NullPointerException npe){
			logger.error("Null Pointer Exception in getRecentActivities");
		}
		catch(NoHostAvailableException noHostEx){
			logger.error("Servers not Available to process the request in getRecentActivities");
		}
		
		return recentActivitesMap == null ? new HashMap<String, Object>(): recentActivitesMap;
	}

	/**
	 * This method is used to get candidate's QR code image
	 * @author RavishaG
	 * @param emailID
	 * @return File(imageFile)
	 */
	@Override
	public File getQRcodeImage(String emailID) {
			String getCandidateQRCode = "select qrcode_image from student_details where email_id='"+emailID+"'";
			ByteBuffer qrCodeImage = cassandraOperations.queryForObject(getCandidateQRCode, ByteBuffer.class);
			
			byte [] qrCodeImageArray = new byte[qrCodeImage.remaining()];
			qrCodeImage.get(qrCodeImageArray);
			
			InputStream inputStreamObject = new ByteArrayInputStream(qrCodeImageArray);
			File imageFile = CaerusCommonUtility.writeInputStreamToFile(inputStreamObject);
			
			return imageFile;
	}
	
		

	
	/**
	 * This method is used to check if the candidate has logged in for the first time
	 * @author PallaviD
	 * @param emailId
	 */
	@Override
	public void updateIsFirstLogin(String emailId) {
		try{
			
			String updateIsFirstLogin = "update student_details set is_first_login=false where email_id='"+emailId+"'";
			
			cassandraOperations.execute(updateIsFirstLogin);
			
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * This method is used to add career objective to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	@Override
	public void addCareerObjectiveToResume(String emailID, String careerObjective) {
	
		try
		{
			String query = "update student_details set career_objective = '"+careerObjective+"' where email_id = '"+emailID+"'";
			cassandraOperations.execute(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

	/**
	 * This method is used to add expertise to the candidate's resume
	 * @author RavishaG
	 * @param emailID
	 * @param careerObjective
	 */
	@Override
	public void addExpertiseToResume(String emailID, String expertise) {
		
		try
		{
			ArrayList<String> expertiseList=null;

			if(expertise != null)
			{
				expertiseList= new ArrayList<String>(Arrays.asList(expertise.split(",")));

			}
			
			cassandraOperations.execute(QueryBuilder.update("student_details").with(QueryBuilder.set("expertise_list", expertiseList)).where(QueryBuilder.eq("email_id", emailID)));
			
			// to empty the list if all content is erased while editing.
			if(expertise == "")
			{
				String sqlQuery = "delete expertise_list from student_details where email_id = '"+emailID+"'";
				cassandraOperations.execute(sqlQuery);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	}

	/**
	 * This method is used to check if a candidate is already saved by an employer
	 * @author RavishaG
	 * @param candidateEmailId
	 * @param companyEmailId 
	 * @return boolean(flag)
	 */
	@Override
	public boolean isSavedCandidate(String candidateEmailId, String companyEmailId) {
		
		boolean flag = false;
		
		Select selectSavedCandidate = QueryBuilder.select().countAll().from("saved_candidate");
		
		selectSavedCandidate.allowFiltering();
		
		selectSavedCandidate.where(QueryBuilder.eq("emailid",candidateEmailId));
		
		selectSavedCandidate.where(QueryBuilder.eq("company_id",companyEmailId));
		
		Integer countSavedCandidate = Integer.valueOf(cassandraOperations.queryForObject(selectSavedCandidate, Long.class).toString());
		
		if(countSavedCandidate != 0)
		{
			flag = true;
		}
		
		return flag;
	}

	/**
	 * This method is used add personal details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addPersonalDetailsFromWizard(String studentEmailId,StudentDom student) {
		
		String queryForPersonalDetails = "update student_details set about_your_self ='"+student.getAboutYourSelf()+"', zip_code ='"+student.getZipCode()+"', gender ='"+student.getGender()+"', date_of_birth ='"+student.getDateOfBirth()+"', city='"+student.getCity()+"', state='"+student.getState()+"' where email_id = '"+studentEmailId+"'";
		
		cassandraOperations.execute(queryForPersonalDetails);
		
	}

	/**
	 * This method is used add skill details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param student
	 * @return void
	 */
	@Override
	public void addSkillsFromWizard(String studentEmailId, StudentDom student) {

		String primarySkillsString = student.getPrimarySkills1();
		String secondarySkillsString = student.getSecondarySkills1();
		ArrayList<String> primarySkillList=new ArrayList<String>();
		ArrayList<String> secondarySkillsList=new ArrayList<String>();
		
		
		if(primarySkillsString!=null)
		{
		    primarySkillList= new ArrayList<String>(
				Arrays.asList(primarySkillsString.split(",")));

		}
	
		if(secondarySkillsString!=null)
		{
		secondarySkillsList = new ArrayList<String>(
				Arrays.asList(secondarySkillsString.split(",")));
		}
		
		
		String profileAlreadyExistsQuery = "select count(1) from student_profiles where email_id='"+studentEmailId+"' and is_default=true";
		int profileCount = Integer.valueOf(cassandraOperations.queryForObject(profileAlreadyExistsQuery,Long.class).toString());
				
		Date date = new Date();
		
		if (profileCount==0) 
		{
			Insert insert = QueryBuilder.insertInto("student_details").values(
					new String[]{"primary_skills","secondary_skills","profile_name","last_updated","email_id"}, 
					new Object[]{primarySkillList,secondarySkillsList,"Default",date,studentEmailId});
			
			cassandraOperations.execute(insert);
		
			Insert queryToInsert = QueryBuilder.insertInto("student_profiles").values(
					new String[]{"email_id", "profile_name", "is_default", "primary_skills","secondary_skills","about_yourself"}, 
					new Object[]{studentEmailId,
							"Default",
							true,
							primarySkillList,
							secondarySkillsList,
							student.getAboutYourSelf()});
			
			cassandraOperations.execute(queryToInsert);
		}
		
		else
		{
			Insert insert = QueryBuilder.insertInto("student_details").values(
					new String[]{"primary_skills","secondary_skills","email_id"}, 
					new Object[]{primarySkillList,secondarySkillsList,studentEmailId});
			
			cassandraOperations.execute(insert);
			
			String profileNameQuery = "select profile_name from student_profiles where email_id='"+studentEmailId+"' and is_default=true";
			String profileName = cassandraOperations.queryForObject(profileNameQuery,String.class);
			
			Insert queryToInsert = QueryBuilder.insertInto("student_profiles").values(
					new String[]{"primary_skills","secondary_skills","about_yourself","email_id","profile_name"}, 
					new Object[]{primarySkillList,secondarySkillsList,student.getAboutYourSelf(),studentEmailId,profileName});
			
			cassandraOperations.execute(queryToInsert);
		}
				
	
	}

	
	/**
	 * This method is used add some additional extra details from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param studentDom
	 * @return void
	 */
	@Override
	public void addStudentInterests(String studentEmailId, StudentDom studentDom)
	{
		List<String> interests = studentDom.getInterestList();
		String interestsString = CaerusCommonUtility.getCassandraInQueryString(interests);
		
		String queryForOtherDetails = "update student_details set interest_list =["+interestsString+"] where email_id = '"+studentEmailId+"'";
		cassandraOperations.execute(queryForOtherDetails);
		
		String updatedResumeSection = "You have updated the Resume Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedResumeSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
			
		}
	}

	/**
	 * This method is used add languages known by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param studentDom
	 * @return void
	 */
	@Override
	public void addStudentLanguagesKnown(String studentEmailId,StudentDom studentDom) 
	{
		String queryForLanguages = null;
		
		if(!(studentDom.getLanguage() == null || studentDom.getLanguage().isEmpty() ))
		{
			queryForLanguages = "update student_details set language_list = language_list + {'"+studentDom.getLanguage()+"'} where email_id = '"+studentEmailId+"'";
			cassandraOperations.execute(queryForLanguages);
		}	
		else
		{
			for (String language : studentDom.getLanguagesList()) 
			{
				queryForLanguages = "update student_details set language_list = language_list + {'"+language+"'} where email_id = '"+studentEmailId+"'";
				cassandraOperations.execute(queryForLanguages);
			}
		}
		
		String updatedResumeSection = "You have updated the Resume Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedResumeSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
			
		}
	}

	/**
	 * This method is used to remove languages by a candidate from the wizard page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param studentDom
	 * @return null
	 */
	@Override
	public void removeLanguages(String studentEmailId, StudentDom studentDom)
	{
		String queryToRemoveLanguage = "update student_details set language_list = language_list - {'"+studentDom.getLanguage()+"'} where email_id = '"+studentEmailId+"'";
		cassandraOperations.execute(queryToRemoveLanguage);
	}
	
	
	/**
	 * This method is used to add certification details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param certificationList
	 * @param i
	 * @return null
	 */
	@Override
	public void addCertificationDetails(String studentEmailId,List<PortfolioDetailsDom> certificationList, int i) {
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		String yearInString = String.valueOf(year);
		
		
		for (PortfolioDetailsDom portfolioDetailsDom : certificationList) {
			if(portfolioDetailsDom.getCertificationEndMonth() == null){
				portfolioDetailsDom.setCertificationEndMonth("");
			}
			
			if(!(portfolioDetailsDom.getCertificationEndYear() == null))
				{
					if (portfolioDetailsDom.getCertificationEndYear().equals("no expiry"))
					{
						portfolioDetailsDom.setCertificationEndYear(yearInString);
					}
			}
			String queryForCertifiations = "update student_details set certifications_map = certifications_map + {'"+(i+1) + "_certificateName"+"':'"+portfolioDetailsDom.getCertificateName()+"','"+(i+1) + "_certificateNumber"+"':'"+portfolioDetailsDom.getCertificateNumber()+"','"+(i+1) + "_authorityName"+"':'"
			+portfolioDetailsDom.getCertificateAuthority()+"','"+(i+1) + "_startMonth"+"':'"+portfolioDetailsDom.getCertificationStartMonth()+"','"+(i+1) + "_startYear"+"':'"+portfolioDetailsDom.getCertificationStartYear()+"','"+(i+1) + "_endMonth"+"':'"+portfolioDetailsDom.getCertificationEndMonth()+"','"+(i+1)
			+ "_endYear"+"':'"+portfolioDetailsDom.getCertificationEndYear()+"'} where email_id = '"+studentEmailId+"'"; 
			
			cassandraOperations.execute(queryForCertifiations);
			
			i++;
		}
		
		String updatedResumeSection = "You have updated the Resume Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedResumeSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
		    //throw new DoesNotExistException();
		}
	}

	/**
	 * This method is used to add publication details of a candidate from the portfolio page to the database
	 * @author RavishaG
	 * @param studentEmailId
	 * @param publicationList
	 * @param i
	 * @return null
	 */
	@Override
	public void addPublicationDetails(String studentEmailId,List<PortfolioDetailsDom> publicationList, int i) {
		
		for (PortfolioDetailsDom portfolioDetailsDom : publicationList) {
			
			String queryForCertifiations = "update student_details set publications_map = publications_map + {'"+(i+1) + "_publicationTitle"+"':'"+portfolioDetailsDom.getPublicationTitle()+"','"+(i+1) + "_publisherName"+"':'"+portfolioDetailsDom.getPublisherName()+"','"+(i+1) + "_publisherAuthorFirstName"+"':'"+portfolioDetailsDom.getPublisherAuthorFirstName()+"','"+(i+1) + "_publisherAuthorLastName"+"':'"+portfolioDetailsDom.getPublisherAuthorLastName()+"','"+(i+1) + "_publicationUrl"+"':'"+portfolioDetailsDom.getPublicationUrl()+"','"+(i+1)
					+ "_publicationDate"+"':'"+portfolioDetailsDom.getPublicationDate()+"','"+(i+1) + "_publicationSummary"+"':'"+portfolioDetailsDom.getPublicationSummary()+"'} where email_id = '"+studentEmailId+"'"; 
			
			cassandraOperations.execute(queryForCertifiations);
			
			i++;
		}
		
		String updatedResumeSection = "You have updated the Resume Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedResumeSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
			
		}
		
	}

	/**
	 * This method is used to increment the count of video profile views of a candidate 
	 * @author ravishag
	 * @param studentEmailId
	 * int i
	 * @return null
	 */
	@Override
	public void incrementVideoProfileViews(String studentEmailId,int i) {
		
		i = i+1;
		
		Update updateVideoProfileCount = QueryBuilder.update("student_details");
		
		updateVideoProfileCount.with(QueryBuilder.set("video_profile_view_count",i));
		
		updateVideoProfileCount.where(QueryBuilder.eq("email_id", studentEmailId));
		
		cassandraOperations.execute(updateVideoProfileCount);
		
	}

	@Override
	public void updateStudentIScore(Double score,String studentEmailId) {

		String cqlQuery = "update student_details set i_score="+score+"where email_id ='"+studentEmailId+"'";
		cassandraOperations.execute(cqlQuery);
		
	}

	
	@Override
	public void updateMailSettings(String emailId, Map<String, List<String>> mailSettingsMap) 
	{
		Map<String,Boolean> mailsettings=new HashMap<String,Boolean>();
		
		try
		{
			for(int i=mailSettingsMap.size();i>0;i--)
			{
				List<String> subscribeoptions =mailSettingsMap.get("selected_radio");
				
				for(String subscribeoption : subscribeoptions )
				{
					mailsettings.put(subscribeoption,true);
				}
				
				List<String> alertOptions =mailSettingsMap.get("selected_checkbox");
				
				for(String alertOption : alertOptions )
				{
					mailsettings.put(alertOption,true);
				}
			}
		
			Insert insert = QueryBuilder.insertInto("student_details").values(
					new String[]{"mail_settings","email_id"}, 
					new Object[]{mailsettings,emailId});
			
			cassandraOperations.execute(insert);
			
		}
		catch(Exception e){
			e.printStackTrace();
			//throw new DoesNotExistException();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String,Boolean> getCandidateMailSettings(String emailId) 
	{
		Map<String, Boolean> mailSettingsMap=new HashMap<String, Boolean>();
		
		String queryForGettingMailSettings="select mail_settings from student_details where email_id='"+emailId+"'";
		
		try
		{
			mailSettingsMap = cassandraOperations.queryForObject(queryForGettingMailSettings,Map.class);
		}
		
		catch(NullPointerException npe)
		{
			
		}
		
		return mailSettingsMap == null ? new HashMap<String, Boolean>(): mailSettingsMap;
	}

	

	
	/**
	 * This method is used to update a candidate's profile visibility to true or false
	 * @author RavishaG
	 * @param emailId
	 * @param visibility
	 */
	@Override
	public void updateProfileVisibility(String emailId, boolean visibility) {
	
		String query = "update student_details set profile_visibility = "+visibility+" where email_id = '"+emailId+"'";
		
		cassandraOperations.execute(query);
		
	}
	
	
	/**
	 * This method is used to add work details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param workList
	 * @param i
	 * @return null
	 */
	@Override
	public void addWorkDetails(String studentEmailId, List<PortfolioDetailsDom> workList, int i) {
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		String yearInString = String.valueOf(year);
		
		
		for (PortfolioDetailsDom portfolioDetailsDom : workList) {
			if(portfolioDetailsDom.getWorkMonthTo() == null){
				portfolioDetailsDom.setWorkMonthTo("");
			}
			
			if(!(portfolioDetailsDom.getWorkYearTo() == null))
				{
					if (portfolioDetailsDom.getWorkYearTo().equals("no expiry"))
					{
						portfolioDetailsDom.setWorkYearTo(yearInString);
					}
			}
			String queryForWork = "update student_details set work_map = work_map + {'"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_COMPANY_NAME+"':'"+portfolioDetailsDom.getWorkCompanyName()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_DESCRIPTION+"':'"+portfolioDetailsDom.getWorkDescription()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_DESIGNATION+"':'"+portfolioDetailsDom.getWorkDesignation()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_MONTH_FROM+"':'"+portfolioDetailsDom.getWorkMonthFrom()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_YEAR_FROM+"':'"+portfolioDetailsDom.getWorkYearFrom()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_MONTH_TO+"':'"+portfolioDetailsDom.getWorkMonthTo()+"','"+(i+1) + "_"+CaerusAPIStringConstants.CANDIDATE_WORK_MAP_WORK_YEAR_TO+"':'"+portfolioDetailsDom.getWorkYearTo()+"'} "
					+ "where email_id ='"+studentEmailId+"'"; 
			
			cassandraOperations.execute(queryForWork);
			
			i++;
		}
		
		//Code Added By RavishaG to map Candidate Recent Activities	
		String updatedWorkSection = "You have updated the Work Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedWorkSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
		    //throw new DoesNotExistException();
		}
	}
	
	/** This method is used to add school details of  a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param portfolioDetailsDom
	 */
	@Override
	public void addSchoolDetails(String studentEmailId, PortfolioDetailsDom portfolioDetailsDom) {
		
		String schoolName = "";
		if(portfolioDetailsDom.getSchoolName() != null && portfolioDetailsDom.getSchoolName().trim().length() > 0){
			schoolName = portfolioDetailsDom.getSchoolName().replaceAll("'","");
		}
		
		String queryForSchool = "update student_details set school_map = school_map + {'schoolName':'"+schoolName+"','schoolState':'"+portfolioDetailsDom.getSchoolState()+"','schoolGpaFrom':'"+portfolioDetailsDom.getSchoolGpaFrom()+"','schoolGpaTo':'"+portfolioDetailsDom.getSchoolGpaTo()+"','schoolPassingMonth':'"+portfolioDetailsDom.getSchoolPassingMonth()+"','schoolPassingYear':'"+portfolioDetailsDom.getSchoolPassingYear()+"'} where email_id = '"+studentEmailId+"'"; 
		cassandraOperations.execute(queryForSchool);
		
		//Code Added By RavishaG to map Candidate Recent Activities	
		String updatedEducationSection = "You have updated the Education Section Of Portfolio ";
		try
		{
		    Date currentDate = new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedEducationSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
		    //throw new DoesNotExistException();
		}
		
	}

	/**
	 * This method is used to add university details of a candidate from the portfolio page to the database
	 * @author PallaviD
	 * @param studentEmailId
	 * @param universityList
	 * @param i
	 */
	@Override
	public void addUniversityDetails(String studentEmailId,List<PortfolioDetailsDom> universityList, int i) 
	{
		/* Added by RavishaG to add courses, universities and course types to database */
		for (PortfolioDetailsDom portfolioDetailsDom : universityList) 
		{
			if(portfolioDetailsDom.getUniversityCourseName() != null && portfolioDetailsDom.getUniversityCourseName() != "")
			{
				String queryForCourseName = "select course_name from master_demo";
				List<String> courseNameList = cassandraOperations.queryForObject(queryForCourseName,List.class);
				
				if(!(courseNameList.contains(portfolioDetailsDom.getUniversityCourseName())))
				{
					String queryToUpdateCourseName = "update master_demo set course_name = course_name + ['"+portfolioDetailsDom.getUniversityCourseName()+"'] where master_values = '1'";
					cassandraOperations.execute(queryToUpdateCourseName);			
				}
				
			}
			
			if(portfolioDetailsDom.getUniversityName() != null && portfolioDetailsDom.getUniversityName() != "")
			{
				String queryForUniversityName = "select university_name from master_demo";
				List<String> universityNameList = cassandraOperations.queryForObject(queryForUniversityName,List.class);
				if(!(universityNameList.contains(portfolioDetailsDom.getUniversityName())))
				{	
					String queryToUpdateUniversityName = "update master_demo set university_name = university_name + ['"+portfolioDetailsDom.getUniversityName()+"'] where master_values = '1'";
					cassandraOperations.execute(queryToUpdateUniversityName);			
				}
			}
			
			if(portfolioDetailsDom.getUniversityCourseType() != null && portfolioDetailsDom.getUniversityCourseType() != "")
			{ 
				if(!(portfolioDetailsDom.getUniversityCourseType().equals("Associates Degree") || portfolioDetailsDom.getUniversityCourseType().equals("Bachelors Degree")))
				{
					portfolioDetailsDom.setUniversityCourseType("Masters Degree");
				}
			}
			
			String queryForUniversity = "update student_details set university_map = university_map + {'"+(i+1) + "_universityName"+"':'"+portfolioDetailsDom.getUniversityName()+"','"+(i+1) + "_universityCourseType"+"':'"+portfolioDetailsDom.getUniversityCourseType()+"', '"+(i+1) + "_universityCourseName"+"':'"+portfolioDetailsDom.getUniversityCourseName()+"', '"+(i+1) + "_universityGpaFrom"+"':'"+portfolioDetailsDom.getUniversityGpaFrom()+"','"+(i+1) + "_universityGpaTo"+"':'"+portfolioDetailsDom.getUniversityGpaTo()+"','"+(i+1) + "_universityYearFrom"+"':'"+portfolioDetailsDom.getUniversityYearFrom()+"','"+(i+1) + "_universityYearTo"+"':'"+portfolioDetailsDom.getUniversityYearTo()+"','"+(i+1) + "_universityMonthFrom"+"':'"+portfolioDetailsDom.getUniversityMonthFrom()+"','"+(i+1) + "_universityMonthTo"+"':'"+portfolioDetailsDom.getUniversityMonthTo()+"'} "
					+ "where email_id = '"+studentEmailId+"'"; 
			cassandraOperations.execute(queryForUniversity); 
			i++;
			
		}
		
		//Code Added By RavishaG to map Candidate Recent Activities	
		String updatedEducationSection = "You have updated the Education Section Of Portfolio ";
		try
		{
		    Date currentDate=new Date();
		    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+updatedEducationSection+"':'"+currentDate.getTime()+"'} where email_id ='"+studentEmailId+"'";
		    cassandraOperations.update(queryForTracker);
			
		}
		catch(Exception e)
		{
		   // throw new DoesNotExistException();
		}
		
	}
	
	
	public void addSearchedKeywords(String searchKeyword, Boolean userInputFlag) {
		
		int keywordCount=1;
		try {
			
			//Check if keyword exists
			 Select keyWordExistQuery = QueryBuilder.select().countAll().from("keyword_master");
			 
			 keyWordExistQuery.where(QueryBuilder.eq("keyword", searchKeyword.toLowerCase()));
			 
			 Integer existKeyword = Integer.valueOf(cassandraOperations.queryForObject(keyWordExistQuery, Long.class).toString());
			 
			
			if(existKeyword<1)
			{
				Insert insertKeywordQuery = QueryBuilder.insertInto("keyword_master").values(
						new String[]{"keyword", "keyword_count","user_input_flag"}, 
						new Object[]{
								searchKeyword.toLowerCase(),keywordCount,userInputFlag
								});		
				
				cassandraOperations.execute(insertKeywordQuery);
			}
			
			else
			{
				Select getKeywordCountQuery = QueryBuilder.select("keyword_count").from("keyword_master");
				
				getKeywordCountQuery.where(QueryBuilder.eq("keyword", searchKeyword.toLowerCase()));
								
				keywordCount = cassandraOperations.queryForObject(getKeywordCountQuery, Integer.class);
				
				keywordCount=keywordCount+1;
				
				String updateCountQuery="update keyword_master set keyword_count= "+ keywordCount + ", user_input_flag ="+ userInputFlag+" where keyword='"+searchKeyword.toLowerCase()+"'" ;
				cassandraOperations.execute(updateCountQuery);
				
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}

		/**
		 * @author BalajiI
		 * @param appliedStudentEmailIdsStr
		 * @return List<StudentDom>(appliedCandidates)
		 */
		public List<StudentDom> getCandidateListByEmailId(String appliedStudentEmailIdsStr) {
			List<StudentDom> appliedCandidates = new ArrayList<StudentDom>();
			
			String getAppliedCandidates = "select * from student_details where email_id in ("+appliedStudentEmailIdsStr+");";
			try{
				appliedCandidates = cassandraOperations.query(getAppliedCandidates,new CandidateDetailsMapper());
			}
			catch(IllegalArgumentException argEx)
			{
				logger.error("Empty Result Set in getCandidateListByEmailId");
			}
			catch (NoHostAvailableException noHostEx) {
				logger.error("No Hosts Found to Serve Requests");
			}
			return appliedCandidates == null ? new ArrayList<StudentDom>() : appliedCandidates;
		}
		
		
		private class CandidateDetailsMapper implements RowMapper<StudentDom>{
			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				
				StudentDom student = new StudentDom();
				student.setEmailID(rs.getString("email_id"));
				student.setProfileName(rs.getString("profile_name"));
				student.setFirstName(rs.getString("first_name"));
				student.setLastName(rs.getString("last_name"));
				student.setMobileNumber(rs.getString("mobile_number"));
				student.setState(rs.getString("state"));
				student.setZipCode(rs.getString("zip_code"));
				student.setCity(rs.getString("city"));
				student.setGender(rs.getString("gender"));
				student.setAddress(rs.getString("address"));
				student.setDateOfBirth(rs.getString("date_of_birth"));		
				student.setPrimarySkills( rs.getList("primary_skills",String.class));
				student.setSecondarySkills(rs.getList("secondary_skills",String.class));
				student.setJobStatus( rs.getMap("job_status",String.class,String.class));
				student.setInternshipStatus(rs.getMap("internship_status",String.class,String.class));	
				student.setAboutYourSelf(rs.getString("about_your_self"));
				
				if(rs.getBytes("uploaded_resume") != null)
				{
					byte[] resumeData = new byte[rs.getBytes("uploaded_resume").remaining()];
					rs.getBytes("uploaded_resume").get(resumeData);
				    student.setFileData(resumeData);
				}
				
				if(rs.getBytes("uploaded_photo") != null)
				{
				    byte[] photoData = new byte[rs.getBytes("uploaded_photo").remaining()];
				    rs.getBytes("uploaded_photo").get(photoData);
				    student.setPhotoData(photoData);
				}
				
				if(rs.getBool("photo_verified_flag") != false)
					student.setPhotoName(rs.getString("photoname"));
				else
					student.setPhotoName(null);
				
				student.setVideoName(rs.getString("videoname"));
				
				if(rs.getBytes("uploaded_video_clip") != null)
				{
				    byte[] videoData = new byte[rs.getBytes("uploaded_video_clip").remaining()];
				    rs.getBytes("uploaded_video_clip").get(videoData);
				    student.setUploadVideoclip(videoData);
				}
				
				student.setResumeName(rs.getString("resumename"));			
				student.setFirstLogin(rs.getBool("is_first_login"));
				student.setCareerObjective(rs.getString("career_objective"));
				student.setExpertizeList((List<String>)rs.getList("expertise_list",String.class));
				student.setLanguagesList( rs.getSet("language_list",String.class));
				student.setInterestList( rs.getList("interest_list",String.class));
				student.setCertificationsMap( rs.getMap("certifications_map",String.class,String.class));
				student.setPublicationsMap( rs.getMap("publications_map",String.class,String.class));
				student.setViewVideoProfileCount(rs.getInt("video_profile_view_count"));
				student.setIScore(rs.getDouble("i_score"));
				student.setiScore(rs.getDouble("i_score"));
				student.setProfileVisibility(rs.getBool("profile_visibility"));
				student.setWorkMap(rs.getMap("work_map",String.class,String.class));
				student.setSchoolMap( rs.getMap("school_map",String.class,String.class));
				student.setUniversityMap( rs.getMap("university_map",String.class,String.class));
				
				return student;
			}
			
			
		}

		/**
		 * @author balajii
		 * This method is used to Update Student Skills of a Candidate
		 * @param studentUpdatedSkills
		 */
		@Override
		public void updateSkills(StudentDom studentUpdatedSkills)
		{
			try
			{
				String defaultProfileName = "";
				try
				{
					String profileCheckQuery = "select profile_name from student_profiles where email_id='"+studentUpdatedSkills.getEmailID()+"'";
					defaultProfileName = cassandraOperations.queryForObject(profileCheckQuery,String.class);
				}
				catch(IllegalArgumentException e)
				{			
					defaultProfileName = "Default";
				}
				
				/**  Default Profile Exists in student_details table */
				if(null != defaultProfileName)
				{
					Update updateStudentSkills = QueryBuilder.update("student_details");
					updateStudentSkills.with(QueryBuilder.set("primary_skills", studentUpdatedSkills.getPrimarySkills() ) );
					updateStudentSkills.with(QueryBuilder.set("secondary_skills",studentUpdatedSkills.getSecondarySkills() ));
					updateStudentSkills.with(QueryBuilder.set("last_updated", new Date()));
					
					updateStudentSkills.where(QueryBuilder.eq("email_id", studentUpdatedSkills.getEmailID()));
					
					Update updateStudentProfileSkills = QueryBuilder.update("student_profiles");
					updateStudentProfileSkills.with(QueryBuilder.set("primary_skills", studentUpdatedSkills.getPrimarySkills())  );
					updateStudentProfileSkills.with(QueryBuilder.set("secondary_skills",studentUpdatedSkills.getSecondarySkills() ) );
					updateStudentProfileSkills.where(QueryBuilder.eq("email_id", studentUpdatedSkills.getEmailID()));
					updateStudentProfileSkills.where(QueryBuilder.eq("profile_name", defaultProfileName));
					
					cassandraOperations.execute(updateStudentSkills);
					cassandraOperations.execute(updateStudentProfileSkills);
				}
				/** No Default Profile in student_details table*/
				else
				{
					Update updateStudentSkills = QueryBuilder.update("student_details");
					updateStudentSkills.with(QueryBuilder.set("primary_skills",studentUpdatedSkills.getPrimarySkills())  );
					updateStudentSkills.with(QueryBuilder.set("secondary_skills", studentUpdatedSkills.getSecondarySkills()) );
					updateStudentSkills.with(QueryBuilder.set("last_updated", new Date()));
					
					updateStudentSkills.where(QueryBuilder.eq("email_id", studentUpdatedSkills.getEmailID()));
					updateStudentSkills.where(QueryBuilder.eq("profile_name", CaerusAPIStringConstants.DEFAULT_CANDIDATE_PROFILE_NAME));
					
					String defaultStudentProfileName = null;
					try
					{
						String fetchDefaultProfileQuery = "select profile_name from student_profiles where email_id='"+studentUpdatedSkills.getEmailID()+"' and is_default=true";
						defaultStudentProfileName = cassandraOperations.queryForObject(fetchDefaultProfileQuery, String.class);
					}
					catch(IllegalArgumentException e)
					{			
						/** Default Profile Doesnt Exist in student_profiles table */
						
						Insert insertIntoStudentProfile = QueryBuilder.insertInto("student_profiles").values(
								new String[]{"primary_skills","secondary_skills","profile_name","email_id","is_default"}, 
								new Object[]{
										studentUpdatedSkills.getPrimarySkills(),
										studentUpdatedSkills.getSecondarySkills(),
										CaerusAPIStringConstants.DEFAULT_CANDIDATE_PROFILE_NAME,
										studentUpdatedSkills.getEmailID(),
										true}
								);
						cassandraOperations.execute(insertIntoStudentProfile);
					}
					
					/** Default Profile Exists in student_profiles table */
					if(null != defaultStudentProfileName)
					{
						Update updateStudentProfileSkills = QueryBuilder.update("student_profiles");
						updateStudentProfileSkills.with(QueryBuilder.set("primary_skills", studentUpdatedSkills.getPrimarySkills()) );
						updateStudentProfileSkills.with(QueryBuilder.set("secondary_skills", studentUpdatedSkills.getSecondarySkills() ) );
						updateStudentProfileSkills.where(QueryBuilder.eq("email_id", studentUpdatedSkills.getEmailID()));
						updateStudentProfileSkills.where(QueryBuilder.eq("profile_name", defaultStudentProfileName));
						
						cassandraOperations.execute(updateStudentProfileSkills);
					}
				}
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
		}

		@Override
		public List<StudentDom> getProfiles(String candidateEmailId) {
			Select getStudentProfiles = QueryBuilder.select().from("student_profiles");
			getStudentProfiles.where(QueryBuilder.eq("email_id", candidateEmailId));
			getStudentProfiles.where(QueryBuilder.eq("is_deleted", false));
			
			List<StudentDom> studentProfiles = new ArrayList<StudentDom>();
			try {
				studentProfiles = cassandraOperations.query(getStudentProfiles,new StudentProfileMapper());
			}
			catch(NullPointerException npe){
				studentProfiles = new ArrayList<StudentDom>();
			}
			catch (IllegalArgumentException argEx) {
				logger.error("IllegalArgumentException in getProfiles");
			}
			catch (NoHostAvailableException noHostEx) {
				logger.error("NoHostAvailableException in getProfiles");
			}
			
			return studentProfiles == null ? new ArrayList<StudentDom>() : studentProfiles;
		}
		
		private class StudentProfileMapper implements RowMapper<StudentDom> {
			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				StudentDom profileDetails = new StudentDom();
				
				profileDetails.setProfileName(rs.getString("profile_name"));
				
				if(rs.getDate("last_updated") != null)
					profileDetails.setLastUpdate(rs.getDate("last_updated").toString());
				
				profileDetails.setAboutYourSelf(rs.getString("about_yourself"));
				profileDetails.setDefault(rs.getBool("is_default"));
				profileDetails.setPrimarySkills(rs.getList("primary_skills", String.class));
				profileDetails.setSecondarySkills(rs.getList("secondary_skills", String.class));
				profileDetails.setResumeName(rs.getString("resume_name"));
				
				if(rs.getBytes("uploaded_resume") != null)
				{
				    byte[] resumeData = new byte[rs.getBytes("uploaded_resume").remaining()];
				    rs.getBytes("uploaded_resume").get(resumeData);
				    profileDetails.setFileData(resumeData);
				}
				return profileDetails;
			}
			
		}

		@Override
		public StudentDom getProfileDetails(String candidateEmailId,String profileName) {
			Select getProfileDetails = QueryBuilder.select().from("student_profiles");
			getProfileDetails.where(QueryBuilder.eq("email_id", candidateEmailId));
			getProfileDetails.where(QueryBuilder.eq("profile_name", profileName));
			
			StudentDom profileDetails = new StudentDom();
			try {
				profileDetails = cassandraOperations.queryForObject(getProfileDetails, new StudentProfileMapper());
			}
			catch(NullPointerException npe){
				profileDetails = new StudentDom();
			}
			catch (IllegalArgumentException argEx) {
				logger.error("IllegalArgumentException in getProfiles");
			}
			catch (NoHostAvailableException noHostEx) {
				logger.error("NoHostAvailableException in getProfiles");
			}
			return profileDetails == null ? new StudentDom() : profileDetails;
		}

		@Override
		public void updateStudentProfile(StudentDom profileDetailsDom) {
			
			Boolean isDefault = false;
			String selectDefaultProfile = "select is_default from student_profiles where email_id='"+profileDetailsDom.getEmailID()+"' and profile_name='"+profileDetailsDom.getProfileName()+"'";
			try {
				isDefault = cassandraOperations.queryForObject(selectDefaultProfile, Boolean.class);
			}
			catch(IllegalArgumentException | NullPointerException ex){
				isDefault = false;
			}
			
			Insert insertIntoStudentProfile = QueryBuilder.insertInto("student_profiles").values(
					new String[]{"profile_name","email_id","primary_skills","secondary_skills","about_yourself","last_updated","is_default","is_deleted"},
					new Object[]{
							profileDetailsDom.getProfileName(),
							profileDetailsDom.getEmailID(),
							profileDetailsDom.getPrimarySkills(),
							profileDetailsDom.getSecondarySkills(),
							profileDetailsDom.getAboutYourSelf(),
							new Date(),
							isDefault,
							false
					});
			cassandraOperations.execute(insertIntoStudentProfile);
			
			if(profileDetailsDom.getFile() != null && profileDetailsDom.getFile().getOriginalFilename() != null && profileDetailsDom.getFile().getOriginalFilename().length() > 0)
			{
				Update updateStudentProfile = QueryBuilder.update("student_profiles");
				updateStudentProfile.where(QueryBuilder.eq("profile_name", profileDetailsDom.getProfileName()));
				updateStudentProfile.where(QueryBuilder.eq("email_id", profileDetailsDom.getEmailID()));
				
				updateStudentProfile.with(QueryBuilder.set("resume_name", profileDetailsDom.getFile().getOriginalFilename()));
				updateStudentProfile.with(QueryBuilder.set("uploaded_resume", ByteBuffer.wrap(profileDetailsDom.getFile().getBytes())));
				
				cassandraOperations.execute(updateStudentProfile);
				
				if(isDefault != null && isDefault){
					Update updateStudentDetails = QueryBuilder.update("student_details");
					updateStudentDetails.with(QueryBuilder.set("resumename", profileDetailsDom.getFile().getOriginalFilename()));
					updateStudentDetails.with(QueryBuilder.set("uploaded_resume", ByteBuffer.wrap(profileDetailsDom.getFile().getBytes())));
					updateStudentDetails.with(QueryBuilder.set("last_updated", new Date()));
					
					updateStudentDetails.where(QueryBuilder.eq("email_id", profileDetailsDom.getEmailID()));
					cassandraOperations.execute(updateStudentDetails);
				}
				
			}
			
			if(isDefault != null && isDefault){
				Update updateStudentDetails = QueryBuilder.update("student_details");
				updateStudentDetails.with(QueryBuilder.set("profile_name", profileDetailsDom.getProfileName()));
				updateStudentDetails.with(QueryBuilder.set("primary_skills", profileDetailsDom.getPrimarySkills()));
				updateStudentDetails.with(QueryBuilder.set("secondary_skills", profileDetailsDom.getSecondarySkills()));
				updateStudentDetails.with(QueryBuilder.set("about_your_self", profileDetailsDom.getAboutYourSelf()));
				updateStudentDetails.with(QueryBuilder.set("last_updated", new Date()));
				
				updateStudentDetails.where(QueryBuilder.eq("email_id", profileDetailsDom.getEmailID()));
				
				cassandraOperations.execute(updateStudentDetails);
			}
			
		}

		@Override
		public void markDefault(String candidateEmailId, String profileName) {
			
			Select selectPreviousDefaultProfileName = QueryBuilder.select("profile_name").from("student_profiles");
			selectPreviousDefaultProfileName.where(QueryBuilder.eq("email_id", candidateEmailId));
			selectPreviousDefaultProfileName.where(QueryBuilder.eq("is_default", true));
			
			String previousDefaultProfileName = "";
			previousDefaultProfileName = cassandraOperations.queryForObject(selectPreviousDefaultProfileName, String.class);
			
			if(previousDefaultProfileName != null && previousDefaultProfileName.length() > 0) {
				Update updatePreviousDefaultProfile = QueryBuilder.update("student_profiles");
				updatePreviousDefaultProfile.with(QueryBuilder.set("is_default", false));
				updatePreviousDefaultProfile.where(QueryBuilder.eq("email_id", candidateEmailId));
				updatePreviousDefaultProfile.where(QueryBuilder.eq("profile_name", previousDefaultProfileName));
				
				cassandraOperations.execute(updatePreviousDefaultProfile);
			}
			
			StudentDom profileDetails = getProfileDetails(candidateEmailId, profileName);
			
			Update updateDefaultFlag = 	QueryBuilder.update("student_profiles");
			updateDefaultFlag.with(QueryBuilder.set("is_default", true));
			updateDefaultFlag.where(QueryBuilder.eq("email_id", candidateEmailId));
			updateDefaultFlag.where(QueryBuilder.eq("profile_name", profileName));
			
			cassandraOperations.execute(updateDefaultFlag);
			
			if(profileDetails.getFileData() == null)
				profileDetails.setFileData(new byte[1]);
			
			Update updateStudentDetails = QueryBuilder.update("student_details");
			//updateStudentDetails.with(QueryBuilder.set("profile_name", profileName));
			updateStudentDetails.with(QueryBuilder.set("primary_skills", profileDetails.getPrimarySkills()));
			updateStudentDetails.with(QueryBuilder.set("secondary_skills", profileDetails.getSecondarySkills()));
			updateStudentDetails.with(QueryBuilder.set("resumename", profileDetails.getResumeName()));
			updateStudentDetails.with(QueryBuilder.set("uploaded_resume", ByteBuffer.wrap(profileDetails.getFileData())));
			updateStudentDetails.with(QueryBuilder.set("about_your_self", profileDetails.getAboutYourSelf()));
			updateStudentDetails.with(QueryBuilder.set("last_updated", new Date()));
			updateStudentDetails.where(QueryBuilder.eq("email_id", candidateEmailId));			
			
			cassandraOperations.execute(updateStudentDetails);
			
		}

		@Override
		public void deleteProfile(String candidateEmailId, String profileName) {
			Update updateDeleteFlag = QueryBuilder.update("student_profiles");
			updateDeleteFlag.with(QueryBuilder.set("is_deleted", true));
			
			updateDeleteFlag.where(QueryBuilder.eq("email_id", candidateEmailId));
			updateDeleteFlag.where(QueryBuilder.eq("profile_name", profileName));
			
			cassandraOperations.execute(updateDeleteFlag);
		}

		@Override
		public boolean checkIfProfileNameExists(String profileName,String candidateEmailId) {
			Select checkProfileExists = QueryBuilder.select().countAll().from("student_profiles");
			checkProfileExists.where(QueryBuilder.eq("email_id", candidateEmailId));
			checkProfileExists.where(QueryBuilder.eq("profile_name", profileName));
			checkProfileExists.where(QueryBuilder.eq("is_deleted", false));
			
			Integer profileCount = 0;
			profileCount = Integer.valueOf(cassandraOperations.queryForObject(checkProfileExists, Long.class).toString());
			
			return profileCount == 0 ? false : true;
		}

		@Override
		public void uploadQRCodeImage(InputStream qrcodeImage, String emailId) {
			byte[] qrByteData = null;
			try {
				qrByteData = IOUtils.toByteArray(qrcodeImage);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		Update updateCandidateQRCode = QueryBuilder.update("student_details");
		updateCandidateQRCode.with(QueryBuilder.set("qrcode_image", ByteBuffer.wrap(qrByteData)));
		updateCandidateQRCode.where(QueryBuilder.eq("email_id", emailId));
			
		cassandraOperations.execute(updateCandidateQRCode);
		}

		@Override
		public StudentDom getStudentImage(String studentEmailId) {
			
			Select select = QueryBuilder.select("photoname","uploaded_photo").from("student_details");
			
			select.where(QueryBuilder.eq("email_id", studentEmailId));
			
			StudentDom studentDom = new StudentDom();
			
			try
			{
				studentDom = cassandraOperations.queryForObject(select, new StudentImageMapper());
			}
			
			catch(IllegalArgumentException ex)
			{
				
			}
			
			return studentDom == null ? new StudentDom() : studentDom;
		}
		
		
		private static class StudentImageMapper implements RowMapper<StudentDom> {

			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				
				StudentDom student = new StudentDom();
				student.setPhotoName(rs.getString("photoname"));
				
				if(rs.getBytes("uploaded_photo") != null)
				{
					byte[] photoData = new byte[rs.getBytes("uploaded_photo").remaining()];
					rs.getBytes("uploaded_photo").get(photoData);
				    student.setPhotoData(photoData);
				}
				
				return student;
			}
		
		}

		@Override
		public void candidateBetaRegistration(StudentDom student) {
			Insert insertIntoStudentDetails = QueryBuilder.insertInto("student_details").values(
					new String[]{"email_id", "first_name", "last_name", "is_first_login","date_of_birth","profile_visibility","mail_settings"},
					new Object[]{student.getEmailID(),
							student.getFirstName(),
							student.getLastName(),
							student.isFirstLogin(),
							student.getDateOfBirth(),
							student.isProfileVisibility(),
							student.getMailSettingsMap()
					});
			
			cassandraOperations.execute(insertIntoStudentDetails);
			
			//Code Added By RavishaG to map Candidate Recent Activities	
			String registeredMessage = "You have registered with us";
			
			try
			{
			    Date currentDate = new Date();
			    String queryForTracker = "update student_details set recent_activities_map = recent_activities_map + {'"+registeredMessage+"':'"+currentDate.getTime()+"'} where email_id = '"+student.getEmailID()+"'";
			    cassandraOperations.execute(queryForTracker);
				
			}
			catch(Exception e)
			{
			    throw new DoesNotExistException();
			}
			
			String password = DigestUtils.md5Hex(student.getPassword());
			
			Insert insertIntoUser = QueryBuilder.insertInto("user").values(
				new String[]{"username", "password", "authority", "first_name", "last_name", "enabled"}, 
				new Object[]{student.getEmailID(), 
						password,
						student.getAuthority(), 
						student.getFirstName(),
						student.getLastName(),
						true});
					

			cassandraOperations.execute(insertIntoUser);
			
			
			Insert insertIntoStudentProfile = QueryBuilder.insertInto("student_profiles").values(
					new String[]{"email_id","profile_name","is_default","is_deleted","last_updated"}, 
					new Object[]{student.getEmailID(),CaerusAPIStringConstants.DEFAULT_CANDIDATE_PROFILE_NAME,true,false,new Date()});
			
			cassandraOperations.execute(insertIntoStudentProfile);
			
		}

		@Override
		public Map<String,Integer> getCandidateSearchedKeywords() {
			Select select = QueryBuilder.select("keyword","keyword_count").from("keyword_master");
			select.where(QueryBuilder.eq("user_input_flag", true));
			
			Map<String,Integer> candidateSearchedKeywords = new HashMap<String,Integer>();
			
			ResultSet resultSet = cassandraOperations.query(select);
			if(resultSet != null && !resultSet.isExhausted())
			{
				for (Row row : resultSet) {
					if(row != null)
						candidateSearchedKeywords.put(row.getString("keyword"),row.getInt("keyword_count"));
				}
				
			}
			return candidateSearchedKeywords == null ? new HashMap<String,Integer>() : candidateSearchedKeywords;
		}

		
		@Override
		public void addToCandidateRecentSearches(String combinationWord,String emailId,String searchCriterion) {
			
			Long lastRecentSearchId = getLastRecentSearchId();
			
			String searchParameterName = "recSearch" + lastRecentSearchId;
			
			Insert insert = QueryBuilder.insertInto("saved_searches").values(
					new String[]{"emailid","search_parameter_name","saved_search_on","keyword","is_saved_search","search_criterion"}, 
					new Object[]{emailId,searchParameterName,new Date(),combinationWord,false,searchCriterion});
			
			cassandraOperations.execute(insert);
			incrementRecentSearchId();
			
		}
		
		Long getLastRecentSearchId(){
			long lastFileId = 0;
			try {
				Select selectLastFileId = QueryBuilder.select("recent_search_id").from("counter_references");
				selectLastFileId.where(QueryBuilder.eq("master_value",1));
				
				lastFileId = cassandraOperations.queryForObject(selectLastFileId,Long.class);
			}
			catch(NullPointerException npe){
				logger.error("NullPointerException in getLastFileId");
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in getLastFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in getLastFileId");
			}
			return lastFileId;
		}
		
		Boolean incrementRecentSearchId(){
			Boolean flag = false;
			Update updateFileId = QueryBuilder.update("counter_references");
			updateFileId.with(QueryBuilder.incr("recent_search_id",1));
			updateFileId.where(QueryBuilder.eq("master_value",1));
			
			try {
				cassandraOperations.execute(updateFileId);
				flag = true;
			}
			catch(IllegalArgumentException argEx){
				logger.error("IllegalArgumentException in incrementFileId");
			}
			catch(NoHostAvailableException noHostEx){
				logger.error("NoHostAvailableException in incrementFileId");
			}
			return flag;	
		}

		@Override
		public Map<String,Date> getCandidateRecentSearches(String emailId) {
			
			Select select = QueryBuilder.select("keyword","saved_search_on").from("saved_searches");
			
			select.where(QueryBuilder.eq("emailid", emailId));
			
			select.where(QueryBuilder.eq("is_saved_search", false));
			
			select.allowFiltering();
			
			Map<String,Date> recentSearches = new HashMap<String,Date>();
			
			ResultSet resultSet = cassandraOperations.query(select);
			if(resultSet != null && !resultSet.isExhausted())
			{
				for (Row row : resultSet) {
					if(row != null)
						recentSearches.put(row.getString("keyword"),row.getDate("saved_search_on"));
				}
				
			}
			
			return recentSearches == null ? new HashMap<String,Date>()  : recentSearches;
		}

		@Override
		public List<StudentDom> getCandidateDetails(ArrayList<String> candidateEmailIds) {
			
			Select select = QueryBuilder.select("email_id","first_name","last_name","profile_name","photoname","photo_verified_flag").from("student_details");
			select.where(QueryBuilder.in("email_id", candidateEmailIds.toArray()));
			
			List<StudentDom> candidateDetails = new ArrayList<StudentDom>();
			try
			{
				candidateDetails = cassandraOperations.query(select,new CandidateMapper());
			}
			catch(IllegalArgumentException | NoHostAvailableException ex)
			{
				logger.error("Error occured in getCandidateDetails()");
			}
			
			return candidateDetails == null ? new ArrayList<StudentDom>() : candidateDetails;
		}
		
		
		private class CandidateMapper implements RowMapper<StudentDom>{
			@Override
			public StudentDom mapRow(Row rs, int arg1) throws DriverException {
				
				StudentDom student = new StudentDom();
				student.setEmailID(rs.getString("email_id"));
				student.setProfileName(rs.getString("profile_name"));
				student.setFirstName(rs.getString("first_name"));
				student.setLastName(rs.getString("last_name"));
				
				if(rs.getBool("photo_verified_flag") != false)
					student.setPhotoName(rs.getString("photoname"));
				else
					student.setPhotoName(null);
				
				return student;
			}
			
			
		}

		@Override
		public void sendRecommendationRequest(StudentRecommendationDom studentRecommendationDom) {
			
			int userCount = 0;
		 
			Insert insert = QueryBuilder.insertInto("candidate_recommendation").values
			(new String[] {"student_email_id", "request_time", "recommender_first_name", "recommender_last_name",
					"organization", "designation", "recommender_email_id", 
					"request_message", "type", "reco_response_time", "student_status", 
					"recommender_status", "creativity_rating", "work_ethic_rating", 
					"leadership_rating", "reminder_count", "detailed_reco"} 
		     , new Object[] { studentRecommendationDom.getStudentEmailId(),	studentRecommendationDom.getRequestTime(),
				studentRecommendationDom.getRecommenderFirstName(), studentRecommendationDom.getRecommenderLastName(), studentRecommendationDom.getOrganization(), studentRecommendationDom.getDesignation(),
				studentRecommendationDom.getRecommenderEmailId(), studentRecommendationDom.getRequestMessage(), studentRecommendationDom.getType(),
				studentRecommendationDom.getRecommenderResponseTime(),studentRecommendationDom.getStudentRecoStatus(),
				studentRecommendationDom.getRecommenderStatus(), studentRecommendationDom.getCreativityRating(), studentRecommendationDom.getWorkEthicRating(),
				studentRecommendationDom.getLeadershipRating(), 0, studentRecommendationDom.getDetailedReco()
		});
			
			cassandraOperations.execute(insert);
			
			String sql = "Select count(1) from user where username='"+studentRecommendationDom.getRecommenderEmailId()+"'";
			userCount = Integer.valueOf(cassandraOperations.queryForObject(sql, Long.class).toString());
			
			if(userCount==0){
				 Insert insertIntoUser = QueryBuilder.insertInto("user").values(new String[]{"username","password","authority","first_name","last_name","is_admin","enabled", "entity_name"}, 
						 new Object[]{studentRecommendationDom.getRecommenderEmailId(),
								DigestUtils.md5Hex("12345678"), 
								CaerusAPIStringConstants.DEFAULT_RECOMMENDER_AUTHORITY,
								studentRecommendationDom.getRecommenderFirstName(), 
								studentRecommendationDom.getRecommenderLastName(), 
								false, 
								true,
								studentRecommendationDom.getOrganization()
						 });
			
				 cassandraOperations.execute(insertIntoUser);
			}
			
		
			
		}

		@Override
		public List<StudentRecommendationDom> getCandidateRecommendations(String emailId, String authority, String recommenderStatus) {
			
			List<StudentRecommendationDom> recommendationList = new ArrayList<StudentRecommendationDom>();
			
			if(authority.equalsIgnoreCase(CaerusAPIStringConstants.DEFAULT_STUDENT_AUTHORITY)){
				
				Select select = QueryBuilder.select("designation", "organization", "recommender_first_name", "recommender_last_name", "request_time", "student_status", "recommender_email_id", "reco_response_time").from("candidate_recommendation");
				select.where(QueryBuilder.eq("student_email_id", emailId));
				try
				{
					recommendationList = cassandraOperations.query(select,new RecommendationMapper());
				}
				catch(IllegalArgumentException | NoHostAvailableException ex)
				{
					logger.error("Error occured in getCandidateRecommendations()");
				}
			}
			
		
			if(authority.equalsIgnoreCase(CaerusAPIStringConstants.DEFAULT_RECOMMENDER_AUTHORITY)){
			
				Select select = QueryBuilder.select("student_email_id", "creativity_rating", "designation", "detailed_reco", "leadership_rating", "organization", 
					"reco_response_time", "recommender_first_name", "recommender_last_name", "recommender_status", "request_message", "request_time", 
					"student_status", "work_ethic_rating", "student_first_name", "student_last_name", "years_student_known").from("candidate_recommendation");
				select.where(QueryBuilder.eq("recommender_email_id", emailId));
				select.allowFiltering();
				 
				if(null != recommenderStatus && !recommenderStatus.isEmpty()){
				select.where(QueryBuilder.eq("recommender_status", recommenderStatus));			 
				}
				
				try
				{
					recommendationList = cassandraOperations.query(select,new RecommenderMapper());
				}
				catch(IllegalArgumentException | NoHostAvailableException ex)
				{
				     logger.error("Error occured in getCandidateRecommendations()");
				}
			
				}
			return recommendationList == null ? new ArrayList<StudentRecommendationDom>() : recommendationList;
		}

		private class RecommendationMapper implements RowMapper<StudentRecommendationDom>{
		
			@Override
			public StudentRecommendationDom mapRow(Row rs, int arg1) throws DriverException {
				
				StudentRecommendationDom recommendation = new StudentRecommendationDom();
				recommendation.setDesignation(rs.getString("designation"));
				recommendation.setOrganization(rs.getString("organization"));
				recommendation.setRecommenderFirstName(rs.getString("recommender_first_name"));
				recommendation.setRecommenderLastName(rs.getString("recommender_last_name"));
				recommendation.setRequestTime(rs.getDate("request_time"));
				recommendation.setStudentRecoStatus(rs.getString("student_status"));
				recommendation.setRecommenderEmailId(rs.getString("recommender_email_id"));
				recommendation.setRecommenderResponseTime(rs.getDate("reco_response_time"));
				
				
				return recommendation;
			}
			
			}
		
		private class RecommenderMapper implements RowMapper<StudentRecommendationDom>{

			@Override
			public StudentRecommendationDom mapRow(Row rs, int arg1) throws DriverException {
				StudentRecommendationDom recommendation = new StudentRecommendationDom();
				
				recommendation.setStudentEmailId(rs.getString("student_email_id"));
				recommendation.setCreativityRating(rs.getString("creativity_rating"));
				recommendation.setDesignation(rs.getString("designation"));
				recommendation.setDetailedReco(rs.getString("detailed_reco"));
				recommendation.setLeadershipRating(rs.getString("leadership_rating"));
				recommendation.setOrganization(rs.getString("organization"));
				recommendation.setRecommenderResponseTime(rs.getDate("reco_response_time"));
				recommendation.setRecommenderFirstName(rs.getString("recommender_first_name"));
				recommendation.setRecommenderLastName(rs.getString("recommender_last_name"));
				recommendation.setRecommenderStatus(rs.getString("recommender_status"));
				recommendation.setRequestMessage(rs.getString("request_message"));
				recommendation.setRequestTime(rs.getDate("request_time"));
				recommendation.setWorkEthicRating(rs.getString("work_ethic_rating"));
				recommendation.setStudentFirstName(rs.getString("student_first_name"));
				recommendation.setStudentLastName(rs.getString("student_last_name"));
				recommendation.setYearsStudentKnown(rs.getString("years_student_known"));
				
				return recommendation;
			}
			
		}
		
		private class RecoReminderMapper implements RowMapper<StudentRecommendationDom>{

			@Override
			public StudentRecommendationDom mapRow(Row rs, int arg1)
					throws DriverException {
				StudentRecommendationDom recommendation = new StudentRecommendationDom();
				recommendation.setReminderCount(rs.getInt("reminder_count"));
				recommendation.setRecommenderStatus(rs.getString("recommender_status"));
				recommendation.setRequestTime(rs.getDate("request_time"));
				return recommendation;
			}
			
		}

		@Override
		public void sendRecommendationReminder(String candidateEmailId,	String recommenderEmailId) {
			
			
			Select select = QueryBuilder.select("reminder_count", "recommender_status", "request_time").from("candidate_recommendation");
			select.where(QueryBuilder.eq("student_email_id", candidateEmailId));
			select.where(QueryBuilder.eq("recommender_email_id", recommenderEmailId));
			
			StudentRecommendationDom studentRecommendationDom = cassandraOperations.queryForObject(select, new RecoReminderMapper());
			
			Long differenceInDays = CaerusCommonUtility.getDateDifferenceInLong(CaerusAPIStringConstants.EVENT_DATE_FORMAT, studentRecommendationDom.getRequestTime().toString());

			if(studentRecommendationDom.getReminderCount() < 2 && studentRecommendationDom.getRecommenderStatus().equalsIgnoreCase("pending") && differenceInDays > 10){
				
				Update update = QueryBuilder.update("candidate_recommendation");
				update.with(QueryBuilder.set("request_time", new Date()));
				update.with(QueryBuilder.set("reminder_count", studentRecommendationDom.getReminderCount()+1));
				
				update.where(QueryBuilder.eq("student_email_id", candidateEmailId));
				update.where(QueryBuilder.eq("recommender_email_id", recommenderEmailId));
				
				cassandraOperations.execute(update);
				
			}
			
		}

		@Override
		public void submitRecommendation(
				StudentRecommendationDom studentRecommendationDom) {
			Update updateRecommendation = QueryBuilder.update("candidate_recommendation");
			
			updateRecommendation.with(QueryBuilder.set("creativity_rating", studentRecommendationDom.getCreativityRating()));
			if(!studentRecommendationDom.getDetailedReco().equalsIgnoreCase("")){
				updateRecommendation.with(QueryBuilder.set("detailed_reco", studentRecommendationDom.getDetailedReco()));
			}
			updateRecommendation.with(QueryBuilder.set("leadership_rating", studentRecommendationDom.getLeadershipRating()));
			updateRecommendation.with(QueryBuilder.set("reco_response_time", new Date()));
			updateRecommendation.with(QueryBuilder.set("organization", studentRecommendationDom.getOrganization()));
			updateRecommendation.with(QueryBuilder.set("recommender_first_name", studentRecommendationDom.getRecommenderFirstName()));
			updateRecommendation.with(QueryBuilder.set("recommender_last_name", studentRecommendationDom.getRecommenderLastName()));
			updateRecommendation.with(QueryBuilder.set("recommender_status", studentRecommendationDom.getRecommenderStatus()));
			updateRecommendation.with(QueryBuilder.set("student_status", studentRecommendationDom.getStudentRecoStatus()));
			updateRecommendation.with(QueryBuilder.set("work_ethic_rating", studentRecommendationDom.getWorkEthicRating()));
			updateRecommendation.with(QueryBuilder.set("years_student_known", studentRecommendationDom.getYearsStudentKnown()));
				
			updateRecommendation.where(QueryBuilder.eq("student_email_id", studentRecommendationDom.getStudentEmailId()));
			updateRecommendation.where(QueryBuilder.eq("recommender_email_id", studentRecommendationDom.getRecommenderEmailId()));
			
			cassandraOperations.execute(updateRecommendation);
		}
		
		
		
	}