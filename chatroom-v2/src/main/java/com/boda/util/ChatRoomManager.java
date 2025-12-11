package com.boda.util;

import com.boda.model.Message;
import com.boda.model.User;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

public class ChatRoomManager {
    private static volatile ChatRoomManager instance;
    private List<Message> messages;
    private Map<String, User> onlineUsers;
    private int visitorCount;

    // 添加消息锁，解决多线程问题
    private final Object messageLock = new Object();
    private final Object userLock = new Object();

    private ChatRoomManager() {
        // 使用线程安全的集合
        messages = new CopyOnWriteArrayList<>();
        onlineUsers = new ConcurrentHashMap<>();
        visitorCount = 0;
    }

    // 双重检查锁定，解决多线程问题
    public static ChatRoomManager getInstance() {
        if (instance == null) {
            synchronized (ChatRoomManager.class) {
                if (instance == null) {
                    instance = new ChatRoomManager();
                }
            }
        }
        return instance;
    }

    // 线程安全的添加消息方法
    public void addMessage(Message message) {
        synchronized (messageLock) {
            messages.add(message);
            // 限制消息数量，最多保留100条
            if (messages.size() > 100) {
                messages.remove(0);
            }
        }
    }

    // 添加系统消息
    public void addSystemMessage(String content) {
        Message systemMsg = new Message(content, true);
        addMessage(systemMsg);
    }

    // 获取所有公开消息（非私聊）
    public List<Message> getPublicMessages() {
        List<Message> publicMessages = new ArrayList<>();
        synchronized (messageLock) {
            for (Message msg : messages) {
                if (!msg.isPrivate() && !msg.getUsername().equals("系统消息")) {
                    publicMessages.add(msg);
                }
            }
        }
        return publicMessages;
    }

    // 获取用户相关的消息（公开消息+发给该用户的私聊）
    public List<Message> getUserMessages(String username) {
        List<Message> userMessages = new ArrayList<>();
        synchronized (messageLock) {
            for (Message msg : messages) {
                // 包括：公开消息、系统消息、发给该用户的私聊
                if (!msg.isPrivate() ||
                        msg.getIsSystem() ||
                        msg.getTargetUser() != null && msg.getTargetUser().equals(username) ||
                        msg.getUsername() != null && msg.getUsername().equals(username)) {
                    userMessages.add(msg);
                }
            }
        }
        return userMessages;
    }

    // 获取所有消息（包括私聊）
    public List<Message> getAllMessages() {
        return new ArrayList<>(messages);
    }

    // 线程安全的用户登录
    public void userLogin(User user) {
        synchronized (userLock) {
            onlineUsers.put(user.getUsername(), user);
        }
        // 添加系统消息
        addSystemMessage("欢迎 " + user.getUsername() + " 进入聊天室！");
    }

    // 线程安全的用户退出
    public void userLogout(String username) {
        synchronized (userLock) {
            onlineUsers.remove(username);
        }
        // 添加系统消息
        addSystemMessage(username + " 离开了聊天室。");
    }

    // 获取在线用户（线程安全）
    public List<User> getOnlineUsers() {
        return new ArrayList<>(onlineUsers.values());
    }

    // 获取在线用户名列表
    public List<String> getOnlineUsernames() {
        return new ArrayList<>(onlineUsers.keySet());
    }

    // 检查用户是否在线
    public boolean isUserOnline(String username) {
        return onlineUsers.containsKey(username);
    }

    // 访客计数（线程安全）
    public void incrementVisitorCount() {
        synchronized (this) {
            visitorCount++;
        }
    }

    public int getVisitorCount() {
        return visitorCount;
    }
}