<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>商品详情</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/product.css"/>
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
        
        <!-- 小导航 -->
        <span class="layui-breadcrumb" id="cateNav" lay-separator=">"></span>
        <div class="goods">
            <!-- 商品图片 -->
            <div class="layui-carousel" id="goodsImg"></div>
            <!-- 商品详情 -->
            <div class="goods-data" id="goodsData"></div>
        </div>
    
    </div>
</div>
<%@ include file="/web/front/footer.jsp" %>

    <script id="goodsAdd" type="text/html">
     <div class="title">
         <h3>{{d.name}}</h3>
         <p>{{d.descr}}</p>
     </div>
     <div class="gd-price">
         <div class="gdf">价格：</div>
         <div class="price">￥{{=d.unitPrice.toFixed(2)}}</div>
     </div>
     <div class="gd">
         <div class="gdf">配送至：</div>
         <div class="layui-form address">
             <div>
                 <select>
                     <option value="">请选择</option>
                 </select>
             </div>
             <div>
                 <select>
                     <option value="">请选择</option>
                 </select>
             </div>
             <div>
                 <select>
                     <option value="">请选择</option>
                 </select>
             </div>
         </div>
     </div>
     <div class="gd">
         <div class="gdf">颜色：</div>
         <div class="color">
             <div>黑色</div>
             <div>红色</div>
             <div>银色</div>
         </div>
     </div>
     <div class="gd">
         <div class="gdf">数量：</div>
         <div class="amount">
             <div><a href="javascript:amountSub();">-</a></div>
             <div style="width: 40px;"><input type="text" id="amount" value="1"></div>
             <div><a href="javascript:amountAdd();">+</a></div>
             <label class="stock">库存：{{d.stock}}</label>
         </div>
     </div>
     <div class="buy">
         <span class="buy-now"><a href="javascript:collectAdd('{{d.code}}');">加入收藏</a></span>
         <span class="shop-cart">
            <a href="javascript:cartAdd('{{d.code}}');"><i class="layui-icon layui-icon-cart"></i> 加入购物车</a>
         </span>
     </div>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "laytpl", "layer"], function() {
    	var element = layui.element;
        var $ = layui.jquery;
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        
        function init() {
	        $("#goodsData").html(laytpl($("#goodsAdd").html()).render(${obj}));
	        
	        var html = "<div carousel-item>";
	        $.each(${obj.imgs}, function(index, img) {
	        	html += "<div><img src='/mall/image/productImg/"+img.name+"'></div>";
	        });
	        html += "</div>";
	        $("#goodsImg").html(html);
	        initCarousel("#goodsImg", "450px", "450px", false, "always", null);
	        
	        getCategory();
	        
	        $("#amount").focusout(function() {
	        	var input = $("#amount").val();
	        	if (!checkInt(input)) {
	                $("#amount").val("1");
	                return;
	            }
	            var amount = Number(input);
	            if (amount > 100) {
	            	layer.msg("最大数量为100哦", {icon:0,time:1500});
	            	$("#amount").val("100");
	            } else if (amount == 0) {
	            	$("#amount").val("1");
	            }
	        });
	        
	        $("#search-btn").click(search);
        }
        
        function getCategory() {
        	ajax("/dict/getProdCate", "json", {code:"${obj.dictCode}"}, function(data) {
        		var html = "<a href='javascrpt:;'>"+data.cate1Name+"</a>";
        		html += "<a href='javascrpt:;'>"+data.cate2Name+"</a>";
        		html += "<a href='javascrpt:;'>"+data.name+"</a>";
        		html += "<a><cite>${obj.name}</cite></a>";
        		$("#cateNav").html(html);
        		element.render("breadcrumb");
        	});
        }
        
        amountSub = function() {
        	var input = $("#amount").val();
        	if (!checkInt(input)) {
                $("#amount").val("1");
                return;
            }
        	var amount = Number(input);
        	if (amount <= 1) {
        		$("#amount").val("1");
        	} else {
        		$("#amount").val(amount - 1);
        	}
        }
        
        amountAdd = function() {
        	var input = $("#amount").val();
            if (!checkInt(input)) {
                $("#amount").val("1");
                return;
            }
            var amount = Number(input);
            if (amount >= 100) {
            	layer.msg("最大数量为100哦", {icon:0,time:1500});
                $("#amount").val("100");
            } else {
            	$("#amount").val(amount + 1);
            }
        }
        
        cartAdd = function(code) {
        	if (${empty user}) {
        		location.href = root.path + "/login.jsp";
        		return;
        	}
        	ajax("/cart/add", "text", {code:"${user.code}", productCode:code, quantity:$("#amount").val()},
        			function(data) {
        		if (data == "添加成功") {
        			layer.msg(data, {icon:6, time:1500});
        			ajax("/cart/getCount", "text", {code:"${user.code}"}, function(data) {
        	            $("#cartCount").text(data);
        	        });
        		} else {
        			layer.msg(data, {icon:0, time:1500});
        		}
        	});
        }
        
        collectAdd = function(productCode) {
        	if (${empty user}) {
                location.href = root.path + "/login.jsp";
                return;
            }
        	ajax("/collect/add", "text", {code:"${user.code}", productCode:productCode}, function(data) {
        		if (data == "添加成功") {
                    layer.msg("收藏成功", {icon:6, time:1500});
        		} else {
        			layer.msg(data, {icon:0, time:1500});
        		}
        	});
        }
        
        init();
    });
    </script>
</body>
</html>