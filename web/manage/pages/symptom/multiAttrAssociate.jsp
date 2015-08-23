<%-- 
    Document   : diseaseAdd
    Created on : 2012-5-19, 15:19:52
    Author     : Administrator
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.bpps.pojo.Symptom"%>
<%@page import="com.bpps.dao.SymptomDAO"%>
<%@page import="com.bpps.pojo.Position" %>
<%@page import="java.util.List" %>
<%@page import="com.bpps.dao.PositionDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String strLabelId = request.getParameter("labelId");
    int labelId = 0;
    if (strLabelId != null && !strLabelId.isEmpty()) {
        labelId = Integer.parseInt(strLabelId);
    } else {
        labelId = (Integer) request.getAttribute("labelId");
    }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>多属性关联信息添加页面</title>
        <!--link href="${pageContext.request.contextPath}/ui/layout.css" rel="stylesheet" type="text/css"/-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/default.css" />
        <link href="${pageContext.request.contextPath}/ui/skin_1/css/common.css" rel="stylesheet" type="text/css">
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/ui/skin_1/js/eceye_01.js"></script>
        <!--script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/kindeditor.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/lang/zh_CN.js"></script>
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/plugins/code/prettify.js"></script-->
        <script type="text/javascript"  charset="utf-8" src="${pageContext.request.contextPath}/js/jquery.js"></script>

    </head>
    <body>
        <table cellpadding="0" cellspacing="0" id="main-mypos">
            <tr>
                <td width="3" height="21" align="left"><img src="${pageContext.request.contextPath}/ui/skin_1/images/nav-left.gif" width="4" height="27"></td>
                <th align="left">您的位置：症状病害关联 > 多属性关联信息添加</th>
                <td width="3" align="right"><img src="${pageContext.request.contextPath}/ui/skin_1/images/rht-left.gif" ></td>
            </tr>
        </table>
        <div id="page">
            <div id="formContent">

            </div>
            <div>
                <%=""%>
            </div>
        </div>

        <table border="0" cellspacing="0" cellpadding="0" class="pannel-1" >
            <!-- Pannel title -->
            <thead>
                <tr>
                    <td class="pannel-head-left">&nbsp;</td>
                    <th class="pannel-head-mid">增加多属性关联信息</th>
                    <td class="pannel-head-right"></td>
                </tr>
            </thead>
            <!-- /Pannel title -->
            <!-- Pannel contents -->
            <tbody>

                <tr>
                    <td  colspan="3" valign="top" ><!-- form(input) 默认不显示，去掉display 样式后显示-->
                        <fieldset>
                            <legend>增加多属性关联信息</legend>
                            <form name="addAssoForm" id="addAssoForm" method="post" action="${pageContext.request.contextPath}/multiAttrAssociate">
                                <table  class="theform" >
                                <!--%@include file="/WEB-INF/jspf/label<%=labelId%>_pos_dis_sym.jspf"%-->
                                    <jsp:include page='<%="/WEB-INF/jspf/label" + labelId + "_pos_dis_sym.jspf"%>'/>
                                    <tr><th>病害症状关联属性：</th>
                                        <th id="symDisAttrContainer" style="text-align: left; vertical-align: bottom"> <input type="text" name="disSymAttr" value="" /></th></tr>
                                    <tr><td colspan="2"><input type="button" class="bt" name="button" id="addAssoButton" value="提交内容" onclick="updateDisSymAttr();"/> </td></tr>
                                </table>
                            </form>
                        </fieldset>

                    </td>
                </tr>

            </tbody>
            <!-- /Pannel contents -->
        </table>

        <script type="text/javascript">
            
    /**
     * check some input box is null posId
     */
    function updateDisSymAttr() {
        var posId = $("#posId").val();
        var symId = $("#symId").val();
        var disId = $("#disId").val();
        var symtype = $("#symtype").val();
        var disSymAttr = [];
        $("input[name='disSymAttr']:checked").each(function(i,o){
            disSymAttr[i] = $(o).val();
        });
        if(posId=="0" || symId=="0" || disId=="0"){
            alert("部位，症状，病害三项不能为空");
            return;
        }
        //var reqURL = "/bpps/multiAttrAssociate?posId="+posId+"&disId="+disId+"&symId="+symId;
        var reqURL = "/bpps/symptomAction.do?method=multiAttrAssociate&posId="+posId+"&disId="+disId+"&symId="+symId+"&symtype="+symtype+"&disSymAttr="+disSymAttr;
        //alert(reqURL);
        var repobj=$.ajax({url:reqURL,async:false});
        alert(repobj.responseText);
        //$("#addAssoForm").submit();
    }

        /**
         * set disease and symptom
         */
        function setDisSym(pos) {
            var posId = pos.value;
            var posDis = document.getElementById("pos"+posId+"_dis").value;
            var posSym = document.getElementById("pos"+posId+"_sym").value;
            var posDisDom = eval("(" + posDis + ")");
            var posSymDom = eval("(" + posSym + ")");
            var disKeys = posDisDom.key;
            var disValues = posDisDom.value;
            var symKeys = posSymDom.key;
            var symValues = posSymDom.value;
            //alert(keys);alert(values);
            var disObj = document.getElementById("disId");
            for(var i=0;i<disObj.options.length;)
            {
                disObj.removeChild(disObj.options[i]); 
            }
            var option = new Option("空","0");
            disObj.add(option);
            for(var i=0; i<disKeys.length; i++){
                option = new Option(disValues[i],disKeys[i]);
                disObj.add(option);
            }
        
            var symObj = document.getElementById("symId");
            for(var i=0;i<symObj.options.length;)
            {
                symObj.removeChild(symObj.options[i]); 
            }
            var option = new Option("空","0");
            symObj.add(option);
            for(var i=0; i<symKeys.length; i++){
                option = new Option(symValues[i],symKeys[i]);
                symObj.add(option);
            }
    }
    
    
    /**
     * set disease and symptom association attribution 
     */
    function setDisSymAttr() {
        var posId = $("#posId").val();
        var symId = $("#symId").val();
        var disId = $("#disId").val();
        if(posId!="0"&&symId!="0"&&disId!="0"){
            var reqURL = "/bpps/disSymServlet?posId="+posId+"&disId="+disId+"&symId="+symId;
            //alert(reqURL);
            var repobj=$.ajax({url:reqURL,async:false});
            $("#symDisAttrContainer").html(repobj.responseText);
            //alert(repobj.responseText);
        }
        /*
        var symValues = "{key:[1,0],value:['关联','不关联']}";
        var symDisContent = "<input type=\"radio\" name=\"disSymAttr\" value=\"1\"/>&nbsp;关联\
                            <input type=\"radio\" name=\"disSymAttr\" value=\"0\"/>&nbsp;不关联";
        var symObj = document.getElementById("sym"+symId);
        if(symObj!=null){
            symValues = symObj.value;
        }
        var symObjValues = eval("(" + symValues + ")");
        var keys = symObjValues.key;
        var values = symObjValues.value;
        //alert(keys);alert(values);
        for(var i=0;i<disSymObj.options.length;)
        {
            disSymObj.removeChild(disSymObj.options[i]); 
        }
        var option = new Option("空","0");
        disSymObj.add(option);
        for(var i=0; i<keys.length; i++){
            //alert(keys[i]);
            option = new Option(values[i],keys[i]);
            disSymObj.add(option);
        }
        */
    }
    
//            $(document).ready(function(){
//                $("#addAssoButton").click(function(){
//                    htmlobj=$.ajax({url:"/bpps/disSymServlet",async:false});
//                    $("#symDisAttrContainer").html(htmlobj.responseText);
//                });
//        });
                
        </script>

    </body>
</html>