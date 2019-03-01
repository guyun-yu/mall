<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-header">
    <div class="layui-logo"><a href="<%=path%>/front/index.jsp" class="index">MALL</a></div>
    <c:if test="${user.role == 1 || user.role == 2}">
	    <!-- 顶部左侧 -->
	    <ul class="layui-nav layui-layout-left">
	        <li class="layui-nav-item">
	           <a href="<%=path%>/page/index.jsp" title="后台主页"><i class="layui-icon layui-icon-website"></i></a>
	        </li>
	    </ul>
    </c:if>
    <!-- 顶部右侧 -->
    <ul class="layui-nav layui-layout-right">
        <c:choose>
            <c:when test="${!empty user}">
		        <li class="layui-nav-item"><a href="javascript:;">${user.name}</a>
		            <dl class="layui-nav-child">
		                <dd>
		                    <a href="<%=path%>/front/user/userIndex.jsp">个人主页</a>
		                </dd>
		                <dd>
		                    <a href="<%=path%>/updPass.jsp">修改密码</a>
		                </dd>
		            </dl>
		        </li>
		        <li class="layui-nav-item"><a href="<%=path%>/front/order/orderList.jsp">我的订单</a></li>
		        <li class="layui-nav-item">
		            <a href="<%=path%>/front/order/cart.jsp">购物车<span class="layui-badge" id="cartCount">0</span></a>
		        </li>
		        <li class="layui-nav-item"><a href="<%=appPath%>/user/exit">退出</a></li>
            </c:when>
            <c:otherwise>
		        <li class="layui-nav-item"><a href="<%=path%>/login.jsp">登陆</a></li>
		        <li class="layui-nav-item"><a href="<%=path%>/register.jsp">注册</a></li>
		        <li class="layui-nav-item"><a href="javascript:;">网站导航</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

<script type="text/javascript">
layui.use(["jquery"], function() {
	var $ = layui.jquery;
	
	if (${!empty user}) {
		ajax("/cart/getCount", "text", {code:"${user.code}"}, function(data) {
			$("#cartCount").text(data);
		});
	}
});
</script>