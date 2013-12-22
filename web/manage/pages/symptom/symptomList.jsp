<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Position"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Symptom" %>
<%@page import="com.bpps.pojo.Symptom2" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.SymptomDAO" %>

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
        <th align="left">您的位置：症状管理 > 症状信息列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">症状信息列表</th>
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
        <legend>症状列表</legend>
            <form name="symptomList" method="post" action="${pageContext.request.contextPath}/symptomAction.do?method=listAction&labelId=<%=labelId%>">
<table  class="theform">
                    <tr><th>选择部位：<select name="posId">

<%
        int labelIdInt = Integer.parseInt(labelId);
        int posId =  (Integer)request.getAttribute("posId");
        PositionDAO PositionDAO = new PositionDAO();
        List<Position> Positions = PositionDAO.getPositions(labelIdInt);

        if(Positions==null || Positions.isEmpty()){
            out.print("<option value=\"\">暂无数据</option>");
        }else
        out.print("<option value=\"0\">全部</option>");
        for (Position position : Positions) {
            if(position.getPosId()==posId)
                out.print("<option selected value=\"");
            else
                out.print("<option value=\"");
            out.print(position.getPosId());
            out.print("\">");
            out.print(position.getPosName());
            out.print("</option>");
        }
%>
                     </select>
                <input type="submit" class="bt" name="button" value="提交"/></th></tr>
                </table>
                     
                <table  class="theform">
                    <tr><th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">症状部位</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">症状名称</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">父症状</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">症状名称属性</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

<%
        SymptomDAO symptomDAO = new SymptomDAO();
        List<Symptom2> symptoms = null;
        if(posId == 0){
            symptoms = symptomDAO.getSymptoms2ByLabelId(labelIdInt);
        }else{
            symptoms = symptomDAO.getSymptoms2ByPosId(posId);
        }

        if(symptoms==null || symptoms.isEmpty()){
            out.print("<tr><td colspan=4 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
        }else
        for (Symptom2 symptom2 : symptoms) {
            Symptom symptom = symptom2.getSymptom();
            out.print("<tr><td>");
            out.print(symptom2.getPosName());
            out.print("</td><td>");
            out.print(symptom.getSymName());
            out.print("</td><td>");
            out.print(symptom2.getParentSymName());
            out.print("</td><td>");
            int pro = symptom.getSymProperty();
            if(pro==1){
                out.print("是否");
            }else{
                out.print("文字描述");
            }
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/symptomAction.do?method=updateAction&symId=");
            out.print(symptom.getSymId());
            out.print("&labelId=");
            out.print(labelId);
            out.print("'>修改</a>");
            out.print("</td><td><a onclick=\"return confirm('是否删除?');\" href='");
            out.print(request.getContextPath());
            out.print("/symptomAction.do?method=deleteAction&symId=");
            out.print(symptom.getSymId());
            out.print("&labelId=");
            out.print(labelId);
            out.print("'>删除</a>");
            out.print("</td><td>");
        }
%>

                </table>
                
            </form>
        </fieldset>


       </td>
    </tr>


  </tbody>
  <!-- /Pannel contents -->
</table>

    </body>
</html>