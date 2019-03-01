<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>重置密码</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/updPass.css"/>
</head>
<body>
<div class="layui-layout-admin">
    <%@ include file="/web/front/header.jsp" %>
    
    <div class="layui-main">
        <div class="step-nav">
            <div class="step step1 finish">
                <div class="step-icon">1</div>
                <div class="step-text">身份验证</div>
            </div>
            <div class="step-line step1-line"></div>
            <div class="step step2">
                <div class="step-icon">2</div>
                <div class="step-text">修改密码</div>
            </div>
            <div class="step-line step2-line"></div>
            <div class="step step3">
                <div class="step-icon"><i class="layui-icon layui-icon-ok"></i></div>
                <div class="step-text">完成</div>
            </div>
        </div>
        
        <div class="step-cent">
            <form class="layui-form" onsubmit="return false;">
                <div class="step step1 show">
	                <div class="layui-form-item">
					    <label class="layui-form-label">电话</label>
					    <div class="layui-input-block">
					        <input type="text" name="phone" placeholder="请输入电话" class="layui-input">
					    </div>
				    </div>
	                <div class="layui-form-item">
					    <label class="layui-form-label">验证码</label>
					    <div class="layui-input-inline">
					        <input type="text" name="authCode" lay-verify="required" placeholder="请输入验证码" 
					        class="layui-input">
					        <button class="layui-btn layui-btn-primary authCode">获取验证码</button>
					    </div>
				    </div>
				    <div class="layui-form-item">
    				    <button class="layui-btn layui-btn-fluid submit" id="step1-submit">确定</button>
				    </div>
                </div>
            
                <div class="step step2">
                    <div class="layui-form-item">
                        <label class="layui-form-label">账号</label>
                        <div class="layui-input-block">
                            <input type="text" name="code" lay-verify="required" class="layui-input"
                            readonly="readonly">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">新密码</label>
                        <div class="layui-input-block">
                            <input type="password" name="password" lay-verify="required" placeholder="新密码" 
                            class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">确认密码</label>
                        <div class="layui-input-block">
                            <input type="password" name="again" lay-verify="required" placeholder="确认密码" 
                            class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn layui-btn-fluid submit"  lay-submit lay-filter="submit">确定</button>
                    </div>
                </div>
            </form>
            
            <div class="step step3">
                <div class="success">
                    <div class="success-icon"><i class="layui-icon layui-icon-ok"></i></div>
                    <div class="success-text">
                        <h2>修改成功，请牢记密码</h2>
                        <a href="<%=path%>/login.jsp">重新登录</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/web/front/footer.jsp" %>

<script type="text/javascript">
    layui.use(["element", "jquery", "form", "layer"], function() {
    	var $ = layui.$;
    	var layer = layui.layer;
    	
    	function init() {
    		if (!${empty user}) {
    			$("input[name='code']").val("${user.code}");
    			$("input[name='phone']").val("${user.phone}");
    		}
    		
    		$(".authCode").click(function() {
    			var time = 60;
    			$(".authCode").prop("disabled", true);
    			$(".authCode").toggleClass("layui-btn-disabled");
    			$(".authCode").text("获取验证码(" + time-- + "s)");
    			var timer = window.setInterval(function() {
	    			$(".authCode").text("获取验证码(" + time-- + "s)");
    				
    				if (time < 0) {
		    			window.clearInterval(timer);
		    			$(".authCode").text("获取验证码");
		    			$(".authCode").prop("disabled", false);
		                $(".authCode").toggleClass("layui-btn-disabled");
    				}
    			}, 1000);
    		});
    		
    		$("#step1-submit").click(function() {
    			var phone = $("input[name='phone']").val();
    			var authCode = $("input[name='authCode']").val();
    			ajax("/user/phoneCode", "text", {phone:phone, authCode:authCode}, function(data) {
    				if (data == "手机号错误" || data == "验证码错误") {
    					layer.msg(data, {icon:0});
    				} else {
    					var user = JSON.parse(data);
    					$("input[name='code']").val(user.code);
    					toStep2();
    				}
    			});
    		});
    	}
    	
    	formSubmit("/user/updPass", "submit(submit)", "text", function(data) {
            if (data == "修改成功") {
                toStep3();
            } else {
                layer.msg(data, {icon: 0});
            }
        });
    	
    	function toStep2() {
    		$(".step-nav .step1-line").addClass("finish");
    		$(".step-nav .step2").addClass("finish");
    		$(".step-cent .step1").removeClass("show");
    		$(".step-cent .step2").addClass("show");
    	}
    	
    	function toStep3() {
    		$(".step-nav .step2-line").addClass("finish");
    		$(".step-nav .step3").addClass("finish");
    		$(".step-cent .step2").removeClass("show");
    		$(".step-cent .step3").addClass("show");
    	}
    	
    	init();
    });
</script>
</body>
</html>