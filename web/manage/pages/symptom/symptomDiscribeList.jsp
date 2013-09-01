<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.SymptomDiscribe"%>
<%@page import="com.bpps.dao.SymptomDiscribeDAO"%>
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
        <title>症状描述列表页面</title>
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
        <th align="left">您的位置：症状管理 > 症状描述列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">症状描述列表</th>
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
        <legend>症状描述列表</legend>
            <form name="symptomList" method="post" action="${pageContext.request.contextPath}/symptomDiscribeAction.do?method=listAction&labelId=<%=labelId%>">
                <table  class="theform">
                    <tr><th>选择部位：<select id="posId" name="posId" onChange="getPosSym(this);">

<%
        int labelIdInt = Integer.parseInt(labelId);
        
        PositionDAO PositionDAO = new PositionDAO();
        List<Position> Positions = PositionDAO.getPositions(labelIdInt);

        if(Positions==null || Positions.isEmpty()){
            out.print("<option value=\"\">暂无数据</option>");
        }else
        //out.print("<option value=\"0\">全部</option>");
        for (Position position : Positions) {
            out.print("<option value=\"");
            out.print(position.getPosId());
            out.print("\">");
            out.print(position.getPosName());
            out.print("</option>");
        }
%>
                     </select>
                    <select id="symId" name="symId">
                        <option value="0">无</option>
                    </select>
<%
        SymptomDAO symptomDAO = new SymptomDAO();
        for (Position position : Positions) {
            String symKey = "key:[";
            String symValue = "value:[";
            List<Symptom> symptoms = symptomDAO.getNeedDiscSymptomsByPosId(position.getPosId());
            for (Symptom symptom : symptoms) {
                symKey = symKey + symptom.getSymId() + ",";
                symValue = symValue + "'"+ symptom.getSymName() + "',";
            }
            if(!symKey.equals("key:["))
                symKey = symKey.substring(0, symKey.length()-1);
            if(!symValue.equals("value:["))
                symValue = symValue.substring(0, symValue.length()-1);
            String rst = "{" + symKey + "]," + symValue + "]}";
            out.print("<input type=\"hidden\" id=\"pos_"+ position.getPosId() +"\" value=\""+ rst +"\"/>");
        }
%>
<script type="text/javascript">

    /**
     * get pos sym
     */
    function getPosSym(obj) {
        var posId = obj.value;
        var posValues = document.getElementById("pos_"+posId).value;
        var parSym = eval("(" + posValues + ")");
        var keys = parSym.key;
        var values = parSym.value;
        //alert(keys);alert(values);
        var parentSymIdObj = document.getElementById("symId");
        for(var i=0;i<parentSymIdObj.options.length;)
        {
            parentSymIdObj.removeChild(parentSymIdObj.options[i]);
        }
        var option = new Option("空","0");
        parentSymIdObj.add(option);
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            parentSymIdObj.add(option);
        }
    }
    var posIdObj = document.getElementById("posId");
    getPosSym(posIdObj);
</script>
                <input type="submit" class="bt" name="button" value="提交"/></th></tr>
                </table>

                <table  class="theform">
                    <tr><th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">所属症状</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">症状描述名称</th>
                        <!--th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th-->
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

<%
        int symId =  (Integer)request.getAttribute("symId");
        SymptomDiscribeDAO symptomDiscribeDAO = new SymptomDiscribeDAO();
        List<SymptomDiscribe> symptomDiscribes = null;
        if(symId == 0){
            symptomDiscribes = symptomDiscribeDAO.getSymptomDiscribes();
        }else{
            symptomDiscribes = symptomDiscribeDAO.getSymptomDiscribesBySymId(symId);
        }

        if(symptomDiscribes==null || symptomDiscribes.isEmpty()){
            out.print("<tr><td colspan=3 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
        }else
        for (SymptomDiscribe symptomDiscribe : symptomDiscribes) {
            out.print("<tr><td>");
            out.print(symptomDiscribe.getSymName());
            out.print("</td><td>");
            out.print(symptomDiscribe.getSymDiscName());
            /*
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/symptomDiscribeAction.do?method=updateAction&symDiscId=");
            out.print(symptomDiscribe.getSymDiscId());
            out.print("'>修改</a>");
            */
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/symptomDiscribeAction.do?method=deleteAction&symDiscId=");
            out.print(symptomDiscribe.getSymDiscId());
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