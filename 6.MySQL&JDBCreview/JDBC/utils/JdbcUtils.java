package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

public class JdbcUtils {
	//块编辑，alt+shift+A
	static final String DRIVERCLASS;
	static final String URL;
	static final String USER;
	static final String PASSWORD;
	
	static {
		//获取ResourceBundle
		ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
		
		//获取指定内容
		DRIVERCLASS = bundle.getString("driverClass");
		URL = bundle.getString("url");
		USER = bundle.getString("user");
		PASSWORD = bundle.getString("password");
	}
	
	static {
		//注册驱动
		try {
			Class.forName(DRIVERCLASS);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws Exception {
		//获取连接
		return DriverManager.getConnection(URL,USER,PASSWORD);
	}

	/**
	 * 释放资源
	 * @param conn 链接
	 * @param st 语句执行者
	 * @param rs 结果集
	 */
	public static void closeResource(Connection conn, Statement st, ResultSet rs) {
		closeResultSet(rs);	
		closeStatement(st);
		closeConnection(conn);			
	}
	
	/**
	 *  释放链接
	 * @param conn
	 */
	public static void closeConnection(Connection conn) {
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn = null;
		}
	}
	
	/**
	 * 	释放语句执行知
	 * @param st
	 */
	public static void closeStatement(Statement st) {
		if(st!=null) {
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			st = null;
		}
	}
	
	/**
	 * 	释放结果集
	 * @param rs
	 */
	public static void closeResultSet(ResultSet rs) {
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rs = null;
		}
	}
	
}
