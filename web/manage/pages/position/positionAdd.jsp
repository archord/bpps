<%-- 
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>部位添加页面</title>
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
        <th align="left">您的部位：部位管理 > 增加部位信息</th>
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
      <th class="pannel-head-mid">增加部位信息</th>
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
        <legend>增加病害部位</legend>
            <form name="positionAdd" method="post" action="${pageContext.request.contextPath}/positionAction.do?method=addAction" enctype="multipart/form-data">
                <table  class="theform" >
                    <tr><th>病害部位名称：</th>
                    <td><input type="text" name="posName" value="" /><input type="hidden" name="labelId" value="<%=labelId%>"/></td></tr>
                <tr><th>病害部位简介：</th>
                    <td><textarea name="posDescribe" rows="4" cols="60"></textarea></td></tr>
                <tr><th>病害部位图片：</th>
                    <td><input type="file" name="posImage"/></td></tr>
                <tr><td colspan="2"><input type="button" class="bt" name="button" value="提交内容" onclick="checkInputValue();"/></td></tr>
                </table>
            </form>
        </fieldset>


       </td>
    </tr>
       <script type="text/javascript" >

                    /**
                     * check some input box is null
                     */
                    function checkInputValue() {
                        var disName = document.getElementsByName("posName")[0].value;
                        if(disName==null || disName==""){
                            alert("疾病部位名称不能为空");
                            return;
                        }
                        document.getElementsByName("positionAdd")[0].submit();
                    }
	</script>

  </tbody>
  <!-- /Pannel contents -->
</table>

    </body>
</html>
<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>