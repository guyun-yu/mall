var root = {
		appPath: "/mall",
		path: "/mall/web"
}

function formSubmit(url, submit, dataType, func) {
	layui.use("form", function() {
		layui.form.on(submit, function(data) {
			ajax(url, dataType, data.field, func);
			return false;
		});
	});
}

function ajax(url, dataType, field, func) {
	layui.use("jquery", function() {
		layui.$.ajax({
			type: "post",
			url: root.appPath + url,
			dataType: dataType,
			data: field,
			traditional: true,
			success: func
		});
	});
}

function pageInit(elem, rowCount, limit, curr, limits, func) {
	limits = limits == null ? [5, 10, 20, 30, 40] : limits;
	layui.use("laypage", function() {
		layui.laypage.render({
			elem: elem,
			count: rowCount,
			groups: 3,
			limit: limit,
			curr: curr,
			limits: limits,
			layout: ["count", "prev", "page", "next", "limit", "skip"],
			jump: func
		});
	});
}

function dateInit(elem, type) {
	layui.use("laydate", function() {
		layui.laydate.render({
			elem: elem,
			type: type
		});
	});
}

function openDialog(url, title, area, resize, func) {
	layui.use("layer", function() {
		layui.layer.open({
    		type: 2,
    		content: root.appPaht + url,
    		title: title,
    		area: area == null ? ["500px", "520px"] : area,
    		closeBtn: 1,
    		resize: resize,
    		maxmin: true,
    		end: func
    	});
	});
}

function checkInt(input) {
	if (typeof input != "string") {
		return false;
	}
	return input.match(/^\d*$/) !== null;
}

function getOpt(url, code, html, elem, func) {
	layui.use(["jquery", "laytpl", "form"], function() {
		var $ = layui.jquery;
		var laytpl = layui.laytpl;
		var form = layui.form;
		ajax(url, "json", code, function(data) {
			$.each(data, function(index, dom) {
				html += laytpl($("#optAdd").html()).render(dom);
			});
			$("select[name='"+elem+"']").html(html);
			func();
			form.render("select");
		});
	});
}

function initCarousel(elem, width, height, autoplay, arrow, indicator) {
	layui.use(["carousel"],function() {
		layui.carousel.render({
            elem: elem,
            width: width,
            height: height,
            autoplay: autoplay,
            arrow: arrow == null ? "hover" : arrow,
            indicator: indicator == null ? "inside" : indicator
        });
	});
}

function setCheckAll() {
	layui.use(["jquery", "form"], function() {
		var $ = layui.jquery;
		var form  = layui.form;
		
		if ($("#tbody :checkbox").length != 0) {
			if ($("#tbody :checkbox:not(:checked)").length == 0) {
				$("input[lay-filter='checkAll']").prop("checked", true);
			} else {
				$("input[lay-filter='checkAll']").prop("checked", false);
			}
		} 
		form.render("checkbox");
	});
}

function search() {
	layui.use("jquery", function() {
		var $ = layui.$;
		
		var val = $.trim($("#search-input").val());
        if ("" === val) {
            return;
        }
        location.href = root.appPath + "/product/search?name=" + val;
	});
}