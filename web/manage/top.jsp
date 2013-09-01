<%-- 
    Document   : top
    Created on : 2012-5-27, 10:13:04
    Author     : Administrator
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>无标题文档</title>

        <!-- -->
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <!-- -->

        <script language="javascript">
            function set_local(url,frame){
                if(!url || !frame){return alert('值不全！');}
                parent.frames[frame].location=url;
            }
        </script>
    <body>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-image:url(${pageContext.request.contextPath}/ui/skin_1/images/top-bg.jpg); background-repeat:repeat-x">
            <tr>
                <td width="330" height="72" rowspan="2" valign="top"><img src="${pageContext.request.contextPath}/ui/skin_1/images/logo1.jpg"></td>
                <td height="26" valign="bottom" style="padding-right:5px">
                    <table width="205" border="0" align="right" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="15"><img src="${pageContext.request.contextPath}/ui/skin_1/images/gohome.jpg"></td>
                            <td width="60"><a href="/bpps" target="_blank" style='color:#00CCFF'>系统首页</a></td>
                            <td width="15"><img src="${pageContext.request.contextPath}/ui/skin_1/images/lout.gif"></td>
                            <td><a href="javascript:void(window.parent.close())" style='color:#00CCFF'>退&nbsp;出</a></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <!-- 一级菜单配置 -->
                    <div id="topnav" class="top-s1">
                        <div onClick="set_local('systemManage.jsp','leftFrame');set_local('systemInfoAll.jsp','mainFrame');">
                            <div id="default">系统管理<br></div>
                        </div>
                        <%
                            LabelDAO labelDAO = new LabelDAO();
                            List<LabelSystem> level1 = labelDAO.getActiveCrops();
                            for (LabelSystem label1 : level1) {
                        %>
                        <div onClick="set_local('leftmenu.jsp?labelId=<%=label1.getLabelId()%>','leftFrame');set_local('systemInfo.jsp?labelId=<%=label1.getLabelId()%>','mainFrame');">
                            <div ><%=label1.getName()%><br></div>
                        </div>
                        <%
                            }
                        %>            

                    </div>

                </td>
            </tr>
        </table>
    </body>
    <script language="javascript">
        /**
         * @ Author:Lanlin
         */

        var items=e.$('topnav');
        for(var i=0;i<items.childNodes.length;i++){
            var son2=items.childNodes[i];
            for(var k=0;k<son2.childNodes.length;k++){
                if(son2.childNodes[k].id=='default'){
                    son2.childNodes[k].className='top-item-1';
                }else{
                    son2.childNodes[k].className='top-item-2';
                }
                son2.childNodes[k].onclick=(function (){
                    clearAll();
                    this.className='top-item-1';
                })
            }
        }

        function clearAll(){
            var items=e.$('topnav');
            for(var i=0;i<items.childNodes.length;i++){
                var son2=items.childNodes[i];
                for(var k=0;k<son2.childNodes.length;k++){
                    son2.childNodes[k].className='top-item-2';
                }
            }
        }


    </script>
</html>
