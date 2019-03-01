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
        <form class="layui-form layui-form-pane" lay-filter="addorUpd" id="addorUpd" onsubmit="return false;">
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
          <div class="layui-form-item" pane>
		    <label class="layui-form-label">权限</label>
		    <div class="layui-input-block" id="role"></div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">权限描述</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="descr" placeholder="权限描述"/>
		    </div>
		  </div>
          <div class="layui-form-item btn">
            <button class="layui-btn" id="submit">确定</button>
            <input type="reset" class="layui-btn" id="reset" value="重置"/>
          </div>
        </form>
    </div>
    
    <script id="checkboxAdd" type="text/html">
       <input type="checkbox" class="layui-input" name="role" value="{{d.code}}" title="{{d.name}}"/>
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
        	getCheckbox();
        	$("#submit").click(submit);
        }
        
        function getCheckbox() {
        	ajax("/menu/getChildMenu", "json", {}, function(data) {
        		var html = "";
        		$.each(data, function(i, dom) {
        			html += laytpl($("#checkboxAdd").html()).render(dom)
        		});
        		$("#role").html(html);
        		form.render("checkbox");
        		showData();
        	});
        }
        
        function showData() {
        	if (isAdd) {return}
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"name": "${obj.name}",
        		"descr": "${obj.descr}"
        	});
        	$("input[name='code']").prop("readonly", true);
        	ajax("/roleMenu/getListAll", "json", {code: "${obj.code}"}, function(data) {
        		$.each(data, function(i, dom) {
        			$(":checkbox[value='"+dom.menuCode+"']").prop("checked", true);
        		});
        		form.render("checkbox");
        	});
        }
        
        function submit() {
        	ajax("/role/" + (isAdd ? "addRole" : "updRole"), "text", $("#addorUpd").serialize(), function(data) {
        		if (data == "添加成功") {
        			layer.msg("成功", {icon: 6, time: 800}, parent.window.closeTab);
        		} else {
        		    layer.msg(data, {icon: 0});
                }
        	});
        }
        	
        init();
    });
    </script>
</body>
</html>