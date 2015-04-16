package caerusapp.dao;

import caerusapp.domain.UserPOJO;

public interface ILoginDao {

	UserPOJO authenticateUser(String username);

}
