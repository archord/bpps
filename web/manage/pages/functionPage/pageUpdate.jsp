<%--
    Document   : SymptomAdd
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
FunctionPage functionPage = (FunctionPage)request.getAttribute("detail");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>功能页修改页面</title>
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
        <th align="left">您的位置：功能页管理 > 修改功能页信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">修改功能页信息</th>
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
        <legend>修改功能页</legend>
            <form name="symptomAdd" method="post" action="${pageContext.request.contextPath}/functionPageAction.do?method=doUpdateAction">
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
            out.print("\" ");
            if(label1.getLabelId()==functionPage.getLabelId())
                out.print("selected");
            out.print(">");
            out.print(label1.getName());
            out.print("</option>");
        }
%>
                        </select>
                            
                        </td></tr>
                  <tr><th>功能页名称：</th>
                        <td>
                            <input type="hidden" name="pageId" value="<%=functionPage.getPageId()%>" />
                            <input type="text" name="name" value="<%=functionPage.getName()%>" /></td></tr>
                <tr><th>功能页链接：</th>
                    <td><input type="text" name="url" value="<%=functionPage.getUrl()%>" /></td></tr>
                <tr><th>是否是文章：</th>
                    <td>
                    <select id="ispage" name="ispage">
                        <option value="0">否</option>
                        <option value="1" <%if(functionPage.getIspage()==1)out.print("selected");%>>是</option>
                    </select>
                    </td></tr>
                <tr><th>仅黄瓜显示：</th>
                    <td>
                    <select id="onlyHGShow" name="onlyHGShow">
                        <option value="0">否</option>
                        <option value="1" <%if(functionPage.getOnlyHGShow()==1)out.print("selected");%>>是</option>
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
                out.print("<option value=\""+ article1.getArticleId() + "\" ");
                if(functionPage.getArticleId() == article1.getArticleId())
                    out.print("selected");
                out.print(">");
                out.print(article1.getArticleName());
                out.print("</option>");
            }
        }
%>
                    </select>
                    </td></tr>
                <tr><td colspan="2"><input type="submit" class="bt" name="button" value="提交内容" /></td></tr>
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