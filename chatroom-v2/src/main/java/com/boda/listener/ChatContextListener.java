package com.boda.listener;

import com.boda.util.ChatRoomManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ChatContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("聊天室应用程序启动...");

        // 初始化聊天室管理器
        ChatRoomManager manager = ChatRoomManager.getInstance();
        System.out.println("聊天室管理器初始化完成");

        // 将管理器保存到应用上下文
        sce.getServletContext().setAttribute("chatRoomManager", manager);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("聊天室应用程序关闭...");
        // 清理资源
    }
}