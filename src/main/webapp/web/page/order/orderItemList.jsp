<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>订单项信息</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/userList.css"/>
</head>
<body>
	<div class="layui-collapse">
	    <div class="layui-colla-item">
		    <h2 class="layui-colla-title">条件查询</h2>
		    <div class="layui-colla-content">
			    <form class="layui-form select"  onsubmit="return false;">
			        <div class="layui-input-inline">
			            <input type="text" name="productCode" class="layui-input" placeholder="商品编号">
			        </div>
			        <input type="hidden" name="orderCode" value="${code}">
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
        <a href="javascript:parent.window.changeTab('orderItemAdd', true, '订单 - 添加商品');"
            data-url="/orderItem/addProduct?orderCode=${code}" data-id="orderItemAdd"
            class="layui-btn layui-btn-sm layui-btn-normal">添加商品</a>
        <table class="layui-table">
            <colgroup>
                <col width="5%">
                <col width="5%">
                <col width="15%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
                <col width="20%">
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" lay-filter="checkAll" lay-skin="primary"></th>
                    <th>序号</th>
                    <th>订单号</th>
                    <th>商品</th>
                    <th>数量</th>
                    <th>单价</th>
                    <th>总价</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="tbody"></tbody>
        </table>
		<div id="page"></div>
    </div>
    
    <script id="tbodyAdd" type="text/html">
     <tr>
         <td><input type="checkbox" value="{{d.id}}" lay-filter="checkOne" lay-skin="primary"></td>
         <td>{{d.num}}</td>
         <td>{{d.orderCode}}</td>
         <td>{{d.productCode}}</td>
         <td>{{d.quantity}}</td>
         <td>{{=d.unitPrice.toFixed(2)}}</td>
         <td>{{=d.totalPrice.toFixed(2)}}</td>
         <td>
             <a href="javascript:del('{{d.id}}');" class="layui-btn layui-btn-xs layui-btn-danger">
                 <i class="layui-icon layui-icon-delete"></i>删除
             </a>
             <a href="javascript:;" class="layui-btn layui-btn-xs layui-btn-normal">
                 <i class="layui-icon layui-icon-edit"></i>修改数量
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
        }
        
    	formSubmit("/orderItem/getList", "submit(select)", "json", function(data) {
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
        
        del = function(id) {
            layer.confirm("确认删除？", function(index) {
                ajax("/orderItem/del", "text", {id:id}, function(data) {
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
                var id = new Array();
                $("#tbody :checked").each(function(i, dom) {
                    id[i] = $(dom).val();
                });
                ajax("/orderItem/delAll", "text", {id:id}, function(data) {
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