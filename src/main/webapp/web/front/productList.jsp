<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>商品列表</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/productList.css"/>
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
		<form class="layui-form" onsubmit="return false;" style="display: none;">
		    <input type="hidden" name="name" value="%${name}%">
		    <input type="hidden" name="dictCode" value="${obj.code}">
		    <input type="hidden" name="pageIndex" value="1">
		    <input type="hidden" name="pageLimit" value="4">
		    <button lay-submit lay-filter="select" id="select"></button>
		</form>
		
	    <!-- 小导航 -->
	    <span class="layui-breadcrumb" id="breadcrumb" lay-separator=">"></span>
	    <!-- 引用文本 -->
	    <blockquote class="layui-elem-quote">
	        <span id="block-title"></span>
	        <span>商品筛选</span>
	    </blockquote>
	    <!-- 条件筛选 -->
	    <div class="goods-cond">
	        <div class="goods-attr">
	            <div>品牌：</div>
	            <ul>
	                <li><a href="javascript:;">联想</a></li>
	                <li><a href="javascript:;">华硕</a></li>
	                <li><a href="javascript:;">苹果</a></li>
	                <li><a href="javascript:;">戴尔</a></li>
	            </ul>
	            <div class="layui-form"><input type="checkbox" lay-skin="switch" lay-text="多选|多选"></div>
	        </div>
	        <div class="goods-attr">
	            <div>屏幕尺寸：</div>
	            <ul>
	                <li><a href="javascript:;">12.5英寸</a></li>
	                <li><a href="javascript:;">12.5英寸</a></li>
	                <li><a href="javascript:;">12.5英寸</a></li>
	                <li><a href="javascript:;">12.5英寸</a></li>
	            </ul>
	            <div class="layui-form"><input type="checkbox" lay-skin="switch" lay-text="多选|多选"></div>
	        </div>
	        <div class="goods-attr">
	            <div>处理器：</div>
	            <ul>
	                <li><a href="javascript:;">Intel i7</a></li>
	                <li><a href="javascript:;">Intel i7</a></li>
	                <li><a href="javascript:;">Intel i7</a></li>
	                <li><a href="javascript:;">Intel i7</a></li>
	                <li><a href="javascript:;">Intel i7</a></li>
	            </ul>
	            <div class="layui-form"><input type="checkbox" lay-skin="switch" lay-text="多选|多选"></div>
	        </div>
	    </div>
	    <!-- 商品列表 -->
	    <div class="layui-tab">
	      <ul class="layui-tab-title">
	        <li class="layui-this">销量</li>
	        <li>价格</li>
	        <li>评论数</li>
	        <li>上架时间</li>
	      </ul>
	    </div>
	    <div class="product">
	        <ul id="product"></ul>
	        <div style="clear: both;"></div>
	    </div>
	    <!-- 分页 -->
	    <div id="page"></div>
	</div>
</div>
<%@ include file="/web/front/footer.jsp" %>

    <script id="productAdd" type="text/html">
     <li>
         <div class="product-item">
             <a href="/mall/product/getProduct?code={{d.code}}"><img src="/mall/image/productImg/{{d.mainPicture}}"></a>
             <div class="price">￥{{=d.unitPrice.toFixed(2)}}</div>
             <div class="sales">共{{d.sales}}人付款</div>
             <div class="name"><a href="/mall/product/getProduct?code={{d.code}}">{{d.name}}</a></div>
             <div class="descr"><a href="/mall/product/getProduct?code={{d.code}}">{{d.descr}}</a></div>
             <div class="buy">
                 <a href="javascript:cartAdd('{{d.code}}');"><i class="layui-icon layui-icon-cart"></i> 加入购物车</a>
             </div>
         </div>
     </li>
    </script>
            
    <script type="text/javascript">
    layui.use(["element", "form", "laytpl", "layer", "jquery"], function() {
    	var element = layui.element;
    	var laytpl = layui.laytpl;
    	var layer = layui.layer;
    	var $ = layui.jquery;
    	
    	function init() {
    		initBreadcrumb();
    		getList();
    		
    		$("#search-btn").click(function() {
    			var val = $("#search-input").val();
    			if ("" === val) {
    				return;
    			}
    			$("input[name='name']").val("%" + val + "%");
    			$("input[name='dictCode']").val("");
    			
    			var html = '<a href="javascript:;">全部结果</a>';
                html += '<a><cite>'+ val +'</cite></a>';
                $("#breadcrumb").html(html);
                $("#block-title").html(val);
    			getList();
    			element.render("breadcrumb");
    		});
    	}
    	
    	function initBreadcrumb() {
    		var html = "";
    		if (${empty obj}) {
    			html += '<a href="javascript:;">全部结果</a>';
    			html += '<a><cite>${name}</cite></a>';
    			$("#block-title").html("${name}");
    			$("#search-input").val("${name}");
    		} else {
    			html += '<a href="javascript:;">${obj.cate1Name}</a>';
    			html += '<a href="javascript:;">${obj.cate2Name}</a>';
    			html += '<a href="javascript:;">${obj.name}</a>';
    			$("#block-title").html("${obj.name}");
    		}
    		$("#breadcrumb").html(html);
    		element.render("breadcrumb");
    	}
    	
    	formSubmit("/product/getList", "submit(select)", "json", function(data) {
            var limit = $("input[name='pageLimit']").val();
            var curr = $("input[name='pageIndex']").val();
            pageInit("page", data.rowCount, limit, curr, [4, 8, 20, 40, 60], function(obj, first) {
                $("input[name='pageLimit']").val(obj.limit);
                $("input[name='pageIndex']").val(obj.curr);
                if (!first) {
                    getList();
                }
            });
            
            var html = "";
            var list = data.list;
            $.each(list, function(index, dom) {
                html += laytpl($("#productAdd").html()).render(dom);
            });
            $("#product").html(html);
            
            var leng = list.length;
            if (curr != 1 && leng < 1) {
                $("input[name='pageIndex']").val(1);
                getList();
            } else if (curr == 1 && leng < 1) {
                layer.msg("没有查到商品", {icon: 5});
            }
        });
    	
    	function getList() {
            $("#select").click();
        }
    	
    	cartAdd = function(code) {
            if (${empty user}) {
                location.href = root.path + "/login.jsp";
                return;
            }
            ajax("/cart/add", "text", {code:"${user.code}", productCode:code, quantity:1},
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
    	
    	init();
    });
    </script>
</body>
</html>