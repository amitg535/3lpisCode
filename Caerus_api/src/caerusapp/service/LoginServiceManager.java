package caerusapp.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import caerusapp.dao.ILoginDao;
import caerusapp.domain.UserPOJO;

public class LoginServiceManager implements UserDetailsService {
	
	ILoginDao loginDao;
		
	public ILoginDao getLoginDao() {
		return loginDao;
	}

	public void setLoginDao(ILoginDao loginDao) {
		this.loginDao = loginDao;
	}

	
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		UserPOJO user = loginDao.authenticateUser(username);
		
		List<GrantedAuthority> authorities = buildUserAuthority(user.getAuthority());
 
		return buildUserForAuthentication(user, authorities);
		
	}
	
	private User buildUserForAuthentication(UserPOJO user,List<GrantedAuthority> authorities) {
			return new User(user.getUsername(),user.getPassword(), user.getEnabled(), true, true, true, authorities);
		}
	 
		private List<GrantedAuthority> buildUserAuthority(String userRole) {
	 
			Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();
	 
			// Build user's authorities
			/*for (UserRole userRole : userRoles) {*/
				setAuths.add(new SimpleGrantedAuthority(userRole));
			//}
	 
			List<GrantedAuthority> Result = new ArrayList<GrantedAuthority>(setAuths);
	 
			return Result;
		}

}
