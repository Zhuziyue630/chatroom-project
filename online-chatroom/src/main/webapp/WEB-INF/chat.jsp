<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.chatroom.model.Message,java.util.List" %>
<%
    List<Message> messages = (List<Message>) request.getAttribute("messages");
    if (messages == null) {
        messages = java.util.Collections.emptyList();
    }
    List<String> users = (List<String>) request.getAttribute("users");
    if (users == null) {
        users = java.util.Collections.emptyList();
    }
    jakarta.servlet.http.HttpSession currentSession = request.getSession(false);
    String username = currentSession == null ? null : (String) currentSession.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>聊天室</title>
</head>
<body>
<h2>欢迎：<%= username == null ? "游客" : username %></h2>

<div style="display:flex;gap:20px;">
    <div style="flex:2;border:1px solid #ccc;padding:10px;height:300px;overflow:auto;">
        <h3>聊天记录</h3>
        <ul>
            <% for (Message msg : messages) { %>
            <li>
                <strong><%= msg.getSender() %>：</strong>
                <%= msg.getContent() %>
                <small>(<%= msg.getTime() %>)</small>
            </li>
            <% } %>
        </ul>
    </div>
    <div style="flex:1;border:1px solid #ccc;padding:10px;height:300px;overflow:auto;">
        <h3>在线用户</h3>
        <ul>
            <% for (String user : users) { %>
            <li><%= user %></li>
            <% } %>
        </ul>
    </div>
</div>

<form action="<%= request.getContextPath() %>/chat" method="post" style="margin-top:15px;">
    <input type="text" name="message" placeholder="说点什么..." required>
    <button type="submit">发送</button>
</form>

<form action="<%= request.getContextPath() %>/logout" method="post" style="margin-top:10px;">
    <button type="submit">退出聊天室</button>
</form>
</body>
</html>
