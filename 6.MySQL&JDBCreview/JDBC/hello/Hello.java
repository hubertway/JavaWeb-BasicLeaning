package hello;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.Test;

import utils.JdbcUtils;

public class Hello {
	
	@Test
	public void f1() {
		System.out.println("hello");
	}
	
	@Test
	public void f2() throws Exception {
//		注册驱动
		Class.forName("com.mysql.jdbc.Driver");
//		获取连接
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/day07","root","1234");		
//		编写sql
		String sql="select * from category;";
//		创建预编译的语句执行者
		PreparedStatement st = conn.prepareStatement(sql);
//		设置参数
		
//		执行sql
		ResultSet rs =st.executeQuery();		
//		处理结果
		while(rs.next()) {
			System.out.println(rs.getString("cid")+"::"+rs.getString("cname"));
		}	
//		释放资源
		rs.close();
		st.close();
		conn.close();
	}
	
	@Test
	public void f3() {
		//插入数据语句
		Connection conn=null;
		ResultSet rs = null;
		PreparedStatement st = null;
		
		try {
			//获取链接
			conn = JdbcUtils.getConnection();	
			//编写sql
			String sql = "insert into category values(?,?);";
			//获取语句执行者
			st = conn.prepareStatement(sql);
			//设置参数
			st.setString(1, "c006");
			st.setString(2, "数码");	
			//执行sql
			int i = st.executeUpdate();
			//处理结果
			if(i==1) {
				System.out.println("successful");
			}else {
				System.out.println("false");
			}		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			//释放资源
			JdbcUtils.closeResource(conn, st, rs);
		}
	}
	
	@Test
	public void f4() {
		//更新操作
		Connection conn=null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			conn = JdbcUtils.getConnection();
			String sql = "update category set cname=? where cid=?;";
			st=conn.prepareStatement(sql);
			st.setString(1, "手机");
			st.setString(2, "c006");
			int i=st.executeUpdate();
			if(i==1) {
				System.out.println("successful");
			}else {
				System.out.println("false");
			}	
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JdbcUtils.closeResource(conn, st, rs);
		}
	}
	
	@Test
	public void f5() {
		//删除操作
		Connection conn=null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			conn=JdbcUtils.getConnection();
			String sql = "DELETE FROM category WHERE cid=?;";
			st = conn.prepareStatement(sql);
			st.setString(1, "c006");
			int i = st.executeUpdate();
			if(i==1) {
				System.out.println("successful");
			}else {
				System.out.println("false");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JdbcUtils.closeResource(conn, st, rs);
		}
	}
}
