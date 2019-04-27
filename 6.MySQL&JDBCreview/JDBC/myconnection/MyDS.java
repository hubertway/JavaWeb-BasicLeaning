package myconnection;

import java.sql.Connection;
import java.util.LinkedList;

import utils.JdbcUtils;

public class MyDS {
	static LinkedList<Connection> pool= new LinkedList<>();
	
	static {
		//初始化
		for (int i = 0; i < 3; i++) {
			try {
				Connection conn = JdbcUtils.getConnection();
				pool.add(conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	//从连接池中获取连接
	public static Connection getConnection() {
		if(pool.isEmpty()) {
			//再添加
			for (int i = 0; i < 3; i++) {
				try {
					Connection conn = JdbcUtils.getConnection();
					pool.add(conn);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println("从连接池中获取一个连接");
		Connection conn = pool.removeFirst();
		ConnectionWrap myconn = new ConnectionWrap(conn,pool);
		return myconn;
	}
	
	//归还连接的方法
	public static void addBack( Connection conn) {
		pool.addLast(conn);
		System.out.println("连接已经归还");
	}
}
