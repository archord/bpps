<%-- 
    Document   : split
    Created on : 2012-5-27, 10:15:29
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

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
body {
	height: 1000px;
        background-image: url(${pageContext.request.contextPath}/ui/skin_1/images/splitbg.jpg);
}
-->
</style>
</head>

<body>
<table width="6" height="600px" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5"  align="center">
        <img src="${pageContext.request.contextPath}/ui/skin_1/images/splitedot.jpg" width="5" height="51"
             onClick="var leftObj=window.parent.frow2;if(leftObj.cols=='191,5,*'){leftObj.cols='0,5,*';}else{leftObj.cols='191,5,*';}"
             onMouseOver="this.src='${pageContext.request.contextPath}/ui/skin_1/images/splitedot2.jpg'"
             onMouseOut="this.src='${pageContext.request.contextPath}/ui/skin_1/images/splitedot.jpg'" style="cursor:pointer"></td>
  </tr>
</table>
</body>
</html>
