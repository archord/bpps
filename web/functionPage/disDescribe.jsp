<%@page import="com.bpps.pojo.Position"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>

<%
request.setCharacterEncoding("UTF-8");
String labelId = request.getParameter("labelId");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>黄瓜主要病害标准化远程智能诊断系统Beta1</title>
        <link href="ui/layout.css" rel="stylesheet" type="text/css"/>
        <!--script language="javascript" type="text/javascript" src="js/jquery.js"></script-->
    </head>
    <body>

        <div id="page">
            <div id="header" style="border: solid 1px gray;">
                <div id="headerLogo">
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img src="${pageContext.request.contextPath}/attached/image/sysimg/head.jpg"/></a>
                </div>
                <div id="headerNav"><span><a href="${pageContext.request.contextPath}/index.jsp">黄瓜</a></span><span><a>番茄</a></span><span><a>茄子</a></span><span><a>南瓜</a>
                    <span><a>西葫芦</a></span><span><a>辣椒</a></span><span><a>白菜</a></span><span><a>草莓</a></span></div>
            </div>

            <table id="mainTable" >
                <tr>
                    <td>
                        <div id="mainLeft">
                            <div id="login">
                                <form name="userLogin" method="post" action="${pageContext.request.contextPath}/userInfoAction.do?method=loginAction">
                                <table>
                                    <%
                                    String urlPath = request.getContextPath();
                                    Object loginError = request.getAttribute("loginerror");
                                    int loginStatus = 0;
                                    if(loginError!=null){
                                        loginStatus = (Integer)loginError;
                                    }
                                    if(loginStatus==1){
                                        out.println("<tr><td colspan=\"2\"><span style=\"color:red\">用户名或密码错误</span></td></tr>");
                                    }else if(loginStatus==2){
                                        out.println("<tr><td colspan=\"2\"><span style=\"color:red\">请登录</span></td></tr>");
                                    }else{
                                        out.println("<tr style=\"height:10px\"><td clospan=\"2\"></td></tr>");
                                    }
                                    %>

                                    <tr ><td>用户名：</td><td><input type="text" name="userName" style="width:100px"/></td></tr>
                                    <tr><td>密码：</td><td><input type="password" name="password" style="width:100px"/></td></tr>
                                    <tr><td colspan="2" align="center"><input type="submit" value="登录" class="submit"  style="width:60px;height: 23px;"/></td></tr>
                                </table>
                                    </form>
                            </div>
                            <div id="menuList">
                                <ul class="list1">病害诊断</ul>
                                <!--li class="list2"><a href="#" onclick="return false;"> 作物类型选择 </a></li-->
                                <li class="list2"><a href="<%=urlPath%>/symSearch.jsp" target="_blank"> 症状文字检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/imageSearch.jsp" target="_blank"> 症状图像检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/disDescribe.jsp" target="_blank"> 症状标准描述 </a></li>
                                <ul class="list1">病害防治</ul>
                                <ul class="list1">虫害诊断</ul>
                                <ul class="list1">虫害防治</ul>
                                <ul class="list1">在线咨询平台</ul>
                                <ul class="list1">语言咨询平台</ul>
                                <ul class="list1">专家资源</ul>
                                <ul class="list1">实用技术</ul>

                            </div>
                        </div>
                    </td>
                    <td>
                        <div id="diseaseCenter">
                            <p class="title">黄瓜病害列表</p>
                            <table width="98%">
<%
            int labelIdInt = Integer.parseInt(labelId);
            DiseaseDAO diseaseDAO = new DiseaseDAO();
            List<Disease> diseases = diseaseDAO.getDiseasesByLabelId(labelIdInt);
            for (Disease disease : diseases) {
                String introduction = disease.getDisIntroduction();
                String subIntro = "";
                if(introduction!=null){
                    if(introduction.length()<35)
                        subIntro = introduction;
                    else
                        subIntro = introduction.substring(0, 35)+"…";
                }
                out.println("<tr><td style=\"width:30%;\"><span><a target=\"_blank\" href=\""+ urlPath +"/diseaseAction.do?method=detailAction&disId="
                        + disease.getDisId() +"\"> " + disease.getDisName() + " </a></span></td><td>"+subIntro+"</td></tr>");

            }
%>
</table>
<div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>

                        </div>
                    </td>
                </tr>
            </table>

        </div>

        <script type="text/javascript">

        </script>

        <div id="footer">Copyright©2011 All rights reserved, maintained by Beijing Plant Protection Station.</div>
    </body>
</html>


