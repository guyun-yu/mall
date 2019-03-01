<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>购物车</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/cart.css"/>
</head>
<body>
<div class="layui-layout-admin">
    <%@ include file="/web/front/header.jsp" %>
    <!-- 主体内容 -->
    <div class="layui-main">
        <div class="logo">
            <a href="<%=path%>/front/index.jsp"><img src="/mall/image/logo.png"></a>
        </div>
        <!-- 搜索框 -->
        <div class="select">
            <input type="text" class="select-input" id="search-input">
            <button class="layui-btn layui-btn-normal" id="search-btn">搜索</button>
        </div>
        
        <h2>购物车</h2>
        <div class="layui-form">
	        <table class="layui-table" lay-skin="line">
	            <thead>
	                <tr>
	                    <th style="width: 5%"><input type="checkbox" lay-filter="checkAll" lay-skin="primary"></th>
	                    <th style="width: 45%">商品</th>
	                    <th style="width: 10%">单价</th>
	                    <th style="width: 12%">数量</th>
	                    <th style="width: 15%">小计</th>
	                    <th style="width: 10%">操作</th>
	                </tr>
	            </thead>
	            <tbody class="goods" id="tbody"></tbody>
	            <tfoot>
	                <tr>
	                    <td class="format-paddqing" colspan="3">
	                        <span class="ft">
	                           <input type="checkbox" lay-filter="checkAll" lay-skin="primary" title="全选">
	                        </span>
	                        <span class="ft">
		                        <a href="javascript:delAll('${user.code}');" 
		                        class="layui-btn layui-btn-xs layui-btn-danger">
			                    <i class="layui-icon layui-icon-delete"></i> 删除选中商品
			                    </a>
	                        </span>
	                    </td>
	                    <td class="format-padding" colspan="2" style="text-align: right;">
	                        <span class="ft">总价:</span>
	                        <span class="total-price ft">￥<span id="totalPrice">0.00</span></span>
	                    </td>
	                    <td class="format-padding">
	                        <div class="pay"><a href="javascript:confirmOrder('${user.code}');">结算</a></div>
	                    </td>
	                </tr>
	            </tfoot>
	        </table>
        </div>
    </div>
    
</div>
<%@ include file="/web/front/footer.jsp" %>

    <script id="tbodyAdd" type="text/html">
    <tr id="tr{{d.id}}">
        <td><input type="checkbox" lay-skin="primary" lay-filter="checkOne" value="{{d.id}}"></td>
        <td>
            <div class="good-descr">
                <img src="/mall/image/productImg/{{d.mainPicture}}">
                <div>
                    <a href="<%=appPath%>/product/getProduct?code={{d.productCode}}">{{d.productName}}<br>{{d.descr}}</a>
                </div>
            </div>
        </td>
        <td>￥<span id="unitPrice{{d.id}}">{{=d.unitPrice.toFixed(2)}}</span></td>
        <td>
            <div class="amount">
                <div><a href="javascript:amountSub({{d.id}});">-</a></div>
                <div style="width:40px;">
                    <input type="text" id="quantity{{d.id}}" name="{{d.id}}" value="{{d.quantity}}">
                </div>
                <div><a href="javascript:amountAdd({{d.id}});">+</a></div>
            </div>
        </td>
        <td>￥<span id="subtotal{{d.id}}">{{= (d.unitPrice * d.quantity).toFixed(2)}}</span></td>
        <td>
	        <a href="javascript:del({{d.id}});" class="layui-btn layui-btn-xs layui-btn-danger">
	            <i class="layui-icon layui-icon-delete"></i>删除
	        </a>
        </td>
    </tr>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "laytpl"], function() {
    	var $ = layui.jquery;
    	var form = layui.form;
    	var laytpl = layui.laytpl;
    	
    	function init() {
    		$("#search-btn").click(search);
    		
    		getData();
    	}
    	
    	function getData() {
	    	ajax("/cart/getListAll", "json", {code:"${user.code}"}, function(data) {
	    		var html = "";
	    		$.each(data, function(index, dom) {
	    			html += laytpl($("#tbodyAdd").html()).render(dom);
	    		});
	    		$("#tbody").html(html);
	    		
	    		var total = 0;
	    		$.each(data, function(index, dom) {
	    			if (dom.checked) {
	    				$("input[value='"+dom.id+"']").prop("checked", true);
	    				total += parseFloat($("#subtotal" + dom.id).text());
	    			}
	    		});
	    		$("#totalPrice").text(total.toFixed(2));
	    		setCheckAll();
	            
	            var oldQuantity = 1;
	            var oldSubtotal;
	            $("#tbody input[type='text']").focusin(function() {
	            	oldQuantity = $(this).val();
	            	oldSubtotal = $("#subtotal" + $(this).attr("name")).text();
	            });
	    		$("#tbody input[type='text']").focusout(function() {
	    			var input = $(this).val();
	    			if (!checkInt(input)) {
	    				$(this).val(oldQuantity);
	    				return;
	    			}
	    			var quantity = Number(input);
	                if (quantity > 100) {
	                    layer.msg("最大数量为100哦", {icon:0,time:1500});
	                    $(this).val(100);
	                } else if (quantity == 0) {
	                    $(this).val(1);
	                }
	                
	                setTotalPrice($(this).attr("name"), oldSubtotal);
	    		});
	    	});
    	}
    	
    	amountSub = function(id) {
    		var oldSubtotal = $("#subtotal" + id).text();
    		var input = $("#quantity" + id).val();
            if (!checkInt(input)) {
                $("#quantity" + id).val(1);
                return;
            }
            var quantity = Number(input);
            if (quantity <= 1) {
                $("#quantity" + id).val(1);
            } else {
                $("#quantity" + id).val(quantity - 1);
            }
            setTotalPrice(id, oldSubtotal);
    	}
    	
    	amountAdd = function(id) {
    		var oldSubtotal = $("#subtotal" + id).text();
    		var input = $("#quantity" + id).val();
            if (!checkInt(input)) {
                $("#quantity" + id).val(1);
                return;
            }
            var quantity = Number(input);
            if (quantity >= 100) {
                layer.msg("最大数量为100哦", {icon:0,time:1500});
                $("#quantity" + id).val(100);
            } else {
                $("#quantity" + id).val(quantity + 1);
            }
            setTotalPrice(id, oldSubtotal);
    	}
    	
    	function setTotalPrice(id, oldSubtotal) {
            setSubtotal(id);
            setQuantity(id);
            if ($("#tr"+id+" input[type='checkbox']").prop("checked")) {
            	var total = parseFloat($("#totalPrice").text()) + parseFloat($("#subtotal" + id).text())
            	       - parseFloat(oldSubtotal);
            	$("#totalPrice").text(total.toFixed(2));
            }
    	}
    	
    	function setSubtotal(id) {
    		var subtotal = parseFloat($("#quantity" + id).val()) * parseFloat($("#unitPrice" + id).text());
    		$("#subtotal" + id).text(subtotal.toFixed(2));
    	}
    	
    	function setQuantity(id) {
    		ajax("/cart/upd", "text", {id:id,quantity:$("#quantity" + id).val()}, function() {});
    	}
    	
    	form.on('checkbox(checkOne)', function(data) {
    		var total;
    		if (data.elem.checked) {
    			total = parseFloat($("#totalPrice").text()) + parseFloat($("#subtotal" + data.value).text());
    		} else {
    			total = parseFloat($("#totalPrice").text()) - parseFloat($("#subtotal" + data.value).text());
    		}
   			$("#totalPrice").text(total.toFixed(2));
   			ajax("/cart/upd", "text", {id:data.value, checked:data.elem.checked}, function() {});
   			
   			setCheckAll();
    	});
    	
    	form.on("checkbox(checkAll)", function(data) {
    		$("input[type='checkbox']").prop("checked", data.elem.checked);
    		form.render("checkbox");
    		if (data.elem.checked) {
    			var total = 0;
    			$.each($("span[id^='subtotal']"), function(index, dom) {
    				total += parseFloat($(dom).text());
    			});
    			$("#totalPrice").text(total.toFixed(2));
    		} else {
    			$("#totalPrice").text("0.00");
    		}
    		
    		$("#tbody input[type='checkbox']").each(function(i, dom) {
    			ajax("/cart/upd", "text", {id:$(dom).val(), checked:data.elem.checked}, function() {});
    		});
    	});
    	
    	confirmOrder = function(code) {
    		ajax("/cart/isStockEnough", "text", {code:code}, function(data) {
    			if (data == "通过") {
    				location.href = root.appPath + "/cart/confirmOrder?code=" + code;
    			} else {
    				layer.msg(data, {icon:0, time:1500});
    			}
    		});
    	}
    	
    	del = function(id) {
    		layer.confirm("确认删除？", function(index) {
	    		ajax("/cart/del", "text", {id:id}, function(data) {
	    			if (data == "删除成功") {
	    				layer.msg(data, {icon:6, time:1500});
	    				ajax("/cart/getCount", "text", {code:"${user.code}"}, function(data) {
	                        $("#cartCount").text(data);
	                    });
	    				getData();
	    			} else {
	    				layer.msg(data, {icon:0});
	    			}
	    		});
	    		layer.close(index);
    		});
    	}
    	
    	delAll = function(code) {
    		layer.confirm("确认删除？", function(index) {
	    		ajax("/cart/delAllCart", "text", {code:code}, function(data) {
	    			if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:1500});
                        ajax("/cart/getCount", "text", {code:"${user.code}"}, function(data) {
                            $("#cartCount").text(data);
                        });
                        getData();
                    } else {
                        layer.msg(data, {icon:0});
                    }
	    		});
	    		layer.close(index);
    		});
    	}
    	
    	init();
    });
    </script>
</body>
</html>