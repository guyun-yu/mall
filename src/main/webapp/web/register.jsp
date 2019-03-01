<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>欢迎注册</title>
<link rel="stylesheet" type="text/css" href="<%=appPath%>/web/css/register.css"/>
</head>
<body class="layui-layout-body" style="background-image: url('/mall/image/background1.jpg');">
<div class="back">
  <div class="layui-main">
    <!-- logo -->
    <div class="logo">
      <a href="<%=appPath%>/web/front/index.jsp"><img src="/mall/image/logo.png"></a>
      <h2>欢迎注册</h2>
    </div>
    
    <!-- 表单 -->
    <form class="layui-form" onsubmit="return false;">
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-username"></label>
        <input type="text" class="layui-input" name="code" placeholder="账号，必填"
               lay-verify="required" autocomplete="off"/>
      </div>
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-cellphone"></label>
        <input type="text" class="layui-input" name="phone" placeholder="电话，必填"
               lay-verify="required" autocomplete="off"/>
      </div>
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-password"></label>
        <input type="password" class="layui-input" name="password" placeholder="密码，必填"
               lay-verify="required" autocomplete="off"/>
      </div>
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-password"></label>
        <input type="password" class="layui-input" name="again" placeholder="确认密码"
               lay-verify="required" autocomplete="off"/>
      </div>
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-username"></label>
        <input type="text" class="layui-input" name="name" placeholder="昵称，必填"
               lay-verify="required" autocomplete="off"/>
      </div>
      <div class="layui-form-item in">
        <label class="layui-icon layui-icon-vercode"></label>
        <input type="text" id="authCode" class="layui-input" name="authCode" lay-verify="required"
               placeholder="验证码"/>
        <img src="<%=appPath%>/common/authCode" class="auth-code"
             onclick="this.src='<%=appPath%>/common/authCode?'+Math.random();">
      </div>
      <div class="layui-form-item">
        <input type="checkbox" title="同意用户协议" lay-skin="primary" checked>
      </div>
      <div class="layui-form-item">
        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="register">立即注册</button>
      </div>
    </form>
  </div>
</div>
  
  <script type="text/javascript">
	layui.use(["layer", "form"], function() {
		var layer = layui.layer;
		
		formSubmit("/user/register", "submit(register)", "text", function(data) {
	        if (data == "添加成功") {
	            layer.msg("注册成功", {icon: 6, time: 800}, function() {
	            	location.href = "<%=request.getHeader("referer")%>";
	            });
	        } else {
	            layer.msg(data, {icon: 0});
	        }
		});
	});
  </script>
</body>
</html>