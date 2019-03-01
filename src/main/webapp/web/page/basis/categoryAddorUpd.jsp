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
    width: 610px;
  }
  .layui-input-inline.format-margin {
    margin: 0px;
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
            <label class="layui-form-label">一级分类</label>
            <div class="layui-input-inline">
              <select name="category1" lay-filter="category1" lay-search></select>
            </div>
            <label class="layui-form-label">二级分类</label>
            <div class="layui-input-inline format-margin">
              <select name="category2" lay-filter="category2" lay-search>
                <option value="">一级分类不用选</option>
              </select>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">描述</label>
		    <div class="layui-input-block">
		      <textarea name="descr" placeholder="分类描述" class="layui-textarea"></textarea>
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
        	getOpt("/dict/getListAll", {parentCode:"cate0000"}, "<option value='cate0000'>一级分类</option>"
        			, "category1", showData);
        }
        
        function showData() {
        	if (isAdd) {return}
        	var category2 = "${obj.category2}";
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"name": "${obj.name}",
        		"descr": "${obj.descr}"
        	});
        	$("input[name='code']").prop("readonly", true);
        	if (category2 === "cate0000") {
        		$("select[name='category1']>option[value='cate0000']").prop("selected", true);
        		form.render("select");
        		return;
        	}
        	var category1 = "${obj.category1}";
        	if (category1 === "cate0000") {
	        	$("select[name='category1']>option[value='"+category2+"']").prop("selected", true);
	        	getOpt("/dict/getListAll", {parentCode:category2}, "<option value='"+category2+"'>二级分类</option>",
	        			"category2", function() {});
        	} else {
		       	$("select[name='category1']>option[value='"+category1+"']").prop("selected", true);
		       	getOpt("/dict/getListAll", {parentCode:category1}, "<option value='"+category1+"'>二级分类</option>",
		       			"category2", function() {
		       		$("select[name='category2']>option[value='"+category2+"']").prop("selected", true);
		       	});
        	}
        }
        	
        formSubmit("/dict/category" + (isAdd ? "Add" : "Upd"), "submit(submit)", "text", function(data) {
        	if (data == "添加成功" || data == "修改成功") {
        		layer.msg(data, {icon: 6, time: 800}, parent.window.closeTab);
        	} else {
        		layer.msg(data, {icon: 0});
        	}
        });
        
        form.on("select(category1)", function(data) {
        	var html = "<option value=''>一级分类不用选</option>";
        	if (data.value === "cate0000") {
        		$("select[name='category2']").html(html);
        		form.render("select");
        		return;
        	}
        	html = "<option value='"+data.value+"'>二级分类</option>";
        	getOpt("/dict/getListAll", {parentCode:data.value}, html, "category2", function() {});
        });
        
        init();
    });
    </script>
</body>
</html>