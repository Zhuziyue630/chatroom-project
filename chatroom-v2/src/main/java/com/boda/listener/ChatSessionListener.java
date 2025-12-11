package com.boda.listener;

import com.boda.util.ChatRoomManager;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class ChatSessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        System.out.println("新会话创建: " + session.getId());

        // 增加访客计数
        ChatRoomManager manager = ChatRoomManager.getInstance();
        manager.incrementVisitorCount();

        System.out.println("当前访客总数: " + manager.getVisitorCount());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String username = (String) session.getAttribute("username");

        if (username != null) {
            System.out.println("用户退出: " + username);
            ChatRoomManager manager = ChatRoomManager.getInstance();
            manager.userLogout(username); // 这会自动添加系统消息
        }

        System.out.println("会话销毁: " + session.getId());
    }
}