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
    position: fixed;
    padding-top: 5px;
    width: 100%;
  }
  .form-div {
    width: 610px;
    margin-left: 40px;
  }
  .layui-input-inline.format-margin {
    margin: 0px;
    }
  .layui-form-item.btn {
    text-align: center;
  }
  .product-data {
    position: absolute;
    left: 660px;
    top:5px;
    width: 400px;
    border: 1px solid #e2e2e2;
  }
</style>
</head>
<body>
    <div class="layui-main">
        <div class="form-div">
	        <form class="layui-form layui-form-pane" lay-filter="addorUpd" onsubmit="return false;">
	          <div class="layui-form-item">
			    <label class="layui-form-label">一级分类</label>
			    <div class="layui-input-inline">
			      <select name="dictCode1" lay-filter="dictCode1" lay-search></select>
			    </div>
			    <label class="layui-form-label">二级分类</label>
			    <div class="layui-input-inline format-margin">
			      <select name="dictCode2" lay-filter="dictCode2" lay-search>
                    <option value="">请选择</option>
                  </select>
			    </div>
			  </div>
	          <div class="layui-form-item">
			    <label class="layui-form-label">三级分类</label>
			    <div class="layui-input-inline">
			      <select name="dictCode" lay-filter="dictCode" lay-search>
                    <option value="">请选择</option>
                  </select>
			    </div>
			    <label class="layui-form-label">商品</label>
			    <div class="layui-input-inline format-margin">
			      <select name="productCode" lay-filter="productCode" lay-verify="required" lay-search>
                    <option value="">请选择</option>
                  </select>
			    </div>
			  </div>
	          <div class="layui-form-item">
			    <label class="layui-form-label">数量</label>
			    <div class="layui-input-inline">
			      <input type="text" class="layui-input" name="quantity" lay-verify="required"/>
			    </div>
			    <label class="layui-form-label">总价</label>
			    <div class="layui-input-inline format-margin">
			      <input type="text" class="layui-input" name="totalPrice" readonly placeholder="只读"/>
			    </div>
			  </div>
			  <input type="hidden" name="orderCode" value="${orderCode}"/>
	          <div class="layui-form-item btn">
	            <button class="layui-btn" lay-submit lay-filter="submit">确定</button>
	            <input type="reset" class="layui-btn" id="reset" value="重置"/>
	          </div>
	        </form>
        </div>
        
        <div class="product-data">
            <div class="layui-form">
              <div class="layui-form-item">
                <label class="layui-form-label">商品编号:</label>
                <label class="layui-form-label" name="productCode"></label>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">商品名称:</label>
                <label class="layui-form-label" name="productName"></label>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">单价:</label>
                <label class="layui-form-label" name="unitPrice"></label>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">库存:</label>
                <label class="layui-form-label" name="stock"></label>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">状态:</label>
                <label class="layui-form-label" name="status"></label>
              </div>
            </div>
        </div>
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
        
        function init() {
        	getOpt("/dict/getListAll", {parentCode:"0000"}, "<option value=''>请选择</option>", "dictCode1", function() {});
        	
        	$("input[name='quantity']").focusout(function() {
        		if ($("select[name='productCode']").val() == "") {
        			layer.msg("请选择商品", {icon:0, time: 1000});
        			return;
        		}
        		var input = $("input[name='quantity']").val();
        		if (checkInt(input)) {
        			var quantity = Number(input);
        			var unitPrice = Number($("label[name='unitPrice']").text());
        			$("input[name='totalPrice']").val(quantity * unitPrice);
        		} else {
        			$("input[name='quantity']").val("");
        			layer.msg("数量只能为整数", {icon:0, time:1000});
        		}
        	});
        	
        	$("input[type='reset']").click(resetLabel);
        }
        
        function resetLabel() {
       		$("label[name='productCode']").empty();
            $("label[name='productName']").empty();
            $("label[name='unitPrice']").empty();
            $("label[name='stock']").empty();
            $("label[name='status']").empty();
        }
        
        form.on("select(dictCode1)", function(data) {
            var html = "<option value=''>请选择</option>";
            $("select[name='productCode']").html(html);
            $("select[name='dictCode']").html(html);
            resetLabel();
            if (data.value === "") {
                $("select[name='dictCode2']").html(html);
                form.render("select");
                return;
            }
            getOpt("/dict/getListAll", {parentCode:data.value}, html, "dictCode2", function() {});
        });
        
        form.on("select(dictCode2)", function(data) {
            var html = "<option value=''>请选择</option>";
            if (data.value === "") {
                $("select[name='dictCode']").html(html);
                form.render("select");
                return;
            }
            getOpt("/dict/getListAll", {parentCode:data.value}, html, "dictCode", function() {});
        });
        
        form.on("select(dictCode)", function(data) {
            var html = "<option value=''>请选择</option>";
            resetLabel();
            if (data.value === "") {
                $("select[name='productCode']").html(html);
                form.render("select");
                return;
            }
            getOpt("/product/getListAll", {dictCode:data.value}, html, "productCode", function() {});
        });
        
        form.on("select(productCode)", function(data) {
        	if (data.value === "") {
        		resetLabel();
        	}
        	ajax("/product/getModel", "json", {id:data.value}, function(data) {
        		if (data == "对象为空") {
        			layer.msg(data, {icon: 0});
        		}
        		$("label[name='productCode']").text(data.code);
        		$("label[name='productName']").text(data.name);
        		$("label[name='unitPrice']").text(data.unitPrice);
        		$("label[name='stock']").text(data.stock);
        		$("label[name='status']").text(data.status);
        		$("input[name='unitPrice']").val(data.unitPrice);
        	});
        });
        
        formSubmit("/orderItem/add", "submit(submit)", "text", function(data) {
        	if (data == "添加成功") {
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