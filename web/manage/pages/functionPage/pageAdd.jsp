<%-- 
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.pojo.FunctionPage"%>
<%@page import="com.bpps.dao.FunctionPageDAO" %>
<%@page import="com.bpps.pojo.Article"%>
<%@page import="com.bpps.dao.ArticleDAO" %>

<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("disContent") != null ? request.getParameter("disContent") : "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>功能页添加页面</title>
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
        <th align="left">您的位置：功能页管理 > 增加功能页信息</th>
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
      <th class="pannel-head-mid">增加功能页信息</th>
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
        <legend>增加功能页</legend>
            <form name="pageAdd" method="post" action="${pageContext.request.contextPath}/functionPageAction.do?method=addAction">
                <table  class="theform" >
                    <tr><th>所属标签：</th>
                        <td>
                        <select id="labelId" name="labelId">

<%
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
%>
                        </select>
                            
                        </td></tr>
                    <tr><th>功能页名称：</th>
                        <td><input type="text" name="name" value="" /></td></tr>
                <tr><th>功能页链接：</th>
                    <td><input type="text" name="url" value="" /></td></tr>
                <tr><th>是否是文章：</th>
                    <td>
                    <select id="ispage" name="ispage">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                    </td></tr>
                <tr><th>仅黄瓜显示：</th>
                    <td>
                    <select id="onlyHGShow" name="onlyHGShow">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                    </td></tr>
                <tr><th>文章：</th>
                    <td>
                    <select id="articleId" name="articleId">
<%
        ArticleDAO articleDAO = new ArticleDAO();
        List<Article> articles = articleDAO.getArticles();

        if(articles==null || articles.isEmpty()){
            out.print("<option value=\"0\">无</option>");
        }else{
            out.print("<option value=\"0\">无</option>");
            for (Article article1 : articles) {
                out.print("<option value=\""+ article1.getArticleId() + "\">"+ article1.getArticleName() + "</option>");
            }
        }
%>
                    </select>
                    </td></tr>
                
                <tr><td colspan="2"><input type="button" class="bt" name="button" value="提交内容" onclick="checkInputValue();"/> </td></tr>
                </table>
            </form>
        </fieldset>
       </td>
    </tr>
  </tbody>
  <!-- /Pannel contents -->
</table>
                
<script type="text/javascript" >
    /**
     * check some input box is null
     */
    function checkInputValue() {
        var name = document.getElementsByName("name")[0].value;
        if(name==null || name==""){
            alert("标签名称不能为空");
            return;
        }
        document.getElementsByName("pageAdd")[0].submit();
    }
</script>
    </body>
</html>