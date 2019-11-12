package com.yz.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.yz.model.User;

/**
 * @author ZGD
 * @version 创建时间：2019年10月18日 下午4:21:35 
 * 类说明:登陆拦截器
 */
public class LoginInterceptor implements HandlerInterceptor {

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// 获取请求的RUi:去除http:localhost:8080这部分剩下的
		String uri = request.getRequestURI();
		// UTL:除了login.jsp是可以公开访问的，其他的URL都进行拦截控制
		if (uri.indexOf("/login") >= 0) {
			return true;
		}
		// 获取session
		HttpSession session = request.getSession();
		String username =  (String) session.getAttribute("username");
		// 判断session中是否有用户数据，如果有，则返回true，继续向下执行
		if (username != null) {
			return true;
		}
		// 不符合条件的给出提示信息，并转发到登录页面
		request.setAttribute("msg", "您还没有登录，请先登录！");
		request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request,
				response);
		return false;
	}

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
