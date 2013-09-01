<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.SymptomDiscribe"%>
<%@page import="com.bpps.dao.SymptomDiscribeDAO"%>
<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.PositionDAO" %>
<%
request.setCharacterEncoding("UTF-8");
Position position = (Position)request.getAttribute("detail");
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>部位病害症状列表页面</title>
        <!--link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" />
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script>
        <style>
table td
{
    word-break: keep-all;
    white-space:nowrap;
}

        </style>
    </head>
    <body>
     <table cellpadding="0" cellspacing="0" id="main-mypos">
      <tr>
        <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
        <th align="left">您的位置：部位> 症状列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

    <form name="diseaseSearch" method="post" action="${pageContext.request.contextPath}/diseaseAction.do?method=mutilSearchAction">
        <div id="page">
            <!--div id="article_header">
            黄瓜<%=position.getPosName()%>危害症状
            </div-->
            <div id="article_content" style="">
<%
    if(position.getPosId()!=null){
    SymptomDAO symptomDAO = new SymptomDAO();
    SymptomDiscribeDAO symptomDiscribeDAO = new SymptomDiscribeDAO();
    List<Symptom> symptoms = symptomDAO.getParSymptomsByPosId(position.getPosId());

    int index = 1;
    out.print("<table> ");
    out.print("<tr><td colspan=4><div id=\"article_header\">黄瓜");
    out.print(position.getPosName());
    out.print("危害症状</div></td></tr>");
    for (Symptom symptom : symptoms) {  
        out.print("<tr> ");
        out.print("<td width=\"20px\">" + index++ + "、" + "</td>");
        out.print("<td >" + symptom.getSymName()+"：</td>");
        if(symptom.getSymProperty()==1){
            out.print("<td width=\"80px\"><span class=checkbox><input type=\"radio\" name=\""+ symptom.getSymId() +"\" value=\"1\"/>&nbsp;是</span></td>");
            out.print("<td width=\"80px\"><span class=checkbox><input type=\"radio\" name=\""+ symptom.getSymId() +"\" value=\"0\"/>&nbsp;否</span></td>");
        }else{
            out.print("<td colspan=2><table> <tr> ");
            List<SymptomDiscribe> symptomDiscribes = symptomDiscribeDAO.getSymptomDiscribesBySymId(symptom.getSymId());
            for (SymptomDiscribe symptomDiscribe : symptomDiscribes) {
                out.print("<td><input class=checkbox type=\"radio\" name=\""
                        + symptom.getSymId() +"\" value=\""
                        + symptomDiscribe.getSymDiscId() +"\"/>&nbsp;"
                        + symptomDiscribe.getSymDiscName() +"</td>");
            }
            out.print("</tr></table></td>");
        }
        out.print("</tr> ");
        List<Symptom> childSymptoms = symptomDAO.getChildSymptomsBySymId(symptom.getSymId());
        if(childSymptoms.size()>0){
            int index2 = 1;
            out.print("<tr><td></td><td colspan=3> ");
            out.print("<table> ");
            for (Symptom childSymptom : childSymptoms) {
                out.print("<tr>");
                out.print("<td width=\"15px\">" + index2++ + "</td>");
                out.print("<td>" + childSymptom.getSymName()+"：</td></tr>");
                out.print("<tr><td></td><td>");
                out.print("<table> <tr>");
                if(childSymptom.getSymProperty()==1){
                    out.print("<td width=50px><input class=checkbox type=\"radio\" name=\""+ childSymptom.getSymId() +"\" value=\"1\"/>&nbsp;是</td>");
                    out.print("<td width=50px><input class=checkbox type=\"radio\" name=\""+ childSymptom.getSymId() +"\" value=\"0\"/>&nbsp;否</td>");
                }else{
                    List<SymptomDiscribe> symptomDiscribes = symptomDiscribeDAO.getSymptomDiscribesBySymId(childSymptom.getSymId());
                    for (SymptomDiscribe symptomDiscribe : symptomDiscribes) {
                        out.print("<td><input class=checkbox type=\"radio\" name=\""
                                + childSymptom.getSymId() +"\" value=\""
                                + symptomDiscribe.getSymDiscId() +"\"/>&nbsp;"
                                + symptomDiscribe.getSymDiscName() +"</td>");
                    }
                }
                out.print("</tr></table>");
                out.print("</tr> ");
            }
            out.print("</table></td></tr> ");
        }
    }
    out.print("<tr><td colspan=\"4\" align=center><input type=\"submit\" class=\"bt\" name=\"button\" value=\"查找\"/>");
    out.print("<input type=\"hidden\" value=\"0\" name=\"startSymSearch\"/>");
    out.print("<input type=\"hidden\" value=\""+ labelId +"\" name=\"labelId\"/>");
    out.print("<input type=\"hidden\" name=\"posId\" value=\""+ position.getPosId() +"\"/> </td></tr>");
    out.print("<tr><td colspan=\"4\" align=center><a href=\"/bpps/functionPage/symSearch.jsp?labelId="+ labelId +"\">重新选择</a>");
    out.print(" </td></tr>");
    out.print("</table>");
    }else{
        out.print("未找到对应位置信息，请联系管理员！");
    }
%>
            </div>
        </div>
    </form>

        <script type="text/javascript">

            function changeRadioValue(obj) {
                var radio=obj;
                if (radio.tag==1)
                {
                    radio.checked=false;
                    radio.tag=0;
                }
                else
                {
                    radio.checked=true;
                    radio.tag=1
                }
            }
        </script>
    </body>
</html>