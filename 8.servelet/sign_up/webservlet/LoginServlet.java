package web.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;

import service.UserService;

public class LoginServlet extends HttpServlet{
	
	@Override
	//初始化登录次数
	public void init() throws ServletException {
		//获取全局管理者
		ServletContext  context= getServletContext();
		//初始化次数
		context.setAttribute("count", 0);
		System.out.println("初始化次数成功");
	}
	
	
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
			response.getWriter().print("Mismatch,3秒后跳转");
			//定时跳转
			response.setHeader("refresh", "3;url=/3.2sign_up/login.htm");
		}else {
			response.getWriter().print(user.getUsername()+":Welcome back" );
			//获取全局管理者
			ServletContext  context = this.getServletContext();
			//获取总次数
			Integer cnt = (Integer)context.getAttribute("count");
			//将次数+1
			cnt++;
			//将此事再次放入域对象中
			context.setAttribute("count", cnt);
		}
	}
}
