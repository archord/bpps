<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.dao.PosDisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="com.bpps.dao.PositionDAO" %>
<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>
<%@page import="com.jdbc.DatabaseManager" %>

<%
request.setCharacterEncoding("UTF-8");
String labelId = request.getParameter("labelId");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>症状种类列表页面</title>
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
        <th align="left">您的位置：部位管理 > 部位病害关联</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">关联信息表格</th>
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
        <legend>部位病害关联表格</legend>
            <form name="posDisAdd" method="post" action="${pageContext.request.contextPath}/posDisAction.do?method=updateAction&labelId=<%=labelId%>">
                

<%
        int labelIdInt = Integer.parseInt(labelId);
        
        DiseaseDAO diseaseDAO = new DiseaseDAO();
        List<Disease> diseases = diseaseDAO.getDiseasesByLabelId(labelIdInt);

        PositionDAO positionDAO = new PositionDAO();
        List<Position> positions = positionDAO.getPositions(labelIdInt);

        PosDisDAO posdisDAO = new PosDisDAO();

        String tableHeadCss = " style=\"text-align: center;font-size: 14px; color: black;font-weight: bold;background-color: #D1D7DC;\" ";

        if(diseases==null || diseases.isEmpty() || positions==null || positions.isEmpty()){
            out.print("<table  class=\"theform\"><tr><td width = 200px align='center'>系统中数据不全，请插入数据！</td></tr></table>");
        }else{
        out.print("<table  class=\"theform\">");
        if(diseases.size()>0){
            out.print("<tr><th ");
            out.print(tableHeadCss);
            out.print(" width=\"60px\">部位/病害</th>");
            for (Position position : positions) {
                out.print("<th ");
                out.print(tableHeadCss);
                out.print(" width=\"80px\">");
                out.print(position.getPosName());
                out.print("</th>");
            }
            out.print("</tr>");
        }

        

        DatabaseManager dbm = new DatabaseManager();
        for (Disease disease : diseases) {
            List<Integer> checkedPositions = posdisDAO.getPosIdByDisId(dbm, disease.getDisId());
            out.print("<tr>");
            out.print("<td ");
            out.print(tableHeadCss);
            out.print(" width=100px>");
            out.print(disease.getDisName());
            out.print("</td>");
            for (Position position : positions) {
                out.print("<td align=center>");
                if(checkedPositions.contains(position.getPosId()))
                    out.print("<input type=\"checkbox\" name=\""+ position.getPosId() +"\" value=\""+ disease.getDisId() +"\" checked/>");
                else
                    out.print("<input type=\"checkbox\" name=\""+ position.getPosId() +"\" value=\""+ disease.getDisId() +"\" />");
                out.print("</td>");
            }
            out.print("</tr>");
        }
        dbm.close();
        out.print("</table>");
%>
            <div style="float: right; height: 30px;vertical-align: middle;">
                <input type="hidden" name="labelId" value="<%=labelId%>"/>
                <input type="submit" class="bt" name="button" value="提交内容"/>
            </div>
<%}%>
            </form>
        </fieldset>


       </td>
    </tr>


  </tbody>
  <!-- /Pannel contents -->
</table>

    </body>
</html>