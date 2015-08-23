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
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">审核状态</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">回答</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;width:80px;background-color: #D1D7DC;">删除</th></tr>

                                <%                                    request.setCharacterEncoding("UTF-8");
                                    int pageSize = 15;
                                    int pageNum = 1, firstPage = 1, endPage = 1, upPage = 1, downPage = 1;
                                    String pageStr = request.getParameter("page");
                                    if (pageStr != null && !pageStr.isEmpty()) {
                                        pageNum = Integer.parseInt(pageStr);
                                    }
                                    ExpertHelpMessageDAO expertHelpMessageDAO = new ExpertHelpMessageDAO();
                                    int msgSize = expertHelpMessageDAO.getTotal();
                                    int unAudit = expertHelpMessageDAO.getUnAuditNum();
                                    endPage = msgSize%pageSize==0?msgSize/pageSize:msgSize/pageSize+1;
                                    if(pageNum==1){
                                        upPage = 1;
                                    }else{
                                        upPage=pageNum-1;
                                    }
                                    if(pageNum==endPage){
                                        downPage = 1;
                                    }else{
                                        downPage=pageNum+1;
                                    }
                                    int startRecord = (pageNum-1)*pageSize;
                                    int endRecord = (pageNum)*pageSize;
                                    List<ExpertHelpMessage> messages = expertHelpMessageDAO.getExpertHelpMessages(startRecord, endRecord);

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
                                            } else {
                                                out.print("未审核");
                                            }
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertHelpMessageAction.do?method=updateAction&ehmId=");
                                            out.print(message.getEhmId());
                                            out.print("'>");
                                            if (isEnable == 1) {
                                                out.print("修改");
                                            } else if (isEnable == 2) {
                                                out.print("修改");
                                            } else {
                                                out.print("审核");
                                            }
                                            out.print("</td><td><a onclick=\"return confirm('是否删除?');\" href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertHelpMessageAction.do?method=deleteAction&ehmId=");
                                            out.print(message.getEhmId());
                                            out.print("'>删除");
                                            out.print("</a></td></tr>");
                                        }
                                    }
                                %>
                                <tr><td colspan="6" style="text-align: right;">
                                        <span style="margin-right: 30px;cursor:pointer;">共<%=msgSize%>个提问<%=unAudit%>个未审核</span>
                                        <span style="margin-right: 30px;cursor:pointer;"><%=pageNum%>页/<%=endPage%>页</span>
                                        <span style="margin-right: 30px;cursor:pointer;"><a href="${pageContext.request.contextPath}/manage/pages/expertHelpMessage/expertHelpMessageList.jsp?page=<%=firstPage%>" target="mainFrame">第一页</a></span>
                                        <span style="margin-right: 30px;cursor:pointer;"><a href="${pageContext.request.contextPath}/manage/pages/expertHelpMessage/expertHelpMessageList.jsp?page=<%=upPage%>" target="mainFrame">上一页</a></span>
                                        <span style="margin-right: 30px;cursor:pointer;"><a href="${pageContext.request.contextPath}/manage/pages/expertHelpMessage/expertHelpMessageList.jsp?page=<%=downPage%>" target="mainFrame">下一页</a></span>
                                        <span style="margin-right: 30px;cursor:pointer;"><a href="${pageContext.request.contextPath}/manage/pages/expertHelpMessage/expertHelpMessageList.jsp?page=<%=endPage%>" target="mainFrame">最后一页</a></span>
                                    </td></tr>

                            </table>
                        </fieldset>
                    </td>
                </tr>


            </tbody>
            <!-- /Pannel contents -->
        </table>

    </body>
</html>