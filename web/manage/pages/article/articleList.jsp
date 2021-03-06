<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Article"%>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.ArticleDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>文章列表页面</title>
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
        <th align="left">您的位置：文章管理 > 文章列表</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">文章列表</th>
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
        <legend>文章列表</legend>
            <form name="symptomList" method="post" action="${pageContext.request.contextPath}/symptomAction.do?method=listAction">

                <table  class="theform">
                    <tr>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">编号</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">所属标签</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">文章名称</th>
                        <!--th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;">文章内容</th-->
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">修改</th>
                        <th style="text-align: left;font-size: 16px; color: black;font-weight: bold;background-color: #D1D7DC;" width="50px">删除</th></tr>

<%
        ArticleDAO articleDAO = new ArticleDAO();
        List<Article> articles = articleDAO.getArticles();

        if(articles==null || articles.isEmpty()){
            out.print("<tr><td colspan=6 align='center'>系统中暂时没有数据，请插入数据！</td></tr>");
        }else
        for (Article article1 : articles) {
            out.print("<tr><td>");
            out.print(article1.getArticleId());
            out.print("</td><td>");
            out.print(article1.getLabelName());
            out.print("</td><td>");
            out.print(article1.getArticleName());
//            out.print("</td><td>");
//            String articleContent = article1.getArticleContent();
//            if(articleContent.length()<50)
//                out.print(articleContent);
//            else
//                out.print(articleContent.substring(0, 50)+"…");
            out.print("</td><td><a href='");
            out.print(request.getContextPath());
            out.print("/articleAction.do?method=updateAction&articleId=");
            out.print(article1.getArticleId());
            out.print("'>修改</a>");
            out.print("</td><td><a onclick=\"return confirm('是否删除?');\" href='");
            out.print(request.getContextPath());
            out.print("/articleAction.do?method=deleteAction&articleId=");
            out.print(article1.getArticleId());
            out.print("'>删除</a>");
            out.print("</td><td>");
        }
%>

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