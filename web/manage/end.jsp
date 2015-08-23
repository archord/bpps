<%-- 
    Document   : end
    Created on : 2012-5-27, 10:17:08
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.UserInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<style>
body{
margin:0px;
padding:0px;}
</style>
<body>
<%
UserInfo user = (UserInfo)session.getAttribute("userInfo");
String userName = "";
if(user!=null)
    userName = user.getUserName();
%>
<div style="font-size:12px;width:100%;line-height:20px;background-image:url(${pageContext.request.contextPath}/ui/skin_1/images/endbg.jpg);background-repeat:repeat-x;background-position:left bottom;">
    &nbsp;当前登录：黄瓜病害管理&nbsp;&gt;&nbsp;<%=userName%>&nbsp;欢迎您！
</div>
</body>
</html>