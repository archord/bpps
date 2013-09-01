<%-- 
    Document   : leftmenu_rcsw
    Created on : 2012-5-27, 10:14:03
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>无标题文档</title>
<style type="text/css">
<!--
body {
	background-color: #AECFF0;
	padding-left:2px;
	height: 100%;
}
-->
</style>

<!-- -->
<link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
<script language="javascript" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
<!-- -->
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:2px 0 0 0">
  <tr>
    <td width="187" height="296" valign="top">
     <!--菜单开始 -->
    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-01')">标签管理<br></th>
        </tr>
        <tr>
          <td id="item-01"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/labelAction.do?method=listAction" target="mainFrame">标签列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/label/labelAdd.jsp" target="mainFrame">增加标签</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/label/updateLabelInfo.jsp" target="mainFrame">更新标签信息</a></th>
              </tr>

          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->

    <!--菜单开始 -->
    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-02')">页面管理<br></th>
        </tr>
        <tr>
          <td id="item-02"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">

              <tr>
                <th><a href="${pageContext.request.contextPath}/functionPageAction.do?method=listAction" target="mainFrame">功能页列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/functionPage/pageAdd.jsp" target="mainFrame">添加功能页</a></th>
              </tr>

          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->

    <!--菜单开始 -->
    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-03')">文章管理<br></th>
        </tr>
        <tr>
          <td id="item-03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">

              <tr>
                <th><a href="${pageContext.request.contextPath}/articleAction.do?method=listAction" target="mainFrame">文章列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/article/articleAdd.jsp" target="mainFrame">添加文章</a></th>
              </tr>

          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->

	 <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-04')">专家管理<br></th>
        </tr>
        <tr>
          <td id="item-04"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/expert/expertList.jsp" target="mainFrame">专家列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/expert/expertAdd.jsp" target="mainFrame">增加专家</a></th>
              </tr>
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->
          
	 <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-05')">用户提问信息管理<br></th>
        </tr>
        <tr>
          <td id="item-05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/expertHelpMessage/expertHelpMessageList.jsp" target="mainFrame">用户提问列表</a></th>
              </tr>
              <!--tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/expert/expertAdd.jsp" target="mainFrame">增加专家协助信息</a></th>
              </tr-->
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->


	 <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-06')">用户管理<br></th>
        </tr>
        <tr>
          <td id="item-06"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/userInfoAction.do?method=listAction" target="mainFrame">用户列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/userInfo/userAdd.jsp" target="mainFrame">增加用户</a></th>
              </tr>
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->
    </td>
  </tr>
</table>
              
<script type="text/javascript" >
    e.hidNode('item-02');
    e.hidNode('item-03');
    e.hidNode('item-04');
    e.hidNode('item-05');
    e.hidNode('item-06');
</script>
</body>
</html>
