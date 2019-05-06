package webservlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;

import service.UserService;

public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     //设置编码
		response.setContentType("text/html;charset=utf-8");
		//接收用户名和密码
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//调用userservice里的login(username,password) 返回值User user
		User user=null;
		try {
			user = new UserService().login(username,password);
		} catch (SQLException e) {
			e.printStackTrace();
//			throw new RuntimeException("网络异常，稍好再试");
		}
		//判断user是否为空 ：空则“Mismatch”，不空则“Welcome”
		if(user==null) {
			response.getWriter().print("Mismatch");
		}else {
			response.getWriter().print(user.getUsername()+":Welcome back" );
		}
	}
}
