<%-- 
    Document   : leftmenu_rcsw
    Created on : 2012-5-27, 10:14:03
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.Position"%>
<%@page import="java.util.List"%>
<%@page import="com.bpps.dao.PositionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>无标题文档</title>
<style type="text/css">
<!--
body {
	background-color: #AECFF0;
	padding-left:2px;
	height: 100%;
}
-->
</style>

<!-- -->
<link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
<script language="javascript" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
<!-- -->
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:2px 0 0 0">
  <tr>
    <td width="187" height="296" valign="top">
     <!--菜单开始 -->
    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-01')">病害管理<br></th>
        </tr>
        <tr>
          <td id="item-01"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/diseaseAction.do?method=listAction&labelId=<%=labelId%>" target="mainFrame">查看病害信息</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/disease/diseaseAdd.jsp?labelId=<%=labelId%>" target="mainFrame">增加病害</a></th>
              </tr>

          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->

    <!--菜单开始 -->
    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-02')">部位管理<br></th>
        </tr>
        <tr>
          <td id="item-02"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">

              <tr>
                <th><a href="${pageContext.request.contextPath}/positionAction.do?method=listAction&labelId=<%=labelId%>" target="mainFrame">查看部位信息</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/position/positionAdd.jsp?labelId=<%=labelId%>" target="mainFrame">增加部位</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/position/posAssociateDisease.jsp?labelId=<%=labelId%>" target="mainFrame">部位病害关联</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/position/posDiseaseImageAdd.jsp?labelId=<%=labelId%>" target="mainFrame">添加部位病害图像</a></th>
              </tr>

          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->


	 <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-03')">部位症状管理<br></th>
        </tr>
        <tr>
          <td id="item-03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/symptomAction.do?method=listAction&posId=0&labelId=<%=labelId%>" target="mainFrame">查看症状</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/symptomAdd.jsp?labelId=<%=labelId%>" target="mainFrame">增加症状</a></th>
              </tr>
              
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/symptomImageList.jsp?labelId=<%=labelId%>" target="mainFrame">症状图片列表</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/symptomImageAdd.jsp?labelId=<%=labelId%>" target="mainFrame">增加症状图片</a></th>
              </tr>
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->


	 <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-04')">症状描述管理<br></th>
        </tr>
        <tr>
          <td id="item-04"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">
              <tr>
                <th><a href="${pageContext.request.contextPath}/symptomDiscribeAction.do?method=listAction&symId=0&labelId=<%=labelId%>" target="mainFrame">查看症状描述</a></th>
              </tr>
              <tr>
                <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/symptomDiscribeAdd.jsp?labelId=<%=labelId%>" target="mainFrame">增加症状描述</a></th>
              </tr>
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->

	   <!--菜单开始 -->
     <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="left-item-s1">
        <tr>
          <th onClick="e.hidNode('item-05')">症状病害关联<br></th>
        </tr>
        <tr>
          <td id="item-05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="pro-item-s1">

<%
        int labelIdInt = Integer.parseInt(labelId);
        PositionDAO positionDAO = new PositionDAO();
        List<Position> positions = positionDAO.getPositions(labelIdInt);
        for (Position position : positions) {
%>
              <tr>
                  <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/symAssociateDisease.jsp?posid=<%=position.getPosId()%>&labelId=<%=labelId%>" target="mainFrame"><%=position.getPosName()%></a></th>
              </tr>
<%
        }
%>
              <tr>
                  <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/multiAttrAssociate.jsp?labelId=<%=labelId%>" target="mainFrame">多属性信息关联</a></th>
              </tr>
              <!--tr>
                  <th><a href="${pageContext.request.contextPath}/manage/pages/symptom/assoInfoSearch.jsp?labelId=<%=labelId%>" target="mainFrame">关联信息查询</a></th>
              </tr-->
          </table></td>
        </tr>
      </table>
	  <!--菜单结束 -->
    </td>
  </tr>
</table> 
<script type="text/javascript" >
    e.hidNode('item-02');
    e.hidNode('item-03');
    e.hidNode('item-04');
    e.hidNode('item-05');
</script>
</body>
</html>
