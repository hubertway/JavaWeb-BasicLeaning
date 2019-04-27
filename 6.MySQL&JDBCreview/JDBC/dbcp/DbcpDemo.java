package dbcp;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.dbcp.BasicDataSourceFactory;
import org.junit.Test;

import utils.JdbcUtils;

public class DbcpDemo {
	@Test
	public void f1() throws Exception {//硬编码
		//创建连接池
		BasicDataSource ds=new BasicDataSource();
		//配置信息
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql:///day07");
		ds.setUsername("root");
		ds.setPassword("1234");
		
		Connection conn = ds.getConnection();
		String sql = "INSERT INTO category VALUES(?,?);";
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString(1, "c011");
		st.setString(2, "饮料");
		
		int i = st.executeUpdate();
		System.out.println(i);
		JdbcUtils.closeResource(conn, st, null);
	}

	@Test
	public void f2() throws Exception {//配置文件
		//存放配置文件
		Properties prop = new Properties();
		prop.load(new FileInputStream("src/dbcp.properties"));
		//创建连接池
		DataSource ds = new BasicDataSourceFactory().createDataSource(prop);
		
		Connection conn = ds.getConnection();
		String sql = "INSERT INTO category VALUES(?,?);";
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString(1, "c012");
		st.setString(2, "小吃");
		
		int i = st.executeUpdate();
		System.out.println(i);
		JdbcUtils.closeResource(conn, st, null);
	}
}
