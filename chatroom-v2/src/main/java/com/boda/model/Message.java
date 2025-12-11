package com.boda.model;

import java.util.Date;

public class Message {
    private String username;
    private String content;
    private Date timestamp;
    private String ipAddress;
    private String targetUser;  // 私聊目标用户（null表示群聊）
    private boolean isSystem;   // 是否为系统消息

    public Message() {
        this.timestamp = new Date();
        this.isSystem = false;
    }

    public Message(String username, String content, String ipAddress) {
        this.username = username;
        this.content = content;
        this.ipAddress = ipAddress;
        this.timestamp = new Date();
        this.isSystem = false;
        this.targetUser = null;
    }

    // 私聊构造函数
    public Message(String username, String content, String ipAddress, String targetUser) {
        this.username = username;
        this.content = content;
        this.ipAddress = ipAddress;
        this.targetUser = targetUser;
        this.timestamp = new Date();
        this.isSystem = false;
    }

    // 系统消息构造函数
    public Message(String content, boolean isSystem) {
        this.username = "系统消息";
        this.content = content;
        this.timestamp = new Date();
        this.isSystem = isSystem;
        this.ipAddress = "127.0.0.1";
        this.targetUser = null;
    }

    // Getter和Setter方法
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getTimestamp() { return timestamp; }
    public void setTimestamp(Date timestamp) { this.timestamp = timestamp; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getTargetUser() { return targetUser; }
    public void setTargetUser(String targetUser) { this.targetUser = targetUser; }

    public boolean getIsSystem() { return isSystem; }
    public void setIsSystem(boolean isSystem) { this.isSystem = isSystem; }

    // 检查是否为私聊消息
    public boolean isPrivate() {
        return targetUser != null && !targetUser.isEmpty();
    }
}