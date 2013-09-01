<%-- 
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.PositionDAO" %>

<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("disContent") != null ? request.getParameter("disContent") : "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害症状添加页面</title>
        <!--link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" />
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script>

    </head>
    <body>
     <table cellpadding="0" cellspacing="0" id="main-mypos">
      <tr>
        <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
        <th align="left">您的位置：症状管理 > 增加症状信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>
        <div id="page">
            <div id="formContent">

            </div>
            <div>
            <%=htmlData%>
            </div>
        </div>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">增加症状信息</th>
      <td class="pannel-head-right"></td>
    </tr>
  </thead>
  <!-- /Pannel title -->
  <!-- Pannel contents -->
  <tbody>
    <!-- 收款提示 -->

    <tr>
      <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
        <fieldset>
        <legend>增加症状</legend>
            <form name="userAdd" method="post" action="${pageContext.request.contextPath}/userInfoAction.do?method=addAction">
                <table  class="theform" >
                <tr><th>用户名：</th>
                    <td><input type="text" name="userName" value="" /></td></tr>
                <tr><th>密码：</th>
                    <td><input type="password" name="password" value="" /></td></tr>
                <tr><td colspan="2"><input type="button" class="bt" name="button" value="添加用户"  onclick="checkInputValue();"/> </td></tr>
                </table>
            </form>
        </fieldset>


       </td>
    </tr>
       <script type="text/javascript" >

                    /**
                     * check some input box is null
                     */
                    function checkInputValue() {
                        var disName = document.getElementsByName("userName")[0].value;
                        if(disName==null || disName==""){
                            alert("用户名不能为空");
                            return;
                        }
                        var password = document.getElementsByName("password")[0].value;
                        if(password==null || password==""){
                            alert("密码不能为空");
                            return;
                        }
                        document.getElementsByName("userAdd")[0].submit();
                    }
	</script>

  </tbody>
  <!-- /Pannel contents -->
</table>

    </body>
</html>