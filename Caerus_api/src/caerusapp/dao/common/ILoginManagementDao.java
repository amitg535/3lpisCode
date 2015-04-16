package caerusapp.dao.common;

import java.util.List;
import java.util.Map;
import java.util.Set;

import caerusapp.domain.common.BetaUserDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.student.StudentDom;

public interface ILoginManagementDao {

	public LoginManagementDom getUserDetailsByEmailID(String emailID);

	public void addLoginDetails(UserBrowsingPatternsDom userBrowsingPatternsDom, String authority);

	/**
	 * This method is used to check the enabled flag of a user
	 * @author RavishaG
	 * @param emailId
	 * @return Boolean
	 */
	public Boolean checkValidUser(String emailId);

	/**
	 * This method is used to update a user's password
	 * @author RavishaG
	 * @param loginManagementDom
	 */
	public void updateUsersLoginPassword(LoginManagementDom loginManagementDom);

	/**
	 * This method is used to retrieve admin details of University/Corporate
	 * @author PallaviD
	 * @param entityName
	 * @return adminDetails(LoginManagementDom)
	 */
	public LoginManagementDom getAdminByEntityName(String entityName);
	
	/**
	 * This method is used to find the authority of a user on the basis of email Id
	 * @author RavishaG
	 * @param emaiId
	 * @return string
	 */
	public String getAuthorityByEmailId(String emaiId);

	public void setUserLogoutTime(String userEmailId);

	public void updateRecentActivities(String userName);

	public void updateUserBrowsingPatterns(UserBrowsingPatternsDom userBrowsingPatternsDom, String userEmailId);
	
	public String getEntityNameByEmailId(String userId);

	public String getEnabledStatusByUsername(String userName);

	public void updateEnabledStatusByUsername(String userName);

	public List<LoginManagementDom> getUsers(String companyName);

	public void updateUserDetails(LoginManagementDom userDetails);

	public void addUser(LoginManagementDom userDetails);

	public void disableUsers(Map<String, String> disableUser);

	public void enableUsers(Map<String, String> enableUser);

	public List<LoginManagementDom> getUserDetails();

	public List<StudentDom> getUnverifiedPhotoStudents();

	public void verifyUserPhoto(String userName);

	public void rejectUserPhoto(String userName);

	public List<StudentDom> getUnverifiedVideoStudents();
	
	public boolean checkBetaUserExists(String emailId);
	
	public int insertBetaUser(BetaUserDom betaUser);

	public List<BetaUserDom> getBetaUsers();

	public void updateBetaUserStatus(String emailId, String status);

	public void enableUser(String emailId);

	public String getLastInsertedBetaCompanyNumber();

	public String getLastInsertedBetaUniversityNumber();

	public void verifyUserVideo(String userName);

	public void rejectUserVideo(String userName);

	public boolean checkEntityExist(String string);
	
	public List<String> getMasterResults(String masterType);

	public void deleteMasterValue(String masterType, String masterValue);

	public void addMasterValue(String masterType, String masterValue);

	public Boolean checkMasterValueExists(String masterType, String masterValue);

	public void updateMasterValue(String masterType, String oldValue,String newMasterValue);

	public void addMasterValues(Set<String> elements, String masterType);


	public Long getInternshipViewedCount(String internshipIdAndFirmId);

	public Long getCampusJobViewedCount(String jobId, String universityName);

	public Long getCampusInternshipViewedCount(String internshipId,String universityName);

	void changeCompanyNameforNonPrimarykeys(LoginManagementDom loginManagentDom);

	public Long getJobViewedCount(String jobIdAndFirmId);

}
