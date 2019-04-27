package myconnection;

import java.sql.Connection;

public class TestDS {
	public static void main(String[] args) throws Exception {
		 MyDS  md = new  MyDS();
		Connection conn=md.getConnection();
		System.out.println(conn);
		conn.close();
	}
}
