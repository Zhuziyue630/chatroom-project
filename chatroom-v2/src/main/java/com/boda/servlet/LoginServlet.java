package com.boda.servlet;

import com.boda.model.User;
import com.boda.util.ChatRoomManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=用户名不能为空");
            return;
        }

        if (username.length() < 2 || username.length() > 10) {
            response.sendRedirect("login.jsp?error=用户名长度应在2-10个字符之间");
            return;
        }

        // 简单密码验证
        if (!"123456".equals(password)) {
            response.sendRedirect("login.jsp?error=密码错误");
            return;
        }

        // 获取用户IP
        String ipAddress = request.getRemoteAddr();

        // 创建用户对象
        User user = new User(username, ipAddress);

        // 添加到在线用户列表
        ChatRoomManager manager = ChatRoomManager.getInstance();
        manager.userLogin(user);

        // 创建会话
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("ipAddress", ipAddress);

        // 设置会话超时时间（30分钟）
        session.setMaxInactiveInterval(30 * 60);

        System.out.println("用户登录成功: " + username + ", IP: " + ipAddress);

        // 重定向到聊天页面
        response.sendRedirect("chat.jsp");
    }
}