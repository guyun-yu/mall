<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>订单信息</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/userList.css"/>
</head>
<body>
	<div class="layui-collapse">
	    <div class="layui-colla-item">
		    <h2 class="layui-colla-title">条件查询</h2>
		    <div class="layui-colla-content">
			    <form class="layui-form select"  onsubmit="return false;">
			        <div class="layui-input-inline">
			            <input type="text" name="code" class="layui-input" placeholder="订单编号">
			        </div>
			        <div class="layui-input-inline">
			            <input type="text" name="userCode" class="layui-input" placeholder="用户账号">
			        </div>
			        <div class="layui-inline">
			            <select name="status">
			                <option value="">状态：不限</option>
			                <option value="1">已下单</option>
			                <option value="2">已付款</option>
			                <option value="3">已发货</option>
			                <option value="4">已退款</option>
			                <option value="5">已收货</option>
			                <option value="6">已评论</option>
			            </select>
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
        <table class="layui-table">
            <colgroup>
                <col width="5%">
                <col width="5%">
                <col width="15%">
                <col width="10%">
                <col width="10%">
                <col width="14%">
                <col width="5%">
                <col width="6%">
                <col width="20%">
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" lay-filter="checkAll" lay-skin="primary"></th>
                    <th>序号</th>
                    <th>订单编号</th>
                    <th>用户账号</th>
                    <th>付款金额</th>
                    <th>创建时间</th>
                    <th>收货地址</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="tbody"></tbody>
        </table>
		<div id="page"></div>
    </div>
    
    <script id="tbodyAdd" type="text/html">
     <tr>
         <td><input type="checkbox" value="{{d.code}}" lay-filter="checkOne" lay-skin="primary"></td>
         <td>{{d.num}}</td>
         <td>{{d.code}}</td>
         <td>{{d.userCode}}</td>
         <td>{{=d.payment.toFixed(2)}}</td>
         <td>{{d.createTime}}</td>
         <td>{{d.shippingId}}</td>
         <td>{{d.status}}</td>
         <td>
             <a href="javascript:del('{{d.code}}');" class="layui-btn layui-btn-xs layui-btn-danger">
                 <i class="layui-icon layui-icon-delete"></i>删除
             </a>
             <a href="javascript:parent.window.changeTab('orderUpd{{d.code}}', true, '订单 - 修改');"
                 data-url="/order/updTab?id={{d.code}}" data-id="orderUpd{{d.code}}"
                 class="layui-btn layui-btn-xs layui-btn-normal">
                 <i class="layui-icon layui-icon-edit"></i>编辑
             </a>
             <a href="javascript:parent.window.changeTab('orderItemList{{d.code}}', true, '订单项列表');"
                 data-url="/order/orderItemTab?code={{d.code}}" data-id="orderItemList{{d.code}}"
                 class="layui-btn layui-btn-xs layui-btn-normal">
                 <i class="layui-icon layui-icon-form"></i>查看商品
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
        
    	formSubmit("/order/getList", "submit(select)", "json", function(data) {
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
	        	switch (dom.status) {
				case 1:
					dom.status = "已下单";
					break;
				case 2:
					dom.status = "已付款";
					break;
				case 3:
					dom.status = "已发货";
					break;
				case 4:
					dom.status = "已退款";
					break;
				case 5:
					dom.status = "已收货";
					break;
				case 6:
					dom.status = "已评论";
					break;
				default:
					break;
				}
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
                ajax("/order/del", "text", {id:code}, function(data) {
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
                ajax("/order/delAll", "text", {id:code}, function(data) {
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