<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>在线聊天室登录</title>
</head>
<body>
<h2>进入聊天室</h2>
<form action="<%= request.getContextPath() %>/login" method="post">
    <label>昵称：
        <input type="text" name="username" required>
    </label>
    <button type="submit">进入</button>
</form>
<p style="color:red;">
    <%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %>
</p>
</body>
</html>
