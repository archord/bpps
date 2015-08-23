<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.bpps.pojo.SymptomDiscribe"%>
<%@page import="com.bpps.dao.SymptomDiscribeDAO"%>
<%@page import="java.util.Map"%>
<%@page import="com.bpps.dao.SymDisDAO"%>
<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@page import="com.bpps.dao.PosDisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="com.bpps.dao.PositionDAO" %>
<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>

<%
request.setCharacterEncoding("UTF-8");
String strPosId = request.getParameter("posid");
int posId = 0;
if(strPosId!=null && !strPosId.isEmpty()){
    posId = Integer.parseInt(strPosId);
}else{
    posId = (Integer)request.getAttribute("posid");
}

PositionDAO positionDAO = new PositionDAO();
Position curPos = positionDAO.getPositionById(posId);
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
        <th align="left">您的位置：症状病害关联 > <%=curPos.getPosName()%></th>
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
        <legend>症状病害关联</legend>
            <form name="symDisAction" method="post" action="${pageContext.request.contextPath}/symDisAction.do">
                
<%
        SymptomDAO symptomDAO = new SymptomDAO();
        List<Symptom> symptoms = symptomDAO.getSymptomsByPosId(posId);

        PosDisDAO posdisDAO = new PosDisDAO();
        List<Disease> diseases = posdisDAO.getDiseasesByPosId(posId);

        SymDisDAO symDisDAO = new SymDisDAO();

        SymptomDiscribeDAO symptomDiscribeDAO = new SymptomDiscribeDAO();

        String tableHeadCss = " style=\"text-align: center;font-size: 12px; color: black;font-weight: bold;background-color: #D1D7DC;table-layout: fixed;\" ";

        if(diseases==null || diseases.isEmpty() || symptoms==null || symptoms.isEmpty()){
            out.print("<table class=\"theform\"><tr><td width = 200px align='center'>系统中数据不全，请插入数据！</td></tr></table>");
        }else{
        out.print("<table  class=\"theform\">");
        if(diseases.size()>0){
            out.print("<tr><th ");
            out.print(tableHeadCss);
            out.print(" width=\"60px\">症状/病害</th>");
            for (Symptom symptom : symptoms) {
                out.print("<th ");
                out.print(tableHeadCss);
                out.print(" width=\"60px\">");
                out.print(symptom.getSymName());
                out.print("</th>");
            }
            out.print("</tr>");
        }

        Map<Integer, String> symDiscOptionMap = new HashMap<Integer, String>();
        for (Symptom symptom : symptoms) {
            List<SymptomDiscribe> symptomDiscribes = symptomDiscribeDAO.getSymptomDiscribesBySymId(symptom.getSymId());
            StringBuilder symDiscOption = new StringBuilder();
            symDiscOption.append("<select name=\"");
            symDiscOption.append(symptom.getSymId());
            symDiscOption.append("_");
            //symDiscOption.append(disease.getDisId());
            symDiscOption.append("\">");
            symDiscOption.append("<option value=\"0\">无</option>");
            if (symptomDiscribes != null || !symptomDiscribes.isEmpty()) {
                for (SymptomDiscribe symptomDiscribe : symptomDiscribes) {
                    symDiscOption.append("<option value=\"");
                    symDiscOption.append(symptomDiscribe.getSymDiscId());
                    symDiscOption.append("\">");
                    symDiscOption.append(symptomDiscribe.getSymDiscName());
                    symDiscOption.append("</option>");
                }
            }
            symDiscOption.append("</select>");
            symDiscOptionMap.put(symptom.getSymId(), symDiscOption.toString());
        }
        for (Disease disease : diseases) {
            Map<Integer,Integer> values = symDisDAO.getDiscribeByPosDisId(posId, disease.getDisId());
            out.print("<tr>");
            out.print("<td ");
            out.print(tableHeadCss);
            out.print(" width=100px>");
            out.print(disease.getDisName());
            out.print("</td>");

            for (Symptom symptom : symptoms) {
                String optionName = "<select name=\"" + symptom.getSymId()+"_";
                //symDiscOption.append(disease.getDisId());
                StringBuilder symptomDiscribes = new StringBuilder(symDiscOptionMap.get(symptom.getSymId()));
                symptomDiscribes.insert(symptomDiscribes.indexOf(optionName)+optionName.length(), disease.getDisId());

                out.print("<td align=center>");
                if(values.containsKey(symptom.getSymId())){
                    int value = values.get(symptom.getSymId());
                    if(symptom.getSymProperty()==1){
                        if(value!=0)
                            out.print("<input type=\"checkbox\" name=\""+ symptom.getSymId() +"\" value=\""+ disease.getDisId() +"\" checked/>");
                        else
                            out.print("<input type=\"checkbox\" name=\""+ symptom.getSymId() +"\" value=\""+ disease.getDisId() +"\" />");
                    }else{
                        if(value!=0){
                            StringBuilder tmpBuilder = new StringBuilder(symptomDiscribes.toString());
                            String tmpStr = "<option value=\"" + value + "\"" ;
                            int index = tmpBuilder.indexOf(tmpStr);
                            if(index>0)
                                tmpBuilder.insert(index+tmpStr.length(), " selected");
                            out.print(tmpBuilder.toString());
                            //out.print("<input type=\"text\" name=\""+ symptom.getSymId() +"_"+ disease.getDisId() +"\" value=\""+ values.get(symptom.getSymId()) +"\" style=\"width:50px\"/>");
                        }else{
                            out.print(symptomDiscribes.toString());
                        }
                    }
                }else{
                    if(symptom.getSymProperty()==1)
                        out.print("<input type=\"checkbox\" name=\""+ symptom.getSymId() +"\" value=\""+ disease.getDisId() +"\" />");
                    else
                        out.print(symptomDiscribes.toString());
                }
                out.print("</td>");
            }
            out.print("</tr>");
        }
        out.print("</table>");
%>

            <div style="float: right; height: 30px;vertical-align: middle;">
                <input type="hidden" name="posId" value="<%=posId%>"/>
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