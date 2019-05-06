package service;

import java.sql.SQLException;

import domain.User;

import dao.UserDao;

public class UserService {
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @return User用户
	 * @throws SQLException 
	 */
	public User login(String username, String password) throws SQLException {
		//调用dao
		UserDao dao = new UserDao();
		return dao.getUserByNameAndPassword(username,password);
	}

}
