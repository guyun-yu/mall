<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>信息维护</title>
<style type="text/css">
  .layui-main {
    padding-top: 5px;
    width: 500px;
  }
  .layui-form-item.btn {
    text-align: center;
  }
</style>
</head>
<body>
    <div class="layui-main">
        <form class="layui-form layui-form-pane" lay-filter="addorUpd" onsubmit="return false;">
          <div class="layui-form-item">
		    <label class="layui-form-label">编号</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="code" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">名称</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="name" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">url</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="url" placeholder="顶级菜单不用填"/>
		    </div>
		  </div>
          <div class="layui-form-item">
            <label class="layui-form-label">上级菜单</label>
            <div class="layui-input-block">
              <select name="parentCode" lay-filter="parentCode" lay-search></select>
            </div>
          </div>
          <div class="layui-form-item btn">
            <button class="layui-btn" lay-submit lay-filter="submit">确定</button>
            <input type="reset" class="layui-btn" id="reset" value="重置"/>
          </div>
        </form>
    </div>
    
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
    
    <script type="text/javascript">
    layui.use(["form", "jquery", "layer", "laytpl"], function() {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form; 
        var laytpl = layui.laytpl;
        var isAdd = ${empty obj};
        
        function init() {
        	if (!isAdd) {
        		$("#reset").prop("type", "button");
	            $("#reset").click(showData);
        	}
        	getOpt("/menu/getListAll", {parentCode:"menu0000"}, "<option value='menu0000'>顶级菜单</option>"
        			, "parentCode", showData);
        }
        
        function showData() {
        	if (isAdd) {return}
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"name": "${obj.name}",
        		"url": "${obj.url}",
        		"parentCode": "${obj.parentCode}"
        	});
        	$("input[name='code']").prop("readonly", true);
        	form.render("select");
        }
        	
        formSubmit("/menu/" + (isAdd ? "add" : "upd"), "submit(submit)", "text", function(data) {
        	if (data == "添加成功" || data == "修改成功") {
        		layer.msg(data, {icon: 6, time: 800}, parent.window.closeTab);
        	} else {
        		layer.msg(data, {icon: 0});
        	}
        });
        
        init();
    });
    </script>
</body>
</html>