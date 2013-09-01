<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.SymptomImage"%>
<%@page import="com.bpps.dao.SymptomImageDAO"%>
<%@page import="com.bpps.pojo.Position"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Symptom" %>
<%@page import="com.bpps.pojo.Symptom2" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.SymptomDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String siId = request.getParameter("siId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>症状图片查看页面</title>
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
                <th align="left">您的位置：症状图片管理 > 症状图片查看</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">症状图片查看</th>
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
                            <legend>症状图片查看</legend>
<%
    int siIdInt = Integer.parseInt(siId);
    SymptomImageDAO symptomImageDAO = new SymptomImageDAO();
    SymptomImage symptomImage = symptomImageDAO.getSymptomImageById(siIdInt);

%>
<table style="none">
    <tr><td><img src="<%=symptomImage.getSiImagePath()+"_b.jpg"%>"/></td></tr>
    <tr><td><img src="<%=symptomImage.getSiImagePath()+"_s.jpg"%>"/></td></tr>
</table>
                        </fieldset>


                    </td>
                </tr>
            </tbody>
            <!-- /Pannel contents -->
        </table>
    </body>
</html>