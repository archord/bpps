<%@page import="com.bpps.pojo.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@ page pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>症状图片检索页面</title>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/layout.css" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/css/jquery-ui.css" id="theme"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/css/jquery.image-gallery.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/css/style.css"/>
        <style>
            table td
            {
                word-break: keep-all;
                white-space:nowrap;
            }

        </style>
    </head>
    <body>
        <div id="page" style="width:1000px;">
            <table cellpadding="0" cellspacing="0" id="main-mypos">
                <tr>
                    <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                    <th align="left">您的位置：自助诊断> 病害图片检索</th>
                    <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
                </tr>
            </table>
            <div id="gallery"></div><input type="hidden" id="labelId" name="labelId" value="<%=labelId%>"/>
            <script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/jquery-1.7.1.js"></script>
            <!--script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/jquery.min.js"></script-->
            <script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/jquery-ui.min.js"></script>
            <script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/load-image.min.js"></script>
            <!--script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/jquery.image-gallery.min.js"></script-->
            <script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/jquery.image-gallery.js"></script>
            <script src="${pageContext.request.contextPath}/ui/jQuery-Image-Gallery-master/js/main.js"></script>

            <div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>
        </div>

    </body>
</html>