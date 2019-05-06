package dao;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import domain.User;
import utils.DataSourceUtils;

public class UserDao {

	/**
	 * 登录
	 * @param username
	 * @param password
	 * @return 用户
	 * @throws SQLException 
	 */
	public User getUserByNameAndPassword(String username, String password) throws SQLException {
		//创建queryrunner
		QueryRunner qr =  new QueryRunner(DataSourceUtils.getDataSource());
		//编写sql
		String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
		//执行sql
		User user= qr.query(sql, new BeanHandler<>(User.class), username,password);
		return user;
	}

}
