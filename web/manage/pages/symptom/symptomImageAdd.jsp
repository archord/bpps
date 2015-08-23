<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.PositionDAO" %>

<%
request.setCharacterEncoding("UTF-8");
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>症状图片添加页面</title>
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
        <th align="left">您的位置：症状图片管理 > 增加症状图片</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>
        <div id="page">
            <div id="formContent">

            </div>
            <div>
            </div>
        </div>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">增加症状图片</th>
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
        <legend>增加症状图片</legend>
            <form name="siAdd" method="post" action="${pageContext.request.contextPath}/symptomImageAction.do?method=addAction" enctype="multipart/form-data">
                <table  class="theform" >
                    <tr><th>症状所属位置：</th>
                        <td>
                        <select id="posId" name="posId" onChange="getPosSym(this);">

<%
        int labelIdInt = Integer.parseInt(labelId);
        PositionDAO PositionDAO = new PositionDAO();
        List<Position> Positions = PositionDAO.getPositions(labelIdInt);

        if(Positions==null || Positions.isEmpty()){
            out.print("<option value=\"0\">无</option>");
        }else
        
        for (Position position : Positions) {
            out.print("<option value=\"");
            out.print(position.getPosId());
            out.print("\">");
            out.print(position.getPosName());
            out.print("</option>");
        }
%>
                        </select>
                        </td></tr>
                <tr><th>所属症状：</th>
                    <td>
                    <select id="symId" name="symId">
                        <option value="0">无</option>
                    </select>
<%
        SymptomDAO symptomDAO = new SymptomDAO();
        for (Position position : Positions) {
            String symKey = "key:[";
            String symValue = "value:[";
            List<Symptom> symptoms = symptomDAO.getSymptomsByPosIdForImageAdd(position.getPosId());
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
        var option = null;
        //var option = new Option("空","0");
        //parentSymIdObj.add(option);
        if(keys.length==0){
            option = new Option("空","0");
            parentSymIdObj.add(option);
        }
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            parentSymIdObj.add(option);
        }
    }
    var posIdObj = document.getElementById("posId");
    getPosSym(posIdObj);

    /**
     * check some input box is null
     */
    function checkInputValue() {
        var disName = document.getElementsByName("siImage")[0].value;
        if(disName==null || disName==""){
            alert("症状图片不能为空");
            return;
        }
        document.getElementsByName("siAdd")[0].submit();
    }
</script>

                    </td></tr>
                <tr><th>症状图像：</th>
                    <td><input type="file" name="siImage"/><input type="hidden" name="labelId" value="<%=labelId%>"/></td></tr>
                <tr><td colspan="2"><input type="button" class="bt" name="button" value="提交内容" onclick="checkInputValue();"/> </td></tr>
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