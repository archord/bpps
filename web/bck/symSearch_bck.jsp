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
                <div id="headerNav"><span><a>黄瓜</a></span><span><a>番茄</a></span><span><a>茄子</a></span><span><a>南瓜</a>
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
                                <li class="list2"><a href="<%=urlPath%>/symSearch.jsp"> 症状文字检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/imageSearch.jsp"> 症状图像检索 </a></li>
                                <li class="list2"><a href="<%=urlPath%>/disDescribe.jsp"> 症状标准描述 </a></li>
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
                        <div id="mainCenter">
                            <form id="symSearch" name="symSearch" method="post" action="${pageContext.request.contextPath}/diseaseAction.do?method=mutilSearchAction">
<%

            int labelIdInt = Integer.parseInt(labelId);
            PositionDAO positionDAO= new PositionDAO();
            List<Position> positions = positionDAO.getPositions(labelIdInt);

            out.println("<table>");
            int colNum = 3;
            int rowNum = (positions.size()%colNum==0)?(positions.size()/colNum) : (positions.size()/colNum+1);
            if(colNum>positions.size())
                colNum=positions.size();
            out.println("<tr><td colspan="+colNum+" style=\"font-size: 16px;font-weight: bolder;margin-top: 10px;text-indent: 0em;\">请选择危害部位</td></tr>");
            for(int row=0; row<rowNum; row++){
                String trImg = "<tr>";
                String trName = "<tr>";
                String trChechbox = "<tr>";
                for(int col=0; col<colNum; col++){
                    int index = row*colNum+col;
                    if(index<positions.size()){
                        /*trImg += "<td>";
                        trImg += "<span class=img><a target=\"_blank\" href=\""+ urlPath +"/positionAction.do?method=detailAction&posId="+ positions.get(index).getPosId() +"\"> ";
                        trImg += "<img src=\""+ positions.get(index).getPosImagePath() +"\" alt=\""+ positions.get(index).getPosName() +"\"/></a></span> ";
                        trImg += "</td>";
                        
                        trName += "<td>";
                        trName += "<span class=imgName><a target=\"_blank\" href=\""+ urlPath +"/positionAction.do?method=detailAction&posId="+ positions.get(index).getPosId() +"\">";
                        trName += positions.get(index).getPosName();
                        trName += "</a></span>";
                        trName += "</td>";*/
                        
                        trImg += "<td>";
                        trImg += "<span class=img> ";
                        trImg += "<img src=\""+ positions.get(index).getPosImagePath() +"\" alt=\""+ positions.get(index).getPosName() +"\"/></span> ";
                        trImg += "</td>";
                        
                        trName += "<td>";
                        trName += "<input style=\"border:0px;width:20px;\" class=checkbox type=\"checkbox\" name=\"posIds\" value=\""+ positions.get(index).getPosId() +"\"/><span class=imgName>";
                        trName += positions.get(index).getPosName();
                        trName += "</span>";
                        trName += "</td>";
                    }else{
                        trImg += "<td>";
                        trImg += "</td>";
                        trName += "<td>";
                        trName += "</td>";
                    }
                }
                trImg += "</tr>";
                trName += "</tr>";
                out.println(trImg);
                out.println(trName);
            }
            out.println("<tr><td colspan=\""+ colNum +"\" align=\"center\">");
            out.println("<input type=\"hidden\" value=\"1\" name=\"startSymSearch\"/>");
            out.println("<input onclick=\"return checkedNum();\" type=\"submit\" value=\"检索\" class=\"submit\"  style=\"width:70px;height: 25px;\"/>");
            out.println("</td></tr>");
            out.println("</table>");
            /*
            for (Position position : positions) {//float:left;
                out.println("<div style=\"float:left; text-align:center;\"><table><tr><td>");
                out.println("<span><a href=\""+ urlPath +"/positionAction.do?method=detailAction&posId="+ position.getPosId() +"\"> ");
                out.println("<img src=\""+ position.getPosImagePath() +"\" alt=\""+ position.getPosName() +"\"/> ");
                out.println(" </a></span>");
                out.println("</td></tr>");
                out.println("<tr><td><span><a href=\""+ urlPath +"/positionAction.do?method=detailAction&posId="+ position.getPosId() +"\">");
                out.println(position.getPosName());
                out.println("</a></span></td></tr></table></div>");
            }
  */
%>
</form>
<div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>

                        </div>
                    </td>
                </tr>
            </table>

        </div>

        <script type="text/javascript">
            function checkedNum(){
                var objs = document.getElementsByName("posIds");
                var posNum = 0;
                for(var i=0; i<objs.length; i++){
                    if(objs[i].checked){
                        posNum++;
                    }
                }
                if(posNum==0){
                    alert("请至少选择一个部位！");
                    return false;
                }else{
                    document.getElementById("symSearch").submit();
                    return true;
                }
            }
        </script>

        <div id="footer">Copyright©2011 All rights reserved, maintained by Beijing Plant Protection Station.</div>
    </body>
</html>