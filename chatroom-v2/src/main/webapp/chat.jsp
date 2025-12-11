<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>聊天室 2.0 - 增强版</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: #f0f2f5;
            height: 100vh;
        }

        .chat-container {
            display: flex;
            height: 100vh;
            max-width: 1600px;
            margin: 0 auto;
            padding: 20px;
            gap: 20px;
        }

        /* 左侧用户面板 */
        .user-panel {
            width: 300px;
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
        }

        .user-header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
        }

        .user-details h3 {
            color: #333;
            margin-bottom: 5px;
        }

        .user-details p {
            color: #666;
            font-size: 12px;
        }

        .private-chat-section {
            margin-top: 20px;
            flex: 1;
        }

        .private-chat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .private-chat-header h4 {
            color: #333;
        }

        .refresh-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
        }

        .user-list {
            list-style: none;
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 20px;
        }

        .user-list li {
            padding: 12px;
            margin-bottom: 8px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: background 0.3s;
        }

        .user-list li:hover {
            background: #e9ecef;
        }

        .user-list li.active {
            background: #e3f2fd;
            border: 2px solid #2196f3;
        }

        .user-list li .user-info-side {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-status {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .user-status.online {
            background: #4CAF50;
        }

        .user-status.offline {
            background: #ccc;
        }

        .private-message-btn {
            background: #ff9800;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        /* 中间聊天区域 */
        .chat-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .chat-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-mode {
            display: flex;
            gap: 10px;
        }

        .mode-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .mode-btn.active {
            background: rgba(255,255,255,0.4);
        }

        .logout-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        .message-area {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: #fafafa;
        }

        .message {
            margin-bottom: 15px;
            max-width: 80%;
            animation: fadeIn 0.3s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .message.self {
            margin-left: auto;
        }

        .message.system {
            max-width: 100%;
            text-align: center;
        }

        .message-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 5px;
            flex-wrap: wrap;
        }

        .message-username {
            font-weight: bold;
            color: #333;
        }

        .message.system .message-username {
            color: #ff5722;
            font-weight: bold;
        }

        .message-time {
            color: #999;
            font-size: 12px;
        }

        .message-ip {
            color: #666;
            font-size: 11px;
            background: #f0f0f0;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .private-tag {
            background: #ff9800;
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 11px;
            margin-left: 5px;
        }

        .message-content {
            background: white;
            padding: 12px 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            word-break: break-word;
        }

        .message.self .message-content {
            background: #e3f2fd;
        }

        .message.system .message-content {
            background: #fff3e0;
            border-left: 4px solid #ff9800;
        }

        /* 消息输入区域 */
        .input-area {
            padding: 20px;
            border-top: 1px solid #eee;
            background: white;
        }

        .chat-info {
            margin-bottom: 10px;
            color: #666;
            font-size: 14px;
            padding: 8px 12px;
            background: #f8f9fa;
            border-radius: 6px;
        }

        .input-group {
            display: flex;
            gap: 10px;
        }

        .message-input {
            flex: 1;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 14px;
            resize: none;
            font-family: inherit;
        }

        .message-input:focus {
            border-color: #667eea;
            outline: none;
        }

        .send-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: transform 0.2s;
        }

        .send-btn:hover {
            transform: translateY(-2px);
        }

        /* 右侧统计面板 */
        .stats-panel {
            width: 280px;
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
        }

        .stats-header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .stat-item {
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .stat-value {
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }

        .thread-info {
            background: #e8f5e9;
            border-left: 4px solid #4CAF50;
        }

        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 20px;
        }

        .action-btn {
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .refresh-all {
            background: #2196f3;
            color: white;
        }

        .clear-chat {
            background: #ff5722;
            color: white;
        }

        .export-chat {
            background: #4CAF50;
            color: white;
        }

        /* 滚动条样式 */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }

        ::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }

        .empty-message {
            text-align: center;
            color: #999;
            padding: 40px;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="chat-container">
    <!-- 左侧用户面板 -->
    <div class="user-panel">
        <div class="user-header">
            <h3>在线用户 (${chatRoomManager.onlineUsers.size()})</h3>
        </div>

        <div class="user-info">
            <div class="avatar">
                ${sessionScope.username.charAt(0)}
            </div>
            <div class="user-details">
                <h3>${sessionScope.username}</h3>
                <p>IP: ${sessionScope.ipAddress}</p>
                <p>线程: ${Thread.currentThread().getName()}</p>
            </div>
        </div>

        <div class="private-chat-section">
            <div class="private-chat-header">
                <h4>私聊对象</h4>
                <button class="refresh-btn" onclick="refreshUsers()">刷新</button>
            </div>

            <ul class="user-list" id="userList">
                <c:forEach var="user" items="${chatRoomManager.onlineUsers}">
                    <c:if test="${user.username ne sessionScope.username}">
                        <li onclick="selectUser('${user.username}')" id="user-${user.username}">
                            <div class="user-info-side">
                                <span class="user-status online"></span>
                                <span>${user.username}</span>
                            </div>
                            <button class="private-message-btn" onclick="event.stopPropagation(); selectUser('${user.username}')">
                                私聊
                            </button>
                        </li>
                    </c:if>
                </c:forEach>

                <c:if test="${chatRoomManager.onlineUsers.size() <= 1}">
                    <li class="empty-message">暂无其他在线用户</li>
                </c:if>
            </ul>
        </div>
    </div>

    <!-- 中间聊天区域 -->
    <div class="chat-panel">
        <div class="chat-header">
            <div>
                <h2>聊天室 2.0 - 增强版</h2>
                <div style="font-size: 12px; opacity: 0.9; margin-top: 5px;">
                    支持私聊 | 线程安全 | 实时通知
                </div>
            </div>
            <div class="chat-mode">
                <button class="mode-btn active" onclick="switchMode('all')" id="modeAll">全部消息</button>
                <button class="mode-btn" onclick="switchMode('private')" id="modePrivate">私聊消息</button>
                <a href="logout" class="logout-btn">退出</a>
            </div>
        </div>

        <div class="message-area" id="messageArea">
            <c:set var="userMessages" value="${chatRoomManager.getUserMessages(sessionScope.username)}" />

            <c:choose>
                <c:when test="${empty userMessages}">
                    <div class="empty-message">
                        <h3>📝 还没有消息</h3>
                        <p>发送第一条消息开始聊天吧！</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="msg" items="${userMessages}">
                        <c:choose>
                            <c:when test="${msg.isSystem}">
                                <!-- 系统消息 -->
                                <div class="message system">
                                    <div class="message-header">
                                        <span class="message-username">${msg.username}</span>
                                        <span class="message-time">
                                                <fmt:formatDate value="${msg.timestamp}" pattern="HH:mm:ss" />
                                            </span>
                                    </div>
                                    <div class="message-content">${msg.content}</div>
                                </div>
                            </c:when>
                            <c:when test="${msg.username eq sessionScope.username}">
                                <!-- 自己发送的消息 -->
                                <div class="message self">
                                    <div class="message-header">
                                        <span class="message-username">我</span>
                                        <span class="message-time">
                                                <fmt:formatDate value="${msg.timestamp}" pattern="HH:mm:ss" />
                                            </span>
                                        <span class="message-ip">${msg.ipAddress}</span>
                                        <c:if test="${msg.targetUser ne null}">
                                            <span class="private-tag">私聊给 ${msg.targetUser}</span>
                                        </c:if>
                                    </div>
                                    <div class="message-content">${msg.content}</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- 他人发送的消息 -->
                                <div class="message">
                                    <div class="message-header">
                                        <span class="message-username">${msg.username}</span>
                                        <span class="message-time">
                                                <fmt:formatDate value="${msg.timestamp}" pattern="HH:mm:ss" />
                                            </span>
                                        <span class="message-ip">${msg.ipAddress}</span>
                                        <c:if test="${msg.targetUser ne null and msg.targetUser eq sessionScope.username}">
                                            <span class="private-tag">私聊</span>
                                        </c:if>
                                    </div>
                                    <div class="message-content">${msg.content}</div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="input-area">
            <div class="chat-info" id="chatInfo">
                <span id="currentMode">群聊模式</span>
                <span id="targetUserInfo" style="display: none;"> | 私聊给: <strong id="targetUserName"></strong></span>
            </div>

            <form action="sendMessage" method="post" onsubmit="return validateMessage()" id="messageForm">
                <input type="hidden" name="targetUser" id="targetUserInput" value="">

                <div class="input-group">
                        <textarea name="message" class="message-input"
                                  rows="3" placeholder="输入消息..."
                                  id="messageInput"></textarea>
                    <button type="submit" class="send-btn">发送</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 右侧统计面板 -->
    <div class="stats-panel">
        <div class="stats-header">
            <h3>系统统计</h3>
        </div>

        <div class="stat-item">
            <div class="stat-label">在线用户数</div>
            <div class="stat-value">${chatRoomManager.onlineUsers.size()}</div>
        </div>

        <div class="stat-item">
            <div class="stat-label">消息总数</div>
            <div class="stat-value">${chatRoomManager.allMessages.size()}</div>
        </div>

        <div class="stat-item">
            <div class="stat-label">访客总数</div>
            <div class="stat-value">${chatRoomManager.visitorCount}</div>
        </div>

        <div class="stat-item thread-info">
            <div class="stat-label">当前线程</div>
            <div class="stat-value" style="font-size: 14px;">${Thread.currentThread().getName()}</div>
            <div style="font-size: 12px; color: #666; margin-top: 5px;">
                线程ID: ${Thread.currentThread().getId()}
            </div>
        </div>

        <div class="action-buttons">
            <button class="action-btn refresh-all" onclick="location.reload()">
                🔄 刷新页面
            </button>
            <button class="action-btn clear-chat" onclick="clearChat()">
                🗑️ 清空聊天（本地）
            </button>
            <button class="action-btn export-chat" onclick="exportChat()">
                📤 导出聊天记录
            </button>
        </div>

        <div style="margin-top: 20px; font-size: 12px; color: #888; text-align: center;">
            <p>版本: 2.0.0 增强版</p>
            <p>线程安全 | 私聊功能 | 实时通知</p>
        </div>
    </div>
</div>
<script>
    // 当前选中的私聊用户
    let currentTargetUser = null;
    let currentMode = 'all';

    // 页面加载完成后初始化
    window.onload = function() {
        scrollToBottom();
        document.getElementById('messageInput').focus();

        // 检查是否有私聊参数
        const urlParams = new URLSearchParams(window.location.search);
        const privateUser = urlParams.get('private');
        if (privateUser) {
            selectUser(privateUser);
        }

        // 自动刷新在线用户列表（每15秒）
        setInterval(refreshUsers, 15000);

        // 自动刷新消息（每10秒）
        setInterval(function() {
            if (currentMode === 'all') {
                refreshMessages();
            }
        }, 10000);
    };

    // 滚动到底部
    function scrollToBottom() {
        const messageArea = document.getElementById('messageArea');
        messageArea.scrollTop = messageArea.scrollHeight;
    }

    // 选择私聊用户
    function selectUser(username) {
        // 更新选中状态
        document.querySelectorAll('.user-list li').forEach(li => {
            li.classList.remove('active');
        });

        const userElement = document.getElementById('user-' + username);
        if (userElement) {
            userElement.classList.add('active');
        }

        // 更新当前目标用户
        currentTargetUser = username;
        document.getElementById('targetUserInput').value = username;
        document.getElementById('targetUserName').textContent = username;
        document.getElementById('targetUserInfo').style.display = 'inline';

        // 更新输入框提示
        document.getElementById('messageInput').placeholder = '发送私聊消息给 ' + username + '...';
        document.getElementById('currentMode').textContent = '私聊模式';

        // 切换到私聊模式
        switchMode('private');

        // 滚动到底部
        setTimeout(scrollToBottom, 100);
    }

    // 切换消息模式
    function switchMode(mode) {
        currentMode = mode;

        // 更新按钮状态
        document.getElementById('modeAll').classList.toggle('active', mode === 'all');
        document.getElementById('modePrivate').classList.toggle('active', mode === 'private');

        // 刷新消息显示
        refreshMessages();
    }

    // 刷新在线用户列表
    function refreshUsers() {
        // 这里可以通过Ajax实现，简单起见直接刷新页面
        location.reload();
    }

    // 刷新消息（Ajax方式）
    function refreshMessages() {
        // 简单实现：刷新页面
        if (currentMode === 'all') {
            location.reload();
        }
    }

    // 验证消息
    function validateMessage() {
        const input = document.getElementById('messageInput');
        if (input.value.trim() === '') {
            alert('消息不能为空！');
            return false;
        }

        // 如果是私聊模式但没选择用户
        if (currentTargetUser && !document.getElementById('targetUserInput').value) {
            alert('请选择私聊对象！');
            return false;
        }

        return true;
    }

    // 清空聊天记录（本地）
    function clearChat() {
        if (confirm('确定要清空聊天记录吗？这只会清除本地显示，不会删除服务器数据。')) {
            const messageArea = document.getElementById('messageArea');
            messageArea.innerHTML = '<div class="empty-message"><h3>📝 聊天记录已清空</h3><p>刷新页面恢复消息</p></div>';
            scrollToBottom();
        }
    }

    // 导出聊天记录
    function exportChat() {
        const messages = [];
        const messageElements = document.querySelectorAll('.message');

        messageElements.forEach(msg => {
            const username = msg.querySelector('.message-username')?.textContent || '未知';
            const time = msg.querySelector('.message-time')?.textContent || '';
            const content = msg.querySelector('.message-content')?.textContent || '';
            const isPrivate = msg.querySelector('.private-tag') ? ' [私聊]' : '';

            messages.push(`${time} ${username}${isPrivate}: ${content}`);
        });

        const chatText = messages.join('\n');
        const blob = new Blob([chatText], { type: 'text/plain' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'chatroom-export-' + new Date().toISOString().split('T')[0] + '.txt';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        alert('聊天记录已导出！');
    }

    // 快捷键支持
    document.addEventListener('keydown', function(e) {
        // Ctrl+Enter 发送
        if (e.ctrlKey && e.key === 'Enter') {
            document.getElementById('messageForm').submit();
        }

        // ESC 取消私聊
        if (e.key === 'Escape' && currentTargetUser) {
            currentTargetUser = null;
            document.getElementById('targetUserInput').value = '';
            document.getElementById('targetUserInfo').style.display = 'none';
            document.getElementById('messageInput').placeholder = '输入消息...';
            document.getElementById('currentMode').textContent = '群聊模式';
            switchMode('all');

            // 移除选中状态
            document.querySelectorAll('.user-list li').forEach(li => {
                li.classList.remove('active');
            });
        }
    });

    // 输入框自动增高
    document.getElementById('messageInput').addEventListener('input', function() {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
</script>
</body>
</html>