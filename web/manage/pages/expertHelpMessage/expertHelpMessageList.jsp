<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.ExpertHelpMessage"%>
<%@page import="com.bpps.dao.ExpertHelpMessageDAO"%>
<%@page import="com.bpps.pojo.Article"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.ArticleDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>用户提问列表页面</title>
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
                <th align="left">您的位置：用户提问管理 > 用户提问列表</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">用户提问列表</th>
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
                            <legend>用户提问列表</legend>
                            <table class="theform">
                                <tr>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">提问者</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:250px;background-color: #D1D7DC;">用户提问</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">专家解答</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">审核通过</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">回答</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">删除</th></tr>

                                <%
                                    request.setCharacterEncoding("UTF-8");
                                    ExpertHelpMessageDAO expertHelpMessageDAO = new ExpertHelpMessageDAO();
                                    List<ExpertHelpMessage> messages = expertHelpMessageDAO.getExpertHelpMessages();

                                    if (messages == null || messages.isEmpty()) {
                                        out.print("<tr><td colspan=5 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
                                    } else {
                                        for (ExpertHelpMessage message : messages) {
                                            int srtLen = 15;
                                            String userQuestion = message.getEhmUserQuestion();
                                            String expertAnswer = message.getEhmExpertAnswer();
                                            if (userQuestion == null) {
                                                userQuestion = "无";
                                            }
                                            if (expertAnswer == null) {
                                                expertAnswer = "无";
                                            }
                                            if (userQuestion.length() > srtLen) {
                                                userQuestion = userQuestion.substring(0, srtLen) + "...";
                                            }
                                            if (expertAnswer.length() > srtLen) {
                                                expertAnswer = expertAnswer.substring(0, srtLen) + "...";
                                            }
                                            out.print("<tr><td>");
                                            out.print(message.getEhmUserName());
                                            out.print("</td><td>");
                                            out.print(userQuestion);
                                            out.print("</td><td>");
                                            out.print(expertAnswer);
                                            out.print("</td><td>");
                                            int isEnable = message.getEptEnable();
                                            if (isEnable == 1) {
                                                out.print("通过");
                                            } else if (isEnable == 2) {
                                                out.print("不通过");
                                            }else {
                                                out.print("待审");
                                            }
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertHelpMessageAction.do?method=updateAction&ehmId=");
                                            out.print(message.getEhmId());
                                            out.print("'>回答");
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertHelpMessageAction.do?method=deleteAction&ehmId=");
                                            out.print(message.getEhmId());
                                            out.print("'>删除");
                                            out.print("</a></td></tr>");
                                        }
                                    }
                                %>

                            </table>
                        </fieldset>
                    </td>
                </tr>


            </tbody>
            <!-- /Pannel contents -->
        </table>

    </body>
</html>