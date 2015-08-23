<%-- 
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.pojo.FunctionPage"%>
<%@page import="com.bpps.dao.FunctionPageDAO"%>
<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>

<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("disContent") != null ? request.getParameter("disContent") : "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>标签调整顺序页面</title>
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
        <th align="left">您的位置：标签管理 > 标签调整顺序</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>
        <div id="page">
            <div id="formContent">

            </div>
            <div>
            <%=htmlData%>
            </div>
        </div>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">标签调整顺序</th>
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
        <legend>一级标签列表</legend>
            <form name="labelAdd" method="post" action="${pageContext.request.contextPath}/labelAction.do?method=adjustMenuOrder">
                <table  class="theform" >
                    <tr><th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">标签名称</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">导航栏显示次序</th></tr>
<%

        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> level1 = labelDAO.getMenuLabelsOrderByOrder();
        int i = 1;
        StringBuffer sb = new StringBuffer();
        for (LabelSystem label1 : level1) {
            out.print("<tr><td>");
            out.print(label1.getName());
            out.print("</td><td><input name=\"label");
            out.print(label1.getLabelId());
            out.print("\" id=\"label");
            out.print(i++);
            out.print("\" value=\"");
            out.print(label1.getMenuOrder());
            out.print("\"></td></tr>");
            sb.append("label");
            sb.append(label1.getLabelId());
            sb.append(",");
        }
%>
                    <tr><td colspan="2"><input type="hidden" id="menunum" value="<%=level1.size()%>"/>
                            <input type="hidden" id="labellst" value="<%=sb.substring(0, sb.length()-1)%>"/>
                        <input type="submit" class="bt" name="button" value="提交内容" onclick="return checkInputValue();"/> </td></tr>
                </table>
            </form>
        </fieldset>


       </td>
    </tr>


  </tbody>
  <!-- /Pannel contents -->
</table>

<script type="text/javascript">

    /**
     * check some input box is null
     */
    function checkInputValue() {
        var labelLst = document.getElementById("labellst").value;
        var labelNames = labelLst.split(',');
        var orderLst = new Array();
        for(var i=0; i<labelNames.length; i++){
            orderLst.push(document.getElementById(labelNames[i]).value);
        }
        orderLst.sort();
        for(var i=0; i<orderLst.length-1; i++){
            if(orderLst[i]==orderLst[i+1]){
                alert("排序重复，请填写正确的次序！");
                return false;
            }
        }
        return true;
    }
</script>

    </body>
</html>