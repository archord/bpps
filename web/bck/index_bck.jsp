<%@page import="com.bpps.pojo.Position"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.bpps.pojo.Disease" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.DiseaseDAO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN">
    <head>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
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
                                <ul class="list1">病害诊断与防治</ul>
                                <!--li class="list2"><a href="#" onclick="return false;"> 作物类型选择 </a></li-->
                                <li class="list2"><a href="<%=urlPath%>/symSearch.jsp" target="_blank"> 症状文字检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/imageSearch.jsp" target="_blank"> 症状图像检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/disDescribe.jsp" target="_blank"> 症状标准描述 </a></li>
                                <ul class="list1">虫害诊断与防治</ul>
                                <ul class="list1">在线咨询平台</ul>
                                <ul class="list1">语音咨询平台</ul>
                                <ul class="list1">专家资源</ul>
                                <ul class="list1">实用技术</ul>

                            </div>
                        </div>
                    </td>
                    <td>
                        <div id="mainCenter">
        <p class="title">系统简介</p>
        <p class="detail">农作物病虫害诊断与防治系统数据库，包括蔬菜、粮食作物、经济作物等多种作物的病虫害信息数据库、植物保护专家资源数据库、农作物病虫害标准图像实例数据库等多个子数据库。
            其中，农作物病虫害标准图像实例数据库主要包括黄瓜病害（20种）、虫害（15种）的典型形态特征文字描述知识库和彩色图像实例库，入库标准图谱3800余张，信息丰富、质量高。
            植物保护专家资源数据库中包括有我国各地从事与农作物植物保护研究的50位专家。</p>
        
        <p class="title">病害症状标准化描述文字检索系统</p>
        <p class="detail">根据各病害症状特点，将危害部位分为五大类：分别为全株（根部）、苗期（包括子叶、真叶、生长点及根茎部）、成株期叶部、成株期茎蔓须部、成株期果实等。
            检索时，首先选择病害的危害部位；然后检索各部位的危害症状，系统根据操作者选择的病害症状，判断出病害的类别。</p>
        <p class="title">病害症状图像检索系统</p>
        <p class="detail">根据病害危害部位，选择与田间症状相对应的相似图像，系统判断病害的类别。</p>
        <p class="title">病害防治标准化描述系统</p>
        <p class="detail">根据病害的名称，直接选择感兴趣的病害类别，查看该病害的病原菌、症状、发病规律、防治技术等的总结性描述。</p>
        <p>&nbsp; </p>

                            
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