<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Disease"%>
<%@page import="com.bpps.dao.DiseaseDAO"%>
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
        <title>症状描述添加页面</title>
        <!--link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" />
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
	<script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script>

    </head>

    <body>

<%
request.setCharacterEncoding("UTF-8");
String resultMessage = (String)request.getAttribute("resultMessage") != null ? (String)request.getAttribute("resultMessage") : "";
if(!resultMessage.equals(""))
        out.print("<script type=\"text/javascript\">alert('"+resultMessage+"');</script>");
%>

     <table cellpadding="0" cellspacing="0" id="main-mypos">
      <tr>
        <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
        <th align="left">您的位置：部位管理 > 部位图像管理</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">增加部位图像信息</th>
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
        <legend>增加部位图像</legend>
            <form name="symDisAdd" method="post" action="${pageContext.request.contextPath}/posDisAction.do?method=addImageAction" enctype="multipart/form-data">
                <table  class="theform" >
                    <tr><th>部位：</th>
                        <td>
                          <input type="hidden" name="labelId" value="<%=labelId%>"/>
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
                <tr><th>病害：</th>
                    <td>
                    <select id="disId" name="disId">
                        <option value="0">无</option>
                    </select>
<%
        DiseaseDAO diseaseDAO = new DiseaseDAO();
        for (Position position : Positions) {
            String symKey = "key:[";
            String symValue = "value:[";
            List<Disease> diseases = diseaseDAO.getDiseasesByPosId(position.getPosId());
            for (Disease disease : diseases) {
                symKey = symKey + disease.getDisId() + ",";
                symValue = symValue + "'"+ disease.getDisName() + "',";
            }
            if(!symKey.equals("key:["))
                symKey = symKey.substring(0, symKey.length()-1);
            if(!symValue.equals("value:["))
                symValue = symValue.substring(0, symValue.length()-1);
            String rst = "{" + symKey + "]," + symValue + "]}";
            out.print("<input type=\"hidden\" id=\"dis_"+ position.getPosId() +"\" value=\""+ rst +"\"/>");
        }
%>
<script type="text/javascript">

    /**
     * get pos sym
     */
    function getPosSym(obj) {
        var posId = obj.value;
        var posValues = document.getElementById("dis_"+posId).value;
        var parSym = eval("(" + posValues + ")");
        var keys = parSym.key;
        var values = parSym.value;
        //alert(keys);alert(values);
        var parentSymIdObj = document.getElementById("disId");
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
        var disName = document.getElementsByName("posDisImage")[0].value;
        if(disName==null || disName==""){
            alert("部位病害图像不能为空！");
            return;
        }
        document.getElementsByName("symDisAdd")[0].submit();
    }

</script>

                    </td></tr>
                <tr><th>部位病害图像：</th>
                    <td><input type="file" name="posDisImage"/></td></tr>
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