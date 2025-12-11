# 聊天室项目

## 项目介绍
Java Web聊天室项目，包含两个版本：
- 版本1.0：基础聊天室
- 版本2.0：增强版聊天室（事件监听、过滤器、私聊功能）

## 在线演示
- 版本2.0（增强版）：http://10.100.164.41:8080/chatroom-v2/
- 版本1.0（基础版）：http://10.100.164.41:8080/online-chatroom-1.0-SNAPSHOT/

## 技术栈
- Java 17
- Jakarta EE 9.1
- Tomcat 11
- JSP + JSTL
- Maven

## 版本2.0新功能
1. **事件监听**
   - ServletContextListener：应用生命周期管理
   - HttpSessionListener：用户会话跟踪

2. **过滤器**
   - EncodingFilter：字符编码处理
   - LoginFilter：登录验证

3. **私聊功能**
   - 支持一对一私密聊天
   - 私聊消息标记

4. **线程安全**
   - 双重检查锁定
   - 线程安全集合

5. **系统通知**
   - 用户进出实时通知
   - 在线用户统计

## 项目结构
chatroom-v2/
├── src/main/java/com/boda/
│ ├── model/ # 数据模型
│ ├── util/ # 工具类
│ ├── filter/ # 过滤器
│ ├── listener/ # 监听器
│ └── servlet/ # Servlet
├── src/main/webapp/ # Web资源
└── pom.xml # Maven配置

## 使用说明
1. 部署到Tomcat
2. 访问应用
3. 登录（默认密码：123456）
4. 开始聊天

## 分支说明
- main: 主分支
- v1-basic: 版本1.0基础聊天室
- v2-enhanced: 版本2.0增强功能
