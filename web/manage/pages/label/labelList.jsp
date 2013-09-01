<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>

<%
request.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>标签列表页面</title>
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
        <th align="left">您的位置：标签管理 > 标签信息列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">标签信息列表</th>
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
        <legend>标签列表</legend>

            <form name="LabelList" method="post" action="${pageContext.request.contextPath}/manage/pages/label/labelList.jsp">
                <table  class="theform">
                    <tr><th>选择父标签：
                    <input type="hidden" id="pid" name="pid" value=""/>
                    <%@include file="/WEB-INF/jspf/mutil_level_selectbox.jspf"%>
                    <input type="submit" class="bt" name="button" value="提交"/></th></tr>
                </table>
            </form>
                
                <table  class="theform">
                    <tr><th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">编号</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">标签名称</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">父标签</th>
                        <!--th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">功能页</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">URL</th-->
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">是否激活</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">是否作物</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

<%
        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> labels = null;
        
        String strPid = request.getParameter("pid");
        if (strPid == null || strPid.equals("")) {
            labels = labelDAO.getAllLabels();
        } else {
            int pid = Integer.parseInt(strPid);
            if(pid == 0)
                labels = labelDAO.getLevel1Labels();
            else
                labels = labelDAO.getLabelsByPId(pid);
        }

        if(labels==null || labels.isEmpty()){
            out.print("<tr><td colspan=7 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
        }else
        for (LabelSystem label : labels) {
            out.print("<tr><td>");
            out.print(label.getLabelId());
            out.print("</td><td>");
            out.print(label.getName());
            out.print("</td><td>");
            out.print(label.getpName());
            out.print("</td><td>");
//            out.print(label.getPageName());
//            out.print("</td><td>");
//            out.print(label.getUrl());
//            out.print("</td><td>");
            if(label.getIsactive()==1)
                out.print("是");
            else
                out.print("否");
            out.print("</td><td>");
            if(label.getIscrop()==1)
                out.print("是");
            else
                out.print("否");
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/labelAction.do?method=updateAction&labelId=");
            out.print(label.getLabelId());
            out.print("'>修改</a>");
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/labelAction.do?method=deleteAction&labelId=");
            out.print(label.getLabelId());
            out.print("'>删除</a>");
            out.print("</td></tr>");
        }
%>

                </table>

        </fieldset>


       </td>
    </tr>


  </tbody>
  <!-- /Pannel contents -->
</table>

<script type="text/javascript">

    /**
     * set level2 labels
     */
    function setLevel2(obj) {
        var levelId = obj.value;
        var pidObj = document.getElementById("pid");
        pidObj.value = levelId;
        var levelValues = document.getElementById("label_"+levelId).value;
        var level2Labels = eval("(" + levelValues + ")");
        var keys = level2Labels.key;
        var values = level2Labels.value;
        //alert(keys);alert(values);
        var level2Obj = document.getElementById("level2");
        for(var i=0;i<level2Obj.options.length;)
        {
            level2Obj.removeChild(level2Obj.options[i]); 
        }
        var option = new Option("空","0");
        level2Obj.add(option);
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            level2Obj.add(option);
        }
        
        var level3Obj = document.getElementById("level3");
        for(var i=0;i<level3Obj.options.length;)
        {
            level3Obj.removeChild(level3Obj.options[i]); 
        }
        var option = new Option("空","0");
        level3Obj.add(option);
    }
    
    
    /**
     * set level3 labels
     */
    function setLevel3(obj) {
        var levelId = obj.value;
        var pidObj = document.getElementById("pid");
        pidObj.value = levelId;
        var levelValues = document.getElementById("label_"+levelId).value;
        var level2Labels = eval("(" + levelValues + ")");
        var keys = level2Labels.key;
        var values = level2Labels.value;
        //alert(keys);alert(values);
        var level2Obj = document.getElementById("level3");
        for(var i=0;i<level2Obj.options.length;)
        {
            level2Obj.removeChild(level2Obj.options[i]); 
        }
        var option = new Option("空","0");
        level2Obj.add(option);
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            level2Obj.add(option);
        }
    }
    
    function changeLevel3(obj){
        var levelId = obj.value;
        var pidObj = document.getElementById("pid");
        pidObj.value = levelId;
    }

    /**
     * check some input box is null
     */
    function checkInputValue() {
        var name = document.getElementsByName("name")[0].value;
        if(name==null || name==""){
            alert("标签名称不能为空");
            return;
        }
        document.getElementsByName("labelAdd")[0].submit();
    }
</script>
    </body>
</html>