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
		    <label class="layui-form-label">订单编号</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="code"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">用户账号</label>
		    <div class="layui-input-block">
		      <select name="userCode" lay-filter="userCode" lay-search lay-verify="required"></select>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">付款金额</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="payment"/>
		    </div>
		  </div>
          <div class="layui-form-item">
		    <label class="layui-form-label">创建时间</label>
		    <div class="layui-input-block">
		      <input type="text" class="layui-input" name="createTime"/>
		    </div>
		  </div>
          <div class="layui-form-item" pane>
		    <label class="layui-form-label">收货地址</label>
		    <div class="layui-input-block">
		      <select name="shippingId" lay-search>
		          <option value="">请选择</option>
		      </select>
		    </div>
		  </div>
          <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
              <select name="status">
                <option value="1" disabled>已下单</option>
                <option value="2" disabled>已付款</option>
                <option value="3" disabled>已发货</option>
                <option value="4" disabled>已退款</option>
                <option value="5" disabled>已收货</option>
                <option value="6" disabled>已评论</option>
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
    layui.use(["form", "jquery", "layer", "laytpl"], function() {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form; 
        var laytpl = layui.laytpl;
        
        function init() {
       		$("#reset").prop("type", "button");
            $("#reset").click(showData);
            getOpt("<option value=''>请选择</option>", "userCode", showData);
        }
        
        function getOpt(html, elem, func) {
            ajax("/user/getListAll", "json", {}, function(data) {
                $.each(data, function(index, dom) {
                    html += laytpl($("#optAdd").html()).render(dom);
                });
                $("select[name='"+elem+"']").html(html);
                func();
                form.render("select");
            });
        }
        
        function showData() {
        	var status = ${obj.status};
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"userCode": "${obj.userCode}",
        		"payment": "${obj.payment}",
        		"createTime": "${obj.createTime}",
        		"status": status
        	});
        	switch (status) {
			case 2:
				$("select[name='status']>option[value='3']").prop("disabled", false);
				break;

			default:
				break;
			}
        	$("select[name='status']>option[value='"+status+"']").prop("disabled", false);
        	$("input[name='code']").prop("readonly", true);
        	$("input[name='createTime']").prop("readonly", true);
        }
        	
        formSubmit("/order/upd", "submit(submit)", "text", function(data) {
        	if (data == "修改成功") {
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