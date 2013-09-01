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
List<Disease> rstDiseases = (List<Disease>)request.getAttribute("rstDiseases");
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害搜索结果列表</title>
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
        <th align="left">您的位置：病害查看&nbsp;>&nbsp;病害搜索结果列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>
        <div id="page">
            <div id="article_header">
            匹配病害列表
            </div>
            <div id="article_content" style="text-align: center;">
<%
            String urlPath = request.getContextPath();
            /*if(rstDiseases!=null)
            for (Disease disease : rstDiseases) {
                out.println("<span><a href=\""+ urlPath +"/diseaseAction.do?method=detailAction&disId="+ disease.getDisId() +"\"> ");
                out.println("<img src=\""+ disease.getDisImagePath() +"\" alt=\""+ disease.getDisName() +"\"/> ");
                out.println(" </a></span>");
            }*/
            out.println("<table style=\"clear:both;width:100%\">");
            if(rstDiseases!=null&&!rstDiseases.isEmpty()){
            int colNum = 3;
            int rowNum = (rstDiseases.size()%colNum==0)?(rstDiseases.size()/colNum) : (rstDiseases.size()/colNum+1);
            if(colNum>rstDiseases.size())
                colNum=rstDiseases.size();
            int colWidth = 100/colNum;
            for(int row=0; row<rowNum; row++){
                String trImg = "<tr style=\"width:100%\">";
                String trName = "<tr style=\"width:100%\">";
                for(int col=0; col<colNum; col++){
                    int index = row*colNum+col;
                    if(index<rstDiseases.size()){
                        trImg += "<td ";
                        trImg += "style=\"width:";
                        trImg += colWidth;
                        trImg += "%\">";
                        trImg += "<span class=img><a href=\""+ urlPath +"/diseaseAction.do?method=detailAction&disId="+ rstDiseases.get(index).getDisId() +"\"> ";
                        trImg += "<img src=\""+ rstDiseases.get(index).getDisImagePath() +"\" alt=\""+ rstDiseases.get(index).getDisName() +"\"/></a></span> ";
                        trImg += "</td>";
                        trName += "<td>";
                        trName += "<span class=imgName><a href=\""+ urlPath +"/diseaseAction.do?method=detailAction&disId="+ rstDiseases.get(index).getDisId() +"\">";
                        trName += rstDiseases.get(index).getDisName();
                        trName += "</a></span>";
                        trName += "</td>";
                    }else{
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
            }else{
                out.println("<tr><td>没有匹配的病害，请重新选择症状！</td></tr>");
            }
            out.println("</table>");
%>
            </div>
            <div><a href="${pageContext.request.contextPath}/functionPage/symSearch.jsp?labelId=<%=labelId%>">重新选择</a></div>
        </div>

    </body>
</html>