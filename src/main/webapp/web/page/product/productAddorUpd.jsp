<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp" %>
<title>信息维护</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/page/css/addorUpd.css"/>
</head>
<body>
    <div class="layui-tab layui-tab-card" lay-filter="proUpd">
        <ul class="layui-tab-title">
            <li class="layui-this">基本信息</li>
            <li>商品图片</li>
        </ul>
        
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
		        <form class="layui-form layui-form-pane" lay-filter="addorUpd" onsubmit="return false;">
		          <div class="layui-form-item">
				    <label class="layui-form-label">一级分类</label>
				    <div class="layui-input-inline">
				      <select name="category1" lay-filter="category1" lay-search></select>
				    </div>
				    <label class="layui-form-label">二级分类</label>
				    <div class="layui-input-inline format-margin">
				      <select name="category2" lay-filter="category2" lay-search>
				        <option value="">请选择</option>
				      </select>
				    </div>
				  </div>
		          <div class="layui-form-item">
				    <label class="layui-form-label">三级分类</label>
				    <div class="layui-input-inline">
				      <select name="dictCode" lay-filter="dictCode" lay-verify="required" lay-search>
				        <option value="">请选择</option>
				      </select>
				    </div>
				    <label class="layui-form-label">状态</label>
				    <div class="layui-input-inline format-margin">
				      <select name="status">
				        <option value="1">上架</option>
				        <option value="2">下架</option>
				        <option value="3">未发布</option>
				        <option value="4">缺货</option>
				      </select>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <label class="layui-form-label">编号</label>
				    <div class="layui-input-inline">
				      <input type="text" class="layui-input" name="code" lay-verify="required" placeholder="必填"/>
				    </div>
				    <label class="layui-form-label">名称</label>
				    <div class="layui-input-inline format-margin">
				      <input type="text" class="layui-input" name="name" lay-verify="required" placeholder="必填"/>
				    </div>
				  </div>
		          <div class="layui-form-item">
				    <label class="layui-form-label">单价</label>
				    <div class="layui-input-inline">
				      <input type="text" class="layui-input" name="unitPrice"/>
				    </div>
				    <label class="layui-form-label">库存</label>
				    <div class="layui-input-inline format-margin">
			          <input type="text" class="layui-input" name="stock"/>
				    </div>
				  </div>
		          <div class="layui-form-item layui-form-text">
		            <label class="layui-form-label">描述</label>
		            <div class="layui-input-block">
		              <textarea name="descr" placeholder="商品描述" class="layui-textarea"></textarea>
		            </div>
		          </div>
		          <div class="layui-form-item btn">
		            <button class="layui-btn" lay-submit lay-filter="submit">确定</button>
		            <input type="reset" class="layui-btn" id="reset" value="重置"/>
		          </div>
		        </form>
            </div>
            <div class="layui-tab-item">
                <div class="layui-collapse">
                  <div class="layui-colla-item">
				    <h2 class="layui-colla-title">图片上传</h2>
				    <div class="layui-colla-content">
	                    <button class="layui-btn layui-btn-normal layui-btn-sm" id="imgChoose">选择图片</button>
	                    <button class="layui-btn layui-btn-normal layui-btn-sm" id="imgUpload">
	                       <i class="layui-icon layui-icon-upload"></i>上传
	                    </button>
	                    <table class="layui-table">
	                       <colgroup>
			                    <col width="35%">
			                    <col width="20%">
			                    <col width="20%">
			                    <col width="25%">
			                </colgroup>
			                <thead>
			                    <tr>
			                        <th>文件名</th>
			                        <th>大小</th>
			                        <th>状态</th>
			                        <th>操作</th>
			                    </tr>
			                </thead>
			                <tbody id="tbody"></tbody>
	                    </table>
				    </div>
				  </div>
                </div>
                
                <div class="img-list">
                    <div id="imgList"></div>
                    <div class="clear"></div>
                    <div id="page"></div>
                    <div class="clear"></div>
                </div>
                <form class="layui-form" onsubmit="return false;">
	                <input type="hidden" name="pageIndex" value="1">
	                <input type="hidden" name="pageLimit" value="8">
	                <input type="hidden" name="code" value="${obj.code}">
	                <button lay-submit lay-filter="select" id="select"></button>
                </form>
            </div>
        </div>
    
    </div>
     
    <script id="optAdd" type="text/html">
       <option value="{{d.code}}">{{d.name}}</option>
    </script>
       
    <script id="imgItemAdd" type="text/html">
       <div class="img-item">
           <div class="layui-card">
             <div class="layui-card-header" id="{{d.name}}">
                 {{# if (d.type == 1) { }}
                     <a href="javascript:;" class="layui-btn layui-btn-sm
                     layui-btn-normal">主图</a>
                 {{# } else { }} 
                     <a href="javascript:setMain('{{d.name}}');" class="layui-btn layui-btn-sm
                     layui-btn-normal">设为主图</a>
                 {{# } }}
                 <a href="javascript:del('{{d.name}}');" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
             </div>
             <div class="layui-card-body">
                 <img src="/mall/image/productImg/{{d.name}}"/>
             </div>
           </div>
       </div>
    </script>
    
    <script type="text/javascript">
    layui.use(["element", "form", "jquery", "layer", "laytpl", "upload"], function() {
    	var element = layui.element;
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var laytpl = layui.laytpl;
        var upload = layui.upload;
        var isAdd = ${empty obj};
        var url = "/dict/getListAll";
        
        function init() {
        	getOpt(url, {parentCode:"0000"}, "<option value=''>请选择</option>", "category1", showData);
        	if (!isAdd) {
        		$("#reset").prop("type", "button");
	            $("#reset").click(showData);
	            showData();
        	} else {
        		$("input[type='hidden'][name='code']").val("|||");
        	}
        }
        
        form.on("select(category1)", function(data) {
        	var html = "<option value=''>请选择</option>";
    		$("select[name='dictCode']").html(html);
       		if (data.value === "") {
	    		$("select[name='category2']").html(html);
	            form.render("select");
      			return;
       		}
        	getOpt(url, {parentCode:data.value}, html, "category2", function() {});
        });
        
        form.on("select(category2)", function(data) {
        	var html = "<option value=''>请选择</option>";
       		if (data.value === "") {
	    		$("select[name='dictCode']").html(html);
	            form.render("select");
      			return;
       		}
        	getOpt(url, {parentCode:data.value}, html, "dictCode", function() {});
        });

        function showData() {
        	if (isAdd) {return}
        	var category1 = "${obj.category1}";
        	form.val("addorUpd", {
        		"code": "${obj.code}",
        		"name": "${obj.name}",
        		"unitPrice": "${obj.unitPrice}",
        		"stock": "${obj.stock}",
        		"descr": "${obj.descr}",
        		"category1": category1
        	});
        	$("input[name='code']").prop("readonly", true);
        	getOpt(url, {parentCode:category1}, "<option value=''>请选择</option>",
        			"category2", function() {
        		var category2 = "${obj.category2}";
        		$("select[name='category2']>option[value='"+category2+"']").prop("selected", true);
        		
        		getOpt(url, {parentCode:category2}, "<option value=''>请选择</option>",
                        "dictCode", function() {
	        		$("select[name='dictCode']>option[value='${obj.dictCode}']").prop("selected", true);
        		});
        	});
        }
        	
        formSubmit("/product/" + (isAdd ? "add" : "upd"), "submit(submit)", "text", function(data) {
        	if (data == "添加成功" || data == "修改成功") {
        		$("input[type='hidden'][name='code']").val($("input[type='text'][name='code']").val());
        		layer.confirm(data + "！是否关闭当前选项卡？", {icon: 6, title:'提示'}, parent.window.closeTab);
        	} else {
        		layer.msg(data, {icon: 0});
        	}
        });
        
        var uploadListIns = upload.render({
        	elem: "#imgChoose",
            url: root.appPath + "/productImg/upload",
            accept: "images",
            acceptMime: "image/*",
            auto: false,
            bindAction: "#imgUpload",
            multiple: true,
            choose: function(obj) {
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                  var tr = $(['<tr id="upload-'+ index +'">'
                    ,'<td>'+ file.name +'</td>'
                    ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                    ,'<td>等待上传</td>'
                    ,'<td>'
                    ,'<button class="layui-btn layui-btn-xs layui-btn-normal demo-reload layui-hide">重传</button>'
                    ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                    ,'</td>'
                    ,'</tr>'].join(''));
                  
                  //单个重传
                  tr.find('.demo-reload').on('click', function(){
                    obj.upload(index, file);
                  });
                  
                  //删除
                  tr.find('.demo-delete').on('click', function(){
                    delete files[index]; //删除对应的文件
                    tr.remove();
                    uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                  });
                    $("#tbody").append(tr);
                  });
                
                this.data = {code:$("input[type='hidden'][name='code']").val()}
            },
            done: function(res, index, upload){
                if(res == 0){ //上传成功
                	getList();
                    var tr = $("#tbody").find('tr#upload-'+ index)
                    ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                    tds.eq(3).html(''); //清空操作
                    return delete this.files[index]; //删除文件队列已经上传成功的文件
                }
                this.error(index, upload);
            },
            error: function(index, upload){
                var tr = $("#tbody").find('tr#upload-'+ index)
                ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
        });
        
        formSubmit("/productImg/getList", "submit(select)", "json", function(data) {
            var limit = $("input[name='pageLimit']").val();
            var curr = $("input[name='pageIndex']").val();
            pageInit("page", data.rowCount, limit, curr, [4, 8, 16, 32, 48], function(obj, first) {
                $("input[name='pageLimit']").val(obj.limit);
                $("input[name='pageIndex']").val(obj.curr);
                if (!first) {
                    getList();
                }
            });
            
            var html = "";
            var list = data.list;
            $.each(list, function(index, dom) {
                html += laytpl($("#imgItemAdd").html()).render(dom);
            });
            $("#imgList").html(html);
            
            var leng = list.length;
            if (curr != 1 && leng < 1) {
                $("input[name='pageIndex']").val(1);
                getList();
            } else if (curr == 1 && leng < 1) {
                layer.msg("没有查到数据", {icon: 5});
            }
        });
        
        function getList() {
        	$("#select").click();
        }
        
        setMain = function(name) {
        	ajax("/productImg/setMain", "text", {code:$("input[type='hidden'][name='code']").val(),name:name},
        			function(data) {
        		if (data == "修改成功") {
        			getList();
        			layer.confirm("修改成功！是否关闭当前选项卡？", {icon: 6, title:'提示'}, parent.window.closeTab);
                } else {
                    layer.msg(data, {icon: 0});
                }
        	});
        }
        
        element.on("tab(proUpd)", function(data){
        	if (data.index == 1) {
        		getList();
        	}
        });
        
        del = function(name) {
        	layer.confirm("确认删除？", function(index) {
                ajax("/productImg/del", "text", {id:name}, function(data) {
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