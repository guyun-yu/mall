<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>欢迎登录</title>
<link rel="stylesheet" type="text/css" href= "<%=path%>/css/login.css"/>
</head>
<body class="layui-layout-body">
  <!-- 页面头部 -->
  <div class="title">
    <a href="<%=path%>/front/index.jsp"><img src="/mall/image/logo.png" class="logo"></a>
    <h2>欢迎登录</h2>
  </div>
  <hr>
  
  <!-- 页面主体 -->
  <div class="body">
    <div class="img" style="background-image: url('/mall/image/login.jpg');">
      <div class="d-form">
        <div class="layui-form-item">
          <h2>账户登录</h2>
        </div>
        <hr>
        <!-- 登陆表单 -->
        <form class="layui-form"  onsubmit="return false;">
	        <div class="layui-form-item">
	          <label class="layui-icon layui-icon-username"></label>
	          <input type="text" class="layui-input" name="code" placeholder="账号" lay-verify="required"
	                 autocomplete="off"/>
	        </div>
	        <div class="layui-form-item">
	          <label class="layui-icon layui-icon-password"></label>
	          <input type="password" class="layui-input" name="password" placeholder="密码" lay-verify="required"
	                 autocomplete="off"/>
	        </div>
	        <div class="layui-form-item">
	          <label class="layui-icon layui-icon-vercode"></label>
	          <input type="text" id="authCode" class="layui-input" name="authCode" lay-verify="required"
	                 placeholder="验证码"/>
	          <img src="<%=appPath%>/common/authCode" class="auth-code"
	               onclick="this.src='<%=appPath%>/common/authCode?'+Math.random();">
	        </div>
	        <div class="layui-form-item">
	          <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="login">登陆</button>
	        </div>
        </form>
        <hr>
        <div class="layui-form-item">
          <a href="<%=path%>/register.jsp">立即注册</a>
          <a href="<%=path%>/updPass.jsp" class="forgot">忘记密码</a>
        </div>
      </div>
    </div>
  </div>
  
  <script type="text/javascript">
  layui.use("layer", function() {
	  var layer = layui.layer;
	  
	  formSubmit("/user/login", "submit(login)", "json", function(data) {
		  var msg = data.msg;
		  console.log(msg);
		  if (msg == "登录成功") {
			  layer.msg(msg, {icon: 6, time: 800}, function() {
				  var role = data.role;
				  if (role == "1" || role == "2") {
					   location.href = root.path + "/page/index.jsp";
				  } else {
					  var url = "<%=request.getHeader("referer")%>";
					  if (url == "null" || url.indexOf("login") > -1) {
						  location.href = root.appPath;
					  } else {
						  location.href = url;
					  }
				  }
			  });
		  } else {
			  layer.msg(msg, {icon: 0});
		  }
	  });
  });
  </script>
</body>
</html>