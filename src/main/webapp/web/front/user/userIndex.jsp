<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>个人主页</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/userIndex.css"/>
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
        
        <div class="cent">
	        <ul class="user-nav">
	            <li><a href="javascript:;" class="open-url" data-url="/front/user/userInfo.jsp">个人中心</a></li>
	            <li class="hr"></li>
	            <li><a href="<%=path%>/updPass.jsp">修改密码</a></li>
	            <li class="hr"></li>
	            <li><a href="<%=path%>/front/order/orderList.jsp">我的订单</a></li>
	            <li class="hr"></li>
	            <li><a href="javascript:;"  class="open-url" data-url="/front/user/address.jsp">收货地址</a></li>
	            <li class="hr"></li>
	            <li><a href="javascript:;"  class="open-url" data-url="/front/user/collectList.jsp">我的收藏</a></li>
	            <li class="hr"></li>
	            <li><a href="javascript:;">服务中心</a></li>
	        </ul>
	        
	        <iframe name="frame" src="<%=path%>/front/user/userInfo.jsp"></iframe>
        </div>
    </div>
</div>
<%@ include file="/web/front/footer.jsp" %>

<script type="text/javascript">
    layui.use(["element", "jquery"], function() {
    	var $ = layui.$;
    	
    	function init() {
    		$(".open-url").click(function() {
	   			var url = $(this).data("url");
	   			window.open(root.path + url, "frame");
    		});
    		
    		$("#search-btn").click(search);
    	}
    	
    	init();
    });
</script>
</body>
</html>