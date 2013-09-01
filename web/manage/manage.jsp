<%-- 
    Document   : manage
    Created on : 2012-5-27, 10:09:28
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.UserInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserInfo user = (UserInfo)session.getAttribute("userInfo");
    if(user==null){
        response.sendRedirect(request.getContextPath()+"/index.jsp");
%>

<!--jsp:forward page="${pageContext.request.contextPath}/index.jsp"/-->
<%
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>黄瓜主要病害标准化远程智能诊断系统后台管理页面Beta1</title>
<script language="javascript">
self.moveTo(0,0);
self.resizeTo(screen.availWidth,screen.availHeight);
</script>
</head>
<!-- cols ：定义列数及列宽（一列） rows：定义行数及行宽（2行）-->
<frameset cols="*" rows="72,*"  frameborder="1" border="1" framespacing="0">
  <!--第一行-->
  <frame src="${pageContext.request.contextPath}/manage/top.jsp" name="topFrame" frameborder="no" scrolling="No" noresize="noresize" id="topFrame">
  <!--第二行（拆分为三列）-->
  <frameset id="frow2" cols="191,5,*" frameborder="no" border="0" framespacing="0">
      <frame src="${pageContext.request.contextPath}/manage/systemManage.jsp" name="leftFrame" scrolling="auto" noresize="noresize" id="leftFrame">
      <frame src="${pageContext.request.contextPath}/manage/split.jsp" name="splitFrame" frameborder="no" scrolling="no" noresize id="splitFrame">
      <frameset cols="*" rows="*,20" framespacing="0">
             <frame src="${pageContext.request.contextPath}/manage/systemInfoAll.jsp" name="mainFrame" id="mainFrame" scrolling="yes">
             <frame src="${pageContext.request.contextPath}/manage/end.jsp" name="endFrame" frameborder="no" scrolling="No" noresize="noresize" id="endFrame">
      </frameset>
  </frameset>
</frameset>

<noframes></noframes>


<body>您的浏览器不支持框架！</body>
</html>