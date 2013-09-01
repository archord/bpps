<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Expert"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.ExpertDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>专家列表页面</title>
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
                <th align="left">您的位置：专家管理 > 专家列表</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">专家列表</th>
                    <td class="pannel-head-right"></td>
                </tr>
            </thead>
            <!-- /Pannel title -->
            <!-- Pannel contents -->
            <tbody>

                <tr>
                    <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
                        <fieldset>
                            <legend>专家列表</legend>
                            <form name="symptomList" method="post" action="${pageContext.request.contextPath}/expertAction.do?method=listAction">
                            </form>

                            <table  class="theform">
                                <tr>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">姓名</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">性别</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">职称</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">地址</th>
                                    <!--th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">照片链接</th-->
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

                                <%
                                    ExpertDAO articleDAO = new ExpertDAO();
                                    List<Expert> articles = articleDAO.getExperts();

                                    if (articles == null || articles.isEmpty()) {
                                        out.print("<tr><td colspan=6 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
                                    } else {
                                        for (Expert article1 : articles) {
                                            out.print("<tr><td>");
                                            out.print(article1.getEptName());
                                            out.print("</td><td>");
                                            if(article1.getEptSex()==0)
                                                out.print("男");
                                            else
                                                out.print("女");
                                            out.print("</td><td>");
                                            if(article1.getEptZhichen()==null || article1.getEptZhichen().equals(""))
                                                out.print("无");
                                            else
                                                out.print(article1.getEptZhichen());
                                            out.print("</td><td>");
                                            if(article1.getEptAddress()==null || article1.getEptAddress().equals(""))
                                                out.print("无");
                                            else
                                                out.print(article1.getEptAddress());
//                                            out.print("</td><td>");
//                                            if(article1.getEptPhotoUrl()==null || article1.getEptPhotoUrl().equals(""))
//                                                out.print("无");
//                                            else
//                                                out.print(article1.getEptPhotoUrl());
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertAction.do?method=updateAction&eptId=");
                                            out.print(article1.getEptId());
                                            out.print("'>修改</a>");
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/expertAction.do?method=deleteAction&eptId=");
                                            out.print(article1.getEptId());
                                            out.print("'>删除</a>");
                                            out.print("</td><td>");
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