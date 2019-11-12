<%@page import="nba.model.Team"%>
<%@page import="java.util.List"%>
<%@page import="nba.model.Season"%>
<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>æ·»å çå-ä¼åè®°å¿çç®¡çç³»ç»</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="../../static/css/font.css">
		<link rel="stylesheet" href="../../static/css/weadmin.css">
		<!-- è®©IE8/9æ¯æåªä½æ¥è¯¢ï¼ä»èå¼å®¹æ æ ¼ -->
		<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>
	<%
		//è·åææçèµå­£åææçé
		List<Season> seasons = Season.getSeasonList();
		List<Team> teams = Team.getTeamList("", 0, 0);
		request.setAttribute("seasons", seasons);
		request.setAttribute("teams", teams);
	%>
	<body>
		<div class="weadmin-body">
			<form id="playerForm" class="layui-form" action="">
				<div class="layui-form-item">
				    <label class="layui-form-label"><span class="we-red">*</span>赛季</label>
				    <div class="layui-inline">
				      <select name="season" lay-verify="required">
				      <c:forEach items="${seasons }" var="season">
				      	<option value="${season.id }">${season.season }</option>
				      </c:forEach>
				      </select>
				    </div>
				    <div class="layui-inline">
				      <select name="game_type" lay-verify="required">
				      	<option value="c">常规赛</option>
				      	<option value="q">季前赛</option>
				      	<option value="h">季后赛</option>
				      </select>
				    </div>
				</div>
				
				<div class="layui-form-item">
					<label for="L_date" class="layui-form-label">
		                <span class="we-red">*</span>比赛时间
		            </label>
					<div class="layui-input-inline">
						<input type="text" value="" id="L_date" name="date" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label for="L_away_team" class="layui-form-label">
					<span class="we-red">*</span>客队
		            </label>
					<div class="layui-input-inline">
				      <select id="L_away_team" name="away_team" lay-filter="away_team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.id }">${team.teamName }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="L_home_team" class="layui-form-label">
					<span class="we-red">*</span>主队
		            </label>
					<div class="layui-input-inline">
				      <select id="L_home_team" name="home_team" lay-filter="home_team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.id }">${team.teamName }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_score" class="layui-form-label">
				    	比分
				    </label>
				    <div class="layui-inline" style="width:80px;">
				      	<input type="text" id="L_home_score" name="home_score" placeholder="客队" autocomplete="off" class="layui-input"/>
				    </div>-&nbsp;
				    <div class="layui-inline" style="width:80px;">
				      	<input type="text" id="L_away_score" name="away_score" placeholder="主队" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<div class="layui-form-item">
					<button class="layui-btn" lay-filter="add" lay-submit="">提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</form>
		</div>
		<script src="../../lib/layui/layui.js" charset="utf-8"></script>
		<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
		<script>
			layui.extend({
				admin: '{/}../../static/js/admin'
			});
			layui.use(['form', 'jquery','util','admin', 'layer' ,'laydate'], function() {
				var form = layui.form,
					$ = layui.jquery,
					util = layui.util,
					admin = layui.admin,
					laydate = layui.laydate,
					layer = layui.layer;
				
				
					
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
						"../../acGAME!insertGame.action",
						$("#playerForm").serialize(),
						function(data){
							layer.alert("新增成功", {
								icon: 6
							}, function() {
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);
								var parent$ = window.parent.layui.jquery;
								var currpage = parent$(".layui-laypage-skip").find("input").val();
								parent.layui.table.reload('player_table',{page:{curr:currpage}});
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