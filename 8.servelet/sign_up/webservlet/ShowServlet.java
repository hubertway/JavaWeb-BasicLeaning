package web.servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 展示登录人数的总次数
 */
public class ShowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置编码
		response.setContentType("text/html;charset=utf-8");
		//获取全局管理者
		ServletContext context = this.getServletContext();
		//获取登录次数
		Integer cnt = (Integer) context.getAttribute("count");
		// 在页面打印总次数
		response.getWriter().print("登录成功的次数为"+cnt);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		doGet(request, response);
	}

}
