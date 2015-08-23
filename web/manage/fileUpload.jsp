<%-- 
    Document   : fileUpload
    Created on : 2012-5-26, 20:43:27
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>file upload</title>
    </head>
    <body>
        <h1>file upload!</h1>
        <form action="${pageContext.request.contextPath}/fileUploadAction.do" method="POST" enctype="multipart/form-data">
            <input type="file" name="uploadfile" value="" />
            <input type="submit" value="上传" name="submitfile" />
        </form>
    </body>
</html>
<script type="text/javascript">

</script>