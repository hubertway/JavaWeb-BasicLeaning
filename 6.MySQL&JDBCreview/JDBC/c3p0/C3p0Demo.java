package c3p0;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.junit.Test;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import utils.JdbcUtils;

public class C3p0Demo {
	@Test
	public void f1() throws Exception { //硬编码
		ComboPooledDataSource ds = new ComboPooledDataSource();
		ds.setDriverClass("com.mysql.jdbc.Driver");
		ds.setJdbcUrl("jdbc:mysql:///day07");
		ds.setUser("root");
		ds.setPassword("1234");
		
		Connection conn = ds.getConnection();
		String sql = "INSERT INTO category VALUES(?,?);";
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString(1, "c013");
		st.setString(2, "毒药");
		
		int i = st.executeUpdate();
		System.out.println(i);
		JdbcUtils.closeResource(conn, st, null);
	}
	
	@Test
	public void f2() throws Exception { //配置文件
		ComboPooledDataSource ds = new ComboPooledDataSource();
		
		Connection conn = ds.getConnection();
		String sql = "INSERT INTO category VALUES(?,?);";
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString(1, "c015");
		st.setString(2, "解药");
		
		int i = st.executeUpdate();
		System.out.println(i);
		JdbcUtils.closeResource(conn, st, null);
	}
	
}
