<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>
<%@page import="com.bpps.pojo.Article"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.ArticleDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
Article article = (Article)request.getAttribute("detail");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>文章修改页面</title>
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
        <th align="left">您的位置：文章管理 > 修改文章信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">修改文章信息</th>
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
        <legend>修改文章</legend>
            <form name="articleUpdate" method="post" action="${pageContext.request.contextPath}/articleAction.do?method=doUpdateAction">
                <table  class="theform" >
                    <tr><th>所属标签：</th>
                        <td>
                        <select id="labelId" name="labelId">

<%
        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> level1 = labelDAO.getAllLabels();

        out.print("<option value=\"0\">无</option>");
        if(level1!=null && !level1.isEmpty())
        for (LabelSystem label1 : level1) {
            out.print("<option value=\"");
            out.print(label1.getLabelId());
            out.print("\" ");
            if(label1.getLabelId() == article.getLabelId())
             out.print("selected");
            out.print(" >");
            out.print(label1.getName());
            out.print("</option>");
        }
%>
                        </select>
                            
                        </td></tr>
                    <tr><th>文章名称：</th>
                        <td>
                            <input type="hidden" name="articleId" value="<%=article.getArticleId()%>" />
                            <input type="text" name="articleName" value="<%=article.getArticleName()%>" /></td></tr>
                <tr><th>文章内容：</th>
                    <td><textarea name="articleContent" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"><%=article.getArticleContent()%></textarea></td></tr>
                
                <tr><td colspan="2">
                    <input type="submit" id="addArticleButton" class="bt" name="button" value="提交内容" onclick="return checkInputValue();"/> (提交快捷键: Ctrl + Enter)
                    </td></tr>
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
			var editor1 = K.create('textarea[name="articleContent"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['articleUpdate'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['articleUpdate'].submit();
					});
				}
			});
			prettyPrint();
		});
    /**
     * check some input box is null
     */
                   function checkInputValue() {
                        var disName = document.getElementsByName("articleName")[0].value;
                        if(disName==null || disName==""){
                            alert("文章名称不能为空");
                            return false;
                        }
                        //document.getElementsByName("diseaseAdd")[0].submit();
                        //document.getElementById("addDiseaseButton").click();
                        return true;
                    }
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