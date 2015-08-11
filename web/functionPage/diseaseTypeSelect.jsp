<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    String labelIdStr = request.getParameter("labelId");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害图片检索——疾病类型选择页面</title>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
        <link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/>
        <!--link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" /-->
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script>

    </head>
    <body>
        <table cellpadding="0" cellspacing="0" id="main-mypos">
            <tr>
                <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                <th align="left">您的位置：自助诊断> 疾病图片检索> 疾病类型选择</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <div id="page">

            <div id="article_content" style="text-align: center;height: 600px;vertical-align: middle;">
                <table style="clear:both;width:100%;text-align: center;">
                    <tr>
                        <td align="center">
                            <span style="display:block;width:150px;height:60px;background-color: greenyellow;vertical-align: middle;padding-top: 35px">
                                <a href="${pageContext.request.contextPath}/functionPage/diseasePosSelect.jsp?disType=0&labelId=<%=labelIdStr%>">病害图像检索</a>
                            </span></td>
                        <td align="center">
                            <span style="display:block;width:150px;height:60px;background-color: greenyellow;vertical-align: middle;padding-top: 35px">
                                <a href="${pageContext.request.contextPath}/functionPage/diseaseImageSearch2.jsp?disType=1&labelId=<%=labelIdStr%>">虫害图像检索</a>
                            </span></td>
                    </tr>
                </table>
            </div>
        </div>
        <%@include file="/WEB-INF/jspf/foot.jspf"%>
    </body>
</html>