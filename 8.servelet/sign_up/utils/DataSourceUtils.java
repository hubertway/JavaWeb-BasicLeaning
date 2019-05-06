package utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DataSourceUtils {
	private static ComboPooledDataSource ds = new ComboPooledDataSource();
	
	/**
	 * 获取数据源
	 * @return 连接池
	 */
	public static DataSource getDataSource() {
		return ds;
	}
	
	/**
	 * 获取连接
	 * @return 连接
	 * @throws Exception
	 */
	public static Connection getConnection() throws Exception {
		return ds.getConnection();
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
