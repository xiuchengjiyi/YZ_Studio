<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>更新比分-休城记忆的管理系统</title>
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
			<form id="teamForm" class="layui-form" action="" >
			<input type="hidden" id="game_id" name="game_id" value="${game.game_id }" />
			<input type="hidden" id="season" name="season" value="${game.season_id }" />
			<input type="hidden" id="away_team" name="away_team" value="${game.away_team_id }" />
			<input type="hidden" id="home_team" name="home_team" value="${game.home_team_id }" />
				<div class="layui-form-item">
					<div class="layui-inline">
						<label for="L_teamName" class="layui-form-label">
			                <img id="away_team_photo" width="50px" height="50px" alt="" src="data:image/jpg;base64,${game.away_team_photo }"><p id="away_name">${game.away_team_name }</p>
			            </label>
						<div class="layui-input-inline" style="width:150px;">
							<input  type="text" id="away_score" name="away_score" value="${game.away_score }"
							lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div> 
					<div class="layui-inline">
						<div class="layui-input-inline" style="width:150px;">
							<input type="text" id="home_score" name="home_score" value="${game.home_score }" lay-verify="required" autocomplete="off" class="layui-input">
						</div>
						<label  class="layui-form-label">
			                <img id="home_team_photo" width="50px" height="50px" alt="" src="data:image/jpg;base64,${game.home_team_photo }"><p id="home_name">${game.home_team_name }</p>
			            </label>
					</div>
				</div>
				
				<div class="layui-form-item">
					<button class="layui-btn" lay-filter="add" lay-submit="">确定</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</form>
		</div>
		<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/admin.js" type="text/javascript" charset="utf-8"></script>
		
		<script>
			layui.extend({
				admin: '${pageContext.request.contextPath }/js/admin'
			});
			layui.use(['form', 'jquery','util','admin', 'layer' ,'laydate'], function() {
				var form = layui.form,
					$ = layui.jquery,
					util = layui.util,
					admin = layui.admin,
					laydate = layui.laydate,
					layer = layui.layer;
					
				laydate.render({
					elem: '#L_watchedate'
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
						"updateGameScore",
						$("#teamForm").serialize(),
						function(data){
							layer.msg("更新成功", {
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
								parent.layui.table.reload('game_table',{page:{curr:currpage}});//刷新当前页面
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