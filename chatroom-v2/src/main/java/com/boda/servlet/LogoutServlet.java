package com.boda.servlet;

import com.boda.util.ChatRoomManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String username = (String) session.getAttribute("username");

            if (username != null) {
                // 从在线用户列表移除
                ChatRoomManager manager = ChatRoomManager.getInstance();
                manager.userLogout(username);

                System.out.println("用户退出: " + username);
            }

            // 使会话无效
            session.invalidate();
        }

        // 重定向到登录页面
        response.sendRedirect("login.jsp");
    }
}