<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.SymptomImage"%>
<%@page import="com.bpps.dao.SymptomImageDAO"%>
<%@page import="com.bpps.pojo.Symptom2"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@page import="com.bpps.dao.PosDisDAO"%>
<%@page import="com.bpps.pojo.Position"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page import="com.bpps.pojo.SymptomDisease"%>
<%@page import="com.bpps.dao.SymDisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String disIdStr = request.getParameter("disId");
    String labelIdStr = request.getParameter("labelId");
    Integer disId = Integer.parseInt(disIdStr);
    String urlPath = request.getContextPath();
    DiseaseDAO disDAO = new DiseaseDAO();
    Disease disease = disDAO.getDiseaseById(disId);
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害图片检索页面结果</title>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
        <link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/>
        <!--link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" /-->
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/ui/zoombox.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <!--script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script-->
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/jquery.min.1.7.2.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/zoombox.js"></script>

    </head>
    <body>
        <table cellpadding="0" cellspacing="0" id="main-mypos">
            <tr>
                <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                <th align="left">您的位置：自助诊断> 病害图片检索> <%=disease.getDisName()%>相关症状列表</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <div id="page">
            <!--div id="article_header">
                病害列表
            </div-->
            <div id="article_content" style="text-align: center;">
<%
    int labelIdInt = Integer.parseInt(labelIdStr);
    PositionDAO positionDAO = new PositionDAO();
    SymDisDAO symDisDAO = new SymDisDAO();
    SymptomImageDAO symptomImageDAO = new SymptomImageDAO();
    List<Position> positions = positionDAO.getPositions(labelIdInt);
    int flag = 0;
    StringBuffer webSB = new StringBuffer();
    for(Position pos : positions){
        List<SymptomDisease> symDiss = symDisDAO.getAssSymDisByPosDisId(pos.getPosId(), disId);
        if (symDiss != null && !symDiss.isEmpty()) {
            webSB.append("<div id=\"article_header\">");
            webSB.append(pos.getPosName());
            webSB.append("症状</div>\n");
            webSB.append("<table style=\"clear:both;width:100%\">\n");
            int colNum = 3;
            int rowNum = (symDiss.size() % colNum == 0) ? (symDiss.size() / colNum) : (symDiss.size() / colNum + 1);
            if (colNum > symDiss.size()) {
                colNum = symDiss.size();
            }
            int colWidth = 100 / colNum;
            for (int row = 0; row < rowNum; row++) {
                flag = 1;
                StringBuffer imgSB = new StringBuffer();
                StringBuffer nameSB = new StringBuffer();
                imgSB.append("<tr style=\"width:100%\">\n");
                nameSB.append("<tr style=\"width:100%\">\n");
                for (int col = 0; col < colNum; col++) {
                    int index = row * colNum + col;
                    if (index < symDiss.size()) {
                        List<SymptomImage> symImgs = symptomImageDAO.getSymptomImagesBySymId(symDiss.get(index).getSymId());
                        imgSB.append("<td ");
                        imgSB.append("style=\"width:");
                        imgSB.append(colWidth);
                        imgSB.append("%\">");
                        imgSB.append("<span class=img>");
                        nameSB.append("<td ");
                        nameSB.append("<span class=imgName>");
                        if(symImgs.size()>=1)
                        {
                            imgSB.append("<a href=\"");
                            imgSB.append(symImgs.get(0).getSiImagePath());
                            imgSB.append("_b.jpg\" alt=\"");
                            imgSB.append(symDiss.get(index).getSymName());
                            imgSB.append("\">");
                            imgSB.append("<img src=\"");
                            imgSB.append(symImgs.get(0).getSiImagePath());
                            imgSB.append("_s.jpg\" alt=\"");
                            imgSB.append(symDiss.get(index).getSymName());
                            imgSB.append("\"/>");
                            nameSB.append(symDiss.get(index).getSymName());
                        }else{
                            imgSB.append("<a href=\"#\" alt=\"");
                            imgSB.append(symDiss.get(index).getSymName());
                            imgSB.append("\"/>");
                            imgSB.append(symDiss.get(index).getSymName());
                            imgSB.append("图片位");
                            nameSB.append(symDiss.get(index).getSymName());
                        }
                        imgSB.append("</a></span> </td>\n");
                        nameSB.append("</span></td>\n");
                    } else {
                        imgSB.append("<td></td>");
                        nameSB.append("<td></td>");
                    }
                }
                imgSB.append("</tr>\n");
                nameSB.append("</tr>\n");
                webSB.append(imgSB.toString());
                webSB.append(nameSB.toString());
            }
            webSB.append("</table>\n");
        }
    }
    out.print(webSB.toString());
    if(flag==0)
    out.print("<table style=\"clear:both;width:100%\"><tr style=\"width:100%\"><td colspan=4 align='center'>系统中暂时没有数据！</td></tr></table>");



%>
            </div>
            <!--div><a href="${pageContext.request.contextPath}/functionPage/symSearch.jsp">重新选择</a></div-->
        </div>
<%@include file="/WEB-INF/jspf/foot.jspf"%>

<script type="text/javascript">
    jQuery(function($){
        $('a.zoombox').zoombox();

        /*** Or You can also use specific options 
        $('a.zoombox').zoombox({
            theme       : 'zoombox',        //available themes : zoombox,lightbox, prettyphoto, darkprettyphoto, simple
            opacity     : 0.8,              // Black overlay opacity
            duration    : 800,              // Animation duration
            animation   : true,             // Do we have to animate the box ?
            width       : 600,              // Default width
            height      : 400,              // Default height
            gallery     : true,             // Allow gallery thumb view
            autoplay : false                // Autoplay for video
        });
       */
    });
</script>

    </body>
</html>