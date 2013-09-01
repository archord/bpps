<%--
    Document   : SymptomAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page import="com.bpps.dao.SymptomDAO"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.PositionDAO" %>
<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.pojo.Symptom2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
Symptom2 symptom2 = (Symptom2)request.getAttribute("detail");
Symptom symptom = symptom2.getSymptom();
String labelId = request.getParameter("labelId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>病害症状修改页面</title>
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
        <th align="left">您的位置：症状管理 > 修改症状信息</th>
        <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
      </tr>
    </table>

 <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
  <!-- Pannel title -->
  <thead>
    <tr>
      <td class="pannel-head-left">&nbsp;</td>
      <th class="pannel-head-mid">修改症状信息</th>
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
        <legend>修改症状信息</legend>
            <form name="symptomAdd" method="post" action="${pageContext.request.contextPath}/symptomAction.do?method=doUpdateAction">
                <table  class="theform" >
                    <tr><th>症状所属位置：</th>
                        <td>
                        <select id="posId" name="posId">

<%
        int labelIdInt = Integer.parseInt(labelId);
        PositionDAO PositionDAO = new PositionDAO();
        List<Position> Positions = PositionDAO.getPositions(labelIdInt);

        if(Positions==null || Positions.isEmpty()){
            out.print("<option value=\"0\">无</option>");
        }else
        for (Position position : Positions) {
            out.print("<option value=\"");
            out.print(position.getPosId());
            if(position.getPosId()==symptom.getPosId()){
                out.print("\" selected>");
            }else{
                out.print("\">");
            }
            out.print(position.getPosName());
            out.print("</option>");
        }
%>
                        </select><input type="hidden" name="symId" value="<%=symptom.getSymId()%>"/>
                        <input type="hidden" name="labelId" value="<%=symptom.getLabelId()%>"/></td></tr>
                <tr><th>病症状名称：</th>
                    <td><input type="text" name="symName" value="<%=symptom.getSymName()%>" /></td></tr>
                <tr><th>父症状：</th>
                    <td>
                    <select id="parentSymId" name="parentSymId">
                        <option value="<%=symptom.getParentSymId()%>"><%=symptom2.getParentSymName()%></option>
                    </select>
<%
        SymptomDAO symptomDAO = new SymptomDAO();
        for (Position position : Positions) {
            String symKey = "key:[";
            String symValue = "value:[";
            List<Symptom> symptoms = symptomDAO.getParSymptomsByPosId(position.getPosId());
            for (Symptom sym : symptoms) {
                symKey = symKey + sym.getSymId() + ",";
                symValue = symValue + "'"+ sym.getSymName() + "',";
            }
            if(!symKey.equals("key:["))
                symKey = symKey.substring(0, symKey.length()-1);
            if(!symValue.equals("value:["))
                symValue = symValue.substring(0, symValue.length()-1);
            String rst = "{" + symKey + "]," + symValue + "]}";
            out.print("<input type=\"hidden\" id=\"pos_"+ position.getPosId() +"\" value=\""+ rst +"\"/>");
        }
%>
<script type="text/javascript">

    /**
     * get pos sym
     */
    function getPosSym(obj) {
        var posId = obj.value;
        var posValues = document.getElementById("pos_"+posId).value;
        var parSym = eval("(" + posValues + ")");
        var keys = parSym.key;
        var values = parSym.value;
        //alert(keys);
        var parentSymIdObj = document.getElementById("parentSymId");
        var parentSymId = parentSymIdObj.value;
        for(var i=0;i<parentSymIdObj.options.length;)
        {
            parentSymIdObj.removeChild(parentSymIdObj.options[i]);
        }
        var option = new Option("空","0");
        parentSymIdObj.add(option);
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            if(keys[i] == parentSymId)
                option.selected=true;
            parentSymIdObj.add(option);
        }
    }
    var posIdObj = document.getElementById("posId");
    getPosSym(posIdObj);
</script>

                    </td></tr>
                <tr><th>症状名称属性：</th>
                    <td>
                        <select name="symProperty">
                            <option value="1" <%if(symptom.getSymProperty()==1) out.print("selected");%>>是否</option>
                            <option value="2" <%if(symptom.getSymProperty()==2) out.print("selected");%>>文字描述</option>
                        </select>
                    </td></tr>
                <tr><td colspan="2"><input type="submit" class="bt" name="button" value="提交内容" /></td></tr>
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
			var editor1 = K.create('textarea[name="disContent"]', {
				uploadJson : '${pageContext.request.contextPath}/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['SymptomAdd'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['SymptomAdd'].submit();
					});
				}
			});
			prettyPrint();
		});
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