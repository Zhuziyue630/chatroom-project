<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>聊天室登录</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            width: 350px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #667eea;
            outline: none;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .login-btn:hover {
            transform: translateY(-2px);
        }

        .error-message {
            background: #ffebee;
            color: #d32f2f;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
        }

        .info-message {
            background: #e3f2fd;
            color: #1565c0;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
        }

        .password-hint {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>聊天室 2.0</h2>

    <c:if test="${not empty param.error}">
        <div class="error-message">
            ❌ ${param.error}
        </div>
    </c:if>

    <c:if test="${not empty param.message}">
        <div class="info-message">
            ✅ ${param.message}
        </div>
    </c:if>

    <form action="login" method="post">
        <div class="input-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username"
                   placeholder="请输入用户名(2-10位)" required>
        </div>

        <div class="input-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password"
                   placeholder="请输入密码" required>
            <div class="password-hint">默认密码: 123456</div>
        </div>

        <button type="submit" class="login-btn">登录聊天室</button>
    </form>

    <div style="margin-top: 20px; color: #666; font-size: 14px;">
        功能特性：事件监听 | 过滤器 | 实时聊天
    </div>
</div>
</body>
</html>