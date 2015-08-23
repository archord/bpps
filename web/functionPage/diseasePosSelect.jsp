<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.bpps.dao.PositionDAO"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    String labelId = request.getParameter("labelId");
    String disType = request.getParameter("disType");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害图片检索——病害部位选择页面</title>
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
                <th align="left">您的位置：自助诊断> 疾病图片检索> 疾病部位选择</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <div id="page">
            <div id="mainCenter" style="width: 95%;border: none;">
                <form id="symSearch" name="symSearch" method="post" action="${pageContext.request.contextPath}/diseaseAction.do?method=mutilSearchAction">
                    <%
                        int labelIdInt = Integer.parseInt(labelId);
                        PositionDAO positionDAO = new PositionDAO();
                        List<Position> positions = positionDAO.getPositions(labelIdInt);

                        out.println("<table>");
                        int colNum = 3;
                        int rowNum = (positions.size() % colNum == 0) ? (positions.size() / colNum) : (positions.size() / colNum + 1);
                        if (colNum > positions.size()) {
                            colNum = positions.size();
                        }
                        out.println("<tr><td colspan=" + colNum + " style=\"font-size: 16px;font-weight: bolder;margin-top: 10px;text-indent: 0em;\">请选择病害部位</td></tr>");
                        for (int row = 0; row < rowNum; row++) {
                            String trImg = "<tr>";
                            String trName = "<tr>";
                            String trChechbox = "<tr>";
                            for (int col = 0; col < colNum; col++) {
                                int index = row * colNum + col;
                                if (index < positions.size()) {

                                    trImg += "<td>";
                                    trImg += "<a href=\""+request.getContextPath()+"/functionPage/diseaseImageSearch.jsp?disType=0&labelId="+labelId+"&posId="+positions.get(index).getPosId()+"\">";
                                    trImg += "<span class=img> ";
                                    trImg += "<img src=\"" + positions.get(index).getPosImagePath() + "\" alt=\"" + positions.get(index).getPosName() + "\"/></span></a>";
                                    trImg += "</td>";

                                    trName += "<td><span class=imgName>";
                                    trName += positions.get(index).getPosName();
                                    trName += "</span>";
                                    trName += "</td>";
                                } else {
                                    trImg += "<td>";
                                    trImg += "</td>";
                                    trName += "<td>";
                                    trName += "</td>";
                                }
                            }
                            trImg += "</tr>";
                            trName += "</tr>";
                            out.println(trImg);
                            out.println(trName);
                        }
                        out.println("</table>");
                    %>
                </form>
                <div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>

            </div>
        </div>
        <%@include file="/WEB-INF/jspf/foot.jspf"%>
    </body>
</html>