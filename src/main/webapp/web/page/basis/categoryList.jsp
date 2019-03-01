<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>商品分类</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/userList.css"/>
</head>
<body>
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">条件查询</h2>
            <div class="layui-colla-content">
                <form class="layui-form select"  onsubmit="return false;">
                    <div class="layui-input-inline">
                        <select name="code" lay-search></select>
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" name="name" class="layui-input" placeholder="名称">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" name="descr" class="layui-input" placeholder="描述">
                    </div>
                    <div class="layui-inline">
                        <select name="parentCode" lay-search></select>
                    </div>
                    <input type="hidden" name="pageIndex" value="1">
                    <input type="hidden" name="pageLimit" value="5">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="select" id="select">
                        <i class="layui-icon layui-icon-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </div>
        
    <div class="layui-form">
        <a href="javascript:delAll();" class="layui-btn layui-btn-sm layui-btn-danger">删除选中项</a>
        <a href="javascript:parent.window.changeTab('categoryAdd', true, '商品分类 - 添加');"
            data-url="/dict/addTab" data-id="categoryAdd"
            class="layui-btn layui-btn-sm layui-btn-normal">添加</a>
        <table class="layui-table">
            <colgroup>
                <col width="5%">
                <col width="5%">
                <col width="10%">
                <col width="10%">
                <col width="30%">
                <col width="10%">
                <col width="15%">
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" lay-filter="checkAll" lay-skin="primary"></th>
                    <th>序号</th>
                    <th>编号</th>
                    <th>名称</th>
                    <th>描述</th>
                    <th>上级编号</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="tbody"></tbody>
        </table>
        <div id="page"></div>
    </div>
    
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
    
    <script id="tbodyAdd" type="text/html">
     <tr>
         <td><input type="checkbox" value="{{d.code}}" lay-filter="checkOne" lay-skin="primary"></td>
         <td>{{d.num}}</td>
         <td>{{d.code}}</td>
         <td>{{d.name}}</td>
         <td>{{d.descr}}</td>
         <td>{{d.parentCode}}</td>
         <td>
             <a href="javascript:del('{{d.code}}');" class="layui-btn layui-btn-xs layui-btn-danger">
                 <i class="layui-icon layui-icon-delete"></i>删除
             </a>
             <a href="javascript:parent.window.changeTab('categoryUpd{{d.code}}', true, '商品分类 - 修改');"
                 data-url="/dict/categoryUpdTab?code={{d.code}}" data-id="categoryUpd{{d.code}}"
                 class="layui-btn layui-btn-xs layui-btn-normal">
                 <i class="layui-icon layui-icon-edit"></i>编辑
             </a>
         </td>
     </tr>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "laytpl", "layer"], function() {
        var $ = layui.jquery;
        var form = layui.form;
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        
        function init() {
            form.on("checkbox(checkAll)", checkAll);
            form.on("checkbox(checkOne)", setCheckAll);
            getList();
            initSelect();
        }
        
        function initSelect() {
            ajax("/dict/getListAll", "json", {parentCode:"cate0000"}, function(data) {
                var html = "<option value=''>一级分类：不限</option>";
                $.each(data, function(index, dom) {
                    html += laytpl($("#optAdd").html()).render(dom);
                });
                $("select[name='parentCode']").html(html);
                form.render("select");
            });
            ajax("/dict/getListAll", "json", {}, function(data) {
                var html = "<option value=''>编号：不限</option>";
                $.each(data, function(index, dom) {
                    html += laytpl($("#optAdd").html()).render(dom);
                });
                $("select[name='code']").html(html);
                form.render("select");
            });
        }
        
        formSubmit("/dict/getList", "submit(select)", "json", function(data) {
            var limit = $("input[name='pageLimit']").val();
            var curr = $("input[name='pageIndex']").val();
            pageInit("page", data.rowCount, limit, curr, null, function(obj, first) {
                $("input[name='pageLimit']").val(obj.limit);
                $("input[name='pageIndex']").val(obj.curr);
                if (!first) {
                    getList();
                }
            });
            
            var html = "";
            var list = data.list;
            $.each(list, function(index, dom) {
                dom.num = index + 1 + (curr-1)*limit;
                html += laytpl($("#tbodyAdd").html()).render(dom);
            });
            $("#tbody").html(html);
            form.render("checkbox");
            
            var leng = list.length;
            if (curr != 1 && leng < 1) {
                $("input[name='pageIndex']").val(1);
                getList();
            } else if (curr == 1 && leng < 1) {
                layer.msg("没有查到数据", {icon: 5});
            }
        });
        
        function checkAll(data) {
            $("#tbody :checkbox").prop("checked", data.elem.checked);
            form.render("checkbox");
        }
        
        function getList() {
            $("#select").click();
            $("input[lay-filter='checkAll']").prop("checked", false);
        }
        
        del = function(code) {
            layer.confirm("确认删除？", function(index) {
                ajax("/dict/del", "text", {id:code}, function(data) {
                    if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:800});
                    } else {
                        layer.msg(data, {icon:0, time:1000});
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
                ajax("/dict/delAll", "text", {id:code}, function(data) {
                    if (data == "删除成功") {
                        layer.msg(data, {icon:6, time:800});
                    } else {
                        layer.msg(data, {icon:0, time:1000});
                    }
                    getList();
                });
                layer.close(index);
            });
        }
        
        init();
    });
    </script>
</body>
</html>