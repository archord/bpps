<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Disease" %>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="com.bpps.pojo.SymptomDisease" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.Set" %>
<%@page import="java.util.Iterator" %>
<%@page import="com.bpps.dao.SymDisDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    Disease disease = (Disease) request.getAttribute("detail");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>疾病详细信息页面</title>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
        <!--link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" />
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script>
        <style type="text/css">
            
            #dstable {
                max-width: 100%;
                background-color: transparent;
                border-collapse: collapse;
                border-spacing: 0;
                border: 1px solid #DFDFDF;
                background-color: #F9F9F9;
                width: 100%;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                font-family: Arial,"Bitstream Vera Sans",Helvetica,Verdana,sans-serif;
                color: #333;
            }
            #dstable td, #dstable th {
                border-top-color: white;
                border-bottom: 1px solid #DFDFDF;
                color: #555;
            }
            #dstable th {
                text-shadow: rgba(255, 255, 255, 0.796875) 0px 1px 0px;
                font-family: Georgia,"Times New Roman","Bitstream Charter",Times,serif;
                font-weight: bold;
                padding: 7px 7px 8px;
                text-align: center;
                line-height: 1.3em;
                font-size: 14px;
            }
            #dstable td{
                font-size: 14px;
                padding: 4px 7px 2px;
                vertical-align: middle;
                font-family: Georgia,"Times New Roman","Bitstream Charter",Times,serif;
            }
            #dstable td span{
                height: 20px;
                display:block 
            }
            #disdetailtitle{
                font-size: 14px;
                font-family: Georgia,"Times New Roman","Bitstream Charter",Times,serif;
            }
        </style>
    </head>
    <body>
        <table cellpadding="0" cellspacing="0" id="main-mypos">
            <tr>
                <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                <th align="left">您的位置：疾病详细信息</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <div id="page">
            <div id="article_header">
                <%=disease.getDisName()%>（<%=disease.getDisNameEn()%>）
            </div>
            <div id="diseaseSymptoms">
                <span>该疾病可能发生在多个部位，具体各部位症状如下表所示，如需确诊该疾病还请综合判断多个症状。</span><br/>
                <span>&nbsp;</span>
                <table id="dstable">
                    <thead>
                        <tr><th>部位</th><th>症状</th><th>症状描述</th></tr>
                    <tbody>
                        <%
                            SymDisDAO sdDao = new SymDisDAO();
                            Map<Position, List<SymptomDisease>> psmap = sdDao.getSympDisByDisId(disease.getDisId());
                            Iterator<Position> posIter = psmap.keySet().iterator();
                            while (posIter.hasNext()) {
                                Position tpos = posIter.next();
                                List<SymptomDisease> sdlist = psmap.get(tpos);
                                out.print("<tr><td >");
                                out.print(tpos.getPosName());
                                out.print("</td><td >");
                                for (SymptomDisease sd : sdlist) {
                                    out.print("<span>");
                                    out.print(sd.getSymName());
                                    out.print("</span>");
                                }
                                out.print("</td><td >");
                                for (SymptomDisease sd : sdlist) {
                                    out.print("<span>");
                                    out.print(sd.getSymDisDiscribe());
                                    out.print("</span>");
                                }
                                out.print("</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div id="article_content">
                <span>&nbsp;</span><br/>
                <span id="disdetailtitle">疾病详细信息如下：</span>
                <%=disease.getDisContent()%>
            </div>
            <div>
                <br>
                关于如何防治请点击<a href="${pageContext.request.contextPath}/functionPage/preventionDetail.jsp?disId=<%=disease.getDisId()%>">防治方法</a>
                <br>
                <br>
                <br>
                <br>
            </div>

            <%@include file="/WEB-INF/jspf/foot.jspf"%>
            <br>
            <br>
        </div>

    </body>
</html>