<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>主页</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/index.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/amazeui.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/hmstyle.css"/>
</head>
<body>
<div class="layui-layout-admin">
    <%@ include file="/web/front/header.jsp" %>
    <!-- 主体内容 -->
    <div class="layui-main">
        <div class="logo">
            <a href="#"><img src="/mall/image/logo.png"></a>
        </div>          
        <!-- 分类导航 -->
        <div class="cate">
            <ul class="cate-nav" id="cateNav"></ul>
        </div>
        <!-- 搜索框 -->
        <div class="select">
            <input type="text" class="select-input" id="search-input">
            <button class="layui-btn layui-btn-normal" id="search-btn">搜索</button>
        </div>

        <!-- 热门分类 -->
        <div class="hot-category">
            <span class="layui-breadcrumb" lay-separator="|" id="hot-cate"></span>
        </div>

        <!-- 轮播 -->
        <div class="layui-carousel" id="carousel1">
            <div carousel-item>
                <div>
                    <img src="/mall/image/carousel1.jpg">
                </div>
                <div>
                    <img src="/mall/image/carousel2.jpg">
                </div>
                <div>
                    <img src="/mall/image/carousel3.jpg">
                </div>
                <div>
                    <img src="/mall/image/carousel4.jpg">
                </div>
                <div>
                    <img src="/mall/image/carousel5.jpg">
                </div>
            </div>
        </div>

        <!-- 优惠商品 -->
        <fieldset class="layui-elem-field layui-field-title">
            <legend>限时优惠</legend>
            <div class="layui-field-box goods">
                <div class="timer">
                  <h1>限时秒杀</h1>
                  <p>距离结束还剩</p>
                  <label>12:23:12</label>
                </div>
                <div class="layui-carousel" id="carousel2">
                    <div carousel-item>
                        <div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel6.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel7.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel8.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel9.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel10.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel11.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel12.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                            <div class="float-left goods-item">
                                <img src="/mall/image/carousel13.jpg">
                                <p>名称</p>
                                <div class="price">
                                   <span class="new-price">￥195.00</span>
                                   <span class="old-price">￥200.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-carousel" id="carousel3">
                    <div carousel-item>
                        <div>
                            <img src="/mall/image/carousel14.jpg">
                        </div>
                        <div>
                            <img src="/mall/image/carousel15.jpg">
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
        
        <fieldset class="layui-elem-field layui-field-title">
            <legend>热门优选</legend>
            <div class="layui-field-box goods">
            </div>
        </fieldset>
        
        <!-- 电子商品 -->
        <fieldset class="layui-elem-field layui-field-title">
            <legend>智能先锋</legend>
            <div class="layui-field-box goods">
                <div class="elec-gd1 elec-goods1">
                    <a href="javascript:;" class="title">手机频道</a>
                    <div class="phone">
                    <a href="javascript:;"><img src="/mall/image/phone1.jpg"></a>
                    <a href="javascript:;"><img src="/mall/image/phone2.jpg"></a>
                    </div>
                    <table class="phone-brand">
                        <tr>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand1.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand2.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand3.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand4.jpg"></a></td>
                        </tr>
                        <tr>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand1.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand2.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand3.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand4.jpg"></a></td>
                        </tr>
                        <tr>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand1.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand2.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand3.jpg"></a></td>
                            <td><a href="javascript:;"><img src="/mall/image/phoneBrand4.jpg"></a></td>
                        </tr>
                    </table>
                </div>
                
                <div class="elec-gd1 elec-goods2">
                    <a href="javascript:;" class="title">新品上市</a>
                    <div class="phone">
                        <a href="javascript:;"><img src="/mall/image/phone3.jpg"></a>
                    </div>
                </div>
                
                <div class="elec-gd2 elec-goods3">
                        <a href="javascript:;"><img src="/mall/image/computer1.jpg" class="cmpt-img"></a>
                </div>
                <div class="dect decorate1"></div>
                
                <div class="elec-gd2 elec-goods4">
                    <div><a href="javascript:;"><img src="/mall/image/phone4.jpg"></a></div>
                    <div><a href="javascript:;"><img src="/mall/image/phone4.jpg"></a></div>
                </div>
                <div class="dect decorate2"></div>
                
                <div class="elec-gd1 elec-goods5">
                    <table>
                        <tr>
                            <td class="td1" colspan="2"><a href="javascript:;">电脑配件</a></td>
                        </tr>
                        <tr>
                            <td class="td2"><a href="javascript:;"><img src="/mall/image/computer2.jpg"></a></td>
                            <td class="td2"><a href="javascript:;"><img src="/mall/image/computer2.jpg"></a></td>
                        </tr>
                        <tr>
                            <td class="td1" colspan="2"><a href="javascript:;">出行无忧</a></td>
                        </tr>
                        <tr>
                            <td class="td2"><a href="javascript:;"><img src="/mall/image/computer2.jpg"></a></td>
                            <td class="td2"><a href="javascript:;"><img src="/mall/image/computer2.jpg"></a></td>
                        </tr>
                    </table>
                </div>
                
                <div class="elec-gd1 elec-goods6">
                    <a href="javascript:;" class="title">电脑办公</a>
                    <div><a href="javascript:;"><img src="/mall/image/computer3.jpg"></a></div>
                    <div><a href="javascript:;"><img src="/mall/image/computer3.jpg"></a></div>
                </div>
                
            </div>
        </fieldset>
    </div>

</div>
<%@ include file="/web/front/footer.jsp" %>
    <script type="text/javascript">
    layui.use(["element", "jquery"], function() {
    	var element = layui.element;
        var $ = layui.jquery;
        
        function init() {
	        initCarousel("#carousel1", "1060px", "400px", true, null, null);
	        initCarousel("#carousel2", "810px", "250px", true, "always", "none");
	        initCarousel("#carousel3", "180px", "250px", true, "none", null);
        	
	        $("#search-btn").click(search);
        }
        
        ajax("/dict/getAllCateList", "json", {}, function(data) {
        	var html = "";
        	var html2 = "";
        	$.each(data, function(index1, dom1) {
        		html += '<li class="cate-nav-item"><a href="javascript:;">'+dom1.name+'</a>';
        		html += '<div class="cate-cont">';
        		$.each(dom1.child, function(index2, dom2) {
	        		html += '<dl class="cate-data">';
        			html += '<dt class="cate-data-tltle"><a href="javascript:;">'+dom2.name+'&nbsp;&gt;</a></dt>';
        			html += '<dd class="cate-data-cont">';
        			$.each(dom2.child, function(index3, dom3) {
        				if (dom3.code.indexOf("11") > -1) {
        					html2 += '<a href="/mall/dict/getCategory?code='+dom3.code+'">'+dom3.name+'</a>';
        				}
        				html += '<a href="/mall/dict/getCategory?code='+dom3.code+'">'+dom3.name+'</a>';
        			});
        			html += '</dd></dl>';
        		});
        		html += '</div></li>';
        	});
        	$("#cateNav").html(html);
        	$("#hot-cate").html(html2);
        	element.render("breadcrumb");
        });
        
        init();
    });
  </script>
</body>
</html>