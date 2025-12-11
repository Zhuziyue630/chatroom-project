package com.boda.servlet;

import com.boda.model.Message;
import com.boda.util.ChatRoomManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/sendMessage")
public class MessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String content = request.getParameter("message");
        String targetUser = request.getParameter("targetUser"); // 私聊目标用户
        String ipAddress = (String) session.getAttribute("ipAddress");

        if (content != null && !content.trim().isEmpty()) {
            Message message;

            if (targetUser != null && !targetUser.trim().isEmpty()) {
                // 私聊消息
                message = new Message(username, content.trim(), ipAddress, targetUser.trim());
                // 添加[私聊]前缀
                message.setContent("[私聊给 " + targetUser.trim() + "] " + content.trim());
            } else {
                // 群聊消息
                message = new Message(username, content.trim(), ipAddress);
            }

            // 添加到消息列表
            ChatRoomManager manager = ChatRoomManager.getInstance();
            manager.addMessage(message);

            System.out.println("新消息: " + username + " → " +
                    (targetUser != null ? targetUser : "所有人") + " - " + content);
        }

        // 返回聊天页面
        response.sendRedirect("chat.jsp");
    }
}