<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>
<%@page import="com.bpps.pojo.ExpertHelpMessage"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.ExpertHelpMessageDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    ExpertHelpMessage expertHelpMessage = (ExpertHelpMessage) request.getAttribute("detail");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>用户提问专家解答页面</title>
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
                <th align="left">您的位置：用户提问管理 > 解答用户提问</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">解答用户提问</th>
                    <td class="pannel-head-right"></td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
                        <fieldset>
                            <legend>修改文章</legend>
                            <form name="articleUpdate" method="post" action="${pageContext.request.contextPath}/expertHelpMessageAction.do?method=doUpdateAction">
                                <table  class="theform" >
                                    <tr><th>提问者网名：</th>
                                        <td><%=expertHelpMessage.getEhmUserName()%><input type="hidden" name="ehmId" value="<%=expertHelpMessage.getEhmId()%>" /></td></tr>
                                    <tr><th>问题：</th>
                                        <td><textarea name="ehmUserQuestion" cols="80" rows="2" style="width:500px;height:80px;" readonly><%=expertHelpMessage.getEhmUserQuestion()%></textarea></td></tr>
                                    <tr><th>解答：</th>
                                        <td><textarea name="ehmExpertAnswer" cols="80" rows="2" style="width:500px;height:80px;"><%=expertHelpMessage.getEhmExpertAnswer()%></textarea></td></tr>
                                    <tr><th>审核通过：</th>
                                        <td><select name="eptEnable">
                                                <option value="0">未审核</option>
                                                <option value="1" <%if(expertHelpMessage.getEptEnable()==1)out.print("selected");%>>审核通过</option>
                                                <option value="2" <%if(expertHelpMessage.getEptEnable()==2)out.print("selected");%>>审核不通过</option>
                                            </select></td></tr>
                                    <tr><td colspan="2">
                                            <input type="submit" class="bt" name="button" value="提交内容" onclick="return checkInputValue();"/>
                                        </td></tr>
                                </table>
                            </form>
                        </fieldset>
                    </td>
                </tr>
            </tbody>
            <!-- /Pannel contents -->
        </table>
    </body>
</html>