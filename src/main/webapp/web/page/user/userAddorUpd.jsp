<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>信息维护</title>
<style type="text/css">
  .layui-main {
    padding-top: 5px;
    width: 40%;
  }
  .layui-form-item.btn {
    text-align: center;
  }
</style>
</head>
<body>
    <div class="layui-main">
        <form class="layui-form layui-form-pane" lay-filter="addorUpd" onsubmit="return false;">
          <div class="layui-form-item">
		    <label class="layui-form-label">账号</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="code" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">电话</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="phone" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item password">
		    <label class="layui-form-label">密码</label>
		    <div class="layui-input-block">
		      <input type="password" class="layui-input" name="password" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item password">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-block">
		      <input type="password" class="layui-input" name="again" lay-verify="required" placeholder="必填"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">昵称</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="name" placeholder="只属于你哦"/>
		    </div>
		  </div>
          <div class="layui-form-item" pane>
		    <label class="layui-form-label">性别</label>
		    <div class="layui-input-block">
	          <input type="radio" class="layui-input" name="sex" value="男" title="男" />
	          <input type="radio" class="layui-input" name="sex" value="女" title="女" />
	          <input type="radio" class="layui-input" name="sex" value="保密" title="保密" checked/>
		    </div>
		  </div>
          <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input" name="birthday" id="birthday" placeholder="填写有惊喜哦"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-block">
              <select name="role">
                <option value="">请选择</option>
                <option value="2">管理员</option>
                <option value="3">普通用户</option>
              </select>
            </div>
          </div>
          <div class="layui-form-item btn">
            <button class="layui-btn" lay-submit lay-filter="submit">确定</button>
            <input type="reset" class="layui-btn" id="reset" value="重置"/>
          </div>
        </form>
    </div>
    
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
    
    <script type="text/javascript">
    layui.use(["form", "jquery", "layer"], function() {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form; 
        var isAdd = ${empty obj};
        
        function init() {
        	if (!isAdd) {
        		$("#reset").prop("type", "button");
	            $("#reset").click(showData);
	            $(".password").remove();
	            if (${user.role} != 1) {
	            	$("select[name='role']").attr("disabled", true);
	            }
        	}
        	
            getOpt("/role/getListAll", {}, "", "role", showData);
            dateInit("#birthday", "date");
        }
        
        function showData() {
        	if (isAdd) {return}
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"phone": "${user.phone}",
        		"name": "${obj.name}",
        		"sex": "${obj.sex}",
        		"birthday": "${obj.birthday}",
        		"role": "${obj.role}"
        	});
        	$("input[name='code']").prop("readonly", true);
        }
        	
        formSubmit("/user/" + (isAdd ? "addUser" : "upd"), "submit(submit)", "text", function(data) {
        	if (data == "添加成功" || data == "修改成功") {
        		layer.msg(data, {icon: 6, time: 800}, parent.window.closeTab);
        	} else {
        		layer.msg(data, {icon: 0});
        	}
        });
        
        init();
    });
    </script>
</body>
</html>