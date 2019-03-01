<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>我的收藏</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/collectList.css"/>
</head>
<body>
    <div class="main">
        <ul class="product" id="product"></ul>
        <div style="clear: both;"></div>
    </div>
    
    <script id="productAdd" type="text/html">
    <li>
        <div class="product-item">
            <a href="javascript:openProduct('{{d.productCode}}');">
                <img src="/mall/image/productImg/{{d.mainPicture}}">
            </a>
            <div class="price">￥{{d.unitPrice}}</div>
            <div class="name"><a href="javascript:openProduct('{{d.productCode}}');">{{d.productName}}11</a></div>
            <div class="del">
                <a href="javascript:del('{{d.id}}');">删除</a>
            </div>
        </div>
    </li>
    </script>
    
    <script type="text/javascript">
    layui.use(["jquery", "laytpl", "layer"], function() {
    	var $ = layui.$;
    	var laytpl = layui.laytpl;
    	var layer = layui.layer;
    	
    	function init() {
    		ajax("/collect/getListAll", "json", {code:"${user.code}"}, function(data) {
    	        var html = "";
 	            $.each(data, function(index, dom) {
 	                html += laytpl($("#productAdd").html()).render(dom);
 	            });
 	            $("#product").html(html);
 	            
 	            if (data.length < 1) {
 	            	layer.msg("暂无收藏", {icon:0})
 	            }
    		});
    	}
    	
    	del = function(id) {
    		layer.confirm("确认删除？", function(index) {
    			ajax("/collect/del", "text", {id:id}, function(data) {
    				if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:800}, init);
                    } else {
                        layer.msg(data, {icon:0, time:1000}, init);
                    }
    			});
    			layer.close(index);
    		});
    	}
    	
    	openProduct = function(code) {
    		parent.location.href = root.appPath + "/product/getProduct?code=" + code;
    	}
    	
    	init();
    });
    </script>
</body>
</html>