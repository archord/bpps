<%-- 
    Document   : systemInfo
    Created on : 2012-5-27, 10:16:24
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="java.util.List"%>
<%@page import="com.bpps.dao.LabelDAO"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page import="com.bpps.dao.DiseaseDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>无标题文档</title>

        <!-- -->
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <!-- -->
        <style type="text/css">
            <!--
            span {
                text-decoration: underline;
                color: #990000;
            }
            -->
        </style>
    </head>
    <body>
        <table cellpadding="0" cellspacing="0" id="main-mypos">
            <tr>
                <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                <th align="left">您的位置：首页</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <!-- * Pannel -->
        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">信息总览</th>
                    <td class="pannel-head-right"></td>
                </tr>
            </thead>
            <!-- /Pannel title -->
            <!-- Pannel contents -->
            <tbody>
                <!-- 收款提示 -->

                <tr>
                    <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->

                        <%


                        %>

                        <%
                            DiseaseDAO diseaseDAO = new DiseaseDAO();
                            PositionDAO positionDAO = new PositionDAO();
                            SymptomDAO symptomDAO = new SymptomDAO();
                            LabelDAO labelDAO = new LabelDAO();
                            List<LabelSystem> level1 = labelDAO.getActiveCrops();
                            for (LabelSystem label1 : level1) {
                                int labelId = label1.getLabelId().intValue();
                                int disTotal = diseaseDAO.getTotalByLabelId(labelId);
                                int posTotal = positionDAO.getTotalByLabelId(labelId);
                                int symTotal = symptomDAO.getTotalByLabelId(labelId);
                        %>
                        <fieldset>
                            <legend><%=label1.getName()%></legend><table id="search" class="theform" >
                                <tr>
                                    <!--th>病害总数：</th><td>总数目：<span>38</span></td-->
                                    <td>病害总数：<span><%=disTotal%></span></td>
                                    <td>部位总数：<span><%=posTotal%></span></td>
                                    <td>症状总数：<span><%=symTotal%></span></td>
                                </tr>
                            </table>
                        </fieldset>
                        <%
                            }
                        %>            


                    </td>
                </tr>


            </tbody>
            <!-- /Pannel contents -->
        </table>
        <!-- / * Pannel -->
    </body>
</html>
