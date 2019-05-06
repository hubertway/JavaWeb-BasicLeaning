package life;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class LifeServlet implements Servlet {

	/**
	 * 初始化方法
	 * 执行者：服务器
	 * 执行次数：一次
	 * 执行时机：默认第一次访问的时候
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println("wu~~~~wa~~~~");
	}
	
	/**
	 * 服务方法
	 * 执行者：服务器
	 * 执行次数：请求一次执行一次
	 * 执行时机：有请求的时候
	 */
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		System.out.println("swag~~~~skr~~~~~");
	}
	
	/**
	 * 销毁方法
	 * 执行者：服务器
	 * 执行次数：只执行一次
	 * 执行时机：当servlet被移除或服务器正常关闭时
	 */
	public void destroy() {
		System.out.println("The night king is coming!~");
	}
	
	@Override
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}


}
