<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN">
    <head>
        <title>黄瓜主要病害标准化远程智能诊断系统——防治决策</title>
        <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/ui/skin_1/icon/icon.ico"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="Content-Style-Type" content="text/css" />  <!-- w3c recomends this meta tag  -->
        <meta http-equiv="Content-Script-Type" content="text/javascript" />  <!-- w3c recomends this meta tag  -->
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="copyright" content="" />
        <meta name="author" content="" />
        <meta name="rating" content="general" />
        <meta name="robots" content="all" />
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/dropdown/dropdown.css" type="text/css" media="screen, projection" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ui/layout.css" type="text/css"/>	
        <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/nav2.1.js"></script>
        <script language="javascript" type="text/javascript">
            $(document).ready(function(){
                $("#JqueryMenu").navPlugin({
                    'itemWidth': 120,
                    'itemHeight': 30
                });
            });
        </script>
    </head>
    <body>
        <div id="page">
            <%@include file="/WEB-INF/jspf/head.jspf"%>
            <table id="mainTable" >
                <tr>
                    <td><%@include file="/WEB-INF/jspf/left.jspf"%></td>
                    <td><%@include file="/WEB-INF/jspf/preventionList.jspf"%></td>
                </tr>
            </table>
        </div>
        <%@include file="/WEB-INF/jspf/foot.jspf"%>
    </body>
</html>