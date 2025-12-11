<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>聊天室 2.0 增强版</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .welcome-container {
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 900px;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 36px;
            background: linear-gradient(to right, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .subtitle {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin: 40px 0;
        }

        .feature-card {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .feature-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .feature-title {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .feature-desc {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }

        .start-btn {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 18px 40px;
            border-radius: 12px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 30px;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .start-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .version-info {
            margin-top: 30px;
            color: #888;
            font-size: 14px;
        }

        .tech-stack {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .tech-badge {
            background: #e3f2fd;
            color: #1976d2;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="welcome-container">
    <h1>聊天室 2.0 增强版</h1>
    <p class="subtitle">基于 Jakarta EE | 线程安全 | 私聊功能 | 实时通知</p>

    <div class="features">
        <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3 class="feature-title">事件监听</h3>
            <p class="feature-desc">实时监控会话创建与销毁，自动管理用户状态</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">🔧</div>
            <h3 class="feature-title">过滤器</h3>
            <p class="feature-desc">字符编码过滤与登录验证，确保系统安全</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">💬</div>
            <h3 class="feature-title">私聊功能</h3>
            <p class="feature-desc">支持一对一私密聊天，保护隐私</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">⚡</div>
            <h3 class="feature-title">线程安全</h3>
            <p class="feature-desc">双重检查锁定，解决多线程并发问题</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">🔔</div>
            <h3 class="feature-title">实时通知</h3>
            <p class="feature-desc">用户进出聊天室实时广播通知</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">📊</div>
            <h3 class="feature-title">数据统计</h3>
            <p class="feature-desc">实时显示在线用户、消息总数等统计信息</p>
        </div>
    </div>

    <div class="tech-stack">
        <span class="tech-badge">Jakarta EE 9.1</span>
        <span class="tech-badge">Tomcat 11</span>
        <span class="tech-badge">Java 17</span>
        <span class="tech-badge">JSTL 2.0</span>
        <span class="tech-badge">线程安全</span>
    </div>

    <a href="login.jsp" class="start-btn">开始体验增强版聊天室</a>

    <div class="version-info">
        <p>版本: 2.0.0 增强版 | 技术支持: 事件监听 + 过滤器 + 私聊功能</p>
        <p style="margin-top: 10px;">默认登录密码: 123456 | 快捷键: Ctrl+Enter发送 | ESC取消私聊</p>
    </div>
</div>
</body>
</html>