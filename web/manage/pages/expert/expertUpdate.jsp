<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.pojo.LabelSystem"%>
<%@page import="com.bpps.dao.LabelDAO"%>
<%@page import="com.bpps.pojo.Expert"%>
<%@page import="com.bpps.dao.ExpertDAO"%>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
Expert expert = (Expert)request.getAttribute("detail");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>专家信息修改页面</title>
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
        <th align="left">您的位置：专家管理 > 修改专家信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">修改专家信息</th>
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
                            
        <legend>修改专家信息</legend>
            <form name="articleUpdate" method="post" action="${pageContext.request.contextPath}/expertAction.do?method=doUpdateAction" enctype="multipart/form-data">
                <table  class="theform" >
                    <tr><th>所属标签（专家类别）：</th>
                        <td><input type="hidden" name="eptId" value="<%=expert.getEptId()%>" />
                        <select id="labelId" name="labelId">

<%
        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> level1 = labelDAO.getAllLabels();

        out.print("<option value=\"0\">无</option>");
        if(level1!=null && !level1.isEmpty())
        for (LabelSystem label1 : level1) {
            out.print("<option value=\"");
            out.print(label1.getLabelId());
            out.print("\" ");
            if(label1.getLabelId() == expert.getLabelId())
                out.print("selected");
            out.print(">");
            out.print(label1.getName());
            out.print("</option>");
        }
%>
                        </select>
                            
                        </td>
                        <th>照片：</th>
                        <td><input type="file" name="eptPhoto" value="" /></td></tr>
                    <tr><th>姓名：</th>
                        <td><input type="text" name="eptName" value="<%=expert.getEptName()%>" /></td>
                        <th>性别：</th>
                        <td>
                            <select id="eptSex" name="eptSex">
                                <option value="0">男</option>
                                <option value="1" <%if(expert.getEptSex()==1)out.print("selected");%>>女</option>
                            </select></td></tr>
                    <tr><th>职称：</th>
                        <td><input type="text" name="eptZhichen" value="<%=expert.getEptZhichen()%>" /></td>
                        <th>专业特长：</th>
                        <td><input type="text" name="eptFeature" value="<%=expert.getEptFeature()%>" /></td></tr>
                    <tr><th>所在单位：</th>
                        <td><input type="text" name="eptOrganization" value="<%=expert.getEptOrganization()%>" /></td>
                        <th>联系地址：</th>
                        <td><input type="text" name="eptAddress" value="<%=expert.getEptAddress()%>" /></td></tr>
                    <tr><th>电话：</th>
                        <td><input type="text" name="eptPhone" value="<%=expert.getEptPhone()%>" /></td>
                        <th>邮编：</th>
                        <td><input type="text" name="eptPostcode" value="<%=expert.getEptPostcode()%>" /></td></tr>
                    <tr><th>邮箱：</th>
                        <td><input type="text" name="eptEmail" value="<%=expert.getEptEmail()%>" /></td>
                        <th>个人网站：</th>
                        <td><input type="text" name="eptWeb" value="<%=expert.getEptWeb()%>" /></td></tr>
                <tr><th>个人简介：</th>
                    <td colspan="3"><textarea name="eptIntroduce" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"><%=expert.getEptIntroduce()%></textarea></td></tr>
                
                <tr><td colspan="4">
                    <input type="submit" id="addExpertButton" class="bt" name="button" value="提交内容" onclick="return checkInputValue();"/> (提交快捷键: Ctrl + Enter)
                    </td></tr>
                </table>
            </form>
        
        </fieldset>
       </td>
    </tr>
  </tbody>
  <!-- /Pannel contents -->
</table>
    
<script type="text/javascript" >
    KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="eptIntroduce"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['articleUpdate'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['articleUpdate'].submit();
					});
				}
			});
			prettyPrint();
		});
    /**
     * check some input box is null
     */
                   function checkInputValue() {
                        var disName = document.getElementsByName("eptName")[0].value;
                        if(disName==null || disName==""){
                            alert("专家姓名不能为空");
                            return false;
                        }
                        //document.getElementsByName("diseaseAdd")[0].submit();
                        //document.getElementById("addDiseaseButton").click();
                        return true;
                    }
</script>
    </body>
</html>
<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>