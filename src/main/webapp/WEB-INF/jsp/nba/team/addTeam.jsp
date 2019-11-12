<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>添加球队-休城记忆的管理系统</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/weadmin.css">
		<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
		<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>

	<body>
		<div class="weadmin-body">
			<form id="teamForm" class="layui-form" action="../../acTEAM!insertTeam.action">
				<div class="layui-form-item">
					<label for="team_name" class="layui-form-label">
		                <span class="we-red">*</span>球队名称
		            </label>
					<div class="layui-input-inline">
						<input style="width: 300px" type="text" id="team_name" name="team_name" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="location_city" class="layui-form-label">
		                <span class="we-red">*</span>所属城市
		            </label>
					<div class="layui-input-inline">
						<input style="width: 300px" type="text" id="location_city" name="location_city" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
				    <label for="english_name" class="layui-form-label">
				    	<span class="we-red">*</span>英文全称
				    </label>
				    <div class="layui-input-inline">
				      	<input style="width: 300px" type="text" id="english_name" name="english_name" lay-verify="required" autocomplete="off" class="layui-input"/>
				    </div>
				</div>

				<div class="layui-form-item">
				    <label class="layui-form-label">所在赛区</label>
				    <div class="layui-input-block">
				      <select name="area" lay-verify="required">
				        <option value="">请选择</option>
				        <option value="1">西南赛区</option>
				        <option value="2">西北赛区</option>
				        <option value="3">太平洋赛区</option>
				        <option value="4">东南赛区</option>
				        <option value="5">中部赛区</option>
				        <option value="6">大西洋赛区</option>
				      </select>
				    </div>
				</div>
				
				<div class="layui-form-item">
				    <label class="layui-form-label">所在分部</label>
				    <div class="layui-input-block">
				      <select name="branch" lay-verify="required">
				        <option value="">请选择</option>
				        <option value="1">东部</option>
				        <option value="2">西部</option>
				      </select>
				    </div>
				</div>
				
				<div class="layui-form-item">
				<label class="layui-form-label">球队标志</label>
				<div class="layui-upload">
					<button type="button" class="layui-btn" id="test1">上传图片</button>
					<div style="margin-left: 110px;" class="layui-upload-list">
						<img class="layui-upload-img" width="150px" height="150px"
							id="demo1" src="data:image/jpg;base64,${team.photo }"> <input type="hidden" id="photo_path"
							name="photo_path" value="${team.photo_path }">
						<p id="demoText"></p>
					</div>
				</div>
			</div>
				<div class="layui-form-item">
					<button class="layui-btn" lay-filter="add" lay-submit="">确定</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</form>
		</div>
		<script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
		
		<script>
			layui.extend({
				admin: '${pageContext.request.contextPath }/js/admin'
			});
			layui.use(['form', 'jquery','util','admin', 'layer' ,'laydate','upload'], function() {
				var form = layui.form,
					$ = layui.jquery,
					util = layui.util,
					admin = layui.admin,
					laydate = layui.laydate,
					layer = layui.layer,
					upload = layui.upload;
					
				laydate.render({
					elem: '#L_watchedate'
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
									$("#photo_path").val(
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

				//自定义验证规则
				form.verify({
					
				});
				//失去焦点时判断值为空不验证，一旦填写必须验证
				$('input[name="email"]').blur(function(){
					//这里是失去焦点时的事件
					if($('input[name="email"]').val()){
						$('input[name="email"]').attr('lay-verify','email');
					}else{
						$('input[name="email"]').removeAttr('lay-verify');
					}
				});

				//监听提交
				form.on('submit(add)', function(data) {
					$.post(
						"insertTeam",
						$("#teamForm").serialize(),
						function(data){
							layer.msg("增加成功", {
								icon: 6,time:500
							}, function() {
								//获取提交成功的时间
								//var time = new Date();
								//var timeNow = util.toDateString(time);
								// 获得iframe索引
								var index = parent.layer.getFrameIndex(window.name);
								//关闭当前iframe
								parent.layer.close(index);
								var parent$ = window.parent.layui.jquery;//获取父页面的jQuery
								var currpage = parent$(".layui-laypage-skip").find("input").val(); //当前页码值
								parent.layui.table.reload('team_table',{page:{curr:currpage}});//刷新当前页面
							});
						}
					);
					//$(".layui-laypage-btn")[0].click();
					return false;
				});

			});
		</script>
	</body>

</html>