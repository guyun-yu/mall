<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>菜单维护</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/userList.css"/>
</head>
<body>
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">条件查询</h2>
            <div class="layui-colla-content">
                <form class="layui-form select"  onsubmit="return false;">
                    <div class="layui-input-inline">
                        <input type="text" name="code" class="layui-input" placeholder="编号">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" name="name" class="layui-input" placeholder="名称">
                    </div>
                    <div class="layui-inline">
                        <select name="parentCode" lay-search></select>
                    </div>
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="select" id="select">
                        <i class="layui-icon layui-icon-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </div>
        
    <div class="layui-form">
        <a href="javascript:delAll();" class="layui-btn layui-btn-sm layui-btn-danger">删除选中项</a>
        <a href="javascript:parent.window.changeTab('menuAdd', true, '菜单 - 添加');"
            data-url="/menu/addTab" data-id="menuAdd"
            class="layui-btn layui-btn-sm layui-btn-normal">添加</a>
        <table id="table"></table>
    </div>
    
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
    
    <script id="tbodyAdd" type="text/html">
    <a href="javascript:del('{{d.code}}');" class="layui-btn layui-btn-xs layui-btn-danger">
        <i class="layui-icon layui-icon-delete"></i>删除
    </a>
    <a href="javascript:parent.window.changeTab('menuUpd{{d.code}}', true, '菜单 - 修改');"
        data-url="/menu/updTab?id={{d.code}}" data-id="menuUpd{{d.code}}"
        class="layui-btn layui-btn-xs layui-btn-normal">
        <i class="layui-icon layui-icon-edit"></i>编辑
    </a>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "laytpl", "layer", "table"], function() {
        var $ = layui.jquery;
        var form = layui.form;
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        var table = layui.table;
        
        function init() {
            $("#select").click(getTable);
            getList();
            initSelect();
        }
        
        function initSelect() {
            ajax("/menu/getListAll", "json", {parentCode:"menu0000"}, function(data) {
                var html = "<option value=''>顶级菜单：不限</option>";
                $.each(data, function(index, dom) {
                    html += laytpl($("#optAdd").html()).render(dom);
                });
                $("select[name='parentCode']").html(html);
                form.render("select");
            });
        }
        
        function getTable() {
        	table.render({
        		elem: "#table"
        		,height: 290
        	    ,url: root.appPath + "/menu/getList"
        	    ,page: true
        	    ,limit: 5
        	    ,limits: [5, 10, 20, 30, 40]
        	    ,where: {
        	    	code: $("input[name='code']").val(),
        	    	name: $("input[name='name']").val(),
        	    	parentCode: $("select[name='parentCode']").val()
        	    }
        	    ,request: {
        	    	 pageName: 'pageIndex'
     	    		 ,limitName: 'pageLimit'
        	    }
        	    ,cols: [[
        	    	 {checkbox: true}
       	    	    ,{title: 'ID', type: 'numbers'}
       	    	    ,{field: 'code', title: '菜单编号'}
       	    	    ,{field: 'name', title: '菜单名'}
       	    	    ,{field: 'url', title: 'url'}
       	    	    ,{field: 'parentCode', title: '父菜单'}
       	    	    ,{title: '操作', templet: "#tbodyAdd"}
        	    ]]
        	    ,parseData: function(res) {
        	    	return {
        	    		"code": 0,
        	    		"count": res.rowCount,
        	    		"data": res.list
        	    	}
        	    }
        	});
        }
        
        function getList() {
            $("#select").click();
            $("input[lay-filter='checkAll']").prop("checked", false);
        }
        
        del = function(code) {
            layer.confirm("确认删除？", function(index) {
                ajax("/menu/del", "text", {id:code}, function(data) {
                    if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:1000});
                    } else {
                        layer.msg(data, {icon:0, time:1500});
                    }
                    getList();
                });
                layer.close(index);
            });
        }
        
        delAll = function() {
            layer.confirm("确认删除？", function(index) {
                var code = new Array();
                $("#tbody :checked").each(function(i, dom) {
                    code[i] = $(dom).val();
                });
                layer.close(index);
            });
        }
        
        init();
    });
    </script>
</body>
</html>