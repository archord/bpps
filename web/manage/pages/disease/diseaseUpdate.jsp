<%--
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Disease"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
Disease disease = (Disease)request.getAttribute("detail");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>疾病种类修改页面</title>
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
        <th align="left">您的位置：疾病管理 > 修改疾病信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">修改疾病信息</th>
      <td class="pannel-head-right"></td>
    </tr>
  </thead>
  <!-- /Pannel title -->
  <!-- Pannel contents -->
  <tbody>

    <tr>
      <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
        <fieldset>
        <legend>修改疾病信息</legend>
            <form name="diseaseUpdate" method="post" action="${pageContext.request.contextPath}/diseaseAction.do?method=doUpdateAction" enctype="multipart/form-data">
                <table  class="theform" >
                    <tr><th>疾病类别：</th>
                        <td><input type="radio" name="disType" <%if(disease.getDisType()==0)out.print("checked");%> value="0" />病害&nbsp;
                            <input type="radio" name="disType" <%if(disease.getDisType()==1)out.print("checked");%> value="1" />虫害</td></tr>
                    <tr><th>疾病名称：</th>
                        <td><input type="text" name="disName" value="<%=disease.getDisName()%>" />
                            <input type="hidden" name="disId" value="<%=disease.getDisId()%>"/>
                            <input type="hidden" name="labelId" value="<%=disease.getLabelId()%>"/></td></tr>
                <tr><th>疾病英文名称：</th>
                    <td><input type="text" name="disNameEn" value="<%=disease.getDisNameEn()%>" /></td></tr>
                <tr><th>疾病图片：</th>
                    <td><input type="file" name="disImage" value="" /><input type="hidden" name="disImagePath" value="<%=disease.getDisImagePath()%>" /></td></tr>
                <tr><th>疾病简介：</th>
                    <td><textarea name="disIntroduction" rows="4" cols="60"><%=disease.getDisIntroduction()%></textarea></td></tr>
                <tr><th>疾病详细内容：</th<td></td></tr>
                <tr><td colspan="2"><textarea name="disContent" cols="100" rows="6" style="width:700px;height:150px;visibility:hidden;"><%=disease.getDisContent()%></textarea>
                </td></tr>
                <tr><th>疾病防治内容：</th<td></td></tr>
                <tr><td colspan="2"><textarea name="disPreventionContent" cols="100" rows="6" style="width:700px;height:150px;visibility:hidden;"><%=disease.getDisPreventionContent()%></textarea>
                </td></tr>
                <tr><th>疾病高光谱特征：</th<td></td></tr>
                <tr><td colspan="2"><textarea name="disSpectrum" cols="100" rows="6" style="width:700px;height:150px;visibility:hidden;"><%=disease.getDisSpectrum()%></textarea>
                </td></tr>
                <tr><td colspan="2"><input type="submit" class="bt" name="button" value="提交内容" /> (提交快捷键: Ctrl + Enter)</td></tr>
                </table>
            </form>
        </fieldset>


       </td>
    </tr>


  </tbody>
  <!-- /Pannel contents -->
</table>

        <script type="text/javascript" >
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="disContent"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
				}
			});
			var editor2 = K.create('textarea[name="disPreventionContent"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
				}
			});
			var editor3 = K.create('textarea[name="disSpectrum"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['diseaseUpdate'].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>
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