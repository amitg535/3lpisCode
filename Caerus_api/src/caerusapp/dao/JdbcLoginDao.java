package caerusapp.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.cassandra.core.CassandraOperations;

import caerusapp.domain.UserPOJO;

public class JdbcLoginDao implements ILoginDao {

	@Autowired
	CassandraOperations cassandraOperations;
	
	public UserPOJO authenticateUser(String username) {
		  
		UserPOJO user = cassandraOperations.selectOneById(UserPOJO.class, username);
	
		if(user == null)
		{
			user = new UserPOJO();
			user.setAuthority("Anonymous User");
		}
		
		return user;
	}

}
