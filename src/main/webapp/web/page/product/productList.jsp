<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>用户信息</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/userList.css"/>
</head>
<body>
	<div class="layui-collapse">
	    <div class="layui-colla-item">
		    <h2 class="layui-colla-title">条件查询</h2>
		    <div class="layui-colla-content">
			    <form class="layui-form select"  onsubmit="return false;">
			        <div class="layui-input-inline">
			            <input type="text" name="code" class="layui-input" placeholder="商品编号">
			        </div>
			        <div class="layui-input-inline">
			            <input type="text" name="name" class="layui-input" placeholder="商品名称">
			        </div>
			        <div class="layui-inline">
			            <select name="dictCode" lay-search></select>
			        </div>
			        <input type="hidden" name="pageIndex" value="1">
			        <input type="hidden" name="pageLimit" value="5">
			        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="select" id="select">
			            <i class="layui-icon layui-icon-search"></i>
			        </button>
			    </form>
		    </div>
	    </div>
	</div>
	    
    <div class="layui-form">
        <a href="javascript:delAll();" class="layui-btn layui-btn-sm layui-btn-danger">删除选中项</a>
        <a href="javascript:parent.window.changeTab('productAdd', true, '商品 - 添加');"
            data-url="/product/addTab" data-id="productAdd"
            class="layui-btn layui-btn-sm layui-btn-normal">添加</a>
        <div class="table-scroll">
	        <table class="layui-table" style="width: 140%;">
	            <colgroup>
	                <col width="3%">
                    <col width="4%">
                    <col width="10%">
                    <col width="10%">
                    <col width="5%">
                    <col width="15%">
                    <col width="5%">
                    <col width="5%">
                    <col width="5%">
                    <col width="5%">
                    <col width="10%">
                    <col width="10%">
	            </colgroup>
	            <thead>
	                <tr>
	                    <th><input type="checkbox" lay-filter="checkAll" lay-skin="primary"></th>
	                    <th>序号</th>
	                    <th>编号</th>
	                    <th>名称</th>
	                    <th>单价</th>
	                    <th>描述</th>
	                    <th>库存</th>
	                    <th>点击量</th>
	                    <th>销量</th>
	                    <th>状态</th>
	                    <th>分类编号</th>
	                    <th>操作</th>
	                </tr>
	            </thead>
	            <tbody id="tbody"></tbody>
	        </table>
        </div>
		<div id="page"></div>
    </div>
    
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
    
    <script id="tbodyAdd" type="text/html">
     <tr>
         <td><input type="checkbox" lay-filter="checkOne" value="{{d.code}}" lay-skin="primary"></td>
         <td>{{d.num}}</td>
         <td>{{d.code}}</td>
         <td>{{d.name}}</td>
         <td>{{= d.unitPrice.toFixed(2)}}</td>
         <td>{{d.descr}}</td>
         <td>{{d.stock}}</td>
         <td>{{d.clickQuantity}}</td>
         <td>{{d.sales}}</td>
         <td>{{d.status}}</td>
         <td>{{d.dictCode}}</td>
         <td>
             <a href="javascript:del('{{d.code}}');" class="layui-btn layui-btn-xs layui-btn-danger">
                 <i class="layui-icon layui-icon-delete"></i>删除
             </a>
             <a href="javascript:parent.window.changeTab('productUpd{{d.code}}', true, '商品 - 修改');"
                 data-url="/product/updTab?id={{d.code}}" data-id="productUpd{{d.code}}"
                 class="layui-btn layui-btn-xs layui-btn-normal">
                 <i class="layui-icon layui-icon-edit"></i>编辑
             </a>
         </td>
     </tr>
    </script>

    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "laytpl", "layer"], function() {
        var $ = layui.jquery;
        var form = layui.form;
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        
        function init() {
	       	form.on("checkbox(checkAll)", checkAll);
	       	form.on("checkbox(checkOne)", setCheckAll);
	       	getList();
	       	getOpt("/dict/getListAll", {}, "<option value=''>分类：不限</option>", "dictCode", function() {});
        }
        
    	formSubmit("/product/getList", "submit(select)", "json", function(data) {
    		var limit = $("input[name='pageLimit']").val();
    		var curr = $("input[name='pageIndex']").val();
			pageInit("page", data.rowCount, limit, curr, null, function(obj, first) {
				$("input[name='pageLimit']").val(obj.limit);
				$("input[name='pageIndex']").val(obj.curr);
		        if (!first) {
		            getList();
		        }
			});
    		
	        var html = "";
    		var list = data.list;
	        $.each(list, function(index, dom) {
	        	dom.num = index + 1 + (curr-1)*limit;
	            html += laytpl($("#tbodyAdd").html()).render(dom);
	        });
            $("#tbody").html(html);
	        form.render("checkbox");
	        
    		var leng = list.length;
	        if (curr != 1 && leng < 1) {
	        	$("input[name='pageIndex']").val(1);
	        	getList();
	        } else if (curr == 1 && leng < 1) {
	            layer.msg("没有查到数据", {icon: 5});
	        }
    	});
        
        function checkAll(data) {
        	$("#tbody :checkbox").prop("checked", data.elem.checked);
            form.render("checkbox");
        }
        
        function getList() {
        	$("#select").click();
        	$("input[lay-filter='checkAll']").prop("checked", false);
        }
        
        del = function(code) {
            layer.confirm("确认删除？", function(index) {
                ajax("/product/del", "text", {id:code}, function(data) {
                    if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:800});
                    } else {
                        layer.msg(data, {icon:0, time:1000});
                    }
                    getList();
                });
                layer.close(index);
            });
        }
        
        delAll = function() {
            layer.confirm("确认删除？", function(index) {
                var code = new Array();
                $("#tbody :checked").each(function(i, dom) {
                    code[i] = $(dom).val();
                });
                ajax("/product/delAll", "text", {id:code}, function(data) {
                    if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:800});
                    } else {
                        layer.msg(data, {icon:0, time:1000});
                    }
                    getList();
                });
                layer.close(index);
            });
        }        
        
        init();
    });
    </script>
</body>
</html>