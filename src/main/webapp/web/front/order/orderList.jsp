<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>订单列表</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/orderList.css"/>
</head>
<body>
<div class="layui-layout-admin">
    <!-- 顶部导航 -->
    <%@ include file="/web/front/header.jsp" %>
    
    <!-- 主体内容 -->
    <div class="layui-main">
        <blockquote class="layui-elem-quote layui-quote-nm">我的订单</blockquote>
        
        <form class="layui-form" onsubmit="return false;">
            <input type="hidden" name="userCode" value="${user.code}">
            <input type="hidden" name="status" value="">
            <input type="hidden" name="pageIndex" value="1">
            <input type="hidden" name="pageLimit" value="5">
            <button lay-submit lay-filter="select" id="select"></button>
        </form>
        
        <div class="layui-tab layui-tab-brief mt">
            <ul class="layui-tab-title extra-1">
                <li class="layui-this"><a href="javascript:search('');">全部订单</a></li>
                <li><a href="javascript:search('1');">待付款</a></li>
                <li><a href="javascript:search('3');">待收货</a></li>
                <li><a href="javascript:search('5');">待评价</a></li>
            </ul>
                
            <div class="layui-tab-content">
                <table class="layui-table">
                    <thead>
                        <tr>
                            <th style="width: 48%;">订单详情</th>
                            <th style="width: 10%;">单价</th>
                            <th style="width: 8%;">数量</th>
                            <th style="width: 10%;">实付款</th>
                            <th style="width: 12%;">
                                <div class="layui-form">
                                    <select lay-filter="status">
                                        <option value="">全部状态</option>
                                        <option value="1">待付款</option>
                                        <option value="3">待收货</option>
                                        <option value="5">待评论</option>
                                        <option value="4">已退款</option>
                                    </select>
                                </div>
                            </th>
                            <th style="width: 12%;">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tbody"></tbody>
                </table>
                <div id="page"></div>
            </div>
        </div>
    </div>
    
</div>
<%@ include file="/web/front/footer.jsp" %>

	<script id="trThAdd" type="text/html">
    <tr class="tr-th">
        <td colspan="6">
          <span>{{d.createTime}}</span>
          <span>订单号： <a href="javascript:;">{{d.code}}</a></span>
        </td>
    </tr>
	</script>
	
	<script type="text/javascript">
	layui.use(["element","jquery", "laytpl", "form"], function() {
		var $ = layui.jquery;
		var laytpl = layui.laytpl;
		var form = layui.form;
		
		formSubmit("/order/getOrder", "submit(select)", "json", function(data) {
            var limit = $("input[name='pageLimit']").val();
            var curr = $("input[name='pageIndex']").val();
            pageInit("page", data.rowCount, limit, curr, null, function(obj, first) {
                $("input[name='pageLimit']").val(obj.limit);
                $("input[name='pageIndex']").val(obj.curr);
                if (!first) {
                    getList();
                }
            });
            
            var list = data.list;
            var html = "";
            $.each(list, function(index, order) {
                html += laytpl($("#trThAdd").html()).render(order);
                $.each(order.child, function(i, dom) {
//                 	console.log(dom);
                	html += '<tr class="tr-bd"><td class="product-descr">';
                	html += '<img src="/mall/image/productImg/'+dom.imgName+'">';
                	html += '<div><a href="'+root.appPath+'/product/getProduct?code='+dom.productCode+'">'
                	html +=	dom.productName+'<br>'+dom.productDescr+'</a></div></td>';
                	html += '<td>￥'+parseFloat(dom.unitPrice).toFixed(2)+'</td><td>'+dom.quantity+'</td>';
                	if (i == 0) {
                		var len = order.child.length;
	                	html += '<td rowspan="'+len+'">'+parseFloat(order.payment).toFixed(2)+'</td>';
	                	var code = order.code;
	                	var status = order.status;
	                	switch (status) {
						case 1:
		                	html += '<td rowspan="'+len+'">待付款</td>';
		                	html += '<td rowspan="'+len+'"><div>';
		                	html += '<a href="javascript:workFolw(\''+code+'\', '+status+');">付款</a></div></td>';
							break;
						case 2:
		                	html += '<td rowspan="'+len+'">待发货</td>';
		                	html += '<td rowspan="'+len+'"><div><a href="javascript:;">申请发票</a></div>';
		                	html += '<div><a href="javascript:;">查看物流</a></div>';
		                	html += '<div><a href="javascript:;">申请退款</a></div></td>';
							break;
						case 3:
		                	html += '<td rowspan="'+len+'">已发货</td>';
		                	html += '<td rowspan="'+len+'"><div><a href="javascript:;">申请发票</a></div>';
		                	html += '<div><a href="javascript:;">查看物流</a></div>';
		                	html += '<div><a href="javascript:workFolw(\''+code+'\', '+status+');">确认收货</a></div>';
		                	html += '<div><a href="javascript:;">申请退款</a></div></td>';
							break;
						case 4:
		                	html += '<td rowspan="'+len+'">已退款</td>';
		                	html += '<td rowspan="'+len+'"><div><a href="javascript:;">查看详情</a></div></td>';
							break;
						case 5:
		                	html += '<td rowspan="'+len+'">待评论</td>';
		                	html += '<td rowspan="'+len+'"><div>';
		                	html += '<a href="javascript:workFolw(\''+code+'\', '+status+');">评论</a></div>';
		                	html += '<div><a href="javascript:;">查看发票</a></div></td>';
							break;
						case 6:
		                	html += '<td rowspan="'+len+'">已评论</td>';
		                	html += '<td rowspan="'+len+'"><div><a href="javascript:;">查看详情</a></div>';
		                	html += '<div><a href="javascript:;">查看发票</a></div></td>';
							break;

						default:
							break;
						}
                	}
                	html += '</tr>';
                });
            });
            $("#tbody").html(html);
            
            var leng = list.length;
            if (curr != 1 && leng < 1) {
                $("input[name='pageIndex']").val(1);
                getList();
            } else if (curr == 1 && leng < 1) {
                layer.msg("没有查到数据", {icon: 5});
            }
        });
		
		workFolw = function(code, status) {
			switch (status) {
				case 1:
					ajax("/order/pay", "text", {code:code}, function(data) {
						getList();
					});
					break;
				case 3:
					status = 5;
					ajax("/order/upd", "text", {code:code, status:status}, function(data) {
                        getList();
                    });
                    break;
				case 5:
					status = 6;
					ajax("/order/upd", "text", {code:code, status:status}, function(data) {
						getList();
					});
					break;
	
				default:
					break;
			}
		}
		
		form.on('select(status)', function(data){
			search(data.value);
		});
		
		search = function(status) {
			$("input[name='status']").val(status);
			getList();
		}
		
		function getList() {
            $("#select").click();
        }
		
		getList();
	});
	</script>
</body>
</html>