<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>确认订单</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/confirmOrder.css"/>
</head>
<body>
<div class="layui-layout-admin">
    <%@ include file="/web/front/header.jsp" %>
    <div class="layui-main">
	    <fieldset class="layui-elem-field">
		  <legend>选择收货地址</legend>
		  <div class="layui-field-box">
			<div class="step-tit">
			        <h3>收货人信息</h3>
			        <div class="extra-r">
			            <a href="#none" class="ftx-05 J_consignee_global">新增收货地址</a>
			            <input type="hidden" id="del_consignee_type" value="0">
			        </div>
			        <div class="clr"></div>
			</div>
			<div id="consignee-addr" class="consignee-content">
				<div class="consignee-scrollbar">
					<div class="ui-scrollbar-main">
						<div class="consignee-scroll">
							<div class="consignee-cont" id="consignee1">
								<ul id="consignee-list">
									<li class="ui-switchable-panel ui-switchable-panel-selected"
										style="display: list-item;">
										<div class="consignee-item item-selected">
											<span title="超级管理员">超级管理员 山东</span><b></b>
										</div>
										<div class="addr-detail">
											<span class="addr-name" title="超级管理员">超级管理员</span>
											<span class="addr-info"
												title="山东 青岛市 市南区  青大一路青岛大学">山东 青岛市 市南区
												青大一路青岛大学</span>
											<span class="addr-tel">158****1991</span>
											<span class="addr-default">默认地址</span>
										</div>
										<div class="op-btns" >
											<span></span> 
											<a href="#none" class="ftx-05 edit-consignee">编辑</a> 
											<a href="#none" class="ftx-05 del-consignee hide"
											    style="display: none;">删除</a>
										</div>
									</li>

									<li class="ui-switchable-panel" style="display: list-item;">
									   <div class="consignee-item">
											<span>超级管理员 山东</span><b></b>
										</div>
										<div class="addr-detail">
											<span class="addr-name"title="超级管理员">超级管理员</span>
											<span class="addr-info"
												title="山东 青岛市 城阳区 城阳街道 春阳路盈园商务中心">山东 青岛市 城阳区 城阳街道
												春阳路盈园商务中心</span>
											<span class="addr-tel">158****1991</span>
										</div>
										<div class="op-btns">
											<a href="#none" class="ftx-05 setdefault-consignee">设为默认地址</a>
											<a href="#none" class="ftx-05 edit-consignee">编辑</a>
											<a href="#none" class="ftx-05 del-consignee">删除</a>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		  </div>
		</fieldset>
		
	    <fieldset class="layui-elem-field layui-field-title">
		  <legend>确认订单信息</legend>
		  <div class="layui-field-box">
		      <table class="layui-table"  lay-skin="line">
			      <colgroup>
	                <col width="35%">
	                <col width="20%">
	                <col width="15%">
	                <col width="15%">
	                <col width="15%">
	            </colgroup>
	            <thead>
	                <tr>
	                    <th>商品</th>
	                    <th>商品属性</th>
	                    <th>单价</th>
	                    <th>数量</th>
	                    <th>小计</th>
	                </tr>
	            </thead>
	            <tbody id="tbody"></tbody>
		      </table>
		      <div class="trade-foot">
		          <div class="trade-foot-detail">
		              <div class="price-tit">应付总额：<span class="total-price" id="totalPrice"></span></div>
		              <div class="consignee-info">寄送至：山东 青岛市 市南区 青大一路青岛大学</div>
		          </div>
		          <button class="layui-btn submit" id="submit">提交订单</button>
		      </div>
		  </div>
		</fieldset>
    </div>
</div>
<%@ include file="/web/front/footer.jsp" %>

    <script id="tbodyAdd" type="text/html">
    <tr>
        <td class="product-descr">
            <img src="/mall/image/productImg/{{d.mainPicture}}">
            <div>
              <a href="javascript:;">{{d.productName}}<br>{{d.descr}}</a>
            </div>
        </td>
        <td>颜色：白色<br>储存容量：256G</td>
        <td class="unit-price">{{= d.unitPrice.toFixed(2) }}</td>
        <td class="quantity">{{d.quantity}}</td>
        <td class="subtotal">{{= (d.unitPrice * d.quantity).toFixed(2)}}</td>
    </tr>
    </script>

	<script type="text/javascript">
	layui.use(["element", "jquery", "laytpl"], function() {
		var $ = layui.jquery;
		var laytpl = layui.laytpl;
		
		function init() {
			var html = "";
			$.each(${list}, function(i, dom) {
				html += laytpl($("#tbodyAdd").html()).render(dom);
			});
			$("#tbody").html(html);
			
			getTotalPrice();
			
			$("#submit").click(function() {
				var userCode = ${list}[0].code;
				location.href = root.appPath + "/order/createOrder?userCode=" + userCode;
			});
		}
		
		function getTotalPrice() {
			var totalPrice = 0;
			$(".subtotal").each(function(i, dom) {
				totalPrice += parseFloat($(dom).text());
			});
			$("#totalPrice").html("￥" + totalPrice.toFixed(2));
		}
		
		init();
	});
	</script>
</body>
</html>