package com.boda.model;

import java.util.Date;

public class User {
    private String username;
    private Date loginTime;
    private String ipAddress;

    public User() {
        this.loginTime = new Date();
    }

    public User(String username, String ipAddress) {
        this.username = username;
        this.ipAddress = ipAddress;
        this.loginTime = new Date();
    }

    // Getter和Setter方法
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public Date getLoginTime() { return loginTime; }
    public void setLoginTime(Date loginTime) { this.loginTime = loginTime; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
}