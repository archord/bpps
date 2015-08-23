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
        <title>添加标签页面</title>
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
        <th align="left">您的位置：标签管理 > 增加标签</th>
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
      <th class="pannel-head-mid">增加标签信息</th>
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
        <legend>增加标签</legend>
            <form name="labelAdd" method="post" action="${pageContext.request.contextPath}/labelAction.do?method=addAction">
                <table  class="theform" >
                    <tr><th>父标签：</th>
                        <td>
                        <input type="hidden" id="pid" name="pid" value="0"/>
                        <%@include file="/WEB-INF/jspf/mutil_level_selectbox.jspf"%>
                        
                        <!--select id="level1" name="level1" onChange="setLevel2(this);"-->
<!--%
        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> level1 = labelDAO.getLevel1Labels();

        out.print("<option value=\"0\">无</option>");
        if(level1!=null && !level1.isEmpty())
        for (LabelSystem label1 : level1) {
            out.print("<option value=\"");
            out.print(label1.getLabelId());
            out.print("\">");
            out.print(label1.getName());
            out.print("</option>");
        }
%-->
                        <!--/select>
       <select id="level2" name="level2" onChange="setLevel3(this);">
                        <option value="0">无</option>
                    </select>
                        <select id="level3" name="level3" onchange="changeLevel3(this);">
                        <option value="0">无</option>
                    </select-->
<!--%
        if(level1!=null && !level1.isEmpty())
        for (LabelSystem label1 : level1) {
            String level1Key = "key:[";
            String level1Value = "value:[";
            List<LabelSystem> level2 = labelDAO.getLabelsByPId(label1.getLabelId());
            for (LabelSystem label2 : level2) {
                level1Key = level1Key + label2.getLabelId() + ",";
                level1Value = level1Value + "'"+ label2.getName() + "',";
                
                String level2Key = "key:[";
                String level2Value = "value:[";
                List<LabelSystem> level3 = labelDAO.getLabelsByPId(label2.getLabelId());
                for (LabelSystem label3 : level3) {
                    level2Key = level2Key + label3.getLabelId() + ",";
                    level2Value = level2Value + "'"+ label3.getName() + "',";
                }
                if(!level2Key.equals("key:["))
                    level2Key = level2Key.substring(0, level2Key.length()-1);
                if(!level2Value.equals("value:["))
                    level2Value = level2Value.substring(0, level2Value.length()-1);
                String rst = "{" + level2Key + "]," + level2Value + "]}";
                out.print("<input type=\"hidden\" id=\"label_"+ label2.getLabelId() +"\" value=\""+ rst +"\"/>");
            }
            if(!level1Key.equals("key:["))
                level1Key = level1Key.substring(0, level1Key.length()-1);
            if(!level1Value.equals("value:["))
                level1Value = level1Value.substring(0, level1Value.length()-1);
            String rst = "{" + level1Key + "]," + level1Value + "]}";
            out.print("<input type=\"hidden\" id=\"label_"+ label1.getLabelId() +"\" value=\""+ rst +"\"/>");
        }
%-->

                        
                        </td></tr>
                <tr><th>标签名称：</th>
                    <td><input type="text" name="name" value="" /></td></tr>
                <!--tr><th>功能页面：</th>
                    <td>
                        <select id="pageid" name="pageid"-->

<%
//        FunctionPageDAO pageDAO = new FunctionPageDAO();
//        List<FunctionPage> pages = pageDAO.getAllFunctionPages();
//
//        out.print("<option value=\"0\">无</option>");
//        for (FunctionPage page1 : pages) {
//            out.print("<option value=\"");
//            out.print(page1.getPageId());
//            out.print("\" ");
//            out.print(">");
//            out.print(page1.getName());
//            out.print("</option>");
//        }
%>
                        <!--/select></td></tr>
                <tr><th>标签所对应URL：</th>
                    <td><input type="text" name="url" value="" /></td></tr-->
                <tr><th>是否激活：</th>
                    <td>
                        <select name="isactive">
                            <option value="0">否</option>
                            <option value="1">是</option>
                        </select></td></tr>
                <tr><th>是否作物：</th>
                    <td>
                        <select name="iscrop">
                            <option value="0">否</option>
                            <option value="1">是</option>
                        </select></td></tr>
                <tr><td colspan="2"><input type="button" class="bt" name="button" value="提交内容" onclick="checkInputValue();"/> </td></tr>
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