package caerusapp.service.common;

import java.util.List;
import java.util.Map;
import java.util.Set;

import caerusapp.dao.common.ILoginManagementDao;
import caerusapp.domain.common.BetaUserDom;
import caerusapp.domain.common.LoginManagementDom;
import caerusapp.domain.common.UserBrowsingPatternsDom;
import caerusapp.domain.student.StudentDom;

public class CaerusLoginManagement implements ILoginManagement {

	ILoginManagementDao loginManagementDao;

	public ILoginManagementDao getLoginManagementDao() {
		return loginManagementDao;
	}

	public void setLoginManagementDao(ILoginManagementDao loginManagementDao) {
		this.loginManagementDao = loginManagementDao;
	}

	@Override
	public LoginManagementDom getUserDetailsByEmailID(String emailID) {
		return loginManagementDao.getUserDetailsByEmailID(
				emailID);
	}
	
	
	@Override
	public void addLoginDetails(UserBrowsingPatternsDom userBrowsingPatternsDom, String authority) {
		
		loginManagementDao.addLoginDetails(userBrowsingPatternsDom,authority);
	}

	/**
	 * This method is used to check the enabled flag of a user
	 * @author RavishaG
	 * @param emailId
	 * @return Boolean
	 */
	@Override
	public Boolean checkValidUser(String emailId) {
		
		return loginManagementDao.checkValidUser(emailId);
	}

	/**
	 * This method is used to update a user's password
	 * @author RavishaG
	 * @param loginManagementDom
	 */
	@Override
	public void updateUsersLoginPassword(LoginManagementDom loginManagementDom) {
		
		loginManagementDao.updateUsersLoginPassword(loginManagementDom);
		
	}

	/**
	 * This method is used to retrieve admin details of University/Corporate
	 * @author PallaviD
	 * @param entityName
	 * @return adminDetails(LoginManagementDom)
	 */
	@Override
	public LoginManagementDom getAdminByEntityName(String entityName) {
		return loginManagementDao.getAdminByEntityName(entityName);
	}
	
	/**
	 * This method is used to find the authority of a user on the basis of email Id
	 * @author RavishaG
	 * @param emaiId
	 * @return string
	 */
	@Override
	public String getAuthorityByEmailId(String emaiId) {
		return loginManagementDao.getAuthorityByEmailId(emaiId);
	}

	@Override
	public void setUserLogoutTime(String userEmailId) {
		loginManagementDao.setUserLogoutTime(userEmailId);
	}

	@Override
	public void updateRecentActivities(String userName) {
		loginManagementDao.updateRecentActivities(userName);
	}

	@Override
	public void updateUserBrowsingPatterns(UserBrowsingPatternsDom userBrowsingPatternsDom, String userEmailId) {
		loginManagementDao.updateUserBrowsingPatterns(userBrowsingPatternsDom,userEmailId);
	}

	@Override
	public String getEntityNameByEmailId(String userId) {
		return loginManagementDao.getEntityNameByEmailId(userId);
	}

	@Override
	public String getEnabledStatusByUsername(String userName) {
		
		return loginManagementDao.getEnabledStatusByUsername(userName);
	}

	@Override
	public void updateEnabledStatusByUsername(String userName) {
		loginManagementDao.updateEnabledStatusByUsername(userName);
	}

	@Override
	public List<LoginManagementDom> getUsers(String companyName) {
		return loginManagementDao.getUsers(companyName);
	}

	@Override
	public void updateUserDetails(LoginManagementDom userDetails) {
		loginManagementDao.updateUserDetails(userDetails);
	}

	@Override
	public void addUser(LoginManagementDom userDetails) {
		loginManagementDao.addUser(userDetails);
	}

	@Override
	public void disableUsers(Map<String, String> disableUser) {
		loginManagementDao.disableUsers(disableUser);
	}

	@Override
	public void enableUsers(Map<String, String> enableUser) {
		loginManagementDao.enableUsers(enableUser);
	}

	@Override
	public List<LoginManagementDom> getUserDetails() {
		return loginManagementDao.getUserDetails();
	}

	@Override
	public List<StudentDom> getUnverifiedPhotoStudents() {
		return loginManagementDao.getUnverifiedPhotoStudents();
	}

	@Override
	public void verifyUserPhoto(String userName) {
		loginManagementDao.verifyUserPhoto(userName);
	}

	@Override
	public void rejectUserPhoto(String userName) {
		loginManagementDao.rejectUserPhoto(userName);
	}

	@Override
	public List<StudentDom> getUnverifiedVideoStudents() {
		
		return loginManagementDao.getUnverifiedVideoStudents();
	}

	@Override
	public boolean checkBetaUserExists(String emailId) {
		return loginManagementDao.checkBetaUserExists(emailId);
	}

	@Override
	public int insertBetaUser(BetaUserDom betaUser) {
		return loginManagementDao.insertBetaUser(betaUser);
	}
	
	public List<BetaUserDom> getBetaUsers() {
		return loginManagementDao.getBetaUsers();
	}

	@Override
	public void updateBetaUserStatus(String emailId, String status) {
		loginManagementDao.updateBetaUserStatus(emailId, status );
		
	}

	@Override
	public void enableUser(String emailId) {
		loginManagementDao.enableUser(emailId);
		
	}

	@Override
	public String getLastInsertedBetaCompanyNumber() {
		return loginManagementDao.getLastInsertedBetaCompanyNumber();
	}

	@Override
	public String getLastInsertedBetaUniversityNumber() {
		return loginManagementDao.getLastInsertedBetaUniversityNumber();
	}

	@Override
	public void verifyUserVideo(String userName) {
		loginManagementDao.verifyUserVideo(userName);
	}

	@Override
	public void rejectUserVideo(String userName) {
		loginManagementDao.rejectUserVideo(userName);
	}

	@Override
	public boolean checkEntityExist(String string) {
		return loginManagementDao.checkEntityExist(string);
	}

	
	public List<String> getMasterResults(String masterType) {
		return loginManagementDao.getMasterResults(masterType);
	}

	@Override
	public void deleteMasterValue(String masterType, String masterValue) {
		 loginManagementDao.deleteMasterValue(masterType,masterValue);
	}

	@Override
	public void addMasterValue(String masterType, String masterValue) {
		loginManagementDao.addMasterValue(masterType,masterValue);
	}

	@Override
	public Boolean checkMasterValueExists(String masterType, String masterValue) {
		return loginManagementDao.checkMasterValueExists(masterType,masterValue);
	}

	@Override
	public void updateMasterValue(String masterType, String oldValue,String newMasterValue) {
		loginManagementDao.updateMasterValue(masterType,oldValue,newMasterValue);
	}

	@Override
	public void addMasterValues(Set<String> elements,String masterType) {
		loginManagementDao.addMasterValues(elements,masterType);
	}

	@Override
	public void changeCompanyNameforNonPrimarykeys(LoginManagementDom loginManagentDom) {
		loginManagementDao.changeCompanyNameforNonPrimarykeys(loginManagentDom);
		}
		
	public Long getJobViewedCount(String jobIdAndFirmId) {
		return loginManagementDao.getJobViewedCount(jobIdAndFirmId);
	}

	@Override
	public Long getInternshipViewedCount(String internshipIdAndFirmId) {
		return loginManagementDao.getInternshipViewedCount(internshipIdAndFirmId);
	}

	@Override
	public Long getCampusJobViewedCount(String jobId, String universityName) {
		return loginManagementDao.getCampusJobViewedCount(jobId,universityName);
	}

	@Override
	public Long getCampusInternshipViewedCount(String internshipId,String universityName) {
		return loginManagementDao.getCampusInternshipViewedCount(internshipId,universityName);
	}

	
}
