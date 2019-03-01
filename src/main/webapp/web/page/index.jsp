<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>主页</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/index.css"/>
</head>
<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo">MALL</div>
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item">
                    <a href="<%=path%>/front/index.jsp" title="前台主页">
                        <i class="layui-icon layui-icon-website"></i>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:refresh();" title="刷新">
                        <i class="layui-icon layui-icon-refresh"></i>
                    </a>
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="javascript:;">
	                    <img src="/mall/image/headImg/default.png" class="layui-nav-img">${user.name}
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=path%>/front/user/userIndex.jsp">个人主页</a></dd>
                        <dd><a href="<%=path%>/updPass.jsp">修改密码</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="<%=appPath%>/user/exit">退了</a></li>
            </ul>
        </div>

        <!-- 左侧导航区域 -->
        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <ul class="layui-nav layui-nav-tree" id="leftNav"></ul>
            </div>
        </div>
        
        <div class="pagetabs">
	        <div class="layui-icon layadmin-tabs-control layui-icon-down">
	        </div>
            <div class="layui-tab layui-tab-brief" lay-allowClose="true"  lay-filter="tabTitle">
                <ul class="layui-tab-title" id="tabTitle"></ul>
            </div>
        </div>

        <!-- 内容主体区域 -->
        <div class="layui-body" id="tabBody"></div>

        <div class="layui-footer" >
            © mall.situ.com
        </div>
    </div>
    
    <script type="text/html" id="tabContent">
       <div class="layui-tab-item" id="{{d.id}}">
           <iframe src="{{d.url}}"></iframe>
       </div>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "laytpl", "jquery"], function() {
    	var element = layui.element;
    	var laytpl = layui.laytpl;
    	var $ = layui.jquery;
    	
    	function init() {
    		ajax("/menu/getAllMenu", "json", {rolecode: "${user.role}"}, function(data) {
    			var html = '';
    			$.each(data, function(i, menu1) {
	    			html += '<li class="layui-nav-item">';
	    			html += '<a href="javascript:;">'+menu1.name+'</a><dl class="layui-nav-child">';
	    			$.each(menu1.child, function(i, menu2) {
	    				html += '<dd><a href="javascript:;" class="open-tab"';
	    				html += 'data-url="'+menu2.url+'" data-id="'+menu2.code+'">'+menu2.name+'</a></dd>';
	    			});
	    			html += '</dl></li>';
    			});
    			$("#leftNav").html(html);
    			element.render('nav');
	    		$(".open-tab").click(changeTab);
    		});
    	}
	    
    	element.tab({
    		headerElem: "#tabTitle>li",
    		bodyElem: "#tabBody>.layui-tab-item"
    	});
    	
    	element.on("tab(tabTitle)", function(data) {
    		var id = $(this).attr("lay-id");
    		$("#tabBody .layui-show").removeClass("layui-show");
    		$("#" + id).addClass("layui-show");
    		$("#leftNav .layui-this").removeClass("layui-this");
    		$("#leftNav a[data-id='"+id+"']").parent().addClass("layui-this");
    		
            if (typeof id === "undefined") {
            	element.tabChange("tabTitle", "userList");
            	return;
            }
    		if (id.indexOf("List") > -1) {
    	        refresh();
    		}
    	});
    	
    	element.on("tabDelete(tabTitle)", function(data) {
    		$("#" + $(this).parent().attr("lay-id")).remove();
    	});
   	
    	changeTab = function(dataId, isChilder, title) {
    		var obj = $(this);
    		if (isChilder) {
    			obj = $("#tabBody .layui-show").find("iframe").contents().find("a[data-id='"+dataId+"']");
    		}
    	    var id = obj.data("id");
    	    if ($("#tabTitle li[lay-id='"+id+"']").length > 0) {
    	        element.tabChange("tabTitle", id);
    	    } else {
    	        addTab(id, obj.data("url"), typeof title === "undefined" ? obj.html() : title);
    	    }
    	}
    	
    	closeTab = function() {
    		var id = $("#tabTitle .layui-this").attr("lay-id");
    		if (id === "userList") {return;}
    		element.tabDelete("tabTitle", id);
    		$("#" + id).remove();
    	}
    	
    	function addTab(id, url, title) {
   	        element.tabAdd("tabTitle", {
   	            title: title,
   	            id: id
   	        });
   	        var html = laytpl($("#tabContent").html()).render({id:id, url: root.appPath + url});
   	        $("#tabBody").append(html);
   	        element.render("tab");
   	        element.tabChange("tabTitle", id);
    	}
    	
    	refresh = function() {
    		$(".layui-show iframe").attr("src", $(".layui-show iframe").attr("src"));
    	}
    	
    	init();
    });
    </script>
</body>
</html>