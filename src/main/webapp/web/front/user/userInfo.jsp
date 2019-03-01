<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
          <div class="layui-form-item btn">
            <button class="layui-btn" lay-submit lay-filter="submit">确定</button>
            <input type="reset" class="layui-btn" id="reset" value="重置"/>
          </div>
        </form>
    </div>
    
    <script type="text/javascript">
    layui.use(["form", "jquery"], function() {
    	var form = layui.form;
    	var $ = layui.$;
    	
    	function init() {
    		$("#reset").prop("type", "button");
            $("#reset").click(showData);
            
            showData();
            dateInit("#birthday", "date");
    	}
    	
    	function showData() {
            form.val("addorUpd", {
                "code": "${user.code}",
                "phone": "${user.phone}",
                "name": "${user.name}",
                "sex": "${user.sex}",
                "birthday": "${user.birthday}"
            });
            $("input[name='code']").prop("readonly", true);
        }
    	
    	formSubmit("/user/upd", "submit(submit)", "text", function(data) {
            if (data == "修改成功") {
                layer.msg(data, {icon: 6, time: 1500}, function() {
                	ajax("/user/updUser", "text", {code:"${user.code}"}, function(data) {
                		if (data == "修改成功") {
                			parent.location.reload();
                		}
                	});
                });
            } else {
                layer.msg(data, {icon: 0});
            }
        });
        
        init();
    });
    </script>
</body>
</html>