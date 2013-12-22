<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String labelId = request.getParameter("labelId");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害种类列表页面</title>
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
                <th align="left">您的位置：病害管理 > 病害信息列表</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">病害信息列表</th>
                    <td class="pannel-head-right"></td>
                </tr>
            </thead>
            <!-- /Pannel title -->
            <!-- Pannel contents -->
            <tbody>

                <tr>
                    <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
                        <fieldset>
                            <legend>病害列表</legend>
                            <table  class="theform">
                                <tr><th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">病害名称</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">病害简介</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th>
                                    <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

                                <%
                                    int labelIdInt = Integer.parseInt(labelId);
                                    DiseaseDAO diseaseDAO = new DiseaseDAO();
                                    List<Disease> diseases = diseaseDAO.getDiseasesByLabelId(labelIdInt);

                                    if (diseases == null || diseases.isEmpty()) {
                                        out.print("<tr><td colspan=4 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
                                    } else {
                                        for (Disease disease : diseases) {
                                            out.print("<tr><td>");
                                            out.print(disease.getDisName());
                                            out.print("</td><td>");
                                            String introduction = disease.getDisIntroduction();
                                            if (introduction != null) {
                                                if (introduction.length() < 50) {
                                                    out.print(introduction);
                                                } else {
                                                    out.print(introduction.substring(0, 50) + "…");
                                                }
                                            } else {
                                                out.print("");
                                            }
                                            out.print("</td><td><a href='");
                                            out.print(request.getContextPath());
                                            out.print("/diseaseAction.do?method=updateAction&disId=");
                                            out.print(disease.getDisId());
                                            out.print("&labelId=");
                                            out.print(disease.getLabelId());
                                            out.print("'>修改</a>");
                                            out.print("</td><td><a onclick=\"return confirm('是否删除?');\" href='");
                                            out.print(request.getContextPath());
                                            out.print("/diseaseAction.do?method=deleteAction&disId=");
                                            out.print(disease.getDisId());
                                            out.print("&labelId=");
                                            out.print(disease.getLabelId());
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