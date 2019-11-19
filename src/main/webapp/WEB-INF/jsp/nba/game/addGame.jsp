<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>新增比赛</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/weadmin.css">
	</head>
	<body>
		<div class="weadmin-body">
			<form id="gameForm" class="layui-form" action="">
				<div class="layui-form-item">
					<div class="layui-inline">
				    	<label class="layui-form-label"><span class="we-red">*</span>赛季</label>
				    	<div class="layui-input-inline" style="width: 120px">
						    <select name="season" lay-verify="required">
						    <c:forEach items="${seasons }" var="season">
						      	<option value="${season.season_id }">${season.season }</option>
						    </c:forEach>
						    </select>
					    </div>
				    </div>
				    <div class="layui-inline">
					    <div class="layui-input-inline" style="width: 120px">
						    <select name="game_type" lay-verify="required">
						      	<option value="1">常规赛</option>
						      	<option value="3">季前赛</option>
						      	<option value="2">季后赛</option>
						    </select>
					    </div>
				    </div>
				</div>
				
				<div class="layui-form-item">
						<label for="game_date" class="layui-form-label">
			                <span class="we-red">*</span>比赛时间</label>
						<div class="layui-inline"  >
							<input type="text" onblur="checkDate()" value="" id="game_date" name="game_date" lay-verify="required" autocomplete="off" class="layui-input">
						</div>
				</div>
				
				<div class="layui-form-item">
					<label for="away_team" class="layui-form-label">
					<span class="we-red">*</span>客队
		            </label>
					<div class="layui-input-inline">
				      <select id="away_team" name="away_team" lay-filter="away_team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.team_id }">${team.team_name }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="home_team" class="layui-form-label">
					<span class="we-red">*</span>主队
		            </label>
					<div class="layui-input-inline">
				      <select id="home_team" name="home_team" lay-filter="home_team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.team_id }">${team.team_name }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_score" class="layui-form-label">
				    	比分
				    </label>
				    <div class="layui-inline" style="width:80px;">
				      	<input type="text" id="away_score" name="away_score" placeholder="客队" autocomplete="off" class="layui-input"/>
				    </div>-&nbsp;
				    <div class="layui-inline" style="width:80px;">
				      	<input type="text" id="home_score" name="home_score" placeholder="主队" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<div class="layui-form-item">
					<button class="layui-btn" lay-filter="add" lay-submit="">提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</form>
		</div>
		<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
		<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
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
				
				$(function(){  
					$("#game_date").focus();
				})
					
				laydate.render({
					elem: '#L_date',
					type: 'datetime'
				});

				form.verify({
					
				});
				$('input[name="email"]').blur(function(){
					if($('input[name="email"]').val()){
						$('input[name="email"]').attr('lay-verify','email');
					}else{
						$('input[name="email"]').removeAttr('lay-verify');
					}
				});

				form.on('submit(add)', function(data) {
					$.post(
						"insertGame",
						$("#gameForm").serialize(),
						function(data){
							layer.msg("新增成功", {
								icon: 6,time:500
							}, function() {
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);
								var parent$ = window.parent.layui.jquery;
								var currpage = parent$(".layui-laypage-skip").find("input").val();
								parent.layui.table.reload('game_table',{page:{curr:currpage}});
							});
						}
					);
					return false;
				});

			});
			
			function checkDate(){
				var game_date = $("#game_date").val();
				if(game_date.length != 12){
					layer.msg("时间不符合规范！",{icon:2,time:500})
					return ;
				}
				game_date = game_date.substring(0,4)+"-"+game_date.substring(4,6)+"-"+game_date.substring(6,8)+" "
							+game_date.substring(8,10)+":"+game_date.substring(10)+":00";
				$("#game_date").val(game_date);
			}
		</script>
	</body>

</html>