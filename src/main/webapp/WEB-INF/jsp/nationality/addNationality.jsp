<%@pagelanguage ="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>添加国家或地区-休城记忆的影视基地</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/weadmin.css">
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
</head>

<body>
	<div class="weadmin-body">
		<form id="nationalityForm" class="layui-form"
			action="">
			<div class="layui-form-item">
				<input name="nat_id" type="hidden" value="${nationality.nat_id }"/>
				<div class="layui-inline">
					<label for="nationality" class="layui-form-label"> <span
						class="we-red">*</span>国家或地区名
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="nationality" name="nationality" value="${nationality.nationality }"
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label for="en_nationality" class="layui-form-label"> 英文名 </label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="en_nationality" name="en_nationality"  value="${nationality.en_nationality }"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">国旗</label>
				<div class="layui-upload">
					<button type="button" class="layui-btn" id="test1">上传图片</button>
					<div style="margin-left: 110px;" class="layui-upload-list">
						<img class="layui-upload-img" width="150px" height="100px"
							id="demo1" src="data:image/jpg;base64,${nationality.flag_picture }"> <input type="hidden" id="flag_path"
							name="flag_path" value="${nationality.flag_path }">
						<p id="demoText"></p>
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<button class="layui-btn" lay-filter="add" id="add" lay-submit="">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</form>
	</div>
	<script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/lay/modules/rate.js" charset="utf-8"></script>
	<script>
		layui.extend({
			admin : '${pageContext.request.contextPath }/js/admin'
		});

		layui.use(
			[ 'form', 'jquery', 'util', 'admin', 'layer', 'laydate', 'upload' ],
			function() {
				var form = layui.form, $ = layui.jquery, util = layui.util, admin = layui.admin, laydate = layui.laydate, layer = layui.layer, upload = layui.upload;

				$(function(){  
				});
				//普通图片上传
				var uploadInst = upload
						.render({
							elem : '#test1',
							url : 'upload',
							before : function(obj) {
								//预读本地文件示例，不支持ie8
								obj.preview(function(index,
												file, result) {
											$('#demo1').attr('src',
													result); //图片链接（base64）
										});
							},
							done : function(res) {
								if (res.code == 0) {
									//上传成功
									$("#flag_path").val(
											res.data[0].src);
								}
								//如果上传失败
								if (res.code > 0) {
									return layer.msg('上传失败');
								}
								//上传成功
							},
							error : function() {
								//演示失败状态，并实现重传
								var demoText = $('#demoText');
								demoText
										.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
								demoText.find('.demo-reload').on(
										'click', function() {
											uploadInst.upload();
										});
							}
						});

				laydate.render({
					elem : '#birthday'
				});

				//自定义验证规则
				form.verify({
					checkdate : function(value) {
						var now = new Date();
						var time = now.getFullYear()
								+ "-"
								+ ((now.getMonth() + 1) < 10 ? "0"
										: "")
								+ (now.getMonth() + 1) + "-"
								+ (now.getDate() < 10 ? "0" : "")
								+ now.getDate();
						var valueNum = parseInt(value.replace(/-/g,
								''), 10);
						var nowNum = parseInt(time
								.replace(/-/g, ''), 10);
						if (valueNum > nowNum) {
							return "观看时间不能超过当前时间";
						}
					},
				});
				//失去焦点时判断值为空不验证，一旦填写必须验证
				$('input[name="email"]').blur(
						function() {
							//这里是失去焦点时的事件
							if ($('input[name="email"]').val()) {
								$('input[name="email"]').attr(
										'lay-verify', 'email');
							} else {
								$('input[name="email"]')
										.removeAttr('lay-verify');
							}
						});

				//监听提交
				form.on('submit(add)',function(data) {
					var url;
					if("${flag}" == "edit"){
						url = "editNationality";
					}else if("${flag}" == "insert"){
						url = "insertNationality";
					}
					$("#add").attr("disabled","disabled");
					$.post(
						url,
						$("#nationalityForm").serialize(),
						function(data) {
							var obj = new Function("return" + data)();
							if(obj.code != 0){
								layer.msg(obj.message,
										{
											icon : 6,
											time : 1000,
										},
										function() {
											// 获得iframe索引
											var index = parent.layer.getFrameIndex(window.name);
											//关闭当前iframe
											parent.layer.close(index);
											var parent$ = window.parent.layui.jquery;//获取父页面的jQuery
											var currpage = parent$(".layui-laypage-skip").find("input").val(); //当前页码值
											parent.layui.table.reload('nationality_table',{page : {curr : currpage}});//刷新当前页面
								});
							}else{
								layer.alert(obj.message,{icon:2},function(){
									$("#add").attr("disabled","");
								})
							}
							
					});
					//$(".layui-laypage-btn")[0].click();
					return false;
				});

			});
	</script>
</body>

</html>