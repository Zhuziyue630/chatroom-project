package com.boda.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("登录检查过滤器初始化...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        System.out.println("LoginFilter: 检查访问 " + uri);

        // 检查用户是否已登录
        if (session == null || session.getAttribute("username") == null) {
            System.out.println("未登录，重定向到登录页面");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 继续处理请求
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("登录检查过滤器销毁...");
    }
}