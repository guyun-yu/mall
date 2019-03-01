<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/front/fheader.jsp" %>
<title>主页</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/amazeui.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/hmstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/front/css/index.css"/>
<script src="<%=path%>/lib/js/jquery.min.js"></script>
<script src="<%=path%>/lib/js/amazeui.min.js"></script>
</head>
<body>
<div class="layui-layout-admin">
    <%@ include file="/web/front/header.jsp" %>
    <!-- 主体内容 -->
    <div class="layui-main">
        <div class="logo">
            <a href="#"><img src="/mall/image/logo.png"></a>
        </div>          
        <!-- 搜索框 -->
        <div class="select">
            <input type="text" class="select-input" id="search-input">
            <button class="layui-btn layui-btn-normal" id="search-btn">搜索</button>
        </div>
    </div>

	<div class="banner">
		<!--轮播 -->
		<div class="am-slider am-slider-default scoll" data-am-flexslider id="demo-slider-0">
			<ul class="am-slides">
				<li class="banner1"><a href="#none;"><img src="<%=appPath%>/image/index/ad1.jpg" /></a></li>
				<li class="banner2"><a href="#none;"><img src="<%=appPath%>/image/index/ad2.jpg" /></a></li>
				<li class="banner3"><a href="#none;"><img src="<%=appPath%>/image/index/ad3.jpg" /></a></li>
				<li class="banner4"><a href="#none;"><img src="<%=appPath%>/image/index/ad4.jpg" /></a></li>
			</ul>
		</div>
		<div class="clear"></div>
	</div>

	<div class="shopNav">
		<div class="slideall">
			<div class="long-title">
				<span class="all-goods">全部分类</span>
			</div>
			<div class="nav-cont">
				<ul>
					<li class="index"><a href="#none">首页</a></li>
					<li class="qc"><a href="#none">闪购</a></li>
					<li class="qc"><a href="#none">限时抢</a></li>
					<li class="qc"><a href="#none">团购</a></li>
					<li class="qc last"><a href="#none">大包装</a></li>
				</ul>
			</div>
			<!--侧边导航 -->
			<div id="nav" class="navfull">
				<div class="area clearfix">
					<div class="category-content" id="guide_2">
						<div class="category">
							<ul class="category-list" id="js_climit_li"></ul>
						</div>
					</div>
				</div>
			</div>

			<div class="clear"></div>
		</div>
	</div>

	<div class="shopMainbg">
		<div class="shopMain" id="shopmain">
			<!--今日推荐 -->
			<div class="am-g am-g-fixed recommendation" id="recommend"></div>
			<div class="clear "></div>
			
			<!--热门活动 -->
			<div class="am-container activity ">
				<div class="shopTitle ">
					<h4>活动</h4>
					<h3>每期活动 优惠享不停</h3>
					<span class="more">
					   <a href="#none;">全部活动<i class="am-icon-angle-right" style="padding-left: 10px;"></i></a>
					</span>
				</div>
				<div class="am-g am-g-fixed ">
					<div class="am-u-sm-3 ">
						<div class="icon-sale one "></div>
						<h4>秒杀</h4>
						<div class="activityMain ">
							<img src="<%=appPath%>/image/index/activity1.jpg "></img>
						</div>
						<div class="info ">
							<h3>春节送礼优选</h3>
						</div>
					</div>

					<div class="am-u-sm-3 ">
						<div class="icon-sale two "></div>
						<h4>特惠</h4>
						<div class="activityMain ">
							<img src="<%=appPath%>/image/index/activity2.jpg "></img>
						</div>
						<div class="info ">
							<h3>春节送礼优选</h3>
						</div>
					</div>

					<div class="am-u-sm-3 ">
						<div class="icon-sale three "></div>
						<h4>团购</h4>
						<div class="activityMain ">
							<img src="<%=appPath%>/image/index/activity3.jpg "></img>
						</div>
						<div class="info ">
							<h3>春节送礼优选</h3>
						</div>
					</div>

					<div class="am-u-sm-3 last ">
						<div class="icon-sale "></div>
						<h4>超值</h4>
						<div class="activityMain ">
							<img src="<%=appPath%>/image/index/activity.jpg "></img>
						</div>
						<div class="info ">
							<h3>春节送礼优选</h3>
						</div>
					</div>

				</div>
			</div>
			<div class="clear "></div>

			<div id="f1">
				<!--甜点-->
				<div class="am-container ">
					<div class="shopTitle ">
						<h4>甜品</h4>
						<h3>每一道甜品都有一个故事</h3>
						<div class="today-brands ">
							<a href="#none;">桂花糕</a> <a href="#none">奶皮酥</a> <a href="#none">栗子糕 </a>
							<a href="#none;">马卡龙</a> <a href="#none">铜锣烧</a> <a href="#none">豌豆黄</a>
						</div>
						<span class="more ">
						  <a href="#none">更多美味<i class="am-icon-angle-right" style="padding-left: 10px;"></i></a>
						</span>
					</div>
				</div>

				<div class="am-g am-g-fixed floodFour">
					<div class="am-u-sm-5 am-u-md-4 text-one list ">
						<div class="word">
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
						</div>
						<a href="#none">
							<div class="outer-con">
								<div class="title ">开抢啦！</div>
								<div class="sub-title ">零食大礼包</div>
							</div>
							<img src="<%=appPath%>/image/index/act1.png " />
						</a>
						<div class="triangle-topright"></div>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two sug">
						<div class="outer-con ">
							<div class="title ">雪之恋和风大福</div>
							<div class="sub-title ">¥13.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/2.jpg" /></a>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two">
						<div class="outer-con ">
							<div class="title ">雪之恋和风大福</div>
							<div class="sub-title ">¥13.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/1.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three big">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/5.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three sug">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/3.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three ">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none "><img src="<%=appPath%>/image/index/4.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three last big ">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/5.jpg" /></a>
					</div>

				</div>
				<div class="clear "></div>
			</div>

			<div id="f2">
				<!--坚果-->
				<div class="am-container ">
					<div class="shopTitle ">
						<h4>坚果</h4>
						<h3>酥酥脆脆，回味无穷</h3>
						<div class="today-brands ">
							<a href="#none">腰果</a><a href="#none">松子</a><a href="#none">夏威夷果 </a> 
							<a href="#none">碧根果</a><a href="#none">开心果</a><a href="#none">核桃仁</a>
						</div>
						<span class="more ">
						    <a href="#none">更多美味<i class="am-icon-angle-right" style="padding-left:10px;"></i></a>
						</span>
					</div>
				</div>
				<div class="am-g am-g-fixed floodThree ">
					<div class="am-u-sm-4 text-four list">
						<div class="word">
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
						</div>
						<a href="#none"> <img src="<%=appPath%>/image/index/act1.png " />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
							</div>
						</a>
						<div class="triangle-topright"></div>
					</div>
					<div class="am-u-sm-4 text-four">
						<a href="#none"> <img src="<%=appPath%>/image/index/6.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-4 text-four sug">
						<a href="#none"> <img src="<%=appPath%>/image/index/7.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>

					<div class="am-u-sm-6 am-u-md-3 text-five big ">
						<a href="#none"> <img src="<%=appPath%>/image/index/10.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five ">
						<a href="#none"> <img src="<%=appPath%>/image/index/8.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five sug">
						<a href="#none"> <img src="<%=appPath%>/image/index/9.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five big">
						<a href="#none"> <img src="<%=appPath%>/image/index/10.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
				</div>
				<div class="clear "></div>
			</div>
			
			<div id="f3">
				<!--甜点-->
				<div class="am-container ">
					<div class="shopTitle ">
						<h4>甜品</h4>
						<h3>每一道甜品都有一个故事</h3>
						<div class="today-brands ">
							<a href="#none;">桂花糕</a> <a href="#none">奶皮酥</a> <a href="#none">栗子糕 </a>
							<a href="#none;">马卡龙</a> <a href="#none">铜锣烧</a> <a href="#none">豌豆黄</a>
						</div>
						<span class="more ">
						  <a href="#none">更多美味<i class="am-icon-angle-right" style="padding-left: 10px;"></i></a>
						</span>
					</div>
				</div>

				<div class="am-g am-g-fixed floodFour">
					<div class="am-u-sm-5 am-u-md-4 text-one list ">
						<div class="word">
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
                            <a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
						</div>
						<a href="#none">
							<div class="outer-con">
								<div class="title ">开抢啦！</div>
								<div class="sub-title ">零食大礼包</div>
							</div>
							<img src="<%=appPath%>/image/index/act1.png " />
						</a>
						<div class="triangle-topright"></div>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two sug">
						<div class="outer-con ">
							<div class="title ">雪之恋和风大福</div>
							<div class="sub-title ">¥13.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/2.jpg" /></a>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two">
						<div class="outer-con ">
							<div class="title ">雪之恋和风大福</div>
							<div class="sub-title ">¥13.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/1.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three big">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/5.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three sug">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/3.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three ">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none "><img src="<%=appPath%>/image/index/4.jpg" /></a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three last big ">
						<div class="outer-con ">
							<div class="title ">小优布丁</div>
							<div class="sub-title ">¥4.8</div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#none"><img src="<%=appPath%>/image/index/5.jpg" /></a>
					</div>

				</div>
				<div class="clear "></div>
			</div>

			<div id="f4">
				<!--坚果-->
				<div class="am-container ">
					<div class="shopTitle ">
						<h4>坚果</h4>
						<h3>酥酥脆脆，回味无穷</h3>
						<div class="today-brands ">
							<a href="#none">腰果</a><a href="#none">松子</a><a href="#none">夏威夷果 </a> 
							<a href="#none">碧根果</a><a href="#none">开心果</a><a href="#none">核桃仁</a>
						</div>
						<span class="more ">
						    <a href="#none">更多美味<i class="am-icon-angle-right" style="padding-left:10px;"></i></a>
						</span>
					</div>
				</div>
				<div class="am-g am-g-fixed floodThree ">
					<div class="am-u-sm-4 text-four list">
						<div class="word">
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a> 
							<a class="outer" href="#none"><span class="inner"><b class="text">核桃</b></span></a>
						</div>
						<a href="#none"> <img src="<%=appPath%>/image/index/act1.png " />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
							</div>
						</a>
						<div class="triangle-topright"></div>
					</div>
					<div class="am-u-sm-4 text-four">
						<a href="#none"> <img src="<%=appPath%>/image/index/6.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-4 text-four sug">
						<a href="#none"> <img src="<%=appPath%>/image/index/7.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>

					<div class="am-u-sm-6 am-u-md-3 text-five big ">
						<a href="#none"> <img src="<%=appPath%>/image/index/10.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five ">
						<a href="#none"> <img src="<%=appPath%>/image/index/8.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five sug">
						<a href="#none"> <img src="<%=appPath%>/image/index/9.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
					<div class="am-u-sm-6 am-u-md-3 text-five big">
						<a href="#none"> <img src="<%=appPath%>/image/index/10.jpg" />
							<div class="outer-con ">
								<div class="title ">雪之恋和风大福</div>
								<div class="sub-title ">¥13.8</div>
								<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
							</div>
						</a>
					</div>
				</div>
				<div class="clear "></div>
			</div>
			
		</div>
	</div>

</div>
    <%@ include file="/web/front/footer.jsp" %>
    
    <script type="text/html" id="recommendAdd">
    <div class="am-u-sm-4 am-u-lg-3 ">
        <div class="info ">
            <h3>{{d.name}}</h3>
            <h4>{{d.descr}}</h4>
        </div>
        <div class="recommendationMain">
            <a href="<%=appPath%>/product/getProduct?code={{d.code}}">
                <img src="<%=appPath%>/image/productImg/{{d.mainPicture}}"></img>
            </a>
        </div>
    </div>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "laytpl"], function() {
    	var element = layui.element;
    	var laytpl = layui.laytpl;
        
        function init() {
	        ajax("/dict/getAllCateList", "json", {}, function(data) {
	        	var html = "";
	        	$.each(data, function(index1, dom1) {
	        		html += '<li class="appliance js_toggle relative"><div class="category-info">';
	        		html += '<h3 class="category-name b-category-name">';
	        		html += '<a href="#none" class="ml-22" title="'+dom1.name+'">'+dom1.name+'</a></h3>';
	        		html += '<em>&gt;</em></div><div class="menu-item menu-in top"><div class="area-in">';
	        		html += '<div class="area-bg"><div class="menu-srot"><div class="sort-side">';
	        		$.each(dom1.child, function(index2, dom2) {
	        			html += '<dl class="dl-sort"><dt><span title="'+dom2.name+'">'+dom2.name+'</span></dt>';
	        			html += '';
	        			$.each(dom2.child, function(index3, dom3) {
	        				html += '<dd><a href="/mall/dict/getCategory?code='+dom3.code+'" title="'+dom3.name+'">';
	        				html += '<span>'+dom3.name+'</span></a></dd>';
	        			});
	        			html += '</dl>';
	        		});
	        		html += '</div></div></div></div></div><b class="arrow"></b></li>';
	        	});
	        	$("#js_climit_li").html(html);
	        	
	        	$("li").hover(function() {
                    $(this).addClass("hover");
                    $(this).children("div.menu-in").css("display", "block")
                }, function() {
                    $(this).removeClass("hover");
                    $(this).children("div.menu-in").css( "display", "none");
                });
	        });
	        
	        ajax("/product/getHotProduct", "json", {pageIndex:1, pageLimit:3}, function(data) {
	        	html = '<div class="clock am-u-sm-3"><img src="<%=appPath%>/image/index/2016.png"></img>';
	        	html += '<p>今日<br>推荐</p></div>';
	        	$.each(data, function(i, dom) {
	        		html += laytpl($("#recommendAdd").html()).render(dom);
	        	});
	        	$("#recommend").html(html);
	        });
        	
	        $("#search-btn").click(search);
        }
        
        
        init();
    });
  </script>
</body>
</html>